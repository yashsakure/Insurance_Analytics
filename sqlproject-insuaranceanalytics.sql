CREATE DATABASE PROJECT2;
USE PROJECT2;
-- kpi 1 -- No, of invoice by account excecutive--
select account_executive, count(invoice_number) as "Number_of_invoice" from invoice
group by account_executive order by Number_of_invoice desc;

-- kpi 2 -- yearly meeting count
select  meeting_year , count(*) as "meeting_count" from meeting
 group by meeting_year order by meeting_count desc;
 
 -- kpi 3--  
 -- a. cross sell- Target, acheivement, invoice amount-
 select sum(cross_sell_bugdet) as "target" from individual_budgets;
 
 with acte as (select sum(amount) as "Acheivement" from brokerage where income_class="cross sell"),
 bcte as  (select sum(amount) as "total_fees" from fees where income_class="cross sell")
 select acheivement + total_fees as "placed_acheivement" from acte,bcte;
 
 select sum(amount) as "Invoice" from invoice where income_class="cross sell";
 
 -- b. new- Target, acheivement, invoice amount-
 select sum(new_budget) as "target" from individual_budgets;
 

 with acte as (select sum(amount) as "Acheivement" from brokerage where income_class="new"),
 bcte as  (select round(sum(amount),2) as "total_fees" from fees where income_class="new")
 select acheivement + total_fees "placed_acheivement" from acte,bcte;
 
  select sum(amount) as "Invoice" from invoice where income_class="new";
  
 -- c. renewal-Target, acheivement, invoice amount-
 select sum(renewal_budget) as "target" from individual_budgets;
 
 with acte as (select sum(amount) as "Acheivement" from brokerage where income_class="renewal"),
 bcte as  (select round(sum(amount),2) as "total_fees" from fees where income_class="renewal")
 select acheivement + total_fees "placed_acheivement" from acte,bcte;
 
  select sum(amount) as "Invoice" from invoice where income_class="renewal";
  
 -- kpi 4 - Stage Funnel by Revenue- 
 select stage, sum(revenue_amount) as "total_revenue"  from opportunity 
 group by stage order by total_revenue desc;
 
 -- kpi 5--No of meeting By Account Executive--
 select account_executive, count(*) as "meeting_count" from meeting 
 group by account_executive order by meeting_count desc;
 
 -- kpi 6- Top Open Opportunity
 select opportunity_name, sum(revenue_amount) as "total_revenue" from opportunity where open_opportunity="open" 
 group by opportunity_name order by total_revenue desc limit 10;
select product_group, sum(revenue_amount) as "total_revenue" from opportunity where open_opportunity="open" 
 group by product_group order by total_revenue desc limit 5;
 select opportunity_name, sum(revenue_amount) as "total_revenue" from opportunity 
 where stage ="Qualify Opportunity" or "Propose Solution"
 group by opportunity_name order by total_revenue desc limit 3;
 




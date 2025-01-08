use coffeeshop;
alter table sales rename column ï»¿sale_id to sale_id;
SELECT * FROM CITY;
SELECT* FROM CUSTOMERS;
SELECT* FROM PRODUCTS;
SELECT* FROM SALES;
select count(*) from sales where year(sale_date) = 2023;
SELECT COUNT(sale_date) AS total_products_sold
FROM sales
WHERE YEAR(sale_date) = 2024;
-- Q1. SHOW TABLES 
SHOW TABLES;
-- Q2. HOW MANY PEOPLE IN EACH CITY ARE ESTIMATED TO CONSUME COFFEE ,GIVEN THAT 25% POPULATION DOES?
SELECT CITY_NAME,ROUND((POPULATION*0.25)/1000,2) AS COFFEE_CONSUMERS,CITY_RANK FROM CITY ORDER BY 1 ASC;
-- Q3.SHOW THE PRODUCTS THAT ARE 5 STAR RATING
select* from sales where rating = 5;	
-- Q4. DISPLAY THE PRODUCTS THAT ARE ABOVE OR EQUAL TO RS.350?
SELECT* FROM PRODUCTS WHERE PRICE>= 350;
-- Q5 How many units of each coffee product have been sold?
SELECT 
	p.product_name,
	COUNT(s.sale_id) as total_orders
FROM products as p
LEFT JOIN
sales as s
ON s.product_id = p.product_id
GROUP BY 1
ORDER BY 2 DESC;

select* from city;
select* from customers;
select* from products;
select* from sales;
-- Q6.  Give the names of customers their city,date and what product they have consumed?
select c.customer_name,ci.city_name,s.sale_date,p.product_name
from customers c 
join city ci on ci.city_id = c.city_id
join sales s on s.customer_id = c.customer_id
join products p on p.product_id = s.product_id;
-- Q7. TOTAL SALES IN 2023 ?
SELECT SUM(TOTAL) SALES FROM SALES WHERE YEAR(SALE_DATE) = 2023 ;
-- Q8. Write Productname,sum of sales  and average rating?
select p.product_name,sum(s.total) as Sales ,round(avg(rating),1) 
as Average_rating from products p
join sales s on p.product_id = s.product_id
group by p.product_name;
-- Q9.Which city has highest population?
SELECT 
    CITY_NAME, POPULATION
FROM
    CITY
WHERE
     POPULATION < (SELECT 
            MAX(POPULATION)
        FROM
            CITY);
-- second highest population
SELECT MAX(population) AS second_highest_salary
FROM city
WHERE population < (SELECT MAX(population) FROM sales);
-- Q10. Second Highest Population of city with name?
SELECT 
    city_name, population
FROM
    city
WHERE
    population = (SELECT 
            MAX(population)
        FROM
            city
        WHERE
            population < (SELECT 
                    MAX(population)
                FROM
                    city)); 

select* from city order by population desc;
desc city;
-- Customer name with A?
SELECT CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_NAME LIKE "Aa%";
-- Q11. Product id 24 total sales?
select p.product_name,sum(s.total) Total_sales from products p
join sales s on p.product_id = s.product_id 
where p.product_id = 24
group by product_name;

-- Q12. Which Product is sold more?
select p.product_name,sum(s.total) as Total_sales from products p
join sales s on p.product_id = s.product_id
group by p.product_name 
order by Total_sales desc
limit 1;

-- Q13. Which Product is sold Less?
select p.product_name,sum(s.total) as Total_sales from products p
join sales s on p.product_id = s.product_id
group by p.product_name 
order by Total_sales asc
limit 1;
-- Q14. Average sales in each city?
select c.city_name, avg(s.total) as average_sales from city c 
join customers cu on c.city_id = cu.city_id 
join sales s on cu.customer_id = s.customer_id
group by c.city_name
order by average_sales desc;
-- Q15. Order the city name in the order of city_rank?
select city_name,city_rank from city order by city_rank asc;
-- Q16. Total Products and Their Price
SELECT 
    COUNT(*) AS Total_products, SUM(price) AS Price
FROM
    Products;
    -- Q17. To view the datas?
SELECT * FROM CITY;
SELECT* FROM CUSTOMERS;
SELECT* FROM PRODUCTS;
SELECT* FROM SALES;
-- Q18. Average sales in 2023 & 2024
SELECT 
    AVG(total) as Average_sales 
FROM
    sales
WHERE
    YEAR(sale_date) = 2023 or 2024;
-- Q19. which year has High sales any 5 years ?
SELECT 
    YEAR(sale_date) AS Year, SUM(total) AS Total
FROM
    sales
GROUP BY YEAR(sale_date)
ORDER BY Total ASC
LIMIT 5;
-- Q20. Which Year has High sales?
select year(sale_date) as Year, sum(total) as Total from sales
group by year(sale_date) order by Total desc limit 1;
-- Q21. Which Year has Low sales?
select year(sale_date) as Year, sum(total) as Total from sales
group by year(sale_date) order by Total asc limit 1;
-- Q22. Need Customer name , City name and total he purchased?
select cu.customer_name,c.city_name,sum(s.total) as total from customers cu join city c
on cu.city_id = c.city_id
join sales s on s.customer_id = cu.customer_id
group by cu.customer_name,c.city_name;
-- Q23.Give Discount as per they Purchase
UPDATE sales s
JOIN (
    SELECT customer_id, SUM(total) AS total 
    FROM sales 
    GROUP BY customer_id
) AS totals ON s.customer_id = totals.customer_id
SET s.discount = CASE 
    WHEN totals.total >= 20000 THEN 20
    WHEN totals.total >= 15000 THEN 15
    WHEN totals.total >= 10000 THEN 10
    ELSE 5
END;

-- Q24.Give name, city name and final price after discount?
select cu.customer_name,c.city_name,round(sum(s.total-s.total*s.discount/100)) as final_price from customers cu
join city c	on cu.city_id = c.city_id 
join sales s on cu.customer_id = s.customer_id
group by cu.customer_name,c.city_name;

-- Q25. Give name, city and discount price ?
select cu.customer_name,c.city_name,round(sum(s.total*s.discount/100)) as Discount_price from customers cu
join city c on cu.city_id = c.city_id 
join sales s on cu.customer_id = s.customer_id
group by cu.customer_name,c.city_name;

-- Q26 How much sales on month 9?
select sum(total) as sales  from sales where month(sale_date) = 9;

-- Q27. How much sales on city?
select c.city_name,sum(total) as total_sales from city c join customers cu 
on c.city_id = cu.city_id 
join sales s 
on cu.customer_id = s.customer_id 
group by c.city_name order by total_sales desc;

-- Q28. How much did each customers had purchased in my shop ?
select cu.customer_name,sum(s.total) as total_sales from customers cu 
join sales s on cu.customer_id = s.customer_id
group by cu.customer_name 
order by total_sales desc;

-- Q29. How to rename a table 
alter table sales rename to sales_data;
alter table city rename to city_data;
alter table products rename to products_data;
alter table customers rename to customers_data;

alter table sales_data rename to sales;
alter table city_data rename to city;
alter table products_data rename to products;
alter table customers_data rename to customers;

-- Q30. How many customers from each city?
select c.city_name,count(cu.city_id) as count_of_customers from city c join customers cu
on c.city_id = cu.city_id group by c.city_name order by count_of_customers;

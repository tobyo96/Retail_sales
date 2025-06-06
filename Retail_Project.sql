--- Total profit---
SELECT SUM(units_sold*(price-cost)) AS total_profit
FROM products p
JOIN sales s ON p.product_id = s.product_id
;

--- AVT ---
SELECT SUM(units_sold*price) AS total_sales, COUNT(sale_id) AS Amt_of_sales, SUM(units_sold*price)/COUNT(sale_id) AS AVT
FROM products p
JOIN sales s ON p.product_id = s.product_id

--- ASP --- 
SELECT SUM(units_sold*price) AS total_sales, SUM(units_sold) AS Amt_of_units, SUM(units_sold*price)/SUM(units_sold) AS ASP
FROM products p
JOIN sales s ON p.product_id = s.product_id

--- TOTAL UNITS SOLD ---
SELECT SUM(units_sold) AS Amt_of_units
FROM products p
JOIN sales s ON p.product_id = s.product_id

--- TOTAL AMOUNT OF TRANS ---
SELECT COUNT(sale_id) AS Amt_of_sales
FROM products p
JOIN sales s ON p.product_id = s.product_id---Sales per store---
SELECT store_id, SUM(units_sold) AS total_units, sum(units_sold*price) AS Sale_price, SUM(units_sold*(price-cost)) AS profit
FROM sales s 
JOIN products p ON s.product_id = p.product_id
GROUP BY 1;

--- SALES & PROFIT MONTHLY ---
SELECT date_format(STR_TO_DATE(sale_date, '%d/%m/%Y'), '%Y-%m') AS formatted_date,
	SUM(units_sold) AS total_units_sold,
    sum(units_sold*price) AS Sale_price, 
    SUM(units_sold*(price-cost)) AS profit
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY 1
ORDER BY 1;

--- SALES & PROFIT SEASONAL ---
SELECT  
    sum(units_sold*price) AS Sale_price, 
    SUM(units_sold*(price-cost)) AS profit,
    CASE WHEN date_format(STR_TO_DATE(sale_date, '%d/%m/%Y'), '%m') BETWEEN '03' AND '05' THEN 'SPRING'
		WHEN date_format(STR_TO_DATE(sale_date, '%d/%m/%Y'), '%m') BETWEEN '06' AND '08' THEN 'SUMMER'
        WHEN date_format(STR_TO_DATE(sale_date, '%d/%m/%Y'), '%m') BETWEEN '09' AND '11' THEN 'AUTUMN'
        ELSE 'WINTER' END AS season 
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY 3
ORDER BY 3;

--- TOP 3 CUSTOMERS ---
SELECT c.customer_id, SUM(price*units_sold) AS sale_price
FROM customers c
JOIN sales s ON s.customer_id = c.customer_id
JOIN products p ON p.product_id = s.product_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3;
 
--- BOTTOM 3 CUSTOMERS ---
SELECT c.customer_id, SUM(price*units_sold) AS sale_price
FROM customers c
JOIN sales s ON s.customer_id = c.customer_id
JOIN products p ON p.product_id = s.product_id
GROUP BY 1
ORDER BY 2 
LIMIT 3;

--- TOP 5 SELLING ITEMS ---
SELECT p.product_id, SUM(units_sold)
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
JOIN products p ON p.product_id = s.product_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

--- SALES PER AGE GROUP ---
SELECT age_group, SUM(price*units_sold) AS sale_price
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
JOIN products p ON p.product_id = s.product_id
GROUP BY 1
ORDER BY 3 DESC



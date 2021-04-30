--Vinícius Henrique Neres Slavov 
--RA: 21909362 
--Banco de Dados/ 5 Semestre 
CREATE database products_sql; 
USE products_sql;
/*1. Use comando SQL apropriados para criar a base de dados, a tabela e chave primária(primary key) 
para armazear estes dados de um produto: ok
A descrição (nome) do produto sem valores repetidos e com preenchimento obrigatório: ok
A data de compra do produto com preenchimento obrigatório: ok
O preço de compra do produto com preenchimento obrigatório: ok
O preço de venda do produto com preenchimento obrigatório: ok
A quantidade em estoque do produto com preenchimento opcional: ok
O código do tipo produto com preenchimento obrigatório:ok */
CREATE TABLE tb_produtos (
  id_produto INT NOT NULL primary key auto_increment, 
  nome_produto VARCHAR(45) not null unique, 
  data_compra DATE not null, 
  preco_compra NUMERIC(16,2) not null, 
  preco_venda NUMERIC(16,2) not null, 
  qntd_estoque INT, 
  cod_tipo_prod INT not null

); 
INSERT INTO tb_produtos (nome_produto, data_compra , preco_compra, preco_venda, qntd_estoque, cod_tipo_prod)  -- dando valores pata tabela 
values('Iphone 12', '2020-03-23', 40000, 35000, 100, 1), 
      ('HB20', '2018-10-23', 1578, 1000, 500, 2), 
      ('Honda PCX', '2016-09-22', 100, 80,  3400, 3),
      ('Iphone 8', '2021-04-2', 7500, 5000 , 150, 4),
      ('Notebook', '2019-01-30', 200, 150 , 1000, 5);

/* 2. Selecione os produtos do tipo 3 ou os produtos do tipo 4.  
Desses produtos dos dois tipos, mostre apenas os produtos com preço de venda maior que R$ 1.000,00.  
Resolva o where de duas maneiras diferentes.  
Classifique a consulta pela descrição do produtos dentro de cada tipo.*/ 
--Primeira maneira
SELECT * FROM tb_produtos WHERE cod_tipo_prod = 3 and preco_venda > 1000.00 or cod_tipo_prod = 4 and preco_venda >= 1000.00; 
ORDER BY nome_produto; 
--Segunda Maneira
SELECT * FROM tb_produtos WHERE cod_tipo_prod IN (3,4) AND preco_venda > 1000; 
ORDER BY nome_produto;

/* 3. Mostre a descrição, o valor de venda, a quantidade em estoque e o valor total de cada produto com duas casas decimais, ou seja o valor de venda vezes a quantidade em estoque. 
Mostre o valor 0 (zero) quando a  quantidade em estoque for NULL, não mostre o valor total de cada produto igual a NULL.*/

SELECT nome_produto, 
  preco_venda, 
  IFNULL((qntd_estoque, 0) AS qntd_estoque, 
  IFNULL((preco_venda*qntd_estoque, 2),0) AS preco_total
FROM tb_produtos; 

/* 4. Use as funções de expressões regulares e classe predefinida de caracteres para criar um padrão de expressão regular para aceitar o dia e mês de uma data qualquer. 
Não aceite dados inconsistentes para o dia e o mês.*/ 

where data_compra like '[0-1][0-9][^0-9][0-3][0-9]'

/* 
5. Elabore o enunciado e a resolução de uma questão para ser resolvido com operador de concatenação, operadores aritméticos, where com mais de uma condição e order by. 
Mostre o resultado da operação aritmética com duas casas decimais. 
*/ 
-- Faça a busca na tabela usando duas condições
CREATE TABLE tb_pessoa (
  id_pessoa INT NOT NULL primary key , 
  nome_pessoa VARCHAR(45) not null , 
  caracteristica text not null, 
  

);  
INSERT INTO tb_pessoa (id_pessoa, nome_pessoa, caracteristica) 
values('1', 'Carlos', 'Alto'), 
      ('2', 'Chico', 'Gordo'), 
      ('3', 'Vanessa', 'Magro'),
      ('4', 'Felipe', 'Baixo'),
      ('5', 'Vinicius', 'Alto');
WITH tb_pessoa AS 
 ( 
     SELECT DISTINCT c.id_pessoa 
     FROM caracteristica c
     WHERE c.caracteristica in ('Alto','Magro')
     GROUP BY c.id_pessoa
     HAVING count(Distinct c.caracteristica) >= 2 
 )
SELECT p.nome_pessoa, c.caracteristica
FROM tb_pessoa filtro 
    JOIN pessoa p ON o.id = filtro.id_pessoa
    JOIN característica c ON c.id_pessoa = p.id
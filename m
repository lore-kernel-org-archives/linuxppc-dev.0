Return-Path: <dgibson@ozlabs.org>
Date: Wed, 7 Nov 2007 11:16:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>, linuxppc-dev@ozlabs.org
Subject: [1/3] dtc: Simplify lexing/parsing of literals vs. node/property names
Message-ID: <20071107001619.GB553@localhost.localdomain>
References: <20071107001303.GA553@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071107001303.GA553@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The current scheme of having CELLDATA and MEMRESERVE states to
recognize hex literals instead of node or property names is
arse-backwards.  The patch switches things around so that literals are
lexed in normal states, and property/node names are only recognized in
the special PROPNODENAME state, which is only entered after a { or a
;, and is left as soon as we scan a property/node name or a keyword.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---
 dtc-lexer.l  |  105 +++++++++++---------------------------------------
 dtc-parser.y |  123 ++++++++++++++++++++++++++---------------------------------
 2 files changed, 80 insertions(+), 148 deletions(-)

Index: dtc/dtc-lexer.l
===================================================================
--- dtc.orig/dtc-lexer.l	2007-11-07 10:02:42.000000000 +1100
+++ dtc/dtc-lexer.l	2007-11-07 11:01:12.000000000 +1100
@@ -21,9 +21,8 @@
 %option noyywrap nounput yylineno
 
 %x INCLUDE
-%x CELLDATA
 %x BYTESTRING
-%x MEMRESERVE
+%x PROPNODENAME
 
 PROPCHAR	[a-zA-Z0-9,._+*#?-]
 UNITCHAR	[0-9a-f,]
@@ -51,7 +50,7 @@
 
 %%
 
-"/include/"		BEGIN(INCLUDE);
+<*>"/include/"		BEGIN(INCLUDE);
 
 <INCLUDE>\"[^"\n]*\"	{
 			yytext[strlen(yytext) - 1] = 0;
@@ -63,13 +62,13 @@
 		}
 
 
-<<EOF>>		{
+<*><<EOF>>		{
 			if (!pop_input_file()) {
 				yyterminate();
 			}
 		}
 
-\"([^\\"]|\\.)*\"	{
+<*>\"([^\\"]|\\.)*\"	{
 			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
 			DPRINT("String: %s\n", yytext);
@@ -79,45 +78,24 @@
 			return DT_STRING;
 		}
 
-"/memreserve/"	{
+<*>"/memreserve/"	{
 			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
 			DPRINT("Keyword: /memreserve/\n");
-			BEGIN(MEMRESERVE);
-			return DT_MEMRESERVE;
-		}
-
-<MEMRESERVE>[0-9a-fA-F]+ {
-			yylloc.filenum = srcpos_filenum;
-			yylloc.first_line = yylineno;
-			if (yyleng > 2*sizeof(yylval.addr)) {
-				fprintf(stderr, "Address value %s too large\n",
-					yytext);
-			}
-			yylval.addr = (u64) strtoull(yytext, NULL, 16);
-			DPRINT("Addr: %llx\n",
-			       (unsigned long long)yylval.addr);
-			return DT_ADDR;
-		}
-
-<MEMRESERVE>";"	{
-			yylloc.filenum = srcpos_filenum;
-			yylloc.first_line = yylineno;
-			DPRINT("/MEMRESERVE\n");
 			BEGIN(INITIAL);
-			return ';';
+			return DT_MEMRESERVE;
 		}
 
 <*>[a-zA-Z_][a-zA-Z0-9_]*:	{
 			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
 			DPRINT("Label: %s\n", yytext);
-			yylval.str = strdup(yytext);
-			yylval.str[yyleng-1] = '\0';
+			yylval.labelref = strdup(yytext);
+			yylval.labelref[yyleng-1] = '\0';
 			return DT_LABEL;
 		}
 
-<CELLDATA>[bodh]# {
+[bodh]# {
 			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
 			if (*yytext == 'b')
@@ -132,27 +110,19 @@
 			return DT_BASE;
 		}
 
-<CELLDATA>[0-9a-fA-F]+	{
-			yylloc.filenum = srcpos_filenum;
-			yylloc.first_line = yylineno;
-			yylval.str = strdup(yytext);
-			DPRINT("Cell: '%s'\n", yylval.str);
-			return DT_CELL;
-		}
-
-<CELLDATA>">"	{
+[0-9a-fA-F]+	{
 			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
-			DPRINT("/CELLDATA\n");
-			BEGIN(INITIAL);
-			return '>';
+			yylval.literal = strdup(yytext);
+			DPRINT("Literal: '%s'\n", yylval.literal);
+			return DT_LITERAL;
 		}
 
-<CELLDATA>\&{REFCHAR}*	{
+\&{REFCHAR}*	{
 			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
 			DPRINT("Ref: %s\n", yytext+1);
-			yylval.str = strdup(yytext+1);
+			yylval.labelref = strdup(yytext+1);
 			return DT_REF;
 		}
 
@@ -172,30 +142,13 @@
 			return ']';
 		}
 
-,		{ /* Technically this is a valid property name,
-		     but we'd rather use it as punctuation, so detect it
-		     here in preference */
+<PROPNODENAME>{PROPCHAR}+(@{UNITCHAR}+)? {
 			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
-			DPRINT("Char (propname like): %c (\\x%02x)\n", yytext[0],
-				(unsigned)yytext[0]);
-			return yytext[0];
-		}
-
-{PROPCHAR}+	{
-			yylloc.filenum = srcpos_filenum;
-			yylloc.first_line = yylineno;
-			DPRINT("PropName: %s\n", yytext);
-			yylval.str = strdup(yytext);
-			return DT_PROPNAME;
-		}
-
-{PROPCHAR}+(@{UNITCHAR}+)? {
-			yylloc.filenum = srcpos_filenum;
-			yylloc.first_line = yylineno;
-			DPRINT("NodeName: %s\n", yytext);
-			yylval.str = strdup(yytext);
-			return DT_NODENAME;
+			DPRINT("PropNodeName: %s\n", yytext);
+			yylval.propnodename = strdup(yytext);
+			BEGIN(INITIAL);
+			return DT_PROPNODENAME;
 		}
 
 
@@ -213,21 +166,17 @@
 <*>.		{
 			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
-			switch (yytext[0]) {
-				case '<':
-					DPRINT("CELLDATA\n");
-					BEGIN(CELLDATA);
-					break;
-				case '[':
-					DPRINT("BYTESTRING\n");
-					BEGIN(BYTESTRING);
-					break;
-				default:
-
+			if (yytext[0] == '[') {
+				DPRINT("<BYTESTRING>\n");
+				BEGIN(BYTESTRING);
+			}
+			if ((yytext[0] == '{')
+			    || (yytext[0] == ';')) {
+				DPRINT("<PROPNODENAME>\n");
+				BEGIN(PROPNODENAME);
+			}
 			DPRINT("Char: %c (\\x%02x)\n", yytext[0],
 				(unsigned)yytext[0]);
-					break;
-			}
 
 			return yytext[0];
 		}
Index: dtc/dtc-parser.y
===================================================================
--- dtc.orig/dtc-parser.y	2007-11-07 10:02:42.000000000 +1100
+++ dtc/dtc-parser.y	2007-11-07 10:58:51.000000000 +1100
@@ -25,45 +25,46 @@
 #include "srcpos.h"
 
 int yylex(void);
-cell_t cell_from_string(char *s, unsigned int base);
+unsigned long long eval_literal(const char *s, int base, int bits);
 
 extern struct boot_info *the_boot_info;
 
 %}
 
 %union {
-	cell_t cval;
+	char *propnodename;
+	char *literal;
+	char *labelref;
 	unsigned int cbase;
 	u8 byte;
-	char *str;
 	struct data data;
+
+	u64 addr;
+	cell_t cell;
 	struct property *prop;
 	struct property *proplist;
 	struct node *node;
 	struct node *nodelist;
-	int datalen;
-	int hexlen;
-	u64 addr;
 	struct reserve_info *re;
 }
 
 %token DT_MEMRESERVE
-%token <addr> DT_ADDR
-%token <str> DT_PROPNAME
-%token <str> DT_NODENAME
+%token <propnodename> DT_PROPNODENAME
+%token <literal> DT_LITERAL
 %token <cbase> DT_BASE
-%token <str> DT_CELL
 %token <byte> DT_BYTE
 %token <data> DT_STRING
-%token <str> DT_LABEL
-%token <str> DT_REF
+%token <labelref> DT_LABEL
+%token <labelref> DT_REF
 
 %type <data> propdata
 %type <data> propdataprefix
 %type <re> memreserve
 %type <re> memreserves
-%type <cbase> opt_cell_base
+%type <addr> addr
 %type <data> celllist
+%type <cbase> cellbase
+%type <cell> cellval
 %type <data> bytestring
 %type <prop> propdef
 %type <proplist> proplist
@@ -72,8 +73,7 @@
 %type <node> nodedef
 %type <node> subnode
 %type <nodelist> subnodes
-%type <str> label
-%type <str> nodename
+%type <labelref> label
 
 %%
 
@@ -96,16 +96,23 @@
 	;
 
 memreserve:
-	  label DT_MEMRESERVE DT_ADDR DT_ADDR ';'
+	  label DT_MEMRESERVE addr addr ';'
 		{
 			$$ = build_reserve_entry($3, $4, $1);
 		}
-	| label DT_MEMRESERVE DT_ADDR '-' DT_ADDR ';'
+	| label DT_MEMRESERVE addr '-' addr ';'
 		{
 			$$ = build_reserve_entry($3, $5 - $3 + 1, $1);
 		}
 	;
 
+addr:
+	  DT_LITERAL
+		{
+			$$ = eval_literal($1, 16, 64);
+		}
+	  ;
+
 devicetree:
 	  '/' nodedef
 		{
@@ -132,11 +139,11 @@
 	;
 
 propdef:
-	  label DT_PROPNAME '=' propdata ';'
+	  label DT_PROPNODENAME '=' propdata ';'
 		{
 			$$ = build_property($2, $4, $1);
 		}
-	| label DT_PROPNAME ';'
+	| label DT_PROPNODENAME ';'
 		{
 			$$ = build_property($2, empty_data, $1);
 		}
@@ -176,23 +183,14 @@
 		}
 	;
 
-opt_cell_base:
-	  /* empty */
-		{
-			$$ = 16;
-		}
-	| DT_BASE
-	;
-
 celllist:
 	  /* empty */
 		{
 			$$ = empty_data;
 		}
-	| celllist opt_cell_base DT_CELL
+	| celllist cellval
 		{
-			$$ = data_append_cell($1,
-					      cell_from_string($3, $2));
+			$$ = data_append_cell($1, $2);
 		}
 	| celllist DT_REF
 		{
@@ -204,6 +202,21 @@
 		}
 	;
 
+cellbase:
+	  /* empty */
+		{
+			$$ = 16;
+		}
+	| DT_BASE
+	;
+
+cellval:
+	  cellbase DT_LITERAL
+		{
+			$$ = eval_literal($2, $1, 32);
+		}
+	;
+
 bytestring:
 	  /* empty */
 		{
@@ -231,23 +244,12 @@
 	;
 
 subnode:
-	  label nodename nodedef
+	  label DT_PROPNODENAME nodedef
 		{
 			$$ = name_node($3, $2, $1);
 		}
 	;
 
-nodename:
-	  DT_NODENAME
-		{
-			$$ = $1;
-		}
-	| DT_PROPNAME
-		{
-			$$ = $1;
-		}
-	;
-
 label:
 	  /* empty */
 		{
@@ -272,33 +274,18 @@
 		fname, yylloc.first_line, s);
 }
 
-
-/*
- * Convert a string representation of a numeric cell
- * in the given base into a cell.
- *
- * FIXME: should these specification errors be fatal instead?
- */
-
-cell_t cell_from_string(char *s, unsigned int base)
+unsigned long long eval_literal(const char *s, int base, int bits)
 {
-	cell_t c;
+	unsigned long long val;
 	char *e;
 
-	c = strtoul(s, &e, base);
-	if (*e) {
-		fprintf(stderr,
-			"Line %d: Invalid cell value '%s' : "
-			"%c is not a base %d digit; %d assumed\n",
-			yylloc.first_line, s, *e, base, c);
-	}
-
-	if (errno == EINVAL || errno == ERANGE) {
-		fprintf(stderr,
-			"Line %d: Invalid cell value '%s'; %d assumed\n",
-			yylloc.first_line, s, c);
-		errno = 0;
-	}
-
-	return c;
+	errno = 0;
+	val = strtoull(s, &e, base);
+	if (*e)
+		yyerror("bad characters in literal");
+	else if ((errno == ERANGE) || (val > ((1ULL << bits)-1)))
+		yyerror("literal out of range");
+	else if (errno != 0)
+		yyerror("bad literal");
+	return val;
 }


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

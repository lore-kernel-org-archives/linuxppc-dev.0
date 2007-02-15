Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 48D0CDDD03
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 04:13:09 +1100 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>) id 1HHkAL-0005Xl-2f
	for linuxppc-dev@ozlabs.org; Thu, 15 Feb 2007 11:13:06 -0600
To: linuxppc-dev@ozlabs.org
Subject: [DTC PATCH] Add support for decimal,
	octal and binary based cell values.
Date: Thu, 15 Feb 2007 11:13:05 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1HHkAL-0005Xl-2f@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


New syntax d#, b#, o# and h# allow for an explicit prefix
on cell values to specify their base.  Eg: <d# 123>

Signed-off-by: Jon Loeliger <jdl@freescale.com>

---

Beginnings of test cases in the next patch.
Don't stress the yylloc too much.  We'll eventually
work to make that better and more general later.


 data.c       |   21 +++++++++++++++++++++
 dtc-lexer.l  |   21 +++++++++++++++------
 dtc-parser.y |   16 ++++++++++++++--
 dtc.h        |    1 +
 4 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/data.c b/data.c
index 1907a1a..c6c2350 100644
--- a/data.c
+++ b/data.c
@@ -19,6 +19,7 @@
  */
 
 #include "dtc.h"
+#include "dtc-parser.tab.h"
 
 void fixup_free(struct fixup *f)
 {
@@ -224,6 +225,26 @@ struct data data_merge(struct data d1, struct data d2)
 	return d;
 }
 
+/*
+ * Convert a string representation of a numberic cell
+ * in the given base into a cell.
+ */
+cell_t data_convert_cell(char *s, unsigned int base)
+{
+	cell_t c;
+	extern YYLTYPE yylloc;
+
+	c = strtoul(s, NULL, base);
+	if (errno == EINVAL || errno == ERANGE) {
+		fprintf(stderr,
+			"Line %d: Invalid cell value '%s'; %d assumed\n",
+			yylloc.first_line, s, c);
+	}
+
+	return c;
+}
+
+
 struct data data_append_cell(struct data d, cell_t word)
 {
 	cell_t beword = cpu_to_be32(word);
diff --git a/dtc-lexer.l b/dtc-lexer.l
index 6146bad..93f3268 100644
--- a/dtc-lexer.l
+++ b/dtc-lexer.l
@@ -83,15 +83,24 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
 			BEGIN(INITIAL);
 			return ';';
 		}
+<CELLDATA>[bodh]# {
+			yylloc.first_line = yylineno;
+			if (*yytext == 'b')
+				yylval.cbase = 2;
+			else if (*yytext == 'o')
+				yylval.cbase = 8;
+			else if (*yytext == 'd')
+				yylval.cbase = 10;
+			else
+				yylval.cbase = 16;
+			DPRINT("Base: %d\n", yylval.cbase);
+			return DT_BASE;
+		}
 
 <CELLDATA>[0-9a-fA-F]+	{
 			yylloc.first_line = yylineno;
-			if (yyleng > 2*sizeof(yylval.cval)) {
-				fprintf(stderr,
-					"Cell value %s too long\n", yytext);
-			}
-			yylval.cval = strtoul(yytext, NULL, 16);
-			DPRINT("Cell: %x\n", yylval.cval);
+			yylval.str = strdup(yytext);
+			DPRINT("Cell: '%s'\n", yylval.str);
 			return DT_CELL;
 		}
 
diff --git a/dtc-parser.y b/dtc-parser.y
index bd725fe..992fdb1 100644
--- a/dtc-parser.y
+++ b/dtc-parser.y
@@ -33,6 +33,7 @@ extern struct boot_info *the_boot_info;
 
 %union {
 	cell_t cval;
+	unsigned int cbase;
 	u8 byte;
 	char *str;
 	struct data data;
@@ -50,7 +51,8 @@ extern struct boot_info *the_boot_info;
 %token <addr> DT_ADDR
 %token <str> DT_PROPNAME
 %token <str> DT_NODENAME
-%token <cval> DT_CELL
+%token <cbase> DT_BASE
+%token <str> DT_CELL
 %token <byte> DT_BYTE
 %token <data> DT_STRING
 %token <str> DT_UNIT
@@ -61,6 +63,7 @@ extern struct boot_info *the_boot_info;
 %type <data> propdataprefix
 %type <re> memreserve
 %type <re> memreserves
+%type <cbase> opt_cell_base
 %type <data> celllist
 %type <data> bytestring
 %type <prop> propdef
@@ -133,7 +136,16 @@ propdataprefix:	propdata ',' { $$ = $1; }
 	|	/* empty */ { $$ = empty_data; }
 	;
 
-celllist:	celllist DT_CELL { $$ = data_append_cell($1, $2); }
+opt_cell_base:
+	  /* empty */
+		{ $$ = 16; }
+	| DT_BASE
+	;
+
+celllist:	celllist opt_cell_base DT_CELL {
+			$$ = data_append_cell($1,
+					      data_convert_cell($3, $2));
+		}
 	|	celllist DT_REF	{
 			$$ = data_append_cell(data_add_fixup($1, $2), -1);
 		}
diff --git a/dtc.h b/dtc.h
index 8d3964c..7ee96a5 100644
--- a/dtc.h
+++ b/dtc.h
@@ -118,6 +118,7 @@ struct data data_copy_mem(char *mem, int len);
 struct data data_copy_escape_string(char *s, int len);
 struct data data_copy_file(FILE *f, size_t len);
 
+cell_t data_convert_cell(char *s, unsigned int base);
 struct data data_append_data(struct data d, void *p, int len);
 struct data data_merge(struct data d1, struct data d2);
 struct data data_append_cell(struct data d, cell_t word);
-- 
1.5.0.rc3.ge4b0e

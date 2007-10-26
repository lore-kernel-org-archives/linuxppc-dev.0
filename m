Return-Path: <dgibson@ozlabs.org>
Date: Fri, 26 Oct 2007 16:20:29 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: [2/2] dtc: Switch dtc to C-style literals
Message-ID: <20071026062029.GC6136@localhost.localdomain>
References: <20071026061718.GA6136@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071026061718.GA6136@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch introduces a new version of dts file, distinguished from
older files by starting with the special token /dts-v1/.  dts files in
the new version take C-style literals instead of the old bare hex or
OF-style base notation.  In addition, the "range" for of memreserve entries
(/memreserve/ f0000-fffff) is no longer recognized in the new format.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---
 dtc-lexer.l               |   40 ++++++++++++++++++++++++++++++++--------
 dtc-parser.y              |   38 ++++++++++++++++++++++++++++++++++++--
 tests/run_tests.sh        |    4 ++++
 tests/test_tree1.dts      |   16 +++++++++-------
 tests/test_tree1_dts0.dts |   27 +++++++++++++++++++++++++++
 5 files changed, 108 insertions(+), 17 deletions(-)

Index: dtc/dtc-lexer.l
===================================================================
--- dtc.orig/dtc-lexer.l	2007-10-26 15:11:02.000000000 +1000
+++ dtc/dtc-lexer.l	2007-10-26 15:36:46.000000000 +1000
@@ -23,6 +23,7 @@
 %x INCLUDE
 %x BYTESTRING
 %x PROPNODENAME
+%s V1
 
 PROPCHAR	[a-zA-Z0-9,._+*#?-]
 UNITCHAR	[0-9a-f,]
@@ -44,12 +45,18 @@
 #define DPRINT(fmt, ...)	do { } while (0)
 #endif
 
+static int dts_version; /* = 0 */
 
-
+#define BEGIN_DEFAULT()	if (dts_version == 0) { \
+				DPRINT("<INITIAL>\n"); \
+				BEGIN(INITIAL); \
+			} else { \
+				DPRINT("<V1>\n"); \
+				BEGIN(V1); \
+			}
 %}
 
 %%
-
 <*>"/include/"		BEGIN(INCLUDE);
 
 <INCLUDE>\"[^"\n]*\"	{
@@ -58,7 +65,7 @@
 				/* Some unrecoverable error.*/
 				exit(1);
 			}
-			BEGIN(INITIAL);
+			BEGIN_DEFAULT();
 		}
 
 
@@ -78,11 +85,20 @@
 			return DT_STRING;
 		}
 
+<*>"/dts-v1/"	{
+			yylloc.filenum = srcpos_filenum;
+			yylloc.first_line = yylineno;
+			DPRINT("Keyword: /dts-v1/\n");
+			dts_version = 1;
+			BEGIN_DEFAULT();
+			return DT_V1;
+		}
+
 <*>"/memreserve/"	{
 			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
 			DPRINT("Keyword: /memreserve/\n");
-			BEGIN(INITIAL);
+			BEGIN_DEFAULT();
 			return DT_MEMRESERVE;
 		}
 
@@ -95,7 +111,7 @@
 			return DT_LABEL;
 		}
 
-[bodh]# {
+<INITIAL>[bodh]# {
 			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
 			if (*yytext == 'b')
@@ -110,7 +126,15 @@
 			return DT_BASE;
 		}
 
-[0-9a-fA-F]+	{
+<INITIAL>[0-9a-fA-F]+	{
+			yylloc.filenum = srcpos_filenum;
+			yylloc.first_line = yylineno;
+			yylval.literal = strdup(yytext);
+			DPRINT("Literal: '%s'\n", yylval.literal);
+			return DT_LEGACYLITERAL;
+		}
+
+<V1>[0-9]+|0[xX][0-9a-fA-F]+      {
 			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
 			yylval.literal = strdup(yytext);
@@ -138,7 +162,7 @@
 			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
 			DPRINT("/BYTESTRING\n");
-			BEGIN(INITIAL);
+			BEGIN_DEFAULT();
 			return ']';
 		}
 
@@ -147,7 +171,7 @@
 			yylloc.first_line = yylineno;
 			DPRINT("PropNodeName: %s\n", yytext);
 			yylval.propnodename = strdup(yytext);
-			BEGIN(INITIAL);
+			BEGIN_DEFAULT();
 			return DT_PROPNODENAME;
 		}
 
Index: dtc/dtc-parser.y
===================================================================
--- dtc.orig/dtc-parser.y	2007-10-26 15:11:02.000000000 +1000
+++ dtc/dtc-parser.y	2007-10-26 15:49:05.000000000 +1000
@@ -48,9 +48,11 @@
 	struct reserve_info *re;
 }
 
+%token DT_V1
 %token DT_MEMRESERVE
 %token <propnodename> DT_PROPNODENAME
 %token <literal> DT_LITERAL
+%token <literal> DT_LEGACYLITERAL
 %token <cbase> DT_BASE
 %token <byte> DT_BYTE
 %token <data> DT_STRING
@@ -61,6 +63,8 @@
 %type <data> propdataprefix
 %type <re> memreserve
 %type <re> memreserves
+%type <re> v0_memreserve
+%type <re> v0_memreserves
 %type <addr> addr
 %type <data> celllist
 %type <cbase> cellbase
@@ -78,7 +82,11 @@
 %%
 
 sourcefile:
-	  memreserves devicetree
+	  DT_V1 ';' memreserves devicetree
+		{
+			the_boot_info = build_boot_info($3, $4);
+		}
+	| v0_memreserves devicetree
 		{
 			the_boot_info = build_boot_info($1, $2);
 		}
@@ -100,6 +108,24 @@
 		{
 			$$ = build_reserve_entry($3, $4, $1);
 		}
+	;
+
+v0_memreserves:
+	  /* empty */
+		{
+			$$ = NULL;
+		}
+	| v0_memreserve v0_memreserves
+		{
+			$$ = chain_reserve_entry($1, $2);
+		};
+	;
+
+v0_memreserve:
+	  memreserve
+		{
+			$$ = $1;
+		}
 	| label DT_MEMRESERVE addr '-' addr ';'
 		{
 			$$ = build_reserve_entry($3, $5 - $3 + 1, $1);
@@ -108,6 +134,10 @@
 
 addr:
 	  DT_LITERAL
+	  	{
+			$$ = eval_literal($1, 0, 64);
+		}
+	| DT_LEGACYLITERAL
 		{
 			$$ = eval_literal($1, 16, 64);
 		}
@@ -212,7 +242,11 @@
 	;
 
 cellval:
-	  cellbase DT_LITERAL
+	  DT_LITERAL
+		{
+			$$ = eval_literal($1, 0, 32);
+		}
+	| cellbase DT_LEGACYLITERAL
 		{
 			$$ = eval_literal($2, $1, 32);
 		}
Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2007-10-26 15:11:02.000000000 +1000
+++ dtc/tests/run_tests.sh	2007-10-26 15:18:43.000000000 +1000
@@ -118,6 +118,10 @@
     tree1_tests_rw dtc_tree1.test.dtb
     run_test dtbs_equal_ordered dtc_tree1.test.dtb test_tree1.dtb
 
+    run_test dtc.sh -I dts -O dtb -o dtc_tree1_dts0.test.dtb test_tree1_dts0.dts
+    tree1_tests dtc_tree1_dts0.test.dtb
+    tree1_tests_rw dtc_tree1_dts0.test.dtb
+
     run_test dtc.sh -I dts -O dtb -o dtc_escapes.test.dtb escapes.dts
     run_test string_escapes dtc_escapes.test.dtb
 }
Index: dtc/tests/test_tree1.dts
===================================================================
--- dtc.orig/tests/test_tree1.dts	2007-10-26 15:11:02.000000000 +1000
+++ dtc/tests/test_tree1.dts	2007-10-26 15:18:43.000000000 +1000
@@ -1,27 +1,29 @@
-/memreserve/ deadbeef00000000-deadbeef000fffff;
-/memreserve/ abcd1234 00001234;
+/dts-v1/;
+
+/memreserve/ 0xdeadbeef00000000 0x100000;
+/memreserve/ 0xabcd1234 0x00001234;
 
 / {
 	compatible = "test_tree1";
-	prop-int = <deadbeef>;
+	prop-int = <0xdeadbeef>;
 	prop-str = "hello world";
 
 	subnode@1 {
 		compatible = "subnode1";
-		prop-int = <deadbeef>;
+		prop-int = <0xdeadbeef>;
 
 		subsubnode {
 			compatible = "subsubnode1", "subsubnode";
-			prop-int = <deadbeef>;
+			prop-int = <0xdeadbeef>;
 		};
 	};
 
 	subnode@2 {
-		prop-int = <abcd1234>;
+		prop-int = <0xabcd1234>;
 
 		subsubnode@0 {
 			compatible = "subsubnode2", "subsubnode";
-			prop-int = <abcd1234>;
+			prop-int = <0xabcd1234>;
 		};
 	};
 };
Index: dtc/tests/test_tree1_dts0.dts
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/test_tree1_dts0.dts	2007-10-26 15:18:43.000000000 +1000
@@ -0,0 +1,27 @@
+/memreserve/ deadbeef00000000-deadbeef000fffff;
+/memreserve/ abcd1234 00001234;
+
+/ {
+	compatible = "test_tree1";
+	prop-int = <deadbeef>;
+	prop-str = "hello world";
+
+	subnode@1 {
+		compatible = "subnode1";
+		prop-int = <deadbeef>;
+
+		subsubnode {
+			compatible = "subsubnode1", "subsubnode";
+			prop-int = <deadbeef>;
+		};
+	};
+
+	subnode@2 {
+		prop-int = <abcd1234>;
+
+		subsubnode@0 {
+			compatible = "subsubnode2", "subsubnode";
+			prop-int = <abcd1234>;
+		};
+	};
+};


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

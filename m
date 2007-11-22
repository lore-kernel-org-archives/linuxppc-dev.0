Return-Path: <dgibson@ozlabs.org>
Date: Thu, 22 Nov 2007 17:10:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: RFC: Fix some lexical problems with references
Message-ID: <20071122061007.GA22888@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The recent change to the lexer to only recognize property and node
names in the appropriate context removed a number of lexical warts in
our language that would have gotten ugly as we add expression support
and so forth.

But there's one nasty one remaining: references can contain a full
path, including the various problematic node name characters (',', '+'
and '-', for example).  This would cause trouble with expressions, and
it also causes trouble with the patch I'm working on to allow
expanding references to paths rather than phandles.  This patch
therefore reworks the lexer to mitigate these problems.

	- References to labels cause no problems.  These are now
recognized separately from references to full paths.  No syntax change
here.

	- References to full paths, including problematic characters
are allowed by "quoting" the path with braces
e.g. &{/pci@10000/somedevice@3,8000}.  The braces protect any internal
problematic characters from being confused with operators or whatever.

	- For compatibility with existing dts files, in v0 dts files
we allow bare references to paths as before &/foo/bar/whatever - but
*only* if the path contains no troublesome characters.  Specifically
only [a-zA-Z0-9_@/] are allowed.

This is an incompatible change to the dts-v1 format, but since AFAIK
no-one has yet switched to dts-v1 files, I think we can get away with
it.  Better to make the transition when people to convert to v1, and
get rid of the problematic old syntax.

Strictly speaking, it's also an incompatible change to the v0 format,
since some path references that were allowed before are no longer
allowed.  I suspect no-one has been using the no-longer-supported
forms (certainly none of the kernel dts files will cause trouble).  We
might need to think about this harder, though.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/dtc-lexer.l
===================================================================
--- dtc.orig/dtc-lexer.l	2007-11-22 16:33:47.000000000 +1100
+++ dtc/dtc-lexer.l	2007-11-22 16:40:48.000000000 +1100
@@ -25,12 +25,12 @@
 %x PROPNODENAME
 %s V1
 
-PROPCHAR	[a-zA-Z0-9,._+*#?-]
-UNITCHAR	[0-9a-f,]
+PROPNODECHAR	[a-zA-Z0-9,._+*#?@-]
+PATHCHAR	({PROPNODECHAR}|[/])
+LEGACYPATHCHAR	[a-zA-Z0-9_@/]
+LABEL		[a-zA-Z_][a-zA-Z0-9_]*
 WS		[[:space:]]
 
-REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
-
 %{
 #include "dtc.h"
 #include "srcpos.h"
@@ -102,7 +102,7 @@
 			return DT_MEMRESERVE;
 		}
 
-<*>[a-zA-Z_][a-zA-Z0-9_]*:	{
+<*>{LABEL}:	{
 			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
 			DPRINT("Label: %s\n", yytext);
@@ -142,7 +142,24 @@
 			return DT_LITERAL;
 		}
 
-\&{REFCHAR}*	{
+\&{LABEL}	{	/* label reference */
+			yylloc.filenum = srcpos_filenum;
+			yylloc.first_line = yylineno;
+			DPRINT("Ref: %s\n", yytext+1);
+			yylval.labelref = strdup(yytext+1);
+			return DT_REF;
+		}
+
+"&{/"{PATHCHAR}+\}	{	/* new-style path reference */
+			yylloc.filenum = srcpos_filenum;
+			yylloc.first_line = yylineno;
+			yytext[yyleng-1] = '\0';
+			DPRINT("Ref: %s\n", yytext+2);
+			yylval.labelref = strdup(yytext+2);
+			return DT_REF;
+		}
+
+<INITIAL>"&/"{LEGACYPATHCHAR}+ {	/* old-style path reference */
 			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
 			DPRINT("Ref: %s\n", yytext+1);
@@ -166,7 +183,7 @@
 			return ']';
 		}
 
-<PROPNODENAME>{PROPCHAR}+(@{UNITCHAR}+)? {
+<PROPNODENAME>{PROPNODECHAR}+ {
 			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
 			DPRINT("PropNodeName: %s\n", yytext);
Index: dtc/tests/nonexist-node-ref.dts
===================================================================
--- dtc.orig/tests/nonexist-node-ref.dts	2007-11-22 16:33:47.000000000 +1100
+++ dtc/tests/nonexist-node-ref.dts	2007-11-22 16:34:12.000000000 +1100
@@ -1,8 +1,8 @@
 /dts-v1/;
 
 / {
-	ref = < &/node >;
-	badref = < &/nosuchnode >;
+	ref = < &{/node} >;
+	badref = < &{/nosuchnode} >;
 	label: node {
 	};
 };
Index: dtc/tests/references.dts
===================================================================
--- dtc.orig/tests/references.dts	2007-11-22 16:33:47.000000000 +1100
+++ dtc/tests/references.dts	2007-11-22 16:34:12.000000000 +1100
@@ -4,18 +4,18 @@
 	/* Explicit phandles */
 	n1: node1 {
 		linux,phandle = <0x2000>;
-		ref = <&/node2>; /* reference precedes target */
+		ref = <&{/node2}>; /* reference precedes target */
 		lref = <&n2>;
 	};
 	n2: node2 {
 		linux,phandle = <0x1>;
-		ref = <&/node1>; /* reference after target */
+		ref = <&{/node1}>; /* reference after target */
 		lref = <&n1>;
 	};
 
 	/* Implicit phandles */
 	n3: node3 {
-		ref = <&/node4>;
+		ref = <&{/node4}>;
 		lref = <&n4>;
 	};
 	n4: node4 {
Index: dtc/tests/references_dts0.dts
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/references_dts0.dts	2007-11-22 16:34:12.000000000 +1100
@@ -0,0 +1,21 @@
+/ {
+	/* Explicit phandles */
+	n1: node1 {
+		linux,phandle = <2000>;
+		ref = <&/node2>; /* reference precedes target */
+		lref = <&n2>;
+	};
+	n2: node2 {
+		linux,phandle = <1>;
+		ref = <&/node1>; /* reference after target */
+		lref = <&n1>;
+	};
+
+	/* Implicit phandles */
+	n3: node3 {
+		ref = <&/node4>;
+		lref = <&n4>;
+	};
+	n4: node4 {
+	};
+};
Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2007-11-22 16:33:47.000000000 +1100
+++ dtc/tests/run_tests.sh	2007-11-22 16:34:12.000000000 +1100
@@ -145,6 +145,9 @@
     run_test dtc.sh -I dts -O dtb -o dtc_references.test.dtb references.dts
     run_test references dtc_references.test.dtb
 
+    run_test dtc.sh -I dts -O dtb -o dtc_references_dts0.test.dtb references_dts0.dts
+    run_test references dtc_references_dts0.test.dtb
+
     # Check -Odts mode preserve all dtb information
     for tree in test_tree1.dtb dtc_tree1.test.dtb dtc_escapes.test.dtb ; do
 	run_test dtc.sh -I dtb -O dts -o odts_$tree.test.dts $tree


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

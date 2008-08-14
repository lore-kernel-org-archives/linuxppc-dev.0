Return-Path: <jdl@jdl.com>
To: devicetree-discuss@ozlabs.org
Subject: [PATCH V2] DTC: Remove support for the legacy DTS source file format.
Date: Thu, 14 Aug 2008 18:02:43 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1KTlq7-0005Gh-Co@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that all in-kernel-tree DTS files are properly /dts-v1/,
remove direct support for the older, un-numbered DTS
source file format.

Convert existing tests to /dts-v1/ and remove support
for the conversion tests themselves.

For now, though, the conversion tool still exists.

Signed-off-by: Jon Loeliger <jdl@freescale.com>

---

Bah.  Forgot to eliminate the legacy BASE and
LITERAL tokens in the first version of this patch.

There's still a bit more improvement possible WRT
the initial dts_versio value and lexer state.  Later.

 dtc-lexer.l               |   23 ----------------------
 dtc-parser.y              |   46 ---------------------------------------------
 tests/base01.dts          |   24 ++++++++++++----------
 tests/empty.dts           |    2 +
 tests/escapes.dts         |    2 +
 tests/label01.dts         |   38 +++++++++++++++++++-----------------
 tests/references_dts0.dts |   12 ++++++----
 tests/run_tests.sh        |   27 +-------------------------
 tests/test01.dts          |   38 +++++++++++++++++++-----------------
 tests/test_tree1_dts0.dts |   18 +++++++++-------
 10 files changed, 75 insertions(+), 155 deletions(-)

diff --git a/dtc-lexer.l b/dtc-lexer.l
index 6f8b7dd..e12a4ef 100644
--- a/dtc-lexer.l
+++ b/dtc-lexer.l
@@ -110,29 +110,6 @@ static int pop_input_file(void);
 			return DT_LABEL;
 		}
 
-<INITIAL>[bodh]# {
-			yylloc.file = srcpos_file;
-			yylloc.first_line = yylineno;
-			if (*yytext == 'b')
-				yylval.cbase = 2;
-			else if (*yytext == 'o')
-				yylval.cbase = 8;
-			else if (*yytext == 'd')
-				yylval.cbase = 10;
-			else
-				yylval.cbase = 16;
-			DPRINT("Base: %d\n", yylval.cbase);
-			return DT_BASE;
-		}
-
-<INITIAL>[0-9a-fA-F]+	{
-			yylloc.file = srcpos_file;
-			yylloc.first_line = yylineno;
-			yylval.literal = strdup(yytext);
-			DPRINT("Literal: '%s'\n", yylval.literal);
-			return DT_LEGACYLITERAL;
-		}
-
 <V1>[0-9]+|0[xX][0-9a-fA-F]+      {
 			yylloc.file = srcpos_file;
 			yylloc.first_line = yylineno;
diff --git a/dtc-parser.y b/dtc-parser.y
index b2ab562..3762181 100644
--- a/dtc-parser.y
+++ b/dtc-parser.y
@@ -55,7 +55,6 @@ static unsigned long long eval_literal(const char *s, int base, int bits);
 %token DT_MEMRESERVE
 %token <propnodename> DT_PROPNODENAME
 %token <literal> DT_LITERAL
-%token <literal> DT_LEGACYLITERAL
 %token <cbase> DT_BASE
 %token <byte> DT_BYTE
 %token <data> DT_STRING
@@ -67,11 +66,8 @@ static unsigned long long eval_literal(const char *s, int base, int bits);
 %type <data> propdataprefix
 %type <re> memreserve
 %type <re> memreserves
-%type <re> v0_memreserve
-%type <re> v0_memreserves
 %type <addr> addr
 %type <data> celllist
-%type <cbase> cellbase
 %type <cell> cellval
 %type <data> bytestring
 %type <prop> propdef
@@ -90,10 +86,6 @@ sourcefile:
 		{
 			the_boot_info = build_boot_info($3, $4, 0);
 		}
-	| v0_memreserves devicetree
-		{
-			the_boot_info = build_boot_info($1, $2, 0);
-		}
 	;
 
 memreserves:
@@ -114,37 +106,11 @@ memreserve:
 		}
 	;
 
-v0_memreserves:
-	  /* empty */
-		{
-			$$ = NULL;
-		}
-	| v0_memreserve v0_memreserves
-		{
-			$$ = chain_reserve_entry($1, $2);
-		};
-	;
-
-v0_memreserve:
-	  memreserve
-		{
-			$$ = $1;
-		}
-	| label DT_MEMRESERVE addr '-' addr ';'
-		{
-			$$ = build_reserve_entry($3, $5 - $3 + 1, $1);
-		}
-	;
-
 addr:
 	  DT_LITERAL
 		{
 			$$ = eval_literal($1, 0, 64);
 		}
-	| DT_LEGACYLITERAL
-		{
-			$$ = eval_literal($1, 16, 64);
-		}
 	  ;
 
 devicetree:
@@ -269,23 +235,11 @@ celllist:
 		}
 	;
 
-cellbase:
-	  /* empty */
-		{
-			$$ = 16;
-		}
-	| DT_BASE
-	;
-
 cellval:
 	  DT_LITERAL
 		{
 			$$ = eval_literal($1, 0, 32);
 		}
-	| cellbase DT_LEGACYLITERAL
-		{
-			$$ = eval_literal($2, $1, 32);
-		}
 	;
 
 bytestring:
diff --git a/tests/base01.dts b/tests/base01.dts
index f84bc49..97a5dd5 100644
--- a/tests/base01.dts
+++ b/tests/base01.dts
@@ -1,3 +1,5 @@
+/dts-v1/;
+
 / {
 	model = "SomeModel";
 	compatible = "Nothing";
@@ -6,26 +8,26 @@
 
         memory@0 {
                 device_type = "memory";
-		reg = <00000000 00000000 00000000 20000000>;
+		reg = <0x00000000 0x00000000 0x00000000 0x20000000>;
         };
 
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		d10 = <d# 10>;		// hex: 0xa
-		d23 = <d# 23>;		// hex: 0x17
-		b101 = <b# 101>;	// hex: 0x5
-		o17 = <o# 17>;		// hex: 0xf
-		hd00d = <h# d00d>;	// hex: 0xd00d
+		d10 = < 10>;		// hex: 0xa
+		d23 = < 23>;		// hex: 0x17
+		b101 = < 0x5>;	// hex: 0x5
+		o17 = < 017>;		// hex: 0xf
+		hd00d = < 0xd00d>;	// hex: 0xd00d
 
 		//   hex:  0x4d2    0x163e      0x2334    0xd80
-		stuff = <d# 1234    d# 5678    d# 9012    d# 3456>;
+		stuff = < 1234     5678     9012     3456>;
 
 
-		bad-d-1 = <d# abc123>;		// Hrm. 0
-		bad-d-2 = <d# 123456789012345>;
-		bad-o-1 = <o# 891>;
-		bad-o-2 = <o# 123456123456>;
+		bad-d-1 = < 0>;		// Hrm. 0
+		bad-d-2 = < 123456789012345>;
+		bad-o-1 = < 00>;
+		bad-o-2 = < 0123456123456>;
 	};
 
 };
diff --git a/tests/empty.dts b/tests/empty.dts
index 336d7a2..e160dad 100644
--- a/tests/empty.dts
+++ b/tests/empty.dts
@@ -1,2 +1,4 @@
+/dts-v1/;
+
 / {
 };
diff --git a/tests/escapes.dts b/tests/escapes.dts
index f1b8dbc..e05ab46 100644
--- a/tests/escapes.dts
+++ b/tests/escapes.dts
@@ -1,3 +1,5 @@
+/dts-v1/;
+
 / {
 	compatible = "test_string_escapes";
 	escape-str = "nastystring: \a\b\t\n\v\f\r\\\"";
diff --git a/tests/label01.dts b/tests/label01.dts
index 372b17a..a895803 100644
--- a/tests/label01.dts
+++ b/tests/label01.dts
@@ -1,6 +1,8 @@
-/memreserve/ 1000000000000000 0000000002000000;
-memrsv2: /memreserve/ 2000000000000000-20ffffffffffffff;
-/memreserve/ 0-13;
+/dts-v1/;
+
+/memreserve/ 0x1000000000000000 0x0000000002000000;
+memrsv2: /memreserve/ 0x2000000000000000 0x0100000000000000;
+/memreserve/ 0x0000000000000000 0x0000000000000014;
 
 / {
 	model = "MyBoardName";
@@ -9,28 +11,28 @@ memrsv2: /memreserve/ 2000000000000000-20ffffffffffffff;
 	#size-cells = <2>;
 
 	cpus {
-		linux,phandle = <1>;
+		linux,phandle = <0x1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		PowerPC,970@0 {
 			name = "PowerPC,970";
 			device_type = "cpu";
-			reg = <0>;
-			clock-frequency = <5f5e1000>;
-			timebase-frequency = <1FCA055>;
+			reg = <0x00000000>;
+			clock-frequency = <1600000000>;
+			timebase-frequency = <33333333>;
 			linux,boot-cpu;
-			i-cache-size = <10000>;
-			d-cache-size = <8000>;
+			i-cache-size = <65536>;
+			d-cache-size = <32768>;
 		};
 
 		PowerPC,970@1 {
 			name = "PowerPC,970";
 			device_type = "cpu";
-			reg = <1>;
-			clock-frequency = <5f5e1000>;
-			timebase-frequency = <1FCA055>;
-			i-cache-size = <10000>;
-			d-cache-size = <8000>;
+			reg = <0x00000001>;
+			clock-frequency = <1600000000>;
+			timebase-frequency = <33333333>;
+			i-cache-size = <65536>;
+			d-cache-size = <32768>;
 		};
 
 	};
@@ -38,8 +40,8 @@ memrsv2: /memreserve/ 2000000000000000-20ffffffffffffff;
 	node: randomnode {
 		prop: string = str: "foo", str_mid: "stuffstuff\t\t\t\n\n\n" str_end: ;
 		blob = [byte: 0a 0b 0c 0d byte_mid: de ea ad be ef byte_end: ];
-		ref = < cell: &/memory@0 0 cell_mid: ffffffff cell_end: >;
-		mixed = "abc", pre: [1234] post: , gap: < aligned: a b c>;
+		ref = < cell: &{/memory@0} 0x0 cell_mid: 0xffffffff cell_end: >;
+		mixed = "abc", pre: [1234] post: , gap: < aligned: 0xa 0xb 0xc>;
 		tricky1 = [61 lt1: 62 63 00];
 		subnode: child {
 		};
@@ -49,12 +51,12 @@ memrsv2: /memreserve/ 2000000000000000-20ffffffffffffff;
 
 	memory@0 {
 		device_type = "memory";
-		memreg: reg = <00000000 00000000 00000000 20000000>;
+		memreg: reg = <0x00000000 0x00000000 0x00000000 0x20000000>;
 	};
 
 	chosen {
 		bootargs = "root=/dev/sda2";
-		linux,platform = <00000600>;
+		linux,platform = <0x600>;
 	};
 
 };
diff --git a/tests/references_dts0.dts b/tests/references_dts0.dts
index df82c23..36b6f51 100644
--- a/tests/references_dts0.dts
+++ b/tests/references_dts0.dts
@@ -1,19 +1,21 @@
+/dts-v1/;
+
 / {
 	/* Explicit phandles */
 	n1: node1 {
-		linux,phandle = <2000>;
-		ref = <&/node2>; /* reference precedes target */
+		linux,phandle = <0x2000>;
+		ref = <&{/node2}>; /* reference precedes target */
 		lref = <&n2>;
 	};
 	n2: node2 {
-		linux,phandle = <1>;
-		ref = <&/node1>; /* reference after target */
+		linux,phandle = <0x1>;
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
diff --git a/tests/run_tests.sh b/tests/run_tests.sh
index eb29462..30cd9a1 100755
--- a/tests/run_tests.sh
+++ b/tests/run_tests.sh
@@ -71,13 +71,6 @@ run_dtc_test () {
     base_run_test wrap_test $VALGRIND $DTC "$@"
 }
 
-CONVERT=../convert-dtsv0
-
-run_convert_test () {
-    echo -n "convert-dtsv0 $@:	"
-    base_run_test wrap_test $VALGRIND $CONVERT "$@"
-}
-
 tree1_tests () {
     TREE=$1
 
@@ -287,21 +280,6 @@ dtc_tests () {
     run_sh_test dtc-fatal.sh -I fs -O dtb nosuchfile
 }
 
-convert_tests () {
-    V0_DTS="test_tree1_dts0.dts references_dts0.dts empty.dts escapes.dts \
-	test01.dts label01.dts"
-    for dts in $V0_DTS; do
-	run_dtc_test -I dts -O dtb -o cvtraw_$dts.test.dtb $dts
-	run_dtc_test -I dts -O dts -o cvtdtc_$dts.test.dts $dts
-	run_dtc_test -I dts -O dtb -o cvtdtc_$dts.test.dtb cvtdtc_$dts.test.dts
-	run_convert_test $dts
-	run_dtc_test -I dts -O dtb -o cvtcvt_$dts.test.dtb ${dts}v1
-
-	run_wrap_test cmp cvtraw_$dts.test.dtb cvtdtc_$dts.test.dtb
-	run_wrap_test cmp cvtraw_$dts.test.dtb cvtcvt_$dts.test.dtb
-    done
-}
-
 while getopts "vt:m" ARG ; do
     case $ARG in
 	"v")
@@ -317,7 +295,7 @@ while getopts "vt:m" ARG ; do
 done
 
 if [ -z "$TESTSETS" ]; then
-    TESTSETS="libfdt dtc convert"
+    TESTSETS="libfdt dtc"
 fi
 
 # Make sure we don't have stale blobs lying around
@@ -331,9 +309,6 @@ for set in $TESTSETS; do
 	"dtc")
 	    dtc_tests
 	    ;;
-	"convert")
-	    convert_tests
-	    ;;
     esac
 done
 
diff --git a/tests/test01.dts b/tests/test01.dts
index ed2b178..f9fd165 100644
--- a/tests/test01.dts
+++ b/tests/test01.dts
@@ -1,6 +1,8 @@
-/memreserve/ 1000000000000000 0000000002000000;
-/memreserve/ 2000000000000000-20ffffffffffffff;
-/memreserve/ 0-13;
+/dts-v1/;
+
+/memreserve/ 0x1000000000000000 0x0000000002000000;
+/memreserve/ 0x2000000000000000 0x0100000000000000;
+/memreserve/ 0x0000000000000000 0x0000000000000014;
 
 / {
 	model = "MyBoardName";
@@ -9,28 +11,28 @@
 	#size-cells = <2>;
 
 	cpus {
-		linux,phandle = <1>;
+		linux,phandle = <0x1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		PowerPC,970@0 {
 			name = "PowerPC,970";
 			device_type = "cpu";
-			reg = <0>;
-			clock-frequency = <5f5e1000>;
-			timebase-frequency = <1FCA055>;
+			reg = <0x00000000>;
+			clock-frequency = <1600000000>;
+			timebase-frequency = <33333333>;
 			linux,boot-cpu;
-			i-cache-size = <10000>;
-			d-cache-size = <8000>;
+			i-cache-size = <65536>;
+			d-cache-size = <32768>;
 		};
 
 		PowerPC,970@1 {
 			name = "PowerPC,970";
 			device_type = "cpu";
-			reg = <1>;
-			clock-frequency = <5f5e1000>;
-			timebase-frequency = <1FCA055>;
-			i-cache-size = <10000>;
-			d-cache-size = <8000>;
+			reg = <0x00000001>;
+			clock-frequency = <1600000000>;
+			timebase-frequency = <33333333>;
+			i-cache-size = <65536>;
+			d-cache-size = <32768>;
 		};
 
 	};
@@ -38,18 +40,18 @@
 	randomnode {
 		string = "\xff\0stuffstuff\t\t\t\n\n\n";
 		blob = [0a 0b 0c 0d de ea ad be ef];
-		ref = < &/memory@0 >;
-		mixed = "abc", [1234], <a b c>;
+		ref = < &{/memory@0} >;
+		mixed = "abc", [1234], <0xa 0xb 0xc>;
 	};
 
 	memory@0 {
 		device_type = "memory";
-		memreg: reg = <00000000 00000000 00000000 20000000>;
+		memreg: reg = <0x00000000 0x00000000 0x00000000 0x20000000>;
 	};
 
 	chosen {
 		bootargs = "root=/dev/sda2";
-		linux,platform = <00000600>;
+		linux,platform = <0x600>;
 	};
 
 };
diff --git a/tests/test_tree1_dts0.dts b/tests/test_tree1_dts0.dts
index bc65819..6b40cf5 100644
--- a/tests/test_tree1_dts0.dts
+++ b/tests/test_tree1_dts0.dts
@@ -1,9 +1,11 @@
-/memreserve/ deadbeef00000000-deadbeef000fffff;
-/memreserve/ 75bcd15 1000;
+/dts-v1/;
+
+/memreserve/ 0xdeadbeef00000000 0x0000000000100000;
+/memreserve/ 0x00000000075bcd15 0x0000000000001000;
 
 / {
 	compatible = "test_tree1";
-	prop-int = <deadbeef>;
+	prop-int = <0xdeadbeef>;
 	prop-str = "hello world";
 
 	subnode@1 {
@@ -12,18 +14,18 @@
 
 		subsubnode {
 			compatible = "subsubnode1", "subsubnode";
-			prop-int = <h# deadbeef>;
+			prop-int = < 0xdeadbeef>;
 		};
 	};
 
 	subnode@2 {
-		linux,phandle = <2000>;
-		prop-int = <d# 123456789>;
+		linux,phandle = <0x2000>;
+		prop-int = < 123456789>;
 
 		subsubnode@0 {
-			linux,phandle = <2001>;
+			linux,phandle = <0x2001>;
 			compatible = "subsubnode2", "subsubnode";
-			prop-int = <o# 0726746425>;
+			prop-int = < 0726746425>;
 		};
 	};
 };
-- 
1.5.6

Return-Path: <dgibson@ozlabs.org>
Date: Wed, 7 Nov 2007 10:58:22 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Better exercise dtc base and bytestring features
Message-ID: <20071106235822.GK31367@localhost.localdomain>
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

This patch alters the main testcase, and the dts file corresponding to
it so that we at least trivially exercise dtc's bytestring and base
conversion features.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/tests/test_tree1.dts
===================================================================
--- dtc.orig/tests/test_tree1.dts	2007-11-07 10:37:38.000000000 +1100
+++ dtc/tests/test_tree1.dts	2007-11-07 10:39:32.000000000 +1100
@@ -1,5 +1,5 @@
 /memreserve/ deadbeef00000000-deadbeef000fffff;
-/memreserve/ abcd1234 00001234;
+/memreserve/ 75bcd15 1000;
 
 / {
 	compatible = "test_tree1";
@@ -8,20 +8,20 @@
 
 	subnode@1 {
 		compatible = "subnode1";
-		prop-int = <deadbeef>;
+		prop-int = [deadbeef];
 
 		subsubnode {
 			compatible = "subsubnode1", "subsubnode";
-			prop-int = <deadbeef>;
+			prop-int = <h# deadbeef>;
 		};
 	};
 
 	subnode@2 {
-		prop-int = <abcd1234>;
+		prop-int = <d# 123456789>;
 
 		subsubnode@0 {
 			compatible = "subsubnode2", "subsubnode";
-			prop-int = <abcd1234>;
+			prop-int = <o# 0726746425>;
 		};
 	};
 };
Index: dtc/tests/testdata.h
===================================================================
--- dtc.orig/tests/testdata.h	2007-11-07 10:36:40.000000000 +1100
+++ dtc/tests/testdata.h	2007-11-07 10:37:01.000000000 +1100
@@ -17,11 +17,11 @@
 
 #define TEST_ADDR_1	ASM_CONST_LL(0xdeadbeef00000000)
 #define TEST_SIZE_1	ASM_CONST_LL(0x100000)
-#define TEST_ADDR_2	ASM_CONST_LL(0xabcd1234)
-#define TEST_SIZE_2	ASM_CONST_LL(0x1234)
+#define TEST_ADDR_2	ASM_CONST_LL(123456789)
+#define TEST_SIZE_2	ASM_CONST_LL(010000)
 
 #define TEST_VALUE_1	cell_to_fdt(0xdeadbeef)
-#define TEST_VALUE_2	cell_to_fdt(0xabcd1234)
+#define TEST_VALUE_2	cell_to_fdt(123456789)
 
 #define TEST_STRING_1	"hello world"
 #define TEST_STRING_2	"nastystring: \a\b\t\n\v\f\r\\\""

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

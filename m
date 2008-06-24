Return-Path: <dgibson@ozlabs.org>
Date: Tue, 24 Jun 2008 11:21:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Testcase for /include/ directive
Message-ID: <20080624012144.GB1236@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds a testcase for the /include/ directive.  It assembles
a sample dts file with many /include/ directives at a variety of
different lexical / grammatical contexts.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/tests/include0.dts
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/include0.dts	2008-06-24 11:19:42.000000000 +1000
@@ -0,0 +1 @@
+/include/ "include1.dts"
Index: dtc/tests/include1.dts
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/include1.dts	2008-06-24 11:19:42.000000000 +1000
@@ -0,0 +1,23 @@
+/dts-v1/;
+
+/include/ "include2.dts"
+/memreserve/ /include/ "include3.dts";
+
+/ {
+	/include/ "include4.dts"
+	/include/ "include5.dts" = <0xdeadbeef>;
+	prop-str = /include/ "include6.dts";
+
+	/include/ "include7.dts"
+
+	subnode@2 {
+		linux,phandle = <0x2000>;
+		prop-int = <123456789>;
+
+		/include/ "include8.dts"
+			linux,phandle = <0x2001>;
+			compatible = "subsubnode2", "subsubnode";
+			prop-int = <0726746425>;
+		};
+	};
+};
Index: dtc/tests/include2.dts
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/include2.dts	2008-06-24 11:19:42.000000000 +1000
@@ -0,0 +1 @@
+/memreserve/ 0xdeadbeef00000000 0x100000;
Index: dtc/tests/include3.dts
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/include3.dts	2008-06-24 11:19:42.000000000 +1000
@@ -0,0 +1 @@
+123456789 010000
Index: dtc/tests/include4.dts
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/include4.dts	2008-06-24 11:19:42.000000000 +1000
@@ -0,0 +1 @@
+	compatible = "test_tree1";
Index: dtc/tests/include5.dts
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/include5.dts	2008-06-24 11:19:42.000000000 +1000
@@ -0,0 +1 @@
+prop-int
Index: dtc/tests/include6.dts
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/include6.dts	2008-06-24 11:19:42.000000000 +1000
@@ -0,0 +1 @@
+"hello world"
Index: dtc/tests/include7.dts
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/include7.dts	2008-06-24 11:19:42.000000000 +1000
@@ -0,0 +1,9 @@
+	subnode@1 {
+		compatible = "subnode1";
+		prop-int = [deadbeef];
+
+		subsubnode {
+			compatible = "subsubnode1", "subsubnode";
+			prop-int = <0xdeadbeef>;
+		};
+	};
Index: dtc/tests/include8.dts
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/include8.dts	2008-06-24 11:19:42.000000000 +1000
@@ -0,0 +1 @@
+subsubnode@0 {
\ No newline at end of file
Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2008-06-24 11:19:07.000000000 +1000
+++ dtc/tests/run_tests.sh	2008-06-24 11:19:42.000000000 +1000
@@ -207,6 +207,10 @@
     run_dtc_test -I dts -O dtb -o dtc_comments-cmp.test.dtb comments-cmp.dts
     run_test dtbs_equal_ordered dtc_comments.test.dtb dtc_comments-cmp.test.dtb
 
+    # Check /include/ directive
+    run_dtc_test -I dts -O dtb -o includes.test.dtb include0.dts
+    run_test dtbs_equal_ordered includes.test.dtb test_tree1.dtb
+
     # Check /incbin/ directive
     run_dtc_test -I dts -O dtb -o incbin.test.dtb incbin.dts
     run_test incbin incbin.test.dtb

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

Return-Path: <dgibson@ozlabs.org>
Date: Fri, 15 Feb 2008 15:14:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Fold comment handling test into testsuite
Message-ID: <20080215041416.GA6221@localhost.localdomain>
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

For ages dtc has included a sample dts, comment-test.dts, for checking
various lexical corner cases in comment processing.  In fact, it
predates the automated testsuite, and has never been integrated into
it.  This patch addresses this oversight, folding the comment handling
test in with the rest of the testsuite.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/comment-test.dts
===================================================================
--- dtc.orig/comment-test.dts	2008-02-15 15:01:06.000000000 +1100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,38 +0,0 @@
-/* regexps for lexing comments are.. tricky.  Check if we've actually
- * got it right */
-
-/ {
-	// line comment
-	prop1;
-	/* comment */
-	prop2;
-	/* multiline
-
-	notaprop1;
-
-	   comment */
-	prop3;
-	/**/
-	prop4;
-	/***/
-	prop5;
-	/****/
-	prop6;
-	/* another
-	 * multiline
-	 * comment */
-	prop7;
-	/* yet
-	 * another
-	 * multline
-	 * comment
-	 */
-	prop8;
-	/** try this */
-	prop9;
-	/* and this **/
-	prop10;
-	child /* finally */ {
-	};
-};
-/* final comment */
Index: dtc/tests/comments.dts
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/comments.dts	2008-02-15 15:05:50.000000000 +1100
@@ -0,0 +1,39 @@
+/* regexps for lexing comments are.. tricky.  Check if we've actually
+ * got it right */
+/dts-v1/;
+
+/ {
+	// line comment
+	prop1;
+	/* comment */
+	prop2;
+	/* multiline
+
+	notaprop1;
+
+	   comment */
+	prop3;
+	/**/
+	prop4;
+	/***/
+	prop5;
+	/****/
+	prop6;
+	/* another
+	 * multiline
+	 * comment */
+	prop7;
+	/* yet
+	 * another
+	 * multline
+	 * comment
+	 */
+	prop8;
+	/** try this */
+	prop9;
+	/* and this **/
+	prop10;
+	child /* finally */ {
+	};
+};
+/* final comment */
Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2008-02-15 15:01:20.000000000 +1100
+++ dtc/tests/run_tests.sh	2008-02-15 15:08:09.000000000 +1100
@@ -155,6 +155,10 @@ dtc_tests () {
     run_test dtc.sh -I dts -O dtb -o dtc_path-references.test.dtb path-references.dts
     run_test path-references dtc_path-references.test.dtb
 
+    run_test dtc.sh -I dts -O dtb -o dtc_comments.test.dtb comments.dts
+    run_test dtc.sh -I dts -O dtb -o dtc_comments-cmp.test.dtb comments-cmp.dts
+    run_test dtbs_equal_ordered dtc_comments.test.dtb dtc_comments-cmp.test.dtb
+
     # Check -Odts mode preserve all dtb information
     for tree in test_tree1.dtb dtc_tree1.test.dtb dtc_escapes.test.dtb ; do
 	run_test dtc.sh -I dtb -O dts -o odts_$tree.test.dts $tree
Index: dtc/tests/comments-cmp.dts
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/comments-cmp.dts	2008-02-15 15:07:04.000000000 +1100
@@ -0,0 +1,16 @@
+/dts-v1/;
+
+/ {
+	prop1;
+	prop2;
+	prop3;
+	prop4;
+	prop5;
+	prop6;
+	prop7;
+	prop8;
+	prop9;
+	prop10;
+	child {
+	};
+};

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

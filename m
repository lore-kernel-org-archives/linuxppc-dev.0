Return-Path: <dgibson@ozlabs.org>
Date: Fri, 28 Sep 2007 14:57:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: libfdt: Test rw functions on more trees
Message-ID: <20070928045701.GB25743@localhost.localdomain>
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

At present, the testcases for read/write functions (setprop,
del_property and del_node) are only invoked on the single
asm-generated tree, not on any of the other tree images which should
be equivalent.  The functions in question will (correctly) not work on
the "unfinished" tree output from sw_tree1, but should work on most of
the others.

This patch extends the run_tests script to invoke the r/w testcases on
more example trees.  The testsuite still passes clean with this
addition.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2007-09-27 17:49:29.000000000 +1000
+++ dtc/tests/run_tests.sh	2007-09-27 17:57:00.000000000 +1000
@@ -49,6 +49,15 @@ tree1_tests () {
     run_test nop_node $TREE
 }
 
+tree1_tests_rw () {
+    TREE=$1
+
+    # Read-write tests
+    run_test setprop $TREE
+    run_test del_property $TREE
+    run_test del_node $TREE
+}
+
 libfdt_tests () {
     # Make sure we don't have stale blobs lying around
     rm -f *.test.dtb
@@ -76,11 +85,16 @@ libfdt_tests () {
 	tree1_tests opened.$tree
 	tree1_tests repacked.$tree
     done
-    run_test setprop test_tree1.dtb
-    run_test del_property test_tree1.dtb
-    run_test del_node test_tree1.dtb
+
+    for tree in test_tree1.dtb sw_tree1.test.dtb; do
+	tree1_tests_rw $tree
+	tree1_tests_rw moved.$tree
+	tree1_tests_rw shunted.$tree
+	tree1_tests_rw deshunted.$tree
+    done
     run_test rw_tree1
     tree1_tests rw_tree1.test.dtb
+    tree1_tests_rw rw_tree1.test.dtb
 
     # Tests for behaviour on various sorts of corrupted trees
     run_test truncated_property
@@ -92,6 +106,7 @@ dtc_tests () {
 
     run_test dtc.sh -f -I dts -O dtb -o dtc_tree1.test.dtb test_tree1.dts
     tree1_tests dtc_tree1.test.dtb
+    tree1_tests_rw dtc_tree1.test.dtb
 }
 
 while getopts "vdt:" ARG ; do

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

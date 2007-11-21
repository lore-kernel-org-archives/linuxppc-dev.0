Return-Path: <dgibson@ozlabs.org>
Date: Wed, 21 Nov 2007 11:29:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Remove some redundant testcases
Message-ID: <20071121002918.GC13156@localhost.localdomain>
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

This patch removes a number of testcases from the testsuite that are
extremely unlikely to find any bugs that won't be found by the other
tests.  This speeds up the testsuite.

	- Both loops across the various tree block layouts run the
tree1_tests on the basic mangled tree.  This is completely redundant,
so remove the second copy. This removes 456 testcases.

	- We currently run tree1_tests on various trees manipulated by
move_and_save.  We replace those with just a dtbs_equal_ordered test
to check that the manipulated tree is equal to the original.  What
we're testing here is that fdt_move() operates correctly - it's very
unlikely it would succeed well enough for the ordered_equal test to
succeed, but the tree1_tests would fail on the result.  This removes
162 testcases.

	- Currently we re-ordered with mangle-layout both the basic
test_tree1.dtb and sw_tree1.test.dtb.  Since we've already checked
that these dtbs are equivalent with dtbs_ordered_equal, it's very
unlikely that the tests would fail on one but not the other.
Therefore reduce this to only using test_tree1.dtb.  This removes 828
testcases.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2007-11-21 00:13:40.000000000 +1100
+++ dtc/tests/run_tests.sh	2007-11-21 00:19:11.000000000 +1100
@@ -76,13 +76,13 @@
     for tree in test_tree1.dtb sw_tree1.test.dtb unfinished_tree1.test.dtb; do
 	rm -f moved.$tree shunted.$tree deshunted.$tree
 	run_test move_and_save $tree
-	tree1_tests moved.$tree
-	tree1_tests shunted.$tree
-	tree1_tests deshunted.$tree
+	run_test dtbs_equal_ordered $tree moved.$tree
+	run_test dtbs_equal_ordered $tree shunted.$tree
+	run_test dtbs_equal_ordered $tree deshunted.$tree
     done
 
     # v16 and alternate layout tests
-    for tree in test_tree1.dtb sw_tree1.test.dtb; do
+    for tree in test_tree1.dtb; do
 	for version in 17 16; do
 	    for layout in $ALL_LAYOUTS; do
 		run_test mangle-layout $tree $version $layout
@@ -93,13 +93,12 @@
     done
 
     # Read-write tests
-    for basetree in test_tree1.dtb sw_tree1.test.dtb; do
+    for basetree in test_tree1.dtb; do
 	for version in 17 16; do
 	    for layout in $ALL_LAYOUTS; do
 		tree=v$version.$layout.$basetree
 		rm -f opened.$tree repacked.$tree
 		run_test open_pack $tree
-		tree1_tests $tree
 		tree1_tests opened.$tree
 		tree1_tests repacked.$tree
 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

Return-Path: <dgibson@ozlabs.org>
Date: Wed, 7 Nov 2007 10:34:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Add testcases exercising -Odts mode
Message-ID: <20071106233406.GJ31367@localhost.localdomain>
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

This patch adds a batch of testcases exercising dtc's -Odts mode.
Specifically it checks that using dtc to convert dtb->dts->dtb
preserves the original dtb for a number of example dtb files.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2007-11-07 10:23:04.000000000 +1100
+++ dtc/tests/run_tests.sh	2007-11-07 10:27:30.000000000 +1100
@@ -83,7 +83,7 @@
     done
 
     # v16 and alternate layout tests
-    for tree in test_tree1.dtb; do
+    for tree in test_tree1.dtb sw_tree1.test.dtb; do
 	for version in 17 16; do
 	    for layout in $ALL_LAYOUTS; do
 		run_test mangle-layout $tree $version $layout
@@ -94,7 +94,7 @@
     done
 
     # Read-write tests
-    for basetree in test_tree1.dtb; do
+    for basetree in test_tree1.dtb sw_tree1.test.dtb; do
 	for version in 17 16; do
 	    for layout in $ALL_LAYOUTS; do
 		tree=v$version.$layout.$basetree
@@ -126,6 +126,13 @@
 
     run_test dtc.sh -I dts -O dtb -o dtc_escapes.test.dtb escapes.dts
     run_test string_escapes dtc_escapes.test.dtb
+
+    # Check -Odts mode preserve all dtb information
+    for tree in test_tree1.dtb dtc_tree1.test.dtb dtc_escapes.test.dtb ; do
+	run_test dtc.sh -I dtb -O dts -o odts_$tree.test.dts $tree
+	run_test dtc.sh -I dts -O dtb -o odts_$tree.test.dtb odts_$tree.test.dts
+	run_test dtbs_equal_ordered $tree odts_$tree.test.dtb
+    done
 }
 
 while getopts "vdt:" ARG ; do
@@ -144,7 +151,7 @@
 fi
 
 # Make sure we don't have stale blobs lying around
-rm -f *.test.dtb
+rm -f *.test.dtb *.test.dts
 
 for set in $TESTSETS; do
     case $set in
Index: dtc/tests/Makefile.tests
===================================================================
--- dtc.orig/tests/Makefile.tests	2007-11-07 10:24:34.000000000 +1100
+++ dtc/tests/Makefile.tests	2007-11-07 10:24:38.000000000 +1100
@@ -23,7 +23,7 @@
 
 TESTS_DEPFILES = $(TESTS:%=%.d) $(TESTS_PREFIX)testutils.d
 
-TESTS_CLEANFILES_L =  *.output vgcore.* *.dtb
+TESTS_CLEANFILES_L =  *.output vgcore.* *.dtb *.test.dts
 TESTS_CLEANFILES = $(TESTS_CLEANFILES_L:%=$(TESTS_PREFIX)%)
 
 BIN += $(TESTS) $(TESTS_PREFIX)dumptrees

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

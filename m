Return-Path: <dgibson@ozlabs.org>
Date: Tue, 16 Oct 2007 13:53:20 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Don't delete *.test.dtb between testgroups
Message-ID: <20071016035320.GQ26787@localhost.localdomain>
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

The dtc/libfdt testsuite creates a number of .dtb files during its
run.  To ensure a clean test run, these are currently deleted before
each group of tests.

This is, in fact, a mistake, since if something goes wrong in the
first group of tests, deleting the .dtb at the beginning of the second
group of tests makes it harder to figure out what the problem was.

This patch changes the script to only delete the files once, before
the whole test run.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2007-10-12 15:09:43.000000000 +1000
+++ dtc/tests/run_tests.sh	2007-10-12 15:10:13.000000000 +1000
@@ -60,9 +60,6 @@ tree1_tests_rw () {
 }
 
 libfdt_tests () {
-    # Make sure we don't have stale blobs lying around
-    rm -f *.test.dtb
-
     tree1_tests test_tree1.dtb
 
     # Sequential write tests
@@ -102,9 +99,6 @@ libfdt_tests () {
 }
 
 dtc_tests () {
-    # Make sure we don't have stale blobs lying around
-    rm -f *.test.dtb
-
     run_test dtc.sh -f -I dts -O dtb -o dtc_tree1.test.dtb test_tree1.dts
     tree1_tests dtc_tree1.test.dtb
     tree1_tests_rw dtc_tree1.test.dtb
@@ -125,6 +119,9 @@ if [ -z "$TESTSETS" ]; then
     TESTSETS="libfdt dtc"
 fi
 
+# Make sure we don't have stale blobs lying around
+rm -f *.test.dtb
+
 for set in $TESTSETS; do
     case $set in
 	"libfdt")

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

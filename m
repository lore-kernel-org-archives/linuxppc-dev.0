Return-Path: <dgibson@ozlabs.org>
Date: Mon, 17 Sep 2007 14:39:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Cleanup testsuite organization
Message-ID: <20070917043924.GJ32725@localhost.localdomain>
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

run_tests.sh from the dtc testsuite currently has a facility ro run
just "functional" or just "stress" tests.  This distinction is carried
over from libhugetlbfs where the test framework originated, and where
it made sense.

In dtc, we have no stress tests, so running these subsections isn't
particularly interesting.  This patch removes these test subsets,
instead defining a single "libfdt" test subset for testcases related
to libfdt (and not dtc proper only.  Currently that's all of the
testcases, but with any luck we'll have some dtc testcases in the
future.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/tests/Makefile.tests
===================================================================
--- dtc.orig/tests/Makefile.tests	2007-09-04 14:17:32.000000000 +1000
+++ dtc/tests/Makefile.tests	2007-09-04 14:17:36.000000000 +1000
@@ -49,18 +49,6 @@
 checkv:	tests
 	cd $(TESTS_PREFIX); ./run_tests.sh -v
 
-func:	tests
-	cd $(TESTS_PREFIX); ./run_tests.sh -t func
-
-funcv:	tests
-	cd $(TESTS_PREFIX); ./run_tests.sh -t func -v
-
-stress:	tests
-	cd $(TESTS_PREFIX); ./run_tests.sh -t stress
-
-stressv: tests
-	cd $(TESTS_PREFIX); ./run_tests.sh -t stress -v
-
 ifneq ($(DEPTARGETS),)
 -include $(TESTS_DEPFILES)
 endif
Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2007-09-04 14:16:22.000000000 +1000
+++ dtc/tests/run_tests.sh	2007-09-04 14:55:29.000000000 +1000
@@ -49,7 +49,7 @@
     run_test nop_node $TREE
 }
 
-functional_tests () {
+libfdt_tests () {
     # Make sure we don't have stale blobs lying around
     rm -f *.test.dtb
 
@@ -86,10 +86,6 @@
     run_test truncated_property
 }
 
-stress_tests () {
-    ITERATIONS=10           # Number of iterations for looping tests
-}
-
 while getopts "vdt:" ARG ; do
     case $ARG in
 	"v")
@@ -102,16 +98,13 @@
 done
 
 if [ -z "$TESTSETS" ]; then
-    TESTSETS="func stress"
+    TESTSETS="libfdt"
 fi
 
 for set in $TESTSETS; do
     case $set in
-	"func")
-	    functional_tests
-	    ;;
-	"stress")
-	    stress_tests
+	"libfdt")
+	    libfdt_tests
 	    ;;
     esac
 done

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

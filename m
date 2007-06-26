Return-Path: <dgibson@ozlabs.org>
Date: Tue, 26 Jun 2007 11:33:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Count testcases and results in the dtc/libfdt testsuite
Message-ID: <20070626013310.GC4383@localhost.localdomain>
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

There are quite a lot of testcases in the dtc testsuite (recently
imported from libfdt).  It can be easy to miss a stray FAIL result in
the midst of all the rest.  To improve this, this patch adds a summary
to the end of the testsuite results giving the total number of tests
along with the number of PASSes FAILs and other results.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2007-06-18 17:02:44.000000000 +1000
+++ dtc/tests/run_tests.sh	2007-06-18 17:10:41.000000000 +1000
@@ -4,9 +4,24 @@ export QUIET_TEST=1
 
 ENV=/usr/bin/env
 
+tot_tests=0
+tot_pass=0
+tot_fail=0
+tot_config=0
+tot_strange=0
+
 run_test () {
+    tot_tests=$[tot_tests + 1]
     echo -n "$@:	"
-    PATH=".:$PATH" $ENV "$@"
+    if PATH=".:$PATH" $ENV "$@"; then
+	tot_pass=$[tot_pass + 1]
+    elif [ "$?" == "1" ]; then
+	tot_config=$[tot_config + 1]
+    elif [ "$?" == "2" ]; then
+	tot_fail=$[tot_fail + 1]
+    else
+	tot_strange=$[tot_strange + 1]
+    fi
 }
 
 tree1_tests () {
@@ -92,3 +107,12 @@ for set in $TESTSETS; do
 	    ;;
     esac
 done
+
+echo -e "********** TEST SUMMARY"
+echo -e "*     Total testcases:	$tot_tests"
+echo -e "*                PASS:	$tot_pass"
+echo -e "*                FAIL:	$tot_fail"
+echo -e "*   Bad configuration:	$tot_config"
+echo -e "* Strange test result:	$tot_strange"
+echo -e "**********"
+

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

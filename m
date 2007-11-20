Return-Path: <dgibson@ozlabs.org>
Date: Tue, 20 Nov 2007 22:14:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Don't use env(1) in testsuite
Message-ID: <20071120111412.GA13156@localhost.localdomain>
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

The run_tests.sh script currently invokes the testcase binaries via
env(1).  This behaviour is inherited from the libhugetlbfs testsuite
which uses this approach to easily set various configuration
environment variables in testcases.

We don't use that for dtc, and are unlikely to ever want to.
Therefore this patch removes that technique, which substantially
speeds up the testsuite.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2007-11-20 22:06:12.000000000 +1100
+++ dtc/tests/run_tests.sh	2007-11-20 22:06:22.000000000 +1100
@@ -2,8 +2,6 @@
 
 export QUIET_TEST=1
 
-ENV=/usr/bin/env
-
 tot_tests=0
 tot_pass=0
 tot_fail=0
@@ -13,7 +11,7 @@
 run_test () {
     tot_tests=$[tot_tests + 1]
     echo -n "$@:	"
-    if PATH=".:$PATH" $ENV "$@"; then
+    if "./$@"; then
 	tot_pass=$[tot_pass + 1]
     else
 	ret="$?"

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

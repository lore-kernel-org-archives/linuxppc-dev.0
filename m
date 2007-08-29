Return-Path: <dgibson@ozlabs.org>
Date: Wed, 29 Aug 2007 12:18:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Fix summary calculation in testsuite
Message-ID: <20070829021851.GA25233@localhost.localdomain>
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

The bookkeeping for producing the testsuite summary (total number of
tests passed, failed and so forth) is broken.  It uses $? across
several tests, but for checks after the first, the value of $? will no
longer contain the original return code, but just that from the
previous test.  This patch fixes the problem.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2007-08-29 12:04:11.000000000 +1000
+++ dtc/tests/run_tests.sh	2007-08-29 12:04:37.000000000 +1000
@@ -15,12 +15,15 @@
     echo -n "$@:	"
     if PATH=".:$PATH" $ENV "$@"; then
 	tot_pass=$[tot_pass + 1]
-    elif [ "$?" == "1" ]; then
-	tot_config=$[tot_config + 1]
-    elif [ "$?" == "2" ]; then
-	tot_fail=$[tot_fail + 1]
     else
-	tot_strange=$[tot_strange + 1]
+	ret="$?"
+	if [ "$ret" == "1" ]; then
+	    tot_config=$[tot_config + 1]
+	elif [ "$ret" == "2" ]; then
+	    tot_fail=$[tot_fail + 1]
+	else
+	    tot_strange=$[tot_strange + 1]
+	fi
     fi
 }
 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

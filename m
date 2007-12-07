Return-Path: <dgibson@ozlabs.org>
Date: Fri, 7 Dec 2007 15:37:45 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Make dtc-checfails.sh script catch deaths-by-signal
Message-ID: <20071207043745.GF26412@localhost.localdomain>
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

Since commit 5ba0086bfd0fa6ab25f7ce1870417301a26c104f, the
dtc-checkfails.sh script does not check the return code from dtc.
That's reasonable, since depending on the checks we're testing, dtc
could either complete succesfully or return an error.

However, it's never right for dtc to SEGV or otherwise be killed by a
signal.  So the script should catch that, and fail the testcase if it
happens.  This patch implements this behaviour.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/tests/dtc-checkfails.sh
===================================================================
--- dtc.orig/tests/dtc-checkfails.sh	2007-12-07 15:34:17.000000000 +1100
+++ dtc/tests/dtc-checkfails.sh	2007-12-07 15:35:22.000000000 +1100
@@ -17,6 +17,10 @@ rm -f $TMPFILE $LOG
 verbose_run_log "$LOG" "$DTC" -o /dev/null "$@"
 ret="$?"
 
+if [ "$ret" -gt 127 ]; then
+    FAIL "dtc killed by signal (ret=$ret)"
+fi
+
 for c in $CHECKS; do
     if ! grep -E "^(ERROR)|(Warning) \($c\):" $LOG > /dev/null; then
 	FAIL "Failed to trigger check \"%c\""

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

Return-Path: <dgibson@ozlabs.org>
Date: Thu, 29 May 2008 16:16:21 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Remove some small bashisms from test scripts
Message-ID: <20080529061621.GA7220@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some of the helper scripts used to run testcases contain some
constructs that are bashisms.  Or at least which don't work on dash,
the minimal shell used as /bin/sh on recent Ubuntu systems.

This patch removes these constructs so that the testsuite will pass
"out of the box" on systems where /bin/sh is dash.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/tests/dtc-checkfails.sh
===================================================================
--- dtc.orig/tests/dtc-checkfails.sh	2008-05-29 14:51:19.000000000 +1000
+++ dtc/tests/dtc-checkfails.sh	2008-05-29 16:12:14.000000000 +1000
@@ -1,6 +1,6 @@
 #! /bin/sh
 
-. tests.sh
+. ./tests.sh
 
 for x; do
     shift
Index: dtc/tests/dtc-fatal.sh
===================================================================
--- dtc.orig/tests/dtc-fatal.sh	2008-05-29 14:56:51.000000000 +1000
+++ dtc/tests/dtc-fatal.sh	2008-05-29 16:12:31.000000000 +1000
@@ -1,6 +1,6 @@
 #! /bin/sh
 
-. tests.sh
+. ./tests.sh
 
 verbose_run $VALGRIND "$DTC" -o/dev/null "$@"
 ret="$?"
Index: dtc/tests/tests.sh
===================================================================
--- dtc.orig/tests/tests.sh	2008-05-29 16:11:15.000000000 +1000
+++ dtc/tests/tests.sh	2008-05-29 16:11:21.000000000 +1000
@@ -23,7 +23,7 @@ verbose_run () {
 verbose_run_log () {
     LOG="$1"
     shift
-    "$@" &> "$LOG"
+    "$@" > "$LOG" 2>&1
     ret=$?
     if [ -z "$QUIET_TEST" ]; then
 	cat "$LOG" >&2

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

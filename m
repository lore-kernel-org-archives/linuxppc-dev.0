Return-Path: <dgibson@ozlabs.org>
Date: Thu, 6 Dec 2007 16:56:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: More detailed testing of tree checks
Message-ID: <20071206055655.GC19927@localhost.localdomain>
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

This patch modifies the dtc-checkfails.sh testcase wrapper so that
instead of testing just that dtc fails with a particular error code on
the sample input, it scans dtc's stderr output looking for a message
that dtc failed a specific check or checks.  This has several advantages:
	- It means we more precisely check dtc's checking behaviour
	- It means we can check for generation of warnings using the
same script
	- It means we can test cases where dtc should generate
multiple errors or warnings from different checks

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/tests/dtc-checkfails.sh
===================================================================
--- dtc.orig/tests/dtc-checkfails.sh	2007-12-06 16:33:21.000000000 +1100
+++ dtc/tests/dtc-checkfails.sh	2007-12-06 16:48:28.000000000 +1100
@@ -2,21 +2,27 @@
 
 . tests.sh
 
-TMPFILE="tmp.out.$$"
+for x; do
+    shift
+    if [ "$x" = "--" ]; then
+	break;
+    fi
+    CHECKS="$CHECKS $x"
+done
 
-rm -f $TMPFILE
+LOG="tmp.log.$$"
 
-verbose_run "$DTC" -o $TMPFILE "$@"
+rm -f $TMPFILE $LOG
+
+verbose_run_log "$LOG" "$DTC" -o /dev/null "$@"
 ret="$?"
 
-if [ -f $TMPFILE ]; then
-    FAIL "output file was created despite bad input"
-fi
-
-if [ "$ret" = "2" ]; then
-    PASS
-else
-    FAIL "dtc returned error code $ret instead of 2 (check failed)"
-fi
+for c in $CHECKS; do
+    if ! grep -E "^(ERROR)|(Warning) \($c\):" $LOG > /dev/null; then
+	FAIL "Failed to trigger check \"%c\""
+    fi
+done
+
+rm -f $LOG
 
-rm -f $TMPFILE
+PASS
Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2007-12-06 16:33:21.000000000 +1100
+++ dtc/tests/run_tests.sh	2007-12-06 16:47:15.000000000 +1100
@@ -159,14 +159,14 @@
     done
 
     # Check some checks
-    run_test dtc-checkfails.sh -I dts -O dtb dup-nodename.dts
-    run_test dtc-checkfails.sh -I dts -O dtb dup-propname.dts
-    run_test dtc-checkfails.sh -I dts -O dtb dup-phandle.dts
-    run_test dtc-checkfails.sh -I dts -O dtb zero-phandle.dts
-    run_test dtc-checkfails.sh -I dts -O dtb minusone-phandle.dts
-    run_test dtc-checkfails.sh -I dts -O dtb nonexist-node-ref.dts
-    run_test dtc-checkfails.sh -I dts -O dtb nonexist-label-ref.dts
-    run_test dtc-checkfails.sh -I dts -O dtb bad-name-property.dts
+    run_test dtc-checkfails.sh duplicate_node_names -- -I dts -O dtb dup-nodename.dts
+    run_test dtc-checkfails.sh duplicate_property_names -- -I dts -O dtb dup-propname.dts
+    run_test dtc-checkfails.sh explicit_phandles -- -I dts -O dtb dup-phandle.dts
+    run_test dtc-checkfails.sh explicit_phandles -- -I dts -O dtb zero-phandle.dts
+    run_test dtc-checkfails.sh explicit_phandles -- -I dts -O dtb minusone-phandle.dts
+    run_test dtc-checkfails.sh phandle_references -- -I dts -O dtb nonexist-node-ref.dts
+    run_test dtc-checkfails.sh phandle_references -- -I dts -O dtb nonexist-label-ref.dts
+    run_test dtc-checkfails.sh name_properties -- -I dts -O dtb bad-name-property.dts
 }
 
 while getopts "vt:m" ARG ; do
Index: dtc/tests/tests.sh
===================================================================
--- dtc.orig/tests/tests.sh	2007-12-06 16:33:21.000000000 +1100
+++ dtc/tests/tests.sh	2007-12-06 16:35:12.000000000 +1100
@@ -19,3 +19,14 @@
 	"$@" > /dev/null 2> /dev/null
     fi
 }
+
+verbose_run_log () {
+    LOG="$1"
+    shift
+    "$@" &> "$LOG"
+    ret=$?
+    if [ -z "$QUIET_TEST" ]; then
+	cat "$LOG" >&2
+    fi
+    return $ret
+}
Index: dtc/tests/Makefile.tests
===================================================================
--- dtc.orig/tests/Makefile.tests	2007-12-06 16:48:35.000000000 +1100
+++ dtc/tests/Makefile.tests	2007-12-06 16:48:39.000000000 +1100
@@ -26,7 +26,7 @@
 TESTS_DEPFILES = $(TESTS:%=%.d) \
 	$(addprefix $(TESTS_PREFIX),testutils.d trees.d dumptrees.d)
 
-TESTS_CLEANFILES_L =  *.output vglog.* vgcore.* *.dtb *.test.dts
+TESTS_CLEANFILES_L =  *.output vglog.* vgcore.* *.dtb *.test.dts tmp.*
 TESTS_CLEANFILES = $(TESTS_CLEANFILES_L:%=$(TESTS_PREFIX)%)
 
 BIN += $(TESTS) $(TESTS_PREFIX)dumptrees

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

Return-Path: <dgibson@ozlabs.org>
Date: Wed, 5 Mar 2008 16:01:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Assorted improvements to test harness
Message-ID: <20080305050155.GJ8399@localhost.localdomain>
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

This patch makes several small improvements to the test harness.

* An altered way of invoking shell script testcases from run_tests.sh
  means scripts no longer need to me marked executable in the
  repository to work properly.

* dtc.sh never did anything that was really dtc specific - with the
  exception of messages, it would work equally well for any binary
  that returns 0 in the successful case.  Therefore, generalise dtc.sh
  and fold it into run_tests.sh so we don't need a separate script any
  more.

* Tweak various things so that the valgrind options are properly
  propagated down to invoke dtc under valgrind when called via wrapper
  scripts.

* Tweak the valgrind suppressions to work properly on a wider range of
  systems (this was necessary on my machine running Ubuntu Hardy).

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---
 tests/dtc-checkfails.sh  |    5 +-
 tests/dtc.sh             |   10 ----
 tests/mangle-layout.supp |    2 
 tests/open_pack.supp     |    2 
 tests/run_tests.sh       |  112 ++++++++++++++++++++++++++++++-----------------
 5 files changed, 78 insertions(+), 53 deletions(-)

Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2008-03-05 12:38:52.000000000 +1100
+++ dtc/tests/run_tests.sh	2008-03-05 15:45:26.000000000 +1100
@@ -1,5 +1,7 @@
 #! /bin/bash
 
+. tests.sh
+
 export QUIET_TEST=1
 
 export VALGRIND=
@@ -12,16 +14,9 @@
 tot_vg=0
 tot_strange=0
 
-run_test () {
+base_run_test() {
     tot_tests=$[tot_tests + 1]
-    echo -n "$@:	"
-    VGLOCAL="$VALGRIND"
-    if [ -n "$VALGRIND" ]; then
-	if [ -f $1.supp ]; then
-	    VGLOCAL="$VGLOCAL --suppressions=$1.supp"
-	fi
-    fi
-    if $VGLOCAL "./$@"; then
+    if VALGRIND="$VALGRIND" "$@"; then
 	tot_pass=$[tot_pass + 1]
     else
 	ret="$?"
@@ -37,6 +32,45 @@
     fi
 }
 
+run_test () {
+    echo -n "$@:	"
+    if [ -n "$VALGRIND" -a -f $1.supp ]; then
+	VGSUPP="--suppressions=$1.supp"
+    fi
+    base_run_test $VALGRIND $VGSUPP "./$@"
+}
+
+run_sh_test () {
+    echo -n "$@:	"
+    base_run_test sh "$@"
+}
+
+wrap_test () {
+    (
+	if verbose_run "$@"; then
+	    PASS
+	else
+	    ret="$?"
+	    if [ "$ret" -gt 127 ]; then
+		signame=$(kill -l $[ret - 128])
+		FAIL "Killed by SIG$signame"
+	    else
+		FAIL "Returned error code $ret"
+	    fi
+	fi
+    )
+}
+
+run_wrap_test () {
+    echo -n "$@:	"
+    base_run_test wrap_test "$@"
+}
+
+run_dtc_test () {
+    echo -n "dtc $@:	"
+    base_run_test wrap_test $VALGRIND $DTC "$@"
+}
+
 tree1_tests () {
     TREE=$1
 
@@ -140,35 +174,35 @@
 }
 
 dtc_tests () {
-    run_test dtc.sh -I dts -O dtb -o dtc_tree1.test.dtb test_tree1.dts
+    run_dtc_test -I dts -O dtb -o dtc_tree1.test.dtb test_tree1.dts
     tree1_tests dtc_tree1.test.dtb
     tree1_tests_rw dtc_tree1.test.dtb
     run_test dtbs_equal_ordered dtc_tree1.test.dtb test_tree1.dtb
 
-    run_test dtc.sh -I dts -O dtb -o dtc_tree1_dts0.test.dtb test_tree1_dts0.dts
+    run_dtc_test -I dts -O dtb -o dtc_tree1_dts0.test.dtb test_tree1_dts0.dts
     tree1_tests dtc_tree1_dts0.test.dtb
     tree1_tests_rw dtc_tree1_dts0.test.dtb
 
-    run_test dtc.sh -I dts -O dtb -o dtc_escapes.test.dtb escapes.dts
+    run_dtc_test -I dts -O dtb -o dtc_escapes.test.dtb escapes.dts
     run_test string_escapes dtc_escapes.test.dtb
 
-    run_test dtc.sh -I dts -O dtb -o dtc_references.test.dtb references.dts
+    run_dtc_test -I dts -O dtb -o dtc_references.test.dtb references.dts
     run_test references dtc_references.test.dtb
 
-    run_test dtc.sh -I dts -O dtb -o dtc_references_dts0.test.dtb references_dts0.dts
+    run_dtc_test -I dts -O dtb -o dtc_references_dts0.test.dtb references_dts0.dts
     run_test references dtc_references_dts0.test.dtb
 
-    run_test dtc.sh -I dts -O dtb -o dtc_path-references.test.dtb path-references.dts
+    run_dtc_test -I dts -O dtb -o dtc_path-references.test.dtb path-references.dts
     run_test path-references dtc_path-references.test.dtb
 
-    run_test dtc.sh -I dts -O dtb -o dtc_comments.test.dtb comments.dts
-    run_test dtc.sh -I dts -O dtb -o dtc_comments-cmp.test.dtb comments-cmp.dts
+    run_dtc_test -I dts -O dtb -o dtc_comments.test.dtb comments.dts
+    run_dtc_test -I dts -O dtb -o dtc_comments-cmp.test.dtb comments-cmp.dts
     run_test dtbs_equal_ordered dtc_comments.test.dtb dtc_comments-cmp.test.dtb
 
     # Check -Odts mode preserve all dtb information
     for tree in test_tree1.dtb dtc_tree1.test.dtb dtc_escapes.test.dtb ; do
-	run_test dtc.sh -I dtb -O dts -o odts_$tree.test.dts $tree
-	run_test dtc.sh -I dts -O dtb -o odts_$tree.test.dtb odts_$tree.test.dts
+	run_dtc_test -I dtb -O dts -o odts_$tree.test.dts $tree
+	run_dtc_test -I dts -O dtb -o odts_$tree.test.dtb odts_$tree.test.dts
 	run_test dtbs_equal_ordered $tree odts_$tree.test.dtb
     done
 
@@ -176,34 +210,34 @@
     for tree in test_tree1.dtb ; do
 	 for aver in 1 2 3 16 17; do
 	     atree="ov${aver}_$tree.test.dtb"
-	     run_test dtc.sh -I dtb -O dtb -V$aver -o $atree $tree
+	     run_dtc_test -I dtb -O dtb -V$aver -o $atree $tree
 	     for bver in 16 17; do
 		 btree="ov${bver}_$atree"
-		 run_test dtc.sh -I dtb -O dtb -V$bver -o $btree $atree
+		 run_dtc_test -I dtb -O dtb -V$bver -o $btree $atree
 		 run_test dtbs_equal_ordered $btree $tree
 	     done
 	 done
     done
 
     # Check some checks
-    run_test dtc-checkfails.sh duplicate_node_names -- -I dts -O dtb dup-nodename.dts
-    run_test dtc-checkfails.sh duplicate_property_names -- -I dts -O dtb dup-propname.dts
-    run_test dtc-checkfails.sh explicit_phandles -- -I dts -O dtb dup-phandle.dts
-    run_test dtc-checkfails.sh explicit_phandles -- -I dts -O dtb zero-phandle.dts
-    run_test dtc-checkfails.sh explicit_phandles -- -I dts -O dtb minusone-phandle.dts
-    run_test dtc-checkfails.sh phandle_references -- -I dts -O dtb nonexist-node-ref.dts
-    run_test dtc-checkfails.sh phandle_references -- -I dts -O dtb nonexist-label-ref.dts
-    run_test dtc-checkfails.sh name_properties -- -I dts -O dtb bad-name-property.dts
-
-    run_test dtc-checkfails.sh address_cells_is_cell size_cells_is_cell interrupt_cells_is_cell -- -I dts -O dtb bad-ncells.dts
-    run_test dtc-checkfails.sh device_type_is_string model_is_string status_is_string -- -I dts -O dtb bad-string-props.dts
-    run_test dtc-checkfails.sh reg_format ranges_format -- -I dts -O dtb bad-reg-ranges.dts
-    run_test dtc-checkfails.sh ranges_format -- -I dts -O dtb bad-empty-ranges.dts
-    run_test dtc-checkfails.sh avoid_default_addr_size -- -I dts -O dtb default-addr-size.dts
-    run_test dtc-checkfails.sh obsolete_chosen_interrupt_controller -- -I dts -O dtb obsolete-chosen-interrupt-controller.dts
-    run_test dtc-checkfails.sh node_name_chars -- -I dtb -O dtb bad_node_char.dtb
-    run_test dtc-checkfails.sh node_name_format -- -I dtb -O dtb bad_node_format.dtb
-    run_test dtc-checkfails.sh prop_name_chars -- -I dtb -O dtb bad_prop_char.dtb
+    run_sh_test dtc-checkfails.sh duplicate_node_names -- -I dts -O dtb dup-nodename.dts
+    run_sh_test dtc-checkfails.sh duplicate_property_names -- -I dts -O dtb dup-propname.dts
+    run_sh_test dtc-checkfails.sh explicit_phandles -- -I dts -O dtb dup-phandle.dts
+    run_sh_test dtc-checkfails.sh explicit_phandles -- -I dts -O dtb zero-phandle.dts
+    run_sh_test dtc-checkfails.sh explicit_phandles -- -I dts -O dtb minusone-phandle.dts
+    run_sh_test dtc-checkfails.sh phandle_references -- -I dts -O dtb nonexist-node-ref.dts
+    run_sh_test dtc-checkfails.sh phandle_references -- -I dts -O dtb nonexist-label-ref.dts
+    run_sh_test dtc-checkfails.sh name_properties -- -I dts -O dtb bad-name-property.dts
+
+    run_sh_test dtc-checkfails.sh address_cells_is_cell size_cells_is_cell interrupt_cells_is_cell -- -I dts -O dtb bad-ncells.dts
+    run_sh_test dtc-checkfails.sh device_type_is_string model_is_string status_is_string -- -I dts -O dtb bad-string-props.dts
+    run_sh_test dtc-checkfails.sh reg_format ranges_format -- -I dts -O dtb bad-reg-ranges.dts
+    run_sh_test dtc-checkfails.sh ranges_format -- -I dts -O dtb bad-empty-ranges.dts
+    run_sh_test dtc-checkfails.sh avoid_default_addr_size -- -I dts -O dtb default-addr-size.dts
+    run_sh_test dtc-checkfails.sh obsolete_chosen_interrupt_controller -- -I dts -O dtb obsolete-chosen-interrupt-controller.dts
+    run_sh_test dtc-checkfails.sh node_name_chars -- -I dtb -O dtb bad_node_char.dtb
+    run_sh_test dtc-checkfails.sh node_name_format -- -I dtb -O dtb bad_node_format.dtb
+    run_sh_test dtc-checkfails.sh prop_name_chars -- -I dtb -O dtb bad_prop_char.dtb
 }
 
 while getopts "vt:m" ARG ; do
Index: dtc/tests/dtc.sh
===================================================================
--- dtc.orig/tests/dtc.sh	2008-03-05 12:38:52.000000000 +1100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,10 +0,0 @@
-#! /bin/sh
-
-. tests.sh
-
-if verbose_run "$DTC" "$@"; then
-    PASS
-else
-    ret="$?"
-    FAIL "dtc returned error code $ret"
-fi
Index: dtc/tests/dtc-checkfails.sh
===================================================================
--- dtc.orig/tests/dtc-checkfails.sh	2008-03-05 12:38:52.000000000 +1100
+++ dtc/tests/dtc-checkfails.sh	2008-03-05 12:38:56.000000000 +1100
@@ -14,11 +14,12 @@
 
 rm -f $TMPFILE $LOG
 
-verbose_run_log "$LOG" "$DTC" -o /dev/null "$@"
+verbose_run_log "$LOG" $VALGRIND "$DTC" -o /dev/null "$@"
 ret="$?"
 
 if [ "$ret" -gt 127 ]; then
-    FAIL "dtc killed by signal (ret=$ret)"
+    signame=$(kill -l $[ret - 128])
+    FAIL "Killed by SIG$signame"
 fi
 
 for c in $CHECKS; do
Index: dtc/tests/mangle-layout.supp
===================================================================
--- dtc.orig/tests/mangle-layout.supp	2008-03-05 12:48:36.000000000 +1100
+++ dtc/tests/mangle-layout.supp	2008-03-05 12:49:31.000000000 +1100
@@ -2,6 +2,6 @@
    uninitialized alignment gaps can be dumped to output
    Memcheck:Param
    write(buf)
-   obj:/lib/ld-2.6.1.so
+   obj:/lib/ld-*.so
    fun:main
 }
Index: dtc/tests/open_pack.supp
===================================================================
--- dtc.orig/tests/open_pack.supp	2008-03-05 12:49:47.000000000 +1100
+++ dtc/tests/open_pack.supp	2008-03-05 12:49:51.000000000 +1100
@@ -2,6 +2,6 @@
    opened blob dumps uninitialized data
    Memcheck:Param
    write(buf)
-   obj:/lib/ld-2.6.1.so
+   obj:/lib/ld-*.so
    fun:main
 }

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

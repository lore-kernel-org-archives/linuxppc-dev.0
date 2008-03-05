Return-Path: <dgibson@ozlabs.org>
Date: Wed, 5 Mar 2008 16:22:41 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Testcases for input handling
Message-ID: <20080305052241.GL8399@localhost.localdomain>
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

This patch adds some testcases checking corner cases of dtc's input
file handling.  Specifically it checks that dtc works correctly when
given input via stdin, and it checks that dtc fails gracefully if
given a nonexistent input file (or directory, in the case of -Ifs
mode).

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---
 tests/dtc-fatal.sh |   14 ++++++++++++++
 tests/run_tests.sh |   11 +++++++++++
 2 files changed, 25 insertions(+)

Index: dtc/tests/dtc-fatal.sh
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/dtc-fatal.sh	2008-03-05 16:19:32.000000000 +1100
@@ -0,0 +1,14 @@
+#! /bin/sh
+
+. tests.sh
+
+verbose_run $VALGRIND "$DTC" -o/dev/null "$@"
+ret="$?"
+
+if [ "$ret" -gt 127 ]; then
+    FAIL "dtc killed by signal (ret=$ret)"
+elif [ "$ret" != "1" ]; then
+    FAIL "dtc returned incorrect status $ret instead of 1"
+fi
+
+PASS
Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2008-03-05 16:15:52.000000000 +1100
+++ dtc/tests/run_tests.sh	2008-03-05 16:16:15.000000000 +1100
@@ -239,6 +239,17 @@
     run_sh_test dtc-checkfails.sh node_name_chars -- -I dtb -O dtb bad_node_char.dtb
     run_sh_test dtc-checkfails.sh node_name_format -- -I dtb -O dtb bad_node_format.dtb
     run_sh_test dtc-checkfails.sh prop_name_chars -- -I dtb -O dtb bad_prop_char.dtb
+
+    # Check for proper behaviour reading from stdin
+    run_dtc_test -I dts -O dtb -o stdin_dtc_tree1.test.dtb - < test_tree1.dts
+    run_wrap_test cmp stdin_dtc_tree1.test.dtb dtc_tree1.test.dtb
+    run_dtc_test -I dtb -O dts -o stdin_odts_test_tree1.dtb.test.dts - < test_tree1.dtb
+    run_wrap_test cmp stdin_odts_test_tree1.dtb.test.dts odts_test_tree1.dtb.test.dts
+
+    # Check for graceful failure in some error conditions
+    run_sh_test dtc-fatal.sh -I dts -O dtb nosuchfile.dts
+    run_sh_test dtc-fatal.sh -I dtb -O dtb nosuchfile.dtb
+    run_sh_test dtc-fatal.sh -I fs -O dtb nosuchfile
 }
 
 while getopts "vt:m" ARG ; do

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

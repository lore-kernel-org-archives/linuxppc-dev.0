Return-Path: <dgibson@ozlabs.org>
Date: Tue, 20 Nov 2007 16:24:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Add testcases for tree checks
Message-ID: <20071120052423.GC4356@localhost.localdomain>
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

This patch adds a group of testcases to check that dtc correctly
rejects trees with various structural errors.

To make things easier to test, we change dtc so that failing checks
(as opposed to other errors) result in exit code 2.

This patch also fixes an embarrasing bug uncovered by these new tests:
check_phandles() worked out if the tree's phandles were valid, then
throws that information away and returns success always.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

NOTE! jdl, you'll need to chmod +x tests/dtc-checkfails.sh before you
git commit this - it's a new shell script and patch can't encode the
permissions info.

Index: dtc/tests/dup-nodename.dts
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/dup-nodename.dts	2007-11-20 16:02:22.000000000 +1100
@@ -0,0 +1,8 @@
+/dts-v1/;
+
+/ {
+	node {
+	};
+	node {
+	};
+};
Index: dtc/dtc.c
===================================================================
--- dtc.orig/dtc.c	2007-11-20 16:01:54.000000000 +1100
+++ dtc/dtc.c	2007-11-20 16:02:22.000000000 +1100
@@ -197,7 +197,7 @@ int main(int argc, char *argv[])
 	if (!structure_ok) {
 		if (!force) {
 			fprintf(stderr, "ERROR: Input tree has structural errors, aborting (use -f to force output)\n");
-			exit(1);
+			exit(2);
 		} else if (quiet < 3) {
 			fprintf(stderr, "Warning: Input tree has structural errors, output forced\n");
 		}
Index: dtc/tests/dtc.sh
===================================================================
--- dtc.orig/tests/dtc.sh	2007-11-20 16:01:54.000000000 +1100
+++ dtc/tests/dtc.sh	2007-11-20 16:02:22.000000000 +1100
@@ -1,24 +1,6 @@
 #! /bin/sh
 
-PASS () {
-    echo "PASS"
-    exit 0
-}
-
-FAIL () {
-    echo "FAIL" "$@"
-    exit 2
-}
-
-DTC=../dtc
-
-verbose_run () {
-    if [ -z "$QUIET_TEST" ]; then
-	"$@"
-    else
-	"$@" > /dev/null 2> /dev/null
-    fi
-}
+. tests.sh
 
 if verbose_run "$DTC" "$@"; then
     PASS
Index: dtc/tests/tests.sh
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/tests.sh	2007-11-20 16:02:22.000000000 +1100
@@ -0,0 +1,21 @@
+# Common functions for shell testcases
+
+PASS () {
+    echo "PASS"
+    exit 0
+}
+
+FAIL () {
+    echo "FAIL" "$@"
+    exit 2
+}
+
+DTC=../dtc
+
+verbose_run () {
+    if [ -z "$QUIET_TEST" ]; then
+	"$@"
+    else
+	"$@" > /dev/null 2> /dev/null
+    fi
+}
Index: dtc/tests/dtc-checkfails.sh
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/dtc-checkfails.sh	2007-11-20 16:02:50.000000000 +1100
@@ -0,0 +1,22 @@
+#! /bin/sh
+
+. tests.sh
+
+TMPFILE="tmp.out.$$"
+
+rm -f $TMPFILE
+
+verbose_run "$DTC" -o $TMPFILE "$@"
+ret="$?"
+
+if [ -f $TMPFILE ]; then
+    FAIL "output file was created despite bad input"
+fi
+
+if [ "$ret" = "2" ]; then
+    PASS
+else
+    FAIL "dtc returned error code $ret instead of 2 (check failed)"
+fi
+
+rm -f $TMPFILE
Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2007-11-20 16:02:21.000000000 +1100
+++ dtc/tests/run_tests.sh	2007-11-20 16:02:22.000000000 +1100
@@ -143,6 +143,12 @@ dtc_tests () {
 	run_test dtbs_equal_ordered $tree odts_$tree.test.dtb
     done
 
+    # Check some checks
+    run_test dtc-checkfails.sh -I dts -O dtb dup-nodename.dts
+    run_test dtc-checkfails.sh -I dts -O dtb dup-propname.dts
+    run_test dtc-checkfails.sh -I dts -O dtb dup-phandle.dts
+    run_test dtc-checkfails.sh -I dts -O dtb zero-phandle.dts
+    run_test dtc-checkfails.sh -I dts -O dtb minusone-phandle.dts
 }
 
 while getopts "vdt:" ARG ; do
Index: dtc/tests/dup-propname.dts
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/dup-propname.dts	2007-11-20 16:02:22.000000000 +1100
@@ -0,0 +1,6 @@
+/dts-v1/;
+
+/ {
+	prop;
+	prop;
+};
Index: dtc/tests/dup-phandle.dts
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/dup-phandle.dts	2007-11-20 16:02:22.000000000 +1100
@@ -0,0 +1,10 @@
+/dts-v1/;
+
+/ {
+	node1 {
+		linux,phandle = <1>;
+	};
+	node2 {
+		linux,phandle = <1>;
+	};
+};
Index: dtc/tests/minusone-phandle.dts
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/minusone-phandle.dts	2007-11-20 16:02:22.000000000 +1100
@@ -0,0 +1,7 @@
+/dts-v1/;
+
+/ {
+	node {
+		linux,phandle = <0xffffffff>;
+	};
+};
Index: dtc/tests/zero-phandle.dts
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/zero-phandle.dts	2007-11-20 16:02:22.000000000 +1100
@@ -0,0 +1,7 @@
+/dts-v1/;
+
+/ {
+	node {
+		linux,phandle = <0>;
+	};
+};
Index: dtc/checks.c
===================================================================
--- dtc.orig/checks.c	2007-11-20 16:01:54.000000000 +1100
+++ dtc/checks.c	2007-11-20 16:02:23.000000000 +1100
@@ -101,7 +101,7 @@ static int check_phandles(struct node *r
 	for_each_child(node, child)
 		ok = ok && check_phandles(root, child);
 
-	return 1;
+	return ok;
 }
 
 int check_structure(struct node *dt)

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

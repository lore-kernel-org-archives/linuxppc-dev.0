Return-Path: <dgibson@ozlabs.org>
Date: Tue, 18 Sep 2007 10:33:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Add basic testcases for dtc
Message-ID: <20070918003340.GA30766@localhost.localdomain>
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

This patch adds a handful of simple testcases for dtc.  It adds a dts
file which should generate the same sample tree as is used for the
libfdt testcases, and tests invoking dtc on this dts, plus the
standard batch of libfdt cases on the resulting dtb, which effectively
checks that the dtb is correct.

Because the test framework assumes each testcase is an executable with
the right output conventions, we use a little shell script, dtc.sh, as
a wrapper around dtc itself.  It simply invokes dtc and returns a PASS
or FAIL depending on whether dtc returned an error.

It's not much, but it's a start.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---

NB: Jon, you won't be able to simply git-applymbox this and have it
work.  You'll need to manually add execute permission to tests/dtc.sh
before git commiting it, since I can't encode the permissions in a
patch.  Sorry for the inconvenience, but it didn't really seem worth
setting up my own git to pull from just for that.

Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2007-09-18 10:06:28.000000000 +1000
+++ dtc/tests/run_tests.sh	2007-09-18 10:06:31.000000000 +1000
@@ -86,6 +86,14 @@
     run_test truncated_property
 }
 
+dtc_tests () {
+    # Make sure we don't have stale blobs lying around
+    rm -f *.test.dtb
+
+    run_test dtc.sh -f -I dts -O dtb -o dtc_tree1.test.dtb test_tree1.dts
+    tree1_tests dtc_tree1.test.dtb
+}
+
 while getopts "vdt:" ARG ; do
     case $ARG in
 	"v")
@@ -98,7 +106,7 @@
 done
 
 if [ -z "$TESTSETS" ]; then
-    TESTSETS="libfdt"
+    TESTSETS="libfdt dtc"
 fi
 
 for set in $TESTSETS; do
@@ -106,6 +114,9 @@
 	"libfdt")
 	    libfdt_tests
 	    ;;
+	"dtc")
+	    dtc_tests
+	    ;;
     esac
 done
 
Index: dtc/tests/test_tree1.dts
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/test_tree1.dts	2007-09-18 10:06:31.000000000 +1000
@@ -0,0 +1,20 @@
+/ {
+	prop-int = <deadbeef>;
+	prop-str = "hello world";
+
+	subnode1 {
+		prop-int = <deadbeef>;
+
+		subsubnode {
+			prop-int = <deadbeef>;
+		};
+	};
+
+	subnode2 {
+		prop-int = <abcd1234>;
+
+		subsubnode {
+			prop-int = <abcd1234>;
+		};
+	};
+};
Index: dtc/tests/dtc.sh
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/dtc.sh	2007-09-18 10:07:34.000000000 +1000
@@ -0,0 +1,28 @@
+#! /bin/sh
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
+
+if verbose_run "$DTC" "$@"; then
+    PASS
+else
+    ret="$?"
+    FAIL "dtc returned error code $ret"
+fi
Index: dtc/tests/Makefile.tests
===================================================================
--- dtc.orig/tests/Makefile.tests	2007-09-18 10:27:30.000000000 +1000
+++ dtc/tests/Makefile.tests	2007-09-18 10:27:46.000000000 +1000
@@ -43,10 +43,10 @@
 	rm -f $(STD_CLEANFILES:%=$(TESTS_PREFIX)%)
 	rm -f $(TESTS_CLEANFILES)
 
-check:	tests
+check:	tests dtc
 	cd $(TESTS_PREFIX); ./run_tests.sh
 
-checkv:	tests
+checkv:	tests dtc
 	cd $(TESTS_PREFIX); ./run_tests.sh -v
 
 ifneq ($(DEPTARGETS),)

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

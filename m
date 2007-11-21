Return-Path: <dgibson@ozlabs.org>
Date: Wed, 21 Nov 2007 11:56:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Add valgrind support to testsuite
Message-ID: <20071121005614.GD13156@localhost.localdomain>
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

This patch adds some options to the run_tests.sh script allowing it to
run all the testcases under valgrind to check for pointer corruption
bugs and memory leaks.  Invoking "make checkm" will run the testsuite
with valgrind.

It include a mechanism for specifying valgrind errors to be suppressed
on a per-testcase basis, and adds a couple of such suppression files
for the mangle-layout and open_pack testcases which dump for use by
other testcases a buffer which may contain uninitialized sections.  We
use suppressions rather than initializing the buffer so that valgrind
will catch any internal access s to the uninitialized data, which
would be a bug.

The patch also fixes one genuine bug caught by valgrind -
_packblocks() in fdt_rw.c was using memcpy() where it should have been
using memmove().

At present the valgrinding won't do anything useful for testcases
invoked via a shell script - which includes all the dtc testcases.  I
plan to fix that later.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2007-11-21 11:29:28.000000000 +1100
+++ dtc/tests/run_tests.sh	2007-11-21 11:44:55.000000000 +1100
@@ -2,16 +2,26 @@
 
 export QUIET_TEST=1
 
+export VALGRIND=
+VGCODE=126
+
 tot_tests=0
 tot_pass=0
 tot_fail=0
 tot_config=0
+tot_vg=0
 tot_strange=0
 
 run_test () {
     tot_tests=$[tot_tests + 1]
     echo -n "$@:	"
-    if "./$@"; then
+    VGLOCAL="$VALGRIND"
+    if [ -n "$VALGRIND" ]; then
+	if [ -f $1.supp ]; then
+	    VGLOCAL="$VGLOCAL --suppressions=$1.supp"
+	fi
+    fi
+    if $VGLOCAL "./$@"; then
 	tot_pass=$[tot_pass + 1]
     else
 	ret="$?"
@@ -19,6 +29,8 @@
 	    tot_config=$[tot_config + 1]
 	elif [ "$ret" == "2" ]; then
 	    tot_fail=$[tot_fail + 1]
+	elif [ "$ret" == "$VGCODE" ]; then
+	    tot_vg=$[tot_vg + 1]
 	else
 	    tot_strange=$[tot_strange + 1]
 	fi
@@ -148,7 +160,7 @@
     run_test dtc-checkfails.sh -I dts -O dtb minusone-phandle.dts
 }
 
-while getopts "vdt:" ARG ; do
+while getopts "vt:m" ARG ; do
     case $ARG in
 	"v")
 	    unset QUIET_TEST
@@ -156,6 +168,9 @@
 	"t")
 	    TESTSETS=$OPTARG
 	    ;;
+	"m")
+	    VALGRIND="valgrind --tool=memcheck -q --error-exitcode=$VGCODE"
+	    ;;
     esac
 done
 
@@ -182,6 +197,9 @@
 echo -e "*                PASS:	$tot_pass"
 echo -e "*                FAIL:	$tot_fail"
 echo -e "*   Bad configuration:	$tot_config"
+if [ -n "$VALGRIND" ]; then
+    echo -e "*    valgrind errors:	$tot_vg"
+fi
 echo -e "* Strange test result:	$tot_strange"
 echo -e "**********"
 
Index: dtc/tests/Makefile.tests
===================================================================
--- dtc.orig/tests/Makefile.tests	2007-11-21 11:29:29.000000000 +1100
+++ dtc/tests/Makefile.tests	2007-11-21 11:29:39.000000000 +1100
@@ -26,7 +26,7 @@
 TESTS_DEPFILES = $(TESTS:%=%.d) \
 	$(addprefix $(TESTS_PREFIX),testutils.d trees.d dumptrees.d)
 
-TESTS_CLEANFILES_L =  *.output vgcore.* *.dtb *.test.dts
+TESTS_CLEANFILES_L =  *.output vglog.* vgcore.* *.dtb *.test.dts
 TESTS_CLEANFILES = $(TESTS_CLEANFILES_L:%=$(TESTS_PREFIX)%)
 
 BIN += $(TESTS) $(TESTS_PREFIX)dumptrees
@@ -52,6 +52,9 @@
 check:	tests dtc
 	cd $(TESTS_PREFIX); ./run_tests.sh
 
+checkm: tests dtc
+	cd $(TESTS_PREFIX); ./run_tests.sh -m 2>&1 | tee vglog.$$$$
+
 checkv:	tests dtc
 	cd $(TESTS_PREFIX); ./run_tests.sh -v
 
Index: dtc/libfdt/fdt_rw.c
===================================================================
--- dtc.orig/libfdt/fdt_rw.c	2007-11-21 11:29:28.000000000 +1100
+++ dtc/libfdt/fdt_rw.c	2007-11-21 11:29:39.000000000 +1100
@@ -358,12 +358,12 @@
 	memmove(buf + mem_rsv_off, fdt + fdt_off_mem_rsvmap(fdt), mem_rsv_size);
 	fdt_set_off_mem_rsvmap(buf, mem_rsv_off);
 
-	memcpy(buf + struct_off, fdt + fdt_off_dt_struct(fdt), struct_size);
+	memmove(buf + struct_off, fdt + fdt_off_dt_struct(fdt), struct_size);
 	fdt_set_off_dt_struct(buf, struct_off);
 	fdt_set_size_dt_struct(buf, struct_size);
 
-	memcpy(buf + strings_off, fdt + fdt_off_dt_strings(fdt),
-	       fdt_size_dt_strings(fdt));
+	memmove(buf + strings_off, fdt + fdt_off_dt_strings(fdt),
+		fdt_size_dt_strings(fdt));
 	fdt_set_off_dt_strings(buf, strings_off);
 	fdt_set_size_dt_strings(buf, fdt_size_dt_strings(fdt));
 }
Index: dtc/tests/open_pack.supp
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/open_pack.supp	2007-11-21 11:29:39.000000000 +1100
@@ -0,0 +1,7 @@
+{
+   opened blob dumps uninitialized data
+   Memcheck:Param
+   write(buf)
+   obj:/lib/ld-2.6.1.so
+   fun:main
+}
Index: dtc/tests/mangle-layout.supp
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/mangle-layout.supp	2007-11-21 11:34:33.000000000 +1100
@@ -0,0 +1,7 @@
+{
+   uninitialized alignment gaps can be dumped to output
+   Memcheck:Param
+   write(buf)
+   obj:/lib/ld-2.6.1.so
+   fun:main
+}

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

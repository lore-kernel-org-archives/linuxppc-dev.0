Return-Path: <dgibson@ozlabs.org>
Date: Wed, 26 Mar 2008 17:56:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Rework handling of boot_cpuid_phys
Message-ID: <20080326065607.GC2090@localhost.localdomain>
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

Currently, dtc will put the nonsense value 0xfeedbeef into the
boot_cpuid_phys field of an output blob, unless explicitly given
another value with the -b command line option.  As well as being a
totally unuseful default value, this also means that dtc won't
properly preserve the boot_cpuid_phys field in -I dtb -O dtb mode.

This patch reworks things to improve the boot_cpuid handling.  The new
semantics are that the output's boot_cpuid_phys value is:
	the value given on the command line if -b is used
otherwise
	the value from the input, if in -I dtb mode
otherwise
	0

Implementation-wise we do the following:
	- boot_cpuid_phys is added to struct boot_info, so that
structure now contains all of the blob's semantic information.
	- dt_to_blob() and dt_to_asm() output the cpuid given in
boot_info
	- dt_from_blob() fills in boot_info based on the input blob
	- The other dt_from_*() functions just record 0, but we can
change this easily if e.g. we invent a way of specifying the boot cpu
in the source format.
	- main() overrides the cpuid in the boot_info between input
and output if -b is given

We add some testcases to check this new behaviour.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---
 dtc-parser.y               |    4 +--
 dtc.c                      |   12 +++++++----
 dtc.h                      |    9 +++-----
 flattree.c                 |   14 ++++++-------
 fstree.c                   |    2 -
 livetree.c                 |    3 +-
 tests/Makefile.tests       |    2 -
 tests/boot-cpuid.c         |   48 +++++++++++++++++++++++++++++++++++++++++++++
 tests/dtbs_equal_ordered.c |    7 ++++++
 tests/run_tests.sh         |    8 +++++++
 10 files changed, 88 insertions(+), 21 deletions(-)

Index: dtc/tests/dtbs_equal_ordered.c
===================================================================
--- dtc.orig/tests/dtbs_equal_ordered.c	2008-03-26 17:53:17.000000000 +1100
+++ dtc/tests/dtbs_equal_ordered.c	2008-03-26 17:53:17.000000000 +1100
@@ -125,6 +125,7 @@
 int main(int argc, char *argv[])
 {
 	void *fdt1, *fdt2;
+	uint32_t cpuid1, cpuid2;
 
 	test_init(argc, argv);
 	if (argc != 3)
@@ -135,5 +136,11 @@
 	compare_mem_rsv(fdt1, fdt2);
 	compare_structure(fdt1, fdt2);
 
+	cpuid1 = fdt_boot_cpuid_phys(fdt1);
+	cpuid2 = fdt_boot_cpuid_phys(fdt2);
+	if (cpuid1 != cpuid2)
+		FAIL("boot_cpuid_phys mismatch 0x%x != 0x%x",
+		     cpuid1, cpuid2);
+
 	PASS();
 }
Index: dtc/dtc-parser.y
===================================================================
--- dtc.orig/dtc-parser.y	2008-03-26 17:53:17.000000000 +1100
+++ dtc/dtc-parser.y	2008-03-26 17:53:17.000000000 +1100
@@ -85,11 +85,11 @@
 sourcefile:
 	  DT_V1 ';' memreserves devicetree
 		{
-			the_boot_info = build_boot_info($3, $4);
+			the_boot_info = build_boot_info($3, $4, 0);
 		}
 	| v0_memreserves devicetree
 		{
-			the_boot_info = build_boot_info($1, $2);
+			the_boot_info = build_boot_info($1, $2, 0);
 		}
 	;
 
Index: dtc/dtc.c
===================================================================
--- dtc.orig/dtc.c	2008-03-26 17:53:17.000000000 +1100
+++ dtc/dtc.c	2008-03-26 17:53:17.000000000 +1100
@@ -120,7 +120,7 @@
 	int opt;
 	FILE *outf = NULL;
 	int outversion = DEFAULT_FDT_VERSION;
-	int boot_cpuid_phys = 0xfeedbeef;
+	long long cmdline_boot_cpuid = -1;
 
 	quiet      = 0;
 	reservenum = 0;
@@ -160,7 +160,7 @@
 			quiet++;
 			break;
 		case 'b':
-			boot_cpuid_phys = strtol(optarg, NULL, 0);
+			cmdline_boot_cpuid = strtoll(optarg, NULL, 0);
 			break;
 		case 'v':
 			printf("Version: %s\n", DTC_VERSION);
@@ -194,9 +194,13 @@
 	else
 		die("Unknown input format \"%s\"\n", inform);
 
+	if (cmdline_boot_cpuid != -1)
+		bi->boot_cpuid_phys = cmdline_boot_cpuid;
+
 	fill_fullpaths(bi->dt, "");
 	process_checks(force, bi);
 
+
 	if (streq(outname, "-")) {
 		outf = stdout;
 	} else {
@@ -209,9 +213,9 @@
 	if (streq(outform, "dts")) {
 		dt_to_source(outf, bi);
 	} else if (streq(outform, "dtb")) {
-		dt_to_blob(outf, bi, outversion, boot_cpuid_phys);
+		dt_to_blob(outf, bi, outversion);
 	} else if (streq(outform, "asm")) {
-		dt_to_asm(outf, bi, outversion, boot_cpuid_phys);
+		dt_to_asm(outf, bi, outversion);
 	} else if (streq(outform, "null")) {
 		/* do nothing */
 	} else {
Index: dtc/dtc.h
===================================================================
--- dtc.orig/dtc.h	2008-03-26 17:53:17.000000000 +1100
+++ dtc/dtc.h	2008-03-26 17:53:17.000000000 +1100
@@ -232,10 +232,11 @@
 struct boot_info {
 	struct reserve_info *reservelist;
 	struct node *dt;		/* the device tree */
+	u32 boot_cpuid_phys;
 };
 
 struct boot_info *build_boot_info(struct reserve_info *reservelist,
-				  struct node *tree);
+				  struct node *tree, u32 boot_cpuid_phys);
 
 /* Checks */
 
@@ -243,10 +244,8 @@
 
 /* Flattened trees */
 
-void dt_to_blob(FILE *f, struct boot_info *bi, int version,
-		int boot_cpuid_phys);
-void dt_to_asm(FILE *f, struct boot_info *bi, int version,
-	       int boot_cpuid_phys);
+void dt_to_blob(FILE *f, struct boot_info *bi, int version);
+void dt_to_asm(FILE *f, struct boot_info *bi, int version);
 
 struct boot_info *dt_from_blob(const char *fname);
 
Index: dtc/flattree.c
===================================================================
--- dtc.orig/flattree.c	2008-03-26 17:53:17.000000000 +1100
+++ dtc/flattree.c	2008-03-26 17:53:17.000000000 +1100
@@ -354,8 +354,7 @@
 		fdt->size_dt_struct = cpu_to_be32(dtsize);
 }
 
-void dt_to_blob(FILE *f, struct boot_info *bi, int version,
-		int boot_cpuid_phys)
+void dt_to_blob(FILE *f, struct boot_info *bi, int version)
 {
 	struct version_info *vi = NULL;
 	int i;
@@ -380,7 +379,7 @@
 
 	/* Make header */
 	make_fdt_header(&fdt, vi, reservebuf.len, dtbuf.len, strbuf.len,
-			boot_cpuid_phys);
+			bi->boot_cpuid_phys);
 
 	/*
 	 * If the user asked for more space than is used, adjust the totalsize.
@@ -446,7 +445,7 @@
 	}
 }
 
-void dt_to_asm(FILE *f, struct boot_info *bi, int version, int boot_cpuid_phys)
+void dt_to_asm(FILE *f, struct boot_info *bi, int version)
 {
 	struct version_info *vi = NULL;
 	int i;
@@ -486,7 +485,7 @@
 
 	if (vi->flags & FTF_BOOTCPUID)
 		fprintf(f, "\t.long\t%i\t\t\t\t\t/* boot_cpuid_phys */\n",
-			boot_cpuid_phys);
+			bi->boot_cpuid_phys);
 
 	if (vi->flags & FTF_STRTABSIZE)
 		fprintf(f, "\t.long\t_%s_strings_end - _%s_strings_start\t/* size_dt_strings */\n",
@@ -784,7 +783,7 @@
 struct boot_info *dt_from_blob(const char *fname)
 {
 	struct dtc_file *dtcf;
-	u32 magic, totalsize, version, size_dt;
+	u32 magic, totalsize, version, size_dt, boot_cpuid_phys;
 	u32 off_dt, off_str, off_mem_rsvmap;
 	int rc;
 	char *blob;
@@ -856,6 +855,7 @@
 	off_str = be32_to_cpu(fdt->off_dt_strings);
 	off_mem_rsvmap = be32_to_cpu(fdt->off_mem_rsvmap);
 	version = be32_to_cpu(fdt->version);
+	boot_cpuid_phys = be32_to_cpu(fdt->boot_cpuid_phys);
 
 	if (off_mem_rsvmap >= totalsize)
 		die("Mem Reserve structure offset exceeds total size\n");
@@ -908,5 +908,5 @@
 
 	dtc_close_file(dtcf);
 
-	return build_boot_info(reservelist, tree);
+	return build_boot_info(reservelist, tree, boot_cpuid_phys);
 }
Index: dtc/fstree.c
===================================================================
--- dtc.orig/fstree.c	2008-03-26 17:53:17.000000000 +1100
+++ dtc/fstree.c	2008-03-26 17:53:17.000000000 +1100
@@ -87,6 +87,6 @@
 	tree = read_fstree(dirname);
 	tree = name_node(tree, "", NULL);
 
-	return build_boot_info(NULL, tree);
+	return build_boot_info(NULL, tree, 0);
 }
 
Index: dtc/livetree.c
===================================================================
--- dtc.orig/livetree.c	2008-03-26 17:53:17.000000000 +1100
+++ dtc/livetree.c	2008-03-26 17:53:17.000000000 +1100
@@ -165,13 +165,14 @@
 }
 
 struct boot_info *build_boot_info(struct reserve_info *reservelist,
-				  struct node *tree)
+				  struct node *tree, u32 boot_cpuid_phys)
 {
 	struct boot_info *bi;
 
 	bi = xmalloc(sizeof(*bi));
 	bi->reservelist = reservelist;
 	bi->dt = tree;
+	bi->boot_cpuid_phys = boot_cpuid_phys;
 
 	return bi;
 }
Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2008-03-26 17:53:17.000000000 +1100
+++ dtc/tests/run_tests.sh	2008-03-26 17:55:14.000000000 +1100
@@ -200,6 +200,14 @@
     run_dtc_test -I dts -O dtb -o dtc_comments-cmp.test.dtb comments-cmp.dts
     run_test dtbs_equal_ordered dtc_comments.test.dtb dtc_comments-cmp.test.dtb
 
+    # Check boot_cpuid_phys handling
+    run_dtc_test -I dts -O dtb -b 17 -o boot_cpuid.test.dtb empty.dts
+    run_test boot-cpuid boot_cpuid.test.dtb 17
+    run_dtc_test -I dtb -O dtb -b 17 -o boot_cpuid_test_tree1.test.dtb test_tree1.dtb
+    run_test boot-cpuid boot_cpuid_test_tree1.test.dtb 17
+    run_dtc_test -I dtb -O dtb -o boot_cpuid_preserved_test_tree1.test.dtb boot_cpuid_test_tree1.test.dtb
+    run_test dtbs_equal_ordered boot_cpuid_preserved_test_tree1.test.dtb boot_cpuid_test_tree1.test.dtb
+
     # Check -Odts mode preserve all dtb information
     for tree in test_tree1.dtb dtc_tree1.test.dtb dtc_escapes.test.dtb ; do
 	run_dtc_test -I dtb -O dts -o odts_$tree.test.dts $tree
Index: dtc/tests/Makefile.tests
===================================================================
--- dtc.orig/tests/Makefile.tests	2008-03-26 17:53:17.000000000 +1100
+++ dtc/tests/Makefile.tests	2008-03-26 17:53:17.000000000 +1100
@@ -9,7 +9,7 @@
 	sw_tree1 \
 	move_and_save mangle-layout nopulate \
 	open_pack rw_tree1 set_name setprop del_property del_node \
-	string_escapes references path-references \
+	string_escapes references path-references boot-cpuid \
 	dtbs_equal_ordered \
 	add_subnode_with_nops
 LIB_TESTS = $(LIB_TESTS_L:%=$(TESTS_PREFIX)%)
Index: dtc/tests/boot-cpuid.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/boot-cpuid.c	2008-03-26 17:53:17.000000000 +1100
@@ -0,0 +1,48 @@
+/*
+ * Copyright (C) 2008 David Gibson, IBM Corporation.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public License
+ * as published by the Free Software Foundation; either version 2.1 of
+ * the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <stdint.h>
+
+#include <fdt.h>
+#include <libfdt.h>
+
+#include "tests.h"
+#include "testdata.h"
+
+int main(int argc, char *argv[])
+{
+	void *fdt;
+	uint32_t cpuid;
+
+	test_init(argc, argv);
+
+	if (argc != 3)
+		CONFIG("Usage: %s <dtb file> <cpuid>", argv[0]);
+
+	fdt = load_blob(argv[1]);
+	cpuid = strtoul(argv[2], NULL, 0);
+
+	if (fdt_boot_cpuid_phys(fdt) != cpuid)
+		FAIL("Incorrect boot_cpuid_phys (0x%x instead of 0x%x)",
+		     fdt_boot_cpuid_phys(fdt), cpuid);
+
+	PASS();
+}

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

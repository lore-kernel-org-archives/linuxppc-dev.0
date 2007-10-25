Return-Path: <dgibson@ozlabs.org>
Date: Thu, 25 Oct 2007 15:05:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: libfdt: Test on trees with different block layouts
Message-ID: <20071025050558.GE24856@localhost.localdomain>
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

At present, all the example dtbs we use in the testsuite are version
17 and have reservation map, then structure block then strings block
(the natural ordering based on alignment constraints).  However, all
libfdt's read-only and in-place write functions should also work on
v16 trees, and on trees with other layouts.

This patch adds a testcase / utility function to rearrange the blocks
of a dtb and/or regress a v17 tree to v16, and uses it to run tests on
trees with different layouts and versions.

Signed-off-by: David Gibson <david@tgibson.dropbear.id.au>

Index: dtc/tests/mangle-layout.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/mangle-layout.c	2007-10-25 14:51:55.000000000 +1000
@@ -0,0 +1,166 @@
+/*
+ * libfdt - Flat Device Tree manipulation
+ *	Testcase/tool for rearranging blocks of a dtb
+ * Copyright (C) 2006 David Gibson, IBM Corporation.
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
+#include <limits.h>
+#include <stdint.h>
+
+#include <fdt.h>
+#include <libfdt.h>
+
+#include "tests.h"
+#include "testdata.h"
+
+struct bufstate {
+	void *buf;
+	int size;
+};
+
+void expand_buf(struct bufstate *buf, int newsize)
+{
+	buf->buf = realloc(buf->buf, newsize);
+	if (!buf->buf)
+		CONFIG("Allocation failure");
+	buf->size = newsize;
+}
+
+void new_header(struct bufstate *buf, int version, const void *fdt)
+{
+	int hdrsize;
+
+	if (version == 16)
+		hdrsize = FDT_V16_SIZE;
+	else if (version == 17)
+		hdrsize = FDT_V17_SIZE;
+	else
+		CONFIG("Bad version %d", version);
+
+	expand_buf(buf, hdrsize);
+	memset(buf->buf, 0, hdrsize);
+
+	fdt_set_magic(buf->buf, FDT_MAGIC);
+	fdt_set_version(buf->buf, version);
+	fdt_set_last_comp_version(buf->buf, 16);
+	fdt_set_boot_cpuid_phys(buf->buf, fdt_boot_cpuid_phys(fdt));
+}
+
+void add_block(struct bufstate *buf, int version, char block, const void *fdt)
+{
+	int align, size;
+	const void *src;
+	int offset;
+
+	switch (block) {
+	case 'm':
+		/* Memory reserve map */
+		align = 8;
+		src = fdt + fdt_off_mem_rsvmap(fdt);
+		size = (fdt_num_mem_rsv(fdt) + 1)
+			* sizeof(struct fdt_reserve_entry);
+		break;
+
+	case 't':
+		/* Structure block */
+		align = 4;
+		src = fdt + fdt_off_dt_struct(fdt);
+		size = fdt_size_dt_struct(fdt);
+		break;
+
+	case 's':
+		/* Strings block */
+		align = 1;
+		src = fdt + fdt_off_dt_strings(fdt);
+		size = fdt_size_dt_strings(fdt);
+		break;
+	default:
+		CONFIG("Bad block '%c'", block);
+	}
+
+	offset = ALIGN(buf->size, align);
+	fprintf(stderr, "Moving block %c from %p, to offset %d, size %d\n",
+		block, src, offset, size);
+
+	expand_buf(buf, offset+size);
+
+	memcpy(buf->buf + offset, src, size);
+
+	switch (block) {
+	case 'm':
+		fdt_set_off_mem_rsvmap(buf->buf, offset);
+		break;
+
+	case 't':
+		fdt_set_off_dt_struct(buf->buf, offset);
+		if (version >= 17)
+			fdt_set_size_dt_struct(buf->buf, size);
+		break;
+
+	case 's':
+		fdt_set_off_dt_strings(buf->buf, offset);
+		fdt_set_size_dt_strings(buf->buf, size);
+		break;
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	void *fdt;
+	int version;
+	const char *blockorder;
+	struct bufstate buf = {NULL, 0};
+	int err;
+	const char *inname;
+	char outname[PATH_MAX];
+
+	test_init(argc, argv);
+	if (argc != 4)
+		CONFIG("Usage: %s <dtb file> <version> <block order>", argv[0]);
+
+	inname = argv[1];
+	fdt = load_blob(argv[1]);
+	version = atoi(argv[2]);
+	blockorder = argv[3];
+	sprintf(outname, "v%d.%s.%s", version, blockorder, inname);
+
+	if ((version != 16) && (version != 17))
+		CONFIG("Version must be 16 or 17");
+
+	if (fdt_version(fdt) < 17)
+		CONFIG("Input tree must be v17");
+
+	new_header(&buf, version, fdt);
+
+	while (*blockorder) {
+		add_block(&buf, version, *blockorder, fdt);
+		blockorder++;
+	}
+
+	fdt_set_totalsize(buf.buf, buf.size);
+
+	err = fdt_check_header(buf.buf);
+	if (err)
+		FAIL("Output tree fails check: %s", fdt_strerror(err));
+
+	save_blob(outname, buf.buf);
+
+	PASS();
+}
Index: dtc/tests/Makefile.tests
===================================================================
--- dtc.orig/tests/Makefile.tests	2007-10-25 13:57:12.000000000 +1000
+++ dtc/tests/Makefile.tests	2007-10-25 14:49:42.000000000 +1000
@@ -6,7 +6,7 @@
 	notfound \
 	setprop_inplace nop_property nop_node \
 	sw_tree1 \
-	move_and_save \
+	move_and_save mangle-layout \
 	open_pack rw_tree1 setprop del_property del_node \
 	string_escapes dtbs_equal_ordered
 LIB_TESTS = $(LIB_TESTS_L:%=$(TESTS_PREFIX)%)
Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2007-10-25 13:57:12.000000000 +1000
+++ dtc/tests/run_tests.sh	2007-10-25 14:58:14.000000000 +1000
@@ -79,6 +79,17 @@
 	tree1_tests deshunted.$tree
     done
 
+    # v16 and alternate layout tests
+    for tree in test_tree1.dtb; do
+	for version in 17 16; do
+	    for layout in mts mst tms tsm smt stm; do
+		run_test mangle-layout $tree $version $layout
+		tree1_tests v$version.$layout.$tree
+		run_test dtbs_equal_ordered $tree v$version.$layout.$tree
+	    done
+	done
+    done
+
     # Read-write tests
     for tree in test_tree1.dtb sw_tree1.test.dtb; do
 	rm -f opened.$tree repacked.$tree

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

Return-Path: <dgibson@ozlabs.org>
Date: Mon, 18 Feb 2008 16:09:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: libfdt: More tests of NOP handling behaviour
Message-ID: <20080218050925.GH29975@localhost.localdomain>
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

In light of the recently discovered bug with NOP handling, this adds
some more testcases for NOP handling.  Specifically, it adds a helper
program which will add a NOP tag after every existing tag in a dtb,
and runs the standard battery of tests over trees mangled in this way.

For now, this does not add a NOP at the very beginning of the
structure block.  This causes problems for libfdt at present, because
we assume in many places that the root node's BEGIN_NODE tag is at
offset 0.  I'm still contemplating what to do about this (with one
option being simply to declare such dtbs invalid).

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/tests/nopulate.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/nopulate.c	2008-02-14 17:01:10.000000000 +1100
@@ -0,0 +1,107 @@
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
+int nopulate_struct(char *buf, const void *fdt)
+{
+	int offset, nextoffset = 0;
+	uint32_t tag;
+	char *p;
+
+	p = buf;
+
+	do {
+		offset = nextoffset;
+		tag = fdt_next_tag(fdt, offset, &nextoffset);
+
+		memcpy(p, fdt + fdt_off_dt_struct(fdt) + offset,
+		       nextoffset - offset);
+		p += nextoffset - offset;
+
+		*((uint32_t *)p) = cpu_to_fdt32(FDT_NOP);
+		p += FDT_TAGSIZE;
+
+	} while (tag != FDT_END);
+
+	return p - buf;
+}
+
+int main(int argc, char *argv[])
+{
+	void *fdt, *fdt2;
+	void *buf;
+	int newsize, struct_start, struct_end_old, struct_end_new, delta;
+	const char *inname;
+	char outname[PATH_MAX];
+
+	test_init(argc, argv);
+	if (argc != 2)
+		CONFIG("Usage: %s <dtb file>", argv[0]);
+
+	inname = argv[1];
+	fdt = load_blob(argv[1]);
+	sprintf(outname, "noppy.%s", inname);
+
+	if (fdt_version(fdt) < 17)
+		FAIL("Can't deal with version <17");
+
+	buf = xmalloc(2 * fdt_size_dt_struct(fdt));
+
+	newsize = nopulate_struct(buf, fdt);
+
+	verbose_printf("Nopulated structure block has new size %d\n", newsize);
+
+	/* Replace old strcutre block with the new */
+
+	fdt2 = xmalloc(fdt_totalsize(fdt) + newsize);
+
+	struct_start = fdt_off_dt_struct(fdt);
+	delta = newsize - fdt_size_dt_struct(fdt);
+	struct_end_old = struct_start + fdt_size_dt_struct(fdt);
+	struct_end_new = struct_start + newsize;
+
+	memcpy(fdt2, fdt, struct_start);
+	memcpy(fdt2 + struct_start, buf, newsize);
+	memcpy(fdt2 + struct_end_new, fdt + struct_end_old,
+	       fdt_totalsize(fdt) - struct_end_old);
+
+	fdt_set_totalsize(fdt2, fdt_totalsize(fdt) + delta);
+	fdt_set_size_dt_struct(fdt2, newsize);
+
+	if (fdt_off_mem_rsvmap(fdt) > struct_start)
+		fdt_set_off_mem_rsvmap(fdt2, fdt_off_mem_rsvmap(fdt) + delta);
+	if (fdt_off_dt_strings(fdt) > struct_start)
+		fdt_set_off_dt_strings(fdt2, fdt_off_dt_strings(fdt) + delta);
+
+	save_blob(outname, fdt2);
+
+	PASS();
+}
Index: dtc/tests/Makefile.tests
===================================================================
--- dtc.orig/tests/Makefile.tests	2008-02-14 16:49:55.000000000 +1100
+++ dtc/tests/Makefile.tests	2008-02-14 17:01:10.000000000 +1100
@@ -7,7 +7,7 @@
 	notfound \
 	setprop_inplace nop_property nop_node \
 	sw_tree1 \
-	move_and_save mangle-layout \
+	move_and_save mangle-layout nopulate \
 	open_pack rw_tree1 set_name setprop del_property del_node \
 	string_escapes references path-references \
 	dtbs_equal_ordered \
Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2008-02-14 16:49:55.000000000 +1100
+++ dtc/tests/run_tests.sh	2008-02-14 17:01:10.000000000 +1100
@@ -126,6 +126,13 @@
     tree1_tests rw_tree1.test.dtb
     tree1_tests_rw rw_tree1.test.dtb
 
+    for basetree in test_tree1.dtb sw_tree1.test.dtb rw_tree1.test.dtb; do
+	run_test nopulate $basetree
+	run_test dtbs_equal_ordered $basetree noppy.$basetree
+	tree1_tests noppy.$basetree
+	tree1_tests_rw noppy.$basetree
+    done
+
     # Tests for behaviour on various sorts of corrupted trees
     run_test truncated_property
 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

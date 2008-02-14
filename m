Return-Path: <dgibson@ozlabs.org>
Date: Thu, 14 Feb 2008 16:50:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: libfdt: Fix NOP handling bug in fdt_add_subnode_namelen()
Message-ID: <20080214055034.GA13137@localhost.localdomain>
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

fdt_add_subnode_namelen() has a bug if asked to add a subnode to a
node which has NOP tags interspersed with its properties.  In this
case fdt_add_subnode_namelen() will put the new subnode before the
first NOP tag, even if there are properties after it, which will
result in an invalid blob.

This patch fixes the bug, and adds a testcase for it.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/tests/Makefile.tests
===================================================================
--- dtc.orig/tests/Makefile.tests	2008-02-14 15:10:35.000000000 +1100
+++ dtc/tests/Makefile.tests	2008-02-14 15:10:43.000000000 +1100
@@ -10,7 +10,8 @@
 	move_and_save mangle-layout \
 	open_pack rw_tree1 set_name setprop del_property del_node \
 	string_escapes references path-references \
-	dtbs_equal_ordered
+	dtbs_equal_ordered \
+	add_subnode_with_nops
 LIB_TESTS = $(LIB_TESTS_L:%=$(TESTS_PREFIX)%)
 
 LIBTREE_TESTS_L = truncated_property
Index: dtc/tests/add_subnode_with_nops.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/add_subnode_with_nops.c	2008-02-14 15:12:45.000000000 +1100
@@ -0,0 +1,85 @@
+/*
+ * libfdt - Flat Device Tree manipulation
+ *	Testcase for fdt_nop_node()
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
+#include <ctype.h>
+#include <stdint.h>
+
+#include <fdt.h>
+#include <libfdt.h>
+
+#include "tests.h"
+#include "testdata.h"
+
+#define SPACE	65536
+
+#define CHECK(code) \
+	{ \
+		err = (code); \
+		if (err) \
+			FAIL(#code ": %s", fdt_strerror(err)); \
+	}
+
+#define OFF_CHECK(off, code) \
+	{ \
+		(off) = (code); \
+		if (off < 0) \
+			FAIL(#code ": %s", fdt_strerror(off)); \
+	}
+
+int main(int argc, char *argv[])
+{
+	void *fdt;
+	int err;
+	int offset;
+
+	test_init(argc, argv);
+
+	fdt = xmalloc(SPACE);
+
+	CHECK(fdt_create(fdt, SPACE));
+
+	CHECK(fdt_finish_reservemap(fdt));
+	CHECK(fdt_begin_node(fdt, ""));
+	CHECK(fdt_property_cell(fdt, "prop1", TEST_VALUE_1));
+	CHECK(fdt_property_cell(fdt, "prop2", TEST_VALUE_2));
+	CHECK(fdt_end_node(fdt));
+	CHECK(fdt_finish(fdt));
+
+	verbose_printf("Built empty tree, totalsize = %d\n",
+		       fdt_totalsize(fdt));
+
+	CHECK(fdt_open_into(fdt, fdt, SPACE));
+
+	check_getprop_cell(fdt, 0, "prop1", TEST_VALUE_1);
+	check_getprop_cell(fdt, 0, "prop2", TEST_VALUE_2);
+
+	CHECK(fdt_nop_property(fdt, 0, "prop1"));
+
+	check_getprop_cell(fdt, 0, "prop2", TEST_VALUE_2);
+
+	OFF_CHECK(offset, fdt_add_subnode(fdt, 0, "subnode"));
+
+	check_getprop_cell(fdt, 0, "prop2", TEST_VALUE_2);
+
+	PASS();
+}
Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2008-02-14 15:11:10.000000000 +1100
+++ dtc/tests/run_tests.sh	2008-02-14 15:11:25.000000000 +1100
@@ -128,6 +128,9 @@
 
     # Tests for behaviour on various sorts of corrupted trees
     run_test truncated_property
+
+    # Specific bug tests
+    run_test add_subnode_with_nops
 }
 
 dtc_tests () {
Index: dtc/libfdt/fdt_rw.c
===================================================================
--- dtc.orig/libfdt/fdt_rw.c	2008-02-14 15:15:29.000000000 +1100
+++ dtc/libfdt/fdt_rw.c	2008-02-14 15:15:40.000000000 +1100
@@ -333,7 +333,7 @@
 	do {
 		offset = nextoffset;
 		tag = fdt_next_tag(fdt, offset, &nextoffset);
-	} while (tag == FDT_PROP);
+	} while ((tag == FDT_PROP) || (tag == FDT_NOP));
 
 	nh = _fdt_offset_ptr_w(fdt, offset);
 	nodelen = sizeof(*nh) + ALIGN(namelen+1, FDT_TAGSIZE) + FDT_TAGSIZE;

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

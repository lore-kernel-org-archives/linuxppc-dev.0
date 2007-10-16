Return-Path: <dgibson@ozlabs.org>
Date: Tue, 16 Oct 2007 13:58:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: libfdt: Add functions for handling the "compatible" property
Message-ID: <20071016035825.GR26787@localhost.localdomain>
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

This patch adds functions for dealing with the compatible property.
fdt_node_check_compatible() can be used to determine whether a node is
compatible with a given string and fdt_node_offset_by_compatible()
locates nodes with a given compatible string.

Testcases for these functions are also included.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/libfdt/fdt_ro.c
===================================================================
--- dtc.orig/libfdt/fdt_ro.c	2007-10-12 15:09:27.000000000 +1000
+++ dtc/libfdt/fdt_ro.c	2007-10-12 15:10:39.000000000 +1000
@@ -477,3 +477,86 @@ int fdt_node_offset_by_prop_value(const 
 
 	return -FDT_ERR_NOTFOUND;
 }
+
+int _stringlist_contains(const void *strlist, int listlen, const char *str)
+{
+	int len = strlen(str);
+	const void *p;
+
+	while (listlen >= len) {
+		if (memcmp(str, strlist, len+1) == 0)
+			return 1;
+		p = memchr(strlist, '\0', listlen);
+		if (!p)
+			return 0; /* malformed strlist.. */
+		listlen -= (p-strlist) + 1;
+		strlist = p + 1;
+	}
+	return 0;
+}
+
+int fdt_node_check_compatible(const void *fdt, int nodeoffset,
+			      const char *compatible)
+{
+	const void *prop;
+	int len;
+
+	prop = fdt_getprop(fdt, nodeoffset, "compatible", &len);
+	if (!prop)
+		return len;
+	if (_stringlist_contains(prop, len, compatible))
+		return 0;
+	else
+		return 1;
+}
+
+int fdt_node_offset_by_compatible(const void *fdt, int startoffset,
+				  const char *compatible)
+{
+	uint32_t tag;
+	int offset, nextoffset;
+	int err;
+
+	CHECK_HEADER(fdt);
+
+	if (startoffset >= 0) {
+		tag = _fdt_next_tag(fdt, startoffset, &nextoffset);
+		if (tag != FDT_BEGIN_NODE)
+			return -FDT_ERR_BADOFFSET;
+	} else {
+		nextoffset = 0;
+	}
+
+	/* FIXME: The algorithm here is pretty horrible: we scan each
+	 * property of a node in fdt_node_check_compatible(), then if
+	 * that didn't find what we want, we scan over them again
+	 * making our way to the next node.  Still it's the easiest to
+	 * implement approach; performance can come later. */
+	do {
+		offset = nextoffset;
+		tag = _fdt_next_tag(fdt, offset, &nextoffset);
+
+		switch (tag) {
+		case FDT_BEGIN_NODE:
+			err = fdt_node_check_compatible(fdt, offset,
+							compatible);
+			if ((err < 0)
+			    && (err != -FDT_ERR_NOTFOUND))
+				return err;
+			else if (err == 0)
+				return offset;
+			break;
+
+		case FDT_PROP:
+		case FDT_END:
+		case FDT_END_NODE:
+		case FDT_NOP:
+			break;
+
+		default:
+			return -FDT_ERR_BADSTRUCTURE;
+		}
+	} while (tag != FDT_END);
+
+	return -FDT_ERR_NOTFOUND;
+}
Index: dtc/tests/trees.S
===================================================================
--- dtc.orig/tests/trees.S	2007-10-12 15:09:27.000000000 +1000
+++ dtc/tests/trees.S	2007-10-12 15:10:39.000000000 +1000
@@ -83,13 +83,16 @@ test_tree1_rsvmap:
 
 test_tree1_struct:
 	BEGIN_NODE("")
+	PROP_STR(test_tree1, compatible, "test_tree1")
 	PROP_INT(test_tree1, prop_int, TEST_VALUE_1)
 	PROP_STR(test_tree1, prop_str, TEST_STRING_1)
 
 	BEGIN_NODE("subnode@1")
+	PROP_STR(test_tree1, compatible, "subnode1")
 	PROP_INT(test_tree1, prop_int, TEST_VALUE_1)
 
 	BEGIN_NODE("subsubnode")
+	PROP_STR(test_tree1, compatible, "subsubnode1\0subsubnode")
 	PROP_INT(test_tree1, prop_int, TEST_VALUE_1)
 	END_NODE
 	END_NODE
@@ -98,6 +101,7 @@ test_tree1_struct:
 	PROP_INT(test_tree1, prop_int, TEST_VALUE_2)
 
 	BEGIN_NODE("subsubnode@0")
+	PROP_STR(test_tree1, compatible, "subsubnode2\0subsubnode")
 	PROP_INT(test_tree1, prop_int, TEST_VALUE_2)
 	END_NODE
 	END_NODE
@@ -106,6 +110,7 @@ test_tree1_struct:
 	FDTLONG(FDT_END)
 
 test_tree1_strings:
+	STRING(test_tree1, compatible, "compatible")
 	STRING(test_tree1, prop_int, "prop-int")
 	STRING(test_tree1, prop_str, "prop-str")
 test_tree1_end:
Index: dtc/tests/Makefile.tests
===================================================================
--- dtc.orig/tests/Makefile.tests	2007-10-12 15:09:27.000000000 +1000
+++ dtc/tests/Makefile.tests	2007-10-12 15:10:39.000000000 +1000
@@ -2,6 +2,7 @@ LIB_TESTS_L = get_mem_rsv \
 	root_node find_property subnode_offset path_offset \
 	get_name getprop get_path supernode_atdepth_offset parent_offset \
 	node_offset_by_prop_value \
+	node_check_compatible node_offset_by_compatible \
 	notfound \
 	setprop_inplace nop_property nop_node \
 	sw_tree1 \
Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2007-10-12 15:10:13.000000000 +1000
+++ dtc/tests/run_tests.sh	2007-10-12 15:10:39.000000000 +1000
@@ -42,6 +42,8 @@ tree1_tests () {
     run_test supernode_atdepth_offset $TREE
     run_test parent_offset $TREE
     run_test node_offset_by_prop_value $TREE
+    run_test node_check_compatible $TREE
+    run_test node_offset_by_compatible $TREE
     run_test notfound $TREE
 
     # Write-in-place tests
Index: dtc/libfdt/libfdt.h
===================================================================
--- dtc.orig/libfdt/libfdt.h	2007-10-12 15:09:27.000000000 +1000
+++ dtc/libfdt/libfdt.h	2007-10-12 15:10:39.000000000 +1000
@@ -153,6 +153,11 @@ int fdt_node_offset_by_prop_value(const 
 				  const char *propname,
 				  const void *propval, int proplen);
 
+int fdt_node_check_compatible(const void *fdt, int nodeoffset,
+			      const char *compatible);
+int fdt_node_offset_by_compatible(const void *fdt, int startoffset,
+				  const char *compatible);
+
 /* Write-in-place functions */
 int fdt_setprop_inplace(void *fdt, int nodeoffset, const char *name,
 			const void *val, int len);
Index: dtc/tests/rw_tree1.c
===================================================================
--- dtc.orig/tests/rw_tree1.c	2007-10-12 15:09:27.000000000 +1000
+++ dtc/tests/rw_tree1.c	2007-10-12 15:10:39.000000000 +1000
@@ -72,18 +72,23 @@ int main(int argc, char *argv[])
 	CHECK(fdt_add_mem_rsv(fdt, TEST_ADDR_1, TEST_SIZE_1));
 	CHECK(fdt_add_mem_rsv(fdt, TEST_ADDR_2, TEST_SIZE_2));
 
+	CHECK(fdt_setprop_string(fdt, 0, "compatible", "test_tree1"));
 	CHECK(fdt_setprop_typed(fdt, 0, "prop-int", TEST_VALUE_1));
 	CHECK(fdt_setprop_string(fdt, 0, "prop-str", TEST_STRING_1));
 
 	OFF_CHECK(offset, fdt_add_subnode(fdt, 0, "subnode@1"));
+	CHECK(fdt_setprop_string(fdt, offset, "compatible", "subnode1"));
 	CHECK(fdt_setprop_typed(fdt, offset, "prop-int", TEST_VALUE_1));
 	OFF_CHECK(offset, fdt_add_subnode(fdt, offset, "subsubnode"));
+	CHECK(fdt_setprop(fdt, offset, "compatible",
+			  "subsubnode1\0subsubnode", 23));
 	CHECK(fdt_setprop_typed(fdt, offset, "prop-int", TEST_VALUE_1));
 
 	OFF_CHECK(offset, fdt_add_subnode(fdt, 0, "subnode@2"));
 	CHECK(fdt_setprop_typed(fdt, offset, "prop-int", TEST_VALUE_2));
 	OFF_CHECK(offset, fdt_add_subnode(fdt, offset, "subsubnode@0"));
-
+	CHECK(fdt_setprop(fdt, offset, "compatible",
+			  "subsubnode2\0subsubnode", 23));
 	CHECK(fdt_setprop_typed(fdt, offset, "prop-int", TEST_VALUE_2));
 
 	CHECK(fdt_pack(fdt));
Index: dtc/tests/sw_tree1.c
===================================================================
--- dtc.orig/tests/sw_tree1.c	2007-10-12 15:09:27.000000000 +1000
+++ dtc/tests/sw_tree1.c	2007-10-12 15:10:39.000000000 +1000
@@ -54,12 +54,17 @@ int main(int argc, char *argv[])
 	CHECK(fdt_finish_reservemap(fdt));
 
 	CHECK(fdt_begin_node(fdt, ""));
+	CHECK(fdt_property_string(fdt, "compatible", "test_tree1"));
 	CHECK(fdt_property_typed(fdt, "prop-int", TEST_VALUE_1));
 	CHECK(fdt_property_string(fdt, "prop-str", TEST_STRING_1));
 
 	CHECK(fdt_begin_node(fdt, "subnode@1"));
+	CHECK(fdt_property_string(fdt, "compatible", "subnode1"));
 	CHECK(fdt_property_typed(fdt, "prop-int", TEST_VALUE_1));
 	CHECK(fdt_begin_node(fdt, "subsubnode"));
+	CHECK(fdt_property(fdt, "compatible", "subsubnode1\0subsubnode",
+			   23));
+	CHECK(fdt_property_string(fdt, "compatible", "subsubnode1\0"));
 	CHECK(fdt_property_typed(fdt, "prop-int", TEST_VALUE_1));
 	CHECK(fdt_end_node(fdt));
 	CHECK(fdt_end_node(fdt));
@@ -67,6 +72,8 @@ int main(int argc, char *argv[])
 	CHECK(fdt_begin_node(fdt, "subnode@2"));
 	CHECK(fdt_property_typed(fdt, "prop-int", TEST_VALUE_2));
 	CHECK(fdt_begin_node(fdt, "subsubnode@0"));
+	CHECK(fdt_property(fdt, "compatible", "subsubnode2\0subsubnode",
+			   23));
 	CHECK(fdt_property_typed(fdt, "prop-int", TEST_VALUE_2));
 	CHECK(fdt_end_node(fdt));
 	CHECK(fdt_end_node(fdt));
Index: dtc/tests/test_tree1.dts
===================================================================
--- dtc.orig/tests/test_tree1.dts	2007-10-12 15:09:27.000000000 +1000
+++ dtc/tests/test_tree1.dts	2007-10-12 15:10:39.000000000 +1000
@@ -2,13 +2,16 @@
 /memreserve/ abcd1234 00001234;
 
 / {
+	compatible = "test_tree1";
 	prop-int = <deadbeef>;
 	prop-str = "hello world";
 
 	subnode@1 {
+		compatible = "subnode1";
 		prop-int = <deadbeef>;
 
 		subsubnode {
+			compatible = "subsubnode1", "subsubnode";
 			prop-int = <deadbeef>;
 		};
 	};
@@ -17,6 +20,7 @@
 		prop-int = <abcd1234>;
 
 		subsubnode@0 {
+			compatible = "subsubnode2", "subsubnode";
 			prop-int = <abcd1234>;
 		};
 	};
Index: dtc/tests/node_offset_by_compatible.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/node_offset_by_compatible.c	2007-10-12 15:22:40.000000000 +1000
@@ -0,0 +1,86 @@
+/*
+ * libfdt - Flat Device Tree manipulation
+ *	Testcase for fdt_node_offset_by_compatible()
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
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <stdint.h>
+#include <stdarg.h>
+
+#include <fdt.h>
+#include <libfdt.h>
+
+#include "tests.h"
+#include "testdata.h"
+
+void check_search(void *fdt, const char *compat, ...)
+{
+	va_list ap;
+	int offset = -1, target;
+
+	va_start(ap, compat);
+	do {
+		target = va_arg(ap, int);
+		verbose_printf("Searching (target = %d): %d ->",
+			       target, offset);
+		offset = fdt_node_offset_by_compatible(fdt, offset, compat);
+		verbose_printf("%d\n", offset);
+
+		if (offset != target)
+			FAIL("fdt_node_offset_by_compatible(%s) returns %d "
+			     "instead of %d", compat, offset, target);
+	} while (target >= 0);
+
+	va_end(ap);
+}
+
+int main(int argc, char *argv[])
+{
+	void *fdt;
+	int subnode1_offset, subnode2_offset;
+	int subsubnode1_offset, subsubnode2_offset;
+
+	test_init(argc, argv);
+	fdt = load_blob_arg(argc, argv);
+
+	subnode1_offset = fdt_path_offset(fdt, "/subnode@1");
+	subnode2_offset = fdt_path_offset(fdt, "/subnode@2");
+	subsubnode1_offset = fdt_path_offset(fdt, "/subnode@1/subsubnode");
+	subsubnode2_offset = fdt_path_offset(fdt, "/subnode@2/subsubnode@0");
+
+	if ((subnode1_offset < 0) || (subnode2_offset < 0)
+	    || (subsubnode1_offset < 0) || (subsubnode2_offset < 0))
+		FAIL("Can't find required nodes");
+
+	check_search(fdt, "test_tree1", 0, -FDT_ERR_NOTFOUND);
+	check_search(fdt, "subnode1", subnode1_offset, -FDT_ERR_NOTFOUND);
+	check_search(fdt, "subsubnode1", subsubnode1_offset, -FDT_ERR_NOTFOUND);
+	check_search(fdt, "subsubnode2", subsubnode2_offset, -FDT_ERR_NOTFOUND);
+	/* Eek.. HACK to make this work whatever the order in the
+	 * example tree */
+	if (subsubnode1_offset < subsubnode2_offset)
+		check_search(fdt, "subsubnode", subsubnode1_offset,
+			     subsubnode2_offset, -FDT_ERR_NOTFOUND);
+	else
+		check_search(fdt, "subsubnode", subsubnode2_offset,
+			     subsubnode1_offset, -FDT_ERR_NOTFOUND);
+	check_search(fdt, "nothing-like-this", -FDT_ERR_NOTFOUND);
+
+	PASS();
+}

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

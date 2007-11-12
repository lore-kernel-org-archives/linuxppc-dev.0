Return-Path: <dgibson@ozlabs.org>
Date: Tue, 13 Nov 2007 09:59:38 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: [1/2] libfdt: Add phandle related functions
Message-ID: <20071112225938.GG1219@localhost.localdomain>
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

This patch adds fdt_get_phandle() and fdt_node_offset_by_phandle()
functions to libfdt.  fdt_get_phandle() will retreive the phandle
value of a given node, and fdt_node_offset_by_phandle() will locate a
node given a phandle.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/libfdt/libfdt.h
===================================================================
--- dtc.orig/libfdt/libfdt.h	2007-11-12 19:11:55.000000000 +1100
+++ dtc/libfdt/libfdt.h	2007-11-12 20:11:12.000000000 +1100
@@ -78,29 +78,32 @@
 	/* FDT_ERR_BADPATH: Function was passed a badly formatted path
 	 * (e.g. missing a leading / for a function which requires an
 	 * absolute path) */
-#define FDT_ERR_BADSTATE	6
+#define FDT_ERR_BADPHANDLE	6
+	/* FDT_ERR_BADPHANDLE: Function was passed an invalid phandle
+	 * value.  phandle values of 0 and -1 are not permitted. */
+#define FDT_ERR_BADSTATE	7
 	/* FDT_ERR_BADSTATE: Function was passed an incomplete device
 	 * tree created by the sequential-write functions, which is
 	 * not sufficiently complete for the requested operation. */
 
 /* Error codes: codes for bad device tree blobs */
-#define FDT_ERR_TRUNCATED	7
+#define FDT_ERR_TRUNCATED	8
 	/* FDT_ERR_TRUNCATED: Structure block of the given device tree
 	 * ends without an FDT_END tag. */
-#define FDT_ERR_BADMAGIC	8
+#define FDT_ERR_BADMAGIC	9
 	/* FDT_ERR_BADMAGIC: Given "device tree" appears not to be a
 	 * device tree at all - it is missing the flattened device
 	 * tree magic number. */
-#define FDT_ERR_BADVERSION	9
+#define FDT_ERR_BADVERSION	10
 	/* FDT_ERR_BADVERSION: Given device tree has a version which
 	 * can't be handled by the requested operation.  For
 	 * read-write functions, this may mean that fdt_open_into() is
 	 * required to convert the tree to the expected version. */
-#define FDT_ERR_BADSTRUCTURE	10
+#define FDT_ERR_BADSTRUCTURE	11
 	/* FDT_ERR_BADSTRUCTURE: Given device tree has a corrupt
 	 * structure block or other serious error (e.g. misnested
 	 * nodes, or subnodes preceding properties). */
-#define FDT_ERR_BADLAYOUT	11
+#define FDT_ERR_BADLAYOUT	12
 	/* FDT_ERR_BADLAYOUT: For read-write functions, the given
 	 * device tree has it's sub-blocks in an order that the
 	 * function can't handle (memory reserve map, then structure,
@@ -108,12 +111,12 @@
 	 * into a form suitable for the read-write operations. */
 
 /* "Can't happen" error indicating a bug in libfdt */
-#define FDT_ERR_INTERNAL	12
+#define FDT_ERR_INTERNAL	13
 	/* FDT_ERR_INTERNAL: libfdt has failed an internal assertion.
 	 * Should never be returned, if it is, it indicates a bug in
 	 * libfdt itself. */
 
-#define FDT_ERR_MAX		12
+#define FDT_ERR_MAX		13
 
 /**********************************************************************/
 /* Low-level functions (you probably don't need these)                */
@@ -412,6 +415,20 @@
 }
 
 /**
+ * fdt_get_phandle - retreive the phandle of a given node
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: structure block offset of the node
+ *
+ * fdt_get_phandle() retrieves the phandle of the device tree node at
+ * structure block offset nodeoffset.
+ *
+ * returns:
+ *	the phandle of the node at nodeoffset, on succes (!= 0, != -1)
+ *	0, if the node has no phandle, or another error occurs
+ */
+uint32_t fdt_get_phandle(const void *fdt, int nodeoffset);
+
+/**
  * fdt_get_path - determine the full path of a node
  * @fdt: pointer to the device tree blob
  * @nodeoffset: offset of the node whose path to find
@@ -558,6 +575,27 @@
 				  const void *propval, int proplen);
 
 /**
+ * fdt_node_offset_by_phandle - find the node with a given phandle
+ * @fdt: pointer to the device tree blob
+ * @phandle: phandle value
+ *
+ * fdt_node_offset_by_prop_value() returns the offset of the node
+ * which has the given phandle value.  If there is more than one node
+ * in the tree with the given phandle (an invalid tree), results are
+ * undefined.
+ *
+ * returns:
+ *	structure block offset of the located node (>= 0), on success
+ *	-FDT_ERR_NOTFOUND, no node with that phandle exists
+ *	-FDT_ERR_BADPHANDLE, given phandle value was invalid (0 or -1)
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE, standard meanings
+ */
+int fdt_node_offset_by_phandle(const void *fdt, uint32_t phandle);
+
+/**
  * fdt_node_check_compatible: check a node's compatible property
  * @fdt: pointer to the device tree blob
  * @nodeoffset: offset of a tree node
Index: dtc/tests/testdata.h
===================================================================
--- dtc.orig/tests/testdata.h	2007-11-12 19:11:55.000000000 +1100
+++ dtc/tests/testdata.h	2007-11-12 19:52:35.000000000 +1100
@@ -23,6 +23,9 @@
 #define TEST_VALUE_1	cell_to_fdt(0xdeadbeef)
 #define TEST_VALUE_2	cell_to_fdt(123456789)
 
+#define PHANDLE_1	0x2000
+#define PHANDLE_2	0x2001
+
 #define TEST_STRING_1	"hello world"
 #define TEST_STRING_2	"nastystring: \a\b\t\n\v\f\r\\\""
 #define TEST_STRING_3	"\xde\xad\xbe\xef"
Index: dtc/tests/trees.S
===================================================================
--- dtc.orig/tests/trees.S	2007-11-12 19:11:55.000000000 +1100
+++ dtc/tests/trees.S	2007-11-12 19:52:49.000000000 +1100
@@ -100,9 +100,11 @@
 	END_NODE
 
 	BEGIN_NODE("subnode@2")
+	PROP_INT(test_tree1, phandle, cell_to_fdt(PHANDLE_1))
 	PROP_INT(test_tree1, prop_int, TEST_VALUE_2)
 
 	BEGIN_NODE("subsubnode@0")
+	PROP_INT(test_tree1, phandle, cell_to_fdt(PHANDLE_2))
 	PROP_STR(test_tree1, compatible, "subsubnode2\0subsubnode")
 	PROP_INT(test_tree1, prop_int, TEST_VALUE_2)
 	END_NODE
@@ -116,6 +118,7 @@
 	STRING(test_tree1, compatible, "compatible")
 	STRING(test_tree1, prop_int, "prop-int")
 	STRING(test_tree1, prop_str, "prop-str")
+	STRING(test_tree1, phandle, "linux,phandle")
 test_tree1_strings_end:
 test_tree1_end:
 
Index: dtc/tests/sw_tree1.c
===================================================================
--- dtc.orig/tests/sw_tree1.c	2007-11-12 19:11:55.000000000 +1100
+++ dtc/tests/sw_tree1.c	2007-11-12 19:56:39.000000000 +1100
@@ -69,8 +69,10 @@
 	CHECK(fdt_end_node(fdt));
 
 	CHECK(fdt_begin_node(fdt, "subnode@2"));
+	CHECK(fdt_property_typed(fdt, "linux,phandle", cpu_to_fdt32(PHANDLE_1)));
 	CHECK(fdt_property_typed(fdt, "prop-int", TEST_VALUE_2));
 	CHECK(fdt_begin_node(fdt, "subsubnode@0"));
+	CHECK(fdt_property_typed(fdt, "linux,phandle", cpu_to_fdt32(PHANDLE_2)));
 	CHECK(fdt_property(fdt, "compatible", "subsubnode2\0subsubnode",
 			   23));
 	CHECK(fdt_property_typed(fdt, "prop-int", TEST_VALUE_2));
Index: dtc/tests/test_tree1.dts
===================================================================
--- dtc.orig/tests/test_tree1.dts	2007-11-12 19:42:00.000000000 +1100
+++ dtc/tests/test_tree1.dts	2007-11-12 19:42:02.000000000 +1100
@@ -19,9 +19,11 @@
 	};
 
 	subnode@2 {
+		linux,phandle = <0x2000>;
 		prop-int = <123456789>;
 
 		subsubnode@0 {
+			linux,phandle = <0x2001>;
 			compatible = "subsubnode2", "subsubnode";
 			prop-int = <0726746425>;
 		};
Index: dtc/tests/Makefile.tests
===================================================================
--- dtc.orig/tests/Makefile.tests	2007-11-12 19:42:01.000000000 +1100
+++ dtc/tests/Makefile.tests	2007-11-13 09:34:30.000000000 +1100
@@ -1,7 +1,8 @@
 LIB_TESTS_L = get_mem_rsv \
 	root_node find_property subnode_offset path_offset \
-	get_name getprop get_path supernode_atdepth_offset parent_offset \
-	node_offset_by_prop_value \
+	get_name getprop get_phandle \
+	get_path supernode_atdepth_offset parent_offset \
+	node_offset_by_prop_value node_offset_by_phandle \
 	node_check_compatible node_offset_by_compatible \
 	notfound \
 	setprop_inplace nop_property nop_node \
Index: dtc/tests/get_phandle.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/get_phandle.c	2007-11-12 19:53:11.000000000 +1100
@@ -0,0 +1,58 @@
+/*
+ * libfdt - Flat Device Tree manipulation
+ *	Testcase for fdt_get_phandle()
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
+
+#include <fdt.h>
+#include <libfdt.h>
+
+#include "tests.h"
+#include "testdata.h"
+
+void check_phandle(void *fdt, const char *path, uint32_t checkhandle)
+{
+	int offset;
+	uint32_t phandle;
+
+	offset = fdt_path_offset(fdt, path);
+	if (offset < 0)
+		FAIL("Couldn't find %s", path);
+
+	phandle = fdt_get_phandle(fdt, offset);
+	if (phandle != checkhandle)
+		FAIL("fdt_get_phandle(%s) returned 0x%x instead of 0x%x\n",
+		     path, phandle, checkhandle);
+}
+
+int main(int argc, char *argv[])
+{
+	void *fdt;
+
+	test_init(argc, argv);
+	fdt = load_blob_arg(argc, argv);
+
+	check_phandle(fdt, "/", 0);
+	check_phandle(fdt, "/subnode@2", PHANDLE_1);
+	check_phandle(fdt, "/subnode@2/subsubnode@0", PHANDLE_2);
+
+	PASS();
+}
Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2007-11-12 19:42:00.000000000 +1100
+++ dtc/tests/run_tests.sh	2007-11-12 20:49:37.000000000 +1100
@@ -39,10 +39,12 @@
     run_test path_offset $TREE
     run_test get_name $TREE
     run_test getprop $TREE
+    run_test get_phandle $TREE
     run_test get_path $TREE
     run_test supernode_atdepth_offset $TREE
     run_test parent_offset $TREE
     run_test node_offset_by_prop_value $TREE
+    run_test node_offset_by_phandle $TREE
     run_test node_check_compatible $TREE
     run_test node_offset_by_compatible $TREE
     run_test notfound $TREE
@@ -131,12 +133,16 @@
     run_test dtc.sh -I dts -O dtb -o dtc_escapes.test.dtb escapes.dts
     run_test string_escapes dtc_escapes.test.dtb
 
+    run_test dtc.sh -I dts -O dtb -o dtc_references.test.dtb references.dts
+    run_test references dtc_references.test.dtb
+
     # Check -Odts mode preserve all dtb information
     for tree in test_tree1.dtb dtc_tree1.test.dtb dtc_escapes.test.dtb ; do
 	run_test dtc.sh -I dtb -O dts -o odts_$tree.test.dts $tree
 	run_test dtc.sh -I dts -O dtb -o odts_$tree.test.dtb odts_$tree.test.dts
 	run_test dtbs_equal_ordered $tree odts_$tree.test.dtb
     done
+
 }
 
 while getopts "vdt:" ARG ; do
Index: dtc/libfdt/fdt_ro.c
===================================================================
--- dtc.orig/libfdt/fdt_ro.c	2007-11-12 19:11:55.000000000 +1100
+++ dtc/libfdt/fdt_ro.c	2007-11-12 20:08:39.000000000 +1100
@@ -293,6 +293,18 @@
 	return prop->data;
 }
 
+uint32_t fdt_get_phandle(const void *fdt, int nodeoffset)
+{
+	const uint32_t *php;
+	int len;
+
+	php = fdt_getprop(fdt, nodeoffset, "linux,phandle", &len);
+	if (!php || (len != sizeof(*php)))
+		return 0;
+
+	return fdt32_to_cpu(*php);
+}
+
 int fdt_get_path(const void *fdt, int nodeoffset, char *buf, int buflen)
 {
 	uint32_t tag;
@@ -478,6 +490,15 @@
 	return -FDT_ERR_NOTFOUND;
 }
 
+int fdt_node_offset_by_phandle(const void *fdt, uint32_t phandle)
+{
+	if ((phandle == 0) || (phandle == -1))
+		return -FDT_ERR_BADPHANDLE;
+	phandle = cpu_to_fdt32(phandle);
+	return fdt_node_offset_by_prop_value(fdt, -1, "linux,phandle",
+					     &phandle, sizeof(phandle));
+}
+
 int _stringlist_contains(const void *strlist, int listlen, const char *str)
 {
 	int len = strlen(str);
Index: dtc/tests/rw_tree1.c
===================================================================
--- dtc.orig/tests/rw_tree1.c	2007-11-12 19:11:55.000000000 +1100
+++ dtc/tests/rw_tree1.c	2007-11-12 19:57:10.000000000 +1100
@@ -85,8 +85,12 @@
 	CHECK(fdt_setprop_typed(fdt, offset, "prop-int", TEST_VALUE_1));
 
 	OFF_CHECK(offset, fdt_add_subnode(fdt, 0, "subnode@2"));
+	CHECK(fdt_setprop_typed(fdt, offset, "linux,phandle",
+				cpu_to_fdt32(PHANDLE_1)));
 	CHECK(fdt_setprop_typed(fdt, offset, "prop-int", TEST_VALUE_2));
 	OFF_CHECK(offset, fdt_add_subnode(fdt, offset, "subsubnode@0"));
+	CHECK(fdt_setprop_typed(fdt, offset, "linux,phandle",
+				cpu_to_fdt32(PHANDLE_2)));
 	CHECK(fdt_setprop(fdt, offset, "compatible",
 			  "subsubnode2\0subsubnode", 23));
 	CHECK(fdt_setprop_typed(fdt, offset, "prop-int", TEST_VALUE_2));
Index: dtc/tests/test_tree1_dts0.dts
===================================================================
--- dtc.orig/tests/test_tree1_dts0.dts	2007-11-12 19:42:34.000000000 +1100
+++ dtc/tests/test_tree1_dts0.dts	2007-11-12 19:42:56.000000000 +1100
@@ -17,9 +17,11 @@
 	};
 
 	subnode@2 {
+		linux,phandle = <2000>;
 		prop-int = <d# 123456789>;
 
 		subsubnode@0 {
+			linux,phandle = <2001>;
 			compatible = "subsubnode2", "subsubnode";
 			prop-int = <o# 0726746425>;
 		};
Index: dtc/tests/node_offset_by_phandle.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/node_offset_by_phandle.c	2007-11-12 20:06:50.000000000 +1100
@@ -0,0 +1,64 @@
+/*
+ * libfdt - Flat Device Tree manipulation
+ *	Testcase for fdt_node_offset_by_phandle()
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
+void check_search(void *fdt, uint32_t phandle, int target)
+{
+	int offset;
+
+	offset = fdt_node_offset_by_phandle(fdt, phandle);
+
+	if (offset != target)
+		FAIL("fdt_node_offset_by_phandle(0x%x) returns %d "
+		     "instead of %d", phandle, offset, target);
+}
+
+int main(int argc, char *argv[])
+{
+	void *fdt;
+	int subnode2_offset, subsubnode2_offset;
+
+	test_init(argc, argv);
+	fdt = load_blob_arg(argc, argv);
+
+	subnode2_offset = fdt_path_offset(fdt, "/subnode@2");
+	subsubnode2_offset = fdt_path_offset(fdt, "/subnode@2/subsubnode@0");
+
+	if ((subnode2_offset < 0) || (subsubnode2_offset < 0))
+		FAIL("Can't find required nodes");
+
+	check_search(fdt, PHANDLE_1, subnode2_offset);
+	check_search(fdt, PHANDLE_2, subsubnode2_offset);
+	check_search(fdt, ~PHANDLE_1, -FDT_ERR_NOTFOUND);
+	check_search(fdt, 0, -FDT_ERR_BADPHANDLE);
+	check_search(fdt, -1, -FDT_ERR_BADPHANDLE);
+
+	PASS();
+}

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

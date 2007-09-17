Return-Path: <dgibson@ozlabs.org>
Date: Mon, 17 Sep 2007 14:28:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: libfdt:  Add fdt_node_offset_by_prop_value()
Message-ID: <20070917042834.GI32725@localhost.localdomain>
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

This patch adds a function to libfdt to locate nodes containing a
property with a specific value.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/libfdt/fdt_ro.c
===================================================================
--- dtc.orig/libfdt/fdt_ro.c	2007-09-17 14:00:22.000000000 +1000
+++ dtc/libfdt/fdt_ro.c	2007-09-17 14:04:18.000000000 +1000
@@ -407,3 +407,54 @@ int fdt_parent_offset(const void *fdt, i
 	return fdt_supernode_atdepth_offset(fdt, nodeoffset,
 					    nodedepth - 1, NULL);
 }
+
+int fdt_node_offset_by_prop_value(const void *fdt, int startoffset,
+				  const char *propname,
+				  const void *propval, int proplen)
+{
+	uint32_t tag;
+	int offset, nextoffset;
+	const void *val;
+	int len;
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
+	 * property of a node in fdt_getprop(), then if that didn't
+	 * find what we want, we scan over them again making our way
+	 * to the next node.  Still it's the easiest to implement
+	 * approach; performance can come later. */
+	do {
+		offset = nextoffset;
+		tag = _fdt_next_tag(fdt, offset, &nextoffset);
+
+		switch (tag) {
+		case FDT_BEGIN_NODE:
+			val = fdt_getprop(fdt, offset, propname, &len);
+			if (val
+			    && (len == proplen)
+			    && (memcmp(val, propval, len) == 0))
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
Index: dtc/libfdt/libfdt.h
===================================================================
--- dtc.orig/libfdt/libfdt.h	2007-09-17 14:00:04.000000000 +1000
+++ dtc/libfdt/libfdt.h	2007-09-17 14:00:23.000000000 +1000
@@ -146,6 +146,10 @@ int fdt_supernode_atdepth_offset(const v
 int fdt_node_depth(const void *fdt, int nodeoffset);
 int fdt_parent_offset(const void *fdt, int nodeoffset);
 
+int fdt_node_offset_by_prop_value(const void *fdt, int startoffset,
+				  const char *propname,
+				  const void *propval, int proplen);
+
 /* Write-in-place functions */
 int fdt_setprop_inplace(void *fdt, int nodeoffset, const char *name,
 			const void *val, int len);
Index: dtc/tests/Makefile.tests
===================================================================
--- dtc.orig/tests/Makefile.tests	2007-09-17 14:00:04.000000000 +1000
+++ dtc/tests/Makefile.tests	2007-09-17 14:00:23.000000000 +1000
@@ -1,5 +1,6 @@
 LIB_TESTS_L = root_node find_property subnode_offset path_offset \
 	get_name getprop get_path supernode_atdepth_offset parent_offset \
+	node_offset_by_prop_value \
 	notfound \
 	setprop_inplace nop_property nop_node \
 	sw_tree1 \
Index: dtc/tests/node_offset_by_prop_value.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/node_offset_by_prop_value.c	2007-09-17 14:00:23.000000000 +1000
@@ -0,0 +1,110 @@
+/*
+ * libfdt - Flat Device Tree manipulation
+ *	Testcase for fdt_path_offset()
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
+void vcheck_search(void *fdt, const char *propname, const void *propval,
+		  int proplen, va_list ap)
+{
+	int offset = -1, target;
+
+	do {
+		target = va_arg(ap, int);
+		verbose_printf("Searching (target = %d): %d ->",
+			       target, offset);
+		offset = fdt_node_offset_by_prop_value(fdt, offset, propname,
+						       propval, proplen);
+		verbose_printf("%d\n", offset);
+
+		if (offset != target)
+			FAIL("fdt_node_offset_by_prop_value() returns %d "
+			     "instead of %d", offset, target);
+	} while (target >= 0);
+}
+
+void check_search(void *fdt, const char *propname, const void *propval,
+		  int proplen, ...)
+{
+	va_list ap;
+
+	va_start(ap, proplen);
+	vcheck_search(fdt, propname, propval, proplen, ap);
+	va_end(ap);
+}
+
+void check_search_str(void *fdt, const char *propname, const char *propval, ...)
+{
+	va_list ap;
+
+	va_start(ap, propval);
+	vcheck_search(fdt, propname, propval, strlen(propval)+1, ap);
+	va_end(ap);
+}
+
+#define check_search_val(fdt, propname, propval, ...) \
+	{ \
+		typeof(propval) val = (propval); \
+		check_search((fdt), (propname), &val, sizeof(val), \
+			     ##__VA_ARGS__); \
+	}
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
+	subnode1_offset = fdt_path_offset(fdt, "/subnode1");
+	subnode2_offset = fdt_path_offset(fdt, "/subnode2");
+	subsubnode1_offset = fdt_path_offset(fdt, "/subnode1/subsubnode");
+	subsubnode2_offset = fdt_path_offset(fdt, "/subnode2/subsubnode");
+
+	if ((subnode1_offset < 0) || (subnode2_offset < 0)
+	    || (subsubnode1_offset < 0) || (subsubnode2_offset < 0))
+		FAIL("Can't find required nodes");
+
+	check_search_val(fdt, "prop-int", TEST_VALUE_1, 0, subnode1_offset,
+			 subsubnode1_offset, -FDT_ERR_NOTFOUND);
+
+	check_search_val(fdt, "prop-int", TEST_VALUE_2, subnode2_offset,
+			 subsubnode2_offset, -FDT_ERR_NOTFOUND);
+
+	check_search_str(fdt, "prop-str", TEST_STRING_1, 0, -FDT_ERR_NOTFOUND);
+
+	check_search_str(fdt, "prop-str", "no such string", -FDT_ERR_NOTFOUND);
+
+	check_search_val(fdt, "prop-int", TEST_VALUE_1+1, -FDT_ERR_NOTFOUND);
+
+	check_search(fdt, "no-such-prop", NULL, 0, -FDT_ERR_NOTFOUND);
+
+	PASS();
+}
Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2007-09-17 14:00:04.000000000 +1000
+++ dtc/tests/run_tests.sh	2007-09-17 14:00:23.000000000 +1000
@@ -40,6 +40,7 @@ tree1_tests () {
     run_test get_path $TREE
     run_test supernode_atdepth_offset $TREE
     run_test parent_offset $TREE
+    run_test node_offset_by_prop_value $TREE
     run_test notfound $TREE
 
     # Write-in-place tests

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

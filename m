Return-Path: <dgibson@ozlabs.org>
To: Jon Loeliger <jdl@freescale.com>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 3/3] libfdt: Add fdt_parent_offset() and supporting functions
In-Reply-To: <20070830045253.GA32543@localhost.localdomain>
Message-Id: <20070830045404.28064DDE32@ozlabs.org>
Date: Thu, 30 Aug 2007 14:54:04 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds an fdt_parent_offset() function which returns an
offset to the parent node of a given node.  It also adds two helper
functions which are used to implement fdt_parent_offset() but are also
exported: fdt_supernode_atdepth_offset() which returns the ancestor of
a given node at a specified depth from the root of the tree, and
fdt_node_depth() which returns the depth of a given node.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---
 libfdt/fdt_ro.c                  |   68 ++++++++++++++++++
 libfdt/libfdt.h                  |   10 ++
 tests/Makefile.tests             |    2 
 tests/parent_offset.c            |   90 ++++++++++++++++++++++++
 tests/run_tests.sh               |    2 
 tests/supernode_atdepth_offset.c |  144 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 314 insertions(+), 2 deletions(-)

Index: dtc/libfdt/fdt_ro.c
===================================================================
--- dtc.orig/libfdt/fdt_ro.c	2007-08-29 14:28:32.000000000 +1000
+++ dtc/libfdt/fdt_ro.c	2007-08-30 14:28:35.000000000 +1000
@@ -349,3 +349,71 @@ int fdt_get_path(const void *fdt, int no
 	buf[p] = '\0';
 	return p;
 }
+
+int fdt_supernode_atdepth_offset(const void *fdt, int nodeoffset,
+				 int supernodedepth, int *nodedepth)
+{
+	int level = -1;
+	uint32_t tag;
+	int offset, nextoffset = 0;
+	int supernodeoffset = -FDT_ERR_INTERNAL;
+
+	CHECK_HEADER(fdt);
+
+	if (supernodedepth < 0)
+		return -FDT_ERR_NOTFOUND;
+
+	do {
+		offset = nextoffset;
+		tag = _fdt_next_tag(fdt, offset, &nextoffset);
+		switch (tag) {
+		case FDT_END:
+			return -FDT_ERR_BADOFFSET;
+
+		case FDT_BEGIN_NODE:
+			level++;
+			if (level == supernodedepth)
+				supernodeoffset = offset;
+			break;
+
+		case FDT_END_NODE:
+			level--;
+			break;
+
+		case FDT_PROP:
+		case FDT_NOP:
+			break;
+
+		default:
+			return -FDT_ERR_BADSTRUCTURE;
+		}
+	} while (offset < nodeoffset);
+
+	if (nodedepth)
+		*nodedepth = level;
+
+	if (supernodedepth > level)
+		return -FDT_ERR_NOTFOUND;
+	return supernodeoffset;
+}
+
+int fdt_node_depth(const void *fdt, int nodeoffset)
+{
+	int nodedepth;
+	int err;
+
+	err = fdt_supernode_atdepth_offset(fdt, nodeoffset, 0, &nodedepth);
+	if (err)
+		return (err < 0) ? err : -FDT_ERR_INTERNAL;
+	return nodedepth;
+}
+
+int fdt_parent_offset(const void *fdt, int nodeoffset)
+{
+	int nodedepth = fdt_node_depth(fdt, nodeoffset);
+
+	if (nodedepth < 0)
+		return nodedepth;
+	return fdt_supernode_atdepth_offset(fdt, nodeoffset,
+					    nodedepth - 1, NULL);
+}
Index: dtc/libfdt/libfdt.h
===================================================================
--- dtc.orig/libfdt/libfdt.h	2007-08-30 13:26:56.000000000 +1000
+++ dtc/libfdt/libfdt.h	2007-08-30 14:26:40.000000000 +1000
@@ -74,7 +74,10 @@
 #define FDT_ERR_BADSTRUCTURE	10
 #define FDT_ERR_BADLAYOUT	11
 
-#define FDT_ERR_MAX		11
+/* "Can't happen" error indicating a bug in libfdt */
+#define FDT_ERR_INTERNAL	12
+
+#define FDT_ERR_MAX		12
 
 #define fdt_get_header(fdt, field) \
 	(fdt32_to_cpu(((const struct fdt_header *)(fdt))->field))
@@ -138,6 +141,11 @@ static inline void *fdt_getprop_w(void *
 
 int fdt_get_path(const void *fdt, int nodeoffset, char *buf, int buflen);
 
+int fdt_supernode_atdepth_offset(const void *fdt, int nodeoffset,
+				 int supernodedepth, int *nodedepth);
+int fdt_node_depth(const void *fdt, int nodeoffset);
+int fdt_parent_offset(const void *fdt, int nodeoffset);
+
 /* Write-in-place functions */
 int fdt_setprop_inplace(void *fdt, int nodeoffset, const char *name,
 			const void *val, int len);
Index: dtc/tests/Makefile.tests
===================================================================
--- dtc.orig/tests/Makefile.tests	2007-08-30 13:43:53.000000000 +1000
+++ dtc/tests/Makefile.tests	2007-08-30 14:17:07.000000000 +1000
@@ -1,5 +1,5 @@
 LIB_TESTS_L = root_node find_property subnode_offset path_offset \
-	get_name getprop get_path \
+	get_name getprop get_path supernode_atdepth_offset parent_offset \
 	notfound \
 	setprop_inplace nop_property nop_node \
 	sw_tree1 \
Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2007-08-30 13:44:15.000000000 +1000
+++ dtc/tests/run_tests.sh	2007-08-30 14:17:14.000000000 +1000
@@ -38,6 +38,8 @@ tree1_tests () {
     run_test get_name $TREE
     run_test getprop $TREE
     run_test get_path $TREE
+    run_test supernode_atdepth_offset $TREE
+    run_test parent_offset $TREE
     run_test notfound $TREE
 
     # Write-in-place tests
Index: dtc/tests/supernode_atdepth_offset.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/supernode_atdepth_offset.c	2007-08-30 13:51:45.000000000 +1000
@@ -0,0 +1,144 @@
+/*
+ * libfdt - Flat Device Tree manipulation
+ *	Testcase for fdt_supernode_atdepth_offset()
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
+#define _GNU_SOURCE
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
+int path_depth(const char *path)
+{
+	const char *p;
+	int depth = 0;
+
+	if (path[0] != '/')
+		TEST_BUG();
+
+	if (strcmp(path, "/") == 0)
+		return 0;
+	for (p = path; *p; p++)
+		if (*p == '/')
+			depth++;
+
+	/* Special case for path == "/" */
+	if (p == (path + 1))
+		return 0;
+	else
+		return depth;
+}
+
+int path_prefix(const char *path, int depth)
+{
+	const char *p;
+	int i;
+
+	if (path[0] != '/')
+		TEST_BUG();
+
+	if (depth == 0)
+		return 1;
+
+	p = path;
+	for (i = 0; i < depth; i++)
+		p = strchrnul(p+1, '/');
+
+	return p - path;
+}
+
+void check_supernode_atdepth(struct fdt_header *fdt, const char *path,
+			     int depth)
+{
+	int pdepth = path_depth(path);
+	char *superpath;
+	int nodeoffset, supernodeoffset, superpathoffset;
+	int nodedepth;
+
+	superpath = strndupa(path, path_prefix(path, depth));
+	verbose_printf("Path %s (%d), depth %d, supernode is %s\n",
+		       path, pdepth, depth, superpath);
+
+	nodeoffset = fdt_path_offset(fdt, path);
+	if (nodeoffset < 0)
+		FAIL("fdt_path_offset(%s): %s", path, fdt_strerror(nodeoffset));
+	superpathoffset = fdt_path_offset(fdt, superpath);
+	if (superpathoffset < 0)
+		FAIL("fdt_path_offset(%s): %s", superpath,
+		     fdt_strerror(superpathoffset));
+
+	supernodeoffset = fdt_supernode_atdepth_offset(fdt, nodeoffset,
+						       depth, &nodedepth);
+	if (supernodeoffset < 0)
+		FAIL("fdt_supernode_atdepth_offset(): %s",
+		     fdt_strerror(supernodeoffset));
+
+	if (supernodeoffset != superpathoffset)
+		FAIL("fdt_supernode_atdepth_offset() returns %d instead of %d",
+		     supernodeoffset, superpathoffset);
+
+	if (nodedepth != pdepth)
+		FAIL("fdt_supernode_atdept_offset() returns node depth %d "
+		     "instead of %d", nodedepth, pdepth);
+}
+
+void check_supernode_overdepth(struct fdt_header *fdt, const char *path)
+{
+	int pdepth = path_depth(path);
+	int nodeoffset, err;
+
+	nodeoffset = fdt_path_offset(fdt, path);
+	if (nodeoffset < 0)
+		FAIL("fdt_path_offset(%s): %s", path, fdt_strerror(nodeoffset));
+
+	err = fdt_supernode_atdepth_offset(fdt, nodeoffset, pdepth + 1, NULL);
+	if (err != -FDT_ERR_NOTFOUND)
+		FAIL("fdt_supernode_atdept_offset(%s, %d) returns %d instead "
+		     "of FDT_ERR_NOTFOUND", path, pdepth+1, err);
+}
+
+void check_path(struct fdt_header *fdt, const char *path)
+{
+	int i;
+
+	for (i = 0; i <= path_depth(path); i++)
+		check_supernode_atdepth(fdt, path, i);
+	check_supernode_overdepth(fdt, path);
+}
+int main(int argc, char *argv[])
+{
+	void *fdt;
+
+	test_init(argc, argv);
+	fdt = load_blob_arg(argc, argv);
+
+	check_path(fdt, "/");
+	check_path(fdt, "/subnode1");
+	check_path(fdt, "/subnode2");
+	check_path(fdt, "/subnode1/subsubnode");
+	check_path(fdt, "/subnode2/subsubnode");
+
+	PASS();
+}
Index: dtc/tests/parent_offset.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/parent_offset.c	2007-08-30 14:21:10.000000000 +1000
@@ -0,0 +1,90 @@
+/*
+ * libfdt - Flat Device Tree manipulation
+ *	Testcase for fdt_parent_offset()
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
+#define _GNU_SOURCE
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
+int path_parent_len(const char *path)
+{
+	const char *p = strrchr(path, '/');
+
+	if (!p)
+		TEST_BUG();
+	if (p == path)
+		return 1;
+	else
+		return p - path;
+}
+
+void check_path(struct fdt_header *fdt, const char *path)
+{
+	char *parentpath;
+	int nodeoffset, parentoffset, parentpathoffset;
+
+	parentpath = strndupa(path, path_parent_len(path));
+
+	verbose_printf("Path: \"%s\"\tParent: \"%s\"\n", path, parentpath);
+
+	nodeoffset = fdt_path_offset(fdt, path);
+	if (nodeoffset < 0)
+		FAIL("fdt_path_offset(%s): %s", path, fdt_strerror(nodeoffset));
+
+	parentpathoffset = fdt_path_offset(fdt, parentpath);
+	if (parentpathoffset < 0)
+		FAIL("fdt_path_offset(%s): %s", parentpath,
+		     fdt_strerror(parentpathoffset));
+
+	parentoffset = fdt_parent_offset(fdt, nodeoffset);
+	if (parentoffset < 0)
+		FAIL("fdt_parent_offset(): %s", fdt_strerror(parentoffset));
+
+	if (parentoffset != parentpathoffset)
+		FAIL("fdt_parent_offset() returns %d instead of %d",
+		     parentoffset, parentpathoffset);
+}
+
+int main(int argc, char *argv[])
+{
+	void *fdt;
+	int err;
+
+	test_init(argc, argv);
+	fdt = load_blob_arg(argc, argv);
+
+	check_path(fdt, "/subnode1");
+	check_path(fdt, "/subnode2");
+	check_path(fdt, "/subnode1/subsubnode");
+	check_path(fdt, "/subnode2/subsubnode");
+	err = fdt_parent_offset(fdt, 0);
+	if (err != -FDT_ERR_NOTFOUND)
+		FAIL("fdt_parent_offset(/) returns %d instead of "
+		     "-FDT_ERR_NOTFOUND", err);
+
+	PASS();
+}

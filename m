Return-Path: <dgibson@ozlabs.org>
To: Jon Loeliger <jdl@freescale.com>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 1/3] libfdt: Add fdt_get_name() to retrieve a node's name
In-Reply-To: <20070830045253.GA32543@localhost.localdomain>
Message-Id: <20070830045404.0743FDDE2E@ozlabs.org>
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

This patch adds a new fdt_get_name() function to libfdt which will
return a node's name string (including unit address, if any).

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---
 libfdt/fdt_ro.c      |   24 ++++++++++++++
 libfdt/libfdt.h      |    2 +
 tests/Makefile.tests |    3 +
 tests/get_name.c     |   83 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/run_tests.sh   |    1 
 5 files changed, 112 insertions(+), 1 deletion(-)

Index: dtc/libfdt/fdt_ro.c
===================================================================
--- dtc.orig/libfdt/fdt_ro.c	2007-08-29 13:14:06.000000000 +1000
+++ dtc/libfdt/fdt_ro.c	2007-08-29 14:09:29.000000000 +1000
@@ -169,6 +169,30 @@
 	return offset;	
 }
 
+const char *fdt_get_name(const void *fdt, int nodeoffset, int *len)
+{
+	const struct fdt_node_header *nh;
+	int err;
+
+	if ((err = _fdt_check_header(fdt)) != 0)
+		goto fail;
+
+	err = -FDT_ERR_BADOFFSET;
+	nh = fdt_offset_ptr(fdt, nodeoffset, sizeof(*nh));
+	if (!nh || (fdt32_to_cpu(nh->tag) != FDT_BEGIN_NODE))
+		goto fail;
+
+	if (len)
+		*len = strlen(nh->name);
+
+	return nh->name;
+
+ fail:
+	if (len)
+		*len = err;
+	return NULL;
+}
+
 const struct fdt_property *fdt_get_property(const void *fdt,
 					    int nodeoffset,
 					    const char *name, int *lenp)
Index: dtc/libfdt/libfdt.h
===================================================================
--- dtc.orig/libfdt/libfdt.h	2007-08-29 13:14:06.000000000 +1000
+++ dtc/libfdt/libfdt.h	2007-08-29 14:09:29.000000000 +1000
@@ -115,6 +115,8 @@
 
 int fdt_path_offset(const void *fdt, const char *path);
 
+const char *fdt_get_name(const void *fdt, int nodeoffset, int *baselen);
+
 const struct fdt_property *fdt_get_property(const void *fdt, int nodeoffset,
 					    const char *name, int *lenp);
 
Index: dtc/tests/Makefile.tests
===================================================================
--- dtc.orig/tests/Makefile.tests	2007-08-29 13:14:06.000000000 +1000
+++ dtc/tests/Makefile.tests	2007-08-29 14:09:29.000000000 +1000
@@ -1,4 +1,5 @@
-LIB_TESTS_L = root_node find_property subnode_offset path_offset getprop \
+LIB_TESTS_L = root_node find_property subnode_offset path_offset \
+	get_name getprop \
 	notfound \
 	setprop_inplace nop_property nop_node \
 	sw_tree1 \
Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2007-08-29 13:14:06.000000000 +1000
+++ dtc/tests/run_tests.sh	2007-08-29 14:09:29.000000000 +1000
@@ -35,6 +35,7 @@
     run_test find_property $TREE
     run_test subnode_offset $TREE
     run_test path_offset $TREE
+    run_test get_name $TREE
     run_test getprop $TREE
     run_test notfound $TREE
 
Index: dtc/tests/get_name.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/get_name.c	2007-08-29 13:14:50.000000000 +1000
@@ -0,0 +1,83 @@
+/*
+ * libfdt - Flat Device Tree manipulation
+ *	Testcase for fdt_get_name()
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
+void check_name(void *fdt, const char *path)
+{
+	int offset;
+	const char *getname, *getname2, *checkname;
+	int len;
+
+	checkname = strrchr(path, '/');
+	if (!checkname)
+		TEST_BUG();
+	checkname += 1;
+
+	offset = fdt_path_offset(fdt, path);
+	if (offset < 0)
+		FAIL("Couldn't find %s", path);
+
+	getname = fdt_get_name(fdt, offset, &len);
+	verbose_printf("fdt_get_name(%d) returns \"%s\" (len=%d)\n",
+		       offset, getname, len);
+	if (!getname)
+		FAIL("fdt_get_name(%d): %s", offset, fdt_strerror(len));
+
+	if (strcmp(getname, checkname) != 0)
+		FAIL("fdt_get_name(%s) returned \"%s\" instead of \"%s\"",
+		     path, getname, checkname);
+
+	if (len != strlen(getname))
+		FAIL("fdt_get_name(%s) returned length %d instead of %d",
+		     path, len, strlen(getname));
+
+	/* Now check that it doesn't break if we omit len */
+	getname2 = fdt_get_name(fdt, offset, NULL);
+	if (!getname2)
+		FAIL("fdt_get_name(%d, NULL) failed", offset);
+	if (strcmp(getname2, getname) != 0)
+		FAIL("fdt_get_name(%d, NULL) returned \"%s\" instead of \"%s\"",
+		     offset, getname2, getname);
+}
+
+int main(int argc, char *argv[])
+{
+	void *fdt;
+
+	test_init(argc, argv);
+	fdt = load_blob_arg(argc, argv);
+
+	check_name(fdt, "/");
+	check_name(fdt, "/subnode1");
+	check_name(fdt, "/subnode2");
+	check_name(fdt, "/subnode1/subsubnode");
+	check_name(fdt, "/subnode2/subsubnode");
+
+	PASS();
+}

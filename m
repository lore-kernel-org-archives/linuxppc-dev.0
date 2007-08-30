Return-Path: <dgibson@ozlabs.org>
To: Jon Loeliger <jdl@freescale.com>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 2/3] libfdt: Add fdt_get_path() function
In-Reply-To: <20070830045253.GA32543@localhost.localdomain>
Message-Id: <20070830045404.0C428DDE2F@ozlabs.org>
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

This patch adds an fdt_get_path() function to libfdt, which returns
the full path of a given node in a caller supplied buffer.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---
 libfdt/fdt_ro.c      |   66 ++++++++++++++++++++++++++++++++++++
 libfdt/libfdt.h      |    2 +
 tests/Makefile.tests |    2 -
 tests/get_path.c     |   91 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/run_tests.sh   |    1 
 5 files changed, 161 insertions(+), 1 deletion(-)

Index: dtc/libfdt/fdt_ro.c
===================================================================
--- dtc.orig/libfdt/fdt_ro.c	2007-08-29 14:09:52.000000000 +1000
+++ dtc/libfdt/fdt_ro.c	2007-08-29 14:28:32.000000000 +1000
@@ -283,3 +283,69 @@
 
 	return prop->data;
 }
+
+int fdt_get_path(const void *fdt, int nodeoffset, char *buf, int buflen)
+{
+	uint32_t tag;
+	int p = 0, overflow = 0;
+	int offset, nextoffset, namelen;
+	const char *name;
+
+	CHECK_HEADER(fdt);
+
+	tag = _fdt_next_tag(fdt, 0, &nextoffset);
+	if (tag != FDT_BEGIN_NODE)
+		return -FDT_ERR_BADSTRUCTURE;
+
+	if (buflen < 2)
+		return -FDT_ERR_NOSPACE;
+	buf[0] = '/';
+	p = 1;
+
+	while (offset < nodeoffset) {
+		offset = nextoffset;
+		tag = _fdt_next_tag(fdt, offset, &nextoffset);
+		switch (tag) {
+		case FDT_END:
+			return -FDT_ERR_BADOFFSET;
+
+		case FDT_BEGIN_NODE:
+			name = fdt_get_name(fdt, offset, &namelen);
+			if (!name)
+				return namelen;
+			if (overflow || ((p + namelen + 1) > buflen)) {
+				overflow++;
+				break;
+			}
+			memcpy(buf + p, name, namelen);
+			p += namelen;
+			buf[p++] = '/';
+			break;
+
+		case FDT_END_NODE:
+			if (overflow) {
+				overflow--;
+				break;
+			}
+			do {
+				p--;
+			} while  (buf[p-1] != '/');
+			break;
+
+		case FDT_PROP:
+		case FDT_NOP:
+			break;
+
+		default:
+			return -FDT_ERR_BADSTRUCTURE;
+		}
+	}
+
+	if (overflow)
+		return -FDT_ERR_NOSPACE;
+
+	if (p > 1) /* special case so that root path is "/", not "" */
+		p--;
+	buf[p] = '\0';
+	return p;
+}
Index: dtc/tests/get_path.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/get_path.c	2007-08-29 14:09:53.000000000 +1000
@@ -0,0 +1,91 @@
+/*
+ * libfdt - Flat Device Tree manipulation
+ *	Testcase for fdt_get_path()
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
+#define POISON	('\xff')
+
+void check_path_buf(void *fdt, const char *path, int pathlen, int buflen)
+{
+	int offset;
+	char buf[buflen+1];
+	int len;
+
+	offset = fdt_path_offset(fdt, path);
+	if (offset < 0)
+		FAIL("Couldn't find path \"%s\": %s", path, fdt_strerror(offset));
+
+	memset(buf, POISON, sizeof(buf)); /* poison the buffer */
+
+	len = fdt_get_path(fdt, offset, buf, buflen);
+	if (buflen <= pathlen) {
+		if (len != -FDT_ERR_NOSPACE)
+			FAIL("fdt_get_path([%d bytes]) returns %d with "
+			     "insufficient buffer space", buflen, len);
+	} else {
+		if (len < 0)
+			FAIL("fdt_get_path([%d bytes]): %s", buflen,
+			     fdt_strerror(len));
+		if (len != pathlen)
+			FAIL("fdt_get_path([%d bytes]) reports length %d "
+			     "instead of %d", buflen, len, pathlen);
+		if (strcmp(buf, path) != 0)
+			FAIL("fdt_get_path([%d bytes]) returns \"%s\" "
+			     "instead of \"%s\"", buflen, buf, path);
+	}
+
+	if (buf[buflen] != POISON)
+		FAIL("fdt_get_path([%d bytes]) overran buffer", buflen);
+}
+
+void check_path(void *fdt, const char *path)
+{
+	int pathlen = strlen(path);
+
+	check_path_buf(fdt, path, pathlen, 1024);
+	check_path_buf(fdt, path, pathlen, pathlen+1);
+	check_path_buf(fdt, path, pathlen, pathlen);
+}
+
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
Index: dtc/tests/Makefile.tests
===================================================================
--- dtc.orig/tests/Makefile.tests	2007-08-29 14:09:52.000000000 +1000
+++ dtc/tests/Makefile.tests	2007-08-29 14:09:53.000000000 +1000
@@ -1,5 +1,5 @@
 LIB_TESTS_L = root_node find_property subnode_offset path_offset \
-	get_name getprop \
+	get_name getprop get_path \
 	notfound \
 	setprop_inplace nop_property nop_node \
 	sw_tree1 \
Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2007-08-29 14:09:52.000000000 +1000
+++ dtc/tests/run_tests.sh	2007-08-29 14:09:53.000000000 +1000
@@ -37,6 +37,7 @@
     run_test path_offset $TREE
     run_test get_name $TREE
     run_test getprop $TREE
+    run_test get_path $TREE
     run_test notfound $TREE
 
     # Write-in-place tests
Index: dtc/libfdt/libfdt.h
===================================================================
--- dtc.orig/libfdt/libfdt.h	2007-08-29 14:09:52.000000000 +1000
+++ dtc/libfdt/libfdt.h	2007-08-29 14:10:28.000000000 +1000
@@ -136,6 +136,8 @@
 	return (void *)fdt_getprop(fdt, nodeoffset, name, lenp);
 }
 
+int fdt_get_path(const void *fdt, int nodeoffset, char *buf, int buflen);
+
 /* Write-in-place functions */
 int fdt_setprop_inplace(void *fdt, int nodeoffset, const char *name,
 			const void *val, int len);

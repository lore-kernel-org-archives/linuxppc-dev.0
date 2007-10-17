Return-Path: <dgibson@ozlabs.org>
Date: Wed, 17 Oct 2007 11:23:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Restore missing code for testcases
Message-ID: <20071017012357.GE28260@localhost.localdomain>
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

Recent commits 333542fabf8720b881e992a5abca32ef4bcb841a and
fd1bf3a5ae46962528ef89a824261a88830758a2 added new testcases to dtc.
However, although the testcases were added to the Makefile and
run_tests.sh, one of the .c files for the testcase was omitted from
the patch in each case.

This patch restores the missing testcase code.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---

Oops, I suck.  Screwed up my quilting, somehow.  jdl, you should
really run a "make check" before committing my patches...

Index: dtc/tests/get_mem_rsv.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/get_mem_rsv.c	2007-10-17 11:19:06.000000000 +1000
@@ -0,0 +1,49 @@
+/*
+ * libfdt - Flat Device Tree manipulation
+ *	Testcase for fdt_get_mem_rsv() and fdt_num_mem_rsv()
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
+	int rc;
+
+	test_init(argc, argv);
+	fdt = load_blob_arg(argc, argv);
+
+	rc = fdt_num_mem_rsv(fdt);
+	if (rc < 0)
+		FAIL("fdt_num_mem_rsv(): %s", fdt_strerror(rc));
+	if (rc != 2)
+		FAIL("fdt_num_mem_rsv() returned %d instead of 2", rc);
+
+	check_mem_rsv(fdt, 0, TEST_ADDR_1, TEST_SIZE_1);
+	check_mem_rsv(fdt, 1, TEST_ADDR_2, TEST_SIZE_2);
+	PASS();
+}
Index: dtc/tests/node_check_compatible.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/node_check_compatible.c	2007-10-17 11:19:32.000000000 +1000
@@ -0,0 +1,62 @@
+/*
+ * libfdt - Flat Device Tree manipulation
+ *	Testcase for fdt_node_check_compatible()
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
+#include <stdint.h>
+
+#include <fdt.h>
+#include <libfdt.h>
+
+#include "tests.h"
+#include "testdata.h"
+
+void check_compatible(const void *fdt, const char *path, const char *compat)
+{
+	int offset, err;
+
+	offset = fdt_path_offset(fdt, path);
+	if (offset < 0)
+		FAIL("fdt_path_offset(%s): %s", path, fdt_strerror(offset));
+
+	err = fdt_node_check_compatible(fdt, offset, compat);
+	if (err < 0)
+		FAIL("fdt_node_check_compatible(%s): %s", path,
+		     fdt_strerror(err));
+	if (err != 0)
+		FAIL("%s is not compatible with \"%s\"", path, compat);
+}
+
+int main(int argc, char *argv[])
+{
+	void *fdt;
+
+	test_init(argc, argv);
+	fdt = load_blob_arg(argc, argv);
+
+	check_compatible(fdt, "/", "test_tree1");
+	check_compatible(fdt, "/subnode@1/subsubnode", "subsubnode1");
+	check_compatible(fdt, "/subnode@1/subsubnode", "subsubnode");
+	check_compatible(fdt, "/subnode@2/subsubnode", "subsubnode2");
+	check_compatible(fdt, "/subnode@2/subsubnode", "subsubnode");
+
+	PASS();
+}

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

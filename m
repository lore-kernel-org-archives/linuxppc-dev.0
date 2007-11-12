Return-Path: <dgibson@ozlabs.org>
Date: Tue, 13 Nov 2007 10:02:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: [2/2] dtc: Add testcase for dtc references
Message-ID: <20071112230229.GH1219@localhost.localdomain>
References: <20071112225938.GG1219@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071112225938.GG1219@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds a testcase for dtc's reference-to-phandle
functionality.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/tests/references.dts
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/references.dts	2007-11-12 20:47:05.000000000 +1100
@@ -0,0 +1,23 @@
+/dts-v1/;
+
+/ {
+  	/* Explicit phandles */
+	n1: node1 {
+		linux,phandle = <0x2000>;
+		ref = <&/node2>; /* reference precedes target */
+		lref = <&n2>;
+	};
+	n2: node2 {
+	      	linux,phandle = <0x1>;
+		ref = <&/node1>; /* reference after target */
+		lref = <&n1>;
+	};
+
+	/* Implicit phandles */
+	n3: node3 {
+	    	ref = <&/node4>;
+		lref = <&n4>;
+	};
+	n4: node4 {
+	};
+};
Index: dtc/tests/Makefile.tests
===================================================================
--- dtc.orig/tests/Makefile.tests	2007-11-12 20:49:56.000000000 +1100
+++ dtc/tests/Makefile.tests	2007-11-12 20:50:01.000000000 +1100
@@ -9,7 +9,8 @@
 	sw_tree1 \
 	move_and_save mangle-layout \
 	open_pack rw_tree1 setprop del_property del_node \
-	string_escapes dtbs_equal_ordered
+	string_escapes references \
+	dtbs_equal_ordered
 LIB_TESTS = $(LIB_TESTS_L:%=$(TESTS_PREFIX)%)
 
 LIBTREE_TESTS_L = truncated_property
Index: dtc/tests/references.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/references.c	2007-11-12 21:23:33.000000000 +1100
@@ -0,0 +1,100 @@
+/*
+ * libfdt - Flat Device Tree manipulation
+ *	Testcase for phandle references in dtc
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
+void check_ref(const void *fdt, int node, uint32_t checkref)
+{
+	const uint32_t *p;
+	uint32_t ref;
+	int len;
+
+	p = fdt_getprop(fdt, node, "ref", &len);
+	if (!p)
+		FAIL("fdt_getprop(%d, \"ref\"): %s", node, fdt_strerror(len));
+	if (len != sizeof(*p))
+		FAIL("'ref' in node at %d has wrong size (%d instead of %d)",
+		     node, len, sizeof(*p));
+	ref = fdt32_to_cpu(*p);
+	if (ref != checkref)
+		FAIL("'ref' in node at %d has value 0x%x instead of 0x%x",
+		     node, ref, checkref);
+
+	p = fdt_getprop(fdt, node, "lref", &len);
+	if (!p)
+		FAIL("fdt_getprop(%d, \"lref\"): %s", node, fdt_strerror(len));
+	if (len != sizeof(*p))
+		FAIL("'lref' in node at %d has wrong size (%d instead of %d)",
+		     node, len, sizeof(*p));
+	ref = fdt32_to_cpu(*p);
+	if (ref != checkref)
+		FAIL("'lref' in node at %d has value 0x%x instead of 0x%x",
+		     node, ref, checkref);
+}
+
+int main(int argc, char *argv[])
+{
+	void *fdt;
+	int n1, n2, n3, n4;
+	uint32_t h1, h2, h4;
+
+	test_init(argc, argv);
+	fdt = load_blob_arg(argc, argv);
+
+	n1 = fdt_path_offset(fdt, "/node1");
+	if (n1 < 0)
+		FAIL("fdt_path_offset(/node1): %s", fdt_strerror(n1));
+	n2 = fdt_path_offset(fdt, "/node2");
+	if (n2 < 0)
+		FAIL("fdt_path_offset(/node2): %s", fdt_strerror(n2));
+	n3 = fdt_path_offset(fdt, "/node3");
+	if (n3 < 0)
+		FAIL("fdt_path_offset(/node3): %s", fdt_strerror(n3));
+	n4 = fdt_path_offset(fdt, "/node4");
+	if (n4 < 0)
+		FAIL("fdt_path_offset(/node4): %s", fdt_strerror(n4));
+
+	h1 = fdt_get_phandle(fdt, n1);
+	h2 = fdt_get_phandle(fdt, n2);
+	h4 = fdt_get_phandle(fdt, n4);
+
+	if (h1 != 0x2000)
+		FAIL("/node1 has wrong phandle, 0x%x instead of 0x%x",
+		     h1, 0x2000);
+	if (h2 != 0x1)
+		FAIL("/node2 has wrong phandle, 0x%x instead of 0x%x",
+		     h2, 0x1);
+	if ((h4 == 0x2000) || (h4 == 0x1) || (h4 == 0))
+		FAIL("/node4 has bad phandle, 0x%x", h4);
+
+	check_ref(fdt, n1, h2);
+	check_ref(fdt, n2, h1);
+	check_ref(fdt, n3, h4);
+
+	PASS();
+}


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

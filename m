Return-Path: <dgibson@ozlabs.org>
Date: Wed, 5 Dec 2007 10:43:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Implement path references
Message-ID: <20071204234350.GE9487@localhost.localdomain>
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

This patch extends dtc syntax to allow references (&label, or
&{/full/path}) directly within property definitions, rather than
inside a cell list.  Such references are expanded to the full path of
the referenced node, as a string, instead of to a phandle as
references within cell lists are evaluated.

A testcase is also included.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2007-12-05 09:48:12.000000000 +1100
+++ dtc/tests/run_tests.sh	2007-12-05 10:31:51.000000000 +1100
@@ -148,6 +148,9 @@
     run_test dtc.sh -I dts -O dtb -o dtc_references_dts0.test.dtb references_dts0.dts
     run_test references dtc_references_dts0.test.dtb
 
+    run_test dtc.sh -I dts -O dtb -o dtc_path-references.test.dtb path-references.dts
+    run_test path-references dtc_path-references.test.dtb
+
     # Check -Odts mode preserve all dtb information
     for tree in test_tree1.dtb dtc_tree1.test.dtb dtc_escapes.test.dtb ; do
 	run_test dtc.sh -I dtb -O dts -o odts_$tree.test.dts $tree
Index: dtc/dtc-parser.y
===================================================================
--- dtc.orig/dtc-parser.y	2007-12-05 10:18:26.000000000 +1100
+++ dtc/dtc-parser.y	2007-12-05 10:31:51.000000000 +1100
@@ -192,6 +192,10 @@
 		{
 			$$ = data_merge($1, $3);
 		}
+	| propdataprefix DT_REF
+	  	{
+			$$ = data_add_marker($1, REF_PATH, $2);
+		}
 	| propdata DT_LABEL
 		{
 			$$ = data_add_marker($1, LABEL, $2);
Index: dtc/dtc.h
===================================================================
--- dtc.orig/dtc.h	2007-12-05 09:02:20.000000000 +1100
+++ dtc/dtc.h	2007-12-05 10:32:26.000000000 +1100
@@ -104,6 +104,7 @@
 /* Data blobs */
 enum markertype {
 	REF_PHANDLE,
+	REF_PATH,
 	LABEL,
 };
 
@@ -139,6 +140,8 @@
 struct data data_copy_file(FILE *f, size_t len);
 
 struct data data_append_data(struct data d, const void *p, int len);
+struct data data_insert_at_marker(struct data d, struct marker *m,
+				  const void *p, int len);
 struct data data_merge(struct data d1, struct data d2);
 struct data data_append_cell(struct data d, cell_t word);
 struct data data_append_re(struct data d, const struct fdt_reserve_entry *re);
Index: dtc/tests/Makefile.tests
===================================================================
--- dtc.orig/tests/Makefile.tests	2007-12-03 15:33:10.000000000 +1100
+++ dtc/tests/Makefile.tests	2007-12-05 10:31:51.000000000 +1100
@@ -9,7 +9,7 @@
 	sw_tree1 \
 	move_and_save mangle-layout \
 	open_pack rw_tree1 setprop del_property del_node \
-	string_escapes references \
+	string_escapes references path-references \
 	dtbs_equal_ordered
 LIB_TESTS = $(LIB_TESTS_L:%=$(TESTS_PREFIX)%)
 
Index: dtc/tests/path-references.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/path-references.c	2007-12-05 10:31:51.000000000 +1100
@@ -0,0 +1,83 @@
+/*
+ * libfdt - Flat Device Tree manipulation
+ *	Testcase for string references in dtc
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
+void check_ref(const void *fdt, int node, const char *checkpath)
+{
+	const char *p;
+	int len;
+
+	p = fdt_getprop(fdt, node, "ref", &len);
+	if (!p)
+		FAIL("fdt_getprop(%d, \"ref\"): %s", node, fdt_strerror(len));
+	if (!streq(p, checkpath))
+		FAIL("'ref' in node at %d has value \"%s\" instead of \"%s\"",
+		     node, p, checkpath);
+
+	p = fdt_getprop(fdt, node, "lref", &len);
+	if (!p)
+		FAIL("fdt_getprop(%d, \"lref\"): %s", node, fdt_strerror(len));
+	if (!streq(p, checkpath))
+		FAIL("'lref' in node at %d has value \"%s\" instead of \"%s\"",
+		     node, p, checkpath);
+}
+
+int main(int argc, char *argv[])
+{
+	void *fdt;
+	const char *p;
+	int len, multilen;
+	int n1, n2;
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
+
+	check_ref(fdt, n1, "/node2");
+	check_ref(fdt, n2, "/node1");
+
+	/* Check multiple reference */
+	multilen = strlen("/node1") + strlen("/node2") + 2;
+	p = fdt_getprop(fdt, 0, "multiref", &len);
+	if (!p)
+		FAIL("fdt_getprop(0, \"multiref\"): %s", fdt_strerror(len));
+	if (len != multilen)
+		FAIL("multiref has wrong length, %d instead of %d",
+		     len, multilen);
+	if ((!streq(p, "/node1") || !streq(p + strlen("/node1") + 1, "/node2")))
+		FAIL("multiref has wrong value");
+
+	PASS();
+}
Index: dtc/tests/path-references.dts
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/path-references.dts	2007-12-05 10:35:55.000000000 +1100
@@ -0,0 +1,14 @@
+/dts-v1/;
+
+/ {
+	/* Check multiple references case */
+	multiref = &n1 , &n2;
+	n1: node1 {
+		ref = &{/node2}; /* reference precedes target */
+		lref = &n2;
+	};
+	n2: node2 {
+		ref = &{/node1}; /* reference after target */
+		lref = &n1;
+	};
+};
Index: dtc/data.c
===================================================================
--- dtc.orig/data.c	2007-12-05 09:02:20.000000000 +1100
+++ dtc/data.c	2007-12-05 10:34:01.000000000 +1100
@@ -202,6 +202,21 @@
 	return d;
 }
 
+struct data data_insert_at_marker(struct data d, struct marker *m,
+				  const void *p, int len)
+{
+	d = data_grow_for(d, len);
+	memmove(d.val + m->offset + len, d.val + m->offset, d.len - m->offset);
+	memcpy(d.val + m->offset, p, len);
+	d.len += len;
+
+	/* Adjust all markers after the one we're inserting at */
+	m = m->next;
+	for_each_marker(m)
+		m->offset += len;
+	return d;
+}
+
 struct data data_append_markers(struct data d, struct marker *m)
 {
 	struct marker **mp = &d.markers;
Index: dtc/checks.c
===================================================================
--- dtc.orig/checks.c	2007-12-05 09:48:12.000000000 +1100
+++ dtc/checks.c	2007-12-05 10:33:50.000000000 +1100
@@ -302,11 +302,36 @@
 CHECK(phandle_references, NULL, NULL, fixup_phandle_references, NULL, ERROR,
       &duplicate_node_names, &explicit_phandles);
 
+static void fixup_path_references(struct check *c, struct node *dt,
+				  struct node *node, struct property *prop)
+{
+	struct marker *m = prop->val.markers;
+	struct node *refnode;
+	char *path;
+
+	for_each_marker_of_type(m, REF_PATH) {
+		assert(m->offset <= prop->val.len);
+
+		refnode = get_node_by_ref(dt, m->ref);
+		if (!refnode) {
+			FAIL(c, "Reference to non-existent node or label \"%s\"\n",
+			     m->ref);
+			continue;
+		}
+
+		path = refnode->fullpath;
+		prop->val = data_insert_at_marker(prop->val, m, path,
+						  strlen(path) + 1);
+	}
+}
+CHECK(path_references, NULL, NULL, fixup_path_references, NULL, ERROR,
+      &duplicate_node_names);
+
 static struct check *check_table[] = {
 	&duplicate_node_names, &duplicate_property_names,
 	&name_is_string, &name_properties,
 	&explicit_phandles,
-	&phandle_references,
+	&phandle_references, &path_references,
 };
 
 int check_semantics(struct node *dt, int outversion, int boot_cpuid_phys);

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

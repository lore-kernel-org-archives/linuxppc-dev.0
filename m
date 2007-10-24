Return-Path: <dgibson@ozlabs.org>
Date: Wed, 24 Oct 2007 11:06:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>, linuxppc-dev@ozlabs.org
Subject: libfdt: Rename and publish _fdt_next_tag()
Message-ID: <20071024010609.GH10595@localhost.localdomain>
References: <20071024002852.GG10595@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071024002852.GG10595@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Although it's a low-level function that shouldn't normally be needed,
there are circumstances where it's useful for users of libfdt to use
the _fdt_next_tag() function.  Therefore, this patch renames it to
fdt_next_tag() and publishes it in libfdt.h.

In addition, this patch adds a new testcase using fdt_next_tag(),
dtbs_equal_ordered.  This testcase tests for structural equality of
two dtbs, including the order of properties and subnodes, but ignoring
NOP tags, the order of the dtb sections and the layout of strings in
the strings block.  This will be useful for testing other dtc
functionality in the future.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/libfdt/fdt.c
===================================================================
--- dtc.orig/libfdt/fdt.c	2007-10-24 10:45:07.000000000 +1000
+++ dtc/libfdt/fdt.c	2007-10-24 10:45:13.000000000 +1000
@@ -90,7 +90,7 @@
 	return p;
 }
 
-uint32_t _fdt_next_tag(const void *fdt, int offset, int *nextoffset)
+uint32_t fdt_next_tag(const void *fdt, int offset, int *nextoffset)
 {
 	const uint32_t *tagp, *lenp;
 	uint32_t tag;
Index: dtc/libfdt/libfdt.h
===================================================================
--- dtc.orig/libfdt/libfdt.h	2007-10-24 10:45:11.000000000 +1000
+++ dtc/libfdt/libfdt.h	2007-10-24 10:45:13.000000000 +1000
@@ -92,8 +92,9 @@
 #define fdt_offset_ptr_typed_w(fdt, offset, var) \
 	((typeof(var))(fdt_offset_ptr_w((fdt), (offset), sizeof(*(var)))))
 
-/* General functions */
+uint32_t fdt_next_tag(const void *fdt, int offset, int *nextoffset);
 
+/* General functions */
 #define fdt_get_header(fdt, field) \
 	(fdt32_to_cpu(((const struct fdt_header *)(fdt))->field))
 #define fdt_magic(fdt) 			(fdt_get_header(fdt, magic))
Index: dtc/libfdt/fdt_ro.c
===================================================================
--- dtc.orig/libfdt/fdt_ro.c	2007-10-24 10:45:07.000000000 +1000
+++ dtc/libfdt/fdt_ro.c	2007-10-24 10:45:13.000000000 +1000
@@ -113,13 +113,13 @@
 
 	CHECK_HEADER(fdt);
 
-	tag = _fdt_next_tag(fdt, parentoffset, &nextoffset);
+	tag = fdt_next_tag(fdt, parentoffset, &nextoffset);
 	if (tag != FDT_BEGIN_NODE)
 		return -FDT_ERR_BADOFFSET;
 
 	do {
 		offset = nextoffset;
-		tag = _fdt_next_tag(fdt, offset, &nextoffset);
+		tag = fdt_next_tag(fdt, offset, &nextoffset);
 
 		switch (tag) {
 		case FDT_END:
@@ -229,14 +229,14 @@
 	if (nodeoffset % FDT_TAGSIZE)
 		goto fail;
 
-	tag = _fdt_next_tag(fdt, nodeoffset, &nextoffset);
+	tag = fdt_next_tag(fdt, nodeoffset, &nextoffset);
 	if (tag != FDT_BEGIN_NODE)
 		goto fail;
 
 	do {
 		offset = nextoffset;
 
-		tag = _fdt_next_tag(fdt, offset, &nextoffset);
+		tag = fdt_next_tag(fdt, offset, &nextoffset);
 		switch (tag) {
 		case FDT_END:
 			err = -FDT_ERR_TRUNCATED;
@@ -302,7 +302,7 @@
 
 	CHECK_HEADER(fdt);
 
-	tag = _fdt_next_tag(fdt, 0, &nextoffset);
+	tag = fdt_next_tag(fdt, 0, &nextoffset);
 	if (tag != FDT_BEGIN_NODE)
 		return -FDT_ERR_BADSTRUCTURE;
 
@@ -313,7 +313,7 @@
 
 	while (nextoffset <= nodeoffset) {
 		offset = nextoffset;
-		tag = _fdt_next_tag(fdt, offset, &nextoffset);
+		tag = fdt_next_tag(fdt, offset, &nextoffset);
 		switch (tag) {
 		case FDT_END:
 			return -FDT_ERR_BADOFFSET;
@@ -374,7 +374,7 @@
 
 	do {
 		offset = nextoffset;
-		tag = _fdt_next_tag(fdt, offset, &nextoffset);
+		tag = fdt_next_tag(fdt, offset, &nextoffset);
 		switch (tag) {
 		case FDT_END:
 			return -FDT_ERR_BADOFFSET;
@@ -439,7 +439,7 @@
 	CHECK_HEADER(fdt);
 
 	if (startoffset >= 0) {
-		tag = _fdt_next_tag(fdt, startoffset, &nextoffset);
+		tag = fdt_next_tag(fdt, startoffset, &nextoffset);
 		if (tag != FDT_BEGIN_NODE)
 			return -FDT_ERR_BADOFFSET;
 	} else {
@@ -453,7 +453,7 @@
 	 * approach; performance can come later. */
 	do {
 		offset = nextoffset;
-		tag = _fdt_next_tag(fdt, offset, &nextoffset);
+		tag = fdt_next_tag(fdt, offset, &nextoffset);
 
 		switch (tag) {
 		case FDT_BEGIN_NODE:
@@ -520,7 +520,7 @@
 	CHECK_HEADER(fdt);
 
 	if (startoffset >= 0) {
-		tag = _fdt_next_tag(fdt, startoffset, &nextoffset);
+		tag = fdt_next_tag(fdt, startoffset, &nextoffset);
 		if (tag != FDT_BEGIN_NODE)
 			return -FDT_ERR_BADOFFSET;
 	} else {
@@ -534,7 +534,7 @@
 	 * implement approach; performance can come later. */
 	do {
 		offset = nextoffset;
-		tag = _fdt_next_tag(fdt, offset, &nextoffset);
+		tag = fdt_next_tag(fdt, offset, &nextoffset);
 
 		switch (tag) {
 		case FDT_BEGIN_NODE:
Index: dtc/libfdt/fdt_rw.c
===================================================================
--- dtc.orig/libfdt/fdt_rw.c	2007-10-24 10:45:07.000000000 +1000
+++ dtc/libfdt/fdt_rw.c	2007-10-24 10:45:13.000000000 +1000
@@ -224,7 +224,7 @@
 	int namestroff;
 	int err;
 
-	tag = _fdt_next_tag(fdt, nodeoffset, &nextoffset);
+	tag = fdt_next_tag(fdt, nodeoffset, &nextoffset);
 	if (tag != FDT_BEGIN_NODE)
 		return -FDT_ERR_BADOFFSET;
 
@@ -298,10 +298,10 @@
 		return offset;
 
 	/* Try to place the new node after the parent's properties */
-	_fdt_next_tag(fdt, parentoffset, &nextoffset); /* skip the BEGIN_NODE */
+	fdt_next_tag(fdt, parentoffset, &nextoffset); /* skip the BEGIN_NODE */
 	do {
 		offset = nextoffset;
-		tag = _fdt_next_tag(fdt, offset, &nextoffset);
+		tag = fdt_next_tag(fdt, offset, &nextoffset);
 	} while (tag == FDT_PROP);
 
 	nh = _fdt_offset_ptr_w(fdt, offset);
Index: dtc/libfdt/fdt_sw.c
===================================================================
--- dtc.orig/libfdt/fdt_sw.c	2007-10-24 10:45:07.000000000 +1000
+++ dtc/libfdt/fdt_sw.c	2007-10-24 10:45:13.000000000 +1000
@@ -235,7 +235,7 @@
 
 	/* Walk the structure, correcting string offsets */
 	offset = 0;
-	while ((tag = _fdt_next_tag(fdt, offset, &nextoffset)) != FDT_END) {
+	while ((tag = fdt_next_tag(fdt, offset, &nextoffset)) != FDT_END) {
 		if (tag == FDT_PROP) {
 			struct fdt_property *prop =
 				fdt_offset_ptr_w(fdt, offset, sizeof(*prop));
Index: dtc/libfdt/fdt_wip.c
===================================================================
--- dtc.orig/libfdt/fdt_wip.c	2007-10-24 10:45:07.000000000 +1000
+++ dtc/libfdt/fdt_wip.c	2007-10-24 10:45:13.000000000 +1000
@@ -100,12 +100,12 @@
 	uint32_t tag;
 	int offset, nextoffset;
 
-	tag = _fdt_next_tag(fdt, nodeoffset, &nextoffset);
+	tag = fdt_next_tag(fdt, nodeoffset, &nextoffset);
 	if (tag != FDT_BEGIN_NODE)
 		return -FDT_ERR_BADOFFSET;
 	do {
 		offset = nextoffset;
-		tag = _fdt_next_tag(fdt, offset, &nextoffset);
+		tag = fdt_next_tag(fdt, offset, &nextoffset);
 
 		switch (tag) {
 		case FDT_END:
Index: dtc/tests/dtbs_equal_ordered.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/dtbs_equal_ordered.c	2007-10-24 10:52:47.000000000 +1000
@@ -0,0 +1,139 @@
+/*
+ * libfdt - Flat Device Tree manipulation
+ *	Tests if two given dtbs are structurally equal (including order)
+ * Copyright (C) 2007 David Gibson, IBM Corporation.
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
+void compare_mem_rsv(const void *fdt1, const void *fdt2)
+{
+	int i;
+	uint64_t addr1, size1, addr2, size2;
+	int err;
+
+	if (fdt_num_mem_rsv(fdt1) != fdt_num_mem_rsv(fdt2))
+		FAIL("Trees have different number of reserve entries");
+	for (i = 0; i < fdt_num_mem_rsv(fdt1); i++) {
+		err = fdt_get_mem_rsv(fdt1, i, &addr1, &size1);
+		if (err)
+			FAIL("fdt_get_mem_rsv(fdt1, %d, ...): %s", i,
+			     fdt_strerror(err));
+		err = fdt_get_mem_rsv(fdt2, i, &addr2, &size2);
+		if (err)
+			FAIL("fdt_get_mem_rsv(fdt2, %d, ...): %s", i,
+			     fdt_strerror(err));
+		if ((addr1 != addr2) || (size1 != size2))
+			FAIL("Mismatch in reserve entry %d: "
+			     "(0x%llx, 0x%llx) != (0x%llx, 0x%llx)", i,
+			     addr1, size1, addr2, size2);
+	}
+}
+
+void compare_structure(const void *fdt1, const void *fdt2)
+{
+	int nextoffset1 = 0, nextoffset2 = 0;
+	int offset1, offset2;
+	uint32_t tag1, tag2;
+	const char *name1, *name2;
+	int err;
+	const struct fdt_property *prop1, *prop2;
+	int len1, len2;
+
+	while (1) {
+		do {
+			offset1 = nextoffset1;
+			tag1 = fdt_next_tag(fdt1, offset1, &nextoffset1);
+		} while (tag1 == FDT_NOP);
+		do {
+			offset2 = nextoffset2;
+			tag2 = fdt_next_tag(fdt2, offset2, &nextoffset2);
+		} while (tag2 == FDT_NOP);
+
+		if (tag1 != tag2)
+			FAIL("Tag mismatch (%d != %d) at (%d, %d)",
+			     tag1, tag2, offset1, offset2);
+
+		switch (tag1) {
+		case FDT_BEGIN_NODE:
+			name1 = fdt_get_name(fdt1, offset1, &err);
+			if (!name1)
+				FAIL("fdt_get_name(fdt1, %d, ..): %s",
+				     offset1, fdt_strerror(err));
+			name2 = fdt_get_name(fdt2, offset2, NULL);
+			if (!name2)
+				FAIL("fdt_get_name(fdt2, %d, ..): %s",
+				     offset2, fdt_strerror(err));
+			if (!streq(name1, name2))
+			    FAIL("Name mismatch (\"%s\" != \"%s\") at (%d, %d)",
+				 name1, name2, offset1, offset2);
+			break;
+
+		case FDT_PROP:
+			prop1 = fdt_offset_ptr_typed(fdt1, offset1, prop1);
+			if (!prop1)
+				FAIL("Could get fdt1 property at %d", offset1);
+			prop2 = fdt_offset_ptr_typed(fdt2, offset2, prop2);
+			if (!prop2)
+				FAIL("Could get fdt2 property at %d", offset2);
+
+			name1 = fdt_string(fdt1, fdt32_to_cpu(prop1->nameoff));
+			name2 = fdt_string(fdt2, fdt32_to_cpu(prop2->nameoff));
+			if (!streq(name1, name2))
+				FAIL("Property name mismatch \"%s\" != \"%s\" "
+				     "at (%d, %d)", name1, name2, offset1, offset2);
+			len1 = fdt32_to_cpu(prop1->len);
+			len2 = fdt32_to_cpu(prop2->len);
+			if (len1 != len2)
+				FAIL("Property length mismatch %u != %u "
+				     "at (%d, %d)", len1, len2, offset1, offset2);
+
+			if (memcmp(prop1->data, prop2->data, len1) != 0)
+				FAIL("Property value mismatch at (%d, %d)",
+				     offset1, offset2);
+			break;
+
+		case FDT_END:
+			return;
+		}
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	void *fdt1, *fdt2;
+
+	test_init(argc, argv);
+	if (argc != 3)
+		CONFIG("Usage: %s <dtb file> <dtb file>", argv[0]);
+	fdt1 = load_blob(argv[1]);
+	fdt2 = load_blob(argv[2]);
+
+	compare_mem_rsv(fdt1, fdt2);
+	compare_structure(fdt1, fdt2);
+
+	PASS();
+}
Index: dtc/tests/Makefile.tests
===================================================================
--- dtc.orig/tests/Makefile.tests	2007-10-24 10:45:07.000000000 +1000
+++ dtc/tests/Makefile.tests	2007-10-24 10:45:13.000000000 +1000
@@ -8,7 +8,7 @@
 	sw_tree1 \
 	move_and_save \
 	open_pack rw_tree1 setprop del_property del_node \
-	string_escapes
+	string_escapes dtbs_equal_ordered
 LIB_TESTS = $(LIB_TESTS_L:%=$(TESTS_PREFIX)%)
 
 LIBTREE_TESTS_L = truncated_property
Index: dtc/tests/tests.h
===================================================================
--- dtc.orig/tests/tests.h	2007-10-24 10:45:07.000000000 +1000
+++ dtc/tests/tests.h	2007-10-24 10:45:13.000000000 +1000
@@ -129,7 +129,7 @@
 #define check_getprop_string(fdt, nodeoffset, name, s) \
 	check_getprop((fdt), (nodeoffset), (name), strlen(s)+1, (s))
 int nodename_eq(const char *s1, const char *s2);
-//void *load_blob(const char *filename);
+void *load_blob(const char *filename);
 void *load_blob_arg(int argc, char *argv[]);
 void save_blob(const char *filename, void *blob);
 
Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2007-10-24 10:45:07.000000000 +1000
+++ dtc/tests/run_tests.sh	2007-10-24 10:45:13.000000000 +1000
@@ -104,6 +104,7 @@
     run_test dtc.sh -I dts -O dtb -o dtc_tree1.test.dtb test_tree1.dts
     tree1_tests dtc_tree1.test.dtb
     tree1_tests_rw dtc_tree1.test.dtb
+    run_test dtbs_equal_ordered dtc_tree1.test.dtb test_tree1.dtb
 
     run_test dtc.sh -I dts -O dtb -o dtc_escapes.test.dtb escapes.dts
     run_test string_escapes dtc_escapes.test.dtb

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

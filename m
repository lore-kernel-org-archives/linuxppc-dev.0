Return-Path: <dgibson@ozlabs.org>
Date: Thu, 1 Nov 2007 11:37:31 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: libfdt: Handle v16 and re-ordered trees for r/w
Message-ID: <20071101003731.GG16119@localhost.localdomain>
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

Currently all the read/write functions in libfdt require that the
given tree be v17, and further, that the tree has the memory
reservation block, structure block and strings block stored in that
physical order.

This patch eases these constraints, by making fdt_open_int() reorder
the blocks, and/or convert the tree to v17, so that it will then be
ready for the other read-write functions.

It also extends fdt_pack() to actually remove any gaps between blocks
that might be present.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/libfdt/fdt_rw.c
===================================================================
--- dtc.orig/libfdt/fdt_rw.c	2007-10-31 18:45:58.000000000 +1100
+++ dtc/libfdt/fdt_rw.c	2007-11-01 11:18:24.000000000 +1100
@@ -55,6 +55,18 @@
 
 #include "libfdt_internal.h"
 
+static int _blocks_misordered(const void *fdt,
+			      int mem_rsv_size, int struct_size)
+{
+	return (fdt_off_mem_rsvmap(fdt) < ALIGN(sizeof(struct fdt_header), 8))
+		|| (fdt_off_dt_struct(fdt) <
+		    (fdt_off_mem_rsvmap(fdt) + mem_rsv_size))
+		|| (fdt_off_dt_strings(fdt) <
+		    (fdt_off_dt_struct(fdt) + struct_size))
+		|| (fdt_totalsize(fdt) <
+		    (fdt_off_dt_strings(fdt) + fdt_size_dt_strings(fdt)));
+}
+
 static int rw_check_header(void *fdt)
 {
 	int err;
@@ -63,16 +75,8 @@
 		return err;
 	if (fdt_version(fdt) < 17)
 		return -FDT_ERR_BADVERSION;
-	if (fdt_off_mem_rsvmap(fdt) < ALIGN(sizeof(struct fdt_header), 8))
-		return -FDT_ERR_BADLAYOUT;
-	if (fdt_off_dt_struct(fdt) <
-	    (fdt_off_mem_rsvmap(fdt) + sizeof(struct fdt_reserve_entry)))
-		return -FDT_ERR_BADLAYOUT;
-	if (fdt_off_dt_strings(fdt) <
-	    (fdt_off_dt_struct(fdt) + fdt_size_dt_struct(fdt)))
-		return -FDT_ERR_BADLAYOUT;
-	if (fdt_totalsize(fdt) <
-	    (fdt_off_dt_strings(fdt) + fdt_size_dt_strings(fdt)))
+	if (_blocks_misordered(fdt, sizeof(struct fdt_reserve_entry),
+			       fdt_size_dt_struct(fdt)))
 		return -FDT_ERR_BADLAYOUT;
 	if (fdt_version(fdt) > 17)
 		fdt_set_version(fdt, 17);
@@ -342,36 +346,102 @@
 				   endoffset - nodeoffset, 0);
 }
 
-int fdt_open_into(void *fdt, void *buf, int bufsize)
+static void _packblocks(const void *fdt, void *buf,
+		       int mem_rsv_size, int struct_size)
+{
+	int mem_rsv_off, struct_off, strings_off;
+
+	mem_rsv_off = ALIGN(sizeof(struct fdt_header), 8);
+	struct_off = mem_rsv_off + mem_rsv_size;
+	strings_off = struct_off + struct_size;
+
+	memmove(buf + mem_rsv_off, fdt + fdt_off_mem_rsvmap(fdt), mem_rsv_size);
+	fdt_set_off_mem_rsvmap(buf, mem_rsv_off);
+
+	memcpy(buf + struct_off, fdt + fdt_off_dt_struct(fdt), struct_size);
+	fdt_set_off_dt_struct(buf, struct_off);
+	fdt_set_size_dt_struct(buf, struct_size);
+
+	memcpy(buf + strings_off, fdt + fdt_off_dt_strings(fdt),
+	       fdt_size_dt_strings(fdt));
+	fdt_set_off_dt_strings(buf, strings_off);
+	fdt_set_size_dt_strings(buf, fdt_size_dt_strings(fdt));
+}
+
+int fdt_open_into(const void *fdt, void *buf, int bufsize)
 {
 	int err;
+	int mem_rsv_size, struct_size;
+	int newsize;
+	void *tmp;
 
-	err = fdt_move(fdt, buf, bufsize);
+	err = fdt_check_header(fdt);
 	if (err)
 		return err;
 
-	fdt = buf;
+	mem_rsv_size = (fdt_num_mem_rsv(fdt)+1)
+		* sizeof(struct fdt_reserve_entry);
 
-	fdt_set_totalsize(fdt, bufsize);
+	if (fdt_version(fdt) >= 17) {
+		struct_size = fdt_size_dt_struct(fdt);
+	} else {
+		struct_size = 0;
+		while (fdt_next_tag(fdt, struct_size, &struct_size) != FDT_END)
+			;
+	}
 
-	/* FIXME: re-order if necessary */
+	if (!_blocks_misordered(fdt, mem_rsv_size, struct_size)) {
+		/* no further work necessary */
+		err = fdt_move(fdt, buf, bufsize);
+		if (err)
+			return err;
+		fdt_set_version(buf, 17);
+		fdt_set_size_dt_struct(buf, struct_size);
+		fdt_set_totalsize(buf, bufsize);
+		return 0;
+	}
 
-	err = rw_check_header(fdt);
-	if (err)
-		return err;
+	/* Need to reorder */
+	newsize = ALIGN(sizeof(struct fdt_header), 8) + mem_rsv_size
+		+ struct_size + fdt_size_dt_strings(fdt);
+
+	if (bufsize < newsize)
+		return -FDT_ERR_NOSPACE;
+
+	if (((buf + newsize) <= fdt)
+	    || (buf >= (fdt + fdt_totalsize(fdt)))) {
+		tmp = buf;
+	} else {
+		tmp = (void *)fdt + fdt_totalsize(fdt);
+		if ((tmp + newsize) > (buf + bufsize))
+			return -FDT_ERR_NOSPACE;
+	}
+
+	_packblocks(fdt, tmp, mem_rsv_size, struct_size);
+	memmove(buf, tmp, newsize);
+
+	fdt_set_magic(buf, FDT_MAGIC);
+	fdt_set_totalsize(buf, bufsize);
+	fdt_set_version(buf, 17);
+	fdt_set_last_comp_version(buf, 16);
+	fdt_set_boot_cpuid_phys(buf, fdt_boot_cpuid_phys(fdt));
 
 	return 0;
 }
 
 int fdt_pack(void *fdt)
 {
+	int mem_rsv_size;
 	int err;
 
 	err = rw_check_header(fdt);
 	if (err)
 		return err;
 
-	/* FIXME: pack components */
+	mem_rsv_size = (fdt_num_mem_rsv(fdt)+1)
+		* sizeof(struct fdt_reserve_entry);
+	_packblocks(fdt, fdt, mem_rsv_size, fdt_size_dt_struct(fdt));
 	fdt_set_totalsize(fdt, _blob_data_size(fdt));
+
 	return 0;
 }
Index: dtc/libfdt/libfdt.h
===================================================================
--- dtc.orig/libfdt/libfdt.h	2007-10-31 18:45:59.000000000 +1100
+++ dtc/libfdt/libfdt.h	2007-11-01 10:38:53.000000000 +1100
@@ -412,7 +412,7 @@
 /* Read-write functions                                               */
 /**********************************************************************/
 
-int fdt_open_into(void *fdt, void *buf, int bufsize);
+int fdt_open_into(const void *fdt, void *buf, int bufsize);
 int fdt_pack(void *fdt);
 
 int fdt_add_mem_rsv(void *fdt, uint64_t address, uint64_t size);
Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2007-11-01 10:38:52.000000000 +1100
+++ dtc/tests/run_tests.sh	2007-11-01 10:38:53.000000000 +1100
@@ -62,6 +62,8 @@
     run_test del_node $TREE
 }
 
+ALL_LAYOUTS="mts mst tms tsm smt stm"
+
 libfdt_tests () {
     tree1_tests test_tree1.dtb
 
@@ -82,7 +84,7 @@
     # v16 and alternate layout tests
     for tree in test_tree1.dtb; do
 	for version in 17 16; do
-	    for layout in mts mst tms tsm smt stm; do
+	    for layout in $ALL_LAYOUTS; do
 		run_test mangle-layout $tree $version $layout
 		tree1_tests v$version.$layout.$tree
 		run_test dtbs_equal_ordered $tree v$version.$layout.$tree
@@ -91,18 +93,21 @@
     done
 
     # Read-write tests
-    for tree in test_tree1.dtb sw_tree1.test.dtb; do
-	rm -f opened.$tree repacked.$tree
-	run_test open_pack $tree
-	tree1_tests opened.$tree
-	tree1_tests repacked.$tree
-    done
-
-    for tree in test_tree1.dtb sw_tree1.test.dtb; do
-	tree1_tests_rw $tree
-	tree1_tests_rw moved.$tree
-	tree1_tests_rw shunted.$tree
-	tree1_tests_rw deshunted.$tree
+    for basetree in test_tree1.dtb; do
+	for version in 17 16; do
+	    for layout in $ALL_LAYOUTS; do
+		tree=v$version.$layout.$basetree
+		rm -f opened.$tree repacked.$tree
+		run_test open_pack $tree
+		tree1_tests $tree
+		tree1_tests opened.$tree
+		tree1_tests repacked.$tree
+
+		tree1_tests_rw $tree
+		tree1_tests_rw opened.$tree
+		tree1_tests_rw repacked.$tree
+	    done
+	done
     done
     run_test rw_tree1
     tree1_tests rw_tree1.test.dtb
Index: dtc/tests/del_property.c
===================================================================
--- dtc.orig/tests/del_property.c	2007-10-31 18:45:59.000000000 +1100
+++ dtc/tests/del_property.c	2007-11-01 10:38:53.000000000 +1100
@@ -41,6 +41,8 @@
 	test_init(argc, argv);
 	fdt = load_blob_arg(argc, argv);
 
+	fdt = open_blob_rw(fdt);
+
 	oldsize = fdt_totalsize(fdt);
 
 	intp = check_getprop_typed(fdt, 0, "prop-int", TEST_VALUE_1);
Index: dtc/tests/testutils.c
===================================================================
--- dtc.orig/tests/testutils.c	2007-10-31 18:45:59.000000000 +1100
+++ dtc/tests/testutils.c	2007-11-01 10:38:53.000000000 +1100
@@ -220,3 +220,21 @@
 		offset += ret;
 	}
 }
+
+void *open_blob_rw(void *blob)
+{
+	int err;
+	void *buf = blob;
+
+	err = fdt_open_into(blob, buf, fdt_totalsize(blob));
+	if (err == -FDT_ERR_NOSPACE) {
+		/* Ran out of space converting to v17 */
+		int newsize = fdt_totalsize(blob) + 8;
+
+		buf = xmalloc(newsize);
+		err = fdt_open_into(blob, buf, newsize);
+	}
+	if (err)
+		FAIL("fdt_open_into(): %s", fdt_strerror(err));
+	return buf;
+}
Index: dtc/tests/del_node.c
===================================================================
--- dtc.orig/tests/del_node.c	2007-10-31 18:45:59.000000000 +1100
+++ dtc/tests/del_node.c	2007-11-01 10:38:53.000000000 +1100
@@ -40,6 +40,8 @@
 	test_init(argc, argv);
 	fdt = load_blob_arg(argc, argv);
 
+	fdt = open_blob_rw(fdt);
+
 	oldsize = fdt_totalsize(fdt);
 
 	subnode1_offset = fdt_path_offset(fdt, "/subnode@1");
Index: dtc/tests/tests.h
===================================================================
--- dtc.orig/tests/tests.h	2007-10-31 18:45:59.000000000 +1100
+++ dtc/tests/tests.h	2007-11-01 10:38:53.000000000 +1100
@@ -132,5 +132,6 @@
 void *load_blob(const char *filename);
 void *load_blob_arg(int argc, char *argv[]);
 void save_blob(const char *filename, void *blob);
+void *open_blob_rw(void *blob);
 
 #endif /* _TESTS_H */

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

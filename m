Return-Path: <dgibson@ozlabs.org>
Date: Wed, 10 Oct 2007 17:12:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: libfdt: Add functions to get/add/delete memory reservemap entries
Message-ID: <20071010071212.GC6135@localhost.localdomain>
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

This patch adds functions to libfdt for accessing the memory
reservation map section of a device tree blob.  fdt_num_mem_rsv()
retreives the number of reservation entries in a dtb, and
fdt_get_mem_rsv() retreives a specific reservation entry.
fdt_add_mem_rsv() adds a new entry, and fdt_del_mem_rsv() removes a
specific numbered entry.

Testcases for these new functions are also included.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/libfdt/fdt_ro.c
===================================================================
--- dtc.orig/libfdt/fdt_ro.c	2007-10-10 17:04:09.000000000 +1000
+++ dtc/libfdt/fdt_ro.c	2007-10-10 17:04:09.000000000 +1000
@@ -87,6 +87,23 @@ char *fdt_string(const void *fdt, int st
 	return (char *)fdt + fdt_off_dt_strings(fdt) + stroffset;
 }
 
+int fdt_get_mem_rsv(const void *fdt, int n, uint64_t *address, uint64_t *size)
+{
+	CHECK_HEADER(fdt);
+	*address = fdt64_to_cpu(_fdt_mem_rsv(fdt, n)->address);
+	*size = fdt64_to_cpu(_fdt_mem_rsv(fdt, n)->size);
+	return 0;
+}
+
+int fdt_num_mem_rsv(const void *fdt)
+{
+	int i = 0;
+
+	while (fdt64_to_cpu(_fdt_mem_rsv(fdt, i)->size) != 0)
+		i++;
+	return i;
+}
+
 int fdt_subnode_offset_namelen(const void *fdt, int parentoffset,
 			       const char *name, int namelen)
 {
Index: dtc/libfdt/libfdt.h
===================================================================
--- dtc.orig/libfdt/libfdt.h	2007-10-10 17:04:09.000000000 +1000
+++ dtc/libfdt/libfdt.h	2007-10-10 17:04:09.000000000 +1000
@@ -112,6 +112,9 @@ int fdt_move(const void *fdt, void *buf,
 /* Read-only functions */
 char *fdt_string(const void *fdt, int stroffset);
 
+int fdt_get_mem_rsv(const void *fdt, int n, uint64_t *address, uint64_t *size);
+int fdt_num_mem_rsv(const void *fdt);
+
 int fdt_subnode_offset_namelen(const void *fdt, int parentoffset,
 			       const char *name, int namelen);
 int fdt_subnode_offset(const void *fdt, int parentoffset, const char *name);
@@ -183,6 +186,9 @@ int fdt_finish(void *fdt);
 int fdt_open_into(void *fdt, void *buf, int bufsize);
 int fdt_pack(void *fdt);
 
+int fdt_add_mem_rsv(void *fdt, uint64_t address, uint64_t size);
+int fdt_del_mem_rsv(void *fdt, int n);
+
 int fdt_setprop(void *fdt, int nodeoffset, const char *name,
 		const void *val, int len);
 #define fdt_setprop_typed(fdt, nodeoffset, name, val) \
Index: dtc/tests/trees.S
===================================================================
--- dtc.orig/tests/trees.S	2007-10-10 17:04:09.000000000 +1000
+++ dtc/tests/trees.S	2007-10-10 17:04:09.000000000 +1000
@@ -37,6 +37,11 @@ tree:	\
 	FDTQUAD(addr)		; \
 	FDTQUAD(len)		;
 
+#define EMPTY_RSVMAP(tree) \
+	.balign	8		; \
+tree##_rsvmap:			; \
+	RSVMAP_ENTRY(0, 0)
+
 #define PROPHDR(tree, name, len) \
 	FDTLONG(FDT_PROP)	; \
 	FDTLONG(len)		; \
@@ -70,7 +75,10 @@ tree##_##name:	\
 
 	TREE_HDR(test_tree1)
 
+	.balign	8
 test_tree1_rsvmap:
+	RSVMAP_ENTRY(TEST_ADDR_1, TEST_SIZE_1)
+	RSVMAP_ENTRY(TEST_ADDR_2, TEST_SIZE_2)
 	RSVMAP_ENTRY(0, 0)
 
 test_tree1_struct:
@@ -103,8 +111,7 @@ test_tree1_strings:
 test_tree1_end:
 
 	TREE_HDR(truncated_property)
-truncated_property_rsvmap:
-	RSVMAP_ENTRY(0, 0)
+	EMPTY_RSVMAP(truncated_property)
 
 truncated_property_struct:
 	BEGIN_NODE("")
Index: dtc/tests/testdata.h
===================================================================
--- dtc.orig/tests/testdata.h	2007-10-10 17:04:09.000000000 +1000
+++ dtc/tests/testdata.h	2007-10-10 17:04:09.000000000 +1000
@@ -9,6 +9,17 @@
 			 | (((x) << 8) & 0xff0000) | (((x) << 24) & 0xff000000))
 #endif
 
+#ifdef __ASSEMBLY__
+#define ASM_CONST_LL(x)	(x)
+#else
+#define ASM_CONST_LL(x)	(x##ULL)
+#endif
+
+#define TEST_ADDR_1	ASM_CONST_LL(0xdeadbeef00000000)
+#define TEST_SIZE_1	ASM_CONST_LL(0x100000)
+#define TEST_ADDR_2	ASM_CONST_LL(0xabcd1234)
+#define TEST_SIZE_2	ASM_CONST_LL(0x1234)
+
 #define TEST_VALUE_1	cell_to_fdt(0xdeadbeef)
 #define TEST_VALUE_2	cell_to_fdt(0xabcd1234)
 
Index: dtc/tests/Makefile.tests
===================================================================
--- dtc.orig/tests/Makefile.tests	2007-10-10 17:04:09.000000000 +1000
+++ dtc/tests/Makefile.tests	2007-10-10 17:04:09.000000000 +1000
@@ -1,4 +1,5 @@
-LIB_TESTS_L = root_node find_property subnode_offset path_offset \
+LIB_TESTS_L = get_mem_rsv \
+	root_node find_property subnode_offset path_offset \
 	get_name getprop get_path supernode_atdepth_offset parent_offset \
 	node_offset_by_prop_value \
 	notfound \
Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2007-10-10 17:04:09.000000000 +1000
+++ dtc/tests/run_tests.sh	2007-10-10 17:04:09.000000000 +1000
@@ -31,6 +31,7 @@ tree1_tests () {
     TREE=$1
 
     # Read-only tests
+    run_test get_mem_rsv $TREE
     run_test root_node $TREE
     run_test find_property $TREE
     run_test subnode_offset $TREE
Index: dtc/tests/sw_tree1.c
===================================================================
--- dtc.orig/tests/sw_tree1.c	2007-10-10 17:04:09.000000000 +1000
+++ dtc/tests/sw_tree1.c	2007-10-10 17:04:09.000000000 +1000
@@ -49,7 +49,10 @@ int main(int argc, char *argv[])
 	fdt = xmalloc(SPACE);
 	CHECK(fdt_create(fdt, SPACE));
 
+	CHECK(fdt_add_reservemap_entry(fdt, TEST_ADDR_1, TEST_SIZE_1));
+	CHECK(fdt_add_reservemap_entry(fdt, TEST_ADDR_2, TEST_SIZE_2));
 	CHECK(fdt_finish_reservemap(fdt));
+
 	CHECK(fdt_begin_node(fdt, ""));
 	CHECK(fdt_property_typed(fdt, "prop-int", TEST_VALUE_1));
 	CHECK(fdt_property_string(fdt, "prop-str", TEST_STRING_1));
Index: dtc/tests/test_tree1.dts
===================================================================
--- dtc.orig/tests/test_tree1.dts	2007-10-10 17:04:09.000000000 +1000
+++ dtc/tests/test_tree1.dts	2007-10-10 17:04:09.000000000 +1000
@@ -1,3 +1,6 @@
+/memreserve/ deadbeef00000000-deadbeef000fffff;
+/memreserve/ abcd1234 00001234;
+
 / {
 	prop-int = <deadbeef>;
 	prop-str = "hello world";
Index: dtc/libfdt/libfdt_internal.h
===================================================================
--- dtc.orig/libfdt/libfdt_internal.h	2007-10-10 17:04:09.000000000 +1000
+++ dtc/libfdt/libfdt_internal.h	2007-10-10 17:04:09.000000000 +1000
@@ -73,6 +73,18 @@ static inline void *_fdt_offset_ptr_w(vo
 	return (void *)_fdt_offset_ptr(fdt, offset);
 }
 
+static inline const struct fdt_reserve_entry *_fdt_mem_rsv(const void *fdt, int n)
+{
+	const struct fdt_reserve_entry *rsv_table =
+		fdt + fdt_off_mem_rsvmap(fdt);
+
+	return rsv_table + n;
+}
+static inline struct fdt_reserve_entry *_fdt_mem_rsv_w(void *fdt, int n)
+{
+	return (void *)_fdt_mem_rsv(fdt, n);
+}
+
 #define SW_MAGIC		(~FDT_MAGIC)
 
 #endif /* _LIBFDT_INTERNAL_H */
Index: dtc/tests/tests.h
===================================================================
--- dtc.orig/tests/tests.h	2007-10-10 17:04:09.000000000 +1000
+++ dtc/tests/tests.h	2007-10-10 17:04:09.000000000 +1000
@@ -108,6 +108,8 @@ static inline void *xrealloc(void *p, si
 	return p;
 }
 
+void check_mem_rsv(void *fdt, int n, uint64_t addr, uint64_t size);
+
 void check_property(void *fdt, int nodeoffset, const char *name,
 		    int len, const void *val);
 #define check_property_typed(fdt, nodeoffset, name, val) \
Index: dtc/tests/testutils.c
===================================================================
--- dtc.orig/tests/testutils.c	2007-10-10 17:04:09.000000000 +1000
+++ dtc/tests/testutils.c	2007-10-10 17:04:09.000000000 +1000
@@ -69,6 +69,21 @@ void test_init(int argc, char *argv[])
 		       test_name, getpid());
 }
 
+void check_mem_rsv(void *fdt, int n, uint64_t addr, uint64_t size)
+{
+	int err;
+	uint64_t addr_v, size_v;
+
+	err = fdt_get_mem_rsv(fdt, n, &addr_v, &size_v);
+	if (err < 0)
+		FAIL("fdt_get_mem_rsv(%d): %s", n, fdt_strerror(err));
+	if ((addr_v != addr) || (size_v != size))
+		FAIL("fdt_get_mem_rsv() returned (0x%llx,0x%llx) "
+		     "instead of (0x%llx,0x%llx)",
+		     (unsigned long long)addr_v, (unsigned long long)size_v,
+		     (unsigned long long)addr, (unsigned long long)size);
+}
+
 void check_property(void *fdt, int nodeoffset, const char *name,
 		    int len, const void *val)
 {
Index: dtc/libfdt/fdt_rw.c
===================================================================
--- dtc.orig/libfdt/fdt_rw.c	2007-10-10 17:04:09.000000000 +1000
+++ dtc/libfdt/fdt_rw.c	2007-10-10 17:04:09.000000000 +1000
@@ -101,6 +101,19 @@ static int _blob_splice(void *fdt, void 
 	return 0;
 }
 
+static int _blob_splice_mem_rsv(void *fdt, struct fdt_reserve_entry *p,
+				int oldn, int newn)
+{
+	int delta = (newn - oldn) * sizeof(*p);
+	int err;
+	err = _blob_splice(fdt, p, oldn * sizeof(*p), newn * sizeof(*p));
+	if (err)
+		return err;
+	fdt_set_header(fdt, off_dt_struct, fdt_off_dt_struct(fdt) + delta);
+	fdt_set_header(fdt, off_dt_strings, fdt_off_dt_strings(fdt) + delta);
+	return 0;
+}
+
 static int _blob_splice_struct(void *fdt, void *p,
 			       int oldlen, int newlen)
 {
@@ -149,6 +162,40 @@ static int _find_add_string(void *fdt, c
 	return (new - strtab);
 }
 
+int fdt_add_mem_rsv(void *fdt, uint64_t address, uint64_t size)
+{
+	struct fdt_reserve_entry *re;
+	int err;
+
+	if ((err = rw_check_header(fdt)))
+		return err;
+
+	re = _fdt_mem_rsv_w(fdt, fdt_num_mem_rsv(fdt));
+	err = _blob_splice_mem_rsv(fdt, re, 0, 1);
+	if (err)
+		return err;
+
+	re->address = cpu_to_fdt64(address);
+	re->size = cpu_to_fdt64(size);
+	return 0;
+}
+
+int fdt_del_mem_rsv(void *fdt, int n)
+{
+	struct fdt_reserve_entry *re = _fdt_mem_rsv_w(fdt, n);
+	int err;
+
+	if ((err = rw_check_header(fdt)))
+		return err;
+	if (n >= fdt_num_mem_rsv(fdt))
+		return -FDT_ERR_NOTFOUND;
+
+	err = _blob_splice_mem_rsv(fdt, re, 1, 0);
+	if (err)
+		return err;
+	return 0;
+}
+
 static int _resize_property(void *fdt, int nodeoffset, const char *name, int len,
 			    struct fdt_property **prop)
 {
Index: dtc/tests/rw_tree1.c
===================================================================
--- dtc.orig/tests/rw_tree1.c	2007-10-10 17:04:09.000000000 +1000
+++ dtc/tests/rw_tree1.c	2007-10-10 17:04:09.000000000 +1000
@@ -69,6 +69,9 @@ int main(int argc, char *argv[])
 
 	CHECK(fdt_open_into(fdt, fdt, SPACE));
 
+	CHECK(fdt_add_mem_rsv(fdt, TEST_ADDR_1, TEST_SIZE_1));
+	CHECK(fdt_add_mem_rsv(fdt, TEST_ADDR_2, TEST_SIZE_2));
+
 	CHECK(fdt_setprop_typed(fdt, 0, "prop-int", TEST_VALUE_1));
 	CHECK(fdt_setprop_string(fdt, 0, "prop-str", TEST_STRING_1));
 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

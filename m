Return-Path: <dgibson@ozlabs.org>
Date: Tue, 20 Nov 2007 13:35:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: libfdt: Abolish _typed() variants, add _cell() variants
Message-ID: <20071120023546.GA4356@localhost.localdomain>
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

In a number of places through libfdt and its tests, we have *_typed()
macro variants on functions which use gcc's typeof and statement
expression extensions to allow passing literals where the underlying
function takes a buffer and size.

These seemed like a good idea at the time, but in fact they have some
problems.  They use typeof and statement expressions, extensions I'd
prefer to avoid for portability.  Plus, they have potential gotchas -
although they'll deal with the size of the thing passed, they won't
deal with other representation issues (like endianness) and results
could be very strange if the type of the expression passed isn't what
you think it is.

In fact, the only users of these _typed() macros were when the value
passed is a single cell (32-bit integer).  Therefore, this patch
removes all these _typed() macros and replaces them with explicit
_cell() variants which handle a single 32-bit integer, and which also
perform endian convesions as appropriate.

With this in place, it now becomes easy to use standardized big-endian
representation for integer valued properties in the testcases,
regardless of the platform we're running on.  We therefore do that,
which has the additional advantage that all the example trees created
during a test run are now byte-for-byte identical regardless of
platform.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/libfdt/libfdt.h
===================================================================
--- dtc.orig/libfdt/libfdt.h	2007-11-20 13:04:09.000000000 +1100
+++ dtc/libfdt/libfdt.h	2007-11-20 13:05:24.000000000 +1100
@@ -657,12 +657,12 @@ int fdt_node_offset_by_compatible(const 
 
 int fdt_setprop_inplace(void *fdt, int nodeoffset, const char *name,
 			const void *val, int len);
-
-#define fdt_setprop_inplace_typed(fdt, nodeoffset, name, val) \
-	({ \
-		typeof(val) x = val; \
-		fdt_setprop_inplace(fdt, nodeoffset, name, &x, sizeof(x)); \
-	})
+static inline int fdt_setprop_inplace_cell(void *fdt, int nodeoffset,
+					   const char *name, uint32_t val)
+{
+	val = cpu_to_fdt32(val);
+	return fdt_setprop_inplace(fdt, nodeoffset, name, &val, sizeof(val));
+}
 
 int fdt_nop_property(void *fdt, int nodeoffset, const char *name);
 int fdt_nop_node(void *fdt, int nodeoffset);
@@ -676,11 +676,11 @@ int fdt_add_reservemap_entry(void *fdt, 
 int fdt_finish_reservemap(void *fdt);
 int fdt_begin_node(void *fdt, const char *name);
 int fdt_property(void *fdt, const char *name, const void *val, int len);
-#define fdt_property_typed(fdt, name, val) \
-	({ \
-		typeof(val) x = (val); \
-		fdt_property((fdt), (name), &x, sizeof(x)); \
-	})
+static inline int fdt_property_cell(void *fdt, const char *name, uint32_t val)
+{
+	val = cpu_to_fdt32(val);
+	return fdt_property(fdt, name, &val, sizeof(val));
+}
 #define fdt_property_string(fdt, name, str) \
 	fdt_property(fdt, name, str, strlen(str)+1)
 int fdt_end_node(void *fdt);
@@ -698,11 +698,12 @@ int fdt_del_mem_rsv(void *fdt, int n);
 
 int fdt_setprop(void *fdt, int nodeoffset, const char *name,
 		const void *val, int len);
-#define fdt_setprop_typed(fdt, nodeoffset, name, val) \
-	({ \
-		typeof(val) x = (val); \
-		fdt_setprop((fdt), (nodeoffset), (name), &x, sizeof(x)); \
-	})
+static inline int fdt_setprop_cell(void *fdt, int nodeoffset, const char *name,
+				   uint32_t val)
+{
+	val = cpu_to_fdt32(val);
+	return fdt_setprop(fdt, nodeoffset, name, &val, sizeof(val));
+}
 #define fdt_setprop_string(fdt, nodeoffset, name, str) \
 	fdt_setprop((fdt), (nodeoffset), (name), (str), strlen(str)+1)
 int fdt_delprop(void *fdt, int nodeoffset, const char *name);
Index: dtc/tests/setprop_inplace.c
===================================================================
--- dtc.orig/tests/setprop_inplace.c	2007-11-20 10:15:51.000000000 +1100
+++ dtc/tests/setprop_inplace.c	2007-11-20 13:05:55.000000000 +1100
@@ -42,14 +42,14 @@ int main(int argc, char *argv[])
 	test_init(argc, argv);
 	fdt = load_blob_arg(argc, argv);
 
-	intp = check_getprop_typed(fdt, 0, "prop-int", TEST_VALUE_1);
+	intp = check_getprop_cell(fdt, 0, "prop-int", TEST_VALUE_1);
 
 	verbose_printf("Old int value was 0x%08x\n", *intp);
-	err = fdt_setprop_inplace_typed(fdt, 0, "prop-int", ~TEST_VALUE_1);
+	err = fdt_setprop_inplace_cell(fdt, 0, "prop-int", ~TEST_VALUE_1);
 	if (err)
 		FAIL("Failed to set \"prop-int\" to 0x08%x: %s",
 		     ~TEST_VALUE_1, fdt_strerror(err));
-	intp = check_getprop_typed(fdt, 0, "prop-int", ~TEST_VALUE_1);
+	intp = check_getprop_cell(fdt, 0, "prop-int", ~TEST_VALUE_1);
 	verbose_printf("New int value is 0x%08x\n", *intp);
 
 	strp = check_getprop(fdt, 0, "prop-str", strlen(TEST_STRING_1)+1,
Index: dtc/tests/del_node.c
===================================================================
--- dtc.orig/tests/del_node.c	2007-11-20 10:15:51.000000000 +1100
+++ dtc/tests/del_node.c	2007-11-20 13:04:09.000000000 +1100
@@ -48,19 +48,19 @@ int main(int argc, char *argv[])
 	if (subnode1_offset < 0)
 		FAIL("Couldn't find \"/subnode@1\": %s",
 		     fdt_strerror(subnode1_offset));
-	check_getprop_typed(fdt, subnode1_offset, "prop-int", TEST_VALUE_1);
+	check_getprop_cell(fdt, subnode1_offset, "prop-int", TEST_VALUE_1);
 
 	subnode2_offset = fdt_path_offset(fdt, "/subnode@2");
 	if (subnode2_offset < 0)
 		FAIL("Couldn't find \"/subnode@2\": %s",
 		     fdt_strerror(subnode2_offset));
-	check_getprop_typed(fdt, subnode2_offset, "prop-int", TEST_VALUE_2);
+	check_getprop_cell(fdt, subnode2_offset, "prop-int", TEST_VALUE_2);
 
 	subsubnode2_offset = fdt_path_offset(fdt, "/subnode@2/subsubnode");
 	if (subsubnode2_offset < 0)
 		FAIL("Couldn't find \"/subnode@2/subsubnode\": %s",
 		     fdt_strerror(subsubnode2_offset));
-	check_getprop_typed(fdt, subsubnode2_offset, "prop-int", TEST_VALUE_2);
+	check_getprop_cell(fdt, subsubnode2_offset, "prop-int", TEST_VALUE_2);
 
 	err = fdt_del_node(fdt, subnode1_offset);
 	if (err)
@@ -76,13 +76,13 @@ int main(int argc, char *argv[])
 	if (subnode2_offset < 0)
 		FAIL("Couldn't find \"/subnode2\": %s",
 		     fdt_strerror(subnode2_offset));
-	check_getprop_typed(fdt, subnode2_offset, "prop-int", TEST_VALUE_2);
+	check_getprop_cell(fdt, subnode2_offset, "prop-int", TEST_VALUE_2);
 
 	subsubnode2_offset = fdt_path_offset(fdt, "/subnode@2/subsubnode");
 	if (subsubnode2_offset < 0)
 		FAIL("Couldn't find \"/subnode@2/subsubnode\": %s",
 		     fdt_strerror(subsubnode2_offset));
-	check_getprop_typed(fdt, subsubnode2_offset, "prop-int", TEST_VALUE_2);
+	check_getprop_cell(fdt, subsubnode2_offset, "prop-int", TEST_VALUE_2);
 
 	err = fdt_del_node(fdt, subnode2_offset);
 	if (err)
Index: dtc/tests/del_property.c
===================================================================
--- dtc.orig/tests/del_property.c	2007-11-20 10:15:51.000000000 +1100
+++ dtc/tests/del_property.c	2007-11-20 13:04:09.000000000 +1100
@@ -45,7 +45,7 @@ int main(int argc, char *argv[])
 
 	oldsize = fdt_totalsize(fdt);
 
-	intp = check_getprop_typed(fdt, 0, "prop-int", TEST_VALUE_1);
+	intp = check_getprop_cell(fdt, 0, "prop-int", TEST_VALUE_1);
 	verbose_printf("int value was 0x%08x\n", *intp);
 
 	err = fdt_delprop(fdt, 0, "prop-int");
Index: dtc/tests/find_property.c
===================================================================
--- dtc.orig/tests/find_property.c	2007-11-20 10:15:51.000000000 +1100
+++ dtc/tests/find_property.c	2007-11-20 13:04:09.000000000 +1100
@@ -35,7 +35,7 @@ int main(int argc, char *argv[])
 	test_init(argc, argv);
 	fdt = load_blob_arg(argc, argv);
 
-	check_property_typed(fdt, 0, "prop-int", TEST_VALUE_1);
+	check_property_cell(fdt, 0, "prop-int", TEST_VALUE_1);
 	check_property(fdt, 0, "prop-str", strlen(TEST_STRING_1)+1, TEST_STRING_1);
 
 	PASS();
Index: dtc/tests/getprop.c
===================================================================
--- dtc.orig/tests/getprop.c	2007-11-20 10:15:51.000000000 +1100
+++ dtc/tests/getprop.c	2007-11-20 13:04:09.000000000 +1100
@@ -36,7 +36,7 @@ int main(int argc, char *argv[])
 	test_init(argc, argv);
 	fdt = load_blob_arg(argc, argv);
 
-	check_getprop_typed(fdt, 0, "prop-int", TEST_VALUE_1);
+	check_getprop_cell(fdt, 0, "prop-int", TEST_VALUE_1);
 	check_getprop(fdt, 0, "prop-str", strlen(TEST_STRING_1)+1, TEST_STRING_1);
 
 	PASS();
Index: dtc/tests/node_offset_by_prop_value.c
===================================================================
--- dtc.orig/tests/node_offset_by_prop_value.c	2007-11-20 10:15:51.000000000 +1100
+++ dtc/tests/node_offset_by_prop_value.c	2007-11-20 13:04:09.000000000 +1100
@@ -67,9 +67,9 @@ void check_search_str(void *fdt, const c
 	va_end(ap);
 }
 
-#define check_search_val(fdt, propname, propval, ...) \
+#define check_search_cell(fdt, propname, propval, ...) \
 	{ \
-		typeof(propval) val = (propval); \
+		uint32_t val = cpu_to_fdt32(propval); \
 		check_search((fdt), (propname), &val, sizeof(val), \
 			     ##__VA_ARGS__); \
 	}
@@ -92,17 +92,17 @@ int main(int argc, char *argv[])
 	    || (subsubnode1_offset < 0) || (subsubnode2_offset < 0))
 		FAIL("Can't find required nodes");
 
-	check_search_val(fdt, "prop-int", TEST_VALUE_1, 0, subnode1_offset,
-			 subsubnode1_offset, -FDT_ERR_NOTFOUND);
+	check_search_cell(fdt, "prop-int", TEST_VALUE_1, 0, subnode1_offset,
+			  subsubnode1_offset, -FDT_ERR_NOTFOUND);
 
-	check_search_val(fdt, "prop-int", TEST_VALUE_2, subnode2_offset,
-			 subsubnode2_offset, -FDT_ERR_NOTFOUND);
+	check_search_cell(fdt, "prop-int", TEST_VALUE_2, subnode2_offset,
+			  subsubnode2_offset, -FDT_ERR_NOTFOUND);
 
 	check_search_str(fdt, "prop-str", TEST_STRING_1, 0, -FDT_ERR_NOTFOUND);
 
 	check_search_str(fdt, "prop-str", "no such string", -FDT_ERR_NOTFOUND);
 
-	check_search_val(fdt, "prop-int", TEST_VALUE_1+1, -FDT_ERR_NOTFOUND);
+	check_search_cell(fdt, "prop-int", TEST_VALUE_1+1, -FDT_ERR_NOTFOUND);
 
 	check_search(fdt, "no-such-prop", NULL, 0, -FDT_ERR_NOTFOUND);
 
Index: dtc/tests/nop_node.c
===================================================================
--- dtc.orig/tests/nop_node.c	2007-11-20 10:15:51.000000000 +1100
+++ dtc/tests/nop_node.c	2007-11-20 13:04:09.000000000 +1100
@@ -43,19 +43,19 @@ int main(int argc, char *argv[])
 	if (subnode1_offset < 0)
 		FAIL("Couldn't find \"/subnode1\": %s",
 		     fdt_strerror(subnode1_offset));
-	check_getprop_typed(fdt, subnode1_offset, "prop-int", TEST_VALUE_1);
+	check_getprop_cell(fdt, subnode1_offset, "prop-int", TEST_VALUE_1);
 
 	subnode2_offset = fdt_path_offset(fdt, "/subnode@2");
 	if (subnode2_offset < 0)
 		FAIL("Couldn't find \"/subnode2\": %s",
 		     fdt_strerror(subnode2_offset));
-	check_getprop_typed(fdt, subnode2_offset, "prop-int", TEST_VALUE_2);
+	check_getprop_cell(fdt, subnode2_offset, "prop-int", TEST_VALUE_2);
 
 	subsubnode2_offset = fdt_path_offset(fdt, "/subnode@2/subsubnode");
 	if (subsubnode2_offset < 0)
 		FAIL("Couldn't find \"/subnode@2/subsubnode\": %s",
 		     fdt_strerror(subsubnode2_offset));
-	check_getprop_typed(fdt, subsubnode2_offset, "prop-int", TEST_VALUE_2);
+	check_getprop_cell(fdt, subsubnode2_offset, "prop-int", TEST_VALUE_2);
 
 	err = fdt_nop_node(fdt, subnode1_offset);
 	if (err)
@@ -71,13 +71,13 @@ int main(int argc, char *argv[])
 	if (subnode2_offset < 0)
 		FAIL("Couldn't find \"/subnode2\": %s",
 		     fdt_strerror(subnode2_offset));
-	check_getprop_typed(fdt, subnode2_offset, "prop-int", TEST_VALUE_2);
+	check_getprop_cell(fdt, subnode2_offset, "prop-int", TEST_VALUE_2);
 
 	subsubnode2_offset = fdt_path_offset(fdt, "/subnode@2/subsubnode");
 	if (subsubnode2_offset < 0)
 		FAIL("Couldn't find \"/subnode@2/subsubnode\": %s",
 		     fdt_strerror(subsubnode2_offset));
-	check_getprop_typed(fdt, subsubnode2_offset, "prop-int", TEST_VALUE_2);
+	check_getprop_cell(fdt, subsubnode2_offset, "prop-int", TEST_VALUE_2);
 
 	err = fdt_nop_node(fdt, subnode2_offset);
 	if (err)
Index: dtc/tests/nop_property.c
===================================================================
--- dtc.orig/tests/nop_property.c	2007-11-20 10:15:51.000000000 +1100
+++ dtc/tests/nop_property.c	2007-11-20 13:04:09.000000000 +1100
@@ -41,7 +41,7 @@ int main(int argc, char *argv[])
 	test_init(argc, argv);
 	fdt = load_blob_arg(argc, argv);
 
-	intp = check_getprop_typed(fdt, 0, "prop-int", TEST_VALUE_1);
+	intp = check_getprop_cell(fdt, 0, "prop-int", TEST_VALUE_1);
 	verbose_printf("int value was 0x%08x\n", *intp);
 
 	err = fdt_nop_property(fdt, 0, "prop-int");
Index: dtc/tests/rw_tree1.c
===================================================================
--- dtc.orig/tests/rw_tree1.c	2007-11-20 10:15:51.000000000 +1100
+++ dtc/tests/rw_tree1.c	2007-11-20 13:04:09.000000000 +1100
@@ -73,27 +73,25 @@ int main(int argc, char *argv[])
 	CHECK(fdt_add_mem_rsv(fdt, TEST_ADDR_2, TEST_SIZE_2));
 
 	CHECK(fdt_setprop_string(fdt, 0, "compatible", "test_tree1"));
-	CHECK(fdt_setprop_typed(fdt, 0, "prop-int", TEST_VALUE_1));
+	CHECK(fdt_setprop_cell(fdt, 0, "prop-int", TEST_VALUE_1));
 	CHECK(fdt_setprop_string(fdt, 0, "prop-str", TEST_STRING_1));
 
 	OFF_CHECK(offset, fdt_add_subnode(fdt, 0, "subnode@1"));
 	CHECK(fdt_setprop_string(fdt, offset, "compatible", "subnode1"));
-	CHECK(fdt_setprop_typed(fdt, offset, "prop-int", TEST_VALUE_1));
+	CHECK(fdt_setprop_cell(fdt, offset, "prop-int", TEST_VALUE_1));
 	OFF_CHECK(offset, fdt_add_subnode(fdt, offset, "subsubnode"));
 	CHECK(fdt_setprop(fdt, offset, "compatible",
 			  "subsubnode1\0subsubnode", 23));
-	CHECK(fdt_setprop_typed(fdt, offset, "prop-int", TEST_VALUE_1));
+	CHECK(fdt_setprop_cell(fdt, offset, "prop-int", TEST_VALUE_1));
 
 	OFF_CHECK(offset, fdt_add_subnode(fdt, 0, "subnode@2"));
-	CHECK(fdt_setprop_typed(fdt, offset, "linux,phandle",
-				cpu_to_fdt32(PHANDLE_1)));
-	CHECK(fdt_setprop_typed(fdt, offset, "prop-int", TEST_VALUE_2));
+	CHECK(fdt_setprop_cell(fdt, offset, "linux,phandle", PHANDLE_1));
+	CHECK(fdt_setprop_cell(fdt, offset, "prop-int", TEST_VALUE_2));
 	OFF_CHECK(offset, fdt_add_subnode(fdt, offset, "subsubnode@0"));
-	CHECK(fdt_setprop_typed(fdt, offset, "linux,phandle",
-				cpu_to_fdt32(PHANDLE_2)));
+	CHECK(fdt_setprop_cell(fdt, offset, "linux,phandle", PHANDLE_2));
 	CHECK(fdt_setprop(fdt, offset, "compatible",
 			  "subsubnode2\0subsubnode", 23));
-	CHECK(fdt_setprop_typed(fdt, offset, "prop-int", TEST_VALUE_2));
+	CHECK(fdt_setprop_cell(fdt, offset, "prop-int", TEST_VALUE_2));
 
 	CHECK(fdt_pack(fdt));
 
Index: dtc/tests/setprop.c
===================================================================
--- dtc.orig/tests/setprop.c	2007-11-20 10:15:51.000000000 +1100
+++ dtc/tests/setprop.c	2007-11-20 13:04:09.000000000 +1100
@@ -52,7 +52,7 @@ int main(int argc, char *argv[])
 
 	fdt = buf;
 
-	intp = check_getprop_typed(fdt, 0, "prop-int", TEST_VALUE_1);
+	intp = check_getprop_cell(fdt, 0, "prop-int", TEST_VALUE_1);
 
 	verbose_printf("Old int value was 0x%08x\n", *intp);
 	err = fdt_setprop_string(fdt, 0, "prop-int", NEW_STRING);
Index: dtc/tests/subnode_offset.c
===================================================================
--- dtc.orig/tests/subnode_offset.c	2007-11-20 13:04:09.000000000 +1100
+++ dtc/tests/subnode_offset.c	2007-11-20 13:04:09.000000000 +1100
@@ -70,16 +70,16 @@ int main(int argc, char *argv[])
 	if (subnode1_offset == subnode2_offset)
 		FAIL("Different subnodes have same offset");
 
-	check_property_typed(fdt, subnode1_offset, "prop-int", TEST_VALUE_1);
-	check_property_typed(fdt, subnode2_offset, "prop-int", TEST_VALUE_2);
+	check_property_cell(fdt, subnode1_offset, "prop-int", TEST_VALUE_1);
+	check_property_cell(fdt, subnode2_offset, "prop-int", TEST_VALUE_2);
 
 	subsubnode1_offset = check_subnode(fdt, subnode1_offset, "subsubnode");
 	subsubnode2_offset = check_subnode(fdt, subnode2_offset, "subsubnode@0");
 	subsubnode2_offset2 = check_subnode(fdt, subnode2_offset, "subsubnode");
 
-	check_property_typed(fdt, subsubnode1_offset, "prop-int", TEST_VALUE_1);
-	check_property_typed(fdt, subsubnode2_offset, "prop-int", TEST_VALUE_2);
-	check_property_typed(fdt, subsubnode2_offset2, "prop-int", TEST_VALUE_2);
+	check_property_cell(fdt, subsubnode1_offset, "prop-int", TEST_VALUE_1);
+	check_property_cell(fdt, subsubnode2_offset, "prop-int", TEST_VALUE_2);
+	check_property_cell(fdt, subsubnode2_offset2, "prop-int", TEST_VALUE_2);
 
 	if (subsubnode2_offset != subsubnode2_offset2)
 		FAIL("Different offsets with and without unit address");
Index: dtc/tests/sw_tree1.c
===================================================================
--- dtc.orig/tests/sw_tree1.c	2007-11-20 10:15:51.000000000 +1100
+++ dtc/tests/sw_tree1.c	2007-11-20 13:04:09.000000000 +1100
@@ -55,27 +55,27 @@ int main(int argc, char *argv[])
 
 	CHECK(fdt_begin_node(fdt, ""));
 	CHECK(fdt_property_string(fdt, "compatible", "test_tree1"));
-	CHECK(fdt_property_typed(fdt, "prop-int", TEST_VALUE_1));
+	CHECK(fdt_property_cell(fdt, "prop-int", TEST_VALUE_1));
 	CHECK(fdt_property_string(fdt, "prop-str", TEST_STRING_1));
 
 	CHECK(fdt_begin_node(fdt, "subnode@1"));
 	CHECK(fdt_property_string(fdt, "compatible", "subnode1"));
-	CHECK(fdt_property_typed(fdt, "prop-int", TEST_VALUE_1));
+	CHECK(fdt_property_cell(fdt, "prop-int", TEST_VALUE_1));
 	CHECK(fdt_begin_node(fdt, "subsubnode"));
 	CHECK(fdt_property(fdt, "compatible", "subsubnode1\0subsubnode",
 			   23));
-	CHECK(fdt_property_typed(fdt, "prop-int", TEST_VALUE_1));
+	CHECK(fdt_property_cell(fdt, "prop-int", TEST_VALUE_1));
 	CHECK(fdt_end_node(fdt));
 	CHECK(fdt_end_node(fdt));
 
 	CHECK(fdt_begin_node(fdt, "subnode@2"));
-	CHECK(fdt_property_typed(fdt, "linux,phandle", cpu_to_fdt32(PHANDLE_1)));
-	CHECK(fdt_property_typed(fdt, "prop-int", TEST_VALUE_2));
+	CHECK(fdt_property_cell(fdt, "linux,phandle", PHANDLE_1));
+	CHECK(fdt_property_cell(fdt, "prop-int", TEST_VALUE_2));
 	CHECK(fdt_begin_node(fdt, "subsubnode@0"));
-	CHECK(fdt_property_typed(fdt, "linux,phandle", cpu_to_fdt32(PHANDLE_2)));
+	CHECK(fdt_property_cell(fdt, "linux,phandle", PHANDLE_2));
 	CHECK(fdt_property(fdt, "compatible", "subsubnode2\0subsubnode",
 			   23));
-	CHECK(fdt_property_typed(fdt, "prop-int", TEST_VALUE_2));
+	CHECK(fdt_property_cell(fdt, "prop-int", TEST_VALUE_2));
 	CHECK(fdt_end_node(fdt));
 	CHECK(fdt_end_node(fdt));
 
Index: dtc/tests/testdata.h
===================================================================
--- dtc.orig/tests/testdata.h	2007-11-20 10:15:51.000000000 +1100
+++ dtc/tests/testdata.h	2007-11-20 13:04:09.000000000 +1100
@@ -20,8 +20,8 @@
 #define TEST_ADDR_2	ASM_CONST_LL(123456789)
 #define TEST_SIZE_2	ASM_CONST_LL(010000)
 
-#define TEST_VALUE_1	cell_to_fdt(0xdeadbeef)
-#define TEST_VALUE_2	cell_to_fdt(123456789)
+#define TEST_VALUE_1	0xdeadbeef
+#define TEST_VALUE_2	123456789
 
 #define PHANDLE_1	0x2000
 #define PHANDLE_2	0x2001
Index: dtc/tests/tests.h
===================================================================
--- dtc.orig/tests/tests.h	2007-11-20 10:15:51.000000000 +1100
+++ dtc/tests/tests.h	2007-11-20 13:04:09.000000000 +1100
@@ -112,18 +112,18 @@ void check_mem_rsv(void *fdt, int n, uin
 
 void check_property(void *fdt, int nodeoffset, const char *name,
 		    int len, const void *val);
-#define check_property_typed(fdt, nodeoffset, name, val) \
+#define check_property_cell(fdt, nodeoffset, name, val) \
 	({ \
-		typeof(val) x = val; \
+		uint32_t x = cpu_to_fdt32(val);			      \
 		check_property(fdt, nodeoffset, name, sizeof(x), &x); \
 	})
 
 
 const void *check_getprop(void *fdt, int nodeoffset, const char *name,
 			  int len, const void *val);
-#define check_getprop_typed(fdt, nodeoffset, name, val) \
+#define check_getprop_cell(fdt, nodeoffset, name, val) \
 	({ \
-		typeof(val) x = val; \
+		uint32_t x = cpu_to_fdt32(val);			     \
 		check_getprop(fdt, nodeoffset, name, sizeof(x), &x); \
 	})
 #define check_getprop_string(fdt, nodeoffset, name, s) \
Index: dtc/tests/trees.S
===================================================================
--- dtc.orig/tests/trees.S	2007-11-20 10:15:51.000000000 +1100
+++ dtc/tests/trees.S	2007-11-20 13:04:09.000000000 +1100
@@ -50,8 +50,7 @@ tree##_rsvmap_end:		;
 
 #define PROP_INT(tree, name, val) \
 	PROPHDR(tree, name, 4) \
-	/* For ease of testing the property values go in native-endian */ \
-	.long	val		;
+	FDTLONG(val)		;
 
 #define PROP_STR(tree, name, str) \
 	PROPHDR(tree, name, 55f - 54f) \
@@ -100,11 +99,11 @@ test_tree1_struct:
 	END_NODE
 
 	BEGIN_NODE("subnode@2")
-	PROP_INT(test_tree1, phandle, cell_to_fdt(PHANDLE_1))
+	PROP_INT(test_tree1, phandle, PHANDLE_1)
 	PROP_INT(test_tree1, prop_int, TEST_VALUE_2)
 
 	BEGIN_NODE("subsubnode@0")
-	PROP_INT(test_tree1, phandle, cell_to_fdt(PHANDLE_2))
+	PROP_INT(test_tree1, phandle, PHANDLE_2)
 	PROP_STR(test_tree1, compatible, "subsubnode2\0subsubnode")
 	PROP_INT(test_tree1, prop_int, TEST_VALUE_2)
 	END_NODE

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

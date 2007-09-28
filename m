Return-Path: <dgibson@ozlabs.org>
Date: Fri, 28 Sep 2007 15:51:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: libfdt: Make unit address optional for finding nodes
Message-ID: <20070928055104.GE25743@localhost.localdomain>
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

At present, the fdt_subnode_offset() and fdt_path_offset() functions
in libfdt require the exact name of the nodes in question be passed,
including unit address.

This is contrary to traditional OF-like finddevice() behaviour, which
allows the unit address to be omitted (which is useful when the device
name is unambiguous without the address).

This patch introduces similar behaviour to
fdt_subnode_offset_namelen(), and hence to fdt_subnode_offset() and
fdt_path_offset() which are implemented in terms of the former.  The
unit address can be omitted from the given node name.  If this is
ambiguous, the first such node in the flattened tree will be selected
(this behaviour is consistent with IEEE1275 which specifies only that
an arbitrary node matching the given information be selected).

This very small change is then followed by many more diffs which
change the test examples and testcases to exercise this behaviour.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---

Jon, I initially considered making this behaviour optional,
i.e. adding a flag to subnode_offset() determining if it needed exact
matches or name-without-address matches.  I couldn't see that it was
actually any use, though.

Index: dtc/libfdt/fdt_ro.c
===================================================================
--- dtc.orig/libfdt/fdt_ro.c	2007-09-27 17:58:46.000000000 +1000
+++ dtc/libfdt/fdt_ro.c	2007-09-27 18:36:03.000000000 +1000
@@ -62,8 +62,8 @@
 			return err; \
 	}
 
-static int offset_streq(const void *fdt, int offset,
-			const char *s, int len)
+static int nodename_eq(const void *fdt, int offset,
+		       const char *s, int len)
 {
 	const char *p = fdt_offset_ptr(fdt, offset, len+1);
 
@@ -74,10 +74,12 @@ static int offset_streq(const void *fdt,
 	if (memcmp(p, s, len) != 0)
 		return 0;
 
-	if (p[len] != '\0')
+	if (p[len] == '\0')
+		return 1;
+	else if (!memchr(s, '@', len) && (p[len] == '@'))
+		return 1;
+	else
 		return 0;
-
-	return 1;
 }
 
 char *fdt_string(const void *fdt, int stroffset)
@@ -110,7 +112,7 @@ int fdt_subnode_offset_namelen(const voi
 			level++;
 			if (level != 1)
 				continue;
-			if (offset_streq(fdt, offset+FDT_TAGSIZE, name, namelen))
+			if (nodename_eq(fdt, offset+FDT_TAGSIZE, name, namelen))
 				/* Found it! */
 				return offset;
 			break;
Index: dtc/tests/trees.S
===================================================================
--- dtc.orig/tests/trees.S	2007-09-27 17:58:46.000000000 +1000
+++ dtc/tests/trees.S	2007-09-27 17:58:54.000000000 +1000
@@ -78,7 +78,7 @@ test_tree1_struct:
 	PROP_INT(test_tree1, prop_int, TEST_VALUE_1)
 	PROP_STR(test_tree1, prop_str, TEST_STRING_1)
 
-	BEGIN_NODE("subnode1")
+	BEGIN_NODE("subnode@1")
 	PROP_INT(test_tree1, prop_int, TEST_VALUE_1)
 
 	BEGIN_NODE("subsubnode")
@@ -86,10 +86,10 @@ test_tree1_struct:
 	END_NODE
 	END_NODE
 
-	BEGIN_NODE("subnode2")
+	BEGIN_NODE("subnode@2")
 	PROP_INT(test_tree1, prop_int, TEST_VALUE_2)
 
-	BEGIN_NODE("subsubnode")
+	BEGIN_NODE("subsubnode@0")
 	PROP_INT(test_tree1, prop_int, TEST_VALUE_2)
 	END_NODE
 	END_NODE
Index: dtc/tests/subnode_offset.c
===================================================================
--- dtc.orig/tests/subnode_offset.c	2007-09-27 17:58:46.000000000 +1000
+++ dtc/tests/subnode_offset.c	2007-09-27 17:58:54.000000000 +1000
@@ -48,7 +48,7 @@ int check_subnode(struct fdt_header *fdt
 
 	if (tag != FDT_BEGIN_NODE)
 		FAIL("Incorrect tag 0x%08x on property \"%s\"", tag, name);
-	if (!streq(nh->name, name))
+	if (!nodename_eq(nh->name, name))
 		FAIL("Subnode name mismatch \"%s\" instead of \"%s\"",
 		     nh->name, name);
 
@@ -59,13 +59,13 @@ int main(int argc, char *argv[])
 {
 	void *fdt;
 	int subnode1_offset, subnode2_offset;
-	int subsubnode1_offset, subsubnode2_offset;
+	int subsubnode1_offset, subsubnode2_offset, subsubnode2_offset2;
 
 	test_init(argc, argv);
 	fdt = load_blob_arg(argc, argv);
 
-	subnode1_offset = check_subnode(fdt, 0, "subnode1");
-	subnode2_offset = check_subnode(fdt, 0, "subnode2");
+	subnode1_offset = check_subnode(fdt, 0, "subnode@1");
+	subnode2_offset = check_subnode(fdt, 0, "subnode@2");
 
 	if (subnode1_offset == subnode2_offset)
 		FAIL("Different subnodes have same offset");
@@ -74,10 +74,15 @@ int main(int argc, char *argv[])
 	check_property_typed(fdt, subnode2_offset, "prop-int", TEST_VALUE_2);
 
 	subsubnode1_offset = check_subnode(fdt, subnode1_offset, "subsubnode");
-	subsubnode2_offset = check_subnode(fdt, subnode2_offset, "subsubnode");
+	subsubnode2_offset = check_subnode(fdt, subnode2_offset, "subsubnode@0");
+	subsubnode2_offset2 = check_subnode(fdt, subnode2_offset, "subsubnode");
 
 	check_property_typed(fdt, subsubnode1_offset, "prop-int", TEST_VALUE_1);
 	check_property_typed(fdt, subsubnode2_offset, "prop-int", TEST_VALUE_2);
+	check_property_typed(fdt, subsubnode2_offset2, "prop-int", TEST_VALUE_2);
+
+	if (subsubnode2_offset != subsubnode2_offset2)
+		FAIL("Different offsets with and without unit address");
 
 	PASS();
 }
Index: dtc/tests/path_offset.c
===================================================================
--- dtc.orig/tests/path_offset.c	2007-09-27 17:58:46.000000000 +1000
+++ dtc/tests/path_offset.c	2007-09-27 17:58:54.000000000 +1000
@@ -48,7 +48,7 @@ int check_subnode(void *fdt, int parent,
 
 	if (tag != FDT_BEGIN_NODE)
 		FAIL("Incorrect tag 0x%08x on property \"%s\"", tag, name);
-	if (!streq(nh->name, name))
+	if (!nodename_eq(nh->name, name))
 		FAIL("Subnode name mismatch \"%s\" instead of \"%s\"",
 		     nh->name, name);
 
@@ -61,8 +61,8 @@ int main(int argc, char *argv[])
 	int root_offset;
 	int subnode1_offset, subnode2_offset;
 	int subnode1_offset_p, subnode2_offset_p;
-	int subsubnode1_offset, subsubnode2_offset;
-	int subsubnode1_offset_p, subsubnode2_offset_p;
+	int subsubnode1_offset, subsubnode2_offset, subsubnode2_offset2;
+	int subsubnode1_offset_p, subsubnode2_offset_p, subsubnode2_offset2_p;
 
 	test_init(argc, argv);
 	fdt = load_blob_arg(argc, argv);
@@ -74,11 +74,11 @@ int main(int argc, char *argv[])
 	else if (root_offset != 0)
 		FAIL("fdt_path_offset(\"/\") returns incorrect offset %d",
 		     root_offset);
-	subnode1_offset = check_subnode(fdt, 0, "subnode1");
-	subnode2_offset = check_subnode(fdt, 0, "subnode2");
+	subnode1_offset = check_subnode(fdt, 0, "subnode@1");
+	subnode2_offset = check_subnode(fdt, 0, "subnode@2");
 
-	subnode1_offset_p = fdt_path_offset(fdt, "/subnode1");
-	subnode2_offset_p = fdt_path_offset(fdt, "/subnode2");
+	subnode1_offset_p = fdt_path_offset(fdt, "/subnode@1");
+	subnode2_offset_p = fdt_path_offset(fdt, "/subnode@2");
 
 	if (subnode1_offset != subnode1_offset_p)
 		FAIL("Mismatch between subnode_offset (%d) and path_offset (%d)",
@@ -89,10 +89,12 @@ int main(int argc, char *argv[])
 		     subnode2_offset, subnode2_offset_p);
 
 	subsubnode1_offset = check_subnode(fdt, subnode1_offset, "subsubnode");
-	subsubnode2_offset = check_subnode(fdt, subnode2_offset, "subsubnode");
+	subsubnode2_offset = check_subnode(fdt, subnode2_offset, "subsubnode@0");
+	subsubnode2_offset2 = check_subnode(fdt, subnode2_offset, "subsubnode");
 
-	subsubnode1_offset_p = fdt_path_offset(fdt, "/subnode1/subsubnode");
-	subsubnode2_offset_p = fdt_path_offset(fdt, "/subnode2/subsubnode");
+	subsubnode1_offset_p = fdt_path_offset(fdt, "/subnode@1/subsubnode");
+	subsubnode2_offset_p = fdt_path_offset(fdt, "/subnode@2/subsubnode@0");
+	subsubnode2_offset2_p = fdt_path_offset(fdt, "/subnode@2/subsubnode");
 
 	if (subsubnode1_offset != subsubnode1_offset_p)
 		FAIL("Mismatch between subnode_offset (%d) and path_offset (%d)",
Index: dtc/tests/tests.h
===================================================================
--- dtc.orig/tests/tests.h	2007-09-27 17:58:46.000000000 +1000
+++ dtc/tests/tests.h	2007-09-27 17:58:54.000000000 +1000
@@ -126,6 +126,7 @@ const void *check_getprop(void *fdt, int
 	})
 #define check_getprop_string(fdt, nodeoffset, name, s) \
 	check_getprop((fdt), (nodeoffset), (name), strlen(s)+1, (s))
+int nodename_eq(const char *s1, const char *s2);
 //void *load_blob(const char *filename);
 void *load_blob_arg(int argc, char *argv[]);
 void save_blob(const char *filename, void *blob);
Index: dtc/tests/testutils.c
===================================================================
--- dtc.orig/tests/testutils.c	2007-09-27 17:58:46.000000000 +1000
+++ dtc/tests/testutils.c	2007-09-27 17:58:54.000000000 +1000
@@ -125,6 +125,21 @@ const void *check_getprop(void *fdt, int
 	return propval;
 }
 
+int nodename_eq(const char *s1, const char *s2)
+{
+	int len = strlen(s2);
+
+	len = strlen(s2);
+	if (strncmp(s1, s2, len) != 0)
+		return 0;
+	if (s1[len] == '\0')
+		return 1;
+	else if (!memchr(s2, '@', len) && (s1[len] == '@'))
+		return 1;
+	else
+		return 0;
+}
+
 #define CHUNKSIZE	128
 
 void *load_blob(const char *filename)
Index: dtc/tests/get_name.c
===================================================================
--- dtc.orig/tests/get_name.c	2007-09-27 17:58:46.000000000 +1000
+++ dtc/tests/get_name.c	2007-09-27 17:58:54.000000000 +1000
@@ -74,10 +74,10 @@ int main(int argc, char *argv[])
 	fdt = load_blob_arg(argc, argv);
 
 	check_name(fdt, "/");
-	check_name(fdt, "/subnode1");
-	check_name(fdt, "/subnode2");
-	check_name(fdt, "/subnode1/subsubnode");
-	check_name(fdt, "/subnode2/subsubnode");
+	check_name(fdt, "/subnode@1");
+	check_name(fdt, "/subnode@2");
+	check_name(fdt, "/subnode@1/subsubnode");
+	check_name(fdt, "/subnode@2/subsubnode@0");
 
 	PASS();
 }
Index: dtc/tests/get_path.c
===================================================================
--- dtc.orig/tests/get_path.c	2007-09-27 17:58:46.000000000 +1000
+++ dtc/tests/get_path.c	2007-09-27 17:58:54.000000000 +1000
@@ -82,10 +82,10 @@ int main(int argc, char *argv[])
 	fdt = load_blob_arg(argc, argv);
 
 	check_path(fdt, "/");
-	check_path(fdt, "/subnode1");
-	check_path(fdt, "/subnode2");
-	check_path(fdt, "/subnode1/subsubnode");
-	check_path(fdt, "/subnode2/subsubnode");
+	check_path(fdt, "/subnode@1");
+	check_path(fdt, "/subnode@2");
+	check_path(fdt, "/subnode@1/subsubnode");
+	check_path(fdt, "/subnode@2/subsubnode@0");
 
 	PASS();
 }
Index: dtc/tests/supernode_atdepth_offset.c
===================================================================
--- dtc.orig/tests/supernode_atdepth_offset.c	2007-09-27 17:58:46.000000000 +1000
+++ dtc/tests/supernode_atdepth_offset.c	2007-09-27 17:58:54.000000000 +1000
@@ -135,10 +135,10 @@ int main(int argc, char *argv[])
 	fdt = load_blob_arg(argc, argv);
 
 	check_path(fdt, "/");
-	check_path(fdt, "/subnode1");
-	check_path(fdt, "/subnode2");
-	check_path(fdt, "/subnode1/subsubnode");
-	check_path(fdt, "/subnode2/subsubnode");
+	check_path(fdt, "/subnode@1");
+	check_path(fdt, "/subnode@2");
+	check_path(fdt, "/subnode@1/subsubnode");
+	check_path(fdt, "/subnode@2/subsubnode@0");
 
 	PASS();
 }
Index: dtc/tests/node_offset_by_prop_value.c
===================================================================
--- dtc.orig/tests/node_offset_by_prop_value.c	2007-09-27 17:58:46.000000000 +1000
+++ dtc/tests/node_offset_by_prop_value.c	2007-09-27 17:58:54.000000000 +1000
@@ -83,10 +83,10 @@ int main(int argc, char *argv[])
 	test_init(argc, argv);
 	fdt = load_blob_arg(argc, argv);
 
-	subnode1_offset = fdt_path_offset(fdt, "/subnode1");
-	subnode2_offset = fdt_path_offset(fdt, "/subnode2");
-	subsubnode1_offset = fdt_path_offset(fdt, "/subnode1/subsubnode");
-	subsubnode2_offset = fdt_path_offset(fdt, "/subnode2/subsubnode");
+	subnode1_offset = fdt_path_offset(fdt, "/subnode@1");
+	subnode2_offset = fdt_path_offset(fdt, "/subnode@2");
+	subsubnode1_offset = fdt_path_offset(fdt, "/subnode@1/subsubnode");
+	subsubnode2_offset = fdt_path_offset(fdt, "/subnode@2/subsubnode@0");
 
 	if ((subnode1_offset < 0) || (subnode2_offset < 0)
 	    || (subsubnode1_offset < 0) || (subsubnode2_offset < 0))
Index: dtc/tests/nop_node.c
===================================================================
--- dtc.orig/tests/nop_node.c	2007-09-27 17:58:46.000000000 +1000
+++ dtc/tests/nop_node.c	2007-09-27 17:58:54.000000000 +1000
@@ -39,21 +39,21 @@ int main(int argc, char *argv[])
 	test_init(argc, argv);
 	fdt = load_blob_arg(argc, argv);
 
-	subnode1_offset = fdt_path_offset(fdt, "/subnode1");
+	subnode1_offset = fdt_path_offset(fdt, "/subnode@1");
 	if (subnode1_offset < 0)
 		FAIL("Couldn't find \"/subnode1\": %s",
 		     fdt_strerror(subnode1_offset));
 	check_getprop_typed(fdt, subnode1_offset, "prop-int", TEST_VALUE_1);
 
-	subnode2_offset = fdt_path_offset(fdt, "/subnode2");
+	subnode2_offset = fdt_path_offset(fdt, "/subnode@2");
 	if (subnode2_offset < 0)
 		FAIL("Couldn't find \"/subnode2\": %s",
 		     fdt_strerror(subnode2_offset));
 	check_getprop_typed(fdt, subnode2_offset, "prop-int", TEST_VALUE_2);
 
-	subsubnode2_offset = fdt_path_offset(fdt, "/subnode2/subsubnode");
+	subsubnode2_offset = fdt_path_offset(fdt, "/subnode@2/subsubnode");
 	if (subsubnode2_offset < 0)
-		FAIL("Couldn't find \"/subnode2/subsubnode\": %s",
+		FAIL("Couldn't find \"/subnode@2/subsubnode\": %s",
 		     fdt_strerror(subsubnode2_offset));
 	check_getprop_typed(fdt, subsubnode2_offset, "prop-int", TEST_VALUE_2);
 
@@ -61,21 +61,21 @@ int main(int argc, char *argv[])
 	if (err)
 		FAIL("fdt_nop_node(subnode1): %s", fdt_strerror(err));
 
-	subnode1_offset = fdt_path_offset(fdt, "/subnode1");
+	subnode1_offset = fdt_path_offset(fdt, "/subnode@1");
 	if (subnode1_offset != -FDT_ERR_NOTFOUND)
 		FAIL("fdt_path_offset(subnode1) returned \"%s\" instead of \"%s\"",
 		     fdt_strerror(subnode1_offset),
 		     fdt_strerror(-FDT_ERR_NOTFOUND));
 
-	subnode2_offset = fdt_path_offset(fdt, "/subnode2");
+	subnode2_offset = fdt_path_offset(fdt, "/subnode@2");
 	if (subnode2_offset < 0)
 		FAIL("Couldn't find \"/subnode2\": %s",
 		     fdt_strerror(subnode2_offset));
 	check_getprop_typed(fdt, subnode2_offset, "prop-int", TEST_VALUE_2);
 
-	subsubnode2_offset = fdt_path_offset(fdt, "/subnode2/subsubnode");
+	subsubnode2_offset = fdt_path_offset(fdt, "/subnode@2/subsubnode");
 	if (subsubnode2_offset < 0)
-		FAIL("Couldn't find \"/subnode2/subsubnode\": %s",
+		FAIL("Couldn't find \"/subnode@2/subsubnode\": %s",
 		     fdt_strerror(subsubnode2_offset));
 	check_getprop_typed(fdt, subsubnode2_offset, "prop-int", TEST_VALUE_2);
 
@@ -83,19 +83,19 @@ int main(int argc, char *argv[])
 	if (err)
 		FAIL("fdt_nop_node(subnode2): %s", fdt_strerror(err));
 
-	subnode1_offset = fdt_path_offset(fdt, "/subnode1");
+	subnode1_offset = fdt_path_offset(fdt, "/subnode@1");
 	if (subnode1_offset != -FDT_ERR_NOTFOUND)
 		FAIL("fdt_path_offset(subnode1) returned \"%s\" instead of \"%s\"",
 		     fdt_strerror(subnode1_offset),
 		     fdt_strerror(-FDT_ERR_NOTFOUND));
 
-	subnode2_offset = fdt_path_offset(fdt, "/subnode2");
+	subnode2_offset = fdt_path_offset(fdt, "/subnode@2");
 	if (subnode2_offset != -FDT_ERR_NOTFOUND)
 		FAIL("fdt_path_offset(subnode2) returned \"%s\" instead of \"%s\"",
 		     fdt_strerror(subnode2_offset),
 		     fdt_strerror(-FDT_ERR_NOTFOUND));
 
-	subsubnode2_offset = fdt_path_offset(fdt, "/subnode2/subsubnode");
+	subsubnode2_offset = fdt_path_offset(fdt, "/subnode@2/subsubnode");
 	if (subsubnode2_offset != -FDT_ERR_NOTFOUND)
 		FAIL("fdt_path_offset(subsubnode2) returned \"%s\" instead of \"%s\"",
 		     fdt_strerror(subsubnode2_offset),
Index: dtc/tests/notfound.c
===================================================================
--- dtc.orig/tests/notfound.c	2007-09-27 17:58:46.000000000 +1000
+++ dtc/tests/notfound.c	2007-09-27 17:58:54.000000000 +1000
@@ -53,7 +53,7 @@ int main(int argc, char *argv[])
 	val = fdt_getprop(fdt, 0, "nonexistant-property", &lenerr);
 	check_error("fdt_getprop(\"nonexistant-property\"", lenerr);
 
-	subnode1_offset = fdt_subnode_offset(fdt, 0, "subnode1");
+	subnode1_offset = fdt_subnode_offset(fdt, 0, "subnode@1");
 	if (subnode1_offset < 0)
 		FAIL("Couldn't find subnode1: %s", fdt_strerror(subnode1_offset));
 
Index: dtc/tests/parent_offset.c
===================================================================
--- dtc.orig/tests/parent_offset.c	2007-09-27 17:58:46.000000000 +1000
+++ dtc/tests/parent_offset.c	2007-09-27 17:58:54.000000000 +1000
@@ -77,10 +77,10 @@ int main(int argc, char *argv[])
 	test_init(argc, argv);
 	fdt = load_blob_arg(argc, argv);
 
-	check_path(fdt, "/subnode1");
-	check_path(fdt, "/subnode2");
-	check_path(fdt, "/subnode1/subsubnode");
-	check_path(fdt, "/subnode2/subsubnode");
+	check_path(fdt, "/subnode@1");
+	check_path(fdt, "/subnode@2");
+	check_path(fdt, "/subnode@1/subsubnode");
+	check_path(fdt, "/subnode@2/subsubnode@0");
 	err = fdt_parent_offset(fdt, 0);
 	if (err != -FDT_ERR_NOTFOUND)
 		FAIL("fdt_parent_offset(/) returns %d instead of "
Index: dtc/tests/del_node.c
===================================================================
--- dtc.orig/tests/del_node.c	2007-09-27 17:58:46.000000000 +1000
+++ dtc/tests/del_node.c	2007-09-27 17:58:54.000000000 +1000
@@ -42,21 +42,21 @@ int main(int argc, char *argv[])
 
 	oldsize = fdt_totalsize(fdt);
 
-	subnode1_offset = fdt_path_offset(fdt, "/subnode1");
+	subnode1_offset = fdt_path_offset(fdt, "/subnode@1");
 	if (subnode1_offset < 0)
-		FAIL("Couldn't find \"/subnode1\": %s",
+		FAIL("Couldn't find \"/subnode@1\": %s",
 		     fdt_strerror(subnode1_offset));
 	check_getprop_typed(fdt, subnode1_offset, "prop-int", TEST_VALUE_1);
 
-	subnode2_offset = fdt_path_offset(fdt, "/subnode2");
+	subnode2_offset = fdt_path_offset(fdt, "/subnode@2");
 	if (subnode2_offset < 0)
-		FAIL("Couldn't find \"/subnode2\": %s",
+		FAIL("Couldn't find \"/subnode@2\": %s",
 		     fdt_strerror(subnode2_offset));
 	check_getprop_typed(fdt, subnode2_offset, "prop-int", TEST_VALUE_2);
 
-	subsubnode2_offset = fdt_path_offset(fdt, "/subnode2/subsubnode");
+	subsubnode2_offset = fdt_path_offset(fdt, "/subnode@2/subsubnode");
 	if (subsubnode2_offset < 0)
-		FAIL("Couldn't find \"/subnode2/subsubnode\": %s",
+		FAIL("Couldn't find \"/subnode@2/subsubnode\": %s",
 		     fdt_strerror(subsubnode2_offset));
 	check_getprop_typed(fdt, subsubnode2_offset, "prop-int", TEST_VALUE_2);
 
@@ -64,21 +64,21 @@ int main(int argc, char *argv[])
 	if (err)
 		FAIL("fdt_del_node(subnode1): %s", fdt_strerror(err));
 
-	subnode1_offset = fdt_path_offset(fdt, "/subnode1");
+	subnode1_offset = fdt_path_offset(fdt, "/subnode@1");
 	if (subnode1_offset != -FDT_ERR_NOTFOUND)
 		FAIL("fdt_path_offset(subnode1) returned \"%s\" instead of \"%s\"",
 		     fdt_strerror(subnode1_offset),
 		     fdt_strerror(-FDT_ERR_NOTFOUND));
 
-	subnode2_offset = fdt_path_offset(fdt, "/subnode2");
+	subnode2_offset = fdt_path_offset(fdt, "/subnode@2");
 	if (subnode2_offset < 0)
 		FAIL("Couldn't find \"/subnode2\": %s",
 		     fdt_strerror(subnode2_offset));
 	check_getprop_typed(fdt, subnode2_offset, "prop-int", TEST_VALUE_2);
 
-	subsubnode2_offset = fdt_path_offset(fdt, "/subnode2/subsubnode");
+	subsubnode2_offset = fdt_path_offset(fdt, "/subnode@2/subsubnode");
 	if (subsubnode2_offset < 0)
-		FAIL("Couldn't find \"/subnode2/subsubnode\": %s",
+		FAIL("Couldn't find \"/subnode@2/subsubnode\": %s",
 		     fdt_strerror(subsubnode2_offset));
 	check_getprop_typed(fdt, subsubnode2_offset, "prop-int", TEST_VALUE_2);
 
@@ -86,19 +86,19 @@ int main(int argc, char *argv[])
 	if (err)
 		FAIL("fdt_del_node(subnode2): %s", fdt_strerror(err));
 
-	subnode1_offset = fdt_path_offset(fdt, "/subnode1");
+	subnode1_offset = fdt_path_offset(fdt, "/subnode@1");
 	if (subnode1_offset != -FDT_ERR_NOTFOUND)
 		FAIL("fdt_path_offset(subnode1) returned \"%s\" instead of \"%s\"",
 		     fdt_strerror(subnode1_offset),
 		     fdt_strerror(-FDT_ERR_NOTFOUND));
 
-	subnode2_offset = fdt_path_offset(fdt, "/subnode2");
+	subnode2_offset = fdt_path_offset(fdt, "/subnode@2");
 	if (subnode2_offset != -FDT_ERR_NOTFOUND)
 		FAIL("fdt_path_offset(subnode2) returned \"%s\" instead of \"%s\"",
 		     fdt_strerror(subnode2_offset),
 		     fdt_strerror(-FDT_ERR_NOTFOUND));
 
-	subsubnode2_offset = fdt_path_offset(fdt, "/subnode2/subsubnode");
+	subsubnode2_offset = fdt_path_offset(fdt, "/subnode@2/subsubnode");
 	if (subsubnode2_offset != -FDT_ERR_NOTFOUND)
 		FAIL("fdt_path_offset(subsubnode2) returned \"%s\" instead of \"%s\"",
 		     fdt_strerror(subsubnode2_offset),
Index: dtc/tests/sw_tree1.c
===================================================================
--- dtc.orig/tests/sw_tree1.c	2007-09-27 17:58:46.000000000 +1000
+++ dtc/tests/sw_tree1.c	2007-09-27 17:58:54.000000000 +1000
@@ -54,16 +54,16 @@ int main(int argc, char *argv[])
 	CHECK(fdt_property_typed(fdt, "prop-int", TEST_VALUE_1));
 	CHECK(fdt_property_string(fdt, "prop-str", TEST_STRING_1));
 
-	CHECK(fdt_begin_node(fdt, "subnode1"));
+	CHECK(fdt_begin_node(fdt, "subnode@1"));
 	CHECK(fdt_property_typed(fdt, "prop-int", TEST_VALUE_1));
 	CHECK(fdt_begin_node(fdt, "subsubnode"));
 	CHECK(fdt_property_typed(fdt, "prop-int", TEST_VALUE_1));
 	CHECK(fdt_end_node(fdt));
 	CHECK(fdt_end_node(fdt));
 
-	CHECK(fdt_begin_node(fdt, "subnode2"));
+	CHECK(fdt_begin_node(fdt, "subnode@2"));
 	CHECK(fdt_property_typed(fdt, "prop-int", TEST_VALUE_2));
-	CHECK(fdt_begin_node(fdt, "subsubnode"));
+	CHECK(fdt_begin_node(fdt, "subsubnode@0"));
 	CHECK(fdt_property_typed(fdt, "prop-int", TEST_VALUE_2));
 	CHECK(fdt_end_node(fdt));
 	CHECK(fdt_end_node(fdt));
Index: dtc/tests/rw_tree1.c
===================================================================
--- dtc.orig/tests/rw_tree1.c	2007-09-27 17:58:46.000000000 +1000
+++ dtc/tests/rw_tree1.c	2007-09-27 17:58:54.000000000 +1000
@@ -72,14 +72,14 @@ int main(int argc, char *argv[])
 	CHECK(fdt_setprop_typed(fdt, 0, "prop-int", TEST_VALUE_1));
 	CHECK(fdt_setprop_string(fdt, 0, "prop-str", TEST_STRING_1));
 
-	OFF_CHECK(offset, fdt_add_subnode(fdt, 0, "subnode1"));
+	OFF_CHECK(offset, fdt_add_subnode(fdt, 0, "subnode@1"));
 	CHECK(fdt_setprop_typed(fdt, offset, "prop-int", TEST_VALUE_1));
 	OFF_CHECK(offset, fdt_add_subnode(fdt, offset, "subsubnode"));
 	CHECK(fdt_setprop_typed(fdt, offset, "prop-int", TEST_VALUE_1));
 
-	OFF_CHECK(offset, fdt_add_subnode(fdt, 0, "subnode2"));
+	OFF_CHECK(offset, fdt_add_subnode(fdt, 0, "subnode@2"));
 	CHECK(fdt_setprop_typed(fdt, offset, "prop-int", TEST_VALUE_2));
-	OFF_CHECK(offset, fdt_add_subnode(fdt, offset, "subsubnode"));
+	OFF_CHECK(offset, fdt_add_subnode(fdt, offset, "subsubnode@0"));
 
 	CHECK(fdt_setprop_typed(fdt, offset, "prop-int", TEST_VALUE_2));
 
Index: dtc/tests/test_tree1.dts
===================================================================
--- dtc.orig/tests/test_tree1.dts	2007-09-27 17:58:46.000000000 +1000
+++ dtc/tests/test_tree1.dts	2007-09-27 17:58:54.000000000 +1000
@@ -2,7 +2,7 @@
 	prop-int = <deadbeef>;
 	prop-str = "hello world";
 
-	subnode1 {
+	subnode@1 {
 		prop-int = <deadbeef>;
 
 		subsubnode {
@@ -10,10 +10,10 @@
 		};
 	};
 
-	subnode2 {
+	subnode@2 {
 		prop-int = <abcd1234>;
 
-		subsubnode {
+		subsubnode@0 {
 			prop-int = <abcd1234>;
 		};
 	};

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

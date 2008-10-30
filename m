Return-Path: <dgibson@ozlabs.org>
Date: Thu, 30 Oct 2008 13:41:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: libfdt: Fix bug in fdt_subnode_offset_namelen()
Message-ID: <20081030024108.GC17505@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There's currently an off-by-one bug in fdt_subnode_offset_namelen()
which causes it to keep searching after it's finished the subnodes of
the given parent, and into the subnodes of siblings of the original
node which come after it in the tree.

This patch fixes the bug.  It also extends the subnode_offset testcase
(updating all of the 'test_tree1' example trees in the process) to
catch it.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/tests/test_tree1.dts
===================================================================
--- dtc.orig/tests/test_tree1.dts	2008-10-30 12:57:46.000000000 +1100
+++ dtc/tests/test_tree1.dts	2008-10-30 13:00:49.000000000 +1100
@@ -16,6 +16,9 @@
 			compatible = "subsubnode1", "subsubnode";
 			prop-int = <0xdeadbeef>;
 		};
+
+		ss1 {
+		};
 	};
 
 	subnode@2 {
@@ -27,5 +30,8 @@
 			compatible = "subsubnode2", "subsubnode";
 			prop-int = <0726746425>;
 		};
+
+		ss2 {
+		};
 	};
 };
Index: dtc/tests/subnode_offset.c
===================================================================
--- dtc.orig/tests/subnode_offset.c	2008-10-30 12:58:04.000000000 +1100
+++ dtc/tests/subnode_offset.c	2008-10-30 13:14:26.000000000 +1100
@@ -60,6 +60,7 @@ int main(int argc, char *argv[])
 	void *fdt;
 	int subnode1_offset, subnode2_offset;
 	int subsubnode1_offset, subsubnode2_offset, subsubnode2_offset2;
+	int ss11_off, ss12_off, ss21_off, ss22_off;
 
 	test_init(argc, argv);
 	fdt = load_blob_arg(argc, argv);
@@ -84,5 +85,15 @@ int main(int argc, char *argv[])
 	if (subsubnode2_offset != subsubnode2_offset2)
 		FAIL("Different offsets with and without unit address");
 
+	ss11_off = check_subnode(fdt, subnode1_offset, "ss1");
+	ss21_off = fdt_subnode_offset(fdt, subnode2_offset, "ss1");
+	if (ss21_off != -FDT_ERR_NOTFOUND)
+		FAIL("Incorrectly found ss1 in subnode2");
+
+	ss12_off = fdt_subnode_offset(fdt, subnode1_offset, "ss2");
+	if (ss12_off != -FDT_ERR_NOTFOUND)
+		FAIL("Incorrectly found ss2 in subnode1");
+	ss22_off = check_subnode(fdt, subnode2_offset, "ss2");
+
 	PASS();
 }
Index: dtc/tests/trees.S
===================================================================
--- dtc.orig/tests/trees.S	2008-10-30 13:04:34.000000000 +1100
+++ dtc/tests/trees.S	2008-10-30 13:05:15.000000000 +1100
@@ -96,6 +96,10 @@ test_tree1_struct:
 	PROP_STR(test_tree1, compatible, "subsubnode1\0subsubnode")
 	PROP_INT(test_tree1, prop_int, TEST_VALUE_1)
 	END_NODE
+
+	BEGIN_NODE("ss1")
+	END_NODE
+
 	END_NODE
 
 	BEGIN_NODE("subnode@2")
@@ -107,6 +111,10 @@ test_tree1_struct:
 	PROP_STR(test_tree1, compatible, "subsubnode2\0subsubnode")
 	PROP_INT(test_tree1, prop_int, TEST_VALUE_2)
 	END_NODE
+
+	BEGIN_NODE("ss2")
+	END_NODE
+
 	END_NODE
 
 	END_NODE
Index: dtc/tests/sw_tree1.c
===================================================================
--- dtc.orig/tests/sw_tree1.c	2008-10-30 13:05:44.000000000 +1100
+++ dtc/tests/sw_tree1.c	2008-10-30 13:06:16.000000000 +1100
@@ -66,6 +66,8 @@ int main(int argc, char *argv[])
 			   23));
 	CHECK(fdt_property_cell(fdt, "prop-int", TEST_VALUE_1));
 	CHECK(fdt_end_node(fdt));
+	CHECK(fdt_begin_node(fdt, "ss1"));
+	CHECK(fdt_end_node(fdt));
 	CHECK(fdt_end_node(fdt));
 
 	CHECK(fdt_begin_node(fdt, "subnode@2"));
@@ -77,6 +79,9 @@ int main(int argc, char *argv[])
 			   23));
 	CHECK(fdt_property_cell(fdt, "prop-int", TEST_VALUE_2));
 	CHECK(fdt_end_node(fdt));
+	CHECK(fdt_begin_node(fdt, "ss2"));
+	CHECK(fdt_end_node(fdt));
+
 	CHECK(fdt_end_node(fdt));
 
 	CHECK(fdt_end_node(fdt));
Index: dtc/tests/rw_tree1.c
===================================================================
--- dtc.orig/tests/rw_tree1.c	2008-10-30 13:07:29.000000000 +1100
+++ dtc/tests/rw_tree1.c	2008-10-30 13:10:16.000000000 +1100
@@ -50,7 +50,7 @@ int main(int argc, char *argv[])
 {
 	void *fdt;
 	int err;
-	int offset;
+	int offset, s1, s2;
 
 	test_init(argc, argv);
 
@@ -77,21 +77,25 @@ int main(int argc, char *argv[])
 	CHECK(fdt_setprop_string(fdt, 0, "prop-str", TEST_STRING_1));
 
 	OFF_CHECK(offset, fdt_add_subnode(fdt, 0, "subnode@1"));
-	CHECK(fdt_setprop_string(fdt, offset, "compatible", "subnode1"));
-	CHECK(fdt_setprop_cell(fdt, offset, "prop-int", TEST_VALUE_1));
-	OFF_CHECK(offset, fdt_add_subnode(fdt, offset, "subsubnode"));
+	s1 = offset;
+	CHECK(fdt_setprop_string(fdt, s1, "compatible", "subnode1"));
+	CHECK(fdt_setprop_cell(fdt, s1, "prop-int", TEST_VALUE_1));
+	OFF_CHECK(offset, fdt_add_subnode(fdt, s1, "subsubnode"));
 	CHECK(fdt_setprop(fdt, offset, "compatible",
 			  "subsubnode1\0subsubnode", 23));
 	CHECK(fdt_setprop_cell(fdt, offset, "prop-int", TEST_VALUE_1));
+	OFF_CHECK(offset, fdt_add_subnode(fdt, s1, "ss1"));
 
 	OFF_CHECK(offset, fdt_add_subnode(fdt, 0, "subnode@2"));
-	CHECK(fdt_setprop_cell(fdt, offset, "linux,phandle", PHANDLE_1));
-	CHECK(fdt_setprop_cell(fdt, offset, "prop-int", TEST_VALUE_2));
-	OFF_CHECK(offset, fdt_add_subnode(fdt, offset, "subsubnode@0"));
+	s2 = offset;
+	CHECK(fdt_setprop_cell(fdt, s2, "linux,phandle", PHANDLE_1));
+	CHECK(fdt_setprop_cell(fdt, s2, "prop-int", TEST_VALUE_2));
+	OFF_CHECK(offset, fdt_add_subnode(fdt, s2, "subsubnode@0"));
 	CHECK(fdt_setprop_cell(fdt, offset, "linux,phandle", PHANDLE_2));
 	CHECK(fdt_setprop(fdt, offset, "compatible",
 			  "subsubnode2\0subsubnode", 23));
 	CHECK(fdt_setprop_cell(fdt, offset, "prop-int", TEST_VALUE_2));
+	OFF_CHECK(offset, fdt_add_subnode(fdt, s2, "ss2"));
 
 	CHECK(fdt_pack(fdt));
 
Index: dtc/libfdt/fdt_ro.c
===================================================================
--- dtc.orig/libfdt/fdt_ro.c	2008-10-30 13:19:28.000000000 +1100
+++ dtc/libfdt/fdt_ro.c	2008-10-30 13:25:51.000000000 +1100
@@ -108,12 +108,12 @@ int fdt_num_mem_rsv(const void *fdt)
 int fdt_subnode_offset_namelen(const void *fdt, int offset,
 			       const char *name, int namelen)
 {
-	int depth;
+	int depth = 0;
 
 	FDT_CHECK_HEADER(fdt);
 
-	for (depth = 0;
-	     offset >= 0;
+	for (depth = 0, offset = fdt_next_node(fdt, offset, &depth);
+	     (offset >= 0) && (depth > 0);
 	     offset = fdt_next_node(fdt, offset, &depth)) {
 		if (depth < 0)
 			return -FDT_ERR_NOTFOUND;
@@ -122,7 +122,10 @@ int fdt_subnode_offset_namelen(const voi
 			return offset;
 	}
 
-	return offset; /* error */
+	if (offset < 0)
+		return offset; /* error */
+	else
+		return -FDT_ERR_NOTFOUND;
 }
 
 int fdt_subnode_offset(const void *fdt, int parentoffset,
Index: dtc/tests/test_tree1_dts0.dts
===================================================================
--- dtc.orig/tests/test_tree1_dts0.dts	2008-10-30 13:34:45.000000000 +1100
+++ dtc/tests/test_tree1_dts0.dts	2008-10-30 13:35:05.000000000 +1100
@@ -16,6 +16,9 @@
 			compatible = "subsubnode1", "subsubnode";
 			prop-int = < 0xdeadbeef>;
 		};
+
+		ss1 {
+		};
 	};
 
 	subnode@2 {
@@ -27,5 +30,8 @@
 			compatible = "subsubnode2", "subsubnode";
 			prop-int = < 0726746425>;
 		};
+
+		ss2 {
+		};
 	};
 };
Index: dtc/tests/include1.dts
===================================================================
--- dtc.orig/tests/include1.dts	2008-10-30 13:36:39.000000000 +1100
+++ dtc/tests/include1.dts	2008-10-30 13:36:52.000000000 +1100
@@ -19,5 +19,8 @@
 			compatible = "subsubnode2", "subsubnode";
 			prop-int = <0726746425>;
 		};
+
+		ss2 {
+		};
 	};
 };
Index: dtc/tests/include7.dts
===================================================================
--- dtc.orig/tests/include7.dts	2008-10-30 13:36:09.000000000 +1100
+++ dtc/tests/include7.dts	2008-10-30 13:36:27.000000000 +1100
@@ -6,4 +6,7 @@
 			compatible = "subsubnode1", "subsubnode";
 			prop-int = <0xdeadbeef>;
 		};
+
+		ss1 {
+		};
 	};

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

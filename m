Return-Path: <dgibson@ozlabs.org>
Date: Mon, 5 Nov 2007 14:29:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: libfdt: Add more documentation (patch the fourth)
Message-ID: <20071105032937.GB21064@localhost.localdomain>
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

This patch documents a few more functions in libfdt.h.  It also makes
a slight update to the description of the FDT_ERR_INTERNAL error code.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/libfdt/libfdt.h
===================================================================
--- dtc.orig/libfdt/libfdt.h	2007-11-05 14:08:10.000000000 +1100
+++ dtc/libfdt/libfdt.h	2007-11-05 14:23:17.000000000 +1100
@@ -110,7 +110,8 @@
 /* "Can't happen" error indicating a bug in libfdt */
 #define FDT_ERR_INTERNAL	12
 	/* FDT_ERR_INTERNAL: libfdt has failed an internal assertion.
-	 * Indicates a bug in libfdt itself. */
+	 * Should never be returned, if it is, it indicates a bug in
+	 * libfdt itself. */
 
 #define FDT_ERR_MAX		12
 
@@ -437,9 +438,81 @@ static inline void *fdt_getprop_w(void *
  */
 int fdt_get_path(const void *fdt, int nodeoffset, char *buf, int buflen);
 
+/**
+ * fdt_supernode_atdepth_offset - find a specific ancestor of a node
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose parent to find
+ * @supernodedepth: depth of the ancestor to find
+ * @nodedepth: pointer to an integer variable (will be overwritten) or NULL
+ *
+ * fdt_supernode_atdepth_offset() finds an ancestor of the given node
+ * at a specific depth from the root (where the root itself has depth
+ * 0, its immediate subnodes depth 1 and so forth).  So
+ *	fdt_supernode_atdepth_offset(fdt, nodeoffset, 0, NULL);
+ * will always return 0, the offset of the root node.  If the node at
+ * nodeoffset has depth D, then:
+ *	fdt_supernode_atdepth_offset(fdt, nodeoffset, D, NULL);
+ * will return nodeoffset itself.
+ *
+ * NOTE: This function is expensive, as it must scan the device tree
+ * structure from the start to nodeoffset.
+ *
+ * returns:
+
+ *	structure block offset of the node at node offset's ancestor
+ *		of depth supernodedepth (>=0), on success
+ * 	-FDT_ERR_BADOFFSET, nodeoffset does not refer to a BEGIN_NODE tag
+*	-FDT_ERR_NOTFOUND, supernodedepth was greater than the depth of nodeoffset
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE, standard meanings
+ */
 int fdt_supernode_atdepth_offset(const void *fdt, int nodeoffset,
 				 int supernodedepth, int *nodedepth);
+
+/**
+ * fdt_node_depth - find the depth of a given node
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose parent to find
+ *
+ * fdt_node_depth() finds the depth of a given node.  The root node
+ * has depth 0, its immediate subnodes depth 1 and so forth.
+ *
+ * NOTE: This function is expensive, as it must scan the device tree
+ * structure from the start to nodeoffset.
+ *
+ * returns:
+ *	depth of the node at nodeoffset (>=0), on success
+ * 	-FDT_ERR_BADOFFSET, nodeoffset does not refer to a BEGIN_NODE tag
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE, standard meanings
+ */
 int fdt_node_depth(const void *fdt, int nodeoffset);
+
+/**
+ * fdt_parent_offset - find the parent of a given node
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose parent to find
+ *
+ * fdt_parent_offset() locates the parent node of a given node (that
+ * is, it finds the offset of the node which contains the node at
+ * nodeoffset as a subnode).
+ *
+ * NOTE: This function is expensive, as it must scan the device tree
+ * structure from the start to nodeoffset, *twice*.
+ *
+ * returns:
+ *	stucture block offset of the parent of the node at nodeoffset
+ *		(>=0), on success
+ * 	-FDT_ERR_BADOFFSET, nodeoffset does not refer to a BEGIN_NODE tag
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE, standard meanings
+ */
 int fdt_parent_offset(const void *fdt, int nodeoffset);
 
 int fdt_node_offset_by_prop_value(const void *fdt, int startoffset,

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

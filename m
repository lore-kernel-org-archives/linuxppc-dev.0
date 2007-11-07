Return-Path: <dgibson@ozlabs.org>
Date: Wed, 7 Nov 2007 11:54:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: libfdt: Add more documentation (path the fifth)
Message-ID: <20071107005414.GE553@localhost.localdomain>
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

This patch documents a few more functions in libfdt.h.  All the
read-only functions are now documented.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/libfdt/libfdt.h
===================================================================
--- dtc.orig/libfdt/libfdt.h	2007-11-06 10:37:44.000000000 +1100
+++ dtc/libfdt/libfdt.h	2007-11-07 11:52:27.000000000 +1100
@@ -515,12 +515,107 @@
  */
 int fdt_parent_offset(const void *fdt, int nodeoffset);
 
+/**
+ * fdt_node_offset_by_prop_value - find nodes with a given property value
+ * @fdt: pointer to the device tree blob
+ * @startoffset: only find nodes after this offset
+ * @propname: property name to check
+ * @propval: property value to search for
+ * @proplen: length of the value in propval
+ *
+ * fdt_node_offset_by_prop_value() returns the offset of the first
+ * node after startoffset, which has a property named propname whose
+ * value is of length proplen and has value equal to propval; or if
+ * startoffset is -1, the very first such node in the tree.
+ *
+ * To iterate through all nodes matching the criterion, the following
+ * idiom can be used:
+ *	offset = fdt_node_offset_by_prop_value(fdt, -1, propname,
+ *					       propval, proplen);
+ *	while (offset != -FDT_ERR_NOTFOUND) {
+ *		// other code here
+ *		offset = fdt_node_offset_by_prop_value(fdt, offset, propname,
+ *						       propval, proplen);
+ *	}
+ *
+ * Note the -1 in the first call to the function, if 0 is used here
+ * instead, the function will never locate the root node, even if it
+ * matches the criterion.
+ *
+ * returns:
+ *	structure block offset of the located node (>= 0, >startoffset),
+ *		 on success
+ *	-FDT_ERR_NOTFOUND, no node matching the criterion exists in the
+ *		tree after startoffset
+ * 	-FDT_ERR_BADOFFSET, nodeoffset does not refer to a BEGIN_NODE tag
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE, standard meanings
+ */
 int fdt_node_offset_by_prop_value(const void *fdt, int startoffset,
 				  const char *propname,
 				  const void *propval, int proplen);
 
+/**
+ * fdt_node_check_compatible: check a node's compatible property
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of a tree node
+ * @compatible: string to match against
+ *
+ *
+ * fdt_node_check_compatible() returns 0 if the given node contains a
+ * 'compatible' property with the given string as one of its elements,
+ * it returns non-zero otherwise, or on error.
+ *
+ * returns:
+ *	0, if the node has a 'compatible' property listing the given string
+ *	1, if the node has a 'compatible' property, but it does not list
+ *		the given string
+ *	-FDT_ERR_NOTFOUND, if the given node has no 'compatible' property
+ * 	-FDT_ERR_BADOFFSET, if nodeoffset does not refer to a BEGIN_NODE tag
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE, standard meanings
+ */
 int fdt_node_check_compatible(const void *fdt, int nodeoffset,
 			      const char *compatible);
+
+/**
+ * fdt_node_offset_by_compatible - find nodes with a given 'compatible' value
+ * @fdt: pointer to the device tree blob
+ * @startoffset: only find nodes after this offset
+ * @compatible: 'compatible' string to match against
+ *
+ * fdt_node_offset_by_compatible() returns the offset of the first
+ * node after startoffset, which has a 'compatible' property which
+ * lists the given compatible string; or if startoffset is -1, the
+ * very first such node in the tree.
+ *
+ * To iterate through all nodes matching the criterion, the following
+ * idiom can be used:
+ *	offset = fdt_node_offset_by_compatible(fdt, -1, compatible);
+ *	while (offset != -FDT_ERR_NOTFOUND) {
+ *		// other code here
+ *		offset = fdt_node_offset_by_compatible(fdt, offset, compatible);
+ *	}
+ *
+ * Note the -1 in the first call to the function, if 0 is used here
+ * instead, the function will never locate the root node, even if it
+ * matches the criterion.
+ *
+ * returns:
+ *	structure block offset of the located node (>= 0, >startoffset),
+ *		 on success
+ *	-FDT_ERR_NOTFOUND, no node matching the criterion exists in the
+ *		tree after startoffset
+ * 	-FDT_ERR_BADOFFSET, nodeoffset does not refer to a BEGIN_NODE tag
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE, standard meanings
+ */
 int fdt_node_offset_by_compatible(const void *fdt, int startoffset,
 				  const char *compatible);
 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

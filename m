Return-Path: <dgibson@ozlabs.org>
Date: Mon, 17 Dec 2007 14:41:52 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: libfdt: Add more documentation (patch the sixth)
Message-ID: <20071217034152.GA2973@localhost.localdomain>
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

This patch adds some more documenting comments to libfdt.h.
Specifically this documents all the write-in-place functions.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/libfdt/libfdt.h
===================================================================
--- dtc.orig/libfdt/libfdt.h	2007-12-11 14:23:09.000000000 +1100
+++ dtc/libfdt/libfdt.h	2007-12-11 14:40:11.000000000 +1100
@@ -655,8 +655,65 @@ int fdt_node_offset_by_compatible(const 
 /* Write-in-place functions                                           */
 /**********************************************************************/
 
+/**
+ * fdt_setprop_inplace - change a property's value, but not its size
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to change
+ * @name: name of the property to change
+ * @val: pointer to data to replace the property value with
+ * @len: length of the property value
+ *
+ * fdt_setprop_inplace() replaces the value of a given property with
+ * the data in val, of length len.  This function cannot change the
+ * size of a property, and so will only work if len is equal to the
+ * current length of the property.
+ *
+ * This function will alter only the bytes in the blob which contain
+ * the given property value, and will not alter or move any other part
+ * of the tree.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOSPACE, if len is not equal to the property's current length
+ *	-FDT_ERR_NOTFOUND, node does not have the named property
+ *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
 int fdt_setprop_inplace(void *fdt, int nodeoffset, const char *name,
 			const void *val, int len);
+
+/**
+ * fdt_setprop_inplace_cell - change the value of a single-cell property
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to change
+ * @name: name of the property to change
+ * @val: cell (32-bit integer) value to replace the property with
+ *
+ * fdt_setprop_inplace_cell() replaces the value of a given property
+ * with the 32-bit integer cell value in val, converting val to
+ * big-endian if necessary.  This function cannot change the size of a
+ * property, and so will only work if the property already exists and
+ * has length 4.
+ *
+ * This function will alter only the bytes in the blob which contain
+ * the given property value, and will not alter or move any other part
+ * of the tree.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOSPACE, if the property's length is not equal to 4
+  *	-FDT_ERR_NOTFOUND, node does not have the named property
+ *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
 static inline int fdt_setprop_inplace_cell(void *fdt, int nodeoffset,
 					   const char *name, uint32_t val)
 {
@@ -664,7 +721,54 @@ static inline int fdt_setprop_inplace_ce
 	return fdt_setprop_inplace(fdt, nodeoffset, name, &val, sizeof(val));
 }
 
+/**
+ * fdt_nop_property - replace a property with nop tags
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to nop
+ * @name: name of the property to nop
+ *
+ * fdt_nop_property() will replace a given property's representation
+ * in the blob with FDT_NOP tags, effectively removing it from the
+ * tree.
+ *
+ * This function will alter only the bytes in the blob which contain
+ * the property, and will not alter or move any other part of the
+ * tree.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOTFOUND, node does not have the named property
+ *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
 int fdt_nop_property(void *fdt, int nodeoffset, const char *name);
+
+/**
+ * fdt_nop_node - replace a node (subtree) with nop tags
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node to nop
+ *
+ * fdt_nop_node() will replace a given node's representation in the
+ * blob, including all its subnodes, if any, with FDT_NOP tags,
+ * effectively removing it from the tree.
+ *
+ * This function will alter only the bytes in the blob which contain
+ * the node and its properties and subnodes, and will not alter or
+ * move any other part of the tree.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
 int fdt_nop_node(void *fdt, int nodeoffset);
 
 /**********************************************************************/

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

Return-Path: <dgibson@ozlabs.org>
Date: Mon, 17 Dec 2007 14:42:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: libfdt: Add more documentation (patch the seventh)
Message-ID: <20071217034207.GB2973@localhost.localdomain>
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

This patch adds more documenting comments to libfdt.h.  Specifically,
these document the read/write functions (not including fdt_open_into()
and fdt_pack(), for now).

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/libfdt/libfdt.h
===================================================================
--- dtc.orig/libfdt/libfdt.h	2007-12-12 09:20:48.000000000 +1100
+++ dtc/libfdt/libfdt.h	2007-12-12 23:31:39.000000000 +1100
@@ -797,23 +797,242 @@ int fdt_finish(void *fdt);
 int fdt_open_into(const void *fdt, void *buf, int bufsize);
 int fdt_pack(void *fdt);
 
+/**
+ * fdt_add_mem_rsv - add one memory reserve map entry
+ * @fdt: pointer to the device tree blob
+ * @addres, @size: 64-bit values (native endian)
+ *
+ * Adds a reserve map entry to the given blob reserving a region at
+ * address address of length size.
+ *
+ * This function will insert data into the reserve map and will
+ * therfore change the indexes of some entries in the table.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOSPACE, there is insufficient free space in the blob to
+ *		contain the new reservation entry
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
 int fdt_add_mem_rsv(void *fdt, uint64_t address, uint64_t size);
+
+/**
+ * fdt_del_mem_rsv - remove a memory reserve map entry
+ * @fdt: pointer to the device tree blob
+ * @n: entry to remove
+ *
+ * fdt_del_mem_rsv() removes the n-th memory reserve map entry from
+ * the blob.
+ *
+ * This function will delete data from the reservation table and will
+ * therfore change the indexes of some entries in the table.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOTFOUND, there is no entry of the given index (i.e. there
+ *		are less than n+1 reserve map entries)
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
 int fdt_del_mem_rsv(void *fdt, int n);
 
+/**
+ * fdt_setprop - create or change a property
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to change
+ * @name: name of the property to change
+ * @val: pointer to data to set the property value to
+ * @len: length of the property value
+ *
+ * fdt_setprop() sets the value of the named property in the given
+ * node to the given value and length, creeating the property if it
+ * does not already exist.
+ *
+ * This function may insert or delete data from the blob, and will
+ * therefore change the offsets of some existing nodes.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOSPACE, there is insufficient free space in the blob to
+ *		contain the new property value
+ *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
 int fdt_setprop(void *fdt, int nodeoffset, const char *name,
 		const void *val, int len);
+
+/**
+ * fdt_setprop_cell - set a property to a single cell value
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to change
+ * @name: name of the property to change
+ * @val: 32-bit integer value for the property (native endian)
+ *
+ * fdt_setprop_cell() sets the value of the named property in the
+ * given node to the given cell value (converting to big-endian if
+ * necessary), or creates a new property with that value if it does
+ * not already exist.
+ *
+ * This function may insert or delete data from the blob, and will
+ * therefore change the offsets of some existing nodes.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOSPACE, there is insufficient free space in the blob to
+ *		contain the new property value
+ *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
 static inline int fdt_setprop_cell(void *fdt, int nodeoffset, const char *name,
 				   uint32_t val)
 {
 	val = cpu_to_fdt32(val);
 	return fdt_setprop(fdt, nodeoffset, name, &val, sizeof(val));
 }
+
+/**
+ * fdt_setprop_string - set a property to a string value
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to change
+ * @name: name of the property to change
+ * @str: string value for the property
+ *
+ * fdt_setprop_string() sets the value of the named property in the
+ * given node to the given string value (using the length of the
+ * string to determine the new length of the property), or creates a
+ * new property with that value if it does not already exist.
+ *
+ * This function may insert or delete data from the blob, and will
+ * therefore change the offsets of some existing nodes.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOSPACE, there is insufficient free space in the blob to
+ *		contain the new property value
+ *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
 #define fdt_setprop_string(fdt, nodeoffset, name, str) \
 	fdt_setprop((fdt), (nodeoffset), (name), (str), strlen(str)+1)
+
+/**
+ * fdt_delprop - delete a property
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to nop
+ * @name: name of the property to nop
+ *
+ * fdt_del_property() will delete the given property.
+ *
+ * This function will delete data from the blob, and will therefore
+ * change the offsets of some existing nodes.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_NOTFOUND, node does not have the named property
+ *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
 int fdt_delprop(void *fdt, int nodeoffset, const char *name);
+
+/**
+ * fdt_add_subnode_namelen - creates a new node based on substring
+ * @fdt: pointer to the device tree blob
+ * @parentoffset: structure block offset of a node
+ * @name: name of the subnode to locate
+ * @namelen: number of characters of name to consider
+ *
+ * Identical to fdt_add_subnode(), but use only the first namelen
+ * characters of name as the name of the new node.  This is useful for
+ * creating subnodes based on a portion of a larger string, such as a
+ * full path.
+ */
 int fdt_add_subnode_namelen(void *fdt, int parentoffset,
 			    const char *name, int namelen);
+
+/**
+ * fdt_add_subnode - creates a new node
+ * @fdt: pointer to the device tree blob
+ * @parentoffset: structure block offset of a node
+ * @name: name of the subnode to locate
+ *
+ * fdt_add_subnode() creates a new node as a subnode of the node at
+ * structure block offset parentoffset, with the given name (which
+ * should include the unit address, if any).
+ *
+ * This function will insert data into the blob, and will therefore
+ * change the offsets of some existing nodes.
+
+ * returns:
+ *	structure block offset of the created nodeequested subnode (>=0), on success
+ *	-FDT_ERR_NOTFOUND, if the requested subnode does not exist
+ *	-FDT_ERR_BADOFFSET, if parentoffset did not point to an FDT_BEGIN_NODE tag
+ *	-FDT_ERR_EXISTS, if the node at parentoffset already has a subnode of
+ *		the given name
+ *	-FDT_ERR_NOSPACE, if there is insufficient free space in the
+ *		blob to contain the new node
+ *	-FDT_ERR_NOSPACE
+ *	-FDT_ERR_BADLAYOUT
+ *      -FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_TRUNCATED, standard meanings.
+ */
 int fdt_add_subnode(void *fdt, int parentoffset, const char *name);
+
+/**
+ * fdt_del_node - delete a node (subtree)
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node to nop
+ *
+ * fdt_del_node() will remove the given node, including all its
+ * subnodes if any, from the blob.
+ *
+ * This function will delete data from the blob, and will therefore
+ * change the offsets of some existing nodes.
+ *
+ * returns:
+ *	0, on success
+ *	-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *	-FDT_ERR_BADLAYOUT,
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_TRUNCATED, standard meanings
+ */
 int fdt_del_node(void *fdt, int nodeoffset);
 
 /**********************************************************************/

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

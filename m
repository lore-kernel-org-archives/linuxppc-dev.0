Return-Path: <dgibson@ozlabs.org>
Date: Thu, 25 Oct 2007 11:27:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: libfdt: Documentation (patch the second)
Message-ID: <20071025012731.GA24856@localhost.localdomain>
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

Add documentation for another handful of libfdt functions to libfdt.h

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/libfdt/libfdt.h
===================================================================
--- dtc.orig/libfdt/libfdt.h	2007-10-25 10:52:31.000000000 +1000
+++ dtc/libfdt/libfdt.h	2007-10-25 11:26:26.000000000 +1000
@@ -237,13 +237,91 @@
  */
 int fdt_get_mem_rsv(const void *fdt, int n, uint64_t *address, uint64_t *size);
 
+/**
+ * fdt_subnode_offset_namelen - find a subnode based on substring
+ * @fdt: pointer to the device tree blob
+ * @parentoffset: structure block offset of a node
+ * @name: name of the subnode to locate
+ * @namelen: number of characters of name to consider
+ *
+ * Identical to fdt_subnode_offset(), but only examine the first
+ * namelen characters of name for matching the subnode name.  This is
+ * useful for finding subnodes based on a portion of a larger string,
+ * such as a full path.
+ */
 int fdt_subnode_offset_namelen(const void *fdt, int parentoffset,
 			       const char *name, int namelen);
+/**
+ * fdt_subnode_offset - find a subnode of a given node
+ * @fdt: pointer to the device tree blob
+ * @parentoffset: structure block offset of a node
+ * @name: name of the subnode to locate
+ *
+ * fdt_subnode_offset() finds a subnode of the node at structure block
+ * offset parentoffset with the given name.  name may include a unit
+ * address, in which case fdt_subnode_offset() will find the subnode
+ * with that unit address, or the unit address may be omitted, in
+ * which case fdt_subnode_offset() will find an arbitrary subnode
+ * whose name excluding unit address matches the given name.
+ *
+ * returns:
+ *	structure block offset of the requested subnode (>=0), on success
+ *	-FDT_ERR_NOTFOUND, if the requested subnode does not exist
+ *	-FDT_ERR_BADOFFSET, if parentoffset did not point to an FDT_BEGIN_NODE tag
+ *      -FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_TRUNCATED, standard meanings.
+ */
 int fdt_subnode_offset(const void *fdt, int parentoffset, const char *name);
 
+/**
+ * fdt_path_offset - find a tree node by its full path
+ * @fdt: pointer to the device tree blob
+ * @path: full path of the node to locate
+ *
+ * fdt_path_offset() finds a node of a given path in the device tree.
+ * Each path component may omit the unit address portion, but the
+ * results of this are undefined if any such path component is
+ * ambiguous (that is if there are multiple nodes at the relevant
+ * level matching the given component, differentiated only by unit
+ * address).
+ *
+ * returns:
+ *	structure block offset of the node with the requested path (>=0), on success
+ *	-FDT_ERR_BADPATH, given path does not begin with '/' or is invalid
+ *	-FDT_ERR_NOTFOUND, if the requested node does not exist
+ *      -FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE,
+ *	-FDT_ERR_TRUNCATED, standard meanings.
+ */
 int fdt_path_offset(const void *fdt, const char *path);
 
-const char *fdt_get_name(const void *fdt, int nodeoffset, int *baselen);
+/**
+ * fdt_get_name - retreive the name of a given node
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: structure block offset of the starting node
+ * @len: pointer to an intger variable (will be overwritten) or NULL
+ *
+ * fdt_get_name() retrieves the name (including unit address) of the
+ * device tree node at structure block offset nodeoffset.  If len is
+ * non-NULL, the length of this name is also returned, in the integer
+ * pointed to by len.
+ *
+ * returns:
+ *	pointer to the node's name, on success
+ *		*len contains the length of that name (>=0)
+ *	NULL, on error
+ *		*len contains an error code (<0):
+ *		-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *		-FDT_ERR_BADMAGIC,
+ *		-FDT_ERR_BADVERSION,
+ *		-FDT_ERR_BADSTATE, standard meanings
+ */
+const char *fdt_get_name(const void *fdt, int nodeoffset, int *len);
 
 const struct fdt_property *fdt_get_property(const void *fdt, int nodeoffset,
 					    const char *name, int *lenp);

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

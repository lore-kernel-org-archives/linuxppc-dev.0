Return-Path: <dgibson@ozlabs.org>
Date: Wed, 24 Oct 2007 17:10:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: libfdt: Add some documenting comments in libfdt.h
Message-ID: <20071024071058.GC17853@localhost.localdomain>
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

This patch adds some internal documentation in libfdt.h, in the form
of comments on the error codes and some functions.  Only a couple of
functions are covered so far, leaving the documentation still woefully
inadequate, but hey, it's a start.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/libfdt/libfdt.h
===================================================================
--- dtc.orig/libfdt/libfdt.h	2007-10-24 15:56:14.000000000 +1000
+++ dtc/libfdt/libfdt.h	2007-10-24 16:55:09.000000000 +1000
@@ -59,27 +59,64 @@
 
 /* Error codes: informative error codes */
 #define FDT_ERR_NOTFOUND	1
+	/* FDT_ERR_NOTFOUND: The requested node or property does not exist */
 #define FDT_ERR_EXISTS		2
+	/* FDT_ERR_EXISTS: Attemped to create a node or property which
+	 * already exists */
 #define FDT_ERR_NOSPACE		3
+	/* FDT_ERR_NOSPACE: Operation needed to expand the device
+	 * tree, but its buffer did not have sufficient space to
+	 * contain the expanded tree. Use fdt_open_into() to move the
+	 * device tree to a buffer with more space. */
 
 /* Error codes: codes for bad parameters */
 #define FDT_ERR_BADOFFSET	4
+	/* FDT_ERR_BADOFFSET: Function was passed a structure block
+	 * offset which is out-of-bounds, or which points to an
+	 * unsuitable part of the structure for the operation. */
 #define FDT_ERR_BADPATH		5
+	/* FDT_ERR_BADPATH: Function was passed a badly formatted path
+	 * (e.g. missing a leading / for a function which requires an
+	 * absolute path) */
 #define FDT_ERR_BADSTATE	6
+	/* FDT_ERR_BADSTATE: Function was passed an incomplete device
+	 * tree created by the sequential-write functions, which is
+	 * not sufficiently complete for the requested operation. */
 
 /* Error codes: codes for bad device tree blobs */
 #define FDT_ERR_TRUNCATED	7
+	/* FDT_ERR_TRUNCATED: Structure block of the given device tree
+	 * ends without an FDT_END tag. */
 #define FDT_ERR_BADMAGIC	8
+	/* FDT_ERR_BADMAGIC: Given "device tree" appears not to be a
+	 * device tree at all - it is missing the flattened device
+	 * tree magic number. */
 #define FDT_ERR_BADVERSION	9
+	/* FDT_ERR_BADVERSION: Given device tree has a version which
+	 * can't be handled by the requested operation.  For
+	 * read-write functions, this may mean that fdt_open_into() is
+	 * required to convert the tree to the expected version. */
 #define FDT_ERR_BADSTRUCTURE	10
+	/* FDT_ERR_BADSTRUCTURE: Given device tree has a corrupt
+	 * structure block or other serious error (e.g. misnested
+	 * nodes, or subnodes preceding properties). */
 #define FDT_ERR_BADLAYOUT	11
+	/* FDT_ERR_BADLAYOUT: For read-write functions, the given
+	 * device tree has it's sub-blocks in an order that the
+	 * function can't handle (memory reserve map, then structure,
+	 * then strings).  Use fdt_open_into() to reorganize the tree
+	 * into a form suitable for the read-write operations. */
 
 /* "Can't happen" error indicating a bug in libfdt */
 #define FDT_ERR_INTERNAL	12
+	/* FDT_ERR_INTERNAL: libfdt has failed an internal assertion.
+	 * Indicates a bug in libfdt itself. */
 
 #define FDT_ERR_MAX		12
 
-/* Low-level functions (you probably don't need these) */
+/**********************************************************************/
+/* Low-level functions (you probably don't need these)                */
+/**********************************************************************/
 
 const void *fdt_offset_ptr(const void *fdt, int offset, int checklen);
 static inline void *fdt_offset_ptr_w(void *fdt, int offset, int checklen)
@@ -94,7 +131,10 @@ static inline void *fdt_offset_ptr_w(voi
 
 uint32_t fdt_next_tag(const void *fdt, int offset, int *nextoffset);
 
-/* General functions */
+/**********************************************************************/
+/* General functions                                                  */
+/**********************************************************************/
+
 #define fdt_get_header(fdt, field) \
 	(fdt32_to_cpu(((const struct fdt_header *)(fdt))->field))
 #define fdt_magic(fdt) 			(fdt_get_header(fdt, magic))
@@ -111,15 +151,91 @@ uint32_t fdt_next_tag(const void *fdt, i
 #define fdt_set_header(fdt, field, val) \
 	((struct fdt_header *)(fdt))->field = cpu_to_fdt32(val)
 
+/**
+ * fdt_check_header - sanity check a device tree or possible device tree
+ * @fdt: pointer to data which might be a flattened device tree
+ *
+ * fdt_check_header() checks that the given buffer contains what
+ * appears to be a flattened device tree with sane information in its
+ * header.
+ *
+ * returns:
+ *     0, if the buffer appears to contain a valid device tree
+ *     -FDT_ERR_BADMAGIC,
+ *     -FDT_ERR_BADVERSION,
+ *     -FDT_ERR_BADSTATE, standard meanings, as above
+ */
 int fdt_check_header(const void *fdt);
+
+/**
+ * fdt_move - move a device tree around in memory
+ * @fdt: pointer to the device tree to move
+ * @buf: pointer to memory where the device is to be moved
+ * @bufsize: size of the memory space at buf
+ *
+ * fdt_move() relocates, if possible, the device tree blob located at
+ * fdt to the buffer at buf of size bufsize.  The buffer may overlap
+ * with the existing device tree blob at fdt.  Therefore,
+ *     fdt_move(fdt, fdt, fdt_totalsize(fdt))
+ * should always succeed.
+ *
+ * returns:
+ *     0, on success
+ *     -FDT_ERR_NOSPACE, bufsize is insufficient to contain the device tree
+ *     -FDT_ERR_BADMAGIC,
+ *     -FDT_ERR_BADVERSION,
+ *     -FDT_ERR_BADSTATE, standard meanings
+ */
 int fdt_move(const void *fdt, void *buf, int bufsize);
 
-/* Read-only functions */
+/**********************************************************************/
+/* Read-only functions                                                */
+/**********************************************************************/
+
+/**
+ * fdt_string - retreive a string from the strings block of a device tree
+ * @fdt: pointer to the device tree blob
+ * @stroffset: offset of the string within the strings block (native endian)
+ *
+ * fdt_string() retrieves a pointer to a single string from the
+ * strings block of the device tree blob at fdt.
+ *
+ * returns:
+ *     a pointer to the string, on success
+ *     NULL, if stroffset is out of bounds
+ */
 const char *fdt_string(const void *fdt, int stroffset);
 
-int fdt_get_mem_rsv(const void *fdt, int n, uint64_t *address, uint64_t *size);
+/**
+ * fdt_num_mem_rsv - retreive the number of memory reserve map entries
+ * @fdt: pointer to the device tree blob
+ *
+ * Returns the number of entries in the device tree blob's memory
+ * reservation map.  This does not include the terminating 0,0 entry
+ * or any other (0,0) entries reserved for expansion.
+ *
+ * returns:
+ *     the number of entries
+ */
 int fdt_num_mem_rsv(const void *fdt);
 
+/**
+ * fdt_get_mem_rsv - retreive one memory reserve map entry
+ * @fdt: pointer to the device tree blob
+ * @address, @size: pointers to 64-bit variables
+ *
+ * On success, *address and *size will contain the address and size of
+ * the n-th reserve map entry from the device tree blob, in
+ * native-endian format.
+ *
+ * returns:
+ *     0, on success
+ *     -FDT_ERR_BADMAGIC,
+ *     -FDT_ERR_BADVERSION,
+ *     -FDT_ERR_BADSTATE, standard meanings
+ */
+int fdt_get_mem_rsv(const void *fdt, int n, uint64_t *address, uint64_t *size);
+
 int fdt_subnode_offset_namelen(const void *fdt, int parentoffset,
 			       const char *name, int namelen);
 int fdt_subnode_offset(const void *fdt, int parentoffset, const char *name);
@@ -163,7 +279,10 @@ int fdt_node_check_compatible(const void
 int fdt_node_offset_by_compatible(const void *fdt, int startoffset,
 				  const char *compatible);
 
-/* Write-in-place functions */
+/**********************************************************************/
+/* Write-in-place functions                                           */
+/**********************************************************************/
+
 int fdt_setprop_inplace(void *fdt, int nodeoffset, const char *name,
 			const void *val, int len);
 
@@ -176,7 +295,10 @@ int fdt_setprop_inplace(void *fdt, int n
 int fdt_nop_property(void *fdt, int nodeoffset, const char *name);
 int fdt_nop_node(void *fdt, int nodeoffset);
 
-/* Sequential-write functions */
+/**********************************************************************/
+/* Sequential write functions                                         */
+/**********************************************************************/
+
 int fdt_create(void *buf, int bufsize);
 int fdt_add_reservemap_entry(void *fdt, uint64_t addr, uint64_t size);
 int fdt_finish_reservemap(void *fdt);
@@ -192,7 +314,10 @@ int fdt_property(void *fdt, const char *
 int fdt_end_node(void *fdt);
 int fdt_finish(void *fdt);
 
-/* Read-write functions */
+/**********************************************************************/
+/* Read-write functions                                               */
+/**********************************************************************/
+
 int fdt_open_into(void *fdt, void *buf, int bufsize);
 int fdt_pack(void *fdt);
 
@@ -214,7 +339,10 @@ int fdt_add_subnode_namelen(void *fdt, i
 int fdt_add_subnode(void *fdt, int parentoffset, const char *name);
 int fdt_del_node(void *fdt, int nodeoffset);
 
-/* Extra functions */
+/**********************************************************************/
+/* Debugging / informational functions                                */
+/**********************************************************************/
+
 const char *fdt_strerror(int errval);
 
 #endif /* _LIBFDT_H */

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

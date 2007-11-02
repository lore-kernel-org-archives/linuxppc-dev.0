Return-Path: <dgibson@ozlabs.org>
Date: Fri, 2 Nov 2007 15:47:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: libfdt: Add more documentation (patch the third)
Message-ID: <20071102044716.GK19839@localhost.localdomain>
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

This patch adds documentation in libfdt.h for a few more libfdt
functions.  It also makes a slight update to the documentation of
fdt_get_name().

Index: dtc/libfdt/libfdt.h
===================================================================
--- dtc.orig/libfdt/libfdt.h	2007-11-02 15:44:58.000000000 +1100
+++ dtc/libfdt/libfdt.h	2007-11-02 15:46:37.000000000 +1100
@@ -319,28 +319,54 @@ int fdt_path_offset(const void *fdt, con
  * fdt_get_name - retreive the name of a given node
  * @fdt: pointer to the device tree blob
  * @nodeoffset: structure block offset of the starting node
- * @len: pointer to an intger variable (will be overwritten) or NULL
+ * @lenp: pointer to an integer variable (will be overwritten) or NULL
  *
  * fdt_get_name() retrieves the name (including unit address) of the
- * device tree node at structure block offset nodeoffset.  If len is
+ * device tree node at structure block offset nodeoffset.  If lenp is
  * non-NULL, the length of this name is also returned, in the integer
- * pointed to by len.
+ * pointed to by lenp.
  *
  * returns:
  *	pointer to the node's name, on success
- *		*len contains the length of that name (>=0)
+ *		If lenp is non-NULL, *lenp contains the length of that name (>=0)
  *	NULL, on error
- *		*len contains an error code (<0):
+ *		if lenp is non-NULL *lenp contains an error code (<0):
  *		-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
  *		-FDT_ERR_BADMAGIC,
  *		-FDT_ERR_BADVERSION,
  *		-FDT_ERR_BADSTATE, standard meanings
  */
-const char *fdt_get_name(const void *fdt, int nodeoffset, int *len);
+const char *fdt_get_name(const void *fdt, int nodeoffset, int *lenp);
 
+/**
+ * fdt_get_property - find a given property in a given node
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to find
+ * @name: name of the property to find
+ * @lenp: pointer to an integer variable (will be overwritten) or NULL
+ *
+ * fdt_get_property() retrieves a pointer to the fdt_property
+ * structure within the device tree blob corresponding to the property
+ * named 'name' of the node at offset nodeoffset.  If lenp is
+ * non-NULL, the length of the property value also returned, in the
+ * integer pointed to by lenp.
+ *
+ * returns:
+ *	pointer to the structure representing the property
+ *		if lenp is non-NULL, *lenp contains the length of the property
+ *		value (>=0)
+ *	NULL, on error
+ *		if lenp is non-NULL, *lenp contains an error code (<0):
+ *		-FDT_ERR_NOTFOUND, node does not have named property
+ *		-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *		-FDT_ERR_BADMAGIC,
+ *		-FDT_ERR_BADVERSION,
+ *		-FDT_ERR_BADSTATE,
+ *		-FDT_ERR_BADSTRUCTURE,
+ *		-FDT_ERR_TRUNCATED, standard meanings
+ */
 const struct fdt_property *fdt_get_property(const void *fdt, int nodeoffset,
 					    const char *name, int *lenp);
-
 static inline struct fdt_property *fdt_get_property_w(void *fdt, int nodeoffset,
 						      const char *name,
 						      int *lenp)
@@ -349,6 +375,33 @@ static inline struct fdt_property *fdt_g
 						       name, lenp);
 }
 
+/**
+ * fdt_getprop - retrieve the value of a given property
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to find
+ * @name: name of the property to find
+ * @lenp: pointer to an integer variable (will be overwritten) or NULL
+ *
+ * fdt_getprop() retrieves a pointer to the value of the property
+ * named 'name' of the node at offset nodeoffset (this will be a
+ * pointer to within the device blob itself, not a copy of the value).
+ * If lenp is non-NULL, the length of the property value also
+ * returned, in the integer pointed to by lenp.
+ *
+ * returns:
+ *	pointer to the property's value
+ *		if lenp is non-NULL, *lenp contains the length of the property
+ *		value (>=0)
+ *	NULL, on error
+ *		if lenp is non-NULL, *lenp contains an error code (<0):
+ *		-FDT_ERR_NOTFOUND, node does not have named property
+ *		-FDT_ERR_BADOFFSET, nodeoffset did not point to FDT_BEGIN_NODE tag
+ *		-FDT_ERR_BADMAGIC,
+ *		-FDT_ERR_BADVERSION,
+ *		-FDT_ERR_BADSTATE,
+ *		-FDT_ERR_BADSTRUCTURE,
+ *		-FDT_ERR_TRUNCATED, standard meanings
+ */
 const void *fdt_getprop(const void *fdt, int nodeoffset,
 			const char *name, int *lenp);
 static inline void *fdt_getprop_w(void *fdt, int nodeoffset,
@@ -357,6 +410,31 @@ static inline void *fdt_getprop_w(void *
 	return (void *)fdt_getprop(fdt, nodeoffset, name, lenp);
 }
 
+/**
+ * fdt_get_path - determine the full path of a node
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose path to find
+ * @buf: character buffer to contain the returned path (will be overwritten)
+ * @buflen: size of the character buffer at buf
+ *
+ * fdt_get_path() computes the full path of the node at offset
+ * nodeoffset, and records that path in the buffer at buf.
+ *
+ * NOTE: This function is expensive, as it must scan the device tree
+ * structure from the start to nodeoffset.
+ *
+ * returns:
+ *	0, on success
+ *		buf contains the absolute path of the node at
+ *		nodeoffset, as a NUL-terminated string.
+ * 	-FDT_ERR_BADOFFSET, nodeoffset does not refer to a BEGIN_NODE tag
+ *	-FDT_ERR_NOSPACE, the path of the given node is longer than (bufsize-1)
+ *		characters and will not fit in the given buffer.
+ *	-FDT_ERR_BADMAGIC,
+ *	-FDT_ERR_BADVERSION,
+ *	-FDT_ERR_BADSTATE,
+ *	-FDT_ERR_BADSTRUCTURE, standard meanings
+ */
 int fdt_get_path(const void *fdt, int nodeoffset, char *buf, int buflen);
 
 int fdt_supernode_atdepth_offset(const void *fdt, int nodeoffset,

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

Return-Path: <dgibson@ozlabs.org>
Date: Wed, 6 Aug 2008 14:50:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: libfdt: Implement fdt_get_property_namelen() and fdt_getprop_namelen()
Message-ID: <20080806045049.GC6690@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

As well as fdt_subnode_offset(), libfdt includes an
fdt_subnode_offset_namelen() function that takes the subnode name to
look up not as a NUL-terminated string, but as a string with an
explicit length.  This can be useful when the caller has the name as
part of a longer string, such as a full path.

However, we don't have corresponding 'namelen' versions for
fdt_get_property() and fdt_getprop().  There are less obvious use
cases for these variants on property names, but there are
circumstances where they can be useful e.g. looking up property names
which need to be parsed from a longer string buffer such as user input
or a configuration file, or looking up an alias in a path with
IEEE1275 style aliases.

So, since it's very easy to implement such variants, this patch does
so.  The original NUL-terminated variants are, of course, implemented
in terms of the namelen versions.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/libfdt/fdt_ro.c
===================================================================
--- dtc.orig/libfdt/fdt_ro.c	2008-08-05 14:12:17.000000000 +1000
+++ dtc/libfdt/fdt_ro.c	2008-08-05 14:39:19.000000000 +1000
@@ -80,6 +80,14 @@ const char *fdt_string(const void *fdt, 
 	return (const char *)fdt + fdt_off_dt_strings(fdt) + stroffset;
 }
 
+static int _fdt_string_eq(const void *fdt, int stroffset,
+			  const char *s, int len)
+{
+	const char *p = fdt_string(fdt, stroffset);
+
+	return (strlen(p) == len) && (memcmp(p, s, len) == 0);
+}
+
 int fdt_get_mem_rsv(const void *fdt, int n, uint64_t *address, uint64_t *size)
 {
 	FDT_CHECK_HEADER(fdt);
@@ -175,9 +183,10 @@ const char *fdt_get_name(const void *fdt
 	return NULL;
 }
 
-const struct fdt_property *fdt_get_property(const void *fdt,
-					    int nodeoffset,
-					    const char *name, int *lenp)
+const struct fdt_property *fdt_get_property_namelen(const void *fdt,
+						    int nodeoffset,
+						    const char *name,
+						    int namelen, int *lenp)
 {
 	uint32_t tag;
 	const struct fdt_property *prop;
@@ -210,7 +219,7 @@ const struct fdt_property *fdt_get_prope
 			if (! prop)
 				goto fail;
 			namestroff = fdt32_to_cpu(prop->nameoff);
-			if (strcmp(fdt_string(fdt, namestroff), name) == 0) {
+			if (_fdt_string_eq(fdt, namestroff, name, namelen)) {
 				/* Found it! */
 				int len = fdt32_to_cpu(prop->len);
 				prop = fdt_offset_ptr(fdt, offset,
@@ -238,18 +247,32 @@ const struct fdt_property *fdt_get_prope
 	return NULL;
 }
 
-const void *fdt_getprop(const void *fdt, int nodeoffset,
-		  const char *name, int *lenp)
+const struct fdt_property *fdt_get_property(const void *fdt,
+					    int nodeoffset,
+					    const char *name, int *lenp)
+{
+	return fdt_get_property_namelen(fdt, nodeoffset, name,
+					strlen(name), lenp);
+}
+
+const void *fdt_getprop_namelen(const void *fdt, int nodeoffset,
+				const char *name, int namelen, int *lenp)
 {
 	const struct fdt_property *prop;
 
-	prop = fdt_get_property(fdt, nodeoffset, name, lenp);
+	prop = fdt_get_property_namelen(fdt, nodeoffset, name, namelen, lenp);
 	if (! prop)
 		return NULL;
 
 	return prop->data;
 }
 
+const void *fdt_getprop(const void *fdt, int nodeoffset,
+			const char *name, int *lenp)
+{
+	return fdt_getprop_namelen(fdt, nodeoffset, name, strlen(name), lenp);
+}
+
 uint32_t fdt_get_phandle(const void *fdt, int nodeoffset)
 {
 	const uint32_t *php;
Index: dtc/libfdt/libfdt.h
===================================================================
--- dtc.orig/libfdt/libfdt.h	2008-08-05 14:29:15.000000000 +1000
+++ dtc/libfdt/libfdt.h	2008-08-05 14:40:58.000000000 +1000
@@ -343,6 +343,22 @@ int fdt_path_offset(const void *fdt, con
 const char *fdt_get_name(const void *fdt, int nodeoffset, int *lenp);
 
 /**
+ * fdt_get_property_namelen - find a property based on substring
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to find
+ * @name: name of the property to find
+ * @namelen: number of characters of name to consider
+ * @lenp: pointer to an integer variable (will be overwritten) or NULL
+ *
+ * Identical to fdt_get_property_namelen(), but only examine the first
+ * namelen characters of name for matching the property name.
+ */
+const struct fdt_property *fdt_get_property_namelen(const void *fdt,
+						    int nodeoffset,
+						    const char *name,
+						    int namelen, int *lenp);
+
+/**
  * fdt_get_property - find a given property in a given node
  * @fdt: pointer to the device tree blob
  * @nodeoffset: offset of the node whose property to find
@@ -380,6 +396,20 @@ static inline struct fdt_property *fdt_g
 }
 
 /**
+ * fdt_getprop_namelen - get property value based on substring
+ * @fdt: pointer to the device tree blob
+ * @nodeoffset: offset of the node whose property to find
+ * @name: name of the property to find
+ * @namelen: number of characters of name to consider
+ * @lenp: pointer to an integer variable (will be overwritten) or NULL
+ *
+ * Identical to fdt_getprop(), but only examine the first namelen
+ * characters of name for matching the property name.
+ */
+const void *fdt_getprop_namelen(const void *fdt, int nodeoffset,
+				const char *name, int namelen, int *lenp);
+
+/**
  * fdt_getprop - retrieve the value of a given property
  * @fdt: pointer to the device tree blob
  * @nodeoffset: offset of the node whose property to find

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

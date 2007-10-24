Return-Path: <dgibson@ozlabs.org>
Date: Wed, 24 Oct 2007 10:28:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: libfdt: Rename and publish _fdt_check_header()
Message-ID: <20071024002852.GG10595@localhost.localdomain>
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

It's potentially useful for users of libfdt to sanity check a device
tree (or, rather, a blob of data which may or may not be a device
tree) before processing it in more detail with libfdt.

This patch renames the libfdt internal function _fdt_check_header() to
fdt_check_header() and makes it a published function, so it can now be
used for this purpose.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/libfdt/fdt.c
===================================================================
--- dtc.orig/libfdt/fdt.c	2007-10-24 10:24:58.000000000 +1000
+++ dtc/libfdt/fdt.c	2007-10-24 10:25:12.000000000 +1000
@@ -55,7 +55,7 @@
 
 #include "libfdt_internal.h"
 
-int _fdt_check_header(const void *fdt)
+int fdt_check_header(const void *fdt)
 {
 	if (fdt_magic(fdt) == FDT_MAGIC) {
 		/* Complete tree */
@@ -143,7 +143,7 @@
 
 int fdt_move(const void *fdt, void *buf, int bufsize)
 {
-	int err = _fdt_check_header(fdt);
+	int err = fdt_check_header(fdt);
 
 	if (err)
 		return err;
Index: dtc/libfdt/libfdt.h
===================================================================
--- dtc.orig/libfdt/libfdt.h	2007-10-24 10:23:48.000000000 +1000
+++ dtc/libfdt/libfdt.h	2007-10-24 10:24:49.000000000 +1000
@@ -79,6 +79,22 @@
 
 #define FDT_ERR_MAX		12
 
+/* Low-level functions (you probably don't need these) */
+
+const void *fdt_offset_ptr(const void *fdt, int offset, int checklen);
+static inline void *fdt_offset_ptr_w(void *fdt, int offset, int checklen)
+{
+	return (void *)fdt_offset_ptr(fdt, offset, checklen);
+}
+
+
+#define fdt_offset_ptr_typed(fdt, offset, var) \
+	((typeof(var))(fdt_offset_ptr((fdt), (offset), sizeof(*(var)))))
+#define fdt_offset_ptr_typed_w(fdt, offset, var) \
+	((typeof(var))(fdt_offset_ptr_w((fdt), (offset), sizeof(*(var)))))
+
+/* General functions */
+
 #define fdt_get_header(fdt, field) \
 	(fdt32_to_cpu(((const struct fdt_header *)(fdt))->field))
 #define fdt_magic(fdt) 			(fdt_get_header(fdt, magic))
@@ -95,18 +111,7 @@
 #define fdt_set_header(fdt, field, val) \
 	((struct fdt_header *)(fdt))->field = cpu_to_fdt32(val)
 
-const void *fdt_offset_ptr(const void *fdt, int offset, int checklen);
-static inline void *fdt_offset_ptr_w(void *fdt, int offset, int checklen)
-{
-	return (void *)fdt_offset_ptr(fdt, offset, checklen);
-}
-
-
-#define fdt_offset_ptr_typed(fdt, offset, var) \
-	((typeof(var))(fdt_offset_ptr((fdt), (offset), sizeof(*(var)))))
-#define fdt_offset_ptr_typed_w(fdt, offset, var) \
-	((typeof(var))(fdt_offset_ptr_w((fdt), (offset), sizeof(*(var)))))
-
+int fdt_check_header(const void *fdt);
 int fdt_move(const void *fdt, void *buf, int bufsize);
 
 /* Read-only functions */
Index: dtc/libfdt/libfdt_internal.h
===================================================================
--- dtc.orig/libfdt/libfdt_internal.h	2007-10-24 10:23:40.000000000 +1000
+++ dtc/libfdt/libfdt_internal.h	2007-10-24 10:23:45.000000000 +1000
@@ -58,7 +58,6 @@
 #define memeq(p, q, n)	(memcmp((p), (q), (n)) == 0)
 #define streq(p, q)	(strcmp((p), (q)) == 0)
 
-int _fdt_check_header(const void *fdt);
 uint32_t _fdt_next_tag(const void *fdt, int startoffset, int *nextoffset);
 const char *_fdt_find_string(const char *strtab, int tabsize, const char *s);
 int _fdt_node_end_offset(void *fdt, int nodeoffset);
Index: dtc/libfdt/fdt_ro.c
===================================================================
--- dtc.orig/libfdt/fdt_ro.c	2007-10-24 10:25:24.000000000 +1000
+++ dtc/libfdt/fdt_ro.c	2007-10-24 10:25:44.000000000 +1000
@@ -58,7 +58,7 @@
 #define CHECK_HEADER(fdt) \
 	{ \
 		int err; \
-		if ((err = _fdt_check_header(fdt)) != 0) \
+		if ((err = fdt_check_header(fdt)) != 0) \
 			return err; \
 	}
 
@@ -193,7 +193,7 @@
 	const struct fdt_node_header *nh;
 	int err;
 
-	if ((err = _fdt_check_header(fdt)) != 0)
+	if ((err = fdt_check_header(fdt)) != 0)
 		goto fail;
 
 	err = -FDT_ERR_BADOFFSET;
@@ -222,7 +222,7 @@
 	int offset, nextoffset;
 	int err;
 
-	if ((err = _fdt_check_header(fdt)) != 0)
+	if ((err = fdt_check_header(fdt)) != 0)
 		goto fail;
 
 	err = -FDT_ERR_BADOFFSET;
Index: dtc/libfdt/fdt_rw.c
===================================================================
--- dtc.orig/libfdt/fdt_rw.c	2007-10-24 10:25:52.000000000 +1000
+++ dtc/libfdt/fdt_rw.c	2007-10-24 10:25:56.000000000 +1000
@@ -59,7 +59,7 @@
 {
 	int err;
 
-	if ((err = _fdt_check_header(fdt)))
+	if ((err = fdt_check_header(fdt)))
 		return err;
 	if (fdt_version(fdt) < 0x11)
 		return -FDT_ERR_BADVERSION;

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

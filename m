Return-Path: <dgibson@ozlabs.org>
Date: Mon, 7 Jul 2008 10:14:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Enable and fix -Wcast-qual warnings
Message-ID: <20080707001415.GD6267@yookeroo.seuss>
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

Enabling -Wcast-qual warnings in dtc shows up a number of places where
we are incorrectly discarding a const qualification.  There are also
some places where we are intentionally discarding the 'const', and we
need an ugly cast through uintptr_t to suppress the warning.  However,
most of these are pretty well isolated with the *_w() functions.  So
in the interests of maximum safety with const qualifications, this
patch enables the warnings and fixes the existing complaints.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/Makefile
===================================================================
--- dtc.orig/Makefile	2008-07-04 16:54:38.000000000 +1000
+++ dtc/Makefile	2008-07-04 16:54:38.000000000 +1000
@@ -16,7 +16,7 @@
 CONFIG_LOCALVERSION =
 
 CPPFLAGS = -I libfdt
-CFLAGS = -Wall -g -Os -Wpointer-arith
+CFLAGS = -Wall -g -Os -Wpointer-arith -Wcast-qual
 
 CPPFLAGS += -std=c99 -D_XOPEN_SOURCE -D_BSD_SOURCE
 CFLAGS += -Werror
Index: dtc/ftdump.c
===================================================================
--- dtc.orig/ftdump.c	2008-07-04 16:54:38.000000000 +1000
+++ dtc/ftdump.c	2008-07-04 16:54:38.000000000 +1000
@@ -48,11 +48,11 @@
 		return;
 
 	if (is_printable_string(data, len)) {
-		printf(" = \"%s\"", (char *)data);
+		printf(" = \"%s\"", (const char *)data);
 	} else if ((len % 4) == 0) {
 		printf(" = <");
 		for (i = 0; i < len; i += 4)
-			printf("%08x%s", *((uint32_t *)data + i),
+			printf("%08x%s", *((const uint32_t *)data + i),
 			       i < (len - 4) ? " " : "");
 		printf(">");
 	} else {
Index: dtc/treesource.c
===================================================================
--- dtc.orig/treesource.c	2008-07-04 16:54:38.000000000 +1000
+++ dtc/treesource.c	2008-07-04 16:54:38.000000000 +1000
@@ -176,7 +176,7 @@
 		}
 
 		fprintf(f, "%02hhx", *bp++);
-		if ((void *)bp >= propend)
+		if ((const void *)bp >= propend)
 			break;
 		fprintf(f, " ");
 	}
Index: dtc/libfdt/fdt_ro.c
===================================================================
--- dtc.orig/libfdt/fdt_ro.c	2008-07-04 16:54:38.000000000 +1000
+++ dtc/libfdt/fdt_ro.c	2008-07-04 16:54:38.000000000 +1000
@@ -77,7 +77,7 @@
 
 const char *fdt_string(const void *fdt, int stroffset)
 {
-	return (char *)fdt + fdt_off_dt_strings(fdt) + stroffset;
+	return (const char *)fdt + fdt_off_dt_strings(fdt) + stroffset;
 }
 
 int fdt_get_mem_rsv(const void *fdt, int n, uint64_t *address, uint64_t *size)
Index: dtc/libfdt/libfdt.h
===================================================================
--- dtc.orig/libfdt/libfdt.h	2008-07-04 16:54:38.000000000 +1000
+++ dtc/libfdt/libfdt.h	2008-07-04 16:54:38.000000000 +1000
@@ -125,7 +125,7 @@
 const void *fdt_offset_ptr(const void *fdt, int offset, int checklen);
 static inline void *fdt_offset_ptr_w(void *fdt, int offset, int checklen)
 {
-	return (void *)fdt_offset_ptr(fdt, offset, checklen);
+	return (void *)(uintptr_t)fdt_offset_ptr(fdt, offset, checklen);
 }
 
 uint32_t fdt_next_tag(const void *fdt, int offset, int *nextoffset);
@@ -375,8 +375,8 @@
 						      const char *name,
 						      int *lenp)
 {
-	return (struct fdt_property *)fdt_get_property(fdt, nodeoffset,
-						       name, lenp);
+	return (struct fdt_property *)(uintptr_t)
+		fdt_get_property(fdt, nodeoffset, name, lenp);
 }
 
 /**
@@ -411,7 +411,7 @@
 static inline void *fdt_getprop_w(void *fdt, int nodeoffset,
 				  const char *name, int *lenp)
 {
-	return (void *)fdt_getprop(fdt, nodeoffset, name, lenp);
+	return (void *)(uintptr_t)fdt_getprop(fdt, nodeoffset, name, lenp);
 }
 
 /**
Index: dtc/libfdt/libfdt_internal.h
===================================================================
--- dtc.orig/libfdt/libfdt_internal.h	2008-07-04 16:54:38.000000000 +1000
+++ dtc/libfdt/libfdt_internal.h	2008-07-04 16:54:38.000000000 +1000
@@ -77,19 +77,20 @@
 
 static inline void *_fdt_offset_ptr_w(void *fdt, int offset)
 {
-	return (void *)_fdt_offset_ptr(fdt, offset);
+	return (void *)(uintptr_t)_fdt_offset_ptr(fdt, offset);
 }
 
 static inline const struct fdt_reserve_entry *_fdt_mem_rsv(const void *fdt, int n)
 {
-	const struct fdt_reserve_entry *rsv_table = (struct fdt_reserve_entry *)
+	const struct fdt_reserve_entry *rsv_table =
+		(const struct fdt_reserve_entry *)
 		((const char *)fdt + fdt_off_mem_rsvmap(fdt));
 
 	return rsv_table + n;
 }
 static inline struct fdt_reserve_entry *_fdt_mem_rsv_w(void *fdt, int n)
 {
-	return (void *)_fdt_mem_rsv(fdt, n);
+	return (void *)(uintptr_t)_fdt_mem_rsv(fdt, n);
 }
 
 #define SW_MAGIC		(~FDT_MAGIC)
Index: dtc/libfdt/fdt_rw.c
===================================================================
--- dtc.orig/libfdt/fdt_rw.c	2008-07-04 16:54:38.000000000 +1000
+++ dtc/libfdt/fdt_rw.c	2008-07-04 16:54:38.000000000 +1000
@@ -257,7 +257,7 @@
 
 	RW_CHECK_HEADER(fdt);
 
-	namep = (char *)fdt_get_name(fdt, nodeoffset, &oldlen);
+	namep = (char *)(uintptr_t)fdt_get_name(fdt, nodeoffset, &oldlen);
 	if (!namep)
 		return oldlen;
 
@@ -432,7 +432,7 @@
 	/* But if that overlaps with the old tree... */
 	if (((tmp + newsize) > fdtstart) && (tmp < fdtend)) {
 		/* Try right after the old tree instead */
-		tmp = (char *)fdtend;
+		tmp = (char *)(uintptr_t)fdtend;
 		if ((tmp + newsize) > ((char *)buf + bufsize))
 			return -FDT_ERR_NOSPACE;
 	}

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

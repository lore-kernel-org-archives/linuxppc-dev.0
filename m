Return-Path: <dgibson@ozlabs.org>
Date: Wed, 9 Jul 2008 14:10:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: libfdt: Increase namespace-pollution paranoia
Message-ID: <20080709041024.GB29648@yookeroo.seuss>
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

libfdt is supposed to easy to embed in projects all and sundry.
Often, it won't be practical to separate the embedded libfdt's
namespace from that of the surrounding project.  Which means there can
be namespace conflicts between even libfdt's internal/static functions
and functions or macros coming from the surrounding project's headers
via libfdt_env.h.

This patch, therefore, renames a bunch of libfdt internal functions
and macros and makes a few other chances to reduce the chances of
namespace collisions with embedding projects.  Specifically:
	- Internal functions (even static ones) are now named _fdt_*()

	- The type and (static) global for the error table in
          fdt_strerror() gain an fdt_ prefix

	- The unused macro PALIGN is removed

	- The memeq and streq macros are removed and open-coded in the
          users (they were only used once each)

	- Other macros gain an FDT_ prefix

	- To save some of the bulk from the previous change, an
          FDT_TAGALIGN() macro is introduced, where FDT_TAGALIGN(x) ==
          FDT_ALIGN(x, FDT_TAGSIZE)

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/libfdt/libfdt_internal.h
===================================================================
--- dtc.orig/libfdt/libfdt_internal.h	2008-07-09 12:09:08.000000000 +1000
+++ dtc/libfdt/libfdt_internal.h	2008-07-09 12:39:12.000000000 +1000
@@ -52,13 +52,10 @@
  */
 #include <fdt.h>
 
-#define ALIGN(x, a)	(((x) + (a) - 1) & ~((a) - 1))
-#define PALIGN(p, a)	((void *)ALIGN((unsigned long)(p), (a)))
+#define FDT_ALIGN(x, a)		(((x) + (a) - 1) & ~((a) - 1))
+#define FDT_TAGALIGN(x)		(FDT_ALIGN((x), FDT_TAGSIZE))
 
-#define memeq(p, q, n)	(memcmp((p), (q), (n)) == 0)
-#define streq(p, q)	(strcmp((p), (q)) == 0)
-
-#define CHECK_HEADER(fdt) \
+#define FDT_CHECK_HEADER(fdt) \
 	{ \
 		int err; \
 		if ((err = fdt_check_header(fdt)) != 0) \
@@ -93,6 +90,6 @@
 	return (void *)(uintptr_t)_fdt_mem_rsv(fdt, n);
 }
 
-#define SW_MAGIC		(~FDT_MAGIC)
+#define FDT_SW_MAGIC		(~FDT_MAGIC)
 
 #endif /* _LIBFDT_INTERNAL_H */
Index: dtc/libfdt/fdt.c
===================================================================
--- dtc.orig/libfdt/fdt.c	2008-07-09 12:10:29.000000000 +1000
+++ dtc/libfdt/fdt.c	2008-07-09 12:39:29.000000000 +1000
@@ -63,7 +63,7 @@
 			return -FDT_ERR_BADVERSION;
 		if (fdt_last_comp_version(fdt) > FDT_LAST_SUPPORTED_VERSION)
 			return -FDT_ERR_BADVERSION;
-	} else if (fdt_magic(fdt) == SW_MAGIC) {
+	} else if (fdt_magic(fdt) == FDT_SW_MAGIC) {
 		/* Unfinished sequential-write blob */
 		if (fdt_size_dt_struct(fdt) == 0)
 			return -FDT_ERR_BADSTATE;
@@ -124,7 +124,7 @@
 	}
 
 	if (nextoffset)
-		*nextoffset = ALIGN(offset, FDT_TAGSIZE);
+		*nextoffset = FDT_TAGALIGN(offset);
 
 	return tag;
 }
@@ -184,14 +184,14 @@
 	const char *p;
 
 	for (p = strtab; p <= last; p++)
-		if (memeq(p, s, len))
+		if (memcmp(p, s, len) == 0)
 			return p;
 	return NULL;
 }
 
 int fdt_move(const void *fdt, void *buf, int bufsize)
 {
-	CHECK_HEADER(fdt);
+	FDT_CHECK_HEADER(fdt);
 
 	if (fdt_totalsize(fdt) > bufsize)
 		return -FDT_ERR_NOSPACE;
Index: dtc/libfdt/fdt_ro.c
===================================================================
--- dtc.orig/libfdt/fdt_ro.c	2008-07-09 12:10:02.000000000 +1000
+++ dtc/libfdt/fdt_ro.c	2008-07-09 12:16:36.000000000 +1000
@@ -55,8 +55,8 @@
 
 #include "libfdt_internal.h"
 
-static int nodename_eq(const void *fdt, int offset,
-		       const char *s, int len)
+static int _fdt_nodename_eq(const void *fdt, int offset,
+			    const char *s, int len)
 {
 	const char *p = fdt_offset_ptr(fdt, offset + FDT_TAGSIZE, len+1);
 
@@ -82,7 +82,7 @@
 
 int fdt_get_mem_rsv(const void *fdt, int n, uint64_t *address, uint64_t *size)
 {
-	CHECK_HEADER(fdt);
+	FDT_CHECK_HEADER(fdt);
 	*address = fdt64_to_cpu(_fdt_mem_rsv(fdt, n)->address);
 	*size = fdt64_to_cpu(_fdt_mem_rsv(fdt, n)->size);
 	return 0;
@@ -102,7 +102,7 @@
 {
 	int depth;
 
-	CHECK_HEADER(fdt);
+	FDT_CHECK_HEADER(fdt);
 
 	for (depth = 0;
 	     offset >= 0;
@@ -110,7 +110,7 @@
 		if (depth < 0)
 			return -FDT_ERR_NOTFOUND;
 		else if ((depth == 1)
-			 && nodename_eq(fdt, offset, name, namelen))
+			 && _fdt_nodename_eq(fdt, offset, name, namelen))
 			return offset;
 	}
 
@@ -129,7 +129,7 @@
 	const char *p = path;
 	int offset = 0;
 
-	CHECK_HEADER(fdt);
+	FDT_CHECK_HEADER(fdt);
 
 	if (*path != '/')
 		return -FDT_ERR_BADPATH;
@@ -210,7 +210,7 @@
 			if (! prop)
 				goto fail;
 			namestroff = fdt32_to_cpu(prop->nameoff);
-			if (streq(fdt_string(fdt, namestroff), name)) {
+			if (strcmp(fdt_string(fdt, namestroff), name) == 0) {
 				/* Found it! */
 				int len = fdt32_to_cpu(prop->len);
 				prop = fdt_offset_ptr(fdt, offset,
@@ -268,7 +268,7 @@
 	int offset, depth, namelen;
 	const char *name;
 
-	CHECK_HEADER(fdt);
+	FDT_CHECK_HEADER(fdt);
 
 	if (buflen < 2)
 		return -FDT_ERR_NOSPACE;
@@ -321,7 +321,7 @@
 	int offset, depth;
 	int supernodeoffset = -FDT_ERR_INTERNAL;
 
-	CHECK_HEADER(fdt);
+	FDT_CHECK_HEADER(fdt);
 
 	if (supernodedepth < 0)
 		return -FDT_ERR_NOTFOUND;
@@ -380,7 +380,7 @@
 	const void *val;
 	int len;
 
-	CHECK_HEADER(fdt);
+	FDT_CHECK_HEADER(fdt);
 
 	/* FIXME: The algorithm here is pretty horrible: we scan each
 	 * property of a node in fdt_getprop(), then if that didn't
@@ -445,7 +445,7 @@
 {
 	int offset, err;
 
-	CHECK_HEADER(fdt);
+	FDT_CHECK_HEADER(fdt);
 
 	/* FIXME: The algorithm here is pretty horrible: we scan each
 	 * property of a node in fdt_node_check_compatible(), then if
Index: dtc/libfdt/fdt_rw.c
===================================================================
--- dtc.orig/libfdt/fdt_rw.c	2008-07-09 12:12:19.000000000 +1000
+++ dtc/libfdt/fdt_rw.c	2008-07-09 12:41:59.000000000 +1000
@@ -55,10 +55,10 @@
 
 #include "libfdt_internal.h"
 
-static int _blocks_misordered(const void *fdt,
+static int _fdt_blocks_misordered(const void *fdt,
 			      int mem_rsv_size, int struct_size)
 {
-	return (fdt_off_mem_rsvmap(fdt) < ALIGN(sizeof(struct fdt_header), 8))
+	return (fdt_off_mem_rsvmap(fdt) < FDT_ALIGN(sizeof(struct fdt_header), 8))
 		|| (fdt_off_dt_struct(fdt) <
 		    (fdt_off_mem_rsvmap(fdt) + mem_rsv_size))
 		|| (fdt_off_dt_strings(fdt) <
@@ -67,14 +67,14 @@
 		    (fdt_off_dt_strings(fdt) + fdt_size_dt_strings(fdt)));
 }
 
-static int rw_check_header(void *fdt)
+static int _fdt_rw_check_header(void *fdt)
 {
-	CHECK_HEADER(fdt);
+	FDT_CHECK_HEADER(fdt);
 
 	if (fdt_version(fdt) < 17)
 		return -FDT_ERR_BADVERSION;
-	if (_blocks_misordered(fdt, sizeof(struct fdt_reserve_entry),
-			       fdt_size_dt_struct(fdt)))
+	if (_fdt_blocks_misordered(fdt, sizeof(struct fdt_reserve_entry),
+				   fdt_size_dt_struct(fdt)))
 		return -FDT_ERR_BADLAYOUT;
 	if (fdt_version(fdt) > 17)
 		fdt_set_version(fdt, 17);
@@ -82,22 +82,22 @@
 	return 0;
 }
 
-#define RW_CHECK_HEADER(fdt) \
+#define FDT_RW_CHECK_HEADER(fdt) \
 	{ \
 		int err; \
-		if ((err = rw_check_header(fdt)) != 0) \
+		if ((err = _fdt_rw_check_header(fdt)) != 0) \
 			return err; \
 	}
 
-static inline int _blob_data_size(void *fdt)
+static inline int _fdt_data_size(void *fdt)
 {
 	return fdt_off_dt_strings(fdt) + fdt_size_dt_strings(fdt);
 }
 
-static int _blob_splice(void *fdt, void *splicepoint, int oldlen, int newlen)
+static int _fdt_splice(void *fdt, void *splicepoint, int oldlen, int newlen)
 {
 	char *p = splicepoint;
-	char *end = (char *)fdt + _blob_data_size(fdt);
+	char *end = (char *)fdt + _fdt_data_size(fdt);
 
 	if (((p + oldlen) < p) || ((p + oldlen) > end))
 		return -FDT_ERR_BADOFFSET;
@@ -107,12 +107,12 @@
 	return 0;
 }
 
-static int _blob_splice_mem_rsv(void *fdt, struct fdt_reserve_entry *p,
-				int oldn, int newn)
+static int _fdt_splice_mem_rsv(void *fdt, struct fdt_reserve_entry *p,
+			       int oldn, int newn)
 {
 	int delta = (newn - oldn) * sizeof(*p);
 	int err;
-	err = _blob_splice(fdt, p, oldn * sizeof(*p), newn * sizeof(*p));
+	err = _fdt_splice(fdt, p, oldn * sizeof(*p), newn * sizeof(*p));
 	if (err)
 		return err;
 	fdt_set_off_dt_struct(fdt, fdt_off_dt_struct(fdt) + delta);
@@ -120,13 +120,13 @@
 	return 0;
 }
 
-static int _blob_splice_struct(void *fdt, void *p,
-			       int oldlen, int newlen)
+static int _fdt_splice_struct(void *fdt, void *p,
+			      int oldlen, int newlen)
 {
 	int delta = newlen - oldlen;
 	int err;
 
-	if ((err = _blob_splice(fdt, p, oldlen, newlen)))
+	if ((err = _fdt_splice(fdt, p, oldlen, newlen)))
 		return err;
 
 	fdt_set_size_dt_struct(fdt, fdt_size_dt_struct(fdt) + delta);
@@ -134,20 +134,20 @@
 	return 0;
 }
 
-static int _blob_splice_string(void *fdt, int newlen)
+static int _fdt_splice_string(void *fdt, int newlen)
 {
 	void *p = (char *)fdt
 		+ fdt_off_dt_strings(fdt) + fdt_size_dt_strings(fdt);
 	int err;
 
-	if ((err = _blob_splice(fdt, p, 0, newlen)))
+	if ((err = _fdt_splice(fdt, p, 0, newlen)))
 		return err;
 
 	fdt_set_size_dt_strings(fdt, fdt_size_dt_strings(fdt) + newlen);
 	return 0;
 }
 
-static int _find_add_string(void *fdt, const char *s)
+static int _fdt_find_add_string(void *fdt, const char *s)
 {
 	char *strtab = (char *)fdt + fdt_off_dt_strings(fdt);
 	const char *p;
@@ -161,7 +161,7 @@
 		return (p - strtab);
 
 	new = strtab + fdt_size_dt_strings(fdt);
-	err = _blob_splice_string(fdt, len);
+	err = _fdt_splice_string(fdt, len);
 	if (err)
 		return err;
 
@@ -174,10 +174,10 @@
 	struct fdt_reserve_entry *re;
 	int err;
 
-	RW_CHECK_HEADER(fdt);
+	FDT_RW_CHECK_HEADER(fdt);
 
 	re = _fdt_mem_rsv_w(fdt, fdt_num_mem_rsv(fdt));
-	err = _blob_splice_mem_rsv(fdt, re, 0, 1);
+	err = _fdt_splice_mem_rsv(fdt, re, 0, 1);
 	if (err)
 		return err;
 
@@ -191,19 +191,19 @@
 	struct fdt_reserve_entry *re = _fdt_mem_rsv_w(fdt, n);
 	int err;
 
-	RW_CHECK_HEADER(fdt);
+	FDT_RW_CHECK_HEADER(fdt);
 
 	if (n >= fdt_num_mem_rsv(fdt))
 		return -FDT_ERR_NOTFOUND;
 
-	err = _blob_splice_mem_rsv(fdt, re, 1, 0);
+	err = _fdt_splice_mem_rsv(fdt, re, 1, 0);
 	if (err)
 		return err;
 	return 0;
 }
 
-static int _resize_property(void *fdt, int nodeoffset, const char *name, int len,
-			    struct fdt_property **prop)
+static int _fdt_resize_property(void *fdt, int nodeoffset, const char *name,
+				int len, struct fdt_property **prop)
 {
 	int oldlen;
 	int err;
@@ -212,17 +212,16 @@
 	if (! (*prop))
 		return oldlen;
 
-	if ((err = _blob_splice_struct(fdt, (*prop)->data,
-				       ALIGN(oldlen, FDT_TAGSIZE),
-				       ALIGN(len, FDT_TAGSIZE))))
+	if ((err = _fdt_splice_struct(fdt, (*prop)->data, FDT_TAGALIGN(oldlen),
+				      FDT_TAGALIGN(len))))
 		return err;
 
 	(*prop)->len = cpu_to_fdt32(len);
 	return 0;
 }
 
-static int _add_property(void *fdt, int nodeoffset, const char *name, int len,
-			 struct fdt_property **prop)
+static int _fdt_add_property(void *fdt, int nodeoffset, const char *name,
+			     int len, struct fdt_property **prop)
 {
 	int proplen;
 	int nextoffset;
@@ -232,14 +231,14 @@
 	if ((nextoffset = _fdt_check_node_offset(fdt, nodeoffset)) < 0)
 		return nextoffset;
 
-	namestroff = _find_add_string(fdt, name);
+	namestroff = _fdt_find_add_string(fdt, name);
 	if (namestroff < 0)
 		return namestroff;
 
 	*prop = _fdt_offset_ptr_w(fdt, nextoffset);
-	proplen = sizeof(**prop) + ALIGN(len, FDT_TAGSIZE);
+	proplen = sizeof(**prop) + FDT_TAGALIGN(len);
 
-	err = _blob_splice_struct(fdt, *prop, 0, proplen);
+	err = _fdt_splice_struct(fdt, *prop, 0, proplen);
 	if (err)
 		return err;
 
@@ -255,7 +254,7 @@
 	int oldlen, newlen;
 	int err;
 
-	RW_CHECK_HEADER(fdt);
+	FDT_RW_CHECK_HEADER(fdt);
 
 	namep = (char *)(uintptr_t)fdt_get_name(fdt, nodeoffset, &oldlen);
 	if (!namep)
@@ -263,8 +262,8 @@
 
 	newlen = strlen(name);
 
-	err = _blob_splice_struct(fdt, namep, ALIGN(oldlen+1, FDT_TAGSIZE),
-				  ALIGN(newlen+1, FDT_TAGSIZE));
+	err = _fdt_splice_struct(fdt, namep, FDT_TAGALIGN(oldlen+1),
+				 FDT_TAGALIGN(newlen+1));
 	if (err)
 		return err;
 
@@ -278,11 +277,11 @@
 	struct fdt_property *prop;
 	int err;
 
-	RW_CHECK_HEADER(fdt);
+	FDT_RW_CHECK_HEADER(fdt);
 
-	err = _resize_property(fdt, nodeoffset, name, len, &prop);
+	err = _fdt_resize_property(fdt, nodeoffset, name, len, &prop);
 	if (err == -FDT_ERR_NOTFOUND)
-		err = _add_property(fdt, nodeoffset, name, len, &prop);
+		err = _fdt_add_property(fdt, nodeoffset, name, len, &prop);
 	if (err)
 		return err;
 
@@ -295,14 +294,14 @@
 	struct fdt_property *prop;
 	int len, proplen;
 
-	RW_CHECK_HEADER(fdt);
+	FDT_RW_CHECK_HEADER(fdt);
 
 	prop = fdt_get_property_w(fdt, nodeoffset, name, &len);
 	if (! prop)
 		return len;
 
-	proplen = sizeof(*prop) + ALIGN(len, FDT_TAGSIZE);
-	return _blob_splice_struct(fdt, prop, proplen, 0);
+	proplen = sizeof(*prop) + FDT_TAGALIGN(len);
+	return _fdt_splice_struct(fdt, prop, proplen, 0);
 }
 
 int fdt_add_subnode_namelen(void *fdt, int parentoffset,
@@ -315,7 +314,7 @@
 	uint32_t tag;
 	uint32_t *endtag;
 
-	RW_CHECK_HEADER(fdt);
+	FDT_RW_CHECK_HEADER(fdt);
 
 	offset = fdt_subnode_offset_namelen(fdt, parentoffset, name, namelen);
 	if (offset >= 0)
@@ -331,14 +330,14 @@
 	} while ((tag == FDT_PROP) || (tag == FDT_NOP));
 
 	nh = _fdt_offset_ptr_w(fdt, offset);
-	nodelen = sizeof(*nh) + ALIGN(namelen+1, FDT_TAGSIZE) + FDT_TAGSIZE;
+	nodelen = sizeof(*nh) + FDT_TAGALIGN(namelen+1) + FDT_TAGSIZE;
 
-	err = _blob_splice_struct(fdt, nh, 0, nodelen);
+	err = _fdt_splice_struct(fdt, nh, 0, nodelen);
 	if (err)
 		return err;
 
 	nh->tag = cpu_to_fdt32(FDT_BEGIN_NODE);
-	memset(nh->name, 0, ALIGN(namelen+1, FDT_TAGSIZE));
+	memset(nh->name, 0, FDT_TAGALIGN(namelen+1));
 	memcpy(nh->name, name, namelen);
 	endtag = (uint32_t *)((char *)nh + nodelen - FDT_TAGSIZE);
 	*endtag = cpu_to_fdt32(FDT_END_NODE);
@@ -355,22 +354,22 @@
 {
 	int endoffset;
 
-	RW_CHECK_HEADER(fdt);
+	FDT_RW_CHECK_HEADER(fdt);
 
 	endoffset = _fdt_node_end_offset(fdt, nodeoffset);
 	if (endoffset < 0)
 		return endoffset;
 
-	return _blob_splice_struct(fdt, _fdt_offset_ptr_w(fdt, nodeoffset),
-				   endoffset - nodeoffset, 0);
+	return _fdt_splice_struct(fdt, _fdt_offset_ptr_w(fdt, nodeoffset),
+				  endoffset - nodeoffset, 0);
 }
 
-static void _packblocks(const char *old, char *new,
-		       int mem_rsv_size, int struct_size)
+static void _fdt_packblocks(const char *old, char *new,
+			    int mem_rsv_size, int struct_size)
 {
 	int mem_rsv_off, struct_off, strings_off;
 
-	mem_rsv_off = ALIGN(sizeof(struct fdt_header), 8);
+	mem_rsv_off = FDT_ALIGN(sizeof(struct fdt_header), 8);
 	struct_off = mem_rsv_off + mem_rsv_size;
 	strings_off = struct_off + struct_size;
 
@@ -396,7 +395,7 @@
 	const char *fdtend = fdtstart + fdt_totalsize(fdt);
 	char *tmp;
 
-	CHECK_HEADER(fdt);
+	FDT_CHECK_HEADER(fdt);
 
 	mem_rsv_size = (fdt_num_mem_rsv(fdt)+1)
 		* sizeof(struct fdt_reserve_entry);
@@ -409,7 +408,7 @@
 			;
 	}
 
-	if (!_blocks_misordered(fdt, mem_rsv_size, struct_size)) {
+	if (!_fdt_blocks_misordered(fdt, mem_rsv_size, struct_size)) {
 		/* no further work necessary */
 		err = fdt_move(fdt, buf, bufsize);
 		if (err)
@@ -421,7 +420,7 @@
 	}
 
 	/* Need to reorder */
-	newsize = ALIGN(sizeof(struct fdt_header), 8) + mem_rsv_size
+	newsize = FDT_ALIGN(sizeof(struct fdt_header), 8) + mem_rsv_size
 		+ struct_size + fdt_size_dt_strings(fdt);
 
 	if (bufsize < newsize)
@@ -437,7 +436,7 @@
 			return -FDT_ERR_NOSPACE;
 	}
 
-	_packblocks(fdt, tmp, mem_rsv_size, struct_size);
+	_fdt_packblocks(fdt, tmp, mem_rsv_size, struct_size);
 	memmove(buf, tmp, newsize);
 
 	fdt_set_magic(buf, FDT_MAGIC);
@@ -453,12 +452,12 @@
 {
 	int mem_rsv_size;
 
-	RW_CHECK_HEADER(fdt);
+	FDT_RW_CHECK_HEADER(fdt);
 
 	mem_rsv_size = (fdt_num_mem_rsv(fdt)+1)
 		* sizeof(struct fdt_reserve_entry);
-	_packblocks(fdt, fdt, mem_rsv_size, fdt_size_dt_struct(fdt));
-	fdt_set_totalsize(fdt, _blob_data_size(fdt));
+	_fdt_packblocks(fdt, fdt, mem_rsv_size, fdt_size_dt_struct(fdt));
+	fdt_set_totalsize(fdt, _fdt_data_size(fdt));
 
 	return 0;
 }
Index: dtc/libfdt/fdt_sw.c
===================================================================
--- dtc.orig/libfdt/fdt_sw.c	2008-07-09 12:11:32.000000000 +1000
+++ dtc/libfdt/fdt_sw.c	2008-07-09 12:42:47.000000000 +1000
@@ -55,22 +55,22 @@
 
 #include "libfdt_internal.h"
 
-static int sw_check_header(void *fdt)
+static int _fdt_sw_check_header(void *fdt)
 {
-	if (fdt_magic(fdt) != SW_MAGIC)
+	if (fdt_magic(fdt) != FDT_SW_MAGIC)
 		return -FDT_ERR_BADMAGIC;
 	/* FIXME: should check more details about the header state */
 	return 0;
 }
 
-#define SW_CHECK_HEADER(fdt) \
+#define FDT_SW_CHECK_HEADER(fdt) \
 	{ \
 		int err; \
-		if ((err = sw_check_header(fdt)) != 0) \
+		if ((err = _fdt_sw_check_header(fdt)) != 0) \
 			return err; \
 	}
 
-static void *grab_space(void *fdt, int len)
+static void *_fdt_grab_space(void *fdt, int len)
 {
 	int offset = fdt_size_dt_struct(fdt);
 	int spaceleft;
@@ -94,13 +94,13 @@
 
 	memset(buf, 0, bufsize);
 
-	fdt_set_magic(fdt, SW_MAGIC);
+	fdt_set_magic(fdt, FDT_SW_MAGIC);
 	fdt_set_version(fdt, FDT_LAST_SUPPORTED_VERSION);
 	fdt_set_last_comp_version(fdt, FDT_FIRST_SUPPORTED_VERSION);
 	fdt_set_totalsize(fdt,  bufsize);
 
-	fdt_set_off_mem_rsvmap(fdt, ALIGN(sizeof(struct fdt_header),
-					  sizeof(struct fdt_reserve_entry)));
+	fdt_set_off_mem_rsvmap(fdt, FDT_ALIGN(sizeof(struct fdt_header),
+					      sizeof(struct fdt_reserve_entry)));
 	fdt_set_off_dt_struct(fdt, fdt_off_mem_rsvmap(fdt));
 	fdt_set_off_dt_strings(fdt, bufsize);
 
@@ -112,7 +112,7 @@
 	struct fdt_reserve_entry *re;
 	int offset;
 
-	SW_CHECK_HEADER(fdt);
+	FDT_SW_CHECK_HEADER(fdt);
 
 	if (fdt_size_dt_struct(fdt))
 		return -FDT_ERR_BADSTATE;
@@ -140,9 +140,9 @@
 	struct fdt_node_header *nh;
 	int namelen = strlen(name) + 1;
 
-	SW_CHECK_HEADER(fdt);
+	FDT_SW_CHECK_HEADER(fdt);
 
-	nh = grab_space(fdt, sizeof(*nh) + ALIGN(namelen, FDT_TAGSIZE));
+	nh = _fdt_grab_space(fdt, sizeof(*nh) + FDT_TAGALIGN(namelen));
 	if (! nh)
 		return -FDT_ERR_NOSPACE;
 
@@ -155,9 +155,9 @@
 {
 	uint32_t *en;
 
-	SW_CHECK_HEADER(fdt);
+	FDT_SW_CHECK_HEADER(fdt);
 
-	en = grab_space(fdt, FDT_TAGSIZE);
+	en = _fdt_grab_space(fdt, FDT_TAGSIZE);
 	if (! en)
 		return -FDT_ERR_NOSPACE;
 
@@ -165,7 +165,7 @@
 	return 0;
 }
 
-static int find_add_string(void *fdt, const char *s)
+static int _fdt_find_add_string(void *fdt, const char *s)
 {
 	char *strtab = (char *)fdt + fdt_totalsize(fdt);
 	const char *p;
@@ -193,13 +193,13 @@
 	struct fdt_property *prop;
 	int nameoff;
 
-	SW_CHECK_HEADER(fdt);
+	FDT_SW_CHECK_HEADER(fdt);
 
-	nameoff = find_add_string(fdt, name);
+	nameoff = _fdt_find_add_string(fdt, name);
 	if (nameoff == 0)
 		return -FDT_ERR_NOSPACE;
 
-	prop = grab_space(fdt, sizeof(*prop) + ALIGN(len, FDT_TAGSIZE));
+	prop = _fdt_grab_space(fdt, sizeof(*prop) + FDT_TAGALIGN(len));
 	if (! prop)
 		return -FDT_ERR_NOSPACE;
 
@@ -218,10 +218,10 @@
 	uint32_t tag;
 	int offset, nextoffset;
 
-	SW_CHECK_HEADER(fdt);
+	FDT_SW_CHECK_HEADER(fdt);
 
 	/* Add terminator */
-	end = grab_space(fdt, sizeof(*end));
+	end = _fdt_grab_space(fdt, sizeof(*end));
 	if (! end)
 		return -FDT_ERR_NOSPACE;
 	*end = cpu_to_fdt32(FDT_END);
Index: dtc/libfdt/fdt_strerror.c
===================================================================
--- dtc.orig/libfdt/fdt_strerror.c	2008-07-09 12:21:10.000000000 +1000
+++ dtc/libfdt/fdt_strerror.c	2008-07-09 12:22:25.000000000 +1000
@@ -55,29 +55,29 @@
 
 #include "libfdt_internal.h"
 
-struct errtabent {
+struct fdt_errtabent {
 	const char *str;
 };
 
-#define ERRTABENT(val) \
+#define FDT_ERRTABENT(val) \
 	[(val)] = { .str = #val, }
 
-static struct errtabent errtable[] = {
-	ERRTABENT(FDT_ERR_NOTFOUND),
-	ERRTABENT(FDT_ERR_EXISTS),
-	ERRTABENT(FDT_ERR_NOSPACE),
-
-	ERRTABENT(FDT_ERR_BADOFFSET),
-	ERRTABENT(FDT_ERR_BADPATH),
-	ERRTABENT(FDT_ERR_BADSTATE),
-
-	ERRTABENT(FDT_ERR_TRUNCATED),
-	ERRTABENT(FDT_ERR_BADMAGIC),
-	ERRTABENT(FDT_ERR_BADVERSION),
-	ERRTABENT(FDT_ERR_BADSTRUCTURE),
-	ERRTABENT(FDT_ERR_BADLAYOUT),
+static struct fdt_errtabent fdt_errtable[] = {
+	FDT_ERRTABENT(FDT_ERR_NOTFOUND),
+	FDT_ERRTABENT(FDT_ERR_EXISTS),
+	FDT_ERRTABENT(FDT_ERR_NOSPACE),
+
+	FDT_ERRTABENT(FDT_ERR_BADOFFSET),
+	FDT_ERRTABENT(FDT_ERR_BADPATH),
+	FDT_ERRTABENT(FDT_ERR_BADSTATE),
+
+	FDT_ERRTABENT(FDT_ERR_TRUNCATED),
+	FDT_ERRTABENT(FDT_ERR_BADMAGIC),
+	FDT_ERRTABENT(FDT_ERR_BADVERSION),
+	FDT_ERRTABENT(FDT_ERR_BADSTRUCTURE),
+	FDT_ERRTABENT(FDT_ERR_BADLAYOUT),
 };
-#define ERRTABSIZE	(sizeof(errtable) / sizeof(errtable[0]))
+#define FDT_ERRTABSIZE	(sizeof(fdt_errtable) / sizeof(fdt_errtable[0]))
 
 const char *fdt_strerror(int errval)
 {
@@ -85,8 +85,8 @@
 		return "<valid offset/length>";
 	else if (errval == 0)
 		return "<no error>";
-	else if (errval > -ERRTABSIZE) {
-		const char *s = errtable[-errval].str;
+	else if (errval > -FDT_ERRTABSIZE) {
+		const char *s = fdt_errtable[-errval].str;
 
 		if (s)
 			return s;
Index: dtc/libfdt/fdt_wip.c
===================================================================
--- dtc.orig/libfdt/fdt_wip.c	2008-07-09 12:24:04.000000000 +1000
+++ dtc/libfdt/fdt_wip.c	2008-07-09 12:24:29.000000000 +1000
@@ -72,7 +72,7 @@
 	return 0;
 }
 
-static void nop_region(void *start, int len)
+static void _fdt_nop_region(void *start, int len)
 {
 	uint32_t *p;
 
@@ -89,7 +89,7 @@
 	if (! prop)
 		return len;
 
-	nop_region(prop, len + sizeof(*prop));
+	_fdt_nop_region(prop, len + sizeof(*prop));
 
 	return 0;
 }
@@ -139,6 +139,7 @@
 	if (endoffset < 0)
 		return endoffset;
 
-	nop_region(fdt_offset_ptr_w(fdt, nodeoffset, 0), endoffset - nodeoffset);
+	_fdt_nop_region(fdt_offset_ptr_w(fdt, nodeoffset, 0),
+			endoffset - nodeoffset);
 	return 0;
 }

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

Return-Path: <dgibson@ozlabs.org>
Date: Tue, 20 May 2008 16:23:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: libfdt: Seval cleanups to parameter checking
Message-ID: <20080520062334.GO22279@yookeroo.seuss>
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

This patch makes a couple of small cleanups to parameter checking of
libfdt functions.

	- In several functions which take a node offset, we use an
idiom involving fdt_next_tag() first to check that we have indeed been
given a node offset.  This patch adds a helper function
_fdt_check_node_offset() to encapsulate this usage of fdt_next_tag().
- In fdt_rw.c in several places we have the expanded version of the
RW_CHECK_HEADER() macro for no particular reason.  This patch replaces
those instances with an invocation of the macro; that's what it's for.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---
 libfdt/fdt.c             |   17 ++++++++++++-----
 libfdt/fdt_ro.c          |   26 ++++++++------------------
 libfdt/fdt_rw.c          |   23 ++++++++---------------
 libfdt/libfdt_internal.h |    1 +
 4 files changed, 29 insertions(+), 38 deletions(-)

Index: dtc/libfdt/fdt.c
===================================================================
--- dtc.orig/libfdt/fdt.c	2008-03-24 13:04:47.000000000 +1100
+++ dtc/libfdt/fdt.c	2008-05-20 15:54:41.000000000 +1000
@@ -129,16 +129,23 @@ uint32_t fdt_next_tag(const void *fdt, i
 	return tag;
 }
 
+int _fdt_check_node_offset(const void *fdt, int offset)
+{
+	if ((offset < 0) || (offset % FDT_TAGSIZE)
+	    || (fdt_next_tag(fdt, offset, &offset) != FDT_BEGIN_NODE))
+		return -FDT_ERR_BADOFFSET;
+
+	return offset;
+}
+
 int fdt_next_node(const void *fdt, int offset, int *depth)
 {
 	int nextoffset = 0;
 	uint32_t tag;
 
-	if (offset >= 0) {
-		tag = fdt_next_tag(fdt, offset, &nextoffset);
-		if (tag != FDT_BEGIN_NODE)
-			return -FDT_ERR_BADOFFSET;
-	}
+	if (offset >= 0)
+		if ((nextoffset = _fdt_check_node_offset(fdt, offset)) < 0)
+			return nextoffset;
 
 	do {
 		offset = nextoffset;
Index: dtc/libfdt/libfdt_internal.h
===================================================================
--- dtc.orig/libfdt/libfdt_internal.h	2008-03-24 13:04:47.000000000 +1100
+++ dtc/libfdt/libfdt_internal.h	2008-05-20 15:46:41.000000000 +1000
@@ -66,6 +66,7 @@
 	}
 
 uint32_t _fdt_next_tag(const void *fdt, int startoffset, int *nextoffset);
+int _fdt_check_node_offset(const void *fdt, int offset);
 const char *_fdt_find_string(const char *strtab, int tabsize, const char *s);
 int _fdt_node_end_offset(void *fdt, int nodeoffset);
 
Index: dtc/libfdt/fdt_ro.c
===================================================================
--- dtc.orig/libfdt/fdt_ro.c	2008-03-24 13:04:47.000000000 +1100
+++ dtc/libfdt/fdt_ro.c	2008-05-20 16:01:09.000000000 +1000
@@ -157,16 +157,12 @@ int fdt_path_offset(const void *fdt, con
 
 const char *fdt_get_name(const void *fdt, int nodeoffset, int *len)
 {
-	const struct fdt_node_header *nh;
+	const struct fdt_node_header *nh = _fdt_offset_ptr(fdt, nodeoffset);
 	int err;
 
-	if ((err = fdt_check_header(fdt)) != 0)
-		goto fail;
-
-	err = -FDT_ERR_BADOFFSET;
-	nh = fdt_offset_ptr(fdt, nodeoffset, sizeof(*nh));
-	if (!nh || (fdt32_to_cpu(nh->tag) != FDT_BEGIN_NODE))
-		goto fail;
+	if (((err = fdt_check_header(fdt)) != 0)
+	    || ((err = _fdt_check_node_offset(fdt, nodeoffset)) < 0))
+			goto fail;
 
 	if (len)
 		*len = strlen(nh->name);
@@ -189,17 +185,11 @@ const struct fdt_property *fdt_get_prope
 	int offset, nextoffset;
 	int err;
 
-	if ((err = fdt_check_header(fdt)) != 0)
-		goto fail;
-
-	err = -FDT_ERR_BADOFFSET;
-	if (nodeoffset % FDT_TAGSIZE)
-		goto fail;
-
-	tag = fdt_next_tag(fdt, nodeoffset, &nextoffset);
-	if (tag != FDT_BEGIN_NODE)
-		goto fail;
+	if (((err = fdt_check_header(fdt)) != 0)
+	    || ((err = _fdt_check_node_offset(fdt, nodeoffset)) < 0))
+			goto fail;
 
+	nextoffset = err;
 	do {
 		offset = nextoffset;
 
Index: dtc/libfdt/fdt_rw.c
===================================================================
--- dtc.orig/libfdt/fdt_rw.c	2008-05-20 16:03:11.000000000 +1000
+++ dtc/libfdt/fdt_rw.c	2008-05-20 16:13:32.000000000 +1000
@@ -172,8 +172,7 @@ int fdt_add_mem_rsv(void *fdt, uint64_t 
 	struct fdt_reserve_entry *re;
 	int err;
 
-	if ((err = rw_check_header(fdt)))
-		return err;
+	RW_CHECK_HEADER(fdt);
 
 	re = _fdt_mem_rsv_w(fdt, fdt_num_mem_rsv(fdt));
 	err = _blob_splice_mem_rsv(fdt, re, 0, 1);
@@ -190,8 +189,8 @@ int fdt_del_mem_rsv(void *fdt, int n)
 	struct fdt_reserve_entry *re = _fdt_mem_rsv_w(fdt, n);
 	int err;
 
-	if ((err = rw_check_header(fdt)))
-		return err;
+	RW_CHECK_HEADER(fdt);
+
 	if (n >= fdt_num_mem_rsv(fdt))
 		return -FDT_ERR_NOTFOUND;
 
@@ -223,15 +222,13 @@ static int _resize_property(void *fdt, i
 static int _add_property(void *fdt, int nodeoffset, const char *name, int len,
 			 struct fdt_property **prop)
 {
-	uint32_t tag;
 	int proplen;
 	int nextoffset;
 	int namestroff;
 	int err;
 
-	tag = fdt_next_tag(fdt, nodeoffset, &nextoffset);
-	if (tag != FDT_BEGIN_NODE)
-		return -FDT_ERR_BADOFFSET;
+	if ((nextoffset = _fdt_check_node_offset(fdt, nodeoffset)) < 0)
+		return nextoffset;
 
 	namestroff = _find_add_string(fdt, name);
 	if (namestroff < 0)
@@ -256,8 +253,7 @@ int fdt_set_name(void *fdt, int nodeoffs
 	int oldlen, newlen;
 	int err;
 
-	if ((err = rw_check_header(fdt)))
-		return err;
+	RW_CHECK_HEADER(fdt);
 
 	namep = (char *)fdt_get_name(fdt, nodeoffset, &oldlen);
 	if (!namep)
@@ -280,8 +276,7 @@ int fdt_setprop(void *fdt, int nodeoffse
 	struct fdt_property *prop;
 	int err;
 
-	if ((err = rw_check_header(fdt)))
-		return err;
+	RW_CHECK_HEADER(fdt);
 
 	err = _resize_property(fdt, nodeoffset, name, len, &prop);
 	if (err == -FDT_ERR_NOTFOUND)
@@ -454,9 +449,7 @@ int fdt_pack(void *fdt)
 	int mem_rsv_size;
 	int err;
 
-	err = rw_check_header(fdt);
-	if (err)
-		return err;
+	RW_CHECK_HEADER(fdt);
 
 	mem_rsv_size = (fdt_num_mem_rsv(fdt)+1)
 		* sizeof(struct fdt_reserve_entry);

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

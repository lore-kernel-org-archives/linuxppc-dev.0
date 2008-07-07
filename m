Return-Path: <dgibson@ozlabs.org>
Date: Mon, 7 Jul 2008 10:10:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Enable and fix -Wpointer-arith warnings
Message-ID: <20080707001048.GC6267@yookeroo.seuss>
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

This patch turns on the -Wpointer-arith option in the dtc Makefile,
and fixes the resulting warnings due to using (void *) in pointer
arithmetic.  While convenient, pointer arithmetic on void * is not
portable, so it's better that we avoid it, particularly in libfdt.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/Makefile
===================================================================
--- dtc.orig/Makefile	2008-07-04 11:48:05.000000000 +1000
+++ dtc/Makefile	2008-07-04 16:54:42.000000000 +1000
@@ -16,7 +16,7 @@
 CONFIG_LOCALVERSION =
 
 CPPFLAGS = -I libfdt
-CFLAGS = -Wall -g -Os
+CFLAGS = -Wall -g -Os -Wpointer-arith
 
 CPPFLAGS += -std=c99 -D_XOPEN_SOURCE -D_BSD_SOURCE
 CFLAGS += -Werror
Index: dtc/libfdt/fdt.c
===================================================================
--- dtc.orig/libfdt/fdt.c	2008-07-04 13:13:49.000000000 +1000
+++ dtc/libfdt/fdt.c	2008-07-04 14:04:05.000000000 +1000
@@ -76,7 +76,7 @@
 
 const void *fdt_offset_ptr(const void *fdt, int offset, int len)
 {
-	const void *p;
+	const char *p;
 
 	if (fdt_version(fdt) >= 0x11)
 		if (((offset + len) < offset)
Index: dtc/libfdt/fdt_ro.c
===================================================================
--- dtc.orig/libfdt/fdt_ro.c	2008-07-04 13:13:17.000000000 +1000
+++ dtc/libfdt/fdt_ro.c	2008-07-04 16:54:42.000000000 +1000
@@ -408,10 +408,10 @@
 					     &phandle, sizeof(phandle));
 }
 
-int _stringlist_contains(const void *strlist, int listlen, const char *str)
+int _stringlist_contains(const char *strlist, int listlen, const char *str)
 {
 	int len = strlen(str);
-	const void *p;
+	const char *p;
 
 	while (listlen >= len) {
 		if (memcmp(str, strlist, len+1) == 0)
Index: dtc/libfdt/libfdt_internal.h
===================================================================
--- dtc.orig/libfdt/libfdt_internal.h	2008-07-04 13:11:47.000000000 +1000
+++ dtc/libfdt/libfdt_internal.h	2008-07-04 16:54:42.000000000 +1000
@@ -72,7 +72,7 @@
 
 static inline const void *_fdt_offset_ptr(const void *fdt, int offset)
 {
-	return fdt + fdt_off_dt_struct(fdt) + offset;
+	return (const char *)fdt + fdt_off_dt_struct(fdt) + offset;
 }
 
 static inline void *_fdt_offset_ptr_w(void *fdt, int offset)
@@ -82,8 +82,8 @@
 
 static inline const struct fdt_reserve_entry *_fdt_mem_rsv(const void *fdt, int n)
 {
-	const struct fdt_reserve_entry *rsv_table =
-		fdt + fdt_off_mem_rsvmap(fdt);
+	const struct fdt_reserve_entry *rsv_table = (struct fdt_reserve_entry *)
+		((const char *)fdt + fdt_off_mem_rsvmap(fdt));
 
 	return rsv_table + n;
 }
Index: dtc/libfdt/fdt_sw.c
===================================================================
--- dtc.orig/libfdt/fdt_sw.c	2008-07-04 13:15:50.000000000 +1000
+++ dtc/libfdt/fdt_sw.c	2008-07-04 14:04:33.000000000 +1000
@@ -121,7 +121,7 @@
 	if ((offset + sizeof(*re)) > fdt_totalsize(fdt))
 		return -FDT_ERR_NOSPACE;
 
-	re = (struct fdt_reserve_entry *)(fdt + offset);
+	re = (struct fdt_reserve_entry *)((char *)fdt + offset);
 	re->address = cpu_to_fdt64(addr);
 	re->size = cpu_to_fdt64(size);
 
Index: dtc/libfdt/fdt_wip.c
===================================================================
--- dtc.orig/libfdt/fdt_wip.c	2008-07-04 13:15:06.000000000 +1000
+++ dtc/libfdt/fdt_wip.c	2008-07-04 14:05:42.000000000 +1000
@@ -76,7 +76,7 @@
 {
 	uint32_t *p;
 
-	for (p = start; (void *)p < (start + len); p++)
+	for (p = start; (char *)p < ((char *)start + len); p++)
 		*p = cpu_to_fdt32(FDT_NOP);
 }
 
Index: dtc/libfdt/fdt_rw.c
===================================================================
--- dtc.orig/libfdt/fdt_rw.c	2008-07-04 13:25:22.000000000 +1000
+++ dtc/libfdt/fdt_rw.c	2008-07-04 16:54:42.000000000 +1000
@@ -94,13 +94,14 @@
 	return fdt_off_dt_strings(fdt) + fdt_size_dt_strings(fdt);
 }
 
-static int _blob_splice(void *fdt, void *p, int oldlen, int newlen)
+static int _blob_splice(void *fdt, void *splicepoint, int oldlen, int newlen)
 {
-	void *end = fdt + _blob_data_size(fdt);
+	char *p = splicepoint;
+	char *end = (char *)fdt + _blob_data_size(fdt);
 
 	if (((p + oldlen) < p) || ((p + oldlen) > end))
 		return -FDT_ERR_BADOFFSET;
-	if ((end - oldlen + newlen) > (fdt + fdt_totalsize(fdt)))
+	if ((end - oldlen + newlen) > ((char *)fdt + fdt_totalsize(fdt)))
 		return -FDT_ERR_NOSPACE;
 	memmove(p + newlen, p + oldlen, end - p - oldlen);
 	return 0;
@@ -135,7 +136,8 @@
 
 static int _blob_splice_string(void *fdt, int newlen)
 {
-	void *p = fdt + fdt_off_dt_strings(fdt) + fdt_size_dt_strings(fdt);
+	void *p = (char *)fdt
+		+ fdt_off_dt_strings(fdt) + fdt_size_dt_strings(fdt);
 	int err;
 
 	if ((err = _blob_splice(fdt, p, 0, newlen)))
@@ -338,7 +340,7 @@
 	nh->tag = cpu_to_fdt32(FDT_BEGIN_NODE);
 	memset(nh->name, 0, ALIGN(namelen+1, FDT_TAGSIZE));
 	memcpy(nh->name, name, namelen);
-	endtag = (uint32_t *)((void *)nh + nodelen - FDT_TAGSIZE);
+	endtag = (uint32_t *)((char *)nh + nodelen - FDT_TAGSIZE);
 	*endtag = cpu_to_fdt32(FDT_END_NODE);
 
 	return offset;
@@ -363,7 +365,7 @@
 				   endoffset - nodeoffset, 0);
 }
 
-static void _packblocks(const void *fdt, void *buf,
+static void _packblocks(const char *old, char *new,
 		       int mem_rsv_size, int struct_size)
 {
 	int mem_rsv_off, struct_off, strings_off;
@@ -372,17 +374,17 @@
 	struct_off = mem_rsv_off + mem_rsv_size;
 	strings_off = struct_off + struct_size;
 
-	memmove(buf + mem_rsv_off, fdt + fdt_off_mem_rsvmap(fdt), mem_rsv_size);
-	fdt_set_off_mem_rsvmap(buf, mem_rsv_off);
+	memmove(new + mem_rsv_off, old + fdt_off_mem_rsvmap(old), mem_rsv_size);
+	fdt_set_off_mem_rsvmap(new, mem_rsv_off);
 
-	memmove(buf + struct_off, fdt + fdt_off_dt_struct(fdt), struct_size);
-	fdt_set_off_dt_struct(buf, struct_off);
-	fdt_set_size_dt_struct(buf, struct_size);
-
-	memmove(buf + strings_off, fdt + fdt_off_dt_strings(fdt),
-		fdt_size_dt_strings(fdt));
-	fdt_set_off_dt_strings(buf, strings_off);
-	fdt_set_size_dt_strings(buf, fdt_size_dt_strings(fdt));
+	memmove(new + struct_off, old + fdt_off_dt_struct(old), struct_size);
+	fdt_set_off_dt_struct(new, struct_off);
+	fdt_set_size_dt_struct(new, struct_size);
+
+	memmove(new + strings_off, old + fdt_off_dt_strings(old),
+		fdt_size_dt_strings(old));
+	fdt_set_off_dt_strings(new, strings_off);
+	fdt_set_size_dt_strings(new, fdt_size_dt_strings(old));
 }
 
 int fdt_open_into(const void *fdt, void *buf, int bufsize)
@@ -390,7 +392,9 @@
 	int err;
 	int mem_rsv_size, struct_size;
 	int newsize;
-	void *tmp;
+	const char *fdtstart = fdt;
+	const char *fdtend = fdtstart + fdt_totalsize(fdt);
+	char *tmp;
 
 	CHECK_HEADER(fdt);
 
@@ -423,12 +427,13 @@
 	if (bufsize < newsize)
 		return -FDT_ERR_NOSPACE;
 
-	if (((buf + newsize) <= fdt)
-	    || (buf >= (fdt + fdt_totalsize(fdt)))) {
-		tmp = buf;
-	} else {
-		tmp = (void *)fdt + fdt_totalsize(fdt);
-		if ((tmp + newsize) > (buf + bufsize))
+	/* First attempt to build converted tree at beginning of buffer */
+	tmp = buf;
+	/* But if that overlaps with the old tree... */
+	if (((tmp + newsize) > fdtstart) && (tmp < fdtend)) {
+		/* Try right after the old tree instead */
+		tmp = (char *)fdtend;
+		if ((tmp + newsize) > ((char *)buf + bufsize))
 			return -FDT_ERR_NOSPACE;
 	}
 
Index: dtc/ftdump.c
===================================================================
--- dtc.orig/ftdump.c	2008-07-04 13:42:44.000000000 +1000
+++ dtc/ftdump.c	2008-07-04 16:54:42.000000000 +1000
@@ -70,9 +70,9 @@
 	uint32_t off_dt = fdt32_to_cpu(bph->off_dt_struct);
 	uint32_t off_str = fdt32_to_cpu(bph->off_dt_strings);
 	struct fdt_reserve_entry *p_rsvmap =
-		(struct fdt_reserve_entry *)(blob + off_mem_rsvmap);
-	char *p_struct = blob + off_dt;
-	char *p_strings = blob + off_str;
+		(struct fdt_reserve_entry *)((char *)blob + off_mem_rsvmap);
+	char *p_struct = (char *)blob + off_dt;
+	char *p_strings = (char *)blob + off_str;
 	uint32_t version = fdt32_to_cpu(bph->version);
 	uint32_t totalsize = fdt32_to_cpu(bph->totalsize);
 	uint32_t tag;
Index: dtc/tests/incbin.c
===================================================================
--- dtc.orig/tests/incbin.c	2008-07-04 13:47:25.000000000 +1000
+++ dtc/tests/incbin.c	2008-07-04 13:48:00.000000000 +1000
@@ -31,10 +31,10 @@
 
 #define CHUNKSIZE	1024
 
-void *load_file(const char *name, int *len)
+char *load_file(const char *name, int *len)
 {
 	FILE *f;
-	void *buf = NULL;
+	char *buf = NULL;
 	int bufsize = 0, n;
 
 	*len = 0;
@@ -60,7 +60,8 @@
 
 int main(int argc, char *argv[])
 {
-	void *fdt, *incbin;
+	void *fdt;
+	char *incbin;
 	int len;
 
 	test_init(argc, argv);
Index: dtc/tests/mangle-layout.c
===================================================================
--- dtc.orig/tests/mangle-layout.c	2008-07-04 13:44:25.000000000 +1000
+++ dtc/tests/mangle-layout.c	2008-07-04 14:27:52.000000000 +1000
@@ -31,7 +31,7 @@
 #include "testdata.h"
 
 struct bufstate {
-	void *buf;
+	char *buf;
 	int size;
 };
 
@@ -73,7 +73,7 @@
 	case 'm':
 		/* Memory reserve map */
 		align = 8;
-		src = fdt + fdt_off_mem_rsvmap(fdt);
+		src = (const char *)fdt + fdt_off_mem_rsvmap(fdt);
 		size = (fdt_num_mem_rsv(fdt) + 1)
 			* sizeof(struct fdt_reserve_entry);
 		break;
@@ -81,14 +81,14 @@
 	case 't':
 		/* Structure block */
 		align = 4;
-		src = fdt + fdt_off_dt_struct(fdt);
+		src = (const char *)fdt + fdt_off_dt_struct(fdt);
 		size = fdt_size_dt_struct(fdt);
 		break;
 
 	case 's':
 		/* Strings block */
 		align = 1;
-		src = fdt + fdt_off_dt_strings(fdt);
+		src = (const char *)fdt + fdt_off_dt_strings(fdt);
 		size = fdt_size_dt_strings(fdt);
 		break;
 	default:
Index: dtc/tests/move_and_save.c
===================================================================
--- dtc.orig/tests/move_and_save.c	2008-07-04 13:44:04.000000000 +1000
+++ dtc/tests/move_and_save.c	2008-07-04 14:09:34.000000000 +1000
@@ -33,7 +33,7 @@
 int main(int argc, char *argv[])
 {
 	void *fdt, *fdt1, *fdt2, *fdt3;
-	void *buf;
+	char *buf;
 	int shuntsize;
 	int bufsize;
 	int err;
Index: dtc/tests/nopulate.c
===================================================================
--- dtc.orig/tests/nopulate.c	2008-07-04 13:45:22.000000000 +1000
+++ dtc/tests/nopulate.c	2008-07-04 14:09:52.000000000 +1000
@@ -30,7 +30,7 @@
 #include "tests.h"
 #include "testdata.h"
 
-int nopulate_struct(char *buf, const void *fdt)
+int nopulate_struct(char *buf, const char *fdt)
 {
 	int offset, nextoffset = 0;
 	uint32_t tag;
@@ -42,7 +42,7 @@
 		offset = nextoffset;
 		tag = fdt_next_tag(fdt, offset, &nextoffset);
 
-		memcpy(p, fdt + fdt_off_dt_struct(fdt) + offset,
+		memcpy(p, (const char *)fdt + fdt_off_dt_struct(fdt) + offset,
 		       nextoffset - offset);
 		p += nextoffset - offset;
 
@@ -56,8 +56,7 @@
 
 int main(int argc, char *argv[])
 {
-	void *fdt, *fdt2;
-	void *buf;
+	char *fdt, *fdt2, *buf;
 	int newsize, struct_start, struct_end_old, struct_end_new, delta;
 	const char *inname;
 	char outname[PATH_MAX];
Index: dtc/tests/testutils.c
===================================================================
--- dtc.orig/tests/testutils.c	2008-07-04 13:43:43.000000000 +1000
+++ dtc/tests/testutils.c	2008-07-04 14:10:05.000000000 +1000
@@ -200,7 +200,7 @@
 	int fd;
 	int totalsize;
 	int offset;
-	void *p;
+	char *p;
 	int ret;
 
 	fd = open(filename, O_WRONLY | O_CREAT | O_TRUNC, 0666);

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

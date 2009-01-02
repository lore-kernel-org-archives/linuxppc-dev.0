Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id A7916DE002
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Jan 2009 08:04:56 +1100 (EST)
From: Milton Miller <miltonm@bga.com>
To: Simon Horman <horms@verge.net.au>, <kexec@lists.infradead.org> 
Message-Id: <kexec-29-1-4r.miltonm@bga.com>
In-Reply-To: <kexec-29-1.miltonm@bga.com>
Subject: [PATCH kexec-tools 4/5] ppc64: cleanups
Date: Fri, 02 Jan 2009 15:04:48 -0600
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

don't copy purgatory, as elf-load-rel does that for us (like x86_64).

move function declarations from c to h files

remove casts between void  * and various pointers

change some pointers between char and unsigned char *

change args to be vars of the right type instead of casting or
copying between types

Signed-off-by: Milton Miller <miltonm@bga.com>
---
we still need to cast purgatory or we get a signed-ness warning on the pointer


Index: kexec-tools/kexec/arch/ppc64/fs2dt.c
===================================================================
--- kexec-tools.orig/kexec/arch/ppc64/fs2dt.c	2009-01-02 02:16:17.000000000 -0600
+++ kexec-tools/kexec/arch/ppc64/fs2dt.c	2009-01-02 02:16:19.000000000 -0600
@@ -46,8 +46,6 @@ static unsigned long long mem_rsrv[2*MEM
 
 static int crash_param = 0;
 static char local_cmdline[COMMAND_LINE_SIZE] = { "" };
-static unsigned *dt_len; /* changed len of modified cmdline
-			    in flat device-tree */
 extern mem_rgns_t usablemem_rgns;
 static struct bootblock bb[1];
 
@@ -314,7 +312,6 @@ static void putprops(char *fn, struct di
 		len = statbuf.st_size;
 
 		*dt++ = 3;
-		dt_len = dt;
 		*dt++ = len;
 		*dt++ = propnum(fn);
 
@@ -509,12 +506,11 @@ static void putnode(void)
 	free(namelist);
 }
 
-int create_flatten_tree(struct kexec_info *info, unsigned char **bufp,
-			unsigned long *sizep, char *cmdline)
+int create_flatten_tree(char **bufp, off_t *sizep, char *cmdline)
 {
 	unsigned long len;
 	unsigned long tlen;
-	unsigned char *buf;
+	char *buf;
 	unsigned long me;
 
 	me = 0;
@@ -556,7 +552,7 @@ int create_flatten_tree(struct kexec_inf
 
 	reserve(me, bb->totalsize); /* patched later in kexec_load */
 
-	buf = (unsigned char *) malloc(bb->totalsize);
+	buf = malloc(bb->totalsize);
 	*bufp = buf;
 	memcpy(buf, bb, bb->off_mem_rsvmap);
 	tlen = bb->off_mem_rsvmap;
Index: kexec-tools/kexec/arch/ppc64/kexec-elf-ppc64.c
===================================================================
--- kexec-tools.orig/kexec/arch/ppc64/kexec-elf-ppc64.c	2009-01-02 02:16:17.000000000 -0600
+++ kexec-tools/kexec/arch/ppc64/kexec-elf-ppc64.c	2009-01-02 02:16:19.000000000 -0600
@@ -42,10 +42,6 @@ uint64_t initrd_base, initrd_size;
 unsigned char reuse_initrd = 0;
 const char *ramdisk;
 
-int create_flatten_tree(struct kexec_info *, unsigned char **, unsigned long *,
-			char *);
-int my_r2(struct mem_ehdr *ehdr);
-
 int elf_ppc64_probe(const char *buf, off_t len)
 {
 	struct mem_ehdr ehdr;
@@ -80,7 +76,7 @@ int elf_ppc64_load(int argc, char **argv
 	const char *devicetreeblob;
 	int cmdline_len, modified_cmdline_len;
 	uint64_t max_addr, hole_addr;
-	unsigned char *seg_buf = NULL;
+	char *seg_buf = NULL;
 	off_t seg_size = 0;
 	struct mem_phdr *phdr;
 	size_t size;
@@ -187,8 +183,7 @@ int elf_ppc64_load(int argc, char **argv
 	if (size > phdr->p_memsz)
 		size = phdr->p_memsz;
 
-	my_kernel = hole_addr = (uint64_t)locate_hole(info, size, 0, 0,
-			max_addr, 1);
+	my_kernel = hole_addr = locate_hole(info, size, 0, 0, max_addr, 1);
 	ehdr.e_phdr[0].p_paddr = hole_addr;
 	result = elf_exec_load(&ehdr, info);
 	if (result < 0) {
@@ -210,16 +205,6 @@ int elf_ppc64_load(int argc, char **argv
 	}
 
 	/* Add v2wrap to the current image */
-	seg_buf = NULL;
-	seg_size = 0;
-
-	seg_buf = (unsigned char *) malloc(purgatory_size);
-	if (seg_buf == NULL) {
-		free_elf_info(&ehdr);
-		return -1;
-	}
-	memcpy(seg_buf, purgatory, purgatory_size);
-	seg_size = purgatory_size;
 	elf_rel_build_load(info, &info->rhdr, (const char *)purgatory,
 				purgatory_size, 0, max_addr, 1, 0);
 
@@ -232,7 +217,7 @@ int elf_ppc64_load(int argc, char **argv
 			"Can't use ramdisk with device tree blob input\n");
 			return -1;
 		}
-		seg_buf = (unsigned char *)slurp_file(ramdisk, &seg_size);
+		seg_buf = slurp_file(ramdisk, &seg_size);
 		hole_addr = add_buffer(info, seg_buf, seg_size, seg_size,
 			0, 0, max_addr, 1);
 		initrd_base = hole_addr;
@@ -240,21 +225,11 @@ int elf_ppc64_load(int argc, char **argv
 	} /* ramdisk */
 
 	if (devicetreeblob) {
-		unsigned char *blob_buf = NULL;
-		off_t blob_size = 0;
-
 		/* Grab device tree from buffer */
-		blob_buf =
-			(unsigned char *)slurp_file(devicetreeblob, &blob_size);
-
-		seg_buf = blob_buf;
-		seg_size = blob_size;
+		seg_buf = slurp_file(devicetreeblob, &seg_size);
 	} else {
 		/* create from fs2dt */
-		seg_buf = NULL;
-		seg_size = 0;
-		create_flatten_tree(info, (unsigned char **)&seg_buf,
-				(unsigned long *)&seg_size,cmdline);
+		create_flatten_tree(&seg_buf, &seg_size, cmdline);
 	}
 	my_dt_offset = add_buffer(info, seg_buf, seg_size, seg_size,
 				0, 0, max_addr, -1);
@@ -264,14 +239,13 @@ int elf_ppc64_load(int argc, char **argv
 	 * entry is before this one
 	 */
 	bb_ptr = (struct bootblock *)(seg_buf);
-	rsvmap_ptr = (uint64_t *)
-		(((char *)seg_buf) + bb_ptr->off_mem_rsvmap);
+	rsvmap_ptr = (uint64_t *)(seg_buf + bb_ptr->off_mem_rsvmap);
 	while (*rsvmap_ptr || *(rsvmap_ptr+1))
 		rsvmap_ptr += 2;
 	rsvmap_ptr -= 2;
 	*rsvmap_ptr = my_dt_offset;
 	rsvmap_ptr++;
-	*rsvmap_ptr = (uint64_t)bb_ptr->totalsize;
+	*rsvmap_ptr = bb_ptr->totalsize;
 
 	/* Set kernel */
 	elf_rel_set_symbol(&info->rhdr, "kernel", &my_kernel, sizeof(my_kernel));
@@ -319,7 +293,7 @@ int elf_ppc64_load(int argc, char **argv
 	elf_rel_set_symbol(&info->rhdr, "stack", &my_stack, sizeof(my_stack));
 
 	/* Set toc */
-	toc_addr = (unsigned long) my_r2(&info->rhdr);
+	toc_addr = my_r2(&info->rhdr);
 	elf_rel_set_symbol(&info->rhdr, "my_toc", &toc_addr, sizeof(toc_addr));
 
 #ifdef DEBUG
Index: kexec-tools/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
===================================================================
--- kexec-tools.orig/kexec/arch/ppc64/kexec-elf-rel-ppc64.c	2009-01-02 02:16:17.000000000 -0600
+++ kexec-tools/kexec/arch/ppc64/kexec-elf-rel-ppc64.c	2009-01-02 02:16:19.000000000 -0600
@@ -3,6 +3,7 @@
 #include <string.h>
 #include "../../kexec.h"
 #include "../../kexec-elf.h"
+#include "kexec-ppc64.h"
 
 int machine_verify_elf_rel(struct mem_ehdr *ehdr)
 {
Index: kexec-tools/kexec/arch/ppc64/kexec-ppc64.h
===================================================================
--- kexec-tools.orig/kexec/arch/ppc64/kexec-ppc64.h	2009-01-02 02:16:17.000000000 -0600
+++ kexec-tools/kexec/arch/ppc64/kexec-ppc64.h	2009-01-02 02:16:19.000000000 -0600
@@ -14,6 +14,9 @@ int elf_ppc64_load(int argc, char **argv
 void elf_ppc64_usage(void);
 void reserve(unsigned long long where, unsigned long long length);
 
+int create_flatten_tree(char **, off_t *, char *);
+unsigned long my_r2(const struct mem_ehdr *ehdr);
+
 extern uint64_t initrd_base, initrd_size;
 extern int max_memory_ranges;
 extern unsigned char reuse_initrd;

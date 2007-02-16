Return-Path: <dgibson@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 1/3] zImage: Add more flexible gunzip convenience functions
In-Reply-To: <20070216062458.GA23008@localhost.localdomain>
Message-Id: <20070216062739.37C95DDD05@ozlabs.org>
Date: Fri, 16 Feb 2007 17:27:39 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

At present, arch/powerpc/boot/main.c includes a gunzip() function
which is a convenient wrapper around zlib.  However, it doesn't
conveniently allow decompressing part of an image to one location,
then the remainder to a different address.

This patch adds a new set of more flexible convenience wrappers around
zlib, moving them to their own file, gunzip_util.c, in the process.
These wrappers allow decompressing sections of the compressed image to
different locations.  In addition, they transparently handle
uncompressed data, avoiding special case code to handle uncompressed
vmlinux images.

The patch also converts main.c to use the new wrappers, using the new
flexibility to avoid decompressing the vmlinux's ELF header twice as
we did previously.  That in turn means we avoid extending our
allocations for the vmlinux to allow space for the extra copy of the
ELF header.

Signed-off-by: David Gibson <dwg@au1.ibm.com>
---

 arch/powerpc/boot/Makefile      |    3 
 arch/powerpc/boot/gunzip_util.c |  140 ++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/gunzip_util.h |   30 ++++++++
 arch/powerpc/boot/main.c        |  112 +++++---------------------------
 4 files changed, 191 insertions(+), 94 deletions(-)

Index: working-2.6/arch/powerpc/boot/gunzip_util.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ working-2.6/arch/powerpc/boot/gunzip_util.c	2007-02-16 12:21:27.000000000 +1100
@@ -0,0 +1,140 @@
+/*
+ * Copyright 2007 David Gibson, IBM Corporation.
+ * Based on earlier work, Copyright (C) Paul Mackerras 1997.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <stddef.h>
+#include "string.h"
+#include "stdio.h"
+#include "ops.h"
+#include "gunzip_util.h"
+
+struct gunzip_state state;
+
+#define HEAD_CRC	2
+#define EXTRA_FIELD	4
+#define ORIG_NAME	8
+#define COMMENT		0x10
+#define RESERVED	0xe0
+
+void gunzip_start(struct gunzip_state *state, void *src, int srclen)
+{
+	char *hdr = src;
+	int hdrlen = 0;
+
+	memset(state, 0, sizeof(*state));
+
+	/* Check for gzip magic number */
+	if ((hdr[0] == 0x1f) && (hdr[1] == 0x8b)) {
+		/* gzip data, initialize zlib parameters */
+		int r, flags;
+
+		state->s.workspace = state->scratch;
+		if (zlib_inflate_workspacesize() > sizeof(state->scratch)) {
+			printf("insufficient scratch space for gunzip\n\r");
+			exit();
+		}
+
+		/* skip header */
+		hdrlen = 10;
+		flags = hdr[3];
+		if (hdr[2] != Z_DEFLATED || (flags & RESERVED) != 0) {
+			printf("bad gzipped data\n\r");
+			exit();
+		}
+		if ((flags & EXTRA_FIELD) != 0)
+			hdrlen = 12 + hdr[10] + (hdr[11] << 8);
+		if ((flags & ORIG_NAME) != 0)
+			while (hdr[hdrlen++] != 0)
+				;
+		if ((flags & COMMENT) != 0)
+			while (hdr[hdrlen++] != 0)
+				;
+		if ((flags & HEAD_CRC) != 0)
+			hdrlen += 2;
+		if (hdrlen >= srclen) {
+			printf("gunzip_start: ran out of data in header\n\r");
+			exit();
+		}
+
+		r = zlib_inflateInit2(&state->s, -MAX_WBITS);
+		if (r != Z_OK) {
+			printf("inflateInit2 returned %d\n\r", r);
+			exit();
+		}
+	}
+
+	state->s.next_in = src + hdrlen;
+	state->s.avail_in = srclen - hdrlen;
+}
+
+int gunzip_partial(struct gunzip_state *state, void *dst, int dstlen)
+{
+	int len;
+
+	if (state->s.workspace) {
+		/* gunzipping */
+		int r;
+
+		state->s.next_out = dst;
+		state->s.avail_out = dstlen;
+		r = zlib_inflate(&state->s, Z_FULL_FLUSH);
+		if (r != Z_OK && r != Z_STREAM_END) {
+			printf("inflate returned %d msg: %s\n\r", r, state->s.msg);
+			exit();
+		}
+		len = state->s.next_out - (unsigned char *)dst;
+	} else {
+		/* uncompressed image */
+		len = min(state->s.avail_in, (unsigned)dstlen);
+		memcpy(dst, state->s.next_in, len);
+		state->s.next_in += len;
+		state->s.avail_in -= len;
+	}
+	return len;
+}
+
+void gunzip_exactly(struct gunzip_state *state, void *dst, int dstlen)
+{
+	int len;
+
+	len  = gunzip_partial(state, dst, dstlen);
+	if (len < dstlen) {
+			printf("gunzip_block: ran out of data\n\r");
+			exit();
+	}
+}
+
+void gunzip_discard(struct gunzip_state *state, int len)
+{
+	static char discard_buf[128];
+
+	while (len > sizeof(discard_buf)) {
+		gunzip_exactly(state, discard_buf, sizeof(discard_buf));
+		len -= sizeof(discard_buf);
+	}
+
+	if (len > 0)
+		gunzip_exactly(state, discard_buf, len);
+}
+
+int gunzip_finish(struct gunzip_state *state, void *dst, int dstlen)
+{
+	int len;
+
+	if (state->s.workspace) {
+		len = gunzip_partial(state, dst, dstlen);
+		zlib_inflateEnd(&state->s);
+	} else {
+		/* uncompressed image */
+		len = min(state->s.avail_in, (unsigned)dstlen);
+		memcpy(dst, state->s.next_in, len);
+	}
+
+	return len;
+}
Index: working-2.6/arch/powerpc/boot/main.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/main.c	2007-02-16 12:19:18.000000000 +1100
+++ working-2.6/arch/powerpc/boot/main.c	2007-02-16 12:21:47.000000000 +1100
@@ -14,8 +14,8 @@
 #include "page.h"
 #include "string.h"
 #include "stdio.h"
-#include "zlib.h"
 #include "ops.h"
+#include "gunzip_util.h"
 #include "flatdevtree.h"
 
 extern void flush_cache(void *, unsigned long);
@@ -42,71 +42,12 @@ static struct addr_range initrd;
 static unsigned long elfoffset;
 static int is_64bit;
 
-/* scratch space for gunzip; 46912 is from zlib_inflate_workspacesize() */
-static char scratch[46912];
 static char elfheader[256];
 
 typedef void (*kernel_entry_t)(unsigned long, unsigned long, void *);
 
 #undef DEBUG
 
-#define HEAD_CRC	2
-#define EXTRA_FIELD	4
-#define ORIG_NAME	8
-#define COMMENT		0x10
-#define RESERVED	0xe0
-
-static void gunzip(void *dst, int dstlen, unsigned char *src, int *lenp)
-{
-	z_stream s;
-	int r, i, flags;
-
-	/* skip header */
-	i = 10;
-	flags = src[3];
-	if (src[2] != Z_DEFLATED || (flags & RESERVED) != 0) {
-		printf("bad gzipped data\n\r");
-		exit();
-	}
-	if ((flags & EXTRA_FIELD) != 0)
-		i = 12 + src[10] + (src[11] << 8);
-	if ((flags & ORIG_NAME) != 0)
-		while (src[i++] != 0)
-			;
-	if ((flags & COMMENT) != 0)
-		while (src[i++] != 0)
-			;
-	if ((flags & HEAD_CRC) != 0)
-		i += 2;
-	if (i >= *lenp) {
-		printf("gunzip: ran out of data in header\n\r");
-		exit();
-	}
-
-	if (zlib_inflate_workspacesize() > sizeof(scratch)) {
-		printf("gunzip needs more mem\n");
-		exit();
-	}
-	memset(&s, 0, sizeof(s));
-	s.workspace = scratch;
-	r = zlib_inflateInit2(&s, -MAX_WBITS);
-	if (r != Z_OK) {
-		printf("inflateInit2 returned %d\n\r", r);
-		exit();
-	}
-	s.next_in = src + i;
-	s.avail_in = *lenp - i;
-	s.next_out = dst;
-	s.avail_out = dstlen;
-	r = zlib_inflate(&s, Z_FULL_FLUSH);
-	if (r != Z_OK && r != Z_STREAM_END) {
-		printf("inflate returned %d msg: %s\n\r", r, s.msg);
-		exit();
-	}
-	*lenp = s.next_out - (unsigned char *) dst;
-	zlib_inflateEnd(&s);
-}
-
 static int is_elf64(void *hdr)
 {
 	Elf64_Ehdr *elf64 = hdr;
@@ -132,8 +73,8 @@ static int is_elf64(void *hdr)
 		return 0;
 
 	elfoffset = (unsigned long)elf64ph->p_offset;
-	vmlinux.size = (unsigned long)elf64ph->p_filesz + elfoffset;
-	vmlinux.memsize = (unsigned long)elf64ph->p_memsz + elfoffset;
+	vmlinux.size = (unsigned long)elf64ph->p_filesz;
+	vmlinux.memsize = (unsigned long)elf64ph->p_memsz;
 
 	is_64bit = 1;
 	return 1;
@@ -164,26 +105,22 @@ static int is_elf32(void *hdr)
 		return 0;
 
 	elfoffset = elf32ph->p_offset;
-	vmlinux.size = elf32ph->p_filesz + elf32ph->p_offset;
-	vmlinux.memsize = elf32ph->p_memsz + elf32ph->p_offset;
+	vmlinux.size = elf32ph->p_filesz;
+	vmlinux.memsize = elf32ph->p_memsz;
 	return 1;
 }
 
 static void prep_kernel(unsigned long a1, unsigned long a2)
 {
+	static struct gunzip_state gzstate;
 	int len;
 
 	vmlinuz.addr = (unsigned long)_vmlinux_start;
 	vmlinuz.size = (unsigned long)(_vmlinux_end - _vmlinux_start);
 
 	/* gunzip the ELF header of the kernel */
-	if (*(unsigned short *)vmlinuz.addr == 0x1f8b) {
-		len = vmlinuz.size;
-		gunzip(elfheader, sizeof(elfheader),
-				(unsigned char *)vmlinuz.addr, &len);
-	} else
-		memcpy(elfheader, (const void *)vmlinuz.addr,
-		       sizeof(elfheader));
+	gunzip_start(&gzstate, (void *)vmlinuz.addr, vmlinuz.size);
+	gunzip_exactly(&gzstate, elfheader, sizeof(elfheader));
 
 	if (!is_elf64(elfheader) && !is_elf32(elfheader)) {
 		printf("Error: not a valid PPC32 or PPC64 ELF file!\n\r");
@@ -192,10 +129,10 @@ static void prep_kernel(unsigned long a1
 	if (platform_ops.image_hdr)
 		platform_ops.image_hdr(elfheader);
 
-	/* We need to alloc the memsize plus the file offset since gzip
-	 * will expand the header (file offset), then the kernel, then
-	 * possible rubbish we don't care about. But the kernel bss must
-	 * be claimed (it will be zero'd by the kernel itself)
+	/* We need to alloc the memsize: gzip will expand the kernel
+	 * text/data, then possible rubbish we don't care about. But
+	 * the kernel bss must be claimed (it will be zero'd by the
+	 * kernel itself)
 	 */
 	printf("Allocating 0x%lx bytes for kernel ...\n\r", vmlinux.memsize);
 	vmlinux.addr = (unsigned long)malloc(vmlinux.memsize);
@@ -237,24 +174,13 @@ static void prep_kernel(unsigned long a1
 	}
 
 	/* Eventually gunzip the kernel */
-	if (*(unsigned short *)vmlinuz.addr == 0x1f8b) {
-		printf("gunzipping (0x%lx <- 0x%lx:0x%0lx)...",
-		       vmlinux.addr, vmlinuz.addr, vmlinuz.addr+vmlinuz.size);
-		len = vmlinuz.size;
-		gunzip((void *)vmlinux.addr, vmlinux.memsize,
-			(unsigned char *)vmlinuz.addr, &len);
-		printf("done 0x%lx bytes\n\r", len);
-	} else {
-		memmove((void *)vmlinux.addr,(void *)vmlinuz.addr,
-			vmlinuz.size);
-	}
-
-	/* Skip over the ELF header */
-#ifdef DEBUG
-	printf("... skipping 0x%lx bytes of ELF header\n\r",
-			elfoffset);
-#endif
-	vmlinux.addr += elfoffset;
+	printf("gunzipping (0x%lx <- 0x%lx:0x%0lx)...",
+	       vmlinux.addr, vmlinuz.addr, vmlinuz.addr+vmlinuz.size);
+	/* discard up to the actual load data */
+	gunzip_discard(&gzstate, elfoffset - sizeof(elfheader));
+	len = gunzip_finish(&gzstate, (void *)vmlinux.addr,
+			    vmlinux.memsize);
+	printf("done 0x%lx bytes\n\r", len);
 
 	flush_cache((void *)vmlinux.addr, vmlinux.size);
 }
Index: working-2.6/arch/powerpc/boot/Makefile
===================================================================
--- working-2.6.orig/arch/powerpc/boot/Makefile	2007-02-16 12:19:18.000000000 +1100
+++ working-2.6/arch/powerpc/boot/Makefile	2007-02-16 12:19:21.000000000 +1100
@@ -41,7 +41,8 @@ $(addprefix $(obj)/,$(zlib) main.o): $(a
 		$(addprefix $(obj)/,$(zlibheader))
 
 src-wlib := string.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
-		ns16550.c serial.c simple_alloc.c div64.S util.S $(zlib)
+		ns16550.c serial.c simple_alloc.c div64.S util.S \
+		gunzip_util.c $(zlib)
 src-plat := of.c
 src-boot := crt0.S $(src-wlib) $(src-plat) empty.c
 
Index: working-2.6/arch/powerpc/boot/gunzip_util.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ working-2.6/arch/powerpc/boot/gunzip_util.h	2007-02-16 12:21:35.000000000 +1100
@@ -0,0 +1,30 @@
+/*
+ * Decompression convenience functions
+ *
+ * Copyright 2007 David Gibson, IBM Corporation.
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+#ifndef _PPC_BOOT_GUNZIP_UTIL_H_
+#define _PPC_BOOT_GUNZIP_UTIL_H_
+
+#include "zlib.h"
+
+/* scratch space for gunzip; 46912 is from zlib_inflate_workspacesize() */
+#define GUNZIP_SCRATCH_SIZE	46912
+
+struct gunzip_state {
+	char scratch[46912];
+	z_stream s;
+};
+
+void gunzip_start(struct gunzip_state *state, void *src, int srclen);
+int gunzip_partial(struct gunzip_state *state, void *dst, int dstlen);
+void gunzip_exactly(struct gunzip_state *state, void *dst, int len);
+void gunzip_discard(struct gunzip_state *state, int len);
+int gunzip_finish(struct gunzip_state *state, void *dst, int len);
+
+#endif /* _PPC_BOOT_GUNZIP_UTIL_H_ */
+

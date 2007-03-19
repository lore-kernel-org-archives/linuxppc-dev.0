Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 142DCDE0D4
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 08:06:59 +1100 (EST)
Date: Mon, 19 Mar 2007 14:58:03 -0600 (CST)
Subject: [PATCH 4/7] bootwrapper: add a fatal error helper
From: Milton Miller <miltonm@bga.com>
Sender: <miltonm@realtime.net>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <boot-00.miltonm@bga.com>
Message-Id: <boot-04.miltonm@bga.com>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a macro fatal that calls printf then exit.  User must include stdio.h.

Typically replaces 3 lines with 1, although I added back some whitespace.

Signed-off-by: Milton Miller <miltonm@bga.com>
--- 
 gunzip_util.c |   36 ++++++++++++------------------------
 main.c        |   30 +++++++++++-------------------
 of.c          |    7 +++----
 ops.h         |    2 ++
 4 files changed, 28 insertions(+), 47 deletions(-)

Index: kernel/arch/powerpc/boot/main.c
===================================================================
--- kernel.orig/arch/powerpc/boot/main.c	2007-03-19 08:32:50.000000000 -0500
+++ kernel/arch/powerpc/boot/main.c	2007-03-19 08:33:02.000000000 -0500
@@ -120,10 +120,9 @@ static struct addr_range prep_kernel(voi
 	gunzip_start(&gzstate, vmlinuz_addr, vmlinuz_size);
 	gunzip_exactly(&gzstate, elfheader, sizeof(elfheader));
 
-	if (!parse_elf64(elfheader, &ei) && !parse_elf32(elfheader, &ei)) {
-		printf("Error: not a valid PPC32 or PPC64 ELF file!\n\r");
-		exit();
-	}
+	if (!parse_elf64(elfheader, &ei) && !parse_elf32(elfheader, &ei))
+		fatal("Error: not a valid PPC32 or PPC64 ELF file!\n\r");
+
 	if (platform_ops.image_hdr)
 		platform_ops.image_hdr(elfheader);
 
@@ -137,11 +136,9 @@ static struct addr_range prep_kernel(voi
 	if (platform_ops.vmlinux_alloc) {
 		addr = platform_ops.vmlinux_alloc(ei.memsize);
 	} else {
-		if ((unsigned long)_start < ei.memsize) {
-			printf("Insufficient memory for kernel at address 0!"
+		if ((unsigned long)_start < ei.memsize)
+			fatal("Insufficient memory for kernel at address 0!"
 			       " (_start=%lx)\n\r", _start);
-			exit();
-		}
 	}
 
 	/* Finally, gunzip the kernel */
@@ -191,11 +188,9 @@ static struct addr_range prep_initrd(str
 		printf("Allocating 0x%lx bytes for initrd ...\n\r",
 		       initrd_size);
 		initrd_addr = (unsigned long)malloc(initrd_size);
-		if (! initrd_addr) {
-			printf("Can't allocate memory for initial "
+		if (! initrd_addr)
+			fatal("Can't allocate memory for initial "
 			       "ramdisk !\n\r");
-			exit();
-		}
 		printf("Relocating initrd 0x%p <- 0x%p (0x%lx bytes)\n\r",
 		       initrd_addr, old_addr, initrd_size);
 		memmove((void *)initrd_addr, old_addr, initrd_size);
@@ -205,10 +200,8 @@ static struct addr_range prep_initrd(str
 
 	/* Tell the kernel initrd address via device tree */
 	devp = finddevice("/chosen");
-	if (! devp) {
-		printf("Device tree has no chosen node!\n\r");
-		exit();
-	}
+	if (! devp)
+		fatal("Device tree has no chosen node!\n\r");
 
 	initrd_start = (u32)initrd_addr;
 	initrd_end = (u32)initrd_addr + initrd_size;
@@ -305,7 +298,6 @@ void start(void *sp)
 		kentry((unsigned long)initrd.addr, initrd.size,
 		       loader_info.promptr);
 
-	/* console closed so printf below may not work */
-	printf("Error: Linux kernel returned to zImage boot wrapper!\n\r");
-	exit();
+	/* console closed so printf in fatal below may not work */
+	fatal("Error: Linux kernel returned to zImage boot wrapper!\n\r");
 }
Index: kernel/arch/powerpc/boot/of.c
===================================================================
--- kernel.orig/arch/powerpc/boot/of.c	2007-03-19 08:32:50.000000000 -0500
+++ kernel/arch/powerpc/boot/of.c	2007-03-19 08:33:02.000000000 -0500
@@ -212,10 +212,9 @@ static void *of_vmlinux_alloc(unsigned l
 {
 	void *p = malloc(size);
 
-	if (!p) {
-		printf("Can't allocate memory for kernel image!\n\r");
-		exit();
-	}
+	if (!p)
+		fatal("Can't allocate memory for kernel image!\n\r");
+
 	return p;
 }
 
Index: kernel/arch/powerpc/boot/ops.h
===================================================================
--- kernel.orig/arch/powerpc/boot/ops.h	2007-03-19 08:32:50.000000000 -0500
+++ kernel/arch/powerpc/boot/ops.h	2007-03-19 08:33:02.000000000 -0500
@@ -157,6 +157,8 @@ static inline void exit(void)
 		platform_ops.exit();
 	for(;;);
 }
+#define fatal(args...) { printf(args); exit(); }
+
 
 #define BSS_STACK(size) \
 	static char _bss_stack[size]; \
Index: kernel/arch/powerpc/boot/gunzip_util.c
===================================================================
--- kernel.orig/arch/powerpc/boot/gunzip_util.c	2007-03-19 08:32:50.000000000 -0500
+++ kernel/arch/powerpc/boot/gunzip_util.c	2007-03-19 08:33:02.000000000 -0500
@@ -52,18 +52,14 @@ void gunzip_start(struct gunzip_state *s
 		int r, flags;
 
 		state->s.workspace = state->scratch;
-		if (zlib_inflate_workspacesize() > sizeof(state->scratch)) {
-			printf("insufficient scratch space for gunzip\n\r");
-			exit();
-		}
+		if (zlib_inflate_workspacesize() > sizeof(state->scratch))
+			fatal("insufficient scratch space for gunzip\n\r");
 
 		/* skip header */
 		hdrlen = 10;
 		flags = hdr[3];
-		if (hdr[2] != Z_DEFLATED || (flags & RESERVED) != 0) {
-			printf("bad gzipped data\n\r");
-			exit();
-		}
+		if (hdr[2] != Z_DEFLATED || (flags & RESERVED) != 0)
+			fatal("bad gzipped data\n\r");
 		if ((flags & EXTRA_FIELD) != 0)
 			hdrlen = 12 + hdr[10] + (hdr[11] << 8);
 		if ((flags & ORIG_NAME) != 0)
@@ -74,16 +70,12 @@ void gunzip_start(struct gunzip_state *s
 				;
 		if ((flags & HEAD_CRC) != 0)
 			hdrlen += 2;
-		if (hdrlen >= srclen) {
-			printf("gunzip_start: ran out of data in header\n\r");
-			exit();
-		}
+		if (hdrlen >= srclen)
+			fatal("gunzip_start: ran out of data in header\n\r");
 
 		r = zlib_inflateInit2(&state->s, -MAX_WBITS);
-		if (r != Z_OK) {
-			printf("inflateInit2 returned %d\n\r", r);
-			exit();
-		}
+		if (r != Z_OK)
+			fatal("inflateInit2 returned %d\n\r", r);
 	}
 
 	state->s.next_in = src + hdrlen;
@@ -117,10 +109,8 @@ int gunzip_partial(struct gunzip_state *
 		state->s.next_out = dst;
 		state->s.avail_out = dstlen;
 		r = zlib_inflate(&state->s, Z_FULL_FLUSH);
-		if (r != Z_OK && r != Z_STREAM_END) {
-			printf("inflate returned %d msg: %s\n\r", r, state->s.msg);
-			exit();
-		}
+		if (r != Z_OK && r != Z_STREAM_END)
+			fatal("inflate returned %d msg: %s\n\r", r, state->s.msg);
 		len = state->s.next_out - (unsigned char *)dst;
 	} else {
 		/* uncompressed image */
@@ -151,10 +141,8 @@ void gunzip_exactly(struct gunzip_state 
 	int len;
 
 	len  = gunzip_partial(state, dst, dstlen);
-	if (len < dstlen) {
-		printf("gunzip_block: ran out of data\n\r");
-		exit();
-	}
+	if (len < dstlen)
+		fatal("gunzip_block: ran out of data\n\r");
 }
 
 /**

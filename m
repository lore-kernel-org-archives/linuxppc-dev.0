Return-Path: <oohall@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sdVCc4sVpzDsft
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 14:29:48 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id hi10so320241pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 21:29:48 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH v2 3/6] powerpc/boot: use the preboot decompression API
Date: Tue, 20 Sep 2016 14:29:21 +1000
Message-Id: <1474345764-28038-4-git-send-email-oohall@gmail.com>
In-Reply-To: <1474345764-28038-1-git-send-email-oohall@gmail.com>
References: <1474345764-28038-1-git-send-email-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the powerpc boot wrapper has its own wrapper around zlib to
handle decompressing gzipped kernels. The kernel decompressor library
functions now provide a generic interface that can be used in the pre-boot
environment. This allows boot wrappers to easily support different
compression algorithms. This patch converts the wrapper to use this new
API, but does not add support for using new algorithms.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/boot/Makefile     |  34 +++++++---
 arch/powerpc/boot/decompress.c | 142 +++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/main.c       |  35 +++++-----
 arch/powerpc/boot/ops.h        |   3 +
 4 files changed, 189 insertions(+), 25 deletions(-)
 create mode 100644 arch/powerpc/boot/decompress.c

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index bede555d78cf..861348c72519 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -63,13 +63,28 @@ $(obj)/treeboot-currituck.o: BOOTCFLAGS += -mcpu=405
 $(obj)/treeboot-akebono.o: BOOTCFLAGS += -mcpu=405
 $(obj)/virtex405-head.o: BOOTAFLAGS += -mcpu=405
 
-# the kernel's version of zlib pulls in a lot of other kernel headers
-# which we don't provide inside the wrapper.
+# The pre-boot decompressors pull in a lot of kernel headers and other source
+# files. This creates a bit of a dependency headache since we need to copy
+# these files into the build dir, fix up any includes and ensure that dependent
+# files are copied in the right order.
+
+# these need to be separate variables because they are copied out of different
+# directories in the kernel tree. Sure you COULd merge them, but it's a
+# cure-is-worse-than-disease situation.
+zlib-decomp-$(CONFIG_KERNEL_GZIP) := decompress_inflate.c
 zlib-$(CONFIG_KERNEL_GZIP) := inffast.c inflate.c inftrees.c
 zlibheader-$(CONFIG_KERNEL_GZIP) := inffast.h inffixed.h inflate.h inftrees.h infutil.h
 zliblinuxheader-$(CONFIG_KERNEL_GZIP) := zlib.h zconf.h zutil.h
 
-$(addprefix $(obj)/,$(zlib-y) cuboot-c2k.o gunzip_util.o main.o): \
+$(addprefix $(obj)/, decompress.o): \
+	$(addprefix $(obj)/,$(zlib-decomp-y))
+
+$(addprefix $(obj)/, $(zlib-decomp-y)): \
+	$(addprefix $(obj)/,$(zliblinuxheader-y)) \
+	$(addprefix $(obj)/,$(zlibheader-y)) \
+	$(addprefix $(obj)/,$(zlib-y))
+
+$(addprefix $(obj)/,$(zlib-y)): \
 	$(addprefix $(obj)/,$(zliblinuxheader-y)) \
 	$(addprefix $(obj)/,$(zlibheader-y))
 
@@ -79,10 +94,10 @@ libfdtheader := fdt.h libfdt.h libfdt_internal.h
 $(addprefix $(obj)/,$(libfdt) libfdt-wrapper.o simpleboot.o epapr.o opal.o): \
 	$(addprefix $(obj)/,$(libfdtheader))
 
-src-wlib-y := string.S crt0.S crtsavres.S stdio.c main.c \
+src-wlib-y := string.S crt0.S crtsavres.S stdio.c decompress.c main.c \
 		$(libfdt) libfdt-wrapper.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
-		gunzip_util.c elf_util.c $(zlib-y) devtree.c stdlib.c \
+		elf_util.c $(zlib-y) devtree.c stdlib.c \
 		oflib.c ofconsole.c cuboot.c mpsc.c cpm-serial.c \
 		uartlite.c mpc52xx-psc.c opal.c opal-calls.S
 src-wlib-$(CONFIG_40x) += 4xx.c planetcore.c
@@ -143,6 +158,9 @@ $(addprefix $(obj)/,$(zlibheader-y)): $(obj)/%: $(srctree)/lib/zlib_inflate/%
 $(addprefix $(obj)/,$(zliblinuxheader-y)): $(obj)/%: $(srctree)/include/linux/%
 	$(call cmd,copy_kern_src)
 
+$(addprefix $(obj)/,$(zlib-decomp-y)): $(obj)/%: $(srctree)/lib/%
+	$(call cmd,copy_kern_src)
+
 quiet_cmd_copy_libfdt = COPY    $@
       cmd_copy_libfdt = cp $< $@
 
@@ -160,7 +178,7 @@ $(obj)/zImage.coff.lds $(obj)/zImage.ps3.lds : $(obj)/%: $(srctree)/$(src)/%.S
 	$(Q)cp $< $@
 
 clean-files := $(zlib-) $(zlibheader-) $(zliblinuxheader-) \
-		$(libfdt) $(libfdtheader) \
+		$(zlib-decomp-) $(libfdt) $(libfdtheader) \
 		empty.c zImage.coff.lds zImage.ps3.lds zImage.lds
 
 quiet_cmd_bootcc = BOOTCC  $@
@@ -410,8 +428,8 @@ clean-files += $(image-) $(initrd-) cuImage.* dtbImage.* treeImage.* \
 	zImage.maple simpleImage.* otheros.bld *.dtb
 
 # clean up files cached by wrapper
-clean-kernel := vmlinux.strip vmlinux.bin
-clean-kernel += $(addsuffix .gz,$(clean-kernel))
+clean-kernel-base := vmlinux.strip vmlinux.bin
+clean-kernel := $(addsuffix .gz,$(clean-kernel-base))
 # If not absolute clean-files are relative to $(obj).
 clean-files += $(addprefix $(objtree)/, $(clean-kernel))
 
diff --git a/arch/powerpc/boot/decompress.c b/arch/powerpc/boot/decompress.c
new file mode 100644
index 000000000000..60fc6fb26867
--- /dev/null
+++ b/arch/powerpc/boot/decompress.c
@@ -0,0 +1,142 @@
+/*
+ * Wrapper around the kernel's pre-boot decompression library.
+ *
+ * Copyright (C) IBM Corporation 2016.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include "elf.h"
+#include "page.h"
+#include "string.h"
+#include "stdio.h"
+#include "ops.h"
+#include "reg.h"
+#include "types.h"
+
+/*
+ * The decompressor_*.c files play #ifdef games so they can be used in both
+ * pre-boot and regular kernel code. We need these definitions to make the
+ * includes work.
+ */
+
+#define STATIC static
+#define INIT
+#define __always_inline inline
+
+/*
+ * The build process will copy the required zlib source files and headers
+ * out of lib/ and "fix" the includes so they do not pull in other kernel
+ * headers.
+ */
+
+#ifdef CONFIG_KERNEL_GZIP
+#	include "decompress_inflate.c"
+#endif
+
+/* globals for tracking the state of the decompression */
+static unsigned long decompressed_bytes;
+static unsigned long limit;
+static unsigned long skip;
+static char *output_buffer;
+
+/*
+ * flush() is called by __decompress() when the decompressor's scratch buffer is
+ * full.
+ */
+static long flush(void *v, unsigned long buffer_size)
+{
+	unsigned long end = decompressed_bytes + buffer_size;
+	unsigned long size = buffer_size;
+	unsigned long offset = 0;
+	char *in = v;
+	char *out;
+
+	/*
+	 * if we hit our decompression limit, we need to fake an error to abort
+	 * the in-progress decompression.
+	 */
+	if (decompressed_bytes >= limit)
+		return -1;
+
+	/* skip this entire block */
+	if (end <= skip) {
+		decompressed_bytes += buffer_size;
+		return buffer_size;
+	}
+
+	/* skip some data at the start, but keep the rest of the block */
+	if (decompressed_bytes < skip && end > skip) {
+		offset = skip - decompressed_bytes;
+
+		in += offset;
+		size -= offset;
+		decompressed_bytes += offset;
+	}
+
+	out = &output_buffer[decompressed_bytes - skip];
+	size = min(decompressed_bytes + size, limit) - decompressed_bytes;
+
+	memcpy(out, in, size);
+	decompressed_bytes += size;
+
+	return buffer_size;
+}
+
+static void print_err(char *s)
+{
+	/* suppress the "error" when we terminate the decompressor */
+	if (decompressed_bytes >= limit)
+		return;
+
+	printf("Decompression error: '%s'\n\r", s);
+}
+
+/**
+ * partial_decompress - decompresses part or all of a compressed buffer
+ * @inbuf:       input buffer
+ * @input_size:  length of the input buffer
+ * @outbuf:      input buffer
+ * @output_size: length of the input buffer
+ * @skip         number of output bytes to ignore
+ *
+ * This function takes compressed data from inbuf, decompresses and write it to
+ * outbuf. Once output_size bytes are written to the output buffer, or the
+ * stream is exhausted the function will return the number of bytes that were
+ * decompressed. Otherwise it will return whatever error code the decompressor
+ * reported (NB: This is specific to each decompressor type).
+ *
+ * The skip functionality is mainly there so the program and discover
+ * the size of the compressed image so that it can ask firmware (if present)
+ * for an appropriately sized buffer.
+ */
+long partial_decompress(void *inbuf, unsigned long input_size,
+	void *outbuf, unsigned long output_size, unsigned long _skip)
+{
+	int ret;
+
+	/* The skipped bytes needs to be included in the size of data we want
+	 * to decompress.
+	 */
+	output_size += _skip;
+
+	decompressed_bytes = 0;
+	output_buffer = outbuf;
+	limit = output_size;
+	skip = _skip;
+
+	ret = __decompress(inbuf, input_size, NULL, flush, outbuf,
+		output_size, NULL, print_err);
+
+	/*
+	 * If decompression was aborted due to an actual error rather than
+	 * a fake error that we used to abort, then we should report it.
+	 */
+	if (decompressed_bytes < limit)
+		return ret;
+
+	return decompressed_bytes - skip;
+}
diff --git a/arch/powerpc/boot/main.c b/arch/powerpc/boot/main.c
index d80161b633f4..f7a184b6c35b 100644
--- a/arch/powerpc/boot/main.c
+++ b/arch/powerpc/boot/main.c
@@ -15,11 +15,8 @@
 #include "string.h"
 #include "stdio.h"
 #include "ops.h"
-#include "gunzip_util.h"
 #include "reg.h"
 
-static struct gunzip_state gzstate;
-
 struct addr_range {
 	void *addr;
 	unsigned long size;
@@ -30,15 +27,14 @@ struct addr_range {
 static struct addr_range prep_kernel(void)
 {
 	char elfheader[256];
-	void *vmlinuz_addr = _vmlinux_start;
+	unsigned char *vmlinuz_addr = (unsigned char *)_vmlinux_start;
 	unsigned long vmlinuz_size = _vmlinux_end - _vmlinux_start;
 	void *addr = 0;
 	struct elf_info ei;
-	int len;
+	long len;
 
-	/* gunzip the ELF header of the kernel */
-	gunzip_start(&gzstate, vmlinuz_addr, vmlinuz_size);
-	gunzip_exactly(&gzstate, elfheader, sizeof(elfheader));
+	partial_decompress(vmlinuz_addr, vmlinuz_size,
+		elfheader, sizeof(elfheader), 0);
 
 	if (!parse_elf64(elfheader, &ei) && !parse_elf32(elfheader, &ei))
 		fatal("Error: not a valid PPC32 or PPC64 ELF file!\n\r");
@@ -51,7 +47,7 @@ static struct addr_range prep_kernel(void)
 	 * the kernel bss must be claimed (it will be zero'd by the
 	 * kernel itself)
 	 */
-	printf("Allocating 0x%lx bytes for kernel ...\n\r", ei.memsize);
+	printf("Allocating 0x%lx bytes for kernel...\n\r", ei.memsize);
 
 	if (platform_ops.vmlinux_alloc) {
 		addr = platform_ops.vmlinux_alloc(ei.memsize);
@@ -71,16 +67,21 @@ static struct addr_range prep_kernel(void)
 					"device tree\n\r");
 	}
 
-	/* Finally, gunzip the kernel */
-	printf("gunzipping (0x%p <- 0x%p:0x%p)...", addr,
+	/* Finally, decompress the kernel */
+	printf("Decompressing (0x%p <- 0x%p:0x%p)...\n\r", addr,
 	       vmlinuz_addr, vmlinuz_addr+vmlinuz_size);
-	/* discard up to the actual load data */
-	gunzip_discard(&gzstate, ei.elfoffset - sizeof(elfheader));
-	len = gunzip_finish(&gzstate, addr, ei.loadsize);
+
+	len = partial_decompress(vmlinuz_addr, vmlinuz_size,
+		addr, ei.loadsize, ei.elfoffset);
+
+	if (len < 0)
+		fatal("Decompression failed with error code %ld\n\r", len);
+
 	if (len != ei.loadsize)
-		fatal("ran out of data!  only got 0x%x of 0x%lx bytes.\n\r",
-				len, ei.loadsize);
-	printf("done 0x%x bytes\n\r", len);
+		 fatal("Decompression error: got 0x%lx bytes, expected 0x%lx.\n\r",
+			 len, ei.loadsize);
+
+	printf("Done! Decompressed 0x%lx bytes\n\r", len);
 
 	flush_cache(addr, ei.loadsize);
 
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index e19b64ef977a..309d1b127e96 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -260,4 +260,7 @@ int __ilog2_u32(u32 n)
 	return 31 - bit;
 }
 
+long partial_decompress(void *inbuf, unsigned long input_size, void *outbuf,
+	unsigned long output_size, unsigned long skip);
+
 #endif /* _PPC_BOOT_OPS_H_ */
-- 
2.5.5

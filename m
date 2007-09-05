Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DEC70DE21B
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 05:21:25 +1000 (EST)
Date: Wed, 5 Sep 2007 14:21:16 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 08/10] bootwrapper: Add a firmware-independent "raw" target.
Message-ID: <20070905192116.GH32113@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070905192001.GA32049@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This target produces a flat binary rather than an ELF file,
fixes the entry point at the beginning of the image, and takes
a complete device tree with no fixups needed.

The device tree must have labels on /#address-cells, the timebase
frequency, and the memory size.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/Kconfig             |   12 +++++++++++
 arch/powerpc/boot/Makefile       |    4 ++-
 arch/powerpc/boot/fixed-head.S   |    4 +++
 arch/powerpc/boot/io.h           |    7 ++++++
 arch/powerpc/boot/raw-platform.c |   41 ++++++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/wrapper        |   21 ++++++++++++++----
 6 files changed, 83 insertions(+), 6 deletions(-)
 create mode 100644 arch/powerpc/boot/fixed-head.S
 create mode 100644 arch/powerpc/boot/raw-platform.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 00099ef..251d0c3 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -358,6 +358,18 @@ config WANT_DEVICE_TREE
 	bool
 	default n
 
+config BUILD_RAW_IMAGE
+	bool "Build firmware-independent image"
+	select WANT_DEVICE_TREE
+	help
+	  If this is enabled, a firmware independent "raw" image will be
+	  built, as zImage.raw.  This requires a completely filled-in
+	  device tree, with the following labels:
+
+	  mem_size_cells: on /#address-cells
+	  memsize: on the size portion of /memory/reg
+	  timebase: on the boot CPU's timebase property
+
 config DEVICE_TREE
 	string "Static device tree source file"
 	depends on WANT_DEVICE_TREE
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 02f0fe0..2a6a4c6 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -48,7 +48,8 @@ src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
 		cpm-serial.c stdlib.c planetcore.c
 src-plat := of.c cuboot-83xx.c cuboot-85xx.c holly.c \
 		cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
-		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c cuboot-8xx.c cuboot-pq2.c
+		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c \
+		cuboot-8xx.c cuboot-pq2.c fixed-head.S raw-platform.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -146,6 +147,7 @@ image-$(CONFIG_PPC_83xx)		+= cuImage.83xx
 image-$(CONFIG_PPC_85xx)		+= cuImage.85xx
 image-$(CONFIG_EBONY)			+= treeImage.ebony cuImage.ebony
 image-$(CONFIG_BAMBOO)			+= treeImage.bamboo
+image-$(CONFIG_BUILD_RAW_IMAGE)		+= zImage.raw
 endif
 
 # For 32-bit powermacs, build the COFF and miboot images
diff --git a/arch/powerpc/boot/fixed-head.S b/arch/powerpc/boot/fixed-head.S
new file mode 100644
index 0000000..8e14cd9
--- /dev/null
+++ b/arch/powerpc/boot/fixed-head.S
@@ -0,0 +1,4 @@
+	.text
+	.global _zimage_start
+_zimage_start:
+	b	_zimage_start_lib
diff --git a/arch/powerpc/boot/io.h b/arch/powerpc/boot/io.h
index ccaedae..ec57ec9 100644
--- a/arch/powerpc/boot/io.h
+++ b/arch/powerpc/boot/io.h
@@ -99,4 +99,11 @@ static inline void barrier(void)
 	asm volatile("" : : : "memory");
 }
 
+static inline void disable_irq(void)
+{
+	int dummy;
+	asm volatile("mfmsr %0; rlwinm %0, %0, 0, ~(1<<15); mtmsr %0" :
+	             "=r" (dummy) : : "memory");
+}
+
 #endif /* _IO_H */
diff --git a/arch/powerpc/boot/raw-platform.c b/arch/powerpc/boot/raw-platform.c
new file mode 100644
index 0000000..b9caeee
--- /dev/null
+++ b/arch/powerpc/boot/raw-platform.c
@@ -0,0 +1,41 @@
+/*
+ * The "raw" platform -- for booting from a complete dtb without
+ * any fixups.
+ *
+ * Author: Scott Wood <scottwood@freescale.com>
+ *
+ * Copyright (c) 2007 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include "ops.h"
+#include "types.h"
+#include "io.h"
+
+BSS_STACK(4096);
+
+/* These are labels in the device tree. */
+extern u32 memsize[2], timebase, mem_size_cells;
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+                   unsigned long r6, unsigned long r7)
+{
+	u64 memsize64 = memsize[0];
+
+	if (mem_size_cells == 2) {
+		memsize64 <<= 32;
+		memsize64 |= memsize[1];
+	}
+
+	if (sizeof(void *) == 4 && memsize64 >= 0x100000000ULL)
+		memsize64 = 0xffffffff;
+
+	disable_irq();
+	timebase_period_ns = 1000000000 / timebase;
+	simple_alloc_init(_end, memsize64 - (unsigned long)_end, 32, 64);
+	ft_init(_dtb_start, _dtb_end - _dtb_start, 32);
+	serial_console_init();
+}
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 65f6854..a6501e9 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -30,6 +30,7 @@ dtb=
 dts=
 cacheit=
 gzip=.gz
+binary=
 
 # cross-compilation prefix
 CROSS=
@@ -107,10 +108,11 @@ while [ "$#" -gt 0 ]; do
 done
 
 if [ -n "$dts" ]; then
-    if [ -z "$dtb" ]; then
-	dtb="$platform.dtb"
-    fi
-    dtc -O dtb -o "$dtb" -b 0 -V 16 "$dts" || exit 1
+    dtasm="$object/$platform.dtb.S"
+    dto="$object/$platform.dtb.o"
+    echo '.section .kernel:dtb,"a"' > "$dtasm"
+    dtc -O asm  -b 0 -V 16 "$dts" >> "$dtasm" || exit 1
+    ${CROSS}gcc "$dtasm" -c -o "$dto"
 fi
 
 if [ -z "$kernel" ]; then
@@ -153,6 +155,10 @@ ps3)
     ksection=.kernel:vmlinux.bin
     isection=.kernel:initrd
     ;;
+raw)
+    platformo="$object/fixed-head.o $object/raw-platform.o"
+    binary=y
+    ;;
 esac
 
 vmz="$tmpdir/`basename \"$kernel\"`.$ext"
@@ -216,7 +222,7 @@ fi
 
 if [ "$platform" != "miboot" ]; then
     ${CROSS}ld -m elf32ppc -T $lds -o "$ofile" \
-	$platformo $tmp $object/wrapper.a
+	$platformo $tmp $dto $object/wrapper.a
     rm $tmp
 fi
 
@@ -295,3 +301,8 @@ ps3)
     gzip --force -9 --stdout "$ofile.bin" > "$object/otheros.bld"
     ;;
 esac
+
+if [ -n "$binary" ]; then
+    mv "$ofile" "$ofile".elf
+    ${CROSS}objcopy -O binary "$ofile".elf "$ofile"
+fi
-- 
1.5.3

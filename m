Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound9-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 510DFDE02C
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 10:43:37 +1100 (EST)
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: grant.likely@secretlab.ca, simekm2@fel.cvut.cz,
	jwilliams@itee.uq.edu.au, linuxppc-dev@ozlabs.org
Subject: [PATCH 1/7] bootwrapper: Add a firmware-independent "raw" target.
Date: Thu, 13 Dec 2007 15:43:27 -0800
Message-Id: <20071213234221.B0BC27D0054@mail142-sin.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

This target produces a flat binary rather than an ELF file,
fixes the entry point at the beginning of the image, and takes
a complete device tree with no fixups needed.

The device tree must have labels on /#address-cells, the timebase
frequency, and the memory size.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/powerpc/Kconfig             |   12 +++++++++++
 arch/powerpc/boot/Makefile       |    6 ++++-
 arch/powerpc/boot/io.h           |    7 ++++++
 arch/powerpc/boot/raw-platform.c |   41 ++++++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/wrapper        |   15 +++++++++----
 5 files changed, 75 insertions(+), 6 deletions(-)
 create mode 100644 arch/powerpc/boot/raw-platform.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 232c298..4a60ec4 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -394,6 +394,18 @@ config WANT_DEVICE_TREE
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
index 18e3271..975e1f5 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -56,7 +56,7 @@ src-plat := of.c cuboot-52xx.c cuboot-83xx.c cuboot-85xx.c holly.c \
 		cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
 		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c cuboot-8xx.c \
 		cuboot-pq2.c cuboot-sequoia.c treeboot-walnut.c cuboot-bamboo.c \
-		fixed-head.S ep88xc.c cuboot-hpc2.c
+		fixed-head.S ep88xc.c cuboot-hpc2.c raw-platform.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -159,6 +159,7 @@ image-$(CONFIG_EBONY)			+= treeImage.ebony cuImage.ebony
 image-$(CONFIG_BAMBOO)			+= treeImage.bamboo cuImage.bamboo
 image-$(CONFIG_SEQUOIA)			+= cuImage.sequoia
 image-$(CONFIG_WALNUT)			+= treeImage.walnut
+image-$(CONFIG_BUILD_RAW_IMAGE)		+= zImage.raw
 endif
 
 # For 32-bit powermacs, build the COFF and miboot images
@@ -221,6 +222,9 @@ $(obj)/treeImage.initrd.%: vmlinux $(dts) $(wrapperbits)
 $(obj)/treeImage.%: vmlinux $(dts) $(wrapperbits)
 	$(call if_changed,wrap,treeboot-$*,$(dts))
 
+$(obj)/zImage.raw: vmlinux $(dts) $(wrapperbits)
+	$(call if_changed,wrap,raw,$(dts))
+
 # If there isn't a platform selected then just strip the vmlinux.
 ifeq (,$(image-y))
 image-y := vmlinux.strip
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
index 31147a0..716cd44 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -116,10 +116,11 @@ while [ "$#" -gt 0 ]; do
 done
 
 if [ -n "$dts" ]; then
-    if [ -z "$dtb" ]; then
-	dtb="$platform.dtb"
-    fi
-    dtc -O dtb -o "$dtb" -b 0 -V 16 "$dts"
+    dtasm="$object/$platform.dtb.S"
+    dto="$object/$platform.dtb.o"
+    echo '.section .kernel:dtb,"a"' > "$dtasm"
+    dtc -O asm -b 0 -V 16 "$dts" >> "$dtasm"
+    ${CROSS}gcc "$dtasm" -c -o "$dto"
 fi
 
 if [ -z "$kernel" ]; then
@@ -167,6 +168,10 @@ ep88xc)
     platformo="$object/fixed-head.o $object/$platform.o"
     binary=y
     ;;
+raw)
+    platformo="$object/fixed-head.o $object/raw-platform.o"
+    binary=y
+    ;;
 esac
 
 vmz="$tmpdir/`basename \"$kernel\"`.$ext"
@@ -230,7 +235,7 @@ fi
 
 if [ "$platform" != "miboot" ]; then
     ${CROSS}ld -m elf32ppc -T $lds -o "$ofile" \
-	$platformo $tmp $object/wrapper.a
+	$platformo $tmp $dto $object/wrapper.a
     rm $tmp
 fi
 
-- 
1.5.3.4

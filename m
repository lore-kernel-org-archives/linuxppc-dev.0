Return-Path: <albert_herranz@yahoo.es>
Received: from smtp104.mail.ukl.yahoo.com (smtp104.mail.ukl.yahoo.com
	[77.238.184.36]) by ozlabs.org (Postfix) with SMTP id BCFB3B70B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 13 Dec 2009 03:32:05 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 03/22] powerpc: gamecube: bootwrapper bits
Date: Sat, 12 Dec 2009 17:31:36 +0100
Message-Id: <1260635515-7478-4-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1260635515-7478-1-git-send-email-albert_herranz@yahoo.es>
References: <1260635515-7478-1-git-send-email-albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add support for the Nintendo GameCube video game console to the powerpc
bootwrapper.

dtbImage.gamecube is a wrapped image that contains a flat device tree,
an entry point compatible with SDload, and an optional initrd.

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
Acked-by: Segher Boessenkool <segher@kernel.crashing.org>
---
 arch/powerpc/boot/Makefile        |    4 +-
 arch/powerpc/boot/gamecube-head.S |  111 +++++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/gamecube.c      |   35 ++++++++++++
 arch/powerpc/boot/wrapper         |    4 +
 4 files changed, 153 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/boot/gamecube-head.S
 create mode 100644 arch/powerpc/boot/gamecube.c

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 44bce21..3e70aab 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -76,7 +76,8 @@ src-plat := of.c cuboot-52xx.c cuboot-824x.c cuboot-83xx.c cuboot-85xx.c holly.c
 		cuboot-katmai.c cuboot-rainier.c redboot-8xx.c ep8248e.c \
 		cuboot-warp.c cuboot-85xx-cpm2.c cuboot-yosemite.c simpleboot.c \
 		virtex405-head.S virtex.c redboot-83xx.c cuboot-sam440ep.c \
-		cuboot-acadia.c cuboot-amigaone.c cuboot-kilauea.c
+		cuboot-acadia.c cuboot-amigaone.c cuboot-kilauea.c \
+		gamecube-head.S gamecube.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -254,6 +255,7 @@ image-$(CONFIG_KSI8560)			+= cuImage.ksi8560
 image-$(CONFIG_STORCENTER)		+= cuImage.storcenter
 image-$(CONFIG_MPC7448HPC2)		+= cuImage.mpc7448hpc2
 image-$(CONFIG_PPC_C2K)			+= cuImage.c2k
+image-$(CONFIG_GAMECUBE)		+= dtbImage.gamecube
 
 # Board port in arch/powerpc/platform/amigaone/Kconfig
 image-$(CONFIG_AMIGAONE)		+= cuImage.amigaone
diff --git a/arch/powerpc/boot/gamecube-head.S b/arch/powerpc/boot/gamecube-head.S
new file mode 100644
index 0000000..65a9b2a
--- /dev/null
+++ b/arch/powerpc/boot/gamecube-head.S
@@ -0,0 +1,111 @@
+/*
+ * arch/powerpc/boot/gamecube-head.S
+ *
+ * Nintendo GameCube bootwrapper entry.
+ * Copyright (C) 2004-2009 The GameCube Linux Team
+ * Copyright (C) 2008,2009 Albert Herranz
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ */
+
+#include "ppc_asm.h"
+
+/*
+ * The entry code does no assumptions regarding:
+ * - if the data and instruction caches are enabled or not
+ * - if the MMU is enabled or not
+ *
+ * We enable the caches if not already enabled, enable the MMU with an
+ * identity mapping scheme and jump to the start code.
+ */
+
+	.text
+
+	.globl _zimage_start
+_zimage_start:
+
+	/* turn the MMU off */
+	mfmsr	9
+	rlwinm	9, 9, 0, ~((1<<4)|(1<<5)) /* MSR_DR|MSR_IR */
+	bcl	20, 31, 1f
+1:
+	mflr	8
+	clrlwi	8, 8, 3		/* convert to a real address */
+	addi	8, 8, _mmu_off - 1b
+	mtsrr0	8
+	mtsrr1	9
+	rfi
+_mmu_off:
+	/* MMU disabled */
+
+	/* setup BATs */
+	isync
+	li      8, 0
+	mtspr	0x210, 8	/* IBAT0U */
+	mtspr	0x212, 8	/* IBAT1U */
+	mtspr	0x214, 8	/* IBAT2U */
+	mtspr	0x216, 8	/* IBAT3U */
+	mtspr	0x218, 8	/* DBAT0U */
+	mtspr	0x21a, 8	/* DBAT1U */
+	mtspr	0x21c, 8	/* DBAT2U */
+	mtspr	0x21e, 8	/* DBAT3U */
+
+	li	8, 0x01ff	/* first 16MiB */
+	li	9, 0x0002	/* rw */
+	mtspr	0x211, 9	/* IBAT0L */
+	mtspr	0x210, 8	/* IBAT0U */
+	mtspr	0x219, 9	/* DBAT0L */
+	mtspr	0x218, 8	/* DBAT0U */
+
+	lis	8, 0x0c00	/* I/O mem */
+	ori	8, 8, 0x3ff	/* 32MiB */
+	lis	9, 0x0c00
+	ori	9, 9, 0x002a	/* uncached, guarded, rw */
+	mtspr	0x21b, 9	/* DBAT1L */
+	mtspr	0x21a, 8	/* DBAT1U */
+
+	lis	8, 0x0100	/* next 8MiB */
+	ori	8, 8, 0x00ff	/* 8MiB */
+	lis	9, 0x0100
+	ori	9, 9, 0x0002	/* rw */
+	mtspr	0x215, 9	/* IBAT2L */
+	mtspr	0x214, 8	/* IBAT2U */
+	mtspr	0x21d, 9	/* DBAT2L */
+	mtspr	0x21c, 8	/* DBAT2U */
+
+	/* enable and invalidate the caches if not already enabled */
+	mfspr	8, 0x3f0	/* HID0 */
+	andi.	0, 8, (1<<15)		/* HID0_ICE */
+	bne	1f
+	ori	8, 8, (1<<15)|(1<<11)	/* HID0_ICE|HID0_ICFI*/
+1:
+	andi.	0, 8, (1<<14)		/* HID0_DCE */
+	bne	1f
+	ori	8, 8, (1<<14)|(1<<10)	/* HID0_DCE|HID0_DCFI*/
+1:
+	mtspr	0x3f0, 8	/* HID0 */
+	isync
+
+	/* initialize arguments */
+	li	3, 0
+	li	4, 0
+	li	5, 0
+
+	/* turn the MMU on */
+	bcl	20, 31, 1f
+1:
+	mflr	8
+	addi	8, 8, _mmu_on - 1b
+	mfmsr	9
+	ori	9, 9, (1<<4)|(1<<5) /* MSR_DR|MSR_IR */
+	mtsrr0	8
+	mtsrr1	9
+	sync
+	rfi
+_mmu_on:
+	b _zimage_start_lib
+
diff --git a/arch/powerpc/boot/gamecube.c b/arch/powerpc/boot/gamecube.c
new file mode 100644
index 0000000..28ae705
--- /dev/null
+++ b/arch/powerpc/boot/gamecube.c
@@ -0,0 +1,35 @@
+/*
+ * arch/powerpc/boot/gamecube.c
+ *
+ * Nintendo GameCube bootwrapper support
+ * Copyright (C) 2004-2009 The GameCube Linux Team
+ * Copyright (C) 2008,2009 Albert Herranz
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ */
+
+#include <stddef.h>
+#include "stdio.h"
+#include "types.h"
+#include "io.h"
+#include "ops.h"
+
+#include "ugecon.h"
+
+BSS_STACK(8192);
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5)
+{
+	u32 heapsize = 16*1024*1024 - (u32)_end;
+
+	simple_alloc_init(_end, heapsize, 32, 64);
+	fdt_init(_dtb_start);
+
+	if (ug_probe())
+		console_ops.write = ug_console_write;
+}
+
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index ac9e9a5..5b9206f 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -230,6 +230,10 @@ xpedite52*)
     link_address='0x1400000'
     platformo=$object/cuboot-85xx.o
     ;;
+gamecube)
+    link_address='0x600000'
+    platformo="$object/$platform-head.o $object/$platform.o"
+    ;;
 esac
 
 vmz="$tmpdir/`basename \"$kernel\"`.$ext"
-- 
1.6.3.3

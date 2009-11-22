Return-Path: <albert_herranz@yahoo.es>
Received: from smtp106.mail.ukl.yahoo.com (smtp106.mail.ukl.yahoo.com
	[77.238.184.38]) by ozlabs.org (Postfix) with SMTP id 07A871007E2
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Nov 2009 09:02:06 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 05/19] powerpc: wii: bootwrapper bits
Date: Sun, 22 Nov 2009 23:01:36 +0100
Message-Id: <1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add support for the Nintendo Wii video game console to the powerpc
bootwrapper.

dtbImage.wii is a wrapped image that contains a flat device tree,
an entry point compatible with the Homebrew Channel and BootMii,
and an optional initrd.

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 arch/powerpc/boot/Makefile |    3 +-
 arch/powerpc/boot/wii.c    |  173 ++++++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/wrapper  |    3 +
 3 files changed, 178 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/boot/wii.c

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index b2f06b0..fbaf101 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -77,7 +77,7 @@ src-plat := of.c cuboot-52xx.c cuboot-824x.c cuboot-83xx.c cuboot-85xx.c holly.c
 		cuboot-warp.c cuboot-85xx-cpm2.c cuboot-yosemite.c simpleboot.c \
 		virtex405-head.S virtex.c redboot-83xx.c cuboot-sam440ep.c \
 		cuboot-acadia.c cuboot-amigaone.c cuboot-kilauea.c \
-		gamecube.c
+		gamecube.c wii.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -256,6 +256,7 @@ image-$(CONFIG_STORCENTER)		+= cuImage.storcenter
 image-$(CONFIG_MPC7448HPC2)		+= cuImage.mpc7448hpc2
 image-$(CONFIG_PPC_C2K)			+= cuImage.c2k
 image-$(CONFIG_GAMECUBE)		+= dtbImage.gamecube
+image-$(CONFIG_WII)			+= dtbImage.wii
 
 # Board port in arch/powerpc/platform/amigaone/Kconfig
 image-$(CONFIG_AMIGAONE)		+= cuImage.amigaone
diff --git a/arch/powerpc/boot/wii.c b/arch/powerpc/boot/wii.c
new file mode 100644
index 0000000..65b73a1
--- /dev/null
+++ b/arch/powerpc/boot/wii.c
@@ -0,0 +1,173 @@
+/*
+ * arch/powerpc/boot/wii.c
+ *
+ * Nintendo Wii bootwrapper support
+ * Copyright (C) 2008-2009 The GameCube Linux Team
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
+
+BSS_STACK(8192);
+
+/*
+ * We enter with an unknown cache, high BATs and MMU status.
+ *
+ * We enable the MMU with an identity mapped memory scheme as expected
+ * by the start code.
+ *
+ */
+asm ("\n\
+.text\n\
+.globl _zimage_start\n\
+_zimage_start:\n\
+\n\
+	mfmsr	9\n\
+	andi.	0, 9, (1<<4)|(1<<5) /* MSR_DR|MSR_IR */\n\
+	bcl	20, 31, 1f\n\
+1: \n\
+	mflr	8\n\
+	clrlwi	8, 8, 3		/* convert to a real address */\n\
+	addi	8, 8, _mmu_off - 1b\n\
+	andc	9, 9, 0\n\
+	mtspr	0x01a, 8	/* SRR0 */\n\
+	mtspr	0x01b, 9	/* SRR1 */\n\
+	sync\n\
+	rfi\n\
+_mmu_off: \n\
+	/* MMU disabled */\n\
+\n\
+	/* Setup BATs */\n\
+	isync\n\
+	li      8, 0\n\
+	mtspr	0x210, 8	/* IBAT0U */\n\
+	mtspr	0x211, 8	/* IBAT0L */\n\
+	mtspr	0x212, 8	/* IBAT1U */\n\
+	mtspr	0x213, 8	/* IBAT1L */\n\
+	mtspr	0x214, 8	/* IBAT2U */\n\
+	mtspr	0x215, 8	/* IBAT2L */\n\
+	mtspr	0x216, 8	/* IBAT3U */\n\
+	mtspr	0x217, 8	/* IBAT3L */\n\
+	mtspr	0x218, 8	/* DBAT0U */\n\
+	mtspr	0x219, 8	/* DBAT0L */\n\
+	mtspr	0x21a, 8	/* DBAT1U */\n\
+	mtspr	0x21b, 8	/* DBAT1L */\n\
+	mtspr	0x21c, 8	/* DBAT2U */\n\
+	mtspr	0x21d, 8	/* DBAT2L */\n\
+	mtspr	0x21e, 8	/* DBAT3U */\n\
+	mtspr	0x21f, 8	/* DBAT3L */\n\
+\n\
+	mtspr	0x230, 8	/* IBAT4U */\n\
+	mtspr	0x231, 8	/* IBAT4L */\n\
+	mtspr	0x232, 8	/* IBAT5U */\n\
+	mtspr	0x233, 8	/* IBAT5L */\n\
+	mtspr	0x234, 8	/* IBAT6U */\n\
+	mtspr	0x235, 8	/* IBAT6L */\n\
+	mtspr	0x236, 8	/* IBAT7U */\n\
+	mtspr	0x237, 8	/* IBAT7L */\n\
+	mtspr	0x238, 8	/* DBAT4U */\n\
+	mtspr	0x239, 8	/* DBAT4L */\n\
+	mtspr	0x23a, 8	/* DBAT5U */\n\
+	mtspr	0x23b, 8	/* DBAT5L */\n\
+	mtspr	0x23c, 8	/* DBAT6U */\n\
+	mtspr	0x23d, 8	/* DBAT6L */\n\
+	mtspr	0x23e, 8	/* DBAT7U */\n\
+	mtspr	0x23f, 8	/* DBAT7L */\n\
+\n\
+	isync\n\
+	li	8, 0x01ff	/* first 16MiB */\n\
+	li	9, 0x0002	/* rw */\n\
+	mtspr	0x210, 8	/* IBAT0U */\n\
+	mtspr	0x211, 9	/* IBAT0L */\n\
+	mtspr	0x218, 8	/* DBAT0U */\n\
+	mtspr	0x219, 9	/* DBAT0L */\n\
+\n\
+	lis	8, 0xcc00	/* I/O mem */\n\
+	ori	8, 8, 0x3ff	/* 32MiB */\n\
+	lis	9, 0x0c00\n\
+	ori	9, 9, 0x002a	/* uncached, guarded, rw */\n\
+	mtspr	0x21a, 8	/* DBAT1U */\n\
+	mtspr	0x21b, 9	/* DBAT1L */\n\
+\n\
+	lis	8, 0x0100	/* next 8MiB */\n\
+	ori	8, 8, 0x00ff	/* 8MiB */\n\
+	lis	9, 0x0100	/* next 8MiB */\n\
+	ori	9, 9, 0x0002	/* rw */\n\
+	mtspr	0x214, 8	/* IBAT2U */\n\
+	mtspr	0x215, 9	/* IBAT2L */\n\
+	mtspr	0x21c, 8	/* DBAT2U */\n\
+	mtspr	0x21d, 9	/* DBAT2L */\n\
+\n\
+	lis	8, 0x1000	/* MEM2 */\n\
+	ori	8, 8, 0x07ff	/* 64MiB */\n\
+	lis	9, 0x1000\n\
+	ori	9, 9, 0x0002	/* rw */\n\
+	mtspr	0x216, 8	/* IBAT3U */\n\
+	mtspr	0x217, 9	/* IBAT3L */\n\
+	mtspr	0x21e, 8	/* DBAT3U */\n\
+	mtspr	0x21f, 9	/* DBAT3L */\n\
+\n\
+	sync\n\
+	isync\n\
+\n\
+	/* enable high BATs */\n\
+	lis	8, 0x8200\n\
+	mtspr	0x3f3, 8	/* HID4 */\n\
+\n\
+	/* enable caches */\n\
+	mfspr	8, 0x3f0\n\
+	ori	8, 8, 0xc000\n\
+	mtspr	0x3f0, 8	/* HID0 */\n\
+	isync\n\
+\n\
+	li	3, 0\n\
+	li	4, 0\n\
+	li	5, 0\n\
+\n\
+	bcl	20, 31, 1f\n\
+1: \n\
+	mflr    8\n\
+	addi    8, 8, _mmu_on - 1b\n\
+	mfmsr	9\n\
+	ori	9, 9, (1<<4)|(1<<5) /* MSR_DR|MSR_IR */\n\
+	mtspr	0x01a, 8	/* SRR0 */\n\
+	mtspr	0x01b, 9	/* SRR1 */\n\
+	sync\n\
+	rfi\n\
+_mmu_on: \n\
+	/* turn on the front blue led (aka: yay! we got here!) */\n\
+	lis	8, 0xcd00\n\
+	ori	8, 8, 0x00c0\n\
+	lwz	9, 0(8)\n\
+	ori	9, 9, 0x20\n\
+	stw	9, 0(8)\n\
+	b _zimage_start_lib\n\
+");
+
+/*
+ *
+ */
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5)
+{
+	u32 heapsize = 24*1024*1024 - (u32)_end;
+
+	simple_alloc_init(_end, heapsize, 32, 64);
+	fdt_init(_dtb_start);
+
+	if (!ug_grab_io_base() && ug_is_adapter_present())
+		console_ops.write = ug_console_write;
+}
+
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index ac9e9a5..0e9ce10 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -230,6 +230,9 @@ xpedite52*)
     link_address='0x1400000'
     platformo=$object/cuboot-85xx.o
     ;;
+wii|gamecube)
+    link_address='0x600000'
+    ;;
 esac
 
 vmz="$tmpdir/`basename \"$kernel\"`.$ext"
-- 
1.6.3.3

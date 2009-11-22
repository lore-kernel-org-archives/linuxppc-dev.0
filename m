Return-Path: <albert_herranz@yahoo.es>
Received: from smtp106.mail.ukl.yahoo.com (smtp106.mail.ukl.yahoo.com
	[77.238.184.38]) by ozlabs.org (Postfix) with SMTP id 6884F1007D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Nov 2009 09:02:05 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 03/19] powerpc: gamecube: bootwrapper bits
Date: Sun, 22 Nov 2009 23:01:34 +0100
Message-Id: <1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
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
---
 arch/powerpc/boot/Makefile   |    4 ++-
 arch/powerpc/boot/gamecube.c |   78 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/boot/gamecube.c

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 44bce21..b2f06b0 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -76,7 +76,8 @@ src-plat := of.c cuboot-52xx.c cuboot-824x.c cuboot-83xx.c cuboot-85xx.c holly.c
 		cuboot-katmai.c cuboot-rainier.c redboot-8xx.c ep8248e.c \
 		cuboot-warp.c cuboot-85xx-cpm2.c cuboot-yosemite.c simpleboot.c \
 		virtex405-head.S virtex.c redboot-83xx.c cuboot-sam440ep.c \
-		cuboot-acadia.c cuboot-amigaone.c cuboot-kilauea.c
+		cuboot-acadia.c cuboot-amigaone.c cuboot-kilauea.c \
+		gamecube.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -254,6 +255,7 @@ image-$(CONFIG_KSI8560)			+= cuImage.ksi8560
 image-$(CONFIG_STORCENTER)		+= cuImage.storcenter
 image-$(CONFIG_MPC7448HPC2)		+= cuImage.mpc7448hpc2
 image-$(CONFIG_PPC_C2K)			+= cuImage.c2k
+image-$(CONFIG_GAMECUBE)		+= dtbImage.gamecube
 
 # Board port in arch/powerpc/platform/amigaone/Kconfig
 image-$(CONFIG_AMIGAONE)		+= cuImage.amigaone
diff --git a/arch/powerpc/boot/gamecube.c b/arch/powerpc/boot/gamecube.c
new file mode 100644
index 0000000..0d6c517
--- /dev/null
+++ b/arch/powerpc/boot/gamecube.c
@@ -0,0 +1,78 @@
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
+/*
+ * We enter with the cache enabled, the MMU enabled and some known legacy
+ * memory mappings active. xBAT3 is unused.
+ *
+ * We leave the MMU enabled, but we switch to an identity mapped memory
+ * scheme as expected by the start code.
+ *
+ */
+asm ("\n\
+.text\n\
+.globl _zimage_start\n\
+_zimage_start:\n\
+\n\
+	isync\n\
+	/* IBAT3,DBAT3 for first 16Mbytes */\n\
+	li	8, 0x01ff	/* 16MB */\n\
+	li      9, 0x0002	/* rw */\n\
+	mtspr   0x216, 8	/* IBAT3U */\n\
+	mtspr   0x217, 9	/* IBAT3L */\n\
+	mtspr   0x21e, 8	/* DBAT3U */\n\
+	mtspr   0x21f, 9	/* DBAT3L */\n\
+\n\
+	sync\n\
+	isync\n\
+\n\
+	li	3, 0\n\
+	li	4, 0\n\
+	li	5, 0\n\
+\n\
+	bcl-    20,4*cr7+so,1f\n\
+1:\n\
+	mflr    8\n\
+	clrlwi  8, 8, 3\n\
+	addi    8, 8, 2f - 1b\n\
+	mtlr    8\n\
+	blr\n\
+2:\n\
+	b _zimage_start_lib\n\
+");
+
+/*
+ *
+ */
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5)
+{
+	u32 heapsize = 16*1024*1024 - (u32)_end;
+
+	simple_alloc_init(_end, heapsize, 32, 64);
+	fdt_init(_dtb_start);
+
+	if (!ug_grab_io_base() && ug_is_adapter_present())
+		console_ops.write = ug_console_write;
+}
+
-- 
1.6.3.3

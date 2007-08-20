Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E770BDDEC9
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 03:40:18 +1000 (EST)
Date: Mon, 20 Aug 2007 12:40:01 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 12/20] bootwrapper: Add 8xx cuboot support.
Message-ID: <20070820174001.GK30562@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070820173920.GA30546@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This allows booting on legacy, non-device-tree aware versions of U-boot.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/Makefile             |    3 +-
 arch/powerpc/boot/cuboot-8xx.c         |   45 ++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/Kconfig.cputype |    1 +
 3 files changed, 48 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/boot/cuboot-8xx.c

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 997980f..e75c92b 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -48,7 +48,7 @@ src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
 		cpm-serial.c
 src-plat := of.c cuboot-83xx.c cuboot-85xx.c holly.c \
 		cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
-		ps3-head.S ps3-hvcall.S ps3.c
+		ps3-head.S ps3-hvcall.S ps3.c cuboot-8xx.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -140,6 +140,7 @@ image-$(CONFIG_PPC_ISERIES)		+= zImage.iseries
 image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage
 
 ifneq ($(CONFIG_DEVICE_TREE),"")
+image-$(CONFIG_PPC_8xx)			+= cuImage.8xx
 image-$(CONFIG_PPC_83xx)		+= cuImage.83xx
 image-$(CONFIG_PPC_85xx)		+= cuImage.85xx
 image-$(CONFIG_EBONY)			+= treeImage.ebony cuImage.ebony
diff --git a/arch/powerpc/boot/cuboot-8xx.c b/arch/powerpc/boot/cuboot-8xx.c
new file mode 100644
index 0000000..88ed840
--- /dev/null
+++ b/arch/powerpc/boot/cuboot-8xx.c
@@ -0,0 +1,45 @@
+/*
+ * Old U-boot compatibility for 8xx
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
+#include "stdio.h"
+#include "cuboot.h"
+
+#define TARGET_8xx
+#define TARGET_HAS_ETH1
+#include "ppcboot.h"
+
+static bd_t bd;
+
+static void platform_fixups(void)
+{
+	void *node;
+
+	dt_fixup_memory(bd.bi_memstart, bd.bi_memsize);
+	dt_fixup_mac_addresses(bd.bi_enetaddr, bd.bi_enet1addr);
+	dt_fixup_cpu_clocks(bd.bi_intfreq, bd.bi_busfreq / 16, bd.bi_busfreq);
+
+	node = finddevice("/soc/cpm");
+	if (node) {
+		setprop(node, "clock-frequency", &bd.bi_busfreq, 4);
+		setprop(node, "fsl,brg-frequency", &bd.bi_busfreq, 4);
+	}
+}
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+                   unsigned long r6, unsigned long r7)
+{
+	CUBOOT_INIT();
+	ft_init(_dtb_start, _dtb_end - _dtb_start, 32);
+	serial_console_init();
+	platform_ops.fixups = platform_fixups;
+}
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index e4b2aee..44417bd 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -36,6 +36,7 @@ config PPC_8xx
 	bool "Freescale 8xx"
 	select FSL_SOC
 	select 8xx
+	select WANT_DEVICE_TREE
 
 config 40x
 	bool "AMCC 40x"
-- 
1.5.0.3

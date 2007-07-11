Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 36886DDE1F
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 18:54:50 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l6B8sUAk005344
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 01:54:31 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6B8sTg0015871
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 03:54:30 -0500 (CDT)
Subject: [PATCH] bootwrapper: adds cuboot for MPC7448HPC2 platform
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <1180319418.20906.12.camel@localhost.localdomain>
References: <1180319418.20906.12.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1184144056.23579.16.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 11 Jul 2007 16:54:16 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Roy Zang <tie-fei.zang@freescale.com>

This patch adds cuboot support for MPC7448HPC2 platform.
The cuImage can be used with legacy u-boot without FDT support.

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
Regenerate this patch based on current Paul's tree.
The original one was pasted at:
http://ozlabs.org/pipermail/linuxppc-dev/2007-May/036834.html
Only have a small changes.
Cheers!

 arch/powerpc/boot/Makefile                 |    3 +-
 arch/powerpc/boot/cuboot-hpc2.c            |   48 ++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/mpc7448hpc2.dts      |    5 +++
 arch/powerpc/boot/ppcboot.h                |    2 +-
 arch/powerpc/platforms/embedded6xx/Kconfig |    1 +
 include/asm-ppc/ppcboot.h                  |    2 +-
 6 files changed, 58 insertions(+), 3 deletions(-)
 create mode 100644 arch/powerpc/boot/cuboot-hpc2.c
 delete mode 100644 include/asm-blackfin/macros.h

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 61a6f34..3ca5a91 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -47,7 +47,7 @@ src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
 		44x.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c cuboot.c
 src-plat := of.c cuboot-83xx.c cuboot-85xx.c holly.c \
 		cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
-		ps3-head.S ps3-hvcall.S ps3.c
+		ps3-head.S ps3-hvcall.S ps3.c cuboot-hpc2.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -142,6 +142,7 @@ ifneq ($(CONFIG_DEVICE_TREE),"")
 image-$(CONFIG_PPC_83xx)		+= cuImage.83xx
 image-$(CONFIG_PPC_85xx)		+= cuImage.85xx
 image-$(CONFIG_EBONY)			+= treeImage.ebony cuImage.ebony
+image-$(CONFIG_MPC7448HPC2)		+= cuImage.hpc2
 endif
 
 # For 32-bit powermacs, build the COFF and miboot images
diff --git a/arch/powerpc/boot/cuboot-hpc2.c b/arch/powerpc/boot/cuboot-hpc2.c
new file mode 100644
index 0000000..e0f754b
--- /dev/null
+++ b/arch/powerpc/boot/cuboot-hpc2.c
@@ -0,0 +1,48 @@
+/*
+ * Copyright (C) 2007 Freescale Semiconductor, Inc. All rights reserved.
+ *
+ * Author: Roy Zang <tie-fei.zang@freescale.com>
+ *
+ * Description:
+ * Old U-boot compatibility for mpc7448hpc2 board
+ * Based on the code of Scott Wood <scottwood@freescale.com>
+ * for 83xx and 85xx.
+ *
+ * This is free software; you can redistribute it and/or modify
+ * it under the terms of  the GNU General  Public License as published by
+ * the Free Software Foundation;  either version 2 of the  License, or
+ * (at your option) any later version.
+ *
+ */
+
+#include "ops.h"
+#include "stdio.h"
+#include "cuboot.h"
+
+#define TARGET_HAS_ENET1
+#include "ppcboot.h"
+
+static bd_t bd;
+extern char _dtb_start[], _dtb_end[];
+
+static void platform_fixups(void)
+{
+	void *tsi;
+
+	dt_fixup_memory(bd.bi_memstart, bd.bi_memsize);
+	dt_fixup_mac_addresses(bd.bi_enetaddr, bd.bi_enet1addr);
+	dt_fixup_cpu_clocks(bd.bi_intfreq, bd.bi_busfreq / 4, bd.bi_busfreq);
+	tsi = find_node_by_devtype(NULL, "tsi-bridge");
+	if (tsi)
+		setprop(tsi, "bus-frequency", &bd.bi_busfreq,
+			sizeof(bd.bi_busfreq));
+}
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+		unsigned long r6, unsigned long r7)
+{
+	CUBOOT_INIT();
+	ft_init(_dtb_start, _dtb_end - _dtb_start, 32);
+	serial_console_init();
+	platform_ops.fixups = platform_fixups;
+}
diff --git a/arch/powerpc/boot/dts/mpc7448hpc2.dts b/arch/powerpc/boot/dts/mpc7448hpc2.dts
index b9158eb..f141ba2 100644
--- a/arch/powerpc/boot/dts/mpc7448hpc2.dts
+++ b/arch/powerpc/boot/dts/mpc7448hpc2.dts
@@ -80,6 +80,7 @@
 		};
 
 		ethernet@6200 {
+			linux,network-index = <0>;
 			#size-cells = <0>;
 			device_type = "network";
 			compatible = "tsi108-ethernet";
@@ -92,6 +93,7 @@
 		};
 
 		ethernet@6600 {
+			linux,network-index = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			device_type = "network";
@@ -187,5 +189,8 @@
 			};
 		};
 	};
+	chosen {
+		linux,stdout-path = "/tsi108@c0000000/serial@7808";
+	};
 
 };
diff --git a/arch/powerpc/boot/ppcboot.h b/arch/powerpc/boot/ppcboot.h
index 5290ff2..f504e1c 100644
--- a/arch/powerpc/boot/ppcboot.h
+++ b/arch/powerpc/boot/ppcboot.h
@@ -78,7 +78,7 @@ typedef struct bd_info {
 	hymod_conf_t	bi_hymod_conf;	/* hymod configuration information */
 #endif
 #if defined(TARGET_EVB64260) || defined(TARGET_405EP) || defined(TARGET_44x) || \
-	defined(TARGET_85xx) ||	defined(TARGET_83xx)
+	defined(TARGET_85xx) ||	defined(TARGET_83xx) || defined(TARGET_HAS_ENET1)
 	/* second onboard ethernet port */
 	unsigned char	bi_enet1addr[6];
 #define HAVE_ENET1ADDR
diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/platforms/embedded6xx/Kconfig
index bec7726..9b330a7 100644
--- a/arch/powerpc/platforms/embedded6xx/Kconfig
+++ b/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -20,6 +20,7 @@ config MPC7448HPC2
 	select TSI108_BRIDGE
 	select DEFAULT_UIMAGE
 	select PPC_UDBG_16550
+	select WANT_DEVICE_TREE
 	help
 	  Select MPC7448HPC2 if configuring for Freescale MPC7448HPC2 (Taiga)
 	  platform
diff --git a/include/asm-blackfin/macros.h b/include/asm-blackfin/macros.h
deleted file mode 100644
index e69de29..0000000
diff --git a/include/asm-ppc/ppcboot.h b/include/asm-ppc/ppcboot.h
index 6b7b63f..eb6e18d 100644
--- a/include/asm-ppc/ppcboot.h
+++ b/include/asm-ppc/ppcboot.h
@@ -74,7 +74,7 @@ typedef struct bd_info {
 	hymod_conf_t	bi_hymod_conf;	/* hymod configuration information */
 #endif
 #if defined(CONFIG_EVB64260) || defined(CONFIG_405EP) || defined(CONFIG_44x) || \
-	defined(CONFIG_85xx) ||	defined(CONFIG_83xx)
+	defined(CONFIG_85xx) ||	defined(CONFIG_83xx) || defined(CONFIG_TSI108_BRIDGE)
 	/* second onboard ethernet port */
 	unsigned char	bi_enet1addr[6];
 #endif
-- 
1.5.1

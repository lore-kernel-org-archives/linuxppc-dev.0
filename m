Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D070EDDD0A
	for <linuxppc-dev@ozlabs.org>; Mon, 28 May 2007 12:30:57 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l4S2UpED005395
	for <linuxppc-dev@ozlabs.org>; Sun, 27 May 2007 19:30:52 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l4S2UoXC011292
	for <linuxppc-dev@ozlabs.org>; Sun, 27 May 2007 21:30:51 -0500 (CDT)
Subject: [PATCH] bootwrapper: adds cuboot for MPC7448HPC2 platform
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Message-Id: <1180319418.20906.12.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 28 May 2007 10:30:18 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This patch adds cuboot support for MPC7448HPC2 platform.
The cuImage can be used with legacy u-boot without FDT support.

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
 arch/powerpc/boot/Makefile                 |    4 +-
 arch/powerpc/boot/cuboot-hpc2.c            |   57 ++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/mpc7448hpc2.dts      |    5 ++
 arch/powerpc/boot/ppcboot.h                |    2 +-
 arch/powerpc/platforms/embedded6xx/Kconfig |    1 +
 include/asm-ppc/ppcboot.h                  |    2 +-
 6 files changed, 68 insertions(+), 3 deletions(-)
 create mode 100644 arch/powerpc/boot/cuboot-hpc2.c

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 8378898..5fa515d 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -48,7 +48,8 @@ src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
 		gunzip_util.c elf_util.c $(zlib) devtree.c \
 		44x.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c
 src-plat := of.c cuboot-83xx.c cuboot-85xx.c holly.c \
-		cuboot-ebony.c treeboot-ebony.c prpmc2800.c
+		cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
+		cuboot-hpc2.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -142,6 +143,7 @@ ifneq ($(CONFIG_DEVICE_TREE),"")
 image-$(CONFIG_PPC_83xx)		+= cuImage.83xx
 image-$(CONFIG_PPC_85xx)		+= cuImage.85xx
 image-$(CONFIG_EBONY)			+= treeImage.ebony cuImage.ebony
+image-$(CONFIG_MPC7448HPC2)		+= cuImage.hpc2
 endif
 
 # For 32-bit powermacs, build the COFF and miboot images
diff --git a/arch/powerpc/boot/cuboot-hpc2.c b/arch/powerpc/boot/cuboot-hpc2.c
new file mode 100644
index 0000000..d8f01c4
--- /dev/null
+++ b/arch/powerpc/boot/cuboot-hpc2.c
@@ -0,0 +1,57 @@
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
+
+#define TARGET_TSI108_BRIDGE
+#include "ppcboot.h"
+
+static bd_t bd;
+extern char _end[];
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
+	unsigned long end_of_ram = bd.bi_memstart + bd.bi_memsize;
+	unsigned long avail_ram = end_of_ram - (unsigned long)_end;
+
+	memcpy(&bd, (bd_t *)r3, sizeof(bd));
+	loader_info.initrd_addr = r4;
+	loader_info.initrd_size = r4 ? r5 - r4 : 0;
+	loader_info.cmdline = (char *)r6;
+	loader_info.cmdline_len = r7 - r6;
+
+	simple_alloc_init(_end, avail_ram - 1024*1024, 32, 64);
+	ft_init(_dtb_start, _dtb_end - _dtb_start, 32);
+	serial_console_init();
+	platform_ops.fixups = platform_fixups;
+}
diff --git a/arch/powerpc/boot/dts/mpc7448hpc2.dts b/arch/powerpc/boot/dts/mpc7448hpc2.dts
index 765c306..a2ee94f 100644
--- a/arch/powerpc/boot/dts/mpc7448hpc2.dts
+++ b/arch/powerpc/boot/dts/mpc7448hpc2.dts
@@ -81,6 +81,7 @@
 		};
 
 		ethernet@6200 {
+			linux,network-index = <0>;
 			#size-cells = <0>;
 			device_type = "network";
 			model = "TSI-ETH";
@@ -93,6 +94,7 @@
 		};
 
 		ethernet@6600 {
+			linux,network-index = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			device_type = "network";
@@ -188,5 +190,8 @@
 			};
 		};
 	};
+	chosen {
+		linux,stdout-path = "/tsi108@c0000000/serial@7808";
+	};
 
 };
diff --git a/arch/powerpc/boot/ppcboot.h b/arch/powerpc/boot/ppcboot.h
index 5290ff2..f7ef004 100644
--- a/arch/powerpc/boot/ppcboot.h
+++ b/arch/powerpc/boot/ppcboot.h
@@ -78,7 +78,7 @@ typedef struct bd_info {
 	hymod_conf_t	bi_hymod_conf;	/* hymod configuration information */
 #endif
 #if defined(TARGET_EVB64260) || defined(TARGET_405EP) || defined(TARGET_44x) || \
-	defined(TARGET_85xx) ||	defined(TARGET_83xx)
+	defined(TARGET_85xx) ||	defined(TARGET_83xx) || defined(TARGET_TSI108_BRIDGE)
 	/* second onboard ethernet port */
 	unsigned char	bi_enet1addr[6];
 #define HAVE_ENET1ADDR
diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/platforms/embedded6xx/Kconfig
index f2d2626..9a6c6c2 100644
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

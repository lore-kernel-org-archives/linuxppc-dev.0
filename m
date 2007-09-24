Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4844ADDE17
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Sep 2007 20:30:55 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l8OAUn2X013477
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Sep 2007 03:30:49 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l8OAUliW009563
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Sep 2007 05:30:48 -0500 (CDT)
Subject: [PATCH v2] bootwrapper: adds cuboot for MPC7448HPC2 platform
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <1184144056.23579.16.camel@localhost.localdomain>
References: <1180319418.20906.12.camel@localhost.localdomain>
	<1184144056.23579.16.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1190629915.20267.8.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 24 Sep 2007 18:31:55 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
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
This is the third time for me to generate the patch.
I do not get any negative comment since my previous commit .
Hope your guys can pick it up and merge it into 2.6.24.
The original were pasted at:
http://ozlabs.org/pipermail/linuxppc-dev/2007-May/036834.html
http://ozlabs.org/pipermail/linuxppc-dev/2007-July/038952.html

Cheers

 arch/powerpc/boot/Makefile                 |    3 +-
 arch/powerpc/boot/cuboot-hpc2.c            |   48 ++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/mpc7448hpc2.dts      |    5 +++
 arch/powerpc/platforms/embedded6xx/Kconfig |    1 +
 4 files changed, 56 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/boot/cuboot-hpc2.c

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index cffef14..6ed1415 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -49,7 +49,7 @@ src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
 src-plat := of.c cuboot-83xx.c cuboot-85xx.c holly.c \
 		cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
 		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c cuboot-8xx.c \
-		cuboot-pq2.c cuboot-sequoia.c treeboot-walnut.c
+		cuboot-pq2.c cuboot-sequoia.c treeboot-walnut.c cuboot-hpc2.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -146,6 +146,7 @@ image-$(CONFIG_8260)			+= cuImage.pq2
 image-$(CONFIG_PPC_83xx)		+= cuImage.83xx
 image-$(CONFIG_PPC_85xx)		+= cuImage.85xx
 image-$(CONFIG_EBONY)			+= treeImage.ebony cuImage.ebony
+image-$(CONFIG_MPC7448HPC2)		+= cuImage.hpc2
 image-$(CONFIG_BAMBOO)			+= treeImage.bamboo
 image-$(CONFIG_SEQUOIA)			+= cuImage.sequoia
 image-$(CONFIG_WALNUT)			+= treeImage.walnut
diff --git a/arch/powerpc/boot/cuboot-hpc2.c b/arch/powerpc/boot/cuboot-hpc2.c
new file mode 100644
index 0000000..d333898
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
+#define TARGET_HAS_ETH1
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
index 70e8a2e..0b58136 100644
--- a/arch/powerpc/boot/dts/mpc7448hpc2.dts
+++ b/arch/powerpc/boot/dts/mpc7448hpc2.dts
@@ -79,6 +79,7 @@
 		};
 
 		ethernet@6200 {
+			linux,network-index = <0>;
 			#size-cells = <0>;
 			device_type = "network";
 			compatible = "tsi109-ethernet", "tsi108-ethernet";
@@ -91,6 +92,7 @@
 		};
 
 		ethernet@6600 {
+			linux,network-index = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			device_type = "network";
@@ -184,5 +186,8 @@
 			};
 		};
 	};
+	chosen {
+		linux,stdout-path = "/tsi108@c0000000/serial@7808";
+	};
 
 };
diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/platforms/embedded6xx/Kconfig
index 2d12f77..6d10e84 100644
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
-- 
1.5.2

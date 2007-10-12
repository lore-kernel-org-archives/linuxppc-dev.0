Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A3274DDE43
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 23:18:38 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l9CDIU1a009153
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 06:18:31 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l9CDIKNB006039
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 08:18:29 -0500 (CDT)
From: Li Yang <leoli@freescale.com>
To: galak@kernel.crashing.org, paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH v3 3/9] add Freescale SerDes PHY support
Date: Fri, 12 Oct 2007 21:28:42 +0800
Message-Id: <1192195728-24189-4-git-send-email-leoli@freescale.com>
In-Reply-To: <1192195728-24189-3-git-send-email-leoli@freescale.com>
References: <1192195728-24189-1-git-send-email-leoli@freescale.com>
	<1192195728-24189-2-git-send-email-leoli@freescale.com>
	<1192195728-24189-3-git-send-email-leoli@freescale.com>
Cc: Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The SerDes(serializer/deserializer) PHY block is a new SoC block used
in Freescale chips to support multiple serial interfaces, such as PCI
Express, SGMII, SATA.

Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/platforms/Kconfig   |    3 +
 arch/powerpc/sysdev/Makefile     |    1 +
 arch/powerpc/sysdev/fsl_serdes.c |  152 ++++++++++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/fsl_serdes.h |   36 +++++++++
 4 files changed, 192 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/sysdev/fsl_serdes.c
 create mode 100644 arch/powerpc/sysdev/fsl_serdes.h

diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index cc6013f..ff4fddc 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -313,4 +313,7 @@ config FSL_ULI1575
 config CPM
 	bool
 
+config FSL_SERDES
+	bool
+
 endmenu
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 1a6f564..a892aa0 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_MV64X60)		+= $(mv64x60-y) mv64x60_pic.o mv64x60_dev.o \
 				   mv64x60_udbg.o
 obj-$(CONFIG_RTC_DRV_CMOS)	+= rtc_cmos_setup.o
 obj-$(CONFIG_AXON_RAM)		+= axonram.o
+obj-$(CONFIG_FSL_SERDES)	+= fsl_serdes.o
 
 ifeq ($(CONFIG_PPC_MERGE),y)
 obj-$(CONFIG_PPC_INDIRECT_PCI)	+= indirect_pci.o
diff --git a/arch/powerpc/sysdev/fsl_serdes.c b/arch/powerpc/sysdev/fsl_serdes.c
new file mode 100644
index 0000000..5e91eb7
--- /dev/null
+++ b/arch/powerpc/sysdev/fsl_serdes.c
@@ -0,0 +1,152 @@
+/*
+ * arch/powerpc/sysdev/fsl_serdes.c
+ *
+ * Copyright (C) 2007 Freescale Semiconductor, Inc. All rights reserved.
+ *
+ * Author: Li Yang <leoli@freescale.com>
+ *
+ * Freescale SerDes initialization routines
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/of.h>
+
+#include <asm/system.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+
+#include "fsl_serdes.h"
+
+static int __init setup_serdes(struct device_node *np)
+{
+	void __iomem *regs;
+	const void *prot;
+	const unsigned int *freq;
+	struct resource res;
+	u32 rfcks;
+
+	of_address_to_resource(np, 0, &res);
+	regs = ioremap(res.start, res.end - res.start + 1);
+
+	prot = of_get_property(np, "protocol", NULL);
+	if (!prot)
+		return -EINVAL;
+	freq = of_get_property(np, "clock", NULL);
+	switch (*freq) {
+	case 100:
+		rfcks = FSL_SRDSCR4_RFCKS_100;
+		break;
+	case 125:
+		rfcks = FSL_SRDSCR4_RFCKS_125;
+		break;
+	case 150:
+		rfcks = FSL_SRDSCR4_RFCKS_150;
+		break;
+	default:
+		printk(KERN_ERR "SerDes: Wrong frequency\n");
+		return -EINVAL;
+	}
+
+	/* Use default prescale and counter */
+
+	/* 1.0V corevdd */
+	if (of_get_property(np, "vdd-1v", NULL)) {
+		/* DPPE/DPPA = 0 */
+		clrbits32(regs + FSL_SRDSCR0_OFFS, FSL_SRDSCR0_DPP_1V2);
+
+		/* VDD = 0 */
+		clrbits32(regs + FSL_SRDSCR2_OFFS, FSL_SRDSCR2_VDD_1V2);
+	}
+
+	/* protocol specific configuration */
+	if (!strcmp(prot, "sata")) {
+		/* Set and clear reset bits */
+		setbits32(regs + FSL_SRDSRSTCTL_OFFS,
+				FSL_SRDSRSTCTL_SATA_RESET);
+		mdelay(1);
+		clrbits32(regs + FSL_SRDSRSTCTL_OFFS,
+				FSL_SRDSRSTCTL_SATA_RESET);
+
+		/* Configure SRDSCR1 */
+		clrbits32(regs + FSL_SRDSCR1_OFFS, FSL_SRDSCR1_PLLBW);
+
+		/* Configure SRDSCR2 */
+		clrsetbits_be32(regs + FSL_SRDSCR2_OFFS,
+				FSL_SRDSCR2_SEIC_MASK, FSL_SRDSCR2_SEIC_SATA);
+
+		/* Configure SRDSCR3 */
+		out_be32(regs + FSL_SRDSCR3_OFFS, FSL_SRDSCR3_KFR_SATA |
+				FSL_SRDSCR3_KPH_SATA |
+				FSL_SRDSCR3_SDFM_SATA_PEX |
+				FSL_SRDSCR3_SDTXL_SATA);
+
+		/* Configure SRDSCR4 */
+		out_be32(regs + FSL_SRDSCR4_OFFS, rfcks |
+				FSL_SRDSCR4_PROT_SATA);
+
+	} else if (!strcmp(prot, "pcie")) {
+		/* Configure SRDSCR1 */
+		setbits32(regs + FSL_SRDSCR1_OFFS, FSL_SRDSCR1_PLLBW);
+
+		/* Configure SRDSCR2 */
+		clrsetbits_be32(regs + FSL_SRDSCR2_OFFS, FSL_SRDSCR2_SEIC_MASK,
+				FSL_SRDSCR2_SEIC_PEX);
+
+		/* Configure SRDSCR3 */
+		out_be32(regs + FSL_SRDSCR3_OFFS, FSL_SRDSCR3_SDFM_SATA_PEX);
+
+		/* Configure SRDSCR4 */
+		if (of_get_property(np, "pcie-x2", NULL))
+			out_be32(regs + FSL_SRDSCR4_OFFS, rfcks |
+				FSL_SRDSCR4_PROT_PEX | FSL_SRDSCR4_PLANE_X2);
+		else
+			out_be32(regs + FSL_SRDSCR4_OFFS, rfcks |
+				FSL_SRDSCR4_PROT_PEX);
+
+	} else if (!strcmp(prot, "sgmii")) {
+		/* Configure SRDSCR1 */
+		clrbits32(regs + FSL_SRDSCR1_OFFS, FSL_SRDSCR1_PLLBW);
+
+		/* Configure SRDSCR2 */
+		clrsetbits_be32(regs + FSL_SRDSCR2_OFFS, FSL_SRDSCR2_SEIC_MASK,
+				FSL_SRDSCR2_SEIC_SGMII);
+
+		/* Configure SRDSCR3 */
+		out_be32(regs + FSL_SRDSCR3_OFFS, 0);
+
+		/* Configure SRDSCR4 */
+		out_be32(regs + FSL_SRDSCR4_OFFS, rfcks |
+				FSL_SRDSCR4_PROT_SGMII);
+
+	} else {
+		printk(KERN_ERR "SerDes: Wrong protocol\n");
+		return -EINVAL;
+	}
+
+	/* Do a software reset */
+	setbits32(regs + FSL_SRDSRSTCTL_OFFS, FSL_SRDSRSTCTL_RST);
+
+	printk(KERN_INFO "Freescale SerDes at %8x initialized\n", res.start);
+
+	return 0;
+}
+
+static int __init fsl_serdes_init(void) {
+	struct device_node *np;
+
+	for (np = NULL; (np = of_find_compatible_node(np, NULL, "fsl,serdes")) != NULL;)
+		setup_serdes(np);
+
+	return 0;
+}
+
+arch_initcall(fsl_serdes_init);
diff --git a/arch/powerpc/sysdev/fsl_serdes.h b/arch/powerpc/sysdev/fsl_serdes.h
new file mode 100644
index 0000000..d4e5570
--- /dev/null
+++ b/arch/powerpc/sysdev/fsl_serdes.h
@@ -0,0 +1,36 @@
+/*
+ * Copyright (C) 2007 Freescale Semiconductor, Inc. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+/* SerDes registers */
+#define FSL_SRDSCR0_OFFS		0x0
+#define FSL_SRDSCR0_DPP_1V2		0x00008800
+#define FSL_SRDSCR1_OFFS		0x4
+#define FSL_SRDSCR1_PLLBW		0x00000040
+#define FSL_SRDSCR2_OFFS		0x8
+#define FSL_SRDSCR2_VDD_1V2		0x00800000
+#define FSL_SRDSCR2_SEIC_MASK		0x00001c1c
+#define FSL_SRDSCR2_SEIC_SATA		0x00001414
+#define FSL_SRDSCR2_SEIC_PEX		0x00001010
+#define FSL_SRDSCR2_SEIC_SGMII		0x00000101
+#define FSL_SRDSCR3_OFFS		0xc
+#define FSL_SRDSCR3_KFR_SATA		0x10100000
+#define FSL_SRDSCR3_KPH_SATA		0x04040000
+#define FSL_SRDSCR3_SDFM_SATA_PEX	0x01010000
+#define FSL_SRDSCR3_SDTXL_SATA		0x00000505
+#define FSL_SRDSCR4_OFFS		0x10
+#define FSL_SRDSCR4_PROT_SATA		0x00000808
+#define FSL_SRDSCR4_PROT_PEX		0x00000101
+#define FSL_SRDSCR4_PROT_SGMII		0x00000505
+#define FSL_SRDSCR4_PLANE_X2		0x01000000
+#define FSL_SRDSCR4_RFCKS_100		0x00000000
+#define FSL_SRDSCR4_RFCKS_125		0x10000000
+#define FSL_SRDSCR4_RFCKS_150		0x30000000
+#define FSL_SRDSRSTCTL_OFFS		0x20
+#define FSL_SRDSRSTCTL_RST		0x80000000
+#define FSL_SRDSRSTCTL_SATA_RESET	0xf
-- 
1.5.3.2.104.g41ef

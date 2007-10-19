Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 79027DDF36
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 21:28:33 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l9JBSSar015116
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 04:28:28 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l9JBSNKa016129
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 06:28:27 -0500 (CDT)
From: Li Yang <leoli@freescale.com>
To: galak@kernel.crashing.org, paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH v7 3/9] add Freescale SerDes PHY support
Date: Fri, 19 Oct 2007 19:38:44 +0800
Message-Id: <1192793930-26039-4-git-send-email-leoli@freescale.com>
In-Reply-To: <1192793930-26039-3-git-send-email-leoli@freescale.com>
References: <1192793930-26039-1-git-send-email-leoli@freescale.com>
	<1192793930-26039-2-git-send-email-leoli@freescale.com>
	<1192793930-26039-3-git-send-email-leoli@freescale.com>
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
 arch/powerpc/platforms/Kconfig   |    7 ++
 arch/powerpc/sysdev/Makefile     |    1 +
 arch/powerpc/sysdev/fsl_serdes.c |  195 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 203 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/sysdev/fsl_serdes.c

diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 229d355..5d64f84 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -315,6 +315,13 @@ config FSL_ULI1575
 config CPM
 	bool
 
+config FSL_SERDES
+	bool
+	help
+	  The SerDes(serializer/deserializer) PHY block is a new SoC block
+	  used in Freescale chips to support multiple serial interfaces,
+	  such as PCI Express, SGMII, SATA.
+
 source "arch/powerpc/sysdev/bestcomm/Kconfig"
 
 endmenu
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 99a77d7..2343ea4 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_MV64X60)		+= $(mv64x60-y) mv64x60_pic.o mv64x60_dev.o \
 				   mv64x60_udbg.o
 obj-$(CONFIG_RTC_DRV_CMOS)	+= rtc_cmos_setup.o
 obj-$(CONFIG_AXON_RAM)		+= axonram.o
+obj-$(CONFIG_FSL_SERDES)	+= fsl_serdes.o
 
 ifeq ($(CONFIG_PPC_MERGE),y)
 obj-$(CONFIG_PPC_INDIRECT_PCI)	+= indirect_pci.o
diff --git a/arch/powerpc/sysdev/fsl_serdes.c b/arch/powerpc/sysdev/fsl_serdes.c
new file mode 100644
index 0000000..670015d
--- /dev/null
+++ b/arch/powerpc/sysdev/fsl_serdes.c
@@ -0,0 +1,195 @@
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
+#include <linux/of_platform.h>
+
+#include <asm/system.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+
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
+
+static int fsl_serdes_probe(struct of_device *ofdev,
+		const struct of_device_id *match)
+{
+	struct device_node *np = ofdev->node;
+	void __iomem *regs;
+	const char *prot;
+	const unsigned int *freq;
+	u32 rfcks;
+
+	regs = of_iomap(np, 0);
+	if (!regs)
+		return -ENOMEM;
+
+	prot = of_get_property(np, "protocol", NULL);
+	if (!prot)
+		goto out;
+	freq = of_get_property(np, "clock", NULL);
+	if (!freq)
+		goto out;
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
+		goto out;
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
+		goto out;
+	}
+
+	/* Do a software reset */
+	setbits32(regs + FSL_SRDSRSTCTL_OFFS, FSL_SRDSRSTCTL_RST);
+	iounmap(regs);
+
+	dev_printk(KERN_INFO, &ofdev->dev, "Initialized as %s\n", prot);
+
+	return 0;
+out:
+	iounmap(regs);
+	return -EINVAL;
+}
+
+static struct of_device_id fsl_serdes_match[] = {
+	{
+		.compatible = "fsl,serdes",
+	},
+	{},
+};
+
+static struct of_platform_driver fsl_serdes_driver = {
+	.name		= "fsl-serdes",
+	.match_table	= fsl_serdes_match,
+	.probe		= fsl_serdes_probe,
+};
+
+static int __init fsl_serdes_init(void)
+{
+	of_register_platform_driver(&fsl_serdes_driver);
+	return 0;
+}
+device_initcall(fsl_serdes_init);
-- 
1.5.3.2.104.g41ef

Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 468F3DDF6C
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 19:56:26 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l9A9uJKK026930
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 02:56:20 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l9A9uFR9029638
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 04:56:19 -0500 (CDT)
From: Li Yang <leoli@freescale.com>
To: galak@kernel.crashing.org, paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 3/9] add Freescale SerDes PHY support
Date: Wed, 10 Oct 2007 18:06:38 +0800
Message-Id: <1192010804-20071-3-git-send-email-leoli@freescale.com>
In-Reply-To: <1192010804-20071-2-git-send-email-leoli@freescale.com>
References: <1192010804-20071-1-git-send-email-leoli@freescale.com>
	<1192010804-20071-2-git-send-email-leoli@freescale.com>
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
 arch/powerpc/platforms/Kconfig   |    4 +
 arch/powerpc/sysdev/Makefile     |    1 +
 arch/powerpc/sysdev/fsl_serdes.c |  170 ++++++++++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/fsl_serdes.h |   36 ++++++++
 4 files changed, 211 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/sysdev/fsl_serdes.c
 create mode 100644 arch/powerpc/sysdev/fsl_serdes.h

diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 19d4628..e89f803 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -291,4 +291,8 @@ config FSL_ULI1575
 	  Freescale reference boards. The boards all use the ULI in pretty
 	  much the same way.
 
+config FSL_SERDES
+	bool
+	default n
+
 endmenu
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 08ce31e..315aa36 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -19,6 +19,7 @@ mv64x60-$(CONFIG_PCI)		+= mv64x60_pci.o
 obj-$(CONFIG_MV64X60)		+= $(mv64x60-y) mv64x60_pic.o mv64x60_dev.o
 obj-$(CONFIG_RTC_DRV_CMOS)	+= rtc_cmos_setup.o
 obj-$(CONFIG_AXON_RAM)		+= axonram.o
+obj-$(CONFIG_FSL_SERDES)	+= fsl_serdes.o
 
 # contains only the suspend handler for time
 ifeq ($(CONFIG_RTC_CLASS),)
diff --git a/arch/powerpc/sysdev/fsl_serdes.c b/arch/powerpc/sysdev/fsl_serdes.c
new file mode 100644
index 0000000..8a04395
--- /dev/null
+++ b/arch/powerpc/sysdev/fsl_serdes.c
@@ -0,0 +1,170 @@
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
+
+#include <asm/system.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/prom.h>
+
+#include "fsl_serdes.h"
+
+static int __init setup_serdes(struct device_node *np)
+{
+	void __iomem *regs;
+	const void *prot;
+	const unsigned int *freq;
+	struct resource res;
+	u32 tmp, rfcks;
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
+		tmp = in_be32(regs + FSL_SRDSCR0_OFFS);
+		tmp &= ~FSL_SRDSCR0_DPP_1V2;
+		out_be32(regs + FSL_SRDSCR0_OFFS, tmp);
+
+		/* VDD = 0 */
+		tmp = in_be32(regs + FSL_SRDSCR2_OFFS);
+		tmp &= ~FSL_SRDSCR2_VDD_1V2;
+		out_be32(regs + FSL_SRDSCR2_OFFS, tmp);
+	}
+
+	/* protocol specific configuration */
+	if (!strcmp(prot, "sata")) {
+		/* Set and clear reset bits */
+		tmp = in_be32(regs + FSL_SRDSRSTCTL_OFFS);
+		tmp |= FSL_SRDSRSTCTL_SATA_RESET;
+		out_be32(regs + FSL_SRDSRSTCTL_OFFS, tmp);
+		mdelay(1);
+		tmp &= ~FSL_SRDSRSTCTL_SATA_RESET;
+		out_be32(regs + FSL_SRDSRSTCTL_OFFS, tmp);
+
+		/* Configure SRDSCR1 */
+		tmp = in_be32(regs + FSL_SRDSCR1_OFFS);
+		tmp &= ~FSL_SRDSCR1_PLLBW;
+		out_be32(regs + FSL_SRDSCR1_OFFS, tmp);
+
+		/* Configure SRDSCR2 */
+		tmp = in_be32(regs + FSL_SRDSCR2_OFFS);
+		tmp &= ~FSL_SRDSCR2_SEIC_MASK;
+		tmp |= FSL_SRDSCR2_SEIC_SATA;
+		out_be32(regs + FSL_SRDSCR2_OFFS, tmp);
+
+		/* Configure SRDSCR3 */
+		tmp = FSL_SRDSCR3_KFR_SATA | FSL_SRDSCR3_KPH_SATA |
+			FSL_SRDSCR3_SDFM_SATA_PEX |
+			FSL_SRDSCR3_SDTXL_SATA;
+		out_be32(regs + FSL_SRDSCR3_OFFS, tmp);
+
+		/* Configure SRDSCR4 */
+		tmp = rfcks | FSL_SRDSCR4_PROT_SATA;
+		out_be32(regs + FSL_SRDSCR4_OFFS, tmp);
+
+	} else if (!strcmp(prot, "pcie")) {
+		/* Configure SRDSCR1 */
+		tmp = in_be32(regs + FSL_SRDSCR1_OFFS);
+		tmp |= FSL_SRDSCR1_PLLBW;
+		out_be32(regs + FSL_SRDSCR1_OFFS, tmp);
+
+		/* Configure SRDSCR2 */
+		tmp = in_be32(regs + FSL_SRDSCR2_OFFS);
+		tmp &= ~FSL_SRDSCR2_SEIC_MASK;
+		tmp |= FSL_SRDSCR2_SEIC_PEX;
+		out_be32(regs + FSL_SRDSCR2_OFFS, tmp);
+
+		/* Configure SRDSCR3 */
+		tmp = FSL_SRDSCR3_SDFM_SATA_PEX;
+		out_be32(regs + FSL_SRDSCR3_OFFS, tmp);
+
+		/* Configure SRDSCR4 */
+		tmp = rfcks | FSL_SRDSCR4_PROT_PEX;
+		if (of_get_property(np, "pcie-x2", NULL))
+				tmp |= FSL_SRDSCR4_PLANE_X2;
+		out_be32(regs + FSL_SRDSCR4_OFFS, tmp);
+
+	} else if (!strcmp(prot, "sgmii")) {
+		/* Configure SRDSCR1 */
+		tmp = in_be32(regs + FSL_SRDSCR1_OFFS);
+		tmp &= ~FSL_SRDSCR1_PLLBW;
+		out_be32(regs + FSL_SRDSCR1_OFFS, tmp);
+
+		/* Configure SRDSCR2 */
+		tmp = in_be32(regs + FSL_SRDSCR2_OFFS);
+		tmp &= ~FSL_SRDSCR2_SEIC_MASK;
+		tmp |= FSL_SRDSCR2_SEIC_SGMII;
+		out_be32(regs + FSL_SRDSCR2_OFFS, tmp);
+
+		/* Configure SRDSCR3 */
+		out_be32(regs + FSL_SRDSCR3_OFFS, 0);
+
+		/* Configure SRDSCR4 */
+		tmp = rfcks | FSL_SRDSCR4_PROT_SGMII;
+		out_be32(regs + FSL_SRDSCR4_OFFS, tmp);
+
+	} else {
+		printk(KERN_ERR "SerDes: Wrong protocol\n");
+		return -EINVAL;
+	}
+
+	/* Do a software reset */
+	tmp = in_be32(regs + FSL_SRDSRSTCTL_OFFS);
+	tmp |= FSL_SRDSRSTCTL_RST;
+	out_be32(regs + FSL_SRDSRSTCTL_OFFS, tmp);
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

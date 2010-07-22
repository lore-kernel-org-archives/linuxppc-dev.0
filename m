Return-Path: <timur@freescale.com>
Received: from VA3EHSOBE001.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) by ozlabs.org (Postfix) with ESMTP id 0065D1007D4
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 02:33:50 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: alsa-devel@alsa-project.org, linuxppc-dev@ozlabs.org, lrg@slimlogic.co.uk,
	broonie@opensource.wolfsonmicro.com, kumar.gala@freescale.com
Subject: [PATCH][v2] powerpc: rename immap_86xx.h to fsl_guts.h,
	and add 85xx support
Date: Thu, 22 Jul 2010 11:33:30 -0500
Message-ID: <1279816410-19079-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The immap_86xx.h header file only defines one data structure: the "global
utilities" register set found on Freescale PowerPC SOCs.  Rename this file
to fsl_guts.h to reflect its true purpose, and extend it to cover the "GUTS"
register set on 85xx chips.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

Liam,

This patch is a powerpc-patch, but it's much simpler if you apply it to
multi-component, since only the SSI audio drivers are affected.

 .../include/asm/{immap_86xx.h => fsl_guts.h}       |  111 +++++++++++++------
 sound/soc/fsl/fsl_ssi.c                            |    2 -
 sound/soc/fsl/mpc8610_hpcd.c                       |   10 +-
 3 files changed, 81 insertions(+), 42 deletions(-)
 rename arch/powerpc/include/asm/{immap_86xx.h => fsl_guts.h} (66%)

diff --git a/arch/powerpc/include/asm/immap_86xx.h b/arch/powerpc/include/asm/fsl_guts.h
similarity index 66%
rename from arch/powerpc/include/asm/immap_86xx.h
rename to arch/powerpc/include/asm/fsl_guts.h
index 0f165e5..bebd124 100644
--- a/arch/powerpc/include/asm/immap_86xx.h
+++ b/arch/powerpc/include/asm/fsl_guts.h
@@ -1,5 +1,5 @@
 /**
- * MPC86xx Internal Memory Map
+ * Freecale 85xx and 86xx Global Utilties register set
  *
  * Authors: Jeff Brown
  *          Timur Tabi <timur@freescale.com>
@@ -10,73 +10,112 @@
  * under  the terms of  the GNU General  Public License as published by the
  * Free Software Foundation;  either version 2 of the  License, or (at your
  * option) any later version.
- *
- * This header file defines structures for various 86xx SOC devices that are
- * used by multiple source files.
  */

-#ifndef __ASM_POWERPC_IMMAP_86XX_H__
-#define __ASM_POWERPC_IMMAP_86XX_H__
+#ifndef __ASM_POWERPC_FSL_GUTS_H__
+#define __ASM_POWERPC_FSL_GUTS_H__
 #ifdef __KERNEL__

-/* Global Utility Registers */
-struct ccsr_guts {
+/*
+ * These #ifdefs are safe because it's not possible to build a kernel that
+ * runs on e500 and e600 cores.
+ */
+
+#if !defined(CONFIG_PPC_85xx) && !defined(CONFIG_PPC_86xx)
+#error Only 85xx and 86xx SOCs are supported
+#endif
+
+/**
+ * Global Utility Registers.
+ *
+ * Not all registers defined in this structure are available on all chips, so
+ * you are expected to know whether a given register actually exists on your
+ * chip before you access it.
+ *
+ * Also, some registers are similar on different chips but have slightly
+ * different names.  In these cases, one name is chosen to avoid extraneous
+ * #ifdefs.
+ */
+#ifdef CONFIG_PPC_85xx
+struct ccsr_guts_85xx {
+#else
+struct ccsr_guts_86xx {
+#endif
 	__be32	porpllsr;	/* 0x.0000 - POR PLL Ratio Status Register */
 	__be32	porbmsr;	/* 0x.0004 - POR Boot Mode Status Register */
 	__be32	porimpscr;	/* 0x.0008 - POR I/O Impedance Status and Control Register */
 	__be32	pordevsr;	/* 0x.000c - POR I/O Device Status Register */
 	__be32	pordbgmsr;	/* 0x.0010 - POR Debug Mode Status Register */
-	u8	res1[0x20 - 0x14];
+	__be32	pordevsr2;	/* 0x.0014 - POR device status register 2 */
+	u8	res018[0x20 - 0x18];
 	__be32	porcir;		/* 0x.0020 - POR Configuration Information Register */
-	u8	res2[0x30 - 0x24];
+	u8	res024[0x30 - 0x24];
 	__be32	gpiocr;		/* 0x.0030 - GPIO Control Register */
-	u8	res3[0x40 - 0x34];
+	u8	res034[0x40 - 0x34];
 	__be32	gpoutdr;	/* 0x.0040 - General-Purpose Output Data Register */
-	u8	res4[0x50 - 0x44];
+	u8	res044[0x50 - 0x44];
 	__be32	gpindr;		/* 0x.0050 - General-Purpose Input Data Register */
-	u8	res5[0x60 - 0x54];
+	u8	res054[0x60 - 0x54];
 	__be32	pmuxcr;		/* 0x.0060 - Alternate Function Signal Multiplex Control */
-	u8	res6[0x70 - 0x64];
+        __be32  pmuxcr2;	/* 0x.0064 - Alternate function signal multiplex control 2 */
+        __be32  dmuxcr;		/* 0x.0068 - DMA Mux Control Register */
+        u8	res06c[0x70 - 0x6c];
 	__be32	devdisr;	/* 0x.0070 - Device Disable Control */
 	__be32	devdisr2;	/* 0x.0074 - Device Disable Control 2 */
-	u8	res7[0x80 - 0x78];
+	u8	res078[0x7c - 0x78];
+	__be32  pmjcr;		/* 0x.007c - 4 Power Management Jog Control Register */
 	__be32	powmgtcsr;	/* 0x.0080 - Power Management Status and Control Register */
-	u8	res8[0x90 - 0x84];
+	__be32  pmrccr;		/* 0x.0084 - Power Management Reset Counter Configuration Register */
+	__be32  pmpdccr;	/* 0x.0088 - Power Management Power Down Counter Configuration Register */
+	__be32  pmcdr;		/* 0x.008c - 4Power management clock disable register */
 	__be32	mcpsumr;	/* 0x.0090 - Machine Check Summary Register */
 	__be32	rstrscr;	/* 0x.0094 - Reset Request Status and Control Register */
-	u8	res9[0xA0 - 0x98];
+	__be32  ectrstcr;	/* 0x.0098 - Exception reset control register */
+	__be32  autorstsr;	/* 0x.009c - Automatic reset status register */
 	__be32	pvr;		/* 0x.00a0 - Processor Version Register */
 	__be32	svr;		/* 0x.00a4 - System Version Register */
-	u8	res10[0xB0 - 0xA8];
+	u8	res0a8[0xb0 - 0xa8];
 	__be32	rstcr;		/* 0x.00b0 - Reset Control Register */
-	u8	res11[0xC0 - 0xB4];
+	u8	res0b4[0xc0 - 0xb4];
+#ifdef CONFIG_PPC_85xx
+	__be32  iovselsr;	/* 0x.00c0 - I/O voltage select status register */
+#else
 	__be32	elbcvselcr;	/* 0x.00c0 - eLBC Voltage Select Ctrl Reg */
-	u8	res12[0x800 - 0xC4];
+#endif
+	u8	res0c4[0x224 - 0xc4];
+	__be32  iodelay1;	/* 0x.0224 - IO delay control register 1 */
+	__be32  iodelay2;	/* 0x.0228 - IO delay control register 2 */
+	u8	res22c[0x800 - 0x22c];
 	__be32	clkdvdr;	/* 0x.0800 - Clock Divide Register */
-	u8	res13[0x900 - 0x804];
+	u8	res804[0x900 - 0x804];
 	__be32	ircr;		/* 0x.0900 - Infrared Control Register */
-	u8	res14[0x908 - 0x904];
+	u8	res904[0x908 - 0x904];
 	__be32	dmacr;		/* 0x.0908 - DMA Control Register */
-	u8	res15[0x914 - 0x90C];
+	u8	res90c[0x914 - 0x90c];
 	__be32	elbccr;		/* 0x.0914 - eLBC Control Register */
-	u8	res16[0xB20 - 0x918];
+	u8	res918[0xb20 - 0x918];
 	__be32	ddr1clkdr;	/* 0x.0b20 - DDR1 Clock Disable Register */
 	__be32	ddr2clkdr;	/* 0x.0b24 - DDR2 Clock Disable Register */
 	__be32	ddrclkdr;	/* 0x.0b28 - DDR Clock Disable Register */
-	u8	res17[0xE00 - 0xB2C];
+	u8	resb2c[0xe00 - 0xb2c];
 	__be32	clkocr;		/* 0x.0e00 - Clock Out Select Register */
-	u8	res18[0xE10 - 0xE04];
+	u8	rese04[0xe10 - 0xe04];
 	__be32	ddrdllcr;	/* 0x.0e10 - DDR DLL Control Register */
-	u8	res19[0xE20 - 0xE14];
+	u8	rese14[0xe20 - 0xe14];
 	__be32	lbcdllcr;	/* 0x.0e20 - LBC DLL Control Register */
-	u8	res20[0xF04 - 0xE24];
+	__be32  cpfor;		/* 0x.0e24 - L2 charge pump fuse override register */
+	u8	rese28[0xf04 - 0xe28];
 	__be32	srds1cr0;	/* 0x.0f04 - SerDes1 Control Register 0 */
 	__be32	srds1cr1;	/* 0x.0f08 - SerDes1 Control Register 0 */
-	u8	res21[0xF40 - 0xF0C];
-	__be32	srds2cr0;	/* 0x.0f40 - SerDes1 Control Register 0 */
-	__be32	srds2cr1;	/* 0x.0f44 - SerDes1 Control Register 0 */
+	u8	resf0c[0xf2c - 0xf0c];
+	__be32  itcr;		/* 0x.0f2c - Internal transaction control register */
+	u8	resf30[0xf40 - 0xf30];
+	__be32	srds2cr0;	/* 0x.0f40 - SerDes2 Control Register 0 */
+	__be32	srds2cr1;	/* 0x.0f44 - SerDes2 Control Register 0 */
 } __attribute__ ((packed));

+#ifdef CONFIG_PPC_86xx
+
 #define CCSR_GUTS_DMACR_DEV_SSI	0	/* DMA controller/channel set to SSI */
 #define CCSR_GUTS_DMACR_DEV_IR	1	/* DMA controller/channel set to IR */

@@ -93,7 +132,7 @@ struct ccsr_guts {
  * ch: The channel on the DMA controller (0, 1, 2, or 3)
  * device: The device to set as the source (CCSR_GUTS_DMACR_DEV_xx)
  */
-static inline void guts_set_dmacr(struct ccsr_guts __iomem *guts,
+static inline void guts_set_dmacr(struct ccsr_guts_86xx __iomem *guts,
 	unsigned int co, unsigned int ch, unsigned int device)
 {
 	unsigned int shift = 16 + (8 * (1 - co) + 2 * (3 - ch));
@@ -129,7 +168,7 @@ static inline void guts_set_dmacr(struct ccsr_guts __iomem *guts,
  * ch: The channel on the DMA controller (0, 1, 2, or 3)
  * value: the new value for the bit (0 or 1)
  */
-static inline void guts_set_pmuxcr_dma(struct ccsr_guts __iomem *guts,
+static inline void guts_set_pmuxcr_dma(struct ccsr_guts_86xx __iomem *guts,
 	unsigned int co, unsigned int ch, unsigned int value)
 {
 	if ((ch == 0) || (ch == 3)) {
@@ -152,5 +191,7 @@ static inline void guts_set_pmuxcr_dma(struct ccsr_guts __iomem *guts,
 #define CCSR_GUTS_CLKDVDR_SSICLK_MASK	0x000000FF
 #define CCSR_GUTS_CLKDVDR_SSICLK(x) ((x) & CCSR_GUTS_CLKDVDR_SSICLK_MASK)

-#endif /* __ASM_POWERPC_IMMAP_86XX_H__ */
-#endif /* __KERNEL__ */
+#endif
+
+#endif
+#endif
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 31e8e5c..48fc0bd 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -24,8 +24,6 @@
 #include <sound/initval.h>
 #include <sound/soc.h>

-#include <asm/immap_86xx.h>
-
 #include "fsl_ssi.h"

 /**
diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index 81ab639..69aeaeb 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -14,7 +14,7 @@
 #include <linux/interrupt.h>
 #include <linux/of_device.h>
 #include <sound/soc.h>
-#include <asm/immap_86xx.h>
+#include <asm/fsl_guts.h>

 #include "../codecs/cs4270.h"
 #include "fsl_dma.h"
@@ -54,9 +54,9 @@ static int mpc8610_hpcd_machine_probe(struct platform_device *sound_device)
 	struct snd_soc_card *card = platform_get_drvdata(sound_device);
 	struct mpc8610_hpcd_data *machine_data =
 		container_of(card, struct mpc8610_hpcd_data, card);
-	struct ccsr_guts __iomem *guts;
+	struct ccsr_guts_86xx __iomem *guts;

-	guts = ioremap(guts_phys, sizeof(struct ccsr_guts));
+	guts = ioremap(guts_phys, sizeof(struct ccsr_guts_86xx));
 	if (!guts) {
 		dev_err(card->dev, "could not map global utilities\n");
 		return -ENOMEM;
@@ -139,9 +139,9 @@ static int mpc8610_hpcd_machine_remove(struct platform_device *sound_device)
 	struct snd_soc_card *card = platform_get_drvdata(sound_device);
 	struct mpc8610_hpcd_data *machine_data =
 		container_of(card, struct mpc8610_hpcd_data, card);
-	struct ccsr_guts __iomem *guts;
+	struct ccsr_guts_86xx __iomem *guts;

-	guts = ioremap(guts_phys, sizeof(struct ccsr_guts));
+	guts = ioremap(guts_phys, sizeof(struct ccsr_guts_86xx));
 	if (!guts) {
 		dev_err(card->dev, "could not map global utilities\n");
 		return -ENOMEM;
--
1.7.0.1

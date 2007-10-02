Return-Path: <b04825@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DB3A8DDF91
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 07:27:22 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l92LRGSd014375
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Oct 2007 14:27:17 -0700 (MST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] update immap_86xx.h for the 8610
Date: Tue,  2 Oct 2007 16:27:13 -0500
Message-Id: <11913604331348-git-send-email-timur@freescale.com>
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Update the definition of the global utilities structure (ccsr_guts) in
immap_86xx.h and add some related macros for the Freescale 8610 SOC.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

This patch is for 2.6.24.

 include/asm-powerpc/immap_86xx.h |   86 ++++++++++++++++++++++++++++++++++----
 1 files changed, 78 insertions(+), 8 deletions(-)

diff --git a/include/asm-powerpc/immap_86xx.h b/include/asm-powerpc/immap_86xx.h
index c83d7ad..0ad4e65 100644
--- a/include/asm-powerpc/immap_86xx.h
+++ b/include/asm-powerpc/immap_86xx.h
@@ -38,7 +38,8 @@ struct ccsr_guts {
 	__be32	pmuxcr;		/* 0x.0060 - Alternate Function Signal Multiplex Control */
 	u8	res6[0x70 - 0x64];
 	__be32	devdisr;	/* 0x.0070 - Device Disable Control */
-	u8	res7[0x80 - 0x74];
+	__be32	devdisr2;	/* 0x.0074 - Device Disable Control 2 */
+	u8	res7[0x80 - 0x78];
 	__be32	powmgtcsr;	/* 0x.0080 - Power Management Status and Control Register */
 	u8	res8[0x90 - 0x84];
 	__be32	mcpsumr;	/* 0x.0090 - Machine Check Summary Register */
@@ -48,18 +49,87 @@ struct ccsr_guts {
 	__be32	svr;		/* 0x.00a4 - System Version Register */
 	u8	res10[0xB0 - 0xA8];
 	__be32	rstcr;		/* 0x.00b0 - Reset Control Register */
-	u8	res11[0xB20 - 0xB4];
-	__be32	ddr1clkdr;	/* 0x.0b20 - DDRC1 Clock Disable Register */
-	__be32	ddr2clkdr;	/* 0x.0b24 - DDRC2 Clock Disable Register */
-	u8	res12[0xE00 - 0xB28];
+	u8	res11[0xC0 - 0xB4];
+	__be32	elbcvselcr;	/* 0x.00c0 - eLBC Voltage Select Ctrl Reg */
+	u8	res12[0x800 - 0xC4];
+	__be32	clkdvdr;	/* 0x.0800 - Clock Divide Register */
+	u8	res13[0x900 - 0x804];
+	__be32	ircr;		/* 0x.0900 - Infrared Control Register */
+	u8	res14[0x908 - 0x904];
+	__be32	dmacr;		/* 0x.0908 - DMA Control Register */
+	u8	res15[0x914 - 0x90C];
+	__be32	elbccr;		/* 0x.0914 - eLBC Control Register */
+	u8	res16[0xB20 - 0x918];
+	__be32	ddr1clkdr;	/* 0x.0b20 - DDR1 Clock Disable Register */
+	__be32	ddr2clkdr;	/* 0x.0b24 - DDR2 Clock Disable Register */
+	__be32	ddrclkdr;	/* 0x.0b28 - DDR Clock Disable Register */
+	u8	res17[0xE00 - 0xB2C];
 	__be32	clkocr;		/* 0x.0e00 - Clock Out Select Register */
-	u8	res13[0xF04 - 0xE04];
+	u8	res18[0xE10 - 0xE04];
+	__be32	ddrdllcr;	/* 0x.0e10 - DDR DLL Control Register */
+	u8	res19[0xE20 - 0xE14];
+	__be32	lbcdllcr;	/* 0x.0e20 - LBC DLL Control Register */
+	u8	res20[0xF04 - 0xE24];
 	__be32	srds1cr0;	/* 0x.0f04 - SerDes1 Control Register 0 */
 	__be32	srds1cr1;	/* 0x.0f08 - SerDes1 Control Register 0 */
-	u8	res14[0xF40 - 0xF0C];
+	u8	res21[0xF40 - 0xF0C];
 	__be32	srds2cr0;	/* 0x.0f40 - SerDes1 Control Register 0 */
 	__be32	srds2cr1;	/* 0x.0f44 - SerDes1 Control Register 0 */
-};
+} __attribute__ ((packed));
+
+#define CCSR_GUTS_DMACR_DEV_SSI	0	/* DMA controller/channel set to SSI */
+#define CCSR_GUTS_DMACR_DEV_IR	1	/* DMA controller/channel set to IR */
+
+/*
+ * Set the DMACR register in the GUTS
+ *
+ * The DMACR register determines the source of initiated transfers for each
+ * channel on each DMA controller.  Rather than have a bunch of repetitive
+ * macros for the bit patterns, we just have a function that calculates
+ * them.
+ *
+ * guts: Pointer to GUTS structure
+ * co: The DMA controller (1 or 2)
+ * ch: The channel on the DMA controller (0, 1, 2, or 3)
+ * device: The device to set as the source (CCSR_GUTS_DMACR_DEV_xx)
+ */
+static inline void guts_set_dmacr(struct ccsr_guts __iomem *guts,
+	unsigned int co, unsigned int ch, unsigned int device)
+{
+	unsigned int shift = 16 + (8 * (2 - co) + 2 * (3 - ch));
+
+	clrsetbits_be32(&guts->dmacr, 3 << shift, device << shift);
+}
+
+#define CCSR_GUTS_PMUXCR_LDPSEL		0x00010000
+#define CCSR_GUTS_PMUXCR_SSI1_MASK	0x0000C000	/* Bitmask for SSI1 */
+#define CCSR_GUTS_PMUXCR_SSI1_LA	0x00000000	/* Latched address */
+#define CCSR_GUTS_PMUXCR_SSI1_HI	0x00004000	/* High impedance */
+#define CCSR_GUTS_PMUXCR_SSI1_SSI	0x00008000	/* Used for SSI1 */
+#define CCSR_GUTS_PMUXCR_SSI2_MASK	0x00003000	/* Bitmask for SSI2 */
+#define CCSR_GUTS_PMUXCR_SSI2_LA	0x00000000	/* Latched address */
+#define CCSR_GUTS_PMUXCR_SSI2_HI	0x00001000	/* High impedance */
+#define CCSR_GUTS_PMUXCR_SSI2_SSI	0x00002000	/* Used for SSI2 */
+#define CCSR_GUTS_PMUXCR_LA_22_25_LA	0x00000000	/* Latched Address */
+#define CCSR_GUTS_PMUXCR_LA_22_25_HI	0x00000400	/* High impedance */
+#define CCSR_GUTS_PMUXCR_DBGDRV		0x00000200	/* Signals not driven */
+#define CCSR_GUTS_PMUXCR_DMA2_0		0x00000008
+#define CCSR_GUTS_PMUXCR_DMA2_3		0x00000004
+#define CCSR_GUTS_PMUXCR_DMA1_0		0x00000002
+#define CCSR_GUTS_PMUXCR_DMA1_3		0x00000001
+
+#define CCSR_GUTS_CLKDVDR_PXCKEN	0x80000000
+#define CCSR_GUTS_CLKDVDR_SSICKEN	0x20000000
+#define CCSR_GUTS_CLKDVDR_PXCKINV	0x10000000
+#define CCSR_GUTS_CLKDVDR_PXCKDLY_SHIFT 25
+#define CCSR_GUTS_CLKDVDR_PXCKDLY_MASK	0x06000000
+#define CCSR_GUTS_CLKDVDR_PXCKDLY(x) \
+	(((x) & 3) << CCSR_GUTS_CLKDVDR_PXCKDLY_SHIFT)
+#define CCSR_GUTS_CLKDVDR_PXCLK_SHIFT	16
+#define CCSR_GUTS_CLKDVDR_PXCLK_MASK	0x001F0000
+#define CCSR_GUTS_CLKDVDR_PXCLK(x) (((x) & 31) << CCSR_GUTS_CLKDVDR_PXCLK_SHIFT)
+#define CCSR_GUTS_CLKDVDR_SSICLK_MASK	0x000000FF
+#define CCSR_GUTS_CLKDVDR_SSICLK(x) ((x) & CCSR_GUTS_CLKDVDR_SSICLK_MASK)
 
 #endif /* __ASM_POWERPC_IMMAP_86XX_H__ */
 #endif /* __KERNEL__ */
-- 
1.5.2.4

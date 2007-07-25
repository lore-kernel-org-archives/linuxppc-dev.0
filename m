Return-Path: <b04825@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7D9C1DDEBF
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 03:30:46 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l6PHUafI023520
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2007 10:30:36 -0700 (MST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] POWERPC: Fix definition of global-utilites structure for 86xx
Date: Wed, 25 Jul 2007 12:30:33 -0500
Message-Id: <11853846332917-git-send-email-timur@freescale.com>
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The current definition of struct ccsr_guts in immap_86xx.h was for 85xx.
This patch fixes that and replaces the vague integer types with sized types
of the correct endianness.  The unused struct ccsr_pci is also deleted.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 include/asm-powerpc/immap_86xx.h |  151 ++++++++++++--------------------------
 1 files changed, 46 insertions(+), 105 deletions(-)

diff --git a/include/asm-powerpc/immap_86xx.h b/include/asm-powerpc/immap_86xx.h
index 59b9e07..c83d7ad 100644
--- a/include/asm-powerpc/immap_86xx.h
+++ b/include/asm-powerpc/immap_86xx.h
@@ -1,124 +1,65 @@
-/*
+/**
  * MPC86xx Internal Memory Map
  *
- * Author: Jeff Brown
+ * Authors: Jeff Brown
+ *          Timur Tabi <timur@freescale.com>
  *
- * Copyright 2004 Freescale Semiconductor, Inc
+ * Copyright 2004,2007 Freescale Semiconductor, Inc
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
  * Free Software Foundation;  either version 2 of the  License, or (at your
  * option) any later version.
  *
+ * This header file defines structures for various 86xx SOC devices that are
+ * used by multiple source files.
  */
 
 #ifndef __ASM_POWERPC_IMMAP_86XX_H__
 #define __ASM_POWERPC_IMMAP_86XX_H__
 #ifdef __KERNEL__
 
-/* Eventually this should define all the IO block registers in 86xx */
-
-/* PCI Registers */
-typedef struct ccsr_pci {
-	uint	cfg_addr;	/* 0x.000 - PCI Configuration Address Register */
-	uint	cfg_data;	/* 0x.004 - PCI Configuration Data Register */
-	uint	int_ack;	/* 0x.008 - PCI Interrupt Acknowledge Register */
-	char	res1[3060];
-	uint	potar0;		/* 0x.c00 - PCI Outbound Transaction Address Register 0 */
-	uint	potear0;	/* 0x.c04 - PCI Outbound Translation Extended Address Register 0 */
-	uint	powbar0;	/* 0x.c08 - PCI Outbound Window Base Address Register 0 */
-	char	res2[4];
-	uint	powar0;		/* 0x.c10 - PCI Outbound Window Attributes Register 0 */
-	char	res3[12];
-	uint	potar1;		/* 0x.c20 - PCI Outbound Transaction Address Register 1 */
-	uint	potear1;	/* 0x.c24 - PCI Outbound Translation Extended Address Register 1 */
-	uint	powbar1;	/* 0x.c28 - PCI Outbound Window Base Address Register 1 */
-	char	res4[4];
-	uint	powar1;		/* 0x.c30 - PCI Outbound Window Attributes Register 1 */
-	char	res5[12];
-	uint	potar2;		/* 0x.c40 - PCI Outbound Transaction Address Register 2 */
-	uint	potear2;	/* 0x.c44 - PCI Outbound Translation Extended Address Register 2 */
-	uint	powbar2;	/* 0x.c48 - PCI Outbound Window Base Address Register 2 */
-	char	res6[4];
-	uint	powar2;		/* 0x.c50 - PCI Outbound Window Attributes Register 2 */
-	char	res7[12];
-	uint	potar3;		/* 0x.c60 - PCI Outbound Transaction Address Register 3 */
-	uint	potear3;	/* 0x.c64 - PCI Outbound Translation Extended Address Register 3 */
-	uint	powbar3;	/* 0x.c68 - PCI Outbound Window Base Address Register 3 */
-	char	res8[4];
-	uint	powar3;		/* 0x.c70 - PCI Outbound Window Attributes Register 3 */
-	char	res9[12];
-	uint	potar4;		/* 0x.c80 - PCI Outbound Transaction Address Register 4 */
-	uint	potear4;	/* 0x.c84 - PCI Outbound Translation Extended Address Register 4 */
-	uint	powbar4;	/* 0x.c88 - PCI Outbound Window Base Address Register 4 */
-	char	res10[4];
-	uint	powar4;		/* 0x.c90 - PCI Outbound Window Attributes Register 4 */
-	char	res11[268];
-	uint	pitar3;		/* 0x.da0 - PCI Inbound Translation Address Register 3  */
-	char	res12[4];
-	uint	piwbar3;	/* 0x.da8 - PCI Inbound Window Base Address Register 3 */
-	uint	piwbear3;	/* 0x.dac - PCI Inbound Window Base Extended Address Register 3 */
-	uint	piwar3;		/* 0x.db0 - PCI Inbound Window Attributes Register 3 */
-	char	res13[12];
-	uint	pitar2;		/* 0x.dc0 - PCI Inbound Translation Address Register 2  */
-	char	res14[4];
-	uint	piwbar2;	/* 0x.dc8 - PCI Inbound Window Base Address Register 2 */
-	uint	piwbear2;	/* 0x.dcc - PCI Inbound Window Base Extended Address Register 2 */
-	uint	piwar2;		/* 0x.dd0 - PCI Inbound Window Attributes Register 2 */
-	char	res15[12];
-	uint	pitar1;		/* 0x.de0 - PCI Inbound Translation Address Register 1  */
-	char	res16[4];
-	uint	piwbar1;	/* 0x.de8 - PCI Inbound Window Base Address Register 1 */
-	char	res17[4];
-	uint	piwar1;		/* 0x.df0 - PCI Inbound Window Attributes Register 1 */
-	char	res18[12];
-	uint	err_dr;		/* 0x.e00 - PCI Error Detect Register */
-	uint	err_cap_dr;	/* 0x.e04 - PCI Error Capture Disable Register */
-	uint	err_en;		/* 0x.e08 - PCI Error Enable Register */
-	uint	err_attrib;	/* 0x.e0c - PCI Error Attributes Capture Register */
-	uint	err_addr;	/* 0x.e10 - PCI Error Address Capture Register */
-	uint	err_ext_addr;	/* 0x.e14 - PCI Error Extended Address Capture Register */
-	uint	err_dl;		/* 0x.e18 - PCI Error Data Low Capture Register */
-	uint	err_dh;		/* 0x.e1c - PCI Error Data High Capture Register */
-	uint	gas_timr;	/* 0x.e20 - PCI Gasket Timer Register */
-	uint	pci_timr;	/* 0x.e24 - PCI Timer Register */
-	char	res19[472];
-} ccsr_pci_t;
-
 /* Global Utility Registers */
-typedef struct ccsr_guts {
-	uint	porpllsr;	/* 0x.0000 - POR PLL Ratio Status Register */
-	uint	porbmsr;	/* 0x.0004 - POR Boot Mode Status Register */
-	uint	porimpscr;	/* 0x.0008 - POR I/O Impedance Status and Control Register */
-	uint	pordevsr;	/* 0x.000c - POR I/O Device Status Register */
-	uint	pordbgmsr;	/* 0x.0010 - POR Debug Mode Status Register */
-	char	res1[12];
-	uint	gpporcr;	/* 0x.0020 - General-Purpose POR Configuration Register */
-	char	res2[12];
-	uint	gpiocr;		/* 0x.0030 - GPIO Control Register */
-	char	res3[12];
-	uint	gpoutdr;	/* 0x.0040 - General-Purpose Output Data Register */
-	char	res4[12];
-	uint	gpindr;		/* 0x.0050 - General-Purpose Input Data Register */
-	char	res5[12];
-	uint	pmuxcr;		/* 0x.0060 - Alternate Function Signal Multiplex Control */
-	char	res6[12];
-	uint	devdisr;	/* 0x.0070 - Device Disable Control */
-	char	res7[12];
-	uint	powmgtcsr;	/* 0x.0080 - Power Management Status and Control Register */
-	char	res8[12];
-	uint	mcpsumr;	/* 0x.0090 - Machine Check Summary Register */
-	char	res9[12];
-	uint	pvr;		/* 0x.00a0 - Processor Version Register */
-	uint	svr;		/* 0x.00a4 - System Version Register */
-	char	res10[3416];
-	uint	clkocr;		/* 0x.0e00 - Clock Out Select Register */
-	char	res11[12];
-	uint	ddrdllcr;	/* 0x.0e10 - DDR DLL Control Register */
-	char	res12[12];
-	uint	lbcdllcr;	/* 0x.0e20 - LBC DLL Control Register */
-	char	res13[61916];
-} ccsr_guts_t;
+struct ccsr_guts {
+	__be32	porpllsr;	/* 0x.0000 - POR PLL Ratio Status Register */
+	__be32	porbmsr;	/* 0x.0004 - POR Boot Mode Status Register */
+	__be32	porimpscr;	/* 0x.0008 - POR I/O Impedance Status and Control Register */
+	__be32	pordevsr;	/* 0x.000c - POR I/O Device Status Register */
+	__be32	pordbgmsr;	/* 0x.0010 - POR Debug Mode Status Register */
+	u8	res1[0x20 - 0x14];
+	__be32	porcir;		/* 0x.0020 - POR Configuration Information Register */
+	u8	res2[0x30 - 0x24];
+	__be32	gpiocr;		/* 0x.0030 - GPIO Control Register */
+	u8	res3[0x40 - 0x34];
+	__be32	gpoutdr;	/* 0x.0040 - General-Purpose Output Data Register */
+	u8	res4[0x50 - 0x44];
+	__be32	gpindr;		/* 0x.0050 - General-Purpose Input Data Register */
+	u8	res5[0x60 - 0x54];
+	__be32	pmuxcr;		/* 0x.0060 - Alternate Function Signal Multiplex Control */
+	u8	res6[0x70 - 0x64];
+	__be32	devdisr;	/* 0x.0070 - Device Disable Control */
+	u8	res7[0x80 - 0x74];
+	__be32	powmgtcsr;	/* 0x.0080 - Power Management Status and Control Register */
+	u8	res8[0x90 - 0x84];
+	__be32	mcpsumr;	/* 0x.0090 - Machine Check Summary Register */
+	__be32	rstrscr;	/* 0x.0094 - Reset Request Status and Control Register */
+	u8	res9[0xA0 - 0x98];
+	__be32	pvr;		/* 0x.00a0 - Processor Version Register */
+	__be32	svr;		/* 0x.00a4 - System Version Register */
+	u8	res10[0xB0 - 0xA8];
+	__be32	rstcr;		/* 0x.00b0 - Reset Control Register */
+	u8	res11[0xB20 - 0xB4];
+	__be32	ddr1clkdr;	/* 0x.0b20 - DDRC1 Clock Disable Register */
+	__be32	ddr2clkdr;	/* 0x.0b24 - DDRC2 Clock Disable Register */
+	u8	res12[0xE00 - 0xB28];
+	__be32	clkocr;		/* 0x.0e00 - Clock Out Select Register */
+	u8	res13[0xF04 - 0xE04];
+	__be32	srds1cr0;	/* 0x.0f04 - SerDes1 Control Register 0 */
+	__be32	srds1cr1;	/* 0x.0f08 - SerDes1 Control Register 0 */
+	u8	res14[0xF40 - 0xF0C];
+	__be32	srds2cr0;	/* 0x.0f40 - SerDes1 Control Register 0 */
+	__be32	srds2cr1;	/* 0x.0f44 - SerDes1 Control Register 0 */
+};
 
 #endif /* __ASM_POWERPC_IMMAP_86XX_H__ */
 #endif /* __KERNEL__ */
-- 
1.5.2.4

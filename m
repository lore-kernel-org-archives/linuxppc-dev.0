Return-Path: <clemens.koller@anagramm.de>
Received: from moutvdomng.kundenserver.de (moutvdom.kundenserver.de
	[212.227.126.249]) by ozlabs.org (Postfix) with ESMTP id E335D67C98
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Jul 2005 20:01:52 +1000 (EST)
Message-ID: <42DCCF89.8040803@anagramm.de>
Date: Tue, 19 Jul 2005 12:01:45 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: ppcembed Mailing List <linuxppc-embedded@ozlabs.org>,
	Clemens Koller <clemens.koller@anagramm.de>
Content-Type: multipart/mixed; boundary="------------010908010106090709010301"
Subject: [PATCH] ppc32: Register definition for MPC85xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010908010106090709010301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello!

I suggest to put the register definitions into the Kernel _before_
more driver writers start using their own / different maps.

Greets,

Clemens Koller

---
Almost complete and verified register map for the MPC85xx.
Based on sources from Jason McMullan and the MPC8540 Reference Manual.

Signed-off-by: Clemens Koller <clemens.koller@anagramm.de>


--------------010908010106090709010301
Content-Type: text/plain;
 name="immap_85xx-register-update.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="immap_85xx-register-update.patch"

diff --git a/include/asm-ppc/immap_85xx.h b/include/asm-ppc/immap_85xx.h
--- a/include/asm-ppc/immap_85xx.h
+++ b/include/asm-ppc/immap_85xx.h
@@ -4,6 +4,12 @@
  * MPC85xx Internal Memory Map
  *
  * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ * changes/verification: Clemens Koller <clemens.koller@anagramm.de>
+ * based on sources from Jason McMullan and the MPC8540 Reference Manual
+ *
+ * Tags in this file:
+ * FIXME - space for improvement
+ * XXX - exceptions/typos in manual
  *
  * Copyright 2004 Freescale Semiconductor, Inc
  *
@@ -20,107 +26,1362 @@
 
 /* Eventually this should define all the IO block registers in 85xx */
 
-/* PCI Registers */
+/* Local-Access Registers and ECM Registers(0x0000-0x2000) */
+typedef struct ccsr_ccsr {
+	uint32_t	ccsrbar;	/* 0x0 - Control Configuration Status Registers Base Address Register */
+	uint8_t		res1[4];
+	uint32_t	altcbar;	/* 0x8 - Alternate Configuration Base Address Register */
+	uint8_t		res2[4];
+	uint32_t	altcar;		/* 0x10 - Alternate Configuration Attribute Register */
+	uint8_t		res3[12];
+	uint32_t	bptr;		/* 0x20 - Boot Page Translation Register */
+	uint8_t		res4[3036];
+} ccsr_ccsr_t;
+
+typedef struct ccsr_law {
+	uint8_t		res1[8];
+	uint32_t	lawbar0;	/* 0xc08 - Local Access Window 0 Base Address Register */
+	uint8_t		res5[4];
+	uint32_t	lawar0;		/* 0xc10 - Local Access Window 0 Attributes Register */
+	uint8_t		res6[20];
+	uint32_t	lawbar1;	/* 0xc28 - Local Access Window 1 Base Address Register */
+	uint8_t		res7[4];
+	uint32_t	lawar1;		/* 0xc30 - Local Access Window 1 Attributes Register */
+	uint8_t		res8[20];
+	uint32_t	lawbar2;	/* 0xc48 - Local Access Window 2 Base Address Register */
+	uint8_t		res9[4];
+	uint32_t	lawar2;		/* 0xc50 - Local Access Window 2 Attributes Register */
+	uint8_t		res10[20];
+	uint32_t	lawbar3;	/* 0xc68 - Local Access Window 3 Base Address Register */
+	uint8_t		res11[4];
+	uint32_t	lawar3;		/* 0xc70 - Local Access Window 3 Attributes Register */
+	uint8_t		res12[20];
+	uint32_t	lawbar4;	/* 0xc88 - Local Access Window 4 Base Address Register */
+	uint8_t		res13[4];
+	uint32_t	lawar4;		/* 0xc90 - Local Access Window 4 Attributes Register */
+	uint8_t		res14[20];
+	uint32_t	lawbar5;	/* 0xca8 - Local Access Window 5 Base Address Register */
+	uint8_t		res15[4];
+	uint32_t	lawar5;		/* 0xcb0 - Local Access Window 5 Attributes Register */
+	uint8_t		res16[20];
+	uint32_t	lawbar6;	/* 0xcc8 - Local Access Window 6 Base Address Register */
+	uint8_t		res17[4];
+	uint32_t	lawar6;		/* 0xcd0 - Local Access Window 6 Attributes Register */
+	uint8_t		res18[20];
+	uint32_t	lawbar7;	/* 0xce8 - Local Access Window 7 Base Address Register */
+	uint8_t		res19[4];
+	uint32_t	lawar7;		/* 0xcf0 - Local Access Window 7 Attributes Register */
+	uint8_t		res20[780];
+} ccsr_law_t;
+
+typedef struct ccsr_ecm {
+	uint32_t	eebacr;		/* 0x1000 - ECM CCB Address Configuration Register */
+	uint8_t		res21[12];
+	uint32_t	eebpcr;		/* 0x1010 - ECM CCB Port Configuration Register */
+	uint8_t		res22[3564];
+	uint32_t	eedr;		/* 0x1e00 - ECM Error Detect Register */
+	uint8_t		res23[4];
+	uint32_t	eeer;		/* 0x1e08 - ECM Error Enable Register */
+	uint32_t	eeatr;		/* 0x1e0c - ECM Error Attributes Capture Register */
+	uint32_t	eeadr;		/* 0x1e10 - ECM Error Address Capture Register */
+	uint8_t		res24[492];
+} ccsr_ecm_t;
+
+
+/* DDR memory controller registers(0x2000-0x3000) */
+typedef struct ccsr_ddr {
+	uint32_t	cs0_bnds;		/* 0x2000 - DDR Chip Select 0 Memory Bounds */
+	uint8_t		res1[4];
+	uint32_t	cs1_bnds;		/* 0x2008 - DDR Chip Select 1 Memory Bounds */
+	uint8_t		res2[4];
+	uint32_t	cs2_bnds;		/* 0x2010 - DDR Chip Select 2 Memory Bounds */
+	uint8_t		res3[4];
+	uint32_t	cs3_bnds;		/* 0x2018 - DDR Chip Select 3 Memory Bounds */
+	uint8_t		res4[100];
+	uint32_t	cs0_config;		/* 0x2080 - DDR Chip Select Configuration */
+	uint32_t	cs1_config;		/* 0x2084 - DDR Chip Select Configuration */
+	uint32_t	cs2_config;		/* 0x2088 - DDR Chip Select Configuration */
+	uint32_t	cs3_config;		/* 0x208c - DDR Chip Select Configuration */
+	uint8_t		res5[120];
+	uint32_t	timing_cfg_1;		/* 0x2108 - DDR SDRAM Timing Configuration Register 1 */
+	uint32_t	timing_cfg_2;		/* 0x210c - DDR SDRAM Timing Configuration Register 2 */
+	uint32_t	sdram_cfg;		/* 0x2110 - DDR SDRAM Control Configuration */
+	uint8_t		res6[4];
+	uint32_t	sdram_mode;		/* 0x2118 - DDR SDRAM Mode Configuration */
+	uint8_t		res7[8];
+	uint32_t	sdram_interval;		/* 0x2124 - DDR SDRAM Interval Configuration */
+	uint8_t		res8[3288];
+	uint32_t	data_err_inject_hi;	/* 0x2e00 - DDR Memory Data Path Error Injection Mask High */
+	uint32_t	data_err_inject_lo;	/* 0x2e04 - DDR Memory Data Path Error Injection Mask Low */
+	uint32_t	ecc_err_inject;		/* 0x2e08 - DDR Memory Data Path Error Injection Mask ECC */
+	uint8_t		res9[20];
+	uint32_t	capture_data_hi;	/* 0x2e20 - DDR Memory Data Path Read Capture High */
+	uint32_t	capture_data_lo;	/* 0x2e24 - DDR Memory Data Path Read Capture Low */
+	uint32_t	capture_ecc;		/* 0x2e28 - DDR Memory Data Path Read Capture ECC */
+	uint8_t		res10[20];
+	uint32_t	err_detect;		/* 0x2e40 - DDR Memory Error Detect */
+	uint32_t	err_disable;		/* 0x2e44 - DDR Memory Error Disable */
+	uint32_t	err_int_en;		/* 0x2e48 - DDR  */
+	uint32_t	capture_attributes;	/* 0x2e4c - DDR Memory Error Attributes Capture */
+	uint32_t	capture_address;	/* 0x2e50 - DDR Memory Error Address Capture */
+	uint32_t	capture_ext_address;	/* 0x2e54 - DDR Memory Error Extended Address Capture */
+	uint32_t	err_sbe;		/* 0x2e58 - DDR Memory Single-Bit ECC Error Management */
+	uint8_t		res11[164];
+	uint32_t	debug_1;		/* 0x2f00 */
+	uint32_t	debug_2;
+	uint32_t	debug_3;
+	uint32_t	debug_4;
+	uint8_t		res12[240];
+} ccsr_ddr_t;
+
+
+/* I2C Registers(0x3000-0x4000) */
+typedef struct ccsr_i2c {
+	uint8_t		i2cadr;		/* 0x3000 - I2C Address Register */
+#define MPC85xx_I2CADR_MASK	0xFE
+	uint8_t		res1[3];
+	uint8_t		i2cfdr;		/* 0x3004 - I2C Frequency Divider Register */
+#define MPC85xx_I2CFDR_MASK	0x3F
+	uint8_t		res2[3];
+	uint8_t		i2ccr;		/* 0x3008 - I2C Control Register */
+#define MPC85xx_I2CCR_MEN	0x80
+#define MPC85xx_I2CCR_MIEN	0x40
+#define MPC85xx_I2CCR_MSTA      0x20
+#define MPC85xx_I2CCR_MTX       0x10
+#define MPC85xx_I2CCR_TXAK      0x08
+#define MPC85xx_I2CCR_RSTA      0x04
+#define MPC85xx_I2CCR_BCST      0x01
+#define MPC85xx_I2CCR_MASK	0xfd
+	uint8_t		res3[3];
+	uint8_t		i2csr;		/* 0x300c - I2C Status Register */
+#define MPC85xx_I2CSR_MCF	0x80
+#define MPC85xx_I2CSR_MAAS      0x40
+#define MPC85xx_I2CSR_MBB       0x20
+#define MPC85xx_I2CSR_MAL       0x10
+#define MPC85xx_I2CSR_BCSTM     0x08
+#define MPC85xx_I2CSR_SRW       0x04
+#define MPC85xx_I2CSR_MIF       0x02
+#define MPC85xx_I2CSR_RXAK      0x01
+	uint8_t		res4[3];
+	uint8_t		i2cdr;		/* 0x3010 - I2C Data Register */
+#define MPC85xx_I2CDR_DATA	0xFF
+	uint8_t		res5[3];
+	uint8_t		i2cdfsrr;	/* 0x3014 - I2C Digital Filtering Sampling Rate Register */
+#define MPC85xx_I2CDFSRR	0x3F
+	uint8_t		res6[4075];
+} ccsr_i2c_t;
+
+#ifdef CONFIG_MPC8540
+/* DUART Registers(0x4000-0x5000) */
+typedef struct ccsr_duart {
+	uint8_t		res1[1280];
+	uint8_t		urbr1_uthr1_udlb1;/* 0x4500 - URBR1, UTHR1, UDLB1 with the same address offset of 0x04500 */
+	uint8_t		uier1_udmb1;	/* 0x4501 - UIER1, UDMB1 with the same address offset of 0x04501 */
+	uint8_t		uiir1_ufcr1_uafr1;/* 0x4502 - UIIR1, UFCR1, UAFR1 with the same address offset of 0x04502 */
+	uint8_t		ulcr1;		/* 0x4503 - UART1 Line Control Register */
+	uint8_t		umcr1;		/* 0x4504 - UART1 Modem Control Register */
+	uint8_t		ulsr1;		/* 0x4505 - UART1 Line Status Register */
+	uint8_t		umsr1;		/* 0x4506 - UART1 Modem Status Register */
+	uint8_t		uscr1;		/* 0x4507 - UART1 Scratch Register */
+	uint8_t		res2[8];
+	uint8_t		udsr1;		/* 0x4510 - UART1 DMA Status Register */
+	uint8_t		res3[239];
+	uint8_t		urbr2_uthr2_udlb2;/* 0x4600 - URBR2, UTHR2, UDLB2 with the same address offset of 0x04600 */
+	uint8_t		uier2_udmb2;	/* 0x4601 - UIER2, UDMB2 with the same address offset of 0x04601 */
+	uint8_t		uiir2_ufcr2_uafr2;/* 0x4602 - UIIR2, UFCR2, UAFR2 with the same address offset of 0x04602 */
+	uint8_t		ulcr2;		/* 0x4603 - UART2 Line Control Register */
+	uint8_t		umcr2;		/* 0x4604 - UART2 Modem Control Register */
+	uint8_t		ulsr2;		/* 0x4605 - UART2 Line Status Register */
+	uint8_t		umsr2;		/* 0x4606 - UART2 Modem Status Register */
+	uint8_t		uscr2;		/* 0x4607 - UART2 Scratch Register */
+	uint8_t		res4[8];
+	uint8_t		udsr2;		/* 0x4610 - UART2 DMA Status Register */
+	uint8_t		res5[2543];
+} ccsr_duart_t;
+#else /* MPC8560 uses UART on its CPM */
+typedef struct ccsr_duart {
+	uint8_t res[4096];
+} ccsr_duart_t;
+#endif
+
+/* Local Bus Controller Registers(0x5000-0x6000) */
+/* Omitting OCeaN(0x6000) and Reserved(0x7000) block */
+typedef struct ccsr_lbc {
+	uint32_t	br0;		/* 0x5000 - LBC Base Register 0 */
+	uint32_t	or0;		/* 0x5004 - LBC Options Register 0 */
+	uint32_t	br1;		/* 0x5008 - LBC Base Register 1 */
+	uint32_t	or1;		/* 0x500c - LBC Options Register 1 */
+	uint32_t	br2;		/* 0x5010 - LBC Base Register 2 */
+	uint32_t	or2;		/* 0x5014 - LBC Options Register 2 */
+	uint32_t	br3;		/* 0x5018 - LBC Base Register 3 */
+	uint32_t	or3;		/* 0x501c - LBC Options Register 3 */
+	uint32_t	br4;		/* 0x5020 - LBC Base Register 4 */
+	uint32_t	or4;		/* 0x5024 - LBC Options Register 4 */
+	uint32_t	br5;		/* 0x5028 - LBC Base Register 5 */
+	uint32_t	or5;		/* 0x502c - LBC Options Register 5 */
+	uint32_t	br6;		/* 0x5030 - LBC Base Register 6 */
+	uint32_t	or6;		/* 0x5034 - LBC Options Register 6 */
+	uint32_t	br7;		/* 0x5038 - LBC Base Register 7 */
+	uint32_t	or7;		/* 0x503c - LBC Options Register 7 */
+	uint8_t		res1[40];
+	uint32_t	mar;		/* 0x5068 - LBC UPM Address Register */
+	uint8_t		res2[4];
+	uint32_t	mamr;		/* 0x5070 - LBC UPMA Mode Register */
+	uint32_t	mbmr;		/* 0x5074 - LBC UPMB Mode Register */
+	uint32_t	mcmr;		/* 0x5078 - LBC UPMC Mode Register */
+	uint8_t		res3[8];
+	uint32_t	mrtpr;		/* 0x5084 - LBC Memory Refresh Timer Prescaler Register */
+	uint32_t	mdr;		/* 0x5088 - LBC UPM Data Register */
+	uint8_t		res4[8];
+	uint32_t	lsdmr;		/* 0x5094 - LBC SDRAM Mode Register */
+	uint8_t		res5[8];
+	uint32_t	lurt;		/* 0x50a0 - LBC UPM Refresh Timer */
+	uint32_t	lsrt;		/* 0x50a4 - LBC SDRAM Refresh Timer */
+	uint8_t		res6[8];
+	uint32_t	ltesr;		/* 0x50b0 - LBC Transfer Error Status Register */
+	uint32_t	ltedr;		/* 0x50b4 - LBC Transfer Error Disable Register */
+	uint32_t	lteir;		/* 0x50b8 - LBC Transfer Error Interrupt Register */
+	uint32_t	lteatr;		/* 0x50bc - LBC Transfer Error Attributes Register */
+	uint32_t	ltear;		/* 0x50c0 - LBC Transfer Error Address Register */
+	uint8_t		res7[12];
+	uint32_t	lbcr;		/* 0x50d0 - LBC Configuration Register */
+	uint32_t	lcrr;		/* 0x50d4 - LBC Clock Ratio Register */
+	uint8_t		res8[12072];
+} ccsr_lbc_t;
+
+/* PCI Registers(0x8000-0x9000) */
+/* Omitting Reserved(0x9000-0x2_0000) */
 typedef struct ccsr_pci {
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
+	uint32_t	cfg_addr;	/* 0x8000 - PCIX Configuration Address Register */
+	uint32_t	cfg_data;	/* 0x8004 - PCIX Configuration Data Register */
+	uint32_t	int_ack;	/* 0x8008 - PCIX Interrupt Acknowledge Register */
+	uint8_t		res1[3060];
+	uint32_t	potar0;		/* 0x8c00 - PCIX Outbound Transaction Address Register 0 */
+	uint32_t	potear0;	/* 0x8c04 - PCIX Outbound Translation Extended Address Register 0 */
+	uint32_t	powbar0;	/* 0x8c08 - PCIX Outbound Window Base Address Register 0 */
+	uint32_t	powbear0;	/* 0x8c0c - PCIX Outbound Window Base Extended Address Register 0 */
+	uint32_t	powar0;		/* 0x8c10 - PCIX Outbound Window Attributes Register 0 */
+	uint8_t		res2[12];
+	uint32_t	potar1;		/* 0x8c20 - PCIX Outbound Transaction Address Register 1 */
+	uint32_t	potear1;	/* 0x8c24 - PCIX Outbound Translation Extended Address Register 1 */
+	uint32_t	powbar1;	/* 0x8c28 - PCIX Outbound Window Base Address Register 1 */
+	uint32_t	powbear1;	/* 0x8c2c - PCIX Outbound Window Base Extended Address Register 1 */
+	uint32_t	powar1;		/* 0x8c30 - PCIX Outbound Window Attributes Register 1 */
+	uint8_t		res3[12];
+	uint32_t	potar2;		/* 0x8c40 - PCIX Outbound Transaction Address Register 2 */
+	uint32_t	potear2;	/* 0x8c44 - PCIX Outbound Translation Extended Address Register 2 */
+	uint32_t	powbar2;	/* 0x8c48 - PCIX Outbound Window Base Address Register 2 */
+	uint32_t	powbear2;	/* 0x8c4c - PCIX Outbound Window Base Extended Address Register 2 */
+	uint32_t	powar2;		/* 0x8c50 - PCIX Outbound Window Attributes Register 2 */
+	uint8_t		res4[12];
+	uint32_t	potar3;		/* 0x8c60 - PCIX Outbound Transaction Address Register 3 */
+	uint32_t	potear3;	/* 0x8c64 - PCIX Outbound Translation Extended Address Register 3 */
+	uint32_t	powbar3;	/* 0x8c68 - PCIX Outbound Window Base Address Register 3 */
+	uint32_t	powbear3;	/* 0x8c6c - PCIX Outbound Window Base Extended Address Register 3 */
+	uint32_t	powar3;		/* 0x8c70 - PCIX Outbound Window Attributes Register 3 */
+	uint8_t		res5[12];
+	uint32_t	potar4;		/* 0x8c80 - PCIX Outbound Transaction Address Register 4 */
+	uint32_t	potear4;	/* 0x8c84 - PCIX Outbound Translation Extended Address Register 4 */
+	uint32_t	powbar4;	/* 0x8c88 - PCIX Outbound Window Base Address Register 4 */
+	uint32_t	powbear4;	/* 0x8c8c - PCIX Outbound Window Base Extended Address Register 4 */
+	uint32_t	powar4;		/* 0x8c90 - PCIX Outbound Window Attributes Register 4 */
+	uint8_t		res6[268];
+	uint32_t	pitar3;		/* 0x8da0 - PCIX Inbound Translation Address Register 3  */
+	uint32_t	pitear3;	/* 0x8da4 - PCIX Inbound Translation Extended Address Register 3 */
+	uint32_t	piwbar3;	/* 0x8da8 - PCIX Inbound Window Base Address Register 3 */
+	uint32_t	piwbear3;	/* 0x8dac - PCIX Inbound Window Base Extended Address Register 3 */
+	uint32_t	piwar3;		/* 0x8db0 - PCIX Inbound Window Attributes Register 3 */
+	uint8_t		res7[12];
+	uint32_t	pitar2;		/* 0x8dc0 - PCIX Inbound Translation Address Register 2  */
+	uint32_t	pitear2;	/* 0x8dc4 - PCIX Inbound Translation Extended Address Register 2 */
+	uint32_t	piwbar2;	/* 0x8dc8 - PCIX Inbound Window Base Address Register 2 */
+	uint32_t	piwbear2;	/* 0x8dcc - PCIX Inbound Window Base Extended Address Register 2 */
+	uint32_t	piwar2;		/* 0x8dd0 - PCIX Inbound Window Attributes Register 2 */
+	uint8_t		res8[12];
+	uint32_t	pitar1;		/* 0x8de0 - PCIX Inbound Translation Address Register 1  */
+	uint32_t	pitear1;	/* 0x8de4 - PCIX Inbound Translation Extended Address Register 1 */
+	uint32_t	piwbar1;	/* 0x8de8 - PCIX Inbound Window Base Address Register 1 */
+	uint8_t		res9[4];
+	uint32_t	piwar1;		/* 0x8df0 - PCIX Inbound Window Attributes Register 1 */
+	uint8_t		res10[12];
+	uint32_t	pedr;		/* 0x8e00 - PCIX Error Detect Register */
+	uint32_t	pecdr;		/* 0x8e04 - PCIX Error Capture Disable Register */
+	uint32_t	peer;		/* 0x8e08 - PCIX Error Enable Register */
+	uint32_t	peattrcr;	/* 0x8e0c - PCIX Error Attributes Capture Register */
+	uint32_t	peaddrcr;	/* 0x8e10 - PCIX Error Address Capture Register */
+	uint32_t	peextaddrcr;	/* 0x8e14 - PCIX  Error Extended Address Capture Register */
+	uint32_t	pedlcr;		/* 0x8e18 - PCIX Error Data Low Capture Register */
+	uint32_t	pedhcr;		/* 0x8e1c - PCIX Error Error Data High Capture Register */
+	uint8_t		res11[94688];
 } ccsr_pci_t;
 
-/* Global Utility Registers */
+/* L2 Cache Registers(0x2_0000-0x2_1000) */
+typedef struct ccsr_l2cache {
+	uint32_t	l2ctl;		/* 0x20000 - L2 configuration register 0 */
+	uint8_t		res1[12];
+	uint32_t	l2cewar0;	/* 0x20010 - L2 cache external write address register 0 */
+	uint8_t		res2[4];
+	uint32_t	l2cewcr0;	/* 0x20018 - L2 cache external write control register 0 */
+	uint8_t		res3[4];
+	uint32_t	l2cewar1;	/* 0x20020 - L2 cache external write address register 1 */
+	uint8_t		res4[4];
+	uint32_t	l2cewcr1;	/* 0x20028 - L2 cache external write control register 1 */
+	uint8_t		res5[4];
+	uint32_t	l2cewar2;	/* 0x20030 - L2 cache external write address register 2 */
+	uint8_t		res6[4];
+	uint32_t	l2cewcr2;	/* 0x20038 - L2 cache external write control register 2 */
+	uint8_t		res7[4];
+	uint32_t	l2cewar3;	/* 0x20040 - L2 cache external write address register 3 */
+	uint8_t		res8[4];
+	uint32_t	l2cewcr3;	/* 0x20048 - L2 cache external write control register 3 */
+	uint8_t		res9[180];
+	uint32_t	l2srbar0;	/* 0x20100 - L2 memory-mapped SRAM base address register 0 */
+	uint8_t		res10[4];
+	uint32_t	l2srbar1;	/* 0x20108 - L2 memory-mapped SRAM base address register 1 */
+	uint8_t		res11[3316];
+	uint32_t	l2errinjhi;	/* 0x20e00 - L2 error injection mask high register */
+	uint32_t	l2errinjlo;	/* 0x20e04 - L2 error injection mask low register */
+	uint32_t	l2errinjctl;	/* 0x20e08 - L2 error injection tag/ECC control register */
+	uint8_t		res12[20];
+	uint32_t	l2captdatahi;	/* 0x20e20 - L2 error data high capture register */
+	uint32_t	l2captdatalo;	/* 0x20e24 - L2 error data low capture register */
+	uint32_t	l2captecc;	/* 0x20e28 - L2 error ECC capture register */
+	uint8_t		res13[20];
+	uint32_t	l2errdet;	/* 0x20e40 - L2 error detect register */
+	uint32_t	l2errdis;	/* 0x20e44 - L2 error disable register */
+	uint32_t	l2errinten;	/* 0x20e48 - L2 error interrupt enable register */
+	uint32_t	l2errattr;	/* 0x20e4c - L2 error attributes capture register */
+	uint32_t	l2erraddr;	/* 0x20e50 - L2 error address capture register */
+	uint8_t		res14[4];
+	uint32_t	l2errctl;	/* 0x20e58 - L2 error control register */
+	uint8_t		res15[420];
+} ccsr_l2cache_t;
+
+
+/* DMA Registers(0x2_1000-0x2_2000) */
+typedef struct ccsr_dma {
+	uint8_t		res1[256];
+
+						/* 0x21100 - DMA */
+	struct {
+		uint32_t	mr;		/* 0x00 - DMA 0 Mode Register */
+#define MPC85xx_MR_BWC_MASK	(0xf << 24)	/* Bandwidth control */
+#  define MPC85xx_MR_BWC_1	((0) << 24)
+#  define MPC85xx_MR_BWC_2	((1) << 24)
+#  define MPC85xx_MR_BWC_4	((2) << 24)
+#  define MPC85xx_MR_BWC_8	((3) << 24)
+#  define MPC85xx_MR_BWC_16	((4) << 24)
+#  define MPC85xx_MR_BWC_32	((5) << 24)
+#  define MPC85xx_MR_BWC_64	((6) << 24)
+#  define MPC85xx_MR_BWC_128	((7) << 24)
+#  define MPC85xx_MR_BWC_256	((8) << 24)
+#  define MPC85xx_MR_BWC_512	((9) << 24)
+#define MPC85xx_MR_EMP_EN	(1 << 21)	/* External Master Pause En */
+#define MPC85xx_MR_EMS_EN	(1 << 18)	/* External Master Start En */
+#define MPC85xx_MR_DAHTS_MASK	(3 << 16)	/* Dest Hold addr size */
+#  define MPC85xx_MR_DAHTS_1	(0 << 16)
+#  define MPC85xx_MR_DAHTS_2	(1 << 16)
+#  define MPC85xx_MR_DAHTS_4	(2 << 16)
+#  define MPC85xx_MR_DAHTS_8	(3 << 16)
+#define MPC85xx_MR_SAHTS_MASK	(3 << 14)	/* Src Hold addr size */
+#  define MPC85xx_MR_SAHTS_1	(0 << 14)
+#  define MPC85xx_MR_SAHTS_2	(1 << 14)
+#  define MPC85xx_MR_SAHTS_4	(2 << 14)
+#  define MPC85xx_MR_SAHTS_8	(3 << 14)
+#define MPC85xx_MR_DAHE		(1 << 13)	/* Destination Hold Enable */
+#define MPC85xx_MR_SAHE		(1 << 12)	/* Source Hold Enable */
+#define MPC85xx_MR_SRW		(1 << 10)	/* Single register write */
+#define MPC85xx_MR_EOSIE	(1 << 9)	/* End-of-segments interrupt */
+#define MPC85xx_MR_EOLNIE	(1 << 8)	/* End-of-links interrupt */
+#define MPC85xx_MR_EOLSIE	(1 << 7)	/* End-of-lists interrupt */
+#define MPC85xx_MR_PEIE		(1 << 6)	/* Prog. error interrupt */
+#define MPC85xx_MR_XFE		(1 << 5)	/* Enable new chain mode */
+#define MPC85xx_MR_CDSM		(1 << 4)	/* Immediate DMA start */
+#define MPC85xx_MR_SWSM		(1 << 4)	/* Immediate DMA start */
+#define MPC85xx_MR_CA		(1 << 3)	/* Channel Abort */
+#define MPC85xx_MR_CTM		(1 << 2)	/* Chain Mode (0) or Direct (1) */
+#define MPC85xx_MR_CC		(1 << 1)	/* Channel continue */
+#define MPC85xx_MR_CS		(1 << 0)	/* Channel start */
+		uint32_t	sr;		/* 0x04 - DMA 0 Status Register */
+#define MPC85xx_SR_TE		(1 << 7)	/* Transfer Error */
+#define MPC85xx_SR_CH		(1 << 5)	/* Channel Halted */
+#define MPC85xx_SR_PEI		(1 << 4)	/* Programming Error */
+#define MPC85xx_SR_EOLNI	(1 << 3)	/* End-of-links interrupt */
+#define MPC85xx_SR_CB		(1 << 2)	/* Channel Busy */
+#define MPC85xx_SR_EOSI		(1 << 1)	/* End-of-segment interrupt */
+#define MPC85xx_SR_EOLSI	(1 << 0)	/* End-of-list interrupt */
+		uint8_t		res2[4];
+		uint32_t	clndar;		/* 0x2110c - DMA 0 Current Link Descriptor Address Register */
+#define MPC85xx_CLNDAR_EOSIE	(1 << 3)	/* End-of-segment interrupt */
+		uint32_t	satr;		/* 0x10 - DMA 0 Source Attributes Register */
+#define MPC85xx_SATR_ESAD_MASK	(0x3ff)
+#define MPC85xx_SATR_SREADTYPE_R_IO_READ_HOME	(0x2 << 16)
+#define MPC85xx_SATR_SREADTYPE_R_NREAD		(0x4 << 16)
+#define MPC85xx_SATR_SREADTYPE_R_MAINTENANCE	(0x7 << 16)
+
+#define MPC85xx_SATR_SREADTYPE_L_NO_SNOOP	(0x4 << 16)
+#define MPC85xx_SATR_SREADTYPE_L_SNOOP		(0x5 << 16)
+#define MPC85xx_SATR_SREADTYPE_L_L2_UNLOCK	(0x7 << 16)
+
+#define MPC85xx_SATR_STRANSINT_RAPIDIO		(0x6 << 20)
+
+#define MPC85xx_SATR_SSME			(1 << 24)
+#define MPC85xx_SATR_SPCI_ORDER			(1 << 25)
+#define MPC85xx_SATR_STFLOWLVL_LOW		(0 << 26)
+#define MPC85xx_SATR_STFLOWLVL_MED		(1 << 26)
+#define MPC85xx_SATR_STFLOWLVL_HI		(2 << 26)
+#define MPC85xx_SATR_SBPATMU			(1 << 29)
+		uint32_t	sar;		/* 0x14 - DMA 0 Source Address Register */
+		uint32_t	datr;		/* 0x18 - DMA 0 Destination Attributes Register */
+#define MPC85xx_DATR_EDAD_MASK	(0x3ff)
+#define MPC85xx_DATR_DWRITETYPE_R_FLUSH		(0x1 << 16)
+#define MPC85xx_DATR_DWRITETYPE_R_SWRITE	(0x3 << 16)
+#define MPC85xx_DATR_DWRITETYPE_R_NWRITE	(0x4 << 16)
+#define MPC85xx_DATR_DWRITETYPE_R_NWRITE_R	(0x5 << 16)
+#define MPC85xx_DATR_DWRITETYPE_R_MESSAGE	(0x6 << 16)
+#define MPC85xx_DATR_DWRITETYPE_R_MAINTENANCE	(0x7 << 16)
+
+#define MPC85xx_DATR_DWRITETYPE_L_NO_SNOOP	(0x4 << 16)
+#define MPC85xx_DATR_DWRITETYPE_L_SNOOP		(0x5 << 16)
+#define MPC85xx_DATR_DWRITETYPE_L_L2		(0x6 << 16)
+#define MPC85xx_DATR_DWRITETYPE_L_L2_LOCK	(0x7 << 16)
+
+#define MPC85xx_DATR_DTRANSINT_RAPIDIO		(0x6 << 20)
+
+#define MPC85xx_DATR_DSME			(1 << 24)
+#define MPC85xx_DATR_DPCI_ORDER			(1 << 25)
+#define MPC85xx_DATR_DTFLOWLVL_LOW		(0 << 26)
+#define MPC85xx_DATR_DTFLOWLVL_MED		(1 << 26)
+#define MPC85xx_DATR_DTFLOWLVL_HI		(2 << 26)
+#define MPC85xx_DATR_DBPATMU			(1 << 29)
+		uint32_t	dar;		/* 0x1c - DMA 0 Destination Address Register */
+		uint32_t	bcr;		/* 0x20 - DMA 0 Byte Count Register */
+#define MPC85xx_BCR_MASK	0x0cffffff
+		uint8_t		res3[4];
+		uint32_t	nlndar;		/* 0x28 - DMA 0 Next Link Descriptor Address Register */
+#define MPC85xx_NLNDAR_MASK	0xffffffe0
+#define MPC85xx_NLNDAR_NDEOSIE	(1 << 3)	/* Next descriptor end-of-segment interrupt enable */
+#define MPC85xx_NLNDAR_EOLND	(1 << 0)	/* End of links */
+		uint8_t		res4[8];
+/* XXX the MPC8540 reference maual says that this is the clsdar register, but the
+ * following name is from Jason McMullan's version: */
+		uint32_t	clabdar;	/* 0x34 - DMA 0 Current List - Alternate Base Descriptor Address Register */
+		uint8_t		res5[4];
+		uint32_t	nlsdar;		/* 0x3c - DMA 0 Next List Descriptor Address Register */
+		uint32_t	ssr;		/* 0x40 - DMA 0 Source Stride Register */
+		uint32_t	dsr;		/* 0x44 - DMA 0 Destination Stride Register */
+		uint8_t		res6[56];
+	} dma[4];
+	uint32_t	dgsr;			/* 0x21300 - DMA General Status Register */
+	uint8_t		res7[11516];
+} ccsr_dma_t;
+
+/* TSEC1 0x2_4000-0x2_5000 */
+/* TSEC2 0x2_5000-0x2_6000 (hint: add 0x1000 to the register addresses below :-)*/
+typedef struct ccsr_tsec {
+	uint8_t		res1[16];
+	uint32_t	ievent;		/* 0x24010 - Interrupt Event Register */
+	uint32_t	imask;		/* 0x24014 - Interrupt Mask Register */
+	uint32_t	edis;		/* 0x24018 - Error Disabled Register */
+	uint8_t		res2[4];
+	uint32_t	ecntrl;		/* 0x24020 - Ethernet Control Register */
+	uint32_t	minflr;		/* 0x24024 - Minimum Frame Length Register */
+	uint32_t	ptv;		/* 0x24028 - Pause Time Value Register */
+	uint32_t	dmactrl;	/* 0x2402c - DMA Control Register */
+	uint32_t	tbipa;		/* 0x24030 - TBI PHY Address Register */
+	uint8_t		res3[24];
+	uint32_t	fifo_pause_ctrl;	/* 0x2404c - FIFO pause control register */
+	uint8_t		res3b[60];
+	uint32_t	fifo_tx_thr;		/* 0x2408c - FIFO transmit threshold register */
+	uint8_t		res4[8];
+	uint32_t	fifo_tx_starve;		/* 0x24098 - FIFO transmit starve register */
+	uint32_t	fifo_tx_starve_shutoff;	/* 0x2409c - FIFO transmit starve shutoff register */
+	uint8_t		res5[96];
+	uint32_t	tctrl;		/* 0x24100 - Transmit Control Register */
+	uint32_t	tstat;		/* 0x24104 - Transmit Status Register */
+	uint8_t		res6[4];
+	uint32_t	tbdlen;		/* 0x2410c - Transmit Buffer Descriptor Data Length Register */
+	uint8_t		res7[16];
+	uint32_t	ctbptrh;	/* 0x24120 - Current Transmit Buffer Descriptor Pointer High Register */
+	uint32_t	ctbptr;		/* 0x24124 - Current Transmit Buffer Descriptor Pointer Register */
+	uint8_t		res8[88];
+	uint32_t	tbptrh;		/* 0x24180 - Transmit Buffer Descriptor Pointer High Register */
+	uint32_t	tbptr;		/* 0x24184 - Transmit Buffer Descriptor Pointer Low Register */
+	uint8_t		res9[120];
+	uint32_t	tbaseh;		/* 0x24200 - Transmit Descriptor Base Address High Register */
+	uint32_t	tbase;		/* 0x24204 - Transmit Descriptor Base Address Register */
+	uint8_t		res10[168];
+	uint32_t	ostbd;		/* 0x242b0 - Out-of-Sequence Transmit Buffer Descriptor Register */
+	uint32_t	ostbdp;		/* 0x242b4 - Out-of-Sequence Transmit Data Buffer Pointer Register */
+	uint32_t	os32tbdp;	/* 0x242b8 - Out-of-Sequence 32 Bytes Transmit Data Buffer Pointer Low Register */
+	uint32_t	os32iptrh;	/* 0x242bc - Out-of-Sequence 32 Bytes Transmit Insert Pointer High Register */
+	uint32_t	os32iptrl;	/* 0x242c0 - Out-of-Sequence 32 Bytes Transmit Insert Pointer Low Register */
+	uint32_t	os32tbdr;	/* 0x242c4 - Out-of-Sequence 32 Bytes Transmit Reserved Register */
+	uint32_t	os32iil;	/* 0x242c8 - Out-of-Sequence 32 Bytes Transmit Insert Index/Length Register */
+	uint8_t		res11[52];
+	uint32_t	rctrl;		/* 0x24300 - Receive Control Register */
+	uint32_t	rstat;		/* 0x24304 - Receive Status Register */
+	uint8_t		res12[4];
+	uint32_t	rbdlen;		/* 0x2430c - RxBD Data Length Register */
+	uint8_t		res13[16];
+	uint32_t	crbptrh;	/* 0x24320 - Current Receive Buffer Descriptor Pointer High */
+	uint32_t	crbptr;		/* 0x24324 - Current Receive Buffer Descriptor Pointer */
+	uint8_t		res14[24];
+	uint32_t	mrblr;		/* 0x24340 - Maximum Receive Buffer Length Register */
+	uint32_t	mrblr2r3;	/* 0x24344 - Maximum Receive Buffer Length R2R3 Register */
+	uint8_t		res15[56];
+	uint32_t	rbptrh;		/* 0x24380 - Receive Buffer Descriptor Pointer High 0 */
+	uint32_t	rbptr;		/* 0x24384 - Receive Buffer Descriptor Pointer */
+	uint32_t	rbptrh1;	/* 0x24388 - Receive Buffer Descriptor Pointer High 1 */
+	uint32_t	rbptrl1;	/* 0x2438c - Receive Buffer Descriptor Pointer Low 1 */
+	uint32_t	rbptrh2;	/* 0x24390 - Receive Buffer Descriptor Pointer High 2 */
+	uint32_t	rbptrl2;	/* 0x24394 - Receive Buffer Descriptor Pointer Low 2 */
+	uint32_t	rbptrh3;	/* 0x24398 - Receive Buffer Descriptor Pointer High 3 */
+	uint32_t	rbptrl3;	/* 0x2439c - Receive Buffer Descriptor Pointer Low 3 */
+	uint8_t		res16[96];
+	uint32_t	rbaseh;		/* 0x24400 - Receive Descriptor Base Address High 0 */
+	uint32_t	rbase;		/* 0x24404 - Receive Descriptor Base Address */
+	uint32_t	rbaseh1;	/* 0x24408 - Receive Descriptor Base Address High 1 */
+	uint32_t	rbasel1;	/* 0x2440c - Receive Descriptor Base Address Low 1 */
+	uint32_t	rbaseh2;	/* 0x24410 - Receive Descriptor Base Address High 2 */
+	uint32_t	rbasel2;	/* 0x24414 - Receive Descriptor Base Address Low 2 */
+	uint32_t	rbaseh3;	/* 0x24418 - Receive Descriptor Base Address High 3 */
+	uint32_t	rbasel3;	/* 0x2441c - Receive Descriptor Base Address Low 3 */
+	uint8_t		res17[224];
+	uint32_t	maccfg1;	/* 0x24500 - MAC Configuration 1 Register */
+	uint32_t	maccfg2;	/* 0x24504 - MAC Configuration 2 Register */
+	uint32_t	ipgifg;		/* 0x24508 - Inter Packet Gap/Inter Frame Gap Register */
+	uint32_t	hafdup;		/* 0x2450c - Half Duplex Register */
+	uint32_t	maxfrm;		/* 0x24510 - Maximum Frame Length Register */
+	uint8_t		res18[12];
+	uint32_t	miimcfg;	/* 0x24520 - MII Management Configuration Register */
+	uint32_t	miimcom;	/* 0x24524 - MII Management Command Register */
+	uint32_t	miimadd;	/* 0x24528 - MII Management Address Register */
+	uint32_t	miimcon;	/* 0x2452c - MII Management Control Register */
+	uint32_t	miimstat;	/* 0x24530 - MII Management Status Register */
+	uint32_t	miimind;	/* 0x24534 - MII Management Indicator Register */
+	uint8_t		res19[4];
+	uint32_t	ifstat;		/* 0x2453c - Interface Status Register */
+	uint32_t	macstnaddr1;	/* 0x24540 - Station Address Part 1 Register */
+	uint32_t	macstnaddr2;	/* 0x24544 - Station Address Part 2 Register */
+	uint8_t		res20[312];
+	uint32_t	tr64;		/* 0x24680 - Transmit and Receive 64-byte Frame Counter */
+	uint32_t	tr127;		/* 0x24684 - Transmit and Receive 65-127 byte Frame Counter */
+	uint32_t	tr255;		/* 0x24688 - Transmit and Receive 128-255 byte Frame Counter */
+	uint32_t	tr511;		/* 0x2468c - Transmit and Receive 256-511 byte Frame Counter */
+	uint32_t	tr1k;		/* 0x24690 - Transmit and Receive 512-1023 byte Frame Counter */
+	uint32_t	trmax;		/* 0x24694 - Transmit and Receive 1024-1518 byte Frame Counter */
+	uint32_t	trmgv;		/* 0x24698 - Transmit and Receive 1519-1522 byte Good VLAN Frame */
+	uint32_t	rbyt;		/* 0x2469c - Receive Byte Counter */
+	uint32_t	rpkt;		/* 0x246a0 - Receive Packet Counter */
+	uint32_t	rfcs;		/* 0x246a4 - Receive FCS Error Counter */
+	uint32_t	rmca;		/* 0x246a8 - Receive Multicast Packet Counter */
+	uint32_t	rbca;		/* 0x246ac - Receive Broadcast Packet Counter */
+	uint32_t	rxcf;		/* 0x246b0 - Receive Control Frame Packet Counter */
+	uint32_t	rxpf;		/* 0x246b4 - Receive Pause Frame Packet Counter */
+	uint32_t	rxuo;		/* 0x246b8 - Receive Unknown OP Code Counter */
+	uint32_t	raln;		/* 0x246bc - Receive Alignment Error Counter */
+	uint32_t	rflr;		/* 0x246c0 - Receive Frame Length Error Counter */
+	uint32_t	rcde;		/* 0x246c4 - Receive Code Error Counter */
+	uint32_t	rcse;		/* 0x246c8 - Receive Carrier Sense Error Counter */
+	uint32_t	rund;		/* 0x246cc - Receive Undersize Packet Counter */
+	uint32_t	rovr;		/* 0x246d0 - Receive Oversize Packet Counter */
+	uint32_t	rfrg;		/* 0x246d4 - Receive Fragments Counter */
+	uint32_t	rjbr;		/* 0x246d8 - Receive Jabber Counter */
+	uint32_t	rdrp;		/* 0x246dc - Receive Drop Counter */
+	uint32_t	tbyt;		/* 0x246e0 - Transmit Byte Counter Counter */
+	uint32_t	tpkt;		/* 0x246e4 - Transmit Packet Counter */
+	uint32_t	tmca;		/* 0x246e8 - Transmit Multicast Packet Counter */
+	uint32_t	tbca;		/* 0x246ec - Transmit Broadcast Packet Counter */
+	uint32_t	txpf;		/* 0x246f0 - Transmit Pause Control Frame Counter */
+	uint32_t	tdfr;		/* 0x246f4 - Transmit Deferral Packet Counter */
+	uint32_t	tedf;		/* 0x246f8 - Transmit Excessive Deferral Packet Counter */
+	uint32_t	tscl;		/* 0x246fc - Transmit Single Collision Packet Counter */
+	uint32_t	tmcl;		/* 0x24700 - Transmit Multiple Collision Packet Counter */
+	uint32_t	tlcl;		/* 0x24704 - Transmit Late Collision Packet Counter */
+	uint32_t	txcl;		/* 0x24708 - Transmit Excessive Collision Packet Counter */
+	uint32_t	tncl;		/* 0x2470c - Transmit Total Collision Counter */
+	uint8_t		res21[4];
+	uint32_t	tdrp;		/* 0x24714 - Transmit Drop Frame Counter */
+	uint32_t	tjbr;		/* 0x24718 - Transmit Jabber Frame Counter */
+	uint32_t	tfcs;		/* 0x2471c - Transmit FCS Error Counter */
+	uint32_t	txcf;		/* 0x24720 - Transmit Control Frame Counter */
+	uint32_t	tovr;		/* 0x24724 - Transmit Oversize Frame Counter */
+	uint32_t	tund;		/* 0x24728 - Transmit Undersize Frame Counter */
+	uint32_t	tfrg;		/* 0x2472c - Transmit Fragments Frame Counter */
+	uint32_t	car1;		/* 0x24730 - Carry Register One */
+	uint32_t	car2;		/* 0x24734 - Carry Register Two */
+	uint32_t	cam1;		/* 0x24738 - Carry Mask Register One */
+	uint32_t	cam2;		/* 0x2473c - Carry Mask Register Two */
+	uint8_t		res22[192];
+	uint32_t	iaddr0;		/* 0x24800 - Indivdual address register 0 */
+	uint32_t	iaddr1;		/* 0x24804 - Indivdual address register 1 */
+	uint32_t	iaddr2;		/* 0x24808 - Indivdual address register 2 */
+	uint32_t	iaddr3;		/* 0x2480c - Indivdual address register 3 */
+	uint32_t	iaddr4;		/* 0x24810 - Indivdual address register 4 */
+	uint32_t	iaddr5;		/* 0x24814 - Indivdual address register 5 */
+	uint32_t	iaddr6;		/* 0x24818 - Indivdual address register 6 */
+	uint32_t	iaddr7;		/* 0x2481c - Indivdual address register 7 */
+	uint8_t		res23[96];
+	uint32_t	gaddr0;		/* 0x24880 - Global address register 0 */
+	uint32_t	gaddr1;		/* 0x24884 - Global address register 1 */
+	uint32_t	gaddr2;		/* 0x24888 - Global address register 2 */
+	uint32_t	gaddr3;		/* 0x2488c - Global address register 3 */
+	uint32_t	gaddr4;		/* 0x24890 - Global address register 4 */
+	uint32_t	gaddr5;		/* 0x24894 - Global address register 5 */
+	uint32_t	gaddr6;		/* 0x24898 - Global address register 6 */
+	uint32_t	gaddr7;		/* 0x2489c - Global address register 7 */
+	uint8_t		res24[96];
+	uint32_t	pmd0;		/* 0x24900 - Pattern Match Data Register */
+	uint8_t		res25[4];
+	uint32_t	pmask0;		/* 0x24908 - Pattern Mask Register */
+	uint8_t		res26[4];
+	uint32_t	pcntrl0;	/* 0x24910 - Pattern Match Control Register */
+	uint8_t		res27[4];
+	uint32_t	pattrb0;	/* 0x24918 - Pattern Match Attributes Register */
+	uint32_t	pattrbeli0;	/* 0x2491c - Pattern Match Attributes Extract Length and Extract Index Register */
+	uint32_t	pmd1;		/* 0x24920 - Pattern Match Data Register */
+	uint8_t		res28[4];
+	uint32_t	pmask1;		/* 0x24928 - Pattern Mask Register */
+	uint8_t		res29[4];
+	uint32_t	pcntrl1;	/* 0x24930 - Pattern Match Control Register */
+	uint8_t		res30[4];
+	uint32_t	pattrb1;	/* 0x24938 - Pattern Match Attributes Register */
+	uint32_t	pattrbeli1;	/* 0x2493c - Pattern Match Attributes Extract Length and Extract Index Register */
+	uint32_t	pmd2;		/* 0x24940 - Pattern Match Data Register */
+	uint8_t		res31[4];
+	uint32_t	pmask2;		/* 0x24948 - Pattern Mask Register */
+	uint8_t		res32[4];
+	uint32_t	pcntrl2;	/* 0x24950 - Pattern Match Control Register */
+	uint8_t		res33[4];
+	uint32_t	pattrb2;	/* 0x24958 - Pattern Match Attributes Register */
+	uint32_t	pattrbeli2;	/* 0x2495c - Pattern Match Attributes Extract Length and Extract Index Register */
+	uint32_t	pmd3;		/* 0x24960 - Pattern Match Data Register */
+	uint8_t		res34[4];
+	uint32_t	pmask3;		/* 0x24968 - Pattern Mask Register */
+	uint8_t		res35[4];
+	uint32_t	pcntrl3;	/* 0x24970 - Pattern Match Control Register */
+	uint8_t		res36[4];
+	uint32_t	pattrb3;	/* 0x24978 - Pattern Match Attributes Register */
+	uint32_t	pattrbeli3;	/* 0x2497c - Pattern Match Attributes Extract Length and Extract Index Register */
+	uint32_t	pmd4;		/* 0x24980 - Pattern Match Data Register */
+	uint8_t		res37[4];
+	uint32_t	pmask4;		/* 0x24988 - Pattern Mask Register */
+	uint8_t		res38[4];
+	uint32_t	pcntrl4;	/* 0x24990 - Pattern Match Control Register */
+	uint8_t		res39[4];
+	uint32_t	pattrb4;	/* 0x24998 - Pattern Match Attributes Register */
+	uint32_t	pattrbeli4;	/* 0x2499c - Pattern Match Attributes Extract Length and Extract Index Register */
+	uint32_t	pmd5;		/* 0x249a0 - Pattern Match Data Register */
+	uint8_t		res40[4];
+	uint32_t	pmask5;		/* 0x249a8 - Pattern Mask Register */
+	uint8_t		res41[4];
+	uint32_t	pcntrl5;	/* 0x249b0 - Pattern Match Control Register */
+	uint8_t		res42[4];
+	uint32_t	pattrb5;	/* 0x249b8 - Pattern Match Attributes Register */
+	uint32_t	pattrbeli5;	/* 0x249bc - Pattern Match Attributes Extract Length and Extract Index Register */
+	uint32_t	pmd6;		/* 0x249c0 - Pattern Match Data Register */
+	uint8_t		res43[4];
+	uint32_t	pmask6;		/* 0x249c8 - Pattern Mask Register */
+	uint8_t		res44[4];
+	uint32_t	pcntrl6;	/* 0x249d0 - Pattern Match Control Register */
+	uint8_t		res45[4];
+	uint32_t	pattrb6;	/* 0x249d8 - Pattern Match Attributes Register */
+	uint32_t	pattrbeli6;	/* 0x249dc - Pattern Match Attributes Extract Length and Extract Index Register */
+	uint32_t	pmd7;		/* 0x249e0 - Pattern Match Data Register */
+	uint8_t		res46[4];
+	uint32_t	pmask7;		/* 0x249e8 - Pattern Mask Register */
+	uint8_t		res47[4];
+	uint32_t	pcntrl7;	/* 0x249f0 - Pattern Match Control Register */
+	uint8_t		res48[4];
+	uint32_t	pattrb7;	/* 0x249f8 - Pattern Match Attributes Register */
+	uint32_t	pattrbeli7;	/* 0x249fc - Pattern Match Attributes Extract Length and Extract Index Register */
+	uint32_t	pmd8;		/* 0x24a00 - Pattern Match Data Register */
+	uint8_t		res49[4];
+	uint32_t	pmask8;		/* 0x24a08 - Pattern Mask Register */
+	uint8_t		res50[4];
+	uint32_t	pcntrl8;	/* 0x24a10 - Pattern Match Control Register */
+	uint8_t		res51[4];
+	uint32_t	pattrb8;	/* 0x24a18 - Pattern Match Attributes Register */
+	uint32_t	pattrbeli8;	/* 0x24a1c - Pattern Match Attributes Extract Length and Extract Index Register */
+	uint32_t	pmd9;		/* 0x24a20 - Pattern Match Data Register */
+	uint8_t		res52[4];
+	uint32_t	pmask9;		/* 0x24a28 - Pattern Mask Register */
+	uint8_t		res53[4];
+	uint32_t	pcntrl9;	/* 0x24a30 - Pattern Match Control Register */
+	uint8_t		res54[4];
+	uint32_t	pattrb9;	/* 0x24a38 - Pattern Match Attributes Register */
+	uint32_t	pattrbeli9;	/* 0x24a3c - Pattern Match Attributes Extract Length and Extract Index Register */
+	uint32_t	pmd10;		/* 0x24a40 - Pattern Match Data Register */
+	uint8_t		res55[4];
+	uint32_t	pmask10;	/* 0x24a48 - Pattern Mask Register */
+	uint8_t		res56[4];
+	uint32_t	pcntrl10;	/* 0x24a50 - Pattern Match Control Register */
+	uint8_t		res57[4];
+	uint32_t	pattrb10;	/* 0x24a58 - Pattern Match Attributes Register */
+	uint32_t	pattrbeli10;	/* 0x24a5c - Pattern Match Attributes Extract Length and Extract Index Register */
+	uint32_t	pmd11;		/* 0x24a60 - Pattern Match Data Register */
+	uint8_t		res58[4];
+	uint32_t	pmask11;	/* 0x24a68 - Pattern Mask Register */
+	uint8_t		res59[4];
+	uint32_t	pcntrl11;	/* 0x24a70 - Pattern Match Control Register */
+	uint8_t		res60[4];
+	uint32_t	pattrb11;	/* 0x24a78 - Pattern Match Attributes Register */
+	uint32_t	pattrbeli11;	/* 0x24a7c - Pattern Match Attributes Extract Length and Extract Index Register */
+	uint32_t	pmd12;		/* 0x24a80 - Pattern Match Data Register */
+	uint8_t		res61[4];
+	uint32_t	pmask12;	/* 0x24a88 - Pattern Mask Register */
+	uint8_t		res62[4];
+	uint32_t	pcntrl12;	/* 0x24a90 - Pattern Match Control Register */
+	uint8_t		res63[4];
+	uint32_t	pattrb12;	/* 0x24a98 - Pattern Match Attributes Register */
+	uint32_t	pattrbeli12;	/* 0x24a9c - Pattern Match Attributes Extract Length and Extract Index Register */
+	uint32_t	pmd13;		/* 0x24aa0 - Pattern Match Data Register */
+	uint8_t		res64[4];
+	uint32_t	pmask13;	/* 0x24aa8 - Pattern Mask Register */
+	uint8_t		res65[4];
+	uint32_t	pcntrl13;	/* 0x24ab0 - Pattern Match Control Register */
+	uint8_t		res66[4];
+	uint32_t	pattrb13;	/* 0x24ab8 - Pattern Match Attributes Register */
+	uint32_t	pattrbeli13;	/* 0x24abc - Pattern Match Attributes Extract Length and Extract Index Register */
+	uint32_t	pmd14;		/* 0x24ac0 - Pattern Match Data Register */
+	uint8_t		res67[4];
+	uint32_t	pmask14;	/* 0x24ac8 - Pattern Mask Register */
+	uint8_t		res68[4];
+	uint32_t	pcntrl14;	/* 0x24ad0 - Pattern Match Control Register */
+	uint8_t		res69[4];
+	uint32_t	pattrb14;	/* 0x24ad8 - Pattern Match Attributes Register */
+	uint32_t	pattrbeli14;	/* 0x24adc - Pattern Match Attributes Extract Length and Extract Index Register */
+	uint32_t	pmd15;		/* 0x24ae0 - Pattern Match Data Register */
+	uint8_t		res70[4];
+	uint32_t	pmask15;	/* 0x24ae8 - Pattern Mask Register */
+	uint8_t		res71[4];
+	uint32_t	pcntrl15;	/* 0x24af0 - Pattern Match Control Register */
+	uint8_t		res72[4];
+	uint32_t	pattrb15;	/* 0x24af8 - Pattern Match Attributes Register */
+	uint32_t	pattrbeli15;	/* 0x24afc - Pattern Match Attributes Extract Length and Extract Index Register */
+	uint8_t		res73[248];
+	uint32_t	attr;		/* 0x24bf8 - Attributes Register */
+	uint32_t	attreli;	/* 0x24bfc - Attributes Extract Length and Extract Index Register */
+	uint8_t		res74[1024];	/* 0x24c00-0x25000 TSEC1 Future Expansion Space Registers */
+} ccsr_tsec_t;
+
+/* FEC Registers (0x2_6000-0x2_7000) */
+typedef struct ccsr_fec {
+	uint8_t		res1[16];
+	uint32_t	ievent;		/* 0x26010 - Interrupt Event Register */
+	uint32_t	imask;		/* 0x26014 - Interrupt Mask Register */
+	uint32_t	edis;		/* 0x26018 - Error Disabled Register */
+	uint8_t		res2[8];
+	uint32_t	minflr;		/* 0x26024 - Minimum Frame Length Register */
+	uint32_t	ptv;		/* 0x26028 - Pause Time Value Register */
+	uint32_t	dmactrl;	/* 0x2602c - DMA Control Register */
+	uint8_t		res3[28];
+	uint32_t	fifo_pause_ctrl;	/* 0x2604c - FIFO pause control register */
+	uint8_t		res4[60];
+	uint32_t	fifo_tx_thr;		/* 0x2608c - FIFO transmit threshold register */
+	uint8_t		res5[8];
+	uint32_t	fifo_tx_starve;		/* 0x26098 - FIFO transmit starve register */
+	uint32_t	fifo_tx_starve_shutoff;	/* 0x2609c - FIFO transmit starve shutoff register */
+	uint8_t		res6[96];
+	uint32_t	tctrl;		/* 0x26100 - Transmit Control Register */
+	uint32_t	tstat;		/* 0x26104 - Transmit Status Register */
+	uint8_t		res7[4];
+	uint32_t	tbdlen;		/* 0x2610c - Transmit Buffer Descriptor Data Length Register */
+	uint8_t		res8[20];
+	uint32_t	ctbptr;		/* 0x26124 - Current Transmit Buffer Descriptor Pointer Register */
+	uint8_t		res9[92];
+	uint32_t	tbptr;		/* 0x26184 - Transmit Buffer Descriptor Pointer Register */
+	uint8_t		res10[124];
+	uint32_t	tbase;		/* 0x26204 - Transmit Descriptor Base Address Register */
+	uint8_t		res11[168];
+	uint32_t	ostbd;		/* 0x262b0 - Out-of-Sequence Transmit Buffer Descriptor Register */
+	uint32_t	ostbdp;		/* 0x262b4 - Out-of-Sequence Transmit Data Buffer Pointer Register */
+	uint8_t		res12[72];
+	uint32_t	rctrl;		/* 0x26300 - Receive Control Register */
+	uint32_t	rstat;		/* 0x26304 - Receive Status Register */
+	uint8_t		res13[4];
+	uint32_t	rbdlen;		/* 0x2630c - RxBD Data Length Register */
+	uint8_t		res14[20];
+	uint32_t	crbptr;		/* 0x26324 - Current Receive Buffer Descriptor Pointer */
+	uint8_t		res15[24];
+	uint32_t	mrblr;		/* 0x26340 - Maximum Receive Buffer Length Register */
+	uint8_t		res16[64];
+	uint32_t	rbptr;		/* 0x26384 - Receive Buffer Descriptor Pointer */
+	uint8_t		res17[124];
+	uint32_t	rbase;		/* 0x26404 - Receive Descriptor Base Address */
+	uint8_t		res18[248];
+	uint32_t	maccfg1;	/* 0x26500 - MAC Configuration 1 Register */
+	uint32_t	maccfg2;	/* 0x26504 - MAC Configuration 2 Register */
+	uint32_t	ipgifg;		/* 0x26508 - Inter Packet Gap/Inter Frame Gap Register */
+	uint32_t	hafdup;		/* 0x2650c - Half Duplex Register */
+	uint32_t	maxfrm;		/* 0x26510 - Maximum Frame Length Register */
+	uint8_t		res19[40];
+	uint32_t	ifstat;		/* 0x2653c - Interface Status Register */
+	uint32_t	macstnaddr1;	/* 0x26540 - Station Address Part 1 Register */
+	uint32_t	macstnaddr2;	/* 0x26544 - Station Address Part 2 Register */
+	uint8_t		res20[696];	/* 0x26548-0x267fc reserved */
+	uint32_t	iaddr0;		/* 0x26800 - Indivdual address register 0 */
+	uint32_t	iaddr1;		/* 0x26804 - Indivdual address register 1 */
+	uint32_t	iaddr2;		/* 0x26808 - Indivdual address register 2 */
+	uint32_t	iaddr3;		/* 0x2680c - Indivdual address register 3 */
+	uint32_t	iaddr4;		/* 0x26810 - Indivdual address register 4 */
+	uint32_t	iaddr5;		/* 0x26814 - Indivdual address register 5 */
+	uint32_t	iaddr6;		/* 0x26818 - Indivdual address register 6 */
+	uint32_t	iaddr7;		/* 0x2681c - Indivdual address register 7 */
+	uint8_t		res21[96];
+	uint32_t	gaddr0;		/* 0x26880 - Global address register 0 */
+	uint32_t	gaddr1;		/* 0x26884 - Global address register 1 */
+	uint32_t	gaddr2;		/* 0x26888 - Global address register 2 */
+	uint32_t	gaddr3;		/* 0x2688c - Global address register 3 */
+	uint32_t	gaddr4;		/* 0x26890 - Global address register 4 */
+	uint32_t	gaddr5;		/* 0x26894 - Global address register 5 */
+	uint32_t	gaddr6;		/* 0x26898 - Global address register 6 */
+	uint32_t	gaddr7;		/* 0x2689c - Global address register 7 */
+	uint8_t		res22[856];	/* 0x268a0-0x26bf4 reserved */
+	uint32_t	attr;		/* 0x26bf8 - Attributes Register */
+	uint32_t	attreli;	/* 0x26bfc - Attributes Extract Length and Extract Index Register */
+	uint8_t		res23[1024];	/* 0x26c00-0x27000 reserved */
+} ccsr_fec_t;
+
+/* PIC Registers(0x2_7000-0x4_0000-0x8_0000) */
+typedef struct ccsr_pic {
+	uint8_t 	res0[102400];	/* 0x27000-0x40000 */
+	uint8_t		res1[64];
+	uint32_t	ipidr0;		/* 0x40040 - Interprocessor Interrupt Dispatch Register 0 */
+	uint8_t		res2[12];
+	uint32_t	ipidr1;		/* 0x40050 - Interprocessor Interrupt Dispatch Register 1 */
+	uint8_t		res3[12];
+	uint32_t	ipidr2;		/* 0x40060 - Interprocessor Interrupt Dispatch Register 2 */
+	uint8_t		res4[12];
+	uint32_t	ipidr3;		/* 0x40070 - Interprocessor Interrupt Dispatch Register 3 */
+	uint8_t		res5[12];
+	uint32_t	ctpr;		/* 0x40080 - Current Task Priority Register */
+	uint8_t		res6[12];
+	uint32_t	whoami;		/* 0x40090 - Who Am I Register */
+	uint8_t		res7[12];
+	uint32_t	iack;		/* 0x400a0 - Interrupt Acknowledge Register */
+	uint8_t		res8[12];
+	uint32_t	eoi;		/* 0x400b0 - End Of Interrupt Register */
+	uint8_t		res9[3916];
+	uint32_t	frr;		/* 0x41000 - Feature Reporting Register */
+	uint8_t		res10[28];
+	uint32_t	gcr;		/* 0x41020 - Global Configuration Register */
+	uint8_t		res11[92];
+/* FIXME */				/* 0x41040-0x41070 - Vendor reserved */
+ 	uint32_t	vir;		/* 0x41080 - Vendor Identification Register */
+	uint8_t		res12[12];
+	uint32_t	pir;		/* 0x41090 - Processor Initialization Register */
+	uint8_t		res13[12];
+	uint32_t	ipivpr0;	/* 0x410a0 - IPI Vector/Priority Register 0 */
+	uint8_t		res14[12];
+	uint32_t	ipivpr1;	/* 0x410b0 - IPI Vector/Priority Register 1 */
+	uint8_t		res15[12];
+	uint32_t	ipivpr2;	/* 0x410c0 - IPI Vector/Priority Register 2 */
+	uint8_t		res16[12];
+	uint32_t	ipivpr3;	/* 0x410d0 - IPI Vector/Priority Register 3 */
+	uint8_t		res17[12];
+	uint32_t	svr;		/* 0x410e0 - Spurious Vector Register */
+	uint8_t		res18[12];
+	uint32_t	tfrr;		/* 0x410f0 - Timer Frequency Reporting Register */
+	uint8_t		res19[12];
+	uint32_t	gtccr0;		/* 0x41100 - Global Timer Current Count Register 0 */
+	uint8_t		res20[12];
+	uint32_t	gtbcr0;		/* 0x41110 - Global Timer Base Count Register 0 */
+	uint8_t		res21[12];
+	uint32_t	gtvpr0;		/* 0x41120 - Global Timer Vector/Priority Register 0 */
+	uint8_t		res22[12];
+	uint32_t	gtdr0;		/* 0x41130 - Global Timer Destination Register 0 */
+	uint8_t		res23[12];
+	uint32_t	gtccr1;		/* 0x41140 - Global Timer Current Count Register 1 */
+	uint8_t		res24[12];
+	uint32_t	gtbcr1;		/* 0x41150 - Global Timer Base Count Register 1 */
+	uint8_t		res25[12];
+	uint32_t	gtvpr1;		/* 0x41160 - Global Timer Vector/Priority Register 1 */
+	uint8_t		res26[12];
+	uint32_t	gtdr1;		/* 0x41170 - Global Timer Destination Register 1 */
+	uint8_t		res27[12];
+	uint32_t	gtccr2;		/* 0x41180 - Global Timer Current Count Register 2 */
+	uint8_t		res28[12];
+	uint32_t	gtbcr2;		/* 0x41190 - Global Timer Base Count Register 2 */
+	uint8_t		res29[12];
+	uint32_t	gtvpr2;		/* 0x411a0 - Global Timer Vector/Priority Register 2 */
+	uint8_t		res30[12];
+	uint32_t	gtdr2;		/* 0x411b0 - Global Timer Destination Register 2 */
+	uint8_t		res31[12];
+	uint32_t	gtccr3;		/* 0x411c0 - Global Timer Current Count Register 3 */
+	uint8_t		res32[12];
+	uint32_t	gtbcr3;		/* 0x411d0 - Global Timer Base Count Register 3 */
+	uint8_t		res33[12];
+	uint32_t	gtvpr3;		/* 0x411e0 - Global Timer Vector/Priority Register 3 */
+	uint8_t		res34[12];
+	uint32_t	gtdr3;		/* 0x411f0 - Global Timer Destination Register 3 */
+	uint8_t		res35[268];
+	uint32_t	tcr;		/* 0x41300 - Timer Control Register */
+	uint8_t		res36[12];
+	uint32_t	irqsr0;		/* 0x41310 - IRQ_OUT Summary Register 0 */
+	uint8_t		res37[12];
+	uint32_t	irqsr1;		/* 0x41320 - IRQ_OUT Summary Register 1 */
+	uint8_t		res38[12];
+	uint32_t	cisr0;		/* 0x41330 - Critical Interrupt Summary Register 0 */
+	uint8_t		res39[12];
+	uint32_t	cisr1;		/* 0x41340 - Critical Interrupt Summary Register 1 */
+	uint8_t		res40[188];
+/* FIXME */				/* 0x41350-0x413c0 Performance monitors */
+	uint32_t	msgr0;		/* 0x41400 - Message Register 0 */
+	uint8_t		res41[12];
+	uint32_t	msgr1;		/* 0x41410 - Message Register 1 */
+	uint8_t		res42[12];
+	uint32_t	msgr2;		/* 0x41420 - Message Register 2 */
+	uint8_t		res43[12];
+	uint32_t	msgr3;		/* 0x41430 - Message Register 3 */
+	uint8_t		res44[204];
+	uint32_t	mer;		/* 0x41500 - Message Enable Register */
+	uint8_t		res45[12];
+	uint32_t	msr;		/* 0x41510 - Message Status Register */
+	uint8_t		res46[60140];
+	uint32_t	eivpr0;		/* 0x50000 - External Interrupt Vector/Priority Register 0 */
+	uint8_t		res47[12];
+	uint32_t	eidr0;		/* 0x50010 - External Interrupt Destination Register 0 */
+	uint8_t		res48[12];
+	uint32_t	eivpr1;		/* 0x50020 - External Interrupt Vector/Priority Register 1 */
+	uint8_t		res49[12];
+	uint32_t	eidr1;		/* 0x50030 - External Interrupt Destination Register 1 */
+	uint8_t		res50[12];
+	uint32_t	eivpr2;		/* 0x50040 - External Interrupt Vector/Priority Register 2 */
+	uint8_t		res51[12];
+	uint32_t	eidr2;		/* 0x50050 - External Interrupt Destination Register 2 */
+	uint8_t		res52[12];
+	uint32_t	eivpr3;		/* 0x50060 - External Interrupt Vector/Priority Register 3 */
+	uint8_t		res53[12];
+	uint32_t	eidr3;		/* 0x50070 - External Interrupt Destination Register 3 */
+	uint8_t		res54[12];
+	uint32_t	eivpr4;		/* 0x50080 - External Interrupt Vector/Priority Register 4 */
+	uint8_t		res55[12];
+	uint32_t	eidr4;		/* 0x50090 - External Interrupt Destination Register 4 */
+	uint8_t		res56[12];
+	uint32_t	eivpr5;		/* 0x500a0 - External Interrupt Vector/Priority Register 5 */
+	uint8_t		res57[12];
+	uint32_t	eidr5;		/* 0x500b0 - External Interrupt Destination Register 5 */
+	uint8_t		res58[12];
+	uint32_t	eivpr6;		/* 0x500c0 - External Interrupt Vector/Priority Register 6 */
+	uint8_t		res59[12];
+	uint32_t	eidr6;		/* 0x500d0 - External Interrupt Destination Register 6 */
+	uint8_t		res60[12];
+	uint32_t	eivpr7;		/* 0x500e0 - External Interrupt Vector/Priority Register 7 */
+	uint8_t		res61[12];
+	uint32_t	eidr7;		/* 0x500f0 - External Interrupt Destination Register 7 */
+	uint8_t		res62[12];
+	uint32_t	eivpr8;		/* 0x50100 - External Interrupt Vector/Priority Register 8 */
+	uint8_t		res63[12];
+	uint32_t	eidr8;		/* 0x50110 - External Interrupt Destination Register 8 */
+	uint8_t		res64[12];
+	uint32_t	eivpr9;		/* 0x50120 - External Interrupt Vector/Priority Register 9 */
+	uint8_t		res65[12];
+	uint32_t	eidr9;		/* 0x50130 - External Interrupt Destination Register 9 */
+	uint8_t		res66[12];
+	uint32_t	eivpr10;	/* 0x50140 - External Interrupt Vector/Priority Register 10 */
+	uint8_t		res67[12];
+	uint32_t	eidr10;		/* 0x50150 - External Interrupt Destination Register 10 */
+	uint8_t		res68[12];
+	uint32_t	eivpr11;	/* 0x50160 - External Interrupt Vector/Priority Register 11 */
+	uint8_t		res69[12];
+	uint32_t	eidr11;		/* 0x50170 - External Interrupt Destination Register 11 */
+	uint8_t		res70[140];
+	uint32_t	iivpr0;		/* 0x50200 - Internal Interrupt Vector/Priority Register 0 */
+	uint8_t		res71[12];
+	uint32_t	iidr0;		/* 0x50210 - Internal Interrupt Destination Register 0 */
+	uint8_t		res72[12];
+	uint32_t	iivpr1;		/* 0x50220 - Internal Interrupt Vector/Priority Register 1 */
+	uint8_t		res73[12];
+	uint32_t	iidr1;		/* 0x50230 - Internal Interrupt Destination Register 1 */
+	uint8_t		res74[12];
+	uint32_t	iivpr2;		/* 0x50240 - Internal Interrupt Vector/Priority Register 2 */
+	uint8_t		res75[12];
+	uint32_t	iidr2;		/* 0x50250 - Internal Interrupt Destination Register 2 */
+	uint8_t		res76[12];
+	uint32_t	iivpr3;		/* 0x50260 - Internal Interrupt Vector/Priority Register 3 */
+	uint8_t		res77[12];
+	uint32_t	iidr3;		/* 0x50270 - Internal Interrupt Destination Register 3 */
+	uint8_t		res78[12];
+	uint32_t	iivpr4;		/* 0x50280 - Internal Interrupt Vector/Priority Register 4 */
+	uint8_t		res79[12];
+	uint32_t	iidr4;		/* 0x50290 - Internal Interrupt Destination Register 4 */
+	uint8_t		res80[12];
+	uint32_t	iivpr5;		/* 0x502a0 - Internal Interrupt Vector/Priority Register 5 */
+	uint8_t		res81[12];
+	uint32_t	iidr5;		/* 0x502b0 - Internal Interrupt Destination Register 5 */
+	uint8_t		res82[12];
+	uint32_t	iivpr6;		/* 0x502c0 - Internal Interrupt Vector/Priority Register 6 */
+	uint8_t		res83[12];
+	uint32_t	iidr6;		/* 0x502d0 - Internal Interrupt Destination Register 6 */
+	uint8_t		res84[12];
+	uint32_t	iivpr7;		/* 0x502e0 - Internal Interrupt Vector/Priority Register 7 */
+	uint8_t		res85[12];
+	uint32_t	iidr7;		/* 0x502f0 - Internal Interrupt Destination Register 7 */
+	uint8_t		res86[12];
+	uint32_t	iivpr8;		/* 0x50300 - Internal Interrupt Vector/Priority Register 8 */
+	uint8_t		res87[12];
+	uint32_t	iidr8;		/* 0x50310 - Internal Interrupt Destination Register 8 */
+	uint8_t		res88[12];
+	uint32_t	iivpr9;		/* 0x50320 - Internal Interrupt Vector/Priority Register 9 */
+	uint8_t		res89[12];
+	uint32_t	iidr9;		/* 0x50330 - Internal Interrupt Destination Register 9 */
+	uint8_t		res90[12];
+	uint32_t	iivpr10;	/* 0x50340 - Internal Interrupt Vector/Priority Register 10 */
+	uint8_t		res91[12];
+	uint32_t	iidr10;		/* 0x50350 - Internal Interrupt Destination Register 10 */
+	uint8_t		res92[12];
+	uint32_t	iivpr11;	/* 0x50360 - Internal Interrupt Vector/Priority Register 11 */
+	uint8_t		res93[12];
+	uint32_t	iidr11;		/* 0x50370 - Internal Interrupt Destination Register 11 */
+	uint8_t		res94[12];
+	uint32_t	iivpr12;	/* 0x50380 - Internal Interrupt Vector/Priority Register 12 */
+	uint8_t		res95[12];
+	uint32_t	iidr12;		/* 0x50390 - Internal Interrupt Destination Register 12 */
+	uint8_t		res96[12];
+	uint32_t	iivpr13;	/* 0x503a0 - Internal Interrupt Vector/Priority Register 13 */
+	uint8_t		res97[12];
+	uint32_t	iidr13;		/* 0x503b0 - Internal Interrupt Destination Register 13 */
+	uint8_t		res98[12];
+	uint32_t	iivpr14;	/* 0x503c0 - Internal Interrupt Vector/Priority Register 14 */
+	uint8_t		res99[12];
+	uint32_t	iidr14;		/* 0x503d0 - Internal Interrupt Destination Register 14 */
+	uint8_t		res100[12];
+	uint32_t	iivpr15;	/* 0x503e0 - Internal Interrupt Vector/Priority Register 15 */
+	uint8_t		res101[12];
+	uint32_t	iidr15;		/* 0x503f0 - Internal Interrupt Destination Register 15 */
+	uint8_t		res102[12];
+	uint32_t	iivpr16;	/* 0x50400 - Internal Interrupt Vector/Priority Register 16 */
+	uint8_t		res103[12];
+	uint32_t	iidr16;		/* 0x50410 - Internal Interrupt Destination Register 16 */
+	uint8_t		res104[12];
+	uint32_t	iivpr17;	/* 0x50420 - Internal Interrupt Vector/Priority Register 17 */
+	uint8_t		res105[12];
+	uint32_t	iidr17;		/* 0x50430 - Internal Interrupt Destination Register 17 */
+	uint8_t		res106[12];
+	uint32_t	iivpr18;	/* 0x50440 - Internal Interrupt Vector/Priority Register 18 */
+	uint8_t		res107[12];
+	uint32_t	iidr18;		/* 0x50450 - Internal Interrupt Destination Register 18 */
+	uint8_t		res108[12];
+	uint32_t	iivpr19;	/* 0x50460 - Internal Interrupt Vector/Priority Register 19 */
+	uint8_t		res109[12];
+	uint32_t	iidr19;		/* 0x50470 - Internal Interrupt Destination Register 19 */
+	uint8_t		res110[12];
+	uint32_t	iivpr20;	/* 0x50480 - Internal Interrupt Vector/Priority Register 20 */
+	uint8_t		res111[12];
+	uint32_t	iidr20;		/* 0x50490 - Internal Interrupt Destination Register 20 */
+	uint8_t		res112[12];
+	uint32_t	iivpr21;	/* 0x504a0 - Internal Interrupt Vector/Priority Register 21 */
+	uint8_t		res113[12];
+	uint32_t	iidr21;		/* 0x504b0 - Internal Interrupt Destination Register 21 */
+	uint8_t		res114[12];
+	uint32_t	iivpr22;	/* 0x504c0 - Internal Interrupt Vector/Priority Register 22 */
+	uint8_t		res115[12];
+	uint32_t	iidr22;		/* 0x504d0 - Internal Interrupt Destination Register 22 */
+	uint8_t		res116[12];
+	uint32_t	iivpr23;	/* 0x504e0 - Internal Interrupt Vector/Priority Register 23 */
+	uint8_t		res117[12];
+	uint32_t	iidr23;		/* 0x504f0 - Internal Interrupt Destination Register 23 */
+	uint8_t		res118[12];
+	uint32_t	iivpr24;	/* 0x50500 - Internal Interrupt Vector/Priority Register 24 */
+	uint8_t		res119[12];
+	uint32_t	iidr24;		/* 0x50510 - Internal Interrupt Destination Register 24 */
+	uint8_t		res120[12];
+	uint32_t	iivpr25;	/* 0x50520 - Internal Interrupt Vector/Priority Register 25 */
+	uint8_t		res121[12];
+	uint32_t	iidr25;		/* 0x50530 - Internal Interrupt Destination Register 25 */
+	uint8_t		res122[12];
+	uint32_t	iivpr26;	/* 0x50540 - Internal Interrupt Vector/Priority Register 26 */
+	uint8_t		res123[12];
+	uint32_t	iidr26;		/* 0x50550 - Internal Interrupt Destination Register 26 */
+	uint8_t		res124[12];
+	uint32_t	iivpr27;	/* 0x50560 - Internal Interrupt Vector/Priority Register 27 */
+	uint8_t		res125[12];
+	uint32_t	iidr27;		/* 0x50570 - Internal Interrupt Destination Register 27 */
+	uint8_t		res126[12];
+	uint32_t	iivpr28;	/* 0x50580 - Internal Interrupt Vector/Priority Register 28 */
+	uint8_t		res127[12];
+	uint32_t	iidr28;		/* 0x50590 - Internal Interrupt Destination Register 28 */
+	uint8_t		res128[12];
+	uint32_t	iivpr29;	/* 0x505a0 - Internal Interrupt Vector/Priority Register 29 */
+	uint8_t		res129[12];
+	uint32_t	iidr29;		/* 0x505b0 - Internal Interrupt Destination Register 29 */
+	uint8_t		res130[12];
+	uint32_t	iivpr30;	/* 0x505c0 - Internal Interrupt Vector/Priority Register 30 */
+	uint8_t		res131[12];
+	uint32_t	iidr30;		/* 0x505d0 - Internal Interrupt Destination Register 30 */
+	uint8_t		res132[12];
+	uint32_t	iivpr31;	/* 0x505e0 - Internal Interrupt Vector/Priority Register 31 */
+	uint8_t		res133[12];
+	uint32_t	iidr31;		/* 0x505f0 - Internal Interrupt Destination Register 31 */
+	uint8_t		res134[4108];
+	uint32_t	mivpr0;		/* 0x51600 - Messaging Interrupt Vector/Priority Register 0 */
+	uint8_t		res135[12];
+	uint32_t	midr0;		/* 0x51610 - Messaging Interrupt Destination Register 0 */
+	uint8_t		res136[12];
+	uint32_t	mivpr1;		/* 0x51620 - Messaging Interrupt Vector/Priority Register 1 */
+	uint8_t		res137[12];
+	uint32_t	midr1;		/* 0x51630 - Messaging Interrupt Destination Register 1 */
+	uint8_t		res138[12];
+	uint32_t	mivpr2;		/* 0x51640 - Messaging Interrupt Vector/Priority Register 2 */
+	uint8_t		res139[12];
+	uint32_t	midr2;		/* 0x51650 - Messaging Interrupt Destination Register 2 */
+	uint8_t		res140[12];
+	uint32_t	mivpr3;		/* 0x51660 - Messaging Interrupt Vector/Priority Register 3 */
+	uint8_t		res141[12];
+	uint32_t	midr3;		/* 0x51670 - Messaging Interrupt Destination Register 3 */
+	uint8_t		res142[59852];
+	uint32_t	ipi0dr0;	/* 0x60040 - Processor 0 Interprocessor Interrupt Dispatch Register 0 */
+	uint8_t		res143[12];
+	uint32_t	ipi0dr1;	/* 0x60050 - Processor 0 Interprocessor Interrupt Dispatch Register 1 */
+	uint8_t		res144[12];
+	uint32_t	ipi0dr2;	/* 0x60060 - Processor 0 Interprocessor Interrupt Dispatch Register 2 */
+	uint8_t		res145[12];
+	uint32_t	ipi0dr3;	/* 0x60070 - Processor 0 Interprocessor Interrupt Dispatch Register 3 */
+	uint8_t		res146[12];
+	uint32_t	ctpr0;		/* 0x60080 - Current Task Priority Register for Processor 0 */
+	uint8_t		res147[12];
+	uint32_t	whoami0;	/* 0x60090 - Who Am I Register for Processor 0 */
+	uint8_t		res148[12];
+	uint32_t	iack0;		/* 0x600a0 - Interrupt Acknowledge Register for Processor 0 */
+	uint8_t		res149[12];
+	uint32_t	eoi0;		/* 0x600b0 - End Of Interrupt Register for Processor 0 */
+	uint8_t		res150[130892];
+} ccsr_pic_t;
+
+/* CPM Block(0x8_0000-0xc_0000) */
+#ifdef CONFIG_MPC8540
+typedef struct ccsr_cpm2 {
+	uint8_t res[262144];
+} ccsr_cpm2_t;
+#else
+#include <asm/immap_cpm2.h>
+typedef cpm2_map_t ccsr_cpm2_t;
+#endif
+
+/* RapidIO Registers(0xc_0000-0xe_0000) */
+typedef struct ccsr_rio {
+	uint32_t	didcar;		/* 0xc0000 - Device Identity Capability Register */
+	uint32_t	dicar;		/* 0xc0004 - Device Information Capability Register */
+	uint32_t	aidcar;		/* 0xc0008 - Assembly Identity Capability Register */
+	uint32_t	aicar;		/* 0xc000c - Assembly Information Capability Register */
+	uint32_t	pefcar;		/* 0xc0010 - Processing Element Features Capability Register */
+	uint32_t	spicar;		/* 0xc0014 - Switch Port Information Capability Register */
+	uint32_t	socar;		/* 0xc0018 - Source Operations Capability Register */
+	uint32_t	docar;		/* 0xc001c - Destination Operations Capability Register */
+	uint8_t		res1[32];
+	uint32_t	msr;		/* 0xc0040 - Mailbox Command And Status Register */
+	uint32_t	pwdcsr;		/* 0xc0044 - Port-Write and Doorbell Command And Status Register */
+	uint8_t		res2[4];
+	uint32_t	pellccsr;	/* 0xc004c - Processing Element Logic Layer Control Command and Status Register */
+	uint8_t		res3[12];
+	uint32_t	lcsbacsr;	/* 0xc005c - Local Configuration Space Base Address Command and Status Register */
+	uint32_t	bdidcsr;	/* 0xc0060 - Base Device ID Command and Status Register */
+	uint8_t		res4[4];
+	uint32_t	hbdidlcsr;	/* 0xc0068 - Host Base Device ID Lock Command and Status Register */
+	uint32_t	ctcsr;		/* 0xc006c - Component Tag Command and Status Register */
+	uint8_t		res5[144];
+	uint32_t	pmbh0csr;	/* 0xc0100 - 8/16 LP-LVDS Port Maintenance Block Header 0 Command and Status Register */
+	uint8_t		res6[28];
+	uint32_t	pltoccsr;	/* 0xc0120 - Port Link Time-out Control Command and Status Register */
+	uint32_t	prtoccsr;	/* 0xc0124 - Port Response Time-out Control Command and Status Register */
+	uint8_t		res7[20];
+	uint32_t	pgccsr;		/* 0xc013c - Port General Command and Status Register */
+	uint32_t	plmreqcsr;	/* 0xc0140 - Port Link Maintenance Request Command and Status Register */
+	uint32_t	plmrespcsr;	/* 0xc0144 - Port Link Maintenance Response Command and Status Register */
+	uint32_t	plascsr;	/* 0xc0148 - Port Local Ackid Status Command and Status Register */
+	uint8_t		res8[12];
+	uint32_t	pescsr;		/* 0xc0158 - Port Error and Status Command and Status Register */
+	uint32_t	pccsr;		/* 0xc015c - Port Control Command and Status Register */
+	uint8_t		res9[65184];
+	uint32_t	cr;		/* 0xd0000 - Port Control Command and Status Register */
+	uint8_t		res10[12];
+	uint32_t	pcr;		/* 0xd0010 - Port Configuration Register */
+	uint32_t	peir;		/* 0xd0014 - Port Error Injection Register */
+	uint8_t		res11[3048];
+	uint32_t	rowtar0;	/* 0xd0c00 - RapidIO Outbound Window Translation Address Register 0 */
+	uint8_t		res12[12];
+	uint32_t	rowar0;		/* 0xd0c10 - RapidIO Outbound Attributes Register 0 */
+	uint8_t		res13[12];
+	uint32_t	rowtar1;	/* 0xd0c20 - RapidIO Outbound Window Translation Address Register 1 */
+	uint8_t		res14[4];
+	uint32_t	rowbar1;	/* 0xd0c28 - RapidIO Outbound Window Base Address Register 1 */
+	uint8_t		res15[4];
+	uint32_t	rowar1;		/* 0xd0c30 - RapidIO Outbound Attributes Register 1 */
+	uint8_t		res16[12];
+	uint32_t	rowtar2;	/* 0xd0c40 - RapidIO Outbound Window Translation Address Register 2 */
+	uint8_t		res17[4];
+	uint32_t	rowbar2;	/* 0xd0c48 - RapidIO Outbound Window Base Address Register 2 */
+	uint8_t		res18[4];
+	uint32_t	rowar2;		/* 0xd0c50 - RapidIO Outbound Attributes Register 2 */
+	uint8_t		res19[12];
+	uint32_t	rowtar3;	/* 0xd0c60 - RapidIO Outbound Window Translation Address Register 3 */
+	uint8_t		res20[4];
+	uint32_t	rowbar3;	/* 0xd0c68 - RapidIO Outbound Window Base Address Register 3 */
+	uint8_t		res21[4];
+	uint32_t	rowar3;		/* 0xd0c70 - RapidIO Outbound Attributes Register 3 */
+	uint8_t		res22[12];
+	uint32_t	rowtar4;	/* 0xd0c80 - RapidIO Outbound Window Translation Address Register 4 */
+	uint8_t		res23[4];
+	uint32_t	rowbar4;	/* 0xd0c88 - RapidIO Outbound Window Base Address Register 4 */
+	uint8_t		res24[4];
+	uint32_t	rowar4;		/* 0xd0c90 - RapidIO Outbound Attributes Register 4 */
+	uint8_t		res25[12];
+	uint32_t	rowtar5;	/* 0xd0ca0 - RapidIO Outbound Window Translation Address Register 5 */
+	uint8_t		res26[4];
+	uint32_t	rowbar5;	/* 0xd0ca8 - RapidIO Outbound Window Base Address Register 5 */
+	uint8_t		res27[4];
+	uint32_t	rowar5;		/* 0xd0cb0 - RapidIO Outbound Attributes Register 5 */
+	uint8_t		res28[12];
+	uint32_t	rowtar6;	/* 0xd0cc0 - RapidIO Outbound Window Translation Address Register 6 */
+	uint8_t		res29[4];
+	uint32_t	rowbar6;	/* 0xd0cc8 - RapidIO Outbound Window Base Address Register 6 */
+	uint8_t		res30[4];
+	uint32_t	rowar6;		/* 0xd0cd0 - RapidIO Outbound Attributes Register 6 */
+	uint8_t		res31[12];
+	uint32_t	rowtar7;	/* 0xd0ce0 - RapidIO Outbound Window Translation Address Register 7 */
+	uint8_t		res32[4];
+	uint32_t	rowbar7;	/* 0xd0ce8 - RapidIO Outbound Window Base Address Register 7 */
+	uint8_t		res33[4];
+	uint32_t	rowar7;		/* 0xd0cf0 - RapidIO Outbound Attributes Register 7 */
+	uint8_t		res34[12];
+	uint32_t	rowtar8;	/* 0xd0d00 - RapidIO Outbound Window Translation Address Register 8 */
+	uint8_t		res35[4];
+	uint32_t	rowbar8;	/* 0xd0d08 - RapidIO Outbound Window Base Address Register 8 */
+	uint8_t		res36[4];
+	uint32_t	rowar8;		/* 0xd0d10 - RapidIO Outbound Attributes Register 8 */
+	uint8_t		res37[76];
+	uint32_t	riwtar4;	/* 0xd0d60 - RapidIO Inbound Window Translation Address Register 4 */
+	uint8_t		res38[4];
+	uint32_t	riwbar4;	/* 0xd0d68 - RapidIO Inbound Window Base Address Register 4 */
+	uint8_t		res39[4];
+	uint32_t	riwar4;		/* 0xd0d70 - RapidIO Inbound Attributes Register 4 */
+	uint8_t		res40[12];
+	uint32_t	riwtar3;	/* 0xd0d80 - RapidIO Inbound Window Translation Address Register 3 */
+	uint8_t		res41[4];
+	uint32_t	riwbar3;	/* 0xd0d88 - RapidIO Inbound Window Base Address Register 3 */
+	uint8_t		res42[4];
+	uint32_t	riwar3;		/* 0xd0d90 - RapidIO Inbound Attributes Register 3 */
+	uint8_t		res43[12];
+	uint32_t	riwtar2;	/* 0xd0da0 - RapidIO Inbound Window Translation Address Register 2 */
+	uint8_t		res44[4];
+	uint32_t	riwbar2;	/* 0xd0da8 - RapidIO Inbound Window Base Address Register 2 */
+	uint8_t		res45[4];
+	uint32_t	riwar2;		/* 0xd0db0 - RapidIO Inbound Attributes Register 2 */
+	uint8_t		res46[12];
+	uint32_t	riwtar1;	/* 0xd0dc0 - RapidIO Inbound Window Translation Address Register 1 */
+	uint8_t		res47[4];
+	uint32_t	riwbar1;	/* 0xd0dc8 - RapidIO Inbound Window Base Address Register 1 */
+	uint8_t		res48[4];
+	uint32_t	riwar1;		/* 0xd0dd0 - RapidIO Inbound Attributes Register 1 */
+	uint8_t		res49[12];
+	uint32_t	riwtar0;	/* 0xd0de0 - RapidIO Inbound Window Translation Address Register 0 */
+	uint8_t		res50[12];
+	uint32_t	riwar0;		/* 0xd0df0 - RapidIO Inbound Attributes Register 0 */
+	uint8_t		res51[12];
+	uint32_t	pnfedr;		/* 0xd0e00 - Port Notification/Fatal Error Detect Register */
+	uint32_t	pnfedir;	/* 0xd0e04 - Port Notification/Fatal Error Detect Register */
+	uint32_t	pnfeier;	/* 0xd0e08 - Port Notification/Fatal Error Interrupt Enable Register */
+	uint32_t	pecr;		/* 0xd0e0c - Port Error Control Register */
+	uint32_t	pepcsr0;	/* 0xd0e10 - Port Error Packet/Control Symbol Register 0 */
+	uint32_t	pepr1;		/* 0xd0e14 - Port Error Packet Register 1 */
+	uint32_t	pepr2;		/* 0xd0e18 - Port Error Packet Register 2 */
+	uint8_t		res52[4];
+	uint32_t	predr;		/* 0xd0e20 - Port Recoverable Error Detect Register */
+	uint8_t		res53[4];
+	uint32_t	pertr;		/* 0xd0e28 - Port Error Recovery Threshold Register */
+	uint32_t	prtr;		/* 0xd0e2c - Port Retry Threshold Register */
+	uint8_t		res54[464];
+	uint32_t	omr;		/* 0xd1000 - Outbound Mode Register */
+	uint32_t	osr;		/* 0xd1004 - Outbound Status Register */
+	uint32_t	eodqtpar;	/* 0xd1008 - Extended Outbound Descriptor Queue Tail Pointer Address Register */
+	uint32_t	odqtpar;	/* 0xd100c - Outbound Descriptor Queue Tail Pointer Address Register */
+	uint32_t	eosar;		/* 0xd1010 - Extended Outbound Unit Source Address Register */
+	uint32_t	osar;		/* 0xd1014 - Outbound Unit Source Address Register */
+	uint32_t	odpr;		/* 0xd1018 - Outbound Destination Port Register */
+	uint32_t	odatr;		/* 0xd101c - Outbound Destination Attributes Register */
+	uint32_t	odcr;		/* 0xd1020 - Outbound Doubleword Count Register */
+	uint32_t	eodqhpar;	/* 0xd1024 - Extended Outbound Descriptor Queue Head Pointer Address Register */
+	uint32_t	odqhpar;	/* 0xd1028 - Outbound Descriptor Queue Head Pointer Address Register */
+	uint8_t		res55[52];
+	uint32_t	imr;		/* 0xd1060 - Outbound Mode Register */
+	uint32_t	isr;		/* 0xd1064 - Inbound Status Register */
+	uint32_t	eidqtpar;	/* 0xd1068 - Extended Inbound Descriptor Queue Tail Pointer Address Register */
+	uint32_t	idqtpar;	/* 0xd106c - Inbound Descriptor Queue Tail Pointer Address Register */
+	uint32_t	eifqhpar;	/* 0xd1070 - Extended Inbound Frame Queue Head Pointer Address Register */
+	uint32_t	ifqhpar;	/* 0xd1074 - Inbound Frame Queue Head Pointer Address Register */
+	uint8_t		res56[1000];
+	uint32_t	dmr;		/* 0xd1460 - Doorbell Mode Register */
+	uint32_t	dsr;		/* 0xd1464 - Doorbell Status Register */
+	uint32_t	edqtpar;	/* 0xd1468 - Extended Doorbell Queue Tail Pointer Address Register */
+	uint32_t	dqtpar;		/* 0xd146c - Doorbell Queue Tail Pointer Address Register */
+	uint32_t	edqhpar;	/* 0xd1470 - Extended Doorbell Queue Head Pointer Address Register */
+	uint32_t	dqhpar;		/* 0xd1474 - Doorbell Queue Head Pointer Address Register */
+	uint8_t		res57[104];
+	uint32_t	pwmr;		/* 0xd14e0 - Port-Write Mode Register */
+	uint32_t	pwsr;		/* 0xd14e4 - Port-Write Status Register */
+	uint32_t	epwqbar;	/* 0xd14e8 - Extended Port-Write Queue Base Address Register */
+	uint32_t	pwqbar;		/* 0xd14ec - Port-Write Queue Base Address Register */
+	uint8_t		res58[60176];
+} ccsr_rio_t;
+
+/* Global Utilities Register Block(0xe_0000-0xf_ffff) */
 typedef struct ccsr_guts {
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
+	uint32_t	porpllsr;	/* 0xe0000 - POR PLL ratio status register */
+	uint32_t	porbmsr;	/* 0xe0004 - POR boot mode status register */
+	uint32_t	porimpscr;	/* 0xe0008 - POR I/O impedance status and control register */
+	uint32_t	pordevsr;	/* 0xe000c - POR I/O device status regsiter */
+	uint32_t	pordbgmsr;	/* 0xe0010 - POR debug mode status register */
+	uint8_t		res1[12];
+	uint32_t	gpporcr;	/* 0xe0020 - General-purpose POR configuration register */
+	uint8_t		res2[12];
+	uint32_t	gpiocr;		/* 0xe0030 - GPIO control register */
+	uint8_t		res3[12];
+	uint32_t	gpoutdr;	/* 0xe0040 - General-purpose output data register */
+	uint8_t		res4[12];
+	uint32_t	gpindr;		/* 0xe0050 - General-purpose input data register */
+	uint8_t		res5[12];
+	uint32_t	pmuxcr;		/* 0xe0060 - Alternate function signal multiplex control */
+	uint8_t		res6[12];
+	uint32_t	devdisr;	/* 0xe0070 - Device disable control */
+	uint8_t		res7[12];
+	uint32_t	powmgtcsr;	/* 0xe0080 - Power management status and control register */
+	uint8_t		res8[12];
+	uint32_t	mcpsumr;	/* 0xe0090 - Machine check summary register */
+	uint8_t		res9[12];
+	uint32_t	pvr;		/* 0xe00a0 - Processor version register */
+	uint32_t	svr;		/* 0xe00a4 - System version register */
+	uint8_t		res10[3416];
+	uint32_t	clkocr;		/* 0xe0e00 - Clock out select register */
+	uint8_t		res11[12];
+	uint32_t	ddrdllcr;	/* 0xe0e10 - DDR DLL control register */
+	uint8_t		res12[12];
+	uint32_t	lbcdllcr;	/* 0xe0e20 - LBC DLL control register */
+	uint8_t		res13[61915];
+/* FIXME */				/* Performance monitor, Watchdog, Trace Buffers, Context ID, others */
 } ccsr_guts_t;
 
+typedef struct ccsr {
+	ccsr_ccsr_t		im_ccsr;
+	ccsr_law_t		im_law;
+	ccsr_ecm_t		im_ecm;
+	ccsr_ddr_t		im_ddr;
+	ccsr_i2c_t		im_i2c;
+	ccsr_duart_t		im_duart;
+	ccsr_lbc_t		im_lbc;
+	ccsr_pci_t		im_pci;
+	ccsr_l2cache_t		im_l2cache;
+	ccsr_dma_t		im_dma;
+	ccsr_tsec_t		im_tsec[2];
+	ccsr_fec_t		im_fec;
+	ccsr_pic_t		im_pic;
+	ccsr_cpm2_t		im_cpm;
+	ccsr_rio_t		im_rio;
+	ccsr_guts_t		im_guts;
+} ccsr_t;
+
+extern volatile ccsr_t *immap;
+
 #endif /* __ASM_IMMAP_85XX_H__ */
 #endif /* __KERNEL__ */

--------------010908010106090709010301--

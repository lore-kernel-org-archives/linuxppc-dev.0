Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 7A25367D98
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Oct 2006 14:11:54 +1000 (EST)
Date: Tue, 3 Oct 2006 23:11:31 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2.2/7] Add QUICC Engine (QE) infrastructure (2/2, try 2)
Message-Id: <20061003231131.22bb6e9d.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Li Yang <leoli@freescale.com>

note: linuxppc-dev rejected patch 2/7, so I split 2/7 into two, of which this is the second and last.

See "[PATCH 2.1/7] Add QUICC Engine (QE) infrastructure (1/2)" for a description of what's changed.

Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Shlomi Gridish <gridish@freescale.com>
Signed-off-by: Kim Phillips <kim.phillips@freescale.com>

---
 arch/powerpc/Kconfig           |   12 +
 arch/powerpc/sysdev/Makefile   |    1 
 include/asm-powerpc/immap_qe.h |  477 ++++++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/qe.h       |  457 ++++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/qe_ic.h    |   64 +++++
 include/asm-powerpc/ucc.h      |   84 +++++++
 include/asm-powerpc/ucc_fast.h |  243 ++++++++++++++++++++
 include/asm-powerpc/ucc_slow.h |  289 ++++++++++++++++++++++++
 include/linux/fsl_devices.h    |   65 ++++-
 9 files changed, 1678 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index de1ef2f..e8446b8 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -355,6 +355,16 @@ config APUS
 	  <http://linux-apus.sourceforge.net/>.
 endchoice
 
+config QUICC_ENGINE
+	bool
+	depends on PPC_MPC836x || PPC_MPC832x
+	default y
+	help
+	  The QUICC Engine (QE) is a new generation of communications
+	  coprocessors on Freescale embedded CPUs (akin to CPM in older chips).
+	  Selecting this option means that you wish to build a kernel
+	  for a machine with a QE coprocessor.
+
 config PPC_PSERIES
 	depends on PPC_MULTIPLATFORM && PPC64
 	bool "IBM pSeries & new (POWER5-based) iSeries"
@@ -1059,6 +1069,8 @@ # XXX source "arch/ppc/8xx_io/Kconfig"
 
 # XXX source "arch/ppc/8260_io/Kconfig"
 
+source "arch/powerpc/sysdev/qe_lib/Kconfig"
+
 source "arch/powerpc/platforms/iseries/Kconfig"
 
 source "lib/Kconfig"
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index f15f4d7..91f052d 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_MMIO_NVRAM)	+= mmio_nvram.o
 obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
 obj-$(CONFIG_PPC_TODC)		+= todc.o
 obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
+obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
 
 ifeq ($(CONFIG_PPC_MERGE),y)
 obj-$(CONFIG_PPC_I8259)		+= i8259.o
diff --git a/include/asm-powerpc/immap_qe.h b/include/asm-powerpc/immap_qe.h
new file mode 100644
index 0000000..ce12f85
--- /dev/null
+++ b/include/asm-powerpc/immap_qe.h
@@ -0,0 +1,477 @@
+/*
+ * include/asm-powerpc/immap_qe.h
+ *
+ * QUICC Engine (QE) Internal Memory Map.
+ * The Internal Memory Map for devices with QE on them. This
+ * is the superset of all QE devices (8360, etc.).
+
+ * Copyright (C) 2006. Freescale Semicondutor, Inc. All rights reserved.
+ *
+ * Authors: 	Shlomi Gridish <gridish@freescale.com>
+ * 		Li Yang <leoli@freescale.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#ifndef _ASM_POWERPC_IMMAP_QE_H
+#define _ASM_POWERPC_IMMAP_QE_H
+#ifdef __KERNEL__
+
+#include <linux/kernel.h>
+
+#define QE_IMMAP_SIZE	(1024 * 1024)	/* 1MB from 1MB+IMMR */
+
+/* QE I-RAM */
+struct qe_iram {
+	__be32	iadd;		/* I-RAM Address Register */
+	__be32	idata;		/* I-RAM Data Register */
+	u8	res0[0x78];
+} __attribute__ ((packed));
+
+/* QE Interrupt Controller */
+struct qe_ic_regs {
+	__be32	qicr;
+	__be32	qivec;
+	__be32	qripnr;
+	__be32	qipnr;
+	__be32	qipxcc;
+	__be32	qipycc;
+	__be32	qipwcc;
+	__be32	qipzcc;
+	__be32	qimr;
+	__be32	qrimr;
+	__be32	qicnr;
+	u8	res0[0x4];
+	__be32	qiprta;
+	__be32	qiprtb;
+	u8	res1[0x4];
+	__be32	qricr;
+	u8	res2[0x20];
+	__be32	qhivec;
+	u8	res3[0x1C];
+} __attribute__ ((packed));
+
+/* Communications Processor */
+struct cp_qe {
+	__be32	cecr;		/* QE command register */
+	__be32	ceccr;		/* QE controller configuration register */
+	__be32	cecdr;		/* QE command data register */
+	u8	res0[0xA];
+	__be16	ceter;		/* QE timer event register */
+	u8	res1[0x2];
+	__be16	cetmr;		/* QE timers mask register */
+	__be32	cetscr;		/* QE time-stamp timer control register */
+	__be32	cetsr1;		/* QE time-stamp register 1 */
+	__be32	cetsr2;		/* QE time-stamp register 2 */
+	u8	res2[0x8];
+	__be32	cevter;		/* QE virtual tasks event register */
+	__be32	cevtmr;		/* QE virtual tasks mask register */
+	__be16	cercr;		/* QE RAM control register */
+	u8	res3[0x2];
+	u8	res4[0x24];
+	__be16	ceexe1;		/* QE external request 1 event register */
+	u8	res5[0x2];
+	__be16	ceexm1;		/* QE external request 1 mask register */
+	u8	res6[0x2];
+	__be16	ceexe2;		/* QE external request 2 event register */
+	u8	res7[0x2];
+	__be16	ceexm2;		/* QE external request 2 mask register */
+	u8	res8[0x2];
+	__be16	ceexe3;		/* QE external request 3 event register */
+	u8	res9[0x2];
+	__be16	ceexm3;		/* QE external request 3 mask register */
+	u8	res10[0x2];
+	__be16	ceexe4;		/* QE external request 4 event register */
+	u8	res11[0x2];
+	__be16	ceexm4;		/* QE external request 4 mask register */
+	u8	res12[0x2];
+	u8	res13[0x280];
+} __attribute__ ((packed));
+
+/* QE Multiplexer */
+struct qe_mux {
+	__be32	cmxgcr;		/* CMX general clock route register */
+	__be32	cmxsi1cr_l;	/* CMX SI1 clock route low register */
+	__be32	cmxsi1cr_h;	/* CMX SI1 clock route high register */
+	__be32	cmxsi1syr;	/* CMX SI1 SYNC route register */
+	__be32	cmxucr1;	/* CMX UCC1, UCC3 clock route register */
+	__be32	cmxucr2;	/* CMX UCC5, UCC7 clock route register */
+	__be32	cmxucr3;	/* CMX UCC2, UCC4 clock route register */
+	__be32	cmxucr4;	/* CMX UCC6, UCC8 clock route register */
+	__be32	cmxupcr;	/* CMX UPC clock route register */
+	u8	res0[0x1C];
+} __attribute__ ((packed));
+
+/* QE Timers */
+struct qe_timers {
+	u8	gtcfr1;		/* Timer 1 and Timer 2 global config register*/
+	u8	res0[0x3];
+	u8	gtcfr2;		/* Timer 3 and timer 4 global config register*/
+	u8	res1[0xB];
+	__be16	gtmdr1;		/* Timer 1 mode register */
+	__be16	gtmdr2;		/* Timer 2 mode register */
+	__be16	gtrfr1;		/* Timer 1 reference register */
+	__be16	gtrfr2;		/* Timer 2 reference register */
+	__be16	gtcpr1;		/* Timer 1 capture register */
+	__be16	gtcpr2;		/* Timer 2 capture register */
+	__be16	gtcnr1;		/* Timer 1 counter */
+	__be16	gtcnr2;		/* Timer 2 counter */
+	__be16	gtmdr3;		/* Timer 3 mode register */
+	__be16	gtmdr4;		/* Timer 4 mode register */
+	__be16	gtrfr3;		/* Timer 3 reference register */
+	__be16	gtrfr4;		/* Timer 4 reference register */
+	__be16	gtcpr3;		/* Timer 3 capture register */
+	__be16	gtcpr4;		/* Timer 4 capture register */
+	__be16	gtcnr3;		/* Timer 3 counter */
+	__be16	gtcnr4;		/* Timer 4 counter */
+	__be16	gtevr1;		/* Timer 1 event register */
+	__be16	gtevr2;		/* Timer 2 event register */
+	__be16	gtevr3;		/* Timer 3 event register */
+	__be16	gtevr4;		/* Timer 4 event register */
+	__be16	gtps;		/* Timer 1 prescale register */
+	u8 res2[0x46];
+} __attribute__ ((packed));
+
+/* BRG */
+struct qe_brg {
+	__be32	brgc1;		/* BRG1 configuration register */
+	__be32	brgc2;		/* BRG2 configuration register */
+	__be32	brgc3;		/* BRG3 configuration register */
+	__be32	brgc4;		/* BRG4 configuration register */
+	__be32	brgc5;		/* BRG5 configuration register */
+	__be32	brgc6;		/* BRG6 configuration register */
+	__be32	brgc7;		/* BRG7 configuration register */
+	__be32	brgc8;		/* BRG8 configuration register */
+	__be32	brgc9;		/* BRG9 configuration register */
+	__be32	brgc10;		/* BRG10 configuration register */
+	__be32	brgc11;		/* BRG11 configuration register */
+	__be32	brgc12;		/* BRG12 configuration register */
+	__be32	brgc13;		/* BRG13 configuration register */
+	__be32	brgc14;		/* BRG14 configuration register */
+	__be32	brgc15;		/* BRG15 configuration register */
+	__be32	brgc16;		/* BRG16 configuration register */
+	u8	res0[0x40];
+} __attribute__ ((packed));
+
+/* SPI */
+struct spi {
+	u8	res0[0x20];
+	__be32	spmode;		/* SPI mode register */
+	u8	res1[0x2];
+	u8	spie;		/* SPI event register */
+	u8	res2[0x1];
+	u8	res3[0x2];
+	u8	spim;		/* SPI mask register */
+	u8	res4[0x1];
+	u8	res5[0x1];
+	u8	spcom;		/* SPI command register */
+	u8	res6[0x2];
+	__be32	spitd;		/* SPI transmit data register (cpu mode) */
+	__be32	spird;		/* SPI receive data register (cpu mode) */
+	u8	res7[0x8];
+} __attribute__ ((packed));
+
+/* SI */
+struct si1 {
+	__be16	siamr1;		/* SI1 TDMA mode register */
+	__be16	sibmr1;		/* SI1 TDMB mode register */
+	__be16	sicmr1;		/* SI1 TDMC mode register */
+	__be16	sidmr1;		/* SI1 TDMD mode register */
+	u8	siglmr1_h;	/* SI1 global mode register high */
+	u8	res0[0x1];
+	u8	sicmdr1_h;	/* SI1 command register high */
+	u8	res2[0x1];
+	u8	sistr1_h;	/* SI1 status register high */
+	u8	res3[0x1];
+	__be16	sirsr1_h;	/* SI1 RAM shadow address register high */
+	u8	sitarc1;	/* SI1 RAM counter Tx TDMA */
+	u8	sitbrc1;	/* SI1 RAM counter Tx TDMB */
+	u8	sitcrc1;	/* SI1 RAM counter Tx TDMC */
+	u8	sitdrc1;	/* SI1 RAM counter Tx TDMD */
+	u8	sirarc1;	/* SI1 RAM counter Rx TDMA */
+	u8	sirbrc1;	/* SI1 RAM counter Rx TDMB */
+	u8	sircrc1;	/* SI1 RAM counter Rx TDMC */
+	u8	sirdrc1;	/* SI1 RAM counter Rx TDMD */
+	u8	res4[0x8];
+	__be16	siemr1;		/* SI1 TDME mode register 16 bits */
+	__be16	sifmr1;		/* SI1 TDMF mode register 16 bits */
+	__be16	sigmr1;		/* SI1 TDMG mode register 16 bits */
+	__be16	sihmr1;		/* SI1 TDMH mode register 16 bits */
+	u8	siglmg1_l;	/* SI1 global mode register low 8 bits */
+	u8	res5[0x1];
+	u8	sicmdr1_l;	/* SI1 command register low 8 bits */
+	u8	res6[0x1];
+	u8	sistr1_l;	/* SI1 status register low 8 bits */
+	u8	res7[0x1];
+	__be16	sirsr1_l;	/* SI1 RAM shadow address register low 16 bits*/
+	u8	siterc1;	/* SI1 RAM counter Tx TDME 8 bits */
+	u8	sitfrc1;	/* SI1 RAM counter Tx TDMF 8 bits */
+	u8	sitgrc1;	/* SI1 RAM counter Tx TDMG 8 bits */
+	u8	sithrc1;	/* SI1 RAM counter Tx TDMH 8 bits */
+	u8	sirerc1;	/* SI1 RAM counter Rx TDME 8 bits */
+	u8	sirfrc1;	/* SI1 RAM counter Rx TDMF 8 bits */
+	u8	sirgrc1;	/* SI1 RAM counter Rx TDMG 8 bits */
+	u8	sirhrc1;	/* SI1 RAM counter Rx TDMH 8 bits */
+	u8	res8[0x8];
+	__be32	siml1;		/* SI1 multiframe limit register */
+	u8	siedm1;		/* SI1 extended diagnostic mode register */
+	u8	res9[0xBB];
+} __attribute__ ((packed));
+
+/* SI Routing Tables */
+struct sir {
+	u8 	tx[0x400];
+	u8	rx[0x400];
+	u8	res0[0x800];
+} __attribute__ ((packed));
+
+/* USB Controller */
+struct usb_ctlr {
+	u8	usb_usmod;
+	u8	usb_usadr;
+	u8	usb_uscom;
+	u8	res1[1];
+	__be16	usb_usep1;
+	__be16	usb_usep2;
+	__be16	usb_usep3;
+	__be16	usb_usep4;
+	u8	res2[4];
+	__be16	usb_usber;
+	u8	res3[2];
+	__be16	usb_usbmr;
+	u8	res4[1];
+	u8	usb_usbs;
+	__be16	usb_ussft;
+	u8	res5[2];
+	__be16	usb_usfrn;
+	u8	res6[0x22];
+} __attribute__ ((packed));
+
+/* MCC */
+struct mcc {
+	__be32	mcce;		/* MCC event register */
+	__be32	mccm;		/* MCC mask register */
+	__be32	mccf;		/* MCC configuration register */
+	__be32	merl;		/* MCC emergency request level register */
+	u8	res0[0xF0];
+} __attribute__ ((packed));
+
+/* QE UCC Slow */
+struct ucc_slow {
+	__be32	gumr_l;		/* UCCx general mode register (low) */
+	__be32	gumr_h;		/* UCCx general mode register (high) */
+	__be16	upsmr;		/* UCCx protocol-specific mode register */
+	u8	res0[0x2];
+	__be16	utodr;		/* UCCx transmit on demand register */
+	__be16	udsr;		/* UCCx data synchronization register */
+	__be16	ucce;		/* UCCx event register */
+	u8	res1[0x2];
+	__be16	uccm;		/* UCCx mask register */
+	u8	res2[0x1];
+	u8	uccs;		/* UCCx status register */
+	u8	res3[0x24];
+	__be16	utpt;
+	u8	guemr;		/* UCC general extended mode register */
+	u8	res4[0x200 - 0x091];
+} __attribute__ ((packed));
+
+/* QE UCC Fast */
+struct ucc_fast {
+	__be32	gumr;		/* UCCx general mode register */
+	__be32	upsmr;		/* UCCx protocol-specific mode register */
+	__be16	utodr;		/* UCCx transmit on demand register */
+	u8	res0[0x2];
+	__be16	udsr;		/* UCCx data synchronization register */
+	u8	res1[0x2];
+	__be32	ucce;		/* UCCx event register */
+	__be32	uccm;		/* UCCx mask register */
+	u8	uccs;		/* UCCx status register */
+	u8	res2[0x7];
+	__be32	urfb;		/* UCC receive FIFO base */
+	__be16	urfs;		/* UCC receive FIFO size */
+	u8	res3[0x2];
+	__be16	urfet;		/* UCC receive FIFO emergency threshold */
+	__be16	urfset;		/* UCC receive FIFO special emergency
+				   threshold */
+	__be32	utfb;		/* UCC transmit FIFO base */
+	__be16	utfs;		/* UCC transmit FIFO size */
+	u8	res4[0x2];
+	__be16	utfet;		/* UCC transmit FIFO emergency threshold */
+	u8	res5[0x2];
+	__be16	utftt;		/* UCC transmit FIFO transmit threshold */
+	u8	res6[0x2];
+	__be16	utpt;		/* UCC transmit polling timer */
+	u8	res7[0x2];
+	__be32	urtry;		/* UCC retry counter register */
+	u8	res8[0x4C];
+	u8	guemr;		/* UCC general extended mode register */
+	u8	res9[0x100 - 0x091];
+} __attribute__ ((packed));
+
+/* QE UCC */
+struct ucc_common {
+	u8	res1[0x90];
+	u8	guemr;
+	u8	res2[0x200 - 0x091];
+} __attribute__ ((packed));
+
+struct ucc {
+	union {
+		struct	ucc_slow slow;
+		struct	ucc_fast fast;
+		struct	ucc_common common;
+	};
+} __attribute__ ((packed));
+
+/* MultiPHY UTOPIA POS Controllers (UPC) */
+struct upc {
+	__be32	upgcr;		/* UTOPIA/POS general configuration register */
+	__be32	uplpa;		/* UTOPIA/POS last PHY address */
+	__be32	uphec;		/* ATM HEC register */
+	__be32	upuc;		/* UTOPIA/POS UCC configuration */
+	__be32	updc1;		/* UTOPIA/POS device 1 configuration */
+	__be32	updc2;		/* UTOPIA/POS device 2 configuration */
+	__be32	updc3;		/* UTOPIA/POS device 3 configuration */
+	__be32	updc4;		/* UTOPIA/POS device 4 configuration */
+	__be32	upstpa;		/* UTOPIA/POS STPA threshold */
+	u8	res0[0xC];
+	__be32	updrs1_h;	/* UTOPIA/POS device 1 rate select */
+	__be32	updrs1_l;	/* UTOPIA/POS device 1 rate select */
+	__be32	updrs2_h;	/* UTOPIA/POS device 2 rate select */
+	__be32	updrs2_l;	/* UTOPIA/POS device 2 rate select */
+	__be32	updrs3_h;	/* UTOPIA/POS device 3 rate select */
+	__be32	updrs3_l;	/* UTOPIA/POS device 3 rate select */
+	__be32	updrs4_h;	/* UTOPIA/POS device 4 rate select */
+	__be32	updrs4_l;	/* UTOPIA/POS device 4 rate select */
+	__be32	updrp1;		/* UTOPIA/POS device 1 receive priority low */
+	__be32	updrp2;		/* UTOPIA/POS device 2 receive priority low */
+	__be32	updrp3;		/* UTOPIA/POS device 3 receive priority low */
+	__be32	updrp4;		/* UTOPIA/POS device 4 receive priority low */
+	__be32	upde1;		/* UTOPIA/POS device 1 event */
+	__be32	upde2;		/* UTOPIA/POS device 2 event */
+	__be32	upde3;		/* UTOPIA/POS device 3 event */
+	__be32	upde4;		/* UTOPIA/POS device 4 event */
+	__be16	uprp1;
+	__be16	uprp2;
+	__be16	uprp3;
+	__be16	uprp4;
+	u8	res1[0x8];
+	__be16	uptirr1_0;	/* Device 1 transmit internal rate 0 */
+	__be16	uptirr1_1;	/* Device 1 transmit internal rate 1 */
+	__be16	uptirr1_2;	/* Device 1 transmit internal rate 2 */
+	__be16	uptirr1_3;	/* Device 1 transmit internal rate 3 */
+	__be16	uptirr2_0;	/* Device 2 transmit internal rate 0 */
+	__be16	uptirr2_1;	/* Device 2 transmit internal rate 1 */
+	__be16	uptirr2_2;	/* Device 2 transmit internal rate 2 */
+	__be16	uptirr2_3;	/* Device 2 transmit internal rate 3 */
+	__be16	uptirr3_0;	/* Device 3 transmit internal rate 0 */
+	__be16	uptirr3_1;	/* Device 3 transmit internal rate 1 */
+	__be16	uptirr3_2;	/* Device 3 transmit internal rate 2 */
+	__be16	uptirr3_3;	/* Device 3 transmit internal rate 3 */
+	__be16	uptirr4_0;	/* Device 4 transmit internal rate 0 */
+	__be16	uptirr4_1;	/* Device 4 transmit internal rate 1 */
+	__be16	uptirr4_2;	/* Device 4 transmit internal rate 2 */
+	__be16	uptirr4_3;	/* Device 4 transmit internal rate 3 */
+	__be32	uper1;		/* Device 1 port enable register */
+	__be32	uper2;		/* Device 2 port enable register */
+	__be32	uper3;		/* Device 3 port enable register */
+	__be32	uper4;		/* Device 4 port enable register */
+	u8	res2[0x150];
+} __attribute__ ((packed));
+
+/* SDMA */
+struct sdma {
+	__be32	sdsr;		/* Serial DMA status register */
+	__be32	sdmr;		/* Serial DMA mode register */
+	__be32	sdtr1;		/* SDMA system bus threshold register */
+	__be32	sdtr2;		/* SDMA secondary bus threshold register */
+	__be32	sdhy1;		/* SDMA system bus hysteresis register */
+	__be32	sdhy2;		/* SDMA secondary bus hysteresis register */
+	__be32	sdta1;		/* SDMA system bus address register */
+	__be32	sdta2;		/* SDMA secondary bus address register */
+	__be32	sdtm1;		/* SDMA system bus MSNUM register */
+	__be32	sdtm2;		/* SDMA secondary bus MSNUM register */
+	u8	res0[0x10];
+	__be32	sdaqr;		/* SDMA address bus qualify register */
+	__be32	sdaqmr;		/* SDMA address bus qualify mask register */
+	u8	res1[0x4];
+	__be32	sdebcr;		/* SDMA CAM entries base register */
+	u8	res2[0x38];
+} __attribute__ ((packed));
+
+/* Debug Space */
+struct dbg {
+	__be32	bpdcr;		/* Breakpoint debug command register */
+	__be32	bpdsr;		/* Breakpoint debug status register */
+	__be32	bpdmr;		/* Breakpoint debug mask register */
+	__be32	bprmrr0;	/* Breakpoint request mode risc register 0 */
+	__be32	bprmrr1;	/* Breakpoint request mode risc register 1 */
+	u8	res0[0x8];
+	__be32	bprmtr0;	/* Breakpoint request mode trb register 0 */
+	__be32	bprmtr1;	/* Breakpoint request mode trb register 1 */
+	u8	res1[0x8];
+	__be32	bprmir;		/* Breakpoint request mode immediate register */
+	__be32	bprmsr;		/* Breakpoint request mode serial register */
+	__be32	bpemr;		/* Breakpoint exit mode register */
+	u8	res2[0x48];
+} __attribute__ ((packed));
+
+/* RISC Special Registers (Trap and Breakpoint) */
+struct rsp {
+	u8	fixme[0x100];
+} __attribute__ ((packed));
+
+struct qe_immap {
+	struct qe_iram		iram;		/* I-RAM */
+	struct qe_ic_regs	ic;		/* Interrupt Controller */
+	struct cp_qe		cp;		/* Communications Processor */
+	struct qe_mux		qmx;		/* QE Multiplexer */
+	struct qe_timers	qet;		/* QE Timers */
+	struct spi		spi[0x2];	/* spi */
+	struct mcc		mcc;		/* mcc */
+	struct qe_brg		brg;		/* brg */
+	struct usb_ctlr		usb;		/* USB */
+	struct si1		si1;		/* SI */
+	u8			res11[0x800];
+	struct sir		sir;		/* SI Routing Tables */
+	struct ucc		ucc1;		/* ucc1 */
+	struct ucc		ucc3;		/* ucc3 */
+	struct ucc		ucc5;		/* ucc5 */
+	struct ucc		ucc7;		/* ucc7 */
+	u8			res12[0x600];
+	struct upc		upc1;		/* MultiPHY UTOPIA POS Ctrlr 1*/
+	struct ucc		ucc2;		/* ucc2 */
+	struct ucc		ucc4;		/* ucc4 */
+	struct ucc		ucc6;		/* ucc6 */
+	struct ucc		ucc8;		/* ucc8 */
+	u8			res13[0x600];
+	struct upc		upc2;		/* MultiPHY UTOPIA POS Ctrlr 2*/
+	struct sdma		sdma;		/* SDMA */
+	struct dbg		dbg;		/* Debug Space */
+	struct rsp		rsp[0x2];	/* RISC Special Registers
+						   (Trap and Breakpoint) */
+	u8			res14[0x300];
+	u8			res15[0x3A00];
+	u8			res16[0x8000];	/* 0x108000 - 0x110000 */
+	u8			muram[0xC000];	/* 0x110000 - 0x11C000
+						   Multi-user RAM */
+	u8			res17[0x24000];	/* 0x11C000 - 0x140000 */
+	u8			res18[0xC0000];	/* 0x140000 - 0x200000 */
+} __attribute__ ((packed));
+
+extern struct qe_immap *qe_immr;
+extern phys_addr_t get_qe_base(void);
+
+static inline unsigned long immrbar_virt_to_phys(volatile void * address)
+{
+	if ( ((u32)address >= (u32)qe_immr) &&
+			((u32)address < ((u32)qe_immr + QE_IMMAP_SIZE)) )
+		return (unsigned long)(address - (u32)qe_immr +
+				(u32)get_qe_base());
+	return (unsigned long)virt_to_phys(address);
+}
+
+#endif /* __KERNEL__ */
+#endif /* _ASM_POWERPC_IMMAP_QE_H */
diff --git a/include/asm-powerpc/qe.h b/include/asm-powerpc/qe.h
new file mode 100644
index 0000000..a62168e
--- /dev/null
+++ b/include/asm-powerpc/qe.h
@@ -0,0 +1,457 @@
+/*
+ * Copyright (C) 2006 Freescale Semicondutor, Inc. All rights reserved.
+ *
+ * Authors: 	Shlomi Gridish <gridish@freescale.com>
+ * 		Li Yang <leoli@freescale.com>
+ *
+ * Description:
+ * QUICC Engine (QE) external definitions and structure.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#ifndef _ASM_POWERPC_QE_H
+#define _ASM_POWERPC_QE_H
+#ifdef __KERNEL__
+
+#include <asm/immap_qe.h>
+
+#define QE_NUM_OF_SNUM	28
+#define QE_NUM_OF_BRGS	16
+#define QE_NUM_OF_PORTS	1024
+
+/* Memory partitions
+*/
+#define MEM_PART_SYSTEM		0
+#define MEM_PART_SECONDARY	1
+#define MEM_PART_MURAM		2
+
+/* Export QE common operations */
+extern void qe_reset(void);
+extern int par_io_init(struct device_node *np);
+extern int par_io_of_config(struct device_node *np);
+
+/* QE internal API */
+int qe_issue_cmd(u32 cmd, u32 device, u8 mcn_protocol, u32 cmd_input);
+void qe_setbrg(u32 brg, u32 rate);
+int qe_get_snum(void);
+void qe_put_snum(u8 snum);
+u32 qe_muram_alloc(u32 size, u32 align);
+int qe_muram_free(u32 offset);
+u32 qe_muram_alloc_fixed(u32 offset, u32 size);
+void qe_muram_dump(void);
+void *qe_muram_addr(u32 offset);
+
+/* Buffer descriptors */
+struct qe_bd {
+	u16 status;
+	u16 length;
+	u32 buf;
+} __attribute__ ((packed));
+
+#define BD_STATUS_MASK	0xffff0000
+#define BD_LENGTH_MASK	0x0000ffff
+
+/* Alignment */
+#define QE_INTR_TABLE_ALIGN	16	/* ??? */
+#define QE_ALIGNMENT_OF_BD	8
+#define QE_ALIGNMENT_OF_PRAM	64
+
+/* RISC allocation */
+enum qe_risc_allocation {
+	QE_RISC_ALLOCATION_RISC1 = 1,	/* RISC 1 */
+	QE_RISC_ALLOCATION_RISC2 = 2,	/* RISC 2 */
+	QE_RISC_ALLOCATION_RISC1_AND_RISC2 = 3	/* Dynamically choose
+						   RISC 1 or RISC 2 */
+};
+
+/* QE extended filtering Table Lookup Key Size */
+enum qe_fltr_tbl_lookup_key_size {
+	QE_FLTR_TABLE_LOOKUP_KEY_SIZE_8_BYTES
+		= 0x3f,		/* LookupKey parsed by the Generate LookupKey
+				   CMD is truncated to 8 bytes */
+	QE_FLTR_TABLE_LOOKUP_KEY_SIZE_16_BYTES
+		= 0x5f,		/* LookupKey parsed by the Generate LookupKey
+				   CMD is truncated to 16 bytes */
+};
+
+/* QE FLTR extended filtering Largest External Table Lookup Key Size */
+enum qe_fltr_largest_external_tbl_lookup_key_size {
+	QE_FLTR_LARGEST_EXTERNAL_TABLE_LOOKUP_KEY_SIZE_NONE
+		= 0x0,/* not used */
+	QE_FLTR_LARGEST_EXTERNAL_TABLE_LOOKUP_KEY_SIZE_8_BYTES
+		= QE_FLTR_TABLE_LOOKUP_KEY_SIZE_8_BYTES,	/* 8 bytes */
+	QE_FLTR_LARGEST_EXTERNAL_TABLE_LOOKUP_KEY_SIZE_16_BYTES
+		= QE_FLTR_TABLE_LOOKUP_KEY_SIZE_16_BYTES,	/* 16 bytes */
+};
+
+/* structure representing QE parameter RAM */
+struct qe_timer_tables {
+	u16 tm_base;		/* QE timer table base adr */
+	u16 tm_ptr;		/* QE timer table pointer */
+	u16 r_tmr;		/* QE timer mode register */
+	u16 r_tmv;		/* QE timer valid register */
+	u32 tm_cmd;		/* QE timer cmd register */
+	u32 tm_cnt;		/* QE timer internal cnt */
+} __attribute__ ((packed));
+
+#define QE_FLTR_TAD_SIZE	8
+
+/* QE extended filtering Termination Action Descriptor (TAD) */
+struct qe_fltr_tad {
+	u8 serialized[QE_FLTR_TAD_SIZE];
+} __attribute__ ((packed));
+
+/* Communication Direction */
+enum comm_dir {
+	COMM_DIR_NONE = 0,
+	COMM_DIR_RX = 1,
+	COMM_DIR_TX = 2,
+	COMM_DIR_RX_AND_TX = 3
+};
+
+/* Clocks and BRGs */
+enum qe_clock {
+	QE_CLK_NONE = 0,
+	QE_BRG1,		/* Baud Rate Generator 1 */
+	QE_BRG2,		/* Baud Rate Generator 2 */
+	QE_BRG3,		/* Baud Rate Generator 3 */
+	QE_BRG4,		/* Baud Rate Generator 4 */
+	QE_BRG5,		/* Baud Rate Generator 5 */
+	QE_BRG6,		/* Baud Rate Generator 6 */
+	QE_BRG7,		/* Baud Rate Generator 7 */
+	QE_BRG8,		/* Baud Rate Generator 8 */
+	QE_BRG9,		/* Baud Rate Generator 9 */
+	QE_BRG10,		/* Baud Rate Generator 10 */
+	QE_BRG11,		/* Baud Rate Generator 11 */
+	QE_BRG12,		/* Baud Rate Generator 12 */
+	QE_BRG13,		/* Baud Rate Generator 13 */
+	QE_BRG14,		/* Baud Rate Generator 14 */
+	QE_BRG15,		/* Baud Rate Generator 15 */
+	QE_BRG16,		/* Baud Rate Generator 16 */
+	QE_CLK1,		/* Clock 1 */
+	QE_CLK2,		/* Clock 2 */
+	QE_CLK3,		/* Clock 3 */
+	QE_CLK4,		/* Clock 4 */
+	QE_CLK5,		/* Clock 5 */
+	QE_CLK6,		/* Clock 6 */
+	QE_CLK7,		/* Clock 7 */
+	QE_CLK8,		/* Clock 8 */
+	QE_CLK9,		/* Clock 9 */
+	QE_CLK10,		/* Clock 10 */
+	QE_CLK11,		/* Clock 11 */
+	QE_CLK12,		/* Clock 12 */
+	QE_CLK13,		/* Clock 13 */
+	QE_CLK14,		/* Clock 14 */
+	QE_CLK15,		/* Clock 15 */
+	QE_CLK16,		/* Clock 16 */
+	QE_CLK17,		/* Clock 17 */
+	QE_CLK18,		/* Clock 18 */
+	QE_CLK19,		/* Clock 19 */
+	QE_CLK20,		/* Clock 20 */
+	QE_CLK21,		/* Clock 21 */
+	QE_CLK22,		/* Clock 22 */
+	QE_CLK23,		/* Clock 23 */
+	QE_CLK24,		/* Clock 24 */
+	QE_CLK_DUMMY,
+};
+
+/* QE CMXUCR Registers.
+ * There are two UCCs represented in each of the four CMXUCR registers.
+ * These values are for the UCC in the LSBs
+ */
+#define QE_CMXUCR_MII_ENET_MNG		0x00007000
+#define QE_CMXUCR_MII_ENET_MNG_SHIFT	12
+#define QE_CMXUCR_GRANT			0x00008000
+#define QE_CMXUCR_TSA			0x00004000
+#define QE_CMXUCR_BKPT			0x00000100
+#define QE_CMXUCR_TX_CLK_SRC_MASK	0x0000000F
+
+/* QE CMXGCR Registers.
+*/
+#define QE_CMXGCR_MII_ENET_MNG		0x00007000
+#define QE_CMXGCR_MII_ENET_MNG_SHIFT	12
+#define QE_CMXGCR_USBCS			0x0000000f
+
+/* QE CECR Commands.
+*/
+#define QE_CR_FLG			0x00010000
+#define QE_RESET			0x80000000
+#define QE_INIT_TX_RX			0x00000000
+#define QE_INIT_RX			0x00000001
+#define QE_INIT_TX			0x00000002
+#define QE_ENTER_HUNT_MODE		0x00000003
+#define QE_STOP_TX			0x00000004
+#define QE_GRACEFUL_STOP_TX		0x00000005
+#define QE_RESTART_TX			0x00000006
+#define QE_CLOSE_RX_BD			0x00000007
+#define QE_SWITCH_COMMAND		0x00000007
+#define QE_SET_GROUP_ADDRESS		0x00000008
+#define QE_START_IDMA			0x00000009
+#define QE_MCC_STOP_RX			0x00000009
+#define QE_ATM_TRANSMIT			0x0000000a
+#define QE_HPAC_CLEAR_ALL		0x0000000b
+#define QE_GRACEFUL_STOP_RX		0x0000001a
+#define QE_RESTART_RX			0x0000001b
+#define QE_HPAC_SET_PRIORITY		0x0000010b
+#define QE_HPAC_STOP_TX			0x0000020b
+#define QE_HPAC_STOP_RX			0x0000030b
+#define QE_HPAC_GRACEFUL_STOP_TX	0x0000040b
+#define QE_HPAC_GRACEFUL_STOP_RX	0x0000050b
+#define QE_HPAC_START_TX		0x0000060b
+#define QE_HPAC_START_RX		0x0000070b
+#define QE_USB_STOP_TX			0x0000000a
+#define QE_USB_RESTART_TX		0x0000000b
+#define QE_QMC_STOP_TX			0x0000000c
+#define QE_QMC_STOP_RX			0x0000000d
+#define QE_SS7_SU_FIL_RESET		0x0000000e
+/* jonathbr added from here down for 83xx */
+#define QE_RESET_BCS			0x0000000a
+#define QE_MCC_INIT_TX_RX_16		0x00000003
+#define QE_MCC_STOP_TX			0x00000004
+#define QE_MCC_INIT_TX_1		0x00000005
+#define QE_MCC_INIT_RX_1		0x00000006
+#define QE_MCC_RESET			0x00000007
+#define QE_SET_TIMER			0x00000008
+#define QE_RANDOM_NUMBER		0x0000000c
+#define QE_ATM_MULTI_THREAD_INIT	0x00000011
+#define QE_ASSIGN_PAGE			0x00000012
+#define QE_ADD_REMOVE_HASH_ENTRY	0x00000013
+#define QE_START_FLOW_CONTROL		0x00000014
+#define QE_STOP_FLOW_CONTROL		0x00000015
+#define QE_ASSIGN_PAGE_TO_DEVICE	0x00000016
+
+#define QE_ASSIGN_RISC			0x00000010
+#define QE_CR_MCN_NORMAL_SHIFT		6
+#define QE_CR_MCN_USB_SHIFT		4
+#define QE_CR_MCN_RISC_ASSIGN_SHIFT	8
+#define QE_CR_SNUM_SHIFT		17
+
+/* QE CECR Sub Block - sub block of QE command.
+*/
+#define QE_CR_SUBBLOCK_INVALID		0x00000000
+#define QE_CR_SUBBLOCK_USB		0x03200000
+#define QE_CR_SUBBLOCK_UCCFAST1		0x02000000
+#define QE_CR_SUBBLOCK_UCCFAST2		0x02200000
+#define QE_CR_SUBBLOCK_UCCFAST3		0x02400000
+#define QE_CR_SUBBLOCK_UCCFAST4		0x02600000
+#define QE_CR_SUBBLOCK_UCCFAST5		0x02800000
+#define QE_CR_SUBBLOCK_UCCFAST6		0x02a00000
+#define QE_CR_SUBBLOCK_UCCFAST7		0x02c00000
+#define QE_CR_SUBBLOCK_UCCFAST8		0x02e00000
+#define QE_CR_SUBBLOCK_UCCSLOW1		0x00000000
+#define QE_CR_SUBBLOCK_UCCSLOW2		0x00200000
+#define QE_CR_SUBBLOCK_UCCSLOW3		0x00400000
+#define QE_CR_SUBBLOCK_UCCSLOW4		0x00600000
+#define QE_CR_SUBBLOCK_UCCSLOW5		0x00800000
+#define QE_CR_SUBBLOCK_UCCSLOW6		0x00a00000
+#define QE_CR_SUBBLOCK_UCCSLOW7		0x00c00000
+#define QE_CR_SUBBLOCK_UCCSLOW8		0x00e00000
+#define QE_CR_SUBBLOCK_MCC1		0x03800000
+#define QE_CR_SUBBLOCK_MCC2		0x03a00000
+#define QE_CR_SUBBLOCK_MCC3		0x03000000
+#define QE_CR_SUBBLOCK_IDMA1		0x02800000
+#define QE_CR_SUBBLOCK_IDMA2		0x02a00000
+#define QE_CR_SUBBLOCK_IDMA3		0x02c00000
+#define QE_CR_SUBBLOCK_IDMA4		0x02e00000
+#define QE_CR_SUBBLOCK_HPAC		0x01e00000
+#define QE_CR_SUBBLOCK_SPI1		0x01400000
+#define QE_CR_SUBBLOCK_SPI2		0x01600000
+#define QE_CR_SUBBLOCK_RAND		0x01c00000
+#define QE_CR_SUBBLOCK_TIMER		0x01e00000
+#define QE_CR_SUBBLOCK_GENERAL		0x03c00000
+
+/* QE CECR Protocol - For non-MCC, specifies mode for QE CECR command */
+#define QE_CR_PROTOCOL_UNSPECIFIED	0x00	/* For all other protocols */
+#define QE_CR_PROTOCOL_HDLC_TRANSPARENT	0x00
+#define QE_CR_PROTOCOL_ATM_POS		0x0A
+#define QE_CR_PROTOCOL_ETHERNET		0x0C
+#define QE_CR_PROTOCOL_L2_SWITCH	0x0D
+
+/* BMR byte order */
+#define QE_BMR_BYTE_ORDER_BO_PPC	0x08	/* powerpc little endian */
+#define QE_BMR_BYTE_ORDER_BO_MOT	0x10	/* motorola big endian */
+#define QE_BMR_BYTE_ORDER_BO_MAX	0x18
+
+/* BRG configuration register */
+#define QE_BRGC_ENABLE		0x00010000
+#define QE_BRGC_DIVISOR_SHIFT	1
+#define QE_BRGC_DIVISOR_MAX	0xFFF
+#define QE_BRGC_DIV16		1
+
+/* QE Timers registers */
+#define QE_GTCFR1_PCAS	0x80
+#define QE_GTCFR1_STP2	0x20
+#define QE_GTCFR1_RST2	0x10
+#define QE_GTCFR1_GM2	0x08
+#define QE_GTCFR1_GM1	0x04
+#define QE_GTCFR1_STP1	0x02
+#define QE_GTCFR1_RST1	0x01
+
+/* SDMA registers */
+#define QE_SDSR_BER1	0x02000000
+#define QE_SDSR_BER2	0x01000000
+
+#define QE_SDMR_GLB_1_MSK	0x80000000
+#define QE_SDMR_ADR_SEL		0x20000000
+#define QE_SDMR_BER1_MSK	0x02000000
+#define QE_SDMR_BER2_MSK	0x01000000
+#define QE_SDMR_EB1_MSK		0x00800000
+#define QE_SDMR_ER1_MSK		0x00080000
+#define QE_SDMR_ER2_MSK		0x00040000
+#define QE_SDMR_CEN_MASK	0x0000E000
+#define QE_SDMR_SBER_1		0x00000200
+#define QE_SDMR_SBER_2		0x00000200
+#define QE_SDMR_EB1_PR_MASK	0x000000C0
+#define QE_SDMR_ER1_PR		0x00000008
+
+#define QE_SDMR_CEN_SHIFT	13
+#define QE_SDMR_EB1_PR_SHIFT	6
+
+#define QE_SDTM_MSNUM_SHIFT	24
+
+#define QE_SDEBCR_BA_MASK	0x01FFFFFF
+
+/* UPC */
+#define UPGCR_PROTOCOL	0x80000000	/* protocol ul2 or pl2 */
+#define UPGCR_TMS	0x40000000	/* Transmit master/slave mode */
+#define UPGCR_RMS	0x20000000	/* Receive master/slave mode */
+#define UPGCR_ADDR	0x10000000	/* Master MPHY Addr multiplexing */
+#define UPGCR_DIAG	0x01000000	/* Diagnostic mode */
+
+/* UCC */
+#define UCC_GUEMR_MODE_MASK_RX	0x02
+#define UCC_GUEMR_MODE_MASK_TX	0x01
+#define UCC_GUEMR_MODE_FAST_RX	0x02
+#define UCC_GUEMR_MODE_FAST_TX	0x01
+#define UCC_GUEMR_MODE_SLOW_RX	0x00
+#define UCC_GUEMR_MODE_SLOW_TX	0x00
+#define UCC_GUEMR_SET_RESERVED3	0x10	/* Bit 3 in the guemr is reserved but
+					   must be set 1 */
+
+/* structure representing UCC SLOW parameter RAM */
+struct ucc_slow_pram {
+	u16 rbase;		/* RX BD base address */
+	u16 tbase;		/* TX BD base address */
+	u8 rfcr;		/* Rx function code */
+	u8 tfcr;		/* Tx function code */
+	u16 mrblr;		/* Rx buffer length */
+	u32 rstate;		/* Rx internal state */
+	u32 rptr;		/* Rx internal data pointer */
+	u16 rbptr;		/* rb BD Pointer */
+	u16 rcount;		/* Rx internal byte count */
+	u32 rtemp;		/* Rx temp */
+	u32 tstate;		/* Tx internal state */
+	u32 tptr;		/* Tx internal data pointer */
+	u16 tbptr;		/* Tx BD pointer */
+	u16 tcount;		/* Tx byte count */
+	u32 ttemp;		/* Tx temp */
+	u32 rcrc;		/* temp receive CRC */
+	u32 tcrc;		/* temp transmit CRC */
+} __attribute__ ((packed));
+
+/* General UCC SLOW Mode Register (GUMRH & GUMRL) */
+#define UCC_SLOW_GUMR_H_CRC16		0x00004000
+#define UCC_SLOW_GUMR_H_CRC16CCITT	0x00000000
+#define UCC_SLOW_GUMR_H_CRC32CCITT	0x00008000
+#define UCC_SLOW_GUMR_H_REVD		0x00002000
+#define UCC_SLOW_GUMR_H_TRX		0x00001000
+#define UCC_SLOW_GUMR_H_TTX		0x00000800
+#define UCC_SLOW_GUMR_H_CDP		0x00000400
+#define UCC_SLOW_GUMR_H_CTSP		0x00000200
+#define UCC_SLOW_GUMR_H_CDS		0x00000100
+#define UCC_SLOW_GUMR_H_CTSS		0x00000080
+#define UCC_SLOW_GUMR_H_TFL		0x00000040
+#define UCC_SLOW_GUMR_H_RFW		0x00000020
+#define UCC_SLOW_GUMR_H_TXSY		0x00000010
+#define UCC_SLOW_GUMR_H_4SYNC		0x00000004
+#define UCC_SLOW_GUMR_H_8SYNC		0x00000008
+#define UCC_SLOW_GUMR_H_16SYNC		0x0000000c
+#define UCC_SLOW_GUMR_H_RTSM		0x00000002
+#define UCC_SLOW_GUMR_H_RSYN		0x00000001
+
+#define UCC_SLOW_GUMR_L_TCI		0x10000000
+#define UCC_SLOW_GUMR_L_RINV		0x02000000
+#define UCC_SLOW_GUMR_L_TINV		0x01000000
+#define UCC_SLOW_GUMR_L_TEND		0x00020000
+#define UCC_SLOW_GUMR_L_ENR		0x00000020
+#define UCC_SLOW_GUMR_L_ENT		0x00000010
+
+/* General UCC FAST Mode Register */
+#define UCC_FAST_GUMR_TCI	0x20000000
+#define UCC_FAST_GUMR_TRX	0x10000000
+#define UCC_FAST_GUMR_TTX	0x08000000
+#define UCC_FAST_GUMR_CDP	0x04000000
+#define UCC_FAST_GUMR_CTSP	0x02000000
+#define UCC_FAST_GUMR_CDS	0x01000000
+#define UCC_FAST_GUMR_CTSS	0x00800000
+#define UCC_FAST_GUMR_TXSY	0x00020000
+#define UCC_FAST_GUMR_RSYN	0x00010000
+#define UCC_FAST_GUMR_RTSM	0x00002000
+#define UCC_FAST_GUMR_REVD	0x00000400
+#define UCC_FAST_GUMR_ENR	0x00000020
+#define UCC_FAST_GUMR_ENT	0x00000010
+
+/* Slow UCC Event Register (UCCE) */
+#define UCC_SLOW_UCCE_GLR	0x1000
+#define UCC_SLOW_UCCE_GLT	0x0800
+#define UCC_SLOW_UCCE_DCC	0x0400
+#define UCC_SLOW_UCCE_FLG	0x0200
+#define UCC_SLOW_UCCE_AB	0x0200
+#define UCC_SLOW_UCCE_IDLE	0x0100
+#define UCC_SLOW_UCCE_GRA	0x0080
+#define UCC_SLOW_UCCE_TXE	0x0010
+#define UCC_SLOW_UCCE_RXF	0x0008
+#define UCC_SLOW_UCCE_CCR	0x0008
+#define UCC_SLOW_UCCE_RCH	0x0008
+#define UCC_SLOW_UCCE_BSY	0x0004
+#define UCC_SLOW_UCCE_TXB	0x0002
+#define UCC_SLOW_UCCE_TX	0x0002
+#define UCC_SLOW_UCCE_RX	0x0001
+#define UCC_SLOW_UCCE_GOV	0x0001
+#define UCC_SLOW_UCCE_GUN	0x0002
+#define UCC_SLOW_UCCE_GINT	0x0004
+#define UCC_SLOW_UCCE_IQOV	0x0008
+
+#define UCC_SLOW_UCCE_HDLC_SET	(UCC_SLOW_UCCE_TXE | UCC_SLOW_UCCE_BSY | \
+		UCC_SLOW_UCCE_GRA | UCC_SLOW_UCCE_TXB | UCC_SLOW_UCCE_RXF | \
+		UCC_SLOW_UCCE_DCC | UCC_SLOW_UCCE_GLT | UCC_SLOW_UCCE_GLR)
+#define UCC_SLOW_UCCE_ENET_SET	(UCC_SLOW_UCCE_TXE | UCC_SLOW_UCCE_BSY | \
+		UCC_SLOW_UCCE_GRA | UCC_SLOW_UCCE_TXB | UCC_SLOW_UCCE_RXF)
+#define UCC_SLOW_UCCE_TRANS_SET	(UCC_SLOW_UCCE_TXE | UCC_SLOW_UCCE_BSY | \
+		UCC_SLOW_UCCE_GRA | UCC_SLOW_UCCE_TX | UCC_SLOW_UCCE_RX | \
+		UCC_SLOW_UCCE_DCC | UCC_SLOW_UCCE_GLT | UCC_SLOW_UCCE_GLR)
+#define UCC_SLOW_UCCE_UART_SET	(UCC_SLOW_UCCE_BSY | UCC_SLOW_UCCE_GRA | \
+		UCC_SLOW_UCCE_TXB | UCC_SLOW_UCCE_TX | UCC_SLOW_UCCE_RX | \
+		UCC_SLOW_UCCE_GLT | UCC_SLOW_UCCE_GLR)
+#define UCC_SLOW_UCCE_QMC_SET	(UCC_SLOW_UCCE_IQOV | UCC_SLOW_UCCE_GINT | \
+		UCC_SLOW_UCCE_GUN | UCC_SLOW_UCCE_GOV)
+
+#define UCC_SLOW_UCCE_OTHER	(UCC_SLOW_UCCE_TXE | UCC_SLOW_UCCE_BSY | \
+		UCC_SLOW_UCCE_GRA | UCC_SLOW_UCCE_DCC | UCC_SLOW_UCCE_GLT | \
+		UCC_SLOW_UCCE_GLR)
+
+#define UCC_SLOW_INTR_TX	UCC_SLOW_UCCE_TXB
+#define UCC_SLOW_INTR_RX	(UCC_SLOW_UCCE_RXF | UCC_SLOW_UCCE_RX)
+#define UCC_SLOW_INTR		(UCC_SLOW_INTR_TX | UCC_SLOW_INTR_RX)
+
+/* UCC Transmit On Demand Register (UTODR) */
+#define UCC_SLOW_TOD	0x8000
+#define UCC_FAST_TOD	0x8000
+
+/* Function code masks */
+#define FC_GBL				0x20
+#define FC_DTB_LCL			0x02
+#define UCC_FAST_FUNCTION_CODE_GBL	0x20
+#define UCC_FAST_FUNCTION_CODE_DTB_LCL	0x02
+#define UCC_FAST_FUNCTION_CODE_BDB_LCL	0x01
+
+static inline long IS_MURAM_ERR(const u32 offset)
+{
+	return offset > (u32) - 1000L;
+}
+
+#endif /* __KERNEL__ */
+#endif /* _ASM_POWERPC_QE_H */
diff --git a/include/asm-powerpc/qe_ic.h b/include/asm-powerpc/qe_ic.h
new file mode 100644
index 0000000..e386fb7
--- /dev/null
+++ b/include/asm-powerpc/qe_ic.h
@@ -0,0 +1,64 @@
+/*
+ * include/asm-powerpc/qe_ic.h
+ *
+ * Copyright (C) 2006 Freescale Semicondutor, Inc. All rights reserved.
+ *
+ * Authors: 	Shlomi Gridish <gridish@freescale.com>
+ * 		Li Yang <leoli@freescale.com>
+ *
+ * Description:
+ * QE IC external definitions and structure.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#ifndef _ASM_POWERPC_QE_IC_H
+#define _ASM_POWERPC_QE_IC_H
+
+#include <linux/irq.h>
+
+#define NUM_OF_QE_IC_GROUPS	6
+
+/* Flags when we init the QE IC */
+#define QE_IC_SPREADMODE_GRP_W			0x00000001
+#define QE_IC_SPREADMODE_GRP_X			0x00000002
+#define QE_IC_SPREADMODE_GRP_Y			0x00000004
+#define QE_IC_SPREADMODE_GRP_Z			0x00000008
+#define QE_IC_SPREADMODE_GRP_RISCA		0x00000010
+#define QE_IC_SPREADMODE_GRP_RISCB		0x00000020
+
+#define QE_IC_LOW_SIGNAL			0x00000100
+#define QE_IC_HIGH_SIGNAL			0x00000200
+
+#define QE_IC_GRP_W_PRI0_DEST_SIGNAL_HIGH	0x00001000
+#define QE_IC_GRP_W_PRI1_DEST_SIGNAL_HIGH	0x00002000
+#define QE_IC_GRP_X_PRI0_DEST_SIGNAL_HIGH	0x00004000
+#define QE_IC_GRP_X_PRI1_DEST_SIGNAL_HIGH	0x00008000
+#define QE_IC_GRP_Y_PRI0_DEST_SIGNAL_HIGH	0x00010000
+#define QE_IC_GRP_Y_PRI1_DEST_SIGNAL_HIGH	0x00020000
+#define QE_IC_GRP_Z_PRI0_DEST_SIGNAL_HIGH	0x00040000
+#define QE_IC_GRP_Z_PRI1_DEST_SIGNAL_HIGH	0x00080000
+#define QE_IC_GRP_RISCA_PRI0_DEST_SIGNAL_HIGH	0x00100000
+#define QE_IC_GRP_RISCA_PRI1_DEST_SIGNAL_HIGH	0x00200000
+#define QE_IC_GRP_RISCB_PRI0_DEST_SIGNAL_HIGH	0x00400000
+#define QE_IC_GRP_RISCB_PRI1_DEST_SIGNAL_HIGH	0x00800000
+#define QE_IC_GRP_W_DEST_SIGNAL_SHIFT		(12)
+
+/* QE interrupt sources groups */
+enum qe_ic_grp_id {
+	QE_IC_GRP_W = 0,	/* QE interrupt controller group W */
+	QE_IC_GRP_X,		/* QE interrupt controller group X */
+	QE_IC_GRP_Y,		/* QE interrupt controller group Y */
+	QE_IC_GRP_Z,		/* QE interrupt controller group Z */
+	QE_IC_GRP_RISCA,	/* QE interrupt controller RISC group A */
+	QE_IC_GRP_RISCB		/* QE interrupt controller RISC group B */
+};
+
+void qe_ic_init(struct device_node *node, unsigned int flags);
+void qe_ic_set_highest_priority(unsigned int virq, int high);
+int qe_ic_set_priority(unsigned int virq, unsigned int priority);
+int qe_ic_set_high_priority(unsigned int virq, unsigned int priority, int high);
+
+#endif /* _ASM_POWERPC_QE_IC_H */
diff --git a/include/asm-powerpc/ucc.h b/include/asm-powerpc/ucc.h
new file mode 100644
index 0000000..afe3076
--- /dev/null
+++ b/include/asm-powerpc/ucc.h
@@ -0,0 +1,84 @@
+/*
+ * Copyright (C) 2006 Freescale Semicondutor, Inc. All rights reserved.
+ *
+ * Authors: 	Shlomi Gridish <gridish@freescale.com>
+ * 		Li Yang <leoli@freescale.com>
+ *
+ * Description:
+ * Internal header file for UCC unit routines.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#ifndef __UCC_H__
+#define __UCC_H__
+
+#include <asm/immap_qe.h>
+#include <asm/qe.h>
+
+#define STATISTICS
+
+#define UCC_MAX_NUM	8
+
+/* Slow or fast type for UCCs.
+*/
+enum ucc_speed_type {
+	UCC_SPEED_TYPE_FAST, UCC_SPEED_TYPE_SLOW
+};
+
+/* Initial UCCs Parameter RAM address relative to: MEM_MAP_BASE (IMMR).
+*/
+enum ucc_pram_initial_offset {
+	UCC_PRAM_OFFSET_UCC1 = 0x8400,
+	UCC_PRAM_OFFSET_UCC2 = 0x8500,
+	UCC_PRAM_OFFSET_UCC3 = 0x8600,
+	UCC_PRAM_OFFSET_UCC4 = 0x9000,
+	UCC_PRAM_OFFSET_UCC5 = 0x8000,
+	UCC_PRAM_OFFSET_UCC6 = 0x8100,
+	UCC_PRAM_OFFSET_UCC7 = 0x8200,
+	UCC_PRAM_OFFSET_UCC8 = 0x8300
+};
+
+/* ucc_set_type
+ * Sets UCC to slow or fast mode.
+ *
+ * ucc_num - (In) number of UCC (0-7).
+ * regs    - (In) pointer to registers base for the UCC.
+ * speed   - (In) slow or fast mode for UCC.
+ */
+int ucc_set_type(int ucc_num, struct ucc_common *regs,
+		 enum ucc_speed_type speed);
+
+/* ucc_init_guemr
+ * Init the Guemr register.
+ *
+ * regs - (In) pointer to registers base for the UCC.
+ */
+int ucc_init_guemr(struct ucc_common *regs);
+
+int ucc_set_qe_mux_mii_mng(int ucc_num);
+
+int ucc_set_qe_mux_rxtx(int ucc_num, enum qe_clock clock, enum comm_dir mode);
+
+int ucc_mux_set_grant_tsa_bkpt(int ucc_num, int set, u32 mask);
+
+/* QE MUX clock routing for UCC
+*/
+static inline int ucc_set_qe_mux_grant(int ucc_num, int set)
+{
+	return ucc_mux_set_grant_tsa_bkpt(ucc_num, set, QE_CMXUCR_GRANT);
+}
+
+static inline int ucc_set_qe_mux_tsa(int ucc_num, int set)
+{
+	return ucc_mux_set_grant_tsa_bkpt(ucc_num, set, QE_CMXUCR_TSA);
+}
+
+static inline int ucc_set_qe_mux_bkpt(int ucc_num, int set)
+{
+	return ucc_mux_set_grant_tsa_bkpt(ucc_num, set, QE_CMXUCR_BKPT);
+}
+
+#endif				/* __UCC_H__ */
diff --git a/include/asm-powerpc/ucc_fast.h b/include/asm-powerpc/ucc_fast.h
new file mode 100644
index 0000000..39d1c90
--- /dev/null
+++ b/include/asm-powerpc/ucc_fast.h
@@ -0,0 +1,243 @@
+/*
+ * include/asm-powerpc/ucc_fast.h
+ *
+ * Internal header file for UCC FAST unit routines.
+ *
+ * Copyright (C) 2006 Freescale Semicondutor, Inc. All rights reserved.
+ *
+ * Authors: 	Shlomi Gridish <gridish@freescale.com>
+ * 		Li Yang <leoli@freescale.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#ifndef __UCC_FAST_H__
+#define __UCC_FAST_H__
+
+#include <linux/kernel.h>
+
+#include <asm/immap_qe.h>
+#include <asm/qe.h>
+
+#include "ucc.h"
+
+/* Receive BD's status */
+#define R_E	0x80000000	/* buffer empty */
+#define R_W	0x20000000	/* wrap bit */
+#define R_I	0x10000000	/* interrupt on reception */
+#define R_L	0x08000000	/* last */
+#define R_F	0x04000000	/* first */
+
+/* transmit BD's status */
+#define T_R	0x80000000	/* ready bit */
+#define T_W	0x20000000	/* wrap bit */
+#define T_I	0x10000000	/* interrupt on completion */
+#define T_L	0x08000000	/* last */
+
+/* Rx Data buffer must be 4 bytes aligned in most cases */
+#define UCC_FAST_RX_ALIGN			4
+#define UCC_FAST_MRBLR_ALIGNMENT		4
+#define UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT	8
+
+/* Sizes */
+#define UCC_FAST_URFS_MIN_VAL				0x88
+#define UCC_FAST_RECEIVE_VIRTUAL_FIFO_SIZE_FUDGE_FACTOR	8
+
+/* ucc_fast_channel_protocol_mode - UCC FAST mode */
+enum ucc_fast_channel_protocol_mode {
+	UCC_FAST_PROTOCOL_MODE_HDLC = 0x00000000,
+	UCC_FAST_PROTOCOL_MODE_RESERVED01 = 0x00000001,
+	UCC_FAST_PROTOCOL_MODE_RESERVED_QMC = 0x00000002,
+	UCC_FAST_PROTOCOL_MODE_RESERVED02 = 0x00000003,
+	UCC_FAST_PROTOCOL_MODE_RESERVED_UART = 0x00000004,
+	UCC_FAST_PROTOCOL_MODE_RESERVED03 = 0x00000005,
+	UCC_FAST_PROTOCOL_MODE_RESERVED_EX_MAC_1 = 0x00000006,
+	UCC_FAST_PROTOCOL_MODE_RESERVED_EX_MAC_2 = 0x00000007,
+	UCC_FAST_PROTOCOL_MODE_RESERVED_BISYNC = 0x00000008,
+	UCC_FAST_PROTOCOL_MODE_RESERVED04 = 0x00000009,
+	UCC_FAST_PROTOCOL_MODE_ATM = 0x0000000A,
+	UCC_FAST_PROTOCOL_MODE_RESERVED05 = 0x0000000B,
+	UCC_FAST_PROTOCOL_MODE_ETHERNET = 0x0000000C,
+	UCC_FAST_PROTOCOL_MODE_RESERVED06 = 0x0000000D,
+	UCC_FAST_PROTOCOL_MODE_POS = 0x0000000E,
+	UCC_FAST_PROTOCOL_MODE_RESERVED07 = 0x0000000F
+};
+
+/* ucc_fast_transparent_txrx - UCC Fast Transparent TX & RX */
+enum ucc_fast_transparent_txrx {
+	UCC_FAST_GUMR_TRANSPARENT_TTX_TRX_NORMAL = 0x00000000,
+	UCC_FAST_GUMR_TRANSPARENT_TTX_TRX_TRANSPARENT = 0x18000000
+};
+
+/* UCC fast diagnostic mode */
+enum ucc_fast_diag_mode {
+	UCC_FAST_DIAGNOSTIC_NORMAL = 0x0,
+	UCC_FAST_DIAGNOSTIC_LOCAL_LOOP_BACK = 0x40000000,
+	UCC_FAST_DIAGNOSTIC_AUTO_ECHO = 0x80000000,
+	UCC_FAST_DIAGNOSTIC_LOOP_BACK_AND_ECHO = 0xC0000000
+};
+
+/* UCC fast Sync length (transparent mode only) */
+enum ucc_fast_sync_len {
+	UCC_FAST_SYNC_LEN_NOT_USED = 0x0,
+	UCC_FAST_SYNC_LEN_AUTOMATIC = 0x00004000,
+	UCC_FAST_SYNC_LEN_8_BIT = 0x00008000,
+	UCC_FAST_SYNC_LEN_16_BIT = 0x0000C000
+};
+
+/* UCC fast RTS mode */
+enum ucc_fast_ready_to_send {
+	UCC_FAST_SEND_IDLES_BETWEEN_FRAMES = 0x00000000,
+	UCC_FAST_SEND_FLAGS_BETWEEN_FRAMES = 0x00002000
+};
+
+/* UCC fast receiver decoding mode */
+enum ucc_fast_rx_decoding_method {
+	UCC_FAST_RX_ENCODING_NRZ = 0x00000000,
+	UCC_FAST_RX_ENCODING_NRZI = 0x00000800,
+	UCC_FAST_RX_ENCODING_RESERVED0 = 0x00001000,
+	UCC_FAST_RX_ENCODING_RESERVED1 = 0x00001800
+};
+
+/* UCC fast transmitter encoding mode */
+enum ucc_fast_tx_encoding_method {
+	UCC_FAST_TX_ENCODING_NRZ = 0x00000000,
+	UCC_FAST_TX_ENCODING_NRZI = 0x00000100,
+	UCC_FAST_TX_ENCODING_RESERVED0 = 0x00000200,
+	UCC_FAST_TX_ENCODING_RESERVED1 = 0x00000300
+};
+
+/* UCC fast CRC length */
+enum ucc_fast_transparent_tcrc {
+	UCC_FAST_16_BIT_CRC = 0x00000000,
+	UCC_FAST_CRC_RESERVED0 = 0x00000040,
+	UCC_FAST_32_BIT_CRC = 0x00000080,
+	UCC_FAST_CRC_RESERVED1 = 0x000000C0
+};
+
+/* Fast UCC initialization structure */
+struct ucc_fast_info {
+	int ucc_num;
+	enum qe_clock rx_clock;
+	enum qe_clock tx_clock;
+	u32 regs;
+	int irq;
+	u32 uccm_mask;
+	int bd_mem_part;
+	int brkpt_support;
+	int grant_support;
+	int tsa;
+	int cdp;
+	int cds;
+	int ctsp;
+	int ctss;
+	int tci;
+	int txsy;
+	int rtsm;
+	int revd;
+	int rsyn;
+	u16 max_rx_buf_length;
+	u16 urfs;
+	u16 urfet;
+	u16 urfset;
+	u16 utfs;
+	u16 utfet;
+	u16 utftt;
+	u16 ufpt;
+	enum ucc_fast_channel_protocol_mode mode;
+	enum ucc_fast_transparent_txrx ttx_trx;
+	enum ucc_fast_tx_encoding_method tenc;
+	enum ucc_fast_rx_decoding_method renc;
+	enum ucc_fast_transparent_tcrc tcrc;
+	enum ucc_fast_sync_len synl;
+};
+
+struct ucc_fast_private {
+	struct ucc_fast_info *uf_info;
+	struct ucc_fast *uf_regs;	/* a pointer to memory map of UCC regs. */
+	u32 *p_ucce;		/* a pointer to the event register in memory. */
+	u32 *p_uccm;		/* a pointer to the mask register in memory. */
+	int enabled_tx;		/* Whether channel is enabled for Tx (ENT) */
+	int enabled_rx;		/* Whether channel is enabled for Rx (ENR) */
+	int stopped_tx;		/* Whether channel has been stopped for Tx
+				   (STOP_TX, etc.) */
+	int stopped_rx;		/* Whether channel has been stopped for Rx */
+	u32 ucc_fast_tx_virtual_fifo_base_offset;/* pointer to base of Tx
+						    virtual fifo */
+	u32 ucc_fast_rx_virtual_fifo_base_offset;/* pointer to base of Rx
+						    virtual fifo */
+#ifdef STATISTICS
+	u32 tx_frames;		/* Transmitted frames counter. */
+	u32 rx_frames;		/* Received frames counter (only frames
+				   passed to application). */
+	u32 tx_discarded;	/* Discarded tx frames counter (frames that
+				   were discarded by the driver due to errors).
+				   */
+	u32 rx_discarded;	/* Discarded rx frames counter (frames that
+				   were discarded by the driver due to errors).
+				   */
+#endif				/* STATISTICS */
+	u16 mrblr;		/* maximum receive buffer length */
+};
+
+/* ucc_fast_init
+ * Initializes Fast UCC according to user provided parameters.
+ *
+ * uf_info  - (In) pointer to the fast UCC info structure.
+ * uccf_ret - (Out) pointer to the fast UCC structure.
+ */
+int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** uccf_ret);
+
+/* ucc_fast_free
+ * Frees all resources for fast UCC.
+ *
+ * uccf - (In) pointer to the fast UCC structure.
+ */
+void ucc_fast_free(struct ucc_fast_private * uccf);
+
+/* ucc_fast_enable
+ * Enables a fast UCC port.
+ * This routine enables Tx and/or Rx through the General UCC Mode Register.
+ *
+ * uccf - (In) pointer to the fast UCC structure.
+ * mode - (In) TX, RX, or both.
+ */
+void ucc_fast_enable(struct ucc_fast_private * uccf, enum comm_dir mode);
+
+/* ucc_fast_disable
+ * Disables a fast UCC port.
+ * This routine disables Tx and/or Rx through the General UCC Mode Register.
+ *
+ * uccf - (In) pointer to the fast UCC structure.
+ * mode - (In) TX, RX, or both.
+ */
+void ucc_fast_disable(struct ucc_fast_private * uccf, enum comm_dir mode);
+
+/* ucc_fast_irq
+ * Handles interrupts on fast UCC.
+ * Called from the general interrupt routine to handle interrupts on fast UCC.
+ *
+ * uccf - (In) pointer to the fast UCC structure.
+ */
+void ucc_fast_irq(struct ucc_fast_private * uccf);
+
+/* ucc_fast_transmit_on_demand
+ * Immediately forces a poll of the transmitter for data to be sent.
+ * Typically, the hardware performs a periodic poll for data that the
+ * transmit routine has set up to be transmitted. In cases where
+ * this polling cycle is not soon enough, this optional routine can
+ * be invoked to force a poll right away, instead. Proper use for
+ * each transmission for which this functionality is desired is to
+ * call the transmit routine and then this routine right after.
+ *
+ * uccf - (In) pointer to the fast UCC structure.
+ */
+void ucc_fast_transmit_on_demand(struct ucc_fast_private * uccf);
+
+u32 ucc_fast_get_qe_cr_subblock(int uccf_num);
+
+void ucc_fast_dump_regs(struct ucc_fast_private * uccf);
+
+#endif				/* __UCC_FAST_H__ */
diff --git a/include/asm-powerpc/ucc_slow.h b/include/asm-powerpc/ucc_slow.h
new file mode 100644
index 0000000..ca93bc9
--- /dev/null
+++ b/include/asm-powerpc/ucc_slow.h
@@ -0,0 +1,289 @@
+/*
+ * Copyright (C) 2006 Freescale Semicondutor, Inc. All rights reserved.
+ *
+ * Authors: 	Shlomi Gridish <gridish@freescale.com>
+ * 		Li Yang <leoli@freescale.com>
+ *
+ * Description:
+ * Internal header file for UCC SLOW unit routines.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#ifndef __UCC_SLOW_H__
+#define __UCC_SLOW_H__
+
+#include <linux/kernel.h>
+
+#include <asm/immap_qe.h>
+#include <asm/qe.h>
+
+#include "ucc.h"
+
+/* transmit BD's status */
+#define T_R	0x80000000	/* ready bit */
+#define T_PAD	0x40000000	/* add pads to short frames */
+#define T_W	0x20000000	/* wrap bit */
+#define T_I	0x10000000	/* interrupt on completion */
+#define T_L	0x08000000	/* last */
+
+#define T_A	0x04000000	/* Address - the data transmitted as address
+				   chars */
+#define T_TC	0x04000000	/* transmit CRC */
+#define T_CM	0x02000000	/* continuous mode */
+#define T_DEF	0x02000000	/* collision on previous attempt to transmit */
+#define T_P	0x01000000	/* Preamble - send Preamble sequence before
+				   data */
+#define T_HB	0x01000000	/* heartbeat */
+#define T_NS	0x00800000	/* No Stop */
+#define T_LC	0x00800000	/* late collision */
+#define T_RL	0x00400000	/* retransmission limit */
+#define T_UN	0x00020000	/* underrun */
+#define T_CT	0x00010000	/* CTS lost */
+#define T_CSL	0x00010000	/* carrier sense lost */
+#define T_RC	0x003c0000	/* retry count */
+
+/* Receive BD's status */
+#define R_E	0x80000000	/* buffer empty */
+#define R_W	0x20000000	/* wrap bit */
+#define R_I	0x10000000	/* interrupt on reception */
+#define R_L	0x08000000	/* last */
+#define R_C	0x08000000	/* the last byte in this buffer is a cntl
+				   char */
+#define R_F	0x04000000	/* first */
+#define R_A	0x04000000	/* the first byte in this buffer is address
+				   byte */
+#define R_CM	0x02000000	/* continuous mode */
+#define R_ID	0x01000000	/* buffer close on reception of idles */
+#define R_M	0x01000000	/* Frame received because of promiscuous
+				   mode */
+#define R_AM	0x00800000	/* Address match */
+#define R_DE	0x00800000	/* Address match */
+#define R_LG	0x00200000	/* Break received */
+#define R_BR	0x00200000	/* Frame length violation */
+#define R_NO	0x00100000	/* Rx Non Octet Aligned Packet */
+#define R_FR	0x00100000	/* Framing Error (no stop bit) character
+				   received */
+#define R_PR	0x00080000	/* Parity Error character received */
+#define R_AB	0x00080000	/* Frame Aborted */
+#define R_SH	0x00080000	/* frame is too short */
+#define R_CR	0x00040000	/* CRC Error */
+#define R_OV	0x00020000	/* Overrun */
+#define R_CD	0x00010000	/* CD lost */
+#define R_CL	0x00010000	/* this frame is closed because of a
+				   collision */
+
+/* Rx Data buffer must be 4 bytes aligned in most cases.*/
+#define UCC_SLOW_RX_ALIGN		4
+#define UCC_SLOW_MRBLR_ALIGNMENT	4
+#define UCC_SLOW_PRAM_SIZE		0x100
+#define ALIGNMENT_OF_UCC_SLOW_PRAM	64
+
+/* UCC Slow Channel Protocol Mode */
+enum ucc_slow_channel_protocol_mode {
+	UCC_SLOW_CHANNEL_PROTOCOL_MODE_QMC = 0x00000002,
+	UCC_SLOW_CHANNEL_PROTOCOL_MODE_UART = 0x00000004,
+	UCC_SLOW_CHANNEL_PROTOCOL_MODE_BISYNC = 0x00000008,
+};
+
+/* UCC Slow Transparent Transmit CRC (TCRC) */
+enum ucc_slow_transparent_tcrc {
+	/* 16-bit CCITT CRC (HDLC).  (X16 + X12 + X5 + 1) */
+	UCC_SLOW_TRANSPARENT_TCRC_CCITT_CRC16 = 0x00000000,
+	/* CRC16 (BISYNC).  (X16 + X15 + X2 + 1) */
+	UCC_SLOW_TRANSPARENT_TCRC_CRC16 = 0x00004000,
+	/* 32-bit CCITT CRC (Ethernet and HDLC) */
+	UCC_SLOW_TRANSPARENT_TCRC_CCITT_CRC32 = 0x00008000,
+};
+
+/* UCC Slow oversampling rate for transmitter (TDCR) */
+enum ucc_slow_tx_oversampling_rate {
+	/* 1x clock mode */
+	UCC_SLOW_OVERSAMPLING_RATE_TX_TDCR_1 = 0x00000000,
+	/* 8x clock mode */
+	UCC_SLOW_OVERSAMPLING_RATE_TX_TDCR_8 = 0x00010000,
+	/* 16x clock mode */
+	UCC_SLOW_OVERSAMPLING_RATE_TX_TDCR_16 = 0x00020000,
+	/* 32x clock mode */
+	UCC_SLOW_OVERSAMPLING_RATE_TX_TDCR_32 = 0x00030000,
+};
+
+/* UCC Slow Oversampling rate for receiver (RDCR)
+*/
+enum ucc_slow_rx_oversampling_rate {
+	/* 1x clock mode */
+	UCC_SLOW_OVERSAMPLING_RATE_RX_RDCR_1 = 0x00000000,
+	/* 8x clock mode */
+	UCC_SLOW_OVERSAMPLING_RATE_RX_RDCR_8 = 0x00004000,
+	/* 16x clock mode */
+	UCC_SLOW_OVERSAMPLING_RATE_RX_RDCR_16 = 0x00008000,
+	/* 32x clock mode */
+	UCC_SLOW_OVERSAMPLING_RATE_RX_RDCR_32 = 0x0000c000,
+};
+
+/* UCC Slow Transmitter encoding method (TENC)
+*/
+enum ucc_slow_tx_encoding_method {
+	UCC_SLOW_TRANSMITTER_ENCODING_METHOD_TENC_NRZ = 0x00000000,
+	UCC_SLOW_TRANSMITTER_ENCODING_METHOD_TENC_NRZI = 0x00000100
+};
+
+/* UCC Slow Receiver decoding method (RENC)
+*/
+enum ucc_slow_rx_decoding_method {
+	UCC_SLOW_RECEIVER_DECODING_METHOD_RENC_NRZ = 0x00000000,
+	UCC_SLOW_RECEIVER_DECODING_METHOD_RENC_NRZI = 0x00000800
+};
+
+/* UCC Slow Diagnostic mode (DIAG)
+*/
+enum ucc_slow_diag_mode {
+	UCC_SLOW_DIAG_MODE_NORMAL = 0x00000000,
+	UCC_SLOW_DIAG_MODE_LOOPBACK = 0x00000040,
+	UCC_SLOW_DIAG_MODE_ECHO = 0x00000080,
+	UCC_SLOW_DIAG_MODE_LOOPBACK_ECHO = 0x000000c0
+};
+
+struct ucc_slow_info {
+	int ucc_num;
+	enum qe_clock rx_clock;
+	enum qe_clock tx_clock;
+	struct ucc_slow *us_regs;
+	int irq;
+	u16 uccm_mask;
+	int data_mem_part;
+	int init_tx;
+	int init_rx;
+	u32 tx_bd_ring_len;
+	u32 rx_bd_ring_len;
+	int rx_interrupts;
+	int brkpt_support;
+	int grant_support;
+	int tsa;
+	int cdp;
+	int cds;
+	int ctsp;
+	int ctss;
+	int rinv;
+	int tinv;
+	int rtsm;
+	int rfw;
+	int tci;
+	int tend;
+	int tfl;
+	int txsy;
+	u16 max_rx_buf_length;
+	enum ucc_slow_transparent_tcrc tcrc;
+	enum ucc_slow_channel_protocol_mode mode;
+	enum ucc_slow_diag_mode diag;
+	enum ucc_slow_tx_oversampling_rate tdcr;
+	enum ucc_slow_rx_oversampling_rate rdcr;
+	enum ucc_slow_tx_encoding_method tenc;
+	enum ucc_slow_rx_decoding_method renc;
+};
+
+struct ucc_slow_private {
+	struct ucc_slow_info *us_info;
+	struct ucc_slow *us_regs;	/* a pointer to memory map of UCC regs */
+	struct ucc_slow_pram *us_pram;	/* a pointer to the parameter RAM */
+	u32 us_pram_offset;
+	int enabled_tx;		/* Whether channel is enabled for Tx (ENT) */
+	int enabled_rx;		/* Whether channel is enabled for Rx (ENR) */
+	int stopped_tx;		/* Whether channel has been stopped for Tx
+				   (STOP_TX, etc.) */
+	int stopped_rx;		/* Whether channel has been stopped for Rx */
+	struct list_head confQ;	/* frames passed to chip waiting for tx */
+	u32 first_tx_bd_mask;	/* mask is used in Tx routine to save status
+				   and length for first BD in a frame */
+	u32 tx_base_offset;	/* first BD in Tx BD table offset (In MURAM) */
+	u32 rx_base_offset;	/* first BD in Rx BD table offset (In MURAM) */
+	u8 *confBd;		/* next BD for confirm after Tx */
+	u8 *tx_bd;		/* next BD for new Tx request */
+	u8 *rx_bd;		/* next BD to collect after Rx */
+	void *p_rx_frame;	/* accumulating receive frame */
+	u16 *p_ucce;		/* a pointer to the event register in memory.
+				 */
+	u16 *p_uccm;		/* a pointer to the mask register in memory */
+	u16 saved_uccm;		/* a saved mask for the RX Interrupt bits */
+#ifdef STATISTICS
+	u32 tx_frames;		/* Transmitted frames counters */
+	u32 rx_frames;		/* Received frames counters (only frames
+				   passed to application) */
+	u32 rx_discarded;	/* Discarded frames counters (frames that
+				   were discarded by the driver due to
+				   errors) */
+#endif				/* STATISTICS */
+};
+
+/* ucc_slow_init
+ * Initializes Slow UCC according to provided parameters.
+ *
+ * us_info  - (In) pointer to the slow UCC info structure.
+ * uccs_ret - (Out) pointer to the slow UCC structure.
+ */
+int ucc_slow_init(struct ucc_slow_info * us_info, struct ucc_slow_private ** uccs_ret);
+
+/* ucc_slow_free
+ * Frees all resources for slow UCC.
+ *
+ * uccs - (In) pointer to the slow UCC structure.
+ */
+void ucc_slow_free(struct ucc_slow_private * uccs);
+
+/* ucc_slow_enable
+ * Enables a fast UCC port.
+ * This routine enables Tx and/or Rx through the General UCC Mode Register.
+ *
+ * uccs - (In) pointer to the slow UCC structure.
+ * mode - (In) TX, RX, or both.
+ */
+void ucc_slow_enable(struct ucc_slow_private * uccs, enum comm_dir mode);
+
+/* ucc_slow_disable
+ * Disables a fast UCC port.
+ * This routine disables Tx and/or Rx through the General UCC Mode Register.
+ *
+ * uccs - (In) pointer to the slow UCC structure.
+ * mode - (In) TX, RX, or both.
+ */
+void ucc_slow_disable(struct ucc_slow_private * uccs, enum comm_dir mode);
+
+/* ucc_slow_poll_transmitter_now
+ * Immediately forces a poll of the transmitter for data to be sent.
+ * Typically, the hardware performs a periodic poll for data that the
+ * transmit routine has set up to be transmitted. In cases where
+ * this polling cycle is not soon enough, this optional routine can
+ * be invoked to force a poll right away, instead. Proper use for
+ * each transmission for which this functionality is desired is to
+ * call the transmit routine and then this routine right after.
+ *
+ * uccs - (In) pointer to the slow UCC structure.
+ */
+void ucc_slow_poll_transmitter_now(struct ucc_slow_private * uccs);
+
+/* ucc_slow_graceful_stop_tx
+ * Smoothly stops transmission on a specified slow UCC.
+ *
+ * uccs - (In) pointer to the slow UCC structure.
+ */
+void ucc_slow_graceful_stop_tx(struct ucc_slow_private * uccs);
+
+/* ucc_slow_stop_tx
+ * Stops transmission on a specified slow UCC.
+ *
+ * uccs - (In) pointer to the slow UCC structure.
+ */
+void ucc_slow_stop_tx(struct ucc_slow_private * uccs);
+
+/* ucc_slow_restart_x
+ * Restarts transmitting on a specified slow UCC.
+ *
+ * uccs - (In) pointer to the slow UCC structure.
+ */
+void ucc_slow_restart_x(struct ucc_slow_private * uccs);
+
+u32 ucc_slow_get_qe_cr_subblock(int uccs_num);
+
+#endif				/* __UCC_SLOW_H__ */
diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
index 16fbe59..3da29e2 100644
--- a/include/linux/fsl_devices.h
+++ b/include/linux/fsl_devices.h
@@ -46,18 +46,17 @@ #include <linux/types.h>
 
 struct gianfar_platform_data {
 	/* device specific information */
-	u32 device_flags;
-
+	u32	device_flags;
 	/* board specific information */
-	u32 board_flags;
-	u32 bus_id;
-	u32 phy_id;
-	u8 mac_addr[6];
+	u32	board_flags;
+	u32	bus_id;
+	u32	phy_id;
+	u8	mac_addr[6];
 };
 
 struct gianfar_mdio_data {
 	/* board specific information */
-	int irq[32];
+	int	irq[32];
 };
 
 /* Flags related to gianfar device features */
@@ -76,14 +75,13 @@ #define FSL_GIANFAR_BRD_IS_REDUCED	0x000
 
 struct fsl_i2c_platform_data {
 	/* device specific information */
-	u32 device_flags;
+	u32	device_flags;
 };
 
 /* Flags related to I2C device features */
 #define FSL_I2C_DEV_SEPARATE_DFSRR	0x00000001
 #define FSL_I2C_DEV_CLOCK_5200		0x00000002
 
-
 enum fsl_usb2_operating_modes {
 	FSL_USB2_MPH_HOST,
 	FSL_USB2_DR_HOST,
@@ -101,9 +99,9 @@ enum fsl_usb2_phy_modes {
 
 struct fsl_usb2_platform_data {
 	/* board specific information */
-	enum fsl_usb2_operating_modes operating_mode;
-	enum fsl_usb2_phy_modes phy_mode;
-	unsigned int port_enables;
+	enum fsl_usb2_operating_modes	operating_mode;
+	enum fsl_usb2_phy_modes		phy_mode;
+	unsigned int			port_enables;
 };
 
 /* Flags in fsl_usb2_mph_platform_data */
@@ -121,5 +119,44 @@ struct fsl_spi_platform_data {
 	u32	sysclk;
 };
 
-#endif				/* _FSL_DEVICE_H_ */
-#endif				/* __KERNEL__ */
+/* Ethernet interface (phy management and speed)
+*/
+enum enet_interface {
+	ENET_10_MII,		/* 10 Base T,   MII interface */
+	ENET_10_RMII,		/* 10 Base T,  RMII interface */
+	ENET_10_RGMII,		/* 10 Base T, RGMII interface */
+	ENET_100_MII,		/* 100 Base T,   MII interface */
+	ENET_100_RMII,		/* 100 Base T,  RMII interface */
+	ENET_100_RGMII,		/* 100 Base T, RGMII interface */
+	ENET_1000_GMII,		/* 1000 Base T,  GMII interface */
+	ENET_1000_RGMII,	/* 1000 Base T, RGMII interface */
+	ENET_1000_TBI,		/* 1000 Base T,   TBI interface */
+	ENET_1000_RTBI		/* 1000 Base T,  RTBI interface */
+};
+
+struct ucc_geth_platform_data {
+	/* device specific information */
+	u32			device_flags;
+	u32			phy_reg_addr;
+
+	/* board specific information */
+	u32			board_flags;
+	u8			rx_clock;
+	u8			tx_clock;
+	u32			phy_id;
+	enum enet_interface	phy_interface;
+	u32			phy_interrupt;
+	u8			mac_addr[6];
+};
+
+/* Flags related to UCC Gigabit Ethernet device features */
+#define FSL_UGETH_DEV_HAS_GIGABIT		0x00000001
+#define FSL_UGETH_DEV_HAS_COALESCE		0x00000002
+#define FSL_UGETH_DEV_HAS_RMON			0x00000004
+
+/* Flags in ucc_geth_platform_data */
+#define FSL_UGETH_BRD_HAS_PHY_INTR		0x00000001
+				/* if not set use a timer */
+
+#endif /* _FSL_DEVICE_H_ */
+#endif /* __KERNEL__ */
-- 
1.4.2.3

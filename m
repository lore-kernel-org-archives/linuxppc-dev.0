Return-Path: <tnt@246tNt.com>
Received: from outmx016.isp.belgacom.be (outmx016.isp.belgacom.be
	[195.238.2.115]) by ozlabs.org (Postfix) with ESMTP id 876B767A79
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 27 Mar 2005 09:48:48 +1000 (EST)
Received: from outmx016.isp.belgacom.be (localhost [127.0.0.1])
	by outmx016.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j2QNmcFU011258
	for <linuxppc-embedded@ozlabs.org>; Sun, 27 Mar 2005 00:48:39 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <3.20050327_004704.tnt@patchsend.246tNt.com>
From: Sylvain Munaut <tnt@246tNt.com>
To: Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1
In-Reply-To: <0.20050327_004704.tnt@patchsend.246tNt.com>
References: <0.20050327_004704.tnt@patchsend.246tNt.com>
Date: Sun, 27 Mar 2005 00:46:13 +0100 (CET)
Cc: Sylvain Munaut <tnt@246tNt.com>,
	ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH 3/6] ppc32: Change constants style in Freescale MPC52xx
	related code
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

ppc32: Change constants style in Freescale MPC52xx related code

This patch changes the way the constants used for register block
address are defined/used. This is a preparation for the use of
the platform bus / ppc_sys model.


Signed-off-by: Sylvain Munaut <tnt@246tNt.com> 
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
---
diff -Nru a/arch/ppc/boot/simple/mpc52xx_tty.c b/arch/ppc/boot/simple/mpc52xx_tty.c
--- a/arch/ppc/boot/simple/mpc52xx_tty.c	2005-03-26 19:56:12 +01:00
+++ b/arch/ppc/boot/simple/mpc52xx_tty.c	2005-03-26 19:56:12 +01:00
@@ -20,32 +20,31 @@
 #include <asm/io.h>
 #include <asm/time.h>
 
-#if MPC52xx_PF_CONSOLE_PORT == 0
-#define MPC52xx_CONSOLE		MPC52xx_PSC1
-#define MPC52xx_PSC_CONFIG_SHIFT	0
-#elif MPC52xx_PF_CONSOLE_PORT == 1
-#define MPC52xx_CONSOLE		MPC52xx_PSC2
-#define MPC52xx_PSC_CONFIG_SHIFT	4
-#elif MPC52xx_PF_CONSOLE_PORT == 2
-#define MPC52xx_CONSOLE		MPC52xx_PSC3
-#define MPC52xx_PSC_CONFIG_SHIFT	8
+
+#ifdef MPC52xx_PF_CONSOLE_PORT
+#define MPC52xx_CONSOLE MPC52xx_PSCx_OFFSET(MPC52xx_PF_CONSOLE_PORT)
+#define MPC52xx_PSC_CONFIG_SHIFT ((MPC52xx_PF_CONSOLE_PORT-1)<<2)
 #else
 #error "MPC52xx_PF_CONSOLE_PORT not defined"
 #endif
 
 static struct mpc52xx_psc __iomem *psc =
-	(struct mpc52xx_psc __iomem *) MPC52xx_CONSOLE;
+	(struct mpc52xx_psc __iomem *) MPC52xx_PA(MPC52xx_CONSOLE);
 
 /* The decrementer counts at the system bus clock frequency
  * divided by four.  The most accurate time base is connected to the
- * rtc.  We read the decrementer change during one rtc tick (one second)
- * and multiply by 4 to get the system bus clock frequency.
+ * rtc.  We read the decrementer change during one rtc tick
+ * and multiply by 4 to get the system bus clock frequency. Since a
+ * rtc tick is one seconds, and that's pretty long, we change the rtc
+ * dividers temporarly to set them 64x faster ;)
  */
 static int
 mpc52xx_ipbfreq(void)
 {
-	struct mpc52xx_rtc __iomem *rtc = (struct mpc52xx_rtc __iomem *)MPC52xx_RTC;
-	struct mpc52xx_cdm __iomem *cdm = (struct mpc52xx_cdm __iomem *)MPC52xx_CDM;
+	struct mpc52xx_rtc __iomem *rtc =
+		(struct mpc52xx_rtc __iomem *) MPC52xx_PA(MPC52xx_RTC_OFFSET);
+	struct mpc52xx_cdm __iomem *cdm =
+		(struct mpc52xx_cdm __iomem *) MPC52xx_PA(MPC52xx_CDM_OFFSET);
 	int current_time, previous_time;
 	int tbl_start, tbl_end;
 	int xlbfreq, ipbfreq;
@@ -68,7 +67,8 @@
 unsigned long
 serial_init(int ignored, void *ignored2)
 {
-	struct mpc52xx_gpio __iomem *gpio = (struct mpc52xx_gpio __iomem *)MPC52xx_GPIO;
+	struct mpc52xx_gpio __iomem *gpio =
+		(struct mpc52xx_gpio __iomem *) MPC52xx_PA(MPC52xx_GPIO_OFFSET);
 	int divisor;
 	int mode1;
 	int mode2;
diff -Nru a/arch/ppc/platforms/lite5200.c b/arch/ppc/platforms/lite5200.c
--- a/arch/ppc/platforms/lite5200.c	2005-03-26 19:56:12 +01:00
+++ b/arch/ppc/platforms/lite5200.c	2005-03-26 19:56:12 +01:00
@@ -73,8 +73,8 @@
 	u32 intr_ctrl;
 
 	/* Map zones */
-	xlb  = ioremap(MPC52xx_XLB,sizeof(struct mpc52xx_xlb));
-	intr = ioremap(MPC52xx_INTR,sizeof(struct mpc52xx_intr));
+	xlb  = ioremap(MPC52xx_PA(MPC52xx_XLB_OFFSET), MPC52xx_XLB_SIZE);
+	intr = ioremap(MPC52xx_PA(MPC52xx_INTR_OFFSET), MPC52xx_INTR_SIZE);
 
 	if (!xlb || !intr) {
 		printk("lite5200.c: Error while mapping XLB/INTR during "
diff -Nru a/arch/ppc/platforms/lite5200.h b/arch/ppc/platforms/lite5200.h
--- a/arch/ppc/platforms/lite5200.h	2005-03-26 19:56:12 +01:00
+++ b/arch/ppc/platforms/lite5200.h	2005-03-26 19:56:12 +01:00
@@ -17,7 +17,7 @@
 #define __PLATFORMS_LITE5200_H__
 
 /* Serial port used for low-level debug */
-#define MPC52xx_PF_CONSOLE_PORT 0	/* PSC1 */
+#define MPC52xx_PF_CONSOLE_PORT 1	/* PSC1 */
 
 
 #endif /* __PLATFORMS_LITE5200_H__ */
diff -Nru a/arch/ppc/syslib/mpc52xx_pci.c b/arch/ppc/syslib/mpc52xx_pci.c
--- a/arch/ppc/syslib/mpc52xx_pci.c	2005-03-26 19:56:12 +01:00
+++ b/arch/ppc/syslib/mpc52xx_pci.c	2005-03-26 19:56:12 +01:00
@@ -183,7 +183,7 @@
 
 	pci_assign_all_busses = 1;
 
-	pci_regs = ioremap(MPC52xx_PCI, sizeof(struct mpc52xx_pci));
+	pci_regs = ioremap(MPC52xx_PA(MPC52xx_PCI_OFFSET), MPC52xx_PCI_SIZE);
 	if (!pci_regs)
 		return;
 
diff -Nru a/arch/ppc/syslib/mpc52xx_pic.c b/arch/ppc/syslib/mpc52xx_pic.c
--- a/arch/ppc/syslib/mpc52xx_pic.c	2005-03-26 19:56:12 +01:00
+++ b/arch/ppc/syslib/mpc52xx_pic.c	2005-03-26 19:56:12 +01:00
@@ -180,8 +180,8 @@
 	u32 intr_ctrl;
 
 	/* Remap the necessary zones */
-	intr = ioremap(MPC52xx_INTR, sizeof(struct mpc52xx_intr));
-	sdma = ioremap(MPC52xx_SDMA, sizeof(struct mpc52xx_sdma));
+	intr = ioremap(MPC52xx_PA(MPC52xx_INTR_OFFSET), MPC52xx_INTR_SIZE);
+	sdma = ioremap(MPC52xx_PA(MPC52xx_SDMA_OFFSET), MPC52xx_SDMA_SIZE);
 
 	if ((intr==NULL) || (sdma==NULL))
 		panic("Can't ioremap PIC/SDMA register for init_irq !");
diff -Nru a/arch/ppc/syslib/mpc52xx_setup.c b/arch/ppc/syslib/mpc52xx_setup.c
--- a/arch/ppc/syslib/mpc52xx_setup.c	2005-03-26 19:56:12 +01:00
+++ b/arch/ppc/syslib/mpc52xx_setup.c	2005-03-26 19:56:12 +01:00
@@ -38,8 +38,7 @@
 void
 mpc52xx_restart(char *cmd)
 {
-	struct mpc52xx_gpt __iomem *gpt0 =
-		(struct mpc52xx_gpt __iomem *) MPC52xx_GPTx(0);
+	struct mpc52xx_gpt __iomem *gpt0 = MPC52xx_VA(MPC52xx_GPTx_OFFSET(0));
 
 	local_irq_disable();
 
@@ -92,9 +91,7 @@
 
 
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
-#ifdef MPC52xx_PF_CONSOLE_PORT
-#define MPC52xx_CONSOLE MPC52xx_PSCx(MPC52xx_PF_CONSOLE_PORT)
-#else
+#ifndef MPC52xx_PF_CONSOLE_PORT
 #error "mpc52xx PSC for console not selected"
 #endif
 
@@ -110,8 +107,9 @@
 mpc52xx_progress(char *s, unsigned short hex)
 {
 	char c;
-	struct mpc52xx_psc __iomem *psc =
-		(struct mpc52xx_psc __iomem *)MPC52xx_CONSOLE;
+	struct mpc52xx_psc __iomem *psc;
+
+	psc = MPC52xx_VA(MPC52xx_PSCx_OFFSET(MPC52xx_PF_CONSOLE_PORT));
 
 	while ((c = *s++) != 0) {
 		if (c == '\n')
@@ -140,7 +138,7 @@
 		u32 sdram_config_0, sdram_config_1;
 
 		/* Temp BAT2 mapping active when this is called ! */
-		mmap_ctl = (struct mpc52xx_mmap_ctl __iomem *) MPC52xx_MMAP_CTL;
+		mmap_ctl = MPC52xx_VA(MPC52xx_MMAP_CTL_OFFSET);
 
 		sdram_config_0 = in_be32(&mmap_ctl->sdram0);
 		sdram_config_1 = in_be32(&mmap_ctl->sdram1);
@@ -170,8 +168,8 @@
 		struct mpc52xx_rtc __iomem *rtc;
 		struct mpc52xx_cdm __iomem *cdm;
 
-		rtc = ioremap(MPC52xx_RTC, sizeof(struct mpc52xx_rtc));
-		cdm = ioremap(MPC52xx_CDM, sizeof(struct mpc52xx_cdm));
+		rtc = ioremap(MPC52xx_PA(MPC52xx_RTC_OFFSET), MPC52xx_RTC_SIZE);
+		cdm = ioremap(MPC52xx_PA(MPC52xx_CDM_OFFSET), MPC52xx_CDM_SIZE);
 
 		if ((rtc==NULL) || (cdm==NULL))
 			panic("Can't ioremap RTC/CDM while computing bus freq");
diff -Nru a/include/asm-ppc/mpc52xx.h b/include/asm-ppc/mpc52xx.h
--- a/include/asm-ppc/mpc52xx.h	2005-03-26 19:56:12 +01:00
+++ b/include/asm-ppc/mpc52xx.h	2005-03-26 19:56:12 +01:00
@@ -10,7 +10,7 @@
  * Originally written by Dale Farnsworth <dfarnsworth@mvista.com> 
  * for the 2.4 kernel.
  *
- * Copyright (C) 2004 Sylvain Munaut <tnt@246tNt.com>
+ * Copyright (C) 2004-2005 Sylvain Munaut <tnt@246tNt.com>
  * Copyright (C) 2003 MontaVista, Software, Inc.
  *
  * This file is licensed under the terms of the GNU General Public License
@@ -32,46 +32,44 @@
 /* ======================================================================== */
 /* Main registers/struct addresses                                          */
 /* ======================================================================== */
-/* Theses are PHYSICAL addresses !                                          */
-/* TODO : There should be no static mapping, but it's not yet the case, so  */
-/*        we require a 1:1 mapping                                          */
 
+/* MBAR position */
 #define MPC52xx_MBAR		0xf0000000	/* Phys address */
-#define MPC52xx_MBAR_SIZE	0x00010000
 #define MPC52xx_MBAR_VIRT	0xf0000000	/* Virt address */
+#define MPC52xx_MBAR_SIZE	0x00010000
+
+#define MPC52xx_PA(x)		((phys_addr_t)(MPC52xx_MBAR + (x)))
+#define MPC52xx_VA(x)		((void __iomem *)(MPC52xx_MBAR_VIRT + (x)))
 
-#define MPC52xx_MMAP_CTL	(MPC52xx_MBAR + 0x0000)
-#define MPC52xx_SDRAM		(MPC52xx_MBAR + 0x0100)
-#define MPC52xx_CDM		(MPC52xx_MBAR + 0x0200)
-#define MPC52xx_SFTRST		(MPC52xx_MBAR + 0x0220)
-#define MPC52xx_SFTRST_BIT	0x01000000
-#define MPC52xx_INTR		(MPC52xx_MBAR + 0x0500)
-#define MPC52xx_GPTx(x)		(MPC52xx_MBAR + 0x0600 + ((x)<<4))
-#define MPC52xx_RTC		(MPC52xx_MBAR + 0x0800)
-#define MPC52xx_MSCAN1		(MPC52xx_MBAR + 0x0900)
-#define MPC52xx_MSCAN2		(MPC52xx_MBAR + 0x0980)
-#define MPC52xx_GPIO		(MPC52xx_MBAR + 0x0b00)
-#define MPC52xx_GPIO_WKUP	(MPC52xx_MBAR + 0x0c00)
-#define MPC52xx_PCI		(MPC52xx_MBAR + 0x0d00)
-#define MPC52xx_USB_OHCI	(MPC52xx_MBAR + 0x1000)
-#define MPC52xx_SDMA		(MPC52xx_MBAR + 0x1200)
-#define MPC52xx_XLB		(MPC52xx_MBAR + 0x1f00)
-#define MPC52xx_PSCx(x)		(MPC52xx_MBAR + 0x2000 + ((x)<<9))
-#define MPC52xx_PSC1		(MPC52xx_MBAR + 0x2000)
-#define MPC52xx_PSC2		(MPC52xx_MBAR + 0x2200)
-#define MPC52xx_PSC3		(MPC52xx_MBAR + 0x2400)
-#define MPC52xx_PSC4		(MPC52xx_MBAR + 0x2600)
-#define MPC52xx_PSC5		(MPC52xx_MBAR + 0x2800)
-#define MPC52xx_PSC6		(MPC52xx_MBAR + 0x2C00)
-#define MPC52xx_FEC		(MPC52xx_MBAR + 0x3000)
-#define MPC52xx_ATA		(MPC52xx_MBAR + 0x3a00)
-#define MPC52xx_I2C1		(MPC52xx_MBAR + 0x3d00)
-#define MPC52xx_I2C_MICR	(MPC52xx_MBAR + 0x3d20)
-#define MPC52xx_I2C2		(MPC52xx_MBAR + 0x3d40)
+/* Registers zone offset/size  */
+#define MPC52xx_MMAP_CTL_OFFSET		0x0000
+#define MPC52xx_MMAP_CTL_SIZE		0x068
+#define MPC52xx_SDRAM_OFFSET		0x0100
+#define MPC52xx_SDRAM_SIZE		0x010
+#define MPC52xx_CDM_OFFSET		0x0200
+#define MPC52xx_CDM_SIZE		0x038
+#define MPC52xx_INTR_OFFSET		0x0500
+#define MPC52xx_INTR_SIZE		0x04c
+#define MPC52xx_GPTx_OFFSET(x)		(0x0600 + ((x)<<4))
+#define MPC52xx_GPT_SIZE		0x010
+#define MPC52xx_RTC_OFFSET		0x0800
+#define MPC52xx_RTC_SIZE		0x024
+#define MPC52xx_GPIO_OFFSET		0x0b00
+#define MPC52xx_GPIO_SIZE		0x040
+#define MPC52xx_GPIO_WKUP_OFFSET	0x0c00
+#define MPC52xx_GPIO_WKUP_SIZE		0x028
+#define MPC52xx_PCI_OFFSET		0x0d00
+#define MPC52xx_PCI_SIZE		0x100
+#define MPC52xx_SDMA_OFFSET		0x1200
+#define MPC52xx_SDMA_SIZE		0x100
+#define MPC52xx_XLB_OFFSET		0x1f00
+#define MPC52xx_XLB_SIZE		0x100
+#define MPC52xx_PSCx_OFFSET(x)		(((x)!=6)?(0x1e00+((x)<<9)):0x2c00)
+#define MPC52xx_PSC_SIZE		0x0a0
 
 /* SRAM used for SDMA */
-#define MPC52xx_SRAM		(MPC52xx_MBAR + 0x8000)
-#define MPC52xx_SRAM_SIZE	(16*1024)
+#define MPC52xx_SRAM_OFFSET		0x8000
+#define MPC52xx_SRAM_SIZE		0x4000
 
 
 /* ======================================================================== */
@@ -118,11 +116,12 @@
 #define MPC52xx_SPI_SPIF_IRQ		(MPC52xx_PERP_IRQ_BASE + 14)
 #define MPC52xx_I2C1_IRQ		(MPC52xx_PERP_IRQ_BASE + 15)
 #define MPC52xx_I2C2_IRQ		(MPC52xx_PERP_IRQ_BASE + 16)
-#define MPC52xx_CAN1_IRQ		(MPC52xx_PERP_IRQ_BASE + 17)
-#define MPC52xx_CAN2_IRQ		(MPC52xx_PERP_IRQ_BASE + 18)
+#define MPC52xx_MSCAN1_IRQ		(MPC52xx_PERP_IRQ_BASE + 17)
+#define MPC52xx_MSCAN2_IRQ		(MPC52xx_PERP_IRQ_BASE + 18)
 #define MPC52xx_IR_RX_IRQ		(MPC52xx_PERP_IRQ_BASE + 19)
 #define MPC52xx_IR_TX_IRQ		(MPC52xx_PERP_IRQ_BASE + 20)
 #define MPC52xx_XLB_ARB_IRQ		(MPC52xx_PERP_IRQ_BASE + 21)
+#define MPC52xx_BDLC_IRQ		(MPC52xx_PERP_IRQ_BASE + 22)
 
 
 
@@ -162,7 +161,7 @@
 	u32	cs6_start;	/* MMAP_CTRL + 0x58 */
 	u32	cs6_stop;	/* MMAP_CTRL + 0x5c */
 	u32	cs7_start;	/* MMAP_CTRL + 0x60 */
-	u32	cs7_stop;	/* MMAP_CTRL + 0x60 */
+	u32	cs7_stop;	/* MMAP_CTRL + 0x64 */
 };
 
 /* SDRAM control */
@@ -208,7 +207,7 @@
 
 	u16	tcr[16];	/* SDMA + 0x1c .. 0x3a */
 
-	u8	ipr[32];	/* SDMA + 0x3c .. 5b */
+	u8	ipr[32];	/* SDMA + 0x3c .. 0x5b */
 
 	u32	cReqSelect;	/* SDMA + 0x5c */
 	u32	task_size0;	/* SDMA + 0x60 */

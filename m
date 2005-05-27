Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id E52F4679EB
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 May 2005 05:18:58 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	j4RJOAeF011357 for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 May 2005 12:24:10 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id j4RJKKww016212
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 May 2005 14:20:20 -0500 (CDT)
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
In-Reply-To: <f003613a0526b7b6a00a0bd477cd5ac3@freescale.com>
References: <1116607235.29111.20.camel@gleep>
	<f003613a0526b7b6a00a0bd477cd5ac3@freescale.com>
Content-Type: text/plain
Message-Id: <1117221536.26114.99.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Fri, 27 May 2005 14:18:56 -0500
Subject: bd_t Cleaning: Driver Bits
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2005-05-26 at 18:08, Kumar Gala wrote:
> Jon,
> 
> Can you break the patch up into a few pieces, it will be easier to 
> review that way.  Here are the following pieces that make sense to me:
> 
> 0. New firmware interface (fw_bdt*, Kconfig, ...)
> 1. board code changes (everything in arch/ppc/platforms/*)
> 2. driver changes (things in *_io, ide, net, serial dirs -- try to give 
> a better list below)
> 3. System changes (files in arch/ppc/syslib and include/asm-ppc)

And Part 3 of 4 is the Driver Bits:


 ppc/8260_io/enet.c                      |    9 
 ppc/8260_io/fcc_enet.c                  |   15 
 ppc/8xx_io/commproc.c                   |    3 
 ppc/8xx_io/enet.c                       |   10 
 ppc/8xx_io/fec.c                        |    8 
 ide/ppc/mpc8xx.c                        |   14 
 mtd/maps/tqm8xxl.c                      |    7 
 net/fec.c                               |    6 
 net/fec_8xx/fec_8xx-netta.c             |    5 
 net/oaknet.c                            |    6 
 serial/68360serial.c                    |    3 
 serial/cpm_uart/cpm_uart_core.c         |    8 
 serial/cpm_uart/cpm_uart_cpm1.c         |   13 
 serial/cpm_uart/cpm_uart_cpm2.c         |   13 
 serial/mpc52xx_uart.c                   |   11 

Index: arch/ppc/8260_io/enet.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/8260_io/enet.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/8260_io/enet.c  (mode:100644)
@@ -47,6 +47,7 @@
 #include <asm/uaccess.h>
 #include <asm/cpm2.h>
 #include <asm/irq.h>
+#include <asm/firmware.h>
 
 /*
  *				Theory of Operation
@@ -614,9 +615,8 @@
 	struct scc_enet_private *cep;
 	int i, j, err;
 	uint dp_offset;
-	unsigned char	*eap;
+	unsigned char	*eap, *p_addr;
 	unsigned long	mem_addr;
-	bd_t		*bd;
 	volatile	cbd_t		*bdp;
 	volatile	cpm_cpm2_t	*cp;
 	volatile	scc_t		*sccp;
@@ -629,8 +629,6 @@
 	immap = (cpm2_map_t *)CPM_MAP_ADDR;	/* and to internal registers */
 	io = &immap->im_ioport;
 
-	bd = (bd_t *)__res;
-
 	/* Create an Ethernet device instance.
 	*/
 	dev = alloc_etherdev(sizeof(*cep));
@@ -735,9 +733,10 @@
 	 * This is supplied in the board information structure, so we
 	 * copy that into the controller.
 	 */
+	p_addr = fw_get_enetaddr(0);
 	eap = (unsigned char *)&(ep->sen_paddrh);
 	for (i=5; i>=0; i--)
-		*eap++ = dev->dev_addr[i] = bd->bi_enetaddr[i];
+		*eap++ = dev->dev_addr[i] = p_addr[i];
 
 	ep->sen_pper = 0;	/* 'cause the book says so */
 	ep->sen_taddrl = 0;	/* temp address (LSB) */
Index: arch/ppc/8260_io/fcc_enet.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/8260_io/fcc_enet.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/8260_io/fcc_enet.c  (mode:100644)
@@ -47,6 +47,7 @@
 #include <asm/irq.h>
 #include <asm/uaccess.h>
 #include <asm/signal.h>
+#include <asm/firmware.h>
 
 /* We can't use the PHY interrupt if we aren't using MDIO. */
 #if !defined(CONFIG_USE_MDIO)
@@ -1866,9 +1867,8 @@
 init_fcc_param(fcc_info_t *fip, struct net_device *dev,
 						volatile cpm2_map_t *immap)
 {
-	unsigned char	*eap;
+	unsigned char	*eap, *p_addr;
 	unsigned long	mem_addr;
-	bd_t		*bd;
 	int		i, j;
 	struct		fcc_enet_private *cep;
 	volatile	fcc_enet_t	*ep;
@@ -1879,8 +1879,6 @@
 	ep = cep->ep;
 	cp = cpmp;
 
-	bd = (bd_t *)__res;
-
 	/* Zero the whole thing.....I must have missed some individually.
 	 * It works when I do this.
 	 */
@@ -1962,6 +1960,7 @@
 	 * it unique by setting a few bits in the upper byte of the
 	 * non-static part of the address.
 	 */
+	p_addr = fw_get_enetaddr(0);
 	eap = (unsigned char *)&(ep->fen_paddrh);
 	for (i=5; i>=0; i--) {
 
@@ -1971,22 +1970,22 @@
  */
 #ifdef CONFIG_SBC82xx
 		if (i == 5) {
-			/* bd->bi_enetaddr holds the SCC0 address; the FCC
+			/* p_addr holds the SCC0 address; the FCC
 			   devices count up from there */
-			dev->dev_addr[i] = bd->bi_enetaddr[i] & ~3;
+			dev->dev_addr[i] = p_addr[i] & ~3;
 			dev->dev_addr[i] += 1 + fip->fc_fccnum;
 			*eap++ = dev->dev_addr[i];
 		}
 #else
 #ifndef CONFIG_RPX8260
 		if (i == 3) {
-			dev->dev_addr[i] = bd->bi_enetaddr[i];
+			dev->dev_addr[i] = p_addr[i];
 			dev->dev_addr[i] |= (1 << (7 - fip->fc_fccnum));
 			*eap++ = dev->dev_addr[i];
 		} else
 #endif
 		{
-			*eap++ = dev->dev_addr[i] = bd->bi_enetaddr[i];
+			*eap++ = dev->dev_addr[i] = p_addr[i];
 		}
 #endif
 	}
Index: arch/ppc/8xx_io/commproc.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/8xx_io/commproc.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/8xx_io/commproc.c  (mode:100644)
@@ -38,6 +38,7 @@
 #include <asm/io.h>
 #include <asm/tlbflush.h>
 #include <asm/rheap.h>
+#include <asm/firmware.h>
 
 extern int get_pteptr(struct mm_struct *mm, unsigned long addr, pte_t **ptep);
 
@@ -346,7 +347,7 @@
  * The internal baud rate clock is the system clock divided by 16.
  * This assumes the baudrate is 16x oversampled by the uart.
  */
-#define BRG_INT_CLK		(((bd_t *)__res)->bi_intfreq)
+#define BRG_INT_CLK		(fw_get_intfreq())
 #define BRG_UART_CLK		(BRG_INT_CLK/16)
 #define BRG_UART_CLK_DIV16	(BRG_UART_CLK/16)
 
Index: arch/ppc/8xx_io/enet.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/8xx_io/enet.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/8xx_io/enet.c  (mode:100644)
@@ -46,6 +46,8 @@
 #include <asm/mpc8xx.h>
 #include <asm/uaccess.h>
 #include <asm/commproc.h>
+#include <asm/firmware.h>
+
 
 /*
  *				Theory of Operation
@@ -646,9 +648,8 @@
 	struct scc_enet_private *cep;
 	int i, j, k, err;
 	uint dp_offset;
-	unsigned char	*eap, *ba;
+	unsigned char	*eap, *ba, *p_addr;
 	dma_addr_t	mem_addr;
-	bd_t		*bd;
 	volatile	cbd_t		*bdp;
 	volatile	cpm8xx_t	*cp;
 	volatile	scc_t		*sccp;
@@ -659,8 +660,6 @@
 
 	immap = (immap_t *)(mfspr(SPRN_IMMR) & 0xFFFF0000);	/* and to internal registers */
 
-	bd = (bd_t *)__res;
-
 	dev = alloc_etherdev(sizeof(*cep));
 	if (!dev)
 		return -ENOMEM;
@@ -803,9 +802,10 @@
 
 	/* Set Ethernet station address.
 	 */
+	p_addr = fw_get_enetaddr(0);
 	eap = (unsigned char *)&(ep->sen_paddrh);
 	for (i=5; i>=0; i--)
-		*eap++ = dev->dev_addr[i] = bd->bi_enetaddr[i];
+		*eap++ = dev->dev_addr[i] = p_addr[i];
 
 	ep->sen_pper = 0;	/* 'cause the book says so */
 	ep->sen_taddrl = 0;	/* temp address (LSB) */
Index: arch/ppc/8xx_io/fec.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/arch/ppc/8xx_io/fec.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/arch/ppc/8xx_io/fec.c  (mode:100644)
@@ -55,6 +55,7 @@
 #include <asm/irq.h>
 #include <asm/uaccess.h>
 #include <asm/commproc.h>
+#include <asm/firmware.h>
 
 #ifdef	CONFIG_USE_MDIO
 /* Forward declarations of some structures to support different PHYs
@@ -1580,15 +1581,12 @@
 	cbd_t		*cbd_base;
 	volatile	immap_t	*immap;
 	volatile	fec_t	*fecp;
-	bd_t		*bd;
 #ifdef CONFIG_SCC_ENET
 	unsigned char	tmpaddr[6];
 #endif
 
 	immap = (immap_t *)IMAP_ADDR;	/* pointer to internal registers */
 
-	bd = (bd_t *)__res;
-
 	dev = alloc_etherdev(sizeof(*fep));
 	if (!dev)
 		return -ENOMEM;
@@ -1613,7 +1611,7 @@
 	 * this needs some work to get unique addresses.
 	 */
 	eap = (unsigned char *)my_enet_addr;
-	iap = bd->bi_enetaddr;
+	iap = fw_get_enetaddr(0);
 
 #ifdef CONFIG_SCC_ENET
 	/*
@@ -1744,7 +1742,7 @@
 	/* Set MII speed to 2.5 MHz
 	*/
 	fecp->fec_mii_speed = fep->phy_speed =
-		(( (bd->bi_intfreq + 500000) / 2500000 / 2 ) & 0x3F ) << 1;
+		(( (fw_get_intfreq() + 500000) / 2500000 / 2 ) & 0x3F ) << 1;
 #else
 	fecp->fec_mii_speed = 0;	/* turn off MDIO */
 #endif	/* CONFIG_USE_MDIO */
Index: drivers/ide/ppc/mpc8xx.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/drivers/ide/ppc/mpc8xx.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/drivers/ide/ppc/mpc8xx.c  (mode:100644)
@@ -41,6 +41,7 @@
 #include <asm/8xx_immap.h>
 #include <asm/machdep.h>
 #include <asm/irq.h>
+#include <asm/firmware.h>
 
 static int identify  (volatile u8 *p);
 static void print_fixed (volatile u8 *p);
@@ -177,6 +178,7 @@
 	u32 pcmcia_phy_end;
 	static unsigned long pcmcia_base = 0;
 	unsigned long base;
+	unsigned int busfreq;
 
 	*p = 0;
 	if (irq)
@@ -224,21 +226,19 @@
 		printk ("PCMCIA virt base: %08lx\n", pcmcia_base);
 #endif
 		/* Compute clock cycles for PIO timings */
+		busfreq = fw_get_busfreq();
 		for (i=0; i<6; ++i) {
-			bd_t	*binfo = (bd_t *)__res;
-
 			hold_time[i]   =
-				PCMCIA_MK_CLKS (hold_time[i],
-						binfo->bi_busfreq);
+				PCMCIA_MK_CLKS (hold_time[i], busfreq);
 			ide_pio_clocks[i].setup_time  =
 				PCMCIA_MK_CLKS (ide_pio_timings[i].setup_time,
-						binfo->bi_busfreq);
+						busfreq);
 			ide_pio_clocks[i].active_time =
 				PCMCIA_MK_CLKS (ide_pio_timings[i].active_time,
-						binfo->bi_busfreq);
+						busfreq);
 			ide_pio_clocks[i].cycle_time  =
 				PCMCIA_MK_CLKS (ide_pio_timings[i].cycle_time,
-						binfo->bi_busfreq);
+						busfreq);
 #if 0
 			printk ("PIO mode %d timings: %d/%d/%d => %d/%d/%d\n",
 				i,
Index: drivers/mtd/maps/tqm8xxl.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/drivers/mtd/maps/tqm8xxl.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/drivers/mtd/maps/tqm8xxl.c  (mode:100644)
@@ -33,6 +33,8 @@
 #include <linux/mtd/map.h>
 #include <linux/mtd/partitions.h>
 
+#include <asm/firmware.h>
+
 #define FLASH_ADDR 0x40000000
 #define FLASH_SIZE 0x00800000
 #define FLASH_BANK_MAX 4
@@ -115,10 +117,9 @@
 	int idx = 0, ret = 0;
 	unsigned long flash_addr, flash_size, mtd_size = 0;
 	/* pointer to TQM8xxL board info data */
-	bd_t *bd = (bd_t *)__res;
 
-	flash_addr = bd->bi_flashstart;
-	flash_size = bd->bi_flashsize;
+	flash_addr = fw_get_flashstart();
+	flash_size = fw_get_flashsize();
 
 	//request maximum flash size address space
 	start_scan_addr = ioremap(flash_addr, flash_size);
Index: drivers/net/fec.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/drivers/net/fec.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/drivers/net/fec.c  (mode:100644)
@@ -1426,11 +1426,9 @@
 {
 	struct fec_enet_private *fep = netdev_priv(dev);
 	unsigned char *iap, tmpaddr[6];
-	bd_t *bd;
 	int i;
 
-	iap = bd->bi_enetaddr;
-	bd = (bd_t *)__res;
+	iap = fw_get_enetaddr(0);
 
 #ifdef CONFIG_RPXCLASSIC
 	/* The Embedded Planet boards have only one MAC address in
@@ -1472,7 +1470,7 @@
 	/* Set MII speed to 2.5 MHz
 	*/
 	fecp->fec_mii_speed = fep->phy_speed = 
-		((bd->bi_busfreq * 1000000) / 2500000) & 0x7e;
+		((fw_get_busfreq() * 1000000) / 2500000) & 0x7e;
 }
 
 static void __inline__ fec_enable_phy_intr(void)
Index: drivers/net/fec_8xx/fec_8xx-netta.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/drivers/net/fec_8xx/fec_8xx-netta.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/drivers/net/fec_8xx/fec_8xx-netta.c  (mode:100644)
@@ -29,6 +29,7 @@
 #include <asm/irq.h>
 #include <asm/uaccess.h>
 #include <asm/commproc.h>
+#include <asm/firmware.h>
 
 #include "fec_8xx.h"
 
@@ -76,7 +77,6 @@
 int fec_8xx_platform_init(void)
 {
 	immap_t *immap = (immap_t *)IMAP_ADDR;
-	bd_t *bd = (bd_t *) __res;
 	const char *s;
 	char *e;
 	int i;
@@ -116,8 +116,7 @@
 	setbits16(immap->im_ioport.iop_pcint, 0x0200);
 
 	/* fill up */
-	fec1_info.sys_clk = bd->bi_intfreq;
-	fec2_info.sys_clk = bd->bi_intfreq;
+	fec1_info.sys_clk = fec2_info.sys_clk = fw_get_intfreq();
 
 	s = __fw_getenv("ethaddr");
 	if (s != NULL) {
Index: drivers/net/oaknet.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/drivers/net/oaknet.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/drivers/net/oaknet.c  (mode:100644)
@@ -23,6 +23,7 @@
 
 #include <asm/board.h>
 #include <asm/io.h>
+#include <asm/firmware.h>
 
 #include "8390.h"
 
@@ -101,7 +102,7 @@
 #else
 	unsigned long ioaddr = ioremap(OAKNET_IO_BASE, OAKNET_IO_SIZE);
 #endif
-	bd_t *bip = (bd_t *)__res;
+	unsigned char *p_addr;
 
 	if (!ioaddr)
 		return -ENOMEM;
@@ -170,9 +171,10 @@
 
 	/* Tell the world about what and where we've found. */
 
+	p_addr = fw_get_enetaddr(0);
 	printk("%s: %s at", dev->name, name);
 	for (i = 0; i < ETHER_ADDR_LEN; ++i) {
-		dev->dev_addr[i] = bip->bi_enetaddr[i];
+		dev->dev_addr[i] = p_addr[i];
 		printk("%c%.2x", (i ? ':' : ' '), dev->dev_addr[i]);
 	}
 	printk(", found at %#lx, using IRQ %d.\n", dev->base_addr, dev->irq);
Index: drivers/serial/68360serial.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/drivers/serial/68360serial.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/drivers/serial/68360serial.c  (mode:100644)
@@ -2852,9 +2852,6 @@
 /* mleslie TODO:
  * add something to the 68k bootloader to store a desired initial console baud rate */
 
-/* 	bd_t						*bd; */ /* a board info struct used by EPPC-bug */
-/* 	bd = (bd_t *)__res; */
-
  	for (bidx = 0; bidx < (sizeof(baud_table) / sizeof(int)); bidx++)
 	 /* if (bd->bi_baudrate == baud_table[bidx]) */
  		if (CONSOLE_BAUDRATE == baud_table[bidx])
Index: drivers/serial/cpm_uart/cpm_uart_core.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/drivers/serial/cpm_uart/cpm_uart_core.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/drivers/serial/cpm_uart/cpm_uart_core.c  (mode:100644)
@@ -44,6 +44,7 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/delay.h>
+#include <asm/firmware.h>
 
 #if defined(CONFIG_SERIAL_CPM_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
 #define SUPPORT_SYSRQ
@@ -1051,10 +1052,9 @@
 	if (options) {
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 	} else {
-		bd_t *bd = (bd_t *) __res;
-
-		if (bd->bi_baudrate)
-			baud = bd->bi_baudrate;
+		int rate = fw_get_baudrate();
+		if (rate)
+			baud = rate;
 		else
 			baud = 9600;
 	}
Index: drivers/serial/cpm_uart/cpm_uart_cpm1.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/drivers/serial/cpm_uart/cpm_uart_cpm1.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/drivers/serial/cpm_uart/cpm_uart_cpm1.c  (mode:100644)
@@ -39,6 +39,7 @@
 
 #include <asm/io.h>
 #include <asm/irq.h>
+#include <asm/firmware.h>
 
 #include <linux/serial_core.h>
 #include <linux/kernel.h>
@@ -215,7 +216,7 @@
 	    (unsigned long)&cpmp->cp_smc[0];
 	cpm_uart_ports[UART_SMC1].smcp->smc_smcm |= (SMCM_RX | SMCM_TX);
 	cpm_uart_ports[UART_SMC1].smcp->smc_smcmr &= ~(SMCMR_REN | SMCMR_TEN);
-	cpm_uart_ports[UART_SMC1].port.uartclk = (((bd_t *) __res)->bi_intfreq);
+	cpm_uart_ports[UART_SMC1].port.uartclk = fw_get_intfreq();
 	cpm_uart_port_map[cpm_uart_nr++] = UART_SMC1;
 #endif
 
@@ -227,7 +228,7 @@
 	    (unsigned long)&cpmp->cp_smc[1];
 	cpm_uart_ports[UART_SMC2].smcp->smc_smcm |= (SMCM_RX | SMCM_TX);
 	cpm_uart_ports[UART_SMC2].smcp->smc_smcmr &= ~(SMCMR_REN | SMCMR_TEN);
-	cpm_uart_ports[UART_SMC2].port.uartclk = (((bd_t *) __res)->bi_intfreq);
+	cpm_uart_ports[UART_SMC2].port.uartclk = fw_get_intfreq();
 	cpm_uart_port_map[cpm_uart_nr++] = UART_SMC2;
 #endif
 
@@ -241,7 +242,7 @@
 	    ~(UART_SCCM_TX | UART_SCCM_RX);
 	cpm_uart_ports[UART_SCC1].sccp->scc_gsmrl &=
 	    ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-	cpm_uart_ports[UART_SCC1].port.uartclk = (((bd_t *) __res)->bi_intfreq);
+	cpm_uart_ports[UART_SCC1].port.uartclk = fw_get_intfreq();
 	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC1;
 #endif
 
@@ -255,7 +256,7 @@
 	    ~(UART_SCCM_TX | UART_SCCM_RX);
 	cpm_uart_ports[UART_SCC2].sccp->scc_gsmrl &=
 	    ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-	cpm_uart_ports[UART_SCC2].port.uartclk = (((bd_t *) __res)->bi_intfreq);
+	cpm_uart_ports[UART_SCC2].port.uartclk = fw_get_intfreq();
 	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC2;
 #endif
 
@@ -269,7 +270,7 @@
 	    ~(UART_SCCM_TX | UART_SCCM_RX);
 	cpm_uart_ports[UART_SCC3].sccp->scc_gsmrl &=
 	    ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-	cpm_uart_ports[UART_SCC3].port.uartclk = (((bd_t *) __res)->bi_intfreq);
+	cpm_uart_ports[UART_SCC3].port.uartclk = fw_get_intfreq();
 	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC3;
 #endif
 
@@ -283,7 +284,7 @@
 	    ~(UART_SCCM_TX | UART_SCCM_RX);
 	cpm_uart_ports[UART_SCC4].sccp->scc_gsmrl &=
 	    ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-	cpm_uart_ports[UART_SCC4].port.uartclk = (((bd_t *) __res)->bi_intfreq);
+	cpm_uart_ports[UART_SCC4].port.uartclk = fw_get_intfreq();
 	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC4;
 #endif
 	return 0;
Index: drivers/serial/cpm_uart/cpm_uart_cpm2.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/drivers/serial/cpm_uart/cpm_uart_cpm2.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/drivers/serial/cpm_uart/cpm_uart_cpm2.c  (mode:100644)
@@ -39,6 +39,7 @@
 
 #include <asm/io.h>
 #include <asm/irq.h>
+#include <asm/firmware.h>
 
 #include <linux/serial_core.h>
 #include <linux/kernel.h>
@@ -252,7 +253,7 @@
 	    (unsigned long)&cpm2_immr->im_smc[0];
 	cpm_uart_ports[UART_SMC1].smcp->smc_smcm |= (SMCM_RX | SMCM_TX);
 	cpm_uart_ports[UART_SMC1].smcp->smc_smcmr &= ~(SMCMR_REN | SMCMR_TEN);
-	cpm_uart_ports[UART_SMC1].port.uartclk = (((bd_t *) __res)->bi_intfreq);
+	cpm_uart_ports[UART_SMC1].port.uartclk = fw_get_intfreq();
 	cpm_uart_port_map[cpm_uart_nr++] = UART_SMC1;
 #endif
 
@@ -264,7 +265,7 @@
 	    (unsigned long)&cpm2_immr->im_smc[1];
 	cpm_uart_ports[UART_SMC2].smcp->smc_smcm |= (SMCM_RX | SMCM_TX);
 	cpm_uart_ports[UART_SMC2].smcp->smc_smcmr &= ~(SMCMR_REN | SMCMR_TEN);
-	cpm_uart_ports[UART_SMC2].port.uartclk = (((bd_t *) __res)->bi_intfreq);
+	cpm_uart_ports[UART_SMC2].port.uartclk = fw_get_intfreq();
 	cpm_uart_port_map[cpm_uart_nr++] = UART_SMC2;
 #endif
 
@@ -278,7 +279,7 @@
 	    ~(UART_SCCM_TX | UART_SCCM_RX);
 	cpm_uart_ports[UART_SCC1].sccp->scc_gsmrl &=
 	    ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-	cpm_uart_ports[UART_SCC1].port.uartclk = (((bd_t *) __res)->bi_intfreq);
+	cpm_uart_ports[UART_SCC1].port.uartclk = fw_get_intfreq();
 	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC1;
 #endif
 
@@ -292,7 +293,7 @@
 	    ~(UART_SCCM_TX | UART_SCCM_RX);
 	cpm_uart_ports[UART_SCC2].sccp->scc_gsmrl &=
 	    ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-	cpm_uart_ports[UART_SCC2].port.uartclk = (((bd_t *) __res)->bi_intfreq);
+	cpm_uart_ports[UART_SCC2].port.uartclk = fw_get_intfreq();
 	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC2;
 #endif
 
@@ -306,7 +307,7 @@
 	    ~(UART_SCCM_TX | UART_SCCM_RX);
 	cpm_uart_ports[UART_SCC3].sccp->scc_gsmrl &=
 	    ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-	cpm_uart_ports[UART_SCC3].port.uartclk = (((bd_t *) __res)->bi_intfreq);
+	cpm_uart_ports[UART_SCC3].port.uartclk = fw_get_intfreq();
 	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC3;
 #endif
 
@@ -320,7 +321,7 @@
 	    ~(UART_SCCM_TX | UART_SCCM_RX);
 	cpm_uart_ports[UART_SCC4].sccp->scc_gsmrl &=
 	    ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-	cpm_uart_ports[UART_SCC4].port.uartclk = (((bd_t *) __res)->bi_intfreq);
+	cpm_uart_ports[UART_SCC4].port.uartclk = fw_get_intfreq();
 	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC4;
 #endif
 
Index: drivers/serial/mpc52xx_uart.c
===================================================================
--- c7d7a187a2125518e655dfeadffd38156239ffc3/drivers/serial/mpc52xx_uart.c  (mode:100644)
+++ eb4292a8874abcc926f536de90af0bdb001cf12e/drivers/serial/mpc52xx_uart.c  (mode:100644)
@@ -54,6 +54,7 @@
 
 #include <asm/delay.h>
 #include <asm/io.h>
+#include <asm/firmware.h>
 
 #include <asm/mpc52xx.h>
 #include <asm/mpc52xx_psc.h>
@@ -572,14 +573,16 @@
 {
 	struct mpc52xx_psc __iomem *psc = PSC(port);
 	unsigned char mr1;
+	unsigned int fw_baud;
 
 	/* Read the mode registers */
 	out_8(&psc->command,MPC52xx_PSC_SEL_MODE_REG_1);
 	mr1 = in_8(&psc->mode);
 	
 	/* CT{U,L}R are write-only ! */
-	*baud = __res.bi_baudrate ?
-		__res.bi_baudrate : CONFIG_SERIAL_MPC52xx_CONSOLE_BAUD;
+	fw_baud = fw_get_baudrate();
+	*baud = fw_baud ?
+		fw_baud : CONFIG_SERIAL_MPC52xx_CONSOLE_BAUD;
 
 	/* Parse them */
 	switch (mr1 & MPC52xx_PSC_MODE_BITS_MASK) {
@@ -649,7 +652,7 @@
 	/* Basic port init. Needed since we use some uart_??? func before
 	 * real init for early access */
 	spin_lock_init(&port->lock);
-	port->uartclk	= __res.bi_ipbfreq / 2; /* Look at CTLR doc */
+	port->uartclk	= fw_get_ipbfreq() / 2; /* Look at CTLR doc */
 	port->ops	= &mpc52xx_uart_ops;
 	port->mapbase	= MPC52xx_PA(MPC52xx_PSCx_OFFSET(co->index+1));
 
@@ -739,7 +742,7 @@
 	memset(port, 0x00, sizeof(struct uart_port));
 
 	spin_lock_init(&port->lock);
-	port->uartclk	= __res.bi_ipbfreq / 2; /* Look at CTLR doc */
+	port->uartclk	= fw_get_ipbfreq() / 2; /* Look at CTLR doc */
 	port->fifosize	= 255; /* Should be 512 ! But it can't be */
 	                       /* stored in a unsigned char       */
 	port->iotype	= UPIO_MEM;

Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4593DDF106
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:36:09 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l6I1a1GF027714
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:36:02 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1a1Go001565
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:36:01 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I1BKCC007971
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:11:20 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 4ADA2AEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:36:00 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1a0Q7015445
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:36:00 -0500
Date: Tue, 17 Jul 2007 20:36:00 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 46/61] mpc885ads: Rework initialization.
Message-ID: <20070718013600.GR15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It now uses the generic pin/clock functions, among other assorted fixes and
cleanup.

The ioport init and device exclusion callbacks are now gone.

The PCMCIA fsl_soc.c code is now gone, since of_platform_bus_probe() is
now used.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/platforms/8xx/mpc885ads.h       |   38 ---
 arch/powerpc/platforms/8xx/mpc885ads_setup.c |  448 ++++++++-----------------
 arch/powerpc/sysdev/fsl_soc.c                |   25 --
 3 files changed, 144 insertions(+), 367 deletions(-)

diff --git a/arch/powerpc/platforms/8xx/mpc885ads.h b/arch/powerpc/platforms/8xx/mpc885ads.h
index 7c31aec..4df3c19 100644
--- a/arch/powerpc/platforms/8xx/mpc885ads.h
+++ b/arch/powerpc/platforms/8xx/mpc885ads.h
@@ -18,18 +18,6 @@
 #include <asm/ppcboot.h>
 #include <sysdev/fsl_soc.h>
 
-/* U-Boot maps BCSR to 0xff080000 */
-#define BCSR_ADDR		((uint)0xff080000)
-#define BCSR_SIZE		((uint)32)
-#define BCSR0			((uint)(BCSR_ADDR + 0x00))
-#define BCSR1			((uint)(BCSR_ADDR + 0x04))
-#define BCSR2			((uint)(BCSR_ADDR + 0x08))
-#define BCSR3			((uint)(BCSR_ADDR + 0x0c))
-#define BCSR4			((uint)(BCSR_ADDR + 0x10))
-
-#define CFG_PHYDEV_ADDR		((uint)0xff0a0000)
-#define BCSR5			((uint)(CFG_PHYDEV_ADDR + 0x300))
-
 #define IMAP_ADDR		(get_immrbase())
 #define IMAP_SIZE		((uint)(64 * 1024))
 
@@ -37,9 +25,6 @@
 #define CPM_MAP_ADDR		(get_immrbase() + MPC8xx_CPM_OFFSET)
 #define CPM_IRQ_OFFSET		16     // for compability with cpm_uart driver
 
-#define PCMCIA_MEM_ADDR		((uint)0xff020000)
-#define PCMCIA_MEM_SIZE		((uint)(64 * 1024))
-
 /* Bits of interest in the BCSRs.
  */
 #define BCSR1_ETHEN		((uint)0x20000000)
@@ -68,28 +53,5 @@
 #define BCSR5_MII1_EN		0x02
 #define BCSR5_MII1_RST		0x01
 
-/* Interrupt level assignments */
-#define PHY_INTERRUPT	SIU_IRQ7	/* PHY link change interrupt */
-#define SIU_INT_FEC1	SIU_LEVEL1	/* FEC1 interrupt */
-#define SIU_INT_FEC2	SIU_LEVEL3	/* FEC2 interrupt */
-#define FEC_INTERRUPT	SIU_INT_FEC1	/* FEC interrupt */
-
-/* We don't use the 8259 */
-#define NR_8259_INTS	0
-
-/* CPM Ethernet through SCC3 */
-#define PA_ENET_RXD	((ushort)0x0040)
-#define PA_ENET_TXD	((ushort)0x0080)
-#define PE_ENET_TCLK	((uint)0x00004000)
-#define PE_ENET_RCLK	((uint)0x00008000)
-#define PE_ENET_TENA	((uint)0x00000010)
-#define PC_ENET_CLSN	((ushort)0x0400)
-#define PC_ENET_RENA	((ushort)0x0800)
-
-/* Control bits in the SICR to route TCLK (CLK5) and RCLK (CLK6) to
- * SCC3.  Also, make sure GR3 (bit 8) and SC3 (bit 9) are zero */
-#define SICR_ENET_MASK	((uint)0x00ff0000)
-#define SICR_ENET_CLKRT	((uint)0x002c0000)
-
 #endif /* __ASM_MPC885ADS_H__ */
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/platforms/8xx/mpc885ads_setup.c b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
index dc27dab..940fe54 100644
--- a/arch/powerpc/platforms/8xx/mpc885ads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
@@ -6,6 +6,9 @@
  *
  * Copyright 2005 MontaVista Software Inc.
  *
+ * Heavily modified by Scott Wood <scottwood@freescale.com>
+ * Copyright 2007 Freescale Semiconductor, Inc.
+ *
  * This file is licensed under the terms of the GNU General Public License
  * version 2. This program is licensed "as is" without any warranty of any
  * kind, whether express or implied.
@@ -18,7 +21,6 @@
 #include <linux/ioport.h>
 #include <linux/device.h>
 #include <linux/delay.h>
-#include <linux/root_dev.h>
 
 #include <linux/fs_enet_pd.h>
 #include <linux/fs_uart_pd.h>
@@ -37,7 +39,8 @@
 #include <asm/8xx_immap.h>
 #include <asm/commproc.h>
 #include <asm/fs_pd.h>
-#include <asm/prom.h>
+#include <asm/of_platform.h>
+#include <asm/udbg.h>
 
 extern void cpm_reset(void);
 extern void mpc8xx_show_cpuinfo(struct seq_file*);
@@ -48,30 +51,20 @@ extern void mpc8xx_get_rtc_time(struct rtc_time *tm);
 extern void m8xx_pic_init(void);
 extern unsigned int mpc8xx_get_irq(void);
 
-static void init_smc1_uart_ioports(struct fs_uart_platform_info* fpi);
-static void init_smc2_uart_ioports(struct fs_uart_platform_info* fpi);
-static void init_scc3_ioports(struct fs_platform_info* ptr);
+static u32 __iomem *bcsr, *bcsr5;
 
 #ifdef CONFIG_PCMCIA_M8XX
 static void pcmcia_hw_setup(int slot, int enable)
 {
-	unsigned *bcsr_io;
-
-	bcsr_io = ioremap(BCSR1, sizeof(unsigned long));
 	if (enable)
-		clrbits32(bcsr_io, BCSR1_PCCEN);
+		clrbits32(&bcsr[1], BCSR1_PCCEN);
 	else
-		setbits32(bcsr_io, BCSR1_PCCEN);
-
-	iounmap(bcsr_io);
+		setbits32(&bcsr[1], BCSR1_PCCEN);
 }
 
 static int pcmcia_set_voltage(int slot, int vcc, int vpp)
 {
 	u32 reg = 0;
-	unsigned *bcsr_io;
-
-	bcsr_io = ioremap(BCSR1, sizeof(unsigned long));
 
 	switch(vcc) {
 	case 0:
@@ -106,346 +99,188 @@ static int pcmcia_set_voltage(int slot, int vcc, int vpp)
 	}
 
 	/* first, turn off all power */
-	clrbits32(bcsr_io, 0x00610000);
+	clrbits32(&bcsr[1], 0x00610000);
 
 	/* enable new powersettings */
-	setbits32(bcsr_io, reg);
+	setbits32(&bcsr[1], reg);
 
-	iounmap(bcsr_io);
 	return 0;
 }
 #endif
 
-void __init mpc885ads_board_setup(void)
-{
-	cpm8xx_t *cp;
-	unsigned int *bcsr_io;
-	u8 tmpval8;
-
-#ifdef CONFIG_FS_ENET
-	iop8xx_t *io_port;
-#endif
-
-	bcsr_io = ioremap(BCSR1, sizeof(unsigned long));
-	cp = (cpm8xx_t *)immr_map(im_cpm);
-
-	if (bcsr_io == NULL) {
-		printk(KERN_CRIT "Could not remap BCSR\n");
-		return;
-	}
-#ifdef CONFIG_SERIAL_CPM_SMC1
-	clrbits32(bcsr_io, BCSR1_RS232EN_1);
-	clrbits32(&cp->cp_simode, 0xe0000000 >> 17);	/* brg1 */
-	tmpval8 = in_8(&(cp->cp_smc[0].smc_smcm)) | (SMCM_RX | SMCM_TX);
-	out_8(&(cp->cp_smc[0].smc_smcm), tmpval8);
-	clrbits16(&cp->cp_smc[0].smc_smcmr, SMCMR_REN | SMCMR_TEN);	/* brg1 */
-#else
-	setbits32(bcsr_io,BCSR1_RS232EN_1);
-	out_be16(&cp->cp_smc[0].smc_smcmr, 0);
-	out_8(&cp->cp_smc[0].smc_smce, 0);
-#endif
-
-#ifdef CONFIG_SERIAL_CPM_SMC2
-	clrbits32(bcsr_io,BCSR1_RS232EN_2);
-	clrbits32(&cp->cp_simode, 0xe0000000 >> 1);
-	setbits32(&cp->cp_simode, 0x20000000 >> 1);	/* brg2 */
-	tmpval8 = in_8(&(cp->cp_smc[1].smc_smcm)) | (SMCM_RX | SMCM_TX);
-	out_8(&(cp->cp_smc[1].smc_smcm), tmpval8);
-	clrbits16(&cp->cp_smc[1].smc_smcmr, SMCMR_REN | SMCMR_TEN);
+struct cpm_pin {
+	int port, pin, flags;
+};
 
-	init_smc2_uart_ioports(0);
-#else
-	setbits32(bcsr_io,BCSR1_RS232EN_2);
-	out_be16(&cp->cp_smc[1].smc_smcmr, 0);
-	out_8(&cp->cp_smc[1].smc_smce, 0);
-#endif
-	immr_unmap(cp);
-	iounmap(bcsr_io);
-
-#ifdef CONFIG_FS_ENET
-	/* use MDC for MII (common) */
-	io_port = (iop8xx_t*)immr_map(im_ioport);
-	setbits16(&io_port->iop_pdpar, 0x0080);
-	clrbits16(&io_port->iop_pddir, 0x0080);
-
-	bcsr_io = ioremap(BCSR5, sizeof(unsigned long));
-	clrbits32(bcsr_io,BCSR5_MII1_EN);
-	clrbits32(bcsr_io,BCSR5_MII1_RST);
-#ifndef CONFIG_FC_ENET_HAS_SCC
-	clrbits32(bcsr_io,BCSR5_MII2_EN);
-	clrbits32(bcsr_io,BCSR5_MII2_RST);
+static struct cpm_pin mpc885ads_pins[] = {
+	/* SMC1 */
+	{1, 24, CPM_PIN_INPUT}, /* RX */
+	{1, 25, CPM_PIN_INPUT | CPM_PIN_SECONDARY}, /* TX */
 
+	/* SMC2 */
+#ifndef CONFIG_MPC8xx_SECOND_ETH_FEC2
+	{4, 21, CPM_PIN_INPUT}, /* RX */
+	{4, 20, CPM_PIN_INPUT | CPM_PIN_SECONDARY}, /* TX */
 #endif
-	iounmap(bcsr_io);
-	immr_unmap(io_port);
 
+	/* SCC3 */
+	{0, 9, CPM_PIN_INPUT}, /* RX */
+	{0, 8, CPM_PIN_INPUT}, /* TX */
+	{2, 4, CPM_PIN_INPUT | CPM_PIN_SECONDARY | CPM_PIN_GPIO}, /* RENA */
+	{2, 5, CPM_PIN_INPUT | CPM_PIN_SECONDARY | CPM_PIN_GPIO}, /* CLSN */
+	{4, 27, CPM_PIN_INPUT | CPM_PIN_SECONDARY}, /* TENA */
+	{4, 17, CPM_PIN_INPUT}, /* CLK5 */
+	{4, 16, CPM_PIN_INPUT}, /* CLK6 */
+
+	/* MII1 */
+	{0, 0, CPM_PIN_INPUT},
+	{0, 1, CPM_PIN_INPUT},
+	{0, 2, CPM_PIN_INPUT},
+	{0, 3, CPM_PIN_INPUT},
+	{0, 4, CPM_PIN_OUTPUT},
+	{0, 10, CPM_PIN_OUTPUT},
+	{0, 11, CPM_PIN_OUTPUT},
+	{1, 19, CPM_PIN_INPUT},
+	{1, 31, CPM_PIN_INPUT},
+	{2, 12, CPM_PIN_INPUT},
+	{2, 13, CPM_PIN_INPUT},
+	{4, 30, CPM_PIN_OUTPUT},
+	{4, 31, CPM_PIN_OUTPUT},
+
+	/* MII2 */
+#ifdef CONFIG_MPC8xx_SECOND_ETH_FEC2
+	{4, 14, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{4, 15, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{4, 16, CPM_PIN_OUTPUT},
+	{4, 17, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{4, 18, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{4, 19, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{4, 20, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{4, 21, CPM_PIN_OUTPUT},
+	{4, 22, CPM_PIN_OUTPUT},
+	{4, 23, CPM_PIN_OUTPUT},
+	{4, 24, CPM_PIN_OUTPUT},
+	{4, 25, CPM_PIN_OUTPUT},
+	{4, 26, CPM_PIN_OUTPUT},
+	{4, 27, CPM_PIN_OUTPUT},
+	{4, 28, CPM_PIN_OUTPUT},
+	{4, 29, CPM_PIN_OUTPUT},
 #endif
+};
 
-#ifdef CONFIG_PCMCIA_M8XX
-	/*Set up board specific hook-ups*/
-	m8xx_pcmcia_ops.hw_ctrl = pcmcia_hw_setup;
-	m8xx_pcmcia_ops.voltage_set = pcmcia_set_voltage;
-#endif
-}
-
-
-static void init_fec1_ioports(struct fs_platform_info* ptr)
+static void __init init_ioports(void)
 {
-	cpm8xx_t *cp = (cpm8xx_t *)immr_map(im_cpm);
-	iop8xx_t *io_port = (iop8xx_t *)immr_map(im_ioport);
-
-	/* configure FEC1 pins  */
-	setbits16(&io_port->iop_papar, 0xf830);
-	setbits16(&io_port->iop_padir, 0x0830);
-	clrbits16(&io_port->iop_padir, 0xf000);
+	int i;
 
-	setbits32(&cp->cp_pbpar, 0x00001001);
-	clrbits32(&cp->cp_pbdir, 0x00001001);
-
-	setbits16(&io_port->iop_pcpar, 0x000c);
-	clrbits16(&io_port->iop_pcdir, 0x000c);
+	for (i = 0; i < ARRAY_SIZE(mpc885ads_pins); i++) {
+		struct cpm_pin *pin = &mpc885ads_pins[i];
+		cpm1_set_pin(pin->port, pin->pin, pin->flags);
+	}
 
-	setbits32(&cp->cp_pepar, 0x00000003);
-	setbits32(&cp->cp_pedir, 0x00000003);
-	clrbits32(&cp->cp_peso, 0x00000003);
-	clrbits32(&cp->cp_cptr, 0x00000100);
+	cpm1_clk_setup(CPM_CLK_SMC1, CPM_BRG1, CPM_CLK_RTX);
+	cpm1_clk_setup(CPM_CLK_SMC2, CPM_BRG2, CPM_CLK_RTX);
+	cpm1_clk_setup(CPM_CLK_SCC3, CPM_CLK5, CPM_CLK_TX);
+	cpm1_clk_setup(CPM_CLK_SCC3, CPM_CLK6, CPM_CLK_RX);
 
-	immr_unmap(io_port);
-	immr_unmap(cp);
+	/* Set FEC1 and FEC2 to MII mode */
+	clrbits32(&mpc8xx_immr->im_cpm.cp_cptr, 0x00000180);
 }
 
-
-static void init_fec2_ioports(struct fs_platform_info* ptr)
+static void __init mpc885ads_setup_arch(void)
 {
-	cpm8xx_t *cp = (cpm8xx_t *)immr_map(im_cpm);
-	iop8xx_t *io_port = (iop8xx_t *)immr_map(im_ioport);
-
-	/* configure FEC2 pins */
-	setbits32(&cp->cp_pepar, 0x0003fffc);
-	setbits32(&cp->cp_pedir, 0x0003fffc);
-	clrbits32(&cp->cp_peso, 0x000087fc);
-	setbits32(&cp->cp_peso, 0x00037800);
-	clrbits32(&cp->cp_cptr, 0x00000080);
-
-	immr_unmap(io_port);
-	immr_unmap(cp);
-}
+	struct device_node *np;
 
-void init_fec_ioports(struct fs_platform_info *fpi)
-{
-	int fec_no = fs_get_fec_index(fpi->fs_no);
+	cpm_reset();
+	init_ioports();
 
-	switch (fec_no) {
-	case 0:
-		init_fec1_ioports(fpi);
-		break;
-	case 1:
-		init_fec2_ioports(fpi);
-		break;
-	default:
-		printk(KERN_ERR "init_fec_ioports: invalid FEC number\n");
+	np = of_find_compatible_node(NULL, NULL, "fsl,mpc885ads-bcsr");
+	if (!np) {
+		printk(KERN_CRIT "Could not find fsl,mpc885ads-bcsr node\n");
 		return;
 	}
-}
-
-static void init_scc3_ioports(struct fs_platform_info* fpi)
-{
-	unsigned *bcsr_io;
-	iop8xx_t *io_port;
-	cpm8xx_t *cp;
 
-	bcsr_io = ioremap(BCSR_ADDR, BCSR_SIZE);
-	io_port = (iop8xx_t *)immr_map(im_ioport);
-	cp = (cpm8xx_t *)immr_map(im_cpm);
+	bcsr = of_iomap(np, 0);
+	bcsr5 = of_iomap(np, 1);
+	of_node_put(np);
 
-	if (bcsr_io == NULL) {
+	if (!bcsr || !bcsr5) {
 		printk(KERN_CRIT "Could not remap BCSR\n");
 		return;
 	}
 
-	/* Enable the PHY.
-	 */
-	clrbits32(bcsr_io+4, BCSR4_ETH10_RST);
-	udelay(1000);
-	setbits32(bcsr_io+4, BCSR4_ETH10_RST);
-	/* Configure port A pins for Txd and Rxd.
-	 */
-	setbits16(&io_port->iop_papar, PA_ENET_RXD | PA_ENET_TXD);
-	clrbits16(&io_port->iop_padir, PA_ENET_RXD | PA_ENET_TXD);
+	clrbits32(&bcsr[1], BCSR1_RS232EN_1);
+#ifdef CONFIG_MPC8xx_SECOND_ETH_FEC2
+	setbits32(&bcsr[1], BCSR1_RS232EN_2);
+#else
+	clrbits32(&bcsr[1], BCSR1_RS232EN_2);
+#endif
 
-	/* Configure port C pins to enable CLSN and RENA.
-	 */
-	clrbits16(&io_port->iop_pcpar, PC_ENET_CLSN | PC_ENET_RENA);
-	clrbits16(&io_port->iop_pcdir, PC_ENET_CLSN | PC_ENET_RENA);
-	setbits16(&io_port->iop_pcso, PC_ENET_CLSN | PC_ENET_RENA);
+	clrbits32(bcsr5, BCSR5_MII1_EN);
+	setbits32(bcsr5, BCSR5_MII1_RST);
+	udelay(1000);
+	clrbits32(bcsr5, BCSR5_MII1_RST);
 
-	/* Configure port E for TCLK and RCLK.
-	 */
-	setbits32(&cp->cp_pepar, PE_ENET_TCLK | PE_ENET_RCLK);
-	clrbits32(&cp->cp_pepar, PE_ENET_TENA);
-	clrbits32(&cp->cp_pedir,
-		  PE_ENET_TCLK | PE_ENET_RCLK | PE_ENET_TENA);
-	clrbits32(&cp->cp_peso, PE_ENET_TCLK | PE_ENET_RCLK);
-	setbits32(&cp->cp_peso, PE_ENET_TENA);
-
-	/* Configure Serial Interface clock routing.
-	 * First, clear all SCC bits to zero, then set the ones we want.
-	 */
-	clrbits32(&cp->cp_sicr, SICR_ENET_MASK);
-	setbits32(&cp->cp_sicr, SICR_ENET_CLKRT);
+#ifdef CONFIG_MPC8xx_SECOND_ETH_FEC2
+	clrbits32(bcsr5, BCSR5_MII2_EN);
+	setbits32(bcsr5, BCSR5_MII2_RST);
+	udelay(1000);
+	clrbits32(bcsr5, BCSR5_MII2_RST);
+#else
+	setbits32(bcsr5, BCSR5_MII2_EN);
+#endif
 
-	/* Disable Rx and Tx. SMC1 sshould be stopped if SCC3 eternet are used.
-	 */
-	clrbits16(&cp->cp_smc[0].smc_smcmr, SMCMR_REN | SMCMR_TEN);
-	/* On the MPC885ADS SCC ethernet PHY is initialized in the full duplex mode
-	 * by H/W setting after reset. SCC ethernet controller support only half duplex.
-	 * This discrepancy of modes causes a lot of carrier lost errors.
-	 */
+#ifdef CONFIG_MPC8xx_SECOND_ETH_SCC3
+	clrbits32(&bcsr[4], BCSR4_ETH10_RST);
+	udelay(1000);
+	setbits32(&bcsr[4], BCSR4_ETH10_RST);
 
-	/* In the original SCC enet driver the following code is placed at
-	   the end of the initialization */
-	setbits32(&cp->cp_pepar, PE_ENET_TENA);
-	clrbits32(&cp->cp_pedir, PE_ENET_TENA);
-	setbits32(&cp->cp_peso, PE_ENET_TENA);
+	setbits32(&bcsr[1], BCSR1_ETHEN);
 
-	setbits32(bcsr_io+4, BCSR1_ETHEN);
-	iounmap(bcsr_io);
-	immr_unmap(io_port);
-	immr_unmap(cp);
-}
+	np = of_find_node_by_path("/soc@ff000000/cpm@9c0/serial@a80");
+#else
+	np = of_find_node_by_path("/soc@ff000000/cpm@9c0/ethernet@a40");
+#endif
 
-void init_scc_ioports(struct fs_platform_info *fpi)
-{
-	int scc_no = fs_get_scc_index(fpi->fs_no);
+	/* The SCC3 enet registers overlap the SMC1 registers, so
+	 * one of the two must be removed from the device tree.
+	 */
 
-	switch (scc_no) {
-	case 2:
-		init_scc3_ioports(fpi);
-		break;
-	default:
-		printk(KERN_ERR "init_scc_ioports: invalid SCC number\n");
-		return;
+	if (np) {
+		of_detach_node(np);
+		of_node_put(np);
 	}
-}
-
-
 
-static void init_smc1_uart_ioports(struct fs_uart_platform_info* ptr)
-{
-        unsigned *bcsr_io;
-	cpm8xx_t *cp;
-
-	cp = (cpm8xx_t *)immr_map(im_cpm);
-	setbits32(&cp->cp_pepar, 0x000000c0);
-	clrbits32(&cp->cp_pedir, 0x000000c0);
-	clrbits32(&cp->cp_peso, 0x00000040);
-	setbits32(&cp->cp_peso, 0x00000080);
-	immr_unmap(cp);
-
-        bcsr_io = ioremap(BCSR1, sizeof(unsigned long));
-
-        if (bcsr_io == NULL) {
-                printk(KERN_CRIT "Could not remap BCSR1\n");
-                return;
-        }
-        clrbits32(bcsr_io,BCSR1_RS232EN_1);
-        iounmap(bcsr_io);
+#ifdef CONFIG_PCMCIA_M8XX
+	/* Set up board specific hook-ups.*/
+	m8xx_pcmcia_ops.hw_ctrl = pcmcia_hw_setup;
+	m8xx_pcmcia_ops.voltage_set = pcmcia_set_voltage;
+#endif
 }
 
-static void init_smc2_uart_ioports(struct fs_uart_platform_info* fpi)
+static int __init mpc885ads_probe(void)
 {
-        unsigned *bcsr_io;
-	cpm8xx_t *cp;
-
-	cp = (cpm8xx_t *)immr_map(im_cpm);
-	setbits32(&cp->cp_pepar, 0x00000c00);
-	clrbits32(&cp->cp_pedir, 0x00000c00);
-	clrbits32(&cp->cp_peso, 0x00000400);
-	setbits32(&cp->cp_peso, 0x00000800);
-	immr_unmap(cp);
-
-        bcsr_io = ioremap(BCSR1, sizeof(unsigned long));
-
-        if (bcsr_io == NULL) {
-                printk(KERN_CRIT "Could not remap BCSR1\n");
-                return;
-        }
-        clrbits32(bcsr_io,BCSR1_RS232EN_2);
-        iounmap(bcsr_io);
+	unsigned long root = of_get_flat_dt_root();
+	return of_flat_dt_is_compatible(root, "fsl,mpc885ads");
 }
 
-void init_smc_ioports(struct fs_uart_platform_info *data)
-{
-	int smc_no = fs_uart_id_fsid2smc(data->fs_no);
-
-	switch (smc_no) {
-	case 0:
-		init_smc1_uart_ioports(data);
-		data->brg = data->clk_rx;
-		break;
-	case 1:
-		init_smc2_uart_ioports(data);
-		data->brg = data->clk_rx;
-		break;
-	default:
-		printk(KERN_ERR "init_scc_ioports: invalid SCC number\n");
-		return;
-	}
-}
+static struct of_device_id __initdata of_bus_ids[] = {
+	{ .name = "soc", },
+	{ .name = "cpm", },
+	{},
+};
 
-int platform_device_skip(const char *model, int id)
+static int __init declare_of_platform_devices(void)
 {
-#ifdef CONFIG_MPC8xx_SECOND_ETH_SCC3
-	const char *dev = "FEC";
-	int n = 2;
-#else
-	const char *dev = "SCC";
-	int n = 3;
-#endif
-
-	if (!strcmp(model, dev) && n == id)
-		return 1;
+	/* Publish the QE devices */
+	if (machine_is(mpc885_ads))
+		of_platform_bus_probe(NULL, of_bus_ids, NULL);
 
 	return 0;
 }
-
-static void __init mpc885ads_setup_arch(void)
-{
-	struct device_node *cpu;
-
-	cpu = of_find_node_by_type(NULL, "cpu");
-	if (cpu != 0) {
-		const unsigned int *fp;
-
-		fp = of_get_property(cpu, "clock-frequency", NULL);
-		if (fp != 0)
-			loops_per_jiffy = *fp / HZ;
-		else
-			loops_per_jiffy = 50000000 / HZ;
-		of_node_put(cpu);
-	}
-
-	cpm_reset();
-
-	mpc885ads_board_setup();
-
-	ROOT_DEV = Root_NFS;
-}
-
-static int __init mpc885ads_probe(void)
-{
-	char *model = of_get_flat_dt_prop(of_get_flat_dt_root(),
-					  "model", NULL);
-	if (model == NULL)
-		return 0;
-	if (strcmp(model, "MPC885ADS"))
-		return 0;
-
-	return 1;
-}
+device_initcall(declare_of_platform_devices);
 
 define_machine(mpc885_ads) {
-	.name			= "MPC885 ADS",
+	.name			= "Freescale MPC885 ADS",
 	.probe			= mpc885ads_probe,
 	.setup_arch		= mpc885ads_setup_arch,
 	.init_IRQ		= m8xx_pic_init,
@@ -455,4 +290,9 @@ define_machine(mpc885_ads) {
 	.calibrate_decr		= mpc8xx_calibrate_decr,
 	.set_rtc_time		= mpc8xx_set_rtc_time,
 	.get_rtc_time		= mpc8xx_get_rtc_time,
+	.progress		= udbg_progress,
 };
+
+#ifdef CONFIG_PPC_EARLY_DEBUG_CPM
+u32 __iomem *cpm_udbg_txdesc = (u32 __iomem *)0xff002808;
+#endif
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index cee671f..cb4b573 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -37,9 +37,6 @@
 #include <mm/mmu_decl.h>
 #include <asm/cpm2.h>
 
-extern void init_fcc_ioports(struct fs_platform_info*);
-extern void init_fec_ioports(struct fs_platform_info*);
-extern void init_smc_ioports(struct fs_uart_platform_info*);
 static phys_addr_t immrbase = -1;
 
 phys_addr_t get_immrbase(void)
@@ -843,9 +840,6 @@ arch_initcall(cpm_uart_of_init);
 
 #ifdef CONFIG_8xx
 
-extern void init_scc_ioports(struct fs_platform_info*);
-extern int platform_device_skip(const char *model, int id);
-
 static int __init fs_enet_mdio_of_init(void)
 {
 	struct device_node *np;
@@ -929,9 +923,6 @@ static int __init fs_enet_of_init(void)
 		id = of_get_property(np, "device-id", NULL);
 		fs_enet_data.fs_no = *id;
 
-		if (platform_device_skip(model, *id))
-			continue;
-
 		ret = of_address_to_resource(np, 0, &r[0]);
 		if (ret)
 			goto err;
@@ -984,7 +975,6 @@ static int __init fs_enet_of_init(void)
 			snprintf((char*)&bus_id[i], BUS_ID_SIZE, "%x:%02x",
 							(u32)res.start, fs_enet_data.phy_addr);
 			fs_enet_data.bus_id = (char*)&bus_id[i];
-			fs_enet_data.init_ioports = init_fec_ioports;
 		}
 		if (strstr(model, "SCC")) {
 			ret = of_address_to_resource(np, 1, &r[1]);
@@ -1012,7 +1002,6 @@ static int __init fs_enet_of_init(void)
 
 			snprintf((char*)&bus_id[i], BUS_ID_SIZE, "%s", "fixed@10:1");
                         fs_enet_data.bus_id = (char*)&bus_id[i];
-			fs_enet_data.init_ioports = init_scc_ioports;
 		}
 
 		of_node_put(phy);
@@ -1034,20 +1023,6 @@ err:
 
 arch_initcall(fs_enet_of_init);
 
-static int __init fsl_pcmcia_of_init(void)
-{
-	struct device_node *np = NULL;
-	/*
-	 * Register all the devices which type is "pcmcia"
-	 */
-	while ((np = of_find_compatible_node(np,
-			"pcmcia", "fsl,pq-pcmcia")) != NULL)
-			    of_platform_device_create(np, "m8xx-pcmcia", NULL);
-	return 0;
-}
-
-arch_initcall(fsl_pcmcia_of_init);
-
 static const char *smc_regs = "regs";
 static const char *smc_pram = "pram";
 
-- 
1.5.0.3

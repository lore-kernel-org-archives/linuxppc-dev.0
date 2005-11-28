Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 643B468804
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Nov 2005 04:00:13 +1100 (EST)
Message-ID: <438B379B.6090904@ru.mvista.com>
Date: Mon, 28 Nov 2005 20:00:11 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: BLandau@nds.com
Content-Type: multipart/mixed; boundary="------------050206010306050402000906"
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: Adds MPC885ADS, MPC866ADS and MPC8272ADS-specific
 platform stuff for fs_enet
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
--------------050206010306050402000906
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Added proper ppc_sys identification and fs_platform_info's for MPC 885ADS, 866ADS and 
8272ADS. Assuming setbitsXX/clrbitsXX patch is applied.


Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>

---
Sincerely,
Vitaly



--------------050206010306050402000906
Content-Type: text/x-patch;
 name="pre2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pre2.patch"

diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
index 8fa51b0..8e6fcb2 100644
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -506,6 +506,53 @@ config WINCEPT
 
 endchoice
 
+menu "Freescale Ethernet driver platform-specific options"
+	depends on FS_ENET
+
+	config MPC8xx_SECOND_ETH
+	bool "Second Ethernet channel"
+	depends on (MPC885ADS || MPC86XADS)
+	default y
+	help
+	  This enables support for second Ethernet on MPC885ADS and MPC86xADS boards.
+	  The latter will use SCC1, for 885ADS you can select it below.
+
+	choice
+		prompt "Second Ethernet channel"
+		depends on MPC8xx_SECOND_ETH
+		default MPC8xx_SECOND_ETH_FEC2
+
+		config MPC8xx_SECOND_ETH_FEC2
+		bool "FEC2"
+		depends on MPC885ADS
+		help
+		  Enable FEC2 to serve as 2-nd Ethernet channel. Note that SMC2
+		  (often 2-nd UART) will not work if this is enabled.
+
+		config MPC8xx_SECOND_ETH_SCC1
+		bool "SCC1"
+		depends on MPC86XADS
+		select MPC8xx_SCC_ENET_FIXED
+		help
+		  Enable SCC1 to serve as 2-nd Ethernet channel. Note that SMC1
+		  (often 1-nd UART) will not work if this is enabled.
+
+		config MPC8xx_SECOND_ETH_SCC3
+		bool "SCC3"
+		depends on MPC885ADS
+		help
+		  Enable SCC3 to serve as 2-nd Ethernet channel. Note that SMC1
+		  (often 1-nd UART) will not work if this is enabled.
+
+	endchoice
+
+	config MPC8xx_SCC_ENET_FIXED
+	depends on MPC8xx_SECOND_ETH_SCC
+	default n
+	bool "Use fixed MII-less mode for SCC Ethernet"
+
+endmenu
+
 choice
 	prompt "Machine Type"
 	depends on 6xx || POWER3 || POWER4
diff --git a/arch/ppc/platforms/Makefile b/arch/ppc/platforms/Makefile
index 7c5cdab..ee50b0d 100644
--- a/arch/ppc/platforms/Makefile
+++ b/arch/ppc/platforms/Makefile
@@ -22,6 +22,8 @@ ifeq ($(CONFIG_PPC_PMAC),y)
 obj-$(CONFIG_NVRAM)		+= pmac_nvram.o
 obj-$(CONFIG_CPU_FREQ_PMAC)	+= pmac_cpufreq.o
 endif
+
+obj-$(CONFIG_ADS8272)		+= mpc8272ads_setup.o
 obj-$(CONFIG_PMAC_BACKLIGHT)	+= pmac_backlight.o
 obj-$(CONFIG_PREP_RESIDUAL)	+= residual.o
 obj-$(CONFIG_PQ2ADS)		+= pq2ads.o
@@ -45,6 +47,8 @@ obj-$(CONFIG_SBC82xx)		+= sbc82xx.o
 obj-$(CONFIG_SPRUCE)		+= spruce.o
 obj-$(CONFIG_LITE5200)		+= lite5200.o
 obj-$(CONFIG_EV64360)		+= ev64360.o
+obj-$(CONFIG_MPC86XADS)		+= mpc866ads_setup.o
+obj-$(CONFIG_MPC885ADS)		+= mpc885ads_setup.o
 
 ifeq ($(CONFIG_SMP),y)
 obj-$(CONFIG_PPC_PMAC)		+= pmac_smp.o
diff --git a/arch/ppc/platforms/fads.h b/arch/ppc/platforms/fads.h
index a48fb8d..e1c0b1b 100644
--- a/arch/ppc/platforms/fads.h
+++ b/arch/ppc/platforms/fads.h
@@ -112,7 +112,7 @@
 
 /* CPM Ethernet through SCC1 or SCC2 */
 
-#ifdef CONFIG_SCC1_ENET		/* Probably 860 variant */
+#if defined(CONFIG_SCC1_ENET) || defined(CONFIG_MPC8xx_SECOND_ETH_SCC1)		/* Probably 860 variant */
 /* Bits in parallel I/O port registers that have to be set/cleared
  * to configure the pins for SCC1 use.
  * TCLK - CLK1, RCLK - CLK2.
diff --git a/arch/ppc/platforms/mpc8272ads_setup.c b/arch/ppc/platforms/mpc8272ads_setup.c
new file mode 100644
index 0000000..4f76b1b
--- /dev/null
+++ b/arch/ppc/platforms/mpc8272ads_setup.c
@@ -0,0 +1,253 @@
+/*
+ * arch/ppc/platforms/82xx/pq2ads_pd.c
+ *
+ * MPC82xx Board-specific PlatformDevice descriptions
+ *
+ * 2005 (c) MontaVista Software, Inc.
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/ioport.h>
+#include <linux/fs_enet_pd.h>
+
+#include <asm/io.h>
+#include <asm/mpc8260.h>
+#include <asm/cpm2.h>
+#include <asm/immap_cpm2.h>
+#include <asm/irq.h>
+#include <asm/ppc_sys.h>
+#include <asm/ppcboot.h>
+
+#include "pq2ads_pd.h"
+
+static void init_fcc1_ioports(void);
+static void init_fcc2_ioports(void);
+
+static struct fs_mii_bus_info mii_bus_info = {
+	.method                 = fsmii_bitbang,
+	.id                     = 0,
+	.i.bitbang = {
+		.mdio_port	= fsiop_portc,
+		.mdio_bit	= 18,
+		.mdc_port	= fsiop_portc,
+		.mdc_bit	= 19,
+		.delay		= 1,
+	},
+};
+
+static struct fs_platform_info mpc82xx_fcc1_pdata = {
+	.fs_no		= fsid_fcc1,
+	.cp_page	= CPM_CR_FCC1_PAGE,
+	.cp_block 	= CPM_CR_FCC1_SBLOCK,
+	.clk_trx 	= (PC_F1RXCLK | PC_F1TXCLK),
+	.clk_route	= CMX1_CLK_ROUTE,
+	.clk_mask	= CMX1_CLK_MASK,
+	.init_ioports 	= init_fcc1_ioports,
+
+	.phy_addr	= 0,
+#ifdef PHY_INTERRUPT
+	.phy_irq	= PHY_INTERRUPT,
+#else
+	.phy_irq	= -1;
+#endif
+	.mem_offset	= FCC1_MEM_OFFSET,
+	.bus_info	= &mii_bus_info,
+	.rx_ring	= 32,
+	.tx_ring	= 32,
+	.rx_copybreak	= 240,
+	.use_napi	= 0,
+	.napi_weight	= 17,
+};
+
+static struct fs_platform_info mpc82xx_fcc2_pdata = {
+	.fs_no		= fsid_fcc2,
+	.cp_page	= CPM_CR_FCC2_PAGE,
+	.cp_block 	= CPM_CR_FCC2_SBLOCK,
+	.clk_trx 	= (PC_F2RXCLK | PC_F2TXCLK),
+	.clk_route	= CMX2_CLK_ROUTE,
+	.clk_mask	= CMX2_CLK_MASK,
+	.init_ioports	= init_fcc2_ioports,
+
+	.phy_addr	= 3,
+#ifdef PHY_INTERRUPT
+	.phy_irq	= PHY_INTERRUPT,
+#else
+	.phy_irq	= -1;
+#endif
+	.mem_offset	= FCC2_MEM_OFFSET,
+	.bus_info	= &mii_bus_info,
+	.rx_ring	= 32,
+	.tx_ring	= 32,
+	.rx_copybreak	= 240,
+	.use_napi	= 0,
+	.napi_weight	= 17,
+};
+
+static void init_fcc1_ioports(void)
+{
+	struct io_port *io;
+	u32 tempval;
+	int i=0;
+	cpm2_map_t* immap = ioremap(CPM_MAP_ADDR, sizeof(cpm2_map_t));
+	u32 *bcsr = ioremap(BCSR_ADDR+4, sizeof(u32));
+
+	io = &immap->im_ioport;
+
+	/* Enable the PHY */
+	clrbits32(bcsr, BCSR1_FETHIEN);
+	setbits32(bcsr, BCSR1_FETH_RST);
+
+	/* FCC1 pins are on port A/C. */
+	/* Configure port A and C pins for FCC1 Ethernet. */
+
+	tempval = in_be32(&io->iop_pdira);
+	tempval &= ~PA1_DIRA0;
+	tempval |= PA1_DIRA1;
+	out_be32(&io->iop_pdira, tempval);
+
+	tempval = in_be32(&io->iop_psora);
+	tempval &= ~PA1_PSORA0;
+	tempval |= PA1_PSORA1;
+	out_be32(&io->iop_psora, tempval);
+
+	setbits32(&io->iop_ppara,PA1_DIRA0 | PA1_DIRA1);
+
+	/* Alter clocks */
+	tempval = PC_F1TXCLK|PC_F1RXCLK;
+
+	clrbits32(&io->iop_psorc, tempval);
+	clrbits32(&io->iop_pdirc, tempval);
+	setbits32(&io->iop_pparc, tempval);
+
+	clrbits32(&immap->im_cpmux.cmx_fcr, CMX1_CLK_MASK);
+	setbits32(&immap->im_cpmux.cmx_fcr, CMX1_CLK_ROUTE);
+	iounmap(bcsr);
+	iounmap(immap);
+}
+
+static void init_fcc2_ioports(void)
+{
+	cpm2_map_t* immap = ioremap(CPM_MAP_ADDR, sizeof(cpm2_map_t));
+	u32 *bcsr = ioremap(BCSR_ADDR+12, sizeof(u32));
+
+	struct io_port *io;
+	u32 tempval;
+
+	immap = cpm2_immr;
+
+	io = &immap->im_ioport;
+
+	/* Enable the PHY */
+	clrbits32(bcsr, BCSR3_FETHIEN2);
+	setbits32(bcsr, BCSR3_FETH2_RST);
+
+	/* FCC2 are port B/C. */
+	/* Configure port A and C pins for FCC2 Ethernet. */
+
+	tempval = in_be32(&io->iop_pdirb);
+	tempval &= ~PB2_DIRB0;
+	tempval |= PB2_DIRB1;
+	out_be32(&io->iop_pdirb, tempval);
+
+	tempval = in_be32(&io->iop_psorb);
+	tempval &= ~PB2_PSORB0;
+	tempval |= PB2_PSORB1;
+	out_be32(&io->iop_psorb, tempval);
+
+	setbits32(&io->iop_pparb,PB2_DIRB0 | PB2_DIRB1);
+
+	tempval = PC_F2RXCLK|PC_F2TXCLK;
+
+	/* Alter clocks */
+	clrbits32(&io->iop_psorc,tempval);
+	clrbits32(&io->iop_pdirc,tempval);
+	setbits32(&io->iop_pparc,tempval);
+
+	clrbits32(&immap->im_cpmux.cmx_fcr, CMX2_CLK_MASK);
+	setbits32(&immap->im_cpmux.cmx_fcr, CMX2_CLK_ROUTE);
+
+	iounmap(bcsr);
+	iounmap(immap);
+}
+
+
+static void __init mpc8272ads_fixup_enet_pdata(struct platform_device *pdev,
+					      int idx)
+{
+	bd_t* bi = (void*)__res;
+	int fs_no = fsid_fcc1+pdev->id-1;
+
+	mpc82xx_fcc1_pdata.dpram_offset = mpc82xx_fcc2_pdata.dpram_offset = (u32)cpm2_immr->im_dprambase;
+	mpc82xx_fcc1_pdata.fcc_regs_c = mpc82xx_fcc2_pdata.fcc_regs_c = (u32)cpm2_immr->im_fcc_c;
+
+	switch(fs_no) {
+		case fsid_fcc1:
+			memcpy(&mpc82xx_fcc1_pdata.macaddr,bi->bi_enetaddr,6);
+			pdev->dev.platform_data = &mpc82xx_fcc1_pdata;
+		break;
+		case fsid_fcc2:
+			memcpy(&mpc82xx_fcc2_pdata.macaddr,bi->bi_enetaddr,6);
+			mpc82xx_fcc2_pdata.macaddr[5] ^= 1;
+			pdev->dev.platform_data = &mpc82xx_fcc2_pdata;
+		break;
+	}
+}
+
+static int __init mpc8272ads_platform_notify(struct device *dev)
+{
+	static struct {
+		const char *bus_id;
+		void (*rtn) (struct platform_device * pdev, int idx);
+	} dev_map[] = {
+		{"fsl-cpm-fcc", mpc8272ads_fixup_enet_pdata},
+	};
+	struct platform_device *pdev;
+	int i, j, idx;
+	const char *s;
+	if (dev && dev->bus_id)
+		for (i = 0; i < ARRAY_SIZE(dev_map); i++) {
+			idx = -1;
+
+			if ((s = strrchr(dev->bus_id, '.')) != NULL)
+				idx = (int)simple_strtol(s + 1, NULL, 10);
+			else
+				s = dev->bus_id;
+			j = s - dev->bus_id;
+			if (!strncmp(dev->bus_id, dev_map[i].bus_id, j)) {
+				pdev =
+				    container_of(dev, struct platform_device,
+						 dev);
+				dev_map[i].rtn(pdev, idx);
+			}
+		}
+	return 0;
+}
+
+int __init mpc8272ads_init(void)
+{
+	printk(KERN_NOTICE "mpc8272ads: Init\n");
+
+	platform_notify = mpc8272ads_platform_notify;
+
+	identify_ppc_sys_by_name_and_id(BOARD_CHIP_NAME, cpm2_immr->im_memctl.memc_immr);
+
+	/*Remove stuff does not utilized platform way*/
+	ppc_sys_device_remove(MPC82xx_CPM_SCC1);
+	ppc_sys_device_remove(MPC82xx_CPM_SCC2);
+	ppc_sys_device_remove(MPC82xx_CPM_SCC3);
+	ppc_sys_device_remove(MPC82xx_CPM_SCC4);
+	ppc_sys_device_remove(MPC82xx_CPM_SMC1);
+	ppc_sys_device_remove(MPC82xx_CPM_SMC2);
+
+	return 0;
+}
+
+arch_initcall(mpc8272ads_init);
diff --git a/arch/ppc/platforms/mpc866ads_setup.c b/arch/ppc/platforms/mpc866ads_setup.c
new file mode 100644
index 0000000..0809cf3
--- /dev/null
+++ b/arch/ppc/platforms/mpc866ads_setup.c
@@ -0,0 +1,283 @@
+/*arch/ppc/platforms/mpc885ads-setup.c
+ *
+ * Platform setup for the Freescale mpc885ads board
+ *
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ *
+ * Copyright 2005 MontaVista Software Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/param.h>
+#include <linux/string.h>
+#include <linux/ioport.h>
+#include <linux/device.h>
+
+#include <linux/fs_enet_pd.h>
+#include <linux/mii.h>
+
+#include <asm/delay.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/page.h>
+#include <asm/processor.h>
+#include <asm/system.h>
+#include <asm/time.h>
+#include <asm/ppcboot.h>
+#include <asm/8xx_immap.h>
+#include <asm/commproc.h>
+#include <asm/ppc_sys.h>
+#include <asm/mpc8xx.h>
+
+extern unsigned char __res[];
+
+static struct fs_mii_bus_info fec_mii_bus_info = {
+	.method = fsmii_fec,
+	.id = 0,
+};
+
+static struct fs_mii_bus_info scc_mii_bus_info = {
+	.method = fsmii_fixed,
+	.id = 0,
+	.i.fixed.speed = 10,
+	.i.fixed.duplex = 0,
+};
+
+static struct fs_platform_info mpc8xx_fec_pdata[] = {
+	{
+	 .rx_ring = 128,
+	 .tx_ring = 16,
+	 .rx_copybreak = 240,
+
+	 .use_napi = 1,
+	 .napi_weight = 17,
+
+	 .phy_addr = 15,
+	 .phy_irq = -1,
+
+	 .use_rmii = 0,
+
+	 .bus_info = &fec_mii_bus_info,
+	 }
+};
+
+static struct fs_platform_info mpc8xx_scc_pdata = {
+	.rx_ring = 64,
+	.tx_ring = 8,
+	.rx_copybreak = 240,
+
+	.use_napi = 1,
+	.napi_weight = 17,
+
+	.phy_addr = -1,
+	.phy_irq = -1,
+
+	.bus_info = &scc_mii_bus_info,
+};
+
+void __init board_init(void)
+{
+	volatile cpm8xx_t *cp = cpmp;
+	unsigned *bcsr_io;
+
+	bcsr_io = ioremap(BCSR1, sizeof(unsigned long));
+
+	if (bcsr_io == NULL) {
+		printk(KERN_CRIT "Could not remap BCSR1\n");
+		return;
+	}
+#ifdef CONFIG_SERIAL_CPM_SMC1
+	cp->cp_simode &= ~(0xe0000000 >> 17);	/* brg1 */
+	clrbits32(bcsr_io,(0x80000000 >> 7));
+#else
+	setbits32(bcsr_io,(0x80000000 >> 7));
+
+	cp->cp_pbpar &= ~(0x000000c0);
+	cp->cp_pbdir |= 0x000000c0;
+	cp->cp_smc[0].smc_smcmr = 0;
+	cp->cp_smc[0].smc_smce = 0;
+#endif
+
+#ifdef CONFIG_SERIAL_CPM_SMC2
+	cp->cp_simode &= ~(0xe0000000 >> 1);
+	cp->cp_simode |= (0x20000000 >> 1);	/* brg2 */
+	clrbits32(bcsr_io,(0x80000000 >> 13));
+#else
+	clrbits32(bcsr_io,(0x80000000 >> 13));
+	cp->cp_pbpar &= ~(0x00000c00);
+	cp->cp_pbdir |= 0x00000c00;
+	cp->cp_smc[1].smc_smcmr = 0;
+	cp->cp_smc[1].smc_smce = 0;
+#endif
+	iounmap(bcsr_io);
+}
+
+static void setup_fec1_ioports(void)
+{
+	immap_t *immap = (immap_t *) IMAP_ADDR;
+
+	setbits16(&immap->im_ioport.iop_pdpar, 0x1fff);
+	setbits16(&immap->im_ioport.iop_pddir, 0x1fff);
+}
+
+static void setup_scc1_ioports(void)
+{
+	immap_t *immap = (immap_t *) IMAP_ADDR;
+	unsigned *bcsr_io;
+
+	bcsr_io = ioremap(BCSR1, sizeof(unsigned long));
+
+	if (bcsr_io == NULL) {
+		printk(KERN_CRIT "Could not remap BCSR1\n");
+		return;
+	}
+
+	/* Enable the PHY.
+	 */
+	clrbits32(bcsr_io,BCSR1_ETHEN);
+
+	/* Configure port A pins for Txd and Rxd.
+	 */
+	/* Disable receive and transmit in case EPPC-Bug started it.
+	 */
+	setbits16(&immap->im_ioport.iop_papar, PA_ENET_RXD | PA_ENET_TXD);
+	clrbits16(&immap->im_ioport.iop_padir, PA_ENET_RXD | PA_ENET_TXD);
+	clrbits16(&immap->im_ioport.iop_paodr, PA_ENET_TXD);
+
+	/* Configure port C pins to enable CLSN and RENA.
+	 */
+	clrbits16(&immap->im_ioport.iop_pcpar, PC_ENET_CLSN | PC_ENET_RENA);
+	clrbits16(&immap->im_ioport.iop_pcdir, PC_ENET_CLSN | PC_ENET_RENA);
+	setbits16(&immap->im_ioport.iop_pcso, PC_ENET_CLSN | PC_ENET_RENA);
+	/* Configure port A for TCLK and RCLK.
+	 */
+	setbits16(&immap->im_ioport.iop_papar, PA_ENET_TCLK | PA_ENET_RCLK);
+	clrbits16(&immap->im_ioport.iop_padir, PA_ENET_TCLK | PA_ENET_RCLK);
+	clrbits32(&immap->im_cpm.cp_pbpar, PB_ENET_TENA);
+	clrbits32(&immap->im_cpm.cp_pbdir, PB_ENET_TENA);
+
+	/* Configure Serial Interface clock routing.
+	 * First, clear all SCC bits to zero, then set the ones we want.
+	 */
+	clrbits32(&immap->im_cpm.cp_sicr, SICR_ENET_MASK);
+	setbits32(&immap->im_cpm.cp_sicr, SICR_ENET_CLKRT);
+
+	/* In the original SCC enet driver the following code is placed at
+	the end of the initialization */
+	setbits32(&immap->im_cpm.cp_pbpar, PB_ENET_TENA);
+	setbits32(&immap->im_cpm.cp_pbdir, PB_ENET_TENA);
+
+}
+
+static void mpc866ads_fixup_enet_pdata(struct platform_device *pdev, int fs_no)
+{
+	struct fs_platform_info *fpi = pdev->dev.platform_data;
+
+	volatile cpm8xx_t *cp;
+	bd_t *bd = (bd_t *) __res;
+	char *e;
+	int i;
+
+	/* Get pointer to Communication Processor */
+	cp = cpmp;
+	switch (fs_no) {
+	case fsid_fec1:
+		fpi = &mpc8xx_fec_pdata[0];
+		fpi->init_ioports = &setup_fec1_ioports;
+
+		break;
+	case fsid_scc1:
+		fpi = &mpc8xx_scc_pdata;
+		fpi->init_ioports = &setup_scc1_ioports;
+
+		break;
+	default:
+		break;
+	}
+
+	pdev->dev.platform_data = fpi;
+	fpi->fs_no = fs_no;
+
+	e = (unsigned char *)&bd->bi_enetaddr;
+	for (i = 0; i < 6; i++)
+		fpi->macaddr[i] = *e++;
+
+	fpi->macaddr[5 - pdev->id]++;
+
+}
+
+static void mpc866ads_fixup_fec_enet_pdata(struct platform_device *pdev,
+					   int idx)
+{
+	/* This is for FEC devices only */
+	if (strcmp(pdev->name, "fsl-cpm-fec"))
+		return;
+	mpc866ads_fixup_enet_pdata(pdev, fsid_fec1 + pdev->id - 1);
+}
+
+static void mpc866ads_fixup_scc_enet_pdata(struct platform_device *pdev,
+					   int idx)
+{
+	/* This is for SCC devices only */
+	if (strcmp(pdev->name, "fsl-cpm-scc"))
+		return;
+
+	mpc866ads_fixup_enet_pdata(pdev, fsid_scc1 + pdev->id - 1);
+}
+
+static int mpc866ads_platform_notify(struct device *dev)
+{
+	static struct {
+		const char *bus_id;
+		void (*rtn) (struct platform_device * pdev, int idx);
+	} dev_map[] = {
+		{
+		"fsl-cpm-fec", mpc866ads_fixup_fec_enet_pdata}, {
+	"fsl-cpm-scc", mpc866ads_fixup_scc_enet_pdata},};
+	struct platform_device *pdev;
+	int i, j, idx;
+	const char *s;
+	if (dev && dev->bus_id)
+		for (i = 0; i < ARRAY_SIZE(dev_map); i++) {
+			idx = -1;
+
+			if ((s = strrchr(dev->bus_id, '.')) != NULL)
+				idx = (int)simple_strtol(s + 1, NULL, 10);
+			else
+				s = dev->bus_id;
+			j = s - dev->bus_id;
+			if (!strncmp(dev->bus_id, dev_map[i].bus_id, j)) {
+				pdev =
+				    container_of(dev, struct platform_device,
+						 dev);
+				dev_map[i].rtn(pdev, idx);
+			}
+		}
+	return 0;
+}
+
+int __init mpc866ads_init(void)
+{
+	printk(KERN_NOTICE "mpc866ads: Init\n");
+
+	platform_notify = mpc866ads_platform_notify;
+
+	identify_ppc_sys_by_name(BOARD_CHIP_NAME);
+
+	ppc_sys_device_remove(MPC8xx_CPM_FEC2);
+	ppc_sys_device_remove(MPC8xx_CPM_SCC3);
+	ppc_sys_device_remove(MPC8xx_CPM_SCC2);
+	ppc_sys_device_remove(MPC8xx_CPM_SCC4);
+	ppc_sys_device_remove(MPC8xx_CPM_SMC1);
+	ppc_sys_device_remove(MPC8xx_CPM_SMC2);
+
+	return 0;
+}
+
+arch_initcall(mpc866ads_init);
diff --git a/arch/ppc/platforms/mpc885ads_setup.c b/arch/ppc/platforms/mpc885ads_setup.c
new file mode 100644
index 0000000..5e72f64
--- /dev/null
+++ b/arch/ppc/platforms/mpc885ads_setup.c
@@ -0,0 +1,400 @@
+/*arch/ppc/platforms/mpc885ads-setup.c
+ *
+ * Platform setup for the Freescale mpc885ads board
+ *
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ *
+ * Copyright 2005 MontaVista Software Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/param.h>
+#include <linux/string.h>
+#include <linux/ioport.h>
+#include <linux/device.h>
+
+#include <linux/fs_enet_pd.h>
+#include <linux/mii.h>
+
+#include <asm/delay.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/page.h>
+#include <asm/processor.h>
+#include <asm/system.h>
+#include <asm/time.h>
+#include <asm/ppcboot.h>
+#include <asm/8xx_immap.h>
+#include <asm/commproc.h>
+#include <asm/ppc_sys.h>
+
+extern unsigned char __res[];
+
+static void __init mpc885ads_scc_phy_init(char);
+
+static struct fs_mii_bus_info fec_mii_bus_info = {
+	.method = fsmii_fec,
+	.id = 0,
+};
+
+static struct fs_mii_bus_info scc_mii_bus_info = {
+#ifdef CONFIG_SCC_ENET_8xx_FIXED
+	.method = fsmii_fixed,
+#else
+	.method = fsmii_fec,
+#endif
+
+	.id = 0,
+};
+
+static struct fs_platform_info mpc8xx_fec_pdata[] = {
+	{
+	 .rx_ring = 128,
+	 .tx_ring = 16,
+	 .rx_copybreak = 240,
+
+	 .use_napi = 1,
+	 .napi_weight = 17,
+
+	 .phy_addr = 0,
+	 .phy_irq = SIU_IRQ7,
+
+	 .bus_info = &fec_mii_bus_info,
+	 }, {
+	     .rx_ring = 128,
+	     .tx_ring = 16,
+	     .rx_copybreak = 240,
+
+	     .use_napi = 1,
+	     .napi_weight = 17,
+
+	     .phy_addr = 1,
+	     .phy_irq = SIU_IRQ7,
+
+	     .bus_info = &fec_mii_bus_info,
+	     }
+};
+
+static struct fs_platform_info mpc8xx_scc_pdata = {
+	.rx_ring = 64,
+	.tx_ring = 8,
+	.rx_copybreak = 240,
+
+	.use_napi = 1,
+	.napi_weight = 17,
+
+	.phy_addr = 2,
+#ifdef CONFIG_MPC8xx_SCC_ENET_FIXED
+	.phy_irq = -1,
+#else
+	.phy_irq = SIU_IRQ7,
+#endif
+
+	.bus_info = &scc_mii_bus_info,
+};
+
+void __init board_init(void)
+{
+	volatile cpm8xx_t *cp = cpmp;
+	unsigned int *bcsr_io;
+
+#ifdef CONFIG_FS_ENET
+	immap_t *immap = (immap_t *) IMAP_ADDR;
+#endif
+	bcsr_io = ioremap(BCSR1, sizeof(unsigned long));
+
+	if (bcsr_io == NULL) {
+		printk(KERN_CRIT "Could not remap BCSR\n");
+		return;
+	}
+#ifdef CONFIG_SERIAL_CPM_SMC1
+	cp->cp_simode &= ~(0xe0000000 >> 17);	/* brg1 */
+	clrbits32(bcsr_io, BCSR1_RS232EN_1);
+#else
+	setbits32(bcsr_io,BCSR1_RS232EN_1);
+	cp->cp_smc[0].smc_smcmr = 0;
+	cp->cp_smc[0].smc_smce = 0;
+#endif
+
+#ifdef CONFIG_SERIAL_CPM_SMC2
+	cp->cp_simode &= ~(0xe0000000 >> 1);
+	cp->cp_simode |= (0x20000000 >> 1);	/* brg2 */
+	clrbits32(bcsr_io,BCSR1_RS232EN_2);
+#else
+	setbits32(bcsr_io,BCSR1_RS232EN_2);
+	cp->cp_smc[1].smc_smcmr = 0;
+	cp->cp_smc[1].smc_smce = 0;
+#endif
+	iounmap(bcsr_io);
+
+#ifdef CONFIG_FS_ENET
+	/* use MDC for MII (common) */
+	setbits16(&immap->im_ioport.iop_pdpar, 0x0080);
+	clrbits16(&immap->im_ioport.iop_pddir, 0x0080);
+#endif
+}
+
+static void setup_fec1_ioports(void)
+{
+	immap_t *immap = (immap_t *) IMAP_ADDR;
+
+	/* configure FEC1 pins  */
+	setbits16(&immap->im_ioport.iop_papar, 0xf830);
+	setbits16(&immap->im_ioport.iop_padir, 0x0830);
+	clrbits16(&immap->im_ioport.iop_padir, 0xf000);
+	setbits32(&immap->im_cpm.cp_pbpar, 0x00001001);
+
+	clrbits32(&immap->im_cpm.cp_pbdir, 0x00001001);
+	setbits16(&immap->im_ioport.iop_pcpar, 0x000c);
+	clrbits16(&immap->im_ioport.iop_pcdir, 0x000c);
+	setbits32(&immap->im_cpm.cp_pepar, 0x00000003);
+
+	setbits32(&immap->im_cpm.cp_pedir, 0x00000003);
+	clrbits32(&immap->im_cpm.cp_peso, 0x00000003);
+	clrbits32(&immap->im_cpm.cp_cptr, 0x00000100);
+}
+
+static void setup_fec2_ioports(void)
+{
+	immap_t *immap = (immap_t *) IMAP_ADDR;
+
+	/* configure FEC2 pins */
+	setbits32(&immap->im_cpm.cp_pepar, 0x0003fffc);
+	setbits32(&immap->im_cpm.cp_pedir, 0x0003fffc);
+	setbits32(&immap->im_cpm.cp_peso, 0x00037800);
+	clrbits32(&immap->im_cpm.cp_peso, 0x000087fc);
+	clrbits32(&immap->im_cpm.cp_cptr, 0x00000080);
+}
+
+static void setup_scc3_ioports(void)
+{
+	immap_t *immap = (immap_t *) IMAP_ADDR;
+	unsigned *bcsr_io;
+
+	bcsr_io = ioremap(BCSR_ADDR, BCSR_SIZE);
+
+	if (bcsr_io == NULL) {
+		printk(KERN_CRIT "Could not remap BCSR\n");
+		return;
+	}
+
+	/* Enable the PHY.
+	 */
+	setbits32(bcsr_io+4, BCSR4_ETH10_RST);
+	/* Configure port A pins for Txd and Rxd.
+	 */
+	setbits16(&immap->im_ioport.iop_papar, PA_ENET_RXD | PA_ENET_TXD);
+	clrbits16(&immap->im_ioport.iop_padir, PA_ENET_RXD | PA_ENET_TXD);
+
+	/* Configure port C pins to enable CLSN and RENA.
+	 */
+	clrbits16(&immap->im_ioport.iop_pcpar, PC_ENET_CLSN | PC_ENET_RENA);
+	clrbits16(&immap->im_ioport.iop_pcdir, PC_ENET_CLSN | PC_ENET_RENA);
+	setbits16(&immap->im_ioport.iop_pcso, PC_ENET_CLSN | PC_ENET_RENA);
+
+	/* Configure port E for TCLK and RCLK.
+	 */
+	setbits32(&immap->im_cpm.cp_pepar, PE_ENET_TCLK | PE_ENET_RCLK);
+	clrbits32(&immap->im_cpm.cp_pepar, PE_ENET_TENA);
+	clrbits32(&immap->im_cpm.cp_pedir,
+		  PE_ENET_TCLK | PE_ENET_RCLK | PE_ENET_TENA);
+	clrbits32(&immap->im_cpm.cp_peso, PE_ENET_TCLK | PE_ENET_RCLK);
+	setbits32(&immap->im_cpm.cp_peso, PE_ENET_TENA);
+
+	/* Configure Serial Interface clock routing.
+	 * First, clear all SCC bits to zero, then set the ones we want.
+	 */
+	clrbits32(&immap->im_cpm.cp_sicr, SICR_ENET_MASK);
+	setbits32(&immap->im_cpm.cp_sicr, SICR_ENET_CLKRT);
+
+	/* Disable Rx and Tx. SMC1 sshould be stopped if SCC3 eternet are used.
+	 */
+	immap->im_cpm.cp_smc[0].smc_smcmr &= ~(SMCMR_REN | SMCMR_TEN);
+	/* On the MPC885ADS SCC ethernet PHY is initialized in the full duplex mode
+	 * by H/W setting after reset. SCC ethernet controller support only half duplex.
+	 * This discrepancy of modes causes a lot of carrier lost errors.
+	 */
+
+	/* In the original SCC enet driver the following code is placed at
+	   the end of the initialization */
+	setbits32(&immap->im_cpm.cp_pepar, PE_ENET_TENA);
+	clrbits32(&immap->im_cpm.cp_pedir, PE_ENET_TENA);
+	setbits32(&immap->im_cpm.cp_peso, PE_ENET_TENA);
+
+	setbits32(bcsr_io+1, BCSR1_ETHEN);
+	iounmap(bcsr_io);
+}
+
+static void mpc885ads_fixup_enet_pdata(struct platform_device *pdev, int fs_no)
+{
+	struct fs_platform_info *fpi = pdev->dev.platform_data;
+
+	volatile cpm8xx_t *cp;
+	bd_t *bd = (bd_t *) __res;
+	char *e;
+	int i;
+
+	/* Get pointer to Communication Processor */
+	cp = cpmp;
+	switch (fs_no) {
+	case fsid_fec1:
+		fpi = &mpc8xx_fec_pdata[0];
+		fpi->init_ioports = &setup_fec1_ioports;
+		break;
+	case fsid_fec2:
+		fpi = &mpc8xx_fec_pdata[1];
+		fpi->init_ioports = &setup_fec2_ioports;
+		break;
+	case fsid_scc3:
+		fpi = &mpc8xx_scc_pdata;
+		fpi->init_ioports = &setup_scc3_ioports;
+		mpc885ads_scc_phy_init(fpi->phy_addr);
+		break;
+	default:
+		break;
+	}
+
+	pdev->dev.platform_data = fpi;
+	fpi->fs_no = fs_no;
+
+	e = (unsigned char *)&bd->bi_enetaddr;
+	for (i = 0; i < 6; i++)
+		fpi->macaddr[i] = *e++;
+
+	fpi->macaddr[5 - pdev->id]++;
+
+}
+
+static void mpc885ads_fixup_fec_enet_pdata(struct platform_device *pdev,
+					   int idx)
+{
+	/* This is for FEC devices only */
+	if (!strstr(pdev->name, "fsl-cpm-fec"))
+		return;
+	mpc885ads_fixup_enet_pdata(pdev, fsid_fec1 + pdev->id - 1);
+}
+
+static void __init mpc885ads_fixup_scc_enet_pdata(struct platform_device *pdev,
+						  int idx)
+{
+	/* This is for SCC devices only */
+	if (!strstr(pdev->name, "fsl-cpm-scc"))
+		return;
+
+	mpc885ads_fixup_enet_pdata(pdev, fsid_scc1 + pdev->id - 1);
+}
+
+/* SCC ethernet controller does not have MII management channel. FEC1 MII
+ * channel is used to communicate with the 10Mbit PHY.
+ */
+
+#define MII_ECNTRL_PINMUX        0x4
+#define FEC_ECNTRL_PINMUX        0x00000004
+#define FEC_RCNTRL_MII_MODE        0x00000004
+
+/* Make MII read/write commands.
+ */
+#define mk_mii_write(REG, VAL, PHY_ADDR)    (0x50020000 | (((REG) & 0x1f) << 18) | \
+                ((VAL) & 0xffff) | ((PHY_ADDR) << 23))
+
+static void mpc885ads_scc_phy_init(char phy_addr)
+{
+	volatile immap_t *immap;
+	volatile fec_t *fecp;
+	bd_t *bd;
+
+	bd = (bd_t *) __res;
+	immap = (immap_t *) IMAP_ADDR;	/* pointer to internal registers */
+	fecp = &(immap->im_cpm.cp_fec);
+
+	/* Enable MII pins of the FEC1
+	 */
+	setbits16(&immap->im_ioport.iop_pdpar, 0x0080);
+	clrbits16(&immap->im_ioport.iop_pddir, 0x0080);
+	/* Set MII speed to 2.5 MHz
+	 */
+	out_be32(&fecp->fec_mii_speed,
+		 ((((bd->bi_intfreq + 4999999) / 2500000) / 2) & 0x3F) << 1);
+
+	/* Enable FEC pin MUX
+	 */
+	setbits32(&fecp->fec_ecntrl, MII_ECNTRL_PINMUX);
+	setbits32(&fecp->fec_r_cntrl, FEC_RCNTRL_MII_MODE);
+
+	out_be32(&fecp->fec_mii_data,
+		 mk_mii_write(MII_BMCR, BMCR_ISOLATE, phy_addr));
+	udelay(100);
+	out_be32(&fecp->fec_mii_data,
+		 mk_mii_write(MII_ADVERTISE,
+			      ADVERTISE_10HALF | ADVERTISE_CSMA, phy_addr));
+	udelay(100);
+
+	/* Disable FEC MII settings
+	 */
+	clrbits32(&fecp->fec_ecntrl, MII_ECNTRL_PINMUX);
+	clrbits32(&fecp->fec_r_cntrl, FEC_RCNTRL_MII_MODE);
+	out_be32(&fecp->fec_mii_speed, 0);
+}
+
+static int mpc885ads_platform_notify(struct device *dev)
+{
+	static struct {
+		const char *bus_id;
+		void (*rtn) (struct platform_device * pdev, int idx);
+	} dev_map[] = {
+		{
+		"fsl-cpm-fec", mpc885ads_fixup_fec_enet_pdata}, {
+	"fsl-cpm-scc", mpc885ads_fixup_scc_enet_pdata},};
+	struct platform_device *pdev;
+	int i, j, idx;
+	const char *s;
+	if (dev && dev->bus_id)
+		for (i = 0; i < ARRAY_SIZE(dev_map); i++) {
+			idx = -1;
+
+			if ((s = strrchr(dev->bus_id, '.')) != NULL)
+				idx = (int)simple_strtol(s + 1, NULL, 10);
+			else
+				s = dev->bus_id;
+			j = s - dev->bus_id;
+			if (!strncmp(dev->bus_id, dev_map[i].bus_id, j)) {
+				pdev =
+				    container_of(dev, struct platform_device,
+						 dev);
+				dev_map[i].rtn(pdev, idx);
+			}
+		}
+	return 0;
+}
+
+int __init mpc885ads_init(void)
+{
+	printk(KERN_NOTICE "mpc885ads: Init\n");
+
+	platform_notify = mpc885ads_platform_notify;
+
+	identify_ppc_sys_by_name(BOARD_CHIP_NAME);
+
+#ifdef CONFIG_MPC8xx_SECOND_ETH_SCC3
+	ppc_sys_device_remove(MPC8xx_CPM_FEC2);
+#endif
+#ifdef CONFIG_MPC8xx_SECOND_ETH_FEC2
+	ppc_sys_device_remove(MPC8xx_CPM_SCC3);
+#endif
+
+	ppc_sys_device_remove(MPC8xx_CPM_SCC1);
+	ppc_sys_device_remove(MPC8xx_CPM_SCC2);
+	ppc_sys_device_remove(MPC8xx_CPM_SCC4);
+	ppc_sys_device_remove(MPC8xx_CPM_SMC1);
+	ppc_sys_device_remove(MPC8xx_CPM_SMC2);
+
+	return 0;
+}
+
+arch_initcall(mpc885ads_init);
diff --git a/arch/ppc/platforms/pq2ads.h b/arch/ppc/platforms/pq2ads.h
index 067d9a5..6b26dd3 100644
--- a/arch/ppc/platforms/pq2ads.h
+++ b/arch/ppc/platforms/pq2ads.h
@@ -13,6 +13,10 @@
 
 #include <asm/ppcboot.h>
 
+#if defined(CONFIG_ADS8272)
+#define BOARD_CHIP_NAME "8272"
+#endif
+
 /* Memory map is configured by the PROM startup.
  * We just map a few things we need.  The CSR is actually 4 byte-wide
  * registers that can be accessed as 8-, 16-, or 32-bit values.
diff --git a/arch/ppc/platforms/pq2ads_pd.h b/arch/ppc/platforms/pq2ads_pd.h
new file mode 100644
index 0000000..5b5e92d
--- /dev/null
+++ b/arch/ppc/platforms/pq2ads_pd.h
@@ -0,0 +1,114 @@
+#ifndef __PQ2ADS_PD_H
+#define __PQ2ADS_PD_H
+/*
+ * arch/ppc/platforms/82xx/pq2ads_pd.h
+ *
+ * Some defines for MPC82xx board-specific PlatformDevice descriptions
+ *
+ * 2005 (c) MontaVista Software, Inc.
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/* FCC1 Clock Source Configuration.  These can be redefined in the board specific file.
+   Can only choose from CLK9-12 */
+
+#define F1_RXCLK	11
+#define F1_TXCLK	10
+
+/* FCC2 Clock Source Configuration.  These can be redefined in the board specific file.
+   Can only choose from CLK13-16 */
+#define F2_RXCLK	15
+#define F2_TXCLK	16
+
+/* FCC3 Clock Source Configuration.  These can be redefined in the board specific file.
+   Can only choose from CLK13-16 */
+#define F3_RXCLK	13
+#define F3_TXCLK	14
+
+/* Automatically generates register configurations */
+#define PC_CLK(x)	((uint)(1<<(x-1)))	/* FCC CLK I/O ports */
+
+#define CMXFCR_RF1CS(x)	((uint)((x-5)<<27))	/* FCC1 Receive Clock Source */
+#define CMXFCR_TF1CS(x)	((uint)((x-5)<<24))	/* FCC1 Transmit Clock Source */
+#define CMXFCR_RF2CS(x)	((uint)((x-9)<<19))	/* FCC2 Receive Clock Source */
+#define CMXFCR_TF2CS(x) ((uint)((x-9)<<16))	/* FCC2 Transmit Clock Source */
+#define CMXFCR_RF3CS(x)	((uint)((x-9)<<11))	/* FCC3 Receive Clock Source */
+#define CMXFCR_TF3CS(x) ((uint)((x-9)<<8))	/* FCC3 Transmit Clock Source */
+
+#define PC_F1RXCLK	PC_CLK(F1_RXCLK)
+#define PC_F1TXCLK	PC_CLK(F1_TXCLK)
+#define CMX1_CLK_ROUTE	(CMXFCR_RF1CS(F1_RXCLK) | CMXFCR_TF1CS(F1_TXCLK))
+#define CMX1_CLK_MASK	((uint)0xff000000)
+
+#define PC_F2RXCLK	PC_CLK(F2_RXCLK)
+#define PC_F2TXCLK	PC_CLK(F2_TXCLK)
+#define CMX2_CLK_ROUTE	(CMXFCR_RF2CS(F2_RXCLK) | CMXFCR_TF2CS(F2_TXCLK))
+#define CMX2_CLK_MASK	((uint)0x00ff0000)
+
+#define PC_F3RXCLK	PC_CLK(F3_RXCLK)
+#define PC_F3TXCLK	PC_CLK(F3_TXCLK)
+#define CMX3_CLK_ROUTE	(CMXFCR_RF3CS(F3_RXCLK) | CMXFCR_TF3CS(F3_TXCLK))
+#define CMX3_CLK_MASK	((uint)0x0000ff00)
+
+/* I/O Pin assignment for FCC1.  I don't yet know the best way to do this,
+ * but there is little variation among the choices.
+ */
+#define PA1_COL		0x00000001U
+#define PA1_CRS		0x00000002U
+#define PA1_TXER	0x00000004U
+#define PA1_TXEN	0x00000008U
+#define PA1_RXDV	0x00000010U
+#define PA1_RXER	0x00000020U
+#define PA1_TXDAT	0x00003c00U
+#define PA1_RXDAT	0x0003c000U
+#define PA1_PSORA0	(PA1_RXDAT | PA1_TXDAT)
+#define PA1_PSORA1	(PA1_COL | PA1_CRS | PA1_TXER | PA1_TXEN | \
+		PA1_RXDV | PA1_RXER)
+#define PA1_DIRA0	(PA1_RXDAT | PA1_CRS | PA1_COL | PA1_RXER | PA1_RXDV)
+#define PA1_DIRA1	(PA1_TXDAT | PA1_TXEN | PA1_TXER)
+
+
+/* I/O Pin assignment for FCC2.  I don't yet know the best way to do this,
+ * but there is little variation among the choices.
+ */
+#define PB2_TXER	0x00000001U
+#define PB2_RXDV	0x00000002U
+#define PB2_TXEN	0x00000004U
+#define PB2_RXER	0x00000008U
+#define PB2_COL		0x00000010U
+#define PB2_CRS		0x00000020U
+#define PB2_TXDAT	0x000003c0U
+#define PB2_RXDAT	0x00003c00U
+#define PB2_PSORB0	(PB2_RXDAT | PB2_TXDAT | PB2_CRS | PB2_COL | \
+		PB2_RXER | PB2_RXDV | PB2_TXER)
+#define PB2_PSORB1	(PB2_TXEN)
+#define PB2_DIRB0	(PB2_RXDAT | PB2_CRS | PB2_COL | PB2_RXER | PB2_RXDV)
+#define PB2_DIRB1	(PB2_TXDAT | PB2_TXEN | PB2_TXER)
+
+
+/* I/O Pin assignment for FCC3.  I don't yet know the best way to do this,
+ * but there is little variation among the choices.
+ */
+#define PB3_RXDV	0x00004000U
+#define PB3_RXER	0x00008000U
+#define PB3_TXER	0x00010000U
+#define PB3_TXEN	0x00020000U
+#define PB3_COL		0x00040000U
+#define PB3_CRS		0x00080000U
+#define PB3_TXDAT	0x0f000000U
+#define PB3_RXDAT	0x00f00000U
+#define PB3_PSORB0	(PB3_RXDAT | PB3_TXDAT | PB3_CRS | PB3_COL | \
+		PB3_RXER | PB3_RXDV | PB3_TXER | PB3_TXEN)
+#define PB3_PSORB1	0
+#define PB3_DIRB0	(PB3_RXDAT | PB3_CRS | PB3_COL | PB3_RXER | PB3_RXDV)
+#define PB3_DIRB1	(PB3_TXDAT | PB3_TXEN | PB3_TXER)
+
+#define FCC_MEM_OFFSET(x) (CPM_FCC_SPECIAL_BASE + (x*128))
+#define FCC1_MEM_OFFSET FCC_MEM_OFFSET(0)
+#define FCC2_MEM_OFFSET FCC_MEM_OFFSET(1)
+
+#endif

--------------050206010306050402000906--

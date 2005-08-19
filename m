Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id A971D680E3
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Aug 2005 23:31:56 +1000 (EST)
Message-ID: <4305DF4A.4010809@ru.mvista.com>
Date: Fri, 19 Aug 2005 17:31:54 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Kumar Gala <galak@freescale.com>
References: <8E342283C2100540AAC5D1030970547774A3D9@rcexc.racoms.loc>
In-Reply-To: <8E342283C2100540AAC5D1030970547774A3D9@rcexc.racoms.loc>
Content-Type: multipart/mixed; boundary="------------030801030401010207010708"
Cc: "Schaefer-Hutter, Peter" <Peter.Schaefer-Hutter@tfk-racoms.com>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [RFC][PATCH] [1/2] 8xx platform definitions
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
--------------030801030401010207010708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Strange but one hunk header is missing in original patch.
Here's it again.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>

-- 
Sincerely,
Vitaly

--------------030801030401010207010708
Content-Type: text/x-patch;
 name="bsp_plat_defs_885.1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bsp_plat_defs_885.1.patch"

diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -527,6 +527,42 @@ config WINCEPT
 
 endchoice
 
+menu "Freescale Ethernet driver platform-specific options"
+	depends on FS_ENET
+	
+	config MPC8xx_SECOND_ETH
+	bool "Second Ethernet channel"
+	depends on (MPC885ADS || MPC86xADS)
+	default y
+	help
+	  This enables support for second Ethernet on MPC885ADS and MPC86xADS boards.
+	  The latter will use SCC1, for 885ADS you can select it below.
+	
+	choice 
+		prompt "Second Ethernet channel"
+		depends on MPC8xx_SECOND_ETH
+		default MPC885ADS_SECOND_ETH_FEC2
+				
+		config MPC885ADS_SECOND_ETH_FEC2
+		bool "FEC2"
+		help
+		  Enable FEC2 to serve as 2-nd Ethernet channel. Note that SMC2 
+		  (often 2-nd UART) will not work if this is enabled.
+	  
+		config MPC885ADS_SECOND_ETH_SCC
+		bool "SCC3"
+    		help
+		  Enable SCC3 to serve as 2-nd Ethernet channel. Note that SMC2 
+		  (often 1-nd UART) will not work if this is enabled.
+	
+	endchoice
+	
+		config MPC885ADS_SCC_ENET_FIXED
+		depends on MPC885ADS_SECOND_ETH_SCC
+		default n
+		bool "Use fixed MII-less mode for SCC Ethernet"
+endmenu
+
 choice
 	prompt "Machine Type"
 	depends on 6xx || POWER3 || POWER4
diff --git a/arch/ppc/platforms/Makefile b/arch/ppc/platforms/Makefile
--- a/arch/ppc/platforms/Makefile
+++ b/arch/ppc/platforms/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_SANDPOINT)		+= sandpoint.o
 obj-$(CONFIG_SBC82xx)		+= sbc82xx.o
 obj-$(CONFIG_SPRUCE)		+= spruce.o
 obj-$(CONFIG_LITE5200)		+= lite5200.o
+obj-$(CONFIG_MPC885ADS)	+= mpc885ads_setup.o
 
 ifeq ($(CONFIG_SMP),y)
 obj-$(CONFIG_PPC_PMAC)		+= pmac_smp.o
diff --git a/arch/ppc/platforms/mpc885ads.h b/arch/ppc/platforms/mpc885ads.h
--- a/arch/ppc/platforms/mpc885ads.h
+++ b/arch/ppc/platforms/mpc885ads.h
@@ -88,5 +88,7 @@
 #define SICR_ENET_MASK	((uint)0x00ff0000)
 #define SICR_ENET_CLKRT	((uint)0x002c0000)
 
+#define BOARD_NAME "MPC885"
+
 #endif /* __ASM_MPC885ADS_H__ */
 #endif /* __KERNEL__ */
diff --git a/arch/ppc/platforms/mpc885ads_setup.c b/arch/ppc/platforms/mpc885ads_setup.c
new file mode 100644
--- /dev/null
+++ b/arch/ppc/platforms/mpc885ads_setup.c
@@ -0,0 +1,404 @@
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
+/* access ports */
+#define setbits32(_addr, _v) out_be32(&(_addr), in_be32(&(_addr)) |  (_v))
+#define clrbits32(_addr, _v) out_be32(&(_addr), in_be32(&(_addr)) & ~(_v))
+
+#define setbits16(_addr, _v) out_be16(&(_addr), in_be16(&(_addr)) |  (_v))
+#define clrbits16(_addr, _v) out_be16(&(_addr), in_be16(&(_addr)) & ~(_v))
+
+void __init mpc885ads_scc_phy_init(void);
+static void setup_fec1_ioports(void);
+static void setup_fec2_ioports(void);
+static void setup_scc3_ioports(void);
+
+
+static struct fs_mii_bus_info fec_mii_bus_info = {
+	.method = fsmii_fec,
+	.id = 0,
+};
+
+static struct fs_mii_bus_info scc_mii_bus_info = {
+#ifdef CONFIG_MPC885ADS_SCC_ENET_FIXED
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
+	 .phy_irq = SIU_IRQ7,
+	 .phy_addr = 0,
+	 .bus_info = &fec_mii_bus_info,
+	 .init_ioports = &setup_fec1_ioports,
+	 }, {
+	     .rx_ring = 128,
+	     .tx_ring = 16,
+	     .rx_copybreak = 240,
+
+	     .use_napi = 1,
+	     .napi_weight = 17,
+	     .phy_irq = SIU_IRQ7,
+	     .phy_addr = 1,
+
+	     .bus_info = &fec_mii_bus_info,
+	     .init_ioports = &setup_fec2_ioports,
+	     }
+};
+
+static struct fs_platform_info mpc8xx_scc_pdata = {
+	 .rx_ring = 64,
+	 .tx_ring = 8,
+	 .rx_copybreak = 240,
+
+	 .use_napi = 1,
+	 .napi_weight = 17,
+#ifdef CONFIG_MPC885ADS_SCC_ENET_FIXED
+	 .phy_irq = -1,
+	 .phy_addr = -1,	
+#else
+	 .phy_irq = SIU_IRQ7,
+	 .phy_addr = 2,
+#endif
+	 .bus_info = &scc_mii_bus_info,
+	 .init_ioports = &setup_scc3_ioports,
+
+};
+
+static void __init mpc885_nonplatform_device_init(void)
+{
+	immap_t *immap = (immap_t *) IMAP_ADDR;
+	volatile cpm8xx_t *cp = cpmp;
+	unsigned long *bcsr_io;
+
+	bcsr_io = ioremap(BCSR1, sizeof(unsigned long));
+#ifdef CONFIG_SERIAL_CPM_SMC1
+	cp->cp_simode &= ~(0xe0000000 >> 17);	/* brg1 */
+	out_be32((volatile unsigned __iomem *)bcsr_io,
+		 in_be32((volatile unsigned __iomem *)bcsr_io) &
+		 ~BCSR1_RS232EN_1);
+#else
+	out_be32((volatile unsigned __iomem *)bcsr_io,
+		 in_be32((volatile unsigned __iomem *)bcsr_io) |
+		 BCSR1_RS232EN_1);
+	cp->cp_smc[0].smc_smcmr = 0;
+	cp->cp_smc[0].smc_smce = 0;
+#endif
+
+#ifdef CONFIG_SERIAL_CPM_SMC2
+	cp->cp_simode &= ~(0xe0000000 >> 1);
+	cp->cp_simode |= (0x20000000 >> 1);	/* brg2 */
+	out_be32((volatile unsigned __iomem *)bcsr_io,
+		 in_be32((volatile unsigned __iomem *)bcsr_io) &
+		 ~BCSR1_RS232EN_2);
+#else
+	out_be32((volatile unsigned __iomem *)bcsr_io,
+		 in_be32((volatile unsigned __iomem *)bcsr_io) |
+		 BCSR1_RS232EN_2);
+	cp->cp_smc[1].smc_smcmr = 0;
+	cp->cp_smc[1].smc_smce = 0;
+#endif
+	iounmap(bcsr_io);
+
+#ifdef CONFIG_FS_ENET
+	/* use MDC for MII (common) */
+	setbits16(immap->im_ioport.iop_pdpar, 0x0080);
+	clrbits16(immap->im_ioport.iop_pddir, 0x0080);
+#endif
+}
+
+static void setup_fec1_ioports(void)
+{
+	immap_t *immap = (immap_t *) IMAP_ADDR;
+
+	/* configure FEC1 pins  */
+	setbits16(immap->im_ioport.iop_papar, 0xf830);
+	setbits16(immap->im_ioport.iop_padir, 0x0830);
+	clrbits16(immap->im_ioport.iop_padir, 0xf000);
+	setbits32(immap->im_cpm.cp_pbpar, 0x00001001);
+
+	clrbits32(immap->im_cpm.cp_pbdir, 0x00001001);
+	setbits16(immap->im_ioport.iop_pcpar, 0x000c);
+	clrbits16(immap->im_ioport.iop_pcdir, 0x000c);
+	setbits32(immap->im_cpm.cp_pepar, 0x00000003);
+
+	setbits32(immap->im_cpm.cp_pedir, 0x00000003);
+	clrbits32(immap->im_cpm.cp_peso, 0x00000003);
+	clrbits32(immap->im_cpm.cp_cptr, 0x00000100);
+}
+
+static void setup_fec2_ioports(void)
+{
+	immap_t *immap = (immap_t *) IMAP_ADDR;
+
+	/* configure FEC2 pins */
+	setbits32(immap->im_cpm.cp_pepar, 0x0003fffc);
+	setbits32(immap->im_cpm.cp_pedir, 0x0003fffc);
+	setbits32(immap->im_cpm.cp_peso, 0x00037800);
+	clrbits32(immap->im_cpm.cp_peso, 0x000087fc);
+	clrbits32(immap->im_cpm.cp_cptr, 0x00000080);
+}
+
+static void setup_scc3_ioports(void)
+{
+	immap_t *immap = (immap_t *) IMAP_ADDR;
+	unsigned long *bcsr_io;
+
+	bcsr_io = ioremap(BCSR0, sizeof(unsigned long) * 5);
+	/* Enable the PHY.
+	 */
+		out_be32((volatile void __iomem *)(bcsr_io + 4),
+		 (in_be32((volatile void __iomem *)(bcsr_io + 4)) |
+		  BCSR4_ETH10_RST));
+	
+	/* Configure port A pins for Txd and Rxd.
+	 */
+	setbits16(immap->im_ioport.iop_papar, PA_ENET_RXD | PA_ENET_TXD);
+	clrbits16(immap->im_ioport.iop_padir, PA_ENET_RXD | PA_ENET_TXD);
+
+	/* Configure port C pins to enable CLSN and RENA.
+	 */
+	clrbits16(immap->im_ioport.iop_pcpar, PC_ENET_CLSN | PC_ENET_RENA);
+	clrbits16(immap->im_ioport.iop_pcdir, PC_ENET_CLSN | PC_ENET_RENA);
+	setbits16(immap->im_ioport.iop_pcso, PC_ENET_CLSN | PC_ENET_RENA);
+
+	/* Configure port E for TCLK and RCLK.
+	 */
+	setbits32(immap->im_cpm.cp_pepar, PE_ENET_TCLK | PE_ENET_RCLK);
+	clrbits32(immap->im_cpm.cp_pepar, PE_ENET_TENA);
+	clrbits32(immap->im_cpm.cp_pedir,
+		  PE_ENET_TCLK | PE_ENET_RCLK | PE_ENET_TENA);
+	clrbits32(immap->im_cpm.cp_peso, PE_ENET_TCLK | PE_ENET_RCLK);
+	setbits32(immap->im_cpm.cp_peso, PE_ENET_TENA);
+
+	/* Configure Serial Interface clock routing.
+	 * First, clear all SCC bits to zero, then set the ones we want.
+	 */
+	clrbits32(immap->im_cpm.cp_sicr, SICR_ENET_MASK);
+	setbits32(immap->im_cpm.cp_sicr, SICR_ENET_CLKRT);
+
+	/* Disable Rx and Tx. SMC1 sshould be stopped if SCC3 eternet are used.
+	 */
+	immap->im_cpm.cp_smc[0].smc_smcmr &= ~(SMCMR_REN | SMCMR_TEN);
+	/* On the MPC885ADS SCC ethernet PHY is initialized in the full duplex mode
+	 * by H/W setting after reset. SCC ethernet controller support only half duplex.
+	 * This discrepancy of modes causes a lot of carrier lost errors.
+	 */
+	
+	/* In the original SCC enet driver the following code is placed at the end of the initialization */
+	setbits32(immap->im_cpm.cp_pepar, PE_ENET_TENA);
+	clrbits32(immap->im_cpm.cp_pedir, PE_ENET_TENA);
+	setbits32(immap->im_cpm.cp_peso, PE_ENET_TENA);
+
+	out_be32(((volatile void __iomem *)(bcsr_io + 1)),
+		 (in_be32((volatile void __iomem *)(bcsr_io + 1)) |
+		  BCSR1_ETHEN));
+	iounmap(bcsr_io);
+
+}
+
+static void __init mpc885ads_fixup_enet_pdata(struct platform_device *pdev,
+					      int fs_no)
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
+		fpi = &mpc8xx_fec_pdata[fs_get_fec_index(fs_no)];
+	break;
+	case fsid_fec2:
+		fpi = &mpc8xx_fec_pdata[fs_get_fec_index(fs_no)];
+	break;
+	case fsid_scc3:
+		fpi = &mpc8xx_scc_pdata;
+		mpc885ads_scc_phy_init();
+	break;
+	default:
+	break;
+	}
+
+	pdev->dev.platform_data = fpi;
+	fpi->fs_no = fs_no;
+	e = (unsigned char *)&bd->bi_enetaddr;
+	for (i = 0; i < 6; i++)
+		fpi->macaddr[i] = *e++;
+
+	fpi->macaddr[5 - pdev->id]++;
+
+}
+
+static void __init mpc885ads_fixup_fec_enet_pdata(struct platform_device* pdev, int idx)
+{
+	int fs_no = fsid_fec1 + pdev->id -1;
+	mpc885ads_fixup_enet_pdata(pdev, fs_no);
+}
+
+static void __init mpc885ads_fixup_scc_enet_pdata(struct platform_device* pdev, int idx)
+{
+	int fs_no = fsid_scc1 + pdev->id -1;
+	mpc885ads_fixup_enet_pdata(pdev, fs_no);
+}
+
+/* SCC ethernet controller does not have MII management channel. FEC1 MII
+ * channel is used to communicate with the 10Mbit PHY.
+ */
+
+#define PHY_ADDR            0x2
+
+#define MII_ECNTRL_PINMUX        0x4
+#define FEC_ECNTRL_PINMUX        0x00000004
+#define FEC_RCNTRL_MII_MODE        0x00000004
+
+/* Make MII read/write commands.
+ */
+#define mk_mii_write(REG, VAL)    (0x50020000 | (((REG) & 0x1f) << 18) | \
+                ((VAL) & 0xffff) | (PHY_ADDR << 23))
+
+void __init mpc885ads_scc_phy_init(void)
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
+	immap->im_ioport.iop_pdpar |= 0x0080;
+	immap->im_ioport.iop_pddir &= ~0x0080;
+	/* Set MII speed to 2.5 MHz
+	 */
+	fecp->fec_mii_speed =
+	    ((((bd->bi_intfreq + 4999999) / 2500000) / 2) & 0x3F) << 1;
+
+	/* Enable FEC pin MUX
+	 */
+	fecp->fec_ecntrl |= MII_ECNTRL_PINMUX;
+	fecp->fec_r_cntrl |= FEC_RCNTRL_MII_MODE;
+
+	fecp->fec_mii_data = mk_mii_write(MII_BMCR, BMCR_ISOLATE);
+	udelay(100);
+	fecp->fec_mii_data =
+	    mk_mii_write(MII_ADVERTISE, ADVERTISE_10HALF | ADVERTISE_CSMA);
+	udelay(100);
+
+	/* Disable FEC MII settings
+	 */
+	fecp->fec_ecntrl &= ~MII_ECNTRL_PINMUX;
+	fecp->fec_r_cntrl &= ~FEC_RCNTRL_MII_MODE;
+	fecp->fec_mii_speed = 0;
+}
+
+static int __init mpc885ads_platform_notify(struct device *dev)
+{
+	static struct {
+		const char *bus_id;
+		void (*rtn) (struct platform_device * pdev, int idx);
+	} dev_map[] = {
+		{"fsl-cpm-fec", mpc885ads_fixup_fec_enet_pdata}, 
+		{"fsl-cpm-scc", mpc885ads_fixup_scc_enet_pdata},
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
+int __init mpc885ads_init(void)
+{
+	printk(KERN_NOTICE "mpc885ads: Init\n");
+
+	mpc885_nonplatform_device_init();
+	platform_notify = mpc885ads_platform_notify;
+
+	identify_ppc_sys_by_name(BOARD_NAME);
+	
+	/*take care of pin multiplexing*/
+#ifdef CONFIG_MPC885ADS_SECOND_ETH_SCC
+	ppc_sys_device_remove(MPC8xx_CPM_FEC2);	
+#endif
+#ifdef CONFIG_MPC885ADS_SECOND_ETH_FEC2
+	ppc_sys_device_remove(MPC8xx_CPM_SCC3);
+#endif
+	/*Remove stuff does not utilized platform way*/
+	ppc_sys_device_remove(MPC8xx_CPM_SCC1);
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
diff --git a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
--- a/arch/ppc/syslib/Makefile
+++ b/arch/ppc/syslib/Makefile
@@ -34,7 +34,8 @@ ifeq ($(CONFIG_40x),y)
 obj-$(CONFIG_PCI)		+= indirect_pci.o pci_auto.o ppc405_pci.o
 endif
 endif
-obj-$(CONFIG_8xx)		+= m8xx_setup.o ppc8xx_pic.o $(wdt-mpc8xx-y)
+obj-$(CONFIG_8xx)		+= m8xx_setup.o ppc8xx_pic.o $(wdt-mpc8xx-y) \
+				   ppc_sys.o mpc8xx_devices.o mpc8xx_sys.o
 ifeq ($(CONFIG_8xx),y)
 obj-$(CONFIG_PCI)		+= qspan_pci.o i8259.o
 endif
diff --git a/arch/ppc/syslib/mpc8xx_devices.c b/arch/ppc/syslib/mpc8xx_devices.c
new file mode 100644
--- /dev/null
+++ b/arch/ppc/syslib/mpc8xx_devices.c
@@ -0,0 +1,274 @@
+/*
+ * arch/ppc/syslib/mpc8xx_devices.c
+ *
+ * MPC8xx Device descriptions
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * Copyright 2005 MontaVista Software, Inc. by Vitaly Bordug<vbordug@ru.mvista.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/serial_8250.h>
+#include <linux/fsl_devices.h>
+#include <linux/fs_enet_pd.h>
+#include <linux/mii.h>
+#include <asm/commproc.h>
+#include <asm/mpc8xx.h>
+#include <asm/irq.h>
+#include <asm/ppc_sys.h>
+
+/* access ports */
+#define setbits32(_addr, _v) out_be32(&(_addr), in_be32(&(_addr)) |  (_v))
+#define clrbits32(_addr, _v) out_be32(&(_addr), in_be32(&(_addr)) & ~(_v))
+
+#define setbits16(_addr, _v) out_be16(&(_addr), in_be16(&(_addr)) |  (_v))
+#define clrbits16(_addr, _v) out_be16(&(_addr), in_be16(&(_addr)) & ~(_v))
+
+#define MPC8xx_INT_FEC1		SIU_LEVEL1
+#define MPC8xx_INT_FEC2		SIU_LEVEL3
+
+#define MPC8xx_INT_SCC1		(CPM_IRQ_OFFSET + CPMVEC_SCC1)
+#define MPC8xx_INT_SCC2		(CPM_IRQ_OFFSET + CPMVEC_SCC2)
+#define MPC8xx_INT_SCC3		(CPM_IRQ_OFFSET + CPMVEC_SCC3)
+#define MPC8xx_INT_SCC4		(CPM_IRQ_OFFSET + CPMVEC_SCC4)
+#define MPC8xx_INT_SMC1		(CPM_IRQ_OFFSET + CPMVEC_SMC1)
+#define MPC8xx_INT_SMC2		(CPM_IRQ_OFFSET + CPMVEC_SMC2)
+
+/* Offset from IMMAP base address */
+#define MPC8xx_SCC1_OFFSET	(0xa00)
+#define MPC8xx_SCC1_SIZE	(0x18)
+#define MPC8xx_SCC2_OFFSET	(0xa20)
+#define MPC8xx_SCC2_SIZE	(0x18)
+#define MPC8xx_SCC3_OFFSET	(0xa40)
+#define MPC8xx_SCC3_SIZE	(0x18)
+#define MPC8xx_SCC4_OFFSET	(0xa60)
+#define MPC8xx_SCC4_SIZE	(0x18)
+#define MPC8xx_SMC1_OFFSET	(0xa82)
+#define MPC8xx_SMC1_SIZE	(0x0f)
+#define MPC8xx_SMC2_OFFSET	(0xa92)
+#define MPC8xx_SMC2_SIZE	(0x0d)
+#define MPC8xx_FEC1_OFFSET	(0xe00)
+#define MPC8xx_FEC1_SIZE	(0x88)
+#define MPC8xx_FEC2_OFFSET	(0x1e00)
+#define MPC8xx_FEC2_SIZE	(0x88)
+
+#define MPC8xx_DPARAM_SCC1_OFFSET	(0x3C00)
+#define MPC8xx_DPARAM_SCC1_SIZE	(0x80)
+#define MPC8xx_DPARAM_SCC2_OFFSET	(0x3D00)
+#define MPC8xx_DPARAM_SCC2_SIZE	(0x80)
+#define MPC8xx_DPARAM_SCC3_OFFSET	(0x3E00)
+#define MPC8xx_DPARAM_SCC3_SIZE	(0x80)
+#define MPC8xx_DPARAM_SCC4_OFFSET	(0x3F00)
+#define MPC8xx_DPARAM_SCC4_SIZE	(0x80)
+#define MPC8xx_DPARAM_SMC1_OFFSET	(0x3E80)
+#define MPC8xx_DPARAM_SMC1_SIZE	(0x40)
+#define MPC8xx_DPARAM_SMC2_OFFSET	(0x3F80)
+#define MPC8xx_DPARAM_SMC2_SIZE	(0x40)
+
+/* We use offsets for IORESOURCE_MEM to do not set dependences at compile time.
+ * They will get fixed up by mach_mpc8xx_fixup
+ */
+
+struct platform_device ppc_sys_platform_devices[] = {
+	[MPC8xx_CPM_FEC1] =	{
+		.name = "fsl-cpm-fec",
+		.id	= 1,
+		.num_resources = 2,
+		.resource = (struct resource[])	{
+			{
+				.name 	= "regs",
+				.start	= MPC8xx_FEC1_OFFSET,
+				.end	= MPC8xx_FEC1_OFFSET + MPC8xx_FEC1_SIZE,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "interrupt",
+				.start	= MPC8xx_INT_FEC1,
+				.end	= MPC8xx_INT_FEC1,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC8xx_CPM_FEC2] =	{
+		.name = "fsl-cpm-fec",
+		.id	= 2,
+		.num_resources = 2,
+		.resource = (struct resource[])	{
+			{
+				.name	= "regs",
+				.start	= MPC8xx_FEC2_OFFSET,
+				.end	= MPC8xx_FEC2_OFFSET + MPC8xx_FEC2_SIZE,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "interrupt",
+				.start	= MPC8xx_INT_FEC2,
+				.end	= MPC8xx_INT_FEC2,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC8xx_CPM_SCC1] = {
+		.name = "fsl-cpm-scc",
+		.id	= 1,
+		.num_resources = 3,
+		.resource = (struct resource[]) {
+			{
+				.name	= "regs",
+				.start	= MPC8xx_SCC1_OFFSET,
+				.end	= MPC8xx_SCC1_OFFSET + MPC8xx_SCC1_SIZE,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name 	= "pram",
+				.start 	= MPC8xx_DPARAM_SCC1_OFFSET,
+				.end 	= MPC8xx_DPARAM_SCC1_OFFSET + MPC8xx_DPARAM_SCC1_SIZE,
+				.flags 	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "interrupt",
+				.start	= MPC8xx_INT_SCC1,
+				.end	= MPC8xx_INT_SCC1,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC8xx_CPM_SCC2] = {
+		.name = "fsl-cpm-scc",
+		.id	= 2,
+		.num_resources	= 3,
+		.resource = (struct resource[]) {
+			{
+				.name	= "regs",
+				.start	= MPC8xx_SCC2_OFFSET,
+				.end	= MPC8xx_SCC2_OFFSET + MPC8xx_SCC2_SIZE,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name 	= "pram",
+				.start 	= MPC8xx_DPARAM_SCC2_OFFSET,
+				.end 	= MPC8xx_DPARAM_SCC2_OFFSET + MPC8xx_DPARAM_SCC2_SIZE,
+				.flags 	= IORESOURCE_MEM,
+			},
+
+			{
+				.name	= "interrupt",
+				.start	= MPC8xx_INT_SCC2,
+				.end	= MPC8xx_INT_SCC2,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC8xx_CPM_SCC3] = {
+		.name = "fsl-cpm-scc",
+		.id	= 3,
+		.num_resources	= 3,
+		.resource = (struct resource[]) {
+			{
+				.name	= "regs",
+				.start	= MPC8xx_SCC3_OFFSET,
+				.end	= MPC8xx_SCC3_OFFSET + MPC8xx_SCC3_SIZE,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name 	= "pram",
+				.start 	= MPC8xx_DPARAM_SCC3_OFFSET,
+				.end 	= MPC8xx_DPARAM_SCC3_OFFSET + MPC8xx_DPARAM_SCC3_SIZE,
+				.flags 	= IORESOURCE_MEM,
+			},
+
+			{
+				.name	= "interrupt",
+				.start	= MPC8xx_INT_SCC3,
+				.end	= MPC8xx_INT_SCC3,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC8xx_CPM_SCC4] = {
+		.name = "fsl-cpm-scc",
+		.id	= 4,
+		.num_resources	= 3,
+		.resource = (struct resource[]) {
+			{
+				.name	= "regs",
+				.start	= MPC8xx_SCC4_OFFSET,
+				.end	= MPC8xx_SCC3_OFFSET + MPC8xx_SCC1_SIZE,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name 	= "pram",
+				.start 	= MPC8xx_DPARAM_SCC4_OFFSET,
+				.end 	= MPC8xx_DPARAM_SCC4_OFFSET + MPC8xx_DPARAM_SCC4_SIZE,
+				.flags 	= IORESOURCE_MEM,
+			},
+
+			{
+				.name	= "interrupt",
+				.start	= MPC8xx_INT_SCC4,
+				.end	= MPC8xx_INT_SCC4,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC8xx_CPM_SMC1] = {
+		.name = "fsl-cpm-smc",
+		.id	= 1,
+		.num_resources	= 2,
+		.resource = (struct resource[]) {
+			{
+				.name	= "regs",
+				.start	= MPC8xx_SMC1_OFFSET,
+				.end	= MPC8xx_SCC3_OFFSET + MPC8xx_SMC1_SIZE,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "interrupt",
+				.start	= MPC8xx_INT_SMC1,
+				.end	= MPC8xx_INT_SMC1,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC8xx_CPM_SMC2] = {
+		.name = "fsl-cpm-smc",
+		.id	= 2,
+		.num_resources	= 2,
+		.resource = (struct resource[]) {
+			{
+				.name	= "regs",
+				.start	= MPC8xx_SMC2_OFFSET,
+				.end	= MPC8xx_SMC2_OFFSET + MPC8xx_SMC2_SIZE,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "interrupt",
+				.start	= MPC8xx_INT_SMC2,
+				.end	= MPC8xx_INT_SMC2,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+};
+
+static int __init mach_mpc8xx_fixup(struct platform_device *pdev)
+{
+	ppc_sys_fixup_mem_resource (pdev, IMAP_ADDR);
+	return 0;
+}
+
+static int __init mach_mpc8xx_init(void)
+{
+	ppc_sys_device_fixup = mach_mpc8xx_fixup;
+	return 0;
+}
+
+postcore_initcall(mach_mpc8xx_init);
diff --git a/arch/ppc/syslib/mpc8xx_sys.c b/arch/ppc/syslib/mpc8xx_sys.c
new file mode 100644
--- /dev/null
+++ b/arch/ppc/syslib/mpc8xx_sys.c
@@ -0,0 +1,61 @@
+/*
+ * arch/ppc/platforms/mpc8xx_sys.c
+ *
+ * MPC8xx System descriptions
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * Copyright 2005 MontaVista Software, Inc. by Vitaly Bordug <vbordug@ru.mvista.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <asm/ppc_sys.h>
+
+struct ppc_sys_spec *cur_ppc_sys_spec; 
+struct ppc_sys_spec ppc_sys_specs[] = {
+	{
+		.ppc_sys_name	= "MPC86X",
+		.mask 		= 0xFFFFFFFF,
+		.value 		= 0x00000000,
+		.num_devices	= 2,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC8xx_CPM_FEC1,
+			MPC8xx_CPM_SCC1,
+			MPC8xx_CPM_SCC2,
+			MPC8xx_CPM_SCC3,
+			MPC8xx_CPM_SCC4,
+			MPC8xx_CPM_SMC1,
+			MPC8xx_CPM_SMC2,
+		},
+	},
+	{
+		.ppc_sys_name	= "MPC885",
+		.mask 		= 0xFFFFFFFF,
+		.value 		= 0x00000000,
+		.num_devices	= 3,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC8xx_CPM_FEC1,
+			MPC8xx_CPM_FEC2,
+			MPC8xx_CPM_SCC1,
+			MPC8xx_CPM_SCC2,
+			MPC8xx_CPM_SCC3,
+			MPC8xx_CPM_SCC4,
+			MPC8xx_CPM_SMC1,
+			MPC8xx_CPM_SMC2,
+		},
+	},
+	{	/* default match */
+		.ppc_sys_name	= "",
+		.mask 		= 0x00000000,
+		.value 		= 0x00000000,
+	},
+};
diff --git a/include/asm-ppc/mpc8xx.h b/include/asm-ppc/mpc8xx.h
--- a/include/asm-ppc/mpc8xx.h
+++ b/include/asm-ppc/mpc8xx.h
@@ -101,6 +105,22 @@ extern unsigned char __res[];
 
 struct pt_regs;
 
+enum ppc_sys_devices {
+	MPC8xx_CPM_FEC1,
+	MPC8xx_CPM_FEC2,
+	MPC8xx_CPM_I2C,
+	MPC8xx_CPM_SCC1,
+	MPC8xx_CPM_SCC2,
+	MPC8xx_CPM_SCC3,
+	MPC8xx_CPM_SCC4,
+	MPC8xx_CPM_SPI,
+	MPC8xx_CPM_MCC1,
+	MPC8xx_CPM_MCC2,
+	MPC8xx_CPM_SMC1,
+	MPC8xx_CPM_SMC2,
+	MPC8xx_CPM_USB,
+};
+
 #endif /* !__ASSEMBLY__ */
 #endif /* CONFIG_8xx */
 #endif /* __CONFIG_8xx_DEFS */
diff --git a/include/asm-ppc/ppc_sys.h b/include/asm-ppc/ppc_sys.h
--- a/include/asm-ppc/ppc_sys.h
+++ b/include/asm-ppc/ppc_sys.h
@@ -25,6 +25,8 @@
 #include <asm/mpc83xx.h>
 #elif defined(CONFIG_85xx)
 #include <asm/mpc85xx.h>
+#elif defined(CONFIG_8xx)
+#include <asm/mpc8xx.h>
 #elif defined(CONFIG_PPC_MPC52xx)
 #include <asm/mpc52xx.h>
 #elif defined(CONFIG_MPC10X_BRIDGE)

--------------030801030401010207010708--

Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id E932C67C35
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Oct 2006 09:36:05 +1000 (EST)
Date: Sat, 30 Sep 2006 18:35:58 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 12/15] Change ucc_geth driver to use of_device
Message-Id: <20060930183558.0419dc7e.kim.phillips@freescale.com>
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

Change ucc_geth driver to use of_device

This patch change ucc_geth driver to use of_device from
platform_device.  It also fix a bug that bcsr_regs gets
accidentally unmapped.  Remove trailing space.

Sign-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/sysdev/qe_lib/Makefile    |    2 -
 arch/powerpc/sysdev/qe_lib/qe_common.c |   22 ++++++
 drivers/net/ucc_geth.c                 |  119 +++++++++++++++++++++++---------
 3 files changed, 110 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/Makefile b/arch/powerpc/sysdev/qe_lib/Makefile
index 9a54a81..316a63c 100644
--- a/arch/powerpc/sysdev/qe_lib/Makefile
+++ b/arch/powerpc/sysdev/qe_lib/Makefile
@@ -1,7 +1,7 @@
 #
 # Makefile for the linux ppc-specific parts of QE
 #
-obj-$(CONFIG_QUICC_ENGINE)+= qe_common.o qe.o qe_ic.o qe_io.o
+obj-$(CONFIG_QUICC_ENGINE)+= qe_common.o qe_ic.o qe_io.o
 
 obj-$(CONFIG_UCC)	+= ucc.o
 obj-$(CONFIG_UCC_SLOW)	+= ucc_slow.o
diff --git a/arch/powerpc/sysdev/qe_lib/qe_common.c b/arch/powerpc/sysdev/qe_lib/qe_common.c
index 0cde73c..5c3381f 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_common.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_common.c
@@ -60,6 +60,28 @@ static int qe_sdma_init(void);
 
 static DEFINE_SPINLOCK(qe_lock);
 
+static phys_addr_t qebase = -1;
+
+phys_addr_t get_qe_base(void)
+{
+	struct device_node *qe;
+
+	if (qebase != -1)
+		return qebase;
+
+	qe = of_find_node_by_type(NULL, "qe");
+	if (qe) {
+		unsigned int size;
+		void *prop = get_property(qe, "reg", &size);
+		qebase = of_translate_address(qe, prop);
+		of_node_put(qe);
+	};
+
+	return qebase;
+}
+
+EXPORT_SYMBOL(get_qe_base);
+
 void qe_reset(void)
 {
 	if (qe_immr == NULL)
diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index 625a9ab..ef6cc2a 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -2,14 +2,11 @@
  * Copyright (C) Freescale Semicondutor, Inc. 2006. All rights reserved.
  *
  * Author: Shlomi Gridish <gridish@freescale.com>
+ *	   Li Yang <leoli@freescale.com>
  *
  * Description:
  * QE UCC Gigabit Ethernet Driver
  *
- * Changelog:
- * Jul 6, 2006 Li Yang <LeoLi@freescale.com>
- * - Rearrange code and style fixes
- *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
  * Free Software Foundation;  either version 2 of the  License, or (at your
@@ -31,9 +28,9 @@ #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/fsl_devices.h>
 #include <linux/ethtool.h>
-#include <linux/platform_device.h>
 #include <linux/mii.h>
 
+#include <asm/of_device.h>
 #include <asm/uaccess.h>
 #include <asm/irq.h>
 #include <asm/io.h>
@@ -4131,30 +4128,47 @@ static int ucc_geth_close(struct net_dev
 
 const struct ethtool_ops ucc_geth_ethtool_ops = { };
 
-static int ucc_geth_probe(struct device *device)
+static int ucc_geth_probe(struct of_device* ofdev, const struct of_device_id *match)
 {
-	struct platform_device *pdev = to_platform_device(device);
-	struct ucc_geth_platform_data *ugeth_pdata;
+	struct device *device = &ofdev->dev;
+	struct device_node *np = ofdev->node;
 	struct net_device *dev = NULL;
 	struct ucc_geth_private *ugeth = NULL;
 	struct ucc_geth_info *ug_info;
-	int err;
+	struct resource res;
+	struct device_node *phy;
+	int err, ucc_num, phy_interface;
 	static int mii_mng_configured = 0;
+	phandle *ph;
 
 	ugeth_vdbg("%s: IN", __FUNCTION__);
 
-	ugeth_pdata = (struct ucc_geth_platform_data *)pdev->dev.platform_data;
+	ucc_num = *((int *) get_property(np, "device-id", NULL)) - 1;
+	if ((ucc_num < 0) || (ucc_num > 7))
+		return -ENODEV;
+
+	ug_info = &ugeth_info[ucc_num];
+	ug_info->uf_info.ucc_num = ucc_num;
+	ug_info->uf_info.rx_clock = *((uint *) get_property(np, "rx-clock", NULL));
+	ug_info->uf_info.tx_clock = *((uint *) get_property(np, "tx-clock", NULL));
+	err = of_address_to_resource(np, 0, &res);
+	if (err)
+		return -EINVAL;
+
+	ug_info->uf_info.regs = res.start;
+	ug_info->uf_info.irq = irq_of_parse_and_map(np, 0);
+
+	ph = (phandle *) get_property(np, "phy-handle", NULL);
+	phy = of_find_node_by_phandle(*ph);
 
-	ug_info = &ugeth_info[pdev->id];
-	ug_info->uf_info.ucc_num = pdev->id;
-	ug_info->uf_info.rx_clock = ugeth_pdata->rx_clock;
-	ug_info->uf_info.tx_clock = ugeth_pdata->tx_clock;
-	ug_info->uf_info.regs = ugeth_pdata->phy_reg_addr;
-	ug_info->uf_info.irq = platform_get_irq(pdev, 0);
-	ug_info->phy_address = ugeth_pdata->phy_id;
-	ug_info->enet_interface = ugeth_pdata->phy_interface;
-	ug_info->board_flags = ugeth_pdata->board_flags;
-	ug_info->phy_interrupt = ugeth_pdata->phy_interrupt;
+	if (phy == NULL)
+		return -ENODEV;
+
+	ug_info->phy_address = *(u8 *) get_property(phy, "reg", NULL);
+	ug_info->enet_interface = *((uint *) get_property(phy, "interface", NULL));
+	ug_info->phy_interrupt = irq_of_parse_and_map(phy, 0);
+	ug_info->board_flags = (ug_info->phy_interrupt == NO_IRQ)?
+			0:FSL_UGETH_BRD_HAS_PHY_INTR;
 
 	printk(KERN_INFO "ucc_geth: UCC%1d at 0x%8x (irq = %d) \n",
 		ug_info->uf_info.ucc_num + 1, ug_info->uf_info.regs,
@@ -4162,12 +4176,43 @@ static int ucc_geth_probe(struct device 
 
 	if (ug_info == NULL) {
 		ugeth_err("%s: [%d] Missing additional data!", __FUNCTION__,
-			  pdev->id);
+			  ucc_num);
 		return -ENODEV;
 	}
 
+	/* FIXME: Work around for early chip rev.               */
+	/* There's a bug in initial chip rev(s) in the RGMII ac */
+	/* timing.						*/
+	/* The following compensates by writing to the reserved */
+	/* QE Port Output Hold Registers (CPOH1?).              */
+	phy_interface = *((int *) get_property(phy, "interface", NULL));
+	if ((phy_interface == ENET_1000_RGMII) ||
+			(phy_interface == ENET_100_RGMII) ||
+			(phy_interface == ENET_10_RGMII)) {
+		struct device_node *soc;
+		phys_addr_t immrbase = -1;
+		u32 *tmp_reg;
+		u32 tmp_val;
+
+		soc = of_find_node_by_type(NULL, "soc");
+		if (soc) {
+			unsigned int size;
+			void *prop = get_property(soc, "reg", &size);
+			immrbase = of_translate_address(soc, prop);
+			of_node_put(soc);
+		};
+
+		tmp_reg = (u32 *) ioremap(immrbase + 0x14A8, 0x4);
+		tmp_val = in_be32(tmp_reg);
+		if (ucc_num == 1)
+			out_be32(tmp_reg, tmp_val | 0x00003000);
+		else if (ucc_num == 2)
+			out_be32(tmp_reg, tmp_val | 0x0c000000);
+		iounmap(tmp_reg);
+	}
+	
 	if (!mii_mng_configured) {
-		ucc_set_qe_mux_mii_mng(ug_info->uf_info.ucc_num);
+		ucc_set_qe_mux_mii_mng(ucc_num);
 		mii_mng_configured = 1;
 	}
 
@@ -4214,13 +4259,14 @@ #endif				/* CONFIG_UGETH_NAPI */
 
 	ugeth->ug_info = ug_info;
 	ugeth->dev = dev;
-	memcpy(dev->dev_addr, ugeth_pdata->mac_addr, 6);
+	memcpy(dev->dev_addr, get_property(np, "mac-address", NULL), 6);
 
 	return 0;
 }
 
-static int ucc_geth_remove(struct device *device)
+static int ucc_geth_remove(struct of_device* ofdev)
 {
+	struct device *device = &ofdev->dev;
 	struct net_device *dev = dev_get_drvdata(device);
 	struct ucc_geth_private *ugeth = netdev_priv(dev);
 
@@ -4231,28 +4277,37 @@ static int ucc_geth_remove(struct device
 	return 0;
 }
 
-/* Structure for a device driver */
-static struct device_driver ucc_geth_driver = {
-	.name = DRV_NAME,
-	.bus = &platform_bus_type,
-	.probe = ucc_geth_probe,
-	.remove = ucc_geth_remove,
+static struct of_device_id ucc_geth_match[] = {
+	{ 
+		.compatible = "ucc_geth",
+	},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, ucc_geth_match);
+
+static struct of_platform_driver ucc_geth_driver = {
+	.name		= DRV_NAME,
+	.match_table	= ucc_geth_match,
+	.probe		= ucc_geth_probe,
+	.remove		= ucc_geth_remove,
 };
 
 static int __init ucc_geth_init(void)
 {
 	int i;
+
 	printk(KERN_INFO "ucc_geth: " DRV_DESC "\n");
 	for (i = 0; i < 8; i++)
 		memcpy(&(ugeth_info[i]), &ugeth_primary_info,
 		       sizeof(ugeth_primary_info));
 
-	return driver_register(&ucc_geth_driver);
+	return of_register_driver(&ucc_geth_driver);
 }
 
 static void __exit ucc_geth_exit(void)
 {
-	driver_unregister(&ucc_geth_driver);
+	of_unregister_driver(&ucc_geth_driver);
 }
 
 module_init(ucc_geth_init);
-- 
1.4.2.1

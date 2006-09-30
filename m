Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id E328167B22
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Sep 2006 20:33:14 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k8UAXCMT015062
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Sep 2006 03:33:12 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k8UAX9m8014121
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Sep 2006 05:33:10 -0500 (CDT)
Message-ID: <451E4808.7010004@freescale.com>
Date: Sat, 30 Sep 2006 18:33:44 +0800
From: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
To: paulus@samba.org, Kumar <galak@kernel.crashing.org>
Subject: [PATCH] Change ucc_geth driver to use of_device
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch change ucc_geth driver to use of_device from
platform_device.  It also fix a bug that bcsr_regs gets
accidentally unmapped.  Remove trailing space.

Sign-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/platforms/83xx/mpc8360e_pb.c    |   32 ++++-
 arch/powerpc/sysdev/qe_lib/Makefile          |    2 
 arch/powerpc/sysdev/qe_lib/qe.c              |  176 --------------------------
 arch/powerpc/sysdev/qe_lib/qe_common.c       |   22 +++
 drivers/net/ucc_geth.c                       |  119 +++++++++++++-----

diff --git a/arch/powerpc/platforms/83xx/mpc8360e_pb.c b/arch/powerpc/platforms/83xx/mpc8360e_pb.c
index 4c6e5db..3563b9d 100644
--- a/arch/powerpc/platforms/83xx/mpc8360e_pb.c
+++ b/arch/powerpc/platforms/83xx/mpc8360e_pb.c
@@ -5,9 +5,9 @@
  *	   Yin Olivia <Hong-hua.Yin@freescale.com>
  *
  * Description:
- * MPC8360E MDS PB board specific routines. 
+ * MPC8360E MDS PB board specific routines.
  *
- * Changelog: 
+ * Changelog:
  * Jun 21, 2006	Initial version
  *
  * This program is free software; you can redistribute  it and/or modify it
@@ -30,6 +30,7 @@ #include <linux/seq_file.h>
 #include <linux/root_dev.h>
 #include <linux/initrd.h>
 
+#include <asm/of_device.h>
 #include <asm/system.h>
 #include <asm/atomic.h>
 #include <asm/time.h>
@@ -113,18 +114,17 @@ #ifdef CONFIG_QUICC_ENGINE
 	if ((np = of_find_node_by_name(np, "par_io")) != NULL) {
 		par_io_init(np);
 		of_node_put(np);
-		
+
 		for (np = NULL; (np = of_find_node_by_name(np, "ucc")) != NULL;)
 			par_io_of_config(np);
 	}
-	
-	if ((np = of_find_compatible_node(NULL, "network", "ucc_geth")) 
+
+	if ((np = of_find_compatible_node(NULL, "network", "ucc_geth"))
 			!= NULL){
 		/* Reset the Ethernet PHY */
 		bcsr_regs[9] &= ~0x20;
 		udelay(1000);
 		bcsr_regs[9] |= 0x20;
-		iounmap(bcsr_regs);
 		of_node_put(np);
 	}
 
@@ -142,9 +142,25 @@ #else
 #endif
 }
 
-void __init mpc8360_sys_init_IRQ(void)
+static int __init mpc8360_declare_of_platform_devices(void)
 {
+	struct device_node *np;
+
+	for (np = NULL; (np = of_find_compatible_node(np, "network", "ucc_geth")) != NULL;) {
+		int ucc_num;
+		char bus_id[BUS_ID_SIZE];
+
+		ucc_num = *((uint *) get_property(np, "device-id", NULL)) - 1;
+		snprintf(bus_id, BUS_ID_SIZE, "ucc_geth.%u", ucc_num);
+		of_platform_device_create(np, bus_id, NULL);
+	}
+
+	return 0;
+}
+device_initcall(mpc8360_declare_of_platform_devices);
 
+void __init mpc8360_sys_init_IRQ(void)
+{
 	struct device_node *np;
 
 	np = of_find_node_by_type(NULL, "ipic");
@@ -164,7 +180,7 @@ #ifdef CONFIG_QUICC_ENGINE
 	if (!np)
 		return;
 
-	qe_ic_init(np, 0); 
+	qe_ic_init(np, 0);
 	of_node_put(np);
 #endif				/* CONFIG_QUICC_ENGINE */
 }
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
diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
deleted file mode 100644
index df3e826..0000000
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ /dev/null
@@ -1,176 +0,0 @@
-/*
- * Copyright (C) 2006 Freescale Semicondutor, Inc. All rights reserved.
- *
- * Author: Li Yang <LeoLi@freescale.com>
- *
- * Description:
- * FSL QE SOC setup.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include <linux/config.h>
-#include <linux/stddef.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/errno.h>
-#include <linux/major.h>
-#include <linux/delay.h>
-#include <linux/irq.h>
-#include <linux/module.h>
-#include <linux/device.h>
-#include <linux/platform_device.h>
-#include <linux/fsl_devices.h>
-
-#include <asm/system.h>
-#include <asm/atomic.h>
-#include <asm/io.h>
-#include <asm/irq.h>
-#include <asm/prom.h>
-#include <sysdev/fsl_soc.h>
-#include <mm/mmu_decl.h>
-
-static phys_addr_t qebase = -1;
-
-phys_addr_t get_qe_base(void)
-{
-	struct device_node *qe;
-
-	if (qebase != -1)
-		return qebase;
-
-	qe = of_find_node_by_type(NULL, "qe");
-	if (qe) {
-		unsigned int size;
-		void *prop = get_property(qe, "reg", &size);
-		qebase = of_translate_address(qe, prop);
-		of_node_put(qe);
-	};
-
-	return qebase;
-}
-
-EXPORT_SYMBOL(get_qe_base);
-
-static int __init ucc_geth_of_init(void)
-{
-	struct device_node *np;
-	unsigned int i, ucc_num;
-	struct platform_device *ugeth_dev;
-	struct resource res;
-	int ret;
-
-	for (np = NULL, i = 0;
-	     (np = of_find_compatible_node(np, "network", "ucc_geth")) != NULL;
-	     i++) {
-		struct resource r[2];
-		struct device_node *phy, *mdio;
-		struct ucc_geth_platform_data ugeth_data;
-		unsigned int *id;
-		char *model;
-		void *mac_addr;
-		phandle *ph;
-
-		memset(r, 0, sizeof(r));
-		memset(&ugeth_data, 0, sizeof(ugeth_data));
-
-		ret = of_address_to_resource(np, 0, &r[0]);
-		if (ret)
-			goto err;
-
-		ugeth_data.phy_reg_addr = r[0].start;
-		r[1].start = r[1].end = irq_of_parse_and_map(np, 0);
-		r[1].flags = IORESOURCE_IRQ;
-
-		model = get_property(np, "model", NULL);
-		ucc_num = *((u32 *) get_property(np, "device-id", NULL));
-		if ((strstr(model, "UCC") == NULL) || 
-				(ucc_num < 1) || (ucc_num > 8)) {
-			ret = -ENODEV;
-			goto err;
-		}
-		
-		ugeth_dev =
-		    platform_device_register_simple("ucc_geth", ucc_num - 1,
-				    &r[0], 2);
-
-		if (IS_ERR(ugeth_dev)) {
-			ret = PTR_ERR(ugeth_dev);
-			goto err;
-		}
-
-		mac_addr = get_property(np, "mac-address", NULL);
-		
-		memcpy(ugeth_data.mac_addr, mac_addr, 6);
-
-		ugeth_data.rx_clock = *((u32 *) get_property(np, "rx-clock",
-					NULL));
-		ugeth_data.tx_clock = *((u32 *) get_property(np, "tx-clock",
-					NULL));
-
-		ph = (phandle *) get_property(np, "phy-handle", NULL);
-		phy = of_find_node_by_phandle(*ph);
-
-		if (phy == NULL) {
-			ret = -ENODEV;
-			goto unreg;
-		}
-
-		mdio = of_get_parent(phy);
-
-		id = (u32 *) get_property(phy, "reg", NULL);
-		ret = of_address_to_resource(mdio, 0, &res);
-		if (ret) {
-			of_node_put(phy);
-			of_node_put(mdio);
-			goto unreg;
-		}
-		
-		ugeth_data.phy_id = *id;
-
-		ugeth_data.phy_interrupt = irq_of_parse_and_map(phy, 0);; 
-		ugeth_data.phy_interface = *((u32 *) get_property(phy,
-					"interface", NULL));
-
-		/* FIXME: Work around for early chip rev.               */
-		/* There's a bug in initial chip rev(s) in the RGMII ac */
-		/* timing.						*/
-		/* The following compensates by writing to the reserved */
-		/* QE Port Output Hold Registers (CPOH1?).              */	
-		if ((ugeth_data.phy_interface == ENET_1000_RGMII) || 
-				(ugeth_data.phy_interface == ENET_100_RGMII) ||
-				(ugeth_data.phy_interface == ENET_10_RGMII)) {
-			u32 *tmp_reg = (u32 *) ioremap(get_immrbase() 
-					+ 0x14A8, 0x4);
-			u32 tmp_val = in_be32(tmp_reg);
-			if (ucc_num == 1)
-				out_be32(tmp_reg, tmp_val | 0x00003000);
-			else if (ucc_num == 2)
-				out_be32(tmp_reg, tmp_val | 0x0c000000);
-			iounmap(tmp_reg);
-		}
-		
-		if (ugeth_data.phy_interrupt != 0)
-			ugeth_data.board_flags |= FSL_UGETH_BRD_HAS_PHY_INTR;
-
-		of_node_put(phy);
-		of_node_put(mdio);
-
-		ret = platform_device_add_data(ugeth_dev, &ugeth_data,
-				sizeof(struct ucc_geth_platform_data));
-		if (ret)
-			goto unreg;
-	}
-
-	return 0;
-
-unreg:
-	platform_device_unregister(ugeth_dev);
-err:
-	return ret;
-}
-
-arch_initcall(ucc_geth_of_init);
diff --git a/arch/powerpc/sysdev/qe_lib/qe_common.c b/arch/powerpc/sysdev/qe_lib/qe_common.c
index 516c186..2e6e6fe 100644
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
index 6ca380b..85be97f 100644
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
@@ -4146,30 +4143,47 @@ struct ethtool_ops ucc_geth_ethtool_ops 
 	.get_ethtool_stats = NULL,
 };
 
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
@@ -4177,12 +4191,43 @@ static int ucc_geth_probe(struct device 
 
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
 
@@ -4229,13 +4274,14 @@ #endif				/* CONFIG_UGETH_NAPI */
 
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
 
@@ -4246,28 +4292,37 @@ static int ucc_geth_remove(struct device
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

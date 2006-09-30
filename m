Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 3FD2567DBE
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Oct 2006 09:34:52 +1000 (EST)
Date: Sat, 30 Sep 2006 18:34:48 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 8/15] qe_lib: Add QE SoC support
Message-Id: <20060930183448.4ed20e14.kim.phillips@freescale.com>
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

qe_lib: Add QE SoC support

Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/sysdev/qe_lib/qe.c |  176 +++++++++++++++++++++++++++++++++++++++
 include/linux/fsl_devices.h     |   39 ++++++++-
 2 files changed, 214 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
new file mode 100644
index 0000000..f628759
--- /dev/null
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -0,0 +1,176 @@
+/*
+ * Copyright (C) 2006 Freescale Semicondutor, Inc. All rights reserved.
+ *
+ * Author: Li Yang <LeoLi@freescale.com>
+ *
+ * Description:
+ * FSL QE SOC setup.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/major.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/fsl_devices.h>
+
+#include <asm/system.h>
+#include <asm/atomic.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/prom.h>
+#include <sysdev/fsl_soc.h>
+#include <mm/mmu_decl.h>
+
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
+static int __init ucc_geth_of_init(void)
+{
+	struct device_node *np;
+	unsigned int i, ucc_num;
+	struct platform_device *ugeth_dev;
+	struct resource res;
+	int ret;
+
+	for (np = NULL, i = 0;
+	     (np = of_find_compatible_node(np, "network", "ucc_geth")) != NULL;
+	     i++) {
+		struct resource r[2];
+		struct device_node *phy, *mdio;
+		struct ucc_geth_platform_data ugeth_data;
+		unsigned int *id;
+		char *model;
+		void *mac_addr;
+		phandle *ph;
+
+		memset(r, 0, sizeof(r));
+		memset(&ugeth_data, 0, sizeof(ugeth_data));
+
+		ret = of_address_to_resource(np, 0, &r[0]);
+		if (ret)
+			goto err;
+
+		ugeth_data.phy_reg_addr = r[0].start;
+		r[1].start = r[1].end = irq_of_parse_and_map(np, 0);
+		r[1].flags = IORESOURCE_IRQ;
+
+		model = get_property(np, "model", NULL);
+		ucc_num = *((u32 *) get_property(np, "device-id", NULL));
+		if ((strstr(model, "UCC") == NULL) ||
+				(ucc_num < 1) || (ucc_num > 8)) {
+			ret = -ENODEV;
+			goto err;
+		}
+
+		ugeth_dev =
+		    platform_device_register_simple("ucc_geth", ucc_num - 1,
+				    &r[0], 2);
+
+		if (IS_ERR(ugeth_dev)) {
+			ret = PTR_ERR(ugeth_dev);
+			goto err;
+		}
+
+		mac_addr = get_property(np, "mac-address", NULL);
+
+		memcpy(ugeth_data.mac_addr, mac_addr, 6);
+
+		ugeth_data.rx_clock = *((u32 *) get_property(np, "rx-clock",
+					NULL));
+		ugeth_data.tx_clock = *((u32 *) get_property(np, "tx-clock",
+					NULL));
+
+		ph = (phandle *) get_property(np, "phy-handle", NULL);
+		phy = of_find_node_by_phandle(*ph);
+
+		if (phy == NULL) {
+			ret = -ENODEV;
+			goto unreg;
+		}
+
+		mdio = of_get_parent(phy);
+
+		id = (u32 *) get_property(phy, "reg", NULL);
+		ret = of_address_to_resource(mdio, 0, &res);
+		if (ret) {
+			of_node_put(phy);
+			of_node_put(mdio);
+			goto unreg;
+		}
+
+		ugeth_data.phy_id = *id;
+
+		ugeth_data.phy_interrupt = irq_of_parse_and_map(phy, 0);;
+		ugeth_data.phy_interface = *((u32 *) get_property(phy,
+					"interface", NULL));
+
+		/* FIXME: Work around for early chip rev.               */
+		/* There's a bug in initial chip rev(s) in the RGMII ac */
+		/* timing.						*/
+		/* The following compensates by writing to the reserved */
+		/* QE Port Output Hold Registers (CPOH1?).              */
+		if ((ugeth_data.phy_interface == ENET_1000_RGMII) ||
+				(ugeth_data.phy_interface == ENET_100_RGMII) ||
+				(ugeth_data.phy_interface == ENET_10_RGMII)) {
+			u32 *tmp_reg = (u32 *) ioremap(get_immrbase()
+					+ 0x14A8, 0x4);
+			u32 tmp_val = in_be32(tmp_reg);
+			if (ucc_num == 1)
+				out_be32(tmp_reg, tmp_val | 0x00003000);
+			else if (ucc_num == 2)
+				out_be32(tmp_reg, tmp_val | 0x0c000000);
+			iounmap(tmp_reg);
+		}
+
+		if (ugeth_data.phy_interrupt != 0)
+			ugeth_data.board_flags |= FSL_UGETH_BRD_HAS_PHY_INTR;
+
+		of_node_put(phy);
+		of_node_put(mdio);
+
+		ret = platform_device_add_data(ugeth_dev, &ugeth_data,
+				sizeof(struct ucc_geth_platform_data));
+		if (ret)
+			goto unreg;
+	}
+
+	return 0;
+
+unreg:
+	platform_device_unregister(ugeth_dev);
+err:
+	return ret;
+}
+
+arch_initcall(ucc_geth_of_init);
diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
index 16fbe59..a16d82f 100644
--- a/include/linux/fsl_devices.h
+++ b/include/linux/fsl_devices.h
@@ -83,7 +83,6 @@ struct fsl_i2c_platform_data {
 #define FSL_I2C_DEV_SEPARATE_DFSRR	0x00000001
 #define FSL_I2C_DEV_CLOCK_5200		0x00000002
 
-
 enum fsl_usb2_operating_modes {
 	FSL_USB2_MPH_HOST,
 	FSL_USB2_DR_HOST,
@@ -121,5 +120,43 @@ struct fsl_spi_platform_data {
 	u32	sysclk;
 };
 
+/* Ethernet interface (phy management and speed)
+*/
+typedef enum enet_interface {
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
+} enet_interface_e;
+
+struct ucc_geth_platform_data {
+	/* device specific information */
+	u32 device_flags;
+	u32 phy_reg_addr;
+
+	/* board specific information */
+	u32 board_flags;
+	u8 rx_clock;
+	u8 tx_clock;
+	u32 phy_id;
+	enet_interface_e phy_interface;
+	u32 phy_interrupt;
+	u8 mac_addr[6];
+};
+
+/* Flags related to UCC Gigabit Ethernet device features */
+#define FSL_UGETH_DEV_HAS_GIGABIT		0x00000001
+#define FSL_UGETH_DEV_HAS_COALESCE		0x00000002
+#define FSL_UGETH_DEV_HAS_RMON			0x00000004
+
+/* Flags in ucc_geth_platform_data */
+#define FSL_UGETH_BRD_HAS_PHY_INTR		0x00000001	/* if not set use a timer */
+
 #endif				/* _FSL_DEVICE_H_ */
 #endif				/* __KERNEL__ */
-- 
1.4.2.1

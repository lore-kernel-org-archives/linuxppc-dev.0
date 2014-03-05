Return-Path: <Shengzhou.Liu@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0DFFF2C01AE
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2014 20:23:20 +1100 (EST)
Received: from mail185-tx2 (localhost [127.0.0.1])	by
 mail185-tx2-R.bigfish.com (Postfix) with ESMTP id 6CB99260512	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2014 09:23:16 +0000 (UTC)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
Subject: [PATCH] net/phy: Add Cortina CS43xx PHY support
Date: Wed, 5 Mar 2014 16:16:31 +0800
Message-ID: <1394007391-32256-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: YongHua Cao <B43619@freescale.com>,
 Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add support for Cortina CS4315/CS4340 10G PHY.
(Tested with CS4315 on T2080RDB and CS4340 on T4240RDB).

Signed-off-by: YongHua Cao <B43619@freescale.com>
Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
---
 drivers/net/phy/Kconfig   |  5 +++
 drivers/net/phy/Makefile  |  1 +
 drivers/net/phy/cortina.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+)
 create mode 100644 drivers/net/phy/cortina.c

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 1d18443..f7d6c8c 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -60,6 +60,11 @@ config VITESSE_PHY
         ---help---
           Currently supports the vsc8244
 
+config CORTINA_PHY
+	tristate "Drivers for the Cortina PHYs"
+	---help---
+	  Currently supports the CS4315 and CS4340 PHY.
+
 config SMSC_PHY
 	tristate "Drivers for SMSC PHYs"
 	---help---
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index a4f96b7..4047042 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_LXT_PHY)		+= lxt.o
 obj-$(CONFIG_QSEMI_PHY)		+= qsemi.o
 obj-$(CONFIG_SMSC_PHY)		+= smsc.o
 obj-$(CONFIG_VITESSE_PHY)	+= vitesse.o
+obj-$(CONFIG_CORTINA_PHY)	+= cortina.o
 obj-$(CONFIG_BROADCOM_PHY)	+= broadcom.o
 obj-$(CONFIG_BCM63XX_PHY)	+= bcm63xx.o
 obj-$(CONFIG_BCM87XX_PHY)	+= bcm87xx.o
diff --git a/drivers/net/phy/cortina.c b/drivers/net/phy/cortina.c
new file mode 100644
index 0000000..154827c
--- /dev/null
+++ b/drivers/net/phy/cortina.c
@@ -0,0 +1,92 @@
+/* Driver for Cortina PHYs
+ *
+ * Copyright 2013-2014 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mii.h>
+#include <linux/ethtool.h>
+#include <linux/phy.h>
+
+#define PHY_ID_CS4340	0x13e51002
+
+MODULE_DESCRIPTION("Cortina PHY driver");
+MODULE_AUTHOR("Caoyh");
+MODULE_LICENSE("GPL");
+
+static int cs4340_config_init(struct phy_device *phydev)
+{
+	phydev->supported = SUPPORTED_10000baseT_Full;
+	phydev->advertising = SUPPORTED_10000baseT_Full;
+
+	return 0;
+}
+
+static int cs4340_config_aneg(struct phy_device *phydev)
+{
+	return 0;
+}
+
+static int cs4340_read_status(struct phy_device *phydev)
+{
+	phydev->link = 1;
+	phydev->speed = 10000;
+	phydev->duplex = DUPLEX_FULL;
+	return 0;
+}
+
+static int cs4340_ack_interrupt(struct phy_device *phydev)
+{
+	return 0;
+}
+
+static int cs4340_config_intr(struct phy_device *phydev)
+{
+	return 0;
+}
+
+static struct phy_driver cs4340_driver = {
+	.phy_id		= PHY_ID_CS4340,
+	.phy_id_mask	= 0xffffffff,
+	.name		= "Cortina CS4315/CS4340",
+	.features	= 0,
+	.config_init	= &cs4340_config_init,
+	.config_aneg	= &cs4340_config_aneg,
+	.read_status	= &cs4340_read_status,
+	.ack_interrupt	= &cs4340_ack_interrupt,
+	.config_intr	= &cs4340_config_intr,
+	.driver		= { .owner = THIS_MODULE,},
+};
+
+static int __init cs4340_init(void)
+{
+	int err;
+
+	err = phy_driver_register(&cs4340_driver);
+	if (err < 0)
+			return err;
+
+	return 0;
+}
+
+static void __exit cs4340_exit(void)
+{
+	phy_driver_unregister(&cs4340_driver);
+}
+
+module_init(cs4340_init);
+module_exit(cs4340_exit);
+
+static struct mdio_device_id __maybe_unused cortina_tbl[] = {
+	{ PHY_ID_CS4340, 0xffffffff},
+	{},
+};
+
+MODULE_DEVICE_TABLE(mdio, cortina_tbl);
-- 
1.8.0

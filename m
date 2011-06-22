Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id C9149B6FA9
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Jun 2011 17:55:18 +1000 (EST)
From: Heiko Schocher <hs@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/4] net, phy: am79c874 support
Date: Wed, 22 Jun 2011 09:55:08 +0200
Message-Id: <1308729311-15375-2-git-send-email-hs@denx.de>
In-Reply-To: <1308729311-15375-1-git-send-email-hs@denx.de>
References: <1308729311-15375-1-git-send-email-hs@denx.de>
Cc: Heiko Schocher <hs@denx.de>, linux-netdev@vger.kernel.org,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Heiko Schocher <hs@denx.de>
cc: linux-netdev@vger.kernel.org
cc: Wolfgang Denk <wd@denx.de>
---
 drivers/net/phy/Kconfig  |    5 ++
 drivers/net/phy/Makefile |    1 +
 drivers/net/phy/amd79.c  |  109 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 115 insertions(+), 0 deletions(-)
 create mode 100644 drivers/net/phy/amd79.c

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index a702443..ee70d04 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -15,6 +15,11 @@ if PHYLIB
 
 comment "MII PHY device drivers"
 
+config AMD_PHY
+	tristate "Drivers for the AMD79 PHYs"
+	---help---
+	  Currently supports the amd79c874
+
 config MARVELL_PHY
 	tristate "Drivers for Marvell PHYs"
 	---help---
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 2333215..79bc8b4 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -23,3 +23,4 @@ obj-$(CONFIG_DP83640_PHY)	+= dp83640.o
 obj-$(CONFIG_STE10XP)		+= ste10Xp.o
 obj-$(CONFIG_MICREL_PHY)	+= micrel.o
 obj-$(CONFIG_MDIO_OCTEON)	+= mdio-octeon.o
+obj-$(CONFIG_AMD_PHY)		+= amd79.o
diff --git a/drivers/net/phy/amd79.c b/drivers/net/phy/amd79.c
new file mode 100644
index 0000000..914d696
--- /dev/null
+++ b/drivers/net/phy/amd79.c
@@ -0,0 +1,109 @@
+/*
+ * Driver for AMD am79 PHYs
+ *
+ * Author: Heiko Schocher <hs@denx.de>
+ *
+ * Copyright (c) 2011 DENX Software Engineering GmbH
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <linux/unistd.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/skbuff.h>
+#include <linux/spinlock.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/mii.h>
+#include <linux/ethtool.h>
+#include <linux/phy.h>
+#include <linux/uaccess.h>
+
+#include <asm/irq.h>
+
+#define MII_AMD79_IR		17  /* Interrupt Status/Control Register */
+#define MII_AMD79_IR_EN_LINK	0x0400	/* IR enable Linkstate */
+#define MII_AMD79_IR_ACK_LINK	0x0004	/* IR ack Linkstate */
+
+MODULE_DESCRIPTION("AMD PHY driver");
+MODULE_AUTHOR("Heiko Schocher <hs@denx.de>");
+MODULE_LICENSE("GPL");
+
+static int amd79_ack_interrupt(struct phy_device *phydev)
+{
+	int err;
+
+	err = phy_read(phydev, MII_BMSR);
+	if (err < 0)
+		return err;
+
+	err = phy_read(phydev, MII_AMD79_IR);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static int amd79_config_init(struct phy_device *phydev)
+{
+	int err = 0;
+
+	return err;
+}
+
+static int amd79_config_intr(struct phy_device *phydev)
+{
+	int err;
+
+	if (phydev->interrupts == PHY_INTERRUPT_ENABLED)
+		err = phy_write(phydev, MII_AMD79_IR_EN_LINK,
+			MII_AMD79_IR_EN_LINK);
+	else
+		err = phy_write(phydev, MII_AMD79_IR_EN_LINK, 0);
+
+	return err;
+}
+
+static struct phy_driver amd79_driver = {
+	.phy_id		= 0x0022561b,
+	.name		= "AMD79C874",
+	.phy_id_mask	= 0xfffffff0,
+	.features	= PHY_BASIC_FEATURES,
+	.flags		= PHY_HAS_INTERRUPT,
+	.config_init	= amd79_config_init,
+	.config_aneg	= genphy_config_aneg,
+	.read_status	= genphy_read_status,
+	.ack_interrupt	= amd79_ack_interrupt,
+	.config_intr	= amd79_config_intr,
+	.driver		= { .owner = THIS_MODULE,},
+};
+
+static int __init amd79_init(void)
+{
+	int ret;
+
+	ret = phy_driver_register(&amd79_driver);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void __exit amd79_exit(void)
+{
+	phy_driver_unregister(&amd79_driver);
+}
+
+module_init(amd79_init);
+module_exit(amd79_exit);
-- 
1.7.5.4

Return-Path: <Sergej.Stepanov@ids.de>
Received: from ares.ids.de (ares.ids.de [213.144.29.131])
	by ozlabs.org (Postfix) with ESMTP id 4B2D0DDE00
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Sep 2007 19:25:04 +1000 (EST)
Received: from ares.ids.de (ares.ids.de [127.0.0.1])
	by ares.ids.de (PGP Universal) with ESMTP id 594E2F4919C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Sep 2007 11:25:01 +0200 (CEST)
Subject: [PATCH] adds support for Micrel KS8721BL PHY
From: Sergej Stepanov <Sergej.Stepanov@ids.de>
To: linuxppc-embedded@ozlabs.org
Date: Fri, 14 Sep 2007 11:25:00 +0200
Message-Id: <1189761900.5113.8.camel@p60635-ste.ids.de>
Mime-Version: 1.0
Content-Type: text/plain
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The patch adds the support for Micrel KS8721BL PHY

Signed-off-by: Sergej Stepanov <Sergej.Stepanov@ids.de>
--

diff -ruN linux-2.6.22.1/drivers/net/phy/Kconfig linux-2.6.22.1_ids8247/drivers/net/phy/Kconfig
--- linux-2.6.22.1/drivers/net/phy/Kconfig	2007-07-10 20:56:30.000000000 +0200
+++ linux-2.6.22.1_ids8247/drivers/net/phy/Kconfig	2007-08-02 10:54:34.000000000 +0200
@@ -55,6 +55,11 @@
 	---help---
 	  Currently supports the BCM5411, BCM5421 and BCM5461 PHYs.
 
+config MICREL_PHY
+	tristate "Drivers for MICREL KS8721BL PHYs"
+	---help---
+	  Currently supports on MPC82xx_IDS8247 board.
+
 config FIXED_PHY
 	tristate "Drivers for PHY emulation on fixed speed/link"
 	---help---
diff -ruN linux-2.6.22.1/drivers/net/phy/Makefile linux-2.6.22.1_ids8247/drivers/net/phy/Makefile
--- linux-2.6.22.1/drivers/net/phy/Makefile	2007-07-10 20:56:30.000000000 +0200
+++ linux-2.6.22.1_ids8247/drivers/net/phy/Makefile	2007-08-02 10:54:34.000000000 +0200
@@ -11,4 +11,5 @@
 obj-$(CONFIG_SMSC_PHY)		+= smsc.o
 obj-$(CONFIG_VITESSE_PHY)	+= vitesse.o
 obj-$(CONFIG_BROADCOM_PHY)	+= broadcom.o
+obj-$(CONFIG_MICREL_PHY)	+= micrel.o
 obj-$(CONFIG_FIXED_PHY)		+= fixed.o
diff -ruN linux-2.6.22.1/drivers/net/phy/micrel.c linux-2.6.22.1_ids8247/drivers/net/phy/micrel.c
--- linux-2.6.22.1/drivers/net/phy/micrel.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.22.1_ids8247/drivers/net/phy/micrel.c	2007-08-02 10:54:34.000000000 +0200
@@ -0,0 +1,109 @@
+/*
+ * drivers/net/phy/micrel.c
+ *
+ * Driver for Micrel KS8721BL PHY
+ * based on drivers/net/phy/lxt.c from Andy Fleming
+ *
+ * Author: Sergej Stepanov, IDS GmbH, Germany
+ * Copyright (c) 2007 IDS GmbH, Germany
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <linux/unistd.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
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
+
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/uaccess.h>
+
+
+#define MII_KS8721BL_RXERCR	0x15
+#define MII_KS8721BL_ICSR	0x1B
+#define MII_KS8721BL_PHYCR	0x1F
+
+
+MODULE_DESCRIPTION("Micrel KS8721BL driver");
+MODULE_AUTHOR("Sergej Stepanov");
+MODULE_LICENSE("GPL");
+
+
+static int ks8721bl_config_intr(struct phy_device *phydev)
+{
+  int err1;
+
+	if(phydev->interrupts == PHY_INTERRUPT_ENABLED)
+	{
+	  err1 = phy_write(phydev, MII_KS8721BL_ICSR, 0xFF00);
+	  err1 = phy_write(phydev, 0, 0x1200); /* control register */
+	}
+	else
+		err1 = phy_write(phydev, MII_KS8721BL_ICSR, 0);
+
+	return err1;
+}
+
+static int ks8721bl_config_init(struct phy_device *phydev)
+{
+	phy_write(phydev, MII_KS8721BL_ICSR, 0);
+	return 0;
+}
+
+
+static int ks8721bl_ack_interrupt(struct phy_device *phydev)
+{
+	int err = phy_read(phydev, MII_KS8721BL_ICSR);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static struct phy_driver ks8721bl_driver = {
+	.phy_id		= 0x000221619,
+	.name		= "KS8721BL",
+	.phy_id_mask	= 0xfffffff0,
+	.features	= PHY_BASIC_FEATURES,
+	.flags		= PHY_HAS_INTERRUPT,
+	.config_init	= ks8721bl_config_init,
+	.config_aneg	= genphy_config_aneg,
+	.read_status	= genphy_read_status,
+	.ack_interrupt	= ks8721bl_ack_interrupt,
+	.config_intr	= ks8721bl_config_intr,
+	.driver 	= { .owner = THIS_MODULE,},
+};
+
+static int __init ks8721_init(void)
+{
+	int ret;
+
+	ret = phy_driver_register(&ks8721bl_driver);
+	if (ret)
+		goto err1;
+
+	return 0;
+ err1:
+	return ret;
+}
+
+static void __exit ks8721_exit(void)
+{
+	phy_driver_unregister(&ks8721bl_driver);
+}
+
+module_init(ks8721_init);
+module_exit(ks8721_exit);

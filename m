Return-Path: <shh.xie@gmail.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 799292C0097
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Nov 2013 23:24:34 +1100 (EST)
From: <shh.xie@gmail.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] phylib: Add generic 10G driver
Date: Mon, 11 Nov 2013 19:07:16 +0800
Message-ID: <1384168049-2899-1-git-send-email-shh.xie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shruti@freescale.com, Shaohui Xie <Shaohui.Xie@freescale.com>,
 madalin.bucur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Andy Fleming

Very incomplete, but will allow for binding an ethernet controller
to it.

Also, Add XGMII interface type

Signed-off-by: Andy Fleming
Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
---
 drivers/net/phy/phy_device.c | 101 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/phy.h          |   1 +
 2 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 74630e9..30bf2d5 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -32,6 +32,7 @@
 #include <linux/module.h>
 #include <linux/mii.h>
 #include <linux/ethtool.h>
+#include <linux/mdio.h>
 #include <linux/phy.h>
 
 #include <asm/io.h>
@@ -689,6 +690,13 @@ static int genphy_config_advert(struct phy_device *phydev)
 	return changed;
 }
 
+int gen10g_config_advert(struct phy_device *dev)
+{
+	return 0;
+}
+EXPORT_SYMBOL(gen10g_config_advert);
+
+
 /**
  * genphy_setup_forced - configures/forces speed/duplex from @phydev
  * @phydev: target phy_device struct
@@ -742,6 +750,12 @@ int genphy_restart_aneg(struct phy_device *phydev)
 }
 EXPORT_SYMBOL(genphy_restart_aneg);
 
+int gen10g_restart_aneg(struct phy_device *phydev)
+{
+	return 0;
+}
+EXPORT_SYMBOL(gen10g_restart_aneg);
+
 
 /**
  * genphy_config_aneg - restart auto-negotiation or write BMCR
@@ -784,6 +798,13 @@ int genphy_config_aneg(struct phy_device *phydev)
 }
 EXPORT_SYMBOL(genphy_config_aneg);
 
+int gen10g_config_aneg(struct phy_device *phydev)
+{
+	return 0;
+}
+EXPORT_SYMBOL(gen10g_config_aneg);
+
+
 /**
  * genphy_update_link - update link status in @phydev
  * @phydev: target phy_device struct
@@ -913,6 +934,35 @@ int genphy_read_status(struct phy_device *phydev)
 }
 EXPORT_SYMBOL(genphy_read_status);
 
+int gen10g_read_status(struct phy_device *phydev)
+{
+	int devad, reg;
+	u32 mmd_mask = phydev->c45_ids.devices_in_package;
+
+	phydev->link = 1;
+
+	/* For now just lie and say it's 10G all the time */
+	phydev->speed = 10000;
+	phydev->duplex = DUPLEX_FULL;
+
+	for (devad = 0; mmd_mask; devad++, mmd_mask = mmd_mask >> 1) {
+		if (!(mmd_mask & 1))
+			continue;
+
+		/* Read twice because link state is latched and a
+		 * read moves the current state into the register
+		 */
+		phy_read_mmd(phydev, devad, MDIO_STAT1);
+		reg = phy_read_mmd(phydev, devad, MDIO_STAT1);
+		if (reg < 0 || !(reg & MDIO_STAT1_LSTATUS))
+			phydev->link = 0;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(gen10g_read_status);
+
+
 static int genphy_config_init(struct phy_device *phydev)
 {
 	int val;
@@ -959,6 +1009,15 @@ static int genphy_config_init(struct phy_device *phydev)
 
 	return 0;
 }
+
+static int gen10g_config_init(struct phy_device *phydev)
+{
+	/* Temporarily just say we support everything */
+	phydev->supported = phydev->advertising = SUPPORTED_10000baseT_Full;
+
+	return 0;
+}
+
 int genphy_suspend(struct phy_device *phydev)
 {
 	int value;
@@ -974,6 +1033,13 @@ int genphy_suspend(struct phy_device *phydev)
 }
 EXPORT_SYMBOL(genphy_suspend);
 
+int gen10g_suspend(struct phy_device *phydev)
+{
+	return 0;
+}
+EXPORT_SYMBOL(gen10g_suspend);
+
+
 int genphy_resume(struct phy_device *phydev)
 {
 	int value;
@@ -989,6 +1055,13 @@ int genphy_resume(struct phy_device *phydev)
 }
 EXPORT_SYMBOL(genphy_resume);
 
+int gen10g_resume(struct phy_device *phydev)
+{
+	return 0;
+}
+EXPORT_SYMBOL(gen10g_resume);
+
+
 /**
  * phy_probe - probe and init a PHY device
  * @dev: device to probe and init
@@ -1129,6 +1202,20 @@ static struct phy_driver genphy_driver = {
 	.driver		= {.owner= THIS_MODULE, },
 };
 
+static struct phy_driver gen10g_driver = {
+	.phy_id         = 0xffffffff,
+	.phy_id_mask    = 0xffffffff,
+	.name           = "Generic 10G PHY",
+	.config_init    = gen10g_config_init,
+	.features       = 0,
+	.config_aneg    = gen10g_config_aneg,
+	.read_status    = gen10g_read_status,
+	.suspend        = gen10g_suspend,
+	.resume         = gen10g_resume,
+	.driver         = {.owner = THIS_MODULE, },
+};
+
+
 static int __init phy_init(void)
 {
 	int rc;
@@ -1139,13 +1226,25 @@ static int __init phy_init(void)
 
 	rc = phy_driver_register(&genphy_driver);
 	if (rc)
-		mdio_bus_exit();
+		goto genphy_register_failed;
+
+	rc = phy_driver_register(&gen10g_driver);
+	if (rc)
+		goto gen10g_register_failed;
+
+	return rc;
+
+gen10g_register_failed:
+	phy_driver_unregister(&genphy_driver);
+genphy_register_failed:
+	mdio_bus_exit();
 
 	return rc;
 }
 
 static void __exit phy_exit(void)
 {
+	phy_driver_unregister(&gen10g_driver);
 	phy_driver_unregister(&genphy_driver);
 	mdio_bus_exit();
 }
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 684925a..f864004 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -66,6 +66,7 @@ typedef enum {
 	PHY_INTERFACE_MODE_RGMII_TXID,
 	PHY_INTERFACE_MODE_RTBI,
 	PHY_INTERFACE_MODE_SMII,
+	PHY_INTERFACE_MODE_XGMII,
 } phy_interface_t;
 
 
-- 
1.8.4.1

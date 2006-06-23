Return-Path: <vbordug@ru.mvista.com>
Received: from localhost.localdomain (cdma-41-194.msk.skylink.ru
	[83.217.41.194])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 77F4C67B4D
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jun 2006 09:46:41 +1000 (EST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.6/8.13.6) with ESMTP id k5NNGtZ7006730
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jun 2006 03:16:56 +0400
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH 1/6] PAL: Support of the fixed PHY
Date: Sat, 24 Jun 2006 03:16:55 +0400
Message-Id: <20060623231655.6721.66947.stgit@localhost.localdomain>
In-Reply-To: <20060623231648.6721.3495.stgit@localhost.localdomain>
References: <20060623231648.6721.3495.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This makes it possible for HW PHY-less boards to utilize PAL goodies.
Generic routines to connect to fixed PHY are provided, as well as ability
to specify software callback that fills up link, speed, etc. information
into PHY descriptor (the latter feature not tested so far).

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 drivers/net/phy/Kconfig      |   17 ++++++++++++++
 drivers/net/phy/phy_device.c |   51 +++++++++++++++++++++++++-----------------
 include/linux/phy.h          |    1 +
 3 files changed, 48 insertions(+), 21 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 76e51b1..e977fe1 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -50,5 +50,22 @@ config VITESSE_PHY
         ---help---
           Currently supports the vsc8244
 
+config FIXED_PHY
+	tristate "Drivers for PHY emulation on fixed speed/link"
+	depends on PHYLIB
+	---help---
+	  Adds the driver to PHY layer to cover the boards that do not have any PHY bound,
+	  but with the ability to manipulate with speed/link in software. The relavant MII
+	  speed/duplex parameters could be effectively handled in user-specified  fuction.
+	  Currently tested with mpc866ads.
+
+config FIXED_MII_10_FDX
+	bool "Emulation for 10M Fdx fixed PHY behavior"
+	depends on FIXED_PHY
+
+config FIXED_MII_100_FDX
+	bool "Emulation for 100M Fdx fixed PHY behavior"
+	depends on FIXED_PHY
+
 endmenu
 
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 7da0e3d..dfdafe9 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -46,6 +46,35 @@ static struct phy_driver genphy_driver;
 extern int mdio_bus_init(void);
 extern void mdio_bus_exit(void);
 
+struct phy_device* phy_device_create(struct mii_bus *bus, int addr, int phy_id)
+{
+	struct phy_device *dev;
+	/* We allocate the device, and initialize the
+	 * default values */
+	dev = kcalloc(1, sizeof(*dev), GFP_KERNEL);
+
+	if (NULL == dev)
+		return PTR_ERR(-ENOMEM);
+
+	dev->speed = 0;
+	dev->duplex = -1;
+	dev->pause = dev->asym_pause = 0;
+	dev->link = 1;
+
+	dev->autoneg = AUTONEG_ENABLE;
+
+	dev->addr = addr;
+	dev->phy_id = phy_id;
+	dev->bus = bus;
+
+	dev->state = PHY_DOWN;
+
+	spin_lock_init(&dev->lock);
+
+	return dev;
+}
+EXPORT_SYMBOL(phy_device_create);
+
 /* get_phy_device
  *
  * description: Reads the ID registers of the PHY at addr on the
@@ -78,28 +107,8 @@ struct phy_device * get_phy_device(struc
 	/* If the phy_id is all Fs, there is no device there */
 	if (0xffffffff == phy_id)
 		return NULL;
-
-	/* Otherwise, we allocate the device, and initialize the
-	 * default values */
-	dev = kcalloc(1, sizeof(*dev), GFP_KERNEL);
 
-	if (NULL == dev)
-		return ERR_PTR(-ENOMEM);
-
-	dev->speed = 0;
-	dev->duplex = -1;
-	dev->pause = dev->asym_pause = 0;
-	dev->link = 1;
-
-	dev->autoneg = AUTONEG_ENABLE;
-
-	dev->addr = addr;
-	dev->phy_id = phy_id;
-	dev->bus = bus;
-
-	dev->state = PHY_DOWN;
-
-	spin_lock_init(&dev->lock);
+	dev = phy_device_create(bus, addr, phy_id);
 
 	return dev;
 }
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 331521a..9447a57 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -378,6 +378,7 @@ int phy_mii_ioctl(struct phy_device *phy
 		struct mii_ioctl_data *mii_data, int cmd);
 int phy_start_interrupts(struct phy_device *phydev);
 void phy_print_status(struct phy_device *phydev);
+struct phy_device* phy_device_create(struct mii_bus *bus, int addr, int phy_id);
 
 extern struct bus_type mdio_bus_type;
 #endif /* __PHY_H */

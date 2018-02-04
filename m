Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zZGps3PJ4zF0rJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Feb 2018 03:47:13 +1100 (AEDT)
Subject: PA Semi PWRficient Gigabit Ethernet doesn't work anymore since the
 first networking updates for the kernel 4.16
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <CAHkrCmFCzPd_a1UmyfuZHKM4hXvou0uO0FYoG5bd_fxE8QMueg@mail.gmail.com>
 <DB3PR0402MB3849EEF00D71FF7A230B70C3ECEB0@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <1516035556.18795.71.camel@infinera.com> <20180116143836.GC22903@lunn.ch>
 <1516125454.18795.87.camel@infinera.com>
 <DB3PR0402MB38492999533EB4400DED45BFECE90@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <1516348851.4730.15.camel@infinera.com> <20180119132251.GJ32299@lunn.ch>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <9e8e906d-b2b7-f11c-30ed-ccdf91ac563c@xenosoft.de>
Date: Sun, 4 Feb 2018 17:47:03 +0100
MIME-Version: 1.0
In-Reply-To: <20180119132251.GJ32299@lunn.ch>
Content-Type: multipart/mixed; boundary="------------41AC12B85F34D250F76451DB"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------41AC12B85F34D250F76451DB
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

The PA Semi PWRficient Gigabit Ethernet doesn't work anymore since the 
first networking updates [1] for the kernel 4.16.

Error messages:

[    0.634241] libphy: pasemi gpio mdio bus: probed
[    0.634749] pasemi gpio mdio bus: Cannot register as MDIO bus, err -38
[    2.311496] pasemi_mac 0000:00:14.0: runtime IRQ mapping not provided 
by arch
[    2.311554] pasemi_mac 0000:00:14.1: runtime IRQ mapping not provided 
by arch
[    2.311599] pasemi_mac 0000:00:14.2: runtime IRQ mapping not provided 
by arch
[    2.311641] pasemi_mac 0000:00:14.3: runtime IRQ mapping not provided 
by arch
[    2.312276] pasemi_mac 0000:00:15.0: runtime IRQ mapping not provided 
by arch
[    2.312903] pasemi_mac 0000:00:15.1: runtime IRQ mapping not provided 
by arch
[    3.817420] i2c-pasemi 0000:00:1c.0: runtime IRQ mapping not provided 
by arch
[    3.817616] i2c-pasemi 0000:00:1c.1: runtime IRQ mapping not provided 
by arch
[    3.817809] i2c-pasemi 0000:00:1c.2: runtime IRQ mapping not provided 
by arch
[    4.299984] pasemi_edac 0000:00:04.0: runtime IRQ mapping not 
provided by arch
[    4.300281] pasemi_edac 0000:00:05.0: runtime IRQ mapping not 
provided by arch
[   39.633565] pasemi_mac 0000:00:14.3: PHY init failed: -19.
[   39.633569] pasemi_mac 0000:00:14.3: Defaulting to 1Gbit full duplex

I figured out that the problematic code is in the mdio bus changes of 
the networking updates. [1]

I found the problematic code in the file 'drivers/net/phy/mdio_bus.c'. I 
created a patch which solves the problem with the PA Semi PWRficient 
Gigabit Ethernet. (attached)

Could you please check the changes in the file 'drivers/net/phy/mdio_bus.c'?

Thanks,
Christian

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b2fe5fa68642860e7de76167c3111623aa0d5de1

--------------41AC12B85F34D250F76451DB
Content-Type: text/x-patch;
 name="mdio_bus.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="mdio_bus.patch"

--- a/drivers/net/phy/mdio_bus.c	2018-02-03 17:34:46.973045321 +0100
+++ b/drivers/net/phy/mdio_bus.c	2018-02-04 11:03:14.909093360 +0100
@@ -47,41 +47,11 @@
 
 #include "mdio-boardinfo.h"
 
-static int mdiobus_register_gpiod(struct mdio_device *mdiodev)
-{
-	struct gpio_desc *gpiod = NULL;
-
-	/* Deassert the optional reset signal */
-	if (mdiodev->dev.of_node)
-		gpiod = fwnode_get_named_gpiod(&mdiodev->dev.of_node->fwnode,
-					       "reset-gpios", 0, GPIOD_OUT_LOW,
-					       "PHY reset");
-	if (PTR_ERR(gpiod) == -ENOENT)
-		gpiod = NULL;
-	else if (IS_ERR(gpiod))
-		return PTR_ERR(gpiod);
-
-	mdiodev->reset = gpiod;
-
-	/* Assert the reset signal again */
-	mdio_device_reset(mdiodev, 1);
-
-	return 0;
-}
-
 int mdiobus_register_device(struct mdio_device *mdiodev)
 {
-	int err;
-
 	if (mdiodev->bus->mdio_map[mdiodev->addr])
 		return -EBUSY;
 
-	if (mdiodev->flags & MDIO_DEVICE_FLAG_PHY) {
-		err = mdiobus_register_gpiod(mdiodev);
-		if (err)
-			return err;
-	}
-
 	mdiodev->bus->mdio_map[mdiodev->addr] = mdiodev;
 
 	return 0;

--------------41AC12B85F34D250F76451DB--

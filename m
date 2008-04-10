Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 6DA27DE2A4
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 09:29:32 +1000 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/5] phylib: don't create a phydev for ID-less PHYs.
Date: Thu, 10 Apr 2008 13:51:58 -0400
Message-Id: <4764055962e0a42ce083783bbb897a62090ad90b.1207846542.git.paul.gortmaker@windriver.com>
In-Reply-To: <1207849922-2436-1-git-send-email-paul.gortmaker@windriver.com>
References: <1207849922-2436-1-git-send-email-paul.gortmaker@windriver.com>
Cc: scottwood@freescale.com, linux-net@vger.kernel.org,
	Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I've tested on 8360, 8540 and 8641D and in all cases, the PHY
ID returned for bus addr 0x1f is all zeros, and not all 0xf.
This means we've been allocating a phydev for this "ghost".

In addition to marking 0x0 as an invalid PHY ID, I've also
changed the existing somewhat useless printk to actually
list the bus IDs where it found a PHY so we get a basic
bus summary.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/net/phy/mdio_bus.c   |    4 +++-
 drivers/net/phy/phy_device.c |    5 +++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 963630c..e33a119 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -59,6 +59,7 @@ int mdiobus_register(struct mii_bus *bus)
 	if (bus->reset)
 		bus->reset(bus);
 
+	pr_info("%s: PHY(s) at:", bus->name);
 	for (i = 0; i < PHY_MAX_ADDR; i++) {
 		struct phy_device *phydev;
 
@@ -97,12 +98,13 @@ int mdiobus_register(struct mii_bus *bus)
 				phy_device_free(phydev);
 				phydev = NULL;
 			}
+			printk(" 0x%x", i);
 		}
 
 		bus->phy_map[i] = phydev;
 	}
 
-	pr_info("%s: probed\n", bus->name);
+	printk("\n");
 
 	return err;
 }
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index f4c4fd8..740dd2e 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -116,8 +116,9 @@ struct phy_device * get_phy_device(struct mii_bus *bus, int addr)
 
 	phy_id |= (phy_reg & 0xffff);
 
-	/* If the phy_id is all Fs, there is no device there */
-	if (0xffffffff == phy_id)
+	/* If the phy_id is all Fs, there is no device there. Similarly
+ 	   it seems common to get an ID of zero at addr 0x1f */
+	if (0xffffffff == phy_id || 0 == phy_id)
 		return NULL;
 
 	dev = phy_device_create(bus, addr, phy_id);
-- 
1.5.4.3

Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 29932DE32A
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 09:29:35 +1000 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/5] gianfar: limit scope of gfar_local_mdio functions
Date: Thu, 10 Apr 2008 13:52:00 -0400
Message-Id: <51ed2b5a385f698c6358bc0240abaf5216b82a66.1207846542.git.paul.gortmaker@windriver.com>
In-Reply-To: <d0000263c8e632d0bc29242782cdb2e3158e7e41.1207846542.git.paul.gortmaker@windriver.com>
References: <1207849922-2436-1-git-send-email-paul.gortmaker@windriver.com>
	<4764055962e0a42ce083783bbb897a62090ad90b.1207846542.git.paul.gortmaker@windriver.com>
	<d0000263c8e632d0bc29242782cdb2e3158e7e41.1207846542.git.paul.gortmaker@windriver.com>
In-Reply-To: <4764055962e0a42ce083783bbb897a62090ad90b.1207846542.git.paul.gortmaker@windriver.com>
References: <4764055962e0a42ce083783bbb897a62090ad90b.1207846542.git.paul.gortmaker@windriver.com>
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

The gfar_local_mdio_read/write functions were brought in via
extern since they go right at the regs vs. going via the normal
gfar_mdio_read/write functions.  With the priv->mii_bus properly
set, we can get rid of the externs, the casts etc. and use the
normal gfar_mdio_read/write. We just need to move the call to the
gfar_configure_serdes down slightly to after where priv->mii_bus
is set to a sane value.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/net/gianfar.c     |   17 +++++++----------
 drivers/net/gianfar_mii.c |    4 ++--
 2 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
index 0ad74c1..9173784 100644
--- a/drivers/net/gianfar.c
+++ b/drivers/net/gianfar.c
@@ -130,8 +130,6 @@ static void free_skb_resources(struct gfar_private *priv);
 static void gfar_set_multi(struct net_device *dev);
 static void gfar_set_hash_for_addr(struct net_device *dev, u8 *addr);
 static void gfar_configure_serdes(struct net_device *dev);
-extern int gfar_local_mdio_write(struct gfar_mii __iomem *regs, int mii_id, int regnum, u16 value);
-extern int gfar_local_mdio_read(struct gfar_mii __iomem *regs, int mii_id, int regnum);
 #ifdef CONFIG_GFAR_NAPI
 static int gfar_poll(struct napi_struct *napi, int budget);
 #endif
@@ -459,9 +457,6 @@ static int init_phy(struct net_device *dev)
 
 	phydev = phy_connect(dev, phy_id, &adjust_link, 0, interface);
 
-	if (interface == PHY_INTERFACE_MODE_SGMII)
-		gfar_configure_serdes(dev);
-
 	if (IS_ERR(phydev)) {
 		printk(KERN_ERR "%s: Could not attach to PHY\n", dev->name);
 		return PTR_ERR(phydev);
@@ -474,27 +469,29 @@ static int init_phy(struct net_device *dev)
 	priv->mii_bus = phydev->bus;
 	priv->phydev = phydev;
 
+	if (interface == PHY_INTERFACE_MODE_SGMII)
+		gfar_configure_serdes(dev);
+
 	return 0;
 }
 
 static void gfar_configure_serdes(struct net_device *dev)
 {
 	struct gfar_private *priv = netdev_priv(dev);
-	struct gfar_mii __iomem *regs =
-			(void __iomem *)&priv->regs->gfar_mii_regs;
+	struct mii_bus *bus = priv->mii_bus;
 
 	/* Initialise TBI i/f to communicate with serdes (lynx phy) */
 
 	/* Single clk mode, mii mode off(for aerdes communication) */
-	gfar_local_mdio_write(regs, TBIPA_VALUE, MII_TBICON, TBICON_CLK_SELECT);
+	gfar_mdio_write(bus, TBIPA_VALUE, MII_TBICON, TBICON_CLK_SELECT);
 
 	/* Supported pause and full-duplex, no half-duplex */
-	gfar_local_mdio_write(regs, TBIPA_VALUE, MII_ADVERTISE,
+	gfar_mdio_write(bus, TBIPA_VALUE, MII_ADVERTISE,
 			ADVERTISE_1000XFULL | ADVERTISE_1000XPAUSE |
 			ADVERTISE_1000XPSE_ASYM);
 
 	/* ANEG enable, restart ANEG, full duplex mode, speed[1] set */
-	gfar_local_mdio_write(regs, TBIPA_VALUE, MII_BMCR, BMCR_ANENABLE |
+	gfar_mdio_write(bus, TBIPA_VALUE, MII_BMCR, BMCR_ANENABLE |
 			BMCR_ANRESTART | BMCR_FULLDPLX | BMCR_SPEED1000);
 }
 
diff --git a/drivers/net/gianfar_mii.c b/drivers/net/gianfar_mii.c
index 2432762..d5efa9c 100644
--- a/drivers/net/gianfar_mii.c
+++ b/drivers/net/gianfar_mii.c
@@ -51,7 +51,7 @@
  * the local mdio pins, which may not be the same as system mdio bus, used for
  * controlling the external PHYs, for example.
  */
-int gfar_local_mdio_write(struct gfar_mii __iomem *regs, int mii_id,
+static int gfar_local_mdio_write(struct gfar_mii __iomem *regs, int mii_id,
 			  int regnum, u16 value)
 {
 	/* Set the PHY address and the register address we want to write */
@@ -77,7 +77,7 @@ int gfar_local_mdio_write(struct gfar_mii __iomem *regs, int mii_id,
  * and are always tied to the local mdio pins, which may not be the
  * same as system mdio bus, used for controlling the external PHYs, for eg.
  */
-int gfar_local_mdio_read(struct gfar_mii __iomem *regs, int mii_id, int regnum)
+static int gfar_local_mdio_read(struct gfar_mii __iomem *regs, int mii_id, int regnum)
 
 {
 	u16 value;
-- 
1.5.4.3

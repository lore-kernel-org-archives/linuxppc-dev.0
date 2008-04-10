Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id D988DDE43E
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 09:29:40 +1000 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/5] gianfar: don't hard code the TBIPA MDIO address
Date: Thu, 10 Apr 2008 13:52:02 -0400
Message-Id: <20a0d9a5325368348faa3dcc831da4c24ed4397d.1207846542.git.paul.gortmaker@windriver.com>
In-Reply-To: <9a0d21c220e831ce5673f150ebc8df78b083ab5b.1207846542.git.paul.gortmaker@windriver.com>
References: <1207849922-2436-1-git-send-email-paul.gortmaker@windriver.com>
	<4764055962e0a42ce083783bbb897a62090ad90b.1207846542.git.paul.gortmaker@windriver.com>
	<d0000263c8e632d0bc29242782cdb2e3158e7e41.1207846542.git.paul.gortmaker@windriver.com>
	<51ed2b5a385f698c6358bc0240abaf5216b82a66.1207846542.git.paul.gortmaker@windriver.com>
	<9a0d21c220e831ce5673f150ebc8df78b083ab5b.1207846542.git.paul.gortmaker@windriver.com>
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

Currently the MDIO address for the gianfar Ten Bit
Interface is hard coded to be 0x1f, which can conflit
with some boards if they happen to put a PHY there.

Previous discussions indicated that the proper approach
here would be to dynamically allocate it, based on
picking the highest MDIO address that is not in use
by a PHY.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/net/gianfar.c       |   20 ++++++++++++++++----
 drivers/net/gianfar.h       |    1 -
 drivers/net/gianfar_mii.c   |   11 ++++++++++-
 include/linux/fsl_devices.h |    1 +
 4 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
index 9173784..684c97b 100644
--- a/drivers/net/gianfar.c
+++ b/drivers/net/gianfar.c
@@ -123,6 +123,7 @@ static irqreturn_t gfar_transmit(int irq, void *dev_id);
 static irqreturn_t gfar_interrupt(int irq, void *dev_id);
 static void adjust_link(struct net_device *dev);
 static void init_registers(struct net_device *dev);
+static void gfar_set_tbipa(struct net_device *dev);
 static int init_phy(struct net_device *dev);
 static int gfar_probe(struct platform_device *pdev);
 static int gfar_remove(struct platform_device *pdev);
@@ -469,6 +470,8 @@ static int init_phy(struct net_device *dev)
 	priv->mii_bus = phydev->bus;
 	priv->phydev = phydev;
 
+	gfar_set_tbipa(dev);
+
 	if (interface == PHY_INTERFACE_MODE_SGMII)
 		gfar_configure_serdes(dev);
 
@@ -479,19 +482,20 @@ static void gfar_configure_serdes(struct net_device *dev)
 {
 	struct gfar_private *priv = netdev_priv(dev);
 	struct mii_bus *bus = priv->mii_bus;
+	struct gianfar_mdio_data *mdata = (struct gianfar_mdio_data *)bus->priv;
 
 	/* Initialise TBI i/f to communicate with serdes (lynx phy) */
 
 	/* Single clk mode, mii mode off(for aerdes communication) */
-	gfar_mdio_write(bus, TBIPA_VALUE, MII_TBICON, TBICON_CLK_SELECT);
+	gfar_mdio_write(bus, mdata->tbi_pa, MII_TBICON, TBICON_CLK_SELECT);
 
 	/* Supported pause and full-duplex, no half-duplex */
-	gfar_mdio_write(bus, TBIPA_VALUE, MII_ADVERTISE,
+	gfar_mdio_write(bus, mdata->tbi_pa, MII_ADVERTISE,
 			ADVERTISE_1000XFULL | ADVERTISE_1000XPAUSE |
 			ADVERTISE_1000XPSE_ASYM);
 
 	/* ANEG enable, restart ANEG, full duplex mode, speed[1] set */
-	gfar_mdio_write(bus, TBIPA_VALUE, MII_BMCR, BMCR_ANENABLE |
+	gfar_mdio_write(bus, mdata->tbi_pa, MII_BMCR, BMCR_ANENABLE |
 			BMCR_ANRESTART | BMCR_FULLDPLX | BMCR_SPEED1000);
 }
 
@@ -539,8 +543,16 @@ static void init_registers(struct net_device *dev)
 	/* Initialize the Minimum Frame Length Register */
 	gfar_write(&priv->regs->minflr, MINFLR_INIT_SETTINGS);
 
+}
+
+static void gfar_set_tbipa(struct net_device *dev)
+{
+	struct gfar_private *priv = netdev_priv(dev);
+	struct mii_bus *bus = priv->mii_bus;
+	struct gianfar_mdio_data *mdata = (struct gianfar_mdio_data *)bus->priv;
+
 	/* Assign the TBI an address which won't conflict with the PHYs */
-	gfar_write(&priv->regs->tbipa, TBIPA_VALUE);
+	gfar_write(&priv->regs->tbipa, mdata->tbi_pa);
 }
 
 
diff --git a/drivers/net/gianfar.h b/drivers/net/gianfar.h
index 46cd773..771aa5e 100644
--- a/drivers/net/gianfar.h
+++ b/drivers/net/gianfar.h
@@ -130,7 +130,6 @@ extern const char gfar_driver_version[];
 #define DEFAULT_RXCOUNT	16
 #define DEFAULT_RXTIME	4
 
-#define TBIPA_VALUE		0x1f
 #define MIIMCFG_INIT_VALUE	0x00000007
 #define MIIMCFG_RESET           0x80000000
 #define MIIMIND_BUSY            0x00000001
diff --git a/drivers/net/gianfar_mii.c b/drivers/net/gianfar_mii.c
index 806df3f..41ff8c4 100644
--- a/drivers/net/gianfar_mii.c
+++ b/drivers/net/gianfar_mii.c
@@ -160,7 +160,7 @@ int gfar_mdio_probe(struct device *dev)
 	struct gfar_mii __iomem *regs;
 	struct mii_bus *new_bus;
 	struct resource *r;
-	int err = 0;
+	int i, err = 0;
 
 	if (NULL == dev)
 		return -EINVAL;
@@ -209,6 +209,15 @@ int gfar_mdio_probe(struct device *dev)
 		goto bus_register_fail;
 	}
 
+	/* mdiobus_register has populated the phy_map, so we now know
+ 	   which doghouses have wild dogs living in them.  Search
+	   backwards for the 1st vacant one for the Ten Bit Interface */
+	for (i = PHY_MAX_ADDR - 1; i >= 0; i--)
+		if (new_bus->phy_map[i] == NULL) break;
+
+	printk(KERN_INFO "Gianfar MDIO: using ID 0x%x for TBIPA\n", i);
+	pdata->tbi_pa = i;
+
 	return 0;
 
 bus_register_fail:
diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
index 4b304b6..285bd80 100644
--- a/include/linux/fsl_devices.h
+++ b/include/linux/fsl_devices.h
@@ -60,6 +60,7 @@ struct gianfar_mdio_data {
 	/* board specific information */
 	struct	gfar_mii __iomem *regs;
 	int	irq[32];
+	int	tbi_pa;
 };
 
 /* Flags related to gianfar device features */
-- 
1.5.4.3

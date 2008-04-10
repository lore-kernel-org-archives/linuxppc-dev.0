Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id A815ADE2CD
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 09:29:34 +1000 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/5] gianfar: dont hog the mii_bus->priv with just the regs.
Date: Thu, 10 Apr 2008 13:52:01 -0400
Message-Id: <9a0d21c220e831ce5673f150ebc8df78b083ab5b.1207846542.git.paul.gortmaker@windriver.com>
In-Reply-To: <51ed2b5a385f698c6358bc0240abaf5216b82a66.1207846542.git.paul.gortmaker@windriver.com>
References: <1207849922-2436-1-git-send-email-paul.gortmaker@windriver.com>
	<4764055962e0a42ce083783bbb897a62090ad90b.1207846542.git.paul.gortmaker@windriver.com>
	<d0000263c8e632d0bc29242782cdb2e3158e7e41.1207846542.git.paul.gortmaker@windriver.com>
	<51ed2b5a385f698c6358bc0240abaf5216b82a66.1207846542.git.paul.gortmaker@windriver.com>
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

The gfar was previously using the mii_bus->priv to directly
store the gfar_mii regs, which leaves no room/flexibility to
store anything else there.  I believe it makes more sense to
have mii_bus->priv point at a struct gianfar_mdio_data and
then have the regs stored as a field within that.  It makes
the code easier to read too.

This isn't in a hot path, so there should be no performance
penalty associated with this.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/net/gianfar_mii.c   |   17 ++++++++++-------
 include/linux/fsl_devices.h |    1 +
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/gianfar_mii.c b/drivers/net/gianfar_mii.c
index d5efa9c..806df3f 100644
--- a/drivers/net/gianfar_mii.c
+++ b/drivers/net/gianfar_mii.c
@@ -104,10 +104,10 @@ static int gfar_local_mdio_read(struct gfar_mii __iomem *regs, int mii_id, int r
  * All PHY configuration is done through the TSEC1 MIIM regs */
 int gfar_mdio_write(struct mii_bus *bus, int mii_id, int regnum, u16 value)
 {
-	struct gfar_mii __iomem *regs = (void __iomem *)bus->priv;
+	struct gianfar_mdio_data *mdata = (struct gianfar_mdio_data *)bus->priv;
 
 	/* Write to the local MII regs */
-	return(gfar_local_mdio_write(regs, mii_id, regnum, value));
+	return(gfar_local_mdio_write(mdata->regs, mii_id, regnum, value));
 }
 
 /* Read the bus for PHY at addr mii_id, register regnum, and
@@ -115,16 +115,17 @@ int gfar_mdio_write(struct mii_bus *bus, int mii_id, int regnum, u16 value)
  * configuration has to be done through the TSEC1 MIIM regs */
 int gfar_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
 {
-	struct gfar_mii __iomem *regs = (void __iomem *)bus->priv;
+	struct gianfar_mdio_data *mdata = (struct gianfar_mdio_data *)bus->priv;
 
 	/* Read the local MII regs */
-	return(gfar_local_mdio_read(regs, mii_id, regnum));
+	return(gfar_local_mdio_read(mdata->regs, mii_id, regnum));
 }
 
 /* Reset the MIIM registers, and wait for the bus to free */
 int gfar_mdio_reset(struct mii_bus *bus)
 {
-	struct gfar_mii __iomem *regs = (void __iomem *)bus->priv;
+	struct gianfar_mdio_data *mdata = (struct gianfar_mdio_data *)bus->priv;
+	struct gfar_mii __iomem *regs = mdata->regs;
 	unsigned int timeout = PHY_INIT_TIMEOUT;
 
 	mutex_lock(&bus->mdio_lock);
@@ -192,7 +193,8 @@ int gfar_mdio_probe(struct device *dev)
 		goto reg_map_fail;
 	}
 
-	new_bus->priv = (void __force *)regs;
+	new_bus->priv = pdata;
+	pdata->regs = (void __force *)regs;
 
 	new_bus->irq = pdata->irq;
 
@@ -221,12 +223,13 @@ reg_map_fail:
 int gfar_mdio_remove(struct device *dev)
 {
 	struct mii_bus *bus = dev_get_drvdata(dev);
+	struct gianfar_mdio_data *mdata = (struct gianfar_mdio_data *)bus->priv;
 
 	mdiobus_unregister(bus);
 
 	dev_set_drvdata(dev, NULL);
 
-	iounmap((void __iomem *)bus->priv);
+	iounmap(mdata->regs);
 	bus->priv = NULL;
 	kfree(bus);
 
diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
index 1831b19..4b304b6 100644
--- a/include/linux/fsl_devices.h
+++ b/include/linux/fsl_devices.h
@@ -58,6 +58,7 @@ struct gianfar_platform_data {
 
 struct gianfar_mdio_data {
 	/* board specific information */
+	struct	gfar_mii __iomem *regs;
 	int	irq[32];
 };
 
-- 
1.5.4.3

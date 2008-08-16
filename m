Return-Path: <w.sang@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id B3D3FDDEFB
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Aug 2008 12:41:02 +1000 (EST)
Message-Id: <20080816024055.241009929@pengutronix.de>
References: <20080816023159.126377505@pengutronix.de>
Date: Sat, 16 Aug 2008 04:32:00 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: linuxppc-embedded@ozlabs.org
Subject: [patch 1/2] FEC_MPC52XX_PHY: Remove obsolete code
Cc: Wolfram Sang <w.sang@pengutronix.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Remove last remains of the former (and broken) irq support code. The
driver is polling only.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/net/fec_mpc52xx_phy.c |   20 --------------------
 1 file changed, 20 deletions(-)

Index: .kernel/drivers/net/fec_mpc52xx_phy.c
===================================================================
--- .kernel.orig/drivers/net/fec_mpc52xx_phy.c
+++ .kernel/drivers/net/fec_mpc52xx_phy.c
@@ -76,7 +76,6 @@
 {
 	struct device *dev = &of->dev;
 	struct device_node *np = of->node;
-	struct device_node *child = NULL;
 	struct mii_bus *bus;
 	struct mpc52xx_fec_mdio_priv *priv;
 	struct resource res = {};
@@ -105,15 +104,6 @@
 	for (i=0; i<PHY_MAX_ADDR; i++)
 		bus->irq[i] = PHY_POLL;
 
-	while ((child = of_get_next_child(np, child)) != NULL) {
-		int irq = irq_of_parse_and_map(child, 0);
-		if (irq != NO_IRQ) {
-			const u32 *id = of_get_property(child, "reg", NULL);
-			if (id)
-				bus->irq[*id] = irq;
-		}
-	}
-
 	/* setup registers */
 	err = of_address_to_resource(np, 0, &res);
 	if (err)
@@ -133,9 +123,6 @@
 	/* set MII speed */
 	out_be32(&priv->regs->mii_speed, ((mpc52xx_find_ipb_freq(of->node) >> 20) / 5) << 1);
 
-	/* enable MII interrupt */
-	out_be32(&priv->regs->imask, in_be32(&priv->regs->imask) | FEC_IMASK_MII);
-
 	err = mdiobus_register(bus);
 	if (err)
 		goto out_unmap;
@@ -145,9 +132,6 @@
  out_unmap:
 	iounmap(priv->regs);
  out_free:
-	for (i=0; i<PHY_MAX_ADDR; i++)
-		if (bus->irq[i] != PHY_POLL)
-			irq_dispose_mapping(bus->irq[i]);
 	kfree(bus->irq);
 	kfree(priv);
 	kfree(bus);
@@ -160,15 +144,11 @@
 	struct device *dev = &of->dev;
 	struct mii_bus *bus = dev_get_drvdata(dev);
 	struct mpc52xx_fec_mdio_priv *priv = bus->priv;
-	int i;
 
 	mdiobus_unregister(bus);
 	dev_set_drvdata(dev, NULL);
 
 	iounmap(priv->regs);
-	for (i=0; i<PHY_MAX_ADDR; i++)
-		if (bus->irq[i])
-			irq_dispose_mapping(bus->irq[i]);
 	kfree(priv);
 	kfree(bus->irq);
 	kfree(bus);

-- 
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

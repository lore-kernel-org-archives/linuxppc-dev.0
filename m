Return-Path: <w.sang@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id BB48EDDF0C
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Aug 2008 12:41:02 +1000 (EST)
Message-Id: <20080816024055.390926728@pengutronix.de>
References: <20080816023159.126377505@pengutronix.de>
Date: Sat, 16 Aug 2008 04:32:01 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: linuxppc-embedded@ozlabs.org
Subject: [patch 2/2] FEC_MPC52XX_PHY: Refactor read/write routines
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

Read & write functions now call a generic transfer function, so identical
code in both routines could be eliminated. The result is easier to maintain
and smaller in source and binary code. Also, fix some checkpatch warnings.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/net/fec_mpc52xx_phy.c |   55 ++++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 33 deletions(-)

Index: .kernel/drivers/net/fec_mpc52xx_phy.c
===================================================================
--- .kernel.orig/drivers/net/fec_mpc52xx_phy.c
+++ .kernel/drivers/net/fec_mpc52xx_phy.c
@@ -2,6 +2,7 @@
  * Driver for the MPC5200 Fast Ethernet Controller - MDIO bus driver
  *
  * Copyright (C) 2007  Domen Puncer, Telargo, Inc.
+ * Copyright (C) 2008  Wolfram Sang, Pengutronix
  *
  * This file is licensed under the terms of the GNU General Public License
  * version 2. This program is licensed "as is" without any warranty of any
@@ -21,58 +22,45 @@
 	struct mpc52xx_fec __iomem *regs;
 };
 
-static int mpc52xx_fec_mdio_read(struct mii_bus *bus, int phy_id, int reg)
+static int mpc52xx_fec_mdio_transfer(struct mii_bus *bus, int phy_id,
+		int reg, u32 value)
 {
 	struct mpc52xx_fec_mdio_priv *priv = bus->priv;
 	struct mpc52xx_fec __iomem *fec;
 	int tries = 100;
-	u32 request = FEC_MII_READ_FRAME;
+
+	value |= (phy_id << FEC_MII_DATA_PA_SHIFT) & FEC_MII_DATA_PA_MSK;
+	value |= (reg << FEC_MII_DATA_RA_SHIFT) & FEC_MII_DATA_RA_MSK;
 
 	fec = priv->regs;
 	out_be32(&fec->ievent, FEC_IEVENT_MII);
-
-	request |= (phy_id << FEC_MII_DATA_PA_SHIFT) & FEC_MII_DATA_PA_MSK;
-	request |= (reg << FEC_MII_DATA_RA_SHIFT) & FEC_MII_DATA_RA_MSK;
-
-	out_be32(&priv->regs->mii_data, request);
+	out_be32(&priv->regs->mii_data, value);
 
 	/* wait for it to finish, this takes about 23 us on lite5200b */
 	while (!(in_be32(&fec->ievent) & FEC_IEVENT_MII) && --tries)
 		udelay(5);
 
-	if (tries == 0)
+	if (!tries)
 		return -ETIMEDOUT;
 
-	return in_be32(&priv->regs->mii_data) & FEC_MII_DATA_DATAMSK;
+	return value & FEC_MII_DATA_OP_RD ?
+		in_be32(&priv->regs->mii_data) & FEC_MII_DATA_DATAMSK : 0;
 }
 
-static int mpc52xx_fec_mdio_write(struct mii_bus *bus, int phy_id, int reg, u16 data)
+static int mpc52xx_fec_mdio_read(struct mii_bus *bus, int phy_id, int reg)
 {
-	struct mpc52xx_fec_mdio_priv *priv = bus->priv;
-	struct mpc52xx_fec __iomem *fec;
-	u32 value = data;
-	int tries = 100;
-
-	fec = priv->regs;
-	out_be32(&fec->ievent, FEC_IEVENT_MII);
-
-	value |= FEC_MII_WRITE_FRAME;
-	value |= (phy_id << FEC_MII_DATA_PA_SHIFT) & FEC_MII_DATA_PA_MSK;
-	value |= (reg << FEC_MII_DATA_RA_SHIFT) & FEC_MII_DATA_RA_MSK;
-
-	out_be32(&priv->regs->mii_data, value);
-
-	/* wait for request to finish */
-	while (!(in_be32(&fec->ievent) & FEC_IEVENT_MII) && --tries)
-		udelay(5);
-
-	if (tries == 0)
-		return -ETIMEDOUT;
+	return mpc52xx_fec_mdio_transfer(bus, phy_id, reg, FEC_MII_READ_FRAME);
+}
 
-	return 0;
+static int mpc52xx_fec_mdio_write(struct mii_bus *bus, int phy_id, int reg,
+		u16 data)
+{
+	return mpc52xx_fec_mdio_transfer(bus, phy_id, reg,
+		data | FEC_MII_WRITE_FRAME);
 }
 
-static int mpc52xx_fec_mdio_probe(struct of_device *of, const struct of_device_id *match)
+static int mpc52xx_fec_mdio_probe(struct of_device *of,
+		const struct of_device_id *match)
 {
 	struct device *dev = &of->dev;
 	struct device_node *np = of->node;
@@ -121,7 +109,8 @@
 	dev_set_drvdata(dev, bus);
 
 	/* set MII speed */
-	out_be32(&priv->regs->mii_speed, ((mpc52xx_find_ipb_freq(of->node) >> 20) / 5) << 1);
+	out_be32(&priv->regs->mii_speed,
+		((mpc52xx_find_ipb_freq(of->node) >> 20) / 5) << 1);
 
 	err = mdiobus_register(bus);
 	if (err)

-- 
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

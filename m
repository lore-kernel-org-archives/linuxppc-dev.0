Return-Path: <wd@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 936BBB7087
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jul 2009 07:42:30 +1000 (EST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id D2156DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Jul 2009 07:42:29 +1000 (EST)
From: Wolfgang Denk <wd@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2 v2] MPC52xx FEC: be more conservative when setting
	MII_SPEED register
Date: Thu, 16 Jul 2009 23:42:26 +0200
Message-Id: <1247780546-4426-2-git-send-email-wd@denx.de>
In-Reply-To: <1247671133-12148-1-git-send-email-wd@denx.de>
References: <1247671133-12148-1-git-send-email-wd@denx.de>
Cc: netdev@vger.kernel.org, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds error checking and prevents clobbering unrelated bits
(reserved bits or the DIS_PREAMBLE bit) when writing the MII_SPEED
register on MPC52xx systems.

Signed-off-by: Wolfgang Denk <wd@denx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: <netdev@vger.kernel.org>
---
 drivers/net/fec_mpc52xx.c     |    2 +-
 drivers/net/fec_mpc52xx_phy.c |   21 ++++++++++++++++++---
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/net/fec_mpc52xx.c b/drivers/net/fec_mpc52xx.c
index cc78633..b69d440 100644
--- a/drivers/net/fec_mpc52xx.c
+++ b/drivers/net/fec_mpc52xx.c
@@ -639,7 +639,7 @@ static void mpc52xx_fec_hw_init(struct net_device *dev)
 	/* set phy speed.
 	 * this can't be done in phy driver, since it needs to be called
 	 * before fec stuff (even on resume) */
-	out_be32(&fec->mii_speed, priv->mdio_speed);
+	clrsetbits_be32(&fec->mii_speed, 0x7E, priv->mdio_speed);
 }
 
 /**
diff --git a/drivers/net/fec_mpc52xx_phy.c b/drivers/net/fec_mpc52xx_phy.c
index 31e6d62..4c33dc5 100644
--- a/drivers/net/fec_mpc52xx_phy.c
+++ b/drivers/net/fec_mpc52xx_phy.c
@@ -70,7 +70,7 @@ static int mpc52xx_fec_mdio_probe(struct of_device *of,
 	struct mpc52xx_fec_mdio_priv *priv;
 	struct resource res = {};
 	int err;
-	int i;
+	int i, clock, speed;
 
 	bus = mdiobus_alloc();
 	if (bus == NULL)
@@ -105,8 +105,23 @@ static int mpc52xx_fec_mdio_probe(struct of_device *of,
 	dev_set_drvdata(dev, bus);
 
 	/* set MII speed */
-	out_be32(&priv->regs->mii_speed,
-		((mpc5xxx_get_bus_frequency(of->node) >> 20) / 5) << 1);
+	clock = mpc5xxx_get_bus_frequency(of->node);
+	if (!clock) {
+		dev_err(&of->dev, "could not determine IPS/IPB clock\n");
+		goto out_unmap;
+	}
+
+	/* scale for a MII clock <= 2.5 MHz */
+	speed = (clock + 2499999) / 2500000;
+
+	/* only 6 bits (25:30) available for MII speed */
+	if (speed > 0x3F) {
+		speed = 0x3F;
+		dev_err(&of->dev, "MII clock (%d Hz) exceeds max (2.5 MHz)\n",
+			clock / speed);
+	}
+
+	clrsetbits_be32(&priv->regs->mii_speed, 0x7E, speed << 1);
 
 	err = of_mdiobus_register(bus, np);
 	if (err)
-- 
1.6.0.6

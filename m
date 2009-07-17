Return-Path: <wd@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 497A7B7085
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jul 2009 22:27:12 +1000 (EST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 85A4CDDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Jul 2009 22:27:11 +1000 (EST)
From: Wolfgang Denk <wd@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2 v3] MPC52xx FEC: be more conservative when setting
	MII_SPEED register
Date: Fri, 17 Jul 2009 14:27:08 +0200
Message-Id: <1247833628-15952-2-git-send-email-wd@denx.de>
In-Reply-To: <1247780546-4426-1-git-send-email-wd@denx.de>
References: <1247780546-4426-1-git-send-email-wd@denx.de>
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
v3: - use maximum divider in case MPC512x IPS clock is unknown

 drivers/net/fec_mpc52xx.c     |    2 +-
 drivers/net/fec_mpc52xx_phy.c |   23 ++++++++++++++++++++---
 2 files changed, 21 insertions(+), 4 deletions(-)

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
index 31e6d62..d3537e1 100644
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
@@ -105,8 +105,25 @@ static int mpc52xx_fec_mdio_probe(struct of_device *of,
 	dev_set_drvdata(dev, bus);
 
 	/* set MII speed */
-	out_be32(&priv->regs->mii_speed,
-		((mpc5xxx_get_bus_frequency(of->node) >> 20) / 5) << 1);
+	clock = mpc5xxx_get_bus_frequency(of->node);
+	if (!clock) {
+		/* Use maximum divider if clock is unknown */
+		dev_err(&of->dev, "could not determine IPB clock\n");
+		clock = 0x3F * 5000000;
+	}
+
+	/*
+	 * Scale for a MII clock <= 2.5 MHz
+	 * Note that only 6 bits (25:30) are available for MII speed.
+	 */
+	speed = (clock + 4999999) / 5000000;
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

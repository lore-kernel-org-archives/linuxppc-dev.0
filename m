Return-Path: <g.jaeger@sysgo.com>
Received: from mailgate.sysgo.de (ns.sysgo.de [213.68.67.98])
	by ozlabs.org (Postfix) with ESMTP id F223E2BDA0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Oct 2004 19:10:03 +1000 (EST)
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: linuxppc-embedded@ozlabs.org
References: <41777D14.7090108@primagraphics.com>
	<20041021175208.GC6234@gate.ebshome.net>
	<20041021113924.A28106@home.com>
In-Reply-To: <20041021113924.A28106@home.com>
MIME-Version: 1.0
Date: Fri, 22 Oct 2004 11:09:59 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410221109.59563.g.jaeger@sysgo.com>
Cc: 
Subject: [PATCH][PPC32] IBM-EMAC fixes
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This patch fixes problems with a Gigabit PHY being connected via GMII
interface. It seems, that the RGMII port needs to be setup again after
the EMAC has been reset. It causes also some troubles to enable RX & TX
without having a link. Tested on PPC440GP, GX and PPC405 boards.

Signed-off-by: Gerhard Jaeger <gjaeger@sysgo.com>

--- linux-ppc-2.6.9/drivers/net/ibm_emac/ibm_emac_core.c.orig	2004-10-18 23:53:06.000000000 +0200
+++ linux-ppc-2.6.9/drivers/net/ibm_emac/ibm_emac_core.c		2004-10-22 08:43:12.000000000 +0200
@@ -476,7 +476,7 @@ void emac_phy_write(struct net_device *d
 	out_be32(&emacp->em0stacr, stacr);
 
 	while (((stacr = in_be32(&emacp->em0stacr) & EMAC_STACR_OC) == 0)
-					&& (count++ < 5000))
+					&& (count++ < MDIO_DELAY))
 		udelay(1);
 	MDIO_DEBUG((" (count was %d)\n", count));
 
@@ -1018,31 +1018,49 @@ static int emac_start_xmit(struct sk_buf
 	return 0;
 }
 
+static int emac_set_mii_devs(struct ocp_enet_private *fep )
+{
+	/* set speed (default is 10Mb) */
+	switch (fep->phy_mii.speed) {
+	case SPEED_1000:
+		if (fep->rgmii_dev)
+			emac_rgmii_port_speed(fep->rgmii_dev, fep->rgmii_input,
+					      1000);
+		break;
+	case SPEED_100:
+		if (fep->rgmii_dev)
+			emac_rgmii_port_speed(fep->rgmii_dev, fep->rgmii_input,
+					      100);
+		if (fep->zmii_dev)
+			emac_zmii_port_speed(fep->zmii_dev, fep->zmii_input,
+					     100);
+		break;
+	case SPEED_10:
+	default:
+		if (fep->rgmii_dev)
+			emac_rgmii_port_speed(fep->rgmii_dev, fep->rgmii_input,
+					      10);
+		if (fep->zmii_dev)
+			emac_zmii_port_speed(fep->zmii_dev, fep->zmii_input,
+					     10);
+	}
+	return 0;
+}
+
 static int emac_adjust_to_link(struct ocp_enet_private *fep)
 {
 	emac_t *emacp = fep->emacp;
 	struct ibm_ocp_rgmii *rgmii;
 	unsigned long mode_reg;
-	int full_duplex, speed;
-
-	full_duplex = 0;
-	speed = SPEED_10;
 
 	/* set mode register 1 defaults */
 	mode_reg = EMAC_M1_DEFAULT;
 
-	/* Read link mode on PHY */
-	if (fep->phy_mii.def->ops->read_link(&fep->phy_mii) == 0) {
-		/* If an error occurred, we don't deal with it yet */
-		full_duplex = (fep->phy_mii.duplex == DUPLEX_FULL);
-		speed = fep->phy_mii.speed;
-	}
-
 	if (fep->rgmii_dev)
 		rgmii = RGMII_PRIV(fep->rgmii_dev);
 
 	/* set speed (default is 10Mb) */
-	switch (speed) {
+	switch (fep->phy_mii.speed) {
 	case SPEED_1000:
 		mode_reg |= EMAC_M1_JUMBO_ENABLE | EMAC_M1_RFS_16K;
 		if ((rgmii->mode[fep->rgmii_input] == RTBI)
@@ -1050,40 +1068,28 @@ static int emac_adjust_to_link(struct oc
 			mode_reg |= EMAC_M1_MF_1000GPCS;
 		else
 			mode_reg |= EMAC_M1_MF_1000MBPS;
-		if (fep->rgmii_dev)
-			emac_rgmii_port_speed(fep->rgmii_dev, fep->rgmii_input,
-					      1000);
 		break;
 	case SPEED_100:
 		mode_reg |= EMAC_M1_MF_100MBPS | EMAC_M1_RFS_4K;
-		if (fep->rgmii_dev)
-			emac_rgmii_port_speed(fep->rgmii_dev, fep->rgmii_input,
-					      100);
-		if (fep->zmii_dev)
-			emac_zmii_port_speed(fep->zmii_dev, fep->zmii_input,
-					     100);
 		break;
 	case SPEED_10:
 	default:
 		mode_reg = (mode_reg & ~EMAC_M1_MF_100MBPS) | EMAC_M1_RFS_4K;
-		if (fep->rgmii_dev)
-			emac_rgmii_port_speed(fep->rgmii_dev, fep->rgmii_input,
-					      10);
-		if (fep->zmii_dev)
-			emac_zmii_port_speed(fep->zmii_dev, fep->zmii_input,
-					     10);
 	}
 
-	if (full_duplex)
+	if (fep->phy_mii.duplex == DUPLEX_FULL)
 		mode_reg |= EMAC_M1_FDE | EMAC_M1_EIFC | EMAC_M1_IST;
 	else
 		mode_reg &= ~(EMAC_M1_FDE | EMAC_M1_EIFC | EMAC_M1_ILE);
 
 	LINK_DEBUG(("%s: adjust to link, speed: %d, duplex: %d, opened: %d\n",
-		    fep->ndev->name, speed, full_duplex, fep->opened));
+		    fep->ndev->name, fep->phy_mii.speed,
+		    fep->phy_mii.full_duplex, fep->opened));
 
 	printk(KERN_INFO "%s: Speed: %d, %s duplex.\n",
-	       fep->ndev->name, speed, full_duplex ? "Full" : "Half");
+	       fep->ndev->name, fep->phy_mii.speed,
+	       (fep->phy_mii.duplex == DUPLEX_FULL) ? "Full" : "Half");
+
 	if (fep->opened)
 		out_be32(&emacp->em0mr1, mode_reg);
 
@@ -1311,18 +1317,26 @@ static void emac_reset_configure(struct 
 	 * soft reset without a PHY clock present.
 	 */
 	if (fep->phy_mii.def->ops->poll_link(&fep->phy_mii)) {
+
+		/* Read link mode on PHY */
+		fep->phy_mii.def->ops->read_link(&fep->phy_mii);
+
 		/* Reset the EMAC */
 		out_be32(&emacp->em0mr0, EMAC_M0_SRST);
-		udelay(20);
+
+		/* it seems, that this is necessary for some configs
+		 * to come out of the reset
+		 */
+		emac_set_mii_devs( fep );
+
 		for (i = 0; i < 100; i++) {
 			if ((in_be32(&emacp->em0mr0) & EMAC_M0_SRST) == 0)
 				break;
 			udelay(10);
 		}
-
 		if (i >= 100) {
-			printk(KERN_ERR "%s: Cannot reset EMAC\n",
-			       fep->ndev->name);
+			printk(KERN_ERR "%s: Cannot reset EMAC (0x%08x)\n",
+			       fep->ndev->name, in_be32(&emacp->em0mr0));
 			return;
 		}
 	}
@@ -1583,14 +1597,17 @@ static struct ethtool_ops emac_ethtool_o
 static int emac_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
 	struct ocp_enet_private *fep = dev->priv;
-	uint *data = (uint *) & rq->ifr_ifru;
+	ushort *data = (ushort *) & rq->ifr_ifru;
+	uint    tmp;
+
 
 	switch (cmd) {
 	case SIOCGMIIPHY:
 		data[0] = fep->mii_phy_addr;
 		/* Fall through */
 	case SIOCGMIIREG:
-		data[3] = emac_phy_read(dev, fep->mii_phy_addr, data[1]);
+		tmp = emac_phy_read(dev, fep->mii_phy_addr, data[1]);
+		data[3] = (ushort)(tmp & 0xffff);
 		return 0;
 	case SIOCSMIIREG:
 		if (!capable(CAP_NET_ADMIN))
@@ -1626,7 +1643,10 @@ static int emac_open(struct net_device *
 	}
 	/* Kick the chip rx & tx channels into life */
 	spin_lock_irq(&fep->lock);
-	emac_kick(fep);
+
+	/* no link, no need to kick the interface */
+	if (netif_carrier_ok(fep->ndev))
+		emac_kick(fep);
 	spin_unlock_irq(&fep->lock);
 
 	netif_start_queue(dev);

Return-Path: <g.jaeger@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id 6E6E867A6F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Mar 2005 21:07:02 +1100 (EST)
From: Gerhard Jaeger <g.jaeger@sysgo.com>
Date: Thu, 10 Mar 2005 11:06:53 +0100
To: Eugene Surovegin <ebs@ebshome.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200503101106.53345.g.jaeger@sysgo.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: PPC 440GX with NS DP83865 phy
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 10 March 2005 09:34, Eugene Surovegin wrote:
> On Thu, Mar 10, 2005 at 08:37:08AM +0100, Gerhard Jaeger wrote:
> 
> [snip]
> 
> > I have sent a patch (which has been rejected) a few
> > weeks ago to the list which changes the setup procedure of the EMAC to work
> > with a DP83865 PHY. THe current implementation will not work.
> 
> Gerhard, I wasn't able to find that patch in the patch tracker 
> (http://ozlabs.org/ppc32-patches/) and I missed it when you posted it.
> 
> Could you re-send it or post a link to the relevant message in 
> archive.
>
Hi Eugene,

the patch has been posted in October last year (wow, thought it was in
december or so):
http://ozlabs.org/pipermail/linuxppc-embedded/2004-October/015811.html

I think it needs some cleanup to apply correctly, but the issue is still
the same -  the RGMII bridge needs to be setup again after the EMAC has 
been reset. This problem occurs, when the speed is != 100Mbs, then
the clocking for the phy is not correct. 
I have attached an updated patch, which first checks the PHY speed, then
according to that speed the RGMII and ZMII will be setup...

Gerhard

-- 
Gerhard Jaeger <gjaeger@sysgo.com>            
SYSGO AG                      Embedded and Real-Time Software
www.sysgo.com | www.elinos.com | www.pikeos.com | www.osek.de 

[PATCH][PPC32]IBM-EMAC GMII
This patch fixes problems with a Gigabit PHY being connected via GMII
interface. It seems, that the RGMII bridge needs to be setup again after
the EMAC has been reset. It causes also some troubles to enable RX & TX
without having a link. Tested on PPC440GP, GX and PPC405 boards.

Signed-off-by: Gerhard Jaeger <gjaeger@sysgo.com>

--- linux-2.6.11/drivers/net/ibm_emac/ibm_emac_core.c.orig	2004-10-18 23:53:06.000000000 +0200
+++ linux-2.6.11/drivers/net/ibm_emac/ibm_emac_core.c		2004-10-22 08:43:12.000000000 +0200
@@ -1018,28 +1018,45 @@ static int emac_start_xmit(struct sk_buf
 	return 0;
 }
 
+static int emac_setup_mii_bridges(struct ocp_enet_private *fep )
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
-
 	/* set speed (default is 10Mb) */
-	switch (speed) {
+	switch (fep->phy_mii.speed) {
 	case SPEED_1000:
 		mode_reg |= EMAC_M1_JUMBO_ENABLE | EMAC_M1_RFS_16K;
 		if (fep->rgmii_dev) {
@@ -1050,41 +1067,28 @@ static int emac_adjust_to_link(struct oc
 				mode_reg |= EMAC_M1_MF_1000GPCS;
 			else
 				mode_reg |= EMAC_M1_MF_1000MBPS;
-
-			emac_rgmii_port_speed(fep->rgmii_dev, fep->rgmii_input,
-					      1000);
 		}
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
+	if (fep->phy_mii.duplex)
 		mode_reg |= EMAC_M1_FDE | EMAC_M1_EIFC | EMAC_M1_IST;
 	else
 		mode_reg &= ~(EMAC_M1_FDE | EMAC_M1_EIFC | EMAC_M1_ILE);
 
-	LINK_DEBUG(("%s: adjust to link, speed: %d, duplex: %d, opened: %d\n",
-		    fep->ndev->name, speed, full_duplex, fep->opened));
-
+ 	LINK_DEBUG(("%s: adjust to link, speed: %d, duplex: %d, opened: %d\n",
+		    fep->ndev->name, fep->phy_mii.speed,
+		    fep->phy_mii.full_duplex, fep->opened));
+ 
 	printk(KERN_INFO "%s: Speed: %d, %s duplex.\n",
-	       fep->ndev->name, speed, full_duplex ? "Full" : "Half");
+	       fep->ndev->name, fep->phy_mii.speed,
+	       (fep->phy_mii.duplex == DUPLEX_FULL) ? "Full" : "Half");
 	if (fep->opened)
 		out_be32(&emacp->em0mr1, mode_reg);
 
@@ -1312,15 +1316,23 @@ static void emac_reset_configure(struct 
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
+		emac_setup_mii_bridges( fep );
+
 		for (i = 0; i < 100; i++) {
 			if ((in_be32(&emacp->em0mr0) & EMAC_M0_SRST) == 0)
 				break;
 			udelay(10);
 		}
-
 		if (i >= 100) {
 			printk(KERN_ERR "%s: Cannot reset EMAC\n",
 			       fep->ndev->name);
@@ -1630,7 +1642,10 @@ static int emac_open(struct net_device *
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

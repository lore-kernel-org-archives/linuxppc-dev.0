Return-Path: <jens@de.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0A7BCDE0C9
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 09:30:45 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id l0QMUbSG038692
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 22:30:37 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l0QMUaoX970826
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 23:30:36 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l0QMUa7a001269
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 23:30:36 +0100
From: Jens Osterkamp <jens@de.ibm.com>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: spidernet: dynamic phy setup code
Date: Fri, 26 Jan 2007 23:30:34 +0100
References: <200701261409.29537.jens@de.ibm.com>
	<200701262150.52882.jens@de.ibm.com>
	<20070126221510.GB11220@austin.ibm.com>
In-Reply-To: <20070126221510.GB11220@austin.ibm.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_KEouFFJ46DZhWx4"
Message-Id: <200701262330.34856.jens@de.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Boundary-00=_KEouFFJ46DZhWx4
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 26 January 2007 23:15, Linas Vepstas wrote:
> On Fri, Jan 26, 2007 at 09:50:52PM +0100, Jens Osterkamp wrote:
> > Seems like my kmail has eaten the tabs...i am attaching it as a file,
>
> Ahhh
>
> > does it look ok for you now ?
>
> Yes.
>
> FWIW,
>
> Acked-by: Linas Vepstas <linas@austin.ibm.com>
>
> --linas

Sending it again as attached file

Jens

--Boundary-00=_KEouFFJ46DZhWx4
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="spidernet-on-celleb-update-2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="spidernet-on-celleb-update-2.diff"

Subject: spidernet: dynamic phy setup code

This patch modifies the patch submitted by Kou Ishizaki to make it work on the
blade (http://marc.theaimsgroup.com/?l=linux-netdev&m=116593424505539&w=2).
Unfortunately I dont have access to a Celleb so I cannot test it there.

The basic logic behind this is simple : when the interface first comes up
it tries to detect the phy. When the phy is detected, it is initially set up
to use copper. A timer is set to check the link status in spidernet_link_phy
using poll_link. If link check fails more than SPIDER_NET_ANEG_TIMEOUT
times, it switches to fiber link with autonegotiation. If that fails more
than SPIDER_NET_ANEG_TIMEOUT times, it switches to fiber link with no
autonegotiation. If that also fails, it goes back to copper, and so forth.
If the link comes up, it prints the link abilites and we are done.

The name of the phy found attached to the spider chip is reported to the
user. Hardcoded values for the timeout are moved to #defines. I put in a
few comments to make the code more readable.

Signed-off-by: Jens Osterkamp <jens@de.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/drivers/net/spider_net.c
===================================================================
--- linux-2.6.orig/drivers/net/spider_net.c
+++ linux-2.6/drivers/net/spider_net.c
@@ -1280,19 +1280,23 @@ spider_net_set_mac(struct net_device *ne
  * spider_net_link_reset
  * @netdev: net device structure
  *
+ * This is called when the PHY_LINK signal is asserted. For the blade this is
+ * not connected so we should never get here.
+ *
  */
 static void
 spider_net_link_reset(struct net_device *netdev)
 {
-
 	struct spider_net_card *card=netdev_priv(netdev);
 
 	del_timer_sync(&card->aneg_timer);
 
+	/* clear interrupt, block further interrupts */
 	spider_net_write_reg(card, SPIDER_NET_GMACST,
 			     spider_net_read_reg(card, SPIDER_NET_GMACST));
 	spider_net_write_reg(card, SPIDER_NET_GMACINTEN, 0);
 
+	/* reset phy and setup aneg */
 	mii_phy_probe(&card->phy, card->phy.mii_id);
 	spider_net_setup_aneg(card, is1000);
 	if (card->phy.def->phy_id)
@@ -1616,6 +1620,7 @@ spider_net_init_card(struct spider_net_c
 	spider_net_write_reg(card, SPIDER_NET_CKRCTRL,
 			     SPIDER_NET_CKRCTRL_RUN_VALUE);
 
+	/* trigger ETOMOD signal */
 	spider_net_write_reg(card, SPIDER_NET_GMACOPEMD,
 	                     spider_net_read_reg(card, SPIDER_NET_GMACOPEMD) | 0x4);
 
@@ -1739,6 +1744,8 @@ spider_net_open(struct net_device *netde
 	if (spider_net_init_firmware(card))
 		goto init_firmware_failed;
 
+	/* start probing with copper */
+	card->phy.medium = GMII_COPPER;
 	spider_net_setup_aneg(card, is1000);
 	if (card->phy.def->phy_id)
 		mod_timer(&card->aneg_timer, jiffies + SPIDER_NET_ANEG_TIMER);
@@ -1805,43 +1812,54 @@ static void spider_net_link_phy(unsigned
 	struct spider_net_card *card = (struct spider_net_card *)data;
 	struct mii_phy *phy = &card->phy;
 
-	if (card->aneg_count > 10) {
-		/* timeout */
-		card->aneg_count = 0;
-		is1000 = !is1000;
-		goto re_setup;
+	/* if link didn't come up after SPIDER_NET_ANEG_TIMEOUT tries, setup phy again */
+	if (card->aneg_count > SPIDER_NET_ANEG_TIMEOUT) {
+
+		pr_info("%s: link is down, trying to bring it up\n", card->netdev->name);
+
+		switch(phy->medium) {
+		case GMII_COPPER:
+			/* enable fiber with autonegotiation first */
+			if (phy->def->ops->enable_fiber)
+				phy->def->ops->enable_fiber(phy, 1);
+			phy->medium = GMII_FIBER;
+			break;
+
+		case GMII_FIBER:
+			/* fiber didn't come up, try to disable fiber autoneg */
+			if (phy->def->ops->enable_fiber)
+				phy->def->ops->enable_fiber(phy, 0);
+			phy->medium = GMII_UNKNOWN;
+			break;
+
+		case GMII_UNKNOWN:
+			/* copper, fiber with and without autoneg failed,
+			 * retry from beginning */
+			spider_net_setup_aneg(card, is1000);
+			phy->medium = GMII_COPPER;
+			break;
+		}
+
+	card->aneg_count = 0;
+	mod_timer(&card->aneg_timer, jiffies + SPIDER_NET_ANEG_TIMER);
+	return;
 	}
 
+	/* link still not up, try again later */
 	if (!(phy->def->ops->poll_link(phy))) {
 		card->aneg_count++;
 		mod_timer(&card->aneg_timer, jiffies + SPIDER_NET_ANEG_TIMER);
 		return;
 	}
 
+	/* link came up, get abilities */
 	phy->def->ops->read_link(phy);
 
-	if (phy->speed == 1000 && !is1000) {
-		is1000 = 1;
-		goto re_setup;
-	} else if(phy->speed != 1000 && is1000) {
-		is1000 = 0;
-		goto re_setup;
-	}
-
-	spider_net_write_reg(card, SPIDER_NET_GMACST,
-			     spider_net_read_reg(card, SPIDER_NET_GMACST));
-	spider_net_write_reg(card, SPIDER_NET_GMACINTEN, 0x4);
-
-	pr_info("Found %s with %i Mbps, %s-duplex.\n",
-		phy->def->name, phy->speed, phy->duplex==1 ? "Full" : "Half");
+	pr_info("%s: link is up with %i Mbps, %s-duplex, %sautoneg.\n",
+		card->netdev->name, phy->speed, phy->duplex==1 ? "Full" : "Half",
+		phy->autoneg==1 ? "" : "no ");
 
 	return;
-
-re_setup:
-	mii_phy_probe(phy, phy->mii_id);
-	spider_net_setup_aneg(card, is1000);
-	card->aneg_count = 0;
-	mod_timer(&card->aneg_timer, jiffies + SPIDER_NET_ANEG_TIMER);
 }
 
 /**
@@ -1871,8 +1889,10 @@ spider_net_setup_phy(struct spider_net_c
 		unsigned short id;
 		id = spider_net_read_phy(card->netdev, phy->mii_id, MII_BMSR);
 		if (id != 0x0000 && id != 0xffff) {
-			mii_phy_probe(phy, phy->mii_id);
+			if (!mii_phy_probe(phy, phy->mii_id)) {
+				pr_info("Found %s.\n", phy->def->name);
 			break;
+			}
 		}
 	}
 
Index: linux-2.6/drivers/net/spider_net.h
===================================================================
--- linux-2.6.orig/drivers/net/spider_net.h
+++ linux-2.6/drivers/net/spider_net.h
@@ -51,7 +51,8 @@ extern char spider_net_driver_name[];
 #define SPIDER_NET_TX_DESCRIPTORS_MAX		512
 
 #define SPIDER_NET_TX_TIMER			(HZ/5)
-#define SPIDER_NET_ANEG_TIMER			(HZ*2)
+#define SPIDER_NET_ANEG_TIMER			(HZ)
+#define SPIDER_NET_ANEG_TIMEOUT			2
 
 #define SPIDER_NET_RX_CSUM_DEFAULT		1
 

--Boundary-00=_KEouFFJ46DZhWx4--

Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id A1477DE022
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 13:55:15 +1100 (EST)
Date: Wed, 28 Nov 2007 20:58:25 -0600
From: Olof Johansson <olof@lixom.net>
To: jgarzik@pobox.com
Subject: [PATCH] [12/12] pasemi_mac: Don't enable RX/TX without a link (if
	possible)
Message-ID: <20071129025825.GM17215@lixom.net>
References: <20071129025410.GA17215@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071129025410.GA17215@lixom.net>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

pasemi_mac: Don't enable RX/TX without a link (if possible)

Don't enable RX/TX of packets until we have a link, since there's a chance
we'll just get RX frame errors, etc.

The case where we don't have a PHY we can't do much about: Just enable
it and deal with errors as they come in.


Signed-off-by: Olof Johansson <olof@lixom.net>


---
 drivers/net/pasemi_mac.c |   41 +++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

Index: k.org/drivers/net/pasemi_mac.c
===================================================================
--- k.org.orig/drivers/net/pasemi_mac.c
+++ k.org/drivers/net/pasemi_mac.c
@@ -874,6 +874,24 @@ static irqreturn_t pasemi_mac_tx_intr(in
 	return IRQ_HANDLED;
 }
 
+static void pasemi_mac_intf_disable(struct pasemi_mac *mac)
+{
+	unsigned int flags;
+
+	flags = read_mac_reg(mac, PAS_MAC_CFG_PCFG);
+	flags &= ~PAS_MAC_CFG_PCFG_PE;
+	write_mac_reg(mac, PAS_MAC_CFG_PCFG, flags);
+}
+
+static void pasemi_mac_intf_enable(struct pasemi_mac *mac)
+{
+	unsigned int flags;
+
+	flags = read_mac_reg(mac, PAS_MAC_CFG_PCFG);
+	flags |= PAS_MAC_CFG_PCFG_PE;
+	write_mac_reg(mac, PAS_MAC_CFG_PCFG, flags);
+}
+
 static void pasemi_adjust_link(struct net_device *dev)
 {
 	struct pasemi_mac *mac = netdev_priv(dev);
@@ -889,11 +907,14 @@ static void pasemi_adjust_link(struct ne
 			printk(KERN_INFO "%s: Link is down.\n", dev->name);
 
 		netif_carrier_off(dev);
+		pasemi_mac_intf_disable(mac);
 		mac->link = 0;
 
 		return;
-	} else
+	} else {
+		pasemi_mac_intf_enable(mac);
 		netif_carrier_on(dev);
+	}
 
 	flags = read_mac_reg(mac, PAS_MAC_CFG_PCFG);
 	new_flags = flags & ~(PAS_MAC_CFG_PCFG_HD | PAS_MAC_CFG_PCFG_SPD_M |
@@ -1052,8 +1073,7 @@ static int pasemi_mac_open(struct net_de
 	pasemi_mac_restart_rx_intr(mac);
 	pasemi_mac_restart_tx_intr(mac);
 
-	flags = PAS_MAC_CFG_PCFG_S1 | PAS_MAC_CFG_PCFG_PE |
-		PAS_MAC_CFG_PCFG_PR | PAS_MAC_CFG_PCFG_CE;
+	flags = PAS_MAC_CFG_PCFG_S1 | PAS_MAC_CFG_PCFG_PR | PAS_MAC_CFG_PCFG_CE;
 
 	if (mac->type == MAC_TYPE_GMAC)
 		flags |= PAS_MAC_CFG_PCFG_TSR_1G | PAS_MAC_CFG_PCFG_SPD_1G;
@@ -1064,11 +1084,16 @@ static int pasemi_mac_open(struct net_de
 	write_mac_reg(mac, PAS_MAC_CFG_PCFG, flags);
 
 	ret = pasemi_mac_phy_init(dev);
-	/* Warn for missing PHY on SGMII (1Gig) ports.
-	 */
-	if (ret && mac->type == MAC_TYPE_GMAC) {
-		dev_warn(&mac->pdev->dev, "PHY init failed: %d.\n", ret);
-		dev_warn(&mac->pdev->dev, "Defaulting to 1Gbit full duplex\n");
+	if (ret) {
+		/* Since we won't get link notification, just enable RX */
+		pasemi_mac_intf_enable(mac);
+		if (mac->type == MAC_TYPE_GMAC) {
+			/* Warn for missing PHY on SGMII (1Gig) ports */
+			dev_warn(&mac->pdev->dev,
+				 "PHY init failed: %d.\n", ret);
+			dev_warn(&mac->pdev->dev,
+				 "Defaulting to 1Gbit full duplex\n");
+		}
 	}
 
 	netif_start_queue(dev);

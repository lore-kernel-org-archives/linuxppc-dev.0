Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 63757DDE23
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 13:54:56 +1100 (EST)
Date: Wed, 28 Nov 2007 20:58:06 -0600
From: Olof Johansson <olof@lixom.net>
To: jgarzik@pobox.com
Subject: [PATCH] [11/12] pasemi_mac: Print warning when not attaching to a PHY
Message-ID: <20071129025806.GL17215@lixom.net>
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

pasemi_mac: Print warning when not attaching to a PHY

Print a warning on the console when not connecting to a phy for an interface.
It turns out to be a pretty common problem when someone gets the MDIO info
wrong in their device tree, resulting in the macs running at a fixed 1Gbit FD.

Signed-off-by: Olof Johansson <olof@lixom.net>


---
 drivers/net/pasemi_mac.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

Index: k.org/drivers/net/pasemi_mac.c
===================================================================
--- k.org.orig/drivers/net/pasemi_mac.c
+++ k.org/drivers/net/pasemi_mac.c
@@ -1064,11 +1064,12 @@ static int pasemi_mac_open(struct net_de
 	write_mac_reg(mac, PAS_MAC_CFG_PCFG, flags);
 
 	ret = pasemi_mac_phy_init(dev);
-	/* Some configs don't have PHYs (XAUI etc), so don't complain about
-	 * failed init due to -ENODEV.
+	/* Warn for missing PHY on SGMII (1Gig) ports.
 	 */
-	if (ret && ret != -ENODEV)
-		dev_warn(&mac->pdev->dev, "phy init failed: %d\n", ret);
+	if (ret && mac->type == MAC_TYPE_GMAC) {
+		dev_warn(&mac->pdev->dev, "PHY init failed: %d.\n", ret);
+		dev_warn(&mac->pdev->dev, "Defaulting to 1Gbit full duplex\n");
+	}
 
 	netif_start_queue(dev);
 	napi_enable(&mac->napi);

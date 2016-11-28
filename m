Return-Path: <jhovold@gmail.com>
Received: from mail-lf0-x241.google.com (mail-lf0-x241.google.com
 [IPv6:2a00:1450:4010:c07::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSFXQ5w2CzDvjg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 05:27:34 +1100 (AEDT)
Received: by mail-lf0-x241.google.com with SMTP id p100so10340839lfg.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 10:27:34 -0800 (PST)
Sender: Johan Hovold <jhovold@gmail.com>
From: Johan Hovold <johan@kernel.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: Vince Bridgers <vbridger@opensource.altera.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Fugang Duan <fugang.duan@nxp.com>,
 Pantelis Antoniou <pantelis.antoniou@gmail.com>,
 Vitaly Bordug <vbordug@ru.mvista.com>,
 Claudiu Manoil <claudiu.manoil@freescale.com>,
 Li Yang <leoli@freescale.com>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Felix Fietkau <nbd@openwrt.org>, John Crispin <blogic@openwrt.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 Lars Persson <lars.persson@axis.com>, Mugunthan V N <mugunthanvnm@ti.com>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>,
 Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
 netdev@vger.kernel.org, nios2-dev@lists.rocketboards.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
 Johan Hovold <johan@kernel.org>
Subject: [PATCH net 13/16] net: ethernet: renesas: ravb: fix fixed-link phydev
 leaks
Date: Mon, 28 Nov 2016 19:25:06 +0100
Message-Id: <1480357509-28074-14-git-send-email-johan@kernel.org>
In-Reply-To: <1480357509-28074-1-git-send-email-johan@kernel.org>
References: <1480357509-28074-1-git-send-email-johan@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make sure to deregister and free any fixed-link PHY registered using
of_phy_register_fixed_link() on initialisation errors and on device
close after having disconnected the PHY.

Fixes: b4bc88a868ed ("ravb: Add fixed-link support")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/net/ethernet/renesas/ravb_main.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 630536bc72f9..f1f3be2cfe21 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1008,7 +1008,8 @@ static int ravb_phy_init(struct net_device *ndev)
 	of_node_put(pn);
 	if (!phydev) {
 		netdev_err(ndev, "failed to connect PHY\n");
-		return -ENOENT;
+		err = -ENOENT;
+		goto err_deregister_fixed_link;
 	}
 
 	/* This driver only support 10/100Mbit speeds on Gen3
@@ -1020,8 +1021,7 @@ static int ravb_phy_init(struct net_device *ndev)
 		err = phy_set_max_speed(phydev, SPEED_100);
 		if (err) {
 			netdev_err(ndev, "failed to limit PHY to 100Mbit/s\n");
-			phy_disconnect(phydev);
-			return err;
+			goto err_phy_disconnect;
 		}
 
 		netdev_info(ndev, "limited PHY to 100Mbit/s\n");
@@ -1033,6 +1033,14 @@ static int ravb_phy_init(struct net_device *ndev)
 	phy_attached_info(phydev);
 
 	return 0;
+
+err_phy_disconnect:
+	phy_disconnect(phydev);
+err_deregister_fixed_link:
+	if (of_phy_is_fixed_link(np))
+		of_phy_deregister_fixed_link(np);
+
+	return err;
 }
 
 /* PHY control start function */
@@ -1634,6 +1642,7 @@ static void ravb_set_rx_mode(struct net_device *ndev)
 /* Device close function for Ethernet AVB */
 static int ravb_close(struct net_device *ndev)
 {
+	struct device_node *np = ndev->dev.parent->of_node;
 	struct ravb_private *priv = netdev_priv(ndev);
 	struct ravb_tstamp_skb *ts_skb, *ts_skb2;
 
@@ -1663,6 +1672,8 @@ static int ravb_close(struct net_device *ndev)
 	if (ndev->phydev) {
 		phy_stop(ndev->phydev);
 		phy_disconnect(ndev->phydev);
+		if (of_phy_is_fixed_link(np))
+			of_phy_deregister_fixed_link(np);
 	}
 
 	if (priv->chip_id != RCAR_GEN2) {
-- 
2.7.3

Return-Path: <jhovold@gmail.com>
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com
 [IPv6:2a00:1450:4010:c07::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSFXP36VGzDvhQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 05:27:33 +1100 (AEDT)
Received: by mail-lf0-x243.google.com with SMTP id 98so10306070lfs.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 10:27:33 -0800 (PST)
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
Subject: [PATCH net 10/16] net: ethernet: ucc_geth: fix fixed-link phydev leaks
Date: Mon, 28 Nov 2016 19:25:03 +0100
Message-Id: <1480357509-28074-11-git-send-email-johan@kernel.org>
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
of_phy_register_fixed_link() on probe errors and on driver unbind.

Fixes: 87009814cdbb ("ucc_geth: use the new fixed PHY helpers")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/net/ethernet/freescale/ucc_geth.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index 186ef8f16c80..f76d33279454 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -3868,9 +3868,8 @@ static int ucc_geth_probe(struct platform_device* ofdev)
 	dev = alloc_etherdev(sizeof(*ugeth));
 
 	if (dev == NULL) {
-		of_node_put(ug_info->tbi_node);
-		of_node_put(ug_info->phy_node);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto err_deregister_fixed_link;
 	}
 
 	ugeth = netdev_priv(dev);
@@ -3907,10 +3906,7 @@ static int ucc_geth_probe(struct platform_device* ofdev)
 		if (netif_msg_probe(ugeth))
 			pr_err("%s: Cannot register net device, aborting\n",
 			       dev->name);
-		free_netdev(dev);
-		of_node_put(ug_info->tbi_node);
-		of_node_put(ug_info->phy_node);
-		return err;
+		goto err_free_netdev;
 	}
 
 	mac_addr = of_get_mac_address(np);
@@ -3923,16 +3919,29 @@ static int ucc_geth_probe(struct platform_device* ofdev)
 	ugeth->node = np;
 
 	return 0;
+
+err_free_netdev:
+	free_netdev(dev);
+err_deregister_fixed_link:
+	if (of_phy_is_fixed_link(np))
+		of_phy_deregister_fixed_link(np);
+	of_node_put(ug_info->tbi_node);
+	of_node_put(ug_info->phy_node);
+
+	return err;
 }
 
 static int ucc_geth_remove(struct platform_device* ofdev)
 {
 	struct net_device *dev = platform_get_drvdata(ofdev);
 	struct ucc_geth_private *ugeth = netdev_priv(dev);
+	struct device_node *np = ofdev->dev.of_node;
 
 	unregister_netdev(dev);
 	free_netdev(dev);
 	ucc_geth_memclean(ugeth);
+	if (of_phy_is_fixed_link(np))
+		of_phy_deregister_fixed_link(np);
 	of_node_put(ugeth->ug_info->tbi_node);
 	of_node_put(ugeth->ug_info->phy_node);
 
-- 
2.7.3

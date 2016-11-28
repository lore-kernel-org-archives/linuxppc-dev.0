Return-Path: <jhovold@gmail.com>
Received: from mail-lf0-x241.google.com (mail-lf0-x241.google.com
 [IPv6:2a00:1450:4010:c07::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSFXK2pNqzDvhQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 05:27:29 +1100 (AEDT)
Received: by mail-lf0-x241.google.com with SMTP id o20so10330106lfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 10:27:29 -0800 (PST)
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
Subject: [PATCH net 04/16] net: ethernet: aurora: nb8800: fix fixed-link
 phydev leaks
Date: Mon, 28 Nov 2016 19:24:57 +0100
Message-Id: <1480357509-28074-5-git-send-email-johan@kernel.org>
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

Fixes: c7dfe3abf40e ("net: ethernet: nb8800: support fixed-link DT
node")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/net/ethernet/aurora/nb8800.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/aurora/nb8800.c b/drivers/net/ethernet/aurora/nb8800.c
index 00c38bf151e6..e078d8da978c 100644
--- a/drivers/net/ethernet/aurora/nb8800.c
+++ b/drivers/net/ethernet/aurora/nb8800.c
@@ -1466,12 +1466,12 @@ static int nb8800_probe(struct platform_device *pdev)
 
 	ret = nb8800_hw_init(dev);
 	if (ret)
-		goto err_free_bus;
+		goto err_deregister_fixed_link;
 
 	if (ops && ops->init) {
 		ret = ops->init(dev);
 		if (ret)
-			goto err_free_bus;
+			goto err_deregister_fixed_link;
 	}
 
 	dev->netdev_ops = &nb8800_netdev_ops;
@@ -1504,6 +1504,9 @@ static int nb8800_probe(struct platform_device *pdev)
 
 err_free_dma:
 	nb8800_dma_free(dev);
+err_deregister_fixed_link:
+	if (of_phy_is_fixed_link(pdev->dev.of_node))
+		of_phy_deregister_fixed_link(pdev->dev.of_node);
 err_free_bus:
 	of_node_put(priv->phy_node);
 	mdiobus_unregister(bus);
@@ -1521,6 +1524,8 @@ static int nb8800_remove(struct platform_device *pdev)
 	struct nb8800_priv *priv = netdev_priv(ndev);
 
 	unregister_netdev(ndev);
+	if (of_phy_is_fixed_link(pdev->dev.of_node))
+		of_phy_deregister_fixed_link(pdev->dev.of_node);
 	of_node_put(priv->phy_node);
 
 	mdiobus_unregister(priv->mii_bus);
-- 
2.7.3

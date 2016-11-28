Return-Path: <jhovold@gmail.com>
Received: from mail-lf0-x242.google.com (mail-lf0-x242.google.com
 [IPv6:2a00:1450:4010:c07::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSFXR4f2wzDvjw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 05:27:35 +1100 (AEDT)
Received: by mail-lf0-x242.google.com with SMTP id o141so10369306lff.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 10:27:35 -0800 (PST)
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
Subject: [PATCH net 15/16] net: ethernet: ti: davinci_emac: fix fixed-link
 phydev and of-node leaks
Date: Mon, 28 Nov 2016 19:25:08 +0100
Message-Id: <1480357509-28074-16-git-send-email-johan@kernel.org>
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

Also remember to put the of-node reference on probe errors.

Fixes: 1bb6aa56bb38 ("net: davinci_emac: Add support for fixed-link
PHY")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/net/ethernet/ti/davinci_emac.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index 84fbe5714f8b..481c7bf0395b 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -1767,6 +1767,7 @@ static int davinci_emac_try_get_mac(struct platform_device *pdev,
  */
 static int davinci_emac_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
 	int rc = 0;
 	struct resource *res, *res_ctrl;
 	struct net_device *ndev;
@@ -1805,7 +1806,7 @@ static int davinci_emac_probe(struct platform_device *pdev)
 	if (!pdata) {
 		dev_err(&pdev->dev, "no platform data\n");
 		rc = -ENODEV;
-		goto no_pdata;
+		goto err_free_netdev;
 	}
 
 	/* MAC addr and PHY mask , RMII enable info from platform_data */
@@ -1941,6 +1942,10 @@ static int davinci_emac_probe(struct platform_device *pdev)
 		cpdma_chan_destroy(priv->rxchan);
 	cpdma_ctlr_destroy(priv->dma);
 no_pdata:
+	if (of_phy_is_fixed_link(np))
+		of_phy_deregister_fixed_link(np);
+	of_node_put(priv->phy_node);
+err_free_netdev:
 	free_netdev(ndev);
 	return rc;
 }
@@ -1956,6 +1961,7 @@ static int davinci_emac_remove(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct emac_priv *priv = netdev_priv(ndev);
+	struct device_node *np = pdev->dev.of_node;
 
 	dev_notice(&ndev->dev, "DaVinci EMAC: davinci_emac_remove()\n");
 
@@ -1968,6 +1974,8 @@ static int davinci_emac_remove(struct platform_device *pdev)
 	unregister_netdev(ndev);
 	of_node_put(priv->phy_node);
 	pm_runtime_disable(&pdev->dev);
+	if (of_phy_is_fixed_link(np))
+		of_phy_deregister_fixed_link(np);
 	free_netdev(ndev);
 
 	return 0;
-- 
2.7.3

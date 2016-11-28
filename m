Return-Path: <jhovold@gmail.com>
Received: from mail-lf0-x242.google.com (mail-lf0-x242.google.com
 [IPv6:2a00:1450:4010:c07::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSFXM4LWZzDvhP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 05:27:31 +1100 (AEDT)
Received: by mail-lf0-x242.google.com with SMTP id o20so10330283lfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 10:27:31 -0800 (PST)
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
Subject: [PATCH net 05/16] net: ethernet: bcmsysport: fix fixed-link phydev
 leaks
Date: Mon, 28 Nov 2016 19:24:58 +0100
Message-Id: <1480357509-28074-6-git-send-email-johan@kernel.org>
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

Fixes: 186534a3f832 ("net: systemport: use the new fixed PHY helpers")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/net/ethernet/broadcom/bcmsysport.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index c3354b9941d1..25d1eb4933d0 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -1755,13 +1755,13 @@ static int bcm_sysport_probe(struct platform_device *pdev)
 	if (priv->irq0 <= 0 || priv->irq1 <= 0) {
 		dev_err(&pdev->dev, "invalid interrupts\n");
 		ret = -EINVAL;
-		goto err;
+		goto err_free_netdev;
 	}
 
 	priv->base = devm_ioremap_resource(&pdev->dev, r);
 	if (IS_ERR(priv->base)) {
 		ret = PTR_ERR(priv->base);
-		goto err;
+		goto err_free_netdev;
 	}
 
 	priv->netdev = dev;
@@ -1779,7 +1779,7 @@ static int bcm_sysport_probe(struct platform_device *pdev)
 		ret = of_phy_register_fixed_link(dn);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to register fixed PHY\n");
-			goto err;
+			goto err_free_netdev;
 		}
 
 		priv->phy_dn = dn;
@@ -1821,7 +1821,7 @@ static int bcm_sysport_probe(struct platform_device *pdev)
 	ret = register_netdev(dev);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register net_device\n");
-		goto err;
+		goto err_deregister_fixed_link;
 	}
 
 	priv->rev = topctrl_readl(priv, REV_CNTL) & REV_MASK;
@@ -1832,7 +1832,11 @@ static int bcm_sysport_probe(struct platform_device *pdev)
 		 priv->base, priv->irq0, priv->irq1, txq, rxq);
 
 	return 0;
-err:
+
+err_deregister_fixed_link:
+	if (of_phy_is_fixed_link(dn))
+		of_phy_deregister_fixed_link(dn);
+err_free_netdev:
 	free_netdev(dev);
 	return ret;
 }
@@ -1840,11 +1844,14 @@ static int bcm_sysport_probe(struct platform_device *pdev)
 static int bcm_sysport_remove(struct platform_device *pdev)
 {
 	struct net_device *dev = dev_get_drvdata(&pdev->dev);
+	struct device_node *dn = pdev->dev.of_node;
 
 	/* Not much to do, ndo_close has been called
 	 * and we use managed allocations
 	 */
 	unregister_netdev(dev);
+	if (of_phy_is_fixed_link(dn))
+		of_phy_deregister_fixed_link(dn);
 	free_netdev(dev);
 	dev_set_drvdata(&pdev->dev, NULL);
 
-- 
2.7.3

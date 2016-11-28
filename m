Return-Path: <jhovold@gmail.com>
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com
 [IPv6:2a00:1450:4010:c07::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSFXN3V5JzDvhn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 05:27:32 +1100 (AEDT)
Received: by mail-lf0-x243.google.com with SMTP id p100so10340716lfg.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 10:27:32 -0800 (PST)
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
Subject: [PATCH net 11/16] net: ethernet: marvell: mvneta: fix fixed-link
 phydev leaks
Date: Mon, 28 Nov 2016 19:25:04 +0100
Message-Id: <1480357509-28074-12-git-send-email-johan@kernel.org>
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

Fixes: 83895bedeee6 ("net: mvneta: add support for fixed links")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/net/ethernet/marvell/mvneta.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 0c0a45af950f..707bc4680b9b 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -4191,6 +4191,8 @@ static int mvneta_probe(struct platform_device *pdev)
 	clk_disable_unprepare(pp->clk);
 err_put_phy_node:
 	of_node_put(phy_node);
+	if (of_phy_is_fixed_link(dn))
+		of_phy_deregister_fixed_link(dn);
 err_free_irq:
 	irq_dispose_mapping(dev->irq);
 err_free_netdev:
@@ -4202,6 +4204,7 @@ static int mvneta_probe(struct platform_device *pdev)
 static int mvneta_remove(struct platform_device *pdev)
 {
 	struct net_device  *dev = platform_get_drvdata(pdev);
+	struct device_node *dn = pdev->dev.of_node;
 	struct mvneta_port *pp = netdev_priv(dev);
 
 	unregister_netdev(dev);
@@ -4209,6 +4212,8 @@ static int mvneta_remove(struct platform_device *pdev)
 	clk_disable_unprepare(pp->clk);
 	free_percpu(pp->ports);
 	free_percpu(pp->stats);
+	if (of_phy_is_fixed_link(dn))
+		of_phy_deregister_fixed_link(dn);
 	irq_dispose_mapping(dev->irq);
 	of_node_put(pp->phy_node);
 	free_netdev(dev);
-- 
2.7.3

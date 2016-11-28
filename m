Return-Path: <jhovold@gmail.com>
Received: from mail-lf0-x241.google.com (mail-lf0-x241.google.com
 [IPv6:2a00:1450:4010:c07::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSFXN0zBdzDvhR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 05:27:32 +1100 (AEDT)
Received: by mail-lf0-x241.google.com with SMTP id o20so10330321lfg.3
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
Subject: [PATCH net 06/16] net: ethernet: bcmgenet: fix fixed-link phydev leaks
Date: Mon, 28 Nov 2016 19:24:59 +0100
Message-Id: <1480357509-28074-7-git-send-email-johan@kernel.org>
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

Note that we're still leaking any fixed-link PHY registered in the
non-OF probe path.

Fixes: 9abf0c2b717a ("net: bcmgenet: use the new fixed PHY helpers")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/net/ethernet/broadcom/genet/bcmmii.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index 2e745bd51df4..e87607621e62 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -627,6 +627,7 @@ static int bcmgenet_mii_bus_init(struct bcmgenet_priv *priv)
 int bcmgenet_mii_init(struct net_device *dev)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
+	struct device_node *dn = priv->pdev->dev.of_node;
 	int ret;
 
 	ret = bcmgenet_mii_alloc(priv);
@@ -640,6 +641,8 @@ int bcmgenet_mii_init(struct net_device *dev)
 	return 0;
 
 out:
+	if (of_phy_is_fixed_link(dn))
+		of_phy_deregister_fixed_link(dn);
 	of_node_put(priv->phy_dn);
 	mdiobus_unregister(priv->mii_bus);
 	mdiobus_free(priv->mii_bus);
@@ -649,7 +652,10 @@ int bcmgenet_mii_init(struct net_device *dev)
 void bcmgenet_mii_exit(struct net_device *dev)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
+	struct device_node *dn = priv->pdev->dev.of_node;
 
+	if (of_phy_is_fixed_link(dn))
+		of_phy_deregister_fixed_link(dn);
 	of_node_put(priv->phy_dn);
 	mdiobus_unregister(priv->mii_bus);
 	mdiobus_free(priv->mii_bus);
-- 
2.7.3

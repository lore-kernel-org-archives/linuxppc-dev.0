Return-Path: <jhovold@gmail.com>
Received: from mail-lf0-x244.google.com (mail-lf0-x244.google.com
 [IPv6:2a00:1450:4010:c07::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSFXM585rzDvhQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 05:27:31 +1100 (AEDT)
Received: by mail-lf0-x244.google.com with SMTP id o141so10369083lff.1
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
Subject: [PATCH net 09/16] net: ethernet: gianfar: fix fixed-link phydev leaks
Date: Mon, 28 Nov 2016 19:25:02 +0100
Message-Id: <1480357509-28074-10-git-send-email-johan@kernel.org>
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

Fixes: be40364544bd ("gianfar: use the new fixed PHY helpers")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/net/ethernet/freescale/gianfar.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index 4b4f5bc0e279..9061c2f82b9c 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -1312,6 +1312,7 @@ static void gfar_init_addr_hash_table(struct gfar_private *priv)
  */
 static int gfar_probe(struct platform_device *ofdev)
 {
+	struct device_node *np = ofdev->dev.of_node;
 	struct net_device *dev = NULL;
 	struct gfar_private *priv = NULL;
 	int err = 0, i;
@@ -1462,6 +1463,8 @@ static int gfar_probe(struct platform_device *ofdev)
 	return 0;
 
 register_fail:
+	if (of_phy_is_fixed_link(np))
+		of_phy_deregister_fixed_link(np);
 	unmap_group_regs(priv);
 	gfar_free_rx_queues(priv);
 	gfar_free_tx_queues(priv);
@@ -1474,11 +1477,16 @@ static int gfar_probe(struct platform_device *ofdev)
 static int gfar_remove(struct platform_device *ofdev)
 {
 	struct gfar_private *priv = platform_get_drvdata(ofdev);
+	struct device_node *np = ofdev->dev.of_node;
 
 	of_node_put(priv->phy_node);
 	of_node_put(priv->tbi_node);
 
 	unregister_netdev(priv->ndev);
+
+	if (of_phy_is_fixed_link(np))
+		of_phy_deregister_fixed_link(np);
+
 	unmap_group_regs(priv);
 	gfar_free_rx_queues(priv);
 	gfar_free_tx_queues(priv);
-- 
2.7.3

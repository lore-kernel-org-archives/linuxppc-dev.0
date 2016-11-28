Return-Path: <jhovold@gmail.com>
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com
 [IPv6:2a00:1450:4010:c07::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSFXR1s5kzDvjk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 05:27:35 +1100 (AEDT)
Received: by mail-lf0-x243.google.com with SMTP id p100so10340874lfg.2
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
Subject: [PATCH net 16/16] net: dsa: slave: fix fixed-link phydev leaks
Date: Mon, 28 Nov 2016 19:25:09 +0100
Message-Id: <1480357509-28074-17-git-send-email-johan@kernel.org>
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
of_phy_register_fixed_link() on slave-setup errors and on slave destroy.

Fixes: 0d8bcdd383b8 ("net: dsa: allow for more complex PHY setups")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 net/dsa/slave.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 2a5c20a13fe4..30e2e21d7619 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -1177,6 +1177,8 @@ static int dsa_slave_phy_setup(struct dsa_slave_priv *p,
 		ret = dsa_slave_phy_connect(p, slave_dev, p->port);
 		if (ret) {
 			netdev_err(slave_dev, "failed to connect to port %d: %d\n", p->port, ret);
+			if (phy_is_fixed)
+				of_phy_deregister_fixed_link(port_dn);
 			return ret;
 		}
 	}
@@ -1292,10 +1294,18 @@ int dsa_slave_create(struct dsa_switch *ds, struct device *parent,
 void dsa_slave_destroy(struct net_device *slave_dev)
 {
 	struct dsa_slave_priv *p = netdev_priv(slave_dev);
+	struct dsa_switch *ds = p->parent;
+	struct device_node *port_dn;
+
+	port_dn = ds->ports[p->port].dn;
 
 	netif_carrier_off(slave_dev);
-	if (p->phy)
+	if (p->phy) {
 		phy_disconnect(p->phy);
+
+		if (of_phy_is_fixed_link(port_dn))
+			of_phy_deregister_fixed_link(port_dn);
+	}
 	unregister_netdev(slave_dev);
 	free_netdev(slave_dev);
 }
-- 
2.7.3

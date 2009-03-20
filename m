Return-Path: <Joakim.Tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9A127DDDA0
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Mar 2009 06:43:59 +1100 (EST)
To: leoli@freescale.com,
	netdev@vger.kernel.org,
	linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Subject: Fw: [PATCH] ucc_geth: Correct fixed_link OOPS.
Message-ID: <OF20EA88BB.017079CD-ONC125757F.006C40A2-C125757F.006C646E@transmode.se>
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Fri, 20 Mar 2009 20:43:56 +0100
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

hmm, this mail didn't seem to reach the lists. Resending

 Jocke
----- Forwarded by Joakim Tjernlund/Transmode on 20/03/2009 20:42 -----

From:
Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To:
leoli@freescale.com, netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc:
Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date:
20/03/2009 18:01
Subject:
[PATCH] ucc_geth: Correct fixed_link OOPS.



fixed_link(PHY less) mode will get you an NULL
deference as it does not have a phy-handle.
Correct by using already probed information.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---

The below fixes the problem and seems like the right thing to do.
Can we have this in 2.6.29?

 drivers/net/ucc_geth.c |   17 +----------------
 1 files changed, 1 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index dc2f8f2..12e5c3d 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -1536,11 +1536,6 @@ static void adjust_link(struct net_device *dev)
 static int init_phy(struct net_device *dev)
 {
                 struct ucc_geth_private *priv = netdev_priv(dev);
-                struct device_node *np = priv->node;
-                struct device_node *phy, *mdio;
-                const phandle *ph;
-                char bus_name[MII_BUS_ID_SIZE];
-                const unsigned int *id;
                 struct phy_device *phydev;
                 char phy_id[BUS_ID_SIZE];
 
@@ -1548,18 +1543,8 @@ static int init_phy(struct net_device *dev)
                 priv->oldspeed = 0;
                 priv->oldduplex = -1;
 
-                ph = of_get_property(np, "phy-handle", NULL);
-                phy = of_find_node_by_phandle(*ph);
-                mdio = of_get_parent(phy);
-
-                id = of_get_property(phy, "reg", NULL);
-
-                of_node_put(phy);
-                of_node_put(mdio);
-
-                uec_mdio_bus_name(bus_name, mdio);
                 snprintf(phy_id, sizeof(phy_id), "%s:%02x",
-                                bus_name, *id);
+                                 priv->ug_info->mdio_bus, 
priv->ug_info->phy_address);
 
                 phydev = phy_connect(dev, phy_id, &adjust_link, 0, 
priv->phy_interface);
 
-- 
1.6.1.3

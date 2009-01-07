Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A83CCDE5DE
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 02:54:12 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: netdev@vger.kernel.org
Subject: [PATCH] gianfar: Fixup use of BUS_ID_SIZE
Date: Wed,  7 Jan 2009 09:52:01 -0600
Message-Id: <1231343521-22171-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, kay.sievers@vrfy.org, afleming@freescale.com,
	davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit b31a1d8b41513b96e9c7ec2f68c5734cef0b26a4 went back to using
BUS_ID_SIZE instead of sizeof() as per the larger patch series
that will remove "char bus_id[20]" from struct device.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 drivers/net/gianfar.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
index 7fcc3af..1b8deca 100644
--- a/drivers/net/gianfar.c
+++ b/drivers/net/gianfar.c
@@ -238,8 +238,8 @@ static int gfar_of_init(struct net_device *dev)
 			goto err_out;
 		}
 
-		snprintf(priv->phy_bus_id, BUS_ID_SIZE, PHY_ID_FMT, "0",
-				fixed_link[0]);
+		snprintf(priv->phy_bus_id, sizeof(priv->phy_bus_id),
+				PHY_ID_FMT, "0", fixed_link[0]);
 	} else {
 		phy = of_find_node_by_phandle(*ph);
 
@@ -256,7 +256,7 @@ static int gfar_of_init(struct net_device *dev)
 		of_node_put(mdio);
 
 		gfar_mdio_bus_name(bus_name, mdio);
-		snprintf(priv->phy_bus_id, BUS_ID_SIZE, "%s:%02x",
+		snprintf(priv->phy_bus_id, sizeof(priv->phy_bus_id), "%s:%02x",
 				bus_name, *id);
 	}
 
-- 
1.5.6.5

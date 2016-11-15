Return-Path: <f.fainelli@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJFj85j8qzDvkF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 05:07:24 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id y68so8349427pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 10:07:24 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, andrew@lunn.ch, tremyfr@gmail.com,
 Florian Fainelli <f.fainelli@gmail.com>, Li Yang <leoli@freescale.com>,
 linuxppc-dev@lists.ozlabs.org (open list:FREESCALE QUICC ENGINE UCC ETHERNET
 DRIVER), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 12/15] net: ethernet: ucc: Utilize phy_ethtool_nway_reset
Date: Tue, 15 Nov 2016 10:06:41 -0800
Message-Id: <20161115180644.3941-13-f.fainelli@gmail.com>
In-Reply-To: <20161115180644.3941-1-f.fainelli@gmail.com>
References: <20161115180644.3941-1-f.fainelli@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/freescale/ucc_geth_ethtool.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth_ethtool.c b/drivers/net/ethernet/freescale/ucc_geth_ethtool.c
index 812a968a78e9..8ba636f61b50 100644
--- a/drivers/net/ethernet/freescale/ucc_geth_ethtool.c
+++ b/drivers/net/ethernet/freescale/ucc_geth_ethtool.c
@@ -332,13 +332,6 @@ static void uec_get_ethtool_stats(struct net_device *netdev,
 	}
 }
 
-static int uec_nway_reset(struct net_device *netdev)
-{
-	struct ucc_geth_private *ugeth = netdev_priv(netdev);
-
-	return phy_start_aneg(ugeth->phydev);
-}
-
 /* Report driver information */
 static void
 uec_get_drvinfo(struct net_device *netdev,
@@ -394,7 +387,7 @@ static const struct ethtool_ops uec_ethtool_ops = {
 	.get_regs               = uec_get_regs,
 	.get_msglevel           = uec_get_msglevel,
 	.set_msglevel           = uec_set_msglevel,
-	.nway_reset             = uec_nway_reset,
+	.nway_reset             = phy_ethtool_nway_reset,
 	.get_link               = ethtool_op_get_link,
 	.get_ringparam          = uec_get_ringparam,
 	.set_ringparam          = uec_set_ringparam,
-- 
2.9.3

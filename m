Return-Path: <ukl@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1F2CD1A0A33
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Aug 2014 07:48:45 +1000 (EST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Li Yang <leoli@freescale.com>
Subject: [PATCH 1/3] net: ucc_geth: drop acquired references in probe error
 path and remove
Date: Thu,  7 Aug 2014 23:48:24 +0200
Message-Id: <1407448106-1819-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: netdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, kernel@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The ucc_geth_probe function assigns to ug_info->tbi_node and
ug_info->phy_node a value returned by of_parse_phandle which returns a
new reference. Put this reference again in the error path of
ucc_geth_probe and when removing the device.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
No Fixes: footer here. The problem already exists in v2.6.31-rc1 (e.g.
commit 0b9da337dca9 (net: Rework ucc_geth driver to use of_mdio
infrastructure)). Didn't continue to research a specific commit.
---
 drivers/net/ethernet/freescale/ucc_geth.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index 36fc429298e3..5f1aab9c4ee7 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -3864,8 +3864,11 @@ static int ucc_geth_probe(struct platform_device* ofdev)
 	/* Create an ethernet device instance */
 	dev = alloc_etherdev(sizeof(*ugeth));
 
-	if (dev == NULL)
+	if (dev == NULL) {
+		of_node_put(ug_info->tbi_node);
+		of_node_put(ug_info->phy_node);
 		return -ENOMEM;
+	}
 
 	ugeth = netdev_priv(dev);
 	spin_lock_init(&ugeth->lock);
@@ -3899,6 +3902,8 @@ static int ucc_geth_probe(struct platform_device* ofdev)
 			pr_err("%s: Cannot register net device, aborting\n",
 			       dev->name);
 		free_netdev(dev);
+		of_node_put(ug_info->tbi_node);
+		of_node_put(ug_info->phy_node);
 		return err;
 	}
 
@@ -3922,6 +3927,8 @@ static int ucc_geth_remove(struct platform_device* ofdev)
 	unregister_netdev(dev);
 	free_netdev(dev);
 	ucc_geth_memclean(ugeth);
+	of_node_put(ugeth->info->tbi_node);
+	of_node_put(ugeth->info->phy_node);
 
 	return 0;
 }
-- 
2.0.1

Return-Path: <ukl@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 874941A0A65
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Aug 2014 07:48:49 +1000 (EST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Li Yang <leoli@freescale.com>
Subject: [PATCH 2/3] net: ucc_geth: make probe consistently acquire a
 reference to the phy node
Date: Thu,  7 Aug 2014 23:48:25 +0200
Message-Id: <1407448106-1819-2-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1407448106-1819-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1407448106-1819-1-git-send-email-u.kleine-koenig@pengutronix.de>
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

When the driver attaches to a device that has a phy handle the probe
routine returns with a reference to that node. This reference is
correctly dropped in the error path and the remove function. In the
fixed phy case however no reference is acquired and so the error path
might drop a reference the driver isn't holding. Fix that by getting a
reference to the MAC.

Fixes: 87009814cdbb ("ucc_geth: use the new fixed PHY helpers")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/net/ethernet/freescale/ucc_geth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index 5f1aab9c4ee7..a22ff770f9e5 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -3796,7 +3796,7 @@ static int ucc_geth_probe(struct platform_device* ofdev)
 			if (err)
 				return err;
 		}
-		ug_info->phy_node = np;
+		ug_info->phy_node = of_node_get(np);
 	}
 
 	/* Find the TBI PHY node.  If it's not there, we don't support SGMII */
-- 
2.0.1

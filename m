Return-Path: <ukl@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440FA1A0823
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Aug 2014 04:32:28 +1000 (EST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: David Miller <davem@davemloft.net>
Subject: [PATCH] net: ucc_geth: fix build failure
Date: Sun, 10 Aug 2014 20:32:05 +0200
Message-Id: <1407695525-32227-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20140808.135237.120203200807493642.davem@davemloft.net>
References: <20140808.135237.120203200807493642.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Florian Fainelli <f.fainelli@gmail.com>, kernel@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

My series to fix the reference counting of dt nodes introduced a build
failure. Fix it.

Fixes: fa310789a488 ("net: ucc_geth: drop acquired references in probe error path and remove")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

I found a powerpc toolchain now, so this really builds now. Sorry for the
inconvenience.

Uwe

 drivers/net/ethernet/freescale/ucc_geth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index d6b64e316527..3cf0478b3728 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -3924,8 +3924,8 @@ static int ucc_geth_remove(struct platform_device* ofdev)
 	unregister_netdev(dev);
 	free_netdev(dev);
 	ucc_geth_memclean(ugeth);
-	of_node_put(ugeth->info->tbi_node);
-	of_node_put(ugeth->info->phy_node);
+	of_node_put(ugeth->ug_info->tbi_node);
+	of_node_put(ugeth->ug_info->phy_node);
 
 	return 0;
 }
-- 
2.0.1

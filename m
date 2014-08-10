Return-Path: <groeck7@gmail.com>
Received: from mail-pa0-x22e.google.com (mail-pa0-x22e.google.com
 [IPv6:2607:f8b0:400e:c03::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C69B11A018C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Aug 2014 02:19:22 +1000 (EST)
Received: by mail-pa0-f46.google.com with SMTP id lj1so9736108pab.5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Aug 2014 09:19:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Li Yang <leoli@freescale.com>
Subject: [PATCH] net: ugg_geth: Fix build error in -next
Date: Sun, 10 Aug 2014 09:19:14 -0700
Message-Id: <1407687554-14539-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>,
 Guenter Roeck <linux@roeck-us.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc:mpc83xx_defconfig and other builds fail with

drivers/net/ethernet/freescale/ucc_geth.c: In function 'ucc_geth_remove':
drivers/net/ethernet/freescale/ucc_geth.c:3927:19: error:
	'struct ucc_geth_private' has no member named 'info'
  of_node_put(ugeth->info->tbi_node);
                     ^
drivers/net/ethernet/freescale/ucc_geth.c:3928:19: error:
	     'struct ucc_geth_private' has no member named 'info'
  of_node_put(ugeth->info->phy_node);
  		     ^

Introduced by commit "net: ucc_geth: drop acquired references in probe error
path and remove".

>From the context, it appears that the variable is named ug_info.

Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Only seen in -next.

 drivers/net/ethernet/freescale/ucc_geth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index d6b64e3..3cf0478 100644
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
1.9.1

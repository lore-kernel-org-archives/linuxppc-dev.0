Return-Path: <xerofoify@gmail.com>
Received: from mail-ie0-x234.google.com (mail-ie0-x234.google.com
 [IPv6:2607:f8b0:4001:c03::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 326C51A0D75
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 05:36:38 +1000 (AEST)
Received: by iebmu5 with SMTP id mu5so141181960ieb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2015 12:36:35 -0700 (PDT)
From: Nicholas Krause <xerofoify@gmail.com>
To: leoli@freescale.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] freescale:Make the function ucc_geth_tx have a return type of
 void
Date: Tue,  7 Jul 2015 15:36:29 -0400
Message-Id: <1436297789-31422-1-git-send-email-xerofoify@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This makes the function ucc_geth_tx have a return type of void now
due to this particular function always completing without ever
executing a non recoverable error.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 drivers/net/ethernet/freescale/ucc_geth.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index 78ebd73..70f3045 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -3226,7 +3226,7 @@ static int ucc_geth_rx(struct ucc_geth_private *ugeth, u8 rxQ, int rx_work_limit
 	return howmany;
 }
 
-static int ucc_geth_tx(struct net_device *dev, u8 txQ)
+static void ucc_geth_tx(struct net_device *dev, u8 txQ)
 {
 	/* Start from the next BD that should be filled */
 	struct ucc_geth_private *ugeth = netdev_priv(dev);
@@ -3269,7 +3269,6 @@ static int ucc_geth_tx(struct net_device *dev, u8 txQ)
 		bd_status = in_be32((u32 __iomem *)bd);
 	}
 	ugeth->confBd[txQ] = bd;
-	return 0;
 }
 
 static int ucc_geth_poll(struct napi_struct *napi, int budget)
-- 
2.1.4

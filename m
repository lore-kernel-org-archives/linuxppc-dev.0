Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id C7C2B101309
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 09:59:04 +1100 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: netdev@vger.kernel.org
Date: Mon, 16 Nov 2009 23:57:48 +0100
Message-Id: <1258412274-14686-6-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1258412274-14686-1-git-send-email-w.sang@pengutronix.de>
References: <1258412274-14686-1-git-send-email-w.sang@pengutronix.de>
Subject: [PATCH 05/11] net/can/mscan: fix function annotations
Cc: socketcan-core@lists.berlios.de, linuxppc-dev@ozlabs.org,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

- use extern where apropriate
- don't export symbols

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/net/can/mscan/mscan.c |    3 ---
 drivers/net/can/mscan/mscan.h |    2 +-
 2 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/mscan/mscan.c b/drivers/net/can/mscan/mscan.c
index ca8b556..76e413e 100644
--- a/drivers/net/can/mscan/mscan.c
+++ b/drivers/net/can/mscan/mscan.c
@@ -611,7 +611,6 @@ int register_mscandev(struct net_device *dev, int clock_src)
 
 	return register_candev(dev);
 }
-EXPORT_SYMBOL_GPL(register_mscandev);
 
 void unregister_mscandev(struct net_device *dev)
 {
@@ -621,7 +620,6 @@ void unregister_mscandev(struct net_device *dev)
 	clrbits8(&regs->canctl1, MSCAN_CANE);
 	unregister_candev(dev);
 }
-EXPORT_SYMBOL_GPL(unregister_mscandev);
 
 struct net_device *alloc_mscandev(void)
 {
@@ -651,7 +649,6 @@ struct net_device *alloc_mscandev(void)
 
 	return dev;
 }
-EXPORT_SYMBOL_GPL(alloc_mscandev);
 
 MODULE_AUTHOR("Andrey Volkov <avolkov@varma-el.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/net/can/mscan/mscan.h b/drivers/net/can/mscan/mscan.h
index 76a8abf..2018000 100644
--- a/drivers/net/can/mscan/mscan.h
+++ b/drivers/net/can/mscan/mscan.h
@@ -279,7 +279,7 @@ struct mscan_priv {
 	struct napi_struct napi;
 };
 
-struct net_device *alloc_mscandev(void);
+extern struct net_device *alloc_mscandev(void);
 /*
  * clock_src:
  *	1 = The MSCAN clock source is the onchip Bus Clock.
-- 
1.6.3.3

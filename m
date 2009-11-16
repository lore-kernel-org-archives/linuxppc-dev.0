Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 482C910278F
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 10:00:42 +1100 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: netdev@vger.kernel.org
Date: Mon, 16 Nov 2009 23:57:53 +0100
Message-Id: <1258412274-14686-11-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1258412274-14686-1-git-send-email-w.sang@pengutronix.de>
References: <1258412274-14686-1-git-send-email-w.sang@pengutronix.de>
Subject: [PATCH 10/11] net/can/mscan: add error path to mscan_open()
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

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/net/can/mscan/mscan.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/mscan/mscan.c b/drivers/net/can/mscan/mscan.c
index 263d1a9..bb06dfb 100644
--- a/drivers/net/can/mscan/mscan.c
+++ b/drivers/net/can/mscan/mscan.c
@@ -542,10 +542,8 @@ static int mscan_open(struct net_device *dev)
 
 	ret = request_irq(dev->irq, mscan_isr, 0, dev->name, dev);
 	if (ret < 0) {
-		napi_disable(&priv->napi);
-		printk(KERN_ERR "%s - failed to attach interrupt\n",
-		       dev->name);
-		return ret;
+		dev_err(dev->dev.parent, "failed to attach interrupt\n");
+		goto exit_napi_disable;
 	}
 
 	priv->open_time = jiffies;
@@ -554,11 +552,19 @@ static int mscan_open(struct net_device *dev)
 
 	ret = mscan_start(dev);
 	if (ret)
-		return ret;
+		goto exit_free_irq;
 
 	netif_start_queue(dev);
 
 	return 0;
+
+exit_free_irq:
+	priv->open_time = 0;
+	free_irq(dev->irq, dev);
+exit_napi_disable:
+	napi_disable(&priv->napi);
+	close_candev(dev);
+	return ret;
 }
 
 static int mscan_close(struct net_device *dev)
-- 
1.6.3.3

Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id E5D84B7DDA
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 09:58:28 +1100 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: netdev@vger.kernel.org
Date: Mon, 16 Nov 2009 23:57:46 +0100
Message-Id: <1258412274-14686-4-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1258412274-14686-1-git-send-email-w.sang@pengutronix.de>
References: <1258412274-14686-1-git-send-email-w.sang@pengutronix.de>
Subject: [PATCH 03/11] net/can/mscan: drop support for CAN_MODE_{SLEEP|STOP}
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

The upper layer does not support it yet.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/net/can/mscan/mscan.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/mscan/mscan.c b/drivers/net/can/mscan/mscan.c
index 6394de8..839b471 100644
--- a/drivers/net/can/mscan/mscan.c
+++ b/drivers/net/can/mscan/mscan.c
@@ -487,14 +487,6 @@ static int mscan_do_set_mode(struct net_device *dev, enum can_mode mode)
 		return -EINVAL;
 
 	switch (mode) {
-	case CAN_MODE_SLEEP:
-	case CAN_MODE_STOP:
-		netif_stop_queue(dev);
-		mscan_set_mode(dev,
-			       (mode ==
-				CAN_MODE_STOP) ? MSCAN_INIT_MODE :
-			       MSCAN_SLEEP_MODE);
-		break;
 	case CAN_MODE_START:
 		if (priv->can.state <= CAN_STATE_BUS_OFF)
 			mscan_set_mode(dev, MSCAN_INIT_MODE);
-- 
1.6.3.3

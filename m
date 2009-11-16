Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id CA741100B17
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 09:59:26 +1100 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: netdev@vger.kernel.org
Date: Mon, 16 Nov 2009 23:57:49 +0100
Message-Id: <1258412274-14686-7-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1258412274-14686-1-git-send-email-w.sang@pengutronix.de>
References: <1258412274-14686-1-git-send-email-w.sang@pengutronix.de>
Subject: [PATCH 06/11] net/can/mscan: drop assignment in while-construct
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

As suggested by Wolfgang Grandegger.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/net/can/mscan/mscan.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/mscan/mscan.c b/drivers/net/can/mscan/mscan.c
index 76e413e..20d1991 100644
--- a/drivers/net/can/mscan/mscan.c
+++ b/drivers/net/can/mscan/mscan.c
@@ -379,8 +379,10 @@ static int mscan_rx_poll(struct napi_struct *napi, int quota)
 	struct can_frame *frame;
 	u8 canrflg;
 
-	while (npackets < quota && ((canrflg = in_8(&regs->canrflg)) &
-				    (MSCAN_RXF | MSCAN_ERR_IF))) {
+	while (npackets < quota) {
+		canrflg = in_8(&regs->canrflg);
+		if (!(canrflg & (MSCAN_RXF | MSCAN_ERR_IF)))
+			break;
 
 		skb = alloc_can_skb(dev, &frame);
 		if (!skb) {
-- 
1.6.3.3

Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 84CFA102489
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 10:00:34 +1100 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: netdev@vger.kernel.org
Date: Mon, 16 Nov 2009 23:57:52 +0100
Message-Id: <1258412274-14686-10-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1258412274-14686-1-git-send-email-w.sang@pengutronix.de>
References: <1258412274-14686-1-git-send-email-w.sang@pengutronix.de>
Subject: [PATCH 09/11] net/can/mscan: replace hardcoded values with defines
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

Not all hardcoded values have been replaced as this made the code quite
unreadable. IMHO this compromise serves the purpose of readability.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/net/can/mscan/mscan.c |   15 ++++++++++-----
 drivers/net/can/mscan/mscan.h |    5 +++++
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/mscan/mscan.c b/drivers/net/can/mscan/mscan.c
index 20d1991..263d1a9 100644
--- a/drivers/net/can/mscan/mscan.c
+++ b/drivers/net/can/mscan/mscan.c
@@ -211,18 +211,23 @@ static netdev_tx_t mscan_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	rtr = frame->can_id & CAN_RTR_FLAG;
 
+	/* RTR is always the lowest bit of interest, then IDs follow */
 	if (frame->can_id & CAN_EFF_FLAG) {
-		can_id = (frame->can_id & CAN_EFF_MASK) << 1;
+		can_id = (frame->can_id & CAN_EFF_MASK)
+			 << (MSCAN_EFF_RTR_SHIFT + 1);
 		if (rtr)
-			can_id |= 1;
+			can_id |= 1 << MSCAN_EFF_RTR_SHIFT;
 		out_be16(&regs->tx.idr3_2, can_id);
 
 		can_id >>= 16;
-		can_id = (can_id & 0x7) | ((can_id << 2) & 0xffe0) | (3 << 3);
+		/* EFF_FLAGS are inbetween the IDs :( */
+		can_id = (can_id & 0x7) | ((can_id << 2) & 0xffe0)
+			 | MSCAN_EFF_FLAGS;
 	} else {
-		can_id = (frame->can_id & CAN_SFF_MASK) << 5;
+		can_id = (frame->can_id & CAN_SFF_MASK)
+			 << (MSCAN_SFF_RTR_SHIFT + 1);
 		if (rtr)
-			can_id |= 1 << 4;
+			can_id |= 1 << MSCAN_SFF_RTR_SHIFT;
 	}
 	out_be16(&regs->tx.idr1_0, can_id);
 
diff --git a/drivers/net/can/mscan/mscan.h b/drivers/net/can/mscan/mscan.h
index 2018000..00fc4aa 100644
--- a/drivers/net/can/mscan/mscan.h
+++ b/drivers/net/can/mscan/mscan.h
@@ -131,6 +131,11 @@
 /* MSCAN Miscellaneous Register (CANMISC) bits */
 #define MSCAN_BOHOLD		0x01
 
+/* MSCAN Identifier Register (IDR) bits */
+#define MSCAN_SFF_RTR_SHIFT	4
+#define MSCAN_EFF_RTR_SHIFT	0
+#define MSCAN_EFF_FLAGS		0x18	/* IDE + SRR */
+
 #ifdef MSCAN_FOR_MPC5200
 #define _MSCAN_RESERVED_(n, num) u8 _res##n[num]
 #define _MSCAN_RESERVED_DSR_SIZE	2
-- 
1.6.3.3

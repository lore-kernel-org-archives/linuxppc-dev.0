Return-Path: <wg@denx.de>
From: Wolfgang Grandegger <wg@grandegger.com>
To: Netdev@vger.kernel.org
Subject: [PATCH net-next v4 1/3] can: mscan: fix improper return if dlc < 8 in
	start_xmit function
Date: Thu,  7 Jan 2010 20:43:06 +0100
Message-Id: <1262893388-16218-2-git-send-email-wg@grandegger.com>
In-Reply-To: <1262893388-16218-1-git-send-email-wg@grandegger.com>
References: <1262893388-16218-1-git-send-email-wg@grandegger.com>
Cc: Socketcan-core@lists.berlios.de, Devicetree-discuss@lists.ozlabs.org,
	Linuxppc-dev@lists.ozlabs.org, Wolfgang Grandegger <wg@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wolfgang Grandegger <wg@denx.de>

The start_xmit function of the MSCAN Driver did return improperly if
the CAN dlc check failed (skb not freed and invalid return code). This
patch adds a proper check of the frame lenght and data size and returns
now correctly. The invalid skb packets are dropped silently as suggested
by David Miller in the thread "[RFC] ndo_validate_skb: Let the netdev
check a valid skb content" on the netdev mailing list.

Furthermore, a typo has been fixed.

Signed-off-by: Wolfgang Grandegger <wg@denx.de>
Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/net/can/mscan/mscan.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/mscan/mscan.c b/drivers/net/can/mscan/mscan.c
index 07346f8..0dcbe8c 100644
--- a/drivers/net/can/mscan/mscan.c
+++ b/drivers/net/can/mscan/mscan.c
@@ -4,7 +4,7 @@
  * Copyright (C) 2005-2006 Andrey Volkov <avolkov@varma-el.com>,
  *                         Varma Electronics Oy
  * Copyright (C) 2008-2009 Wolfgang Grandegger <wg@grandegger.com>
- * Copytight (C) 2008-2009 Pengutronix <kernel@pengutronix.de>
+ * Copyright (C) 2008-2009 Pengutronix <kernel@pengutronix.de>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the version 2 of the GNU General Public License
@@ -177,8 +177,11 @@ static netdev_tx_t mscan_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	int i, rtr, buf_id;
 	u32 can_id;
 
-	if (frame->can_dlc > 8)
-		return -EINVAL;
+	if (skb->len != sizeof(*frame) || frame->can_dlc > 8) {
+		kfree_skb(skb);
+		dev->stats.tx_dropped++;
+		return NETDEV_TX_OK;
+	}
 
 	out_8(&regs->cantier, 0);
 
-- 
1.6.2.5

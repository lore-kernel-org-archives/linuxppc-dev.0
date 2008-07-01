Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id E5948DE1F8
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 18:58:27 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org,
	netdev@vger.kernel.org
Subject: [PATCH v2] ibm_newemac: Fixes entry of short packets
Date: Tue,  1 Jul 2008 10:58:19 +0200
Message-Id: <1214902699-10534-1-git-send-email-sr@denx.de>
Cc: Sathya Narayanan <sathyan@teamf1.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Sathya Narayanan <sathyan@teamf1.com>

Short packets has to be discarded by the driver. So this patch addresses the
issue of discarding the short packets of size lesser then ethernet header
size.

Signed-off-by: Sathya Narayanan <sathyan@teamf1.com>
Signed-off-by: Stefan Roese <sr@denx.de>
---
 drivers/net/ibm_newemac/core.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ibm_newemac/core.c b/drivers/net/ibm_newemac/core.c
index ca63fa0..babc79a 100644
--- a/drivers/net/ibm_newemac/core.c
+++ b/drivers/net/ibm_newemac/core.c
@@ -1636,6 +1636,12 @@ static int emac_poll_rx(void *param, int budget)
 			goto next;
 		}
 
+		if (len < ETH_HLEN) {
+			++dev->estats.rx_dropped_stack;
+			emac_recycle_rx_skb(dev, slot, len);
+			goto next;
+		}
+
 		if (len && len < EMAC_RX_COPY_THRESH) {
 			struct sk_buff *copy_skb =
 			    alloc_skb(len + EMAC_RX_SKB_HEADROOM + 2, GFP_ATOMIC);
-- 
1.5.6.1

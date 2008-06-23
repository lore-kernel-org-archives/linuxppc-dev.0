Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 0FD36DE164
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jun 2008 22:55:09 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org,
	netdev@vger.kernel.org
Subject: [PATCH] ibm_newemac: Fixes entry of short packets
Date: Mon, 23 Jun 2008 14:55:05 +0200
Message-Id: <1214225705-25850-1-git-send-email-sr@denx.de>
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
 drivers/net/ibm_newemac/core.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ibm_newemac/core.c b/drivers/net/ibm_newemac/core.c
index 6dfc2c9..aa407b2 100644
--- a/drivers/net/ibm_newemac/core.c
+++ b/drivers/net/ibm_newemac/core.c
@@ -1652,6 +1652,13 @@ static int emac_poll_rx(void *param, int budget)
 
 		skb_put(skb, len);
 	push_packet:
+		if (skb->len < ETH_HLEN) {
+			dev_kfree_skb(skb);
+			printk(KERN_WARNING "%s: short packets dropped\n",
+			       dev->ndev->name);
+			++dev->estats.rx_dropped_stack;
+			goto next;
+		}
 		skb->dev = dev->ndev;
 		skb->protocol = eth_type_trans(skb, dev->ndev);
 		emac_rx_csum(dev, skb, ctrl);
-- 
1.5.6

Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 5A1E3DDF35
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 18:58:12 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org,
	netdev@vger.kernel.org
Subject: [PATCH v3] ibm_newemac: Fixes kernel crashes when speed of cable
	connected changes
Date: Tue,  1 Jul 2008 10:58:05 +0200
Message-Id: <1214902685-10489-1-git-send-email-sr@denx.de>
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

The descriptor pointers were not initialized to NIL values, so it was
poiniting to some random addresses which was completely invalid. This
fix takes care of initializing the descriptor to NIL values and clearing
the valid descriptors on clean ring operation.

Signed-off-by: Sathya Narayanan <sathyan@teamf1.com>
Signed-off-by: Stefan Roese <sr@denx.de>
---
 drivers/net/ibm_newemac/core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ibm_newemac/core.c b/drivers/net/ibm_newemac/core.c
index 5d2108c..ca63fa0 100644
--- a/drivers/net/ibm_newemac/core.c
+++ b/drivers/net/ibm_newemac/core.c
@@ -2719,6 +2719,8 @@ static int __devinit emac_probe(struct of_device *ofdev,
 	/* Clean rings */
 	memset(dev->tx_desc, 0, NUM_TX_BUFF * sizeof(struct mal_descriptor));
 	memset(dev->rx_desc, 0, NUM_RX_BUFF * sizeof(struct mal_descriptor));
+	memset(dev->tx_skb, 0, NUM_TX_BUFF * sizeof(struct sk_buff *));
+	memset(dev->rx_skb, 0, NUM_RX_BUFF * sizeof(struct sk_buff *));
 
 	/* Attach to ZMII, if needed */
 	if (emac_has_feature(dev, EMAC_FTR_HAS_ZMII) &&
-- 
1.5.6.1

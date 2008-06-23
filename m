Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 42275DE13D
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 04:36:16 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org,
	netdev@vger.kernel.org
Subject: [PATCH V2] ibm_newemac: Fixes kernel crashes when speed of cable
	connected changes
Date: Mon, 23 Jun 2008 20:36:02 +0200
Message-Id: <1214246162-25293-1-git-send-email-sr@denx.de>
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
Changed since V1:
- Fixed off-by-one error in for loops

 drivers/net/ibm_newemac/core.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ibm_newemac/core.c b/drivers/net/ibm_newemac/core.c
index 5d2108c..6dfc2c9 100644
--- a/drivers/net/ibm_newemac/core.c
+++ b/drivers/net/ibm_newemac/core.c
@@ -1025,7 +1025,7 @@ static void emac_clean_tx_ring(struct emac_instance *dev)
 	int i;
 
 	for (i = 0; i < NUM_TX_BUFF; ++i) {
-		if (dev->tx_skb[i]) {
+		if (dev->tx_skb[i] && dev->tx_desc[i].data_ptr) {
 			dev_kfree_skb(dev->tx_skb[i]);
 			dev->tx_skb[i] = NULL;
 			if (dev->tx_desc[i].ctrl & MAL_TX_CTRL_READY)
@@ -2719,6 +2719,10 @@ static int __devinit emac_probe(struct of_device *ofdev,
 	/* Clean rings */
 	memset(dev->tx_desc, 0, NUM_TX_BUFF * sizeof(struct mal_descriptor));
 	memset(dev->rx_desc, 0, NUM_RX_BUFF * sizeof(struct mal_descriptor));
+	for (i = 0; i < NUM_TX_BUFF; i++)
+		dev->tx_skb[i] = NULL;
+	for (i = 0; i < NUM_RX_BUFF; i++)
+		dev->rx_skb[i] = NULL;
 
 	/* Attach to ZMII, if needed */
 	if (emac_has_feature(dev, EMAC_FTR_HAS_ZMII) &&
-- 
1.5.6

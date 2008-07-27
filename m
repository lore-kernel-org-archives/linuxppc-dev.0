Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id AEE5ADDE41
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 02:14:26 +1000 (EST)
Date: Mon, 28 Jul 2008 02:14:24 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
	<paulus@samba.org>
Subject: [PATCH] powerpc/ibmveth: fix multiple errors with dma_mapping_error
	conversion
Message-Id: <20080728021424.40cf66bc.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Jeff Garzik <jeff@garzik.org>, LKML <linux-kernel@vger.kernel.org>,
	Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	ppc-dev <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>, FUJITA
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The addition of an argument to dma_mapping_error() in commit
8d8bb39b9eba32dd70e87fd5ad5c5dd4ba118e06 "dma-mapping: add the device
argument to dma_mapping_error()" left a bit of fallout:

drivers/net/ibmveth.c:263: error: too few arguments to function 'dma_mapping_error'
drivers/net/ibmveth.c:264: error: expected ')' before 'goto'
drivers/net/ibmveth.c:284: error: expected expression before '}' token
drivers/net/ibmveth.c:297: error: too few arguments to function 'dma_mapping_error'
drivers/net/ibmveth.c:298: error: expected ')' before 'dma_unmap_single'
drivers/net/ibmveth.c:306: error: expected expression before '}' token
drivers/net/ibmveth.c:491: error: too few arguments to function 'dma_mapping_error'
drivers/net/ibmveth.c:927: error: too few arguments to function 'dma_mapping_error'
drivers/net/ibmveth.c:927: error: expected ')' before '{' token
drivers/net/ibmveth.c:974: error: expected expression before '}' token
drivers/net/ibmveth.c:914: error: label 'out' used but not defined m

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/net/ibmveth.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

Compiler tested for ppc64_defconfig.

diff --git a/drivers/net/ibmveth.c b/drivers/net/ibmveth.c
index 91ec9fd..a03fe1f 100644
--- a/drivers/net/ibmveth.c
+++ b/drivers/net/ibmveth.c
@@ -260,7 +260,7 @@ static void ibmveth_replenish_buffer_pool(struct ibmveth_adapter *adapter, struc
 		dma_addr = dma_map_single(&adapter->vdev->dev, skb->data,
 				pool->buff_size, DMA_FROM_DEVICE);
 
-		if (dma_mapping_error((&adapter->vdev->dev, dma_addr))
+		if (dma_mapping_error(&adapter->vdev->dev, dma_addr))
 			goto failure;
 
 		pool->free_map[free_index] = IBM_VETH_INVALID_MAP;
@@ -294,7 +294,7 @@ failure:
 		pool->consumer_index = pool->size - 1;
 	else
 		pool->consumer_index--;
-	if (!dma_mapping_error((&adapter->vdev->dev, dma_addr))
+	if (!dma_mapping_error(&adapter->vdev->dev, dma_addr))
 		dma_unmap_single(&adapter->vdev->dev,
 		                 pool->dma_addr[index], pool->buff_size,
 		                 DMA_FROM_DEVICE);
@@ -488,7 +488,7 @@ static void ibmveth_cleanup(struct ibmveth_adapter *adapter)
 						 &adapter->rx_buff_pool[i]);
 
 	if (adapter->bounce_buffer != NULL) {
-		if (!dma_mapping_error(adapter->bounce_buffer_dma)) {
+		if (!dma_mapping_error(dev, adapter->bounce_buffer_dma)) {
 			dma_unmap_single(&adapter->vdev->dev,
 					adapter->bounce_buffer_dma,
 					adapter->netdev->mtu + IBMVETH_BUFF_OH,
@@ -924,7 +924,7 @@ static int ibmveth_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 		buf[1] = 0;
 	}
 
-	if (dma_mapping_error((&adapter->vdev->dev, data_dma_addr)) {
+	if (dma_mapping_error(&adapter->vdev->dev, data_dma_addr)) {
 		if (!firmware_has_feature(FW_FEATURE_CMO))
 			ibmveth_error_printk("tx: unable to map xmit buffer\n");
 		skb_copy_from_linear_data(skb, adapter->bounce_buffer,
-- 
1.5.6.3

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

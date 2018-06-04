Return-Path: <yuehaibing@huawei.com>
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zwd527FLzF1Hj
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jun 2018 23:24:08 +1000 (AEST)
From: YueHaibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <qiang.zhao@nxp.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] wan/fsl_ucc_hdlc: use dma_zalloc_coherent instead of
 allocator/memset
Date: Mon, 4 Jun 2018 21:07:59 +0800
Message-ID: <20180604130759.25024-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use dma_zalloc_coherent instead of dma_alloc_coherent
followed by memset 0.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 33df764..4205dfd 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -270,10 +270,10 @@ static int uhdlc_init(struct ucc_hdlc_private *priv)
 	iowrite16be(DEFAULT_HDLC_ADDR, &priv->ucc_pram->haddr4);
 
 	/* Get BD buffer */
-	bd_buffer = dma_alloc_coherent(priv->dev,
-				       (RX_BD_RING_LEN + TX_BD_RING_LEN) *
-				       MAX_RX_BUF_LENGTH,
-				       &bd_dma_addr, GFP_KERNEL);
+	bd_buffer = dma_zalloc_coherent(priv->dev,
+					(RX_BD_RING_LEN + TX_BD_RING_LEN) *
+					MAX_RX_BUF_LENGTH,
+					&bd_dma_addr, GFP_KERNEL);
 
 	if (!bd_buffer) {
 		dev_err(priv->dev, "Could not allocate buffer descriptors\n");
@@ -281,9 +281,6 @@ static int uhdlc_init(struct ucc_hdlc_private *priv)
 		goto free_tiptr;
 	}
 
-	memset(bd_buffer, 0, (RX_BD_RING_LEN + TX_BD_RING_LEN)
-			* MAX_RX_BUF_LENGTH);
-
 	priv->rx_buffer = bd_buffer;
 	priv->tx_buffer = bd_buffer + RX_BD_RING_LEN * MAX_RX_BUF_LENGTH;
 
-- 
2.7.0

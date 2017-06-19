Return-Path: <madalin.bucur@nxp.com>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam01on0051.outbound.protection.outlook.com [104.47.32.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wrvQX1sl5zDqgX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 01:04:36 +1000 (AEST)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Madalin
 Bucur <madalin.bucur@nxp.com>
Subject: [PATCH 2/2] dpaa_eth: reuse the dma_ops provided by the FMan MAC
 device
Date: Mon, 19 Jun 2017 18:04:17 +0300
Message-ID: <1497884657-3744-3-git-send-email-madalin.bucur@nxp.com>
In-Reply-To: <1497884657-3744-1-git-send-email-madalin.bucur@nxp.com>
References: <1497884657-3744-1-git-send-email-madalin.bucur@nxp.com>
Reply-To: <madalin.bucur@nxp.com>
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

Remove the use of arch_setup_dma_ops() that was not exported
and was breaking loadable module compilation.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index 9a520e4..290ad05 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2647,7 +2647,7 @@ static int dpaa_eth_probe(struct platform_device *pdev)
 	priv->buf_layout[TX].priv_data_size = DPAA_TX_PRIV_DATA_SIZE; /* Tx */
 
 	/* device used for DMA mapping */
-	arch_setup_dma_ops(dev, 0, 0, NULL, false);
+	set_dma_ops(dev, get_dma_ops(&pdev->dev));
 	err = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(40));
 	if (err) {
 		dev_err(dev, "dma_coerce_mask_and_coherent() failed\n");
-- 
2.1.0

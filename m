Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 851B91A0A43
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Oct 2014 20:14:40 +1100 (EST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 wenxiong@linux.vnet.ibm.com, brking@linux.vnet.ibm.com,
 scottwood@freescale.com
Subject: [PATCH 2/2] ipr: set coherent DMA mask
Date: Mon, 13 Oct 2014 20:14:36 +1100
Message-Id: <1413191676-1663-2-git-send-email-anton@samba.org>
In-Reply-To: <1413191676-1663-1-git-send-email-anton@samba.org>
References: <1413191676-1663-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-scsi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use dma_set_mask_and_coherent() to set both the DMA and coherent
DMA mask.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 drivers/scsi/ipr.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index 3aa28bd..15f4575 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -9611,16 +9611,17 @@ static int ipr_probe_ioa(struct pci_dev *pdev,
 	ipr_init_regs(ioa_cfg);
 
 	if (ioa_cfg->sis64) {
-		rc = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
+		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 		if (rc < 0) {
-			dev_dbg(&pdev->dev, "Failed to set 64 bit PCI DMA mask\n");
-			rc = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
+			dev_dbg(&pdev->dev, "Failed to set 64 bit DMA mask\n");
+			rc = dma_set_mask_and_coherent(&pdev->dev,
+						       DMA_BIT_MASK(32));
 		}
 	} else
-		rc = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
+		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 
 	if (rc < 0) {
-		dev_err(&pdev->dev, "Failed to set PCI DMA mask\n");
+		dev_err(&pdev->dev, "Failed to set DMA mask\n");
 		goto cleanup_nomem;
 	}
 
-- 
1.9.1

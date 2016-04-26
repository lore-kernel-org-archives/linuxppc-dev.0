Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qvHFN4z8fzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 19:03:36 +1000 (AEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Christian Lamparter <chunkeey@googlemail.com>,
 =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>,
 Julian Margetson <runaway@candw.ms>
Subject: [PATCH v2 13/23] ata: sata_dwc_460ex: remove empty libata callback
Date: Tue, 26 Apr 2016 12:03:14 +0300
Message-Id: <1461661404-1952-14-git-send-email-andriy.shevchenko@linux.intel.com>
In-Reply-To: <1461661404-1952-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1461661404-1952-1-git-send-email-andriy.shevchenko@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mans Rullgard <mans@mansr.com>

The sata_dwc_qc_prep() does nothing.  Use the default ata_noop_qc_prep
instead.

Tested-by: Christian Lamparter <chunkeey@googlemail.com>
Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/ata/sata_dwc_460ex.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 2258baf..3a9dd82 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1132,27 +1132,6 @@ static unsigned int sata_dwc_qc_issue(struct ata_queued_cmd *qc)
 	return 0;
 }
 
-/*
- * Function : sata_dwc_qc_prep
- * arguments : ata_queued_cmd *qc
- * Return value : None
- * qc_prep for a particular queued command
- */
-
-static void sata_dwc_qc_prep(struct ata_queued_cmd *qc)
-{
-	if ((qc->dma_dir == DMA_NONE) || (qc->tf.protocol == ATA_PROT_PIO))
-		return;
-
-#ifdef DEBUG_NCQ
-	if (qc->tag > 0)
-		dev_info(qc->ap->dev, "%s: qc->tag=%d ap->active_tag=0x%08x\n",
-			 __func__, qc->tag, qc->ap->link.active_tag);
-
-	return ;
-#endif
-}
-
 static void sata_dwc_error_handler(struct ata_port *ap)
 {
 	ata_sff_error_handler(ap);
@@ -1212,7 +1191,6 @@ static struct ata_port_operations sata_dwc_ops = {
 	.error_handler		= sata_dwc_error_handler,
 	.hardreset		= sata_dwc_hardreset,
 
-	.qc_prep		= sata_dwc_qc_prep,
 	.qc_issue		= sata_dwc_qc_issue,
 
 	.scr_read		= sata_dwc_scr_read,
-- 
2.8.0.rc3

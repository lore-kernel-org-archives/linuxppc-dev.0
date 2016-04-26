Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qvHFH2y4wzDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 19:03:31 +1000 (AEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Christian Lamparter <chunkeey@googlemail.com>,
 =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>,
 Julian Margetson <runaway@candw.ms>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 03/23] ata: sata_dwc_460ex: set dma_boundary to 0x1fff
Date: Tue, 26 Apr 2016 12:03:04 +0300
Message-Id: <1461661404-1952-4-git-send-email-andriy.shevchenko@linux.intel.com>
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

The original code states:

	Make sure a LLI block is not created that will span 8K max FIS
	boundary. If the block spans such a FIS boundary, there is a chance
	that a DMA burst will cross that boundary -- this results in an error
	in the host controller.

Since we have switched to generic DMAengine API we satisfy above by setting
dma_boundary value to 0x1fff.

Suggested-by: Mans Rullgard <mans@mansr.com>
Tested-by: Christian Lamparter <chunkeey@googlemail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ata/sata_dwc_460ex.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 7f95389..aee8873 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1151,7 +1151,13 @@ static struct scsi_host_template sata_dwc_sht = {
 	 */
 	.sg_tablesize		= LIBATA_MAX_PRD,
 	/* .can_queue		= ATA_MAX_QUEUE, */
-	.dma_boundary		= ATA_DMA_BOUNDARY,
+	/*
+	 * Make sure a LLI block is not created that will span 8K max FIS
+	 * boundary. If the block spans such a FIS boundary, there is a chance
+	 * that a DMA burst will cross that boundary -- this results in an
+	 * error in the host controller.
+	 */
+	.dma_boundary		= 0x1fff /* ATA_DMA_BOUNDARY */,
 };
 
 static struct ata_port_operations sata_dwc_ops = {
-- 
2.8.0.rc3

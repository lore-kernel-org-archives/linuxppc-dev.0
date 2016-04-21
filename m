Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qrRkw0546zDqgZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 04:15:51 +1000 (AEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Christian Lamparter <chunkeey@googlemail.com>,
 =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>,
 Julian Margetson <runaway@candw.ms>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 04/23] ata: sata_dwc_460ex: burst size must be in items not
 bytes
Date: Thu, 21 Apr 2016 21:15:25 +0300
Message-Id: <1461262544-115408-5-git-send-email-andriy.shevchenko@linux.intel.com>
In-Reply-To: <1461262544-115408-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1461262544-115408-1-git-send-email-andriy.shevchenko@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The burst size as defined by DMAengine API is in items of address width. Derive
burst size from AHB_DMA_BRST_DFLT (64 bytes) by dividing it to
DMA_SLAVE_BUSWIDTH_4_BYTES (4 bytes) that gives us 16 items.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ata/sata_dwc_460ex.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index aee8873..4cac27d 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -65,7 +65,7 @@
 #define NO_IRQ		0
 #endif
 
-#define AHB_DMA_BRST_DFLT	64	/* 16 data items burst length*/
+#define AHB_DMA_BRST_DFLT	64	/* 16 data items burst length */
 
 enum {
 	SATA_DWC_MAX_PORTS = 1,
@@ -318,8 +318,8 @@ static struct dma_async_tx_descriptor *dma_dwc_xfer_setup(struct ata_queued_cmd
 	}
 
 	sconf.direction = qc->dma_dir;
-	sconf.src_maxburst = AHB_DMA_BRST_DFLT;
-	sconf.dst_maxburst = AHB_DMA_BRST_DFLT;
+	sconf.src_maxburst = AHB_DMA_BRST_DFLT / 4;	/* in items */
+	sconf.dst_maxburst = AHB_DMA_BRST_DFLT / 4;	/* in items */
 	sconf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	sconf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 
-- 
2.8.0.rc3

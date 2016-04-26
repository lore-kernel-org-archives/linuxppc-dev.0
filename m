Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qvHFP0fcDzDqBZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 19:03:36 +1000 (AEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Christian Lamparter <chunkeey@googlemail.com>,
 =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>,
 Julian Margetson <runaway@candw.ms>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 17/23] ata: sata_dwc_460ex: supply physical address of FIFO
 to DMA
Date: Tue, 26 Apr 2016 12:03:18 +0300
Message-Id: <1461661404-1952-18-git-send-email-andriy.shevchenko@linux.intel.com>
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

DMA operates with physical addresses which is not exactly the same as ioremap()
returns.

Introduce variable to keep physical address of the SATA FIFO register and
supply it when prepare DMA channel.

Tested-by: Christian Lamparter <chunkeey@googlemail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ata/sata_dwc_460ex.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 25e00f2..7b73728 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -100,7 +100,7 @@ struct sata_dwc_regs {
 	u32 versionr;		/* Version Register */
 	u32 idr;		/* ID Register */
 	u32 unimpl[192];	/* Unimplemented */
-	u32 dmadr[256];	/* FIFO Locations in DMA Mode */
+	u32 dmadr[256];		/* FIFO Locations in DMA Mode */
 };
 
 enum {
@@ -149,6 +149,7 @@ struct sata_dwc_device {
 	u32			sactive_issued;
 	u32			sactive_queued;
 	struct phy		*phy;
+	phys_addr_t		dmadr;
 #ifdef CONFIG_SATA_DWC_OLD_DMA
 	struct dw_dma_chip	*dma;
 #endif
@@ -380,15 +381,14 @@ static struct dma_async_tx_descriptor *dma_dwc_xfer_setup(struct ata_queued_cmd
 	struct ata_port *ap = qc->ap;
 	struct sata_dwc_device_port *hsdevp = HSDEVP_FROM_AP(ap);
 	struct sata_dwc_device *hsdev = HSDEV_FROM_AP(ap);
-	dma_addr_t addr = (dma_addr_t)&hsdev->sata_dwc_regs->dmadr;
 	struct dma_slave_config sconf;
 	struct dma_async_tx_descriptor *desc;
 
 	if (qc->dma_dir == DMA_DEV_TO_MEM) {
-		sconf.src_addr = addr;
+		sconf.src_addr = hsdev->dmadr;
 		sconf.device_fc = false;
 	} else {	/* DMA_MEM_TO_DEV */
-		sconf.dst_addr = addr;
+		sconf.dst_addr = hsdev->dmadr;
 		sconf.device_fc = false;
 	}
 
@@ -411,8 +411,8 @@ static struct dma_async_tx_descriptor *dma_dwc_xfer_setup(struct ata_queued_cmd
 	desc->callback = dma_dwc_xfer_done;
 	desc->callback_param = hsdev;
 
-	dev_dbg(hsdev->dev, "%s sg: 0x%p, count: %d addr: %pad\n",
-		__func__, qc->sg, qc->n_elem, &addr);
+	dev_dbg(hsdev->dev, "%s sg: 0x%p, count: %d addr: %pa\n", __func__,
+		qc->sg, qc->n_elem, &hsdev->dmadr);
 
 	return desc;
 }
@@ -1247,6 +1247,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 
 	/* Synopsys DWC SATA specific Registers */
 	hsdev->sata_dwc_regs = base + SATA_DWC_REG_OFFSET;
+	hsdev->dmadr = res->start + SATA_DWC_REG_OFFSET + offsetof(struct sata_dwc_regs, dmadr);
 
 	/* Setup port */
 	host->ports[0]->ioaddr.cmd_addr = base;
-- 
2.8.0.rc3

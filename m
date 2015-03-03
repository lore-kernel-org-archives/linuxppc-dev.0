Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by lists.ozlabs.org (Postfix) with ESMTP id 8C5C11A03DF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Mar 2015 07:43:35 +1100 (AEDT)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, rsarmah@amcc.com,
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [PATCH v1 2/2] sata_dwc_460ex: re-use hsdev->dev instead of dwc_dev
Date: Tue,  3 Mar 2015 22:41:22 +0200
Message-Id: <1425415282-3750-3-git-send-email-andriy.shevchenko@linux.intel.com>
In-Reply-To: <1425415282-3750-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1425415282-3750-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch re-uses hsdev->dev which is allocated on heap. Therefore, the
private structure, which is global variable, is reduced by one field.

In one case ap->dev is used and there it seems to be right decision.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ata/sata_dwc_460ex.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 08cd63f..5ab4849 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -194,7 +194,6 @@ struct sata_dwc_host_priv {
 	void	__iomem	 *scr_addr_sstatus;
 	u32	sata_dwc_sactive_issued ;
 	u32	sata_dwc_sactive_queued ;
-	struct	device	*dwc_dev;
 };
 
 static struct sata_dwc_host_priv host_pvt;
@@ -252,16 +251,16 @@ static const char *get_dma_dir_descript(int dma_dir)
 	}
 }
 
-static void sata_dwc_tf_dump(struct ata_taskfile *tf)
+static void sata_dwc_tf_dump(struct ata_port *ap, struct ata_taskfile *tf)
 {
-	dev_vdbg(host_pvt.dwc_dev,
+	dev_vdbg(ap->dev,
 		"taskfile cmd: 0x%02x protocol: %s flags: 0x%lx device: %x\n",
 		tf->command, get_prot_descript(tf->protocol), tf->flags,
 		tf->device);
-	dev_vdbg(host_pvt.dwc_dev,
+	dev_vdbg(ap->dev,
 		"feature: 0x%02x nsect: 0x%x lbal: 0x%x lbam: 0x%x lbah: 0x%x\n",
 		tf->feature, tf->nsect, tf->lbal, tf->lbam, tf->lbah);
-	dev_vdbg(host_pvt.dwc_dev,
+	dev_vdbg(ap->dev,
 		"hob_feature: 0x%02x hob_nsect: 0x%x hob_lbal: 0x%x hob_lbam: 0x%x hob_lbah: 0x%x\n",
 		tf->hob_feature, tf->hob_nsect, tf->hob_lbal, tf->hob_lbam,
 		tf->hob_lbah);
@@ -337,7 +336,7 @@ static struct dma_async_tx_descriptor *dma_dwc_xfer_setup(struct ata_queued_cmd
 	desc->callback = dma_dwc_xfer_done;
 	desc->callback_param = hsdev;
 
-	dev_dbg(host_pvt.dwc_dev, "%s sg: 0x%p, count: %d addr: %pad\n",
+	dev_dbg(hsdev->dev, "%s sg: 0x%p, count: %d addr: %pad\n",
 		__func__, qc->sg, qc->n_elem, &addr);
 
 	return desc;
@@ -687,7 +686,7 @@ static void sata_dwc_clear_dmacr(struct sata_dwc_device_port *hsdevp, u8 tag)
 		 * This should not happen, it indicates the driver is out of
 		 * sync.  If it does happen, clear dmacr anyway.
 		 */
-		dev_err(host_pvt.dwc_dev,
+		dev_err(hsdev->dev,
 			"%s DMA protocol RX and TX DMA not pending tag=0x%02x pending=%d dmacr: 0x%08x\n",
 			__func__, tag, hsdevp->dma_pending[tag],
 			in_le32(&hsdev->sata_dwc_regs->dmacr));
@@ -779,7 +778,7 @@ static void sata_dwc_enable_interrupts(struct sata_dwc_device *hsdev)
 	 */
 	out_le32(&hsdev->sata_dwc_regs->errmr, SATA_DWC_SERROR_ERR_BITS);
 
-	dev_dbg(host_pvt.dwc_dev, "%s: INTMR = 0x%08x, ERRMR = 0x%08x\n",
+	dev_dbg(hsdev->dev, "%s: INTMR = 0x%08x, ERRMR = 0x%08x\n",
 		 __func__, in_le32(&hsdev->sata_dwc_regs->intmr),
 		in_le32(&hsdev->sata_dwc_regs->errmr));
 }
@@ -855,7 +854,7 @@ static int sata_dwc_port_start(struct ata_port *ap)
 	hsdevp->hsdev = hsdev;
 
 	hsdevp->dws = &sata_dwc_dma_dws;
-	hsdevp->dws->dma_dev = host_pvt.dwc_dev;
+	hsdevp->dws->dma_dev = hsdev->dev;
 
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
@@ -863,7 +862,7 @@ static int sata_dwc_port_start(struct ata_port *ap)
 	/* Acquire DMA channel */
 	hsdevp->chan = dma_request_channel(mask, sata_dwc_dma_filter, hsdevp);
 	if (!hsdevp->chan) {
-		dev_err(host_pvt.dwc_dev, "%s: dma channel unavailable\n",
+		dev_err(hsdev->dev, "%s: dma channel unavailable\n",
 			 __func__);
 		err = -EAGAIN;
 		goto CLEANUP_ALLOC;
@@ -990,7 +989,7 @@ static void sata_dwc_bmdma_start_by_tag(struct ata_queued_cmd *qc, u8 tag)
 		"%s qc=%p tag: %x cmd: 0x%02x dma_dir: %s start_dma? %x\n",
 		__func__, qc, tag, qc->tf.command,
 		get_dma_dir_descript(qc->dma_dir), start_dma);
-	sata_dwc_tf_dump(&(qc->tf));
+	sata_dwc_tf_dump(ap, &qc->tf);
 
 	if (start_dma) {
 		reg = core_scr_read(SCR_ERROR);
@@ -1244,7 +1243,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	}
 
 	/* Save dev for later use in dev_xxx() routines */
-	host_pvt.dwc_dev = &ofdev->dev;
+	hsdev->dev = &ofdev->dev;
 
 	hsdev->dma->dev = &ofdev->dev;
 
-- 
2.1.4

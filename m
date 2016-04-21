Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qrRl11WvPzDqgy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 04:15:57 +1000 (AEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Christian Lamparter <chunkeey@googlemail.com>,
 =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>,
 Julian Margetson <runaway@candw.ms>
Subject: [PATCH v1 19/23] ata: sata_dwc_460ex: use readl/writel_relaxed()
Date: Thu, 21 Apr 2016 21:15:40 +0300
Message-Id: <1461262544-115408-20-git-send-email-andriy.shevchenko@linux.intel.com>
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

From: Mans Rullgard <mans@mansr.com>

Rename the register access macros and use standard _relaxed()
ops instead of __raw variants with explicit byte swapping.

The original driver used the ppc-specific in/out_le32().  When it
was adapted to other systems, these were added to the driver
under ifdefs.  However, those names are not defined as macros on
ppc, so it ended up replacing them there as well with altered
semantics.  This patch restores the original semantics on ppc and
makes the accesses no less strict on other systems.

Also fixes too many sparse warnings to count.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/ata/sata_dwc_460ex.c | 91 +++++++++++++++++++++-----------------------
 1 file changed, 43 insertions(+), 48 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 229e122..2029f43 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -51,13 +51,8 @@
 #define DRV_NAME        "sata-dwc"
 #define DRV_VERSION     "1.3"
 
-#ifndef out_le32
-#define out_le32(a, v)	__raw_writel(__cpu_to_le32(v), (void __iomem *)(a))
-#endif
-
-#ifndef in_le32
-#define in_le32(a)	__le32_to_cpu(__raw_readl((void __iomem *)(a)))
-#endif
+#define sata_dwc_writel(a, v)	writel_relaxed(v, a)
+#define sata_dwc_readl(a)	readl_relaxed(a)
 
 #ifndef NO_IRQ
 #define NO_IRQ		0
@@ -425,7 +420,7 @@ static int sata_dwc_scr_read(struct ata_link *link, unsigned int scr, u32 *val)
 		return -EINVAL;
 	}
 
-	*val = in_le32(link->ap->ioaddr.scr_addr + (scr * 4));
+	*val = sata_dwc_readl(link->ap->ioaddr.scr_addr + (scr * 4));
 	dev_dbg(link->ap->dev, "%s: id=%d reg=%d val=val=0x%08x\n",
 		__func__, link->ap->print_id, scr, *val);
 
@@ -441,7 +436,7 @@ static int sata_dwc_scr_write(struct ata_link *link, unsigned int scr, u32 val)
 			 __func__, scr);
 		return -EINVAL;
 	}
-	out_le32(link->ap->ioaddr.scr_addr + (scr * 4), val);
+	sata_dwc_writel(link->ap->ioaddr.scr_addr + (scr * 4), val);
 
 	return 0;
 }
@@ -455,8 +450,8 @@ static void clear_serror(struct ata_port *ap)
 
 static void clear_interrupt_bit(struct sata_dwc_device *hsdev, u32 bit)
 {
-	out_le32(&hsdev->sata_dwc_regs->intpr,
-		 in_le32(&hsdev->sata_dwc_regs->intpr));
+	sata_dwc_writel(&hsdev->sata_dwc_regs->intpr,
+			sata_dwc_readl(&hsdev->sata_dwc_regs->intpr));
 }
 
 static u32 qcmd_tag_to_mask(u8 tag)
@@ -532,7 +527,7 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 	spin_lock_irqsave(&host->lock, flags);
 
 	/* Read the interrupt register */
-	intpr = in_le32(&hsdev->sata_dwc_regs->intpr);
+	intpr = sata_dwc_readl(&hsdev->sata_dwc_regs->intpr);
 
 	ap = host->ports[port];
 	hsdevp = HSDEVP_FROM_AP(ap);
@@ -551,7 +546,7 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 	if (intpr & SATA_DWC_INTPR_NEWFP) {
 		clear_interrupt_bit(hsdev, SATA_DWC_INTPR_NEWFP);
 
-		tag = (u8)(in_le32(&hsdev->sata_dwc_regs->fptagr));
+		tag = (u8)(sata_dwc_readl(&hsdev->sata_dwc_regs->fptagr));
 		dev_dbg(ap->dev, "%s: NEWFP tag=%d\n", __func__, tag);
 		if (hsdevp->cmd_issued[tag] != SATA_DWC_CMD_ISSUED_PEND)
 			dev_warn(ap->dev, "CMD tag=%d not pending?\n", tag);
@@ -736,13 +731,13 @@ static void sata_dwc_clear_dmacr(struct sata_dwc_device_port *hsdevp, u8 tag)
 	struct sata_dwc_device *hsdev = HSDEV_FROM_HSDEVP(hsdevp);
 
 	if (hsdevp->dma_pending[tag] == SATA_DWC_DMA_PENDING_RX) {
-		out_le32(&(hsdev->sata_dwc_regs->dmacr),
-			 SATA_DWC_DMACR_RX_CLEAR(
-				 in_le32(&(hsdev->sata_dwc_regs->dmacr))));
+		sata_dwc_writel(&hsdev->sata_dwc_regs->dmacr,
+			SATA_DWC_DMACR_RX_CLEAR(
+				sata_dwc_readl(&hsdev->sata_dwc_regs->dmacr)));
 	} else if (hsdevp->dma_pending[tag] == SATA_DWC_DMA_PENDING_TX) {
-		out_le32(&(hsdev->sata_dwc_regs->dmacr),
-			 SATA_DWC_DMACR_TX_CLEAR(
-				 in_le32(&(hsdev->sata_dwc_regs->dmacr))));
+		sata_dwc_writel(&hsdev->sata_dwc_regs->dmacr,
+			SATA_DWC_DMACR_TX_CLEAR(
+				sata_dwc_readl(&hsdev->sata_dwc_regs->dmacr)));
 	} else {
 		/*
 		 * This should not happen, it indicates the driver is out of
@@ -751,9 +746,9 @@ static void sata_dwc_clear_dmacr(struct sata_dwc_device_port *hsdevp, u8 tag)
 		dev_err(hsdev->dev,
 			"%s DMA protocol RX and TX DMA not pending tag=0x%02x pending=%d dmacr: 0x%08x\n",
 			__func__, tag, hsdevp->dma_pending[tag],
-			in_le32(&hsdev->sata_dwc_regs->dmacr));
-		out_le32(&(hsdev->sata_dwc_regs->dmacr),
-			SATA_DWC_DMACR_TXRXCH_CLEAR);
+			sata_dwc_readl(&hsdev->sata_dwc_regs->dmacr));
+		sata_dwc_writel(&hsdev->sata_dwc_regs->dmacr,
+				SATA_DWC_DMACR_TXRXCH_CLEAR);
 	}
 }
 
@@ -778,7 +773,7 @@ static void sata_dwc_dma_xfer_complete(struct ata_port *ap, u32 check_status)
 			 __func__, qc->tag, qc->tf.command,
 			 get_dma_dir_descript(qc->dma_dir),
 			 get_prot_descript(qc->tf.protocol),
-			 in_le32(&(hsdev->sata_dwc_regs->dmacr)));
+			 sata_dwc_readl(&hsdev->sata_dwc_regs->dmacr));
 	}
 #endif
 
@@ -787,7 +782,7 @@ static void sata_dwc_dma_xfer_complete(struct ata_port *ap, u32 check_status)
 			dev_err(ap->dev,
 				"%s DMA protocol RX and TX DMA not pending dmacr: 0x%08x\n",
 				__func__,
-				in_le32(&(hsdev->sata_dwc_regs->dmacr)));
+				sata_dwc_readl(&hsdev->sata_dwc_regs->dmacr));
 		}
 
 		hsdevp->dma_pending[tag] = SATA_DWC_DMA_PENDING_NONE;
@@ -828,20 +823,20 @@ static int sata_dwc_qc_complete(struct ata_port *ap, struct ata_queued_cmd *qc,
 static void sata_dwc_enable_interrupts(struct sata_dwc_device *hsdev)
 {
 	/* Enable selective interrupts by setting the interrupt maskregister*/
-	out_le32(&hsdev->sata_dwc_regs->intmr,
-		 SATA_DWC_INTMR_ERRM |
-		 SATA_DWC_INTMR_NEWFPM |
-		 SATA_DWC_INTMR_PMABRTM |
-		 SATA_DWC_INTMR_DMATM);
+	sata_dwc_writel(&hsdev->sata_dwc_regs->intmr,
+			SATA_DWC_INTMR_ERRM |
+			SATA_DWC_INTMR_NEWFPM |
+			SATA_DWC_INTMR_PMABRTM |
+			SATA_DWC_INTMR_DMATM);
 	/*
 	 * Unmask the error bits that should trigger an error interrupt by
 	 * setting the error mask register.
 	 */
-	out_le32(&hsdev->sata_dwc_regs->errmr, SATA_DWC_SERROR_ERR_BITS);
+	sata_dwc_writel(&hsdev->sata_dwc_regs->errmr, SATA_DWC_SERROR_ERR_BITS);
 
 	dev_dbg(hsdev->dev, "%s: INTMR = 0x%08x, ERRMR = 0x%08x\n",
-		 __func__, in_le32(&hsdev->sata_dwc_regs->intmr),
-		in_le32(&hsdev->sata_dwc_regs->errmr));
+		 __func__, sata_dwc_readl(&hsdev->sata_dwc_regs->intmr),
+		sata_dwc_readl(&hsdev->sata_dwc_regs->errmr));
 }
 
 static void sata_dwc_setup_port(struct ata_ioports *port, void __iomem *base)
@@ -938,14 +933,14 @@ static int sata_dwc_port_start(struct ata_port *ap)
 	if (ap->port_no == 0)  {
 		dev_dbg(ap->dev, "%s: clearing TXCHEN, RXCHEN in DMAC\n",
 			__func__);
-		out_le32(&hsdev->sata_dwc_regs->dmacr,
-			 SATA_DWC_DMACR_TXRXCH_CLEAR);
+		sata_dwc_writel(&hsdev->sata_dwc_regs->dmacr,
+				SATA_DWC_DMACR_TXRXCH_CLEAR);
 
 		dev_dbg(ap->dev, "%s: setting burst size in DBTSR\n",
 			 __func__);
-		out_le32(&hsdev->sata_dwc_regs->dbtsr,
-			 (SATA_DWC_DBTSR_MWR(AHB_DMA_BRST_DFLT) |
-			  SATA_DWC_DBTSR_MRD(AHB_DMA_BRST_DFLT)));
+		sata_dwc_writel(&hsdev->sata_dwc_regs->dbtsr,
+				(SATA_DWC_DBTSR_MWR(AHB_DMA_BRST_DFLT) |
+				 SATA_DWC_DBTSR_MRD(AHB_DMA_BRST_DFLT)));
 	}
 
 	/* Clear any error bits before libata starts issuing commands */
@@ -1060,11 +1055,11 @@ static void sata_dwc_bmdma_start_by_tag(struct ata_queued_cmd *qc, u8 tag)
 		}
 
 		if (dir == DMA_TO_DEVICE)
-			out_le32(&hsdev->sata_dwc_regs->dmacr,
-				SATA_DWC_DMACR_TXCHEN);
+			sata_dwc_writel(&hsdev->sata_dwc_regs->dmacr,
+					SATA_DWC_DMACR_TXCHEN);
 		else
-			out_le32(&hsdev->sata_dwc_regs->dmacr,
-				SATA_DWC_DMACR_RXCHEN);
+			sata_dwc_writel(&hsdev->sata_dwc_regs->dmacr,
+					SATA_DWC_DMACR_RXCHEN);
 
 		/* Enable AHB DMA transfer on the specified channel */
 		dmaengine_submit(desc);
@@ -1150,13 +1145,13 @@ static int sata_dwc_hardreset(struct ata_link *link, unsigned int *class,
 	sata_dwc_enable_interrupts(hsdev);
 
 	/* Reconfigure the DMA control register */
-	out_le32(&hsdev->sata_dwc_regs->dmacr,
-		 SATA_DWC_DMACR_TXRXCH_CLEAR);
+	sata_dwc_writel(&hsdev->sata_dwc_regs->dmacr,
+			SATA_DWC_DMACR_TXRXCH_CLEAR);
 
 	/* Reconfigure the DMA Burst Transaction Size register */
-	out_le32(&hsdev->sata_dwc_regs->dbtsr,
-		 SATA_DWC_DBTSR_MWR(AHB_DMA_BRST_DFLT) |
-		 SATA_DWC_DBTSR_MRD(AHB_DMA_BRST_DFLT));
+	sata_dwc_writel(&hsdev->sata_dwc_regs->dbtsr,
+			SATA_DWC_DBTSR_MWR(AHB_DMA_BRST_DFLT) |
+			SATA_DWC_DBTSR_MRD(AHB_DMA_BRST_DFLT));
 
 	return ret;
 }
@@ -1257,8 +1252,8 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	sata_dwc_setup_port(&host->ports[0]->ioaddr, base);
 
 	/* Read the ID and Version Registers */
-	idr = in_le32(&hsdev->sata_dwc_regs->idr);
-	versionr = in_le32(&hsdev->sata_dwc_regs->versionr);
+	idr = sata_dwc_readl(&hsdev->sata_dwc_regs->idr);
+	versionr = sata_dwc_readl(&hsdev->sata_dwc_regs->versionr);
 	dev_notice(&ofdev->dev, "id %d, controller version %c.%c%c\n",
 		   idr, ver[0], ver[1], ver[2]);
 
-- 
2.8.0.rc3

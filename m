Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qvHFP3g2mzDq9q
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 19:03:37 +1000 (AEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Christian Lamparter <chunkeey@googlemail.com>,
 =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>,
 Julian Margetson <runaway@candw.ms>
Subject: [PATCH v2 11/23] ata: sata_dwc_460ex: get rid of global data
Date: Tue, 26 Apr 2016 12:03:12 +0300
Message-Id: <1461661404-1952-12-git-send-email-andriy.shevchenko@linux.intel.com>
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

This moves all global data into the driver private struct, thus
permitting multiple devices of this type to be used.

The core_scr_read/write() functions are replaced with equivalent
calls to the existing sata_dwc_scr_read/write().

Tested-by: Christian Lamparter <chunkeey@googlemail.com>
Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/ata/sata_dwc_460ex.c | 79 ++++++++++++++++----------------------------
 1 file changed, 29 insertions(+), 50 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 4b8eded..24837d6 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -146,6 +146,8 @@ struct sata_dwc_device {
 	struct ata_host		*host;
 	u8 __iomem		*reg_base;
 	struct sata_dwc_regs	*sata_dwc_regs;	/* DW Synopsys SATA specific */
+	u32			sactive_issued;
+	u32			sactive_queued;
 	struct phy		*phy;
 #ifdef CONFIG_SATA_DWC_OLD_DMA
 	struct dw_dma_chip	*dma;
@@ -190,14 +192,6 @@ enum {
 	SATA_DWC_DMA_PENDING_RX		= 2,
 };
 
-struct sata_dwc_host_priv {
-	void	__iomem	 *scr_addr_sstatus;
-	u32	sata_dwc_sactive_issued ;
-	u32	sata_dwc_sactive_queued ;
-};
-
-static struct sata_dwc_host_priv host_pvt;
-
 /*
  * Prototypes
  */
@@ -457,21 +451,11 @@ static int sata_dwc_scr_write(struct ata_link *link, unsigned int scr, u32 val)
 	return 0;
 }
 
-static u32 core_scr_read(unsigned int scr)
-{
-	return in_le32(host_pvt.scr_addr_sstatus + (scr * 4));
-}
-
-static void core_scr_write(unsigned int scr, u32 val)
-{
-	out_le32(host_pvt.scr_addr_sstatus + (scr * 4), val);
-}
-
-static void clear_serror(void)
+static void clear_serror(struct ata_port *ap)
 {
 	u32 val;
-	val = core_scr_read(SCR_ERROR);
-	core_scr_write(SCR_ERROR, val);
+	sata_dwc_scr_read(&ap->link, SCR_ERROR, &val);
+	sata_dwc_scr_write(&ap->link, SCR_ERROR, val);
 }
 
 static void clear_interrupt_bit(struct sata_dwc_device *hsdev, u32 bit)
@@ -498,7 +482,7 @@ static void sata_dwc_error_intr(struct ata_port *ap,
 
 	ata_ehi_clear_desc(ehi);
 
-	serror = core_scr_read(SCR_ERROR);
+	sata_dwc_scr_read(&ap->link, SCR_ERROR, &serror);
 	status = ap->ops->sff_check_status(ap);
 
 	tag = ap->link.active_tag;
@@ -509,7 +493,7 @@ static void sata_dwc_error_intr(struct ata_port *ap,
 		hsdevp->dma_pending[tag], hsdevp->cmd_issued[tag]);
 
 	/* Clear error register and interrupt bit */
-	clear_serror();
+	clear_serror(ap);
 	clear_interrupt_bit(hsdev, SATA_DWC_INTPR_ERR);
 
 	/* This is the only error happening now.  TODO check for exact error */
@@ -548,7 +532,7 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 	int handled, num_processed, port = 0;
 	uint intpr, sactive, sactive2, tag_mask;
 	struct sata_dwc_device_port *hsdevp;
-	host_pvt.sata_dwc_sactive_issued = 0;
+	hsdev->sactive_issued = 0;
 
 	spin_lock_irqsave(&host->lock, flags);
 
@@ -577,7 +561,7 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 		if (hsdevp->cmd_issued[tag] != SATA_DWC_CMD_ISSUED_PEND)
 			dev_warn(ap->dev, "CMD tag=%d not pending?\n", tag);
 
-		host_pvt.sata_dwc_sactive_issued |= qcmd_tag_to_mask(tag);
+		hsdev->sactive_issued |= qcmd_tag_to_mask(tag);
 
 		qc = ata_qc_from_tag(ap, tag);
 		/*
@@ -591,11 +575,11 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 		handled = 1;
 		goto DONE;
 	}
-	sactive = core_scr_read(SCR_ACTIVE);
-	tag_mask = (host_pvt.sata_dwc_sactive_issued | sactive) ^ sactive;
+	sata_dwc_scr_read(&ap->link, SCR_ACTIVE, &sactive);
+	tag_mask = (hsdev->sactive_issued | sactive) ^ sactive;
 
 	/* If no sactive issued and tag_mask is zero then this is not NCQ */
-	if (host_pvt.sata_dwc_sactive_issued == 0 && tag_mask == 0) {
+	if (hsdev->sactive_issued == 0 && tag_mask == 0) {
 		if (ap->link.active_tag == ATA_TAG_POISON)
 			tag = 0;
 		else
@@ -665,22 +649,19 @@ DRVSTILLBUSY:
 	 */
 
 	 /* process completed commands */
-	sactive = core_scr_read(SCR_ACTIVE);
-	tag_mask = (host_pvt.sata_dwc_sactive_issued | sactive) ^ sactive;
+	sata_dwc_scr_read(&ap->link, SCR_ACTIVE, &sactive);
+	tag_mask = (hsdev->sactive_issued | sactive) ^ sactive;
 
-	if (sactive != 0 || (host_pvt.sata_dwc_sactive_issued) > 1 || \
-							tag_mask > 1) {
+	if (sactive != 0 || hsdev->sactive_issued > 1 || tag_mask > 1) {
 		dev_dbg(ap->dev,
 			"%s NCQ:sactive=0x%08x  sactive_issued=0x%08x tag_mask=0x%08x\n",
-			__func__, sactive, host_pvt.sata_dwc_sactive_issued,
-			tag_mask);
+			__func__, sactive, hsdev->sactive_issued, tag_mask);
 	}
 
-	if ((tag_mask | (host_pvt.sata_dwc_sactive_issued)) != \
-					(host_pvt.sata_dwc_sactive_issued)) {
+	if ((tag_mask | hsdev->sactive_issued) != hsdev->sactive_issued) {
 		dev_warn(ap->dev,
-			 "Bad tag mask?  sactive=0x%08x (host_pvt.sata_dwc_sactive_issued)=0x%08x  tag_mask=0x%08x\n",
-			 sactive, host_pvt.sata_dwc_sactive_issued, tag_mask);
+			 "Bad tag mask?  sactive=0x%08x sactive_issued=0x%08x  tag_mask=0x%08x\n",
+			 sactive, hsdev->sactive_issued, tag_mask);
 	}
 
 	/* read just to clear ... not bad if currently still busy */
@@ -742,7 +723,7 @@ STILLBUSY:
 	 * we were processing --we read status as part of processing a completed
 	 * command).
 	 */
-	sactive2 = core_scr_read(SCR_ACTIVE);
+	sata_dwc_scr_read(&ap->link, SCR_ACTIVE, &sactive2);
 	if (sactive2 != sactive) {
 		dev_dbg(ap->dev,
 			"More completed - sactive=0x%x sactive2=0x%x\n",
@@ -828,8 +809,9 @@ static int sata_dwc_qc_complete(struct ata_port *ap, struct ata_queued_cmd *qc,
 	u8 status = 0;
 	u32 mask = 0x0;
 	u8 tag = qc->tag;
+	struct sata_dwc_device *hsdev = HSDEV_FROM_AP(ap);
 	struct sata_dwc_device_port *hsdevp = HSDEVP_FROM_AP(ap);
-	host_pvt.sata_dwc_sactive_queued = 0;
+	hsdev->sactive_queued = 0;
 	dev_dbg(ap->dev, "%s checkstatus? %x\n", __func__, check_status);
 
 	if (hsdevp->dma_pending[tag] == SATA_DWC_DMA_PENDING_TX)
@@ -842,10 +824,8 @@ static int sata_dwc_qc_complete(struct ata_port *ap, struct ata_queued_cmd *qc,
 
 	/* clear active bit */
 	mask = (~(qcmd_tag_to_mask(tag)));
-	host_pvt.sata_dwc_sactive_queued = (host_pvt.sata_dwc_sactive_queued) \
-						& mask;
-	host_pvt.sata_dwc_sactive_issued = (host_pvt.sata_dwc_sactive_issued) \
-						& mask;
+	hsdev->sactive_queued = hsdev->sactive_queued & mask;
+	hsdev->sactive_issued = hsdev->sactive_issued & mask;
 	ata_qc_complete(qc);
 	return 0;
 }
@@ -974,7 +954,7 @@ static int sata_dwc_port_start(struct ata_port *ap)
 	}
 
 	/* Clear any error bits before libata starts issuing commands */
-	clear_serror();
+	clear_serror(ap);
 	ap->private_data = hsdevp;
 	dev_dbg(ap->dev, "%s: done\n", __func__);
 	return 0;
@@ -1025,7 +1005,7 @@ static void sata_dwc_exec_command_by_tag(struct ata_port *ap,
 	 * managed SError register for the disk needs to be done before the
 	 * task file is loaded.
 	 */
-	clear_serror();
+	clear_serror(ap);
 	ata_sff_exec_command(ap, tf);
 }
 
@@ -1078,7 +1058,7 @@ static void sata_dwc_bmdma_start_by_tag(struct ata_queued_cmd *qc, u8 tag)
 	sata_dwc_tf_dump(ap, &qc->tf);
 
 	if (start_dma) {
-		reg = core_scr_read(SCR_ERROR);
+		sata_dwc_scr_read(&ap->link, SCR_ERROR, &reg);
 		if (reg & SATA_DWC_SERROR_ERR_BITS) {
 			dev_err(ap->dev, "%s: ****** SError=0x%08x ******\n",
 				__func__, reg);
@@ -1140,9 +1120,9 @@ static unsigned int sata_dwc_qc_issue(struct ata_queued_cmd *qc)
 	}
 
 	if (ata_is_ncq(qc->tf.protocol)) {
-		sactive = core_scr_read(SCR_ACTIVE);
+		sata_dwc_scr_read(&ap->link, SCR_ACTIVE, &sactive);
 		sactive |= (0x00000001 << tag);
-		core_scr_write(SCR_ACTIVE, sactive);
+		sata_dwc_scr_write(&ap->link, SCR_ACTIVE, sactive);
 
 		dev_dbg(qc->ap->dev,
 			"%s: tag=%d ap->link.sactive = 0x%08x sactive=0x%08x\n",
@@ -1298,7 +1278,6 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	/* Setup port */
 	host->ports[0]->ioaddr.cmd_addr = base;
 	host->ports[0]->ioaddr.scr_addr = base + SATA_DWC_SCR_OFFSET;
-	host_pvt.scr_addr_sstatus = base + SATA_DWC_SCR_OFFSET;
 	sata_dwc_setup_port(&host->ports[0]->ioaddr, (unsigned long)base);
 
 	/* Read the ID and Version Registers */
-- 
2.8.0.rc3

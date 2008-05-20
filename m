Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9DF5FDDF4E
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 15:20:06 +1000 (EST)
Date: Tue, 20 May 2008 00:19:45 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: jgarzik@pobox.com
Subject: [PATCH] Add port multiplier (PMP) support in sata_fsl driver
Message-ID: <Pine.LNX.4.64.0805200015010.5318@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, htejun@gmail.com, ashish.kalra@freescale.com,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Ashish Kalra <ashish.kalra@freescale.com>

PMP support for sata_fsl driver.

Signed-off-by: Ashish Kalra <ashish.kalra@freescale.com>
---
Jeff,

The following commit (4c9bf4e799ce06a7378f1196587084802a414c03):
libata: replace tf_read with qc_fill_rtf for non-SFF drivers

Broke the sata_fsl.c driver in 2.6.26.  I know the following patch fixes
the issue, it clearly also adds port multipler support.  I'm not sure if
you are willing to take that as part of 2.6.26 or not, but the current
2.6.26 driver is broken.

On boot with debug enabled we get something like (w/o this patch):

spurious interrupt!!, CC = 0x1
interrupt status 0x1
xx_scr_read, reg_in = 1
spurious interrupt!!, CC = 0x1
interrupt status 0x1
xx_scr_read, reg_in = 1
spurious interrupt!!, CC = 0x1
interrupt status 0x1
xx_scr_read, reg_in = 1

.. continues for ever.

- k

 drivers/ata/sata_fsl.c |  224 +++++++++++++++++++++++++++++++++++-------------
 1 files changed, 163 insertions(+), 61 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 853559e..3924e72 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -34,7 +34,7 @@ enum {

 	SATA_FSL_HOST_FLAGS	= (ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
-				ATA_FLAG_NCQ),
+				ATA_FLAG_PMP | ATA_FLAG_NCQ),

 	SATA_FSL_MAX_CMDS	= SATA_FSL_QUEUE_DEPTH,
 	SATA_FSL_CMD_HDR_SIZE	= 16,	/* 4 DWORDS */
@@ -395,7 +395,7 @@ static void sata_fsl_qc_prep(struct ata_queued_cmd *qc)
 	cd = (struct command_desc *)pp->cmdentry + tag;
 	cd_paddr = pp->cmdentry_paddr + tag * SATA_FSL_CMD_DESC_SIZE;

-	ata_tf_to_fis(&qc->tf, 0, 1, (u8 *) &cd->cfis);
+	ata_tf_to_fis(&qc->tf, qc->dev->link->pmp, 1, (u8 *) &cd->cfis);

 	VPRINTK("Dumping cfis : 0x%x, 0x%x, 0x%x\n",
 		cd->cfis[0], cd->cfis[1], cd->cfis[2]);
@@ -438,6 +438,8 @@ static unsigned int sata_fsl_qc_issue(struct ata_queued_cmd *qc)
 		ioread32(CA + hcr_base),
 		ioread32(CE + hcr_base), ioread32(CC + hcr_base));

+	iowrite32(qc->dev->link->pmp, CQPMP + hcr_base);
+
 	/* Simply queue command to the controller/device */
 	iowrite32(1 << tag, CQ + hcr_base);

@@ -558,11 +560,36 @@ static void sata_fsl_thaw(struct ata_port *ap)
 		ioread32(hcr_base + HCONTROL), ioread32(hcr_base + HSTATUS));
 }

+static void sata_fsl_pmp_attach(struct ata_port *ap)
+{
+	struct sata_fsl_host_priv *host_priv = ap->host->private_data;
+	void __iomem *hcr_base = host_priv->hcr_base;
+	u32 temp;
+
+	temp = ioread32(hcr_base + HCONTROL);
+	iowrite32((temp | HCONTROL_PMP_ATTACHED), hcr_base + HCONTROL);
+}
+
+static void sata_fsl_pmp_detach(struct ata_port *ap)
+{
+	struct sata_fsl_host_priv *host_priv = ap->host->private_data;
+	void __iomem *hcr_base = host_priv->hcr_base;
+	u32 temp;
+
+	temp = ioread32(hcr_base + HCONTROL);
+	temp &= ~HCONTROL_PMP_ATTACHED;
+	iowrite32(temp, hcr_base + HCONTROL);
+
+	/* enable interrupts on the controller/port */
+	temp = ioread32(hcr_base + HCONTROL);
+	iowrite32((temp | DEFAULT_PORT_IRQ_ENABLE_MASK), hcr_base + HCONTROL);
+
+}
+
 static int sata_fsl_port_start(struct ata_port *ap)
 {
 	struct device *dev = ap->host->dev;
 	struct sata_fsl_port_priv *pp;
-	int retval;
 	void *mem;
 	dma_addr_t mem_dma;
 	struct sata_fsl_host_priv *host_priv = ap->host->private_data;
@@ -688,12 +715,13 @@ static int sata_fsl_prereset(struct ata_link *link, unsigned long deadline)
 }

 static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
-			      unsigned long deadline)
+					unsigned long deadline)
 {
 	struct ata_port *ap = link->ap;
 	struct sata_fsl_port_priv *pp = ap->private_data;
 	struct sata_fsl_host_priv *host_priv = ap->host->private_data;
 	void __iomem *hcr_base = host_priv->hcr_base;
+	int pmp = sata_srst_pmp(link);
 	u32 temp;
 	struct ata_taskfile tf;
 	u8 *cfis;
@@ -703,6 +731,9 @@ static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,

 	DPRINTK("in xx_softreset\n");

+	if (pmp != SATA_PMP_CTRL_PORT)
+		goto issue_srst;
+
 try_offline_again:
 	/*
 	 * Force host controller to go off-line, aborting current operations
@@ -746,6 +777,7 @@ try_offline_again:

 	temp = ioread32(hcr_base + HCONTROL);
 	temp |= (HCONTROL_ONLINE_PHY_RST | HCONTROL_SNOOP_ENABLE);
+	temp |= HCONTROL_PMP_ATTACHED;
 	iowrite32(temp, hcr_base + HCONTROL);

 	temp = ata_wait_register(hcr_base + HSTATUS, ONLINE, 0, 1, 500);
@@ -771,7 +803,8 @@ try_offline_again:
 		ata_port_printk(ap, KERN_WARNING,
 				"No Device OR PHYRDY change,Hstatus = 0x%x\n",
 				ioread32(hcr_base + HSTATUS));
-		goto err;
+		*class = ATA_DEV_NONE;
+		goto out;
 	}

 	/*
@@ -783,7 +816,8 @@ try_offline_again:

 	if ((temp & 0xFF) != 0x18) {
 		ata_port_printk(ap, KERN_WARNING, "No Signature Update\n");
-		goto err;
+		*class = ATA_DEV_NONE;
+		goto out;
 	} else {
 		ata_port_printk(ap, KERN_INFO,
 				"Signature Update detected @ %d msecs\n",
@@ -798,6 +832,7 @@ try_offline_again:
 	 * reached here, we can send a command to the target device
 	 */

+issue_srst:
 	DPRINTK("Sending SRST/device reset\n");

 	ata_tf_init(link->device, &tf);
@@ -808,7 +843,7 @@ try_offline_again:
 				     SRST_CMD | CMD_DESC_SNOOP_ENABLE, 0, 0, 5);

 	tf.ctl |= ATA_SRST;	/* setup SRST bit in taskfile control reg */
-	ata_tf_to_fis(&tf, 0, 0, cfis);
+	ata_tf_to_fis(&tf, pmp, 0, cfis);

 	DPRINTK("Dumping cfis : 0x%x, 0x%x, 0x%x, 0x%x\n",
 		cfis[0], cfis[1], cfis[2], cfis[3]);
@@ -854,8 +889,10 @@ try_offline_again:
 	sata_fsl_setup_cmd_hdr_entry(pp, 0, CMD_DESC_SNOOP_ENABLE, 0, 0, 5);

 	tf.ctl &= ~ATA_SRST;	/* 2nd H2D Ctl. register FIS */
-	ata_tf_to_fis(&tf, 0, 0, cfis);
+	ata_tf_to_fis(&tf, pmp, 0, cfis);

+	if (pmp != SATA_PMP_CTRL_PORT)
+		iowrite32(pmp, CQPMP + hcr_base);
 	iowrite32(1, CQ + hcr_base);
 	msleep(150);		/* ?? */

@@ -886,12 +923,21 @@ try_offline_again:
 		VPRINTK("cereg = 0x%x\n", ioread32(hcr_base + CE));
 	}

+out:
 	return 0;

 err:
 	return -EIO;
 }

+static void sata_fsl_error_handler(struct ata_port *ap)
+{
+
+	DPRINTK("in xx_error_handler\n");
+	sata_pmp_error_handler(ap);
+
+}
+
 static void sata_fsl_post_internal_cmd(struct ata_queued_cmd *qc)
 {
 	if (qc->flags & ATA_QCFLAG_FAILED)
@@ -905,18 +951,21 @@ static void sata_fsl_post_internal_cmd(struct ata_queued_cmd *qc)

 static void sata_fsl_error_intr(struct ata_port *ap)
 {
-	struct ata_link *link = &ap->link;
-	struct ata_eh_info *ehi = &link->eh_info;
 	struct sata_fsl_host_priv *host_priv = ap->host->private_data;
 	void __iomem *hcr_base = host_priv->hcr_base;
-	u32 hstatus, dereg, cereg = 0, SError = 0;
+	u32 hstatus, dereg=0, cereg = 0, SError = 0;
 	unsigned int err_mask = 0, action = 0;
-	struct ata_queued_cmd *qc;
-	int freeze = 0;
+	int freeze = 0, abort=0;
+	struct ata_link *link = NULL;
+	struct ata_queued_cmd *qc = NULL;
+	struct ata_eh_info *ehi;

 	hstatus = ioread32(hcr_base + HSTATUS);
 	cereg = ioread32(hcr_base + CE);

+	/* first, analyze and record host port events */
+	link = &ap->link;
+	ehi = &link->eh_info;
 	ata_ehi_clear_desc(ehi);

 	/*
@@ -926,42 +975,28 @@ static void sata_fsl_error_intr(struct ata_port *ap)
 	sata_fsl_scr_read(ap, SCR_ERROR, &SError);
 	if (unlikely(SError & 0xFFFF0000)) {
 		sata_fsl_scr_write(ap, SCR_ERROR, SError);
-		err_mask |= AC_ERR_ATA_BUS;
 	}

 	DPRINTK("error_intr,hStat=0x%x,CE=0x%x,DE =0x%x,SErr=0x%x\n",
 		hstatus, cereg, ioread32(hcr_base + DE), SError);

-	/* handle single device errors */
-	if (cereg) {
-		/*
-		 * clear the command error, also clears queue to the device
-		 * in error, and we can (re)issue commands to this device.
-		 * When a device is in error all commands queued into the
-		 * host controller and at the device are considered aborted
-		 * and the queue for that device is stopped. Now, after
-		 * clearing the device error, we can issue commands to the
-		 * device to interrogate it to find the source of the error.
-		 */
-		dereg = ioread32(hcr_base + DE);
-		iowrite32(dereg, hcr_base + DE);
-		iowrite32(cereg, hcr_base + CE);
+	/* handle fatal errors */
+	if (hstatus & FATAL_ERROR_DECODE) {
+		ehi->err_mask |= AC_ERR_ATA_BUS;
+		ehi->action |= ATA_EH_SOFTRESET;

-		DPRINTK("single device error, CE=0x%x, DE=0x%x\n",
-			ioread32(hcr_base + CE), ioread32(hcr_base + DE));
 		/*
-		 * We should consider this as non fatal error, and TF must
-		 * be updated as done below.
+		 * Ignore serror in case of fatal errors as we always want
+		 * to do a soft-reset of the FSL SATA controller. Analyzing
+		 * serror may cause libata to schedule a hard-reset action,
+		 * and hard-reset currently does not do controller
+		 * offline/online, causing command timeouts and leads to an
+		 * un-recoverable state, hence make libATA ignore
+		 * autopsy in case of fatal errors.
 		 */

-		err_mask |= AC_ERR_DEV;
-	}
+		ehi->flags |= ATA_EHI_NO_AUTOPSY;

-	/* handle fatal errors */
-	if (hstatus & FATAL_ERROR_DECODE) {
-		err_mask |= AC_ERR_ATA_BUS;
-		action |= ATA_EH_RESET;
-		/* how will fatal error interrupts be completed ?? */
 		freeze = 1;
 	}

@@ -971,30 +1006,83 @@ static void sata_fsl_error_intr(struct ata_port *ap)

 		/* Setup a soft-reset EH action */
 		ata_ehi_hotplugged(ehi);
+		ata_ehi_push_desc(ehi, "%s", "PHY RDY changed");
 		freeze = 1;
 	}

-	/* record error info */
-	qc = ata_qc_from_tag(ap, link->active_tag);
+	/* handle single device errors */
+	if (cereg) {
+		/*
+		 * clear the command error, also clears queue to the device
+		 * in error, and we can (re)issue commands to this device.
+		 * When a device is in error all commands queued into the
+		 * host controller and at the device are considered aborted
+		 * and the queue for that device is stopped. Now, after
+		 * clearing the device error, we can issue commands to the
+		 * device to interrogate it to find the source of the error.
+		 */
+		abort = 1;
+
+		DPRINTK("single device error, CE=0x%x, DE=0x%x\n",
+			ioread32(hcr_base + CE), ioread32(hcr_base + DE));

-	if (qc)
+		/* find out the offending link and qc */
+		if (ap->nr_pmp_links) {
+			dereg = ioread32(hcr_base + DE);
+			iowrite32(dereg, hcr_base + DE);
+			iowrite32(cereg, hcr_base + CE);
+
+			if (dereg < ap->nr_pmp_links) {
+				link = &ap->pmp_link[dereg];
+				ehi = &link->eh_info;
+				qc = ata_qc_from_tag(ap, link->active_tag);
+				/*
+				 * We should consider this as non fatal error,
+                                 * and TF must be updated as done below.
+		                 */
+
+				err_mask |= AC_ERR_DEV;
+
+			} else {
+				err_mask |= AC_ERR_HSM;
+				action |= ATA_EH_HARDRESET;
+				freeze = 1;
+			}
+		} else {
+			dereg = ioread32(hcr_base + DE);
+			iowrite32(dereg, hcr_base + DE);
+			iowrite32(cereg, hcr_base + CE);
+
+			qc = ata_qc_from_tag(ap, link->active_tag);
+			/*
+			 * We should consider this as non fatal error,
+                         * and TF must be updated as done below.
+	                */
+			err_mask |= AC_ERR_DEV;
+		}
+	}
+
+	/* record error info */
+	if (qc) {
 		qc->err_mask |= err_mask;
-	else
+	} else
 		ehi->err_mask |= err_mask;

 	ehi->action |= action;
-	ehi->serror |= SError;

 	/* freeze or abort */
 	if (freeze)
 		ata_port_freeze(ap);
-	else
-		ata_port_abort(ap);
+	else if (abort) {
+		if (qc)
+			ata_link_abort(qc->dev->link);
+		else
+			ata_port_abort(ap);
+	}
 }

 static void sata_fsl_host_intr(struct ata_port *ap)
 {
-	struct ata_link *link = &ap->link;
 	struct sata_fsl_host_priv *host_priv = ap->host->private_data;
 	void __iomem *hcr_base = host_priv->hcr_base;
 	u32 hstatus, qc_active = 0;
@@ -1017,10 +1105,19 @@ static void sata_fsl_host_intr(struct ata_port *ap)
 		return;
 	}

-	if (link->sactive) {	/* only true for NCQ commands */
+	/* Read command completed register */
+	qc_active = ioread32(hcr_base + CC);
+
+	VPRINTK("Status of all queues :\n");
+	VPRINTK("qc_active/CC = 0x%x, CA = 0x%x, CE=0x%x,CQ=0x%x,apqa=0x%x\n",
+		qc_active,
+		ioread32(hcr_base + CA),
+		ioread32(hcr_base + CE),
+		ioread32(hcr_base + CQ),
+		ap->qc_active);
+
+	if (qc_active & ap->qc_active) {
 		int i;
-		/* Read command completed register */
-		qc_active = ioread32(hcr_base + CC);
 		/* clear CC bit, this will also complete the interrupt */
 		iowrite32(qc_active, hcr_base + CC);

@@ -1032,8 +1129,9 @@ static void sata_fsl_host_intr(struct ata_port *ap)
 		for (i = 0; i < SATA_FSL_QUEUE_DEPTH; i++) {
 			if (qc_active & (1 << i)) {
 				qc = ata_qc_from_tag(ap, i);
-				if (qc)
+				if (qc) {
 					ata_qc_complete(qc);
+				}
 				DPRINTK
 				    ("completing ncq cmd,tag=%d,CC=0x%x,CA=0x%x\n",
 				     i, ioread32(hcr_base + CC),
@@ -1042,19 +1140,21 @@ static void sata_fsl_host_intr(struct ata_port *ap)
 		}
 		return;

-	} else if (ap->qc_active) {
+	} else if ((ap->qc_active & (1 << ATA_TAG_INTERNAL))) {
 		iowrite32(1, hcr_base + CC);
-		qc = ata_qc_from_tag(ap, link->active_tag);
+		qc = ata_qc_from_tag(ap, ATA_TAG_INTERNAL);

-		DPRINTK("completing non-ncq cmd, tag=%d,CC=0x%x\n",
-			link->active_tag, ioread32(hcr_base + CC));
+		DPRINTK("completing non-ncq cmd, CC=0x%x\n",
+			 ioread32(hcr_base + CC));

-		if (qc)
+		if (qc) {
 			ata_qc_complete(qc);
+		}
 	} else {
 		/* Spurious Interrupt!! */
 		DPRINTK("spurious interrupt!!, CC = 0x%x\n",
 			ioread32(hcr_base + CC));
+		iowrite32(qc_active, hcr_base + CC);
 		return;
 	}
 }
@@ -1130,9 +1230,6 @@ static int sata_fsl_init_controller(struct ata_host *host)
 	iowrite32(0x00000FFFF, hcr_base + CE);
 	iowrite32(0x00000FFFF, hcr_base + DE);

-	/* initially assuming no Port multiplier, set CQPMP to 0 */
-	iowrite32(0x0, hcr_base + CQPMP);
-
 	/*
 	 * host controller will be brought on-line, during xx_port_start()
 	 * callback, that should also initiate the OOB, COMINIT sequence
@@ -1154,8 +1251,8 @@ static struct scsi_host_template sata_fsl_sht = {
 	.dma_boundary = ATA_DMA_BOUNDARY,
 };

-static const struct ata_port_operations sata_fsl_ops = {
-	.inherits = &sata_port_ops,
+static struct ata_port_operations sata_fsl_ops = {
+	.inherits		= &sata_pmp_port_ops,

 	.qc_prep = sata_fsl_qc_prep,
 	.qc_issue = sata_fsl_qc_issue,
@@ -1168,10 +1265,15 @@ static const struct ata_port_operations sata_fsl_ops = {
 	.thaw = sata_fsl_thaw,
 	.prereset = sata_fsl_prereset,
 	.softreset = sata_fsl_softreset,
+	.pmp_softreset = sata_fsl_softreset,
+	.error_handler = sata_fsl_error_handler,
 	.post_internal_cmd = sata_fsl_post_internal_cmd,

 	.port_start = sata_fsl_port_start,
 	.port_stop = sata_fsl_port_stop,
+
+	.pmp_attach = sata_fsl_pmp_attach,
+	.pmp_detach = sata_fsl_pmp_detach,
 };

 static const struct ata_port_info sata_fsl_port_info[] = {
-- 
1.5.4.5

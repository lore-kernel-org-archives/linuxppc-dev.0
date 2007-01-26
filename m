Return-Path: <akira2.iguchi@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1252DDE016
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 18:27:10 +1100 (EST)
Received: from tsb-wall.toshiba.co.jp ([133.199.160.134])
	by inet-tsb5.toshiba.co.jp  with ESMTP id l0Q7R77g001951
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 16:27:07 +0900 (JST)
Received: (from root@localhost) by tsb-wall.toshiba.co.jp  id l0Q7R79T029901
	for linuxppc-dev@ozlabs.org; Fri, 26 Jan 2007 16:27:07 +0900 (JST)
Received: from mx.toshiba.co.jp (localhost [127.0.0.1])
	by ovp1.toshiba.co.jp  with ESMTP id l0Q7R7vG019201
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 16:27:07 +0900 (JST)
Message-Id: <200701260727.l0Q7R4QA018992@toshiba.co.jp>
MIME-Version: 1.0
Date: Fri, 26 Jan 2007 16:27:32 +0900
From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
To: linux-ide@vger.kernel.org
Subject: [PATCH 1/3] libata: add another IRQ calls (core and headers)
Cc: jeff@garzik.org, arnd@arndb.de, linuxppc-dev@ozlabs.org, paulus@samba.org,
	alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch is against the libata core and headers.

Two IRQ calls are added in ata_port_operations.
- irq_on() is used to enable interrupts. 
- irq_ack() is used to acknowledge a device interrupt.

In most drivers, ata_irq_on() and ata_irq_ack() are used for
irq_on and irq_ack respectively. 

In some drivers (ex: ahci, sata_sil24) which cannot use them
as is, ata_dummy_irq_on() and ata_dummy_irq_ack() are used.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
---

diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/libata-core.c libata-tj.git.mod/drivers/ata/libata-core.c
--- libata-tj.git/drivers/ata/libata-core.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/libata-core.c	2007-01-26 21:08:27.000000000 +0900
@@ -2671,8 +2671,7 @@ void ata_bus_reset(struct ata_port *ap)
 		ap->device[1].class = ata_dev_try_classify(ap, 1, &err);
 
 	/* re-enable interrupts */
-	if (ap->ioaddr.ctl_addr)	/* FIXME: hack. create a hook instead */
-		ata_irq_on(ap);
+	ap->ops->irq_on(ap);
 
 	/* is double-select really necessary? */
 	if (ap->device[1].class != ATA_DEV_NONE)
@@ -3061,11 +3060,8 @@ void ata_std_postreset(struct ata_port *
 		sata_scr_write(ap, SCR_ERROR, serror);
 
 	/* re-enable interrupts */
-	if (!ap->ops->error_handler) {
-		/* FIXME: hack. create a hook instead */
-		if (ap->ioaddr.ctl_addr)
-			ata_irq_on(ap);
-	}
+	if (!ap->ops->error_handler)
+		ap->ops->irq_on(ap);
 
 	/* is double-select really necessary? */
 	if (classes[0] != ATA_DEV_NONE)
@@ -4176,7 +4172,7 @@ static void ata_hsm_qc_complete(struct a
 			qc = ata_qc_from_tag(ap, qc->tag);
 			if (qc) {
 				if (likely(!(qc->err_mask & AC_ERR_HSM))) {
-					ata_irq_on(ap);
+					ap->ops->irq_on(ap);
 					ata_qc_complete(qc);
 				} else
 					ata_port_freeze(ap);
@@ -4192,7 +4188,7 @@ static void ata_hsm_qc_complete(struct a
 	} else {
 		if (in_wq) {
 			spin_lock_irqsave(ap->lock, flags);
-			ata_irq_on(ap);
+			ap->ops->irq_on(ap);
 			ata_qc_complete(qc);
 			spin_unlock_irqrestore(ap->lock, flags);
 		} else
@@ -5017,7 +5013,7 @@ idle_irq:
 
 #ifdef ATA_IRQ_TRAP
 	if ((ap->stats.idle_irq % 1000) == 0) {
-		ata_irq_ack(ap, 0); /* debug trap */
+		ap->ops->irq_ack(ap, 0); /* debug trap */
 		ata_port_printk(ap, KERN_WARNING, "irq trap\n");
 		return 1;
 	}
@@ -6278,3 +6274,7 @@ EXPORT_SYMBOL_GPL(ata_eh_thaw_port);
 EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
 EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
 EXPORT_SYMBOL_GPL(ata_do_eh);
+EXPORT_SYMBOL_GPL(ata_irq_on);
+EXPORT_SYMBOL_GPL(ata_dummy_irq_on);
+EXPORT_SYMBOL_GPL(ata_irq_ack);
+EXPORT_SYMBOL_GPL(ata_dummy_irq_ack);
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/libata-sff.c libata-tj.git.mod/drivers/ata/libata-sff.c
--- libata-tj.git/drivers/ata/libata-sff.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/libata-sff.c	2007-01-26 21:08:27.000000000 +0900
@@ -64,6 +64,46 @@ u8 ata_irq_on(struct ata_port *ap)
 	return tmp;
 }
 
+u8 ata_dummy_irq_on (struct ata_port *ap) 	{ return 0; }
+
+/**
+ *	ata_irq_ack - Acknowledge a device interrupt.
+ *	@ap: Port on which interrupts are enabled.
+ *
+ *	Wait up to 10 ms for legacy IDE device to become idle (BUSY
+ *	or BUSY+DRQ clear).  Obtain dma status and port status from
+ *	device.  Clear the interrupt.  Return port status.
+ *
+ *	LOCKING:
+ */
+
+u8 ata_irq_ack(struct ata_port *ap, unsigned int chk_drq)
+{
+	unsigned int bits = chk_drq ? ATA_BUSY | ATA_DRQ : ATA_BUSY;
+	u8 host_stat, post_stat, status;
+
+	status = ata_busy_wait(ap, bits, 1000);
+	if (status & bits)
+		if (ata_msg_err(ap))
+			printk(KERN_ERR "abnormal status 0x%X\n", status);
+
+	/* get controller status; clear intr, err bits */
+	host_stat = ioread8(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+	iowrite8(host_stat | ATA_DMA_INTR | ATA_DMA_ERR,
+		 ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+
+	post_stat = ioread8(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+
+	if (ata_msg_intr(ap))
+		printk(KERN_INFO "%s: irq ack: host_stat 0x%X, new host_stat 0x%X, drv_stat 0x%X\n",
+			__FUNCTION__,
+			host_stat, post_stat, status);
+
+	return status;
+}
+
+u8 ata_dummy_irq_ack(struct ata_port *ap, unsigned int chk_drq) { return 0; }
+
 /**
  *	ata_tf_load - send taskfile registers to host controller
  *	@ap: Port to which output is sent
@@ -370,8 +410,7 @@ void ata_bmdma_thaw(struct ata_port *ap)
 	/* clear & re-enable interrupts */
 	ata_chk_status(ap);
 	ap->ops->irq_clear(ap);
-	if (ap->ioaddr.ctl_addr)	/* FIXME: hack. create a hook instead */
-		ata_irq_on(ap);
+	ap->ops->irq_on(ap);
 }
 
 /**
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/include/linux/libata.h libata-tj.git.mod/include/linux/libata.h
--- libata-tj.git/include/linux/libata.h	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/include/linux/libata.h	2007-01-26 21:08:27.000000000 +0900
@@ -631,6 +631,8 @@ struct ata_port_operations {
 
 	irq_handler_t irq_handler;
 	void (*irq_clear) (struct ata_port *);
+	u8 (*irq_on) (struct ata_port *);
+	u8 (*irq_ack) (struct ata_port *ap, unsigned int chk_drq);
 
 	u32 (*scr_read) (struct ata_port *ap, unsigned int sc_reg);
 	void (*scr_write) (struct ata_port *ap, unsigned int sc_reg,
@@ -812,6 +814,10 @@ extern void ata_scsi_slave_destroy(struc
 extern int ata_scsi_change_queue_depth(struct scsi_device *sdev,
 				       int queue_depth);
 extern struct ata_device *ata_dev_pair(struct ata_device *adev);
+extern u8 ata_irq_on(struct ata_port *ap);
+extern u8 ata_dummy_irq_on(struct ata_port *ap);
+extern u8 ata_irq_ack(struct ata_port *ap, unsigned int chk_drq);
+extern u8 ata_dummy_irq_ack(struct ata_port *ap, unsigned int chk_drq);
 
 /*
  * Timing helpers
@@ -1142,42 +1148,6 @@ static inline void ata_qc_reinit(struct 
 	qc->result_tf.feature = 0;
 }
 
-/**
- *	ata_irq_ack - Acknowledge a device interrupt.
- *	@ap: Port on which interrupts are enabled.
- *
- *	Wait up to 10 ms for legacy IDE device to become idle (BUSY
- *	or BUSY+DRQ clear).  Obtain dma status and port status from
- *	device.  Clear the interrupt.  Return port status.
- *
- *	LOCKING:
- */
-
-static inline u8 ata_irq_ack(struct ata_port *ap, unsigned int chk_drq)
-{
-	unsigned int bits = chk_drq ? ATA_BUSY | ATA_DRQ : ATA_BUSY;
-	u8 host_stat, post_stat, status;
-
-	status = ata_busy_wait(ap, bits, 1000);
-	if (status & bits)
-		if (ata_msg_err(ap))
-			printk(KERN_ERR "abnormal status 0x%X\n", status);
-
-	/* get controller status; clear intr, err bits */
-	host_stat = ioread8(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
-	iowrite8(host_stat | ATA_DMA_INTR | ATA_DMA_ERR,
-		 ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
-
-	post_stat = ioread8(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
-
-	if (ata_msg_intr(ap))
-		printk(KERN_INFO "%s: irq ack: host_stat 0x%X, new host_stat 0x%X, drv_stat 0x%X\n",
-			__FUNCTION__,
-			host_stat, post_stat, status);
-
-	return status;
-}
-
 static inline int ata_try_flush_cache(const struct ata_device *dev)
 {
 	return ata_id_wcache_enabled(dev->id) ||

Return-Path: <akira2.iguchi@toshiba.co.jp>
Received: from imx9.toshiba.co.jp (imx9.toshiba.co.jp [202.33.96.51])
	by ozlabs.org (Postfix) with ESMTP id 43E39DE0F8
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 19:54:18 +1100 (EST)
Received: from imx12.toshiba.co.jp (imx12 [61.202.160.132])
	by imx9.toshiba.co.jp  with ESMTP id l0B8s7ZV019264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 17:54:07 +0900 (JST)
Received: from wall11.toshiba.co.jp (wall11 [133.199.90.149])
	by imx12.toshiba.co.jp  with ESMTP id l0B8rvZR027152
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 17:53:57 +0900 (JST)
Received: (from root@localhost) by wall11.toshiba.co.jp  id l0B8rv1d027809
	for linuxppc-dev@ozlabs.org; Thu, 11 Jan 2007 17:53:57 +0900 (JST)
Received: from mx12.toshiba.co.jp (localhost [127.0.0.1])
	by ovp11.toshiba.co.jp  with ESMTP id l0B8ru9P010720
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 17:53:56 +0900 (JST)
Message-Id: <200701110853.l0B8rtXx025120@toshiba.co.jp>
MIME-Version: 1.0
Date: Thu, 11 Jan 2007 17:56:20 +0900
From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
To: linux-ide@vger.kernel.org
Subject: [PATCH 2/2] drivers/ata: export some static functions in libata-core.c
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch modifies some static functions in libata-core.c
and libata.h to use them in ata_scc.c.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
---

--- linux-2.6.20-rc4/drivers/ata/libata-core.c.orig	2007-01-11 01:56:11.000000000 +0900
+++ linux-2.6.20-rc4/drivers/ata/libata-core.c	2007-01-11 01:56:34.000000000 +0900
@@ -767,7 +767,7 @@ unsigned int ata_dev_classify(const stru
  *	Device type - %ATA_DEV_ATA, %ATA_DEV_ATAPI or %ATA_DEV_NONE.
  */
 
-static unsigned int
+unsigned int
 ata_dev_try_classify(struct ata_port *ap, unsigned int device, u8 *r_err)
 {
 	struct ata_taskfile tf;
@@ -2528,26 +2528,6 @@ int ata_set_mode(struct ata_port *ap, st
 }
 
 /**
- *	ata_tf_to_host - issue ATA taskfile to host controller
- *	@ap: port to which command is being issued
- *	@tf: ATA taskfile register set
- *
- *	Issues ATA taskfile register set to ATA host controller,
- *	with proper synchronization with interrupt handler and
- *	other threads.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host lock)
- */
-
-static inline void ata_tf_to_host(struct ata_port *ap,
-				  const struct ata_taskfile *tf)
-{
-	ap->ops->tf_load(ap, tf);
-	ap->ops->exec_command(ap, tf);
-}
-
-/**
  *	ata_busy_sleep - sleep until BSY clears, or timeout
  *	@ap: port containing status register to be polled
  *	@tmout_pat: impatience timeout
@@ -4080,7 +4060,7 @@ static void ata_pio_sector(struct ata_qu
  *	Inherited from caller.
  */
 
-static void ata_pio_sectors(struct ata_queued_cmd *qc)
+void ata_pio_sectors(struct ata_queued_cmd *qc)
 {
 	if (is_multi_taskfile(&qc->tf)) {
 		/* READ/WRITE MULTIPLE */
@@ -4107,7 +4087,7 @@ static void ata_pio_sectors(struct ata_q
  *	caller.
  */
 
-static void atapi_send_cdb(struct ata_port *ap, struct ata_queued_cmd *qc)
+void atapi_send_cdb(struct ata_port *ap, struct ata_queued_cmd *qc)
 {
 	/* send SCSI cdb */
 	DPRINTK("send cdb\n");
@@ -4236,7 +4216,7 @@ next_sg:
  *	Inherited from caller.
  */
 
-static void atapi_pio_bytes(struct ata_queued_cmd *qc)
+void atapi_pio_bytes(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct ata_device *dev = qc->dev;
@@ -4277,33 +4257,6 @@ err_out:
 }
 
 /**
- *	ata_hsm_ok_in_wq - Check if the qc can be handled in the workqueue.
- *	@ap: the target ata_port
- *	@qc: qc on going
- *
- *	RETURNS:
- *	1 if ok in workqueue, 0 otherwise.
- */
-
-static inline int ata_hsm_ok_in_wq(struct ata_port *ap, struct ata_queued_cmd *qc)
-{
-	if (qc->tf.flags & ATA_TFLAG_POLLING)
-		return 1;
-
-	if (ap->hsm_task_state == HSM_ST_FIRST) {
-		if (qc->tf.protocol == ATA_PROT_PIO &&
-		    (qc->tf.flags & ATA_TFLAG_WRITE))
-		    return 1;
-
-		if (is_atapi_taskfile(&qc->tf) &&
-		    !(qc->dev->flags & ATA_DFLAG_CDB_INTR))
-			return 1;
-	}
-
-	return 0;
-}
-
-/**
  *	ata_hsm_qc_complete - finish a qc running on standard HSM
  *	@qc: Command to complete
  *	@in_wq: 1 if called from workqueue, 0 otherwise
@@ -6500,3 +6453,10 @@ EXPORT_SYMBOL_GPL(ata_eh_thaw_port);
 EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
 EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
 EXPORT_SYMBOL_GPL(ata_do_eh);
+
+EXPORT_SYMBOL_GPL(ata_dev_try_classify);
+EXPORT_SYMBOL_GPL(ata_pio_sectors);
+EXPORT_SYMBOL_GPL(atapi_send_cdb);
+EXPORT_SYMBOL_GPL(atapi_pio_bytes);
+EXPORT_SYMBOL_GPL(ata_dev_select);
+EXPORT_SYMBOL_GPL(ata_probe_ent_alloc);
--- linux-2.6.20-rc4/include/linux/libata.h.orig	2007-01-11 01:56:22.000000000 +0900
+++ linux-2.6.20-rc4/include/linux/libata.h	2007-01-11 01:56:34.000000000 +0900
@@ -761,6 +761,12 @@ extern void ata_port_queue_task(struct a
 extern u32 ata_wait_register(void __iomem *reg, u32 mask, u32 val,
 			     unsigned long interval_msec,
 			     unsigned long timeout_msec);
+unsigned int ata_dev_try_classify(struct ata_port *ap, unsigned int device, u8 *r_err);
+void ata_pio_sectors(struct ata_queued_cmd *qc);
+void atapi_send_cdb(struct ata_port *ap, struct ata_queued_cmd *qc);
+void atapi_pio_bytes(struct ata_queued_cmd *qc);
+void ata_dev_select(struct ata_port *ap, unsigned int device, unsigned int wait, unsigned int can_sleep);
+struct ata_probe_ent *ata_probe_ent_alloc(struct device *dev, const struct ata_port_info *port);
 
 /*
  * Default driver ops implementations
@@ -1244,4 +1250,51 @@ static inline struct ata_port *ata_shost
 	return (struct ata_port *) &host->hostdata[0];
 }
 
+/**
+ *	ata_tf_to_host - issue ATA taskfile to host controller
+ *	@ap: port to which command is being issued
+ *	@tf: ATA taskfile register set
+ *
+ *	Issues ATA taskfile register set to ATA host controller,
+ *	with proper synchronization with interrupt handler and
+ *	other threads.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ */
+
+static inline void ata_tf_to_host(struct ata_port *ap,
+				  const struct ata_taskfile *tf)
+{
+	ap->ops->tf_load(ap, tf);
+	ap->ops->exec_command(ap, tf);
+}
+
+/**
+ *	ata_hsm_ok_in_wq - Check if the qc can be handled in the workqueue.
+ *	@ap: the target ata_port
+ *	@qc: qc on going
+ *
+ *	RETURNS:
+ *	1 if ok in workqueue, 0 otherwise.
+ */
+
+static inline int ata_hsm_ok_in_wq(struct ata_port *ap, struct ata_queued_cmd *qc)
+{
+	if (qc->tf.flags & ATA_TFLAG_POLLING)
+		return 1;
+
+	if (ap->hsm_task_state == HSM_ST_FIRST) {
+		if (qc->tf.protocol == ATA_PROT_PIO &&
+		    (qc->tf.flags & ATA_TFLAG_WRITE))
+		    return 1;
+
+		if (is_atapi_taskfile(&qc->tf) &&
+		    !(qc->dev->flags & ATA_DFLAG_CDB_INTR))
+			return 1;
+	}
+
+	return 0;
+}
+
 #endif /* __LINUX_LIBATA_H__ */

Return-Path: <akira2.iguchi@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5EA0167BB4
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 12:01:07 +1100 (EST)
Received: from tsb-wall.toshiba.co.jp ([133.199.160.134])
	by inet-tsb5.toshiba.co.jp  with ESMTP id kBD113G6022017
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 10:01:03 +0900 (JST)
Received: (from root@localhost) by tsb-wall.toshiba.co.jp  id kBD114vd007299
	for linuxppc-dev@ozlabs.org; Wed, 13 Dec 2006 10:01:04 +0900 (JST)
Received: from mx2.toshiba.co.jp (localhost [127.0.0.1])
	by ovp1.toshiba.co.jp  with ESMTP id kBD112xo018258
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 10:01:03 +0900 (JST)
Message-Id: <200612130101.kBD111qK022550@toshiba.co.jp>
MIME-Version: 1.0
Date: Wed, 13 Dec 2006 10:02:29 +0900
From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
To: linas@austin.ibm.com (Linas Vepstas)
Subject: [PATCH] libata-core.c (Re: PATA driver for Celleb)
Cc: linux-ide@vger.kernel.org, paulus@samba.org, arnd@arndb.de,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas-san,
Thank you for your comment.

>On Tue, Dec 12, 2006 at 11:08:24AM +0900, Akira Iguchi wrote:
>> 
>> I use some static functions in libata-core.c because it makes
>
>You will want to split this patch into several pars, and submit the 
>changes to libata-core.c separately.
..
>Please generate unified diffs (diff -pu) or use quilt,
>this makes the patches easier to read. (and smaller)

This patch is the common part (libata-core.c, libata.h) of the
patch I sent yesterday. Please check it out.

Signed-off-by: Kou Ishizaki <kou.ishizaki at toshiba.co.jp>
Signed-off-by: Akira Iguchi <akira2.iguchi at toshiba.co.jp>
---

Index: linux-2.6.19/drivers/ata/libata-core.c
===================================================================
RCS file: /home/public/cvs/linux-2.6.19/drivers/ata/libata-core.c,v
retrieving revision 1.1.1.4
retrieving revision 1.4
diff -p -u -r1.1.1.4 -r1.4
--- linux-2.6.19/drivers/ata/libata-core.c	1 Dec 2006 04:45:53 -0000	1.1.1.4
+++ linux-2.6.19/drivers/ata/libata-core.c	6 Dec 2006 03:00:47 -0000	1.4
@@ -600,7 +600,7 @@ unsigned int ata_dev_classify(const stru
  *	Device type - %ATA_DEV_ATA, %ATA_DEV_ATAPI or %ATA_DEV_NONE.
  */
 
-static unsigned int
+unsigned int
 ata_dev_try_classify(struct ata_port *ap, unsigned int device, u8 *r_err)
 {
 	struct ata_taskfile tf;
@@ -2297,26 +2297,6 @@ int ata_set_mode(struct ata_port *ap, st
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
@@ -3787,7 +3767,7 @@ static void ata_pio_sector(struct ata_qu
  *	Inherited from caller.
  */
 
-static void ata_pio_sectors(struct ata_queued_cmd *qc)
+void ata_pio_sectors(struct ata_queued_cmd *qc)
 {
 	if (is_multi_taskfile(&qc->tf)) {
 		/* READ/WRITE MULTIPLE */
@@ -3814,7 +3794,7 @@ static void ata_pio_sectors(struct ata_q
  *	caller.
  */
 
-static void atapi_send_cdb(struct ata_port *ap, struct ata_queued_cmd *qc)
+void atapi_send_cdb(struct ata_port *ap, struct ata_queued_cmd *qc)
 {
 	/* send SCSI cdb */
 	DPRINTK("send cdb\n");
@@ -3943,7 +3923,7 @@ next_sg:
  *	Inherited from caller.
  */
 
-static void atapi_pio_bytes(struct ata_queued_cmd *qc)
+void atapi_pio_bytes(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct ata_device *dev = qc->dev;
@@ -3984,33 +3964,6 @@ err_out:
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
@@ -6122,6 +6075,7 @@ EXPORT_SYMBOL_GPL(ata_std_prereset);
 EXPORT_SYMBOL_GPL(ata_std_softreset);
 EXPORT_SYMBOL_GPL(sata_std_hardreset);
 EXPORT_SYMBOL_GPL(ata_std_postreset);
+EXPORT_SYMBOL_GPL(ata_dev_revalidate);
 EXPORT_SYMBOL_GPL(ata_dev_classify);
 EXPORT_SYMBOL_GPL(ata_dev_pair);
 EXPORT_SYMBOL_GPL(ata_port_disable);
@@ -6178,3 +6132,10 @@ EXPORT_SYMBOL_GPL(ata_eh_thaw_port);
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
Index: linux-2.6.19/include/linux/libata.h
===================================================================
RCS file: /home/public/cvs/linux-2.6.19/include/linux/libata.h,v
retrieving revision 1.1.1.4
retrieving revision 1.2
diff -p -u -r1.1.1.4 -r1.2
--- linux-2.6.19/include/linux/libata.h	14 Nov 2006 02:16:27 -0000	1.1.1.4
+++ linux-2.6.19/include/linux/libata.h	6 Dec 2006 00:37:13 -0000	1.2
@@ -752,6 +752,13 @@ extern void ata_port_queue_task(struct a
 extern u32 ata_wait_register(void __iomem *reg, u32 mask, u32 val,
 			     unsigned long interval_msec,
 			     unsigned long timeout_msec);
+extern void ata_dev_select (struct ata_port *ap, unsigned int device, unsigned int wait, unsigned int can_sleep);
+extern unsigned int ata_dev_try_classify (struct ata_port *ap, unsigned int device, u8 *r_err);
+extern void ata_pio_sectors (struct ata_queued_cmd *qc);
+extern void atapi_send_cdb (struct ata_port *ap, struct ata_queued_cmd *qc);
+extern void atapi_pio_bytes (struct ata_queued_cmd *qc);
+extern struct ata_probe_ent *ata_probe_ent_alloc (struct device *dev, const struct ata_port_info *port);
+
 
 /*
  * Default driver ops implementations
@@ -762,6 +769,7 @@ extern void ata_tf_to_fis(const struct a
 extern void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf);
 extern void ata_noop_dev_select (struct ata_port *ap, unsigned int device);
 extern void ata_std_dev_select (struct ata_port *ap, unsigned int device);
+extern void ata_dev_select (struct ata_port *ap, unsigned int device, unsigned int wait, unsigned int can_sleep);
 extern u8 ata_check_status(struct ata_port *ap);
 extern u8 ata_altstatus(struct ata_port *ap);
 extern void ata_exec_command(struct ata_port *ap, const struct ata_taskfile *tf);
@@ -1265,4 +1273,51 @@ static inline struct ata_port *ata_shost
 	return (struct ata_port *) &host->hostdata[0];
 }
 
+/**
+ *      ata_tf_to_host - issue ATA taskfile to host controller
+ *      @ap: port to which command is being issued
+ *      @tf: ATA taskfile register set
+ *
+ *      Issues ATA taskfile register set to ATA host controller,
+ *      with proper synchronization with interrupt handler and
+ *      other threads.
+ *
+ *      LOCKING:
+ *      spin_lock_irqsave(host lock)
+ */
+
+static inline void ata_tf_to_host(struct ata_port *ap,
+                                  const struct ata_taskfile *tf)
+{
+        ap->ops->tf_load(ap, tf);
+        ap->ops->exec_command(ap, tf);
+}
+
+/**
+ *      ata_hsm_ok_in_wq - Check if the qc can be handled in the workqueue.
+ *      @ap: the target ata_port
+ *      @qc: qc on going
+ *
+ *      RETURNS:
+ *      1 if ok in workqueue, 0 otherwise.
+ */
+
+static inline int ata_hsm_ok_in_wq(struct ata_port *ap, struct ata_queued_cmd *qc)
+{
+        if (qc->tf.flags & ATA_TFLAG_POLLING)
+                return 1;
+
+        if (ap->hsm_task_state == HSM_ST_FIRST) {
+                if (qc->tf.protocol == ATA_PROT_PIO &&
+                    (qc->tf.flags & ATA_TFLAG_WRITE))
+                    return 1;
+
+                if (is_atapi_taskfile(&qc->tf) &&
+                    !(qc->dev->flags & ATA_DFLAG_CDB_INTR))
+                        return 1;
+        }
+
+        return 0;
+}
+
 #endif /* __LINUX_LIBATA_H__ */

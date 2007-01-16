Return-Path: <akira2.iguchi@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 29BDCDDFDD
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2007 21:46:10 +1100 (EST)
Received: from wall11.toshiba.co.jp (wall11 [133.199.90.149])
	by imx12.toshiba.co.jp  with ESMTP id l0GAk6ot011697
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2007 19:46:06 +0900 (JST)
Received: (from root@localhost) by wall11.toshiba.co.jp  id l0GAk6Of024803
	for linuxppc-dev@ozlabs.org; Tue, 16 Jan 2007 19:46:06 +0900 (JST)
Received: from mx11.toshiba.co.jp (localhost [127.0.0.1])
	by ovp11.toshiba.co.jp  with ESMTP id l0GAk6hs021688
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2007 19:46:06 +0900 (JST)
Message-Id: <200701161046.l0GAk5wj009665@toshiba.co.jp>
MIME-Version: 1.0
Date: Tue, 16 Jan 2007 19:46:14 +0900
From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
To: linux-ide@vger.kernel.org
Subject: [PATCH 2/4] libata-core.c: add another IRQ calls
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

When enabling IRQ, ap->ops->irq_on is checked.
Because most drivers can use ata_irq_on() as is, this
patch allows ap->ops->irq_on to be NULL.
If it is NULL, ata_irq_on() are used.

Similarly, ap->ops->irq_ack is checked when acknowledging a IRQ.
If it is NULL, ata_irq_ack() are used.

And this patch exports ata_dev_try_classify(). It is used in
pata_scc.c to reduce the code duplication.
This driver has the copy of ata_std_softreset(), which has
low-level accessors and cannot be used as is.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
---

--- linux-2.6.20-rc4/drivers/ata/libata-core.c.orig	2007-01-17 01:45:44.000000000 +0900
+++ linux-2.6.20-rc4/drivers/ata/libata-core.c	2007-01-17 02:16:48.000000000 +0900
@@ -767,7 +767,7 @@ unsigned int ata_dev_classify(const stru
  *	Device type - %ATA_DEV_ATA, %ATA_DEV_ATAPI or %ATA_DEV_NONE.
  */
 
-static unsigned int
+unsigned int
 ata_dev_try_classify(struct ata_port *ap, unsigned int device, u8 *r_err)
 {
 	struct ata_taskfile tf;
@@ -2754,8 +2754,12 @@ void ata_bus_reset(struct ata_port *ap)
 		ap->device[1].class = ata_dev_try_classify(ap, 1, &err);
 
 	/* re-enable interrupts */
-	if (ap->ioaddr.ctl_addr)	/* FIXME: hack. create a hook instead */
-		ata_irq_on(ap);
+	if (ap->ioaddr.ctl_addr) {	/* FIXME: hack. create a hook instead */
+		if (ap->ops->irq_on)
+			ap->ops->irq_on(ap);
+		else
+			ata_irq_on(ap);
+	}
 
 	/* is double-select really necessary? */
 	if (ap->device[1].class != ATA_DEV_NONE)
@@ -3149,8 +3153,12 @@ void ata_std_postreset(struct ata_port *
 	/* re-enable interrupts */
 	if (!ap->ops->error_handler) {
 		/* FIXME: hack. create a hook instead */
-		if (ap->ioaddr.ctl_addr)
-			ata_irq_on(ap);
+		if (ap->ioaddr.ctl_addr) {
+			if (ap->ops->irq_on)
+				ap->ops->irq_on(ap);
+			else
+				ata_irq_on(ap);
+		}
 	}
 
 	/* is double-select really necessary? */
@@ -4329,7 +4337,10 @@ static void ata_hsm_qc_complete(struct a
 			qc = ata_qc_from_tag(ap, qc->tag);
 			if (qc) {
 				if (likely(!(qc->err_mask & AC_ERR_HSM))) {
-					ata_irq_on(ap);
+					if (ap->ops->irq_on)
+						ap->ops->irq_on(ap);
+					else
+						ata_irq_on(ap);
 					ata_qc_complete(qc);
 				} else
 					ata_port_freeze(ap);
@@ -4345,7 +4356,10 @@ static void ata_hsm_qc_complete(struct a
 	} else {
 		if (in_wq) {
 			spin_lock_irqsave(ap->lock, flags);
-			ata_irq_on(ap);
+			if (ap->ops->irq_on)
+				ap->ops->irq_on(ap);
+			else
+				ata_irq_on(ap);
 			ata_qc_complete(qc);
 			spin_unlock_irqrestore(ap->lock, flags);
 		} else
@@ -5170,7 +5184,10 @@ idle_irq:
 
 #ifdef ATA_IRQ_TRAP
 	if ((ap->stats.idle_irq % 1000) == 0) {
-		ata_irq_ack(ap, 0); /* debug trap */
+		if (ap->ops->irq_ack)
+			ap->ops->irq_ack(ap, 0);
+		else
+			ata_irq_ack(ap, 0); /* debug trap */
 		ata_port_printk(ap, KERN_WARNING, "irq trap\n");
 		return 1;
 	}
@@ -6500,3 +6517,5 @@ EXPORT_SYMBOL_GPL(ata_eh_thaw_port);
 EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
 EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
 EXPORT_SYMBOL_GPL(ata_do_eh);
+EXPORT_SYMBOL_GPL(ata_dev_try_classify);
+EXPORT_SYMBOL_GPL(ata_probe_ent_alloc);

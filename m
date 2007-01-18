Return-Path: <akira2.iguchi@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1049ADDE47
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jan 2007 11:55:57 +1100 (EST)
Received: from tsb-wall.toshiba.co.jp ([133.199.160.134])
	by inet-tsb5.toshiba.co.jp  with ESMTP id l0I0trxv006315
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jan 2007 09:55:53 +0900 (JST)
Received: (from root@localhost) by tsb-wall.toshiba.co.jp  id l0I0tr0U022750
	for linuxppc-dev@ozlabs.org; Thu, 18 Jan 2007 09:55:53 +0900 (JST)
Received: from mx.toshiba.co.jp (localhost [127.0.0.1])
	by ovp1.toshiba.co.jp  with ESMTP id l0I0tqEL015547
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jan 2007 09:55:52 +0900 (JST)
Message-Id: <200701180055.l0I0tqaW026382@toshiba.co.jp>
MIME-Version: 1.0
Date: Thu, 18 Jan 2007 09:55:59 +0900
From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
To: Mikael Pettersson <mikpe@it.uu.se>
In-Reply-To: (Your message of "Wed, 17 Jan 2007 21:31:55 +0100")
	<17838.34747.222649.93821@alkaid.it.uu.se>
References: <200701170924.l0H9OsdG002754@harpo.it.uu.se>
	<45AE539E.2040600@garzik.org>
	<17838.34747.222649.93821@alkaid.it.uu.se>
Subject: Re: [PATCH 2/4] libata-core.c: add another IRQ calls
Cc: Jeff Garzik <jeff@garzik.org>, arnd@arndb.de, linuxppc-dev@ozlabs.org,
	linux-ide@vger.kernel.org, paulus@samba.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>The real benefits from identifying a common case is to inline
>the code for it. So the fact that the common case is still a
>full-blown function call here and not inline code means that
>there's much less benefit from rewriting an indirect call as
>an if/indirect/direct sequence.

According to your comment, this patch adds IRQ calls (irq_on, irq_ack)
to each driver and always uses these indirect calls.

For irq_on, most drivers use ata_irq_on(). Some drivers
(ahci.c, sata_sil24.c) use ata_dummy_irq_on() because they
don't have either explicit or implicit assignment (ex: ata_pci_init_one)
of ctl_addr.

For irq_ack, ata_irq_ack() is used.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
---

diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/ahci.c linux-2.6.20-rc4.mod/drivers/ata/ahci.c
--- linux-2.6.20-rc4/drivers/ata/ahci.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/ahci.c	2007-01-17 23:07:11.000000000 +0900
@@ -261,6 +261,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= ahci_interrupt,
 	.irq_clear		= ahci_irq_clear,
+	.irq_on			= ata_dummy_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.scr_read		= ahci_scr_read,
 	.scr_write		= ahci_scr_write,
@@ -292,6 +294,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= ahci_interrupt,
 	.irq_clear		= ahci_irq_clear,
+	.irq_on			= ata_dummy_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.scr_read		= ahci_scr_read,
 	.scr_write		= ahci_scr_write,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/ata_generic.c linux-2.6.20-rc4.mod/drivers/ata/ata_generic.c
--- linux-2.6.20-rc4/drivers/ata/ata_generic.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/ata_generic.c	2007-01-17 21:14:41.000000000 +0900
@@ -148,6 +148,8 @@ static struct ata_port_operations generi
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/ata_piix.c linux-2.6.20-rc4.mod/drivers/ata/ata_piix.c
--- linux-2.6.20-rc4/drivers/ata/ata_piix.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/ata_piix.c	2007-01-17 23:07:11.000000000 +0900
@@ -306,6 +306,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
@@ -339,6 +341,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
@@ -369,6 +373,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/libata-core.c linux-2.6.20-rc4.mod/drivers/ata/libata-core.c
--- linux-2.6.20-rc4/drivers/ata/libata-core.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/libata-core.c	2007-01-17 22:28:05.000000000 +0900
@@ -2754,8 +2754,7 @@ void ata_bus_reset(struct ata_port *ap)
 		ap->device[1].class = ata_dev_try_classify(ap, 1, &err);
 
 	/* re-enable interrupts */
-	if (ap->ioaddr.ctl_addr)	/* FIXME: hack. create a hook instead */
-		ata_irq_on(ap);
+	ap->ops->irq_on(ap);
 
 	/* is double-select really necessary? */
 	if (ap->device[1].class != ATA_DEV_NONE)
@@ -3147,11 +3146,8 @@ void ata_std_postreset(struct ata_port *
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
@@ -4329,7 +4325,7 @@ static void ata_hsm_qc_complete(struct a
 			qc = ata_qc_from_tag(ap, qc->tag);
 			if (qc) {
 				if (likely(!(qc->err_mask & AC_ERR_HSM))) {
-					ata_irq_on(ap);
+					ap->ops->irq_on(ap);
 					ata_qc_complete(qc);
 				} else
 					ata_port_freeze(ap);
@@ -4345,7 +4341,7 @@ static void ata_hsm_qc_complete(struct a
 	} else {
 		if (in_wq) {
 			spin_lock_irqsave(ap->lock, flags);
-			ata_irq_on(ap);
+			ap->ops->irq_on(ap);
 			ata_qc_complete(qc);
 			spin_unlock_irqrestore(ap->lock, flags);
 		} else
@@ -5170,7 +5166,7 @@ idle_irq:
 
 #ifdef ATA_IRQ_TRAP
 	if ((ap->stats.idle_irq % 1000) == 0) {
-		ata_irq_ack(ap, 0); /* debug trap */
+		ap->ops->irq_ack(ap, 0); /* debug trap */
 		ata_port_printk(ap, KERN_WARNING, "irq trap\n");
 		return 1;
 	}
@@ -6500,3 +6496,4 @@ EXPORT_SYMBOL_GPL(ata_eh_thaw_port);
 EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
 EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
 EXPORT_SYMBOL_GPL(ata_do_eh);
+EXPORT_SYMBOL_GPL(ata_irq_on);
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/libata-sff.c linux-2.6.20-rc4.mod/drivers/ata/libata-sff.c
--- linux-2.6.20-rc4/drivers/ata/libata-sff.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/libata-sff.c	2007-01-17 21:14:41.000000000 +0900
@@ -724,8 +724,7 @@ void ata_bmdma_thaw(struct ata_port *ap)
 	/* clear & re-enable interrupts */
 	ata_chk_status(ap);
 	ap->ops->irq_clear(ap);
-	if (ap->ioaddr.ctl_addr)	/* FIXME: hack. create a hook instead */
-		ata_irq_on(ap);
+	ap->ops->irq_on(ap);
 }
 
 /**
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/pata_ali.c linux-2.6.20-rc4.mod/drivers/ata/pata_ali.c
--- linux-2.6.20-rc4/drivers/ata/pata_ali.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/pata_ali.c	2007-01-17 21:14:41.000000000 +0900
@@ -374,6 +374,8 @@ static struct ata_port_operations ali_ea
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
@@ -415,6 +417,8 @@ static struct ata_port_operations ali_20
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
@@ -453,6 +457,8 @@ static struct ata_port_operations ali_c2
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
@@ -490,6 +496,8 @@ static struct ata_port_operations ali_c5
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/pata_amd.c linux-2.6.20-rc4.mod/drivers/ata/pata_amd.c
--- linux-2.6.20-rc4/drivers/ata/pata_amd.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/pata_amd.c	2007-01-17 21:14:41.000000000 +0900
@@ -366,6 +366,8 @@ static struct ata_port_operations amd33_
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
@@ -400,6 +402,8 @@ static struct ata_port_operations amd66_
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
@@ -434,6 +438,8 @@ static struct ata_port_operations amd100
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
@@ -468,6 +474,8 @@ static struct ata_port_operations amd133
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
@@ -502,6 +510,8 @@ static struct ata_port_operations nv100_
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
@@ -536,6 +546,8 @@ static struct ata_port_operations nv133_
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/pata_artop.c linux-2.6.20-rc4.mod/drivers/ata/pata_artop.c
--- linux-2.6.20-rc4/drivers/ata/pata_artop.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/pata_artop.c	2007-01-17 21:14:41.000000000 +0900
@@ -345,6 +345,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
@@ -377,6 +379,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/pata_atiixp.c linux-2.6.20-rc4.mod/drivers/ata/pata_atiixp.c
--- linux-2.6.20-rc4/drivers/ata/pata_atiixp.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/pata_atiixp.c	2007-01-17 21:14:41.000000000 +0900
@@ -249,6 +249,8 @@ static struct ata_port_operations atiixp
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/pata_cmd64x.c linux-2.6.20-rc4.mod/drivers/ata/pata_cmd64x.c
--- linux-2.6.20-rc4/drivers/ata/pata_cmd64x.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/pata_cmd64x.c	2007-01-17 21:14:41.000000000 +0900
@@ -308,6 +308,8 @@ static struct ata_port_operations cmd64x
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
@@ -342,6 +344,8 @@ static struct ata_port_operations cmd646
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
@@ -376,6 +380,8 @@ static struct ata_port_operations cmd648
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/pata_cs5520.c linux-2.6.20-rc4.mod/drivers/ata/pata_cs5520.c
--- linux-2.6.20-rc4/drivers/ata/pata_cs5520.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/pata_cs5520.c	2007-01-17 21:14:41.000000000 +0900
@@ -197,6 +197,8 @@ static struct ata_port_operations cs5520
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/pata_cs5530.c linux-2.6.20-rc4.mod/drivers/ata/pata_cs5530.c
--- linux-2.6.20-rc4/drivers/ata/pata_cs5530.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/pata_cs5530.c	2007-01-17 21:14:41.000000000 +0900
@@ -214,6 +214,8 @@ static struct ata_port_operations cs5530
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/pata_cs5535.c linux-2.6.20-rc4.mod/drivers/ata/pata_cs5535.c
--- linux-2.6.20-rc4/drivers/ata/pata_cs5535.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/pata_cs5535.c	2007-01-17 21:14:41.000000000 +0900
@@ -218,6 +218,8 @@ static struct ata_port_operations cs5535
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/pata_cypress.c linux-2.6.20-rc4.mod/drivers/ata/pata_cypress.c
--- linux-2.6.20-rc4/drivers/ata/pata_cypress.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/pata_cypress.c	2007-01-17 21:14:41.000000000 +0900
@@ -169,6 +169,8 @@ static struct ata_port_operations cy82c6
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/pata_efar.c linux-2.6.20-rc4.mod/drivers/ata/pata_efar.c
--- linux-2.6.20-rc4/drivers/ata/pata_efar.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/pata_efar.c	2007-01-17 21:14:41.000000000 +0900
@@ -265,6 +265,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/pata_hpt366.c linux-2.6.20-rc4.mod/drivers/ata/pata_hpt366.c
--- linux-2.6.20-rc4/drivers/ata/pata_hpt366.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/pata_hpt366.c	2007-01-17 21:14:41.000000000 +0900
@@ -375,6 +375,8 @@ static struct ata_port_operations hpt366
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/pata_hpt37x.c linux-2.6.20-rc4.mod/drivers/ata/pata_hpt37x.c
--- linux-2.6.20-rc4/drivers/ata/pata_hpt37x.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/pata_hpt37x.c	2007-01-17 23:07:11.000000000 +0900
@@ -811,6 +811,8 @@ static struct ata_port_operations hpt370
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
@@ -850,6 +852,8 @@ static struct ata_port_operations hpt370
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
@@ -890,6 +894,8 @@ static struct ata_port_operations hpt372
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
@@ -930,6 +936,8 @@ static struct ata_port_operations hpt374
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/pata_hpt3x2n.c linux-2.6.20-rc4.mod/drivers/ata/pata_hpt3x2n.c
--- linux-2.6.20-rc4/drivers/ata/pata_hpt3x2n.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/pata_hpt3x2n.c	2007-01-17 21:14:41.000000000 +0900
@@ -377,6 +377,8 @@ static struct ata_port_operations hpt3x2
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/pata_hpt3x3.c linux-2.6.20-rc4.mod/drivers/ata/pata_hpt3x3.c
--- linux-2.6.20-rc4/drivers/ata/pata_hpt3x3.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/pata_hpt3x3.c	2007-01-17 21:14:41.000000000 +0900
@@ -152,6 +152,8 @@ static struct ata_port_operations hpt3x3
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/pata_isapnp.c linux-2.6.20-rc4.mod/drivers/ata/pata_isapnp.c
--- linux-2.6.20-rc4/drivers/ata/pata_isapnp.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/pata_isapnp.c	2007-01-17 21:14:41.000000000 +0900
@@ -57,6 +57,8 @@ static struct ata_port_operations isapnp
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/pata_it821x.c linux-2.6.20-rc4.mod/drivers/ata/pata_it821x.c
--- linux-2.6.20-rc4/drivers/ata/pata_it821x.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/pata_it821x.c	2007-01-17 21:14:41.000000000 +0900
@@ -708,6 +708,8 @@ static struct ata_port_operations it821x
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= it821x_port_start,
 	.port_stop	= it821x_port_stop,
@@ -744,6 +746,8 @@ static struct ata_port_operations it821x
 
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_handler	= ata_interrupt,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= it821x_port_start,
 	.port_stop	= it821x_port_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/pata_ixp4xx_cf.c linux-2.6.20-rc4.mod/drivers/ata/pata_ixp4xx_cf.c
--- linux-2.6.20-rc4/drivers/ata/pata_ixp4xx_cf.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/pata_ixp4xx_cf.c	2007-01-17 21:14:41.000000000 +0900
@@ -138,6 +138,8 @@ static struct ata_port_operations ixp4xx
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ixp4xx_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/pata_jmicron.c linux-2.6.20-rc4.mod/drivers/ata/pata_jmicron.c
--- linux-2.6.20-rc4/drivers/ata/pata_jmicron.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/pata_jmicron.c	2007-01-17 21:14:41.000000000 +0900
@@ -166,6 +166,8 @@ static const struct ata_port_operations 
 	/* IRQ-related hooks */
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	/* Generic PATA PCI ATA helpers */
 	.port_start		= ata_port_start,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/pata_legacy.c linux-2.6.20-rc4.mod/drivers/ata/pata_legacy.c
--- linux-2.6.20-rc4/drivers/ata/pata_legacy.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/pata_legacy.c	2007-01-17 21:14:41.000000000 +0900
@@ -166,6 +166,8 @@ static struct ata_port_operations simple
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
@@ -191,6 +193,8 @@ static struct ata_port_operations legacy
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
@@ -301,6 +305,8 @@ static struct ata_port_operations pdc202
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
@@ -353,6 +359,8 @@ static struct ata_port_operations ht6560
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
@@ -416,6 +424,8 @@ static struct ata_port_operations ht6560
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
@@ -534,6 +544,8 @@ static struct ata_port_operations opti82
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
@@ -664,6 +676,8 @@ static struct ata_port_operations opti82
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/pata_marvell.c linux-2.6.20-rc4.mod/drivers/ata/pata_marvell.c
--- linux-2.6.20-rc4/drivers/ata/pata_marvell.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/pata_marvell.c	2007-01-17 21:14:41.000000000 +0900
@@ -134,6 +134,8 @@ static const struct ata_port_operations 
 	/* Timeout handling */
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	/* Generic PATA PCI ATA helpers */
 	.port_start		= ata_port_start,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/pata_mpiix.c linux-2.6.20-rc4.mod/drivers/ata/pata_mpiix.c
--- linux-2.6.20-rc4/drivers/ata/pata_mpiix.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/pata_mpiix.c	2007-01-17 21:14:41.000000000 +0900
@@ -192,6 +192,8 @@ static struct ata_port_operations mpiix_
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/pata_netcell.c linux-2.6.20-rc4.mod/drivers/ata/pata_netcell.c
--- linux-2.6.20-rc4/drivers/ata/pata_netcell.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/pata_netcell.c	2007-01-17 21:14:41.000000000 +0900
@@ -94,6 +94,8 @@ static const struct ata_port_operations 
 	/* IRQ-related hooks */
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	/* Generic PATA PCI ATA helpers */
 	.port_start		= ata_port_start,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/pata_ns87410.c linux-2.6.20-rc4.mod/drivers/ata/pata_ns87410.c
--- linux-2.6.20-rc4/drivers/ata/pata_ns87410.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/pata_ns87410.c	2007-01-17 21:14:41.000000000 +0900
@@ -183,6 +183,8 @@ static struct ata_port_operations ns8741
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/pata_oldpiix.c linux-2.6.20-rc4.mod/drivers/ata/pata_oldpiix.c
--- linux-2.6.20-rc4/drivers/ata/pata_oldpiix.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/pata_oldpiix.c	2007-01-17 21:14:41.000000000 +0900
@@ -263,6 +263,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/pata_opti.c linux-2.6.20-rc4.mod/drivers/ata/pata_opti.c
--- linux-2.6.20-rc4/drivers/ata/pata_opti.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/pata_opti.c	2007-01-17 21:14:41.000000000 +0900
@@ -209,6 +209,8 @@ static struct ata_port_operations opti_p
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/pata_optidma.c linux-2.6.20-rc4.mod/drivers/ata/pata_optidma.c
--- linux-2.6.20-rc4/drivers/ata/pata_optidma.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/pata_optidma.c	2007-01-17 21:14:41.000000000 +0900
@@ -393,6 +393,8 @@ static struct ata_port_operations optidm
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
@@ -428,6 +430,8 @@ static struct ata_port_operations optipl
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/pata_pcmcia.c linux-2.6.20-rc4.mod/drivers/ata/pata_pcmcia.c
--- linux-2.6.20-rc4/drivers/ata/pata_pcmcia.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/pata_pcmcia.c	2007-01-17 21:14:41.000000000 +0900
@@ -92,6 +92,8 @@ static struct ata_port_operations pcmcia
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/pata_pdc2027x.c linux-2.6.20-rc4.mod/drivers/ata/pata_pdc2027x.c
--- linux-2.6.20-rc4/drivers/ata/pata_pdc2027x.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/pata_pdc2027x.c	2007-01-17 21:14:41.000000000 +0900
@@ -169,6 +169,8 @@ static struct ata_port_operations pdc202
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
@@ -203,6 +205,8 @@ static struct ata_port_operations pdc202
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/pata_pdc202xx_old.c linux-2.6.20-rc4.mod/drivers/ata/pata_pdc202xx_old.c
--- linux-2.6.20-rc4/drivers/ata/pata_pdc202xx_old.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/pata_pdc202xx_old.c	2007-01-17 21:14:41.000000000 +0900
@@ -301,6 +301,8 @@ static struct ata_port_operations pdc202
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
@@ -335,6 +337,8 @@ static struct ata_port_operations pdc202
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/pata_platform.c linux-2.6.20-rc4.mod/drivers/ata/pata_platform.c
--- linux-2.6.20-rc4/drivers/ata/pata_platform.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/pata_platform.c	2007-01-17 21:14:41.000000000 +0900
@@ -103,6 +103,8 @@ static struct ata_port_operations pata_p
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/pata_qdi.c linux-2.6.20-rc4.mod/drivers/ata/pata_qdi.c
--- linux-2.6.20-rc4/drivers/ata/pata_qdi.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/pata_qdi.c	2007-01-17 21:14:41.000000000 +0900
@@ -189,6 +189,8 @@ static struct ata_port_operations qdi650
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
@@ -217,6 +219,8 @@ static struct ata_port_operations qdi658
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/pata_radisys.c linux-2.6.20-rc4.mod/drivers/ata/pata_radisys.c
--- linux-2.6.20-rc4/drivers/ata/pata_radisys.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/pata_radisys.c	2007-01-17 21:14:41.000000000 +0900
@@ -259,6 +259,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/pata_rz1000.c linux-2.6.20-rc4.mod/drivers/ata/pata_rz1000.c
--- linux-2.6.20-rc4/drivers/ata/pata_rz1000.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/pata_rz1000.c	2007-01-17 21:14:41.000000000 +0900
@@ -122,6 +122,8 @@ static struct ata_port_operations rz1000
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/pata_sc1200.c linux-2.6.20-rc4.mod/drivers/ata/pata_sc1200.c
--- linux-2.6.20-rc4/drivers/ata/pata_sc1200.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/pata_sc1200.c	2007-01-17 21:14:41.000000000 +0900
@@ -224,6 +224,8 @@ static struct ata_port_operations sc1200
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/pata_serverworks.c linux-2.6.20-rc4.mod/drivers/ata/pata_serverworks.c
--- linux-2.6.20-rc4/drivers/ata/pata_serverworks.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/pata_serverworks.c	2007-01-17 21:14:41.000000000 +0900
@@ -359,6 +359,8 @@ static struct ata_port_operations server
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
@@ -394,6 +396,8 @@ static struct ata_port_operations server
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/pata_sil680.c linux-2.6.20-rc4.mod/drivers/ata/pata_sil680.c
--- linux-2.6.20-rc4/drivers/ata/pata_sil680.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/pata_sil680.c	2007-01-17 21:14:41.000000000 +0900
@@ -256,6 +256,8 @@ static struct ata_port_operations sil680
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/pata_sis.c linux-2.6.20-rc4.mod/drivers/ata/pata_sis.c
--- linux-2.6.20-rc4/drivers/ata/pata_sis.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/pata_sis.c	2007-01-17 21:14:41.000000000 +0900
@@ -577,6 +577,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
@@ -610,6 +612,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
@@ -644,6 +648,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
@@ -677,6 +683,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
@@ -710,6 +718,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/pata_sl82c105.c linux-2.6.20-rc4.mod/drivers/ata/pata_sl82c105.c
--- linux-2.6.20-rc4/drivers/ata/pata_sl82c105.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/pata_sl82c105.c	2007-01-17 21:14:41.000000000 +0900
@@ -266,6 +266,8 @@ static struct ata_port_operations sl82c1
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/pata_triflex.c linux-2.6.20-rc4.mod/drivers/ata/pata_triflex.c
--- linux-2.6.20-rc4/drivers/ata/pata_triflex.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/pata_triflex.c	2007-01-17 21:14:41.000000000 +0900
@@ -225,6 +225,8 @@ static struct ata_port_operations trifle
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/pata_via.c linux-2.6.20-rc4.mod/drivers/ata/pata_via.c
--- linux-2.6.20-rc4/drivers/ata/pata_via.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/pata_via.c	2007-01-17 21:14:41.000000000 +0900
@@ -336,6 +336,8 @@ static struct ata_port_operations via_po
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
@@ -371,6 +373,8 @@ static struct ata_port_operations via_po
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/pata_winbond.c linux-2.6.20-rc4.mod/drivers/ata/pata_winbond.c
--- linux-2.6.20-rc4/drivers/ata/pata_winbond.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/pata_winbond.c	2007-01-17 21:14:41.000000000 +0900
@@ -158,6 +158,8 @@ static struct ata_port_operations winbon
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/pdc_adma.c linux-2.6.20-rc4.mod/drivers/ata/pdc_adma.c
--- linux-2.6.20-rc4/drivers/ata/pdc_adma.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/pdc_adma.c	2007-01-17 21:14:41.000000000 +0900
@@ -170,6 +170,8 @@ static const struct ata_port_operations 
 	.data_xfer		= ata_mmio_data_xfer,
 	.irq_handler		= adma_intr,
 	.irq_clear		= adma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 	.port_start		= adma_port_start,
 	.port_stop		= adma_port_stop,
 	.host_stop		= adma_host_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/sata_mv.c linux-2.6.20-rc4.mod/drivers/ata/sata_mv.c
--- linux-2.6.20-rc4/drivers/ata/sata_mv.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/sata_mv.c	2007-01-17 23:07:11.000000000 +0900
@@ -412,6 +412,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= mv_interrupt,
 	.irq_clear		= mv_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.scr_read		= mv5_scr_read,
 	.scr_write		= mv5_scr_write,
@@ -440,6 +442,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= mv_interrupt,
 	.irq_clear		= mv_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.scr_read		= mv_scr_read,
 	.scr_write		= mv_scr_write,
@@ -468,6 +472,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= mv_interrupt,
 	.irq_clear		= mv_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.scr_read		= mv_scr_read,
 	.scr_write		= mv_scr_write,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/sata_nv.c linux-2.6.20-rc4.mod/drivers/ata/sata_nv.c
--- linux-2.6.20-rc4/drivers/ata/sata_nv.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/sata_nv.c	2007-01-17 21:14:41.000000000 +0900
@@ -343,6 +343,8 @@ static const struct ata_port_operations 
 	.data_xfer		= ata_pio_data_xfer,
 	.irq_handler		= nv_generic_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
 	.port_start		= ata_port_start,
@@ -370,6 +372,8 @@ static const struct ata_port_operations 
 	.data_xfer		= ata_pio_data_xfer,
 	.irq_handler		= nv_nf2_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
 	.port_start		= ata_port_start,
@@ -397,6 +401,8 @@ static const struct ata_port_operations 
 	.data_xfer		= ata_pio_data_xfer,
 	.irq_handler		= nv_ck804_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
 	.port_start		= ata_port_start,
@@ -425,6 +431,8 @@ static const struct ata_port_operations 
 	.data_xfer		= ata_mmio_data_xfer,
 	.irq_handler		= nv_adma_interrupt,
 	.irq_clear		= nv_adma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
 	.port_start		= nv_adma_port_start,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/sata_promise.c linux-2.6.20-rc4.mod/drivers/ata/sata_promise.c
--- linux-2.6.20-rc4/drivers/ata/sata_promise.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/sata_promise.c	2007-01-17 23:07:11.000000000 +0900
@@ -149,6 +149,8 @@ static const struct ata_port_operations 
 	.data_xfer		= ata_mmio_data_xfer,
 	.irq_handler		= pdc_interrupt,
 	.irq_clear		= pdc_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.scr_read		= pdc_sata_scr_read,
 	.scr_write		= pdc_sata_scr_write,
@@ -173,6 +175,8 @@ static const struct ata_port_operations 
 	.eng_timeout		= pdc_eng_timeout,
 	.irq_handler		= pdc_interrupt,
 	.irq_clear		= pdc_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.port_start		= pdc_port_start,
 	.port_stop		= pdc_port_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/sata_qstor.c linux-2.6.20-rc4.mod/drivers/ata/sata_qstor.c
--- linux-2.6.20-rc4/drivers/ata/sata_qstor.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/sata_qstor.c	2007-01-17 21:14:41.000000000 +0900
@@ -161,6 +161,8 @@ static const struct ata_port_operations 
 	.eng_timeout		= qs_eng_timeout,
 	.irq_handler		= qs_intr,
 	.irq_clear		= qs_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 	.scr_read		= qs_scr_read,
 	.scr_write		= qs_scr_write,
 	.port_start		= qs_port_start,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/sata_sil.c linux-2.6.20-rc4.mod/drivers/ata/sata_sil.c
--- linux-2.6.20-rc4/drivers/ata/sata_sil.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/sata_sil.c	2007-01-17 21:14:41.000000000 +0900
@@ -207,6 +207,8 @@ static const struct ata_port_operations 
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.irq_handler		= sil_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 	.scr_read		= sil_scr_read,
 	.scr_write		= sil_scr_write,
 	.port_start		= ata_port_start,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/sata_sil24.c linux-2.6.20-rc4.mod/drivers/ata/sata_sil24.c
--- linux-2.6.20-rc4/drivers/ata/sata_sil24.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/sata_sil24.c	2007-01-17 21:14:41.000000000 +0900
@@ -406,6 +406,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= sil24_interrupt,
 	.irq_clear		= sil24_irq_clear,
+	.irq_on			= ata_dummy_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.scr_read		= sil24_scr_read,
 	.scr_write		= sil24_scr_write,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/sata_sis.c linux-2.6.20-rc4.mod/drivers/ata/sata_sis.c
--- linux-2.6.20-rc4/drivers/ata/sata_sis.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/sata_sis.c	2007-01-17 21:14:41.000000000 +0900
@@ -119,6 +119,8 @@ static const struct ata_port_operations 
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 	.scr_read		= sis_scr_read,
 	.scr_write		= sis_scr_write,
 	.port_start		= ata_port_start,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/sata_svw.c linux-2.6.20-rc4.mod/drivers/ata/sata_svw.c
--- linux-2.6.20-rc4/drivers/ata/sata_svw.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/sata_svw.c	2007-01-17 21:14:41.000000000 +0900
@@ -356,6 +356,8 @@ static const struct ata_port_operations 
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 	.scr_read		= k2_sata_scr_read,
 	.scr_write		= k2_sata_scr_write,
 	.port_start		= ata_port_start,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/sata_sx4.c linux-2.6.20-rc4.mod/drivers/ata/sata_sx4.c
--- linux-2.6.20-rc4/drivers/ata/sata_sx4.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/sata_sx4.c	2007-01-17 21:14:41.000000000 +0900
@@ -209,6 +209,8 @@ static const struct ata_port_operations 
 	.eng_timeout		= pdc_eng_timeout,
 	.irq_handler		= pdc20621_interrupt,
 	.irq_clear		= pdc20621_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 	.port_start		= pdc_port_start,
 	.port_stop		= pdc_port_stop,
 	.host_stop		= pdc20621_host_stop,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/sata_uli.c linux-2.6.20-rc4.mod/drivers/ata/sata_uli.c
--- linux-2.6.20-rc4/drivers/ata/sata_uli.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/sata_uli.c	2007-01-17 21:14:41.000000000 +0900
@@ -117,6 +117,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.scr_read		= uli_scr_read,
 	.scr_write		= uli_scr_write,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/sata_via.c linux-2.6.20-rc4.mod/drivers/ata/sata_via.c
--- linux-2.6.20-rc4/drivers/ata/sata_via.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/sata_via.c	2007-01-17 21:14:41.000000000 +0900
@@ -134,6 +134,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
@@ -165,6 +167,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.scr_read		= svia_scr_read,
 	.scr_write		= svia_scr_write,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/drivers/ata/sata_vsc.c linux-2.6.20-rc4.mod/drivers/ata/sata_vsc.c
--- linux-2.6.20-rc4/drivers/ata/sata_vsc.c	2007-01-07 14:45:51.000000000 +0900
+++ linux-2.6.20-rc4.mod/drivers/ata/sata_vsc.c	2007-01-17 21:14:41.000000000 +0900
@@ -308,6 +308,8 @@ static const struct ata_port_operations 
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.irq_handler		= vsc_sata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 	.scr_read		= vsc_sata_scr_read,
 	.scr_write		= vsc_sata_scr_write,
 	.port_start		= ata_port_start,
diff -uprN -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4/include/linux/libata.h linux-2.6.20-rc4.mod/include/linux/libata.h
--- linux-2.6.20-rc4/include/linux/libata.h	2007-01-17 23:23:27.000000000 +0900
+++ linux-2.6.20-rc4.mod/include/linux/libata.h	2007-01-17 23:24:49.000000000 +0900
@@ -638,6 +638,8 @@ struct ata_port_operations {
 
 	irq_handler_t irq_handler;
 	void (*irq_clear) (struct ata_port *);
+	u8 (*irq_on) (struct ata_port *);
+	u8 (*irq_ack) (struct ata_port *ap, unsigned int chk_drq);
 
 	u32 (*scr_read) (struct ata_port *ap, unsigned int sc_reg);
 	void (*scr_write) (struct ata_port *ap, unsigned int sc_reg,
@@ -761,6 +763,7 @@ extern void ata_port_queue_task(struct a
 extern u32 ata_wait_register(void __iomem *reg, u32 mask, u32 val,
 			     unsigned long interval_msec,
 			     unsigned long timeout_msec);
+u8 ata_irq_on(struct ata_port *ap);
 
 /*
  * Default driver ops implementations
@@ -1202,6 +1205,8 @@ static inline u8 ata_irq_ack(struct ata_
 	return status;
 }
 
+static inline u8 ata_dummy_irq_on (struct ata_port *ap)	{ return 0; }
+
 static inline int ata_try_flush_cache(const struct ata_device *dev)
 {
 	return ata_id_wcache_enabled(dev->id) ||

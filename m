Return-Path: <akira2.iguchi@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AD2C1DE128
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2007 21:46:22 +1100 (EST)
Received: from tsb-wall.toshiba.co.jp ([133.199.160.134])
	by inet-tsb5.toshiba.co.jp  with ESMTP id l0GAkENa016624
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2007 19:46:14 +0900 (JST)
Received: (from root@localhost) by tsb-wall.toshiba.co.jp  id l0GAkFu8021519
	for linuxppc-dev@ozlabs.org; Tue, 16 Jan 2007 19:46:15 +0900 (JST)
Received: from mx2.toshiba.co.jp (localhost [127.0.0.1])
	by ovp1.toshiba.co.jp  with ESMTP id l0GAkEBf018840
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2007 19:46:14 +0900 (JST)
Message-Id: <200701161046.l0GAkEOn019773@toshiba.co.jp>
MIME-Version: 1.0
Date: Tue, 16 Jan 2007 19:46:23 +0900
From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
To: linux-ide@vger.kernel.org
Subject: [PATCH 3/4] libata-sff.c: add another IRQ calls
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

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
---

--- linux-2.6.20-rc4/drivers/ata/libata-sff.c.orig	2007-01-17 01:45:56.000000000 +0900
+++ linux-2.6.20-rc4/drivers/ata/libata-sff.c	2007-01-17 02:16:00.000000000 +0900
@@ -724,8 +724,12 @@ void ata_bmdma_thaw(struct ata_port *ap)
 	/* clear & re-enable interrupts */
 	ata_chk_status(ap);
 	ap->ops->irq_clear(ap);
-	if (ap->ioaddr.ctl_addr)	/* FIXME: hack. create a hook instead */
-		ata_irq_on(ap);
+	if (ap->ioaddr.ctl_addr) {	/* FIXME: hack. create a hook instead */
+		if (ap->ops->irq_on)
+			ap->ops->irq_on(ap);
+		else
+			ata_irq_on(ap);
+	}
 }
 
 /**

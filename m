Return-Path: <akira2.iguchi@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F0BB0DE028
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 18:27:38 +1100 (EST)
Received: from wall11.toshiba.co.jp (wall11 [133.199.90.149])
	by imx12.toshiba.co.jp  with ESMTP id l0Q7RYCh019809
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 16:27:34 +0900 (JST)
Received: (from root@localhost) by wall11.toshiba.co.jp  id l0Q7RXQr001266
	for linuxppc-dev@ozlabs.org; Fri, 26 Jan 2007 16:27:33 +0900 (JST)
Received: from mx.toshiba.co.jp (localhost [127.0.0.1])
	by ovp11.toshiba.co.jp  with ESMTP id l0Q7RWUS013492
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 16:27:32 +0900 (JST)
Message-Id: <200701260727.l0Q7RVww019397@toshiba.co.jp>
MIME-Version: 1.0
Date: Fri, 26 Jan 2007 16:27:58 +0900
From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
To: linux-ide@vger.kernel.org
Subject: [PATCH 2/3] libata: add another IRQ calls (libata drivers)
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

This patch is against each libata driver.

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

diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/ahci.c libata-tj.git.mod/drivers/ata/ahci.c
--- libata-tj.git/drivers/ata/ahci.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/ahci.c	2007-01-26 21:10:15.000000000 +0900
@@ -255,6 +255,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= ahci_interrupt,
 	.irq_clear		= ahci_irq_clear,
+	.irq_on			= ata_dummy_irq_on,
+	.irq_ack		= ata_dummy_irq_ack,
 
 	.scr_read		= ahci_scr_read,
 	.scr_write		= ahci_scr_write,
@@ -286,6 +288,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= ahci_interrupt,
 	.irq_clear		= ahci_irq_clear,
+	.irq_on			= ata_dummy_irq_on,
+	.irq_ack		= ata_dummy_irq_ack,
 
 	.scr_read		= ahci_scr_read,
 	.scr_write		= ahci_scr_write,
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/ata_generic.c libata-tj.git.mod/drivers/ata/ata_generic.c
--- libata-tj.git/drivers/ata/ata_generic.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/ata_generic.c	2007-01-26 21:10:15.000000000 +0900
@@ -148,6 +148,8 @@ static struct ata_port_operations generi
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/ata_piix.c libata-tj.git.mod/drivers/ata/ata_piix.c
--- libata-tj.git/drivers/ata/ata_piix.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/ata_piix.c	2007-01-26 21:10:15.000000000 +0900
@@ -308,6 +308,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
 };
@@ -339,6 +341,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
 };
@@ -367,6 +371,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
 };
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_ali.c libata-tj.git.mod/drivers/ata/pata_ali.c
--- libata-tj.git/drivers/ata/pata_ali.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_ali.c	2007-01-26 21:10:15.000000000 +0900
@@ -374,6 +374,8 @@ static struct ata_port_operations ali_ea
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
@@ -413,6 +415,8 @@ static struct ata_port_operations ali_20
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
@@ -449,6 +453,8 @@ static struct ata_port_operations ali_c2
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
@@ -484,6 +490,8 @@ static struct ata_port_operations ali_c5
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_amd.c libata-tj.git.mod/drivers/ata/pata_amd.c
--- libata-tj.git/drivers/ata/pata_amd.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_amd.c	2007-01-26 21:10:15.000000000 +0900
@@ -366,6 +366,8 @@ static struct ata_port_operations amd33_
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
@@ -398,6 +400,8 @@ static struct ata_port_operations amd66_
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
@@ -430,6 +434,8 @@ static struct ata_port_operations amd100
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
@@ -462,6 +468,8 @@ static struct ata_port_operations amd133
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
@@ -494,6 +502,8 @@ static struct ata_port_operations nv100_
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
@@ -526,6 +536,8 @@ static struct ata_port_operations nv133_
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_artop.c libata-tj.git.mod/drivers/ata/pata_artop.c
--- libata-tj.git/drivers/ata/pata_artop.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_artop.c	2007-01-26 21:10:15.000000000 +0900
@@ -345,6 +345,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
 };
@@ -375,6 +377,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
 };
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_atiixp.c libata-tj.git.mod/drivers/ata/pata_atiixp.c
--- libata-tj.git/drivers/ata/pata_atiixp.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_atiixp.c	2007-01-26 21:10:15.000000000 +0900
@@ -249,6 +249,8 @@ static struct ata_port_operations atiixp
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_cmd64x.c libata-tj.git.mod/drivers/ata/pata_cmd64x.c
--- libata-tj.git/drivers/ata/pata_cmd64x.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_cmd64x.c	2007-01-26 21:10:15.000000000 +0900
@@ -308,6 +308,8 @@ static struct ata_port_operations cmd64x
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
@@ -340,6 +342,8 @@ static struct ata_port_operations cmd646
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
@@ -372,6 +376,8 @@ static struct ata_port_operations cmd648
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_cs5520.c libata-tj.git.mod/drivers/ata/pata_cs5520.c
--- libata-tj.git/drivers/ata/pata_cs5520.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_cs5520.c	2007-01-26 21:10:15.000000000 +0900
@@ -197,6 +197,8 @@ static struct ata_port_operations cs5520
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
 };
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_cs5530.c libata-tj.git.mod/drivers/ata/pata_cs5530.c
--- libata-tj.git/drivers/ata/pata_cs5530.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_cs5530.c	2007-01-26 21:10:15.000000000 +0900
@@ -221,6 +221,8 @@ static struct ata_port_operations cs5530
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_cs5535.c libata-tj.git.mod/drivers/ata/pata_cs5535.c
--- libata-tj.git/drivers/ata/pata_cs5535.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_cs5535.c	2007-01-26 21:10:15.000000000 +0900
@@ -218,6 +218,8 @@ static struct ata_port_operations cs5535
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_cypress.c libata-tj.git.mod/drivers/ata/pata_cypress.c
--- libata-tj.git/drivers/ata/pata_cypress.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_cypress.c	2007-01-26 21:10:15.000000000 +0900
@@ -169,6 +169,8 @@ static struct ata_port_operations cy82c6
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_efar.c libata-tj.git.mod/drivers/ata/pata_efar.c
--- libata-tj.git/drivers/ata/pata_efar.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_efar.c	2007-01-26 21:10:15.000000000 +0900
@@ -265,6 +265,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
 };
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_hpt366.c libata-tj.git.mod/drivers/ata/pata_hpt366.c
--- libata-tj.git/drivers/ata/pata_hpt366.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_hpt366.c	2007-01-26 21:10:15.000000000 +0900
@@ -365,6 +365,8 @@ static struct ata_port_operations hpt366
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_hpt37x.c libata-tj.git.mod/drivers/ata/pata_hpt37x.c
--- libata-tj.git/drivers/ata/pata_hpt37x.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_hpt37x.c	2007-01-26 21:10:15.000000000 +0900
@@ -800,6 +800,8 @@ static struct ata_port_operations hpt370
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
@@ -837,6 +839,8 @@ static struct ata_port_operations hpt370
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
@@ -875,6 +879,8 @@ static struct ata_port_operations hpt372
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
@@ -913,6 +919,8 @@ static struct ata_port_operations hpt374
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_hpt3x2n.c libata-tj.git.mod/drivers/ata/pata_hpt3x2n.c
--- libata-tj.git/drivers/ata/pata_hpt3x2n.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_hpt3x2n.c	2007-01-26 21:10:15.000000000 +0900
@@ -377,6 +377,8 @@ static struct ata_port_operations hpt3x2
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_hpt3x3.c libata-tj.git.mod/drivers/ata/pata_hpt3x3.c
--- libata-tj.git/drivers/ata/pata_hpt3x3.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_hpt3x3.c	2007-01-26 21:10:15.000000000 +0900
@@ -152,6 +152,8 @@ static struct ata_port_operations hpt3x3
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_isapnp.c libata-tj.git.mod/drivers/ata/pata_isapnp.c
--- libata-tj.git/drivers/ata/pata_isapnp.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_isapnp.c	2007-01-26 21:10:15.000000000 +0900
@@ -57,6 +57,8 @@ static struct ata_port_operations isapnp
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_it8213.c libata-tj.git.mod/drivers/ata/pata_it8213.c
--- libata-tj.git/drivers/ata/pata_it8213.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_it8213.c	2007-01-26 21:10:15.000000000 +0900
@@ -277,6 +277,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
 };
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_it821x.c libata-tj.git.mod/drivers/ata/pata_it821x.c
--- libata-tj.git/drivers/ata/pata_it821x.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_it821x.c	2007-01-26 21:10:15.000000000 +0900
@@ -676,6 +676,8 @@ static struct ata_port_operations it821x
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= it821x_port_start,
 };
@@ -710,6 +712,8 @@ static struct ata_port_operations it821x
 
 	.irq_clear	= ata_bmdma_irq_clear,
 	.irq_handler	= ata_interrupt,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= it821x_port_start,
 };
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_ixp4xx_cf.c libata-tj.git.mod/drivers/ata/pata_ixp4xx_cf.c
--- libata-tj.git/drivers/ata/pata_ixp4xx_cf.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_ixp4xx_cf.c	2007-01-26 21:10:15.000000000 +0900
@@ -130,6 +130,8 @@ static struct ata_port_operations ixp4xx
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ixp4xx_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_jmicron.c libata-tj.git.mod/drivers/ata/pata_jmicron.c
--- libata-tj.git/drivers/ata/pata_jmicron.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_jmicron.c	2007-01-26 21:10:15.000000000 +0900
@@ -166,6 +166,8 @@ static const struct ata_port_operations 
 	/* IRQ-related hooks */
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	/* Generic PATA PCI ATA helpers */
 	.port_start		= ata_port_start,
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_legacy.c libata-tj.git.mod/drivers/ata/pata_legacy.c
--- libata-tj.git/drivers/ata/pata_legacy.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_legacy.c	2007-01-26 21:10:15.000000000 +0900
@@ -166,6 +166,8 @@ static struct ata_port_operations simple
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
@@ -189,6 +191,8 @@ static struct ata_port_operations legacy
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
@@ -299,6 +303,8 @@ static struct ata_port_operations pdc202
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
@@ -349,6 +355,8 @@ static struct ata_port_operations ht6560
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
@@ -410,6 +418,8 @@ static struct ata_port_operations ht6560
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
@@ -526,6 +536,8 @@ static struct ata_port_operations opti82
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
@@ -654,6 +666,8 @@ static struct ata_port_operations opti82
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_marvell.c libata-tj.git.mod/drivers/ata/pata_marvell.c
--- libata-tj.git/drivers/ata/pata_marvell.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_marvell.c	2007-01-26 21:10:15.000000000 +0900
@@ -134,6 +134,8 @@ static const struct ata_port_operations 
 	/* Timeout handling */
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	/* Generic PATA PCI ATA helpers */
 	.port_start		= ata_port_start,
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_mpc52xx.c libata-tj.git.mod/drivers/ata/pata_mpc52xx.c
--- libata-tj.git/drivers/ata/pata_mpc52xx.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_mpc52xx.c	2007-01-26 21:10:15.000000000 +0900
@@ -298,6 +298,8 @@ static struct ata_port_operations mpc52x
 	.data_xfer		= ata_data_xfer,
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 	.port_start		= ata_port_start,
 };
 
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_mpiix.c libata-tj.git.mod/drivers/ata/pata_mpiix.c
--- libata-tj.git/drivers/ata/pata_mpiix.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_mpiix.c	2007-01-26 21:10:15.000000000 +0900
@@ -192,6 +192,8 @@ static struct ata_port_operations mpiix_
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_netcell.c libata-tj.git.mod/drivers/ata/pata_netcell.c
--- libata-tj.git/drivers/ata/pata_netcell.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_netcell.c	2007-01-26 21:10:15.000000000 +0900
@@ -94,6 +94,8 @@ static const struct ata_port_operations 
 	/* IRQ-related hooks */
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	/* Generic PATA PCI ATA helpers */
 	.port_start		= ata_port_start,
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_ns87410.c libata-tj.git.mod/drivers/ata/pata_ns87410.c
--- libata-tj.git/drivers/ata/pata_ns87410.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_ns87410.c	2007-01-26 21:10:15.000000000 +0900
@@ -183,6 +183,8 @@ static struct ata_port_operations ns8741
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_oldpiix.c libata-tj.git.mod/drivers/ata/pata_oldpiix.c
--- libata-tj.git/drivers/ata/pata_oldpiix.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_oldpiix.c	2007-01-26 21:10:15.000000000 +0900
@@ -263,6 +263,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
 };
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_opti.c libata-tj.git.mod/drivers/ata/pata_opti.c
--- libata-tj.git/drivers/ata/pata_opti.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_opti.c	2007-01-26 21:10:15.000000000 +0900
@@ -209,6 +209,8 @@ static struct ata_port_operations opti_p
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_optidma.c libata-tj.git.mod/drivers/ata/pata_optidma.c
--- libata-tj.git/drivers/ata/pata_optidma.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_optidma.c	2007-01-26 21:10:15.000000000 +0900
@@ -393,6 +393,8 @@ static struct ata_port_operations optidm
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
@@ -426,6 +428,8 @@ static struct ata_port_operations optipl
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_pcmcia.c libata-tj.git.mod/drivers/ata/pata_pcmcia.c
--- libata-tj.git/drivers/ata/pata_pcmcia.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_pcmcia.c	2007-01-26 21:10:15.000000000 +0900
@@ -92,6 +92,8 @@ static struct ata_port_operations pcmcia
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_pdc2027x.c libata-tj.git.mod/drivers/ata/pata_pdc2027x.c
--- libata-tj.git/drivers/ata/pata_pdc2027x.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_pdc2027x.c	2007-01-26 21:10:15.000000000 +0900
@@ -169,6 +169,8 @@ static struct ata_port_operations pdc202
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
 };
@@ -201,6 +203,8 @@ static struct ata_port_operations pdc202
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
 };
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_pdc202xx_old.c libata-tj.git.mod/drivers/ata/pata_pdc202xx_old.c
--- libata-tj.git/drivers/ata/pata_pdc202xx_old.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_pdc202xx_old.c	2007-01-26 21:10:15.000000000 +0900
@@ -298,6 +298,8 @@ static struct ata_port_operations pdc202
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
@@ -330,6 +332,8 @@ static struct ata_port_operations pdc202
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_platform.c libata-tj.git.mod/drivers/ata/pata_platform.c
--- libata-tj.git/drivers/ata/pata_platform.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_platform.c	2007-01-26 21:10:15.000000000 +0900
@@ -86,6 +86,8 @@ static struct ata_port_operations pata_p
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
 };
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_qdi.c libata-tj.git.mod/drivers/ata/pata_qdi.c
--- libata-tj.git/drivers/ata/pata_qdi.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_qdi.c	2007-01-26 21:10:15.000000000 +0900
@@ -191,6 +191,8 @@ static struct ata_port_operations qdi650
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
@@ -217,6 +219,8 @@ static struct ata_port_operations qdi658
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_radisys.c libata-tj.git.mod/drivers/ata/pata_radisys.c
--- libata-tj.git/drivers/ata/pata_radisys.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_radisys.c	2007-01-26 21:10:15.000000000 +0900
@@ -259,6 +259,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
 };
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_rz1000.c libata-tj.git.mod/drivers/ata/pata_rz1000.c
--- libata-tj.git/drivers/ata/pata_rz1000.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_rz1000.c	2007-01-26 21:10:15.000000000 +0900
@@ -122,6 +122,8 @@ static struct ata_port_operations rz1000
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_sc1200.c libata-tj.git.mod/drivers/ata/pata_sc1200.c
--- libata-tj.git/drivers/ata/pata_sc1200.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_sc1200.c	2007-01-26 21:10:15.000000000 +0900
@@ -224,6 +224,8 @@ static struct ata_port_operations sc1200
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_serverworks.c libata-tj.git.mod/drivers/ata/pata_serverworks.c
--- libata-tj.git/drivers/ata/pata_serverworks.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_serverworks.c	2007-01-26 21:10:15.000000000 +0900
@@ -352,6 +352,8 @@ static struct ata_port_operations server
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
@@ -385,6 +387,8 @@ static struct ata_port_operations server
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_sil680.c libata-tj.git.mod/drivers/ata/pata_sil680.c
--- libata-tj.git/drivers/ata/pata_sil680.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_sil680.c	2007-01-26 21:10:15.000000000 +0900
@@ -256,6 +256,8 @@ static struct ata_port_operations sil680
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_sis.c libata-tj.git.mod/drivers/ata/pata_sis.c
--- libata-tj.git/drivers/ata/pata_sis.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_sis.c	2007-01-26 21:10:15.000000000 +0900
@@ -605,6 +605,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
 };
@@ -636,6 +638,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
 };
@@ -668,6 +672,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
 };
@@ -699,6 +705,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
 };
@@ -730,6 +738,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
 };
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_sl82c105.c libata-tj.git.mod/drivers/ata/pata_sl82c105.c
--- libata-tj.git/drivers/ata/pata_sl82c105.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_sl82c105.c	2007-01-26 21:10:15.000000000 +0900
@@ -266,6 +266,8 @@ static struct ata_port_operations sl82c1
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_triflex.c libata-tj.git.mod/drivers/ata/pata_triflex.c
--- libata-tj.git/drivers/ata/pata_triflex.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_triflex.c	2007-01-26 21:10:15.000000000 +0900
@@ -225,6 +225,8 @@ static struct ata_port_operations trifle
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_via.c libata-tj.git.mod/drivers/ata/pata_via.c
--- libata-tj.git/drivers/ata/pata_via.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_via.c	2007-01-26 21:10:15.000000000 +0900
@@ -336,6 +336,8 @@ static struct ata_port_operations via_po
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
@@ -369,6 +371,8 @@ static struct ata_port_operations via_po
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pata_winbond.c libata-tj.git.mod/drivers/ata/pata_winbond.c
--- libata-tj.git/drivers/ata/pata_winbond.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pata_winbond.c	2007-01-26 21:10:15.000000000 +0900
@@ -160,6 +160,8 @@ static struct ata_port_operations winbon
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+	.irq_ack	= ata_irq_ack,
 
 	.port_start	= ata_port_start,
 };
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/pdc_adma.c libata-tj.git.mod/drivers/ata/pdc_adma.c
--- libata-tj.git/drivers/ata/pdc_adma.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/pdc_adma.c	2007-01-26 21:10:15.000000000 +0900
@@ -175,6 +175,8 @@ static const struct ata_port_operations 
 	.data_xfer		= ata_data_xfer,
 	.irq_handler		= adma_intr,
 	.irq_clear		= adma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 	.port_start		= adma_port_start,
 	.port_stop		= adma_port_stop,
 	.host_stop		= adma_host_stop,
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/sata_inic162x.c libata-tj.git.mod/drivers/ata/sata_inic162x.c
--- libata-tj.git/drivers/ata/sata_inic162x.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/sata_inic162x.c	2007-01-26 21:10:15.000000000 +0900
@@ -563,6 +563,8 @@ static struct ata_port_operations inic_p
 
 	.irq_handler		= inic_interrupt,
 	.irq_clear		= inic_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.qc_prep	 	= ata_qc_prep,
 	.qc_issue		= inic_qc_issue,
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/sata_mv.c libata-tj.git.mod/drivers/ata/sata_mv.c
--- libata-tj.git/drivers/ata/sata_mv.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/sata_mv.c	2007-01-26 21:10:15.000000000 +0900
@@ -410,6 +410,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= mv_interrupt,
 	.irq_clear		= mv_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.scr_read		= mv5_scr_read,
 	.scr_write		= mv5_scr_write,
@@ -437,6 +439,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= mv_interrupt,
 	.irq_clear		= mv_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.scr_read		= mv_scr_read,
 	.scr_write		= mv_scr_write,
@@ -464,6 +468,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= mv_interrupt,
 	.irq_clear		= mv_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.scr_read		= mv_scr_read,
 	.scr_write		= mv_scr_write,
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/sata_nv.c libata-tj.git.mod/drivers/ata/sata_nv.c
--- libata-tj.git/drivers/ata/sata_nv.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/sata_nv.c	2007-01-26 21:10:15.000000000 +0900
@@ -362,6 +362,8 @@ static const struct ata_port_operations 
 	.data_xfer		= ata_data_xfer,
 	.irq_handler		= nv_generic_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
 	.port_start		= ata_port_start,
@@ -387,6 +389,8 @@ static const struct ata_port_operations 
 	.data_xfer		= ata_data_xfer,
 	.irq_handler		= nv_nf2_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
 	.port_start		= ata_port_start,
@@ -412,6 +416,8 @@ static const struct ata_port_operations 
 	.data_xfer		= ata_data_xfer,
 	.irq_handler		= nv_ck804_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
 	.port_start		= ata_port_start,
@@ -439,6 +445,8 @@ static const struct ata_port_operations 
 	.data_xfer		= ata_data_xfer,
 	.irq_handler		= nv_adma_interrupt,
 	.irq_clear		= nv_adma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
 	.port_start		= nv_adma_port_start,
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/sata_promise.c libata-tj.git.mod/drivers/ata/sata_promise.c
--- libata-tj.git/drivers/ata/sata_promise.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/sata_promise.c	2007-01-26 21:10:15.000000000 +0900
@@ -172,6 +172,8 @@ static const struct ata_port_operations 
 	.data_xfer		= ata_data_xfer,
 	.irq_handler		= pdc_interrupt,
 	.irq_clear		= pdc_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.scr_read		= pdc_sata_scr_read,
 	.scr_write		= pdc_sata_scr_write,
@@ -197,6 +199,8 @@ static const struct ata_port_operations 
 	.data_xfer		= ata_data_xfer,
 	.irq_handler		= pdc_interrupt,
 	.irq_clear		= pdc_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.scr_read		= pdc_sata_scr_read,
 	.scr_write		= pdc_sata_scr_write,
@@ -220,6 +224,8 @@ static const struct ata_port_operations 
 	.eng_timeout		= pdc_eng_timeout,
 	.irq_handler		= pdc_interrupt,
 	.irq_clear		= pdc_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.port_start		= pdc_port_start,
 };
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/sata_qstor.c libata-tj.git.mod/drivers/ata/sata_qstor.c
--- libata-tj.git/drivers/ata/sata_qstor.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/sata_qstor.c	2007-01-26 21:10:15.000000000 +0900
@@ -161,6 +161,8 @@ static const struct ata_port_operations 
 	.eng_timeout		= qs_eng_timeout,
 	.irq_handler		= qs_intr,
 	.irq_clear		= qs_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 	.scr_read		= qs_scr_read,
 	.scr_write		= qs_scr_write,
 	.port_start		= qs_port_start,
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/sata_sil.c libata-tj.git.mod/drivers/ata/sata_sil.c
--- libata-tj.git/drivers/ata/sata_sil.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/sata_sil.c	2007-01-26 21:10:15.000000000 +0900
@@ -209,6 +209,8 @@ static const struct ata_port_operations 
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.irq_handler		= sil_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 	.scr_read		= sil_scr_read,
 	.scr_write		= sil_scr_write,
 	.port_start		= ata_port_start,
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/sata_sil24.c libata-tj.git.mod/drivers/ata/sata_sil24.c
--- libata-tj.git/drivers/ata/sata_sil24.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/sata_sil24.c	2007-01-26 21:10:15.000000000 +0900
@@ -400,6 +400,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= sil24_interrupt,
 	.irq_clear		= sil24_irq_clear,
+	.irq_on			= ata_dummy_irq_on,
+	.irq_ack		= ata_dummy_irq_ack,
 
 	.scr_read		= sil24_scr_read,
 	.scr_write		= sil24_scr_write,
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/sata_sis.c libata-tj.git.mod/drivers/ata/sata_sis.c
--- libata-tj.git/drivers/ata/sata_sis.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/sata_sis.c	2007-01-26 21:10:15.000000000 +0900
@@ -122,6 +122,8 @@ static const struct ata_port_operations 
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 	.scr_read		= sis_scr_read,
 	.scr_write		= sis_scr_write,
 	.port_start		= ata_port_start,
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/sata_svw.c libata-tj.git.mod/drivers/ata/sata_svw.c
--- libata-tj.git/drivers/ata/sata_svw.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/sata_svw.c	2007-01-26 21:10:15.000000000 +0900
@@ -356,6 +356,8 @@ static const struct ata_port_operations 
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 	.scr_read		= k2_sata_scr_read,
 	.scr_write		= k2_sata_scr_write,
 	.port_start		= ata_port_start,
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/sata_sx4.c libata-tj.git.mod/drivers/ata/sata_sx4.c
--- libata-tj.git/drivers/ata/sata_sx4.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/sata_sx4.c	2007-01-26 21:10:15.000000000 +0900
@@ -207,6 +207,8 @@ static const struct ata_port_operations 
 	.eng_timeout		= pdc_eng_timeout,
 	.irq_handler		= pdc20621_interrupt,
 	.irq_clear		= pdc20621_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 	.port_start		= pdc_port_start,
 };
 
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/sata_uli.c libata-tj.git.mod/drivers/ata/sata_uli.c
--- libata-tj.git/drivers/ata/sata_uli.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/sata_uli.c	2007-01-26 21:10:15.000000000 +0900
@@ -117,6 +117,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.scr_read		= uli_scr_read,
 	.scr_write		= uli_scr_write,
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/sata_via.c libata-tj.git.mod/drivers/ata/sata_via.c
--- libata-tj.git/drivers/ata/sata_via.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/sata_via.c	2007-01-26 21:10:15.000000000 +0900
@@ -142,6 +142,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.port_start		= ata_port_start,
 };
@@ -174,6 +176,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.port_start		= vt6421_port_start,
 };
@@ -203,6 +207,8 @@ static const struct ata_port_operations 
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 
 	.scr_read		= svia_scr_read,
 	.scr_write		= svia_scr_write,
diff -uprN -X libata-tj.git/Documentation/dontdiff libata-tj.git/drivers/ata/sata_vsc.c libata-tj.git.mod/drivers/ata/sata_vsc.c
--- libata-tj.git/drivers/ata/sata_vsc.c	2007-01-20 15:49:09.000000000 +0900
+++ libata-tj.git.mod/drivers/ata/sata_vsc.c	2007-01-26 21:10:15.000000000 +0900
@@ -310,6 +310,8 @@ static const struct ata_port_operations 
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.irq_handler		= vsc_sata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
 	.scr_read		= vsc_sata_scr_read,
 	.scr_write		= vsc_sata_scr_write,
 	.port_start		= ata_port_start,

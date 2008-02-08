Return-Path: <bzolnier@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.229])
	by ozlabs.org (Postfix) with ESMTP id E2C05DED69
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Feb 2008 11:32:07 +1100 (EST)
Received: by wr-out-0506.google.com with SMTP id 68so3283992wra.13
	for <linuxppc-dev@ozlabs.org>; Thu, 07 Feb 2008 16:32:07 -0800 (PST)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Date: Fri, 08 Feb 2008 01:46:19 +0100
Message-Id: <20080208004619.17746.469.sendpatchset@localhost.localdomain>
In-Reply-To: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
References: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
Subject: [PATCH 16/18] ide: remove ->hold field from ide_hwif_t
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

->hold is write-only now, remove it.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/mips/au1xxx-ide.c |    3 ---
 drivers/ide/ppc/pmac.c        |    1 -
 include/linux/ide.h           |    1 -
 3 files changed, 5 deletions(-)

Index: b/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -617,9 +617,6 @@ static int au_ide_probe(struct device *d
 
 	hwif->dev = dev;
 
-	/* hold should be on in all cases */
-	hwif->hold                      = 1;
-
 	hwif->mmio  = 1;
 
 	/* If the user has selected DDMA assisted copies,
Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1120,7 +1120,6 @@ pmac_ide_setup_device(pmac_ide_hwif_t *p
 	hwif->hwif_data = pmif;
 	ide_init_port_hw(hwif, hw);
 	hwif->noprobe = pmif->mediabay;
-	hwif->hold = pmif->mediabay;
 	hwif->cbl = pmif->cable_80 ? ATA_CBL_PATA80 : ATA_CBL_PATA40;
 	hwif->set_pio_mode = pmac_ide_set_pio_mode;
 	if (pmif->kind == controller_un_ata6
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -573,7 +573,6 @@ typedef struct hwif_s {
 
 	unsigned	noprobe    : 1;	/* don't probe for this interface */
 	unsigned	present    : 1;	/* this interface exists */
-	unsigned	hold       : 1; /* this interface is always present */
 	unsigned	serialized : 1;	/* serialized all channel operation */
 	unsigned	sharing_irq: 1;	/* 1 = sharing irq with another hwif */
 	unsigned	reset      : 1;	/* reset after probe */

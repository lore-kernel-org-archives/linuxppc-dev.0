Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id E8B03DDE43
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Feb 2007 03:40:59 +1100 (EST)
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
To: bzolnier@gmail.com
Subject: [PATCH] (pata-2.6 fix queue) sl82c105: DMA support code cleanup (take
	2)
Date: Fri, 23 Feb 2007 19:10:39 +0300
References: <200702140043.25244.sshtylyov@ru.mvista.com>
In-Reply-To: <200702140043.25244.sshtylyov@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702231910.39783.sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fold the now equivalent code in the ide_dma_check() method into a mere call to
ide_use_dma().  Make config_for_dma() return non-zero if DMA mode has been set
and call it from the ide_dma_check() method instead of ide_dma_on().
Also, defer writing the DMA timings to the chip registers until DMA is actually
turned on (and do not enable IORDY for DMA).  Remove unnecessary code from the
init_hwif() method, improve its looks overall, and also rename the driver's
ide_dma_check() and dma_start() methods.

---
This version takes into account that the ide-use-fast-pio.patch had been merged
to mainline...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

 drivers/ide/pci/sl82c105.c |  112 ++++++++++++++++-----------------------------
 1 files changed, 41 insertions(+), 71 deletions(-)

Index: linux-2.6/drivers/ide/pci/sl82c105.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/sl82c105.c
+++ linux-2.6/drivers/ide/pci/sl82c105.c
@@ -11,6 +11,8 @@
  * Merge in Russell's HW workarounds, fix various problems
  * with the timing registers setup.
  *  -- Benjamin Herrenschmidt (01/11/03) benh@kernel.crashing.org
+ *
+ * Copyright (C) 2006-2007 MontaVista Software, Inc. <source@mvista.com>
  */
 
 #include <linux/types.h>
@@ -115,59 +117,28 @@ static void sl82c105_tune_drive(ide_driv
 }
 
 /*
- * Configure the drive and the chipset for DMA
++  * Configure the drive for DMA.
++  * We'll program the chipset only when DMA is actually turned on.
  */
 static int config_for_dma (ide_drive_t *drive)
 {
-	ide_hwif_t *hwif = HWIF(drive);
-	struct pci_dev *dev = hwif->pci_dev;
-	unsigned int reg;
-
 	DBG(("config_for_dma(drive:%s)\n", drive->name));
 
-	reg = (hwif->channel ? 0x4c : 0x44) + (drive->select.b.unit ? 4 : 0);
-
 	if (ide_config_drive_speed(drive, XFER_MW_DMA_2) != 0)
-		return 1;
-
-	pci_write_config_word(dev, reg, 0x0240);
+		return 0;
 
-	return 0;
+	return ide_dma_enable(drive);
 }
 
 /*
- * Check to see if the drive and
- * chipset is capable of DMA mode
+ * Check to see if the drive and chipset are capable of DMA mode.
  */
-
-static int sl82c105_check_drive (ide_drive_t *drive)
+static int sl82c105_ide_dma_check (ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-
-	DBG(("sl82c105_check_drive(drive:%s)\n", drive->name));
-
-	do {
-		struct hd_driveid *id = drive->id;
-
-		if (!drive->autodma)
-			break;
+	DBG(("sl82c105_ide_dma_check(drive:%s)\n", drive->name));
 
-		if (!id || !(id->capability & 1))
-			break;
-
-		/* Consult the list of known "bad" drives */
-		if (__ide_dma_bad_drive(drive))
-			break;
-
-		if (id->field_valid & 2) {
-			if ((id->dma_mword & hwif->mwdma_mask) ||
-			    (id->dma_1word & hwif->swdma_mask))
-				return 0;
-		}
-
-		if (__ide_dma_good_drive(drive) && id->eide_dma_time < 150)
-			return 0;
-	} while (0);
+	if (ide_use_dma(drive) && config_for_dma(drive))
+		return 0;
 
 	return -1;
 }
@@ -236,7 +207,7 @@ static int sl82c105_ide_dma_lost_irq(ide
  * The generic IDE core will have disabled the BMEN bit before this
  * function is called.
  */
-static void sl82c105_ide_dma_start(ide_drive_t *drive)
+static void sl82c105_dma_start(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
 	struct pci_dev *dev = hwif->pci_dev;
@@ -258,12 +229,18 @@ static int sl82c105_ide_dma_timeout(ide_
 
 static int sl82c105_ide_dma_on (ide_drive_t *drive)
 {
+	struct pci_dev *dev	= HWIF(drive)->pci_dev;
+	int rc, reg 		= 0x44 + drive->dn * 4;
+
 	DBG(("sl82c105_ide_dma_on(drive:%s)\n", drive->name));
 
-	if (config_for_dma(drive))
-		return 1;
-	printk(KERN_INFO "%s: DMA enabled\n", drive->name);
-	return __ide_dma_on(drive);
+	rc = __ide_dma_on(drive);
+	if (rc == 0) {
+		pci_write_config_word(dev, reg, 0x0200);
+
+		printk(KERN_INFO "%s: DMA enabled\n", drive->name);
+	}
+	return rc;
 }
 
 static void sl82c105_dma_off_quietly(ide_drive_t *drive)
@@ -376,7 +353,7 @@ static unsigned int __devinit init_chips
 }
 
 /*
- * Initialise the chip
+ * Initialise IDE channel
  */
 static void __devinit init_hwif_sl82c105(ide_hwif_t *hwif)
 {
@@ -396,11 +373,6 @@ static void __devinit init_hwif_sl82c105
 	hwif->drives[0].drive_data = hwif->drives[1].drive_data = 0x0909;
 	hwif->drives[0].autotune   = hwif->drives[1].autotune   = 1;
 
-	hwif->atapi_dma = 0;
-	hwif->mwdma_mask = 0;
-	hwif->swdma_mask = 0;
-	hwif->autodma = 0;
-
 	if (!hwif->dma_base)
 		return;
 
@@ -410,27 +382,27 @@ static void __devinit init_hwif_sl82c105
 		 * Never ever EVER under any circumstances enable
 		 * DMA when the bridge is this old.
 		 */
-		printk("    %s: Winbond 553 bridge revision %d, BM-DMA disabled\n",
-		       hwif->name, rev);
-	} else {
-		hwif->atapi_dma = 1;
-		hwif->mwdma_mask = 0x04;
-
-		hwif->ide_dma_check = &sl82c105_check_drive;
-		hwif->ide_dma_on = &sl82c105_ide_dma_on;
-		hwif->dma_off_quietly = &sl82c105_dma_off_quietly;
-		hwif->ide_dma_lostirq = &sl82c105_ide_dma_lost_irq;
-		hwif->dma_start = &sl82c105_ide_dma_start;
-		hwif->ide_dma_timeout = &sl82c105_ide_dma_timeout;
-
-		if (!noautodma)
-			hwif->autodma = 1;
-		hwif->drives[0].autodma = hwif->autodma;
-		hwif->drives[1].autodma = hwif->autodma;
-
-		if (hwif->mate)
-			hwif->serialized = hwif->mate->serialized = 1;
+		printk("    %s: Winbond W83C553 bridge revision %d, "
+		       "BM-DMA disabled\n", hwif->name, rev);
+		return;
 	}
+
+	hwif->atapi_dma  = 1;
+	hwif->mwdma_mask = 0x04;
+
+	hwif->ide_dma_check		= &sl82c105_ide_dma_check;
+	hwif->ide_dma_on		= &sl82c105_ide_dma_on;
+	hwif->dma_off_quietly		= &sl82c105_dma_off_quietly;
+	hwif->ide_dma_lostirq		= &sl82c105_ide_dma_lost_irq;
+	hwif->dma_start			= &sl82c105_dma_start;
+	hwif->ide_dma_timeout		= &sl82c105_ide_dma_timeout;
+
+	if (!noautodma)
+		hwif->autodma = 1;
+	hwif->drives[0].autodma = hwif->drives[1].autodma = hwif->autodma;
+
+	if (hwif->mate)
+		hwif->serialized = hwif->mate->serialized = 1;
 }
 
 static ide_pci_device_t sl82c105_chipset __devinitdata = {

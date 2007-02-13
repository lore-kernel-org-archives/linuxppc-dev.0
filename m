Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id C8F6EDDEE2
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 08:43:35 +1100 (EST)
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
To: bzolnier@gmail.com
Subject: [PATCH] (pata-2.6 fix queue) sl82c105: DMA support code cleanup
Date: Wed, 14 Feb 2007 00:43:25 +0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702140043.25244.sshtylyov@ru.mvista.com>
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

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch has been actually tested at last. :-)
Note that now this driver can be joined to the ide-use-fast-pio patch.

 drivers/ide/pci/sl82c105.c |  114 +++++++++++++++++----------------------------
 1 files changed, 45 insertions(+), 69 deletions(-)

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
@@ -114,59 +116,32 @@ static void config_for_pio(ide_drive_t *
 }
 
 /*
- * Configure the drive and the chipset for DMA
+ * Configure the drive for DMA.
+ * We'll program the chipset only when DMA is actually turned on.
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
+		return 0;
 
-	pci_write_config_word(dev, reg, 0x0240);
-
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
 	ide_hwif_t *hwif	= HWIF(drive);
+	struct hd_driveid *id	= drive->id;
 
-	DBG(("sl82c105_check_drive(drive:%s)\n", drive->name));
-
-	do {
-		struct hd_driveid *id = drive->id;
-
-		if (!drive->autodma)
-			break;
-
-		if (!id || !(id->capability & 1))
-			break;
-
-		/* Consult the list of known "bad" drives */
-		if (__ide_dma_bad_drive(drive))
-			break;
+	DBG(("sl82c105_ide_dma_check(drive:%s)\n", drive->name));
 
-		if (id->field_valid & 2) {
-			if ((id->dma_mword & hwif->mwdma_mask) ||
-			    (id->dma_1word & hwif->swdma_mask))
-				return hwif->ide_dma_on(drive);
-		}
-
-		if (__ide_dma_good_drive(drive) && id->eide_dma_time < 150)
-			return hwif->ide_dma_on(drive);
-	} while (0);
+	if (drive->autodma && (id->capability & 1) &&
+	    ide_use_dma(drive) && config_for_dma(drive))
+		return hwif->ide_dma_on(drive);
 
 	return hwif->ide_dma_off_quietly(drive);
 }
@@ -235,7 +210,7 @@ static int sl82c105_ide_dma_lost_irq(ide
  * The generic IDE core will have disabled the BMEN bit before this
  * function is called.
  */
-static void sl82c105_ide_dma_start(ide_drive_t *drive)
+static void sl82c105_dma_start(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
 	struct pci_dev *dev = hwif->pci_dev;
@@ -257,12 +232,18 @@ static int sl82c105_ide_dma_timeout(ide_
 
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
 
 static int sl82c105_ide_dma_off_quietly (ide_drive_t *drive)
@@ -396,7 +377,7 @@ static unsigned int __devinit init_chips
 }
 
 /*
- * Initialise the chip
+ * Initialise IDE channel
  */
 static void __devinit init_hwif_sl82c105(ide_hwif_t *hwif)
 {
@@ -418,11 +399,6 @@ static void __devinit init_hwif_sl82c105
 	hwif->drives[1].pio_speed = XFER_PIO_0;
 	hwif->drives[1].autotune = 1;
 
-	hwif->atapi_dma = 0;
-	hwif->mwdma_mask = 0;
-	hwif->swdma_mask = 0;
-	hwif->autodma = 0;
-
 	if (!hwif->dma_base)
 		return;
 
@@ -432,27 +408,27 @@ static void __devinit init_hwif_sl82c105
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
-		hwif->ide_dma_off_quietly = &sl82c105_ide_dma_off_quietly;
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
+	hwif->ide_dma_off_quietly	= &sl82c105_ide_dma_off_quietly;
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

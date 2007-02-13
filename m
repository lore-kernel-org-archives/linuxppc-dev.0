Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id D6945DDEF8
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 09:01:36 +1100 (EST)
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
To: bzolnier@gmail.com
Subject: [PATCH] (pata-2.6 fix queue) sl82c105: rework PIO support
Date: Wed, 14 Feb 2007 01:01:26 +0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702140101.26639.sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Get rid of the 'pio_speed' member of 'ide_drive_t' that was only used by this
driver by storing the PIO mode timings in the 'drive_data' instead -- this
allows us to greatly simplify the process  of "reloading" of the chip's timing
register and do in right in the ide_dma_off_quietly() and to turn the former
config_for_pio() into the tuneproc() method.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This patch has also been actually tested at last. :-)

 drivers/ide/pci/sl82c105.c |   90 +++++++++++++++++----------------------------
 include/linux/ide.h        |    1 
 2 files changed, 34 insertions(+), 57 deletions(-)

Index: linux-2.6/drivers/ide/pci/sl82c105.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/sl82c105.c
+++ linux-2.6/drivers/ide/pci/sl82c105.c
@@ -77,42 +77,43 @@ static unsigned int get_timing_sl82c105(
 /*
  * Configure the drive and chipset for PIO
  */
-static void config_for_pio(ide_drive_t *drive, int pio, int report, int chipset_only)
+static void sl82c105_tune_drive(ide_drive_t *drive, u8 pio)
 {
-	ide_hwif_t *hwif = HWIF(drive);
-	struct pci_dev *dev = hwif->pci_dev;
+	ide_hwif_t *hwif	= HWIF(drive);
+	struct pci_dev *dev	= hwif->pci_dev;
+	int reg			= 0x44 + drive->dn * 4;
 	ide_pio_data_t p;
-	u16 drv_ctrl = 0x909;
-	unsigned int xfer_mode, reg;
+	u16 drv_ctrl;
+	u8  xfer_mode;
 
-	DBG(("config_for_pio(drive:%s, pio:%d, report:%d, chipset_only:%d)\n",
-		drive->name, pio, report, chipset_only));
+	DBG(("sl82c105_tune_drive(drive:%s, pio:%u)\n", drive->name, pio));
 		
-	reg = (hwif->channel ? 0x4c : 0x44) + (drive->select.b.unit ? 4 : 0);
-
-	pio = ide_get_best_pio_mode(drive, pio, 5, &p);
+	xfer_mode = ide_get_best_pio_mode(drive, pio, 5, &p) + XFER_PIO_0;
 
-	xfer_mode = XFER_PIO_0 + pio;
+	if (ide_config_drive_speed(drive, xfer_mode))
+		return;
 
-	if (chipset_only || ide_config_drive_speed(drive, xfer_mode) == 0) {
-		drv_ctrl = get_timing_sl82c105(&p);
-		drive->pio_speed = xfer_mode;
-	} else
-		drive->pio_speed = XFER_PIO_0;
+	drive->drive_data = drv_ctrl = get_timing_sl82c105(&p);
 
-	if (drive->using_dma == 0) {
+	if (!drive->using_dma) {
 		/*
 		 * If we are actually using MW DMA, then we can not
 		 * reprogram the interface drive control register.
 		 */
-		pci_write_config_word(dev, reg, drv_ctrl);
-		pci_read_config_word(dev, reg, &drv_ctrl);
+		pci_write_config_word(dev, reg,  drv_ctrl);
+		pci_read_config_word (dev, reg, &drv_ctrl);
 
-		if (report) {
-			printk("%s: selected %s (%dns) (%04X)\n", drive->name,
-			       ide_xfer_verbose(xfer_mode), p.cycle_time, drv_ctrl);
-		}
 	}
+
+	printk(KERN_DEBUG "%s: selected %s (%dns) (%04X)\n", drive->name,
+	       ide_xfer_verbose(xfer_mode), p.cycle_time, drv_ctrl);
+
+	/*
+	 * We support 32-bit I/O on this interface, and it
+	 * doesn't have problems with interrupts.
+	 */
+	drive->io_32bit = 1;
+	drive->unmask	= 1;
 }
 
 /*
@@ -248,17 +249,14 @@ static int sl82c105_ide_dma_on (ide_driv
 
 static int sl82c105_ide_dma_off_quietly (ide_drive_t *drive)
 {
-	u8 speed = XFER_PIO_0;
-	int rc;
-	
+	struct pci_dev *dev	= HWIF(drive)->pci_dev;
+	int reg 		= 0x44 + drive->dn * 4;
+
 	DBG(("sl82c105_ide_dma_off_quietly(drive:%s)\n", drive->name));
 
-	rc = __ide_dma_off_quietly(drive);
-	if (drive->pio_speed)
-		speed = drive->pio_speed - XFER_PIO_0;
-	config_for_pio(drive, speed, 0, 1);
+	pci_write_config_word(dev, reg, drive->drive_data);
 
-	return rc;
+	return __ide_dma_off_quietly(drive);
 }
 
 /*
@@ -304,24 +302,6 @@ static void sl82c105_resetproc(ide_drive
 }
 	
 /*
- * We only deal with PIO mode here - DMA mode 'using_dma' is not
- * initialised at the point that this function is called.
- */
-static void tune_sl82c105(ide_drive_t *drive, u8 pio)
-{
-	DBG(("tune_sl82c105(drive:%s)\n", drive->name));
-
-	config_for_pio(drive, pio, 1, 0);
-
-	/*
-	 * We support 32-bit I/O on this interface, and it
-	 * doesn't have problems with interrupts.
-	 */
-	drive->io_32bit = 1;
-	drive->unmask = 1;
-}
-
-/*
  * Return the revision of the Winbond bridge
  * which this function is part of.
  */
@@ -385,19 +365,17 @@ static void __devinit init_hwif_sl82c105
 
 	DBG(("init_hwif_sl82c105(hwif: ide%d)\n", hwif->index));
 
-	hwif->tuneproc = tune_sl82c105;
-	hwif->selectproc = sl82c105_selectproc;
-	hwif->resetproc = sl82c105_resetproc;
+	hwif->tuneproc		= sl82c105_tune_drive;
+	hwif->selectproc	= sl82c105_selectproc;
+	hwif->resetproc 	= sl82c105_resetproc;
 
 	/*
 	 * Default to PIO 0 for fallback unless tuned otherwise.
 	 * We always autotune PIO,  this is done before DMA is checked,
 	 * so there's no risk of accidentally disabling DMA
 	 */
-	hwif->drives[0].pio_speed = XFER_PIO_0;
-	hwif->drives[0].autotune = 1;
-	hwif->drives[1].pio_speed = XFER_PIO_0;
-	hwif->drives[1].autotune = 1;
+	hwif->drives[0].drive_data = hwif->drives[1].drive_data = 0x0909;
+	hwif->drives[0].autotune   = hwif->drives[1].autotune   = 1;
 
 	if (!hwif->dma_base)
 		return;
Index: linux-2.6/include/linux/ide.h
===================================================================
--- linux-2.6.orig/include/linux/ide.h
+++ linux-2.6/include/linux/ide.h
@@ -613,7 +613,6 @@ typedef struct ide_drive_s {
 
         u8	quirk_list;	/* considered quirky, set for a specific host */
         u8	init_speed;	/* transfer rate set at boot */
-        u8	pio_speed;      /* unused by core, used by some drivers for fallback from DMA */
         u8	current_speed;	/* current transfer rate set */
         u8	dn;		/* now wide spread use */
         u8	wcache;		/* status of write cache */

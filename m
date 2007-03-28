Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id EBADCDDE0D
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Mar 2007 03:47:05 +1000 (EST)
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
To: bzolnier@gmail.com
Subject: [PATCH pata-2.6] sl82c105: rework PIO support (take 2)
Date: Wed, 28 Mar 2007 21:47:41 +0400
References: <200702140101.26639.sshtylyov@ru.mvista.com>
In-Reply-To: <200702140101.26639.sshtylyov@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703282147.41696.sshtylyov@ru.mvista.com>
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
allows us to greatly  simplify the process of "reloading" of the chip's timing
register and do it right in sl82c150_dma_off_quietly() and to get rid of two
extra arguments to config_for_pio() -- which got renamed to sl82c105_tune_pio()
and now returns a PIO mode selected, with ide_config_drive_speed() call moved
into the tuneproc() method, now called sl82c105_tune_drive() with the code to
set drive's 'io_32bit' and 'unmask' flags in its turn moved to its proper place
in the init_hwif() method.
Also, while at it, rename get_timing_sl82c105() into get_pio_timings() and get
rid of the code in it clamping cycle counts to 32 which was both incorrect and
never executed anyway...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
The patch has been actually tested at last. :-)

 drivers/ide/pci/sl82c105.c |   99 ++++++++++++++++++---------------------------
 include/linux/ide.h        |    1 
 2 files changed, 41 insertions(+), 59 deletions(-)

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
@@ -47,25 +49,19 @@
 #define CTRL_P0EN       (1 << 0)
 
 /*
- * Convert a PIO mode and cycle time to the required on/off
- * times for the interface.  This has protection against run-away
- * timings.
+ * Convert a PIO mode and cycle time to the required on/off times
+ * for the interface.  This has protection against runaway timings.
  */
-static unsigned int get_timing_sl82c105(ide_pio_data_t *p)
+static unsigned int get_pio_timings(ide_pio_data_t *p)
 {
-	unsigned int cmd_on;
-	unsigned int cmd_off;
+	unsigned int cmd_on, cmd_off;
 
-	cmd_on = (ide_pio_timings[p->pio_mode].active_time + 29) / 30;
+	cmd_on  = (ide_pio_timings[p->pio_mode].active_time + 29) / 30;
 	cmd_off = (p->cycle_time - 30 * cmd_on + 29) / 30;
 
-	if (cmd_on > 32)
-		cmd_on = 32;
 	if (cmd_on == 0)
 		cmd_on = 1;
 
-	if (cmd_off > 32)
-		cmd_off = 32;
 	if (cmd_off == 0)
 		cmd_off = 1;
 
@@ -73,44 +69,34 @@ static unsigned int get_timing_sl82c105(
 }
 
 /*
- * Configure the drive and chipset for PIO
+ * Configure the chipset for PIO mode.
  */
-static void config_for_pio(ide_drive_t *drive, int pio, int report, int chipset_only)
+static u8 sl82c105_tune_pio(ide_drive_t *drive, u8 pio)
 {
-	ide_hwif_t *hwif = HWIF(drive);
-	struct pci_dev *dev = hwif->pci_dev;
+	struct pci_dev *dev	= HWIF(drive)->pci_dev;
+	int reg			= 0x44 + drive->dn * 4;
 	ide_pio_data_t p;
-	u16 drv_ctrl = 0x909;
-	unsigned int xfer_mode, reg;
+	u16 drv_ctrl;
 
-	DBG(("config_for_pio(drive:%s, pio:%d, report:%d, chipset_only:%d)\n",
-		drive->name, pio, report, chipset_only));
-		
-	reg = (hwif->channel ? 0x4c : 0x44) + (drive->select.b.unit ? 4 : 0);
+	DBG(("sl82c105_tune_pio(drive:%s, pio:%u)\n", drive->name, pio));
 
 	pio = ide_get_best_pio_mode(drive, pio, 5, &p);
 
-	xfer_mode = XFER_PIO_0 + pio;
+	drive->drive_data = drv_ctrl = get_pio_timings(&p);
 
-	if (chipset_only || ide_config_drive_speed(drive, xfer_mode) == 0) {
-		drv_ctrl = get_timing_sl82c105(&p);
-		drive->pio_speed = xfer_mode;
-	} else
-		drive->pio_speed = XFER_PIO_0;
-
-	if (drive->using_dma == 0) {
+	if (!drive->using_dma) {
 		/*
 		 * If we are actually using MW DMA, then we can not
 		 * reprogram the interface drive control register.
 		 */
-		pci_write_config_word(dev, reg, drv_ctrl);
-		pci_read_config_word(dev, reg, &drv_ctrl);
-
-		if (report) {
-			printk("%s: selected %s (%dns) (%04X)\n", drive->name,
-			       ide_xfer_verbose(xfer_mode), p.cycle_time, drv_ctrl);
-		}
+		pci_write_config_word(dev, reg,  drv_ctrl);
+		pci_read_config_word (dev, reg, &drv_ctrl);
 	}
+
+	printk(KERN_DEBUG "%s: selected %s (%dns) (%04X)\n", drive->name,
+	       ide_xfer_verbose(pio + XFER_PIO_0), p.cycle_time, drv_ctrl);
+
+	return pio;
 }
 
 /*
@@ -267,14 +253,14 @@ static int sl82c105_ide_dma_on (ide_driv
 
 static void sl82c105_dma_off_quietly(ide_drive_t *drive)
 {
-	u8 speed = XFER_PIO_0;
+	struct pci_dev *dev	= HWIF(drive)->pci_dev;
+	int reg 		= 0x44 + drive->dn * 4;
 
 	DBG(("sl82c105_dma_off_quietly(drive:%s)\n", drive->name));
 
+	pci_write_config_word(dev, reg, drive->drive_data);
+
 	ide_dma_off_quietly(drive);
-	if (drive->pio_speed)
-		speed = drive->pio_speed - XFER_PIO_0;
-	config_for_pio(drive, speed, 0, 1);
 }
 
 /*
@@ -323,18 +309,12 @@ static void sl82c105_resetproc(ide_drive
  * We only deal with PIO mode here - DMA mode 'using_dma' is not
  * initialised at the point that this function is called.
  */
-static void tune_sl82c105(ide_drive_t *drive, u8 pio)
+static void sl82c105_tune_drive(ide_drive_t *drive, u8 pio)
 {
-	DBG(("tune_sl82c105(drive:%s)\n", drive->name));
+	DBG(("sl82c105_tune_drive(drive:%s, pio:%u)\n", drive->name, pio));
 
-	config_for_pio(drive, pio, 1, 0);
-
-	/*
-	 * We support 32-bit I/O on this interface, and it
-	 * doesn't have problems with interrupts.
-	 */
-	drive->io_32bit = 1;
-	drive->unmask = 1;
+	pio = sl82c105_tune_pio(drive, pio);
+	(void) ide_config_drive_speed(drive, XFER_PIO_0 + pio);
 }
 
 /*
@@ -401,19 +381,22 @@ static void __devinit init_hwif_sl82c105
 
 	DBG(("init_hwif_sl82c105(hwif: ide%d)\n", hwif->index));
 
-	hwif->tuneproc = tune_sl82c105;
-	hwif->selectproc = sl82c105_selectproc;
-	hwif->resetproc = sl82c105_resetproc;
+	hwif->tuneproc		= &sl82c105_tune_drive;
+	hwif->selectproc	= &sl82c105_selectproc;
+	hwif->resetproc 	= &sl82c105_resetproc;
+
+	/*
+	 * We support 32-bit I/O on this interface, and
+	 * it doesn't have problems with interrupts.
+	 */
+	hwif->drives[0].io_32bit = hwif->drives[1].io_32bit = 1;
+	hwif->drives[0].unmask   = hwif->drives[1].unmask   = 1;
 
 	/*
-	 * Default to PIO 0 for fallback unless tuned otherwise.
 	 * We always autotune PIO,  this is done before DMA is checked,
 	 * so there's no risk of accidentally disabling DMA
 	 */
-	hwif->drives[0].pio_speed = XFER_PIO_0;
-	hwif->drives[0].autotune = 1;
-	hwif->drives[1].pio_speed = XFER_PIO_0;
-	hwif->drives[1].autotune = 1;
+	hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
 
 	hwif->atapi_dma = 0;
 	hwif->mwdma_mask = 0;
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

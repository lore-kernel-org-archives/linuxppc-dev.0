Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 75A22DDEC8
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Mar 2007 06:23:56 +1000 (EST)
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
To: bzolnier@gmail.com
Subject: [PATCH pata-2.6] sl82c105: add speedproc() method and MWDMA0/1 support
Date: Thu, 29 Mar 2007 00:24:32 +0400
References: <200702140043.25244.sshtylyov@ru.mvista.com>
	<200702231913.55522.sshtylyov@ru.mvista.com>
In-Reply-To: <200702231913.55522.sshtylyov@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703290024.32035.sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add the speedproc() method for setting transfer modes, modify config_for_dma()
to call it and use ide_max_dma_mode() to select the best DMA mode.
Add support for the multiword DMA modes 0 and 1, using the upper half of the
'drive_data' field to store the DMA timings to program into the drive control
register when DMA is turned on for real.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This patch replaces sl82c105-add-speedproc.patch from pata-2.6 patchset.

 drivers/ide/pci/sl82c105.c |   71 +++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 66 insertions(+), 5 deletions(-)

Index: linux-2.6/drivers/ide/pci/sl82c105.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/sl82c105.c
+++ linux-2.6/drivers/ide/pci/sl82c105.c
@@ -82,7 +82,14 @@ static u8 sl82c105_tune_pio(ide_drive_t 
 
 	pio = ide_get_best_pio_mode(drive, pio, 5, &p);
 
-	drive->drive_data = drv_ctrl = get_pio_timings(&p);
+	drv_ctrl = get_pio_timings(&p);
+
+	/*
+	 * Store the PIO timings so that we can restore them
+	 * in case DMA will be turned off...
+	 */
+	drive->drive_data &= 0xffff0000;
+	drive->drive_data |= drv_ctrl;
 
 	if (!drive->using_dma) {
 		/*
@@ -100,14 +107,67 @@ static u8 sl82c105_tune_pio(ide_drive_t 
 }
 
 /*
+ * Configure the drive and chipset for a new transfer speed.
+ */
+static int sl82c105_tune_chipset(ide_drive_t *drive, u8 speed)
+{
+	static u16 mwdma_timings[] = {0x0707, 0x0201, 0x0200};
+	u16 drv_ctrl;
+
+ 	DBG(("sl82c105_tune_chipset(drive:%s, speed:%s)\n",
+	     drive->name, ide_xfer_verbose(speed)));
+
+	speed = ide_rate_filter(drive, speed);
+
+	switch (speed) {
+	case XFER_MW_DMA_2:
+	case XFER_MW_DMA_1:
+	case XFER_MW_DMA_0:
+		drv_ctrl = mwdma_timings[speed - XFER_MW_DMA_0];
+
+		/*
+		 * Store the DMA timings so that we can actually program
+		 * them when DMA will be turned on...
+		 */
+		drive->drive_data &= 0x0000ffff;
+		drive->drive_data |= (unsigned long)drv_ctrl << 16;
+
+		/*
+		 * If we are already using DMA, we just reprogram
+		 * the drive control register.
+		 */
+		if (drive->using_dma) {
+			struct pci_dev *dev	= HWIF(drive)->pci_dev;
+			int reg 		= 0x44 + drive->dn * 4;
+
+			pci_write_config_word(dev, reg, drv_ctrl);
+		}
+		break;
+	case XFER_PIO_5:
+	case XFER_PIO_4:
+	case XFER_PIO_3:
+	case XFER_PIO_2:
+	case XFER_PIO_1:
+	case XFER_PIO_0:
+		(void) sl82c105_tune_pio(drive, speed - XFER_PIO_0);
+		break;
+	default:
+		return -1;
+	}
+
+	return ide_config_drive_speed(drive, speed);
+}
+
+/*
  * Configure the drive for DMA.
- * We'll program the chipset only when DMA is actually turned on.
  */
 static int config_for_dma(ide_drive_t *drive)
 {
+	u8 speed = ide_max_dma_mode(drive);
+
 	DBG(("config_for_dma(drive:%s)\n", drive->name));
 
-	if (ide_config_drive_speed(drive, XFER_MW_DMA_2) != 0)
+	if (!speed || sl82c105_tune_chipset(drive, speed))
 		return 0;
 
 	return ide_dma_enable(drive);
@@ -219,7 +279,7 @@ static int sl82c105_ide_dma_on(ide_drive
 
 	rc = __ide_dma_on(drive);
 	if (rc == 0) {
-		pci_write_config_word(dev, reg, 0x0200);
+		pci_write_config_word(dev, reg, drive->drive_data >> 16);
 
 		printk(KERN_INFO "%s: DMA enabled\n", drive->name);
 	}
@@ -357,6 +417,7 @@ static void __devinit init_hwif_sl82c105
 	DBG(("init_hwif_sl82c105(hwif: ide%d)\n", hwif->index));
 
 	hwif->tuneproc		= &sl82c105_tune_drive;
+	hwif->speedproc 	= &sl82c105_tune_chipset;
 	hwif->selectproc	= &sl82c105_selectproc;
 	hwif->resetproc 	= &sl82c105_resetproc;
 
@@ -388,7 +449,7 @@ static void __devinit init_hwif_sl82c105
 	}
 
 	hwif->atapi_dma  = 1;
-	hwif->mwdma_mask = 0x04;
+	hwif->mwdma_mask = 0x07;
 
 	hwif->ide_dma_check		= &sl82c105_ide_dma_check;
 	hwif->ide_dma_on		= &sl82c105_ide_dma_on;

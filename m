Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 52B7D67B6D
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Dec 2006 05:58:02 +1100 (EST)
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
To: akpm@osdl.org, bzolnier@gmail.com
Subject: [PATCH] (2.6.19-rc6-mm2) sl82c105: straighten up IDE control/status
	register caching
Date: Tue, 5 Dec 2006 21:59:28 +0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200612052159.28202.sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-arm@lists.arm.linux.org.uk,
	alan@lxorguk.ukuu.org.uk, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Straighten up the IDE control/status register caching -- you *really* can't
cache the shared register per-channel and hope that it won't get out ouf sync.

Set the PIO fallback mode to PIO0 for the slave drive as well as master --
there was no point in having them different (most probably a resutl of typo).

Do a bit of reformat and cleanup while at it...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

 drivers/ide/pci/sl82c105.c |   31 +++++++++++++------------------
 1 files changed, 13 insertions(+), 18 deletions(-)

Index: linux-2.6/drivers/ide/pci/sl82c105.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/sl82c105.c
+++ linux-2.6/drivers/ide/pci/sl82c105.c
@@ -299,14 +299,14 @@ static void sl82c105_selectproc(ide_driv
 	//DBG(("sl82c105_selectproc(drive:%s)\n", drive->name));
 
 	mask = hwif->channel ? CTRL_P1F16 : CTRL_P0F16;
-	old = val = *((u32 *)&hwif->hwif_data);
+	old = val = (u32)pci_get_drvdata(dev);
 	if (drive->using_dma)
 		val &= ~mask;
 	else
 		val |= mask;
 	if (old != val) {
 		pci_write_config_dword(dev, 0x40, val);	
-		*((u32 *)&hwif->hwif_data) = val;
+		pci_set_drvdata(dev, (void *)val);
 	}
 }
 
@@ -316,14 +316,13 @@ static void sl82c105_selectproc(ide_driv
  */
 static void sl82c105_resetproc(ide_drive_t *drive)
 {
-	ide_hwif_t *hwif = HWIF(drive);
-	struct pci_dev *dev = hwif->pci_dev;
+	struct pci_dev *dev = HWIF(drive)->pci_dev;
 	u32 val;
 
 	DBG(("sl82c105_resetproc(drive:%s)\n", drive->name));
 
 	pci_read_config_dword(dev, 0x40, &val);
-	*((u32 *)&hwif->hwif_data) = val;
+	pci_set_drvdata(dev, (void *)val);
 }
 	
 /*
@@ -394,6 +393,7 @@ static unsigned int __devinit init_chips
 	pci_read_config_dword(dev, 0x40, &val);
 	val |= CTRL_P0EN | CTRL_P0F16 | CTRL_P1F16;
 	pci_write_config_dword(dev, 0x40, val);
+	pci_set_drvdata(dev, (void *)val);
 
 	return dev->irq;
 }
@@ -404,30 +404,25 @@ static unsigned int __devinit init_chips
 
 static void __devinit init_hwif_sl82c105(ide_hwif_t *hwif)
 {
-	struct pci_dev *dev = hwif->pci_dev;
 	unsigned int rev;
 	u8 dma_state;
-	u32 val;
-	
+
 	DBG(("init_hwif_sl82c105(hwif: ide%d)\n", hwif->index));
 
 	hwif->tuneproc = tune_sl82c105;
 	hwif->selectproc = sl82c105_selectproc;
 	hwif->resetproc = sl82c105_resetproc;
-	
-	/* Default to PIO 0 for fallback unless tuned otherwise,
-	 * we always autotune PIO, this is done before DMA is
-	 * checked, so there is no risk of accidentally disabling
-	 * DMA
-	  */
+
+	/*
+	 * Default to PIO 0 for fallback unless tuned otherwise.
+	 * We always autotune PIO,  this is done before DMA is checked,
+	 * so there's no risk of accidentally disabling DMA
+	 */
 	hwif->drives[0].pio_speed = XFER_PIO_0;
 	hwif->drives[0].autotune = 1;
-	hwif->drives[1].pio_speed = XFER_PIO_1;
+	hwif->drives[1].pio_speed = XFER_PIO_0;
 	hwif->drives[1].autotune = 1;
 
-	pci_read_config_dword(dev, 0x40, &val);
-	*((u32 *)&hwif->hwif_data) = val;
-	
 	hwif->atapi_dma = 0;
 	hwif->mwdma_mask = 0;
 	hwif->swdma_mask = 0;

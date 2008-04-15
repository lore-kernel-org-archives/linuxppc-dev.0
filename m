Return-Path: <akira2.iguchi@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 86C53DE01E
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 13:14:18 +1000 (EST)
Received: from arc11.toshiba.co.jp ([133.199.90.127])
	by imx12.toshiba.co.jp  with ESMTP id m3F3EFi2010311
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 12:14:15 +0900 (JST)
Received: (from root@localhost) by arc11.toshiba.co.jp  id m3F3EFLB002649
	for linuxppc-dev@ozlabs.org; Tue, 15 Apr 2008 12:14:15 +0900 (JST)
Received: from mx2.toshiba.co.jp (localhost [127.0.0.1])
	by ovp11.toshiba.co.jp  with ESMTP id m3F3EE44012451
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 12:14:14 +0900 (JST)
Message-Id: <200804150314.m3F3EDX7007038@toshiba.co.jp>
MIME-Version: 1.0
Date: Tue, 15 Apr 2008 12:15:08 +0900
From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
To: bzolnier@gmail.com
Subject: [PATCH] scc_pata.c: do setup itself instead of ide_setup_pci_device ()
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

scc_pata has the different BAR configuration and using ide_setup_pci_device()
is inappropriate. 
(ide_setup_pci_device() expects a normal PCI IDE controller with
BAR0..BAR3 either non-existant or being primary/secondary port bases
in I/O space.)

This patch do all needed setup itself instead of calling ide_setup_pci_device().

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
---

--- linux-2.6.25-rc1/drivers/ide/pci/scc_pata.c	2008-02-11 07:18:14.000000000 +0900
+++ linux-2.6.25-rc1_mod/drivers/ide/pci/scc_pata.c	2008-04-15 11:45:25.000000000 +0900
@@ -523,6 +523,42 @@ static int setup_mmio_scc (struct pci_de
 	return -ENOMEM;
 }
 
+static int scc_ide_setup_pci_device(struct pci_dev *dev, const struct ide_port_info *d)
+{
+	struct scc_ports *ports = pci_get_drvdata(dev);
+	ide_hwif_t *hwif = NULL;
+	hw_regs_t hw;
+	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
+	int i;
+
+	for (i = 0; i < MAX_HWIFS; i++) {
+		hwif = &ide_hwifs[i];
+		if (hwif->chipset == ide_unknown)
+			break; /* pick an unused entry */
+	}
+	if (i == MAX_HWIFS) {
+		printk(KERN_ERR "%s: too many IDE interfaces, no room in table\n", 
+		       SCC_PATA_NAME);
+		return -ENOMEM;
+	}
+
+	memset(&hw, 0, sizeof(hw));
+	for (i = IDE_DATA_OFFSET; i <= IDE_CONTROL_OFFSET; i++)
+		hw.io_ports[i] = ports->dma + 0x20 + i * 4;
+	hw.irq = dev->irq;
+	hw.dev = &dev->dev;
+	hw.chipset = ide_pci;
+	ide_init_port_hw(hwif, &hw);
+	hwif->dev = &dev->dev;
+	hwif->cds = d;
+	
+	idx[0] = hwif->index;
+
+	ide_device_add(idx, d);
+
+	return 0;
+}
+
 /**
  *	init_setup_scc	-	set up an SCC PATA Controller
  *	@dev: PCI device
@@ -545,10 +581,13 @@ static int __devinit init_setup_scc(stru
 	struct scc_ports *ports;
 	int rc;
 
+	rc = pci_enable_device(dev);
+	if (rc)
+		goto end;
+
 	rc = setup_mmio_scc(dev, d->name);
-	if (rc < 0) {
-		return rc;
-	}
+	if (rc < 0)
+		goto end;
 
 	ports = pci_get_drvdata(dev);
 	ctl_base = ports->ctl;
@@ -583,7 +622,10 @@ static int __devinit init_setup_scc(stru
 	out_be32((void*)mode_port, MODE_JCUSFEN);
 	out_be32((void*)intmask_port, INTMASK_MSK);
 
-	return ide_setup_pci_device(dev, d);
+	rc = scc_ide_setup_pci_device(dev, d);
+
+ end:
+	return rc;
 }
 
 /**
@@ -610,17 +652,6 @@ static void __devinit init_mmio_iops_scc
 	hwif->OUTSW = scc_ide_outsw;
 	hwif->OUTSL = scc_ide_outsl;
 
-	hwif->io_ports[IDE_DATA_OFFSET] = dma_base + 0x20;
-	hwif->io_ports[IDE_ERROR_OFFSET] = dma_base + 0x24;
-	hwif->io_ports[IDE_NSECTOR_OFFSET] = dma_base + 0x28;
-	hwif->io_ports[IDE_SECTOR_OFFSET] = dma_base + 0x2c;
-	hwif->io_ports[IDE_LCYL_OFFSET] = dma_base + 0x30;
-	hwif->io_ports[IDE_HCYL_OFFSET] = dma_base + 0x34;
-	hwif->io_ports[IDE_SELECT_OFFSET] = dma_base + 0x38;
-	hwif->io_ports[IDE_STATUS_OFFSET] = dma_base + 0x3c;
-	hwif->io_ports[IDE_CONTROL_OFFSET] = dma_base + 0x40;
-
-	hwif->irq = dev->irq;
 	hwif->dma_base = dma_base;
 	hwif->config_data = ports->ctl;
 	hwif->mmio = 1;

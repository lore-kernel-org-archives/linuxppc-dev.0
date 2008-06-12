Return-Path: <bzolnier@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.158])
	by ozlabs.org (Postfix) with ESMTP id A6214DE6E6
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 09:11:36 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so2639026fga.39
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 16:11:36 -0700 (PDT)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Date: Fri, 13 Jun 2008 01:13:18 +0200
Message-Id: <20080612231318.18335.110.sendpatchset@localhost.localdomain>
In-Reply-To: <20080612231224.18335.91182.sendpatchset@localhost.localdomain>
References: <20080612231224.18335.91182.sendpatchset@localhost.localdomain>
Subject: [PATCH 7/7] ide-pmac: move ide_find_port() call to
	pmac_ide_setup_device()
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Move ide_find_port() call to pmac_ide_setup_device().

While at it:

- fix return value (s/-ENODEV/-ENOENT/)

- add DRV_NAME define and use it to set name field of pmac_port_info

- use ide_find_port_slot() instead of ide_find_port()

- remove superfluous error message (ide_find_port_slot() takes care of it)

- drop IDE interface number from driver banner message (but include bus type)

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ppc/pmac.c |   42 ++++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -48,6 +48,8 @@
 #include <asm/mediabay.h>
 #endif
 
+#define DRV_NAME "ide-pmac"
+
 #undef IDE_PMAC_DEBUG
 
 #define DMA_WAIT_TIMEOUT	50
@@ -982,6 +984,7 @@ static const struct ide_port_ops pmac_id
 static const struct ide_dma_ops pmac_dma_ops;
 
 static const struct ide_port_info pmac_port_info = {
+	.name			= DRV_NAME,
 	.init_dma		= pmac_ide_init_dma,
 	.chipset		= ide_pmac,
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
@@ -1000,11 +1003,11 @@ static const struct ide_port_info pmac_p
  * Setup, register & probe an IDE channel driven by this driver, this is
  * called by one of the 2 probe functions (macio or PCI).
  */
-static int __devinit
-pmac_ide_setup_device(pmac_ide_hwif_t *pmif, ide_hwif_t *hwif, hw_regs_t *hw)
+static int __devinit pmac_ide_setup_device(pmac_ide_hwif_t *pmif, hw_regs_t *hw)
 {
 	struct device_node *np = pmif->node;
 	const int *bidp;
+	ide_hwif_t *hwif;
 	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 	struct ide_port_info d = pmac_port_info;
 
@@ -1073,16 +1076,21 @@ pmac_ide_setup_device(pmac_ide_hwif_t *p
 		msleep(jiffies_to_msecs(IDE_WAKEUP_DELAY));
 	}
 
+	printk(KERN_INFO DRV_NAME ": Found Apple %s controller (%s), "
+			 "bus ID %d%s, irq %d\n", model_name[pmif->kind],
+			 pmif->mdev ? "MacIO" : "PCI", pmif->aapl_bus_id,
+			 pmif->mediabay ? " (mediabay)" : "", hw.irq);
+
+	hwif = ide_find_port_slot(&d);
+	if (hwif == NULL)
+		return -ENOENT;
+
 	/* Setup MMIO ops */
 	default_hwif_mmiops(hwif);
        	hwif->OUTBSYNC = pmac_outbsync;
 
 	ide_init_port_hw(hwif, hw);
 
-	printk(KERN_INFO "ide%d: Found Apple %s controller, bus ID %d%s, irq %d\n",
-	       hwif->index, model_name[pmif->kind], pmif->aapl_bus_id,
-	       pmif->mediabay ? " (mediabay)" : "", hwif->irq);
-
 	idx[0] = hwif->index;
 
 	ide_device_add(idx, &d);
@@ -1112,7 +1120,6 @@ pmac_ide_macio_attach(struct macio_dev *
 {
 	void __iomem *base;
 	unsigned long regbase;
-	ide_hwif_t *hwif;
 	pmac_ide_hwif_t *pmif;
 	int irq, rc;
 	hw_regs_t hw;
@@ -1121,14 +1128,6 @@ pmac_ide_macio_attach(struct macio_dev *
 	if (pmif == NULL)
 		return -ENOMEM;
 
-	hwif = ide_find_port();
-	if (hwif == NULL) {
-		printk(KERN_ERR "ide-pmac: MacIO interface attach with no slot\n");
-		printk(KERN_ERR "          %s\n", mdev->ofdev.node->full_name);
-		rc = -ENODEV;
-		goto out_free_pmif;
-	}
-
 	if (macio_resource_count(mdev) == 0) {
 		printk(KERN_WARNING "ide-pmac: no address for %s\n",
 				    mdev->ofdev.node->full_name);
@@ -1183,7 +1182,7 @@ pmac_ide_macio_attach(struct macio_dev *
 	hw.dev = &mdev->bus->pdev->dev;
 	hw.parent = &mdev->ofdev.dev;
 
-	rc = pmac_ide_setup_device(pmif, hwif, &hw);
+	rc = pmac_ide_setup_device(pmif, &hw);
 	if (rc != 0) {
 		/* The inteface is released to the common IDE layer */
 		dev_set_drvdata(&mdev->ofdev.dev, NULL);
@@ -1242,7 +1241,6 @@ pmac_ide_macio_resume(struct macio_dev *
 static int __devinit
 pmac_ide_pci_attach(struct pci_dev *pdev, const struct pci_device_id *id)
 {
-	ide_hwif_t *hwif;
 	struct device_node *np;
 	pmac_ide_hwif_t *pmif;
 	void __iomem *base;
@@ -1260,14 +1258,6 @@ pmac_ide_pci_attach(struct pci_dev *pdev
 	if (pmif == NULL)
 		return -ENOMEM;
 
-	hwif = ide_find_port();
-	if (hwif == NULL) {
-		printk(KERN_ERR "ide-pmac: PCI interface attach with no slot\n");
-		printk(KERN_ERR "          %s\n", np->full_name);
-		rc = -ENODEV;
-		goto out_free_pmif;
-	}
-
 	if (pci_enable_device(pdev)) {
 		printk(KERN_WARNING "ide-pmac: Can't enable PCI device for "
 				    "%s\n", np->full_name);
@@ -1304,7 +1294,7 @@ pmac_ide_pci_attach(struct pci_dev *pdev
 	hw.irq = pdev->irq;
 	hw.dev = &pdev->dev;
 
-	rc = pmac_ide_setup_device(pmif, hwif, &hw);
+	rc = pmac_ide_setup_device(pmif, &hw);
 	if (rc != 0) {
 		/* The inteface is released to the common IDE layer */
 		pci_set_drvdata(pdev, NULL);

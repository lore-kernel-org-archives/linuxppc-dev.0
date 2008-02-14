Return-Path: <bzolnier@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.191])
	by ozlabs.org (Postfix) with ESMTP id 975C2DDF4D
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 11:22:23 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id g16so145124nfd.9
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 16:22:22 -0800 (PST)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Date: Thu, 14 Feb 2008 01:36:49 +0100
Message-Id: <20080214003649.12879.54140.sendpatchset@localhost.localdomain>
In-Reply-To: <20080214003621.12879.33868.sendpatchset@localhost.localdomain>
References: <20080214003621.12879.33868.sendpatchset@localhost.localdomain>
Subject: [PATCH 04/11] ppc/pmac: remove ppc_ide_md hooks
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

* Add pmac_ide_init_ports() helper and use it instead of
  pmac_ide_init_hwif_ports().

* Remove ppc_ide_md hooks - no need for them
  (IDE pmac host driver takes care of all this setup).

* Then remove no longer needed <linux/ide.h> include
  from arch/powerpc/platforms/powermac/pmac.h.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 arch/powerpc/platforms/powermac/pmac.h  |    5 ---
 arch/powerpc/platforms/powermac/setup.c |    8 -----
 drivers/ide/ppc/pmac.c                  |   50 +++++++-------------------------
 3 files changed, 11 insertions(+), 52 deletions(-)

Index: b/arch/powerpc/platforms/powermac/pmac.h
===================================================================
--- a/arch/powerpc/platforms/powermac/pmac.h
+++ b/arch/powerpc/platforms/powermac/pmac.h
@@ -2,7 +2,6 @@
 #define __PMAC_H__
 
 #include <linux/pci.h>
-#include <linux/ide.h>
 #include <linux/irq.h>
 
 /*
@@ -35,10 +34,6 @@ extern void pmac_check_ht_link(void);
 
 extern void pmac_setup_smp(void);
 
-extern unsigned long pmac_ide_get_base(int index);
-extern void pmac_ide_init_hwif_ports(hw_regs_t *hw,
-	unsigned long data_port, unsigned long ctrl_port, int *irq);
-
 extern int pmac_nvram_init(void);
 extern void pmac_pic_init(void);
 
Index: b/arch/powerpc/platforms/powermac/setup.c
===================================================================
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -574,14 +574,6 @@ static int __init pmac_probe(void)
 	ISA_DMA_THRESHOLD = ~0L;
 	DMA_MODE_READ = 1;
 	DMA_MODE_WRITE = 2;
-
-#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
-#ifdef CONFIG_BLK_DEV_IDE_PMAC
-        ppc_ide_md.ide_init_hwif	= pmac_ide_init_hwif_ports;
-        ppc_ide_md.default_io_base	= pmac_ide_get_base;
-#endif /* CONFIG_BLK_DEV_IDE_PMAC */
-#endif /* defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE) */
-
 #endif /* CONFIG_PPC32 */
 
 #ifdef CONFIG_PMAC_SMU
Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -418,37 +418,6 @@ static void pmac_ide_kauai_selectproc(id
 
 #endif /* CONFIG_BLK_DEV_IDEDMA_PMAC */
 
-/*
- * N.B. this can't be an initfunc, because the media-bay task can
- * call ide_[un]register at any time.
- */
-void
-pmac_ide_init_hwif_ports(hw_regs_t *hw,
-			      unsigned long data_port, unsigned long ctrl_port,
-			      int *irq)
-{
-	int i, ix;
-
-	if (data_port == 0)
-		return;
-
-	for (ix = 0; ix < MAX_HWIFS; ++ix)
-		if (data_port == pmac_ide[ix].regbase)
-			break;
-
-	if (ix >= MAX_HWIFS)
-		return;		/* not an IDE PMAC interface */
-
-	for (i = 0; i < 8; ++i)
-		hw->io_ports[i] = data_port + i * 0x10;
-	hw->io_ports[8] = data_port + 0x160;
-
-	if (irq != NULL)
-		*irq = pmac_ide[ix].irq;
-
-	hw->dev = &pmac_ide[ix].mdev->ofdev.dev;
-}
-
 #define PMAC_IDE_REG(x) \
 	((void __iomem *)((drive)->hwif->io_ports[IDE_DATA_OFFSET] + (x)))
 
@@ -886,12 +855,6 @@ sanitize_timings(pmac_ide_hwif_t *pmif)
 	pmif->timings[2] = pmif->timings[3] = value2;
 }
 
-unsigned long
-pmac_ide_get_base(int index)
-{
-	return pmac_ide[index].regbase;
-}
-
 /* Suspend call back, should be called after the child devices
  * have actually been suspended
  */
@@ -1108,6 +1071,15 @@ pmac_ide_setup_device(pmac_ide_hwif_t *p
 	return 0;
 }
 
+static void __devinit pmac_ide_init_ports(hw_regs_t *hw, unsigned long base)
+{
+	int i;
+
+	for (i = 0; i < 8; ++i)
+		hw->io_ports[i] = base + i * 0x10;
+	hw->io_ports[8] = base + 0x160;
+}
+
 /*
  * Attach to a macio probed interface
  */
@@ -1181,7 +1153,7 @@ pmac_ide_macio_attach(struct macio_dev *
 	dev_set_drvdata(&mdev->ofdev.dev, hwif);
 
 	memset(&hw, 0, sizeof(hw));
-	pmac_ide_init_hwif_ports(&hw, pmif->regbase, 0, NULL);
+	pmac_ide_init_ports(&hw, pmif->regbase);
 	hw.irq = irq;
 	hw.dev = &mdev->ofdev.dev;
 
@@ -1295,7 +1267,7 @@ pmac_ide_pci_attach(struct pci_dev *pdev
 	pci_set_drvdata(pdev, hwif);
 
 	memset(&hw, 0, sizeof(hw));
-	pmac_ide_init_hwif_ports(&hw, pmif->regbase, 0, NULL);
+	pmac_ide_init_ports(&hw, pmif->regbase);
 	hw.irq = pdev->irq;
 	hw.dev = &pdev->dev;
 

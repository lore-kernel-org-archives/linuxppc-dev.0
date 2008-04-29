Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 04DFFDDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 02:19:16 +1000 (EST)
Date: Tue, 29 Apr 2008 20:19:14 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] [IDE] alim15x3: disable init_hwif_ali15x3 for PowerPC
Message-ID: <20080429161914.GA4980@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We don't need init_hwif_ali15x3() on the PowerPC systems either.

Before:

ALI15X3: IDE controller (0x10b9:0x5229 rev 0xc8) at  PCI slot 0001:03:1f.0
ALI15X3: 100% native mode on irq 19
    ide0: BM-DMA at 0x1120-0x1127
    ide1: BM-DMA at 0x1128-0x112f
hda: SONY DVD RW AW-Q170A, ATAPI CD/DVD-ROM drive
hda: UDMA/66 mode selected
ide0: Disabled unable to get IRQ 14.
ide0: failed to initialize IDE interface
ide1: Disabled unable to get IRQ 15.
ide1: failed to initialize IDE interface

After:

ALI15X3: IDE controller (0x10b9:0x5229 rev 0xc8) at  PCI slot 0001:03:1f.0
ALI15X3: 100% native mode on irq 19
    ide0: BM-DMA at 0x1120-0x1127
    ide1: BM-DMA at 0x1128-0x112f
hda: SONY DVD RW AW-Q170A, ATAPI CD/DVD-ROM drive
hda: UDMA/66 mode selected
ide0 at 0x1100-0x1107,0x110a on irq 19
ide1 at 0x1110-0x1117,0x111a on irq 19
hda: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache

ide0 works well, though I can't test ide1, it isn't traced out on
the board.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/ide/pci/alim15x3.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ide/pci/alim15x3.c b/drivers/ide/pci/alim15x3.c
index b36a22b..c1922f9 100644
--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
@@ -412,14 +412,14 @@ static u8 __devinit ali_cable_detect(ide_hwif_t *hwif)
 	return cbl;
 }
 
-#ifndef CONFIG_SPARC64
+#if !defined(CONFIG_SPARC64) && !defined(CONFIG_PPC)
 /**
  *	init_hwif_ali15x3	-	Initialize the ALI IDE x86 stuff
  *	@hwif: interface to configure
  *
  *	Obtain the IRQ tables for an ALi based IDE solution on the PC
  *	class platforms. This part of the code isn't applicable to the
- *	Sparc systems
+ *	Sparc and PowerPC systems.
  */
 
 static void __devinit init_hwif_ali15x3 (ide_hwif_t *hwif)
@@ -463,7 +463,9 @@ static void __devinit init_hwif_ali15x3 (ide_hwif_t *hwif)
 			hwif->irq = irq;
 	}
 }
-#endif
+#else
+#define init_hwif_ali15x3 NULL
+#endif /* !defined(CONFIG_SPARC64) && !defined(CONFIG_PPC) */
 
 /**
  *	init_dma_ali15x3	-	set up DMA on ALi15x3
@@ -517,9 +519,7 @@ static const struct ide_dma_ops ali_dma_ops = {
 static const struct ide_port_info ali15x3_chipset __devinitdata = {
 	.name		= "ALI15X3",
 	.init_chipset	= init_chipset_ali15x3,
-#ifndef CONFIG_SPARC64
 	.init_hwif	= init_hwif_ali15x3,
-#endif
 	.init_dma	= init_dma_ali15x3,
 	.port_ops	= &ali_port_ops,
 	.pio_mask	= ATA_PIO5,
-- 
1.5.5.1

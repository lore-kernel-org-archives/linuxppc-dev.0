Return-Path: <bzolnier@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.179])
	by ozlabs.org (Postfix) with ESMTP id 88311DF026
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Feb 2008 11:32:26 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id z59so3581029pyg.27
	for <linuxppc-dev@ozlabs.org>; Thu, 07 Feb 2008 16:32:25 -0800 (PST)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Date: Fri, 08 Feb 2008 01:46:33 +0100
Message-Id: <20080208004633.17746.86105.sendpatchset@localhost.localdomain>
In-Reply-To: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
References: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
Subject: [PATCH 18/18] ide: remove ide_init_hwif_ports()
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

ide_init_hwif_ports() is only used by init_ide_data() now, inline it there.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide.c   |   11 +++++++++--
 include/linux/ide.h |   32 --------------------------------
 2 files changed, 9 insertions(+), 34 deletions(-)

Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -199,13 +199,20 @@ static void __init init_ide_data (void)
 	/* Initialise all interface structures */
 	for (index = 0; index < MAX_HWIFS; ++index) {
 		ide_hwif_t *hwif = &ide_hwifs[index];
+		unsigned long io_addr = ide_default_io_base(index);
+		unsigned long ctl_addr = ide_default_io_ctl(io_addr);
 
 		ide_init_port_data(hwif, index);
 
+#ifdef CONFIG_IDE_ARCH_OBSOLETE_INIT
 		memset(&hw, 0, sizeof(hw));
-		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0,
-				    &hwif->irq);
+		ide_std_init_ports(&hw, io_addr, ctl_addr);
+# ifdef CONFIG_PPC32
+		if (ppc_ide_md.ide_init_hwif)
+			ppc_ide_md.ide_init_hwif(&hw, io_addr, 0, &hwif->irq);
+# endif
 		memcpy(hwif->io_ports, hw.io_ports, sizeof(hw.io_ports));
+#endif
 		hwif->noprobe = !hwif->io_ports[IDE_DATA_OFFSET];
 #if !defined(CONFIG_PPC32) || !defined(CONFIG_PCI)
 		hwif->irq =
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -215,38 +215,6 @@ static inline void ide_std_init_ports(hw
 # define ide_init_default_irq(base)	(0)
 #endif
 
-#ifdef CONFIG_IDE_ARCH_OBSOLETE_INIT
-static inline void ide_init_hwif_ports(hw_regs_t *hw,
-				       unsigned long io_addr,
-				       unsigned long ctl_addr,
-				       int *irq)
-{
-	if (!ctl_addr)
-		ide_std_init_ports(hw, io_addr, ide_default_io_ctl(io_addr));
-	else
-		ide_std_init_ports(hw, io_addr, ctl_addr);
-
-	if (irq)
-		*irq = 0;
-
-	hw->io_ports[IDE_IRQ_OFFSET] = 0;
-
-#ifdef CONFIG_PPC32
-	if (ppc_ide_md.ide_init_hwif)
-		ppc_ide_md.ide_init_hwif(hw, io_addr, ctl_addr, irq);
-#endif
-}
-#else
-static inline void ide_init_hwif_ports(hw_regs_t *hw,
-				       unsigned long io_addr,
-				       unsigned long ctl_addr,
-				       int *irq)
-{
-	if (io_addr || ctl_addr)
-		printk(KERN_WARNING "%s: must not be called\n", __FUNCTION__);
-}
-#endif /* CONFIG_IDE_ARCH_OBSOLETE_INIT */
-
 /* Currently only m68k, apus and m8xx need it */
 #ifndef IDE_ARCH_ACK_INTR
 # define ide_ack_intr(hwif) (1)

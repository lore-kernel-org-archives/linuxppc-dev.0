Return-Path: <bzolnier@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id 53375DE286
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 11:23:02 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so914891uge.0
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 16:23:02 -0800 (PST)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Date: Thu, 14 Feb 2008 01:37:29 +0100
Message-Id: <20080214003729.12879.2159.sendpatchset@localhost.localdomain>
In-Reply-To: <20080214003621.12879.33868.sendpatchset@localhost.localdomain>
References: <20080214003621.12879.33868.sendpatchset@localhost.localdomain>
Subject: [PATCH 09/11] ppc: remove ppc_ide_md
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

* Add special cases for pplus and prep to ide_default_{irq,io_base}()
  (+ FIXMEs about the need to use IDE platform host driver instead).

* Remove no longer needed ppc_ide_md and struct ide_machdep_calls.

* Then remove <linux/ide.h> include from:
  - arch/powerpc/kernel/setup_32.c
  - arch/ppc/kernel/ppc_ksyms.c
  - arch/ppc/kernel/setup.c
  - arch/ppc/platforms/pplus.c
  - arch/ppc/platforms/prep_setup.c

There should be no functional changes caused by this patch.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 arch/powerpc/kernel/setup_32.c  |    8 ------
 arch/ppc/kernel/ppc_ksyms.c     |    5 ----
 arch/ppc/kernel/setup.c         |    2 -
 arch/ppc/platforms/pplus.c      |   35 -----------------------------
 arch/ppc/platforms/prep_setup.c |   38 --------------------------------
 drivers/ide/ide.c               |    4 ---
 include/asm-powerpc/ide.h       |   47 +++++++++++++++++++++++++++-------------
 7 files changed, 32 insertions(+), 107 deletions(-)

Index: b/arch/powerpc/kernel/setup_32.c
===================================================================
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -10,9 +10,6 @@
 #include <linux/reboot.h>
 #include <linux/delay.h>
 #include <linux/initrd.h>
-#if defined(CONFIG_IDE) || defined(CONFIG_IDE_MODULE)
-#include <linux/ide.h>
-#endif
 #include <linux/tty.h>
 #include <linux/bootmem.h>
 #include <linux/seq_file.h>
@@ -51,11 +48,6 @@
 
 extern void bootx_init(unsigned long r4, unsigned long phys);
 
-#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
-struct ide_machdep_calls ppc_ide_md;
-EXPORT_SYMBOL(ppc_ide_md);
-#endif
-
 int boot_cpuid;
 EXPORT_SYMBOL_GPL(boot_cpuid);
 int boot_cpuid_phys;
Index: b/arch/ppc/kernel/ppc_ksyms.c
===================================================================
--- a/arch/ppc/kernel/ppc_ksyms.c
+++ b/arch/ppc/kernel/ppc_ksyms.c
@@ -12,7 +12,6 @@
 #include <linux/irq.h>
 #include <linux/pci.h>
 #include <linux/delay.h>
-#include <linux/ide.h>
 #include <linux/pm.h>
 #include <linux/bitops.h>
 
@@ -124,10 +123,6 @@ EXPORT_SYMBOL(__ioremap);
 EXPORT_SYMBOL(iounmap);
 EXPORT_SYMBOL(ioremap_bot);	/* aka VMALLOC_END */
 
-#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
-EXPORT_SYMBOL(ppc_ide_md);
-#endif
-
 #ifdef CONFIG_PCI
 EXPORT_SYMBOL(isa_io_base);
 EXPORT_SYMBOL(isa_mem_base);
Index: b/arch/ppc/kernel/setup.c
===================================================================
--- a/arch/ppc/kernel/setup.c
+++ b/arch/ppc/kernel/setup.c
@@ -10,7 +10,6 @@
 #include <linux/reboot.h>
 #include <linux/delay.h>
 #include <linux/initrd.h>
-#include <linux/ide.h>
 #include <linux/screen_info.h>
 #include <linux/bootmem.h>
 #include <linux/seq_file.h>
@@ -57,7 +56,6 @@ extern void ppc6xx_idle(void);
 extern void power4_idle(void);
 
 extern boot_infos_t *boot_infos;
-struct ide_machdep_calls ppc_ide_md;
 
 /* Used with the BI_MEMSIZE bootinfo parameter to store the memory
    size value reported by the boot loader. */
Index: b/arch/ppc/platforms/pplus.c
===================================================================
--- a/arch/ppc/platforms/pplus.c
+++ b/arch/ppc/platforms/pplus.c
@@ -19,7 +19,6 @@
 #include <linux/ioport.h>
 #include <linux/console.h>
 #include <linux/pci.h>
-#include <linux/ide.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
 
@@ -668,35 +667,6 @@ static void __init pplus_init_IRQ(void)
 		ppc_md.progress("init_irq: exit", 0);
 }
 
-#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
-/*
- * IDE stuff.
- */
-static int pplus_ide_default_irq(unsigned long base)
-{
-	switch (base) {
-	case 0x1f0:
-		return 14;
-	case 0x170:
-		return 15;
-	default:
-		return 0;
-	}
-}
-
-static unsigned long pplus_ide_default_io_base(int index)
-{
-	switch (index) {
-	case 0:
-		return 0x1f0;
-	case 1:
-		return 0x170;
-	default:
-		return 0;
-	}
-}
-#endif
-
 #ifdef CONFIG_SMP
 /* PowerPlus (MTX) support */
 static int __init smp_pplus_probe(void)
@@ -862,11 +832,6 @@ platform_init(unsigned long r3, unsigned
 	ppc_md.find_end_of_memory = pplus_find_end_of_memory;
 	ppc_md.setup_io_mappings = pplus_map_io;
 
-#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
-	ppc_ide_md.default_irq = pplus_ide_default_irq;
-	ppc_ide_md.default_io_base = pplus_ide_default_io_base;
-#endif
-
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
 	ppc_md.progress = gen550_progress;
 #endif				/* CONFIG_SERIAL_TEXT_DEBUG */
Index: b/arch/ppc/platforms/prep_setup.c
===================================================================
--- a/arch/ppc/platforms/prep_setup.c
+++ b/arch/ppc/platforms/prep_setup.c
@@ -33,7 +33,6 @@
 #include <linux/console.h>
 #include <linux/timex.h>
 #include <linux/pci.h>
-#include <linux/ide.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
 
@@ -894,38 +893,6 @@ prep_init_IRQ(void)
 		i8259_init(MPC10X_MAPA_PCI_INTACK_ADDR, 0);
 }
 
-#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
-/*
- * IDE stuff.
- */
-static int
-prep_ide_default_irq(unsigned long base)
-{
-	switch (base) {
-		case 0x1f0: return 13;
-		case 0x170: return 13;
-		case 0x1e8: return 11;
-		case 0x168: return 10;
-		case 0xfff0: return 14;		/* MCP(N)750 ide0 */
-		case 0xffe0: return 15;		/* MCP(N)750 ide1 */
-		default: return 0;
-	}
-}
-
-static unsigned long
-prep_ide_default_io_base(int index)
-{
-	switch (index) {
-		case 0: return 0x1f0;
-		case 1: return 0x170;
-		case 2: return 0x1e8;
-		case 3: return 0x168;
-		default:
-			return 0;
-	}
-}
-#endif
-
 #ifdef CONFIG_SMP
 /* PReP (MTX) support */
 static int __init
@@ -1070,11 +1037,6 @@ prep_init(unsigned long r3, unsigned lon
 
 	ppc_md.setup_io_mappings = prep_map_io;
 
-#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
-	ppc_ide_md.default_irq = prep_ide_default_irq;
-	ppc_ide_md.default_io_base = prep_ide_default_io_base;
-#endif
-
 #ifdef CONFIG_SMP
 	smp_ops			 = &prep_smp_ops;
 #endif /* CONFIG_SMP */
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -207,10 +207,6 @@ static void __init init_ide_data (void)
 #ifdef CONFIG_IDE_ARCH_OBSOLETE_INIT
 		memset(&hw, 0, sizeof(hw));
 		ide_std_init_ports(&hw, io_addr, ctl_addr);
-# ifdef CONFIG_PPC32
-		if (ppc_ide_md.ide_init_hwif)
-			ppc_ide_md.ide_init_hwif(&hw, io_addr, 0, &hwif->irq);
-# endif
 		memcpy(hwif->io_ports, hw.io_ports, sizeof(hw.io_ports));
 #endif
 		hwif->noprobe = !hwif->io_ports[IDE_DATA_OFFSET];
Index: b/include/asm-powerpc/ide.h
===================================================================
--- a/include/asm-powerpc/ide.h
+++ b/include/asm-powerpc/ide.h
@@ -31,30 +31,47 @@
 #include <linux/hdreg.h>
 #include <linux/ioport.h>
 
-struct ide_machdep_calls {
-        int         (*default_irq)(unsigned long base);
-        unsigned long (*default_io_base)(int index);
-        void        (*ide_init_hwif)(hw_regs_t *hw,
-                                     unsigned long data_port,
-                                     unsigned long ctrl_port,
-                                     int *irq);
-};
-
-extern struct ide_machdep_calls ppc_ide_md;
-
 #define IDE_ARCH_OBSOLETE_DEFAULTS
 
+/* FIXME: use ide_platform host driver */
 static __inline__ int ide_default_irq(unsigned long base)
 {
-	if (ppc_ide_md.default_irq)
-		return ppc_ide_md.default_irq(base);
+#ifdef CONFIG_PPLUS
+	switch (base) {
+	case 0x1f0:	return 14;
+	case 0x170:	return 15;
+	}
+#endif
+#ifdef CONFIG_PPC_PREP
+	switch (base) {
+	case 0x1f0:	return 13;
+	case 0x170:	return 13;
+	case 0x1e8:	return 11;
+	case 0x168:	return 10;
+	case 0xfff0:	return 14;	/* MCP(N)750 ide0 */
+	case 0xffe0:	return 15;	/* MCP(N)750 ide1 */
+	}
+#endif
 	return 0;
 }
 
+/* FIXME: use ide_platform host driver */
 static __inline__ unsigned long ide_default_io_base(int index)
 {
-	if (ppc_ide_md.default_io_base)
-		return ppc_ide_md.default_io_base(index);
+#ifdef CONFIG_PPLUS
+	switch (index) {
+	case 0:		return 0x1f0;
+	case 1:		return 0x170;
+	}
+#endif
+#ifdef CONFIG_PPC_PREP
+	switch (index) {
+	case 0:		return 0x1f0;
+	case 1:		return 0x170;
+	case 2:		return 0x1e8;
+	case 3:		return 0x168;
+	}
+#endif
 	return 0;
 }
 

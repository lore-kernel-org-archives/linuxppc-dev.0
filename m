Message-Id: <199909121740.TAA00248@piglet.cpu.lu>
Date: Sun, 12 Sep 1999 19:40:09 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: PowerPC Uniform IDE patches
To: andre@suse.com, Paul.Mackerras@cs.anu.edu.au
cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY="134392852-1804289383-937158009=:240"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--134392852-1804289383-937158009=:240
Content-Type: TEXT/plain; CHARSET=US-ASCII

Hi all,

Below is a patch against Andre's latest 2.2.12 Uniform IDE driver, in
order to make it work on the PowerPC.

Paul, is this patch OK with you? If yes, Andre, I'd suggest that you
integrate this into your Uniform IDE stuff.

To others using Andre's IDE stuff: please test and see if it breaks
anything...

Patch below applies to a kernel.org 2.2.12 tree, patched with
'ide.2.2.12.patch' from Andre's page on ftp.kernel.org.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

--134392852-1804289383-937158009=:240
Content-Type: TEXT/plain; CHARSET=US-ASCII
Content-Description: ide.diff

diff -uNr linux-2.2.12-pristine/arch/ppc/kernel/chrp_pci.c linux-2.2.12/arch/ppc/kernel/chrp_pci.c
--- linux-2.2.12-pristine/arch/ppc/kernel/chrp_pci.c	Thu Aug 26 21:51:03 1999
+++ linux-2.2.12/arch/ppc/kernel/chrp_pci.c	Sun Sep 12 16:47:32 1999
@@ -8,6 +8,7 @@
 #include <linux/string.h>
 #include <linux/init.h>
 #include <linux/openpic.h>
+#include <linux/ide.h>
 
 #include <asm/io.h>
 #include <asm/pgtable.h>
@@ -15,7 +16,6 @@
 #include <asm/hydra.h>
 #include <asm/prom.h>
 #include <asm/gg2.h>
-#include <asm/ide.h>
 #include <asm/machdep.h>
 
 #include "pci.h"
diff -uNr linux-2.2.12-pristine/arch/ppc/kernel/chrp_setup.c linux-2.2.12/arch/ppc/kernel/chrp_setup.c
--- linux-2.2.12-pristine/arch/ppc/kernel/chrp_setup.c	Sun Sep 12 16:49:40 1999
+++ linux-2.2.12/arch/ppc/kernel/chrp_setup.c	Sun Sep 12 16:23:23 1999
@@ -28,6 +28,7 @@
 #include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/blk.h>
+#include <linux/ide.h>
 #include <linux/ioport.h>
 #include <linux/console.h>
 #include <linux/pci.h>
@@ -38,8 +39,6 @@
 #include <asm/processor.h>
 #include <asm/io.h>
 #include <asm/pgtable.h>
-#include <linux/ide.h>
-#include <asm/ide.h>
 #include <asm/prom.h>
 #include <asm/gg2.h>
 #include <asm/pci-bridge.h>
diff -uNr linux-2.2.12-pristine/arch/ppc/kernel/mbx_setup.c linux-2.2.12/arch/ppc/kernel/mbx_setup.c
--- linux-2.2.12-pristine/arch/ppc/kernel/mbx_setup.c	Sun Sep 12 16:49:40 1999
+++ linux-2.2.12/arch/ppc/kernel/mbx_setup.c	Sun Sep 12 16:28:41 1999
@@ -30,6 +30,7 @@
 #include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/blk.h>
+#include <linux/ide.h>
 #include <linux/ioport.h>
 
 #include <asm/mmu.h>
@@ -37,7 +38,6 @@
 #include <asm/residual.h>
 #include <asm/io.h>
 #include <asm/pgtable.h>
-#include <asm/ide.h>
 #include <asm/mbx.h>
 #include <asm/machdep.h>
 
diff -uNr linux-2.2.12-pristine/arch/ppc/kernel/pmac_setup.c linux-2.2.12/arch/ppc/kernel/pmac_setup.c
--- linux-2.2.12-pristine/arch/ppc/kernel/pmac_setup.c	Sun Sep 12 16:49:40 1999
+++ linux-2.2.12/arch/ppc/kernel/pmac_setup.c	Sun Sep 12 16:45:38 1999
@@ -39,6 +39,7 @@
 #include <linux/ioport.h>
 #include <linux/major.h>
 #include <linux/blk.h>
+#include <linux/ide.h>
 #include <linux/vt_kern.h>
 #include <linux/console.h>
 #include <linux/pci.h>
@@ -54,7 +55,6 @@
 #include <asm/ohare.h>
 #include <asm/mediabay.h>
 #include <asm/feature.h>
-#include <asm/ide.h>
 #include <asm/machdep.h>
 
 #include "time.h"
@@ -584,14 +584,6 @@
 /* This is declared in drivers/block/ide-pmac.c */
 void pmac_ide_init_hwif_ports (hw_regs_t *hw, ide_ioreg_t data_port, ide_ioreg_t ctrl_port, int *irq);
 
-/*
- * This registers the standard ports for this architecture with the IDE
- * driver.
- */
-void
-ide_init_default_hwifs(void)
-{
-}
 #endif
 
 __initfunc(void
diff -uNr linux-2.2.12-pristine/arch/ppc/kernel/prep_setup.c linux-2.2.12/arch/ppc/kernel/prep_setup.c
--- linux-2.2.12-pristine/arch/ppc/kernel/prep_setup.c	Sun Sep 12 16:49:40 1999
+++ linux-2.2.12/arch/ppc/kernel/prep_setup.c	Sun Sep 12 16:27:07 1999
@@ -28,6 +28,7 @@
 #include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/blk.h>
+#include <linux/ide.h>
 #include <linux/ioport.h>
 #include <linux/console.h>
 #include <linux/timex.h>
@@ -39,8 +40,6 @@
 #include <asm/residual.h>
 #include <asm/io.h>
 #include <asm/pgtable.h>
-#include <linux/ide.h>
-#include <asm/ide.h>
 #include <asm/cache.h>
 #include <asm/dma.h>
 #include <asm/machdep.h>
diff -uNr linux-2.2.12-pristine/arch/ppc/kernel/setup.c linux-2.2.12/arch/ppc/kernel/setup.c
--- linux-2.2.12-pristine/arch/ppc/kernel/setup.c	Sun Sep 12 16:49:40 1999
+++ linux-2.2.12/arch/ppc/kernel/setup.c	Sun Sep 12 16:25:51 1999
@@ -11,14 +11,13 @@
 #include <linux/reboot.h>
 #include <linux/delay.h>
 #include <linux/blk.h>
+#include <linux/ide.h>
 
 #include <asm/adb.h>
 #include <asm/cuda.h>
 #include <asm/pmu.h>
 #include <asm/residual.h>
 #include <asm/io.h>
-#include <linux/ide.h>
-#include <asm/ide.h>
 #include <asm/prom.h>
 #include <asm/processor.h>
 #include <asm/pgtable.h>
diff -uNr linux-2.2.12-pristine/include/asm-ppc/ide.h linux-2.2.12/include/asm-ppc/ide.h
--- linux-2.2.12-pristine/include/asm-ppc/ide.h	Sun Sep 12 16:49:40 1999
+++ linux-2.2.12/include/asm-ppc/ide.h	Sun Sep 12 16:49:40 1999
@@ -59,9 +59,7 @@
 
 extern struct ide_machdep_calls ppc_ide_md;
 
-#if 0
 void ide_init_hwif_ports (hw_regs_t *hw, ide_ioreg_t data_port, ide_ioreg_t ctrl_port, int *irq);
-#endif
 
 void ide_insw(ide_ioreg_t port, void *buf, int ns);
 void ide_outsw(ide_ioreg_t port, void *buf, int ns);

--134392852-1804289383-937158009=:240--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

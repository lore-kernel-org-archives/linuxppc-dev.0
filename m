Return-Path: <niklaus.giger@member.fsf.org>
Received: from viefep24-int.chello.at (viefep18-int.chello.at [213.46.255.22])
	by ozlabs.org (Postfix) with ESMTP id C47BDDDE35
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  3 Dec 2007 07:41:56 +1100 (EST)
Received: from ng ([77.56.222.4]) by viefep28-int.chello.at
	(InterMail vM.7.08.02.02 201-2186-121-104-20070414) with ESMTP
	id <20071202204130.GURZ9569.viefep28-int.chello.at@ng>
	for <linuxppc-embedded@ozlabs.org>; Sun, 2 Dec 2007 21:41:30 +0100
From: Niklaus Giger <niklaus.giger@member.fsf.org>
To: linuxppc-embedded@ozlabs.org
Subject: Problem compiling sequoia using DENX kernel. Xenomai-patch required?
Date: Sun, 2 Dec 2007 21:41:35 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_AixUH8U7KMufXyl"
Message-Id: <200712022141.36467.niklaus.giger@member.fsf.org>
Reply-To: niklaus.giger@member.fsf.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--Boundary-00=_AixUH8U7KMufXyl
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

I tried with (tags DENX-v2.6.23.9, DENX-v.2.6.23, master) to build a kernel 
for the sequoia board.
I am using ELDK 4.1. I did a 
git checkout -b copy-master master
make ARCH=powerpc CROSS_COMPILE=ppc_4xx- CFLAGS=-g sequoia_defconfig 
make ARCH=powerpc CROSS_COMPILE=ppc_4xx- CFLAGS=-g zImage 

First I stumbled about problem compiling arch/powerpc/platforms/44x/ppc4xx*.c
file with errors like
arch/powerpc/platforms/44x/ppc4xx-pci.c: In function 'ppc4xx_setup_pci':
arch/powerpc/platforms/44x/ppc4xx-pci.c:62: sorry, unimplemented: inlining 
failed in call to 'pci_cfg_out': function body not available
arch/powerpc/platforms/44x/ppc4xx-pci.c:98: sorry, unimplemented: called from 
here

After applying the at attached patch I got farther till
  CC      kernel/softirq.o
kernel/softirq.c: In function 'raise_softirq':
kernel/softirq.c:319: sorry, unimplemented: inlining failed in call 
to 'raise_softirq_irqoff': function body not available
kernel/softirq.c:342: sorry, unimplemented: called from here
make[2]: *** [kernel/softirq.o] Fehler 1

I thought that denx compiled images for the sequoia using 2.6.23. 
Do they only work after having applied the Xenomai patch? Because if I apply 
the Xenomai patch, the kernel compiles cleanly. In this case  I think it 
would be nice to get somewhere a hint (or did I missed it somewhere) that 
this is a requirement. I lost quite a few hours as I wanted to first compile 
a "normal" kernel and afterwars apply the xenomai patch.

Any clarifikation would be appreciated.

Best regards

-- 
Niklaus Giger

--Boundary-00=_AixUH8U7KMufXyl
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="powerpc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="powerpc.diff"

diff --git a/arch/powerpc/platforms/44x/ppc4xx-nand.c b/arch/powerpc/platforms/44x/ppc4xx-nand.c
index 2fb553b..0574d2c 100644
--- a/arch/powerpc/platforms/44x/ppc4xx-nand.c
+++ b/arch/powerpc/platforms/44x/ppc4xx-nand.c
@@ -29,8 +29,6 @@
 #include <linux/mtd/nand.h>
 #include <linux/mtd/ndfc.h>
 
-#include <mm/mmu_decl.h>
-
 #include <asm/system.h>
 #include <asm/atomic.h>
 #include <asm/prom.h>
diff --git a/arch/powerpc/platforms/44x/ppc4xx-pci.c b/arch/powerpc/platforms/44x/ppc4xx-pci.c
index 4666250..137555f 100644
--- a/arch/powerpc/platforms/44x/ppc4xx-pci.c
+++ b/arch/powerpc/platforms/44x/ppc4xx-pci.c
@@ -26,8 +26,6 @@
 #include <linux/module.h>
 #include <linux/io.h>
 
-#include <mm/mmu_decl.h>
-
 #include <asm/system.h>
 #include <asm/atomic.h>
 #include <asm/pci-bridge.h>
@@ -44,6 +42,7 @@
 #endif
 
 #ifdef CONFIG_PCI
+extern unsigned long total_memory;
 
 int ppc4xx_exclude_device(struct pci_controller *hose, u_char bus,
 			   u_char devfn)
@@ -53,21 +52,6 @@ int ppc4xx_exclude_device(struct pci_controller *hose, u_char bus,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-inline void pci_writel(void *pci_reg_base, u32 offset, unsigned int val)
-{
-	writel(val, pci_reg_base + offset);
-}
-
-inline void pci_cfg_out(void *cfg, u32 offset, unsigned int value)
-{
-	out_le32((void *)((u32) cfg + offset), value);
-}
-
-inline u32 pci_cfg_in(void *cfg, u32 offset)
-{
-	return in_le32((void *)((u32) cfg + offset));
-}
-
 static void __init ppc4xx_setup_pci(struct pci_controller *hose,
 				     void *pci_reg_base, void *pci_cfg_base)
 {
diff --git a/arch/powerpc/platforms/44x/ppc4xx-usb.c b/arch/powerpc/platforms/44x/ppc4xx-usb.c
index 1b07689..87e87e6 100644
--- a/arch/powerpc/platforms/44x/ppc4xx-usb.c
+++ b/arch/powerpc/platforms/44x/ppc4xx-usb.c
@@ -25,8 +25,6 @@
 #include <linux/module.h>
 #include <linux/io.h>
 
-#include <mm/mmu_decl.h>
-
 #include <asm/system.h>
 #include <asm/atomic.h>
 #include <asm/prom.h>

--Boundary-00=_AixUH8U7KMufXyl--

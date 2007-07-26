Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 26 Jul 2007 14:07:13 +1000
Subject: [PATCH 2/3] powerpc: Make pci_iounmap actually unmap things
Message-Id: <20070726040754.7619BDDEBE@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch uses the newly added functions for testing if an address is
an ISA or PCI IO port to properly unmap things in pci_iounmap that
aren't such ports. Without that, drivers using the iomap API will never
actually unmap resources which on IBM server machines will prevent
hot-unplug of the corresponding HW adapters.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/iomap.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Index: linux-work/arch/powerpc/kernel/iomap.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/iomap.c	2007-07-26 13:44:23.000000000 +1000
+++ linux-work/arch/powerpc/kernel/iomap.c	2007-07-26 13:50:48.000000000 +1000
@@ -7,6 +7,7 @@
 #include <linux/pci.h>
 #include <linux/mm.h>
 #include <asm/io.h>
+#include <asm/pci-bridge.h>
 
 /*
  * Here comes the ppc64 implementation of the IOMAP 
@@ -136,7 +137,12 @@ void __iomem *pci_iomap(struct pci_dev *
 
 void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
 {
-	/* Nothing to do */
+	if (isa_vaddr_is_ioport(addr))
+		return;
+	if (pcibios_vaddr_is_ioport(addr))
+		return;
+	iounmap(addr);
 }
+
 EXPORT_SYMBOL(pci_iomap);
 EXPORT_SYMBOL(pci_iounmap);

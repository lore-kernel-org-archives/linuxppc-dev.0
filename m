Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 42633DDDA5
	for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2009 22:20:25 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/pci: cleanup some minor cruft
Date: Tue,  5 May 2009 07:20:08 -0500
Message-Id: <1241526009-18695-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Removed building setup-irq on ppc32, we don't use it anymore
* Remove duplicate prototype for setup_grackle() code that needs it
  gets it from <asm/grackle.h>
* Removed gratuitous pci_io_size type differences between ppc32/ppc64

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/include/asm/pci-bridge.h |    6 ------
 arch/powerpc/kernel/pci_32.c          |    8 --------
 drivers/pci/Makefile                  |    1 -
 3 files changed, 0 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 90fcfc4..586138e 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -86,17 +86,12 @@ struct pci_controller {
 	void *io_base_alloc;
 #endif
 	resource_size_t io_base_phys;
-#ifndef CONFIG_PPC64
 	resource_size_t pci_io_size;
-#endif
 
 	/* Some machines (PReP) have a non 1:1 mapping of
 	 * the PCI memory space in the CPU bus space
 	 */
 	resource_size_t pci_mem_offset;
-#ifdef CONFIG_PPC64
-	unsigned long pci_io_size;
-#endif
 
 	/* Some machines have a special region to forward the ISA
 	 * "memory" cycles such as VGA memory regions. Left to 0
@@ -185,7 +180,6 @@ extern int early_find_capability(struct pci_controller *hose, int bus,
 extern void setup_indirect_pci(struct pci_controller* hose,
 			       resource_size_t cfg_addr,
 			       resource_size_t cfg_data, u32 flags);
-extern void setup_grackle(struct pci_controller *hose);
 #else	/* CONFIG_PPC64 */
 
 /*
diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index d473634..529e677 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -447,14 +447,6 @@ static int __init pcibios_init(void)
 
 subsys_initcall(pcibios_init);
 
-/* the next one is stolen from the alpha port... */
-void __init
-pcibios_update_irq(struct pci_dev *dev, int irq)
-{
-	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
-	/* XXX FIXME - update OF device tree node interrupt property */
-}
-
 static struct pci_controller*
 pci_bus_to_hose(int bus)
 {
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index ba6af16..b77ae67 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -39,7 +39,6 @@ obj-$(CONFIG_ALPHA) += setup-bus.o setup-irq.o
 obj-$(CONFIG_ARM) += setup-bus.o setup-irq.o
 obj-$(CONFIG_PARISC) += setup-bus.o
 obj-$(CONFIG_SUPERH) += setup-bus.o setup-irq.o
-obj-$(CONFIG_PPC32) += setup-irq.o
 obj-$(CONFIG_PPC) += setup-bus.o
 obj-$(CONFIG_MIPS) += setup-bus.o setup-irq.o
 obj-$(CONFIG_X86_VISWS) += setup-irq.o
-- 
1.6.0.6

Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 26 Jul 2007 14:07:13 +1000
Subject: [PATCH 1/3] powerpc: Add function to check if address is an IO port
Message-Id: <20070726040753.E3B94DDEBB@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds a function that tells you if a given kernel virtual address
is hitting a PCI or ISA IO port permanent mapping or not. This is to
be used in the next patch to fix iomap APIs to properly unmap things.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/pci-common.c |   23 +++++++++++++++++++++++
 include/asm-powerpc/pci-bridge.h |   20 ++++++++++++++++++++
 2 files changed, 43 insertions(+)

Index: linux-work/arch/powerpc/kernel/pci-common.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/pci-common.c	2007-07-26 13:21:41.000000000 +1000
+++ linux-work/arch/powerpc/kernel/pci-common.c	2007-07-26 13:38:48.000000000 +1000
@@ -101,6 +101,29 @@ void pcibios_free_controller(struct pci_
 		kfree(phb);
 }
 
+int pcibios_vaddr_is_ioport(void __iomem *address)
+{
+	int ret = 0;
+	struct pci_controller *hose;
+	unsigned long size;
+
+	spin_lock(&hose_spinlock);
+	list_for_each_entry(hose, &hose_list, list_node) {
+#ifdef CONFIG_PPC64
+		size = hose->pci_io_size;
+#else
+		size = hose->io_resource.end - hose->io_resource.start + 1;
+#endif
+		if (address >= hose->io_base_virt &&
+		    address < (hose->io_base_virt + size)) {
+			ret = 1;
+			break;
+		}
+	}
+	spin_unlock(&hose_spinlock);
+	return ret;
+}
+
 /*
  * Return the domain number for this bus.
  */
Index: linux-work/include/asm-powerpc/pci-bridge.h
===================================================================
--- linux-work.orig/include/asm-powerpc/pci-bridge.h	2007-07-26 13:21:41.000000000 +1000
+++ linux-work/include/asm-powerpc/pci-bridge.h	2007-07-26 14:01:01.000000000 +1000
@@ -64,6 +64,14 @@ static inline struct pci_controller *pci
 	return bus->sysdata;
 }
 
+static inline int isa_vaddr_is_ioport(void __iomem *address)
+{
+	/* No specific ISA handling on ppc32 at this stage, it
+	 * all goes through PCI
+	 */
+	return 0;
+}
+
 /* These are used for config access before all the PCI probing
    has been done. */
 int early_read_config_byte(struct pci_controller *hose, int bus, int dev_fn,
@@ -231,6 +239,13 @@ extern void pcibios_free_controller(stru
 
 extern void isa_bridge_find_early(struct pci_controller *hose);
 
+static inline int isa_vaddr_is_ioport(void __iomem *address)
+{
+	/* Check if address hits the reserved legacy IO range */
+	unsigned long ea = (unsigned long)address;
+	return ea >= ISA_IO_BASE && ea < ISA_IO_END;
+}
+
 extern int pcibios_unmap_io_space(struct pci_bus *bus);
 extern int pcibios_map_io_space(struct pci_bus *bus);
 
@@ -261,11 +276,16 @@ extern struct pci_controller *
 pcibios_alloc_controller(struct device_node *dev);
 #ifdef CONFIG_PCI
 extern unsigned long pci_address_to_pio(phys_addr_t address);
+extern int pcibios_vaddr_is_ioport(void __iomem *address);
 #else
 static inline unsigned long pci_address_to_pio(phys_addr_t address)
 {
 	return (unsigned long)-1;
 }
+static inline int pcibios_vaddr_is_ioport(void __iomem *address)
+{
+	return 0;
+}
 #endif
 
 

Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 21 Nov 2007 17:16:20 +1100
Subject: [RFC/PATCH 3/14] powerpc: Fix declaration of pcibios_free_controller
In-Reply-To: <1195625777.579001.269266058699.qpush@grosgo>
Message-Id: <20071121061710.7E6B5DEAC3@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

pcibios_free_controller() is now available for both 32 and 64 bits
but the header only declares it for 64 bits. This moves the
declaration down next to the pcibios_alloc_controller() one.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 include/asm-powerpc/pci-bridge.h |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: linux-work/include/asm-powerpc/pci-bridge.h
===================================================================
--- linux-work.orig/include/asm-powerpc/pci-bridge.h	2007-11-16 13:44:32.000000000 +1100
+++ linux-work/include/asm-powerpc/pci-bridge.h	2007-11-16 13:46:40.000000000 +1100
@@ -247,7 +247,6 @@ static inline struct pci_controller *pci
 	return PCI_DN(busdn)->phb;
 }
 
-extern void pcibios_free_controller(struct pci_controller *phb);
 
 extern void isa_bridge_find_early(struct pci_controller *hose);
 
@@ -283,9 +282,11 @@ extern void
 pci_process_bridge_OF_ranges(struct pci_controller *hose,
 			   struct device_node *dev, int primary);
 
-/* Allocate a new PCI host bridge structure */
+/* Allocate & free a PCI host bridge structure */
 extern struct pci_controller *
 pcibios_alloc_controller(struct device_node *dev);
+extern void pcibios_free_controller(struct pci_controller *phb);
+
 #ifdef CONFIG_PCI
 extern unsigned long pci_address_to_pio(phys_addr_t address);
 extern int pcibios_vaddr_is_ioport(void __iomem *address);

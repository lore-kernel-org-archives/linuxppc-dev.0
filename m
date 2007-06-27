Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AB683DDEFC
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2007 04:19:20 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/8] [POWERPC] Merge asm-ppc/pci-bridge.h into
	asm-power/pci-bridge.h
Date: Wed, 27 Jun 2007 13:19:11 -0500
Message-Id: <11829683604166-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <11829683583721-git-send-email-galak@kernel.crashing.org>
References: <11829683583721-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Moved bits need for ppc32 from asm-ppc/pci-bridge.h into
asm-powerpc/pci-bridge.h.

Removed ARCH=powerpc specific bits (and comments related to ARCH=ppc)
from asm-ppc/pci-bridge.h as its only used on ARCH=ppc.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 include/asm-powerpc/pci-bridge.h |  138 +++++++++++++++++++++++++++++++++-----
 include/asm-ppc/pci-bridge.h     |   17 -----
 2 files changed, 120 insertions(+), 35 deletions(-)

diff --git a/include/asm-powerpc/pci-bridge.h b/include/asm-powerpc/pci-bridge.h
index 5261527..b032593 100644
--- a/include/asm-powerpc/pci-bridge.h
+++ b/include/asm-powerpc/pci-bridge.h
@@ -3,7 +3,103 @@
 #ifdef __KERNEL__
 
 #ifndef CONFIG_PPC64
-#include <asm-ppc/pci-bridge.h>
+#include <linux/ioport.h>
+#include <linux/pci.h>
+
+struct device_node;
+struct pci_controller;
+
+/*
+ * pci_io_base returns the memory address at which you can access
+ * the I/O space for PCI bus number `bus' (or NULL on error).
+ */
+extern void __iomem *pci_bus_io_base(unsigned int bus);
+extern unsigned long pci_bus_io_base_phys(unsigned int bus);
+extern unsigned long pci_bus_mem_base_phys(unsigned int bus);
+
+/* Allocate a new PCI host bridge structure */
+extern struct pci_controller* pcibios_alloc_controller(void);
+
+/* Helper function for setting up resources */
+extern void pci_init_resource(struct resource *res, resource_size_t start,
+			      resource_size_t end, int flags, char *name);
+
+/* Get the PCI host controller for a bus */
+extern struct pci_controller* pci_bus_to_hose(int bus);
+
+/*
+ * Structure of a PCI controller (host bridge)
+ */
+struct pci_controller {
+	struct pci_bus *bus;
+	void *arch_data;
+	int index;			/* PCI domain number */
+	struct pci_controller *next;
+	struct device *parent;
+
+	int first_busno;
+	int last_busno;
+	int self_busno;
+
+	void __iomem *io_base_virt;
+	resource_size_t io_base_phys;
+
+	/* Some machines (PReP) have a non 1:1 mapping of
+	 * the PCI memory space in the CPU bus space
+	 */
+	resource_size_t pci_mem_offset;
+
+	struct pci_ops *ops;
+	volatile unsigned int __iomem *cfg_addr;
+	volatile void __iomem *cfg_data;
+
+	/*
+	 * Used for variants of PCI indirect handling and possible quirks:
+	 *  SET_CFG_TYPE - used on 4xx or any PHB that does explicit type0/1
+	 *  EXT_REG - provides access to PCI-e extended registers
+	 *  SURPRESS_PRIMARY_BUS - we surpress the setting of PCI_PRIMARY_BUS
+	 *   on Freescale PCI-e controllers since they used the PCI_PRIMARY_BUS
+	 *   to determine which bus number to match on when generating type0
+	 *   config cycles
+	 */
+#define PPC_INDIRECT_TYPE_SET_CFG_TYPE		(0x00000001)
+#define PPC_INDIRECT_TYPE_EXT_REG		(0x00000002)
+#define PPC_INDIRECT_TYPE_SURPRESS_PRIMARY_BUS	(0x00000004)
+	u32 indirect_type;
+
+	/* Currently, we limit ourselves to 1 IO range and 3 mem
+	 * ranges since the common pci_bus structure can't handle more
+	 */
+	struct resource	io_resource;
+	struct resource mem_resources[3];
+};
+
+static inline struct pci_controller *pci_bus_to_host(struct pci_bus *bus)
+{
+	return bus->sysdata;
+}
+
+/* These are used for config access before all the PCI probing
+   has been done. */
+int early_read_config_byte(struct pci_controller *hose, int bus, int dev_fn,
+			   int where, u8 *val);
+int early_read_config_word(struct pci_controller *hose, int bus, int dev_fn,
+			   int where, u16 *val);
+int early_read_config_dword(struct pci_controller *hose, int bus, int dev_fn,
+			    int where, u32 *val);
+int early_write_config_byte(struct pci_controller *hose, int bus, int dev_fn,
+			    int where, u8 val);
+int early_write_config_word(struct pci_controller *hose, int bus, int dev_fn,
+			    int where, u16 val);
+int early_write_config_dword(struct pci_controller *hose, int bus, int dev_fn,
+			     int where, u32 val);
+
+extern void setup_indirect_pci_nomap(struct pci_controller* hose,
+			       void __iomem *cfg_addr, void __iomem *cfg_data);
+extern void setup_indirect_pci(struct pci_controller* hose,
+			       u32 cfg_addr, u32 cfg_data);
+extern void setup_grackle(struct pci_controller *hose);
+
 #else
 
 #include <linux/pci.h>
@@ -49,8 +145,8 @@ struct pci_controller {
 	 */
 	struct resource io_resource;
 	struct resource mem_resources[3];
-	int global_number;		
-	int local_number;		
+	int global_number;
+	int local_number;
 	unsigned long buid;
 	unsigned long dma_window_base_cur;
 	unsigned long dma_window_size;
@@ -132,9 +228,6 @@ static inline struct device_node *pci_bus_to_OF_node(struct pci_bus *bus)
 /** Find the bus corresponding to the indicated device node */
 struct pci_bus * pcibios_find_pci_bus(struct device_node *dn);
 
-extern void pci_process_bridge_OF_ranges(struct pci_controller *hose,
-					 struct device_node *dev, int primary);
-
 /** Remove all of the PCI devices under this bus */
 void pcibios_remove_pci_devices(struct pci_bus *bus);
 
@@ -152,22 +245,10 @@ static inline struct pci_controller *pci_bus_to_host(struct pci_bus *bus)
 	return PCI_DN(busdn)->phb;
 }
 
-extern struct pci_controller*
-pci_find_hose_for_OF_device(struct device_node* node);
-
 extern struct pci_controller *
 pcibios_alloc_controller(struct device_node *dev);
 extern void pcibios_free_controller(struct pci_controller *phb);
 
-#ifdef CONFIG_PCI
-extern unsigned long pci_address_to_pio(phys_addr_t address);
-#else
-static inline unsigned long pci_address_to_pio(phys_addr_t address)
-{
-	return (unsigned long)-1;
-}
-#endif
-
 extern void isa_bridge_find_early(struct pci_controller *hose);
 
 extern int pcibios_unmap_io_space(struct pci_bus *bus);
@@ -185,5 +266,26 @@ extern int pcibios_map_io_space(struct pci_bus *bus);
 #endif
 
 #endif /* CONFIG_PPC64 */
+
+/* Get the PCI host controller for an OF device */
+extern struct pci_controller*
+pci_find_hose_for_OF_device(struct device_node* node);
+
+/* Fill up host controller resources from the OF node */
+extern void
+pci_process_bridge_OF_ranges(struct pci_controller *hose,
+			   struct device_node *dev, int primary);
+
+#ifdef CONFIG_PCI
+extern unsigned long pci_address_to_pio(phys_addr_t address);
+#else
+static inline unsigned long pci_address_to_pio(phys_addr_t address)
+{
+	return (unsigned long)-1;
+}
+#endif
+
+
+
 #endif /* __KERNEL__ */
 #endif
diff --git a/include/asm-ppc/pci-bridge.h b/include/asm-ppc/pci-bridge.h
index c09fbf0..4d35b84 100644
--- a/include/asm-ppc/pci-bridge.h
+++ b/include/asm-ppc/pci-bridge.h
@@ -47,8 +47,6 @@ struct pci_controller {
 
 	int first_busno;
 	int last_busno;
-	int self_busno;
-	/* bus_offset is only used by ARCH=ppc */
 	int bus_offset;
 
 	void __iomem *io_base_virt;
@@ -65,24 +63,9 @@ struct pci_controller {
 	/*
 	 * If set, indirect method will set the cfg_type bit as
 	 * needed to generate type 1 configuration transactions.
-	 * use only on ARCH=ppc
 	 */
 	int set_cfg_type;
 
-	/*
-	 * Used for variants of PCI indirect handling and possible quirks:
-	 *  SET_CFG_TYPE - used on 4xx or any PHB that does explicit type0/1
-	 *  EXT_REG - provides access to PCI-e extended registers
-	 *  SURPRESS_PRIMARY_BUS - we surpress the setting of PCI_PRIMARY_BUS
-	 *   on Freescale PCI-e controllers since they used the PCI_PRIMARY_BUS
-	 *   to determine which bus number to match on when generating type0
-	 *   config cycles
-	 */
-#define PPC_INDIRECT_TYPE_SET_CFG_TYPE		(0x00000001)
-#define PPC_INDIRECT_TYPE_EXT_REG		(0x00000002)
-#define PPC_INDIRECT_TYPE_SURPRESS_PRIMARY_BUS	(0x00000004)
-	u32 indirect_type;
-
 	/* Currently, we limit ourselves to 1 IO range and 3 mem
 	 * ranges since the common pci_bus structure can't handle more
 	 */
-- 
1.5.2.1

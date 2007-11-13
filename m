Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id BD8A1DDECF
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 16:37:06 +1100 (EST)
Received: from ash.ozlabs.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id 9DFF1368004
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 16:37:06 +1100 (EST)
Date: Tue, 13 Nov 2007 16:34:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/2] [POWERPC] clean up pci-bidge.h
Message-Id: <20071113163427.2ab3fdb0.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

No semantic changes.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/asm-powerpc/pci-bridge.h |   95 +++++++++++++++++---------------------
 1 files changed, 42 insertions(+), 53 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/include/asm-powerpc/pci-bridge.h b/include/asm-powerpc/pci-bridge.h
index dc31845..d28185e 100644
--- a/include/asm-powerpc/pci-bridge.h
+++ b/include/asm-powerpc/pci-bridge.h
@@ -1,16 +1,17 @@
 #ifndef _ASM_POWERPC_PCI_BRIDGE_H
 #define _ASM_POWERPC_PCI_BRIDGE_H
 #ifdef __KERNEL__
-
+/*
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
 #include <linux/pci.h>
 #include <linux/list.h>
 #include <linux/ioport.h>
 
 #ifndef CONFIG_PPC64
-
-struct device_node;
-struct pci_controller;
-
 /*
  * Structure of a PCI controller (host bridge)
  */
@@ -51,11 +52,11 @@ struct pci_controller {
 	 *   set.
 	 *  BIG_ENDIAN - cfg_addr is a big endian register
 	 */
-#define PPC_INDIRECT_TYPE_SET_CFG_TYPE		(0x00000001)
-#define PPC_INDIRECT_TYPE_EXT_REG		(0x00000002)
-#define PPC_INDIRECT_TYPE_SURPRESS_PRIMARY_BUS	(0x00000004)
-#define PPC_INDIRECT_TYPE_NO_PCIE_LINK		(0x00000008)
-#define PPC_INDIRECT_TYPE_BIG_ENDIAN		(0x00000010)
+#define PPC_INDIRECT_TYPE_SET_CFG_TYPE		0x00000001
+#define PPC_INDIRECT_TYPE_EXT_REG		0x00000002
+#define PPC_INDIRECT_TYPE_SURPRESS_PRIMARY_BUS	0x00000004
+#define PPC_INDIRECT_TYPE_NO_PCIE_LINK		0x00000008
+#define PPC_INDIRECT_TYPE_BIG_ENDIAN		0x00000010
 	u32 indirect_type;
 
 	/* Currently, we limit ourselves to 1 IO range and 3 mem
@@ -81,18 +82,18 @@ static inline int isa_vaddr_is_ioport(void __iomem *address)
 
 /* These are used for config access before all the PCI probing
    has been done. */
-int early_read_config_byte(struct pci_controller *hose, int bus, int dev_fn,
-			   int where, u8 *val);
-int early_read_config_word(struct pci_controller *hose, int bus, int dev_fn,
-			   int where, u16 *val);
-int early_read_config_dword(struct pci_controller *hose, int bus, int dev_fn,
-			    int where, u32 *val);
-int early_write_config_byte(struct pci_controller *hose, int bus, int dev_fn,
-			    int where, u8 val);
-int early_write_config_word(struct pci_controller *hose, int bus, int dev_fn,
-			    int where, u16 val);
-int early_write_config_dword(struct pci_controller *hose, int bus, int dev_fn,
-			     int where, u32 val);
+extern int early_read_config_byte(struct pci_controller *hose, int bus,
+			int dev_fn, int where, u8 *val);
+extern int early_read_config_word(struct pci_controller *hose, int bus,
+			int dev_fn, int where, u16 *val);
+extern int early_read_config_dword(struct pci_controller *hose, int bus,
+			int dev_fn, int where, u32 *val);
+extern int early_write_config_byte(struct pci_controller *hose, int bus,
+			int dev_fn, int where, u8 val);
+extern int early_write_config_word(struct pci_controller *hose, int bus,
+			int dev_fn, int where, u16 val);
+extern int early_write_config_dword(struct pci_controller *hose, int bus,
+			int dev_fn, int where, u32 val);
 
 extern int early_find_capability(struct pci_controller *hose, int bus,
 				 int dev_fn, int cap);
@@ -104,15 +105,7 @@ extern void setup_grackle(struct pci_controller *hose);
 extern void __init update_bridge_resource(struct pci_dev *dev,
 					  struct resource *res);
 
-#else
-
-
-/*
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
+#else	/* CONFIG_PPC64 */
 
 /*
  * Structure of a PCI controller (host bridge)
@@ -159,8 +152,8 @@ struct pci_controller {
  * PCI stuff, for nodes representing PCI devices, pointed to
  * by device_node->data.
  */
-struct pci_controller;
 struct iommu_table;
+struct device_node;
 
 struct pci_dn {
 	int	busno;			/* pci bus number */
@@ -179,9 +172,9 @@ struct pci_dn {
 	int	eeh_mode;		/* See eeh.h for possible EEH_MODEs */
 	int	eeh_config_addr;
 	int	eeh_pe_config_addr; /* new-style partition endpoint address */
-	int 	eeh_check_count;	/* # times driver ignored error */
-	int 	eeh_freeze_count;	/* # times this device froze up. */
-	int 	eeh_false_positives;	/* # times this device reported #ff's */
+	int	eeh_check_count;	/* # times driver ignored error */
+	int	eeh_freeze_count;	/* # times this device froze up. */
+	int	eeh_false_positives;	/* # times this device reported #ff's */
 	u32	config_space[16];	/* saved PCI config space */
 #endif
 };
@@ -189,7 +182,7 @@ struct pci_dn {
 /* Get the pointer to a device_node's pci_dn */
 #define PCI_DN(dn)	((struct pci_dn *) (dn)->data)
 
-struct device_node *fetch_dev_dn(struct pci_dev *dev);
+extern struct device_node *fetch_dev_dn(struct pci_dev *dev);
 
 /* Get a device_node from a pci_dev.  This code must be fast except
  * in the case where the sysdata is incorrect and needs to be fixed
@@ -227,14 +220,14 @@ static inline struct device_node *pci_bus_to_OF_node(struct pci_bus *bus)
 }
 
 /** Find the bus corresponding to the indicated device node */
-struct pci_bus * pcibios_find_pci_bus(struct device_node *dn);
+extern struct pci_bus *pcibios_find_pci_bus(struct device_node *dn);
 
 /** Remove all of the PCI devices under this bus */
-void pcibios_remove_pci_devices(struct pci_bus *bus);
+extern void pcibios_remove_pci_devices(struct pci_bus *bus);
 
 /** Discover new pci devices under this bus, and add them */
-void pcibios_add_pci_devices(struct pci_bus * bus);
-void pcibios_fixup_new_pci_devices(struct pci_bus *bus, int fix_bus);
+extern void pcibios_add_pci_devices(struct pci_bus *bus);
+extern void pcibios_fixup_new_pci_devices(struct pci_bus *bus, int fix_bus);
 
 extern int pcibios_remove_root_bus(struct pci_controller *phb);
 
@@ -271,20 +264,18 @@ extern int pcibios_map_io_space(struct pci_bus *bus);
 #define PHB_SET_NODE(PHB, NODE)		((PHB)->node = -1)
 #endif
 
-#endif /* CONFIG_PPC64 */
+#endif	/* CONFIG_PPC64 */
 
 /* Get the PCI host controller for an OF device */
-extern struct pci_controller*
-pci_find_hose_for_OF_device(struct device_node* node);
+extern struct pci_controller *pci_find_hose_for_OF_device(
+			struct device_node* node);
 
 /* Fill up host controller resources from the OF node */
-extern void
-pci_process_bridge_OF_ranges(struct pci_controller *hose,
-			   struct device_node *dev, int primary);
+extern void pci_process_bridge_OF_ranges(struct pci_controller *hose,
+			struct device_node *dev, int primary);
 
 /* Allocate a new PCI host bridge structure */
-extern struct pci_controller *
-pcibios_alloc_controller(struct device_node *dev);
+extern struct pci_controller *pcibios_alloc_controller(struct device_node *dev);
 #ifdef CONFIG_PCI
 extern unsigned long pci_address_to_pio(phys_addr_t address);
 extern int pcibios_vaddr_is_ioport(void __iomem *address);
@@ -297,9 +288,7 @@ static inline int pcibios_vaddr_is_ioport(void __iomem *address)
 {
 	return 0;
 }
-#endif
+#endif	/* CONFIG_PCI */
 
-
-
-#endif /* __KERNEL__ */
-#endif
+#endif	/* __KERNEL__ */
+#endif	/* _ASM_POWERPC_PCI_BRIDGE_H */
-- 
1.5.3.5

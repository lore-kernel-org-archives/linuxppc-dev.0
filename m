Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 72490DDE1B
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 07:07:40 +1000 (EST)
Date: Thu, 30 Apr 2009 16:07:33 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [RFC][PATCH] add support to ppc32 to "use" pci_dn
Message-ID: <Pine.LNX.4.64.0904301604540.25174@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben,

This is my cut at unifying a bit of the ppc32 & ppc64 code.  I don't
specifically intend to use all the OF bits on ppc32, but getting some of
the structures the same so the non-OF related foo can be common is my
goal.

This was all about trying to get pci_bus_to_hose() to be common.

- k

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 84007af..6b523b9 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -149,13 +149,52 @@ struct pci_controller {
 #endif	/* CONFIG_PPC64 */
 };

-#ifndef CONFIG_PPC64
+/*
+ * PCI stuff, for nodes representing PCI devices, pointed to
+ * by device_node->data.
+ */
+struct iommu_table;
+
+struct pci_dn {
+	int	busno;			/* pci bus number */
+	int	devfn;			/* pci device and function number */
+
+	struct  pci_controller *phb;	/* for pci devices */
+	struct	iommu_table *iommu_table;	/* for phb's or bridges */
+	struct	device_node *node;	/* back-pointer to the device_node */
+
+	int	pci_ext_config_space;	/* for pci devices */
+
+#ifdef CONFIG_EEH
+	struct	pci_dev *pcidev;	/* back-pointer to the pci device */
+	int	class_code;		/* pci device class */
+	int	eeh_mode;		/* See eeh.h for possible EEH_MODEs */
+	int	eeh_config_addr;
+	int	eeh_pe_config_addr; /* new-style partition endpoint address */
+	int	eeh_check_count;	/* # times driver ignored error */
+	int	eeh_freeze_count;	/* # times this device froze up. */
+	int	eeh_false_positives;	/* # times this device reported #ff's */
+	u32	config_space[16];	/* saved PCI config space */
+#endif
+};
+
+/* Get the pointer to a device_node's pci_dn */
+#define PCI_DN(dn)	((struct pci_dn *) (dn)->data)
+
+extern struct device_node *fetch_dev_dn(struct pci_dev *dev);

 static inline struct pci_controller *pci_bus_to_host(const struct pci_bus *bus)
 {
-	return bus->sysdata;
+	struct device_node *busdn = bus->sysdata;
+
+	BUG_ON(busdn == NULL);
+	return PCI_DN(busdn)->phb;
 }

+
+
+#ifndef CONFIG_PPC64
+
 static inline int isa_vaddr_is_ioport(void __iomem *address)
 {
 	/* No specific ISA handling on ppc32 at this stage, it
@@ -188,40 +227,6 @@ extern void setup_indirect_pci(struct pci_controller* hose,
 extern void setup_grackle(struct pci_controller *hose);
 #else	/* CONFIG_PPC64 */

-/*
- * PCI stuff, for nodes representing PCI devices, pointed to
- * by device_node->data.
- */
-struct iommu_table;
-
-struct pci_dn {
-	int	busno;			/* pci bus number */
-	int	devfn;			/* pci device and function number */
-
-	struct  pci_controller *phb;	/* for pci devices */
-	struct	iommu_table *iommu_table;	/* for phb's or bridges */
-	struct	device_node *node;	/* back-pointer to the device_node */
-
-	int	pci_ext_config_space;	/* for pci devices */
-
-#ifdef CONFIG_EEH
-	struct	pci_dev *pcidev;	/* back-pointer to the pci device */
-	int	class_code;		/* pci device class */
-	int	eeh_mode;		/* See eeh.h for possible EEH_MODEs */
-	int	eeh_config_addr;
-	int	eeh_pe_config_addr; /* new-style partition endpoint address */
-	int	eeh_check_count;	/* # times driver ignored error */
-	int	eeh_freeze_count;	/* # times this device froze up. */
-	int	eeh_false_positives;	/* # times this device reported #ff's */
-	u32	config_space[16];	/* saved PCI config space */
-#endif
-};
-
-/* Get the pointer to a device_node's pci_dn */
-#define PCI_DN(dn)	((struct pci_dn *) (dn)->data)
-
-extern struct device_node *fetch_dev_dn(struct pci_dev *dev);
-
 /* Get a device_node from a pci_dev.  This code must be fast except
  * in the case where the sysdata is incorrect and needs to be fixed
  * up (this will only happen once).
@@ -266,15 +271,6 @@ extern void pcibios_remove_pci_devices(struct pci_bus *bus);
 /** Discover new pci devices under this bus, and add them */
 extern void pcibios_add_pci_devices(struct pci_bus *bus);

-static inline struct pci_controller *pci_bus_to_host(const struct pci_bus *bus)
-{
-	struct device_node *busdn = bus->sysdata;
-
-	BUG_ON(busdn == NULL);
-	return PCI_DN(busdn)->phb;
-}
-
-
 extern void isa_bridge_find_early(struct pci_controller *hose);

 static inline int isa_vaddr_is_ioport(void __iomem *address)
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 71901fb..eaddfd3 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -83,9 +83,9 @@ obj-$(CONFIG_KPROBES)		+= kprobes.o
 obj-$(CONFIG_PPC_UDBG_16550)	+= legacy_serial.o udbg_16550.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o

-pci64-$(CONFIG_PPC64)		+= pci_dn.o isa-bridge.o
+pci64-$(CONFIG_PPC64)		+= isa-bridge.o
 obj-$(CONFIG_PCI)		+= pci_$(CONFIG_WORD_SIZE).o $(pci64-y) \
-				   pci-common.o
+				   pci-common.o pci_dn.o
 obj-$(CONFIG_PCI_MSI)		+= msi.o
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o crash.o \
 				   machine_kexec_$(CONFIG_WORD_SIZE).o
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 9c69e7e..3f2e6fa 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -91,6 +91,7 @@ struct pci_controller *pcibios_alloc_controller(struct device_node *dev)
 	spin_unlock(&hose_spinlock);
 	phb->dn = dev;
 	phb->is_dynamic = mem_init_done;
+	pci_devs_phb_init_dynamic(phb);
 #ifdef CONFIG_PPC64
 	if (dev) {
 		int nid = of_node_to_nid(dev);
diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index d473634..09eb7b6 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -385,7 +385,7 @@ static void __devinit pcibios_scan_phb(struct pci_controller *hose)
 		 node ? node->full_name : "<NO NAME>");

 	/* Create an empty bus for the toplevel */
-	bus = pci_create_bus(hose->parent, hose->first_busno, hose->ops, hose);
+	bus = pci_create_bus(hose->parent, hose->first_busno, hose->ops, node);
 	if (bus == NULL) {
 		printk(KERN_ERR "Failed to create bus for PCI domain %04x\n",
 		       hose->global_number);
@@ -543,7 +543,7 @@ fake_pci_bus(struct pci_controller *hose, int busnr)
 			printk(KERN_ERR "Can't find hose for PCI bus %d!\n", busnr);
 	}
 	bus.number = busnr;
-	bus.sysdata = hose;
+	bus.sysdata = hose->dn;
 	bus.ops = hose? hose->ops: &null_pci_ops;
 	return &bus;
 }
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index d5e36e5..224406e 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -131,11 +131,13 @@ void __devinit pci_devs_phb_init_dynamic(struct pci_controller *phb)
 	struct pci_dn *pdn;

 	/* PHB nodes themselves must not match */
-	update_dn_pci_info(dn, phb);
-	pdn = dn->data;
-	if (pdn) {
-		pdn->devfn = pdn->busno = -1;
-		pdn->phb = phb;
+	if (!dn->data) {
+		update_dn_pci_info(dn, phb);
+		pdn = dn->data;
+		if (pdn) {
+			pdn->devfn = pdn->busno = -1;
+			pdn->phb = phb;
+		}
 	}

 	/* Update dn->phb ptrs for new phb and children devices */

Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 06 Dec 2007 19:11:35 +1100
Subject: [RFC/PATCH 6/10] powerpc: pci32: Add platform option to enable /proc
	PCI domains
In-Reply-To: <1196928690.864849.322811660859.qpush@grosgo>
Message-Id: <20071206081246.C94C3DE502@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds flags the platforms can use to enable domain numbers
in /proc/bus/pci.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/pci-common.c |   20 ++++++++++++++++++++
 arch/powerpc/kernel/pci_64.c     |   12 ------------
 include/asm-powerpc/pci-bridge.h |    5 +++++
 include/asm-powerpc/pci.h        |   14 ++++----------
 4 files changed, 29 insertions(+), 22 deletions(-)

Index: linux-work/arch/powerpc/kernel/pci-common.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/pci-common.c	2007-12-05 13:33:21.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci-common.c	2007-12-05 13:34:51.000000000 +1100
@@ -656,3 +656,23 @@ void __devinit pci_process_bridge_OF_ran
 		hose->mem_resources[memno-1] = tmp;
 	}
 }
+
+/* Decide whether to display the domain number in /proc */
+int pci_proc_domain(struct pci_bus *bus)
+{
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		return 0;
+	else {
+		struct pci_controller *hose = pci_bus_to_host(bus);
+#ifdef CONFIG_PPC64
+		return hose->buid != 0;
+#else
+		if (!(ppc_pci_flags & PPC_PCI_ENABLE_PROC_DOMAINS))
+			return 0;
+		if (ppc_pci_flags & PPC_PCI_COMPAT_DOMAIN_0)
+			return hose->global_number != 0;
+		return 1;
+#endif
+	}
+}
+
Index: linux-work/arch/powerpc/kernel/pci_64.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/pci_64.c	2007-12-05 13:33:21.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci_64.c	2007-12-05 13:33:34.000000000 +1100
@@ -580,18 +580,6 @@ int pcibios_enable_device(struct pci_dev
 	return 0;
 }
 
-/* Decide whether to display the domain number in /proc */
-int pci_proc_domain(struct pci_bus *bus)
-{
-	if (firmware_has_feature(FW_FEATURE_ISERIES))
-		return 0;
-	else {
-		struct pci_controller *hose = pci_bus_to_host(bus);
-		return hose->buid != 0;
-	}
-}
-
-
 #ifdef CONFIG_HOTPLUG
 
 int pcibios_unmap_io_space(struct pci_bus *bus)
Index: linux-work/include/asm-powerpc/pci-bridge.h
===================================================================
--- linux-work.orig/include/asm-powerpc/pci-bridge.h	2007-12-05 13:33:21.000000000 +1100
+++ linux-work/include/asm-powerpc/pci-bridge.h	2007-12-05 13:33:34.000000000 +1100
@@ -28,6 +28,11 @@ enum {
 	 * ISA forwarding enabled
 	 */
 	PPC_PCI_CAN_SKIP_ISA_ALIGN	= 0x00000008,
+
+	/* Enable domain numbers in /proc */
+	PPC_PCI_ENABLE_PROC_DOMAINS	= 0x00000010,
+	/* ... except for domain 0 */
+	PPC_PCI_COMPAT_DOMAIN_0		= 0x00000020,
 };
 
 
Index: linux-work/include/asm-powerpc/pci.h
===================================================================
--- linux-work.orig/include/asm-powerpc/pci.h	2007-12-05 13:33:21.000000000 +1100
+++ linux-work/include/asm-powerpc/pci.h	2007-12-05 13:33:34.000000000 +1100
@@ -98,9 +98,6 @@ static inline void pci_dma_burst_advice(
 #define get_pci_dma_ops()	NULL
 #endif
 
-/* Decide whether to display the domain number in /proc */
-extern int pci_proc_domain(struct pci_bus *bus);
-
 #else /* 32-bit */
 
 #ifdef CONFIG_PCI
@@ -112,17 +109,14 @@ static inline void pci_dma_burst_advice(
 	*strategy_parameter = ~0UL;
 }
 #endif
-
-/* Set the name of the bus as it appears in /proc/bus/pci */
-static inline int pci_proc_domain(struct pci_bus *bus)
-{
-	return 0;
-}
-
 #endif /* CONFIG_PPC64 */
 
 extern int pci_domain_nr(struct pci_bus *bus);
 
+/* Decide whether to display the domain number in /proc */
+extern int pci_proc_domain(struct pci_bus *bus);
+
+
 struct vm_area_struct;
 /* Map a range of PCI memory or I/O space for a device into user space */
 int pci_mmap_page_range(struct pci_dev *pdev, struct vm_area_struct *vma,

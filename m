Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 12 Dec 2007 16:22:58 +1100
Subject: [PATCH 6/13] [POWERPC] pci32: Add platform option to enable /proc PCI
	domains
In-Reply-To: <1197436973.110379.888292904645.qpush@grosgo>
Message-Id: <20071212052302.D964EDDF77@ozlabs.org>
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

 arch/powerpc/kernel/pci-common.c |   16 ++++++++++++++++
 arch/powerpc/kernel/pci_64.c     |    8 --------
 include/asm-powerpc/pci-bridge.h |    5 +++++
 include/asm-powerpc/pci.h        |   15 ++++-----------
 4 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 2a980d5..b2a5395 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -639,3 +639,19 @@ void __devinit pci_process_bridge_OF_ranges(struct pci_controller *hose,
 		hose->mem_resources[memno-1] = tmp;
 	}
 }
+
+/* Decide whether to display the domain number in /proc */
+int pci_proc_domain(struct pci_bus *bus)
+{
+	struct pci_controller *hose = pci_bus_to_host(bus);
+#ifdef CONFIG_PPC64
+	return hose->buid != 0;
+#else
+	if (!(ppc_pci_flags & PPC_PCI_ENABLE_PROC_DOMAINS))
+		return 0;
+	if (ppc_pci_flags & PPC_PCI_COMPAT_DOMAIN_0)
+		return hose->global_number != 0;
+	return 1;
+#endif
+}
+
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 115becf..1b7c810 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -570,14 +570,6 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 	return 0;
 }
 
-/* Decide whether to display the domain number in /proc */
-int pci_proc_domain(struct pci_bus *bus)
-{
-	struct pci_controller *hose = pci_bus_to_host(bus);
-	return hose->buid != 0;
-}
-
-
 #ifdef CONFIG_HOTPLUG
 
 int pcibios_unmap_io_space(struct pci_bus *bus)
diff --git a/include/asm-powerpc/pci-bridge.h b/include/asm-powerpc/pci-bridge.h
index 2972f0d..fed8f52 100644
--- a/include/asm-powerpc/pci-bridge.h
+++ b/include/asm-powerpc/pci-bridge.h
@@ -30,6 +30,11 @@ enum {
 	 * ISA forwarding enabled
 	 */
 	PPC_PCI_CAN_SKIP_ISA_ALIGN	= 0x00000008,
+
+	/* Enable domain numbers in /proc */
+	PPC_PCI_ENABLE_PROC_DOMAINS	= 0x00000010,
+	/* ... except for domain 0 */
+	PPC_PCI_COMPAT_DOMAIN_0		= 0x00000020,
 };
 
 
diff --git a/include/asm-powerpc/pci.h b/include/asm-powerpc/pci.h
index 47cc117..2883f56 100644
--- a/include/asm-powerpc/pci.h
+++ b/include/asm-powerpc/pci.h
@@ -98,9 +98,6 @@ static inline void pci_dma_burst_advice(struct pci_dev *pdev,
 #define get_pci_dma_ops()	NULL
 #endif
 
-/* Decide whether to display the domain number in /proc */
-extern int pci_proc_domain(struct pci_bus *bus);
-
 #else /* 32-bit */
 
 #ifdef CONFIG_PCI
@@ -112,17 +109,14 @@ static inline void pci_dma_burst_advice(struct pci_dev *pdev,
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
-- 
1.5.3.7

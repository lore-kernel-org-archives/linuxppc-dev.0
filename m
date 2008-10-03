Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 03 Oct 2008 10:12:51 +1000
Subject: [PATCH] powerpc: Fix domain numbers in /proc on 64-bit
Message-Id: <20081003001308.69A11DDF39@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The code to properly expose domain numbers in /proc is somewhat
bogus on ppc64 as it depends on the "buid" field being non-0,
but that field is really pseries specific.

This removes that code and makes ppc64 use the same code as 32-bit
which effectively decides whether to expose domains based on
ppc_pci_flags set by the platform, and sets the default for 64-bit
to enable domains and enable compatibility for domain 0 (which
strips the domain number for domain 0 to help with X servers).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/pci-common.c |   10 ++++------
 arch/powerpc/kernel/pci_64.c     |    5 +++++
 2 files changed, 9 insertions(+), 6 deletions(-)

--- linux-work.orig/arch/powerpc/kernel/pci-common.c	2008-09-09 16:31:13.000000000 +1000
+++ linux-work/arch/powerpc/kernel/pci-common.c	2008-09-09 16:31:15.000000000 +1000
@@ -53,8 +53,9 @@ static int global_phb_number;		/* Global
 /* ISA Memory physical address */
 resource_size_t isa_mem_base;
 
-/* Default PCI flags is 0 */
-unsigned int ppc_pci_flags;
+/* Default PCI flags is 0 on ppc32, modified at boot on ppc64 */
+unsigned int ppc_pci_flags = 0;
+
 
 struct pci_controller *pcibios_alloc_controller(struct device_node *dev)
 {
@@ -669,15 +670,12 @@ void __devinit pci_process_bridge_OF_ran
 int pci_proc_domain(struct pci_bus *bus)
 {
 	struct pci_controller *hose = pci_bus_to_host(bus);
-#ifdef CONFIG_PPC64
-	return hose->buid != 0;
-#else
+
 	if (!(ppc_pci_flags & PPC_PCI_ENABLE_PROC_DOMAINS))
 		return 0;
 	if (ppc_pci_flags & PPC_PCI_COMPAT_DOMAIN_0)
 		return hose->global_number != 0;
 	return 1;
-#endif
 }
 
 void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
Index: linux-work/arch/powerpc/kernel/pci_64.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/pci_64.c	2008-09-09 16:31:39.000000000 +1000
+++ linux-work/arch/powerpc/kernel/pci_64.c	2008-09-09 16:31:45.000000000 +1000
@@ -417,6 +417,11 @@ static int __init pcibios_init(void)
 	if (pci_probe_only)
 		ppc_pci_flags |= PPC_PCI_PROBE_ONLY;
 
+	/* On ppc64, we always enable PCI domains and we keep domain 0
+	 * backward compatible in /proc for video cards
+	 */
+	ppc_pci_flags |= PPC_PCI_ENABLE_PROC_DOMAINS | PPC_PCI_COMPAT_DOMAIN_0;
+
 	/* Scan all of the recorded PCI controllers.  */
 	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
 		scan_phb(hose);

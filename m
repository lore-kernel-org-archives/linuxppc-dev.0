Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9AB0BDDF1F
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2007 04:19:31 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 6/8] [POWERPC] Move pci_bus_to_hose users to pci_bus_to_host
Date: Wed, 27 Jun 2007 13:19:16 -0500
Message-Id: <11829683713322-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <11829683691025-git-send-email-galak@kernel.crashing.org>
References: <11829683583721-git-send-email-galak@kernel.crashing.org>
	<11829683604166-git-send-email-galak@kernel.crashing.org>
	<11829683612573-git-send-email-galak@kernel.crashing.org>
	<11829683631074-git-send-email-galak@kernel.crashing.org>
	<11829683663762-git-send-email-galak@kernel.crashing.org>
	<11829683691025-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In the places we can move to using pci_bus_to_host, this allows us
to make pci_bus_to_host static and remove its export.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/pci_32.c      |    8 ++++----
 arch/powerpc/kernel/ppc_ksyms.c   |    1 -
 arch/powerpc/platforms/86xx/pci.c |    2 +-
 include/asm-powerpc/pci-bridge.h  |    3 ---
 4 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index df3251c..c81ffa2 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -766,7 +766,7 @@ static struct device_node *scan_OF_for_pci_bus(struct pci_bus *bus)
 
 	/* Are we a root bus ? */
 	if (bus->self == NULL || bus->parent == NULL) {
-		struct pci_controller *hose = pci_bus_to_hose(bus->number);
+		struct pci_controller *hose = pci_bus_to_host(bus);
 		if (hose == NULL)
 			return NULL;
 		return of_node_get(hose->arch_data);
@@ -1492,7 +1492,7 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 	return 0;
 }
 
-struct pci_controller*
+static struct pci_controller*
 pci_bus_to_hose(int bus)
 {
 	struct pci_controller* hose = hose_head;
@@ -1507,7 +1507,7 @@ static struct resource *__pci_mmap_make_offset(struct pci_dev *dev,
 					       resource_size_t *offset,
 					       enum pci_mmap_state mmap_state)
 {
-	struct pci_controller *hose = pci_bus_to_hose(dev->bus->number);
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
 	unsigned long io_offset = 0;
 	int i, res_bit;
 
@@ -1719,7 +1719,7 @@ void pci_resource_to_user(const struct pci_dev *dev, int bar,
 			  const struct resource *rsrc,
 			  resource_size_t *start, resource_size_t *end)
 {
-	struct pci_controller *hose = pci_bus_to_hose(dev->bus->number);
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
 	resource_size_t offset = 0;
 
 	if (hose == NULL)
diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index c58f2de..e973c32 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -106,7 +106,6 @@ EXPORT_SYMBOL(isa_mem_base);
 EXPORT_SYMBOL(pci_dram_offset);
 EXPORT_SYMBOL(pci_alloc_consistent);
 EXPORT_SYMBOL(pci_free_consistent);
-EXPORT_SYMBOL(pci_bus_to_hose);
 #endif /* CONFIG_PCI */
 
 EXPORT_SYMBOL(start_thread);
diff --git a/arch/powerpc/platforms/86xx/pci.c b/arch/powerpc/platforms/86xx/pci.c
index 5cb2188..73cd5b0 100644
--- a/arch/powerpc/platforms/86xx/pci.c
+++ b/arch/powerpc/platforms/86xx/pci.c
@@ -145,7 +145,7 @@ static void __devinit quirk_fsl_pcie_transparent(struct pci_dev *dev)
 	 */
 	dev->transparent = 1;
 
-	hose = pci_bus_to_hose(dev->bus->number);
+	hose = pci_bus_to_host(dev->bus);
 	if (!hose) {
 		printk(KERN_ERR "Can't find hose for bus %d\n",
 		       dev->bus->number);
diff --git a/include/asm-powerpc/pci-bridge.h b/include/asm-powerpc/pci-bridge.h
index d5a9c9f..69ea865 100644
--- a/include/asm-powerpc/pci-bridge.h
+++ b/include/asm-powerpc/pci-bridge.h
@@ -9,9 +9,6 @@
 struct device_node;
 struct pci_controller;
 
-/* Get the PCI host controller for a bus */
-extern struct pci_controller* pci_bus_to_hose(int bus);
-
 /*
  * Structure of a PCI controller (host bridge)
  */
-- 
1.5.2.1

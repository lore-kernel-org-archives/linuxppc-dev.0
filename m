Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6E679DDF7B
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 16:33:16 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/8] [POWREPC] Fixup a number of modpost warnings on ppc32
Date: Thu, 26 Jul 2007 01:32:35 -0500
Message-Id: <11854315652243-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fixed the following warnings:

WARNING: vmlinux.o(.text+0x2934): Section mismatch: reference to .init.text:__alloc_bootmem (between 'irq_alloc_host' and 'irq_set_default_host')
WARNING: vmlinux.o(.text+0xb2aa): Section mismatch: reference to .init.data:boot_command_line (between 'register_early_udbg_console' and 'udbg_printf')
WARNING: vmlinux.o(.text+0xb2b2): Section mismatch: reference to .init.data:boot_command_line (between 'register_early_udbg_console' and 'udbg_printf')
WARNING: vmlinux.o(.text+0xe354): Section mismatch: reference to .init.text:__alloc_bootmem (between 'pcibios_alloc_controller' and 'pci_domain_nr')
WARNING: vmlinux.o(.text+0x12768): Section mismatch: reference to .init.text:update_bridge_resource (between 'quirk_fsl_pcie_transparent' and 'indirect_read_config')
WARNING: vmlinux.o(.text+0x127a8): Section mismatch: reference to .init.text:update_bridge_resource (between 'quirk_fsl_pcie_transparent' and 'indirect_read_config')
WARNING: vmlinux.o(.text+0x17566c): Section mismatch: reference to .init.text:pcibios_fixup_bus (between 'pci_scan_child_bus' and 'pci_scan_bus_parented')

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/irq.c        |    8 ++++----
 arch/powerpc/kernel/pci-common.c |    2 +-
 arch/powerpc/kernel/pci_32.c     |    2 +-
 arch/powerpc/kernel/udbg.c       |    2 +-
 arch/powerpc/sysdev/fsl_pci.c    |    2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 2fc8786..24bea97 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -418,10 +418,10 @@ irq_hw_number_t virq_to_hw(unsigned int virq)
 }
 EXPORT_SYMBOL_GPL(virq_to_hw);
 
-struct irq_host *irq_alloc_host(unsigned int revmap_type,
-				unsigned int revmap_arg,
-				struct irq_host_ops *ops,
-				irq_hw_number_t inval_irq)
+__init_refok struct irq_host *irq_alloc_host(unsigned int revmap_type,
+						unsigned int revmap_arg,
+						struct irq_host_ops *ops,
+						irq_hw_number_t inval_irq)
 {
 	struct irq_host *host;
 	unsigned int size = sizeof(struct irq_host);
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index fe7d125..7b41a99 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -65,7 +65,7 @@ static void __devinit pci_setup_pci_controller(struct pci_controller *hose)
 	spin_unlock(&hose_spinlock);
 }
 
-struct pci_controller * pcibios_alloc_controller(struct device_node *dev)
+__init_refok struct pci_controller * pcibios_alloc_controller(struct device_node *dev)
 {
 	struct pci_controller *phb;
 
diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index 395086f..cd35c96 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -1247,7 +1247,7 @@ pcibios_init(void)
 
 subsys_initcall(pcibios_init);
 
-void __init pcibios_fixup_bus(struct pci_bus *bus)
+void pcibios_fixup_bus(struct pci_bus *bus)
 {
 	struct pci_controller *hose = (struct pci_controller *) bus->sysdata;
 	unsigned long io_offset;
diff --git a/arch/powerpc/kernel/udbg.c b/arch/powerpc/kernel/udbg.c
index cbca1df..0f9b4ea 100644
--- a/arch/powerpc/kernel/udbg.c
+++ b/arch/powerpc/kernel/udbg.c
@@ -155,7 +155,7 @@ static int early_console_initialized;
  * Called by setup_system after ppc_md->probe and ppc_md->early_init.
  * Call it again after setting udbg_putc in ppc_md->setup_arch.
  */
-void register_early_udbg_console(void)
+void __init register_early_udbg_console(void)
 {
 	if (early_console_initialized)
 		return;
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 8712227..9fb0ce5 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -107,7 +107,7 @@ void __init setup_pci_cmd(struct pci_controller *hose)
 	}
 }
 
-static void __devinit quirk_fsl_pcie_transparent(struct pci_dev *dev)
+static void __init quirk_fsl_pcie_transparent(struct pci_dev *dev)
 {
 	struct resource *res;
 	int i, res_idx = PCI_BRIDGE_RESOURCES;
-- 
1.5.2.2

Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F0F2ADE022
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2007 04:19:35 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 8/8] [POWERPC] Use ppc64 style list management for
	pci_controller on ppc32
Date: Wed, 27 Jun 2007 13:19:18 -0500
Message-Id: <11829683753486-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <11829683733835-git-send-email-galak@kernel.crashing.org>
References: <11829683583721-git-send-email-galak@kernel.crashing.org>
	<11829683604166-git-send-email-galak@kernel.crashing.org>
	<11829683612573-git-send-email-galak@kernel.crashing.org>
	<11829683631074-git-send-email-galak@kernel.crashing.org>
	<11829683663762-git-send-email-galak@kernel.crashing.org>
	<11829683691025-git-send-email-galak@kernel.crashing.org>
	<11829683713322-git-send-email-galak@kernel.crashing.org>
	<11829683733835-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Use the ppc64 style list management and allocation functions for
pci_controllers.  This makes the pci_controller structs just a bit more
common between ppc32 & ppc64.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/pci-common.c |   78 ++++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/pci_32.c     |   61 +++++-------------------------
 arch/powerpc/kernel/pci_64.c     |   66 --------------------------------
 include/asm-powerpc/pci-bridge.h |   11 +++--
 4 files changed, 94 insertions(+), 122 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index b518b88..295cbb1 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -36,6 +36,62 @@
 #define DBG(fmt...)
 #endif
 
+static DEFINE_SPINLOCK(hose_spinlock);
+
+/* XXX kill that some day ... */
+int global_phb_number;		/* Global phb counter */
+
+extern struct list_head hose_list;
+
+/*
+ * pci_controller(phb) initialized common variables.
+ */
+static void __devinit pci_setup_pci_controller(struct pci_controller *hose)
+{
+	memset(hose, 0, sizeof(struct pci_controller));
+
+	spin_lock(&hose_spinlock);
+	hose->global_number = global_phb_number++;
+	list_add_tail(&hose->list_node, &hose_list);
+	spin_unlock(&hose_spinlock);
+}
+
+struct pci_controller * pcibios_alloc_controller(struct device_node *dev)
+{
+	struct pci_controller *phb;
+
+	if (mem_init_done)
+		phb = kmalloc(sizeof(struct pci_controller), GFP_KERNEL);
+	else
+		phb = alloc_bootmem(sizeof (struct pci_controller));
+	if (phb == NULL)
+		return NULL;
+	pci_setup_pci_controller(phb);
+	phb->arch_data = dev;
+	phb->is_dynamic = mem_init_done;
+#ifdef CONFIG_PPC64
+	if (dev) {
+		int nid = of_node_to_nid(dev);
+
+		if (nid < 0 || !node_online(nid))
+			nid = -1;
+
+		PHB_SET_NODE(phb, nid);
+	}
+#endif
+	return phb;
+}
+
+void pcibios_free_controller(struct pci_controller *phb)
+{
+	spin_lock(&hose_spinlock);
+	list_del(&phb->list_node);
+	spin_unlock(&hose_spinlock);
+
+	if (phb->is_dynamic)
+		kfree(phb);
+}
+
 /*
  * Return the domain number for this bus.
  */
@@ -53,6 +109,28 @@ int pci_domain_nr(struct pci_bus *bus)
 EXPORT_SYMBOL(pci_domain_nr);
 
 #ifdef CONFIG_PPC_OF
+
+/* This routine is meant to be used early during boot, when the
+ * PCI bus numbers have not yet been assigned, and you need to
+ * issue PCI config cycles to an OF device.
+ * It could also be used to "fix" RTAS config cycles if you want
+ * to set pci_assign_all_buses to 1 and still use RTAS for PCI
+ * config cycles.
+ */
+struct pci_controller* pci_find_hose_for_OF_device(struct device_node* node)
+{
+	if (!have_of)
+		return NULL;
+	while(node) {
+		struct pci_controller *hose, *tmp;
+		list_for_each_entry_safe(hose, tmp, &hose_list, list_node)
+			if (hose->arch_data == node)
+				return hose;
+		node = node->parent;
+	}
+	return NULL;
+}
+
 static ssize_t pci_show_devspec(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index 3dd931e..10d8a35 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -55,8 +55,7 @@ static u8* pci_to_OF_bus_map;
  */
 int pci_assign_all_buses;
 
-struct pci_controller* hose_head;
-struct pci_controller** hose_tail = &hose_head;
+LIST_HEAD(hose_list);
 
 static int pci_bus_count;
 
@@ -607,25 +606,6 @@ pcibios_enable_resources(struct pci_dev *dev, int mask)
 	return 0;
 }
 
-static int next_controller_index;
-
-struct pci_controller * __init
-pcibios_alloc_controller(struct device_node *dev)
-{
-	struct pci_controller *hose;
-
-	hose = (struct pci_controller *)alloc_bootmem(sizeof(*hose));
-	memset(hose, 0, sizeof(struct pci_controller));
-
-	*hose_tail = hose;
-	hose_tail = &hose->next;
-
-	hose->global_number = next_controller_index++;
-	hose->arch_data = dev;
-
-	return hose;
-}
-
 #ifdef CONFIG_PPC_OF
 /*
  * Functions below are used on OpenFirmware machines.
@@ -671,7 +651,7 @@ void
 pcibios_make_OF_bus_map(void)
 {
 	int i;
-	struct pci_controller* hose;
+	struct pci_controller *hose, *tmp;
 	struct property *map_prop;
 	struct device_node *dn;
 
@@ -688,7 +668,7 @@ pcibios_make_OF_bus_map(void)
 		pci_to_OF_bus_map[i] = 0xff;
 
 	/* For each hose, we begin searching bridges */
-	for(hose=hose_head; hose; hose=hose->next) {
+	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
 		struct device_node* node;	
 		node = (struct device_node *)hose->arch_data;
 		if (!node)
@@ -819,27 +799,6 @@ pci_device_to_OF_node(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pci_device_to_OF_node);
 
-/* This routine is meant to be used early during boot, when the
- * PCI bus numbers have not yet been assigned, and you need to
- * issue PCI config cycles to an OF device.
- * It could also be used to "fix" RTAS config cycles if you want
- * to set pci_assign_all_buses to 1 and still use RTAS for PCI
- * config cycles.
- */
-struct pci_controller* pci_find_hose_for_OF_device(struct device_node* node)
-{
-	if (!have_of)
-		return NULL;
-	while(node) {
-		struct pci_controller* hose;
-		for (hose=hose_head;hose;hose=hose->next)
-			if (hose->arch_data == node)
-				return hose;
-		node=node->parent;
-	}
-	return NULL;
-}
-
 static int
 find_OF_pci_device_filter(struct device_node* node, void* data)
 {
@@ -1248,14 +1207,14 @@ pcibios_fixup_p2p_bridges(void)
 static int __init
 pcibios_init(void)
 {
-	struct pci_controller *hose;
+	struct pci_controller *hose, *tmp;
 	struct pci_bus *bus;
-	int next_busno;
+	int next_busno = 0;
 
 	printk(KERN_INFO "PCI: Probing PCI hardware\n");
 
 	/* Scan all of the recorded PCI controllers.  */
-	for (next_busno = 0, hose = hose_head; hose; hose = hose->next) {
+	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
 		if (pci_assign_all_buses)
 			hose->first_busno = next_busno;
 		hose->last_busno = 0xff;
@@ -1410,9 +1369,9 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 static struct pci_controller*
 pci_bus_to_hose(int bus)
 {
-	struct pci_controller* hose = hose_head;
+	struct pci_controller *hose, *tmp;
 
-	for (; hose; hose = hose->next)
+	list_for_each_entry_safe(hose, tmp, &hose_list, list_node)
 		if (bus >= hose->first_busno && bus <= hose->last_busno)
 			return hose;
 	return NULL;
@@ -1462,9 +1421,9 @@ long sys_pciconfig_iobase(long which, unsigned long bus, unsigned long devfn)
 
 unsigned long pci_address_to_pio(phys_addr_t address)
 {
-	struct pci_controller* hose = hose_head;
+	struct pci_controller *hose, *tmp;
 
-	for (; hose; hose = hose->next) {
+	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
 		unsigned int size = hose->io_resource.end -
 			hose->io_resource.start + 1;
 		if (address >= hose->io_base_phys &&
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 7a9a4fc..e386e3e 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -59,9 +59,6 @@ LIST_HEAD(hose_list);
 
 static struct dma_mapping_ops *pci_dma_ops;
 
-/* XXX kill that some day ... */
-int global_phb_number;		/* Global phb counter */
-
 void set_pci_dma_ops(struct dma_mapping_ops *dma_ops)
 {
 	pci_dma_ops = dma_ops;
@@ -172,55 +169,6 @@ void pcibios_align_resource(void *data, struct resource *res,
 	res->start = start;
 }
 
-static DEFINE_SPINLOCK(hose_spinlock);
-
-/*
- * pci_controller(phb) initialized common variables.
- */
-static void __devinit pci_setup_pci_controller(struct pci_controller *hose)
-{
-	memset(hose, 0, sizeof(struct pci_controller));
-
-	spin_lock(&hose_spinlock);
-	hose->global_number = global_phb_number++;
-	list_add_tail(&hose->list_node, &hose_list);
-	spin_unlock(&hose_spinlock);
-}
-
-struct pci_controller * pcibios_alloc_controller(struct device_node *dev)
-{
-	struct pci_controller *phb;
-
-	if (mem_init_done)
-		phb = kmalloc(sizeof(struct pci_controller), GFP_KERNEL);
-	else
-		phb = alloc_bootmem(sizeof (struct pci_controller));
-	if (phb == NULL)
-		return NULL;
-	pci_setup_pci_controller(phb);
-	phb->arch_data = dev;
-	phb->is_dynamic = mem_init_done;
-	if (dev) {
-		int nid = of_node_to_nid(dev);
-
-		if (nid < 0 || !node_online(nid))
-			nid = -1;
-
-		PHB_SET_NODE(phb, nid);
-	}
-	return phb;
-}
-
-void pcibios_free_controller(struct pci_controller *phb)
-{
-	spin_lock(&hose_spinlock);
-	list_del(&phb->list_node);
-	spin_unlock(&hose_spinlock);
-
-	if (phb->is_dynamic)
-		kfree(phb);
-}
-
 void __devinit pcibios_claim_one_bus(struct pci_bus *b)
 {
 	struct pci_dev *dev;
@@ -957,20 +905,6 @@ void __devinit pcibios_fixup_bus(struct pci_bus *bus)
 }
 EXPORT_SYMBOL(pcibios_fixup_bus);
 
-struct pci_controller* pci_find_hose_for_OF_device(struct device_node* node)
-{
-	if (!have_of)
-		return NULL;
-	while(node) {
-		struct pci_controller *hose, *tmp;
-		list_for_each_entry_safe(hose, tmp, &hose_list, list_node)
-			if (hose->arch_data == node)
-				return hose;
-		node = node->parent;
-	}
-	return NULL;
-}
-
 unsigned long pci_address_to_pio(phys_addr_t address)
 {
 	struct pci_controller *hose, *tmp;
diff --git a/include/asm-powerpc/pci-bridge.h b/include/asm-powerpc/pci-bridge.h
index 69ea865..e72c2a6 100644
--- a/include/asm-powerpc/pci-bridge.h
+++ b/include/asm-powerpc/pci-bridge.h
@@ -2,9 +2,11 @@
 #define _ASM_POWERPC_PCI_BRIDGE_H
 #ifdef __KERNEL__
 
-#ifndef CONFIG_PPC64
-#include <linux/ioport.h>
 #include <linux/pci.h>
+#include <linux/list.h>
+#include <linux/ioport.h>
+
+#ifndef CONFIG_PPC64
 
 struct device_node;
 struct pci_controller;
@@ -14,8 +16,9 @@ struct pci_controller;
  */
 struct pci_controller {
 	struct pci_bus *bus;
+	char is_dynamic;
 	void *arch_data;
-	struct pci_controller *next;
+	struct list_head list_node;
 	struct device *parent;
 
 	int first_busno;
@@ -84,8 +87,6 @@ extern void setup_grackle(struct pci_controller *hose);
 
 #else
 
-#include <linux/pci.h>
-#include <linux/list.h>
 
 /*
  * This program is free software; you can redistribute it and/or
-- 
1.5.2.1

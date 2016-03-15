Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qPqhK51sNzDq6V
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Mar 2016 09:55:13 +1100 (AEDT)
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Tue, 15 Mar 2016 19:55:08 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 8AB01352005C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 18:54:52 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2FLtCiK29950284
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 18:55:12 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2FMt185032396
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 18:55:01 -0400
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
 paulus@samba.org, imunsie@au1.ibm.com, mikey@neuling.org,
 andrew.donnellan@au1.ibm.com, gwshan@linux.vnet.ibm.com,
 bhelgaas@google.com, gpiccoli@linux.vnet.ibm.com
Subject: [PATCH v2] powerpc/pci: Assign fixed PHB number based on device-tree
 properties
Date: Tue, 15 Mar 2016 19:54:41 -0300
Message-Id: <1458082481-29916-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The domain/PHB field of PCI addresses has its value obtained from a
global variable, incremented each time a new domain (represented by
struct pci_controller) is added on the system. The domain addition
process happens during boot or due to PCI device hotplug.

As recent kernels are using predictable naming for network interfaces,
the network stack is more tied to PCI naming. This can be a problem in
hotplug scenarios, because PCI addresses will change if devices are
removed and then re-added. This situation seems unusual, but it can
happen if a user wants to replace a NIC without rebooting the machine,
for example.

This patch changes the way PCI domain values are generated: now, we use
device-tree properties to assign fixed PHB numbers to PCI addresses
when available (meaning pSeries and PowerNV cases). We also use a bitmap
to allow dynamic PHB numbering when device-tree properties are not
used. This bitmap keeps track of used PHB numbers and if a PHB is
released (by hotplug operations for example), it allows the reuse of
this PHB number, avoiding PCI address to change in case of device remove
and re-add soon after. No functional changes were introduced.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/pci-common.c | 43 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 0f7a60f..d4217f9 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -44,8 +44,11 @@
 static DEFINE_SPINLOCK(hose_spinlock);
 LIST_HEAD(hose_list);
 
-/* XXX kill that some day ... */
-static int global_phb_number;		/* Global phb counter */
+/* For dynamic PHB numbering on get_phb_number(): max number of PHBs. */
+#define	MAX_PHBS	8192
+
+/* For dynamic PHB numbering: used/free PHBs tracking bitmap. */
+DECLARE_BITMAP(global_phb_bitmap, MAX_PHBS);
 
 /* ISA Memory physical address */
 resource_size_t isa_mem_base;
@@ -64,6 +67,39 @@ struct dma_map_ops *get_pci_dma_ops(void)
 }
 EXPORT_SYMBOL(get_pci_dma_ops);
 
+static int get_phb_number(struct device_node *dn)
+{
+	const __be64 *prop64;
+	const __be32 *regs;
+	int phb_id = 0;
+
+	/* try fixed PHB numbering first */
+	if (machine_is(pseries)) {
+		regs = of_get_property(dn, "reg", NULL);
+		if (regs)
+			return (int)(be32_to_cpu(regs[1]) & 0xFFFF);
+	}
+
+	else { /* maybe PowerNV? */
+		prop64 = of_get_property(dn, "ibm,opal-phbid", NULL);
+		if (prop64)
+			return (int)(be64_to_cpup(prop64) & 0xFFFF);
+	}
+
+	/* dynamic PHB numbering mechanism */
+	while ((phb_id < MAX_PHBS) && test_bit(phb_id, global_phb_bitmap))
+		phb_id++;
+
+	BUG_ON(phb_id >= MAX_PHBS); /* reached maximum number of PHBs */
+	set_bit(phb_id, global_phb_bitmap);
+	return phb_id;
+}
+
+static void release_phb_number(int phb_id)
+{
+	clear_bit(phb_id, global_phb_bitmap);
+}
+
 struct pci_controller *pcibios_alloc_controller(struct device_node *dev)
 {
 	struct pci_controller *phb;
@@ -72,7 +108,7 @@ struct pci_controller *pcibios_alloc_controller(struct device_node *dev)
 	if (phb == NULL)
 		return NULL;
 	spin_lock(&hose_spinlock);
-	phb->global_number = global_phb_number++;
+	phb->global_number = get_phb_number(dev);
 	list_add_tail(&phb->list_node, &hose_list);
 	spin_unlock(&hose_spinlock);
 	phb->dn = dev;
@@ -94,6 +130,7 @@ EXPORT_SYMBOL_GPL(pcibios_alloc_controller);
 void pcibios_free_controller(struct pci_controller *phb)
 {
 	spin_lock(&hose_spinlock);
+	release_phb_number(phb->global_number);
 	list_del(&phb->list_node);
 	spin_unlock(&hose_spinlock);
 
-- 
2.1.0

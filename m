Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r8cj740hfzDqBP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 May 2016 11:55:23 +1000 (AEST)
Received: from pps.filterd (m0048827.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u4I1iVkr005251
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 May 2016 21:48:27 -0400
Message-Id: <201605180148.u4I1iVkr005251@mx0a-001b2d01.pphosted.com>
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0a-001b2d01.pphosted.com with ESMTP id 230apcgrfs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 May 2016 21:48:26 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Tue, 17 May 2016 22:48:24 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 2FCAC3520068
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 May 2016 21:48:07 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4I1mL454993256
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 May 2016 22:48:21 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4I1mKQC023695
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 May 2016 22:48:21 -0300
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 benh@kernel.crashing.org, paulus@samba.org
Cc: linux-pci@vger.kernel.org, imunsie@au1.ibm.com, mikey@neuling.org,
 andrew.donnellan@au1.ibm.com, gwshan@linux.vnet.ibm.com,
 bhelgaas@google.com, gpiccoli@linux.vnet.ibm.com,
 frederic.barrat@fr.ibm.com, mrochs@linux.vnet.ibm.com
Subject: [PATCH v6] powerpc/pci: Assign fixed PHB number based on device-tree
 properties
Date: Tue, 17 May 2016 22:48:00 -0300
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
process happens during boot or due to PHB hotplug add.

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
Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Reviewed-by: Ian Munsie <imunsie@au1.ibm.com>
---
v6:
    * Dropped the of_get_property() use to use instead
of_property_read_u64()/of_property_read_u32_array as per Michael's
suggestion. Since these 2 functions deal with endianness conversion,
no need to manually convert endianness anymore. Logic was simplified.

    * Changed MAX_PHBS to 64K as per Gavin's suggestion. Changed 0xFFFF
to (MAX_PHBS - 1) then.

    * Changed test_bit() and set_bit() to test_and_set_bit() as per
Gavin's suggestion.

    * Removed some obvious comments.

    * Didn't remove machine check for pSeries on "reg" property lookup.
It's worthy to keep it, since almost every platform (if not all of them)
contain the "reg" property on PHB node in device-tree, but only in
pSeries we're 100% sure it can be used as the PHB unique identifier.
Since the patch has a dynamic PHB numbering mechanism, the other platforms
won't have trouble with it.

 arch/powerpc/kernel/pci-common.c | 59 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 0f7a60f..4afc9c1 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -41,11 +41,18 @@
 #include <asm/ppc-pci.h>
 #include <asm/eeh.h>
 
+/* hose_spinlock protects accesses to the the phb_bitmap. */
 static DEFINE_SPINLOCK(hose_spinlock);
 LIST_HEAD(hose_list);
 
-/* XXX kill that some day ... */
-static int global_phb_number;		/* Global phb counter */
+/* For dynamic PHB numbering on get_phb_number(): max number of PHBs. */
+#define MAX_PHBS 0x10000
+
+/*
+ * For dynamic PHB numbering: used/free PHBs tracking bitmap.
+ * Accesses to this bitmap should be protected by hose_spinlock.
+ */
+static DECLARE_BITMAP(phb_bitmap, MAX_PHBS);
 
 /* ISA Memory physical address */
 resource_size_t isa_mem_base;
@@ -64,6 +71,47 @@ struct dma_map_ops *get_pci_dma_ops(void)
 }
 EXPORT_SYMBOL(get_pci_dma_ops);
 
+/*
+ * This function should run under locking protection, specifically
+ * hose_spinlock.
+ */
+static int get_phb_number(struct device_node *dn)
+{
+	u64 prop;
+	int ret;
+	int phb_id;
+
+	/*
+	 * Try fixed PHB numbering first, by checking archs and reading
+	 * the respective device-tree properties. Firstly, try PowerNV by
+	 * reading "ibm,opal-phbid", only present in OPAL environment.
+	 */
+	ret = of_property_read_u64(dn, "ibm,opal-phbid", &prop);
+	if (ret && machine_is(pseries))
+		ret = of_property_read_u32_array(dn, "reg", (u32 *)&prop, 2);
+	if (ret)
+		goto dynamic_phb_numbering;
+
+	phb_id = (int)(prop & (MAX_PHBS - 1));
+
+	/* We need to be sure to not use the same PHB number twice. */
+	if (test_and_set_bit(phb_id, phb_bitmap))
+		goto dynamic_phb_numbering;
+
+	return phb_id;
+
+	/*
+	 * If not pSeries nor PowerNV, or if fixed PHB numbering tried to add
+	 * the same PHB number twice, then fallback to dynamic PHB numbering.
+	 */
+dynamic_phb_numbering:
+	phb_id = find_first_zero_bit(phb_bitmap, MAX_PHBS);
+	BUG_ON(phb_id >= MAX_PHBS);
+	set_bit(phb_id, phb_bitmap);
+
+	return phb_id;
+}
+
 struct pci_controller *pcibios_alloc_controller(struct device_node *dev)
 {
 	struct pci_controller *phb;
@@ -72,7 +120,7 @@ struct pci_controller *pcibios_alloc_controller(struct device_node *dev)
 	if (phb == NULL)
 		return NULL;
 	spin_lock(&hose_spinlock);
-	phb->global_number = global_phb_number++;
+	phb->global_number = get_phb_number(dev);
 	list_add_tail(&phb->list_node, &hose_list);
 	spin_unlock(&hose_spinlock);
 	phb->dn = dev;
@@ -94,6 +142,11 @@ EXPORT_SYMBOL_GPL(pcibios_alloc_controller);
 void pcibios_free_controller(struct pci_controller *phb)
 {
 	spin_lock(&hose_spinlock);
+
+	/* Clear bit of phb_bitmap to allow reuse of this PHB number. */
+	if (phb->global_number < MAX_PHBS)
+		clear_bit(phb->global_number, phb_bitmap);
+
 	list_del(&phb->list_node);
 	spin_unlock(&hose_spinlock);
 
-- 
2.1.0

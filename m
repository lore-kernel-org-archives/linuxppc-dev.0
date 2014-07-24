Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A1F561A0460
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 16:22:58 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 24 Jul 2014 11:52:56 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 4AAFB3940065
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 11:52:53 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6O6OhxK7799042
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 11:54:43 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6O6MqCc007917
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 11:52:52 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com,
 yan@linux.vnet.ibm.com, qiudayu@linux.vnet.ibm.com
Subject: [PATCH V7 12/17] powerpc/powernv: Expand VF resources according to
 the number of total_pe
Date: Thu, 24 Jul 2014 14:22:22 +0800
Message-Id: <1406182947-11302-13-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1406182947-11302-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1406182947-11302-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On PHB3, VF resources will be covered by M64 BAR to have better PE isolation.
Mostly the total_pe number is different from the total_VFs, which will lead to
a conflict between MMIO space and the PE number.

This patch expands the VF resource size to reserve total_pe number of VFs'
resource, which prevents the conflict.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/machdep.h        |    4 ++
 arch/powerpc/include/asm/pci-bridge.h     |    3 +
 arch/powerpc/kernel/pci-common.c          |    5 ++
 arch/powerpc/platforms/powernv/pci-ioda.c |   91 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/pci.h      |    3 +
 5 files changed, 106 insertions(+)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 3909d1b..fabb8016 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -252,6 +252,10 @@ struct machdep_calls {
 	/* Reset the secondary bus of bridge */
 	void  (*pcibios_reset_secondary_bus)(struct pci_dev *dev);
 
+#ifdef CONFIG_PCI_IOV
+	void (*pcibios_fixup_sriov)(struct pci_bus *bus);
+#endif /* CONFIG_PCI_IOV */
+
 	/* Called to shutdown machine specific hardware not already controlled
 	 * by other drivers.
 	 */
diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 757d7bb..3cb95af 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -173,6 +173,9 @@ struct pci_dn {
 #define IODA_INVALID_PE		(-1)
 #ifdef CONFIG_PPC_POWERNV
 	int	pe_number;
+#ifdef CONFIG_PCI_IOV
+	u16     vfs;			/* number of VFs IOV BAR expended */
+#endif /* CONFIG_PCI_IOV */
 #endif
 	struct list_head child_list;
 	struct list_head list;
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index d38a330..c2b7930 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1651,6 +1651,11 @@ void pcibios_scan_phb(struct pci_controller *hose)
 	if (ppc_md.pcibios_fixup_phb)
 		ppc_md.pcibios_fixup_phb(hose);
 
+#ifdef CONFIG_PCI_IOV
+	if (ppc_md.pcibios_fixup_sriov)
+		ppc_md.pcibios_fixup_sriov(bus);
+#endif /* CONFIG_PCI_IOV */
+
 	/* Configure PCI Express settings */
 	if (bus && !pci_has_flag(PCI_PROBE_ONLY)) {
 		struct pci_bus *child;
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 8318b07..6fd2377 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1505,6 +1505,60 @@ static void pnv_pci_init_ioda_msis(struct pnv_phb *phb)
 static void pnv_pci_init_ioda_msis(struct pnv_phb *phb) { }
 #endif /* CONFIG_PCI_MSI */
 
+#ifdef CONFIG_PCI_IOV
+static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
+{
+	struct pci_controller *hose;
+	struct pnv_phb *phb;
+	struct resource *res;
+	int i;
+	resource_size_t size;
+	struct pci_dn *pdn;
+
+	if (!pdev->is_physfn || pdev->is_added)
+		return;
+
+	hose = pci_bus_to_host(pdev->bus);
+	phb = hose->private_data;
+
+	pdn = pci_get_pdn(pdev);
+	pdn->vfs = 0;
+
+	for (i = PCI_IOV_RESOURCES; i <= PCI_IOV_RESOURCE_END; i++) {
+		res = &pdev->resource[i];
+		if (!res->flags || res->parent)
+			continue;
+		if (!pnv_pci_is_mem_pref_64(res->flags)) {
+			dev_warn(&pdev->dev, " non M64 IOV BAR %pR on %s\n",
+				 res, pci_name(pdev));
+			continue;
+		}
+
+		dev_dbg(&pdev->dev, "PowerNV: Fixing VF BAR[%d] %pR to\n",
+				i, res);
+		size = pnv_pci_sriov_resource_size(pdev, i);
+		res->end = res->start + size * phb->ioda.total_pe - 1;
+		dev_dbg(&pdev->dev, "                       %pR\n", res);
+	}
+	pdn->vfs = phb->ioda.total_pe;
+}
+
+static void pnv_pci_ioda_fixup_sriov(struct pci_bus *bus)
+{
+	struct pci_dev *pdev;
+	struct pci_bus *b;
+
+	list_for_each_entry(pdev, &bus->devices, bus_list) {
+		b = pdev->subordinate;
+
+		if (b)
+			pnv_pci_ioda_fixup_sriov(b);
+
+		pnv_pci_ioda_fixup_iov_resources(pdev);
+	}
+}
+#endif /* CONFIG_PCI_IOV */
+
 /*
  * This function is supposed to be called on basis of PE from top
  * to bottom style. So the the I/O or MMIO segment assigned to
@@ -1681,6 +1735,40 @@ static resource_size_t pnv_pci_window_alignment(struct pci_bus *bus,
 	return phb->ioda.io_segsize;
 }
 
+/*
+ * Allocate firmware data for VF, which doesn't have corresponding
+ * device node. So we have to extend device's archdata.
+ */
+#ifdef CONFIG_PCI_IOV
+static resource_size_t pnv_pcibios_sriov_resource_size(struct pci_dev *pdev, int resno)
+{
+	struct pci_dn *pdn = pci_get_pdn(pdev);
+	resource_size_t size = 0;
+
+	if (!pdn->vfs)
+		return size;
+
+	size = resource_size(pdev->resource + resno);
+	do_div(size, pdn->vfs);
+
+	return size;
+}
+
+resource_size_t pnv_pci_sriov_resource_size(struct pci_dev *pdev, int resno)
+{
+	resource_size_t size;
+
+	size = pnv_pcibios_sriov_resource_size(pdev, resno);
+	if (size != 0)
+		return size;
+
+	size = resource_size(pdev->resource + resno);
+	do_div(size, pci_sriov_get_totalvfs(pdev));
+
+	return size;
+}
+#endif /* CONFIG_PCI_IOV */
+
 /* Prevent enabling devices for which we couldn't properly
  * assign a PE
  */
@@ -1886,6 +1974,9 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	ppc_md.pcibios_enable_device_hook = pnv_pci_enable_device_hook;
 	ppc_md.pcibios_window_alignment = pnv_pci_window_alignment;
 	ppc_md.pcibios_reset_secondary_bus = pnv_pci_reset_secondary_bus;
+#ifdef CONFIG_PCI_IOV
+	ppc_md.pcibios_fixup_sriov = pnv_pci_ioda_fixup_sriov;
+#endif /* CONFIG_PCI_IOV */
 	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
 
 	/* Reset IODA tables to a clean state */
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 0d616f0..e55772f 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -229,5 +229,8 @@ extern void pnv_pci_ioda_tce_invalidate(struct iommu_table *tbl,
 					__be64 *startp, __be64 *endp, bool rm);
 extern void pnv_pci_reset_secondary_bus(struct pci_dev *dev);
 extern int ioda_eeh_phb_reset(struct pci_controller *hose, int option);
+#ifdef CONFIG_PCI_IOV
+resource_size_t pnv_pci_sriov_resource_size(struct pci_dev *pdev, int resno);
+#endif
 
 #endif /* __POWERNV_PCI_H */
-- 
1.7.9.5

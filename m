Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 655531A0257
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 11:57:16 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Tue, 10 Jun 2014 07:27:14 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 3DFA7394003E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 07:27:11 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5A1w2rr56754216
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 07:28:02 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5A1vA8i021384
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 07:27:10 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: benh@au1.ibm.com
Subject: [RFC PATCH V3 11/17] ppc/pnv: Expand VF resources according to the
 number of total_pe
Date: Tue, 10 Jun 2014 09:56:33 +0800
Message-Id: <1402365399-5121-12-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
 gwshan@linux.vnet.ibm.com, qiudayu@linux.vnet.ibm.com, bhelgaas@google.com,
 yan@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
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
 arch/powerpc/include/asm/machdep.h        |    6 +++
 arch/powerpc/include/asm/pci-bridge.h     |    3 ++
 arch/powerpc/kernel/pci-common.c          |   15 ++++++
 arch/powerpc/platforms/powernv/pci-ioda.c |   83 +++++++++++++++++++++++++++++
 4 files changed, 107 insertions(+)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index ad3025d..2f2e770 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -234,9 +234,15 @@ struct machdep_calls {
 
 	/* Called after scan and before resource survey */
 	void (*pcibios_fixup_phb)(struct pci_controller *hose);
+#ifdef CONFIG_PCI_IOV
+	void (*pcibios_fixup_sriov)(struct pci_bus *bus);
+#endif /* CONFIG_PCI_IOV */
 
 	/* Called during PCI resource reassignment */
 	resource_size_t (*pcibios_window_alignment)(struct pci_bus *, unsigned long type);
+#ifdef CONFIG_PCI_IOV
+	resource_size_t (*__pci_sriov_resource_size)(struct pci_dev *, int resno);
+#endif /* CONFIG_PCI_IOV */
 
 	/* Called to shutdown machine specific hardware not already controlled
 	 * by other drivers.
diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 4ca90a3..8c849d8 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -168,6 +168,9 @@ struct pci_dn {
 #define IODA_INVALID_PE		(-1)
 #ifdef CONFIG_PPC_POWERNV
 	int	pe_number;
+#ifdef CONFIG_PCI_IOV
+	u16     vfs;
+#endif /* CONFIG_PCI_IOV */
 #endif
 };
 
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index c449a26..c4e2e92 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -120,6 +120,16 @@ resource_size_t pcibios_window_alignment(struct pci_bus *bus,
 	return 1;
 }
 
+#ifdef CONFIG_PCI_IOV
+resource_size_t pcibios_sriov_resource_size(struct pci_dev *pdev, int resno)
+{
+	if (ppc_md.__pci_sriov_resource_size)
+		return ppc_md.__pci_sriov_resource_size(pdev, resno);
+
+	return 0;
+}
+#endif /* CONFIG_PCI_IOV */
+
 static resource_size_t pcibios_io_size(const struct pci_controller *hose)
 {
 #ifdef CONFIG_PPC64
@@ -1675,6 +1685,11 @@ void pcibios_scan_phb(struct pci_controller *hose)
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
index 87cb3089..7dfad6a 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1298,6 +1298,67 @@ static void pnv_pci_init_ioda_msis(struct pnv_phb *phb)
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
+	if (!hose) {
+		dev_err(&pdev->dev, "%s: NULL pci_controller\n", __func__);
+		return;
+	}
+
+	phb = hose->private_data;
+	if (!phb) {
+		dev_err(&pdev->dev, "%s: NULL PHB\n", __func__);
+		return;
+	}
+
+	pdn = pci_get_pdn(pdev);
+	pdn->vfs = 0;
+
+	for (i = PCI_IOV_RESOURCES; i <= PCI_IOV_RESOURCE_END; i++) {
+		res = &pdev->resource[i];
+		if (!res->flags || res->parent)
+			continue;
+
+		if (!is_mem_pref_64_type(res->flags))
+			continue;
+
+		dev_info(&pdev->dev, "PowerNV: Fixing VF BAR[%d] %pR to\n",
+				i, res);
+		size = pci_sriov_resource_size(pdev, i);
+		res->end = res->start + size * phb->ioda.total_pe - 1;
+		dev_info(&pdev->dev, "                       %pR\n", res);
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
@@ -1498,6 +1559,22 @@ static resource_size_t pnv_pci_window_alignment(struct pci_bus *bus,
 	return phb->ioda.io_segsize;
 }
 
+#ifdef CONFIG_PCI_IOV
+static resource_size_t __pnv_pci_sriov_resource_size(struct pci_dev *pdev, int resno)
+{
+	struct pci_dn *pdn = pci_get_pdn(pdev);
+	u64 size = 0;
+
+	if (!pdn->vfs)
+		return size;
+
+	size = resource_size(pdev->resource + resno);
+	do_div(size, pdn->vfs);
+
+	return size;
+}
+#endif /* CONFIG_PCI_IOV */
+
 /* Prevent enabling devices for which we couldn't properly
  * assign a PE
  */
@@ -1692,9 +1769,15 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	 * for the P2P bridge bars so that each PCI bus (excluding
 	 * the child P2P bridges) can form individual PE.
 	 */
+#ifdef CONFIG_PCI_IOV
+	ppc_md.pcibios_fixup_sriov = pnv_pci_ioda_fixup_sriov;
+#endif /* CONFIG_PCI_IOV */
 	ppc_md.pcibios_fixup = pnv_pci_ioda_fixup;
 	ppc_md.pcibios_enable_device_hook = pnv_pci_enable_device_hook;
 	ppc_md.pcibios_window_alignment = pnv_pci_window_alignment;
+#ifdef CONFIG_PCI_IOV
+	ppc_md.__pci_sriov_resource_size = __pnv_pci_sriov_resource_size;
+#endif /* CONFIG_PCI_IOV */
 	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
 
 	/* Reset IODA tables to a clean state */
-- 
1.7.9.5

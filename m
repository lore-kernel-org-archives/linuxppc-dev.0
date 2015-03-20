Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 270A31A0D6C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 14:14:53 +1100 (AEDT)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Fri, 20 Mar 2015 13:14:52 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id EC3552BB004D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 14:14:50 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2K3Eg4s41025722
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 14:14:50 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2K3EGTe011687
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 14:14:17 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com
Subject: [PATCH V14 15/21] powerpc/powernv: Reserve additional space for IOV
 BAR according to the number of total_pe
Date: Fri, 20 Mar 2015 11:06:31 +0800
Message-Id: <1426820797-6267-16-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1426820797-6267-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1426820797-6267-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, Wei Yang <weiyang@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On PHB3, PF IOV BAR will be covered by M64 BAR to have better PE isolation.
M64 BAR is a type of hardware resource in PHB3, which could map a range of
MMIO to PE numbers on powernv platform. And this range is divided equally
by the number of total_pe with each divided range mapping to a PE number.
Also, the M64 BAR must map a MMIO range with power-of-two size.

The total_pe number is usually different from total_VFs, which can lead to
a conflict between MMIO space and the PE number.

For example, if total_VFs is 128 and total_pe is 256, the second half of
M64 BAR will be part of other PCI device, which may already belong to other
PEs.

This patch prevents the conflict by reserving additional space for the PF
IOV BAR, which is total_pe number of VF's BAR size.

[bhelgaas: make dev_printk() output more consistent, index resource[]
conventionally]
Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/machdep.h        |    4 +++
 arch/powerpc/include/asm/pci-bridge.h     |    3 ++
 arch/powerpc/kernel/pci-common.c          |    6 ++++
 arch/powerpc/platforms/powernv/pci-ioda.c |   43 +++++++++++++++++++++++++++++
 4 files changed, 56 insertions(+)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index c8175a3..1d72fda 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -250,6 +250,10 @@ struct machdep_calls {
 	/* Reset the secondary bus of bridge */
 	void  (*pcibios_reset_secondary_bus)(struct pci_dev *dev);
 
+#ifdef CONFIG_PCI_IOV
+	void (*pcibios_fixup_sriov)(struct pci_dev *pdev);
+#endif /* CONFIG_PCI_IOV */
+
 	/* Called to shutdown machine specific hardware not already controlled
 	 * by other drivers.
 	 */
diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 513f8f2..d0d1718 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -175,6 +175,9 @@ struct pci_dn {
 #define IODA_INVALID_PE		(-1)
 #ifdef CONFIG_PPC_POWERNV
 	int	pe_number;
+#ifdef CONFIG_PCI_IOV
+	u16     vfs_expanded;		/* number of VFs IOV BAR expanded */
+#endif /* CONFIG_PCI_IOV */
 #endif
 	struct list_head child_list;
 	struct list_head list;
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 8203101..375bf70 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -990,6 +990,12 @@ int pcibios_add_device(struct pci_dev *dev)
 	 */
 	if (dev->bus->is_added)
 		pcibios_setup_device(dev);
+
+#ifdef CONFIG_PCI_IOV
+	if (ppc_md.pcibios_fixup_sriov)
+		ppc_md.pcibios_fixup_sriov(dev);
+#endif /* CONFIG_PCI_IOV */
+
 	return 0;
 }
 
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 1b37066..cadd3fb 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1749,6 +1749,46 @@ static void pnv_pci_init_ioda_msis(struct pnv_phb *phb)
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
+	pdn->vfs_expanded = 0;
+
+	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
+		res = &pdev->resource[i + PCI_IOV_RESOURCES];
+		if (!res->flags || res->parent)
+			continue;
+		if (!pnv_pci_is_mem_pref_64(res->flags)) {
+			dev_warn(&pdev->dev, "Skipping expanding VF BAR%d: %pR\n",
+				 i, res);
+			continue;
+		}
+
+		dev_dbg(&pdev->dev, " Fixing VF BAR%d: %pR to\n", i, res);
+		size = pci_iov_resource_size(pdev, i + PCI_IOV_RESOURCES);
+		res->end = res->start + size * phb->ioda.total_pe - 1;
+		dev_dbg(&pdev->dev, "                       %pR\n", res);
+		dev_info(&pdev->dev, "VF BAR%d: %pR (expanded to %d VFs for PE alignment)",
+				i, res, phb->ioda.total_pe);
+	}
+	pdn->vfs_expanded = phb->ioda.total_pe;
+}
+#endif /* CONFIG_PCI_IOV */
+
 /*
  * This function is supposed to be called on basis of PE from top
  * to bottom style. So the the I/O or MMIO segment assigned to
@@ -2125,6 +2165,9 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	ppc_md.pcibios_enable_device_hook = pnv_pci_enable_device_hook;
 	ppc_md.pcibios_window_alignment = pnv_pci_window_alignment;
 	ppc_md.pcibios_reset_secondary_bus = pnv_pci_reset_secondary_bus;
+#ifdef CONFIG_PCI_IOV
+	ppc_md.pcibios_fixup_sriov = pnv_pci_ioda_fixup_iov_resources;
+#endif /* CONFIG_PCI_IOV */
 	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
 
 	/* Reset IODA tables to a clean state */
-- 
1.7.9.5

Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 185731A022E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Nov 2014 02:42:09 +1100 (AEDT)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Mon, 3 Nov 2014 01:42:08 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 06AA52BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Nov 2014 02:42:07 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sA2Fftox36110374
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Nov 2014 02:41:55 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sA2Fg6F9028372
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Nov 2014 02:42:06 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V9 12/18] powerpc/powernv: Expand VF resources according to
 the number of total_pe
Date: Sun,  2 Nov 2014 23:41:28 +0800
Message-Id: <1414942894-17034-13-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1414942894-17034-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1414942894-17034-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On PHB3, PF IOV BAR will be covered by M64 BAR to have better PE isolation.
Mostly the total_pe number is different from the total_VFs, which will lead to
a conflict between MMIO space and the PE number.

For example, total_VFs is 128 and total_pe is 256, then the second half of M64
BAR space will be part of other PCI device, which may already belongs to other
PEs.

This patch expands the PF IOV BAR size to reserve total_pe number of VF's BAR
size, which prevents the conflict.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/machdep.h        |    4 +++
 arch/powerpc/include/asm/pci-bridge.h     |    3 ++
 arch/powerpc/kernel/pci-common.c          |    5 +++
 arch/powerpc/platforms/powernv/pci-ioda.c |   56 +++++++++++++++++++++++++++++
 4 files changed, 68 insertions(+)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 8242262..86d47ca 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -254,6 +254,10 @@ struct machdep_calls {
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
index 063d79d..ff26045 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -172,6 +172,9 @@ struct pci_dn {
 #define IODA_INVALID_PE		(-1)
 #ifdef CONFIG_PPC_POWERNV
 	int	pe_number;
+#ifdef CONFIG_PCI_IOV
+	u16     max_vfs;		/* number of VFs IOV BAR expended */
+#endif /* CONFIG_PCI_IOV */
 #endif
 	struct list_head child_list;
 	struct list_head list;
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 17acfa7..4e3d87d 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1645,6 +1645,11 @@ void pcibios_scan_phb(struct pci_controller *hose)
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
index 6d35ed9..ef279d3 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1601,6 +1601,59 @@ static void pnv_pci_init_ioda_msis(struct pnv_phb *phb)
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
+	pdn->max_vfs = 0;
+
+	for (i = PCI_IOV_RESOURCES; i <= PCI_IOV_RESOURCE_END; i++) {
+		res = &pdev->resource[i];
+		if (!res->flags || res->parent)
+			continue;
+		if (!pnv_pci_is_mem_pref_64(res->flags)) {
+			dev_warn(&pdev->dev, " Skipping expanding IOV BAR %pR on %s\n",
+				 res, pci_name(pdev));
+			continue;
+		}
+
+		dev_dbg(&pdev->dev, " Fixing VF BAR[%d] %pR to\n", i, res);
+		size = pci_iov_resource_size(pdev, i);
+		res->end = res->start + size * phb->ioda.total_pe - 1;
+		dev_dbg(&pdev->dev, "                       %pR\n", res);
+	}
+	pdn->max_vfs = phb->ioda.total_pe;
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
@@ -1983,6 +2036,9 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	ppc_md.pcibios_enable_device_hook = pnv_pci_enable_device_hook;
 	ppc_md.pcibios_window_alignment = pnv_pci_window_alignment;
 	ppc_md.pcibios_reset_secondary_bus = pnv_pci_reset_secondary_bus;
+#ifdef CONFIG_PCI_IOV
+	ppc_md.pcibios_fixup_sriov = pnv_pci_ioda_fixup_sriov;
+#endif /* CONFIG_PCI_IOV */
 	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
 
 	/* Reset IODA tables to a clean state */
-- 
1.7.9.5

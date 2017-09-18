Return-Path: <bryantly@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xwwxz700szDq78
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 05:27:35 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8IJOXXM031952
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Sep 2017 15:27:33 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d2g15gcg1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Sep 2017 15:27:32 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bryantly@linux.vnet.ibm.com>;
 Mon, 18 Sep 2017 15:27:32 -0400
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
 "Juan J . Alvarez" <jjalvare@us.ibm.com>
Subject: [PATCH v1 3/3] powerpc/kernel: Separate SR-IOV Calls
Date: Mon, 18 Sep 2017 14:26:51 -0500
In-Reply-To: <20170918192651.78404-1-bryantly@linux.vnet.ibm.com>
References: <20170918192651.78404-1-bryantly@linux.vnet.ibm.com>
Message-Id: <20170918192651.78404-4-bryantly@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

SR-IOV can now be enabled in PowerNV platforms and Pseries
platforms. Therefore, the appropriate calls were moved to
machine dependent code instead of definition at compile time.

Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
Signed-off-by: Juan J. Alvarez <jjalvare@us.ibm.com>
---
 arch/powerpc/include/asm/machdep.h           |  7 ++++++
 arch/powerpc/include/asm/pci-bridge.h        |  4 +---
 arch/powerpc/kernel/eeh_driver.c             |  4 ++--
 arch/powerpc/kernel/pci-common.c             | 23 +++++++++++++++++++
 arch/powerpc/kernel/pci_dn.c                 |  6 -----
 arch/powerpc/platforms/powernv/eeh-powernv.c | 34 +++++++++++++++-------------
 arch/powerpc/platforms/powernv/pci-ioda.c    |  6 +++--
 7 files changed, 55 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 73b92017b6d7..20f68d36af8c 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -172,11 +172,18 @@ struct machdep_calls {
 	/* Called after scan and before resource survey */
 	void (*pcibios_fixup_phb)(struct pci_controller *hose);
 
+	/* Called after device has been added to bus and
+	 * before sysfs has been created
+	 */
+	void (*pcibios_bus_add_device)(struct pci_dev *pdev);
+
 	resource_size_t (*pcibios_default_alignment)(void);
 
 #ifdef CONFIG_PCI_IOV
 	void (*pcibios_fixup_sriov)(struct pci_dev *pdev);
 	resource_size_t (*pcibios_iov_resource_alignment)(struct pci_dev *, int resno);
+	int (*pcibios_sriov_enable)(struct pci_dev *pdev, u16 num_vfs);
+	int (*pcibios_sriov_disable)(struct pci_dev *pdev);
 #endif /* CONFIG_PCI_IOV */
 
 	/* Called to shutdown machine specific hardware not already controlled
diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 0b8aa1fe2d5f..323628ca4d6d 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -203,10 +203,9 @@ struct pci_dn {
 	struct eeh_dev *edev;		/* eeh device */
 #endif
 #define IODA_INVALID_PE		0xFFFFFFFF
-#ifdef CONFIG_PPC_POWERNV
 	unsigned int pe_number;
-	int     vf_index;		/* VF index in the PF */
 #ifdef CONFIG_PCI_IOV
+	int     vf_index;		/* VF index in the PF */
 	u16     vfs_expanded;		/* number of VFs IOV BAR expanded */
 	u16     num_vfs;		/* number of VFs enabled*/
 	unsigned int *pe_num_map;	/* PE# for the first VF PE or array */
@@ -215,7 +214,6 @@ struct pci_dn {
 	int     (*m64_map)[PCI_SRIOV_NUM_BARS];
 #endif /* CONFIG_PCI_IOV */
 	int	mps;			/* Maximum Payload Size */
-#endif
 	struct list_head child_list;
 	struct list_head list;
 };
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 8b840191df59..f2d1b369974d 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -440,7 +440,7 @@ static void *eeh_add_virt_device(void *data, void *userdata)
 			return NULL;
 	}
 
-#ifdef CONFIG_PPC_POWERNV
+#ifdef CONFIG_PCI_IOV
 	pci_iov_add_virtfn(edev->physfn, pdn->vf_index, 0);
 #endif
 	return NULL;
@@ -496,7 +496,7 @@ static void *eeh_rmv_device(void *data, void *userdata)
 		(*removed)++;
 
 	if (edev->physfn) {
-#ifdef CONFIG_PPC_POWERNV
+#ifdef CONFIG_PCI_IOV
 		struct pci_dn *pdn = eeh_dev_to_pdn(edev);
 
 		pci_iov_remove_virtfn(edev->physfn, pdn->vf_index, 0);
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 02831a396419..d45b956d2e3a 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -249,8 +249,31 @@ resource_size_t pcibios_iov_resource_alignment(struct pci_dev *pdev, int resno)
 
 	return pci_iov_resource_size(pdev, resno);
 }
+
+int pcibios_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
+{
+	if (ppc_md.pcibios_sriov_enable)
+		return ppc_md.pcibios_sriov_enable(pdev, num_vfs);
+
+	return 0;
+}
+
+int pcibios_sriov_disable(struct pci_dev *pdev)
+{
+	if (ppc_md.pcibios_sriov_disable)
+		return ppc_md.pcibios_sriov_disable(pdev);
+
+	return 0;
+}
+
 #endif /* CONFIG_PCI_IOV */
 
+void pcibios_bus_add_device(struct pci_dev *pdev)
+{
+	if (ppc_md.pcibios_bus_add_device)
+		ppc_md.pcibios_bus_add_device(pdev);
+}
+
 static resource_size_t pcibios_io_size(const struct pci_controller *hose)
 {
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index 0e395afbf0f4..ab147a1909c8 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -156,10 +156,8 @@ static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
 	pdn->parent = parent;
 	pdn->busno = busno;
 	pdn->devfn = devfn;
-#ifdef CONFIG_PPC_POWERNV
 	pdn->vf_index = vf_index;
 	pdn->pe_number = IODA_INVALID_PE;
-#endif
 	INIT_LIST_HEAD(&pdn->child_list);
 	INIT_LIST_HEAD(&pdn->list);
 	list_add_tail(&pdn->list, &parent->child_list);
@@ -226,9 +224,7 @@ void remove_dev_pci_data(struct pci_dev *pdev)
 	 */
 	if (pdev->is_virtfn) {
 		pdn = pci_get_pdn(pdev);
-#ifdef CONFIG_PPC_POWERNV
 		pdn->pe_number = IODA_INVALID_PE;
-#endif
 		return;
 	}
 
@@ -294,9 +290,7 @@ struct pci_dn *pci_add_device_node_info(struct pci_controller *hose,
 		return NULL;
 	dn->data = pdn;
 	pdn->phb = hose;
-#ifdef CONFIG_PPC_POWERNV
 	pdn->pe_number = IODA_INVALID_PE;
-#endif
 	regs = of_get_property(dn, "reg", NULL);
 	if (regs) {
 		u32 addr = of_read_number(regs, 1);
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 8864065eba22..349571e995ea 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -44,6 +44,22 @@
 static bool pnv_eeh_nb_init = false;
 static int eeh_event_irq = -EINVAL;
 
+void pnv_pcibios_bus_add_device(struct pci_dev *pdev)
+{
+	struct pci_dn *pdn = pci_get_pdn(pdev);
+
+	if (!pdev->is_virtfn)
+		return;
+
+	/*
+	 * The following operations will fail if VF's sysfs files
+	 * aren't created or its resources aren't finalized.
+	 */
+	eeh_add_device_early(pdn);
+	eeh_add_device_late(pdev);
+	eeh_sysfs_add_device(pdev);
+}
+
 static int pnv_eeh_init(void)
 {
 	struct pci_controller *hose;
@@ -88,6 +104,8 @@ static int pnv_eeh_init(void)
 
 	eeh_set_pe_aux_size(max_diag_size);
 
+	ppc_md.pcibios_bus_add_device = pnv_pcibios_bus_add_device;
+
 	return 0;
 }
 
@@ -1747,22 +1765,6 @@ static struct eeh_ops pnv_eeh_ops = {
 	.restore_config		= pnv_eeh_restore_config
 };
 
-void pcibios_bus_add_device(struct pci_dev *pdev)
-{
-	struct pci_dn *pdn = pci_get_pdn(pdev);
-
-	if (!pdev->is_virtfn)
-		return;
-
-	/*
-	 * The following operations will fail if VF's sysfs files
-	 * aren't created or its resources aren't finalized.
-	 */
-	eeh_add_device_early(pdn);
-	eeh_add_device_late(pdev);
-	eeh_sysfs_add_device(pdev);
-}
-
 #ifdef CONFIG_PCI_IOV
 static void pnv_pci_fixup_vf_mps(struct pci_dev *pdev)
 {
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 57f9e55f4352..f7fed25e06ba 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1674,7 +1674,7 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
 	return ret;
 }
 
-int pcibios_sriov_disable(struct pci_dev *pdev)
+int pnv_pcibios_sriov_disable(struct pci_dev *pdev)
 {
 	pnv_pci_sriov_disable(pdev);
 
@@ -1683,7 +1683,7 @@ int pcibios_sriov_disable(struct pci_dev *pdev)
 	return 0;
 }
 
-int pcibios_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
+int pnv_pcibios_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
 {
 	/* Allocate PCI data */
 	add_dev_pci_data(pdev);
@@ -4002,6 +4002,8 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 #ifdef CONFIG_PCI_IOV
 	ppc_md.pcibios_fixup_sriov = pnv_pci_ioda_fixup_iov_resources;
 	ppc_md.pcibios_iov_resource_alignment = pnv_pci_iov_resource_alignment;
+	ppc_md.pcibios_sriov_enable = pnv_pcibios_sriov_enable;
+	ppc_md.pcibios_sriov_disable = pnv_pcibios_sriov_disable;
 #endif
 
 	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
-- 
2.11.0 (Apple Git-81)

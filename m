Return-Path: <SRS0=vnEJ=O5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AA6C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 08:58:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2854D2176F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 08:58:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2854D2176F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43L5JB3crKzDrB8
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 19:58:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 43L4Yq5PkYzDqvV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2018 19:24:47 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 2CB80AE8035D;
 Thu, 20 Dec 2018 03:24:43 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v7 14/20] powerpc/powernv/npu: Add compound IOMMU groups
Date: Thu, 20 Dec 2018 19:23:44 +1100
Message-Id: <20181220082350.58113-15-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181220082350.58113-1-aik@ozlabs.ru>
References: <20181220082350.58113-1-aik@ozlabs.ru>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Christoph Hellwig <hch@infradead.org>,
 Jose Ricardo Ziviani <joserz@linux.ibm.com>, kvm@vger.kernel.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Alistair Popple <alistair@popple.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sam Bobroff <sbobroff@linux.ibm.com>,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 =?UTF-8?q?Leonardo=20Augusto=20Guimar=C3=A3es=20Garcia?= <lagarcia@br.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

At the moment the powernv platform registers an IOMMU group for each PE.
There is an exception though: an NVLink bridge which is attached to
the corresponding GPU's IOMMU group making it a master.

Now we have POWER9 systems with GPUs connected to each other directly
bypassing PCI. At the moment we do not control state of these links so
we have to put such interconnected GPUs to one IOMMU group which
means that the old scheme with one GPU as a master won't work - there will
be up to 3 GPUs in such group.

This introduces a npu_comp struct which represents a compound IOMMU
group made of multiple PEs - PCI PEs (for GPUs) and NPU PEs (for NVLink
bridges). This converts the existing NVLink1 code to use the new scheme.
From now on, each PE must have a valid iommu_table_group_ops which will
either be called directly (for a single PE group) or indirectly from
a compound group handlers.

This moves IOMMU group registration for NVLink-connected GPUs to npu-dma.c.
For POWER8, this stores a new compound group pointer in the PE (so a GPU
is still a master); for POWER9 the new group pointer is stored in an NPU
(which is allocated per a PCI host controller).

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v7:
* fixed compiler warning in pnv_try_setup_npu_table_group()

v5:
* now read page sizes from PHB NVLink to narrow down what the compoind PE
can actually support (hint: 4K/64K only)
---
 arch/powerpc/include/asm/pci.h            |   1 +
 arch/powerpc/platforms/powernv/pci.h      |   7 +
 arch/powerpc/platforms/powernv/npu-dma.c  | 291 ++++++++++++++++++++--
 arch/powerpc/platforms/powernv/pci-ioda.c | 159 ++++--------
 4 files changed, 322 insertions(+), 136 deletions(-)

diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index baf2886..0c72f18 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -132,5 +132,6 @@ extern struct pci_dev *pnv_pci_get_npu_dev(struct pci_dev *gpdev, int index);
 extern int pnv_npu2_init(struct pci_controller *hose);
 extern int pnv_npu2_map_lpar_dev(struct pci_dev *gpdev, unsigned int lparid,
 		unsigned long msr);
+extern int pnv_npu2_unmap_lpar_dev(struct pci_dev *gpdev);
 
 #endif /* __ASM_POWERPC_PCI_H */
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index cf9f748..aef4bb5 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -62,6 +62,7 @@ struct pnv_ioda_pe {
 
 	/* "Base" iommu table, ie, 4K TCEs, 32-bit DMA */
 	struct iommu_table_group table_group;
+	struct npu_comp		*npucomp;
 
 	/* 64-bit TCE bypass region */
 	bool			tce_bypass_enabled;
@@ -201,6 +202,8 @@ extern void pnv_teardown_msi_irqs(struct pci_dev *pdev);
 extern struct pnv_ioda_pe *pnv_ioda_get_pe(struct pci_dev *dev);
 extern void pnv_set_msi_irq_chip(struct pnv_phb *phb, unsigned int virq);
 extern void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable);
+extern unsigned long pnv_pci_ioda2_get_table_size(__u32 page_shift,
+		__u64 window_size, __u32 levels);
 extern int pnv_eeh_post_init(void);
 
 extern void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
@@ -216,6 +219,10 @@ extern void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
 extern void pnv_npu_try_dma_set_bypass(struct pci_dev *gpdev, bool bypass);
 extern void pnv_pci_ioda2_tce_invalidate_entire(struct pnv_phb *phb, bool rm);
 extern struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe);
+extern struct iommu_table_group *pnv_try_setup_npu_table_group(
+		struct pnv_ioda_pe *pe);
+extern struct iommu_table_group *pnv_npu_compound_attach(
+		struct pnv_ioda_pe *pe);
 
 /* pci-ioda-tce.c */
 #define POWERNV_IOMMU_DEFAULT_LEVELS	1
diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index dc629ee..d93a2cd 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -328,31 +328,6 @@ static struct iommu_table_group_ops pnv_pci_npu_ops = {
 	.unset_window = pnv_npu_unset_window,
 	.take_ownership = pnv_npu_take_ownership,
 };
-
-struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe)
-{
-	struct pnv_phb *phb = npe->phb;
-	struct pci_bus *pbus = phb->hose->bus;
-	struct pci_dev *npdev, *gpdev = NULL, *gptmp;
-	struct pnv_ioda_pe *gpe = get_gpu_pci_dev_and_pe(npe, &gpdev);
-
-	if (!gpe || !gpdev)
-		return NULL;
-
-	npe->table_group.ops = &pnv_pci_npu_ops;
-
-	list_for_each_entry(npdev, &pbus->devices, bus_list) {
-		gptmp = pnv_pci_get_gpu_dev(npdev);
-
-		if (gptmp != gpdev)
-			continue;
-
-		pe_info(gpe, "Attached NPU %s\n", dev_name(&npdev->dev));
-		iommu_group_add_device(gpe->table_group.group, &npdev->dev);
-	}
-
-	return gpe;
-}
 #endif /* !CONFIG_IOMMU_API */
 
 /*
@@ -360,6 +335,17 @@ struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe)
  */
 /* Maximum possible number of ATSD MMIO registers per NPU */
 #define NV_NMMU_ATSD_REGS 8
+#define NV_NPU_MAX_PE_NUM	16
+
+/*
+ * A compound NPU IOMMU group which might consist of 1 GPU + 2xNPUs (POWER8) or
+ * up to 3 x (GPU + 2xNPUs) (POWER9).
+ */
+struct npu_comp {
+	struct iommu_table_group table_group;
+	int pe_num;
+	struct pnv_ioda_pe *pe[NV_NPU_MAX_PE_NUM];
+};
 
 /* An NPU descriptor, valid for POWER9 only */
 struct npu {
@@ -372,8 +358,263 @@ struct npu {
 
 	/* Do we need to explicitly flush the nest mmu? */
 	bool nmmu_flush;
+
+	struct npu_comp npucomp;
 };
 
+#ifdef CONFIG_IOMMU_API
+static long pnv_npu_peers_create_table_userspace(
+		struct iommu_table_group *table_group,
+		int num, __u32 page_shift, __u64 window_size, __u32 levels,
+		struct iommu_table **ptbl)
+{
+	struct npu_comp *npucomp = container_of(table_group, struct npu_comp,
+			table_group);
+
+	if (!npucomp->pe_num || !npucomp->pe[0] ||
+			!npucomp->pe[0]->table_group.ops ||
+			!npucomp->pe[0]->table_group.ops->create_table)
+		return -EFAULT;
+
+	return npucomp->pe[0]->table_group.ops->create_table(
+			&npucomp->pe[0]->table_group, num, page_shift,
+			window_size, levels, ptbl);
+}
+
+static long pnv_npu_peers_set_window(struct iommu_table_group *table_group,
+		int num, struct iommu_table *tbl)
+{
+	int i, j;
+	long ret = 0;
+	struct npu_comp *npucomp = container_of(table_group, struct npu_comp,
+			table_group);
+
+	for (i = 0; i < npucomp->pe_num; ++i) {
+		struct pnv_ioda_pe *pe = npucomp->pe[i];
+
+		if (!pe->table_group.ops->set_window)
+			continue;
+
+		ret = pe->table_group.ops->set_window(&pe->table_group,
+				num, tbl);
+		if (ret)
+			break;
+	}
+
+	if (ret) {
+		for (j = 0; j < i; ++j) {
+			struct pnv_ioda_pe *pe = npucomp->pe[j];
+
+			if (!pe->table_group.ops->unset_window)
+				continue;
+
+			ret = pe->table_group.ops->unset_window(
+					&pe->table_group, num);
+			if (ret)
+				break;
+		}
+	} else {
+		table_group->tables[num] = iommu_tce_table_get(tbl);
+	}
+
+	return ret;
+}
+
+static long pnv_npu_peers_unset_window(struct iommu_table_group *table_group,
+		int num)
+{
+	int i, j;
+	long ret = 0;
+	struct npu_comp *npucomp = container_of(table_group, struct npu_comp,
+			table_group);
+
+	for (i = 0; i < npucomp->pe_num; ++i) {
+		struct pnv_ioda_pe *pe = npucomp->pe[i];
+
+		WARN_ON(npucomp->table_group.tables[num] !=
+				table_group->tables[num]);
+		if (!npucomp->table_group.tables[num])
+			continue;
+
+		if (!pe->table_group.ops->unset_window)
+			continue;
+
+		ret = pe->table_group.ops->unset_window(&pe->table_group, num);
+		if (ret)
+			break;
+	}
+
+	if (ret) {
+		for (j = 0; j < i; ++j) {
+			struct pnv_ioda_pe *pe = npucomp->pe[j];
+
+			if (!npucomp->table_group.tables[num])
+				continue;
+
+			if (!pe->table_group.ops->set_window)
+				continue;
+
+			ret = pe->table_group.ops->set_window(&pe->table_group,
+					num, table_group->tables[num]);
+			if (ret)
+				break;
+		}
+	} else if (table_group->tables[num]) {
+		iommu_tce_table_put(table_group->tables[num]);
+		table_group->tables[num] = NULL;
+	}
+
+	return ret;
+}
+
+static void pnv_npu_peers_take_ownership(struct iommu_table_group *table_group)
+{
+	int i;
+	struct npu_comp *npucomp = container_of(table_group, struct npu_comp,
+			table_group);
+
+	for (i = 0; i < npucomp->pe_num; ++i) {
+		struct pnv_ioda_pe *pe = npucomp->pe[i];
+
+		if (!pe->table_group.ops->take_ownership)
+			continue;
+		pe->table_group.ops->take_ownership(&pe->table_group);
+	}
+}
+
+static void pnv_npu_peers_release_ownership(
+		struct iommu_table_group *table_group)
+{
+	int i;
+	struct npu_comp *npucomp = container_of(table_group, struct npu_comp,
+			table_group);
+
+	for (i = 0; i < npucomp->pe_num; ++i) {
+		struct pnv_ioda_pe *pe = npucomp->pe[i];
+
+		if (!pe->table_group.ops->release_ownership)
+			continue;
+		pe->table_group.ops->release_ownership(&pe->table_group);
+	}
+}
+
+static struct iommu_table_group_ops pnv_npu_peers_ops = {
+	.get_table_size = pnv_pci_ioda2_get_table_size,
+	.create_table = pnv_npu_peers_create_table_userspace,
+	.set_window = pnv_npu_peers_set_window,
+	.unset_window = pnv_npu_peers_unset_window,
+	.take_ownership = pnv_npu_peers_take_ownership,
+	.release_ownership = pnv_npu_peers_release_ownership,
+};
+
+static void pnv_comp_attach_table_group(struct npu_comp *npucomp,
+		struct pnv_ioda_pe *pe)
+{
+	if (WARN_ON(npucomp->pe_num == NV_NPU_MAX_PE_NUM))
+		return;
+
+	npucomp->pe[npucomp->pe_num] = pe;
+	++npucomp->pe_num;
+}
+
+struct iommu_table_group *pnv_try_setup_npu_table_group(struct pnv_ioda_pe *pe)
+{
+	struct iommu_table_group *table_group;
+	struct npu_comp *npucomp;
+	struct pci_dev *gpdev = NULL;
+	struct pci_controller *hose;
+	struct pci_dev *npdev = NULL;
+
+	list_for_each_entry(gpdev, &pe->pbus->devices, bus_list) {
+		npdev = pnv_pci_get_npu_dev(gpdev, 0);
+		if (npdev)
+			break;
+	}
+
+	if (!npdev)
+		/* It is not an NPU attached device, skip */
+		return NULL;
+
+	hose = pci_bus_to_host(npdev->bus);
+
+	if (hose->npu) {
+		table_group = &hose->npu->npucomp.table_group;
+
+		if (!table_group->group) {
+			table_group->ops = &pnv_npu_peers_ops;
+			iommu_register_group(table_group,
+					hose->global_number,
+					pe->pe_number);
+		}
+	} else {
+		/* Create a group for 1 GPU and attached NPUs for POWER8 */
+		pe->npucomp = kzalloc(sizeof(pe->npucomp), GFP_KERNEL);
+		table_group = &pe->npucomp->table_group;
+		table_group->ops = &pnv_npu_peers_ops;
+		iommu_register_group(table_group, hose->global_number,
+				pe->pe_number);
+	}
+
+	/* Steal capabilities from a GPU PE */
+	table_group->max_dynamic_windows_supported =
+		pe->table_group.max_dynamic_windows_supported;
+	table_group->tce32_start = pe->table_group.tce32_start;
+	table_group->tce32_size = pe->table_group.tce32_size;
+	table_group->max_levels = pe->table_group.max_levels;
+	if (!table_group->pgsizes)
+		table_group->pgsizes = pe->table_group.pgsizes;
+
+	npucomp = container_of(table_group, struct npu_comp, table_group);
+	pnv_comp_attach_table_group(npucomp, pe);
+
+	return table_group;
+}
+
+struct iommu_table_group *pnv_npu_compound_attach(struct pnv_ioda_pe *pe)
+{
+	struct iommu_table_group *table_group;
+	struct npu_comp *npucomp;
+	struct pci_dev *gpdev = NULL;
+	struct pci_dev *npdev;
+	struct pnv_ioda_pe *gpe = get_gpu_pci_dev_and_pe(pe, &gpdev);
+
+	WARN_ON(!(pe->flags & PNV_IODA_PE_DEV));
+	if (!gpe)
+		return NULL;
+
+	/*
+	 * IODA2 bridges get this set up from pci_controller_ops::setup_bridge
+	 * but NPU bridges do not have this hook defined so we do it here.
+	 * We do not setup other table group parameters as they won't be used
+	 * anyway - NVLink bridges are subordinate PEs.
+	 */
+	pe->table_group.ops = &pnv_pci_npu_ops;
+
+	table_group = iommu_group_get_iommudata(
+			iommu_group_get(&gpdev->dev));
+
+	/*
+	 * On P9 NPU PHB and PCI PHB support different page sizes,
+	 * keep only matching. We expect here that NVLink bridge PE pgsizes is
+	 * initialized by the caller.
+	 */
+	table_group->pgsizes &= pe->table_group.pgsizes;
+	npucomp = container_of(table_group, struct npu_comp, table_group);
+	pnv_comp_attach_table_group(npucomp, pe);
+
+	list_for_each_entry(npdev, &pe->phb->hose->bus->devices, bus_list) {
+		struct pci_dev *gpdevtmp = pnv_pci_get_gpu_dev(npdev);
+
+		if (gpdevtmp != gpdev)
+			continue;
+
+		iommu_add_device(table_group, &npdev->dev);
+	}
+
+	return table_group;
+}
+#endif /* CONFIG_IOMMU_API */
+
 /* Maximum number of nvlinks per npu */
 #define NV_MAX_LINKS 6
 
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 6972054..6fe8907 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -190,7 +190,8 @@ static void pnv_ioda_free_pe(struct pnv_ioda_pe *pe)
 	unsigned int pe_num = pe->pe_number;
 
 	WARN_ON(pe->pdev);
-
+	WARN_ON(pe->npucomp); /* NPUs are not supposed to be freed */
+	kfree(pe->npucomp);
 	memset(pe, 0, sizeof(struct pnv_ioda_pe));
 	clear_bit(pe_num, phb->ioda.pe_alloc);
 }
@@ -1539,7 +1540,9 @@ void pnv_pci_sriov_disable(struct pci_dev *pdev)
 static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 				       struct pnv_ioda_pe *pe);
 #ifdef CONFIG_IOMMU_API
-static void pnv_ioda_setup_bus_iommu_group(struct pnv_ioda_pe *pe);
+static void pnv_ioda_setup_bus_iommu_group(struct pnv_ioda_pe *pe,
+		struct iommu_table_group *table_group, struct pci_bus *bus);
+
 #endif
 static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
 {
@@ -1595,7 +1598,7 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
 
 		pnv_pci_ioda2_setup_dma_pe(phb, pe);
 #ifdef CONFIG_IOMMU_API
-		pnv_ioda_setup_bus_iommu_group(pe);
+		pnv_ioda_setup_bus_iommu_group(pe, &pe->table_group, NULL);
 #endif
 	}
 }
@@ -2557,7 +2560,7 @@ static long pnv_pci_ioda2_unset_window(struct iommu_table_group *table_group,
 #endif
 
 #ifdef CONFIG_IOMMU_API
-static unsigned long pnv_pci_ioda2_get_table_size(__u32 page_shift,
+unsigned long pnv_pci_ioda2_get_table_size(__u32 page_shift,
 		__u64 window_size, __u32 levels)
 {
 	unsigned long bytes = 0;
@@ -2631,127 +2634,40 @@ static struct iommu_table_group_ops pnv_pci_ioda2_ops = {
 	.release_ownership = pnv_ioda2_release_ownership,
 };
 
-static int gpe_table_group_to_npe_cb(struct device *dev, void *opaque)
-{
-	struct pci_controller *hose;
-	struct pnv_phb *phb;
-	struct pnv_ioda_pe **ptmppe = opaque;
-	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
-	struct pci_dn *pdn = pci_get_pdn(pdev);
-
-	if (!pdn || pdn->pe_number == IODA_INVALID_PE)
-		return 0;
-
-	hose = pci_bus_to_host(pdev->bus);
-	phb = hose->private_data;
-	if (phb->type != PNV_PHB_NPU_NVLINK)
-		return 0;
-
-	*ptmppe = &phb->ioda.pe_array[pdn->pe_number];
-
-	return 1;
-}
-
-/*
- * This returns PE of associated NPU.
- * This assumes that NPU is in the same IOMMU group with GPU and there is
- * no other PEs.
- */
-static struct pnv_ioda_pe *gpe_table_group_to_npe(
-		struct iommu_table_group *table_group)
-{
-	struct pnv_ioda_pe *npe = NULL;
-	int ret = iommu_group_for_each_dev(table_group->group, &npe,
-			gpe_table_group_to_npe_cb);
-
-	BUG_ON(!ret || !npe);
-
-	return npe;
-}
-
-static long pnv_pci_ioda2_npu_set_window(struct iommu_table_group *table_group,
-		int num, struct iommu_table *tbl)
-{
-	struct pnv_ioda_pe *npe = gpe_table_group_to_npe(table_group);
-	long ret = pnv_pci_ioda2_set_window(table_group, num, tbl);
-
-	if (ret)
-		return ret;
-
-	ret = npe->table_group.ops->set_window(&npe->table_group, num, tbl);
-	if (ret)
-		pnv_pci_ioda2_unset_window(table_group, num);
-
-	return ret;
-}
-
-static long pnv_pci_ioda2_npu_unset_window(
-		struct iommu_table_group *table_group,
-		int num)
-{
-	struct pnv_ioda_pe *npe = gpe_table_group_to_npe(table_group);
-	long ret = pnv_pci_ioda2_unset_window(table_group, num);
-
-	if (ret)
-		return ret;
-
-	return npe->table_group.ops->unset_window(&npe->table_group, num);
-}
-
-static void pnv_ioda2_npu_take_ownership(struct iommu_table_group *table_group)
-{
-	struct pnv_ioda_pe *npe = gpe_table_group_to_npe(table_group);
-
-	npe->table_group.ops->take_ownership(&npe->table_group);
-	pnv_ioda2_take_ownership(table_group);
-}
-
-static struct iommu_table_group_ops pnv_pci_ioda2_npu_ops = {
-	.get_table_size = pnv_pci_ioda2_get_table_size,
-	.create_table = pnv_pci_ioda2_create_table_userspace,
-	.set_window = pnv_pci_ioda2_npu_set_window,
-	.unset_window = pnv_pci_ioda2_npu_unset_window,
-	.take_ownership = pnv_ioda2_npu_take_ownership,
-	.release_ownership = pnv_ioda2_release_ownership,
-};
-
 static void pnv_ioda_setup_bus_iommu_group_add_devices(struct pnv_ioda_pe *pe,
+		struct iommu_table_group *table_group,
 		struct pci_bus *bus)
 {
 	struct pci_dev *dev;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-		iommu_add_device(&pe->table_group, &dev->dev);
+		iommu_add_device(table_group, &dev->dev);
 
 		if ((pe->flags & PNV_IODA_PE_BUS_ALL) && dev->subordinate)
 			pnv_ioda_setup_bus_iommu_group_add_devices(pe,
-					dev->subordinate);
+					table_group, dev->subordinate);
 	}
 }
 
-static void pnv_ioda_setup_bus_iommu_group(struct pnv_ioda_pe *pe)
+static void pnv_ioda_setup_bus_iommu_group(struct pnv_ioda_pe *pe,
+		struct iommu_table_group *table_group, struct pci_bus *bus)
 {
-	if (!pnv_pci_ioda_pe_dma_weight(pe))
-		return;
 
-	iommu_register_group(&pe->table_group, pe->phb->hose->global_number,
-			pe->pe_number);
-
-	/*
-	 * set_iommu_table_base(&pe->pdev->dev, tbl) should have been called
-	 * by now
-	 */
 	if (pe->flags & PNV_IODA_PE_DEV)
-		iommu_add_device(&pe->table_group, &pe->pdev->dev);
-	else if (pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL))
-		pnv_ioda_setup_bus_iommu_group_add_devices(pe, pe->pbus);
+		iommu_add_device(table_group, &pe->pdev->dev);
+
+	if ((pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL)) || bus)
+		pnv_ioda_setup_bus_iommu_group_add_devices(pe, table_group,
+				bus);
 }
 
+static unsigned long pnv_ioda_parse_tce_sizes(struct pnv_phb *phb);
+
 static void pnv_pci_ioda_setup_iommu_api(void)
 {
-	struct pci_controller *hose, *tmp;
+	struct pci_controller *hose;
 	struct pnv_phb *phb;
-	struct pnv_ioda_pe *pe, *gpe;
+	struct pnv_ioda_pe *pe;
 
 	/*
 	 * There are 4 types of PEs:
@@ -2773,24 +2689,45 @@ static void pnv_pci_ioda_setup_iommu_api(void)
 		if (phb->type == PNV_PHB_NPU_NVLINK)
 			continue;
 
-		list_for_each_entry(pe, &phb->ioda.pe_list, list)
-			pnv_ioda_setup_bus_iommu_group(pe);
+		list_for_each_entry(pe, &phb->ioda.pe_list, list) {
+			struct iommu_table_group *table_group;
+
+			table_group = pnv_try_setup_npu_table_group(pe);
+			if (!table_group) {
+				if (!pnv_pci_ioda_pe_dma_weight(pe))
+					continue;
+
+				table_group = &pe->table_group;
+				iommu_register_group(&pe->table_group,
+						pe->phb->hose->global_number,
+						pe->pe_number);
+			}
+			pnv_ioda_setup_bus_iommu_group(pe, table_group,
+					pe->pbus);
+		}
 	}
 
 	/*
 	 * Now we have all PHBs discovered, time to add NPU devices to
 	 * the corresponding IOMMU groups.
 	 */
-	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
+	list_for_each_entry(hose, &hose_list, list_node) {
+		unsigned long  pgsizes;
+
 		phb = hose->private_data;
 
 		if (phb->type != PNV_PHB_NPU_NVLINK)
 			continue;
 
+		pgsizes = pnv_ioda_parse_tce_sizes(phb);
 		list_for_each_entry(pe, &phb->ioda.pe_list, list) {
-			gpe = pnv_pci_npu_setup_iommu(pe);
-			if (gpe)
-				gpe->table_group.ops = &pnv_pci_ioda2_npu_ops;
+			/*
+			 * IODA2 bridges get this set up from
+			 * pci_controller_ops::setup_bridge but NPU bridges
+			 * do not have this hook defined so we do it here.
+			 */
+			pe->table_group.pgsizes = pgsizes;
+			pnv_npu_compound_attach(pe);
 		}
 	}
 }
-- 
2.17.1


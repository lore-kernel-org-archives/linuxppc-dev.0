Return-Path: <SRS0=vnEJ=O5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19A6C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 08:55:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35DE921741
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 08:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35DE921741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43L5FJ0flVzDr5l
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 19:55:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 43L4Yp2LhRzDqst
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2018 19:24:46 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 54AF9AE80219;
 Thu, 20 Dec 2018 03:24:12 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v7 05/20] powerpc/powernv/npu: Move OPAL calls away
 from context manipulation
Date: Thu, 20 Dec 2018 19:23:35 +1100
Message-Id: <20181220082350.58113-6-aik@ozlabs.ru>
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

When introduced, the NPU context init/destroy helpers called OPAL which
enabled/disabled PID (a userspace memory context ID) filtering in an NPU
per a GPU; this was a requirement for P9 DD1.0. However newer chip
revision added a PID wildcard support so there is no more need to
call OPAL every time a new context is initialized. Also, since the PID
wildcard support was added, skiboot does not clear wildcard entries
in the NPU so these remain in the hardware till the system reboot.

This moves LPID and wildcard programming to the PE setup code which
executes once during the booting process so NPU2 context init/destroy
won't need to do additional configuration.

This replaces the check for FW_FEATURE_OPAL with a check for npu!=NULL as
this is the way to tell if the NPU support is present and configured.

This moves pnv_npu2_init() declaration as pseries should be able to use it.
This keeps pnv_npu2_map_lpar() in powernv as pseries is not allowed to
call that. This exports pnv_npu2_map_lpar_dev() as following patches
will use it from the VFIO driver.

While at it, replace redundant list_for_each_entry_safe() with
a simpler list_for_each_entry().

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v5:
* add few checks for npu!=NULL

v4:
* add flags check in pnv_npu2_init_context()
---
 arch/powerpc/include/asm/pci.h            |   3 +
 arch/powerpc/platforms/powernv/pci.h      |   2 +-
 arch/powerpc/platforms/powernv/npu-dma.c  | 111 ++++++++++++----------
 arch/powerpc/platforms/powernv/pci-ioda.c |  15 ++-
 4 files changed, 77 insertions(+), 54 deletions(-)

diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index 2af9ded..baf2886 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -129,5 +129,8 @@ extern void pcibios_scan_phb(struct pci_controller *hose);
 
 extern struct pci_dev *pnv_pci_get_gpu_dev(struct pci_dev *npdev);
 extern struct pci_dev *pnv_pci_get_npu_dev(struct pci_dev *gpdev, int index);
+extern int pnv_npu2_init(struct pci_controller *hose);
+extern int pnv_npu2_map_lpar_dev(struct pci_dev *gpdev, unsigned int lparid,
+		unsigned long msr);
 
 #endif /* __ASM_POWERPC_PCI_H */
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index f2d50974..ddb4f02 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -190,6 +190,7 @@ extern void pnv_pci_init_ioda_hub(struct device_node *np);
 extern void pnv_pci_init_ioda2_phb(struct device_node *np);
 extern void pnv_pci_init_npu_phb(struct device_node *np);
 extern void pnv_pci_init_npu2_opencapi_phb(struct device_node *np);
+extern void pnv_npu2_map_lpar(struct pnv_ioda_pe *gpe, unsigned long msr);
 extern void pnv_pci_reset_secondary_bus(struct pci_dev *dev);
 extern int pnv_eeh_phb_reset(struct pci_controller *hose, int option);
 
@@ -220,7 +221,6 @@ extern long pnv_npu_set_window(struct pnv_ioda_pe *npe, int num,
 extern long pnv_npu_unset_window(struct pnv_ioda_pe *npe, int num);
 extern void pnv_npu_take_ownership(struct pnv_ioda_pe *npe);
 extern void pnv_npu_release_ownership(struct pnv_ioda_pe *npe);
-extern int pnv_npu2_init(struct pnv_phb *phb);
 
 /* pci-ioda-tce.c */
 #define POWERNV_IOMMU_DEFAULT_LEVELS	1
diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 5e66439..ef1457f 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -512,6 +512,9 @@ static void acquire_atsd_reg(struct npu_context *npu_context,
 				continue;
 
 			npu = pci_bus_to_host(npdev->bus)->npu;
+			if (!npu)
+				continue;
+
 			mmio_atsd_reg[i].npu = npu;
 			mmio_atsd_reg[i].reg = get_mmio_atsd_reg(npu);
 			while (mmio_atsd_reg[i].reg < 0) {
@@ -676,7 +679,6 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
 	u32 nvlink_index;
 	struct device_node *nvlink_dn;
 	struct mm_struct *mm = current->mm;
-	struct pnv_phb *nphb;
 	struct npu *npu;
 	struct npu_context *npu_context;
 	struct pci_controller *hose;
@@ -687,13 +689,14 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
 	 */
 	struct pci_dev *npdev = pnv_pci_get_npu_dev(gpdev, 0);
 
-	if (!firmware_has_feature(FW_FEATURE_OPAL))
-		return ERR_PTR(-ENODEV);
-
 	if (!npdev)
 		/* No nvlink associated with this GPU device */
 		return ERR_PTR(-ENODEV);
 
+	/* We only support DR/PR/HV in pnv_npu2_map_lpar_dev() */
+	if (flags & ~(MSR_DR | MSR_PR | MSR_HV))
+		return ERR_PTR(-EINVAL);
+
 	nvlink_dn = of_parse_phandle(npdev->dev.of_node, "ibm,nvlink", 0);
 	if (WARN_ON(of_property_read_u32(nvlink_dn, "ibm,npu-link-index",
 							&nvlink_index)))
@@ -708,20 +711,9 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
 	}
 
 	hose = pci_bus_to_host(npdev->bus);
-	nphb = hose->private_data;
 	npu = hose->npu;
-
-	/*
-	 * Setup the NPU context table for a particular GPU. These need to be
-	 * per-GPU as we need the tables to filter ATSDs when there are no
-	 * active contexts on a particular GPU. It is safe for these to be
-	 * called concurrently with destroy as the OPAL call takes appropriate
-	 * locks and refcounts on init/destroy.
-	 */
-	rc = opal_npu_init_context(nphb->opal_id, mm->context.id, flags,
-				PCI_DEVID(gpdev->bus->number, gpdev->devfn));
-	if (rc < 0)
-		return ERR_PTR(-ENOSPC);
+	if (!npu)
+		return ERR_PTR(-ENODEV);
 
 	/*
 	 * We store the npu pci device so we can more easily get at the
@@ -733,9 +725,6 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
 		if (npu_context->release_cb != cb ||
 			npu_context->priv != priv) {
 			spin_unlock(&npu_context_lock);
-			opal_npu_destroy_context(nphb->opal_id, mm->context.id,
-						PCI_DEVID(gpdev->bus->number,
-							gpdev->devfn));
 			return ERR_PTR(-EINVAL);
 		}
 
@@ -761,9 +750,6 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
 
 		if (rc) {
 			kfree(npu_context);
-			opal_npu_destroy_context(nphb->opal_id, mm->context.id,
-					PCI_DEVID(gpdev->bus->number,
-						gpdev->devfn));
 			return ERR_PTR(rc);
 		}
 
@@ -816,7 +802,6 @@ void pnv_npu2_destroy_context(struct npu_context *npu_context,
 			struct pci_dev *gpdev)
 {
 	int removed;
-	struct pnv_phb *nphb;
 	struct npu *npu;
 	struct pci_dev *npdev = pnv_pci_get_npu_dev(gpdev, 0);
 	struct device_node *nvlink_dn;
@@ -826,19 +811,15 @@ void pnv_npu2_destroy_context(struct npu_context *npu_context,
 	if (WARN_ON(!npdev))
 		return;
 
-	if (!firmware_has_feature(FW_FEATURE_OPAL))
-		return;
-
 	hose = pci_bus_to_host(npdev->bus);
-	nphb = hose->private_data;
 	npu = hose->npu;
+	if (!npu)
+		return;
 	nvlink_dn = of_parse_phandle(npdev->dev.of_node, "ibm,nvlink", 0);
 	if (WARN_ON(of_property_read_u32(nvlink_dn, "ibm,npu-link-index",
 							&nvlink_index)))
 		return;
 	WRITE_ONCE(npu_context->npdev[npu->index][nvlink_index], NULL);
-	opal_npu_destroy_context(nphb->opal_id, npu_context->mm->context.id,
-				PCI_DEVID(gpdev->bus->number, gpdev->devfn));
 	spin_lock(&npu_context_lock);
 	removed = kref_put(&npu_context->kref, pnv_npu2_release_context);
 	spin_unlock(&npu_context_lock);
@@ -870,9 +851,6 @@ int pnv_npu2_handle_fault(struct npu_context *context, uintptr_t *ea,
 	/* mmap_sem should be held so the struct_mm must be present */
 	struct mm_struct *mm = context->mm;
 
-	if (!firmware_has_feature(FW_FEATURE_OPAL))
-		return -ENODEV;
-
 	WARN_ON(!rwsem_is_locked(&mm->mmap_sem));
 
 	for (i = 0; i < count; i++) {
@@ -901,15 +879,11 @@ int pnv_npu2_handle_fault(struct npu_context *context, uintptr_t *ea,
 }
 EXPORT_SYMBOL(pnv_npu2_handle_fault);
 
-int pnv_npu2_init(struct pnv_phb *phb)
+int pnv_npu2_init(struct pci_controller *hose)
 {
 	unsigned int i;
 	u64 mmio_atsd;
-	struct device_node *dn;
-	struct pci_dev *gpdev;
 	static int npu_index;
-	uint64_t rc = 0;
-	struct pci_controller *hose = phb->hose;
 	struct npu *npu;
 	int ret;
 
@@ -918,18 +892,6 @@ int pnv_npu2_init(struct pnv_phb *phb)
 		return -ENOMEM;
 
 	npu->nmmu_flush = of_property_read_bool(hose->dn, "ibm,nmmu-flush");
-	for_each_child_of_node(phb->hose->dn, dn) {
-		gpdev = pnv_pci_get_gpu_dev(get_pci_dev(dn));
-		if (gpdev) {
-			rc = opal_npu_map_lpar(phb->opal_id,
-				PCI_DEVID(gpdev->bus->number, gpdev->devfn),
-				0, 0);
-			if (rc)
-				dev_err(&gpdev->dev,
-					"Error %lld mapping device to LPAR\n",
-					rc);
-		}
-	}
 
 	for (i = 0; !of_property_read_u64_index(hose->dn, "ibm,mmio-atsd",
 							i, &mmio_atsd); i++)
@@ -957,3 +919,52 @@ int pnv_npu2_init(struct pnv_phb *phb)
 
 	return ret;
 }
+
+int pnv_npu2_map_lpar_dev(struct pci_dev *gpdev, unsigned int lparid,
+		unsigned long msr)
+{
+	int ret;
+	struct pci_dev *npdev = pnv_pci_get_npu_dev(gpdev, 0);
+	struct pci_controller *hose;
+	struct pnv_phb *nphb;
+
+	if (!npdev)
+		return -ENODEV;
+
+	hose = pci_bus_to_host(npdev->bus);
+	nphb = hose->private_data;
+
+	dev_dbg(&gpdev->dev, "Map LPAR opalid=%llu lparid=%u\n",
+			nphb->opal_id, lparid);
+	/*
+	 * Currently we only support radix and non-zero LPCR only makes sense
+	 * for hash tables so skiboot expects the LPCR parameter to be a zero.
+	 */
+	ret = opal_npu_map_lpar(nphb->opal_id,
+			PCI_DEVID(gpdev->bus->number, gpdev->devfn), lparid,
+			0 /* LPCR bits */);
+	if (ret) {
+		dev_err(&gpdev->dev, "Error %d mapping device to LPAR\n", ret);
+		return ret;
+	}
+
+	dev_dbg(&gpdev->dev, "init context opalid=%llu msr=%lx\n",
+			nphb->opal_id, msr);
+	ret = opal_npu_init_context(nphb->opal_id, 0/*__unused*/, msr,
+			PCI_DEVID(gpdev->bus->number, gpdev->devfn));
+	if (ret < 0)
+		dev_err(&gpdev->dev, "Failed to init context: %d\n", ret);
+	else
+		ret = 0;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pnv_npu2_map_lpar_dev);
+
+void pnv_npu2_map_lpar(struct pnv_ioda_pe *gpe, unsigned long msr)
+{
+	struct pci_dev *gpdev;
+
+	list_for_each_entry(gpdev, &gpe->pbus->devices, bus_list)
+		pnv_npu2_map_lpar_dev(gpdev, 0, msr);
+}
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 8528fb9..ec4ce35 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1271,19 +1271,20 @@ static void pnv_ioda_setup_npu_PEs(struct pci_bus *bus)
 
 static void pnv_pci_ioda_setup_PEs(void)
 {
-	struct pci_controller *hose, *tmp;
+	struct pci_controller *hose;
 	struct pnv_phb *phb;
 	struct pci_bus *bus;
 	struct pci_dev *pdev;
+	struct pnv_ioda_pe *pe;
 
-	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
+	list_for_each_entry(hose, &hose_list, list_node) {
 		phb = hose->private_data;
 		if (phb->type == PNV_PHB_NPU_NVLINK) {
 			/* PE#0 is needed for error reporting */
 			pnv_ioda_reserve_pe(phb, 0);
 			pnv_ioda_setup_npu_PEs(hose->bus);
 			if (phb->model == PNV_PHB_MODEL_NPU2)
-				WARN_ON_ONCE(pnv_npu2_init(phb));
+				WARN_ON_ONCE(pnv_npu2_init(hose));
 		}
 		if (phb->type == PNV_PHB_NPU_OCAPI) {
 			bus = hose->bus;
@@ -1291,6 +1292,14 @@ static void pnv_pci_ioda_setup_PEs(void)
 				pnv_ioda_setup_dev_PE(pdev);
 		}
 	}
+	list_for_each_entry(hose, &hose_list, list_node) {
+		phb = hose->private_data;
+		if (phb->type != PNV_PHB_IODA2)
+			continue;
+
+		list_for_each_entry(pe, &phb->ioda.pe_list, list)
+			pnv_npu2_map_lpar(pe, MSR_DR | MSR_PR | MSR_HV);
+	}
 }
 
 #ifdef CONFIG_PCI_IOV
-- 
2.17.1


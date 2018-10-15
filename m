Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF8EC7112B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 09:49:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 469902064A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 09:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 469902064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YYZS2gH9zF3NY
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 20:49:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 42YYCt1BWGzDr1F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 20:33:46 +1100 (AEDT)
Received: from vpl1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 865B9AE807F1;
 Mon, 15 Oct 2018 05:33:12 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel 4/5] powerpc/powernv/npu: Factor out OPAL calls from
 context manipulation
Date: Mon, 15 Oct 2018 20:33:00 +1100
Message-Id: <20181015093301.1007-5-aik@ozlabs.ru>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181015093301.1007-1-aik@ozlabs.ru>
References: <20181015093301.1007-1-aik@ozlabs.ru>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm-ppc@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

At the moment the NPU context init/destroy code calls OPAL. The init
handler in OPAL configures the NPU to pass ATS requests to nested MMU,
the destroy handler does nothing besides sanity checks.

Since the init handler programs the NPU with a wildcard for LPID/PID,
this can be done at the point where a GPU is mapped to an LPAR; it also
makes calling opal_npu_destroy_context() unnecessary in this context
(this will change with VFIO later though).

Also, the pnv_npu2_init() helper does not really need to call OPAL as
well as it inialized an NPU structure and does not interact with GPU or
NPU at that moment.

This moves OPAL calls to a separate helper. With this change, the API
for GPUs does not do any OPAL calls and therefore can be used by both
pseries and powernv platforms. The new pnv_npu2_map_lpar_phb() helper
should be called on powernv only as it does OPAL calls and it takes
an MSR mask which NPU adds to ATS requests so nested MMU knows what
translations are permitted; the VFIO/KVM will not set MSR_HV.

This removes the check for FW_FEATURE_OPAL as pnv_npu2_init_context/
pnv_npu2_release_context/pnv_npu2_init do not call OPAL anymore.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/pci.h            |   1 +
 arch/powerpc/platforms/powernv/pci.h      |   2 +-
 arch/powerpc/platforms/powernv/npu-dma.c  | 100 +++++++++++++++---------------
 arch/powerpc/platforms/powernv/pci-ioda.c |   7 ++-
 4 files changed, 57 insertions(+), 53 deletions(-)

diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index 1a96075..f196df6 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -130,5 +130,6 @@ extern void pcibios_scan_phb(struct pci_controller *hose);
 extern struct pci_dev *pnv_pci_get_gpu_dev(struct pci_dev *npdev);
 extern struct pci_dev *pnv_pci_get_npu_dev(struct pci_dev *gpdev, int index);
 extern void pnv_npu2_devices_init(void);
+extern int pnv_npu2_init(struct pci_controller *hose);
 
 #endif /* __ASM_POWERPC_PCI_H */
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 3b7617d..ca2ce4b 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -224,7 +224,7 @@ extern long pnv_npu_set_window(struct pnv_ioda_pe *npe, int num,
 extern long pnv_npu_unset_window(struct pnv_ioda_pe *npe, int num);
 extern void pnv_npu_take_ownership(struct pnv_ioda_pe *npe);
 extern void pnv_npu_release_ownership(struct pnv_ioda_pe *npe);
-extern int pnv_npu2_init(struct pnv_phb *phb);
+extern void pnv_npu2_map_lpar_phb(struct pnv_phb *nphb, unsigned long msr);
 
 /* pci-ioda-tce.c */
 #define POWERNV_IOMMU_DEFAULT_LEVELS	1
diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index cb2b4f9..677f30a 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -762,7 +762,6 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
 	u32 nvlink_index;
 	struct device_node *nvlink_dn;
 	struct mm_struct *mm = current->mm;
-	struct pnv_phb *nphb;
 	struct npu *npu;
 	struct npu_context *npu_context;
 
@@ -772,9 +771,6 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
 	 */
 	struct pci_dev *npdev = pnv_pci_get_npu_dev(gpdev, 0);
 
-	if (!firmware_has_feature(FW_FEATURE_OPAL))
-		return ERR_PTR(-ENODEV);
-
 	if (!npdev)
 		/* No nvlink associated with this GPU device */
 		return ERR_PTR(-ENODEV);
@@ -792,22 +788,9 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
 		return ERR_PTR(-EINVAL);
 	}
 
-	nphb = pci_bus_to_host(npdev->bus)->private_data;
 	npu = npdev_to_npu(npdev);
 
 	/*
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
-
-	/*
 	 * We store the npu pci device so we can more easily get at the
 	 * associated npus.
 	 */
@@ -817,9 +800,6 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
 		if (npu_context->release_cb != cb ||
 			npu_context->priv != priv) {
 			spin_unlock(&npu2_devices.context_lock);
-			opal_npu_destroy_context(nphb->opal_id, mm->context.id,
-						PCI_DEVID(gpdev->bus->number,
-							gpdev->devfn));
 			return ERR_PTR(-EINVAL);
 		}
 
@@ -845,9 +825,6 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
 
 		if (rc) {
 			kfree(npu_context);
-			opal_npu_destroy_context(nphb->opal_id, mm->context.id,
-					PCI_DEVID(gpdev->bus->number,
-						gpdev->devfn));
 			return ERR_PTR(rc);
 		}
 
@@ -900,7 +877,6 @@ void pnv_npu2_destroy_context(struct npu_context *npu_context,
 			struct pci_dev *gpdev)
 {
 	int removed;
-	struct pnv_phb *nphb;
 	struct npu *npu;
 	struct pci_dev *npdev = pnv_pci_get_npu_dev(gpdev, 0);
 	struct device_node *nvlink_dn;
@@ -909,18 +885,12 @@ void pnv_npu2_destroy_context(struct npu_context *npu_context,
 	if (WARN_ON(!npdev))
 		return;
 
-	if (!firmware_has_feature(FW_FEATURE_OPAL))
-		return;
-
-	nphb = pci_bus_to_host(npdev->bus)->private_data;
 	npu = npdev_to_npu(npdev);
 	nvlink_dn = of_parse_phandle(npdev->dev.of_node, "ibm,nvlink", 0);
 	if (WARN_ON(of_property_read_u32(nvlink_dn, "ibm,npu-link-index",
 							&nvlink_index)))
 		return;
 	WRITE_ONCE(npu_context->npdev[npu->index][nvlink_index], NULL);
-	opal_npu_destroy_context(nphb->opal_id, npu_context->mm->context.id,
-				PCI_DEVID(gpdev->bus->number, gpdev->devfn));
 	spin_lock(&npu2_devices.context_lock);
 	removed = kref_put(&npu_context->kref, pnv_npu2_release_context);
 	spin_unlock(&npu2_devices.context_lock);
@@ -952,9 +922,6 @@ int pnv_npu2_handle_fault(struct npu_context *context, uintptr_t *ea,
 	/* mmap_sem should be held so the struct_mm must be present */
 	struct mm_struct *mm = context->mm;
 
-	if (!firmware_has_feature(FW_FEATURE_OPAL))
-		return -ENODEV;
-
 	WARN_ON(!rwsem_is_locked(&mm->mmap_sem));
 
 	for (i = 0; i < count; i++) {
@@ -983,15 +950,11 @@ int pnv_npu2_handle_fault(struct npu_context *context, uintptr_t *ea,
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
 
@@ -1006,18 +969,6 @@ int pnv_npu2_init(struct pnv_phb *phb)
 	}
 
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
@@ -1047,3 +998,52 @@ int pnv_npu2_init(struct pnv_phb *phb)
 
 	return ret;
 }
+
+void pnv_npu2_map_lpar_phb(struct pnv_phb *nphb, unsigned long msr)
+{
+	struct pci_dev *gpdev;
+	struct device_node *dn;
+	int ret;
+	struct pci_controller *hose = nphb->hose;
+
+	for_each_child_of_node(hose->dn, dn) {
+		gpdev = pnv_pci_get_gpu_dev(get_pci_dev(dn));
+		if (!gpdev)
+			continue;
+
+		dev_dbg(&gpdev->dev, "Map LPAR opalid=%llu\n", nphb->opal_id);
+		ret = opal_npu_map_lpar(nphb->opal_id,
+				PCI_DEVID(gpdev->bus->number, gpdev->devfn),
+				0, 0);
+		if (!ret)
+			continue;
+		dev_err(&gpdev->dev, "Error %d mapping device to LPAR\n", ret);
+	}
+
+	/*
+	 * It seems that touching NPU2_XTS_BDF_MAP in the way
+	 * the opal_npu_map_lpar() does somehow affects the result of
+	 * what opal_npu_init_context() does so let's put the latter in
+	 * a separate loop.
+	 */
+	for_each_child_of_node(hose->dn, dn) {
+		gpdev = pnv_pci_get_gpu_dev(get_pci_dev(dn));
+		if (!gpdev)
+			continue;
+
+		/*
+		 * Setup the NPU context table for a particular GPU. These need
+		 * to be per-GPU as we need the tables to filter ATSDs when
+		 * there are no active contexts on a particular GPU. It is safe
+		 * for these to be called concurrently with destroy as the OPAL
+		 * call takes appropriate locks and refcounts on init/destroy.
+		 */
+		dev_dbg(&gpdev->dev, "init context opalid=%llu\n",
+				nphb->opal_id);
+		ret = opal_npu_init_context(nphb->opal_id, 0/*__unused*/, msr,
+				PCI_DEVID(gpdev->bus->number, gpdev->devfn));
+		if (!ret)
+			continue;
+		dev_err(&gpdev->dev, "Failed to init context: %d\n", ret);
+	}
+}
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 0cc81c0..56a1398 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1287,8 +1287,11 @@ static void pnv_pci_ioda_setup_PEs(void)
 			/* PE#0 is needed for error reporting */
 			pnv_ioda_reserve_pe(phb, 0);
 			pnv_ioda_setup_npu_PEs(hose->bus);
-			if (phb->model == PNV_PHB_MODEL_NPU2)
-				pnv_npu2_init(phb);
+			if (phb->model == PNV_PHB_MODEL_NPU2) {
+				pnv_npu2_init(hose);
+				pnv_npu2_map_lpar_phb(phb,
+						MSR_DR | MSR_PR | MSR_HV);
+			}
 		}
 		if (phb->type == PNV_PHB_NPU_OCAPI) {
 			bus = hose->bus;
-- 
2.11.0


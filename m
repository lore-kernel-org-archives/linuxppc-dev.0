Return-Path: <SRS0=INWp=NY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284D7C43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 08:52:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A080C223D0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 08:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A080C223D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42vLwl255KzF3Wg
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 19:52:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 42vLQF1YXLzF3FW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2018 19:29:25 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 789D8AE8011E;
 Tue, 13 Nov 2018 03:28:51 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v3 07/22] powerpc/powernv/npu: Move OPAL calls away
 from context manipulation
Date: Tue, 13 Nov 2018 19:28:08 +1100
Message-Id: <20181113082823.2440-8-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113082823.2440-1-aik@ozlabs.ru>
References: <20181113082823.2440-1-aik@ozlabs.ru>
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
Cc: Jose Ricardo Ziviani <joserz@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Alistair Popple <alistair@popple.id.au>,
 Alex Williamson <alex.williamson@redhat.com>, kvm-ppc@vger.kernel.org,
 Sam Bobroff <sbobroff@linux.ibm.com>,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
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

This removes the check for FW_FEATURE_OPAL as pnv_npu2_init_context/
pnv_npu2_release_context/pnv_npu2_init do not call OPAL anymore.

This moves pnv_npu2_init() declaration as pseries should be able to use it.
This keeps pnv_npu2_map_lpar() in powernv as pseries is not allowed to
call that. This exports pnv_npu2_map_lpar_dev() as following patches
will use it from the VFIO driver.

While at it, replace redundant list_for_each_entry_safe() with
a simpler list_for_each_entry().

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/pci.h            |   3 +
 arch/powerpc/platforms/powernv/pci.h      |   2 +-
 arch/powerpc/platforms/powernv/npu-dma.c  | 105 +++++++++++-----------
 arch/powerpc/platforms/powernv/pci-ioda.c |  15 +++-
 4 files changed, 71 insertions(+), 54 deletions(-)

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
index 9fc4e4e..4b60f43 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -698,7 +698,6 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
 	u32 nvlink_index;
 	struct device_node *nvlink_dn;
 	struct mm_struct *mm = current->mm;
-	struct pnv_phb *nphb;
 	struct npu *npu;
 	struct npu_context *npu_context;
 
@@ -708,9 +707,6 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
 	 */
 	struct pci_dev *npdev = pnv_pci_get_npu_dev(gpdev, 0);
 
-	if (!firmware_has_feature(FW_FEATURE_OPAL))
-		return ERR_PTR(-ENODEV);
-
 	if (!npdev)
 		/* No nvlink associated with this GPU device */
 		return ERR_PTR(-ENODEV);
@@ -728,23 +724,10 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
 		return ERR_PTR(-EINVAL);
 	}
 
-	nphb = pci_bus_to_host(npdev->bus)->private_data;
 	npu = npdev_to_npu(npdev);
 	if (!npu)
 		return ERR_PTR(-ENODEV);
 
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
-
 	/*
 	 * We store the npu pci device so we can more easily get at the
 	 * associated npus.
@@ -755,9 +738,6 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
 		if (npu_context->release_cb != cb ||
 			npu_context->priv != priv) {
 			spin_unlock(&npu_context_lock);
-			opal_npu_destroy_context(nphb->opal_id, mm->context.id,
-						PCI_DEVID(gpdev->bus->number,
-							gpdev->devfn));
 			return ERR_PTR(-EINVAL);
 		}
 
@@ -783,9 +763,6 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
 
 		if (rc) {
 			kfree(npu_context);
-			opal_npu_destroy_context(nphb->opal_id, mm->context.id,
-					PCI_DEVID(gpdev->bus->number,
-						gpdev->devfn));
 			return ERR_PTR(rc);
 		}
 
@@ -838,7 +815,6 @@ void pnv_npu2_destroy_context(struct npu_context *npu_context,
 			struct pci_dev *gpdev)
 {
 	int removed;
-	struct pnv_phb *nphb;
 	struct npu *npu;
 	struct pci_dev *npdev = pnv_pci_get_npu_dev(gpdev, 0);
 	struct device_node *nvlink_dn;
@@ -847,10 +823,6 @@ void pnv_npu2_destroy_context(struct npu_context *npu_context,
 	if (WARN_ON(!npdev))
 		return;
 
-	if (!firmware_has_feature(FW_FEATURE_OPAL))
-		return;
-
-	nphb = pci_bus_to_host(npdev->bus)->private_data;
 	npu = npdev_to_npu(npdev);
 	if (!npu)
 		return;
@@ -859,8 +831,6 @@ void pnv_npu2_destroy_context(struct npu_context *npu_context,
 							&nvlink_index)))
 		return;
 	WRITE_ONCE(npu_context->npdev[npu->index][nvlink_index], NULL);
-	opal_npu_destroy_context(nphb->opal_id, npu_context->mm->context.id,
-				PCI_DEVID(gpdev->bus->number, gpdev->devfn));
 	spin_lock(&npu_context_lock);
 	removed = kref_put(&npu_context->kref, pnv_npu2_release_context);
 	spin_unlock(&npu_context_lock);
@@ -892,9 +862,6 @@ int pnv_npu2_handle_fault(struct npu_context *context, uintptr_t *ea,
 	/* mmap_sem should be held so the struct_mm must be present */
 	struct mm_struct *mm = context->mm;
 
-	if (!firmware_has_feature(FW_FEATURE_OPAL))
-		return -ENODEV;
-
 	WARN_ON(!rwsem_is_locked(&mm->mmap_sem));
 
 	for (i = 0; i < count; i++) {
@@ -923,15 +890,11 @@ int pnv_npu2_handle_fault(struct npu_context *context, uintptr_t *ea,
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
 
@@ -940,18 +903,6 @@ int pnv_npu2_init(struct pnv_phb *phb)
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
@@ -981,3 +932,57 @@ int pnv_npu2_init(struct pnv_phb *phb)
 
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
+	int ret;
+	struct pci_dev *gpdev;
+
+	list_for_each_entry(gpdev, &gpe->pbus->devices, bus_list) {
+		ret = pnv_npu2_map_lpar_dev(gpdev, 0, msr);
+		if (ret < 0)
+			dev_err(&gpdev->dev, "Failed to init context: %d\n",
+					ret);
+	}
+}
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index c78c204..ec235ca 100644
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
-				pnv_npu2_init(phb);
+				pnv_npu2_init(hose);
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


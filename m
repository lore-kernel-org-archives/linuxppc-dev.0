Return-Path: <SRS0=n2Bs=OC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6593CC43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 06:13:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7A59206B2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 06:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A59206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 431QwC3XcgzDqV3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 17:12:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 431QVH1V5kzDqT6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2018 16:53:59 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id AD57DAE80218;
 Fri, 23 Nov 2018 00:53:24 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v4 04/19] powerpc/powernv: Move npu struct from pnv_phb
 to pci_controller
Date: Fri, 23 Nov 2018 16:52:49 +1100
Message-Id: <20181123055304.25116-5-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181123055304.25116-1-aik@ozlabs.ru>
References: <20181123055304.25116-1-aik@ozlabs.ru>
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
 Daniel Henrique Barboza <danielhb413@gmail.com>,
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

The powernv PCI code stores NPU data in the pnv_phb struct. The latter
is referenced by pci_controller::private_data. We are going to have NPU2
support in the pseries platform as well but it does not store any
private_data in in the pci_controller struct; and even if it did,
it would be a different data structure.

This makes npu a pointer and stores it one level higher in
the pci_controller struct.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v4:
* changed subj from "powerpc/powernv: Detach npu struct from pnv_phb"
* got rid of global list of npus - store them now in pci_controller
* got rid of npdev_to_npu() helper
---
 arch/powerpc/include/asm/pci-bridge.h    |  1 +
 arch/powerpc/platforms/powernv/pci.h     | 16 -----
 arch/powerpc/platforms/powernv/npu-dma.c | 81 ++++++++++++++++++------
 3 files changed, 64 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 94d4490..aee4fcc 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -129,6 +129,7 @@ struct pci_controller {
 #endif	/* CONFIG_PPC64 */
 
 	void *private_data;
+	struct npu *npu;
 };
 
 /* These are used for config access before all the PCI probing
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 2131373..f2d50974 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -8,9 +8,6 @@
 
 struct pci_dn;
 
-/* Maximum possible number of ATSD MMIO registers per NPU */
-#define NV_NMMU_ATSD_REGS 8
-
 enum pnv_phb_type {
 	PNV_PHB_IODA1		= 0,
 	PNV_PHB_IODA2		= 1,
@@ -176,19 +173,6 @@ struct pnv_phb {
 	unsigned int		diag_data_size;
 	u8			*diag_data;
 
-	/* Nvlink2 data */
-	struct npu {
-		int index;
-		__be64 *mmio_atsd_regs[NV_NMMU_ATSD_REGS];
-		unsigned int mmio_atsd_count;
-
-		/* Bitmask for MMIO register usage */
-		unsigned long mmio_atsd_usage;
-
-		/* Do we need to explicitly flush the nest mmu? */
-		bool nmmu_flush;
-	} npu;
-
 	int p2p_target_count;
 };
 
diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 91d488f..7dd5c0e5 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -327,6 +327,25 @@ struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe)
 	return gpe;
 }
 
+/*
+ * NPU2 ATS
+ */
+/* Maximum possible number of ATSD MMIO registers per NPU */
+#define NV_NMMU_ATSD_REGS 8
+
+/* An NPU descriptor, valid for POWER9 only */
+struct npu {
+	int index;
+	__be64 *mmio_atsd_regs[NV_NMMU_ATSD_REGS];
+	unsigned int mmio_atsd_count;
+
+	/* Bitmask for MMIO register usage */
+	unsigned long mmio_atsd_usage;
+
+	/* Do we need to explicitly flush the nest mmu? */
+	bool nmmu_flush;
+};
+
 /* Maximum number of nvlinks per npu */
 #define NV_MAX_LINKS 6
 
@@ -478,7 +497,6 @@ static void acquire_atsd_reg(struct npu_context *npu_context,
 	int i, j;
 	struct npu *npu;
 	struct pci_dev *npdev;
-	struct pnv_phb *nphb;
 
 	for (i = 0; i <= max_npu2_index; i++) {
 		mmio_atsd_reg[i].reg = -1;
@@ -493,8 +511,10 @@ static void acquire_atsd_reg(struct npu_context *npu_context,
 			if (!npdev)
 				continue;
 
-			nphb = pci_bus_to_host(npdev->bus)->private_data;
-			npu = &nphb->npu;
+			npu = pci_bus_to_host(npdev->bus)->npu;
+			if (!npu)
+				continue;
+
 			mmio_atsd_reg[i].npu = npu;
 			mmio_atsd_reg[i].reg = get_mmio_atsd_reg(npu);
 			while (mmio_atsd_reg[i].reg < 0) {
@@ -662,6 +682,7 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
 	struct pnv_phb *nphb;
 	struct npu *npu;
 	struct npu_context *npu_context;
+	struct pci_controller *hose;
 
 	/*
 	 * At present we don't support GPUs connected to multiple NPUs and I'm
@@ -689,8 +710,11 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
 		return ERR_PTR(-EINVAL);
 	}
 
-	nphb = pci_bus_to_host(npdev->bus)->private_data;
-	npu = &nphb->npu;
+	hose = pci_bus_to_host(npdev->bus);
+	nphb = hose->private_data;
+	npu = hose->npu;
+	if (!npu)
+		return ERR_PTR(-ENODEV);
 
 	/*
 	 * Setup the NPU context table for a particular GPU. These need to be
@@ -764,7 +788,7 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
 	 */
 	WRITE_ONCE(npu_context->npdev[npu->index][nvlink_index], npdev);
 
-	if (!nphb->npu.nmmu_flush) {
+	if (!npu->nmmu_flush) {
 		/*
 		 * If we're not explicitly flushing ourselves we need to mark
 		 * the thread for global flushes
@@ -802,6 +826,7 @@ void pnv_npu2_destroy_context(struct npu_context *npu_context,
 	struct pci_dev *npdev = pnv_pci_get_npu_dev(gpdev, 0);
 	struct device_node *nvlink_dn;
 	u32 nvlink_index;
+	struct pci_controller *hose;
 
 	if (WARN_ON(!npdev))
 		return;
@@ -809,8 +834,11 @@ void pnv_npu2_destroy_context(struct npu_context *npu_context,
 	if (!firmware_has_feature(FW_FEATURE_OPAL))
 		return;
 
-	nphb = pci_bus_to_host(npdev->bus)->private_data;
-	npu = &nphb->npu;
+	hose = pci_bus_to_host(npdev->bus);
+	nphb = hose->private_data;
+	npu = hose->npu;
+	if (!npu)
+		return;
 	nvlink_dn = of_parse_phandle(npdev->dev.of_node, "ibm,nvlink", 0);
 	if (WARN_ON(of_property_read_u32(nvlink_dn, "ibm,npu-link-index",
 							&nvlink_index)))
@@ -888,9 +916,15 @@ int pnv_npu2_init(struct pnv_phb *phb)
 	struct pci_dev *gpdev;
 	static int npu_index;
 	uint64_t rc = 0;
+	struct pci_controller *hose = phb->hose;
+	struct npu *npu;
+	int ret;
 
-	phb->npu.nmmu_flush =
-		of_property_read_bool(phb->hose->dn, "ibm,nmmu-flush");
+	npu = kzalloc(sizeof(*npu), GFP_KERNEL);
+	if (!npu)
+		return -ENOMEM;
+
+	npu->nmmu_flush = of_property_read_bool(hose->dn, "ibm,nmmu-flush");
 	for_each_child_of_node(phb->hose->dn, dn) {
 		gpdev = pnv_pci_get_gpu_dev(get_pci_dev(dn));
 		if (gpdev) {
@@ -904,18 +938,29 @@ int pnv_npu2_init(struct pnv_phb *phb)
 		}
 	}
 
-	for (i = 0; !of_property_read_u64_index(phb->hose->dn, "ibm,mmio-atsd",
+	for (i = 0; !of_property_read_u64_index(hose->dn, "ibm,mmio-atsd",
 							i, &mmio_atsd); i++)
-		phb->npu.mmio_atsd_regs[i] = ioremap(mmio_atsd, 32);
+		npu->mmio_atsd_regs[i] = ioremap(mmio_atsd, 32);
 
-	pr_info("NPU%lld: Found %d MMIO ATSD registers", phb->opal_id, i);
-	phb->npu.mmio_atsd_count = i;
-	phb->npu.mmio_atsd_usage = 0;
+	pr_info("NPU%d: Found %d MMIO ATSD registers", hose->global_number, i);
+	npu->mmio_atsd_count = i;
+	npu->mmio_atsd_usage = 0;
 	npu_index++;
-	if (WARN_ON(npu_index >= NV_MAX_NPUS))
-		return -ENOSPC;
+	if (WARN_ON(npu_index >= NV_MAX_NPUS)) {
+		ret = -ENOSPC;
+		goto fail_exit;
+	}
 	max_npu2_index = npu_index;
-	phb->npu.index = npu_index;
+	npu->index = npu_index;
+	hose->npu = npu;
 
 	return 0;
+
+fail_exit:
+	for (i = 0; i < npu->mmio_atsd_count; ++i)
+		iounmap(npu->mmio_atsd_regs[i]);
+
+	kfree(npu);
+
+	return ret;
 }
-- 
2.17.1


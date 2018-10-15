Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F80CC7112B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 09:48:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F3EF2064A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 09:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F3EF2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YYXP4x93zF3LW
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 20:48:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 42YYCq1MN8zF3Fj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 20:33:43 +1100 (AEDT)
Received: from vpl1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 31491AE807EF;
 Mon, 15 Oct 2018 05:33:09 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel 3/5] powerpc/powernv: Detach npu struct from pnv_phb
Date: Mon, 15 Oct 2018 20:32:59 +1100
Message-Id: <20181015093301.1007-4-aik@ozlabs.ru>
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

The powernv PCI code stores NPU data in the pnv_phb struct. The latter
is referenced by pci_controller::private_data. We are going to have NPU2
support in the pseries platform as well but it does not store any
private_data in in the pci_controller struct; and even if it did,
it would be a different data structure.

This adds a global list of NPUs so each platform can register and use
these in the same fashion.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci.h     | 16 -------
 arch/powerpc/platforms/powernv/npu-dma.c | 71 +++++++++++++++++++++++++-------
 2 files changed, 57 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 8b37b28..3b7617d 100644
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
@@ -180,19 +177,6 @@ struct pnv_phb {
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
index 01402f9..cb2b4f9 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -378,6 +378,25 @@ struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe)
 /*
  * NPU2 ATS
  */
+/* Maximum possible number of ATSD MMIO registers per NPU */
+#define NV_NMMU_ATSD_REGS 8
+
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
+
+	struct list_head next;
+
+	struct pci_controller *hose;
+};
+
 static struct {
 	/*
 	 * spinlock to protect initialisation of an npu_context for
@@ -396,22 +415,27 @@ static struct {
 	uint64_t atsd_threshold;
 	struct dentry *atsd_threshold_dentry;
 
+	struct list_head npu_list;
 } npu2_devices;
 
 void pnv_npu2_devices_init(void)
 {
 	memset(&npu2_devices, 0, sizeof(npu2_devices));
+	INIT_LIST_HEAD(&npu2_devices.npu_list);
 	spin_lock_init(&npu2_devices.context_lock);
 	npu2_devices.atsd_threshold = 2 * 1024 * 1024;
 }
 
 static struct npu *npdev_to_npu(struct pci_dev *npdev)
 {
-	struct pnv_phb *nphb;
+	struct pci_controller *hose = pci_bus_to_host(npdev->bus);
+	struct npu *npu;
 
-	nphb = pci_bus_to_host(npdev->bus)->private_data;
+	list_for_each_entry(npu, &npu2_devices.npu_list, next)
+		if (hose == npu->hose)
+			return npu;
 
-	return &nphb->npu;
+	return NULL;
 }
 
 /* Maximum number of nvlinks per npu */
@@ -843,7 +867,7 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
 	 */
 	WRITE_ONCE(npu_context->npdev[npu->index][nvlink_index], npdev);
 
-	if (!nphb->npu.nmmu_flush) {
+	if (!npu->nmmu_flush) {
 		/*
 		 * If we're not explicitly flushing ourselves we need to mark
 		 * the thread for global flushes
@@ -967,6 +991,13 @@ int pnv_npu2_init(struct pnv_phb *phb)
 	struct pci_dev *gpdev;
 	static int npu_index;
 	uint64_t rc = 0;
+	struct pci_controller *hose = phb->hose;
+	struct npu *npu;
+	int ret;
+
+	npu = kzalloc(sizeof(*npu), GFP_KERNEL);
+	if (!npu)
+		return -ENOMEM;
 
 	if (!npu2_devices.atsd_threshold_dentry) {
 		npu2_devices.atsd_threshold_dentry = debugfs_create_x64(
@@ -974,8 +1005,7 @@ int pnv_npu2_init(struct pnv_phb *phb)
 				&npu2_devices.atsd_threshold);
 	}
 
-	phb->npu.nmmu_flush =
-		of_property_read_bool(phb->hose->dn, "ibm,nmmu-flush");
+	npu->nmmu_flush = of_property_read_bool(hose->dn, "ibm,nmmu-flush");
 	for_each_child_of_node(phb->hose->dn, dn) {
 		gpdev = pnv_pci_get_gpu_dev(get_pci_dev(dn));
 		if (gpdev) {
@@ -989,18 +1019,31 @@ int pnv_npu2_init(struct pnv_phb *phb)
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
 	npu2_devices.max_index = npu_index;
-	phb->npu.index = npu_index;
+	npu->index = npu_index;
+	npu->hose = hose;
+
+	list_add(&npu->next, &npu2_devices.npu_list);
 
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
2.11.0


Return-Path: <SRS0=INWp=NY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8044C43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 08:37:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F0FD2243E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 08:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0FD2243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42vLbC34tvzF3Mq
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 19:37:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 42vLPc3ZqKzF3D5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2018 19:28:52 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id F04E8AE8010F;
 Tue, 13 Nov 2018 03:28:47 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v3 06/22] powerpc/powernv: Detach npu struct from
 pnv_phb
Date: Tue, 13 Nov 2018 19:28:07 +1100
Message-Id: <20181113082823.2440-7-aik@ozlabs.ru>
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

The powernv PCI code stores NPU data in the pnv_phb struct. The latter
is referenced by pci_controller::private_data. We are going to have NPU2
support in the pseries platform as well but it does not store any
private_data in in the pci_controller struct; and even if it did,
it would be a different data structure.

This adds a global list of NPUs so each platform can register and use
these in the same fashion.

As npdev_to_npu() may now fail, this checks the returned pointer.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci.h     | 16 -----
 arch/powerpc/platforms/powernv/npu-dma.c | 78 ++++++++++++++++++++----
 2 files changed, 65 insertions(+), 29 deletions(-)

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
index 9f48831..9fc4e4e 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -330,13 +330,39 @@ struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe)
 /*
  * NPU2 ATS
  */
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
+
+	struct list_head next;
+
+	struct pci_controller *hose;
+};
+
+static LIST_HEAD(npu2_devices);
+
 static struct npu *npdev_to_npu(struct pci_dev *npdev)
 {
-	struct pnv_phb *nphb;
+	struct pci_controller *hose = pci_bus_to_host(npdev->bus);
+	struct npu *npu;
 
-	nphb = pci_bus_to_host(npdev->bus)->private_data;
+	list_for_each_entry(npu, &npu2_devices, next)
+		if (hose == npu->hose)
+			return npu;
 
-	return &nphb->npu;
+	WARN_ON_ONCE(1);
+	return NULL;
 }
 
 /* Maximum number of nvlinks per npu */
@@ -505,6 +531,9 @@ static void acquire_atsd_reg(struct npu_context *npu_context,
 				continue;
 
 			npu = npdev_to_npu(npdev);
+			if (!npu)
+				continue;
+
 			mmio_atsd_reg[i].npu = npu;
 			mmio_atsd_reg[i].reg = get_mmio_atsd_reg(npu);
 			while (mmio_atsd_reg[i].reg < 0) {
@@ -701,6 +730,8 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
 
 	nphb = pci_bus_to_host(npdev->bus)->private_data;
 	npu = npdev_to_npu(npdev);
+	if (!npu)
+		return ERR_PTR(-ENODEV);
 
 	/*
 	 * Setup the NPU context table for a particular GPU. These need to be
@@ -821,6 +852,8 @@ void pnv_npu2_destroy_context(struct npu_context *npu_context,
 
 	nphb = pci_bus_to_host(npdev->bus)->private_data;
 	npu = npdev_to_npu(npdev);
+	if (!npu)
+		return;
 	nvlink_dn = of_parse_phandle(npdev->dev.of_node, "ibm,nvlink", 0);
 	if (WARN_ON(of_property_read_u32(nvlink_dn, "ibm,npu-link-index",
 							&nvlink_index)))
@@ -898,9 +931,15 @@ int pnv_npu2_init(struct pnv_phb *phb)
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
@@ -914,18 +953,31 @@ int pnv_npu2_init(struct pnv_phb *phb)
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
+	npu->hose = hose;
+
+	list_add(&npu->next, &npu2_devices);
 
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


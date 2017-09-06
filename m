Return-Path: <alistair@popple.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xn62N6fRfzDqNY
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Sep 2017 11:49:16 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org
Cc: fbarrat@linux.vnet.ibm.com, arbab@linux.vnet.ibm.com, mpe@ellerman.id.au,
 andrew.donnellan@au1.ibm.com, Alistair Popple <alistair@popple.id.au>
Subject: [PATCH v2 2/2] powerpc/powernv/npu: Don't explicitly flush nmmu tlb
Date: Wed,  6 Sep 2017 11:49:00 +1000
Message-Id: <1504662540-27527-2-git-send-email-alistair@popple.id.au>
In-Reply-To: <1504662540-27527-1-git-send-email-alistair@popple.id.au>
References: <1504662540-27527-1-git-send-email-alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The nest mmu required an explicit flush as a tlbi would not flush it in the
same way as the core. However an alternate firmware fix exists which should
eliminate the need for this flush, so instead add a device-tree property
(ibm,nmmu-flush) on the NVLink2 PHB to enable it only if required.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---

Changes for v2:
 - Use mm_context_add_copro()/mm_context_remove_copro() instead
   of inc_mm_active_cpus()/dec_mm_active_cpus()

 arch/powerpc/platforms/powernv/npu-dma.c | 28 +++++++++++++++++++++++-----
 arch/powerpc/platforms/powernv/pci.h     |  3 +++
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 2fff9a65..f6cbc1a 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -395,6 +395,7 @@ struct npu_context {
 	struct pci_dev *npdev[NV_MAX_NPUS][NV_MAX_LINKS];
 	struct mmu_notifier mn;
 	struct kref kref;
+	bool nmmu_flush;
 
 	/* Callback to stop translation requests on a given GPU */
 	struct npu_context *(*release_cb)(struct npu_context *, void *);
@@ -545,11 +546,13 @@ static void mmio_invalidate(struct npu_context *npu_context, int va,
 	struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS];
 	unsigned long pid = npu_context->mm->context.id;
 
-	/*
-	 * Unfortunately the nest mmu does not support flushing specific
-	 * addresses so we have to flush the whole mm.
-	 */
-	flush_all_mm(npu_context->mm);
+	if (npu_context->nmmu_flush)
+		/*
+		 * Unfortunately the nest mmu does not support flushing specific
+		 * addresses so we have to flush the whole mm once before
+		 * shooting down the GPU translation.
+		 */
+		flush_all_mm(npu_context->mm);
 
 	/*
 	 * Loop over all the NPUs this process is active on and launch
@@ -722,6 +725,16 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
 		return ERR_PTR(-ENODEV);
 	npu_context->npdev[npu->index][nvlink_index] = npdev;
 
+	if (!nphb->npu.nmmu_flush) {
+		/*
+		 * If we're not explicitly flushing ourselves we need to mark
+		 * the thread for global flushes
+		 */
+		npu_context->nmmu_flush = false;
+		mm_context_add_copro(mm);
+	} else
+		npu_context->nmmu_flush = true;
+
 	return npu_context;
 }
 EXPORT_SYMBOL(pnv_npu2_init_context);
@@ -731,6 +744,9 @@ static void pnv_npu2_release_context(struct kref *kref)
 	struct npu_context *npu_context =
 		container_of(kref, struct npu_context, kref);
 
+	if (!npu_context->nmmu_flush)
+		mm_context_remove_copro(npu_context->mm);
+
 	npu_context->mm->context.npu_context = NULL;
 	mmu_notifier_unregister(&npu_context->mn,
 				npu_context->mm);
@@ -819,6 +835,8 @@ int pnv_npu2_init(struct pnv_phb *phb)
 	static int npu_index;
 	uint64_t rc = 0;
 
+	phb->npu.nmmu_flush =
+		of_property_read_bool(phb->hose->dn, "ibm,nmmu-flush");
 	for_each_child_of_node(phb->hose->dn, dn) {
 		gpdev = pnv_pci_get_gpu_dev(get_pci_dev(dn));
 		if (gpdev) {
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index a95273c..22025c6 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -187,6 +187,9 @@ struct pnv_phb {
 
 		/* Bitmask for MMIO register usage */
 		unsigned long mmio_atsd_usage;
+
+		/* Do we need to explicitly flush the nest mmu? */
+		bool nmmu_flush;
 	} npu;
 
 #ifdef CONFIG_CXL_BASE
-- 
2.1.4

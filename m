Return-Path: <alistair@popple.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTFM03G4GzDr44
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 16:23:40 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: mpe@ellerman.id.au
Cc: arbab@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org, sbaskaran@nvidia.com,
 fbarrat@linux.vnet.ibm.com, Alistair Popple <alistair@popple.id.au>
Subject: [PATCH 2/2] powerpc/powernv/npu: Don't explicitly flush nmmu tlb
Date: Fri, 11 Aug 2017 16:22:57 +1000
Message-Id: <1502432577-5911-2-git-send-email-alistair@popple.id.au>
In-Reply-To: <1502432577-5911-1-git-send-email-alistair@popple.id.au>
References: <1502432577-5911-1-git-send-email-alistair@popple.id.au>
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

Michael,

This patch depends on http://patchwork.ozlabs.org/patch/796775/ - [v3,1/3]
powerpc/mm: Add marker for contexts requiring global TLB invalidations.

- Alistair

 arch/powerpc/platforms/powernv/npu-dma.c | 27 +++++++++++++++++++++------
 arch/powerpc/platforms/powernv/pci.h     |  3 +++
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 3d4f879..ac07800 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -544,12 +544,7 @@ static void mmio_invalidate(struct npu_context *npu_context, int va,
 	struct pci_dev *npdev;
 	struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS];
 	unsigned long pid = npu_context->mm->context.id;
-
-	/*
-	 * Unfortunately the nest mmu does not support flushing specific
-	 * addresses so we have to flush the whole mm.
-	 */
-	flush_tlb_mm(npu_context->mm);
+	bool nmmu_flushed = false;
 
 	/*
 	 * Loop over all the NPUs this process is active on and launch
@@ -566,6 +561,17 @@ static void mmio_invalidate(struct npu_context *npu_context, int va,
 			npu = &nphb->npu;
 			mmio_atsd_reg[i].npu = npu;
 
+			if (nphb->npu.nmmu_flush && !nmmu_flushed) {
+				/*
+				 * Unfortunately the nest mmu does not support
+				 * flushing specific addresses so we have to
+				 * flush the whole mm once before shooting down
+				 * the GPU translation.
+				 */
+				flush_tlb_mm(npu_context->mm);
+				nmmu_flushed = true;
+			}
+
 			if (va)
 				mmio_atsd_reg[i].reg =
 					mmio_invalidate_va(npu, address, pid,
@@ -732,6 +738,13 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
 		return ERR_PTR(-ENODEV);
 	npu_context->npdev[npu->index][nvlink_index] = npdev;
 
+	if (!nphb->npu.nmmu_flush)
+		/*
+		 * If we're not explicitly flushing ourselves we need to mark
+		 * the thread for global flushes
+		 */
+		mm_context_set_global_tlbi(&mm->context);
+
 	return npu_context;
 }
 EXPORT_SYMBOL(pnv_npu2_init_context);
@@ -829,6 +842,8 @@ int pnv_npu2_init(struct pnv_phb *phb)
 	static int npu_index;
 	uint64_t rc = 0;
 
+	phb->npu.nmmu_flush =
+		of_property_read_bool(phb->hose->dn, "ibm,nmmu-flush");
 	for_each_child_of_node(phb->hose->dn, dn) {
 		gpdev = pnv_pci_get_gpu_dev(get_pci_dev(dn));
 		if (gpdev) {
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index f16bc40..e8e3e20 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -184,6 +184,9 @@ struct pnv_phb {
 
 		/* Bitmask for MMIO register usage */
 		unsigned long mmio_atsd_usage;
+
+		/* Do we need to explicitly flush the nest mmu? */
+		bool nmmu_flush;
 	} npu;
 
 #ifdef CONFIG_CXL_BASE
-- 
2.1.4

Return-Path: <alistair@popple.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40QKHs2ND4zF1pY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 19:11:37 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au
Cc: mhairgrove@nvidia.com, arbab@linux.ibm.com, bsingharora@gmail.com,
 Alistair Popple <alistair@popple.id.au>
Subject: [PATCH 2/2] powernv/npu: Add a debugfs setting to change ATSD
 threshold
Date: Tue, 17 Apr 2018 19:11:29 +1000
Message-Id: <20180417091129.23069-2-alistair@popple.id.au>
In-Reply-To: <20180417091129.23069-1-alistair@popple.id.au>
References: <20180417091129.23069-1-alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The threshold at which it becomes more efficient to coalesce a range of
ATSDs into a single per-PID ATSD is currently not well understood due to a
lack of real-world work loads. This patch adds a debugfs parameter allowing
the threshold to be altered at runtime in order to aid future development
and refinement of the value.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/platforms/powernv/npu-dma.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index dc34662e9df9..a765bf576c14 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -17,7 +17,9 @@
 #include <linux/pci.h>
 #include <linux/memblock.h>
 #include <linux/iommu.h>
+#include <linux/debugfs.h>
 
+#include <asm/debugfs.h>
 #include <asm/tlb.h>
 #include <asm/powernv.h>
 #include <asm/reg.h>
@@ -44,7 +46,8 @@ DEFINE_SPINLOCK(npu_context_lock);
  * entire TLB on the GPU for the given PID rather than each specific address in
  * the range.
  */
-#define ATSD_THRESHOLD (2*1024*1024)
+static uint64_t atsd_threshold = 2 * 1024 * 1024;
+static struct dentry *atsd_threshold_dentry;
 
 /*
  * Other types of TCE cache invalidation are not functional in the
@@ -682,7 +685,7 @@ static void pnv_npu2_mn_invalidate_range(struct mmu_notifier *mn,
 	struct npu_context *npu_context = mn_to_npu_context(mn);
 	unsigned long address;
 
-	if (end - start > ATSD_THRESHOLD) {
+	if (end - start > atsd_threshold) {
 		/*
 		 * Just invalidate the entire PID if the address range is too
 		 * large.
@@ -956,6 +959,11 @@ int pnv_npu2_init(struct pnv_phb *phb)
 	static int npu_index;
 	uint64_t rc = 0;
 
+	if (!atsd_threshold_dentry) {
+		atsd_threshold_dentry = debugfs_create_x64("atsd_threshold",
+				   0600, powerpc_debugfs_root, &atsd_threshold);
+	}
+
 	phb->npu.nmmu_flush =
 		of_property_read_bool(phb->hose->dn, "ibm,nmmu-flush");
 	for_each_child_of_node(phb->hose->dn, dn) {
-- 
2.11.0

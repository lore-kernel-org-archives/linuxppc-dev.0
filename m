Return-Path: <alistair@popple.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40QKHr61llzF1pY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 19:11:36 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au
Cc: mhairgrove@nvidia.com, arbab@linux.ibm.com, bsingharora@gmail.com,
 Alistair Popple <alistair@popple.id.au>
Subject: [PATCH 1/2] powernv/npu: Do a PID GPU TLB flush when invalidating a
 large address range
Date: Tue, 17 Apr 2018 19:11:28 +1000
Message-Id: <20180417091129.23069-1-alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The NPU has a limited number of address translation shootdown (ATSD)
registers and the GPU has limited bandwidth to process ATSDs. This can
result in contention of ATSD registers leading to soft lockups on some
threads, particularly when invalidating a large address range in
pnv_npu2_mn_invalidate_range().

At some threshold it becomes more efficient to flush the entire GPU TLB for
the given MM context (PID) than individually flushing each address in the
range. This patch will result in ranges greater than 2MB being converted
from 32+ ATSDs into a single ATSD which will flush the TLB for the given
PID on each GPU.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/platforms/powernv/npu-dma.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 94801d8e7894..dc34662e9df9 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -40,6 +40,13 @@
 DEFINE_SPINLOCK(npu_context_lock);
 
 /*
+ * When an address shootdown range exceeds this threshold we invalidate the
+ * entire TLB on the GPU for the given PID rather than each specific address in
+ * the range.
+ */
+#define ATSD_THRESHOLD (2*1024*1024)
+
+/*
  * Other types of TCE cache invalidation are not functional in the
  * hardware.
  */
@@ -675,11 +682,19 @@ static void pnv_npu2_mn_invalidate_range(struct mmu_notifier *mn,
 	struct npu_context *npu_context = mn_to_npu_context(mn);
 	unsigned long address;
 
-	for (address = start; address < end; address += PAGE_SIZE)
-		mmio_invalidate(npu_context, 1, address, false);
+	if (end - start > ATSD_THRESHOLD) {
+		/*
+		 * Just invalidate the entire PID if the address range is too
+		 * large.
+		 */
+		mmio_invalidate(npu_context, 0, 0, true);
+	} else {
+		for (address = start; address < end; address += PAGE_SIZE)
+			mmio_invalidate(npu_context, 1, address, false);
 
-	/* Do the flush only on the final addess == end */
-	mmio_invalidate(npu_context, 1, address, true);
+		/* Do the flush only on the final addess == end */
+		mmio_invalidate(npu_context, 1, address, true);
+	}
 }
 
 static const struct mmu_notifier_ops nv_nmmu_notifier_ops = {
-- 
2.11.0

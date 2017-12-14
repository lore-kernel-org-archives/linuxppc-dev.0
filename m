Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yxwTr13BNzDsQK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Dec 2017 12:10:24 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id d23so2449720pfe.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 17:10:23 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
To: alistair@popple.id.au,
	linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, aneesh.kumar@linux.vnet.ibm.com,
 Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v2] powerpc/npu: Cleanup MMIO ATSD flushing
Date: Thu, 14 Dec 2017 12:10:08 +1100
Message-Id: <20171214011008.4388-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While reviewing the code I found that the flush assumes all
pages are of mmu_linear_psize, which is not correct. The patch
uses find_linux_pte to find the right page size and uses that
for launching the ATSD invalidation. A new helper is added
to abstract the invalidation from the various notifiers.

The patch also cleans up a bit by removing AP size from PID
flushes.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---

Changelog:
  Refactor the handling of return values from find_linux_pte
  as suggested by Aneesh

 arch/powerpc/platforms/powernv/npu-dma.c | 55 ++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index f6cbc1a71472..e8caa3e2019d 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -17,6 +17,7 @@
 #include <linux/pci.h>
 #include <linux/memblock.h>
 #include <linux/iommu.h>
+#include <linux/huge_mm.h>
 
 #include <asm/tlb.h>
 #include <asm/powernv.h>
@@ -27,6 +28,7 @@
 #include <asm/pnv-pci.h>
 #include <asm/msi_bitmap.h>
 #include <asm/opal.h>
+#include <asm/pte-walk.h>
 
 #include "powernv.h"
 #include "pci.h"
@@ -460,9 +462,6 @@ static int mmio_invalidate_pid(struct npu *npu, unsigned long pid, bool flush)
 	/* PRS set to process-scoped */
 	launch |= PPC_BIT(13);
 
-	/* AP */
-	launch |= (u64) mmu_get_ap(mmu_virtual_psize) << PPC_BITLSHIFT(17);
-
 	/* PID */
 	launch |= pid << PPC_BITLSHIFT(38);
 
@@ -474,7 +473,8 @@ static int mmio_invalidate_pid(struct npu *npu, unsigned long pid, bool flush)
 }
 
 static int mmio_invalidate_va(struct npu *npu, unsigned long va,
-			unsigned long pid, bool flush)
+			unsigned long pid, bool flush,
+			unsigned int shift)
 {
 	unsigned long launch;
 
@@ -485,9 +485,8 @@ static int mmio_invalidate_va(struct npu *npu, unsigned long va,
 	launch |= PPC_BIT(13);
 
 	/* AP */
-	launch |= (u64) mmu_get_ap(mmu_virtual_psize) << PPC_BITLSHIFT(17);
+	launch |= (u64) mmu_get_ap(shift) << PPC_BITLSHIFT(17);
 
-	/* PID */
 	launch |= pid << PPC_BITLSHIFT(38);
 
 	/* No flush */
@@ -504,7 +503,8 @@ struct mmio_atsd_reg {
 };
 
 static void mmio_invalidate_wait(
-	struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS], bool flush)
+	struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS], bool flush,
+	unsigned int shift)
 {
 	struct npu *npu;
 	int i, reg;
@@ -537,7 +537,8 @@ static void mmio_invalidate_wait(
  * the value of va.
  */
 static void mmio_invalidate(struct npu_context *npu_context, int va,
-			unsigned long address, bool flush)
+			unsigned long address, bool flush,
+			unsigned int shift)
 {
 	int i, j;
 	struct npu *npu;
@@ -572,7 +573,7 @@ static void mmio_invalidate(struct npu_context *npu_context, int va,
 			if (va)
 				mmio_atsd_reg[i].reg =
 					mmio_invalidate_va(npu, address, pid,
-							flush);
+							flush, shift);
 			else
 				mmio_atsd_reg[i].reg =
 					mmio_invalidate_pid(npu, pid, flush);
@@ -585,10 +586,32 @@ static void mmio_invalidate(struct npu_context *npu_context, int va,
 		}
 	}
 
-	mmio_invalidate_wait(mmio_atsd_reg, flush);
+	mmio_invalidate_wait(mmio_atsd_reg, flush, shift);
 	if (flush)
 		/* Wait for the flush to complete */
-		mmio_invalidate_wait(mmio_atsd_reg, false);
+		mmio_invalidate_wait(mmio_atsd_reg, false, shift);
+}
+
+static void pnv_npu2_invalidate_helper(struct npu_context *npu_context,
+		struct mm_struct *mm, unsigned long start,
+		unsigned long end, bool flush)
+{
+	unsigned long address;
+	unsigned int hshift = 0, shift;
+
+	address = start;
+	do {
+		local_irq_disable();
+		find_linux_pte(mm->pgd, address, NULL, &hshift);
+		if (hshift)
+			shift = hshift;
+		else
+			shift = PAGE_SHIFT;
+		mmio_invalidate(npu_context, address > 0, address, flush,
+				shift);
+		local_irq_enable();
+		address += (1ull << shift);
+	} while (address < end);
 }
 
 static void pnv_npu2_mn_release(struct mmu_notifier *mn,
@@ -604,7 +627,7 @@ static void pnv_npu2_mn_release(struct mmu_notifier *mn,
 	 * There should be no more translation requests for this PID, but we
 	 * need to ensure any entries for it are removed from the TLB.
 	 */
-	mmio_invalidate(npu_context, 0, 0, true);
+	pnv_npu2_invalidate_helper(npu_context, mm, 0, PAGE_SIZE, true);
 }
 
 static void pnv_npu2_mn_change_pte(struct mmu_notifier *mn,
@@ -614,7 +637,7 @@ static void pnv_npu2_mn_change_pte(struct mmu_notifier *mn,
 {
 	struct npu_context *npu_context = mn_to_npu_context(mn);
 
-	mmio_invalidate(npu_context, 1, address, true);
+	pnv_npu2_invalidate_helper(npu_context, mm, address, address, true);
 }
 
 static void pnv_npu2_mn_invalidate_range(struct mmu_notifier *mn,
@@ -622,13 +645,11 @@ static void pnv_npu2_mn_invalidate_range(struct mmu_notifier *mn,
 					unsigned long start, unsigned long end)
 {
 	struct npu_context *npu_context = mn_to_npu_context(mn);
-	unsigned long address;
 
-	for (address = start; address < end; address += PAGE_SIZE)
-		mmio_invalidate(npu_context, 1, address, false);
+	pnv_npu2_invalidate_helper(npu_context, mm, start, end, false);
 
 	/* Do the flush only on the final addess == end */
-	mmio_invalidate(npu_context, 1, address, true);
+	pnv_npu2_invalidate_helper(npu_context, mm, end, end, true);
 }
 
 static const struct mmu_notifier_ops nv_nmmu_notifier_ops = {
-- 
2.13.6

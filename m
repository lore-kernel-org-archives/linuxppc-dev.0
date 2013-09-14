Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A9D9C2C015C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Sep 2013 13:50:36 +1000 (EST)
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2 3/3] powerpc/fsl-book3e-64: Use paca for hugetlb TLB1 entry
 selection
Date: Fri, 13 Sep 2013 22:50:22 -0500
Message-ID: <1379130622-17436-3-git-send-email-scottwood@freescale.com>
In-Reply-To: <1379130622-17436-1-git-send-email-scottwood@freescale.com>
References: <1379130622-17436-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This keeps usage coordinated for hugetlb and indirect entries, which
should make entry selection more predictable and probably improve overall
performance when mixing the two.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
v2: new patch
---
 arch/powerpc/mm/hugetlbpage-book3e.c | 51 +++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage-book3e.c b/arch/powerpc/mm/hugetlbpage-book3e.c
index 3bc7006..ee57ac2 100644
--- a/arch/powerpc/mm/hugetlbpage-book3e.c
+++ b/arch/powerpc/mm/hugetlbpage-book3e.c
@@ -8,6 +8,44 @@
 #include <linux/mm.h>
 #include <linux/hugetlb.h>
 
+#ifdef CONFIG_PPC_FSL_BOOK3E
+#ifdef CONFIG_PPC64
+static inline int tlb1_next(void)
+{
+	struct paca_struct *paca = get_paca();
+	struct tlb_core_data *tcd;
+	int this, next;
+
+	tcd = paca->tcd_ptr;
+	this = tcd->esel_next;
+
+	next = this + 1;
+	if (next >= tcd->esel_max)
+		next = tcd->esel_first;
+
+	tcd->esel_next = next;
+	return this;
+}
+#else
+static inline int tlb1_next(void)
+{
+	int index, ncams;
+
+	ncams = mfspr(SPRN_TLB1CFG) & TLBnCFG_N_ENTRY;
+
+	index = __get_cpu_var(next_tlbcam_idx);
+
+	/* Just round-robin the entries and wrap when we hit the end */
+	if (unlikely(index == ncams - 1))
+		__get_cpu_var(next_tlbcam_idx) = tlbcam_index;
+	else
+		__get_cpu_var(next_tlbcam_idx)++;
+
+	return index;
+}
+#endif /* !PPC64 */
+#endif /* FSL */
+
 static inline int mmu_get_tsize(int psize)
 {
 	return mmu_psize_defs[psize].enc;
@@ -47,7 +85,7 @@ void book3e_hugetlb_preload(struct vm_area_struct *vma, unsigned long ea,
 	struct mm_struct *mm;
 
 #ifdef CONFIG_PPC_FSL_BOOK3E
-	int index, ncams;
+	int index;
 #endif
 
 	if (unlikely(is_kernel_addr(ea)))
@@ -77,18 +115,11 @@ void book3e_hugetlb_preload(struct vm_area_struct *vma, unsigned long ea,
 	}
 
 #ifdef CONFIG_PPC_FSL_BOOK3E
-	ncams = mfspr(SPRN_TLB1CFG) & TLBnCFG_N_ENTRY;
-
 	/* We have to use the CAM(TLB1) on FSL parts for hugepages */
-	index = __get_cpu_var(next_tlbcam_idx);
+	index = tlb1_next();
 	mtspr(SPRN_MAS0, MAS0_ESEL(index) | MAS0_TLBSEL(1));
-
-	/* Just round-robin the entries and wrap when we hit the end */
-	if (unlikely(index == ncams - 1))
-		__get_cpu_var(next_tlbcam_idx) = tlbcam_index;
-	else
-		__get_cpu_var(next_tlbcam_idx)++;
 #endif
+
 	mas1 = MAS1_VALID | MAS1_TID(mm->context.id) | MAS1_TSIZE(tsize);
 	mas2 = ea & ~((1UL << shift) - 1);
 	mas2 |= (pte_val(pte) >> PTE_WIMGE_SHIFT) & MAS2_WIMGE_MASK;
-- 
1.8.1.2

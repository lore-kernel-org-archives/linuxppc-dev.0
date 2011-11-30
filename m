Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6901EB6F69
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2011 12:10:46 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pAU1AdGx020928
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2011 19:10:42 -0600
From: Becky Bruce <beckyb@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Define/use HUGETLB_NEED_PRELOAD insead of
 complicated #if
Date: Tue, 29 Nov 2011 19:10:39 -0600
Message-Id: <13226154392896-git-send-email-beckyb@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Becky Bruce <beckyb@kernel.crashing.org>

Define HUGETLB_NEED_PRELOAD in mmu-book3e.h for CONFIG_PPC64 instead
of having a much more complicated #if block.  This is easier to read
and maintain.

Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
---
 arch/powerpc/include/asm/hugetlb.h    |    3 +--
 arch/powerpc/include/asm/mmu-book3e.h |    7 +++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index 863f49d..dfdb95b 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -124,8 +124,7 @@ static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 					     unsigned long addr, pte_t *ptep,
 					     pte_t pte, int dirty)
 {
-#if defined(CONFIG_PPC_MMU_NOHASH) && \
-	!(defined(CONFIG_PPC_FSL_BOOK3E) && defined(CONFIG_PPC32))
+#ifdef HUGETLB_NEED_PRELOAD
 	/*
 	 * The "return 1" forces a call of update_mmu_cache, which will write a
 	 * TLB entry.  Without this, platforms that don't do a write of the TLB
diff --git a/arch/powerpc/include/asm/mmu-book3e.h b/arch/powerpc/include/asm/mmu-book3e.h
index e4d0afc..20d29a5 100644
--- a/arch/powerpc/include/asm/mmu-book3e.h
+++ b/arch/powerpc/include/asm/mmu-book3e.h
@@ -262,6 +262,13 @@ extern int mmu_vmemmap_psize;
 
 #ifdef CONFIG_PPC64
 extern unsigned long linear_map_top;
+
+/*
+ * 64-bit booke platforms don't load the tlb in the tlb miss handler code.
+ * HUGETLB_NEED_PRELOAD handles this - it causes huge_ptep_set_access_flags to
+ * return 1, indicating that the tlb requires preloading.
+ */
+#define HUGETLB_NEED_PRELOAD
 #endif
 
 #endif /* !__ASSEMBLY__ */
-- 
1.5.6.5

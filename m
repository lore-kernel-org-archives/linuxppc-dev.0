Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40y0H140ntzF0gv
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jun 2018 20:01:49 +1000 (AEST)
Received: by mail-pl0-x243.google.com with SMTP id i5-v6so15053297plt.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Jun 2018 03:01:49 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v4 4/7] powerpc/64s/radix: prefetch user address in
 update_mmu_cache
Date: Fri,  1 Jun 2018 20:01:18 +1000
Message-Id: <20180601100121.393-5-npiggin@gmail.com>
In-Reply-To: <20180601100121.393-1-npiggin@gmail.com>
References: <20180601100121.393-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Prefetch the faulting address in update_mmu_cache to give the page
table walker perhaps 100 cycles head start as locks are dropped and
the interrupt completed.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/mem.c              | 4 +++-
 arch/powerpc/mm/pgtable-book3s64.c | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index c3c39b02b2ba..8cecda4bd66a 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -509,8 +509,10 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 	 */
 	unsigned long access, trap;
 
-	if (radix_enabled())
+	if (radix_enabled()) {
+		prefetch((void *)address);
 		return;
+	}
 
 	/* We only want HPTEs for linux PTEs that have _PAGE_ACCESSED set */
 	if (!pte_young(*ptep) || address >= TASK_SIZE)
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index 82fed87289de..c1f4ca45c93a 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -152,7 +152,8 @@ pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 void update_mmu_cache_pmd(struct vm_area_struct *vma, unsigned long addr,
 			  pmd_t *pmd)
 {
-	return;
+	if (radix_enabled())
+		prefetch((void *)addr);
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
-- 
2.17.0

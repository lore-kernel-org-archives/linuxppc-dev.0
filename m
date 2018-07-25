Return-Path: <npiggin@gmail.com>
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41b9Ys22BdzDrpd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 19:54:41 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id s7-v6so4979130pgv.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 02:54:41 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/64s: free page table caches at exit_mmap time
Date: Wed, 25 Jul 2018 19:54:28 +1000
Message-Id: <20180725095428.22561-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The kernel page table caches are tied to init_mm, so there is no
more need for them after userspace is finished.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/mmu_context_book3s64.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index 3bb5cec03d1f..5738c2db751c 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -221,7 +221,7 @@ static void pmd_frag_destroy(void *pmd_frag)
 	}
 }
 
-static void destroy_pagetable_page(struct mm_struct *mm)
+static void destroy_pagetable_cache(struct mm_struct *mm)
 {
 	void *frag;
 
@@ -244,13 +244,14 @@ void destroy_context(struct mm_struct *mm)
 		WARN_ON(process_tb[mm->context.id].prtb0 != 0);
 	else
 		subpage_prot_free(mm);
-	destroy_pagetable_page(mm);
 	destroy_contexts(&mm->context);
 	mm->context.id = MMU_NO_CONTEXT;
 }
 
 void arch_exit_mmap(struct mm_struct *mm)
 {
+	destroy_pagetable_cache(mm);
+
 	if (radix_enabled()) {
 		/*
 		 * Radix doesn't have a valid bit in the process table
-- 
2.17.0

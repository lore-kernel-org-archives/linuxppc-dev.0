Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yBChQ2wK4zDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 21:16:53 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id z80so15969949pff.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 03:16:53 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/64s/radix: fix preempt imbalance in TLB flush
Date: Tue, 10 Oct 2017 20:16:41 +1000
Message-Id: <20171010101641.5714-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/tlb-radix.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index b3e849c4886e..de414460287a 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -358,7 +358,7 @@ void radix__flush_tlb_collapsed_pmd(struct mm_struct *mm, unsigned long addr)
 	unsigned long ap = mmu_get_ap(mmu_virtual_psize);
 	unsigned long pid, end;
 
-
+	preempt_disable();
 	pid = mm ? mm->context.id : 0;
 	if (unlikely(pid == MMU_NO_CONTEXT))
 		goto no_context;
@@ -366,6 +366,7 @@ void radix__flush_tlb_collapsed_pmd(struct mm_struct *mm, unsigned long addr)
 	/* 4k page size, just blow the world */
 	if (PAGE_SIZE == 0x1000) {
 		radix__flush_all_mm(mm);
+		preempt_enable();
 		return;
 	}
 
-- 
2.13.3

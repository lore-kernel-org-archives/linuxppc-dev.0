Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLtpT48dKzDqfh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Oct 2017 00:07:13 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id p9so14467767pgc.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 06:07:13 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2 1/3] powerpc/64s/radix: fix preempt imbalance in TLB flush
Date: Tue, 24 Oct 2017 23:06:52 +1000
Message-Id: <20171024130654.1223-2-npiggin@gmail.com>
In-Reply-To: <20171024130654.1223-1-npiggin@gmail.com>
References: <20171024130654.1223-1-npiggin@gmail.com>
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
index 3a07d7a5e2fe..892544ebc2d2 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -358,7 +358,7 @@ void radix__flush_tlb_collapsed_pmd(struct mm_struct *mm, unsigned long addr)
 	unsigned long ap = mmu_get_ap(mmu_virtual_psize);
 	unsigned long pid, end;
 
-
+	preempt_disable();
 	pid = mm->context.id;
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

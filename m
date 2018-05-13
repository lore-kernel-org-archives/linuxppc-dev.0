Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40k9cz2SYrzF3Rc
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 May 2018 14:21:23 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id z4-v6so4044335pgu.13
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 May 2018 21:21:23 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 1/3] powerpc/64s/radix: make ptep_get_and_clear_full
 non-atomic for the full case
Date: Sun, 13 May 2018 14:21:04 +1000
Message-Id: <20180513042106.15470-2-npiggin@gmail.com>
In-Reply-To: <20180513042106.15470-1-npiggin@gmail.com>
References: <20180513042106.15470-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This matches other architectures, when we know there will be no
further accesses to the address (e.g., for teardown), page table
entries can be cleared non-atomically.

The comments about NMMU are bogus, all MMU notifiers (including NMMU)
are released at this point, with their TLBs flushed. An NMMU access
at this point would be a bug.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/book3s/64/radix.h | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index 705193e7192f..fcd92f9b6ec0 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -176,14 +176,8 @@ static inline pte_t radix__ptep_get_and_clear_full(struct mm_struct *mm,
 	unsigned long old_pte;
 
 	if (full) {
-		/*
-		 * If we are trying to clear the pte, we can skip
-		 * the DD1 pte update sequence and batch the tlb flush. The
-		 * tlb flush batching is done by mmu gather code. We
-		 * still keep the cmp_xchg update to make sure we get
-		 * correct R/C bit which might be updated via Nest MMU.
-		 */
-		old_pte = __radix_pte_update(ptep, ~0ul, 0);
+		old_pte = pte_val(*ptep);
+		*ptep = __pte(0);
 	} else
 		old_pte = radix__pte_update(mm, addr, ptep, ~0ul, 0, 0);
 
-- 
2.17.0

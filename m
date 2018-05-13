Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40k9d24n9yzF3Rl
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 May 2018 14:21:26 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id a14-v6so4471640pfi.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 May 2018 21:21:26 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 2/3] powerpc/64s/radix: avoid ptesync after set_pte and
 ptep_set_access_flags
Date: Sun, 13 May 2018 14:21:05 +1000
Message-Id: <20180513042106.15470-3-npiggin@gmail.com>
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

The ISA suggests ptesync after setting a pte, to prevent a table walk
initiated by a subsequent access from causing a spurious fault, which
may be an allowance implementation to have page table walk loads
incoherent with store queues.

However there is no correctness problem in spurious faults -- the
kernel copes with these at any time, and the architecture requires
the pte to be re-loaded, which would eventually find the updated pte.

On POWER9 there does not appear to be a large window where this is a
problem, so as an optimisation, remove the costly ptesync from pte
updates. If implementations benefit from ptesync, it would likely be
better to go in update_mmu_cache, rather than set_pte etc which is
called for things like fork and mprotect.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/book3s/64/radix.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index fcd92f9b6ec0..45bf1e1b1d33 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -209,7 +209,6 @@ static inline void radix__ptep_set_access_flags(struct mm_struct *mm,
 		__radix_pte_update(ptep, 0, new_pte);
 	} else
 		__radix_pte_update(ptep, 0, set);
-	asm volatile("ptesync" : : : "memory");
 }
 
 static inline int radix__pte_same(pte_t pte_a, pte_t pte_b)
@@ -226,7 +225,6 @@ static inline void radix__set_pte_at(struct mm_struct *mm, unsigned long addr,
 				 pte_t *ptep, pte_t pte, int percpu)
 {
 	*ptep = pte;
-	asm volatile("ptesync" : : : "memory");
 }
 
 static inline int radix__pmd_bad(pmd_t pmd)
-- 
2.17.0

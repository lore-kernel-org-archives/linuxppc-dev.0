Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zWlZz4hCczDqsP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Feb 2018 01:13:15 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH] powerpc/mm/radix: Fix build error when RADIX_MMU=n
Date: Thu,  1 Feb 2018 01:13:10 +1100
Message-Id: <20180131141310.4938-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The recent TLB flush rework broke the build when the Radix MMU is
disabled at build time, eg:

  (.text+0x264): undefined reference to `.radix__tlbiel_all'

We could add an empty version, but if we ever called it by accident
that would indicate a bad bug, so add a stub that just WARNs if we do.

Fixes: d4748276ae14 ("powerpc/64s: Improve local TLB flush for boot and MCE on POWER9")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/tlbflush-radix.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
index b8f9ad587087..8eea90f80e45 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
@@ -11,7 +11,11 @@ static inline int mmu_get_ap(int psize)
 	return mmu_psize_defs[psize].ap;
 }
 
+#ifdef CONFIG_PPC_RADIX_MMU
 extern void radix__tlbiel_all(unsigned int action);
+#else
+static inline void radix__tlbiel_all(unsigned int action) { WARN_ON(1); };
+#endif
 
 extern void radix__flush_hugetlb_tlb_range(struct vm_area_struct *vma,
 					   unsigned long start, unsigned long end);
-- 
2.14.1

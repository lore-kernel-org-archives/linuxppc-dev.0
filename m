Return-Path: <cov@codeaurora.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwgWW2GMpzDqBK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 01:20:39 +1000 (AEST)
From: Christopher Covington <cov@codeaurora.org>
To: Catalin Marinas <catalin.marinas@arm.com>, criu@openvz.org,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Will Deacon <Will.Deacon@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: Christopher Covington <cov@codeaurora.org>
Subject: [RFC 2/5] mm/powerpc: Make VDSO unmap generic
Date: Thu, 28 Apr 2016 11:18:54 -0400
Message-Id: <1461856737-17071-3-git-send-email-cov@codeaurora.org>
In-Reply-To: <1461856737-17071-1-git-send-email-cov@codeaurora.org>
References: <20151202121918.GA4523@arm.com>
 <1461856737-17071-1-git-send-email-cov@codeaurora.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In order to support unmapping the VDSO on additional architectures, move the
unmap code out from arch/powerpc. Architectures that wish to use the generic
logic must have an unsigned long vdso in mm->context and can opt in by
selecting CONFIG_ARCH_WANT_VDSO_MAP. This allows PowerPC to go back to using
the generic MM hooks, instead of carrying its own.

Signed-off-by: Christopher Covington <cov@codeaurora.org>
---
 arch/powerpc/Kconfig                   |  1 +
 arch/powerpc/include/asm/mmu_context.h | 35 +---------------------------------
 include/asm-generic/mm_hooks.h         |  4 ++++
 3 files changed, 6 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 7cd32c0..f74320e 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -160,6 +160,7 @@ config PPC
 	select HAVE_ARCH_SECCOMP_FILTER
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT
+	select ARCH_WANT_VDSO_MAP
 
 config GENERIC_CSUM
 	def_bool CPU_LITTLE_ENDIAN
diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 508b842..3e51842 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -8,6 +8,7 @@
 #include <linux/spinlock.h>
 #include <asm/mmu.h>	
 #include <asm/cputable.h>
+#include <asm-generic/mm_hooks.h>
 #include <asm/cputhreads.h>
 
 /*
@@ -126,39 +127,5 @@ static inline void enter_lazy_tlb(struct mm_struct *mm,
 #endif
 }
 
-static inline void arch_dup_mmap(struct mm_struct *oldmm,
-				 struct mm_struct *mm)
-{
-}
-
-static inline void arch_exit_mmap(struct mm_struct *mm)
-{
-}
-
-static inline void arch_unmap(struct mm_struct *mm,
-			      struct vm_area_struct *vma,
-			      unsigned long start, unsigned long end)
-{
-	if (start <= mm->context.vdso && mm->context.vdso < end)
-		mm->context.vdso = 0;
-}
-
-static inline void arch_bprm_mm_init(struct mm_struct *mm,
-				     struct vm_area_struct *vma)
-{
-}
-
-static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
-		bool write, bool execute, bool foreign)
-{
-	/* by default, allow everything */
-	return true;
-}
-
-static inline bool arch_pte_access_permitted(pte_t pte, bool write)
-{
-	/* by default, allow everything */
-	return true;
-}
 #endif /* __KERNEL__ */
 #endif /* __ASM_POWERPC_MMU_CONTEXT_H */
diff --git a/include/asm-generic/mm_hooks.h b/include/asm-generic/mm_hooks.h
index cc5d9a14..6645116 100644
--- a/include/asm-generic/mm_hooks.h
+++ b/include/asm-generic/mm_hooks.h
@@ -19,6 +19,10 @@ static inline void arch_unmap(struct mm_struct *mm,
 			struct vm_area_struct *vma,
 			unsigned long start, unsigned long end)
 {
+#ifdef CONFIG_ARCH_WANT_VDSO_MAP
+	if (start <= mm->context.vdso && mm->context.vdso < end)
+		mm->context.vdso = 0;
+#endif  /* CONFIG_ARCH_WANT_VDSO_MAP */
 }
 
 static inline void arch_bprm_mm_init(struct mm_struct *mm,
-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

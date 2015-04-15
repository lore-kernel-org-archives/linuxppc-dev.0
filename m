Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6A71E1A0BD8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 00:17:14 +1000 (AEST)
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Wed, 15 Apr 2015 15:17:11 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 293061B08069
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 15:17:42 +0100 (BST)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3FEH7OV56295448
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 14:17:07 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3FEH67L018343
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 08:17:07 -0600
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Hugh Dickins <hughd@google.com>, Rik van Riel <riel@redhat.com>,
 Mel Gorman <mgorman@suse.de>, Pavel Emelyanov <xemul@parallels.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Ingo Molnar <mingo@kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 3/3] powerpc/mm: Tracking vDSO remap
Date: Wed, 15 Apr 2015 16:16:58 +0200
Message-Id: <29c21a607c8083626e3ce9f4a19cb00b0205dbaa.1429104776.git.ldufour@linux.vnet.ibm.com>
In-Reply-To: <cover.1429104776.git.ldufour@linux.vnet.ibm.com>
References: <cover.1429104776.git.ldufour@linux.vnet.ibm.com>
In-Reply-To: <cover.1429104776.git.ldufour@linux.vnet.ibm.com>
References: <20150414123853.a3e61b7fa95b6c634e0fcce0@linux-foundation.org>
 <cover.1429104776.git.ldufour@linux.vnet.ibm.com>
Cc: criu@openvz.org, cov@codeaurora.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some processes (CRIU) are moving the vDSO area using the mremap system
call. As a consequence the kernel reference to the vDSO base address is
no more valid and the signal return frame built once the vDSO has been
moved is not pointing to the new sigreturn address.

This patch handles vDSO remapping and unmapping.

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
---
 arch/powerpc/include/asm/mm-arch-hooks.h | 13 +++++++++++++
 arch/powerpc/include/asm/mmu_context.h   | 23 ++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/mm-arch-hooks.h b/arch/powerpc/include/asm/mm-arch-hooks.h
index 63091a19de9f..f2a2da895897 100644
--- a/arch/powerpc/include/asm/mm-arch-hooks.h
+++ b/arch/powerpc/include/asm/mm-arch-hooks.h
@@ -12,4 +12,17 @@
 #ifndef _ASM_POWERPC_MM_ARCH_HOOKS_H
 #define _ASM_POWERPC_MM_ARCH_HOOKS_H
 
+static inline void arch_remap(struct mm_struct *mm,
+			      unsigned long old_start, unsigned long old_end,
+			      unsigned long new_start, unsigned long new_end)
+{
+	/*
+	 * mremap() doesn't allow moving multiple vmas so we can limit the
+	 * check to old_start == vdso_base.
+	 */
+	if (old_start == mm->context.vdso_base)
+		mm->context.vdso_base = new_start;
+}
+#define arch_remap arch_remap
+
 #endif /* _ASM_POWERPC_MM_ARCH_HOOKS_H */
diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 73382eba02dc..825cb232eab6 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -8,7 +8,6 @@
 #include <linux/spinlock.h>
 #include <asm/mmu.h>	
 #include <asm/cputable.h>
-#include <asm-generic/mm_hooks.h>
 #include <asm/cputhreads.h>
 
 /*
@@ -109,5 +108,27 @@ static inline void enter_lazy_tlb(struct mm_struct *mm,
 #endif
 }
 
+static inline void arch_dup_mmap(struct mm_struct *oldmm,
+				 struct mm_struct *mm)
+{
+}
+
+static inline void arch_exit_mmap(struct mm_struct *mm)
+{
+}
+
+static inline void arch_unmap(struct mm_struct *mm,
+			      struct vm_area_struct *vma,
+			      unsigned long start, unsigned long end)
+{
+	if (start <= mm->context.vdso_base && mm->context.vdso_base < end)
+		mm->context.vdso_base = 0;
+}
+
+static inline void arch_bprm_mm_init(struct mm_struct *mm,
+				     struct vm_area_struct *vma)
+{
+}
+
 #endif /* __KERNEL__ */
 #endif /* __ASM_POWERPC_MMU_CONTEXT_H */
-- 
1.9.1

Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0A61F1A0145
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2015 04:38:04 +1100 (AEDT)
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Thu, 26 Mar 2015 17:38:01 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 067A71B08074
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 17:38:24 +0000 (GMT)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2QHbvHS1704206
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 17:37:57 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2QHbtG7032188
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 11:37:57 -0600
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Jeff Dike <jdike@addtoit.com>,
 Richard Weinberger <richard@nod.at>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 user-mode-linux-devel@lists.sourceforge.net,
 user-mode-linux-user@lists.sourceforge.net, linux-arch@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v4 2/2] powerpc/mm: Tracking vDSO remap
Date: Thu, 26 Mar 2015 18:37:53 +0100
Message-Id: <7fdae652993cf88bdd633d65e5a8f81c7ad8a1e3.1427390952.git.ldufour@linux.vnet.ibm.com>
In-Reply-To: <cover.1427390952.git.ldufour@linux.vnet.ibm.com>
References: <cover.1427390952.git.ldufour@linux.vnet.ibm.com>
In-Reply-To: <cover.1427390952.git.ldufour@linux.vnet.ibm.com>
References: <20150326141730.GA23060@gmail.com>
 <cover.1427390952.git.ldufour@linux.vnet.ibm.com>
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
Moving or unmapping partially the vDSO lead to invalidate it from the
kernel point of view.

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mmu_context.h | 32 +++++++++++++++++++++++++++-
 arch/powerpc/kernel/vdso.c             | 39 ++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 73382eba02dc..67734ce8be67 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -8,7 +8,6 @@
 #include <linux/spinlock.h>
 #include <asm/mmu.h>	
 #include <asm/cputable.h>
-#include <asm-generic/mm_hooks.h>
 #include <asm/cputhreads.h>
 
 /*
@@ -109,5 +108,36 @@ static inline void enter_lazy_tlb(struct mm_struct *mm,
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
+extern void arch_vdso_remap(struct mm_struct *mm,
+			    unsigned long old_start, unsigned long old_end,
+			    unsigned long new_start, unsigned long new_end);
+static inline void arch_unmap(struct mm_struct *mm, struct vm_area_struct *vma,
+			      unsigned long start, unsigned long end)
+{
+	arch_vdso_remap(mm, start, end, 0, 0);
+}
+
+static inline void arch_bprm_mm_init(struct mm_struct *mm,
+				     struct vm_area_struct *vma)
+{
+}
+
+#define __HAVE_ARCH_REMAP
+static inline void arch_remap(struct mm_struct *mm,
+			      unsigned long old_start, unsigned long old_end,
+			      unsigned long new_start, unsigned long new_end)
+{
+	arch_vdso_remap(mm, old_start, old_end, new_start, new_end);
+}
+
 #endif /* __KERNEL__ */
 #endif /* __ASM_POWERPC_MMU_CONTEXT_H */
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 305eb0d9b768..a11b5d8f36d6 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -283,6 +283,45 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	return rc;
 }
 
+void arch_vdso_remap(struct mm_struct *mm,
+		     unsigned long old_start, unsigned long old_end,
+		     unsigned long new_start, unsigned long new_end)
+{
+	unsigned long vdso_end, vdso_start;
+
+	if (!mm->context.vdso_base)
+		return;
+	vdso_start = mm->context.vdso_base;
+
+#ifdef CONFIG_PPC64
+	/* Calling is_32bit_task() implies that we are dealing with the
+	 * current process memory. If there is a call path where mm is not
+	 * owned by the current task, then we'll have need to store the
+	 * vDSO size in the mm->context.
+	 */
+	BUG_ON(current->mm != mm);
+	if (is_32bit_task())
+		vdso_end = vdso_start + (vdso32_pages << PAGE_SHIFT);
+	else
+		vdso_end = vdso_start + (vdso64_pages << PAGE_SHIFT);
+#else
+	vdso_end = vdso_start + (vdso32_pages << PAGE_SHIFT);
+#endif
+	vdso_end += (1<<PAGE_SHIFT); /* data page */
+
+	/* Check if the vDSO is in the range of the remapped area */
+	if ((vdso_start <= old_start && old_start < vdso_end) ||
+	    (vdso_start < old_end && old_end <= vdso_end)  ||
+	    (old_start <= vdso_start && vdso_start < old_end)) {
+		/* Update vdso_base if the vDSO is entirely moved. */
+		if (old_start == vdso_start && old_end == vdso_end &&
+		    (old_end - old_start) == (new_end - new_start))
+			mm->context.vdso_base = new_start;
+		else
+			mm->context.vdso_base = 0;
+	}
+}
+
 const char *arch_vma_name(struct vm_area_struct *vma)
 {
 	if (vma->vm_mm && vma->vm_start == vma->vm_mm->context.vdso_base)
-- 
1.9.1

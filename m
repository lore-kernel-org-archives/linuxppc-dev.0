Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ED9CB67A40
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 13:52:00 +1000 (EST)
Subject: [PATCH] powerpc vdso updates
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Tue, 30 May 2006 13:51:37 +1000
Message-Id: <1148961097.15722.11.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Ingo Molnar <mingo@elte.hu>, Paul Mackerras <paulus@samba.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch cleans up some locking & error handling in the ppc vdso and
moves the vdso base pointer from the thread struct to the mm context
where it more logically belongs. It brings the powerpc implementation
closer to Ingo's new x86 one and also adds an arch_vma_name() function
allowing to print [vsdo] in /proc/<pid>/maps if Ingo's x86 vdso patch is
also applied.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

This is 2.6.18 material, hopefully should go along with Ingo's x86 vdso updates. Ingo, if you
change something to arch_vma_name(), please let me know.



Index: linux-work/arch/powerpc/kernel/signal_32.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/signal_32.c	2006-05-30 13:34:09.000000000 +1000
+++ linux-work/arch/powerpc/kernel/signal_32.c	2006-05-30 13:40:21.000000000 +1000
@@ -757,10 +757,10 @@ static int handle_rt_signal(unsigned lon
 
 	/* Save user registers on the stack */
 	frame = &rt_sf->uc.uc_mcontext;
-	if (vdso32_rt_sigtramp && current->thread.vdso_base) {
+	if (vdso32_rt_sigtramp && current->mm->context.vdso_base) {
 		if (save_user_regs(regs, frame, 0))
 			goto badframe;
-		regs->link = current->thread.vdso_base + vdso32_rt_sigtramp;
+		regs->link = current->mm->context.vdso_base + vdso32_rt_sigtramp;
 	} else {
 		if (save_user_regs(regs, frame, __NR_rt_sigreturn))
 			goto badframe;
@@ -1029,10 +1029,10 @@ static int handle_signal(unsigned long s
 	    || __put_user(sig, &sc->signal))
 		goto badframe;
 
-	if (vdso32_sigtramp && current->thread.vdso_base) {
+	if (vdso32_sigtramp && current->mm->context.vdso_base) {
 		if (save_user_regs(regs, &frame->mctx, 0))
 			goto badframe;
-		regs->link = current->thread.vdso_base + vdso32_sigtramp;
+		regs->link = current->mm->context.vdso_base + vdso32_sigtramp;
 	} else {
 		if (save_user_regs(regs, &frame->mctx, __NR_sigreturn))
 			goto badframe;
Index: linux-work/arch/powerpc/kernel/signal_64.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/signal_64.c	2006-05-30 13:34:09.000000000 +1000
+++ linux-work/arch/powerpc/kernel/signal_64.c	2006-05-30 13:40:21.000000000 +1000
@@ -394,8 +394,8 @@ static int setup_rt_frame(int signr, str
 	current->thread.fpscr.val = 0;
 
 	/* Set up to return from userspace. */
-	if (vdso64_rt_sigtramp && current->thread.vdso_base) {
-		regs->link = current->thread.vdso_base + vdso64_rt_sigtramp;
+	if (vdso64_rt_sigtramp && current->mm->context.vdso_base) {
+		regs->link = current->mm->context.vdso_base + vdso64_rt_sigtramp;
 	} else {
 		err |= setup_trampoline(__NR_rt_sigreturn, &frame->tramp[0]);
 		if (err)
Index: linux-work/arch/powerpc/kernel/vdso.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/vdso.c	2006-05-30 13:34:09.000000000 +1000
+++ linux-work/arch/powerpc/kernel/vdso.c	2006-05-30 13:41:31.000000000 +1000
@@ -223,6 +223,7 @@ int arch_setup_additional_pages(struct l
 	struct vm_area_struct *vma;
 	unsigned long vdso_pages;
 	unsigned long vdso_base;
+	int rc;
 
 #ifdef CONFIG_PPC64
 	if (test_thread_flag(TIF_32BIT)) {
@@ -237,20 +238,13 @@ int arch_setup_additional_pages(struct l
 	vdso_base = VDSO32_MBASE;
 #endif
 
-	current->thread.vdso_base = 0;
+	current->mm->context.vdso_base = 0;
 
 	/* vDSO has a problem and was disabled, just don't "enable" it for the
 	 * process
 	 */
 	if (vdso_pages == 0)
 		return 0;
-
-	vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
-	if (vma == NULL)
-		return -ENOMEM;
-
-	memset(vma, 0, sizeof(*vma));
-
 	/* Add a page to the vdso size for the data page */
 	vdso_pages ++;
 
@@ -259,17 +253,23 @@ int arch_setup_additional_pages(struct l
 	 * at vdso_base which is the "natural" base for it, but we might fail
 	 * and end up putting it elsewhere.
 	 */
+	down_write(&mm->mmap_sem);
 	vdso_base = get_unmapped_area(NULL, vdso_base,
 				      vdso_pages << PAGE_SHIFT, 0, 0);
-	if (vdso_base & ~PAGE_MASK) {
-		kmem_cache_free(vm_area_cachep, vma);
-		return (int)vdso_base;
+	if (IS_ERR_VALUE(vdso_base)) {
+		rc = vdso_base;
+		goto fail_mmapsem;
 	}
 
-	current->thread.vdso_base = vdso_base;
 
+	/* Allocate a VMA structure and fill it up */
+	vma = kmem_cache_zalloc(vm_area_cachep, SLAB_KERNEL);
+	if (vma == NULL) {
+		rc = -ENOMEM;
+		goto fail_mmapsem;
+	}
 	vma->vm_mm = mm;
-	vma->vm_start = current->thread.vdso_base;
+	vma->vm_start = vdso_base;
 	vma->vm_end = vma->vm_start + (vdso_pages << PAGE_SHIFT);
 
 	/*
@@ -282,23 +282,38 @@ int arch_setup_additional_pages(struct l
 	 * It's fine to use that for setting breakpoints in the vDSO code
 	 * pages though
 	 */
-	vma->vm_flags = VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
+	vma->vm_flags = VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC;
 	vma->vm_flags |= mm->def_flags;
 	vma->vm_page_prot = protection_map[vma->vm_flags & 0x7];
 	vma->vm_ops = &vdso_vmops;
 
-	down_write(&mm->mmap_sem);
-	if (insert_vm_struct(mm, vma)) {
-		up_write(&mm->mmap_sem);
-		kmem_cache_free(vm_area_cachep, vma);
-		return -ENOMEM;
-	}
+	/* Insert new VMA */
+	rc = insert_vm_struct(mm, vma);
+	if (rc)
+		goto fail_vma;
+
+	/* Put vDSO base into mm struct and account for memory usage */
+	current->mm->context.vdso_base = vdso_base;
 	mm->total_vm += (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
 	up_write(&mm->mmap_sem);
-
 	return 0;
+
+ fail_vma:
+	kmem_cache_free(vm_area_cachep, vma);
+ fail_mmapsem:
+	up_write(&mm->mmap_sem);
+	return rc;
+}
+
+const char *arch_vma_name(struct vm_area_struct *vma)
+{
+	if (vma->vm_mm && vma->vm_start == vma->vm_mm->context.vdso_base)
+		return "[vdso]";
+	return NULL;
 }
 
+
+
 static void * __init find_section32(Elf32_Ehdr *ehdr, const char *secname,
 				  unsigned long *size)
 {
Index: linux-work/include/asm-powerpc/elf.h
===================================================================
--- linux-work.orig/include/asm-powerpc/elf.h	2006-05-30 13:34:09.000000000 +1000
+++ linux-work/include/asm-powerpc/elf.h	2006-05-30 13:40:21.000000000 +1000
@@ -294,7 +294,7 @@ do {									\
 	NEW_AUX_ENT(AT_DCACHEBSIZE, dcache_bsize);			\
 	NEW_AUX_ENT(AT_ICACHEBSIZE, icache_bsize);			\
 	NEW_AUX_ENT(AT_UCACHEBSIZE, ucache_bsize);			\
-	VDSO_AUX_ENT(AT_SYSINFO_EHDR, current->thread.vdso_base)	\
+	VDSO_AUX_ENT(AT_SYSINFO_EHDR, current->mm->context.vdso_base)	\
 } while (0)
 
 /* PowerPC64 relocations defined by the ABIs */
Index: linux-work/include/asm-powerpc/mmu.h
===================================================================
--- linux-work.orig/include/asm-powerpc/mmu.h	2006-05-30 13:34:09.000000000 +1000
+++ linux-work/include/asm-powerpc/mmu.h	2006-05-30 13:40:21.000000000 +1000
@@ -360,6 +360,7 @@ typedef struct {
 #ifdef CONFIG_HUGETLB_PAGE
 	u16 low_htlb_areas, high_htlb_areas;
 #endif
+	unsigned long vdso_base;
 } mm_context_t;
 
 
Index: linux-work/include/asm-powerpc/page.h
===================================================================
--- linux-work.orig/include/asm-powerpc/page.h	2006-05-30 13:34:09.000000000 +1000
+++ linux-work/include/asm-powerpc/page.h	2006-05-30 13:40:21.000000000 +1000
@@ -198,6 +198,9 @@ extern void copy_user_page(void *to, voi
 		struct page *p);
 extern int page_is_ram(unsigned long pfn);
 
+struct vm_area_struct;
+extern const char *arch_vma_name(struct vm_area_struct *vma);
+
 #include <asm-generic/memory_model.h>
 #endif /* __ASSEMBLY__ */
 
Index: linux-work/include/asm-powerpc/processor.h
===================================================================
--- linux-work.orig/include/asm-powerpc/processor.h	2006-05-30 13:34:09.000000000 +1000
+++ linux-work/include/asm-powerpc/processor.h	2006-05-30 13:40:21.000000000 +1000
@@ -153,7 +153,6 @@ struct thread_struct {
 	unsigned long	start_tb;	/* Start purr when proc switched in */
 	unsigned long	accum_tb;	/* Total accumilated purr for process */
 #endif
-	unsigned long	vdso_base;	/* base of the vDSO library */
 	unsigned long	dabr;		/* Data address breakpoint register */
 #ifdef CONFIG_ALTIVEC
 	/* Complete AltiVec register set */

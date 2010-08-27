Return-Path: <dkirjanov@hera.kernel.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 01F44B70E6
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Aug 2010 23:49:16 +1000 (EST)
Date: Fri, 27 Aug 2010 13:49:11 +0000
From: Denis Kirjanov <dkirjanov@kernel.org>
To: benh@kernel.crashing.org
Subject: [PATCH] Use is_32bit_task() helper to test 32-bit binary
Message-ID: <20100827134911.GA28893@hera.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch removes all explicit tests for the TIF_32BIT flag

Signed-off-by: Denis Kirjanov <dkirjanov@kernel.org>
---
 arch/powerpc/include/asm/compat.h    |    4 ++--
 arch/powerpc/include/asm/elf.h       |    2 +-
 arch/powerpc/include/asm/page_64.h   |    4 ++--
 arch/powerpc/include/asm/processor.h |    4 ++--
 arch/powerpc/kernel/ptrace.c         |    2 +-
 arch/powerpc/kernel/vdso.c           |    6 +++---
 arch/powerpc/oprofile/backtrace.c    |    2 +-
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/compat.h b/arch/powerpc/include/asm/compat.h
index 396d21a..3369e2c 100644
--- a/arch/powerpc/include/asm/compat.h
+++ b/arch/powerpc/include/asm/compat.h
@@ -143,7 +143,7 @@ static inline void __user *compat_alloc_user_space(long len)
 	 * We cant access below the stack pointer in the 32bit ABI and
 	 * can access 288 bytes in the 64bit ABI
 	 */
-	if (!(test_thread_flag(TIF_32BIT)))
+	if (!is_32bit_task())
 		usp -= 288;
 
 	return (void __user *) (usp - len);
@@ -213,7 +213,7 @@ struct compat_shmid64_ds {
 
 static inline int is_compat_task(void)
 {
-	return test_thread_flag(TIF_32BIT);
+	return is_32bit_task();
 }
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/elf.h
index c376eda..2b917c6 100644
--- a/arch/powerpc/include/asm/elf.h
+++ b/arch/powerpc/include/asm/elf.h
@@ -250,7 +250,7 @@ do {								\
  * the 64bit ABI has never had these issues dont enable the workaround
  * even if we have an executable stack.
  */
-# define elf_read_implies_exec(ex, exec_stk) (test_thread_flag(TIF_32BIT) ? \
+# define elf_read_implies_exec(ex, exec_stk) (is_32bit_task() ? \
 		(exec_stk == EXSTACK_DEFAULT) : 0)
 #else 
 # define SET_PERSONALITY(ex) \
diff --git a/arch/powerpc/include/asm/page_64.h b/arch/powerpc/include/asm/page_64.h
index 358ff14..932f88d 100644
--- a/arch/powerpc/include/asm/page_64.h
+++ b/arch/powerpc/include/asm/page_64.h
@@ -163,7 +163,7 @@ do {						\
 #endif /* !CONFIG_HUGETLB_PAGE */
 
 #define VM_DATA_DEFAULT_FLAGS \
-	(test_thread_flag(TIF_32BIT) ? \
+	(is_32bit_task() ? \
 	 VM_DATA_DEFAULT_FLAGS32 : VM_DATA_DEFAULT_FLAGS64)
 
 /*
@@ -179,7 +179,7 @@ do {						\
 					 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
 #define VM_STACK_DEFAULT_FLAGS \
-	(test_thread_flag(TIF_32BIT) ? \
+	(is_32bit_task() ? \
 	 VM_STACK_DEFAULT_FLAGS32 : VM_STACK_DEFAULT_FLAGS64)
 
 #include <asm-generic/getorder.h>
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 19c05b0..4c14187 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -118,7 +118,7 @@ extern struct task_struct *last_task_used_spe;
 #define TASK_UNMAPPED_BASE_USER32 (PAGE_ALIGN(TASK_SIZE_USER32 / 4))
 #define TASK_UNMAPPED_BASE_USER64 (PAGE_ALIGN(TASK_SIZE_USER64 / 4))
 
-#define TASK_UNMAPPED_BASE ((test_thread_flag(TIF_32BIT)) ? \
+#define TASK_UNMAPPED_BASE ((is_32bit_task()) ? \
 		TASK_UNMAPPED_BASE_USER32 : TASK_UNMAPPED_BASE_USER64 )
 #endif
 
@@ -128,7 +128,7 @@ extern struct task_struct *last_task_used_spe;
 #define STACK_TOP_USER64 TASK_SIZE_USER64
 #define STACK_TOP_USER32 TASK_SIZE_USER32
 
-#define STACK_TOP (test_thread_flag(TIF_32BIT) ? \
+#define STACK_TOP (is_32bit_task() ? \
 		   STACK_TOP_USER32 : STACK_TOP_USER64)
 
 #define STACK_TOP_MAX STACK_TOP_USER64
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 11f3cd9..286d978 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1681,7 +1681,7 @@ long do_syscall_trace_enter(struct pt_regs *regs)
 
 	if (unlikely(current->audit_context)) {
 #ifdef CONFIG_PPC64
-		if (!test_thread_flag(TIF_32BIT))
+		if (!is_32bit_task())
 			audit_syscall_entry(AUDIT_ARCH_PPC64,
 					    regs->gpr[0],
 					    regs->gpr[3], regs->gpr[4],
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 13002fe..fd87287 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -159,7 +159,7 @@ static void dump_vdso_pages(struct vm_area_struct * vma)
 {
 	int i;
 
-	if (!vma || test_thread_flag(TIF_32BIT)) {
+	if (!vma || is_32bit_task()) {
 		printk("vDSO32 @ %016lx:\n", (unsigned long)vdso32_kbase);
 		for (i=0; i<vdso32_pages; i++) {
 			struct page *pg = virt_to_page(vdso32_kbase +
@@ -170,7 +170,7 @@ static void dump_vdso_pages(struct vm_area_struct * vma)
 			dump_one_vdso_page(pg, upg);
 		}
 	}
-	if (!vma || !test_thread_flag(TIF_32BIT)) {
+	if (!vma || !is_32bit_task()) {
 		printk("vDSO64 @ %016lx:\n", (unsigned long)vdso64_kbase);
 		for (i=0; i<vdso64_pages; i++) {
 			struct page *pg = virt_to_page(vdso64_kbase +
@@ -200,7 +200,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 		return 0;
 
 #ifdef CONFIG_PPC64
-	if (test_thread_flag(TIF_32BIT)) {
+	if (is_32bit_task()) {
 		vdso_pagelist = vdso32_pagelist;
 		vdso_pages = vdso32_pages;
 		vdso_base = VDSO32_MBASE;
diff --git a/arch/powerpc/oprofile/backtrace.c b/arch/powerpc/oprofile/backtrace.c
index b4278cf..f75301f 100644
--- a/arch/powerpc/oprofile/backtrace.c
+++ b/arch/powerpc/oprofile/backtrace.c
@@ -105,7 +105,7 @@ void op_powerpc_backtrace(struct pt_regs * const regs, unsigned int depth)
 		}
 	} else {
 #ifdef CONFIG_PPC64
-		if (!test_thread_flag(TIF_32BIT)) {
+		if (!is_32bit_task()) {
 			while (depth--) {
 				sp = user_getsp64(sp, first_frame);
 				if (!sp)
-- 
1.7.0

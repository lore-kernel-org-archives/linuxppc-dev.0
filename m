Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EEC0E1A101F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Dec 2015 15:31:04 +1100 (AEDT)
Date: Wed, 9 Dec 2015 15:30:40 +1100
From: Anton Blanchard <anton@samba.org>
To: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 cyrilbur@gmail.com, scottwood@freescale.com, mikey@neuling.org
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Call restore_sprs() on initial context switch
Message-ID: <20151209153040.6e8f527b@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit 152d523e6307 ("powerpc: Create context switch helpers save_sprs()
and restore_sprs()") has an issue with newly created processes and
kernel threads. These do not call back through __switch_to(), instead
returning straight to ret_from_fork() or ret_from_kernel_thread().

This means restore_sprs() is not getting called. Add a call to it
in ret_from_fork() and ret_from_kernel_thread().

Signed-off-by: Anton Blanchard <anton@samba.org>
Fixes: 152d523e6307 ("powerpc: Create context switch helpers save_sprs() and restore_sprs()")
---
 arch/powerpc/kernel/entry_32.S | 20 ++++++++++++++++++++
 arch/powerpc/kernel/entry_64.S | 20 ++++++++++++++++++++
 arch/powerpc/kernel/process.c  | 19 ++++++++++++-------
 3 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 2405631..64802a1 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -423,6 +423,16 @@ END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
 	.globl	ret_from_fork
 ret_from_fork:
 	REST_NVGPRS(r1)
+	/*
+	 * The first context switch for a process doesn't return through
+	 * __switch_to(), so we need to call restore_sprs() here.
+	 */
+	mr	r4,r2
+	bl	restore_sprs
+	/*
+	 * restore_sprs() returns a pointer to the previous task struct,
+	 * which is what schedule_tail() expects to be passed.
+	 */
 	bl	schedule_tail
 	li	r3,0
 	b	ret_from_syscall
@@ -430,6 +440,16 @@ ret_from_fork:
 	.globl	ret_from_kernel_thread
 ret_from_kernel_thread:
 	REST_NVGPRS(r1)
+	/*
+	 * The first context switch for a kernel thread doesn't return through
+	 * __switch_to(), so we need to call restore_sprs() here.
+	 */
+	mr	r4,r2
+	bl	restore_sprs
+	/*
+	 * restore_sprs() returns a pointer to the previous task struct,
+	 * which is what schedule_tail() expects to be passed.
+	 */
 	bl	schedule_tail
 	mtlr	r14
 	mr	r3,r15
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index c8b4225..a21a861 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -409,12 +409,32 @@ _GLOBAL(ppc_switch_endian)
 	b	.Lsyscall_exit
 
 _GLOBAL(ret_from_fork)
+	/*
+	 * The first context switch for a process doesn't return through
+	 * __switch_to(), so we need to call restore_sprs() here.
+	 */
+	ld	r4,PACACURRENT(r13)
+	bl	restore_sprs
+	/*
+	 * restore_sprs() returns a pointer to the previous task struct,
+	 * which is what schedule_tail() expects to be passed.
+	 */
 	bl	schedule_tail
 	REST_NVGPRS(r1)
 	li	r3,0
 	b	.Lsyscall_exit
 
 _GLOBAL(ret_from_kernel_thread)
+	/*
+	 * The first context switch for a kernel thread doesn't return through
+	 * __switch_to(), so we need to call restore_sprs() here.
+	 */
+	ld	r4,PACACURRENT(r13)
+	bl	restore_sprs
+	/*
+	 * restore_sprs() returns a pointer to the previous task struct,
+	 * which is what schedule_tail() expects to be passed.
+	 */
 	bl	schedule_tail
 	REST_NVGPRS(r1)
 	mtlr	r14
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 73d5ac0..ec10250 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -854,9 +854,12 @@ static inline void save_sprs(struct thread_struct *t)
 #endif
 }
 
-static inline void restore_sprs(struct thread_struct *old_thread,
-				struct thread_struct *new_thread)
+struct task_struct *restore_sprs(struct task_struct *old,
+				 struct task_struct *new)
 {
+	struct thread_struct *old_thread = &old->thread;
+	struct thread_struct *new_thread = &new->thread;
+
 #ifdef CONFIG_ALTIVEC
 	if (cpu_has_feature(CPU_FTR_ALTIVEC) &&
 	    old_thread->vrsave != new_thread->vrsave)
@@ -891,6 +894,12 @@ static inline void restore_sprs(struct thread_struct *old_thread,
 			mtspr(SPRN_TAR, new_thread->tar);
 	}
 #endif
+
+	/*
+	 * ret_from_fork and ret_from_kernel_thread expect us to
+	 * return a pointer to the previous task struct.
+	 */
+	return old;
 }
 
 struct task_struct *__switch_to(struct task_struct *prev,
@@ -966,11 +975,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
 
 	last = _switch(old_thread, new_thread);
 
-	/* Need to recalculate these after calling _switch() */
-	old_thread = &last->thread;
-	new_thread = &current->thread;
-
-	restore_sprs(old_thread, new_thread);
+	restore_sprs(last, current);
 
 #ifdef CONFIG_PPC_BOOK3S_64
 	if (current_thread_info()->local_flags & _TLF_LAZY_MMU) {
-- 
2.5.0

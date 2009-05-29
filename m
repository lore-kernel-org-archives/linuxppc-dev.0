Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 29 May 2009 17:26:38 +1000
Subject: [RFC/PATCH] powerpc: Add PTRACE_SINGLEBLOCK support
Message-Id: <20090529072644.7797ADDF84@ozlabs.org>
Cc: roland@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Roland McGrath <roland@redhat.com>

Reworked by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

This adds block-step support on powerpc, including a PTRACE_SINGLEBLOCK
request for ptrace.

The BookE implementation is tweaked to fire a single step after a
block step in order to mimmic the server behaviour.

Signed-off-by: Roland McGrath <roland@redhat.com>
---

WARNING: There is a difference between the BookE implementations
(that use DBCR0:BT) and the "classic" implementations (that use MSR:BE).

The former will stop -on- the branch that is about to be taken without
actually taking it, while the later will stop on the -target- of the
branch.

The BookE variant is superior in some ways as it allows to know where
you come from on branches. But that also means that the semantics exposed
to user space would not be consistent which is BAD (tm).

I'm not sure what the right approach is. For now, I've made BookE mimmic
server by automatically firing a single step right after the blockstep
from the kernel, so the semantics exposed to userspace are identical,
but that mean we do lose some information in the BookE case that would
have otherwise been available (the branch origin).

Now, some server processors do provide it via an SPR, but I don't know
if we can retrieve it, because I think it could be clobbered by the act
of taking the debug interrupt ... non trivial.

Roland, what do you think is the right approach ? This patch ?

 arch/powerpc/include/asm/ptrace.h |    4 ++++
 arch/powerpc/kernel/head_booke.h  |   10 +++++-----
 arch/powerpc/kernel/ptrace.c      |   23 +++++++++++++++++++++--
 arch/powerpc/kernel/traps.c       |   34 ++++++++++++++++++++++++++++++----
 4 files changed, 60 insertions(+), 11 deletions(-)

--- linux-work.orig/arch/powerpc/include/asm/ptrace.h	2009-02-05 16:22:24.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/ptrace.h	2009-05-29 14:53:39.000000000 +1000
@@ -135,7 +135,9 @@ do {									      \
  * These are defined as per linux/ptrace.h, which see.
  */
 #define arch_has_single_step()	(1)
+#define arch_has_block_step()	(!cpu_has_feature(CPU_FTR_601))
 extern void user_enable_single_step(struct task_struct *);
+extern void user_enable_block_step(struct task_struct *);
 extern void user_disable_single_step(struct task_struct *);
 
 #endif /* __ASSEMBLY__ */
@@ -288,4 +290,6 @@ extern void user_disable_single_step(str
 #define PPC_PTRACE_PEEKUSR_3264  0x91
 #define PPC_PTRACE_POKEUSR_3264  0x90
 
+#define PTRACE_SINGLEBLOCK	0x100	/* resume execution until next branch */
+
 #endif /* _ASM_POWERPC_PTRACE_H */
Index: linux-work/arch/powerpc/kernel/ptrace.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/ptrace.c	2009-02-05 16:22:25.000000000 +1100
+++ linux-work/arch/powerpc/kernel/ptrace.c	2009-05-29 14:31:15.000000000 +1000
@@ -704,15 +704,34 @@ void user_enable_single_step(struct task
 
 	if (regs != NULL) {
 #if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+		task->thread.dbcr0 &= ~DBCR0_BT;
 		task->thread.dbcr0 |= DBCR0_IDM | DBCR0_IC;
 		regs->msr |= MSR_DE;
 #else
+		regs->msr &= ~MSR_BE;
 		regs->msr |= MSR_SE;
 #endif
 	}
 	set_tsk_thread_flag(task, TIF_SINGLESTEP);
 }
 
+void user_enable_block_step(struct task_struct *task)
+{
+	struct pt_regs *regs = task->thread.regs;
+
+	if (regs != NULL) {
+#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+		task->thread.dbcr0 &= ~DBCR0_IC;
+		task->thread.dbcr0 = DBCR0_IDM | DBCR0_BT;
+		regs->msr |= MSR_DE;
+#else
+		regs->msr &= ~MSR_SE;
+		regs->msr |= MSR_BE;
+#endif
+	}
+	set_tsk_thread_flag(task, TIF_SINGLESTEP);
+}
+
 void user_disable_single_step(struct task_struct *task)
 {
 	struct pt_regs *regs = task->thread.regs;
@@ -726,10 +745,10 @@ void user_disable_single_step(struct tas
 
 	if (regs != NULL) {
 #if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
-		task->thread.dbcr0 &= ~(DBCR0_IC | DBCR0_IDM);
+		task->thread.dbcr0 &= ~(DBCR0_IC | DBCR0_BT | DBCR0_IDM);
 		regs->msr &= ~MSR_DE;
 #else
-		regs->msr &= ~MSR_SE;
+		regs->msr &= ~(MSR_SE | MSR_BE);
 #endif
 	}
 	clear_tsk_thread_flag(task, TIF_SINGLESTEP);
Index: linux-work/arch/powerpc/kernel/head_booke.h
===================================================================
--- linux-work.orig/arch/powerpc/kernel/head_booke.h	2009-05-29 14:24:47.000000000 +1000
+++ linux-work/arch/powerpc/kernel/head_booke.h	2009-05-29 14:54:26.000000000 +1000
@@ -256,7 +256,7 @@ label:
 	 * off DE in the DSRR1 value and clearing the debug status.	      \
 	 */								      \
 	mfspr	r10,SPRN_DBSR;		/* check single-step/branch taken */  \
-	andis.	r10,r10,DBSR_IC@h;					      \
+	andis.	r10,r10,(DBSR_IC|DBSR_BT)@h;				      \
 	beq+	2f;							      \
 									      \
 	lis	r10,KERNELBASE@h;	/* check if exception in vectors */   \
@@ -271,7 +271,7 @@ label:
 									      \
 	/* here it looks like we got an inappropriate debug exception. */     \
 1:	rlwinm	r9,r9,0,~MSR_DE;	/* clear DE in the CDRR1 value */     \
-	lis	r10,DBSR_IC@h;		/* clear the IC event */	      \
+	lis	r10,(DBSR_IC|DBSR_BT)@h;	/* clear the IC event */      \
 	mtspr	SPRN_DBSR,r10;						      \
 	/* restore state and get out */					      \
 	lwz	r10,_CCR(r11);						      \
@@ -309,7 +309,7 @@ label:
 	 * off DE in the CSRR1 value and clearing the debug status.	      \
 	 */								      \
 	mfspr	r10,SPRN_DBSR;		/* check single-step/branch taken */  \
-	andis.	r10,r10,DBSR_IC@h;					      \
+	andis.	r10,r10,(DBSR_IC|DBSR_BT)@h;				      \
 	beq+	2f;							      \
 									      \
 	lis	r10,KERNELBASE@h;	/* check if exception in vectors */   \
@@ -317,14 +317,14 @@ label:
 	cmplw	r12,r10;						      \
 	blt+	2f;			/* addr below exception vectors */    \
 									      \
-	lis	r10,DebugCrit@h;						      \
+	lis	r10,DebugCrit@h;					      \
 	ori	r10,r10,DebugCrit@l;					      \
 	cmplw	r12,r10;						      \
 	bgt+	2f;			/* addr above exception vectors */    \
 									      \
 	/* here it looks like we got an inappropriate debug exception. */     \
 1:	rlwinm	r9,r9,0,~MSR_DE;	/* clear DE in the CSRR1 value */     \
-	lis	r10,DBSR_IC@h;		/* clear the IC event */	      \
+	lis	r10,(DBSR_IC|DBSR_BT)@h;	/* clear the IC event */      \
 	mtspr	SPRN_DBSR,r10;						      \
 	/* restore state and get out */					      \
 	lwz	r10,_CCR(r11);						      \
Index: linux-work/arch/powerpc/kernel/traps.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/traps.c	2009-05-29 14:32:06.000000000 +1000
+++ linux-work/arch/powerpc/kernel/traps.c	2009-05-29 17:02:35.000000000 +1000
@@ -1041,7 +1041,34 @@ void SoftwareEmulation(struct pt_regs *r
 
 void __kprobes DebugException(struct pt_regs *regs, unsigned long debug_status)
 {
-	if (debug_status & DBSR_IC) {	/* instruction completion */
+	/* Hack alert: On BookE, Branch Taken stops on the branch itself, while
+	 * on server, it stops on the target of the branch. In order to simulate
+	 * the server behaviour, we thus restart right away with a single step
+	 * instead of stopping here when hitting a BT
+	 */
+	if (debug_status & DBSR_BT) {
+		regs->msr &= ~MSR_DE;
+
+		/* Disable BT */
+		mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) & ~DBCR0_BT);
+		/* Clear the BT event */
+		mtspr(SPRN_DBSR, DBSR_BT);
+
+		/* Do the single step trick only when coming from userspace */
+		if (user_mode(regs)) {
+			current->thread.dbcr0 &= ~DBCR0_BT;
+			current->thread.dbcr0 |= DBCR0_IDM | DBCR0_IC;
+			regs->msr |= MSR_DE;
+			return;
+		}
+
+		if (notify_die(DIE_SSTEP, "block_step", regs, 5,
+			       5, SIGTRAP) == NOTIFY_STOP) {
+			return;
+		}
+		if (debugger_sstep(regs))
+			return;
+	} else if (debug_status & DBSR_IC) { 	/* Instruction complete */
 		regs->msr &= ~MSR_DE;
 
 		/* Disable instruction completion */
@@ -1057,9 +1084,8 @@ void __kprobes DebugException(struct pt_
 		if (debugger_sstep(regs))
 			return;
 
-		if (user_mode(regs)) {
-			current->thread.dbcr0 &= ~DBCR0_IC;
-		}
+		if (user_mode(regs))
+			current->thread.dbcr0 &= ~(DBCR0_IC);
 
 		_exception(SIGTRAP, regs, TRAP_TRACE, regs->nip);
 	} else if (debug_status & (DBSR_DAC1R | DBSR_DAC1W)) {

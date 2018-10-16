Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4F6C04EBD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 05:14:53 +0000 (UTC)
Received: from lists.ozlabs.org (unknown [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E7E92098A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 05:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E7E92098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Z3Qf23CbzF35Q
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 16:14:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Z3Fb0408zDrJn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 16:06:58 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42Z3FJ56Xyz9ttBv;
 Tue, 16 Oct 2018 07:06:44 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id mCAnJNhz-cya; Tue, 16 Oct 2018 07:06:44 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42Z3FJ4PNWz9ttBh;
 Tue, 16 Oct 2018 07:06:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id EA18E8B78F;
 Tue, 16 Oct 2018 07:06:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id BfZ1u-LsTYpM; Tue, 16 Oct 2018 07:06:54 +0200 (CEST)
Received: from pc13168vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7C5408B755;
 Tue, 16 Oct 2018 07:06:54 +0200 (CEST)
Received: by pc13168vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 551DC6F4C9; Tue, 16 Oct 2018 05:06:54 +0000 (UTC)
Message-Id: <6a06f71773381b9327a96ca966ef6e25945bb56b.1539623258.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1539623258.git.christophe.leroy@c-s.fr>
References: <cover.1539623258.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v8 3/9] powerpc: Prepare for moving thread_info into
 task_struct
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 16 Oct 2018 05:06:54 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch cleans the powerpc kernel before activating
CONFIG_THREAD_INFO_IN_TASK:
- The purpose of the pointer given to call_do_softirq() and
call_do_irq() is to point the new stack ==> change it to void* and
rename it 'sp'
- Don't use CURRENT_THREAD_INFO() to locate the stack.
- Fix a few comments.
- Replace current_thread_info()->task by current
- Remove unnecessary casts to thread_info, as they'll become invalid
once thread_info is not in stack anymore.
- Rename THREAD_INFO to TASK_STASK: as it is in fact the offset of the
pointer to the stack in task_struct, this pointer will not be impacted
by the move of THREAD_INFO.
- Makes TASK_STACK available to PPC64. PPC64 will need it to get the
stack pointer from current once the thread_info have been moved.
- Modifies klp_init_thread_info() to take task_struct pointer argument.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/irq.h       |  4 ++--
 arch/powerpc/include/asm/livepatch.h |  7 ++++---
 arch/powerpc/include/asm/processor.h |  4 ++--
 arch/powerpc/include/asm/reg.h       |  2 +-
 arch/powerpc/kernel/asm-offsets.c    |  2 +-
 arch/powerpc/kernel/entry_32.S       |  2 +-
 arch/powerpc/kernel/entry_64.S       |  2 +-
 arch/powerpc/kernel/head_32.S        |  4 ++--
 arch/powerpc/kernel/head_40x.S       |  4 ++--
 arch/powerpc/kernel/head_44x.S       |  2 +-
 arch/powerpc/kernel/head_8xx.S       |  2 +-
 arch/powerpc/kernel/head_booke.h     |  4 ++--
 arch/powerpc/kernel/head_fsl_booke.S |  4 ++--
 arch/powerpc/kernel/irq.c            |  2 +-
 arch/powerpc/kernel/misc_32.S        |  4 ++--
 arch/powerpc/kernel/process.c        |  8 ++++----
 arch/powerpc/kernel/setup-common.c   |  2 +-
 arch/powerpc/kernel/setup_32.c       | 15 +++++----------
 arch/powerpc/kernel/smp.c            |  4 +++-
 19 files changed, 38 insertions(+), 40 deletions(-)

diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
index ee39ce56b2a2..2efbae8d93be 100644
--- a/arch/powerpc/include/asm/irq.h
+++ b/arch/powerpc/include/asm/irq.h
@@ -63,8 +63,8 @@ extern struct thread_info *hardirq_ctx[NR_CPUS];
 extern struct thread_info *softirq_ctx[NR_CPUS];
 
 extern void irq_ctx_init(void);
-extern void call_do_softirq(struct thread_info *tp);
-extern void call_do_irq(struct pt_regs *regs, struct thread_info *tp);
+void call_do_softirq(void *sp);
+void call_do_irq(struct pt_regs *regs, void *sp);
 extern void do_IRQ(struct pt_regs *regs);
 extern void __init init_IRQ(void);
 extern void __do_irq(struct pt_regs *regs);
diff --git a/arch/powerpc/include/asm/livepatch.h b/arch/powerpc/include/asm/livepatch.h
index 47a03b9b528b..8a81d10ccc82 100644
--- a/arch/powerpc/include/asm/livepatch.h
+++ b/arch/powerpc/include/asm/livepatch.h
@@ -43,13 +43,14 @@ static inline unsigned long klp_get_ftrace_location(unsigned long faddr)
 	return ftrace_location_range(faddr, faddr + 16);
 }
 
-static inline void klp_init_thread_info(struct thread_info *ti)
+static inline void klp_init_thread_info(struct task_struct *p)
 {
+	struct thread_info *ti = task_thread_info(p);
 	/* + 1 to account for STACK_END_MAGIC */
-	ti->livepatch_sp = (unsigned long *)(ti + 1) + 1;
+	ti->livepatch_sp = end_of_stack(p) + 1;
 }
 #else
-static void klp_init_thread_info(struct thread_info *ti) { }
+static inline void klp_init_thread_info(struct task_struct *p) { }
 #endif /* CONFIG_LIVEPATCH */
 
 #endif /* _ASM_POWERPC_LIVEPATCH_H */
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 2caa44db709a..53649b9b7dc4 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -40,7 +40,7 @@
 
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
-#include <asm/thread_info.h>
+#include <linux/thread_info.h>
 #include <asm/ptrace.h>
 #include <asm/hw_breakpoint.h>
 
@@ -332,7 +332,7 @@ struct thread_struct {
 
 #define INIT_SP		(sizeof(init_stack) + (unsigned long) &init_stack)
 #define INIT_SP_LIMIT \
-	(_ALIGN_UP(sizeof(init_thread_info), 16) + (unsigned long) &init_stack)
+	(_ALIGN_UP(sizeof(struct thread_info), 16) + (unsigned long)&init_stack)
 
 #ifdef CONFIG_SPE
 #define SPEFSCR_INIT \
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 640a4d818772..d2528a0b2f5b 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1058,7 +1058,7 @@
  *	- SPRG9 debug exception scratch
  *
  * All 32-bit:
- *	- SPRG3 current thread_info pointer
+ *	- SPRG3 current thread_struct physical addr pointer
  *        (virtual on BookE, physical on others)
  *
  * 32-bit classic:
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 10ef2e4db2fd..47adbb8673f1 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -90,10 +90,10 @@ int main(void)
 	DEFINE(SIGSEGV, SIGSEGV);
 	DEFINE(NMI_MASK, NMI_MASK);
 #else
-	OFFSET(THREAD_INFO, task_struct, stack);
 	DEFINE(THREAD_INFO_GAP, _ALIGN_UP(sizeof(struct thread_info), 16));
 	OFFSET(KSP_LIMIT, thread_struct, ksp_limit);
 #endif /* CONFIG_PPC64 */
+	OFFSET(TASK_STACK, task_struct, stack);
 
 #ifdef CONFIG_LIVEPATCH
 	OFFSET(TI_livepatch_sp, thread_info, livepatch_sp);
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 77decded1175..7ea1d71f4546 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -1166,7 +1166,7 @@ ret_from_debug_exc:
 	mfspr	r9,SPRN_SPRG_THREAD
 	lwz	r10,SAVED_KSP_LIMIT(r1)
 	stw	r10,KSP_LIMIT(r9)
-	lwz	r9,THREAD_INFO-THREAD(r9)
+	lwz	r9,TASK_STACK-THREAD(r9)
 	CURRENT_THREAD_INFO(r10, r1)
 	lwz	r10,TI_PREEMPT(r10)
 	stw	r10,TI_PREEMPT(r9)
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 7b1693adff2a..03cbf409c3f8 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -683,7 +683,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
 2:
 #endif /* CONFIG_PPC_BOOK3S_64 */
 
-	CURRENT_THREAD_INFO(r7, r8)  /* base of new stack */
+	clrrdi	r7, r8, THREAD_SHIFT	/* base of new stack */
 	/* Note: this uses SWITCH_FRAME_SIZE rather than INT_FRAME_SIZE
 	   because we don't need to leave the 288-byte ABI gap at the
 	   top of the kernel stack. */
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 61ca27929355..dce6f2ff07e5 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -261,7 +261,7 @@ __secondary_hold_acknowledge:
 	tophys(r11,r1);			/* use tophys(r1) if kernel */ \
 	beq	1f;		\
 	mfspr	r11,SPRN_SPRG_THREAD;	\
-	lwz	r11,THREAD_INFO-THREAD(r11);	\
+	lwz	r11,TASK_STACK-THREAD(r11);	\
 	addi	r11,r11,THREAD_SIZE;	\
 	tophys(r11,r11);	\
 1:	subi	r11,r11,INT_FRAME_SIZE	/* alloc exc. frame */
@@ -841,7 +841,7 @@ __secondary_start:
 	bl	init_idle_6xx
 #endif /* CONFIG_6xx */
 
-	/* get current_thread_info and current */
+	/* get current's stack and current */
 	lis	r1,secondary_ti@ha
 	tophys(r1,r1)
 	lwz	r1,secondary_ti@l(r1)
diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index b19d78410511..3088c9f29f5e 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -115,7 +115,7 @@ _ENTRY(saved_ksp_limit)
 	andi.	r11,r11,MSR_PR;						     \
 	beq	1f;							     \
 	mfspr	r1,SPRN_SPRG_THREAD;	/* if from user, start at top of   */\
-	lwz	r1,THREAD_INFO-THREAD(r1); /* this thread's kernel stack   */\
+	lwz	r1,TASK_STACK-THREAD(r1); /* this thread's kernel stack   */\
 	addi	r1,r1,THREAD_SIZE;					     \
 1:	subi	r1,r1,INT_FRAME_SIZE;	/* Allocate an exception frame     */\
 	tophys(r11,r1);							     \
@@ -158,7 +158,7 @@ _ENTRY(saved_ksp_limit)
 	beq	1f;							     \
 	/* COMING FROM USER MODE */					     \
 	mfspr	r11,SPRN_SPRG_THREAD;	/* if from user, start at top of   */\
-	lwz	r11,THREAD_INFO-THREAD(r11); /* this thread's kernel stack */\
+	lwz	r11,TASK_STACK-THREAD(r11); /* this thread's kernel stack */\
 1:	addi	r11,r11,THREAD_SIZE-INT_FRAME_SIZE; /* Alloc an excpt frm  */\
 	tophys(r11,r11);						     \
 	stw	r10,_CCR(r11);          /* save various registers	   */\
diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index 37e4a7cf0065..15d39b2499de 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -1020,7 +1020,7 @@ _GLOBAL(start_secondary_47x)
 
 	/* Now we can get our task struct and real stack pointer */
 
-	/* Get current_thread_info and current */
+	/* Get current's stack and current */
 	lis	r1,secondary_ti@ha
 	lwz	r1,secondary_ti@l(r1)
 	lwz	r2,TI_TASK(r1)
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 134a573a9f2d..5eeca20e195e 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -124,7 +124,7 @@ turn_on_mmu:
 	tophys(r11,r1);			/* use tophys(r1) if kernel */ \
 	beq	1f;		\
 	mfspr	r11,SPRN_SPRG_THREAD;	\
-	lwz	r11,THREAD_INFO-THREAD(r11);	\
+	lwz	r11,TASK_STACK-THREAD(r11);	\
 	addi	r11,r11,THREAD_SIZE;	\
 	tophys(r11,r11);	\
 1:	subi	r11,r11,INT_FRAME_SIZE	/* alloc exc. frame */
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index d0862a100d29..175f812066dc 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -44,7 +44,7 @@
 	mr	r11, r1;						     \
 	beq	1f;							     \
 	/* if from user, start at top of this thread's kernel stack */       \
-	lwz	r11, THREAD_INFO-THREAD(r10);				     \
+	lwz	r11, TASK_STACK - THREAD(r10);				     \
 	ALLOC_STACK_FRAME(r11, THREAD_SIZE);				     \
 1 :	subi	r11, r11, INT_FRAME_SIZE; /* Allocate exception frame */     \
 	stw	r13, _CCR(r11);		/* save various registers */	     \
@@ -130,7 +130,7 @@
 	DO_KVM	BOOKE_INTERRUPT_##intno exc_level_srr1;		             \
 	andi.	r11,r11,MSR_PR;						     \
 	mfspr	r11,SPRN_SPRG_THREAD;	/* if from user, start at top of   */\
-	lwz	r11,THREAD_INFO-THREAD(r11); /* this thread's kernel stack */\
+	lwz	r11, TASK_STACK - THREAD(r11); /* this thread's kernel stack */\
 	addi	r11,r11,EXC_LVL_FRAME_OVERHEAD;	/* allocate stack frame    */\
 	beq	1f;							     \
 	/* COMING FROM USER MODE */					     \
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 05b574f416b3..239ad8a4754e 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -704,7 +704,7 @@ finish_tlb_load:
 
 	/* Get the next_tlbcam_idx percpu var */
 #ifdef CONFIG_SMP
-	lwz	r12, THREAD_INFO-THREAD(r12)
+	lwz	r12, TASK_STACK-THREAD(r12)
 	lwz	r15, TI_CPU(r12)
 	lis     r14, __per_cpu_offset@h
 	ori     r14, r14, __per_cpu_offset@l
@@ -1076,7 +1076,7 @@ __secondary_start:
 	mr	r4,r24		/* Why? */
 	bl	call_setup_cpu
 
-	/* get current_thread_info and current */
+	/* get current's stack and current */
 	lis	r1,secondary_ti@ha
 	lwz	r1,secondary_ti@l(r1)
 	lwz	r2,TI_TASK(r1)
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 916ddc4aac44..9e7dc4468c8c 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -663,7 +663,7 @@ void do_IRQ(struct pt_regs *regs)
 	struct thread_info *curtp, *irqtp, *sirqtp;
 
 	/* Switch to the irq stack to handle this */
-	curtp = current_thread_info();
+	curtp = (void *)(current_stack_pointer() & ~(THREAD_SIZE - 1));
 	irqtp = hardirq_ctx[raw_smp_processor_id()];
 	sirqtp = softirq_ctx[raw_smp_processor_id()];
 
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 2f0fe8bfc078..32762f4c3458 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -60,7 +60,7 @@ _GLOBAL(call_do_softirq)
 	blr
 
 /*
- * void call_do_irq(struct pt_regs *regs, struct thread_info *irqtp);
+ * void call_do_irq(struct pt_regs *regs, void *sp);
  */
 _GLOBAL(call_do_irq)
 	mflr	r0
@@ -603,7 +603,7 @@ EXPORT_SYMBOL(__bswapdi2)
 #ifdef CONFIG_SMP
 _GLOBAL(start_secondary_resume)
 	/* Reset stack */
-	CURRENT_THREAD_INFO(r1, r1)
+	rlwinm	r1, r1, 0, 0, 31 - THREAD_SHIFT
 	addi	r1,r1,THREAD_SIZE-STACK_FRAME_OVERHEAD
 	li	r3,0
 	stw	r3,0(r1)		/* Zero the stack frame pointer	*/
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 7ad304a3cc7d..84e39cedf03b 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1239,8 +1239,8 @@ struct task_struct *__switch_to(struct task_struct *prev,
 		batch->active = 1;
 	}
 
-	if (current_thread_info()->task->thread.regs) {
-		restore_math(current_thread_info()->task->thread.regs);
+	if (current->thread.regs) {
+		restore_math(current->thread.regs);
 
 		/*
 		 * The copy-paste buffer can only store into foreign real
@@ -1250,7 +1250,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
 		 * mappings, we must issue a cp_abort to clear any state and
 		 * prevent snooping, corruption or a covert channel.
 		 */
-		if (current_thread_info()->task->thread.used_vas)
+		if (current->thread.used_vas)
 			asm volatile(PPC_CP_ABORT);
 	}
 #endif /* CONFIG_PPC_BOOK3S_64 */
@@ -1642,7 +1642,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	unsigned long sp = (unsigned long)task_stack_page(p) + THREAD_SIZE;
 	struct thread_info *ti = task_thread_info(p);
 
-	klp_init_thread_info(ti);
+	klp_init_thread_info(p);
 
 	/* Copy registers */
 	sp -= sizeof(struct pt_regs);
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 9ca9db707bcb..8054a7b9e026 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -940,7 +940,7 @@ void __init setup_arch(char **cmdline_p)
 	/* Reserve large chunks of memory for use by CMA for KVM. */
 	kvm_cma_reserve();
 
-	klp_init_thread_info(&init_thread_info);
+	klp_init_thread_info(&init_task);
 
 	init_mm.start_code = (unsigned long)_stext;
 	init_mm.end_code = (unsigned long) _etext;
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 8c507be12c3c..81ebf7d6f526 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -205,10 +205,8 @@ void __init irqstack_early_init(void)
 	/* interrupt stacks must be in lowmem, we get that for free on ppc32
 	 * as the memblock is limited to lowmem by default */
 	for_each_possible_cpu(i) {
-		softirq_ctx[i] = (struct thread_info *)
-			__va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
-		hardirq_ctx[i] = (struct thread_info *)
-			__va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
+		softirq_ctx[i] = __va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
+		hardirq_ctx[i] = __va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
 	}
 }
 
@@ -226,13 +224,10 @@ void __init exc_lvl_early_init(void)
 		hw_cpu = 0;
 #endif
 
-		critirq_ctx[hw_cpu] = (struct thread_info *)
-			__va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
+		critirq_ctx[hw_cpu] = __va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
 #ifdef CONFIG_BOOKE
-		dbgirq_ctx[hw_cpu] = (struct thread_info *)
-			__va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
-		mcheckirq_ctx[hw_cpu] = (struct thread_info *)
-			__va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
+		dbgirq_ctx[hw_cpu] = __va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
+		mcheckirq_ctx[hw_cpu] = __va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
 #endif
 	}
 }
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 8e3a5da24d59..5613c9617840 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -20,6 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/sched/mm.h>
+#include <linux/sched/task_stack.h>
 #include <linux/sched/topology.h>
 #include <linux/smp.h>
 #include <linux/interrupt.h>
@@ -1020,7 +1021,8 @@ static void cpu_idle_thread_init(unsigned int cpu, struct task_struct *idle)
 
 #ifdef CONFIG_PPC64
 	paca_ptrs[cpu]->__current = idle;
-	paca_ptrs[cpu]->kstack = (unsigned long)ti + THREAD_SIZE - STACK_FRAME_OVERHEAD;
+	paca_ptrs[cpu]->kstack = (unsigned long)task_stack_page(idle) +
+				  THREAD_SIZE - STACK_FRAME_OVERHEAD;
 #ifdef CONFIG_STACKPROTECTOR
 	paca_ptrs[cpu]->canary = idle->stack_canary;
 #endif
-- 
2.13.3


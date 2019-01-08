Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AFEC43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 13:57:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1206D2087E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 13:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1206D2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Yv2L22qQzDqXs
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 00:56:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Ytkb1sPwzDqJh
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2019 00:43:19 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43YtkV6xztz9tyMx;
 Tue,  8 Jan 2019 14:43:14 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 2mpX1pe92MnA; Tue,  8 Jan 2019 14:43:14 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43YtkV6PS5z9tyMv;
 Tue,  8 Jan 2019 14:43:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 455328B833;
 Tue,  8 Jan 2019 14:43:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id OjuxGPxSpx2t; Tue,  8 Jan 2019 14:43:16 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D36BC8B7DF;
 Tue,  8 Jan 2019 14:43:15 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id A7110717F2; Tue,  8 Jan 2019 13:43:15 +0000 (UTC)
Message-Id: <b3bd1fd9cd202e90a9862338cc69b9e9aa4ceafd.1546954237.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1546954233.git.christophe.leroy@c-s.fr>
References: <cover.1546954233.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v12 04/10] powerpc: Prepare for moving thread_info into
 task_struct
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Mike Rapoport <rppt@linux.ibm.com>
Date: Tue,  8 Jan 2019 13:43:15 +0000 (UTC)
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
- Rename THREAD_INFO to TASK_STASK: as it is in fact the offset of the
pointer to the stack in task_struct, this pointer will not be impacted
by the move of THREAD_INFO.
- Makes TASK_STACK available to PPC64. PPC64 will need it to get the
stack pointer from current once the thread_info have been moved.
- Modifies klp_init_thread_info() to take task_struct pointer argument.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/irq.h       | 4 ++--
 arch/powerpc/include/asm/livepatch.h | 6 +++---
 arch/powerpc/include/asm/processor.h | 4 ++--
 arch/powerpc/include/asm/reg.h       | 2 +-
 arch/powerpc/kernel/asm-offsets.c    | 2 +-
 arch/powerpc/kernel/entry_32.S       | 2 +-
 arch/powerpc/kernel/entry_64.S       | 2 +-
 arch/powerpc/kernel/head_32.S        | 4 ++--
 arch/powerpc/kernel/head_40x.S       | 4 ++--
 arch/powerpc/kernel/head_44x.S       | 2 +-
 arch/powerpc/kernel/head_8xx.S       | 2 +-
 arch/powerpc/kernel/head_booke.h     | 4 ++--
 arch/powerpc/kernel/head_fsl_booke.S | 4 ++--
 arch/powerpc/kernel/irq.c            | 2 +-
 arch/powerpc/kernel/misc_32.S        | 4 ++--
 arch/powerpc/kernel/process.c        | 8 ++++----
 arch/powerpc/kernel/setup-common.c   | 2 +-
 arch/powerpc/kernel/smp.c            | 4 +++-
 18 files changed, 32 insertions(+), 30 deletions(-)

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
index 47a03b9b528b..7cb514865a28 100644
--- a/arch/powerpc/include/asm/livepatch.h
+++ b/arch/powerpc/include/asm/livepatch.h
@@ -43,13 +43,13 @@ static inline unsigned long klp_get_ftrace_location(unsigned long faddr)
 	return ftrace_location_range(faddr, faddr + 16);
 }
 
-static inline void klp_init_thread_info(struct thread_info *ti)
+static inline void klp_init_thread_info(struct task_struct *p)
 {
 	/* + 1 to account for STACK_END_MAGIC */
-	ti->livepatch_sp = (unsigned long *)(ti + 1) + 1;
+	task_thread_info(p)->livepatch_sp = end_of_stack(p) + 1;
 }
 #else
-static void klp_init_thread_info(struct thread_info *ti) { }
+static inline void klp_init_thread_info(struct task_struct *p) { }
 #endif /* CONFIG_LIVEPATCH */
 
 #endif /* _ASM_POWERPC_LIVEPATCH_H */
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 692f7383d461..15acb282a876 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -40,7 +40,7 @@
 
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
-#include <asm/thread_info.h>
+#include <linux/thread_info.h>
 #include <asm/ptrace.h>
 #include <asm/hw_breakpoint.h>
 
@@ -326,7 +326,7 @@ struct thread_struct {
 
 #define INIT_SP		(sizeof(init_stack) + (unsigned long) &init_stack)
 #define INIT_SP_LIMIT \
-	(_ALIGN_UP(sizeof(init_thread_info), 16) + (unsigned long) &init_stack)
+	(_ALIGN_UP(sizeof(struct thread_info), 16) + (unsigned long)&init_stack)
 
 #ifdef CONFIG_SPE
 #define SPEFSCR_INIT \
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 1c98ef1f2d5b..581e61db2dcf 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1062,7 +1062,7 @@
  *	- SPRG9 debug exception scratch
  *
  * All 32-bit:
- *	- SPRG3 current thread_info pointer
+ *	- SPRG3 current thread_struct physical addr pointer
  *        (virtual on BookE, physical on others)
  *
  * 32-bit classic:
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 9ffc72ded73a..b2b52e002a76 100644
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
index 0768dfd8a64e..3f83e71ae43f 100644
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
index 435927f549c4..01d0706d873f 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -695,7 +695,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
 2:
 #endif /* CONFIG_PPC_BOOK3S_64 */
 
-	CURRENT_THREAD_INFO(r7, r8)  /* base of new stack */
+	clrrdi	r7, r8, THREAD_SHIFT	/* base of new stack */
 	/* Note: this uses SWITCH_FRAME_SIZE rather than INT_FRAME_SIZE
 	   because we don't need to leave the 288-byte ABI gap at the
 	   top of the kernel stack. */
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 05b08db3901d..8282d25948ae 100644
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
@@ -845,7 +845,7 @@ __secondary_start:
 	bl	init_idle_6xx
 #endif /* CONFIG_PPC_BOOK3S_32 */
 
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
index bf23c19c92d6..4e8c8bf50413 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -1019,7 +1019,7 @@ _GLOBAL(start_secondary_47x)
 
 	/* Now we can get our task struct and real stack pointer */
 
-	/* Get current_thread_info and current */
+	/* Get current's stack and current */
 	lis	r1,secondary_ti@ha
 	lwz	r1,secondary_ti@l(r1)
 	lwz	r2,TI_TASK(r1)
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 57deb1e9ffea..5f5f89e87e3a 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -142,7 +142,7 @@ instruction_counter:
 	tophys(r11,r1);			/* use tophys(r1) if kernel */ \
 	beq	1f;		\
 	mfspr	r11,SPRN_SPRG_THREAD;	\
-	lwz	r11,THREAD_INFO-THREAD(r11);	\
+	lwz	r11,TASK_STACK-THREAD(r11);	\
 	addi	r11,r11,THREAD_SIZE;	\
 	tophys(r11,r11);	\
 1:	subi	r11,r11,INT_FRAME_SIZE	/* alloc exc. frame */
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index 306e26c073a0..69e80e6d0d16 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -55,7 +55,7 @@ END_BTB_FLUSH_SECTION
 	beq	1f;							     \
 	BOOKE_CLEAR_BTB(r11)						\
 	/* if from user, start at top of this thread's kernel stack */       \
-	lwz	r11, THREAD_INFO-THREAD(r10);				     \
+	lwz	r11, TASK_STACK - THREAD(r10);				     \
 	ALLOC_STACK_FRAME(r11, THREAD_SIZE);				     \
 1 :	subi	r11, r11, INT_FRAME_SIZE; /* Allocate exception frame */     \
 	stw	r13, _CCR(r11);		/* save various registers */	     \
@@ -142,7 +142,7 @@ END_BTB_FLUSH_SECTION
 	BOOKE_CLEAR_BTB(r10)						\
 	andi.	r11,r11,MSR_PR;						     \
 	mfspr	r11,SPRN_SPRG_THREAD;	/* if from user, start at top of   */\
-	lwz	r11,THREAD_INFO-THREAD(r11); /* this thread's kernel stack */\
+	lwz	r11, TASK_STACK - THREAD(r11); /* this thread's kernel stack */\
 	addi	r11,r11,EXC_LVL_FRAME_OVERHEAD;	/* allocate stack frame    */\
 	beq	1f;							     \
 	/* COMING FROM USER MODE */					     \
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 2c21e8642a00..6301bb24889a 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -719,7 +719,7 @@ finish_tlb_load:
 
 	/* Get the next_tlbcam_idx percpu var */
 #ifdef CONFIG_SMP
-	lwz	r12, THREAD_INFO-THREAD(r12)
+	lwz	r12, TASK_STACK-THREAD(r12)
 	lwz	r15, TI_CPU(r12)
 	lis     r14, __per_cpu_offset@h
 	ori     r14, r14, __per_cpu_offset@l
@@ -1091,7 +1091,7 @@ __secondary_start:
 	mr	r4,r24		/* Why? */
 	bl	call_setup_cpu
 
-	/* get current_thread_info and current */
+	/* get current's stack and current */
 	lis	r1,secondary_ti@ha
 	lwz	r1,secondary_ti@l(r1)
 	lwz	r2,TI_TASK(r1)
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 4a44bc395fbc..2b152c36d7f4 100644
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
index 02b8cdd73792..b37b50fde828 100644
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
index ce393df243aa..1fc6b1d7c5fa 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1231,8 +1231,8 @@ struct task_struct *__switch_to(struct task_struct *prev,
 		batch->active = 1;
 	}
 
-	if (current_thread_info()->task->thread.regs) {
-		restore_math(current_thread_info()->task->thread.regs);
+	if (current->thread.regs) {
+		restore_math(current->thread.regs);
 
 		/*
 		 * The copy-paste buffer can only store into foreign real
@@ -1242,7 +1242,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
 		 * mappings, we must issue a cp_abort to clear any state and
 		 * prevent snooping, corruption or a covert channel.
 		 */
-		if (current_thread_info()->task->thread.used_vas)
+		if (current->thread.used_vas)
 			asm volatile(PPC_CP_ABORT);
 	}
 #endif /* CONFIG_PPC_BOOK3S_64 */
@@ -1634,7 +1634,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	unsigned long sp = (unsigned long)task_stack_page(p) + THREAD_SIZE;
 	struct thread_info *ti = task_thread_info(p);
 
-	klp_init_thread_info(ti);
+	klp_init_thread_info(p);
 
 	/* Copy registers */
 	sp -= sizeof(struct pt_regs);
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index ca00fbb97cf8..3d0dab1647fe 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -938,7 +938,7 @@ void __init setup_arch(char **cmdline_p)
 	/* Reserve large chunks of memory for use by CMA for KVM. */
 	kvm_cma_reserve();
 
-	klp_init_thread_info(&init_thread_info);
+	klp_init_thread_info(&init_task);
 
 	init_mm.start_code = (unsigned long)_stext;
 	init_mm.end_code = (unsigned long) _etext;
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 3f15edf25a0d..1d3e7cb6704d 100644
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
@@ -1017,7 +1018,8 @@ static void cpu_idle_thread_init(unsigned int cpu, struct task_struct *idle)
 
 #ifdef CONFIG_PPC64
 	paca_ptrs[cpu]->__current = idle;
-	paca_ptrs[cpu]->kstack = (unsigned long)ti + THREAD_SIZE - STACK_FRAME_OVERHEAD;
+	paca_ptrs[cpu]->kstack = (unsigned long)task_stack_page(idle) +
+				 THREAD_SIZE - STACK_FRAME_OVERHEAD;
 #endif
 	ti->cpu = cpu;
 	secondary_ti = current_set[cpu] = ti;
-- 
2.13.3


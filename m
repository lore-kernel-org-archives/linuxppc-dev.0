Return-Path: <SRS0=EZew=QM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F12C282CB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 12:09:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 387742080F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 12:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 387742080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43v3Kr20tRzDqMs
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 23:09:52 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43v2WB1bf7zDqKL
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 22:32:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43v2W94zdjz9sN9; Tue,  5 Feb 2019 22:32:53 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43v2W92h8Cz9sNM; Tue,  5 Feb 2019 22:32:53 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v16 17/21] powerpc: regain entire stack space
Date: Tue,  5 Feb 2019 22:32:15 +1100
Message-Id: <20190205113219.17903-18-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205113219.17903-1-mpe@ellerman.id.au>
References: <20190205113219.17903-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Christophe Leroy <christophe.leroy@c-s.fr>

thread_info is not anymore in the stack, so the entire stack
can now be used.

There is also no risk anymore of corrupting task_cpu(p) with a
stack overflow so the patch removes the test.

When doing this, an explicit test for NULL stack pointer is
needed in validate_sp() as it is not anymore implicitely covered
by the sizeof(thread_info) gap.

In the meantime, with the previous patch all pointers to the stacks
are not anymore pointers to thread_info so this patch changes them
to void*

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/irq.h       | 10 ++++-----
 arch/powerpc/include/asm/processor.h |  3 +--
 arch/powerpc/kernel/asm-offsets.c    |  1 -
 arch/powerpc/kernel/entry_32.S       | 14 ++++--------
 arch/powerpc/kernel/irq.c            | 19 ++++++++---------
 arch/powerpc/kernel/misc_32.S        |  6 ++----
 arch/powerpc/kernel/process.c        | 32 +++++++++++-----------------
 arch/powerpc/kernel/setup_64.c       |  8 +++----
 8 files changed, 38 insertions(+), 55 deletions(-)

diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
index 28a7ace0a1b9..c91a60cda4fa 100644
--- a/arch/powerpc/include/asm/irq.h
+++ b/arch/powerpc/include/asm/irq.h
@@ -48,16 +48,16 @@ struct pt_regs;
  * Per-cpu stacks for handling critical, debug and machine check
  * level interrupts.
  */
-extern struct thread_info *critirq_ctx[NR_CPUS];
-extern struct thread_info *dbgirq_ctx[NR_CPUS];
-extern struct thread_info *mcheckirq_ctx[NR_CPUS];
+extern void *critirq_ctx[NR_CPUS];
+extern void *dbgirq_ctx[NR_CPUS];
+extern void *mcheckirq_ctx[NR_CPUS];
 #endif
 
 /*
  * Per-cpu stacks for handling hard and soft interrupts.
  */
-extern struct thread_info *hardirq_ctx[NR_CPUS];
-extern struct thread_info *softirq_ctx[NR_CPUS];
+extern void *hardirq_ctx[NR_CPUS];
+extern void *softirq_ctx[NR_CPUS];
 
 void call_do_softirq(void *sp);
 void call_do_irq(struct pt_regs *regs, void *sp);
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 9226fb83a82e..ba2f0bc680e4 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -267,8 +267,7 @@ struct thread_struct {
 #define ARCH_MIN_TASKALIGN 16
 
 #define INIT_SP		(sizeof(init_stack) + (unsigned long) &init_stack)
-#define INIT_SP_LIMIT \
-	(_ALIGN_UP(sizeof(struct thread_info), 16) + (unsigned long)&init_stack)
+#define INIT_SP_LIMIT	((unsigned long)&init_stack)
 
 #ifdef CONFIG_SPE
 #define SPEFSCR_INIT \
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 1fb52206c106..94ac190a0b16 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -92,7 +92,6 @@ int main(void)
 	DEFINE(SIGSEGV, SIGSEGV);
 	DEFINE(NMI_MASK, NMI_MASK);
 #else
-	DEFINE(THREAD_INFO_GAP, _ALIGN_UP(sizeof(struct thread_info), 16));
 	OFFSET(KSP_LIMIT, thread_struct, ksp_limit);
 #endif /* CONFIG_PPC64 */
 	OFFSET(TASK_STACK, task_struct, stack);
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 3255c0840beb..aea22c7b891f 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -97,14 +97,11 @@
 	mfspr	r0,SPRN_SRR1
 	stw	r0,_SRR1(r11)
 
-	/* set the stack limit to the current stack
-	 * and set the limit to protect the thread_info
-	 * struct
-	 */
+	/* set the stack limit to the current stack */
 	mfspr	r8,SPRN_SPRG_THREAD
 	lwz	r0,KSP_LIMIT(r8)
 	stw	r0,SAVED_KSP_LIMIT(r11)
-	rlwimi	r0,r1,0,0,(31-THREAD_SHIFT)
+	rlwinm	r0,r1,0,0,(31 - THREAD_SHIFT)
 	stw	r0,KSP_LIMIT(r8)
 	/* fall through */
 #endif
@@ -121,14 +118,11 @@
 	mfspr	r0,SPRN_SRR1
 	stw	r0,crit_srr1@l(0)
 
-	/* set the stack limit to the current stack
-	 * and set the limit to protect the thread_info
-	 * struct
-	 */
+	/* set the stack limit to the current stack */
 	mfspr	r8,SPRN_SPRG_THREAD
 	lwz	r0,KSP_LIMIT(r8)
 	stw	r0,saved_ksp_limit@l(0)
-	rlwimi	r0,r1,0,0,(31-THREAD_SHIFT)
+	rlwinm	r0,r1,0,0,(31 - THREAD_SHIFT)
 	stw	r0,KSP_LIMIT(r8)
 	/* fall through */
 #endif
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 85c48911938a..938944c6e2ee 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -618,9 +618,8 @@ static inline void check_stack_overflow(void)
 	sp = current_stack_pointer() & (THREAD_SIZE-1);
 
 	/* check for stack overflow: is there less than 2KB free? */
-	if (unlikely(sp < (sizeof(struct thread_info) + 2048))) {
-		pr_err("do_IRQ: stack overflow: %ld\n",
-			sp - sizeof(struct thread_info));
+	if (unlikely(sp < 2048)) {
+		pr_err("do_IRQ: stack overflow: %ld\n", sp);
 		dump_stack();
 	}
 #endif
@@ -660,7 +659,7 @@ void __do_irq(struct pt_regs *regs)
 void do_IRQ(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
-	struct thread_info *curtp, *irqtp, *sirqtp;
+	void *curtp, *irqtp, *sirqtp;
 
 	/* Switch to the irq stack to handle this */
 	curtp = (void *)(current_stack_pointer() & ~(THREAD_SIZE - 1));
@@ -686,17 +685,17 @@ void __init init_IRQ(void)
 }
 
 #if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
-struct thread_info   *critirq_ctx[NR_CPUS] __read_mostly;
-struct thread_info    *dbgirq_ctx[NR_CPUS] __read_mostly;
-struct thread_info *mcheckirq_ctx[NR_CPUS] __read_mostly;
+void   *critirq_ctx[NR_CPUS] __read_mostly;
+void    *dbgirq_ctx[NR_CPUS] __read_mostly;
+void *mcheckirq_ctx[NR_CPUS] __read_mostly;
 #endif
 
-struct thread_info *softirq_ctx[NR_CPUS] __read_mostly;
-struct thread_info *hardirq_ctx[NR_CPUS] __read_mostly;
+void *softirq_ctx[NR_CPUS] __read_mostly;
+void *hardirq_ctx[NR_CPUS] __read_mostly;
 
 void do_softirq_own_stack(void)
 {
-	struct thread_info *irqtp;
+	void *irqtp;
 
 	irqtp = softirq_ctx[smp_processor_id()];
 	call_do_softirq(irqtp);
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index b37b50fde828..6f6127c3760c 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -46,11 +46,10 @@ _GLOBAL(call_do_softirq)
 	mflr	r0
 	stw	r0,4(r1)
 	lwz	r10,THREAD+KSP_LIMIT(r2)
-	addi	r11,r3,THREAD_INFO_GAP
+	stw	r3, THREAD+KSP_LIMIT(r2)
 	stwu	r1,THREAD_SIZE-STACK_FRAME_OVERHEAD(r3)
 	mr	r1,r3
 	stw	r10,8(r1)
-	stw	r11,THREAD+KSP_LIMIT(r2)
 	bl	__do_softirq
 	lwz	r10,8(r1)
 	lwz	r1,0(r1)
@@ -66,11 +65,10 @@ _GLOBAL(call_do_irq)
 	mflr	r0
 	stw	r0,4(r1)
 	lwz	r10,THREAD+KSP_LIMIT(r2)
-	addi	r11,r4,THREAD_INFO_GAP
+	stw	r4, THREAD+KSP_LIMIT(r2)
 	stwu	r1,THREAD_SIZE-STACK_FRAME_OVERHEAD(r4)
 	mr	r1,r4
 	stw	r10,8(r1)
-	stw	r11,THREAD+KSP_LIMIT(r2)
 	bl	__do_irq
 	lwz	r10,8(r1)
 	lwz	r1,0(r1)
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index d3c8af4c3a61..da82ab5dd743 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1691,8 +1691,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	sp -= STACK_FRAME_OVERHEAD;
 	p->thread.ksp = sp;
 #ifdef CONFIG_PPC32
-	p->thread.ksp_limit = (unsigned long)task_stack_page(p) +
-				_ALIGN_UP(sizeof(struct thread_info), 16);
+	p->thread.ksp_limit = (unsigned long)end_of_stack(p);
 #endif
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 	p->thread.ptrace_bps[0] = NULL;
@@ -1995,21 +1994,14 @@ static inline int valid_irq_stack(unsigned long sp, struct task_struct *p,
 	unsigned long stack_page;
 	unsigned long cpu = task_cpu(p);
 
-	/*
-	 * Avoid crashing if the stack has overflowed and corrupted
-	 * task_cpu(p), which is in the thread_info struct.
-	 */
-	if (cpu < NR_CPUS && cpu_possible(cpu)) {
-		stack_page = (unsigned long) hardirq_ctx[cpu];
-		if (sp >= stack_page + sizeof(struct thread_struct)
-		    && sp <= stack_page + THREAD_SIZE - nbytes)
-			return 1;
-
-		stack_page = (unsigned long) softirq_ctx[cpu];
-		if (sp >= stack_page + sizeof(struct thread_struct)
-		    && sp <= stack_page + THREAD_SIZE - nbytes)
-			return 1;
-	}
+	stack_page = (unsigned long)hardirq_ctx[cpu];
+	if (sp >= stack_page && sp <= stack_page + THREAD_SIZE - nbytes)
+		return 1;
+
+	stack_page = (unsigned long)softirq_ctx[cpu];
+	if (sp >= stack_page && sp <= stack_page + THREAD_SIZE - nbytes)
+		return 1;
+
 	return 0;
 }
 
@@ -2018,8 +2010,10 @@ int validate_sp(unsigned long sp, struct task_struct *p,
 {
 	unsigned long stack_page = (unsigned long)task_stack_page(p);
 
-	if (sp >= stack_page + sizeof(struct thread_struct)
-	    && sp <= stack_page + THREAD_SIZE - nbytes)
+	if (sp < THREAD_SIZE)
+		return 0;
+
+	if (sp >= stack_page && sp <= stack_page + THREAD_SIZE - nbytes)
 		return 1;
 
 	return valid_irq_stack(sp, p, nbytes);
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 0912948a8ea6..2db1c5f7d141 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -716,19 +716,19 @@ void __init emergency_stack_init(void)
 	limit = min(ppc64_bolted_size(), ppc64_rma_size);
 
 	for_each_possible_cpu(i) {
-		struct thread_info *ti;
+		void *ti;
 
 		ti = alloc_stack(limit, i);
-		paca_ptrs[i]->emergency_sp = (void *)ti + THREAD_SIZE;
+		paca_ptrs[i]->emergency_sp = ti + THREAD_SIZE;
 
 #ifdef CONFIG_PPC_BOOK3S_64
 		/* emergency stack for NMI exception handling. */
 		ti = alloc_stack(limit, i);
-		paca_ptrs[i]->nmi_emergency_sp = (void *)ti + THREAD_SIZE;
+		paca_ptrs[i]->nmi_emergency_sp = ti + THREAD_SIZE;
 
 		/* emergency stack for machine check exception handling. */
 		ti = alloc_stack(limit, i);
-		paca_ptrs[i]->mc_emergency_sp = (void *)ti + THREAD_SIZE;
+		paca_ptrs[i]->mc_emergency_sp = ti + THREAD_SIZE;
 #endif
 	}
 }
-- 
2.20.1


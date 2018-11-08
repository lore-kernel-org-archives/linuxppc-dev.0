Return-Path: <SRS0=TQYx=NT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B3AC32789
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 11:32:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E52AA208A3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 11:32:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E52AA208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rLk26VCMzF3PM
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 22:32:42 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rLN64rpgzF3N9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Nov 2018 22:17:10 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42rLN00NTkz9ty70;
 Thu,  8 Nov 2018 12:17:04 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id p5OKzlUR7PR5; Thu,  8 Nov 2018 12:17:03 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42rLMz700xz9ty6t;
 Thu,  8 Nov 2018 12:17:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9A4AB8B840;
 Thu,  8 Nov 2018 12:17:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id HlXDh2MXeFdD; Thu,  8 Nov 2018 12:17:07 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 425288B832;
 Thu,  8 Nov 2018 12:17:07 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id E7F6A6997B; Thu,  8 Nov 2018 11:17:06 +0000 (UTC)
Message-Id: <fad66673006ecd561bfe987abcaab67957776c95.1541675278.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1541675278.git.christophe.leroy@c-s.fr>
References: <cover.1541675278.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v9 5/9] powerpc: regain entire stack space
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Thu,  8 Nov 2018 11:17:06 +0000 (UTC)
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
---
 arch/powerpc/include/asm/irq.h       | 10 +++++-----
 arch/powerpc/include/asm/processor.h |  3 +--
 arch/powerpc/kernel/asm-offsets.c    |  1 -
 arch/powerpc/kernel/entry_32.S       | 14 ++++----------
 arch/powerpc/kernel/irq.c            | 19 +++++++++----------
 arch/powerpc/kernel/misc_32.S        |  6 ++----
 arch/powerpc/kernel/process.c        | 32 +++++++++++++-------------------
 arch/powerpc/kernel/setup_64.c       |  8 ++++----
 8 files changed, 38 insertions(+), 55 deletions(-)

diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
index 2efbae8d93be..966ddd4d2414 100644
--- a/arch/powerpc/include/asm/irq.h
+++ b/arch/powerpc/include/asm/irq.h
@@ -48,9 +48,9 @@ struct pt_regs;
  * Per-cpu stacks for handling critical, debug and machine check
  * level interrupts.
  */
-extern struct thread_info *critirq_ctx[NR_CPUS];
-extern struct thread_info *dbgirq_ctx[NR_CPUS];
-extern struct thread_info *mcheckirq_ctx[NR_CPUS];
+extern void *critirq_ctx[NR_CPUS];
+extern void *dbgirq_ctx[NR_CPUS];
+extern void *mcheckirq_ctx[NR_CPUS];
 extern void exc_lvl_ctx_init(void);
 #else
 #define exc_lvl_ctx_init()
@@ -59,8 +59,8 @@ extern void exc_lvl_ctx_init(void);
 /*
  * Per-cpu stacks for handling hard and soft interrupts.
  */
-extern struct thread_info *hardirq_ctx[NR_CPUS];
-extern struct thread_info *softirq_ctx[NR_CPUS];
+extern void *hardirq_ctx[NR_CPUS];
+extern void *softirq_ctx[NR_CPUS];
 
 extern void irq_ctx_init(void);
 void call_do_softirq(void *sp);
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 15acb282a876..8179b64871ed 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -325,8 +325,7 @@ struct thread_struct {
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
index fa7a69ffb37a..bd3b146e18a3 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -97,14 +97,11 @@ crit_transfer_to_handler:
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
@@ -121,14 +118,11 @@ crit_transfer_to_handler:
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
index 3fdb6b6973cf..62cfccf4af89 100644
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
@@ -690,9 +689,9 @@ void __init init_IRQ(void)
 }
 
 #if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
-struct thread_info   *critirq_ctx[NR_CPUS] __read_mostly;
-struct thread_info    *dbgirq_ctx[NR_CPUS] __read_mostly;
-struct thread_info *mcheckirq_ctx[NR_CPUS] __read_mostly;
+void   *critirq_ctx[NR_CPUS] __read_mostly;
+void    *dbgirq_ctx[NR_CPUS] __read_mostly;
+void *mcheckirq_ctx[NR_CPUS] __read_mostly;
 
 void exc_lvl_ctx_init(void)
 {
@@ -718,8 +717,8 @@ void exc_lvl_ctx_init(void)
 }
 #endif
 
-struct thread_info *softirq_ctx[NR_CPUS] __read_mostly;
-struct thread_info *hardirq_ctx[NR_CPUS] __read_mostly;
+void *softirq_ctx[NR_CPUS] __read_mostly;
+void *hardirq_ctx[NR_CPUS] __read_mostly;
 
 void irq_ctx_init(void)
 {
@@ -733,7 +732,7 @@ void irq_ctx_init(void)
 
 void do_softirq_own_stack(void)
 {
-	struct thread_info *irqtp;
+	void *irqtp;
 
 	irqtp = softirq_ctx[smp_processor_id()];
 	call_do_softirq(irqtp);
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 32762f4c3458..a3663ad62f16 100644
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
index 6a43d8395553..b9ab0467987f 100644
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
index 877ec9d52827..be6a2ea250a0 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -716,22 +716,22 @@ void __init emergency_stack_init(void)
 	limit = min(ppc64_bolted_size(), ppc64_rma_size);
 
 	for_each_possible_cpu(i) {
-		struct thread_info *ti;
+		void *ti;
 
 		ti = alloc_stack(limit, i);
 		memset(ti, 0, THREAD_SIZE);
-		paca_ptrs[i]->emergency_sp = (void *)ti + THREAD_SIZE;
+		paca_ptrs[i]->emergency_sp = ti + THREAD_SIZE;
 
 #ifdef CONFIG_PPC_BOOK3S_64
 		/* emergency stack for NMI exception handling. */
 		ti = alloc_stack(limit, i);
 		memset(ti, 0, THREAD_SIZE);
-		paca_ptrs[i]->nmi_emergency_sp = (void *)ti + THREAD_SIZE;
+		paca_ptrs[i]->nmi_emergency_sp = ti + THREAD_SIZE;
 
 		/* emergency stack for machine check exception handling. */
 		ti = alloc_stack(limit, i);
 		memset(ti, 0, THREAD_SIZE);
-		paca_ptrs[i]->mc_emergency_sp = (void *)ti + THREAD_SIZE;
+		paca_ptrs[i]->mc_emergency_sp = ti + THREAD_SIZE;
 #endif
 	}
 }
-- 
2.13.3


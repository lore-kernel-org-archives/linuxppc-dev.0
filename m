Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCD8C43143
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 12:48:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE3D82084C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 12:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE3D82084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42P2BQ5sN4zF31s
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 22:47:58 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42P1pK0JS2zF31T
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Oct 2018 22:30:33 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42P1p63BwTz9ttFW;
 Mon,  1 Oct 2018 14:30:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id EM14h9VFGjR3; Mon,  1 Oct 2018 14:30:22 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42P1p61PpNz9ttFT;
 Mon,  1 Oct 2018 14:30:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 64EA08B978;
 Mon,  1 Oct 2018 14:30:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id rZ2Pv_O5VFzh; Mon,  1 Oct 2018 14:30:29 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C83458B95C;
 Mon,  1 Oct 2018 14:30:28 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id C79736F36F; Mon,  1 Oct 2018 12:30:25 +0000 (UTC)
Message-Id: <8108de51846b7b34e4732753b2b65e435b6a2b7a.1538396659.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1538396658.git.christophe.leroy@c-s.fr>
References: <cover.1538396658.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v3 4/7] powerpc: regain entire stack space
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com
Date: Mon,  1 Oct 2018 12:30:25 +0000 (UTC)
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

In the meantime, all pointers to the stacks are not anymore
pointers to thread_info so this patch changes them to void*

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/irq.h       | 10 +++++-----
 arch/powerpc/include/asm/processor.h |  3 +--
 arch/powerpc/kernel/asm-offsets.c    |  1 -
 arch/powerpc/kernel/entry_32.S       | 14 ++++----------
 arch/powerpc/kernel/irq.c            | 19 +++++++++----------
 arch/powerpc/kernel/misc_32.S        |  6 ++----
 arch/powerpc/kernel/process.c        |  9 +++------
 arch/powerpc/kernel/setup_64.c       |  8 ++++----
 8 files changed, 28 insertions(+), 42 deletions(-)

diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
index 8108d1fe33ca..3987929408d3 100644
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
 extern void call_do_softirq(void *tp);
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 31873614392f..834d0d701e19 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -332,8 +332,7 @@ struct thread_struct {
 #define ARCH_MIN_TASKALIGN 16
 
 #define INIT_SP		(sizeof(init_stack) + (unsigned long) &init_stack)
-#define INIT_SP_LIMIT \
-	(_ALIGN_UP(sizeof(struct thread_info), 16) + (unsigned long) &init_stack)
+#define INIT_SP_LIMIT	((unsigned long) &init_stack)
 
 #ifdef CONFIG_SPE
 #define SPEFSCR_INIT \
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index b042d85325f5..ae7eda4ca09e 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -85,7 +85,6 @@ int main(void)
 	DEFINE(NMI_MASK, NMI_MASK);
 	OFFSET(TASKTHREADPPR, task_struct, thread.ppr);
 #else
-	DEFINE(THREAD_INFO_GAP, _ALIGN_UP(sizeof(struct thread_info), 16));
 	OFFSET(KSP_LIMIT, thread_struct, ksp_limit);
 #endif /* CONFIG_PPC64 */
 	OFFSET(TASK_STACK, task_struct, stack);
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index a14f9b5f2762..b45da00b01ef 100644
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
index 699f0f816687..00dbee440bc2 100644
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
 	curtp = (void*)(current_stack_pointer() & ~(THREAD_SIZE - 1));
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
index 24a7f18ea10c..d3ba56307eb4 100644
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
index 111abb4df2ec..1e01bf42dc82 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1691,8 +1691,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	sp -= STACK_FRAME_OVERHEAD;
 	p->thread.ksp = sp;
 #ifdef CONFIG_PPC32
-	p->thread.ksp_limit = (unsigned long)task_stack_page(p) +
-				_ALIGN_UP(sizeof(struct thread_info), 16);
+	p->thread.ksp_limit = (unsigned long)task_stack_page(p);
 #endif
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 	p->thread.ptrace_bps[0] = NULL;
@@ -2001,13 +2000,11 @@ static inline int valid_irq_stack(unsigned long sp, struct task_struct *p,
 	 */
 	if (cpu < NR_CPUS && cpu_possible(cpu)) {
 		stack_page = (unsigned long) hardirq_ctx[cpu];
-		if (sp >= stack_page + sizeof(struct thread_struct)
-		    && sp <= stack_page + THREAD_SIZE - nbytes)
+		if (sp >= stack_page && sp <= stack_page + THREAD_SIZE - nbytes)
 			return 1;
 
 		stack_page = (unsigned long) softirq_ctx[cpu];
-		if (sp >= stack_page + sizeof(struct thread_struct)
-		    && sp <= stack_page + THREAD_SIZE - nbytes)
+		if (sp >= stack_page && sp <= stack_page + THREAD_SIZE - nbytes)
 			return 1;
 	}
 	return 0;
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 2d682f3e31c6..6792e9c90689 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -717,22 +717,22 @@ void __init emergency_stack_init(void)
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


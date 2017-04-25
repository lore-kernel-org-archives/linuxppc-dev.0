Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wC8300GgKzDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 02:35:39 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3PGXq94113569
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 12:35:34 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2a283xeg46-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 12:35:34 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 26 Apr 2017 02:35:31 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3PGZKxT18940086
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 02:35:28 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3PGYoIT014442
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 02:34:51 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anton Blanchard <anton@samba.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/4] powerpc/kprobes: blacklist functions involved when
 returning from exception
Date: Tue, 25 Apr 2017 22:04:09 +0530
In-Reply-To: <cover.1493137432.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1493137432.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1493137432.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1493137432.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <ccf47a52e2d0f52cdaffba24880ec3d3c8a56d63.1493137432.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Blacklist all functions involved when we return from a trap. We:
- convert some of the labels into private labels,
- remove the duplicate 'restore' label, and
- blacklist most functions involved during returning from a trap.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/entry_64.S | 46 ++++++++++++++++++++++++------------------
 arch/powerpc/kernel/traps.c    |  1 +
 2 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 22aaa377149f..e7e05eb590a5 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -184,7 +184,7 @@ __system_call:
 #ifdef CONFIG_PPC_BOOK3S
 	/* No MSR:RI on BookE */
 	andi.	r10,r8,MSR_RI
-	beq-	unrecov_restore
+	beq-	.Lunrecov_restore
 #endif
 	/*
 	 * Disable interrupts so current_thread_info()->flags can't change,
@@ -643,18 +643,18 @@ _GLOBAL(ret_from_except_lite)
 	 * Use the internal debug mode bit to do this.
 	 */
 	andis.	r0,r3,DBCR0_IDM@h
-	beq	restore
+	beq	fast_exc_return_irq
 	mfmsr	r0
 	rlwinm	r0,r0,0,~MSR_DE	/* Clear MSR.DE */
 	mtmsr	r0
 	mtspr	SPRN_DBCR0,r3
 	li	r10, -1
 	mtspr	SPRN_DBSR,r10
-	b	restore
+	b	fast_exc_return_irq
 #else
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	restore_math
-	b	restore
+	b	fast_exc_return_irq
 #endif
 1:	andi.	r0,r4,_TIF_NEED_RESCHED
 	beq	2f
@@ -667,7 +667,7 @@ _GLOBAL(ret_from_except_lite)
 	bne	3f		/* only restore TM if nothing else to do */
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	restore_tm_state
-	b	restore
+	b	fast_exc_return_irq
 3:
 #endif
 	bl	save_nvgprs
@@ -719,14 +719,14 @@ resume_kernel:
 #ifdef CONFIG_PREEMPT
 	/* Check if we need to preempt */
 	andi.	r0,r4,_TIF_NEED_RESCHED
-	beq+	restore
+	beq+	fast_exc_return_irq
 	/* Check that preempt_count() == 0 and interrupts are enabled */
 	lwz	r8,TI_PREEMPT(r9)
 	cmpwi	cr1,r8,0
 	ld	r0,SOFTE(r1)
 	cmpdi	r0,0
 	crandc	eq,cr1*4+eq,eq
-	bne	restore
+	bne	fast_exc_return_irq
 
 	/*
 	 * Here we are preempting the current task. We want to make
@@ -757,7 +757,6 @@ resume_kernel:
 
 	.globl	fast_exc_return_irq
 fast_exc_return_irq:
-restore:
 	/*
 	 * This is the main kernel exit path. First we check if we
 	 * are about to re-enable interrupts
@@ -765,11 +764,11 @@ restore:
 	ld	r5,SOFTE(r1)
 	lbz	r6,PACASOFTIRQEN(r13)
 	cmpwi	cr0,r5,0
-	beq	restore_irq_off
+	beq	.Lrestore_irq_off
 
 	/* We are enabling, were we already enabled ? Yes, just return */
 	cmpwi	cr0,r6,1
-	beq	cr0,do_restore
+	beq	cr0,.Ldo_restore
 
 	/*
 	 * We are about to soft-enable interrupts (we are hard disabled
@@ -778,14 +777,14 @@ restore:
 	 */
 	lbz	r0,PACAIRQHAPPENED(r13)
 	cmpwi	cr0,r0,0
-	bne-	restore_check_irq_replay
+	bne-	.Lrestore_check_irq_replay
 
 	/*
 	 * Get here when nothing happened while soft-disabled, just
 	 * soft-enable and move-on. We will hard-enable as a side
 	 * effect of rfi
 	 */
-restore_no_replay:
+.Lrestore_no_replay:
 	TRACE_ENABLE_INTS
 	li	r0,1
 	stb	r0,PACASOFTIRQEN(r13);
@@ -793,7 +792,7 @@ restore_no_replay:
 	/*
 	 * Final return path. BookE is handled in a different file
 	 */
-do_restore:
+.Ldo_restore:
 #ifdef CONFIG_PPC_BOOK3E
 	b	exception_return_book3e
 #else
@@ -827,7 +826,7 @@ fast_exception_return:
 	REST_8GPRS(5, r1)
 
 	andi.	r0,r3,MSR_RI
-	beq-	unrecov_restore
+	beq-	.Lunrecov_restore
 
 	/* Load PPR from thread struct before we clear MSR:RI */
 BEGIN_FTR_SECTION
@@ -885,7 +884,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	 * make sure that in this case, we also clear PACA_IRQ_HARD_DIS
 	 * or that bit can get out of sync and bad things will happen
 	 */
-restore_irq_off:
+.Lrestore_irq_off:
 	ld	r3,_MSR(r1)
 	lbz	r7,PACAIRQHAPPENED(r13)
 	andi.	r0,r3,MSR_EE
@@ -895,13 +894,13 @@ restore_irq_off:
 1:	li	r0,0
 	stb	r0,PACASOFTIRQEN(r13);
 	TRACE_DISABLE_INTS
-	b	do_restore
+	b	.Ldo_restore
 
 	/*
 	 * Something did happen, check if a re-emit is needed
 	 * (this also clears paca->irq_happened)
 	 */
-restore_check_irq_replay:
+.Lrestore_check_irq_replay:
 	/* XXX: We could implement a fast path here where we check
 	 * for irq_happened being just 0x01, in which case we can
 	 * clear it and return. That means that we would potentially
@@ -911,7 +910,7 @@ restore_check_irq_replay:
 	 */
 	bl	__check_irq_replay
 	cmpwi	cr0,r3,0
- 	beq	restore_no_replay
+	beq	.Lrestore_no_replay
  
 	/*
 	 * We need to re-emit an interrupt. We do so by re-using our
@@ -960,10 +959,17 @@ restore_check_irq_replay:
 #endif /* CONFIG_PPC_DOORBELL */
 1:	b	ret_from_except /* What else to do here ? */
  
-unrecov_restore:
+.Lunrecov_restore:
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	unrecoverable_exception
-	b	unrecov_restore
+	b	.Lunrecov_restore
+
+_ASM_NOKPROBE_SYMBOL(ret_from_except);
+_ASM_NOKPROBE_SYMBOL(ret_from_except_lite);
+_ASM_NOKPROBE_SYMBOL(resume_kernel);
+_ASM_NOKPROBE_SYMBOL(fast_exc_return_irq);
+_ASM_NOKPROBE_SYMBOL(fast_exception_return);
+
 
 #ifdef CONFIG_PPC_RTAS
 /*
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index ece130515cd0..8ce51787b2ba 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1952,6 +1952,7 @@ void unrecoverable_exception(struct pt_regs *regs)
 	       regs->trap, regs->nip);
 	die("Unrecoverable exception", regs, SIGABRT);
 }
+NOKPROBE_SYMBOL(unrecoverable_exception);
 
 #if defined(CONFIG_BOOKE_WDT) || defined(CONFIG_40x)
 /*
-- 
2.12.1

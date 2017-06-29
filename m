Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wz6d91ptzzDr52
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 03:50:21 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5THmndu103348
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 13:50:18 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bd4ewmygh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 13:50:18 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 30 Jun 2017 03:50:15 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5THoDkl66519176
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 03:50:13 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5THoCpf031333
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 03:50:13 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 6/7] powerpc/64s: Blacklist functions invoked on a trap
Date: Thu, 29 Jun 2017 23:19:19 +0530
In-Reply-To: <cover.1498755960.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1498755960.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1498755960.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1498755960.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <79cb0abff58e2e58a894bc96e75cca5f00cfb16b.1498755960.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Blacklist all functions involved while handling a trap. We:
- convert some of the symbols into private symbols, and
- blacklist most functions involved while handling a trap.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/entry_64.S       | 35 ++++++++++++++++++++++-------------
 arch/powerpc/kernel/exceptions-64s.S |  2 ++
 arch/powerpc/kernel/traps.c          |  3 +++
 3 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 5b919b2a62da..d1690ccfde0a 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -185,7 +185,7 @@ system_call:			/* label this so stack traces look sane */
 #ifdef CONFIG_PPC_BOOK3S
 	/* No MSR:RI on BookE */
 	andi.	r10,r8,MSR_RI
-	beq-	unrecov_restore
+	beq-	.Lunrecov_restore
 #endif
 
 /*
@@ -436,6 +436,7 @@ _GLOBAL(save_nvgprs)
 	clrrdi	r0,r11,1
 	std	r0,_TRAP(r1)
 	blr
+_ASM_NOKPROBE_SYMBOL(save_nvgprs);
 
 	
 /*
@@ -806,11 +807,11 @@ restore:
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
@@ -819,14 +820,14 @@ restore:
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
@@ -834,7 +835,7 @@ restore_no_replay:
 	/*
 	 * Final return path. BookE is handled in a different file
 	 */
-do_restore:
+.Ldo_restore:
 #ifdef CONFIG_PPC_BOOK3E
 	b	exception_return_book3e
 #else
@@ -868,7 +869,7 @@ fast_exception_return:
 	REST_8GPRS(5, r1)
 
 	andi.	r0,r3,MSR_RI
-	beq-	unrecov_restore
+	beq-	.Lunrecov_restore
 
 	/* Load PPR from thread struct before we clear MSR:RI */
 BEGIN_FTR_SECTION
@@ -926,7 +927,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	 * make sure that in this case, we also clear PACA_IRQ_HARD_DIS
 	 * or that bit can get out of sync and bad things will happen
 	 */
-restore_irq_off:
+.Lrestore_irq_off:
 	ld	r3,_MSR(r1)
 	lbz	r7,PACAIRQHAPPENED(r13)
 	andi.	r0,r3,MSR_EE
@@ -936,13 +937,13 @@ restore_irq_off:
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
@@ -952,7 +953,7 @@ restore_check_irq_replay:
 	 */
 	bl	__check_irq_replay
 	cmpwi	cr0,r3,0
- 	beq	restore_no_replay
+	beq	.Lrestore_no_replay
  
 	/*
 	 * We need to re-emit an interrupt. We do so by re-using our
@@ -1001,10 +1002,18 @@ restore_check_irq_replay:
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
+_ASM_NOKPROBE_SYMBOL(restore);
+_ASM_NOKPROBE_SYMBOL(fast_exception_return);
+
 
 #ifdef CONFIG_PPC_RTAS
 /*
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 3262e447b895..20318ceeea6a 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1591,6 +1591,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 1:	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	kernel_bad_stack
 	b	1b
+_ASM_NOKPROBE_SYMBOL(bad_stack);
 
 /*
  * When doorbell is triggered from system reset wakeup, the message is
@@ -1652,3 +1653,4 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
 1:
 	blr
 
+_ASM_NOKPROBE_SYMBOL(__replay_interrupt)
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index d4e545d27ef9..bfcfd9ef09f2 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -237,6 +237,7 @@ void die(const char *str, struct pt_regs *regs, long err)
 		err = 0;
 	oops_end(flags, regs, err);
 }
+NOKPROBE_SYMBOL(die);
 
 void user_single_step_siginfo(struct task_struct *tsk,
 				struct pt_regs *regs, siginfo_t *info)
@@ -1968,6 +1969,7 @@ void unrecoverable_exception(struct pt_regs *regs)
 	       regs->trap, regs->nip);
 	die("Unrecoverable exception", regs, SIGABRT);
 }
+NOKPROBE_SYMBOL(unrecoverable_exception);
 
 #if defined(CONFIG_BOOKE_WDT) || defined(CONFIG_40x)
 /*
@@ -1998,6 +2000,7 @@ void kernel_bad_stack(struct pt_regs *regs)
 	       regs->gpr[1], regs->nip);
 	die("Bad kernel stack pointer", regs, SIGABRT);
 }
+NOKPROBE_SYMBOL(kernel_bad_stack);
 
 void __init trap_init(void)
 {
-- 
2.13.1

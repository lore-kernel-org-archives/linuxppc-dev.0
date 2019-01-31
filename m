Return-Path: <SRS0=ULCe=QH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B536AC169C4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 10:31:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32780218AC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 10:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="J+Pi1VxR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32780218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qxN86TWYzDqLd
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 21:31:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="J+Pi1VxR"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qwts1GD2zDqQ3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 21:09:08 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43qwtm5GQwz9tyxG;
 Thu, 31 Jan 2019 11:09:04 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=J+Pi1VxR; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id SrGIw4wQYjHt; Thu, 31 Jan 2019 11:09:04 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43qwtm4D2tz9tyx9;
 Thu, 31 Jan 2019 11:09:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1548929344; bh=gmz5QAlEOncgdeYDyRDfyPxDXqImup+GgKeyTTl5GoA=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=J+Pi1VxR+JDIAw2MIQ0UMQFvFxQtVOHJo9t5ZksGDRf/cMMx3slPF3EJnbAQVD9KB
 zJFJhHwkeNEs5QIUDVhE2YWzB8jGJmoU+LjrKEVk0lapQShOOvTae2s1vNfeeNa1e4
 SbdAPuqB+pL7bfynenGTDNJnKkfOE5tNlwq51Yt4=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B3CBB8B814;
 Thu, 31 Jan 2019 11:09:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 5VhqOtMZ7tEQ; Thu, 31 Jan 2019 11:09:05 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 5A6258B78D;
 Thu, 31 Jan 2019 11:09:05 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id D273272E14; Thu, 31 Jan 2019 10:09:04 +0000 (UTC)
Message-Id: <bee71f467828ac95a2201f39f52dad2470ab7aa7.1548852243.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1548852242.git.christophe.leroy@c-s.fr>
References: <cover.1548852242.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v15 11/13] powerpc/32: Remove CURRENT_THREAD_INFO and rename
 TI_CPU
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
Date: Thu, 31 Jan 2019 10:09:04 +0000 (UTC)
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

Now that thread_info is similar to task_struct, its address is in r2
so CURRENT_THREAD_INFO() macro is useless. This patch removes it.

This patch also moves the 'tovirt(r2, r2)' down just before the
reactivation of MMU translation, so that we keep the physical address
of 'current' in r2 until then. It avoids a few calls to tophys().

At the same time, as the 'cpu' field is not anymore in thread_info,
TI_CPU is renamed TASK_CPU by this patch.

It also allows to get rid of a couple of
'#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE' as ACCOUNT_CPU_USER_ENTRY()
and ACCOUNT_CPU_USER_EXIT() are empty when
CONFIG_VIRT_CPU_ACCOUNTING_NATIVE is not defined.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Makefile                  |  2 +-
 arch/powerpc/include/asm/thread_info.h |  2 --
 arch/powerpc/kernel/asm-offsets.c      |  2 +-
 arch/powerpc/kernel/entry_32.S         | 55 +++++++++++-----------------------
 arch/powerpc/kernel/epapr_hcalls.S     |  5 ++--
 arch/powerpc/kernel/head_fsl_booke.S   |  5 ++--
 arch/powerpc/kernel/idle_6xx.S         |  9 ++----
 arch/powerpc/kernel/idle_e500.S        |  8 ++---
 arch/powerpc/kernel/misc_32.S          |  3 +-
 arch/powerpc/mm/hash_low_32.S          | 14 ++++-----
 arch/powerpc/sysdev/6xx-suspend.S      |  5 ++--
 11 files changed, 38 insertions(+), 72 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 53ffe935f3b0..7de49889bd5d 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -431,7 +431,7 @@ ifdef CONFIG_SMP
 prepare: task_cpu_prepare
 
 task_cpu_prepare: prepare0
-	$(eval KBUILD_CFLAGS += -D_TASK_CPU=$(shell awk '{if ($$2 == "TI_CPU") print $$3;}' include/generated/asm-offsets.h))
+	$(eval KBUILD_CFLAGS += -D_TASK_CPU=$(shell awk '{if ($$2 == "TASK_CPU") print $$3;}' include/generated/asm-offsets.h))
 endif
 
 # Check toolchain versions:
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index d91523c2c7d8..c959b8d66cac 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -19,8 +19,6 @@
 
 #ifdef CONFIG_PPC64
 #define CURRENT_THREAD_INFO(dest, sp)	stringify_in_c(ld dest, PACACURRENT(r13))
-#else
-#define CURRENT_THREAD_INFO(dest, sp)	stringify_in_c(mr dest, r2)
 #endif
 
 #ifndef __ASSEMBLY__
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 94ac190a0b16..03439785c2ea 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -96,7 +96,7 @@ int main(void)
 #endif /* CONFIG_PPC64 */
 	OFFSET(TASK_STACK, task_struct, stack);
 #ifdef CONFIG_SMP
-	OFFSET(TI_CPU, task_struct, cpu);
+	OFFSET(TASK_CPU, task_struct, cpu);
 #endif
 
 #ifdef CONFIG_LIVEPATCH
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index aea22c7b891f..a5e2d5585dcb 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -151,7 +151,6 @@ transfer_to_handler:
 	stw	r2,_XER(r11)
 	mfspr	r12,SPRN_SPRG_THREAD
 	addi	r2,r12,-THREAD
-	tovirt(r2,r2)			/* set r2 to current */
 	beq	2f			/* if from user, fix up THREAD.regs */
 	addi	r11,r1,STACK_FRAME_OVERHEAD
 	stw	r11,PT_REGS(r12)
@@ -161,11 +160,7 @@ transfer_to_handler:
 	lwz	r12,THREAD_DBCR0(r12)
 	andis.	r12,r12,DBCR0_IDM@h
 #endif
-#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
-	CURRENT_THREAD_INFO(r9, r1)
-	tophys(r9, r9)
-	ACCOUNT_CPU_USER_ENTRY(r9, r11, r12)
-#endif
+	ACCOUNT_CPU_USER_ENTRY(r2, r11, r12)
 #if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
 	beq+	3f
 	/* From user and task is ptraced - load up global dbcr0 */
@@ -175,8 +170,7 @@ transfer_to_handler:
 	tophys(r11,r11)
 	addi	r11,r11,global_dbcr0@l
 #ifdef CONFIG_SMP
-	CURRENT_THREAD_INFO(r9, r1)
-	lwz	r9,TI_CPU(r9)
+	lwz	r9,TASK_CPU(r2)
 	slwi	r9,r9,3
 	add	r11,r11,r9
 #endif
@@ -197,9 +191,7 @@ transfer_to_handler:
 	ble-	stack_ovf		/* then the kernel stack overflowed */
 5:
 #if defined(CONFIG_PPC_BOOK3S_32) || defined(CONFIG_E500)
-	CURRENT_THREAD_INFO(r9, r1)
-	tophys(r9,r9)			/* check local flags */
-	lwz	r12,TI_LOCAL_FLAGS(r9)
+	lwz	r12,TI_LOCAL_FLAGS(r2)
 	mtcrf	0x01,r12
 	bt-	31-TLF_NAPPING,4f
 	bt-	31-TLF_SLEEPING,7f
@@ -208,6 +200,7 @@ transfer_to_handler:
 transfer_to_handler_cont:
 3:
 	mflr	r9
+	tovirt(r2, r2)			/* set r2 to current */
 	lwz	r11,0(r9)		/* virtual address of handler */
 	lwz	r9,4(r9)		/* where to go when done */
 #if defined(CONFIG_PPC_8xx) && defined(CONFIG_PERF_EVENTS)
@@ -271,11 +264,11 @@ reenable_mmu:				/* re-enable mmu so we can */
 
 #if defined (CONFIG_PPC_BOOK3S_32) || defined(CONFIG_E500)
 4:	rlwinm	r12,r12,0,~_TLF_NAPPING
-	stw	r12,TI_LOCAL_FLAGS(r9)
+	stw	r12,TI_LOCAL_FLAGS(r2)
 	b	power_save_ppc32_restore
 
 7:	rlwinm	r12,r12,0,~_TLF_SLEEPING
-	stw	r12,TI_LOCAL_FLAGS(r9)
+	stw	r12,TI_LOCAL_FLAGS(r2)
 	lwz	r9,_MSR(r11)		/* if sleeping, clear MSR.EE */
 	rlwinm	r9,r9,0,~MSR_EE
 	lwz	r12,_LINK(r11)		/* and return to address in LR */
@@ -347,8 +340,7 @@ _GLOBAL(DoSyscall)
 	mtmsr	r11
 1:
 #endif /* CONFIG_TRACE_IRQFLAGS */
-	CURRENT_THREAD_INFO(r10, r1)
-	lwz	r11,TI_FLAGS(r10)
+	lwz	r11,TI_FLAGS(r2)
 	andi.	r11,r11,_TIF_SYSCALL_DOTRACE
 	bne-	syscall_dotrace
 syscall_dotrace_cont:
@@ -381,13 +373,12 @@ ret_from_syscall:
 	lwz	r3,GPR3(r1)
 #endif
 	mr	r6,r3
-	CURRENT_THREAD_INFO(r12, r1)
 	/* disable interrupts so current_thread_info()->flags can't change */
 	LOAD_MSR_KERNEL(r10,MSR_KERNEL)	/* doesn't include MSR_EE */
 	/* Note: We don't bother telling lockdep about it */
 	SYNC
 	MTMSRD(r10)
-	lwz	r9,TI_FLAGS(r12)
+	lwz	r9,TI_FLAGS(r2)
 	li	r8,-MAX_ERRNO
 	andi.	r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
 	bne-	syscall_exit_work
@@ -434,8 +425,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 	andi.	r4,r8,MSR_PR
 	beq	3f
-	CURRENT_THREAD_INFO(r4, r1)
-	ACCOUNT_CPU_USER_EXIT(r4, r5, r7)
+	ACCOUNT_CPU_USER_EXIT(r2, r5, r7)
 3:
 #endif
 	lwz	r4,_LINK(r1)
@@ -528,7 +518,7 @@ syscall_exit_work:
 	/* Clear per-syscall TIF flags if any are set.  */
 
 	li	r11,_TIF_PERSYSCALL_MASK
-	addi	r12,r12,TI_FLAGS
+	addi	r12,r2,TI_FLAGS
 3:	lwarx	r8,0,r12
 	andc	r8,r8,r11
 #ifdef CONFIG_IBM405_ERR77
@@ -536,7 +526,6 @@ syscall_exit_work:
 #endif
 	stwcx.	r8,0,r12
 	bne-	3b
-	subi	r12,r12,TI_FLAGS
 	
 4:	/* Anything which requires enabling interrupts? */
 	andi.	r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP)
@@ -815,8 +804,7 @@ ret_from_except:
 
 user_exc_return:		/* r10 contains MSR_KERNEL here */
 	/* Check current_thread_info()->flags */
-	CURRENT_THREAD_INFO(r9, r1)
-	lwz	r9,TI_FLAGS(r9)
+	lwz	r9,TI_FLAGS(r2)
 	andi.	r0,r9,_TIF_USER_WORK_MASK
 	bne	do_work
 
@@ -828,18 +816,14 @@ restore_user:
 	andis.	r10,r0,DBCR0_IDM@h
 	bnel-	load_dbcr0
 #endif
-#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
-	CURRENT_THREAD_INFO(r9, r1)
-	ACCOUNT_CPU_USER_EXIT(r9, r10, r11)
-#endif
+	ACCOUNT_CPU_USER_EXIT(r2, r10, r11)
 
 	b	restore
 
 /* N.B. the only way to get here is from the beq following ret_from_except. */
 resume_kernel:
 	/* check current_thread_info, _TIF_EMULATE_STACK_STORE */
-	CURRENT_THREAD_INFO(r9, r1)
-	lwz	r8,TI_FLAGS(r9)
+	lwz	r8,TI_FLAGS(r2)
 	andis.	r0,r8,_TIF_EMULATE_STACK_STORE@h
 	beq+	1f
 
@@ -865,7 +849,7 @@ resume_kernel:
 
 	/* Clear _TIF_EMULATE_STACK_STORE flag */
 	lis	r11,_TIF_EMULATE_STACK_STORE@h
-	addi	r5,r9,TI_FLAGS
+	addi	r5,r2,TI_FLAGS
 0:	lwarx	r8,0,r5
 	andc	r8,r8,r11
 #ifdef CONFIG_IBM405_ERR77
@@ -877,7 +861,7 @@ resume_kernel:
 
 #ifdef CONFIG_PREEMPT
 	/* check current_thread_info->preempt_count */
-	lwz	r0,TI_PREEMPT(r9)
+	lwz	r0,TI_PREEMPT(r2)
 	cmpwi	0,r0,0		/* if non-zero, just restore regs and return */
 	bne	restore
 	andi.	r8,r8,_TIF_NEED_RESCHED
@@ -893,8 +877,7 @@ resume_kernel:
 	bl	trace_hardirqs_off
 #endif
 1:	bl	preempt_schedule_irq
-	CURRENT_THREAD_INFO(r9, r1)
-	lwz	r3,TI_FLAGS(r9)
+	lwz	r3,TI_FLAGS(r2)
 	andi.	r0,r3,_TIF_NEED_RESCHED
 	bne-	1b
 #ifdef CONFIG_TRACE_IRQFLAGS
@@ -1193,8 +1176,7 @@ load_dbcr0:
 	lis	r11,global_dbcr0@ha
 	addi	r11,r11,global_dbcr0@l
 #ifdef CONFIG_SMP
-	CURRENT_THREAD_INFO(r9, r1)
-	lwz	r9,TI_CPU(r9)
+	lwz	r9,TASK_CPU(r2)
 	slwi	r9,r9,3
 	add	r11,r11,r9
 #endif
@@ -1234,8 +1216,7 @@ recheck:
 	LOAD_MSR_KERNEL(r10,MSR_KERNEL)
 	SYNC
 	MTMSRD(r10)		/* disable interrupts */
-	CURRENT_THREAD_INFO(r9, r1)
-	lwz	r9,TI_FLAGS(r9)
+	lwz	r9,TI_FLAGS(r2)
 	andi.	r0,r9,_TIF_NEED_RESCHED
 	bne-	do_resched
 	andi.	r0,r9,_TIF_USER_WORK_MASK
diff --git a/arch/powerpc/kernel/epapr_hcalls.S b/arch/powerpc/kernel/epapr_hcalls.S
index 52ca2471ee1a..d252f4663a23 100644
--- a/arch/powerpc/kernel/epapr_hcalls.S
+++ b/arch/powerpc/kernel/epapr_hcalls.S
@@ -21,10 +21,9 @@
 #ifndef CONFIG_PPC64
 /* epapr_ev_idle() was derived from e500_idle() */
 _GLOBAL(epapr_ev_idle)
-	CURRENT_THREAD_INFO(r3, r1)
-	PPC_LL	r4, TI_LOCAL_FLAGS(r3)	/* set napping bit */
+	PPC_LL	r4, TI_LOCAL_FLAGS(r2)	/* set napping bit */
 	ori	r4, r4,_TLF_NAPPING	/* so when we take an exception */
-	PPC_STL	r4, TI_LOCAL_FLAGS(r3)	/* it will return to our caller */
+	PPC_STL	r4, TI_LOCAL_FLAGS(r2)	/* it will return to our caller */
 
 	wrteei	1
 
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 4ed2a7c8e89b..1881127682e9 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -244,8 +244,7 @@ set_ivor:
 	stwu	r0,THREAD_SIZE-STACK_FRAME_OVERHEAD(r1)
 
 #ifdef CONFIG_SMP
-	CURRENT_THREAD_INFO(r22, r1)
-	stw	r24, TI_CPU(r22)
+	stw	r24, TASK_CPU(r2)
 #endif
 
 	bl	early_init
@@ -719,7 +718,7 @@ finish_tlb_load:
 
 	/* Get the next_tlbcam_idx percpu var */
 #ifdef CONFIG_SMP
-	lwz	r15, TI_CPU-THREAD(r12)
+	lwz	r15, TASK_CPU-THREAD(r12)
 	lis     r14, __per_cpu_offset@h
 	ori     r14, r14, __per_cpu_offset@l
 	rlwinm  r15, r15, 2, 0, 29
diff --git a/arch/powerpc/kernel/idle_6xx.S b/arch/powerpc/kernel/idle_6xx.S
index d9b6e7e0b5e3..5e69fefcd9c4 100644
--- a/arch/powerpc/kernel/idle_6xx.S
+++ b/arch/powerpc/kernel/idle_6xx.S
@@ -136,10 +136,9 @@ BEGIN_FTR_SECTION
 	DSSALL
 	sync
 END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
-	CURRENT_THREAD_INFO(r9, r1)
-	lwz	r8,TI_LOCAL_FLAGS(r9)	/* set napping bit */
+	lwz	r8,TI_LOCAL_FLAGS(r2)	/* set napping bit */
 	ori	r8,r8,_TLF_NAPPING	/* so when we take an exception */
-	stw	r8,TI_LOCAL_FLAGS(r9)	/* it will return to our caller */
+	stw	r8,TI_LOCAL_FLAGS(r2)	/* it will return to our caller */
 	mfmsr	r7
 	ori	r7,r7,MSR_EE
 	oris	r7,r7,MSR_POW@h
@@ -159,9 +158,7 @@ _GLOBAL(power_save_ppc32_restore)
 	stw	r9,_NIP(r11)		/* make it do a blr */
 
 #ifdef CONFIG_SMP
-	CURRENT_THREAD_INFO(r12, r1)
-	tophys(r12, r12)
-	lwz	r11,TI_CPU(r12)		/* get cpu number * 4 */
+	lwz	r11,TI_CPU(r2)		/* get cpu number * 4 */
 	slwi	r11,r11,2
 #else
 	li	r11,0
diff --git a/arch/powerpc/kernel/idle_e500.S b/arch/powerpc/kernel/idle_e500.S
index 583e55ac7d26..69dfcd2ca011 100644
--- a/arch/powerpc/kernel/idle_e500.S
+++ b/arch/powerpc/kernel/idle_e500.S
@@ -22,10 +22,9 @@
 	.text
 
 _GLOBAL(e500_idle)
-	CURRENT_THREAD_INFO(r3, r1)
-	lwz	r4,TI_LOCAL_FLAGS(r3)	/* set napping bit */
+	lwz	r4,TI_LOCAL_FLAGS(r2)	/* set napping bit */
 	ori	r4,r4,_TLF_NAPPING	/* so when we take an exception */
-	stw	r4,TI_LOCAL_FLAGS(r3)	/* it will return to our caller */
+	stw	r4,TI_LOCAL_FLAGS(r2)	/* it will return to our caller */
 
 #ifdef CONFIG_PPC_E500MC
 	wrteei	1
@@ -88,8 +87,7 @@ _GLOBAL(power_save_ppc32_restore)
 	stw	r9,_NIP(r11)		/* make it do a blr */
 
 #ifdef CONFIG_SMP
-	CURRENT_THREAD_INFO(r12, r1)
-	lwz	r11,TI_CPU(r12)		/* get cpu number * 4 */
+	lwz	r11,TASK_CPU(r2)		/* get cpu number * 4 */
 	slwi	r11,r11,2
 #else
 	li	r11,0
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 6f6127c3760c..0dda4f8e3d7a 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -183,8 +183,7 @@ _GLOBAL(low_choose_750fx_pll)
 
 #ifdef CONFIG_SMP
 	/* Store new HID1 image */
-	CURRENT_THREAD_INFO(r6, r1)
-	lwz	r6,TI_CPU(r6)
+	lwz	r6,TASK_CPU(r2)
 	slwi	r6,r6,2
 #else
 	li	r6, 0
diff --git a/arch/powerpc/mm/hash_low_32.S b/arch/powerpc/mm/hash_low_32.S
index 1e2df3e9f9ea..5bee2d982959 100644
--- a/arch/powerpc/mm/hash_low_32.S
+++ b/arch/powerpc/mm/hash_low_32.S
@@ -186,8 +186,7 @@ _GLOBAL(add_hash_page)
 	add	r3,r3,r0		/* note create_hpte trims to 24 bits */
 
 #ifdef CONFIG_SMP
-	CURRENT_THREAD_INFO(r8, r1)	/* use cpu number to make tag */
-	lwz	r8,TI_CPU(r8)		/* to go in mmu_hash_lock */
+	lwz	r8,TASK_CPU(r2)		/* to go in mmu_hash_lock */
 	oris	r8,r8,12
 #endif /* CONFIG_SMP */
 
@@ -549,9 +548,8 @@ _GLOBAL(flush_hash_pages)
 #ifdef CONFIG_SMP
 	addis	r9,r7,mmu_hash_lock@ha
 	addi	r9,r9,mmu_hash_lock@l
-	CURRENT_THREAD_INFO(r8, r1)
-	add	r8,r8,r7
-	lwz	r8,TI_CPU(r8)
+	add	r8,r2,r7
+	lwz	r8,TASK_CPU(r8)
 	oris	r8,r8,9
 10:	lwarx	r0,0,r9
 	cmpi	0,r0,0
@@ -646,8 +644,7 @@ EXPORT_SYMBOL(flush_hash_pages)
  */
 _GLOBAL(_tlbie)
 #ifdef CONFIG_SMP
-	CURRENT_THREAD_INFO(r8, r1)
-	lwz	r8,TI_CPU(r8)
+	lwz	r8,TASK_CPU(r2)
 	oris	r8,r8,11
 	mfmsr	r10
 	SYNC
@@ -684,8 +681,7 @@ _GLOBAL(_tlbie)
  */
 _GLOBAL(_tlbia)
 #if defined(CONFIG_SMP)
-	CURRENT_THREAD_INFO(r8, r1)
-	lwz	r8,TI_CPU(r8)
+	lwz	r8,TASK_CPU(r2)
 	oris	r8,r8,10
 	mfmsr	r10
 	SYNC
diff --git a/arch/powerpc/sysdev/6xx-suspend.S b/arch/powerpc/sysdev/6xx-suspend.S
index cf48e9cb2575..6c4aec25c4ba 100644
--- a/arch/powerpc/sysdev/6xx-suspend.S
+++ b/arch/powerpc/sysdev/6xx-suspend.S
@@ -29,10 +29,9 @@ _GLOBAL(mpc6xx_enter_standby)
 	ori	r5, r5, ret_from_standby@l
 	mtlr	r5
 
-	CURRENT_THREAD_INFO(r5, r1)
-	lwz	r6, TI_LOCAL_FLAGS(r5)
+	lwz	r6, TI_LOCAL_FLAGS(r2)
 	ori	r6, r6, _TLF_SLEEPING
-	stw	r6, TI_LOCAL_FLAGS(r5)
+	stw	r6, TI_LOCAL_FLAGS(r2)
 
 	mfmsr	r5
 	ori	r5, r5, MSR_EE
-- 
2.13.3


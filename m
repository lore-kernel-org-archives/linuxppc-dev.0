Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BE7C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 14:04:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1AD8206BB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 14:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1AD8206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43YvC965DNzDqYW
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 01:04:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Ytkl4481zDqLW
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2019 00:43:27 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43Ytkg1WmYz9tyN0;
 Tue,  8 Jan 2019 14:43:23 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 4u3a3f9XGa3a; Tue,  8 Jan 2019 14:43:23 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43Ytkg0zMZz9tyMv;
 Tue,  8 Jan 2019 14:43:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7264E8B833;
 Tue,  8 Jan 2019 14:43:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id tRdKCnUuNdYI; Tue,  8 Jan 2019 14:43:24 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 0CAB08B7DF;
 Tue,  8 Jan 2019 14:43:24 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id C0842717F2; Tue,  8 Jan 2019 13:43:23 +0000 (UTC)
Message-Id: <90334f433cc6ff1c1efb88b3163594355c99928b.1546954238.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1546954233.git.christophe.leroy@c-s.fr>
References: <cover.1546954233.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v12 08/10] powerpc/32: Remove CURRENT_THREAD_INFO and rename
 TI_CPU
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Mike Rapoport <rppt@linux.ibm.com>
Date: Tue,  8 Jan 2019 13:43:23 +0000 (UTC)
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

At the same time, as the 'cpu' field is not anymore in thread_info,
this patch renames it to TASK_CPU.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Makefile                  |  2 +-
 arch/powerpc/include/asm/thread_info.h |  2 --
 arch/powerpc/kernel/asm-offsets.c      |  2 +-
 arch/powerpc/kernel/entry_32.S         | 43 ++++++++++++----------------------
 arch/powerpc/kernel/epapr_hcalls.S     |  5 ++--
 arch/powerpc/kernel/head_fsl_booke.S   |  5 ++--
 arch/powerpc/kernel/idle_6xx.S         |  8 +++----
 arch/powerpc/kernel/idle_e500.S        |  8 +++----
 arch/powerpc/kernel/misc_32.S          |  3 +--
 arch/powerpc/mm/hash_low_32.S          | 14 ++++-------
 arch/powerpc/sysdev/6xx-suspend.S      |  5 ++--
 11 files changed, 35 insertions(+), 62 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 326e8ba6e314..5a9bf22a7534 100644
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
index b547bd4168d8..52a061f14c7d 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -168,8 +168,7 @@ transfer_to_handler:
 	tophys(r11,r11)
 	addi	r11,r11,global_dbcr0@l
 #ifdef CONFIG_SMP
-	CURRENT_THREAD_INFO(r9, r1)
-	lwz	r9,TI_CPU(r9)
+	lwz	r9,TASK_CPU(r2)
 	slwi	r9,r9,3
 	add	r11,r11,r9
 #endif
@@ -180,8 +179,7 @@ transfer_to_handler:
 	stw	r12,4(r11)
 #endif
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
-	CURRENT_THREAD_INFO(r9, r1)
-	tophys(r9, r9)
+	tophys(r9, r2)
 	ACCOUNT_CPU_USER_ENTRY(r9, r11, r12)
 #endif
 
@@ -195,8 +193,7 @@ transfer_to_handler:
 	ble-	stack_ovf		/* then the kernel stack overflowed */
 5:
 #if defined(CONFIG_PPC_BOOK3S_32) || defined(CONFIG_E500)
-	CURRENT_THREAD_INFO(r9, r1)
-	tophys(r9,r9)			/* check local flags */
+	tophys(r9,r2)			/* check local flags */
 	lwz	r12,TI_LOCAL_FLAGS(r9)
 	mtcrf	0x01,r12
 	bt-	31-TLF_NAPPING,4f
@@ -345,8 +342,7 @@ _GLOBAL(DoSyscall)
 	mtmsr	r11
 1:
 #endif /* CONFIG_TRACE_IRQFLAGS */
-	CURRENT_THREAD_INFO(r10, r1)
-	lwz	r11,TI_FLAGS(r10)
+	lwz	r11,TI_FLAGS(r2)
 	andi.	r11,r11,_TIF_SYSCALL_DOTRACE
 	bne-	syscall_dotrace
 syscall_dotrace_cont:
@@ -379,13 +375,12 @@ ret_from_syscall:
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
@@ -432,8 +427,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 	andi.	r4,r8,MSR_PR
 	beq	3f
-	CURRENT_THREAD_INFO(r4, r1)
-	ACCOUNT_CPU_USER_EXIT(r4, r5, r7)
+	ACCOUNT_CPU_USER_EXIT(r2, r5, r7)
 3:
 #endif
 	lwz	r4,_LINK(r1)
@@ -526,7 +520,7 @@ syscall_exit_work:
 	/* Clear per-syscall TIF flags if any are set.  */
 
 	li	r11,_TIF_PERSYSCALL_MASK
-	addi	r12,r12,TI_FLAGS
+	addi	r12,r2,TI_FLAGS
 3:	lwarx	r8,0,r12
 	andc	r8,r8,r11
 #ifdef CONFIG_IBM405_ERR77
@@ -534,7 +528,6 @@ syscall_exit_work:
 #endif
 	stwcx.	r8,0,r12
 	bne-	3b
-	subi	r12,r12,TI_FLAGS
 	
 4:	/* Anything which requires enabling interrupts? */
 	andi.	r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP)
@@ -813,8 +806,7 @@ ret_from_except:
 
 user_exc_return:		/* r10 contains MSR_KERNEL here */
 	/* Check current_thread_info()->flags */
-	CURRENT_THREAD_INFO(r9, r1)
-	lwz	r9,TI_FLAGS(r9)
+	lwz	r9,TI_FLAGS(r2)
 	andi.	r0,r9,_TIF_USER_WORK_MASK
 	bne	do_work
 
@@ -827,8 +819,7 @@ restore_user:
 	bnel-	load_dbcr0
 #endif
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
-	CURRENT_THREAD_INFO(r9, r1)
-	ACCOUNT_CPU_USER_EXIT(r9, r10, r11)
+	ACCOUNT_CPU_USER_EXIT(r2, r10, r11)
 #endif
 
 	b	restore
@@ -836,8 +827,7 @@ restore_user:
 /* N.B. the only way to get here is from the beq following ret_from_except. */
 resume_kernel:
 	/* check current_thread_info, _TIF_EMULATE_STACK_STORE */
-	CURRENT_THREAD_INFO(r9, r1)
-	lwz	r8,TI_FLAGS(r9)
+	lwz	r8,TI_FLAGS(r2)
 	andis.	r0,r8,_TIF_EMULATE_STACK_STORE@h
 	beq+	1f
 
@@ -863,7 +853,7 @@ resume_kernel:
 
 	/* Clear _TIF_EMULATE_STACK_STORE flag */
 	lis	r11,_TIF_EMULATE_STACK_STORE@h
-	addi	r5,r9,TI_FLAGS
+	addi	r5,r2,TI_FLAGS
 0:	lwarx	r8,0,r5
 	andc	r8,r8,r11
 #ifdef CONFIG_IBM405_ERR77
@@ -875,7 +865,7 @@ resume_kernel:
 
 #ifdef CONFIG_PREEMPT
 	/* check current_thread_info->preempt_count */
-	lwz	r0,TI_PREEMPT(r9)
+	lwz	r0,TI_PREEMPT(r2)
 	cmpwi	0,r0,0		/* if non-zero, just restore regs and return */
 	bne	restore
 	andi.	r8,r8,_TIF_NEED_RESCHED
@@ -891,8 +881,7 @@ resume_kernel:
 	bl	trace_hardirqs_off
 #endif
 1:	bl	preempt_schedule_irq
-	CURRENT_THREAD_INFO(r9, r1)
-	lwz	r3,TI_FLAGS(r9)
+	lwz	r3,TI_FLAGS(r2)
 	andi.	r0,r3,_TIF_NEED_RESCHED
 	bne-	1b
 #ifdef CONFIG_TRACE_IRQFLAGS
@@ -1191,8 +1180,7 @@ load_dbcr0:
 	lis	r11,global_dbcr0@ha
 	addi	r11,r11,global_dbcr0@l
 #ifdef CONFIG_SMP
-	CURRENT_THREAD_INFO(r9, r1)
-	lwz	r9,TI_CPU(r9)
+	lwz	r9,TASK_CPU(r2)
 	slwi	r9,r9,3
 	add	r11,r11,r9
 #endif
@@ -1232,8 +1220,7 @@ recheck:
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
index ff026c9d3cab..5afd2e236990 100644
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
@@ -159,8 +158,7 @@ _GLOBAL(power_save_ppc32_restore)
 	stw	r9,_NIP(r11)		/* make it do a blr */
 
 #ifdef CONFIG_SMP
-	CURRENT_THREAD_INFO(r12, r11)
-	lwz	r11,TI_CPU(r12)		/* get cpu number * 4 */
+	lwz	r11,TASK_CPU(r2)		/* get cpu number * 4 */
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


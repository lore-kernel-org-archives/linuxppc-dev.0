Return-Path: <B08248@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3AD412C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2012 07:14:41 +1000 (EST)
From: Stuart Yoder <stuart.yoder@freescale.com>
To: <agraf@suse.de>, <benh@kernel.crashing.org>
Subject: [PATCH][v2] PPC: use CURRENT_THREAD_INFO instead of open coded
 assembly
Date: Mon, 2 Jul 2012 16:14:27 -0500
Message-ID: <1341263667-29875-1-git-send-email-stuart.yoder@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Stuart Yoder <stuart.yoder@freescale.com>

Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
---

-this patch is a pre-requisite for the idle hcall which I
am trying to get into Alex's KVM tree, so ideally would like
Ben's ack and get this applied to Alex's tree

-built/tested with a 32-bit booke kernel, built a 64-bit
 booke kernel

-v2
   -moved CURRENT_THREAD_INFO under assembly only
    #ifdef

 arch/powerpc/include/asm/exception-64s.h |    4 ++--
 arch/powerpc/include/asm/thread_info.h   |    8 ++++++++
 arch/powerpc/kernel/entry_32.S           |   24 ++++++++++++------------
 arch/powerpc/kernel/entry_64.S           |   14 +++++++-------
 arch/powerpc/kernel/exceptions-64e.S     |    2 +-
 arch/powerpc/kernel/exceptions-64s.S     |    2 +-
 arch/powerpc/kernel/head_fsl_booke.S     |    2 +-
 arch/powerpc/kernel/idle_6xx.S           |    4 ++--
 arch/powerpc/kernel/idle_book3e.S        |    2 +-
 arch/powerpc/kernel/idle_e500.S          |    4 ++--
 arch/powerpc/kernel/idle_power4.S        |    2 +-
 arch/powerpc/kernel/misc_32.S            |    4 ++--
 arch/powerpc/kvm/bookehv_interrupts.S    |    6 +-----
 arch/powerpc/mm/hash_low_32.S            |    8 ++++----
 arch/powerpc/sysdev/6xx-suspend.S        |    2 +-
 15 files changed, 46 insertions(+), 42 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index d58fc4e..5dbd00d 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -293,7 +293,7 @@ label##_hv:								\
 
 #define RUNLATCH_ON				\
 BEGIN_FTR_SECTION				\
-	clrrdi	r3,r1,THREAD_SHIFT;		\
+	CURRENT_THREAD_INFO(r3, r1)		\
 	ld	r4,TI_LOCAL_FLAGS(r3);		\
 	andi.	r0,r4,_TLF_RUNLATCH;		\
 	beql	ppc64_runlatch_on_trampoline;	\
@@ -332,7 +332,7 @@ label##_common:							\
 #ifdef CONFIG_PPC_970_NAP
 #define FINISH_NAP				\
 BEGIN_FTR_SECTION				\
-	clrrdi	r11,r1,THREAD_SHIFT;		\
+	CURRENT_THREAD_INFO(r11, r1)		\
 	ld	r9,TI_LOCAL_FLAGS(r11);		\
 	andi.	r10,r9,_TLF_NAPPING;		\
 	bnel	power4_fixup_nap;		\
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 68831e9..3760620 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -74,6 +74,14 @@ static inline struct thread_info *current_thread_info(void)
 	return (struct thread_info *)(sp & ~(THREAD_SIZE-1));
 }
 
+#else
+
+#ifndef CONFIG_PPC64
+#define CURRENT_THREAD_INFO(dest, sp)	rlwinm dest, sp, 0, 0, 31-THREAD_SHIFT
+#else
+#define CURRENT_THREAD_INFO(dest, sp)	clrrdi dest, sp, THREAD_SHIFT
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #define PREEMPT_ACTIVE		0x10000000
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index ba3aeb4..bad42e3 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -92,7 +92,7 @@ crit_transfer_to_handler:
 	mfspr	r8,SPRN_SPRG_THREAD
 	lwz	r0,KSP_LIMIT(r8)
 	stw	r0,SAVED_KSP_LIMIT(r11)
-	rlwimi	r0,r1,0,0,(31-THREAD_SHIFT)
+	CURRENT_THREAD_INFO(r0, r1)
 	stw	r0,KSP_LIMIT(r8)
 	/* fall through */
 #endif
@@ -112,7 +112,7 @@ crit_transfer_to_handler:
 	mfspr	r8,SPRN_SPRG_THREAD
 	lwz	r0,KSP_LIMIT(r8)
 	stw	r0,saved_ksp_limit@l(0)
-	rlwimi	r0,r1,0,0,(31-THREAD_SHIFT)
+	CURRENT_THREAD_INFO(r0, r1)
 	stw	r0,KSP_LIMIT(r8)
 	/* fall through */
 #endif
@@ -158,7 +158,7 @@ transfer_to_handler:
 	tophys(r11,r11)
 	addi	r11,r11,global_dbcr0@l
 #ifdef CONFIG_SMP
-	rlwinm	r9,r1,0,0,(31-THREAD_SHIFT)
+	CURRENT_THREAD_INFO(r9, r1)
 	lwz	r9,TI_CPU(r9)
 	slwi	r9,r9,3
 	add	r11,r11,r9
@@ -179,7 +179,7 @@ transfer_to_handler:
 	ble-	stack_ovf		/* then the kernel stack overflowed */
 5:
 #if defined(CONFIG_6xx) || defined(CONFIG_E500)
-	rlwinm	r9,r1,0,0,31-THREAD_SHIFT
+	CURRENT_THREAD_INFO(r9, r1)
 	tophys(r9,r9)			/* check local flags */
 	lwz	r12,TI_LOCAL_FLAGS(r9)
 	mtcrf	0x01,r12
@@ -333,7 +333,7 @@ _GLOBAL(DoSyscall)
 	mtmsr	r11
 1:
 #endif /* CONFIG_TRACE_IRQFLAGS */
-	rlwinm	r10,r1,0,0,(31-THREAD_SHIFT)	/* current_thread_info() */
+	CURRENT_THREAD_INFO(r10, r1)
 	lwz	r11,TI_FLAGS(r10)
 	andi.	r11,r11,_TIF_SYSCALL_T_OR_A
 	bne-	syscall_dotrace
@@ -354,7 +354,7 @@ ret_from_syscall:
 	bl	do_show_syscall_exit
 #endif
 	mr	r6,r3
-	rlwinm	r12,r1,0,0,(31-THREAD_SHIFT)	/* current_thread_info() */
+	CURRENT_THREAD_INFO(r12, r1)
 	/* disable interrupts so current_thread_info()->flags can't change */
 	LOAD_MSR_KERNEL(r10,MSR_KERNEL)	/* doesn't include MSR_EE */
 	/* Note: We don't bother telling lockdep about it */
@@ -815,7 +815,7 @@ ret_from_except:
 
 user_exc_return:		/* r10 contains MSR_KERNEL here */
 	/* Check current_thread_info()->flags */
-	rlwinm	r9,r1,0,0,(31-THREAD_SHIFT)
+	CURRENT_THREAD_INFO(r9, r1)
 	lwz	r9,TI_FLAGS(r9)
 	andi.	r0,r9,_TIF_USER_WORK_MASK
 	bne	do_work
@@ -835,7 +835,7 @@ restore_user:
 /* N.B. the only way to get here is from the beq following ret_from_except. */
 resume_kernel:
 	/* check current_thread_info->preempt_count */
-	rlwinm	r9,r1,0,0,(31-THREAD_SHIFT)
+	CURRENT_THREAD_INFO(r9, r1)
 	lwz	r0,TI_PREEMPT(r9)
 	cmpwi	0,r0,0		/* if non-zero, just restore regs and return */
 	bne	restore
@@ -852,7 +852,7 @@ resume_kernel:
 	bl	trace_hardirqs_off
 #endif
 1:	bl	preempt_schedule_irq
-	rlwinm	r9,r1,0,0,(31-THREAD_SHIFT)
+	CURRENT_THREAD_INFO(r9, r1)
 	lwz	r3,TI_FLAGS(r9)
 	andi.	r0,r3,_TIF_NEED_RESCHED
 	bne-	1b
@@ -1122,7 +1122,7 @@ ret_from_debug_exc:
 	lwz	r10,SAVED_KSP_LIMIT(r1)
 	stw	r10,KSP_LIMIT(r9)
 	lwz	r9,THREAD_INFO-THREAD(r9)
-	rlwinm	r10,r1,0,0,(31-THREAD_SHIFT)
+	CURRENT_THREAD_INFO(r10, r1)
 	lwz	r10,TI_PREEMPT(r10)
 	stw	r10,TI_PREEMPT(r9)
 	RESTORE_xSRR(SRR0,SRR1);
@@ -1156,7 +1156,7 @@ load_dbcr0:
 	lis	r11,global_dbcr0@ha
 	addi	r11,r11,global_dbcr0@l
 #ifdef CONFIG_SMP
-	rlwinm	r9,r1,0,0,(31-THREAD_SHIFT)
+	CURRENT_THREAD_INFO(r9, r1)
 	lwz	r9,TI_CPU(r9)
 	slwi	r9,r9,3
 	add	r11,r11,r9
@@ -1197,7 +1197,7 @@ recheck:
 	LOAD_MSR_KERNEL(r10,MSR_KERNEL)
 	SYNC
 	MTMSRD(r10)		/* disable interrupts */
-	rlwinm	r9,r1,0,0,(31-THREAD_SHIFT)
+	CURRENT_THREAD_INFO(r9, r1)
 	lwz	r9,TI_FLAGS(r9)
 	andi.	r0,r9,_TIF_NEED_RESCHED
 	bne-	do_resched
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index ed1718f..ba943b9 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -146,7 +146,7 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 	REST_2GPRS(7,r1)
 	addi	r9,r1,STACK_FRAME_OVERHEAD
 #endif
-	clrrdi	r11,r1,THREAD_SHIFT
+	CURRENT_THREAD_INFO(r11, r1)
 	ld	r10,TI_FLAGS(r11)
 	andi.	r11,r10,_TIF_SYSCALL_T_OR_A
 	bne-	syscall_dotrace
@@ -181,7 +181,7 @@ syscall_exit:
 	bl	.do_show_syscall_exit
 	ld	r3,RESULT(r1)
 #endif
-	clrrdi	r12,r1,THREAD_SHIFT
+	CURRENT_THREAD_INFO(r12, r1)
 
 	ld	r8,_MSR(r1)
 #ifdef CONFIG_PPC_BOOK3S
@@ -262,7 +262,7 @@ syscall_dotrace:
 	ld	r7,GPR7(r1)
 	ld	r8,GPR8(r1)
 	addi	r9,r1,STACK_FRAME_OVERHEAD
-	clrrdi	r10,r1,THREAD_SHIFT
+	CURRENT_THREAD_INFO(r10, r1)
 	ld	r10,TI_FLAGS(r10)
 	b	.Lsyscall_dotrace_cont
 
@@ -499,7 +499,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
 2:
 #endif /* !CONFIG_PPC_BOOK3S */
 
-	clrrdi	r7,r8,THREAD_SHIFT	/* base of new stack */
+	CURRENT_THREAD_INFO(r7, r8)  /* base of new stack */
 	/* Note: this uses SWITCH_FRAME_SIZE rather than INT_FRAME_SIZE
 	   because we don't need to leave the 288-byte ABI gap at the
 	   top of the kernel stack. */
@@ -559,7 +559,7 @@ _GLOBAL(ret_from_except_lite)
 #endif /* CONFIG_PPC_BOOK3E */
 
 #ifdef CONFIG_PREEMPT
-	clrrdi	r9,r1,THREAD_SHIFT	/* current_thread_info() */
+	CURRENT_THREAD_INFO(r9, r1)
 	li	r0,_TIF_NEED_RESCHED	/* bits to check */
 	ld	r3,_MSR(r1)
 	ld	r4,TI_FLAGS(r9)
@@ -574,7 +574,7 @@ _GLOBAL(ret_from_except_lite)
 	beq	restore		/* if not, just restore regs and return */
 
 	/* Check current_thread_info()->flags */
-	clrrdi	r9,r1,THREAD_SHIFT
+	CURRENT_THREAD_INFO(r9, r1)
 	ld	r4,TI_FLAGS(r9)
 	andi.	r0,r4,_TIF_USER_WORK_MASK
 	bne	do_work
@@ -782,7 +782,7 @@ do_work:
 1:	bl	.preempt_schedule_irq
 
 	/* Re-test flags and eventually loop */
-	clrrdi	r9,r1,THREAD_SHIFT
+	CURRENT_THREAD_INFO(r9, r1)
 	ld	r4,TI_FLAGS(r9)
 	andi.	r0,r4,_TIF_NEED_RESCHED
 	bne	1b
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 7215cc2..3b60028 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -222,7 +222,7 @@ exc_##n##_bad_stack:							    \
  * interrupts happen before the wait instruction.
  */
 #define CHECK_NAPPING()							\
-	clrrdi	r11,r1,THREAD_SHIFT;					\
+	CURRENT_THREAD_INFO(r11, r1)
 	ld	r10,TI_LOCAL_FLAGS(r11);				\
 	andi.	r9,r10,_TLF_NAPPING;					\
 	beq+	1f;							\
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 1c06d29..8ad3468 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -851,7 +851,7 @@ BEGIN_FTR_SECTION
 	bne-	do_ste_alloc		/* If so handle it */
 END_MMU_FTR_SECTION_IFCLR(MMU_FTR_SLB)
 
-	clrrdi	r11,r1,THREAD_SHIFT
+	CURRENT_THREAD_INFO(r11, r1)
 	lwz	r0,TI_PREEMPT(r11)	/* If we're in an "NMI" */
 	andis.	r0,r0,NMI_MASK@h	/* (i.e. an irq when soft-disabled) */
 	bne	77f			/* then don't call hash_page now */
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 1f4434a..7e7bd88 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -192,7 +192,7 @@ _ENTRY(__early_start)
 	li	r0,0
 	stwu	r0,THREAD_SIZE-STACK_FRAME_OVERHEAD(r1)
 
-	rlwinm  r22,r1,0,0,31-THREAD_SHIFT      /* current thread_info */
+	CURRENT_THREAD_INFO(r22, r1)
 	stw	r24, TI_CPU(r22)
 
 	bl	early_init
diff --git a/arch/powerpc/kernel/idle_6xx.S b/arch/powerpc/kernel/idle_6xx.S
index 15c611d..1686916 100644
--- a/arch/powerpc/kernel/idle_6xx.S
+++ b/arch/powerpc/kernel/idle_6xx.S
@@ -135,7 +135,7 @@ BEGIN_FTR_SECTION
 	DSSALL
 	sync
 END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
-	rlwinm	r9,r1,0,0,31-THREAD_SHIFT	/* current thread_info */
+	CURRENT_THREAD_INFO(r9, r1)
 	lwz	r8,TI_LOCAL_FLAGS(r9)	/* set napping bit */
 	ori	r8,r8,_TLF_NAPPING	/* so when we take an exception */
 	stw	r8,TI_LOCAL_FLAGS(r9)	/* it will return to our caller */
@@ -158,7 +158,7 @@ _GLOBAL(power_save_ppc32_restore)
 	stw	r9,_NIP(r11)		/* make it do a blr */
 
 #ifdef CONFIG_SMP
-	rlwinm	r12,r11,0,0,31-THREAD_SHIFT
+	CURRENT_THREAD_INFO(r12, r11)
 	lwz	r11,TI_CPU(r12)		/* get cpu number * 4 */
 	slwi	r11,r11,2
 #else
diff --git a/arch/powerpc/kernel/idle_book3e.S b/arch/powerpc/kernel/idle_book3e.S
index ff007b5..4c7cb400 100644
--- a/arch/powerpc/kernel/idle_book3e.S
+++ b/arch/powerpc/kernel/idle_book3e.S
@@ -60,7 +60,7 @@ _GLOBAL(book3e_idle)
 1:	/* Let's set the _TLF_NAPPING flag so interrupts make us return
 	 * to the right spot
 	*/
-	clrrdi	r11,r1,THREAD_SHIFT
+	CURRENT_THREAD_INFO(r11, r1)
 	ld	r10,TI_LOCAL_FLAGS(r11)
 	ori	r10,r10,_TLF_NAPPING
 	std	r10,TI_LOCAL_FLAGS(r11)
diff --git a/arch/powerpc/kernel/idle_e500.S b/arch/powerpc/kernel/idle_e500.S
index 4f0ab85..1544866 100644
--- a/arch/powerpc/kernel/idle_e500.S
+++ b/arch/powerpc/kernel/idle_e500.S
@@ -21,7 +21,7 @@
 	.text
 
 _GLOBAL(e500_idle)
-	rlwinm	r3,r1,0,0,31-THREAD_SHIFT	/* current thread_info */
+	CURRENT_THREAD_INFO(r3, r1)
 	lwz	r4,TI_LOCAL_FLAGS(r3)	/* set napping bit */
 	ori	r4,r4,_TLF_NAPPING	/* so when we take an exception */
 	stw	r4,TI_LOCAL_FLAGS(r3)	/* it will return to our caller */
@@ -96,7 +96,7 @@ _GLOBAL(power_save_ppc32_restore)
 	stw	r9,_NIP(r11)		/* make it do a blr */
 
 #ifdef CONFIG_SMP
-	rlwinm	r12,r1,0,0,31-THREAD_SHIFT
+	CURRENT_THREAD_INFO(r12, r1)
 	lwz	r11,TI_CPU(r12)		/* get cpu number * 4 */
 	slwi	r11,r11,2
 #else
diff --git a/arch/powerpc/kernel/idle_power4.S b/arch/powerpc/kernel/idle_power4.S
index 2c71b0f..e3edaa1 100644
--- a/arch/powerpc/kernel/idle_power4.S
+++ b/arch/powerpc/kernel/idle_power4.S
@@ -59,7 +59,7 @@ BEGIN_FTR_SECTION
 	DSSALL
 	sync
 END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
-	clrrdi	r9,r1,THREAD_SHIFT	/* current thread_info */
+	CURRENT_THREAD_INFO(r9, r1)
 	ld	r8,TI_LOCAL_FLAGS(r9)	/* set napping bit */
 	ori	r8,r8,_TLF_NAPPING	/* so when we take an exception */
 	std	r8,TI_LOCAL_FLAGS(r9)	/* it will return to our caller */
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 386d57f..407e293 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -179,7 +179,7 @@ _GLOBAL(low_choose_750fx_pll)
 	mtspr	SPRN_HID1,r4
 
 	/* Store new HID1 image */
-	rlwinm	r6,r1,0,0,(31-THREAD_SHIFT)
+	CURRENT_THREAD_INFO(r6, r1)
 	lwz	r6,TI_CPU(r6)
 	slwi	r6,r6,2
 	addis	r6,r6,nap_save_hid1@ha
@@ -699,7 +699,7 @@ _GLOBAL(kernel_thread)
 #ifdef CONFIG_SMP
 _GLOBAL(start_secondary_resume)
 	/* Reset stack */
-	rlwinm	r1,r1,0,0,(31-THREAD_SHIFT)	/* current_thread_info() */
+	CURRENT_THREAD_INFO(r1, r1)
 	addi	r1,r1,THREAD_SIZE-STACK_FRAME_OVERHEAD
 	li	r3,0
 	stw	r3,0(r1)		/* Zero the stack frame pointer	*/
diff --git a/arch/powerpc/kvm/bookehv_interrupts.S b/arch/powerpc/kvm/bookehv_interrupts.S
index 0fa2ef7..c8c7a04 100644
--- a/arch/powerpc/kvm/bookehv_interrupts.S
+++ b/arch/powerpc/kvm/bookehv_interrupts.S
@@ -161,11 +161,7 @@
 	mtspr	SPRN_EPLC, r8
 
 	/* disable preemption, so we are sure we hit the fixup handler */
-#ifdef CONFIG_PPC64
-	clrrdi	r8,r1,THREAD_SHIFT
-#else
-	rlwinm	r8,r1,0,0,31-THREAD_SHIFT       /* current thread_info */
-#endif
+	CURRENT_THREAD_INFO(r8, r1)
 	li	r7, 1
 	stw	r7, TI_PREEMPT(r8)
 
diff --git a/arch/powerpc/mm/hash_low_32.S b/arch/powerpc/mm/hash_low_32.S
index b13d589..115347f 100644
--- a/arch/powerpc/mm/hash_low_32.S
+++ b/arch/powerpc/mm/hash_low_32.S
@@ -184,7 +184,7 @@ _GLOBAL(add_hash_page)
 	add	r3,r3,r0		/* note create_hpte trims to 24 bits */
 
 #ifdef CONFIG_SMP
-	rlwinm	r8,r1,0,0,(31-THREAD_SHIFT) /* use cpu number to make tag */
+	CURRENT_THREAD_INFO(r8, r1)	/* use cpu number to make tag */
 	lwz	r8,TI_CPU(r8)		/* to go in mmu_hash_lock */
 	oris	r8,r8,12
 #endif /* CONFIG_SMP */
@@ -545,7 +545,7 @@ _GLOBAL(flush_hash_pages)
 #ifdef CONFIG_SMP
 	addis	r9,r7,mmu_hash_lock@ha
 	addi	r9,r9,mmu_hash_lock@l
-	rlwinm	r8,r1,0,0,(31-THREAD_SHIFT)
+	CURRENT_THREAD_INFO(r8, r1)
 	add	r8,r8,r7
 	lwz	r8,TI_CPU(r8)
 	oris	r8,r8,9
@@ -639,7 +639,7 @@ _GLOBAL(flush_hash_patch_B)
  */
 _GLOBAL(_tlbie)
 #ifdef CONFIG_SMP
-	rlwinm	r8,r1,0,0,(31-THREAD_SHIFT)
+	CURRENT_THREAD_INFO(r8, r1)
 	lwz	r8,TI_CPU(r8)
 	oris	r8,r8,11
 	mfmsr	r10
@@ -677,7 +677,7 @@ _GLOBAL(_tlbie)
  */
 _GLOBAL(_tlbia)
 #if defined(CONFIG_SMP)
-	rlwinm	r8,r1,0,0,(31-THREAD_SHIFT)
+	CURRENT_THREAD_INFO(r8, r1)
 	lwz	r8,TI_CPU(r8)
 	oris	r8,r8,10
 	mfmsr	r10
diff --git a/arch/powerpc/sysdev/6xx-suspend.S b/arch/powerpc/sysdev/6xx-suspend.S
index 21cda08..cf48e9c 100644
--- a/arch/powerpc/sysdev/6xx-suspend.S
+++ b/arch/powerpc/sysdev/6xx-suspend.S
@@ -29,7 +29,7 @@ _GLOBAL(mpc6xx_enter_standby)
 	ori	r5, r5, ret_from_standby@l
 	mtlr	r5
 
-	rlwinm	r5, r1, 0, 0, 31-THREAD_SHIFT
+	CURRENT_THREAD_INFO(r5, r1)
 	lwz	r6, TI_LOCAL_FLAGS(r5)
 	ori	r6, r6, _TLF_SLEEPING
 	stw	r6, TI_LOCAL_FLAGS(r5)
-- 
1.7.3.4

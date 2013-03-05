Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BDF112C0336
 for <linuxppc-dev@ozlabs.org>; Wed,  6 Mar 2013 10:16:05 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r25NG2V6024139
 for <linuxppc-dev@ozlabs.org>; Tue, 5 Mar 2013 17:16:03 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/8] powerpc/85xx: Add AltiVec support for e6500
Date: Tue,  5 Mar 2013 17:15:56 -0600
Message-Id: <1362525360-23136-4-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1362525360-23136-3-git-send-email-galak@kernel.crashing.org>
References: <1362525360-23136-1-git-send-email-galak@kernel.crashing.org>
 <1362525360-23136-2-git-send-email-galak@kernel.crashing.org>
 <1362525360-23136-3-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The e6500 core adds support for AltiVec on a Book-E class processor.
Connect up all the various exception handling code and build config
mechanisms to allow user spaces apps to utilize AltiVec.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/include/asm/cputable.h       |    2 +-
 arch/powerpc/include/asm/kvm_asm.h        |    4 +++
 arch/powerpc/kernel/cpu_setup_fsl_booke.S |   14 +++++++++
 arch/powerpc/kernel/cputable.c            |    9 ++++--
 arch/powerpc/kernel/exceptions-64e.S      |   47 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/Kconfig.cputype    |    2 +-
 6 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index fb3245e..f326444 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -374,7 +374,7 @@ extern const char *powerpc_base_platform;
 #define CPU_FTRS_E6500	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN | \
 	    CPU_FTR_L2CSR | CPU_FTR_LWSYNC | CPU_FTR_NOEXECUTE | \
 	    CPU_FTR_DBELL | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
-	    CPU_FTR_DEBUG_LVL_EXC | CPU_FTR_EMB_HV)
+	    CPU_FTR_DEBUG_LVL_EXC | CPU_FTR_EMB_HV | CPU_FTR_ALTIVEC_COMP)
 #define CPU_FTRS_GENERIC_32	(CPU_FTR_COMMON | CPU_FTR_NODSISRALIGN)
 
 /* 64-bit CPUs */
diff --git a/arch/powerpc/include/asm/kvm_asm.h b/arch/powerpc/include/asm/kvm_asm.h
index aabcdba..b9dd382 100644
--- a/arch/powerpc/include/asm/kvm_asm.h
+++ b/arch/powerpc/include/asm/kvm_asm.h
@@ -67,6 +67,10 @@
 #define BOOKE_INTERRUPT_HV_SYSCALL 40
 #define BOOKE_INTERRUPT_HV_PRIV 41
 
+/* altivec */
+#define BOOKE_INTERRUPT_ALTIVEC_UNAVAIL 42
+#define BOOKE_INTERRUPT_ALTIVEC_ASSIST 43
+
 /* book3s */
 
 #define BOOK3S_INTERRUPT_SYSTEM_RESET	0x100
diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
index dcd8819..c16729b 100644
--- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
+++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
@@ -53,6 +53,13 @@ _GLOBAL(__e500_dcache_setup)
 	isync
 	blr
 
+_GLOBAL(__setup_cpu_e6500)
+	mflr	r6
+	bl	.setup_altivec_ivors
+	bl	__setup_cpu_e5500
+	mtlr	r6
+	blr
+
 #ifdef CONFIG_PPC32
 _GLOBAL(__setup_cpu_e200)
 	/* enable dedicated debug exception handling resources (Debug APU) */
@@ -107,6 +114,13 @@ _GLOBAL(__setup_cpu_e5500)
 #endif
 
 #ifdef CONFIG_PPC_BOOK3E_64
+_GLOBAL(__restore_cpu_e6500)
+	mflr	r5
+	bl	.setup_altivec_ivors
+	bl	__restore_cpu_e5500
+	mtlr	r5
+	blr
+
 _GLOBAL(__restore_cpu_e5500)
 	mflr	r4
 	bl	__e500_icache_setup
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 75a3d71..cc39139 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -74,7 +74,9 @@ extern void __restore_cpu_a2(void);
 #endif /* CONFIG_PPC64 */
 #if defined(CONFIG_E500)
 extern void __setup_cpu_e5500(unsigned long offset, struct cpu_spec* spec);
+extern void __setup_cpu_e6500(unsigned long offset, struct cpu_spec* spec);
 extern void __restore_cpu_e5500(void);
+extern void __restore_cpu_e6500(void);
 #endif /* CONFIG_E500 */
 
 /* This table only contains "desktop" CPUs, it need to be filled with embedded
@@ -2065,7 +2067,8 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.pvr_value		= 0x80400000,
 		.cpu_name		= "e6500",
 		.cpu_features		= CPU_FTRS_E6500,
-		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
+		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU |
+			PPC_FEATURE_HAS_ALTIVEC_COMP,
 		.mmu_features		= MMU_FTR_TYPE_FSL_E | MMU_FTR_BIG_PHYS |
 			MMU_FTR_USE_TLBILX,
 		.icache_bsize		= 64,
@@ -2073,9 +2076,9 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.num_pmcs		= 4,
 		.oprofile_cpu_type	= "ppc/e6500",
 		.oprofile_type		= PPC_OPROFILE_FSL_EMB,
-		.cpu_setup		= __setup_cpu_e5500,
+		.cpu_setup		= __setup_cpu_e6500,
 #ifndef CONFIG_PPC32
-		.cpu_restore		= __restore_cpu_e5500,
+		.cpu_restore		= __restore_cpu_e6500,
 #endif
 		.machine_check		= machine_check_e500mc,
 		.platform		= "ppce6500",
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index ae54553..42a756e 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -299,6 +299,8 @@ interrupt_base_book3e:					/* fake trap */
 	EXCEPTION_STUB(0x1a0, watchdog)			/* 0x09f0 */
 	EXCEPTION_STUB(0x1c0, data_tlb_miss)
 	EXCEPTION_STUB(0x1e0, instruction_tlb_miss)
+	EXCEPTION_STUB(0x200, altivec_unavailable)	/* 0x0f20 */
+	EXCEPTION_STUB(0x220, altivec_assist)		/* 0x1700 */
 	EXCEPTION_STUB(0x260, perfmon)
 	EXCEPTION_STUB(0x280, doorbell)
 	EXCEPTION_STUB(0x2a0, doorbell_crit)
@@ -395,6 +397,45 @@ interrupt_end_book3e:
 	bl	.kernel_fp_unavailable_exception
 	b	.ret_from_except
 
+/* Altivec Unavailable Interrupt */
+	START_EXCEPTION(altivec_unavailable);
+	NORMAL_EXCEPTION_PROLOG(0x200, BOOKE_INTERRUPT_ALTIVEC_UNAVAIL,
+				PROLOG_ADDITION_NONE)
+	/* we can probably do a shorter exception entry for that one... */
+	EXCEPTION_COMMON(0x200, PACA_EXGEN, INTS_KEEP)
+#ifdef CONFIG_ALTIVEC
+BEGIN_FTR_SECTION
+	ld	r12,_MSR(r1)
+	andi.	r0,r12,MSR_PR;
+	beq-	1f
+	bl	.load_up_altivec
+	b	fast_exception_return
+1:
+END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
+#endif
+	INTS_DISABLE
+	bl	.save_nvgprs
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	.altivec_unavailable_exception
+	b	.ret_from_except
+
+/* AltiVec Assist */
+	START_EXCEPTION(altivec_assist);
+	NORMAL_EXCEPTION_PROLOG(0x220, BOOKE_INTERRUPT_ALTIVEC_ASSIST,
+				PROLOG_ADDITION_NONE)
+	EXCEPTION_COMMON(0x220, PACA_EXGEN, INTS_DISABLE)
+	bl	.save_nvgprs
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+#ifdef CONFIG_ALTIVEC
+BEGIN_FTR_SECTION
+	bl	.altivec_assist_exception
+END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
+#else
+	bl	.unknown_exception
+#endif
+	b	.ret_from_except
+
+
 /* Decrementer Interrupt */
 	MASKABLE_EXCEPTION(0x900, BOOKE_INTERRUPT_DECREMENTER,
 			   decrementer, .timer_interrupt, ACK_DEC)
@@ -807,6 +848,7 @@ fast_exception_return:
 BAD_STACK_TRAMPOLINE(0x000)
 BAD_STACK_TRAMPOLINE(0x100)
 BAD_STACK_TRAMPOLINE(0x200)
+BAD_STACK_TRAMPOLINE(0x220)
 BAD_STACK_TRAMPOLINE(0x260)
 BAD_STACK_TRAMPOLINE(0x280)
 BAD_STACK_TRAMPOLINE(0x2a0)
@@ -1350,6 +1392,11 @@ _GLOBAL(__setup_base_ivors)
 
 	blr
 
+_GLOBAL(setup_altivec_ivors)
+	SET_IVOR(32, 0x200) /* AltiVec Unavailable */
+	SET_IVOR(33, 0x220) /* AltiVec Assist */
+	blr
+
 _GLOBAL(setup_perfmon_ivor)
 	SET_IVOR(35, 0x260) /* Performance Monitor */
 	blr
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index cea2f09..6dfdb65 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -232,7 +232,7 @@ config PHYS_64BIT
 
 config ALTIVEC
 	bool "AltiVec Support"
-	depends on 6xx || POWER4
+	depends on 6xx || POWER4 || (PPC_E500MC && PPC64)
 	---help---
 	  This option enables kernel support for the Altivec extensions to the
 	  PowerPC processor. The kernel currently supports saving and restoring
-- 
1.7.9.7

Return-Path: <SRS0=8VeL=N4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425E6C43441
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 10:29:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAB7D20817
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 10:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAB7D20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42xrtK6XCjzF3VW
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 21:28:57 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42xrnm4WwmzF3jQ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Nov 2018 21:25:00 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42xrnf2nNYz9ty09;
 Sat, 17 Nov 2018 11:24:54 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id IsKbEBsalRHo; Sat, 17 Nov 2018 11:24:54 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42xrnf1ztYz9ty07;
 Sat, 17 Nov 2018 11:24:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 6503A8B78A;
 Sat, 17 Nov 2018 11:24:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id MmIoU5FXUkzR; Sat, 17 Nov 2018 11:24:57 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1159E8B74B;
 Sat, 17 Nov 2018 11:24:57 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id DA3E469A6C; Sat, 17 Nov 2018 10:24:56 +0000 (UTC)
Message-Id: <73b5e7a43bb5979ac534d1c236adb2e04f9d6307.1542395798.git.christophe.leroy@c-s.fr>
In-Reply-To: <aeeaafbdf0357f8bdb8ffd86822a0ddfd5521fd6.1542395798.git.christophe.leroy@c-s.fr>
References: <aeeaafbdf0357f8bdb8ffd86822a0ddfd5521fd6.1542395798.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 2/7] powerpc: change CONFIG_6xx to CONFIG_PPC_BOOK3S_32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 rjw@rjwysocki.net, viresh.kumar@linaro.org
Date: Sat, 17 Nov 2018 10:24:56 +0000 (UTC)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Today we have:

config PPC_BOOK3S_32
	bool "512x/52xx/6xx/7xx/74xx/82xx/83xx/86xx"
	[depends on PPC32 within a choice]

config PPC_BOOK3S
	def_bool y
	depends on PPC_BOOK3S_32 || PPC_BOOK3S_64

config 6xx
	def_bool y
	depends on PPC32 && PPC_BOOK3S

6xx is therefore redundant with PPC_BOOK3S_32.

In order to make the code clearer, lets use preferably PPC_BOOK3S_32.
This will allow to remove CONFIG_6xx in a later patch.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Makefile                     |  2 +-
 arch/powerpc/include/asm/cache.h          |  2 +-
 arch/powerpc/include/asm/mmu.h            |  2 +-
 arch/powerpc/include/asm/reg.h            |  2 +-
 arch/powerpc/include/asm/time.h           |  2 +-
 arch/powerpc/kernel/Makefile              |  2 +-
 arch/powerpc/kernel/cpu_setup_6xx.S       |  2 +-
 arch/powerpc/kernel/entry_32.S            | 10 +++++-----
 arch/powerpc/kernel/head_32.S             | 14 +++++++-------
 arch/powerpc/kernel/misc_32.S             |  4 ++--
 arch/powerpc/kernel/pmc.c                 |  2 +-
 arch/powerpc/kernel/setup_32.c            |  2 +-
 arch/powerpc/kernel/sysfs.c               |  2 +-
 arch/powerpc/mm/mmu_decl.h                |  2 +-
 arch/powerpc/oprofile/Makefile            |  2 +-
 arch/powerpc/oprofile/common.c            |  2 +-
 arch/powerpc/platforms/powermac/cache.S   |  4 ++--
 arch/powerpc/platforms/powermac/feature.c |  2 +-
 arch/powerpc/platforms/powermac/sleep.S   |  4 ++--
 arch/powerpc/sysdev/Makefile              |  2 +-
 20 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 8a2ce14d68d0..e259b8a2dd44 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -241,7 +241,7 @@ KBUILD_CFLAGS	+= $(call cc-option,-fno-dwarf2-cfi-asm)
 # often slow when they are implemented at all
 KBUILD_CFLAGS		+= $(call cc-option,-mno-string)
 
-ifdef CONFIG_6xx
+ifdef CONFIG_PPC_BOOK3S_32
 KBUILD_CFLAGS		+= -mcpu=powerpc
 endif
 
diff --git a/arch/powerpc/include/asm/cache.h b/arch/powerpc/include/asm/cache.h
index 66298461b640..40ea5b3781c6 100644
--- a/arch/powerpc/include/asm/cache.h
+++ b/arch/powerpc/include/asm/cache.h
@@ -71,7 +71,7 @@ extern struct ppc64_caches ppc64_caches;
 #else
 #define __read_mostly __attribute__((__section__(".data..read_mostly")))
 
-#ifdef CONFIG_6xx
+#ifdef CONFIG_PPC_BOOK3S_32
 extern long _get_L2CR(void);
 extern long _get_L3CR(void);
 extern void _set_L2CR(unsigned long);
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index eb20eb3b8fb0..47b651deff5b 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -48,7 +48,7 @@
 #define MMU_FTR_USE_HIGH_BATS		ASM_CONST(0x00010000)
 
 /* Enable >32-bit physical addresses on 32-bit processor, only used
- * by CONFIG_6xx currently as BookE supports that from day 1
+ * by CONFIG_PPC_BOOK3S_32 currently as BookE supports that from day 1
  */
 #define MMU_FTR_BIG_PHYS		ASM_CONST(0x00020000)
 
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index de52c3166ba4..0d2139a0d5b9 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -582,7 +582,7 @@
 #define HID0_POWER9_RADIX	__MASK(63 - 8)
 
 #define SPRN_HID1	0x3F1		/* Hardware Implementation Register 1 */
-#ifdef CONFIG_6xx
+#ifdef CONFIG_PPC_BOOK3S_32
 #define HID1_EMCP	(1<<31)		/* 7450 Machine Check Pin Enable */
 #define HID1_DFS	(1<<22)		/* 7447A Dynamic Frequency Scaling */
 #define HID1_PC0	(1<<16)		/* 7450 PLL_CFG[0] */
diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index b80d492ceb29..54bf7e68a7e1 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -43,7 +43,7 @@ struct div_result {
 
 /* Accessor functions for the timebase (RTC on 601) registers. */
 /* If one day CONFIG_POWER is added just define __USE_RTC as 1 */
-#ifdef CONFIG_6xx
+#ifdef CONFIG_PPC_BOOK3S_32
 #define __USE_RTC()	(cpu_has_feature(CPU_FTR_USE_RTC))
 #else
 #define __USE_RTC()	0
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 53d4b8d5b54d..a5a6a243f3cf 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -69,7 +69,7 @@ obj-$(CONFIG_FA_DUMP)		+= fadump.o
 ifdef CONFIG_PPC32
 obj-$(CONFIG_E500)		+= idle_e500.o
 endif
-obj-$(CONFIG_6xx)		+= idle_6xx.o l2cr_6xx.o cpu_setup_6xx.o
+obj-$(CONFIG_PPC_BOOK3S_32)	+= idle_6xx.o l2cr_6xx.o cpu_setup_6xx.o
 obj-$(CONFIG_TAU)		+= tau_6xx.o
 obj-$(CONFIG_HIBERNATION)	+= swsusp.o suspend.o
 ifdef CONFIG_FSL_BOOKE
diff --git a/arch/powerpc/kernel/cpu_setup_6xx.S b/arch/powerpc/kernel/cpu_setup_6xx.S
index fa3c2c91290c..8c069e96c478 100644
--- a/arch/powerpc/kernel/cpu_setup_6xx.S
+++ b/arch/powerpc/kernel/cpu_setup_6xx.S
@@ -326,7 +326,7 @@ _GLOBAL(__save_cpu_setup)
 	lis	r5,cpu_state_storage@h
 	ori	r5,r5,cpu_state_storage@l
 
-	/* Save HID0 (common to all CONFIG_6xx cpus) */
+	/* Save HID0 (common to all CONFIG_PPC_BOOK3S_32 cpus) */
 	mfspr	r3,SPRN_HID0
 	stw	r3,CS_HID0(r5)
 
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 77decded1175..0768dfd8a64e 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -200,14 +200,14 @@ transfer_to_handler:
 	cmplw	r1,r9			/* if r1 <= ksp_limit */
 	ble-	stack_ovf		/* then the kernel stack overflowed */
 5:
-#if defined(CONFIG_6xx) || defined(CONFIG_E500)
+#if defined(CONFIG_PPC_BOOK3S_32) || defined(CONFIG_E500)
 	CURRENT_THREAD_INFO(r9, r1)
 	tophys(r9,r9)			/* check local flags */
 	lwz	r12,TI_LOCAL_FLAGS(r9)
 	mtcrf	0x01,r12
 	bt-	31-TLF_NAPPING,4f
 	bt-	31-TLF_SLEEPING,7f
-#endif /* CONFIG_6xx || CONFIG_E500 */
+#endif /* CONFIG_PPC_BOOK3S_32 || CONFIG_E500 */
 	.globl transfer_to_handler_cont
 transfer_to_handler_cont:
 3:
@@ -273,7 +273,7 @@ reenable_mmu:				/* re-enable mmu so we can */
 	RFI				/* jump to handler, enable MMU */
 #endif /* CONFIG_TRACE_IRQFLAGS */
 
-#if defined (CONFIG_6xx) || defined(CONFIG_E500)
+#if defined (CONFIG_PPC_BOOK3S_32) || defined(CONFIG_E500)
 4:	rlwinm	r12,r12,0,~_TLF_NAPPING
 	stw	r12,TI_LOCAL_FLAGS(r9)
 	b	power_save_ppc32_restore
@@ -612,7 +612,7 @@ ppc_swapcontext:
 handle_page_fault:
 	stw	r4,_DAR(r1)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-#ifdef CONFIG_6xx
+#ifdef CONFIG_PPC_BOOK3S_32
 	andis.  r0,r5,DSISR_DABRMATCH@h
 	bne-    handle_dabr_fault
 #endif
@@ -629,7 +629,7 @@ handle_page_fault:
 	bl	bad_page_fault
 	b	ret_from_except_full
 
-#ifdef CONFIG_6xx
+#ifdef CONFIG_PPC_BOOK3S_32
 	/* We have a data breakpoint exception - handle it */
 handle_dabr_fault:
 	SAVE_NVGPRS(r1)
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 61ca27929355..118c3b216e60 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -176,10 +176,10 @@ __after_mmu_off:
 	bl	reloc_offset
 	li	r24,0			/* cpu# */
 	bl	call_setup_cpu		/* Call setup_cpu for this CPU */
-#ifdef CONFIG_6xx
+#ifdef CONFIG_PPC_BOOK3S_32
 	bl	reloc_offset
 	bl	init_idle_6xx
-#endif /* CONFIG_6xx */
+#endif /* CONFIG_PPC_BOOK3S_32 */
 
 
 /*
@@ -836,10 +836,10 @@ __secondary_start:
 	lis	r3,-KERNELBASE@h
 	mr	r4,r24
 	bl	call_setup_cpu		/* Call setup_cpu for this CPU */
-#ifdef CONFIG_6xx
+#ifdef CONFIG_PPC_BOOK3S_32
 	lis	r3,-KERNELBASE@h
 	bl	init_idle_6xx
-#endif /* CONFIG_6xx */
+#endif /* CONFIG_PPC_BOOK3S_32 */
 
 	/* get current_thread_info and current */
 	lis	r1,secondary_ti@ha
@@ -880,14 +880,14 @@ __secondary_start:
 
 /*
  * Those generic dummy functions are kept for CPUs not
- * included in CONFIG_6xx
+ * included in CONFIG_PPC_BOOK3S_32
  */
-#if !defined(CONFIG_6xx)
+#if !defined(CONFIG_PPC_BOOK3S_32)
 _ENTRY(__save_cpu_setup)
 	blr
 _ENTRY(__restore_cpu_setup)
 	blr
-#endif /* !defined(CONFIG_6xx) */
+#endif /* !defined(CONFIG_PPC_BOOK3S_32) */
 
 
 /*
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 695b24a2d954..57d2ffb2d45c 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -153,7 +153,7 @@ _GLOBAL(call_setup_cpu)
 	mtctr	r5
 	bctr
 
-#if defined(CONFIG_CPU_FREQ_PMAC) && defined(CONFIG_6xx)
+#if defined(CONFIG_CPU_FREQ_PMAC) && defined(CONFIG_PPC_BOOK3S_32)
 
 /* This gets called by via-pmu.c to switch the PLL selection
  * on 750fx CPU. This function should really be moved to some
@@ -223,7 +223,7 @@ _GLOBAL(low_choose_7447a_dfs)
 	mtmsr	r7
 	blr
 
-#endif /* CONFIG_CPU_FREQ_PMAC && CONFIG_6xx */
+#endif /* CONFIG_CPU_FREQ_PMAC && CONFIG_PPC_BOOK3S_32 */
 
 /*
  * complement mask on the msr then "or" some values on.
diff --git a/arch/powerpc/kernel/pmc.c b/arch/powerpc/kernel/pmc.c
index 58eaa3ddf7b9..2de71faca911 100644
--- a/arch/powerpc/kernel/pmc.c
+++ b/arch/powerpc/kernel/pmc.c
@@ -29,7 +29,7 @@ static void dummy_perf(struct pt_regs *regs)
 {
 #if defined(CONFIG_FSL_EMB_PERFMON)
 	mtpmr(PMRN_PMGC0, mfpmr(PMRN_PMGC0) & ~PMGC0_PMIE);
-#elif defined(CONFIG_PPC64) || defined(CONFIG_6xx)
+#elif defined(CONFIG_PPC64) || defined(CONFIG_PPC_BOOK3S_32)
 	if (cur_cpu_spec->pmc_type == PPC_PMC_IBM)
 		mtspr(SPRN_MMCR0, mfspr(SPRN_MMCR0) & ~(MMCR0_PMXE|MMCR0_PMAO));
 #else
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 81909600013a..972c98d1e208 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -240,7 +240,7 @@ void __init exc_lvl_early_init(void)
 
 void __init setup_power_save(void)
 {
-#ifdef CONFIG_6xx
+#ifdef CONFIG_PPC_BOOK3S_32
 	if (cpu_has_feature(CPU_FTR_CAN_DOZE) ||
 	    cpu_has_feature(CPU_FTR_CAN_NAP))
 		ppc_md.power_save = ppc6xx_idle;
diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 755dc98a57ae..e8e93c2c7d03 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -457,7 +457,7 @@ static ssize_t __used \
 #define HAS_PPC_PMC_CLASSIC	1
 #define HAS_PPC_PMC_IBM		1
 #define HAS_PPC_PMC_PA6T	1
-#elif defined(CONFIG_6xx)
+#elif defined(CONFIG_PPC_BOOK3S_32)
 #define HAS_PPC_PMC_CLASSIC	1
 #define HAS_PPC_PMC_IBM		1
 #define HAS_PPC_PMC_G4		1
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 8574fbbc45e0..c4a717da65eb 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -155,7 +155,7 @@ struct tlbcam {
 };
 #endif
 
-#if defined(CONFIG_6xx) || defined(CONFIG_FSL_BOOKE) || defined(CONFIG_PPC_8xx)
+#if defined(CONFIG_PPC_BOOK3S_32) || defined(CONFIG_FSL_BOOKE) || defined(CONFIG_PPC_8xx)
 /* 6xx have BATS */
 /* FSL_BOOKE have TLBCAM */
 /* 8xx have LTLB */
diff --git a/arch/powerpc/oprofile/Makefile b/arch/powerpc/oprofile/Makefile
index 8d26d7416481..bb2d94c8cbe6 100644
--- a/arch/powerpc/oprofile/Makefile
+++ b/arch/powerpc/oprofile/Makefile
@@ -16,4 +16,4 @@ oprofile-$(CONFIG_OPROFILE_CELL) += op_model_cell.o \
 		cell/spu_task_sync.o
 oprofile-$(CONFIG_PPC_BOOK3S_64) += op_model_power4.o op_model_pa6t.o
 oprofile-$(CONFIG_FSL_EMB_PERFMON) += op_model_fsl_emb.o
-oprofile-$(CONFIG_6xx) += op_model_7450.o
+oprofile-$(CONFIG_PPC_BOOK3S_32) += op_model_7450.o
diff --git a/arch/powerpc/oprofile/common.c b/arch/powerpc/oprofile/common.c
index bf094c5a4bd9..a11132865504 100644
--- a/arch/powerpc/oprofile/common.c
+++ b/arch/powerpc/oprofile/common.c
@@ -212,7 +212,7 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
 			model = &op_model_pa6t;
 			break;
 #endif
-#ifdef CONFIG_6xx
+#ifdef CONFIG_PPC_BOOK3S_32
 		case PPC_OPROFILE_G4:
 			model = &op_model_7450;
 			break;
diff --git a/arch/powerpc/platforms/powermac/cache.S b/arch/powerpc/platforms/powermac/cache.S
index 27862feee4a5..f0641b6e6075 100644
--- a/arch/powerpc/platforms/powermac/cache.S
+++ b/arch/powerpc/platforms/powermac/cache.S
@@ -28,7 +28,7 @@
  */
 
 _GLOBAL(flush_disable_caches)
-#ifndef CONFIG_6xx
+#ifndef CONFIG_PPC_BOOK3S_32
 	blr
 #else
 BEGIN_FTR_SECTION
@@ -356,4 +356,4 @@ END_FTR_SECTION_IFSET(CPU_FTR_L3CR)
 	mtmsr	r11		/* restore DR and EE */
 	isync
 	blr
-#endif	/* CONFIG_6xx */
+#endif	/* CONFIG_PPC_BOOK3S_32 */
diff --git a/arch/powerpc/platforms/powermac/feature.c b/arch/powerpc/platforms/powermac/feature.c
index ed2f54b3f173..073ff4544083 100644
--- a/arch/powerpc/platforms/powermac/feature.c
+++ b/arch/powerpc/platforms/powermac/feature.c
@@ -51,7 +51,7 @@
 #define DBG(fmt...)
 #endif
 
-#ifdef CONFIG_6xx
+#ifdef CONFIG_PPC_BOOK3S_32
 extern int powersave_lowspeed;
 #endif
 
diff --git a/arch/powerpc/platforms/powermac/sleep.S b/arch/powerpc/platforms/powermac/sleep.S
index f89808b9713d..fb64b09cad9d 100644
--- a/arch/powerpc/platforms/powermac/sleep.S
+++ b/arch/powerpc/platforms/powermac/sleep.S
@@ -56,7 +56,7 @@
  * vector that will be called by the ROM on wakeup
  */
 _GLOBAL(low_sleep_handler)
-#ifndef CONFIG_6xx
+#ifndef CONFIG_PPC_BOOK3S_32
 	blr
 #else
 	mflr	r0
@@ -394,5 +394,5 @@ sleep_storage:
 	.long 0
 	.balign	L1_CACHE_BYTES, 0
 
-#endif /* CONFIG_6xx */
+#endif /* CONFIG_PPC_BOOK3S_32 */
 	.section .text
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 2caa4defdfb6..aaf23283ba0c 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -48,7 +48,7 @@ obj-$(CONFIG_PPC_MPC512x)	+= mpc5xxx_clocks.o
 obj-$(CONFIG_PPC_MPC52xx)	+= mpc5xxx_clocks.o
 
 ifdef CONFIG_SUSPEND
-obj-$(CONFIG_6xx)		+= 6xx-suspend.o
+obj-$(CONFIG_PPC_BOOK3S_32)	+= 6xx-suspend.o
 endif
 
 obj-$(CONFIG_PPC_SCOM)		+= scom.o
-- 
2.13.3


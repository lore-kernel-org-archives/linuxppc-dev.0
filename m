Return-Path: <nicholas.piggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rw46C3d50zDqTC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 16:45:23 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id h186so4888844pfg.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 23:45:23 -0700 (PDT)
From: Nicholas Piggin <nicholas.piggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 13/14] powerpc/pseries: consolidate slb exceptions
Date: Thu, 21 Jul 2016 16:44:12 +1000
Message-Id: <1469083453-9279-14-git-send-email-npiggin@gmail.com>
In-Reply-To: <1469083453-9279-1-git-send-email-npiggin@gmail.com>
References: <1469083453-9279-1-git-send-email-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

slb exceptions all follow the same pattern, so put it in a macro.
Generated code should be the same.

Signed-off-by: Nick Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 172 ++++++++++++++---------------------
 1 file changed, 69 insertions(+), 103 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index b7a8a66..c317faf 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -497,111 +497,32 @@ MMU_FTR_SECTION_ELSE
 ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_RADIX)
 COMMON_HANDLER_END(data_access_common)
 
-
-VECTOR_HANDLER_REAL_BEGIN(data_access_slb, 0x380, 0x400)
-	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_0(PACA_EXSLB)
-	EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST_PR, 0x380)
-	std	r3,PACA_EXSLB+EX_R3(r13)
-	mfspr	r3,SPRN_DAR
-	mfspr	r12,SPRN_SRR1
-#ifndef CONFIG_RELOCATABLE
-	b	slb_miss_realmode
-#else
-	/*
-	 * We can't just use a direct branch to slb_miss_realmode
-	 * because the distance from here to there depends on where
-	 * the kernel ends up being put.
-	 */
-	mfctr	r11
-	ld	r10,PACAKBASE(r13)
-	LOAD_HANDLER_4G(r10, slb_miss_realmode)
-	mtctr	r10
-	bctr
-#endif
-VECTOR_HANDLER_REAL_END(data_access_slb, 0x380, 0x400)
-
-VECTOR_HANDLER_VIRT_BEGIN(data_access_slb, 0x4380, 0x4400)
-	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_0(PACA_EXSLB)
-	EXCEPTION_PROLOG_1(PACA_EXSLB, NOTEST, 0x380)
-	std	r3,PACA_EXSLB+EX_R3(r13)
-	mfspr	r3,SPRN_DAR
-	mfspr	r12,SPRN_SRR1
-#ifndef CONFIG_RELOCATABLE
-	b	slb_miss_realmode
-#else
-	/*
-	 * We can't just use a direct branch to slb_miss_realmode
-	 * because the distance from here to there depends on where
-	 * the kernel ends up being put.
-	 */
-	mfctr	r11
-	ld	r10,PACAKBASE(r13)
-	LOAD_HANDLER_4G(r10, slb_miss_realmode)
-	mtctr	r10
-	bctr
-#endif
-VECTOR_HANDLER_VIRT_END(data_access_slb, 0x4380, 0x4400)
-TRAMP_KVM_SKIP(PACA_EXSLB, 0x380)
-
-
-VECTOR_HANDLER_REAL(instruction_access, 0x400, 0x480)
-VECTOR_HANDLER_VIRT(instruction_access, 0x4400, 0x4480, 0x400)
-TRAMP_KVM(PACA_EXGEN, 0x400)
-COMMON_HANDLER_BEGIN(instruction_access_common)
-	EXCEPTION_PROLOG_COMMON(0x400, PACA_EXGEN)
-	RECONCILE_IRQ_STATE(r10, r11)
-	ld	r12,_MSR(r1)
-	ld	r3,_NIP(r1)
-	andis.	r4,r12,0x5820
-	li	r5,0x400
-	std	r3,_DAR(r1)
-	std	r4,_DSISR(r1)
-BEGIN_MMU_FTR_SECTION
-	b	do_hash_page		/* Try to handle as hpte fault */
-MMU_FTR_SECTION_ELSE
-	b	handle_page_fault
-ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_RADIX)
-COMMON_HANDLER_END(instruction_access_common)
-
-
-VECTOR_HANDLER_REAL_BEGIN(instruction_access_slb, 0x480, 0x500)
-	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_0(PACA_EXSLB)
-	EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST_PR, 0x480)
-	std	r3,PACA_EXSLB+EX_R3(r13)
-	mfspr	r3,SPRN_SRR0		/* SRR0 is faulting address */
-	mfspr	r12,SPRN_SRR1
-#ifndef CONFIG_RELOCATABLE
-	b	slb_miss_realmode
-#else
-	mfctr	r11
-	ld	r10,PACAKBASE(r13)
-	LOAD_HANDLER_4G(r10, slb_miss_realmode)
-	mtctr	r10
-	bctr
-#endif
-VECTOR_HANDLER_REAL_END(instruction_access_slb, 0x480, 0x500)
-VECTOR_HANDLER_VIRT_BEGIN(instruction_access_slb, 0x4480, 0x4500)
-	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_0(PACA_EXSLB)
-	EXCEPTION_PROLOG_1(PACA_EXSLB, NOTEST, 0x480)
-	std	r3,PACA_EXSLB+EX_R3(r13)
-	mfspr	r3,SPRN_SRR0		/* SRR0 is faulting address */
-	mfspr	r12,SPRN_SRR1
-#ifndef CONFIG_RELOCATABLE
-	b	slb_miss_realmode
+/*
+ * SLB miss macro takes care of all 4 cases (I/D, real/virt)
+ */
+#if defined(CONFIG_RELOCATABLE)
+#define SLB_ACCESS_EXCEPTION(addr_spr, vec, TEST)		\
+	SET_SCRATCH0(r13);					\
+	EXCEPTION_PROLOG_0(PACA_EXSLB);				\
+	EXCEPTION_PROLOG_1(PACA_EXSLB, TEST, vec);		\
+	std	r3,PACA_EXSLB+EX_R3(r13);			\
+	mfspr	r3,addr_spr;					\
+	mfspr	r12,SPRN_SRR1;					\
+	mfctr	r11;						\
+	ld	r10,PACAKBASE(r13);				\
+	LOAD_HANDLER_4G(r10, slb_miss_realmode);		\
+	mtctr	r10;						\
+	bctr;
 #else
-	mfctr	r11
-	ld	r10,PACAKBASE(r13)
-	LOAD_HANDLER_4G(r10, slb_miss_realmode)
-	mtctr	r10
-	bctr
+#define SLB_ACCESS_EXCEPTION(addr_spr, vec, TEST)		\
+	SET_SCRATCH0(r13);					\
+	EXCEPTION_PROLOG_0(PACA_EXSLB);				\
+	EXCEPTION_PROLOG_1(PACA_EXSLB, TEST, vec);		\
+	std	r3,PACA_EXSLB+EX_R3(r13);			\
+	mfspr	r3,addr_spr;					\
+	mfspr	r12,SPRN_SRR1;					\
+	b	slb_miss_realmode;
 #endif
-VECTOR_HANDLER_VIRT_END(instruction_access_slb, 0x4480, 0x4500)
-TRAMP_KVM(PACA_EXSLB, 0x480)
-
 
 TRAMP_HANDLER_BEGIN(slb_miss_realmode)
 	/*
@@ -674,6 +595,45 @@ COMMON_HANDLER_BEGIN(unrecov_slb)
 COMMON_HANDLER_END(unrecov_slb)
 
 
+VECTOR_HANDLER_REAL_BEGIN(data_access_slb, 0x380, 0x400)
+	SLB_ACCESS_EXCEPTION(SPRN_DAR, 0x380, KVMTEST_PR)
+VECTOR_HANDLER_REAL_END(data_access_slb, 0x380, 0x400)
+
+VECTOR_HANDLER_VIRT_BEGIN(data_access_slb, 0x4380, 0x4400)
+	SLB_ACCESS_EXCEPTION(SPRN_DAR, 0x380, NOTEST)
+VECTOR_HANDLER_VIRT_END(data_access_slb, 0x4380, 0x4400)
+TRAMP_KVM_SKIP(PACA_EXSLB, 0x380)
+
+
+VECTOR_HANDLER_REAL(instruction_access, 0x400, 0x480)
+VECTOR_HANDLER_VIRT(instruction_access, 0x4400, 0x4480, 0x400)
+TRAMP_KVM(PACA_EXGEN, 0x400)
+COMMON_HANDLER_BEGIN(instruction_access_common)
+	EXCEPTION_PROLOG_COMMON(0x400, PACA_EXGEN)
+	RECONCILE_IRQ_STATE(r10, r11)
+	ld	r12,_MSR(r1)
+	ld	r3,_NIP(r1)
+	andis.	r4,r12,0x5820
+	li	r5,0x400
+	std	r3,_DAR(r1)
+	std	r4,_DSISR(r1)
+BEGIN_MMU_FTR_SECTION
+	b	do_hash_page		/* Try to handle as hpte fault */
+MMU_FTR_SECTION_ELSE
+	b	handle_page_fault
+ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_RADIX)
+COMMON_HANDLER_END(instruction_access_common)
+
+
+VECTOR_HANDLER_REAL_BEGIN(instruction_access_slb, 0x480, 0x500)
+	SLB_ACCESS_EXCEPTION(SPRN_SRR0, 0x480, KVMTEST_PR)
+VECTOR_HANDLER_REAL_END(instruction_access_slb, 0x480, 0x500)
+VECTOR_HANDLER_VIRT_BEGIN(instruction_access_slb, 0x4480, 0x4500)
+	SLB_ACCESS_EXCEPTION(SPRN_SRR0, 0x480, NOTEST)
+VECTOR_HANDLER_VIRT_END(instruction_access_slb, 0x4480, 0x4500)
+TRAMP_KVM(PACA_EXSLB, 0x480)
+
+
 VECTOR_HANDLER_REAL_BEGIN(hardware_interrupt, 0x500, 0x600)
 	.globl hardware_interrupt_hv;
 hardware_interrupt_hv:
@@ -922,7 +882,13 @@ TRAMP_KVM_HV(PACA_EXGEN, 0xe40)
 COMMON_HANDLER(emulation_assist_common, 0xe40, emulation_assist_interrupt)
 
 
+/*
+ * hmi_exception trampoline is a special case. It jumps to hmi_exception_early
+ * first, and then eventaully from there to the trampoline to get into virtual
+ * mode.
+ */
 __VECTOR_HANDLER_REAL_OOL_HV_DIRECT(hmi_exception, 0xe60, 0xe80, hmi_exception_early)
+__TRAMP_HANDLER_REAL_OOL_MASKABLE_HV(hmi_exception, 0xe60)
 VECTOR_HANDLER_VIRT_NONE(0x4e60, 0x4e80)
 TRAMP_KVM_HV(PACA_EXGEN, 0xe60)
 COMMON_HANDLER_BEGIN(hmi_exception_early)
-- 
2.8.1

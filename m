Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wW2P42nyNzDqMl
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 May 2017 23:16:24 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id u26so14498572pfd.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 May 2017 06:16:24 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 4/9] powerpc/64s: SLB miss handler avoid r3 save/restore
Date: Sun, 21 May 2017 23:15:45 +1000
Message-Id: <20170521131550.25813-5-npiggin@gmail.com>
In-Reply-To: <20170521131550.25813-1-npiggin@gmail.com>
References: <20170521131550.25813-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The SLB miss handler uses r3 for the faulting address but r12 is
mostly able to be freed up to save r3 in. It just requires SRR1
be reloaded again on error.

It would be more conventional to use r12 for SRR1 (and use r11 to
save r3), but slb_allocate_realmode clobbers r11 and not r12.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 486e205cc762..6ba4c4c6ae69 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -507,9 +507,9 @@ EXC_REAL_BEGIN(data_access_slb, 0x380, 0x80)
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXSLB)
 	EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST_PR, 0x380)
-	std	r3,PACA_EXSLB+EX_R3(r13)
+	mr	r12,r3	/* save r3 */
 	mfspr	r3,SPRN_DAR
-	mfspr	r12,SPRN_SRR1
+	mfspr	r11,SPRN_SRR1
 	crset	4*cr6+eq
 #ifndef CONFIG_RELOCATABLE
 	b	slb_miss_realmode
@@ -530,9 +530,9 @@ EXC_VIRT_BEGIN(data_access_slb, 0x4380, 0x80)
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXSLB)
 	EXCEPTION_PROLOG_1(PACA_EXSLB, NOTEST, 0x380)
-	std	r3,PACA_EXSLB+EX_R3(r13)
+	mr	r12,r3	/* save r3 */
 	mfspr	r3,SPRN_DAR
-	mfspr	r12,SPRN_SRR1
+	mfspr	r11,SPRN_SRR1
 	crset	4*cr6+eq
 #ifndef CONFIG_RELOCATABLE
 	b	slb_miss_realmode
@@ -575,9 +575,9 @@ EXC_REAL_BEGIN(instruction_access_slb, 0x480, 0x80)
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXSLB)
 	EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST_PR, 0x480)
-	std	r3,PACA_EXSLB+EX_R3(r13)
+	mr	r12,r3	/* save r3 */
 	mfspr	r3,SPRN_SRR0		/* SRR0 is faulting address */
-	mfspr	r12,SPRN_SRR1
+	mfspr	r11,SPRN_SRR1
 	crclr	4*cr6+eq
 #ifndef CONFIG_RELOCATABLE
 	b	slb_miss_realmode
@@ -593,9 +593,9 @@ EXC_VIRT_BEGIN(instruction_access_slb, 0x4480, 0x80)
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXSLB)
 	EXCEPTION_PROLOG_1(PACA_EXSLB, NOTEST, 0x480)
-	std	r3,PACA_EXSLB+EX_R3(r13)
+	mr	r12,r3	/* save r3 */
 	mfspr	r3,SPRN_SRR0		/* SRR0 is faulting address */
-	mfspr	r12,SPRN_SRR1
+	mfspr	r11,SPRN_SRR1
 	crclr	4*cr6+eq
 #ifndef CONFIG_RELOCATABLE
 	b	slb_miss_realmode
@@ -613,10 +613,10 @@ TRAMP_KVM(PACA_EXSLB, 0x480)
 EXC_COMMON_BEGIN(slb_miss_realmode)
 	/*
 	 * r13 points to the PACA, r9 contains the saved CR,
-	 * r12 contain the saved SRR1, SRR0 is still ready for return
+	 * r12 contains the saved r3,
+	 * r11 contain the saved SRR1, SRR0 is still ready for return
 	 * r3 has the faulting address
 	 * r9 - r13 are saved in paca->exslb.
-	 * r3 is saved in paca->slb_r3
  	 * cr6.eq is set for a D-SLB miss, clear for a I-SLB miss
 	 * We assume we aren't going to take any exceptions during this
 	 * procedure.
@@ -625,6 +625,9 @@ EXC_COMMON_BEGIN(slb_miss_realmode)
 	stw	r9,PACA_EXSLB+EX_CCR(r13)	/* save CR in exc. frame */
 	std	r10,PACA_EXSLB+EX_LR(r13)	/* save LR */
 
+	andi.	r11,r11,MSR_RI	/* check for unrecoverable exception */
+	beq-	2f
+
 	crset	4*cr0+eq
 #ifdef CONFIG_PPC_STD_MMU_64
 BEGIN_MMU_FTR_SECTION
@@ -638,9 +641,6 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_TYPE_RADIX)
 
 	beq-	8f		/* if bad address, make full stack frame */
 
-	andi.	r10,r12,MSR_RI	/* check for unrecoverable exception */
-	beq-	2f
-
 	/* All done -- return from exception. */
 
 .machine	push
@@ -652,7 +652,7 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_TYPE_RADIX)
 
 	RESTORE_CTR(r9, PACA_EXSLB)
 	RESTORE_PPR_PACA(PACA_EXSLB, r9)
-	ld	r3,PACA_EXSLB+EX_R3(r13)
+	mr	r3,r12
 	ld	r9,PACA_EXSLB+EX_R9(r13)
 	ld	r10,PACA_EXSLB+EX_R10(r13)
 	ld	r11,PACA_EXSLB+EX_R11(r13)
@@ -662,8 +662,9 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_TYPE_RADIX)
 	b	.	/* prevent speculative execution */
 
 2:	std     r3,PACA_EXSLB+EX_DAR(r13)
-	ld	r3,PACA_EXSLB+EX_R3(r13)
+	mr	r3,r12
 	mfspr	r11,SPRN_SRR0
+	mfspr	r12,SPRN_SRR1
 	LOAD_HANDLER(r10,unrecov_slb)
 	mtspr	SPRN_SRR0,r10
 	ld	r10,PACAKMSR(r13)
@@ -672,8 +673,9 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_TYPE_RADIX)
 	b	.
 
 8:	std     r3,PACA_EXSLB+EX_DAR(r13)
-	ld	r3,PACA_EXSLB+EX_R3(r13)
+	mr	r3,r12
 	mfspr	r11,SPRN_SRR0
+	mfspr	r12,SPRN_SRR1
 	LOAD_HANDLER(r10,bad_addr_slb)
 	mtspr	SPRN_SRR0,r10
 	ld	r10,PACAKMSR(r13)
-- 
2.11.0

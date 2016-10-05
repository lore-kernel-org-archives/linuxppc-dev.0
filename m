Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spc2B178vzDrLw
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:23:14 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v3 07/42] powerpc/64s: Consolidate Data Storage 0x300 interrupt
Date: Wed,  5 Oct 2016 11:22:29 +1100
Message-Id: <1475626984-18770-8-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1475626984-18770-1-git-send-email-mpe@ellerman.id.au>
References: <1475626984-18770-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Nicholas Piggin <npiggin@gmail.com>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/exceptions-64s.S | 53 ++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index afdb2043b1f3..edab8cc4fdc1 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -515,6 +515,33 @@ EXC_COMMON_BEGIN(unrecover_mce)
 
 
 EXC_REAL(data_access, 0x300, 0x380)
+EXC_VIRT(data_access, 0x4300, 0x4380, 0x300)
+TRAMP_KVM_SKIP(PACA_EXGEN, 0x300)
+
+EXC_COMMON_BEGIN(data_access_common)
+	/*
+	 * Here r13 points to the paca, r9 contains the saved CR,
+	 * SRR0 and SRR1 are saved in r11 and r12,
+	 * r9 - r13 are saved in paca->exgen.
+	 */
+	mfspr	r10,SPRN_DAR
+	std	r10,PACA_EXGEN+EX_DAR(r13)
+	mfspr	r10,SPRN_DSISR
+	stw	r10,PACA_EXGEN+EX_DSISR(r13)
+	EXCEPTION_PROLOG_COMMON(0x300, PACA_EXGEN)
+	RECONCILE_IRQ_STATE(r10, r11)
+	ld	r12,_MSR(r1)
+	ld	r3,PACA_EXGEN+EX_DAR(r13)
+	lwz	r4,PACA_EXGEN+EX_DSISR(r13)
+	li	r5,0x300
+	std	r3,_DAR(r1)
+	std	r4,_DSISR(r1)
+BEGIN_MMU_FTR_SECTION
+	b	do_hash_page		/* Try to handle as hpte fault */
+MMU_FTR_SECTION_ELSE
+	b	handle_page_fault
+ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
+
 
 EXC_REAL_BEGIN(data_access_slb, 0x380, 0x400)
 	SET_SCRATCH0(r13)
@@ -720,7 +747,6 @@ EXC_REAL_NONE(0x1800, 0x1900)
 /*** Out of line interrupts support ***/
 
 	/* moved from 0x200 */
-TRAMP_KVM_SKIP(PACA_EXGEN, 0x300)
 TRAMP_KVM_SKIP(PACA_EXSLB, 0x380)
 TRAMP_KVM(PACA_EXGEN, 0x400)
 TRAMP_KVM(PACA_EXSLB, 0x480)
@@ -990,7 +1016,6 @@ EXC_COMMON(altivec_assist_common, 0x1700, unknown_exception)
 	 * come here.
 	 */
 
-EXC_VIRT(data_access, 0x4300, 0x4380, 0x300)
 
 EXC_VIRT_BEGIN(data_access_slb, 0x4380, 0x4400)
 	SET_SCRATCH0(r13)
@@ -1115,30 +1140,6 @@ EXC_VIRT_NONE(0x5800, 0x5900)
 EXC_COMMON_BEGIN(ppc64_runlatch_on_trampoline)
 	b	__ppc64_runlatch_on
 
-/*
- * Here r13 points to the paca, r9 contains the saved CR,
- * SRR0 and SRR1 are saved in r11 and r12,
- * r9 - r13 are saved in paca->exgen.
- */
-EXC_COMMON_BEGIN(data_access_common)
-	mfspr	r10,SPRN_DAR
-	std	r10,PACA_EXGEN+EX_DAR(r13)
-	mfspr	r10,SPRN_DSISR
-	stw	r10,PACA_EXGEN+EX_DSISR(r13)
-	EXCEPTION_PROLOG_COMMON(0x300, PACA_EXGEN)
-	RECONCILE_IRQ_STATE(r10, r11)
-	ld	r12,_MSR(r1)
-	ld	r3,PACA_EXGEN+EX_DAR(r13)
-	lwz	r4,PACA_EXGEN+EX_DSISR(r13)
-	li	r5,0x300
-	std	r3,_DAR(r1)
-	std	r4,_DSISR(r1)
-BEGIN_MMU_FTR_SECTION
-	b	do_hash_page		/* Try to handle as hpte fault */
-MMU_FTR_SECTION_ELSE
-	b	handle_page_fault
-ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
-
 EXC_COMMON_BEGIN(h_data_storage_common)
 	mfspr   r10,SPRN_HDAR
 	std     r10,PACA_EXGEN+EX_DAR(r13)
-- 
2.7.4

Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spc2B5nXjzDrM1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:23:14 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v3 09/42] powerpc/64s: Consolidate Instruction Storage 0x400
 interrupt
Date: Wed,  5 Oct 2016 11:22:31 +1100
Message-Id: <1475626984-18770-10-git-send-email-mpe@ellerman.id.au>
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
 arch/powerpc/kernel/exceptions-64s.S | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index c3e1f610cf29..13eb8c7bc051 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -592,6 +592,24 @@ TRAMP_KVM_SKIP(PACA_EXSLB, 0x380)
 
 
 EXC_REAL(instruction_access, 0x400, 0x480)
+EXC_VIRT(instruction_access, 0x4400, 0x4480, 0x400)
+TRAMP_KVM(PACA_EXGEN, 0x400)
+
+EXC_COMMON_BEGIN(instruction_access_common)
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
+ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
+
 
 EXC_REAL_BEGIN(instruction_access_slb, 0x480, 0x500)
 	SET_SCRATCH0(r13)
@@ -772,7 +790,6 @@ EXC_REAL_NONE(0x1800, 0x1900)
 /*** Out of line interrupts support ***/
 
 	/* moved from 0x200 */
-TRAMP_KVM(PACA_EXGEN, 0x400)
 TRAMP_KVM(PACA_EXSLB, 0x480)
 TRAMP_KVM(PACA_EXGEN, 0x900)
 TRAMP_KVM_HV(PACA_EXGEN, 0x980)
@@ -1040,8 +1057,6 @@ EXC_COMMON(altivec_assist_common, 0x1700, unknown_exception)
 	 * come here.
 	 */
 
-EXC_VIRT(instruction_access, 0x4400, 0x4480, 0x400)
-
 EXC_VIRT_BEGIN(instruction_access_slb, 0x4480, 0x4500)
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXSLB)
@@ -1152,20 +1167,6 @@ EXC_COMMON_BEGIN(h_data_storage_common)
 	bl      unknown_exception
 	b       ret_from_except
 
-EXC_COMMON_BEGIN(instruction_access_common)
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
-ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
 
 EXC_COMMON(h_instr_storage_common, 0xe20, unknown_exception)
 
-- 
2.7.4

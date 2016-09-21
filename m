Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfBV84HGrzDsgm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 17:44:48 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id oz2so1948503pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 00:44:48 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 06/41] powerpc/64s: consolidate Data Storage 0x300 interrupt
Date: Wed, 21 Sep 2016 17:43:32 +1000
Message-Id: <20160921074407.4885-7-npiggin@gmail.com>
In-Reply-To: <20160921074407.4885-1-npiggin@gmail.com>
References: <20160921074407.4885-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 55 ++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 4c9a98f..19c9149 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -527,6 +527,34 @@ COMMON_HANDLER_END(unrecover_mce)
 
 
 VECTOR_HANDLER_REAL(data_access, 0x300, 0x380)
+VECTOR_HANDLER_VIRT(data_access, 0x4300, 0x4380, 0x300)
+TRAMP_KVM_SKIP(PACA_EXGEN, 0x300)
+
+COMMON_HANDLER_BEGIN(data_access_common)
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
+COMMON_HANDLER_END(data_access_common)
+
 
 VECTOR_HANDLER_REAL_BEGIN(data_access_slb, 0x380, 0x400)
 	SET_SCRATCH0(r13)
@@ -733,7 +761,6 @@ VECTOR_HANDLER_REAL_NONE(0x1800, 0x1900)
 /*** Out of line interrupts support ***/
 
 	/* moved from 0x200 */
-TRAMP_KVM_SKIP(PACA_EXGEN, 0x300)
 TRAMP_KVM_SKIP(PACA_EXSLB, 0x380)
 TRAMP_KVM(PACA_EXGEN, 0x400)
 TRAMP_KVM(PACA_EXSLB, 0x480)
@@ -1006,7 +1033,6 @@ COMMON_HANDLER(altivec_assist_common, 0x1700, unknown_exception)
 	 * come here.
 	 */
 
-VECTOR_HANDLER_VIRT(data_access, 0x4300, 0x4380, 0x300)
 
 VECTOR_HANDLER_VIRT_BEGIN(data_access_slb, 0x4380, 0x4400)
 	SET_SCRATCH0(r13)
@@ -1132,31 +1158,6 @@ TRAMP_HANDLER_BEGIN(ppc64_runlatch_on_trampoline)
 	b	__ppc64_runlatch_on
 TRAMP_HANDLER_END(ppc64_runlatch_on_trampoline)
 
-/*
- * Here r13 points to the paca, r9 contains the saved CR,
- * SRR0 and SRR1 are saved in r11 and r12,
- * r9 - r13 are saved in paca->exgen.
- */
-COMMON_HANDLER_BEGIN(data_access_common)
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
-COMMON_HANDLER_END(data_access_common)
-
 COMMON_HANDLER_BEGIN(h_data_storage_common)
 	mfspr   r10,SPRN_HDAR
 	std     r10,PACA_EXGEN+EX_DAR(r13)
-- 
2.9.3

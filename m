Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfBVD73rxzDsh3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 17:44:52 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id s3so575549pay.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 00:44:52 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 08/41] powerpc/64s: consolidate Instruction Storage 0x400
 interrupt
Date: Wed, 21 Sep 2016 17:43:34 +1000
Message-Id: <20160921074407.4885-9-npiggin@gmail.com>
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
 arch/powerpc/kernel/exceptions-64s.S | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 2cf3668..5f08388 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -605,6 +605,25 @@ TRAMP_KVM_SKIP(PACA_EXSLB, 0x380)
 
 
 VECTOR_HANDLER_REAL(instruction_access, 0x400, 0x480)
+VECTOR_HANDLER_VIRT(instruction_access, 0x4400, 0x4480, 0x400)
+TRAMP_KVM(PACA_EXGEN, 0x400)
+
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
+ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
+COMMON_HANDLER_END(instruction_access_common)
+
 
 VECTOR_HANDLER_REAL_BEGIN(instruction_access_slb, 0x480, 0x500)
 	SET_SCRATCH0(r13)
@@ -786,7 +805,6 @@ VECTOR_HANDLER_REAL_NONE(0x1800, 0x1900)
 /*** Out of line interrupts support ***/
 
 	/* moved from 0x200 */
-TRAMP_KVM(PACA_EXGEN, 0x400)
 TRAMP_KVM(PACA_EXSLB, 0x480)
 TRAMP_KVM(PACA_EXGEN, 0x900)
 TRAMP_KVM_HV(PACA_EXGEN, 0x980)
@@ -1059,7 +1077,6 @@ COMMON_HANDLER(altivec_assist_common, 0x1700, unknown_exception)
 
 
 
-VECTOR_HANDLER_VIRT(instruction_access, 0x4400, 0x4480, 0x400)
 
 VECTOR_HANDLER_VIRT_BEGIN(instruction_access_slb, 0x4480, 0x4500)
 	SET_SCRATCH0(r13)
@@ -1173,21 +1190,6 @@ COMMON_HANDLER_BEGIN(h_data_storage_common)
 	b       ret_from_except
 COMMON_HANDLER_END(h_data_storage_common)
 
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
-ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
-COMMON_HANDLER_END(instruction_access_common)
 
 COMMON_HANDLER(h_instr_storage_common, 0xe20, unknown_exception)
 
-- 
2.9.3

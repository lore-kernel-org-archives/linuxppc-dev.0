Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfBVB5dhPzDsgq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 17:44:50 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id n24so2027879pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 00:44:50 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 07/41] powerpc/64s: consolidate Data Segment 0x380 interrupt
Date: Wed, 21 Sep 2016 17:43:33 +1000
Message-Id: <20160921074407.4885-8-npiggin@gmail.com>
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
 arch/powerpc/kernel/exceptions-64s.S | 48 +++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 19c9149..2cf3668 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -579,6 +579,31 @@ VECTOR_HANDLER_REAL_BEGIN(data_access_slb, 0x380, 0x400)
 #endif
 VECTOR_HANDLER_REAL_END(data_access_slb, 0x380, 0x400)
 
+VECTOR_HANDLER_VIRT_BEGIN(data_access_slb, 0x4380, 0x4400)
+	SET_SCRATCH0(r13)
+	EXCEPTION_PROLOG_0(PACA_EXSLB)
+	EXCEPTION_PROLOG_1(PACA_EXSLB, NOTEST, 0x380)
+	std	r3,PACA_EXSLB+EX_R3(r13)
+	mfspr	r3,SPRN_DAR
+	mfspr	r12,SPRN_SRR1
+#ifndef CONFIG_RELOCATABLE
+	b	slb_miss_realmode
+#else
+	/*
+	 * We can't just use a direct branch to slb_miss_realmode
+	 * because the distance from here to there depends on where
+	 * the kernel ends up being put.
+	 */
+	mfctr	r11
+	ld	r10,PACAKBASE(r13)
+	LOAD_HANDLER(r10, slb_miss_realmode)
+	mtctr	r10
+	bctr
+#endif
+VECTOR_HANDLER_VIRT_END(data_access_slb, 0x4380, 0x4400)
+TRAMP_KVM_SKIP(PACA_EXSLB, 0x380)
+
+
 VECTOR_HANDLER_REAL(instruction_access, 0x400, 0x480)
 
 VECTOR_HANDLER_REAL_BEGIN(instruction_access_slb, 0x480, 0x500)
@@ -761,7 +786,6 @@ VECTOR_HANDLER_REAL_NONE(0x1800, 0x1900)
 /*** Out of line interrupts support ***/
 
 	/* moved from 0x200 */
-TRAMP_KVM_SKIP(PACA_EXSLB, 0x380)
 TRAMP_KVM(PACA_EXGEN, 0x400)
 TRAMP_KVM(PACA_EXSLB, 0x480)
 TRAMP_KVM(PACA_EXGEN, 0x900)
@@ -1034,28 +1058,6 @@ COMMON_HANDLER(altivec_assist_common, 0x1700, unknown_exception)
 	 */
 
 
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
-	LOAD_HANDLER(r10, slb_miss_realmode)
-	mtctr	r10
-	bctr
-#endif
-VECTOR_HANDLER_VIRT_END(data_access_slb, 0x4380, 0x4400)
 
 VECTOR_HANDLER_VIRT(instruction_access, 0x4400, 0x4480, 0x400)
 
-- 
2.9.3

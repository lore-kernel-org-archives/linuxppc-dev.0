Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spc2B4P4szDrLx
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:23:14 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v3 08/42] powerpc/64s: Consolidate Data Segment 0x380 interrupt
Date: Wed,  5 Oct 2016 11:22:30 +1100
Message-Id: <1475626984-18770-9-git-send-email-mpe@ellerman.id.au>
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
 arch/powerpc/kernel/exceptions-64s.S | 50 ++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index edab8cc4fdc1..c3e1f610cf29 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -566,6 +566,31 @@ EXC_REAL_BEGIN(data_access_slb, 0x380, 0x400)
 #endif
 EXC_REAL_END(data_access_slb, 0x380, 0x400)
 
+EXC_VIRT_BEGIN(data_access_slb, 0x4380, 0x4400)
+	SET_SCRATCH0(r13)
+	EXCEPTION_PROLOG_0(PACA_EXSLB)
+	EXCEPTION_PROLOG_1(PACA_EXSLB, NOTEST, 0x380)
+	std	r3,PACA_EXSLB+EX_R3(r13)
+	mfspr	r3,SPRN_DAR
+	mfspr	r12,SPRN_SRR1
+	crset	4*cr6+eq
+#ifndef CONFIG_RELOCATABLE
+	b	slb_miss_realmode
+#else
+	/*
+	 * We can't just use a direct branch to slb_miss_realmode
+	 * because the distance from here to there depends on where
+	 * the kernel ends up being put.
+	 */
+	mfctr	r11
+	LOAD_HANDLER(r10, slb_miss_realmode)
+	mtctr	r10
+	bctr
+#endif
+EXC_VIRT_END(data_access_slb, 0x4380, 0x4400)
+TRAMP_KVM_SKIP(PACA_EXSLB, 0x380)
+
+
 EXC_REAL(instruction_access, 0x400, 0x480)
 
 EXC_REAL_BEGIN(instruction_access_slb, 0x480, 0x500)
@@ -747,7 +772,6 @@ EXC_REAL_NONE(0x1800, 0x1900)
 /*** Out of line interrupts support ***/
 
 	/* moved from 0x200 */
-TRAMP_KVM_SKIP(PACA_EXSLB, 0x380)
 TRAMP_KVM(PACA_EXGEN, 0x400)
 TRAMP_KVM(PACA_EXSLB, 0x480)
 TRAMP_KVM(PACA_EXGEN, 0x900)
@@ -1016,30 +1040,6 @@ EXC_COMMON(altivec_assist_common, 0x1700, unknown_exception)
 	 * come here.
 	 */
 
-
-EXC_VIRT_BEGIN(data_access_slb, 0x4380, 0x4400)
-	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_0(PACA_EXSLB)
-	EXCEPTION_PROLOG_1(PACA_EXSLB, NOTEST, 0x380)
-	std	r3,PACA_EXSLB+EX_R3(r13)
-	mfspr	r3,SPRN_DAR
-	mfspr	r12,SPRN_SRR1
-	crset	4*cr6+eq
-#ifndef CONFIG_RELOCATABLE
-	b	slb_miss_realmode
-#else
-	/*
-	 * We can't just use a direct branch to slb_miss_realmode
-	 * because the distance from here to there depends on where
-	 * the kernel ends up being put.
-	 */
-	mfctr	r11
-	LOAD_HANDLER(r10, slb_miss_realmode)
-	mtctr	r10
-	bctr
-#endif
-EXC_VIRT_END(data_access_slb, 0x4380, 0x4400)
-
 EXC_VIRT(instruction_access, 0x4400, 0x4480, 0x400)
 
 EXC_VIRT_BEGIN(instruction_access_slb, 0x4480, 0x4500)
-- 
2.7.4

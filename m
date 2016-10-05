Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spc2P5bdzzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:23:25 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v3 38/42] powerpc/64s: Consolidate Altivec 0x1700 interrupt
Date: Wed,  5 Oct 2016 11:23:00 +1100
Message-Id: <1475626984-18770-39-git-send-email-mpe@ellerman.id.au>
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
 arch/powerpc/kernel/exceptions-64s.S | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 40da203d4a07..389032a8e744 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1251,8 +1251,14 @@ EXC_REAL_NONE(0x1600, 0x1700)
 
 
 EXC_REAL(altivec_assist, 0x1700, 0x1800)
-
+EXC_VIRT(altivec_assist, 0x5700, 0x5800, 0x1700)
 TRAMP_KVM(PACA_EXGEN, 0x1700)
+#ifdef CONFIG_ALTIVEC
+EXC_COMMON(altivec_assist_common, 0x1700, altivec_assist_exception)
+#else
+EXC_COMMON(altivec_assist_common, 0x1700, unknown_exception)
+#endif
+
 
 #ifdef CONFIG_CBE_RAS
 EXC_REAL_HV(cbe_thermal, 0x1800, 0x1900)
@@ -1388,12 +1394,6 @@ TRAMP_REAL_BEGIN(kvmppc_skip_Hinterrupt)
 /*** Common interrupt handlers ***/
 
 
-#ifdef CONFIG_ALTIVEC
-EXC_COMMON(altivec_assist_common, 0x1700, altivec_assist_exception)
-#else
-EXC_COMMON(altivec_assist_common, 0x1700, unknown_exception)
-#endif
-
 	/*
 	 * Relocation-on interrupts: A subset of the interrupts can be delivered
 	 * with IR=1/DR=1, if AIL==2 and MSR.HV won't be changed by delivering
@@ -1410,8 +1410,6 @@ EXC_COMMON(altivec_assist_common, 0x1700, unknown_exception)
 	 * come here.
 	 */
 
-EXC_VIRT(altivec_assist, 0x5700, 0x5800, 0x1700)
-
 EXC_VIRT_NONE(0x5800, 0x5900)
 
 EXC_COMMON_BEGIN(ppc64_runlatch_on_trampoline)
-- 
2.7.4

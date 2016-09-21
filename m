Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfBWV4qtyzDshC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 17:45:58 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id my20so1946222pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 00:45:58 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 37/41] powerpc/64s: consolidate Altivec 0x1700 interrupt
Date: Wed, 21 Sep 2016 17:44:03 +1000
Message-Id: <20160921074407.4885-38-npiggin@gmail.com>
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
 arch/powerpc/kernel/exceptions-64s.S | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 3328425..60e7e7e 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1252,8 +1252,14 @@ VECTOR_HANDLER_REAL_NONE(0x1600, 0x1700)
 
 
 VECTOR_HANDLER_REAL(altivec_assist, 0x1700, 0x1800)
-
+VECTOR_HANDLER_VIRT(altivec_assist, 0x5700, 0x5800, 0x1700)
 TRAMP_KVM(PACA_EXGEN, 0x1700)
+#ifdef CONFIG_ALTIVEC
+COMMON_HANDLER(altivec_assist_common, 0x1700, altivec_assist_exception)
+#else
+COMMON_HANDLER(altivec_assist_common, 0x1700, unknown_exception)
+#endif
+
 
 #ifdef CONFIG_CBE_RAS
 VECTOR_HANDLER_REAL_HV(cbe_thermal, 0x1800, 0x1900)
@@ -1391,12 +1397,6 @@ TRAMP_HANDLER_END(kvmppc_skip_Hinterrupt)
 /*** Common interrupt handlers ***/
 
 
-#ifdef CONFIG_ALTIVEC
-COMMON_HANDLER(altivec_assist_common, 0x1700, altivec_assist_exception)
-#else
-COMMON_HANDLER(altivec_assist_common, 0x1700, unknown_exception)
-#endif
-
 	/*
 	 * Relocation-on interrupts: A subset of the interrupts can be delivered
 	 * with IR=1/DR=1, if AIL==2 and MSR.HV won't be changed by delivering
@@ -1413,9 +1413,6 @@ COMMON_HANDLER(altivec_assist_common, 0x1700, unknown_exception)
 	 * come here.
 	 */
 
-
-VECTOR_HANDLER_VIRT(altivec_assist, 0x5700, 0x5800, 0x1700)
-
 VECTOR_HANDLER_VIRT_NONE(0x5800, 0x5900)
 
 TRAMP_HANDLER_BEGIN(ppc64_runlatch_on_trampoline)
-- 
2.9.3

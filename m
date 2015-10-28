Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 77AE31A028B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 11:51:10 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mikey@neuling.org, cyrilbur@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 01/19] powerpc: Don't disable kernel FP/VMX/VSX MSR bits on
 context switch
Date: Wed, 28 Oct 2015 11:50:49 +1100
Message-Id: <1445993467-667-1-git-send-email-anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Writing the MSR is slow, so we want to avoid it whenever possible.

A subsequent patch will add a debug option that strictly manages the
FP/VMX/VSX unavailable bits. For now just remove it, matching what
we do in other areas of the kernel (eg enable_kernel_altivec()).

A context switch microbenchmark using yield():

http://ozlabs.org/~anton/junkcode/context_switch2.c

./context_switch2 --test=yield --fp 0 0

shows an improvement of almost 3% on POWER8.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/entry_64.S | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index a94f155..93bb284 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -453,26 +453,13 @@ _GLOBAL(_switch)
 	SAVE_8GPRS(14, r1)
 	SAVE_10GPRS(22, r1)
 	mflr	r20		/* Return to switch caller */
-	mfmsr	r22
-	li	r0, MSR_FP
-#ifdef CONFIG_VSX
-BEGIN_FTR_SECTION
-	oris	r0,r0,MSR_VSX@h	/* Disable VSX */
-END_FTR_SECTION_IFSET(CPU_FTR_VSX)
-#endif /* CONFIG_VSX */
 #ifdef CONFIG_ALTIVEC
 BEGIN_FTR_SECTION
-	oris	r0,r0,MSR_VEC@h	/* Disable altivec */
 	mfspr	r24,SPRN_VRSAVE	/* save vrsave register value */
 	std	r24,THREAD_VRSAVE(r3)
 END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 #endif /* CONFIG_ALTIVEC */
-	and.	r0,r0,r22
-	beq+	1f
-	andc	r22,r22,r0
-	MTMSRD(r22)
-	isync
-1:	std	r20,_NIP(r1)
+	std	r20,_NIP(r1)
 	mfcr	r23
 	std	r23,_CCR(r1)
 	std	r1,KSP(r3)	/* Set old stack pointer */
-- 
2.5.0

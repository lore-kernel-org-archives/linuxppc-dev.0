Return-Path: <r63875@freescale.com>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe006.messaging.microsoft.com
 [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AE4FCB6F62
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Mar 2012 12:27:12 +1100 (EST)
From: Olivia Yin <hong-hua.yin@freescale.com>
To: <kvm-ppc@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2 1/2] powerpc/e500: make load_up_spe a normal fuction
Date: Thu, 1 Mar 2012 09:20:19 +0800
Message-ID: <1330564819-11139-1-git-send-email-hong-hua.yin@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Liu Yu <yu.liu@freescale.com>, Olivia Yin <hong-hua.yin@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Liu Yu <yu.liu@freescale.com>

So that we can call it when improving SPE switch like book3e did for fp switch.

Signed-off-by: Liu Yu <yu.liu@freescale.com>
Signed-off-by: Olivia Yin <hong-hua.yin@freescale.com>
---
v2: 	add Signed-off-by

 arch/powerpc/kernel/head_fsl_booke.S |   23 ++++++-----------------
 1 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index d5d78c4..c96e025 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -539,8 +539,10 @@ interrupt_base:
 	/* SPE Unavailable */
 	START_EXCEPTION(SPEUnavailable)
 	NORMAL_EXCEPTION_PROLOG
-	bne	load_up_spe
-	addi	r3,r1,STACK_FRAME_OVERHEAD
+	beq	1f
+	bl	load_up_spe
+	b	fast_exception_return
+1:	addi	r3,r1,STACK_FRAME_OVERHEAD
 	EXC_XFER_EE_LITE(0x2010, KernelSPE)
 #else
 	EXCEPTION(0x2020, SPEUnavailable, unknown_exception, EXC_XFER_EE)
@@ -743,7 +745,7 @@ tlb_write_entry:
 /* Note that the SPE support is closely modeled after the AltiVec
  * support.  Changes to one are likely to be applicable to the
  * other!  */
-load_up_spe:
+_GLOBAL(load_up_spe)
 /*
  * Disable SPE for the task which had SPE previously,
  * and save its SPE registers in its thread_struct.
@@ -791,20 +793,7 @@ load_up_spe:
 	subi	r4,r5,THREAD
 	stw	r4,last_task_used_spe@l(r3)
 #endif /* !CONFIG_SMP */
-	/* restore registers and return */
-2:	REST_4GPRS(3, r11)
-	lwz	r10,_CCR(r11)
-	REST_GPR(1, r11)
-	mtcr	r10
-	lwz	r10,_LINK(r11)
-	mtlr	r10
-	REST_GPR(10, r11)
-	mtspr	SPRN_SRR1,r9
-	mtspr	SPRN_SRR0,r12
-	REST_GPR(9, r11)
-	REST_GPR(12, r11)
-	lwz	r11,GPR11(r11)
-	rfi
+	blr
 
 /*
  * SPE unavailable trap from kernel - print a message, but let
-- 
1.6.4

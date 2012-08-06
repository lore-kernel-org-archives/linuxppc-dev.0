Return-Path: <mcaraman@mcaraman-VirtualBox.ea.freescale.net>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BD3C32C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Aug 2012 23:27:29 +1000 (EST)
Received: from mail13-ch1 (localhost [127.0.0.1])	by mail13-ch1-R.bigfish.com
 (Postfix) with ESMTP id C198880394	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Aug 2012 13:27:24 +0000 (UTC)
Received: from CH1EHSMHS015.bigfish.com (snatpool2.int.messaging.microsoft.com
 [10.43.68.233])	by mail13-ch1.bigfish.com (Postfix) with ESMTP id
 E54D62005D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Aug 2012 13:27:21 +0000 (UTC)
Received: from mcaraman-VirtualBox.ea.freescale.net ([10.213.130.145])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id q76DRIIc012085	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Aug 2012 06:27:19 -0700
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/6] powerpc/booke64: use GSRR registers in Guest Doorbell
 interrupts
Date: Mon, 6 Aug 2012 16:27:04 +0300
Message-ID: <1344259628-31161-3-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1344259628-31161-1-git-send-email-mihai.caraman@freescale.com>
References: <1344259628-31161-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Guest Doorbell interrupts use guest save and restore registers. Add a new
Guest Doorbell exception type to accommodate GSRR0/1 SPRs usage in exception
prolog and fix the exception handler.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/include/asm/exception-64e.h |    1 +
 arch/powerpc/include/asm/reg.h           |    1 +
 arch/powerpc/kernel/exceptions-64e.S     |   21 +++++++++++++++++++--
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64e.h b/arch/powerpc/include/asm/exception-64e.h
index ac13add..e73452f 100644
--- a/arch/powerpc/include/asm/exception-64e.h
+++ b/arch/powerpc/include/asm/exception-64e.h
@@ -37,6 +37,7 @@
  * critical data
  */
 
+#define PACA_EXGDBELL PACA_EXGEN
 
 /* We are out of SPRGs so we save some things in the PACA. The normal
  * exception frame is smaller than the CRIT or MC one though
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 6386086..349d9c3 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -863,6 +863,7 @@
 #define SPRN_SPRG_TLB_EXFRAME	SPRN_SPRG2
 #define SPRN_SPRG_TLB_SCRATCH	SPRN_SPRG6
 #define SPRN_SPRG_GEN_SCRATCH	SPRN_SPRG0
+#define SPRN_SPRG_GDBELL_SCRATCH SPRN_SPRG_GEN_SCRATCH
 
 #define SET_PACA(rX)	mtspr	SPRN_SPRG_PACA,rX
 #define GET_PACA(rX)	mfspr	rX,SPRN_SPRG_PACA
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 0243b1b..0f58a95 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -59,6 +59,10 @@
 #define SPRN_GEN_SRR0	SPRN_SRR0
 #define SPRN_GEN_SRR1	SPRN_SRR1
 
+#define	GDBELL_SET_KSTACK	GEN_SET_KSTACK
+#define SPRN_GDBELL_SRR0	SPRN_GSRR0
+#define SPRN_GDBELL_SRR1	SPRN_GSRR1
+
 #define CRIT_SET_KSTACK						            \
 	ld	r1,PACA_CRIT_STACK(r13);				    \
 	subi	r1,r1,SPECIAL_EXC_FRAME_SIZE;
@@ -89,10 +93,13 @@
 #define MC_EXCEPTION_PROLOG(n, addition)				    \
 	EXCEPTION_PROLOG(n, MC, addition##_MC(n))
 
+#define GDBELL_EXCEPTION_PROLOG(n, addition)				    \
+	EXCEPTION_PROLOG(n, GDBELL, addition##_GDBELL(n))
 
 /* Variants of the "addition" argument for the prolog
  */
 #define PROLOG_ADDITION_NONE_GEN(n)
+#define PROLOG_ADDITION_NONE_GDBELL(n)
 #define PROLOG_ADDITION_NONE_CRIT(n)
 #define PROLOG_ADDITION_NONE_DBG(n)
 #define PROLOG_ADDITION_NONE_MC(n)
@@ -543,8 +550,18 @@ kernel_dbg_exc:
 //	b	ret_from_crit_except
 	b	.
 
-/* Guest Doorbell */
-	MASKABLE_EXCEPTION(0x2c0, guest_doorbell, .unknown_exception, ACK_NONE)
+/*
+ *	Guest doorbell interrupt
+ *	This general exception use GSRRx save/restore registers
+ */
+	START_EXCEPTION(guest_doorbell);
+	GDBELL_EXCEPTION_PROLOG(0x2c0, PROLOG_ADDITION_NONE)
+	EXCEPTION_COMMON(0x2c0, PACA_EXGEN, INTS_KEEP)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	.save_nvgprs
+	INTS_RESTORE_HARD
+	bl	.unknown_exception
+	b	.ret_from_except
 
 /* Guest Doorbell critical Interrupt */
 	START_EXCEPTION(guest_doorbell_crit);
-- 
1.7.4.1

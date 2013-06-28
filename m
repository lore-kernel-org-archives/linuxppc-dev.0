Return-Path: <B02008@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0184.outbound.messaging.microsoft.com [213.199.154.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1C6952C02F5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 19:20:21 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 1/2] KVM: PPC: e500mc: Revert "add load inst fixup"
Date: Fri, 28 Jun 2013 12:20:02 +0300
Message-ID: <1372411203-14795-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

lwepx faults needs to be handled by KVM. With the current solution
the host kernel searches for the faulting address using its LPID context.
If a host translation is found we return to the lwepx instr instead of the
fixup ending up in an infinite loop.

Revert the commit 1d628af7 "add load inst fixup". We will address lwepx
issue in a subsequent patch without the need of fixups.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
Resend this patch for Alex G. he was unsubscribed from kvm-ppc mailist
for a while.

 arch/powerpc/kvm/bookehv_interrupts.S |   26 +-------------------------
 1 files changed, 1 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/kvm/bookehv_interrupts.S b/arch/powerpc/kvm/bookehv_interrupts.S
index e8ed7d6..20c7a54 100644
--- a/arch/powerpc/kvm/bookehv_interrupts.S
+++ b/arch/powerpc/kvm/bookehv_interrupts.S
@@ -29,7 +29,6 @@
 #include <asm/asm-compat.h>
 #include <asm/asm-offsets.h>
 #include <asm/bitsperlong.h>
-#include <asm/thread_info.h>
 
 #ifdef CONFIG_64BIT
 #include <asm/exception-64e.h>
@@ -162,32 +161,9 @@
 	PPC_STL	r30, VCPU_GPR(R30)(r4)
 	PPC_STL	r31, VCPU_GPR(R31)(r4)
 	mtspr	SPRN_EPLC, r8
-
-	/* disable preemption, so we are sure we hit the fixup handler */
-	CURRENT_THREAD_INFO(r8, r1)
-	li	r7, 1
-	stw	r7, TI_PREEMPT(r8)
-
 	isync
-
-	/*
-	 * In case the read goes wrong, we catch it and write an invalid value
-	 * in LAST_INST instead.
-	 */
-1:	lwepx	r9, 0, r5
-2:
-.section .fixup, "ax"
-3:	li	r9, KVM_INST_FETCH_FAILED
-	b	2b
-.previous
-.section __ex_table,"a"
-	PPC_LONG_ALIGN
-	PPC_LONG 1b,3b
-.previous
-
+	lwepx   r9, 0, r5
 	mtspr	SPRN_EPLC, r3
-	li	r7, 0
-	stw	r7, TI_PREEMPT(r8)
 	stw	r9, VCPU_LAST_INST(r4)
 	.endif
 
-- 
1.7.4.1

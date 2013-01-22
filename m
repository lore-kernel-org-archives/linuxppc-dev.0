Return-Path: <B08248@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5D1B52C007B
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2013 10:54:53 +1100 (EST)
From: Stuart Yoder <stuart.yoder@freescale.com>
To: <agraf@suse.de>, <benh@kernel.crashing.org>
Subject: [PATCH][v2] KVM: PPC: add paravirt idle loop for 64-bit book E
Date: Tue, 22 Jan 2013 17:54:43 -0600
Message-ID: <1358898883-16218-1-git-send-email-stuart.yoder@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
 Stuart Yoder <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Stuart Yoder <stuart.yoder@freescale.com>

Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
---

-v2
   -macro'ized loop in idle_book3e.S to avoid code 
    duplication, paravirt loop is now in idle_book3e.S

 arch/powerpc/kernel/epapr_hcalls.S |    2 ++
 arch/powerpc/kernel/idle_book3e.S  |   30 ++++++++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/epapr_hcalls.S b/arch/powerpc/kernel/epapr_hcalls.S
index 62c0dc2..9f1ebf7 100644
--- a/arch/powerpc/kernel/epapr_hcalls.S
+++ b/arch/powerpc/kernel/epapr_hcalls.S
@@ -17,6 +17,7 @@
 #include <asm/asm-compat.h>
 #include <asm/asm-offsets.h>
 
+#ifndef CONFIG_PPC64
 /* epapr_ev_idle() was derived from e500_idle() */
 _GLOBAL(epapr_ev_idle)
 	CURRENT_THREAD_INFO(r3, r1)
@@ -42,6 +43,7 @@ epapr_ev_idle_start:
 	 * _TLF_NAPPING.
 	 */
 	b	idle_loop
+#endif
 
 /* Hypercall entry point. Will be patched with device tree instructions. */
 .global epapr_hypercall_start
diff --git a/arch/powerpc/kernel/idle_book3e.S b/arch/powerpc/kernel/idle_book3e.S
index 4c7cb400..e1c9acd 100644
--- a/arch/powerpc/kernel/idle_book3e.S
+++ b/arch/powerpc/kernel/idle_book3e.S
@@ -16,11 +16,13 @@
 #include <asm/ppc-opcode.h>
 #include <asm/processor.h>
 #include <asm/thread_info.h>
+#include <asm/epapr_hcalls.h>
 
 /* 64-bit version only for now */
 #ifdef CONFIG_PPC64
 
-_GLOBAL(book3e_idle)
+.macro BOOK3E_IDLE name loop
+_GLOBAL(\name)
 	/* Save LR for later */
 	mflr	r0
 	std	r0,16(r1)
@@ -67,7 +69,31 @@ _GLOBAL(book3e_idle)
 
 	/* We can now re-enable hard interrupts and go to sleep */
 	wrteei	1
-1:	PPC_WAIT(0)
+	\loop
+
+.endm
+
+.macro BOOK3E_IDLE_LOOP
+1:
+	PPC_WAIT(0)
 	b	1b
+.endm
+
+.macro EPAPR_EV_IDLE_LOOP
+idle_loop:
+       LOAD_REG_IMMEDIATE(r11, EV_HCALL_TOKEN(EV_IDLE))
+
+.global epapr_ev_idle_start
+epapr_ev_idle_start:
+       li      r3, -1
+       nop
+       nop
+       nop
+       b       idle_loop
+.endm
+
+BOOK3E_IDLE epapr_ev_idle, EPAPR_EV_IDLE_LOOP
+
+BOOK3E_IDLE book3e_idle BOOK3E_IDLE_LOOP
 
 #endif /* CONFIG_PPC64 */
-- 
1.7.9.7

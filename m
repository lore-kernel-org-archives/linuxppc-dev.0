Return-Path: <B02008@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0186.outbound.messaging.microsoft.com [213.199.154.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 11BF62C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 02:56:21 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/2] powerpc/booke64: Add LRAT error exception handler
Date: Wed, 3 Jul 2013 19:56:05 +0300
Message-ID: <1372870566-11299-1-git-send-email-mihai.caraman@freescale.com>
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

Add LRAT (Logical to Real Address Translation) error exception handler to
Booke3E 64-bit kernel. LRAT support in KVM will follow afterwards.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/include/asm/kvm_asm.h   |    1 +
 arch/powerpc/include/asm/reg_booke.h |    1 +
 arch/powerpc/kernel/exceptions-64e.S |   14 ++++++++++++++
 3 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_asm.h b/arch/powerpc/include/asm/kvm_asm.h
index 851bac7..83b91e5 100644
--- a/arch/powerpc/include/asm/kvm_asm.h
+++ b/arch/powerpc/include/asm/kvm_asm.h
@@ -74,6 +74,7 @@
 #define BOOKE_INTERRUPT_GUEST_DBELL_CRIT 39
 #define BOOKE_INTERRUPT_HV_SYSCALL 40
 #define BOOKE_INTERRUPT_HV_PRIV 41
+#define BOOKE_INTERRUPT_LRAT_ERROR 42
 
 /* book3s */
 
diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index b417de3..6b113e1 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -101,6 +101,7 @@
 #define SPRN_IVOR39	0x1B1	/* Interrupt Vector Offset Register 39 */
 #define SPRN_IVOR40	0x1B2	/* Interrupt Vector Offset Register 40 */
 #define SPRN_IVOR41	0x1B3	/* Interrupt Vector Offset Register 41 */
+#define SPRN_IVOR42	0x1B4	/* Interrupt Vector Offset Register 42 */
 #define SPRN_GIVOR2	0x1B8	/* Guest IVOR2 */
 #define SPRN_GIVOR3	0x1B9	/* Guest IVOR3 */
 #define SPRN_GIVOR4	0x1BA	/* Guest IVOR4 */
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 0c379e9..e08b469 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -308,6 +308,7 @@ interrupt_base_book3e:					/* fake trap */
 	EXCEPTION_STUB(0x2e0, guest_doorbell_crit)
 	EXCEPTION_STUB(0x300, hypercall)
 	EXCEPTION_STUB(0x320, ehpriv)
+	EXCEPTION_STUB(0x340, lrat_error)
 
 	.globl interrupt_end_book3e
 interrupt_end_book3e:
@@ -676,6 +677,17 @@ kernel_dbg_exc:
 	bl	.unknown_exception
 	b	.ret_from_except
 
+/* LRAT Error interrupt */
+	START_EXCEPTION(lrat_error);
+	NORMAL_EXCEPTION_PROLOG(0x340, BOOKE_INTERRUPT_LRAT_ERROR,
+			        PROLOG_ADDITION_NONE)
+	EXCEPTION_COMMON(0x340, PACA_EXGEN, INTS_KEEP)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	.save_nvgprs
+	INTS_RESTORE_HARD
+	bl	.unknown_exception
+	b	.ret_from_except
+
 /*
  * An interrupt came in while soft-disabled; We mark paca->irq_happened
  * accordingly and if the interrupt is level sensitive, we hard disable
@@ -858,6 +870,7 @@ BAD_STACK_TRAMPOLINE(0x2e0)
 BAD_STACK_TRAMPOLINE(0x300)
 BAD_STACK_TRAMPOLINE(0x310)
 BAD_STACK_TRAMPOLINE(0x320)
+BAD_STACK_TRAMPOLINE(0x340)
 BAD_STACK_TRAMPOLINE(0x400)
 BAD_STACK_TRAMPOLINE(0x500)
 BAD_STACK_TRAMPOLINE(0x600)
@@ -1410,6 +1423,7 @@ _GLOBAL(setup_doorbell_ivors)
 _GLOBAL(setup_ehv_ivors)
 	SET_IVOR(40, 0x300) /* Embedded Hypervisor System Call */
 	SET_IVOR(41, 0x320) /* Embedded Hypervisor Privilege */
+	SET_IVOR(42, 0x340) /* LRAT Error */
 	SET_IVOR(38, 0x2c0) /* Guest Processor Doorbell */
 	SET_IVOR(39, 0x2e0) /* Guest Processor Doorbell Crit/MC */
 	blr
-- 
1.7.3.4

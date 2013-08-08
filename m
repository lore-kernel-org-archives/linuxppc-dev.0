Return-Path: <B02008@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0251.outbound.messaging.microsoft.com [213.199.154.251])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 297902C00CC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Aug 2013 22:56:32 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2] powerpc/booke64: Add LRAT error exception handler
Date: Thu, 8 Aug 2013 15:56:09 +0300
Message-ID: <1375966569-3037-1-git-send-email-mihai.caraman@freescale.com>
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

LRAT (Logical to Real Address Translation) present in MMU v2 provides hardware
translation from a logical page number (LPN) to a real page number (RPN) when
tlbwe is executed by a guest or when a page table translation occurs from a
guest virtual address.

Add LRAT error exception handler to Booke3E 64-bit kernel and the basic KVM
handler to avoid build breakage. This is a prerequisite for KVM LRAT support
that will follow.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
v2
  - squash patches for bisectability
  - set IVOR42 from setup_cpu

 arch/powerpc/include/asm/kvm_asm.h        |    1 +
 arch/powerpc/include/asm/reg_booke.h      |    1 +
 arch/powerpc/kernel/cpu_setup_fsl_booke.S |   12 ++++++++++++
 arch/powerpc/kernel/exceptions-64e.S      |   17 +++++++++++++++++
 arch/powerpc/kvm/bookehv_interrupts.S     |    2 ++
 5 files changed, 33 insertions(+), 0 deletions(-)

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
diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
index 0b9af01..754a11d 100644
--- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
+++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
@@ -57,6 +57,12 @@ _GLOBAL(__setup_cpu_e6500)
 	mflr	r6
 #ifdef CONFIG_PPC64
 	bl	.setup_altivec_ivors
+	/* Touch IVOR42 only if the CPU supports E.HV category */
+	mfspr	r10,SPRN_MMUCFG
+	rlwinm.	r10,r10,0,MMUCFG_LPIDSIZE
+	beq	1f
+	bl	.setup_lrat_ivor
+1:
 #endif
 	bl	__setup_cpu_e5500
 	mtlr	r6
@@ -119,6 +125,12 @@ _GLOBAL(__setup_cpu_e5500)
 _GLOBAL(__restore_cpu_e6500)
 	mflr	r5
 	bl	.setup_altivec_ivors
+	/* Touch IVOR42 only if the CPU supports E.HV category */
+	mfspr	r10,SPRN_MMUCFG
+	rlwinm.	r10,r10,0,MMUCFG_LPIDSIZE
+	beq	1f
+	bl	.setup_lrat_ivor
+1:
 	bl	__restore_cpu_e5500
 	mtlr	r5
 	blr
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 645170a..9e4a506 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -308,6 +308,7 @@ interrupt_base_book3e:					/* fake trap */
 	EXCEPTION_STUB(0x2e0, guest_doorbell_crit)
 	EXCEPTION_STUB(0x300, hypercall)
 	EXCEPTION_STUB(0x320, ehpriv)
+	EXCEPTION_STUB(0x340, lrat_error)
 
 	.globl interrupt_end_book3e
 interrupt_end_book3e:
@@ -675,6 +676,17 @@ kernel_dbg_exc:
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
@@ -857,6 +869,7 @@ BAD_STACK_TRAMPOLINE(0x2e0)
 BAD_STACK_TRAMPOLINE(0x300)
 BAD_STACK_TRAMPOLINE(0x310)
 BAD_STACK_TRAMPOLINE(0x320)
+BAD_STACK_TRAMPOLINE(0x340)
 BAD_STACK_TRAMPOLINE(0x400)
 BAD_STACK_TRAMPOLINE(0x500)
 BAD_STACK_TRAMPOLINE(0x600)
@@ -1412,3 +1425,7 @@ _GLOBAL(setup_ehv_ivors)
 	SET_IVOR(38, 0x2c0) /* Guest Processor Doorbell */
 	SET_IVOR(39, 0x2e0) /* Guest Processor Doorbell Crit/MC */
 	blr
+
+_GLOBAL(setup_lrat_ivor)
+	SET_IVOR(42, 0x340) /* LRAT Error */
+	blr
diff --git a/arch/powerpc/kvm/bookehv_interrupts.S b/arch/powerpc/kvm/bookehv_interrupts.S
index e8ed7d6..a0d6929 100644
--- a/arch/powerpc/kvm/bookehv_interrupts.S
+++ b/arch/powerpc/kvm/bookehv_interrupts.S
@@ -319,6 +319,8 @@ kvm_handler BOOKE_INTERRUPT_DEBUG, EX_PARAMS(DBG), \
 	SPRN_DSRR0, SPRN_DSRR1, 0
 kvm_handler BOOKE_INTERRUPT_DEBUG, EX_PARAMS(CRIT), \
 	SPRN_CSRR0, SPRN_CSRR1, 0
+kvm_handler BOOKE_INTERRUPT_LRAT_ERROR, EX_PARAMS(GEN), \
+	SPRN_SRR0, SPRN_SRR1, (NEED_EMU | NEED_DEAR | NEED_ESR)
 #else
 /*
  * For input register values, see arch/powerpc/include/asm/kvm_booke_hv_asm.h
-- 
1.7.3.4

Return-Path: <mcaraman@mcaraman-VirtualBox.ea.freescale.net>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AA5DD2C0323
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2012 03:14:25 +1100 (EST)
Received: from mail109-ch1 (localhost [127.0.0.1])	by
 mail109-ch1-R.bigfish.com (Postfix) with ESMTP id 303E5360214	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 16:14:21 +0000 (UTC)
Received: from CH1EHSMHS035.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.248])	by mail109-ch1.bigfish.com (Postfix) with ESMTP id
 77FB92004C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 16:14:18 +0000 (UTC)
Received: from mcaraman-VirtualBox.ea.freescale.net ([10.213.130.145])	by
 az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id q9BGEFvW003817	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 09:14:16 -0700
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 04/12] KVM: PPC64: bookehv: Add support for interrupt handling
Date: Thu, 11 Oct 2012 19:13:21 +0300
Message-ID: <1349972009-23027-5-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1349972009-23027-1-git-send-email-mihai.caraman@freescale.com>
References: <1349972009-23027-1-git-send-email-mihai.caraman@freescale.com>
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

Add interrupt handling support for 64-bit bookehv hosts. Unify 32 and 64 bit
implementations using a common stack layout and a common execution flow starting
from kvm_handler_common macro. Update documentation for 64-bit input register
values. This patch only address the bolted TLB miss exception handlers version.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
v1: updated CRIT and TLB exception handling following core side changes.

 arch/powerpc/include/asm/kvm_booke_hv_asm.h |   25 +++++
 arch/powerpc/kvm/bookehv_interrupts.S       |  138 +++++++++++++++++++++++++--
 2 files changed, 155 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_booke_hv_asm.h b/arch/powerpc/include/asm/kvm_booke_hv_asm.h
index a37a12a..7ad5af7 100644
--- a/arch/powerpc/include/asm/kvm_booke_hv_asm.h
+++ b/arch/powerpc/include/asm/kvm_booke_hv_asm.h
@@ -17,6 +17,7 @@
  * there are no exceptions for which we fall through directly to
  * the normal host handler.
  *
+ * 32-bit host
  * Expected inputs (normal exceptions):
  *   SCRATCH0 = saved r10
  *   r10 = thread struct
@@ -33,6 +34,30 @@
  *   *(r8 + GPR9) = saved r9
  *   *(r8 + GPR10) = saved r10 (r10 not yet clobbered)
  *   *(r8 + GPR11) = saved r11
+ *
+ * 64-bit host
+ * Expected inputs (GEN/GDBELL/DBG/MC exception types):
+ *  r10 = saved CR 
+ *  r13 = PACA_POINTER
+ *  *(r13 + PACA_EX##type + EX_R10) = saved r10
+ *  *(r13 + PACA_EX##type + EX_R11) = saved r11
+ *  SPRN_SPRG_##type##_SCRATCH = saved r13 
+ *
+  * Expected inputs (CRIT exception type):
+ *  r10 = saved CR
+ *  r13 = PACA_POINTER
+ *  *(r13 + PACA_EX##type + EX_R10) = saved r10
+ *  *(r13 + PACA_EX##type + EX_R11) = saved r11
+ *  *(r13 + PACA_EX##type + EX_R13) = saved r13
+ *
+ * Expected inputs (TLB exception type):
+ *  r10 = saved CR
+ *  r13 = PACA_POINTER
+ *  *(r13 + PACA_EX##type + EX_TLB_R10) = saved r10
+ *  *(r13 + PACA_EX##type + EX_TLB_R11) = saved r11
+ *  SPRN_SPRG_GEN_SCRATCH = saved r13
+ *
+ * Only the bolted version of TLB miss exception handlers is supported now.
  */
 .macro DO_KVM intno srr1
 #ifdef CONFIG_KVM_BOOKE_HV
diff --git a/arch/powerpc/kvm/bookehv_interrupts.S b/arch/powerpc/kvm/bookehv_interrupts.S
index fa6d552..e8ed7d6 100644
--- a/arch/powerpc/kvm/bookehv_interrupts.S
+++ b/arch/powerpc/kvm/bookehv_interrupts.S
@@ -16,6 +16,7 @@
  *
  * Author: Varun Sethi <varun.sethi@freescale.com>
  * Author: Scott Wood <scotwood@freescale.com>
+ * Author: Mihai Caraman <mihai.caraman@freescale.com>
  *
  * This file is derived from arch/powerpc/kvm/booke_interrupts.S
  */
@@ -30,28 +31,33 @@
 #include <asm/bitsperlong.h>
 #include <asm/thread_info.h>
 
+#ifdef CONFIG_64BIT
+#include <asm/exception-64e.h>
+#else
 #include "../kernel/head_booke.h" /* for THREAD_NORMSAVE() */
+#endif
 
 #define LONGBYTES		(BITS_PER_LONG / 8)
 
 #define VCPU_GUEST_SPRG(n)	(VCPU_GUEST_SPRGS + (n * LONGBYTES))
 
 /* The host stack layout: */
-#define HOST_R1         (0 * LONGBYTES) /* Implied by stwu. */
-#define HOST_CALLEE_LR  (1 * LONGBYTES)
-#define HOST_RUN        (2 * LONGBYTES) /* struct kvm_run */
+#define HOST_R1         0 /* Implied by stwu. */
+#define HOST_CALLEE_LR  PPC_LR_STKOFF
+#define HOST_RUN        (HOST_CALLEE_LR + LONGBYTES)
 /*
  * r2 is special: it holds 'current', and it made nonvolatile in the
  * kernel with the -ffixed-r2 gcc option.
  */
-#define HOST_R2         (3 * LONGBYTES)
-#define HOST_CR         (4 * LONGBYTES)
-#define HOST_NV_GPRS    (5 * LONGBYTES)
+#define HOST_R2         (HOST_RUN + LONGBYTES)
+#define HOST_CR         (HOST_R2 + LONGBYTES)
+#define HOST_NV_GPRS    (HOST_CR + LONGBYTES)
 #define __HOST_NV_GPR(n)  (HOST_NV_GPRS + ((n - 14) * LONGBYTES))
 #define HOST_NV_GPR(n)  __HOST_NV_GPR(__REG_##n)
 #define HOST_MIN_STACK_SIZE (HOST_NV_GPR(R31) + LONGBYTES)
 #define HOST_STACK_SIZE ((HOST_MIN_STACK_SIZE + 15) & ~15) /* Align. */
-#define HOST_STACK_LR   (HOST_STACK_SIZE + LONGBYTES) /* In caller stack frame. */
+/* LR in caller stack frame. */
+#define HOST_STACK_LR	(HOST_STACK_SIZE + PPC_LR_STKOFF)
 
 #define NEED_EMU		0x00000001 /* emulation -- save nv regs */
 #define NEED_DEAR		0x00000002 /* save faulting DEAR */
@@ -198,6 +204,122 @@
 	b	kvmppc_resume_host
 .endm
 
+#ifdef CONFIG_64BIT
+/* Exception types */
+#define EX_GEN			1
+#define EX_GDBELL		2
+#define EX_DBG			3
+#define EX_MC			4
+#define EX_CRIT			5
+#define EX_TLB			6
+
+/*
+ * For input register values, see arch/powerpc/include/asm/kvm_booke_hv_asm.h
+ */
+.macro kvm_handler intno type scratch, paca_ex, ex_r10, ex_r11, srr0, srr1, flags
+ _GLOBAL(kvmppc_handler_\intno\()_\srr1)
+	mr	r11, r4
+	/*
+	 * Get vcpu from Paca: paca->__current.thread->kvm_vcpu
+	 */
+	PPC_LL	r4, PACACURRENT(r13)
+	PPC_LL	r4, (THREAD + THREAD_KVM_VCPU)(r4)
+	stw	r10, VCPU_CR(r4)
+	PPC_STL r11, VCPU_GPR(R4)(r4)
+	PPC_STL	r5, VCPU_GPR(R5)(r4)
+	.if \type == EX_CRIT
+	PPC_LL	r5, (\paca_ex + EX_R13)(r13)
+	.else
+	mfspr	r5, \scratch
+	.endif
+	PPC_STL	r6, VCPU_GPR(R6)(r4)
+	PPC_STL	r8, VCPU_GPR(R8)(r4)
+	PPC_STL	r9, VCPU_GPR(R9)(r4)
+	PPC_STL r5, VCPU_GPR(R13)(r4)
+	PPC_LL	r6, (\paca_ex + \ex_r10)(r13)
+	PPC_LL	r8, (\paca_ex + \ex_r11)(r13)
+	PPC_STL r3, VCPU_GPR(R3)(r4)
+	PPC_STL r7, VCPU_GPR(R7)(r4)
+	PPC_STL r12, VCPU_GPR(R12)(r4)
+	PPC_STL r6, VCPU_GPR(R10)(r4)
+	PPC_STL r8, VCPU_GPR(R11)(r4)
+	mfctr	r5
+	PPC_STL	r5, VCPU_CTR(r4)
+	mfspr	r5, \srr0
+	mfspr	r6, \srr1
+	kvm_handler_common \intno, \srr0, \flags
+.endm
+
+#define EX_PARAMS(type) \
+	EX_##type, \
+	SPRN_SPRG_##type##_SCRATCH, \
+	PACA_EX##type, \
+	EX_R10, \
+	EX_R11
+
+#define EX_PARAMS_TLB \
+	EX_TLB, \
+	SPRN_SPRG_GEN_SCRATCH, \
+	PACA_EXTLB, \
+	EX_TLB_R10, \
+	EX_TLB_R11
+
+kvm_handler BOOKE_INTERRUPT_CRITICAL, EX_PARAMS(CRIT), \
+	SPRN_CSRR0, SPRN_CSRR1, 0
+kvm_handler BOOKE_INTERRUPT_MACHINE_CHECK, EX_PARAMS(MC), \
+	SPRN_MCSRR0, SPRN_MCSRR1, 0
+kvm_handler BOOKE_INTERRUPT_DATA_STORAGE, EX_PARAMS(GEN), \
+	SPRN_SRR0, SPRN_SRR1,(NEED_EMU | NEED_DEAR | NEED_ESR)
+kvm_handler BOOKE_INTERRUPT_INST_STORAGE, EX_PARAMS(GEN), \
+	SPRN_SRR0, SPRN_SRR1, NEED_ESR
+kvm_handler BOOKE_INTERRUPT_EXTERNAL, EX_PARAMS(GEN), \
+	SPRN_SRR0, SPRN_SRR1, 0
+kvm_handler BOOKE_INTERRUPT_ALIGNMENT, EX_PARAMS(GEN), \
+	SPRN_SRR0, SPRN_SRR1,(NEED_DEAR | NEED_ESR)
+kvm_handler BOOKE_INTERRUPT_PROGRAM, EX_PARAMS(GEN), \
+	SPRN_SRR0, SPRN_SRR1,NEED_ESR
+kvm_handler BOOKE_INTERRUPT_FP_UNAVAIL, EX_PARAMS(GEN), \
+	SPRN_SRR0, SPRN_SRR1, 0
+kvm_handler BOOKE_INTERRUPT_AP_UNAVAIL, EX_PARAMS(GEN), \
+	SPRN_SRR0, SPRN_SRR1, 0
+kvm_handler BOOKE_INTERRUPT_DECREMENTER, EX_PARAMS(GEN), \
+	SPRN_SRR0, SPRN_SRR1, 0
+kvm_handler BOOKE_INTERRUPT_FIT, EX_PARAMS(GEN), \
+	SPRN_SRR0, SPRN_SRR1, 0
+kvm_handler BOOKE_INTERRUPT_WATCHDOG, EX_PARAMS(CRIT),\
+	SPRN_CSRR0, SPRN_CSRR1, 0
+/*
+ * Only bolted TLB miss exception handlers are supported for now
+ */
+kvm_handler BOOKE_INTERRUPT_DTLB_MISS, EX_PARAMS_TLB, \
+	SPRN_SRR0, SPRN_SRR1, (NEED_EMU | NEED_DEAR | NEED_ESR)
+kvm_handler BOOKE_INTERRUPT_ITLB_MISS, EX_PARAMS_TLB, \
+	SPRN_SRR0, SPRN_SRR1, 0
+kvm_handler BOOKE_INTERRUPT_SPE_UNAVAIL, EX_PARAMS(GEN), \
+	SPRN_SRR0, SPRN_SRR1, 0
+kvm_handler BOOKE_INTERRUPT_SPE_FP_DATA, EX_PARAMS(GEN), \
+	SPRN_SRR0, SPRN_SRR1, 0
+kvm_handler BOOKE_INTERRUPT_SPE_FP_ROUND, EX_PARAMS(GEN), \
+	SPRN_SRR0, SPRN_SRR1, 0
+kvm_handler BOOKE_INTERRUPT_PERFORMANCE_MONITOR, EX_PARAMS(GEN), \
+	SPRN_SRR0, SPRN_SRR1, 0
+kvm_handler BOOKE_INTERRUPT_DOORBELL, EX_PARAMS(GEN), \
+	SPRN_SRR0, SPRN_SRR1, 0
+kvm_handler BOOKE_INTERRUPT_DOORBELL_CRITICAL, EX_PARAMS(CRIT), \
+	SPRN_CSRR0, SPRN_CSRR1, 0
+kvm_handler BOOKE_INTERRUPT_HV_PRIV, EX_PARAMS(GEN), \
+	SPRN_SRR0, SPRN_SRR1, NEED_EMU
+kvm_handler BOOKE_INTERRUPT_HV_SYSCALL, EX_PARAMS(GEN), \
+	SPRN_SRR0, SPRN_SRR1, 0
+kvm_handler BOOKE_INTERRUPT_GUEST_DBELL, EX_PARAMS(GDBELL), \
+	SPRN_GSRR0, SPRN_GSRR1, 0
+kvm_handler BOOKE_INTERRUPT_GUEST_DBELL_CRIT, EX_PARAMS(CRIT), \
+	SPRN_CSRR0, SPRN_CSRR1, 0
+kvm_handler BOOKE_INTERRUPT_DEBUG, EX_PARAMS(DBG), \
+	SPRN_DSRR0, SPRN_DSRR1, 0
+kvm_handler BOOKE_INTERRUPT_DEBUG, EX_PARAMS(CRIT), \
+	SPRN_CSRR0, SPRN_CSRR1, 0
+#else
 /*
  * For input register values, see arch/powerpc/include/asm/kvm_booke_hv_asm.h
  */
@@ -292,7 +414,7 @@ kvm_lvl_handler BOOKE_INTERRUPT_DEBUG, \
 	SPRN_SPRG_RSCRATCH_CRIT, SPRN_CSRR0, SPRN_CSRR1, 0
 kvm_lvl_handler BOOKE_INTERRUPT_DEBUG, \
 	SPRN_SPRG_RSCRATCH_DBG, SPRN_DSRR0, SPRN_DSRR1, 0
-
+#endif
 
 /* Registers:
  *  SPRG_SCRATCH0: guest r10
-- 
1.7.4.1

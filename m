Return-Path: <mcaraman@mcaraman-VirtualBox.ea.freescale.net>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 77D6E100853
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 22:26:57 +1000 (EST)
Received: from mail138-ch1 (localhost [127.0.0.1])	by
 mail138-ch1-R.bigfish.com (Postfix) with ESMTP id 5215A2202CE	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 12:25:15 +0000 (UTC)
Received: from CH1EHSMHS030.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.245])	by mail138-ch1.bigfish.com (Postfix) with ESMTP id
 A2FFC160047	for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 12:25:13
 +0000 (UTC)
Received: from mcaraman-VirtualBox.ea.freescale.net ([10.213.130.145])	by
 az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id q5PCQmuR019396	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 05:26:49 -0700
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <qemu-ppc@nongnu.org>
Subject: [RFC PATCH 15/17] KVM: PPC64: bookehv: Add support for interrupt
 handling
Date: Mon, 25 Jun 2012 15:26:33 +0300
Message-ID: <1340627195-11544-16-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add bookehv interrupt handling support for 64-bit hosts. Change common stack
layout to refer PPC_LR_STKOFF kernel constant. Dispatch the 64-bit execution
flow to the existing kvm_handler_common asm macro. Update input register
values documentation.
Only the bolted version of TLB miss exception handlers is supported now.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/include/asm/kvm_booke_hv_asm.h |   12 +++-
 arch/powerpc/kvm/bookehv_interrupts.S       |  120 +++++++++++++++++++++++++--
 2 files changed, 122 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_booke_hv_asm.h b/arch/powerpc/include/asm/kvm_booke_hv_asm.h
index 30a600f..8be6f87 100644
--- a/arch/powerpc/include/asm/kvm_booke_hv_asm.h
+++ b/arch/powerpc/include/asm/kvm_booke_hv_asm.h
@@ -1,5 +1,5 @@
 /*
- * Copyright 2010-2011 Freescale Semiconductor, Inc.
+ * Copyright 2010-2012 Freescale Semiconductor, Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License, version 2, as
@@ -17,6 +17,7 @@
  * there are no exceptions for which we fall through directly to
  * the normal host handler.
  *
+ * 32-bit host
  * Expected inputs (normal exceptions):
  *   SCRATCH0 = saved r10
  *   r10 = thread struct
@@ -33,6 +34,15 @@
  *   *(r8 + GPR9) = saved r9
  *   *(r8 + GPR10) = saved r10 (r10 not yet clobbered)
  *   *(r8 + GPR11) = saved r11
+ *
+ * 64-bit host
+ * Expected inputs (exception types GEN/DBG/CRIT/MC):
+ *  r13 = PACA_POINTER
+ *  r10 = saved CR
+ *  SPRN_SPRG_##type##_SCRATCH = saved r13
+ *  *(r13 + PACA_EX##type + EX_R10) = saved r10
+ *  *(r13 + PACA_EX##type + EX_R11) = saved r11
+ * Only the bolted version of TLB miss exception handlers is supported now.
  */
 .macro DO_KVM intno srr1
 #ifdef CONFIG_KVM_BOOKE_HV
diff --git a/arch/powerpc/kvm/bookehv_interrupts.S b/arch/powerpc/kvm/bookehv_interrupts.S
index dff8ed4..04097de 100644
--- a/arch/powerpc/kvm/bookehv_interrupts.S
+++ b/arch/powerpc/kvm/bookehv_interrupts.S
@@ -12,10 +12,11 @@
  * along with this program; if not, write to the Free Software
  * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
  *
- * Copyright (C) 2010-2011 Freescale Semiconductor, Inc.
+ * Copyright (C) 2010-2012 Freescale Semiconductor, Inc.
  *
  * Author: Varun Sethi <varun.sethi@freescale.com>
  * Author: Scott Wood <scotwood@freescale.com>
+ * Author: Mihai Caraman <mihai.caraman@freescale.com>
  *
  * This file is derived from arch/powerpc/kvm/booke_interrupts.S
  */
@@ -30,7 +31,11 @@
 #include <asm/bitsperlong.h>
 #include <asm/thread_info.h>
 
+#ifdef CONFIG_64BIT
+#include <asm/exception-64e.h>
+#else
 #include "../kernel/head_booke.h" /* for THREAD_NORMSAVE() */
+#endif
 
 #define LONGBYTES		(BITS_PER_LONG / 8)
 
@@ -38,20 +43,21 @@
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
 #define HOST_NV_GPR(n)  (HOST_NV_GPRS + ((n - 14) * LONGBYTES))
 #define HOST_MIN_STACK_SIZE (HOST_NV_GPR(31) + LONGBYTES)
 #define HOST_STACK_SIZE ((HOST_MIN_STACK_SIZE + 15) & ~15) /* Align. */
-#define HOST_STACK_LR   (HOST_STACK_SIZE + LONGBYTES) /* In caller stack frame. */
+/* LR in caller stack frame. */
+#define HOST_STACK_LR	(HOST_STACK_SIZE + PPC_LR_STKOFF)
 
 #define NEED_EMU		0x00000001 /* emulation -- save nv regs */
 #define NEED_DEAR		0x00000002 /* save faulting DEAR */
@@ -202,6 +208,102 @@
 	b	kvmppc_resume_host
 .endm
 
+#ifdef CONFIG_64BIT
+/*
+ * For input register values, see arch/powerpc/include/asm/kvm_booke_hv_asm.h
+ */
+.macro kvm_handler intno scratch, paca_ex, ex_r10, ex_r11, srr0, srr1, flags
+ _GLOBAL(kvmppc_handler_\intno\()_\srr1)
+	mr	r11, r4
+	/*
+	 * Get vcpu from Paca: paca->__current.thread->kvm_vcpu
+	 */
+	PPC_LL	r4, PACACURRENT(r13)
+	PPC_LL	r4, (THREAD + THREAD_KVM_VCPU)(r4)
+	stw	r10, VCPU_CR(r4)
+	PPC_STL r11, VCPU_GPR(r4)(r4)
+	PPC_STL	r5, VCPU_GPR(r5)(r4)
+	mfspr	r5, \scratch
+	PPC_STL	r6, VCPU_GPR(r6)(r4)
+	PPC_STL	r8, VCPU_GPR(r8)(r4)
+	PPC_STL	r9, VCPU_GPR(r9)(r4)
+	PPC_STL r5, VCPU_GPR(r13)(r4)
+	PPC_LL	r6, (\paca_ex + \ex_r10)(r13)
+	PPC_LL	r8, (\paca_ex + \ex_r11)(r13)
+	PPC_STL r3, VCPU_GPR(r3)(r4)
+	PPC_STL r7, VCPU_GPR(r7)(r4)
+	PPC_STL r12, VCPU_GPR(r12)(r4)
+	PPC_STL r6, VCPU_GPR(r10)(r4)
+	PPC_STL r8, VCPU_GPR(r11)(r4)
+	mfctr	r5
+	PPC_STL	r5, VCPU_CTR(r4)
+	mfspr	r5, \srr0
+	mfspr	r6, \srr1
+	kvm_handler_common \intno, \srr0, \flags
+.endm
+
+#define EX_PARAMS(type) 	    \
+	SPRN_SPRG_##type##_SCRATCH, \
+	PACA_EX##type, 		    \
+	EX_R10, 		    \
+	EX_R11
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
+kvm_handler BOOKE_INTERRUPT_DTLB_MISS, EX_PARAMS(GEN), \
+	SPRN_SRR0, SPRN_SRR1, (NEED_EMU | NEED_DEAR | NEED_ESR)
+kvm_handler BOOKE_INTERRUPT_ITLB_MISS, EX_PARAMS(GEN), \
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
+kvm_handler BOOKE_INTERRUPT_GUEST_DBELL, EX_PARAMS(GEN), \
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
@@ -296,7 +398,7 @@ kvm_lvl_handler BOOKE_INTERRUPT_DEBUG, \
 	SPRN_SPRG_RSCRATCH_CRIT, SPRN_CSRR0, SPRN_CSRR1, 0
 kvm_lvl_handler BOOKE_INTERRUPT_DEBUG, \
 	SPRN_SPRG_RSCRATCH_DBG, SPRN_DSRR0, SPRN_DSRR1, 0
-
+#endif
 
 /* Registers:
  *  SPRG_SCRATCH0: guest r10
-- 
1.7.4.1

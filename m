Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 408y5T3HJtzF21X
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 02:01:16 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id m68so7612606pfm.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 08:01:16 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] powerpc/64s: return more carefully from sreset NMI
Date: Tue, 27 Mar 2018 01:01:03 +1000
Message-Id: <20180326150103.22941-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

System Reset, being an NMI, must return more carefully than other
interrupts. It has traditionally returned via the nromal return
from exception path, but that has a number of problems.

- r13 does not get restored if returning to kernel. This is for
  interrupts which may cause a context switch, which sreset will
  never do. Interrupting OPAL (which uses a different r13) is one
  place where this causes breakage.

- It may cause several other problems returning to kernel with
  preempt or TIF_EMULATE_STACK_STORE if it hits at the wrong time.

It's safer just to have a simple restore and return, like machine
check which is the other NMI.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 61 ++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 3ac87e53b3da..114ff7170562 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -139,6 +139,21 @@ EXC_COMMON_BEGIN(system_reset_idle_common)
 	b	pnv_powersave_wakeup
 #endif
 
+/*
+ * Set IRQS_ALL_DISABLED unconditionally so arch_irqs_disabled does
+ * the right thing. We do not want to reconcile because that goes
+ * through irq tracing which we don't want in NMI.
+ *
+ * Save PACAIRQHAPPENED because some code will do a hard disable
+ * (e.g., xmon). So we want to restore this back to where it was
+ * when we return. DAR is unused in the stack, so save it there.
+ */
+#define ADD_RECONCILE_NMI						\
+	li	r10,IRQS_ALL_DISABLED;					\
+	stb	r10,PACAIRQSOFTMASK(r13);				\
+	lbz	r10,PACAIRQHAPPENED(r13);				\
+	std	r10,_DAR(r1)
+
 EXC_COMMON_BEGIN(system_reset_common)
 	/*
 	 * Increment paca->in_nmi then enable MSR_RI. SLB or MCE will be able
@@ -157,16 +172,56 @@ EXC_COMMON_BEGIN(system_reset_common)
 	subi	r1,r1,INT_FRAME_SIZE
 	EXCEPTION_COMMON_NORET_STACK(PACA_EXNMI, 0x100,
 			system_reset, system_reset_exception,
-			ADD_NVGPRS;ADD_RECONCILE)
+			ADD_NVGPRS;ADD_RECONCILE_NMI)
+
+	/* This (and MCE) can be simplified with mtmsrd L=1 */
+	/* Clear MSR_RI before setting SRR0 and SRR1. */
+	li	r0,MSR_RI
+	mfmsr	r9
+	andc	r9,r9,r0
+	mtmsrd	r9,1
 
 	/*
-	 * The stack is no longer in use, decrement in_nmi.
+	 * MSR_RI is clear, now we can decrement paca->in_nmi.
 	 */
 	lhz	r10,PACA_IN_NMI(r13)
 	subi	r10,r10,1
 	sth	r10,PACA_IN_NMI(r13)
 
-	b	ret_from_except
+	/*
+	 * Restore soft mask settings.
+	 */
+	ld	r10,_DAR(r1)
+	stb	r10,PACAIRQHAPPENED(r13)
+	ld	r10,SOFTE(r1)
+	stb	r10,PACAIRQSOFTMASK(r13)
+
+	/*
+	 * Keep below code in synch with MACHINE_CHECK_HANDLER_WINDUP.
+	 * Should share common bits...
+	 */
+
+	/* Move original SRR0 and SRR1 into the respective regs */
+	ld	r9,_MSR(r1)
+	mtspr	SPRN_SRR1,r9
+	ld	r3,_NIP(r1)
+	mtspr	SPRN_SRR0,r3
+	ld	r9,_CTR(r1)
+	mtctr	r9
+	ld	r9,_XER(r1)
+	mtxer	r9
+	ld	r9,_LINK(r1)
+	mtlr	r9
+	REST_GPR(0, r1)
+	REST_8GPRS(2, r1)
+	REST_GPR(10, r1)
+	ld	r11,_CCR(r1)
+	mtcr	r11
+	REST_GPR(11, r1)
+	REST_2GPRS(12, r1)
+	/* restore original r1. */
+	ld	r1,GPR1(r1)
+	RFI_TO_USER_OR_KERNEL
 
 #ifdef CONFIG_PPC_PSERIES
 /*
-- 
2.16.1

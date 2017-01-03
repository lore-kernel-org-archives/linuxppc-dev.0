Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tt5Gd3kvjzDqGW
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jan 2017 18:31:21 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id n5so32727025pgh.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Jan 2017 23:31:21 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Balbir Singh <bsingharora@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC v2 2/3] Keep interrupts enabled even on soft disable
Date: Tue,  3 Jan 2017 18:30:57 +1100
Message-Id: <20170103073058.30066-3-bsingharora@gmail.com>
In-Reply-To: <20170103073058.30066-1-bsingharora@gmail.com>
References: <20170103073058.30066-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch removes the disabling of interrupts
in soft-disable mode, when interrupts are received
(in lazy mode). The new scheme keeps the interrupts
enabled when we receive an interrupt and does the
following:

   When an external interrupt is received, we
   store the interrupt in local_paca via
   ppc_md.get_irq(). Later when interrupts are
   enabled and replayed, we reuse the stored
   interrupt and process it via generic_handle_irq

NOTE: This works only for PPC_XICS at the moment
and we'll enable it for XIVE in the future. MPIC/
OpenPIC is not supported due to the requirment
that external interrupts/IPIs need unique priorities.
At the cost of adding more space in the PACA, we
can store multiple priorities and support more
controllers, but I think we can live with supporting
only XICS for now and XIVE in the future.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Nicholas Piggin <npiggin@gmail.com>

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/include/asm/paca.h      |  1 +
 arch/powerpc/kernel/exceptions-64s.S | 25 ++++++++++++++---
 arch/powerpc/kernel/irq.c            | 52 +++++++++++++++++++++++++++++++++++-
 arch/powerpc/kernel/time.c           |  2 +-
 4 files changed, 74 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 6a6792b..dcbcaa6 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -163,6 +163,7 @@ struct paca_struct {
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	u64 tm_scratch;                 /* TM scratch area for reclaim */
 #endif
+	u32 irq;			/* IRQ pending */
 
 #ifdef CONFIG_PPC_POWERNV
 	/* Per-core mask tracking idle threads and a lock bit-[L][TTTTTTTT] */
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index d39d611..cf64bc4 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1273,6 +1273,23 @@ EXC_REAL_NONE(0x1800, 0x1900)
 EXC_VIRT_NONE(0x5800, 0x5900)
 #endif
 
+/*
+ * Currently we support keeping interrupts
+ * enabled only for XICS. We can enhance this
+ * as we add support for other controllers
+ */
+#ifdef CONFIG_PPC_XICS
+#define MASKED_INTERRUPT_DISABLE(_H)			\
+	GET_SCRATCH0(r10);				\
+	std	r13,PACA_EXGEN+EX_R13(r13);		\
+	EXCEPTION_PROLOG_PSERIES_1(handle_irq_mask, _H);
+#else
+#define MASKED_INTERRUPT_DISABLE(_H)			\
+	mfspr	r10,SPRN_##_H##SRR1;			\
+	rldicl	r10,r10,48,1; /* clear MSR_EE */	\
+	rotldi	r10,r10,16;				\
+	mtspr	SPRN_##_H##SRR1,r10;
+#endif
 
 /*
  * An interrupt came in while soft-disabled. We set paca->irq_happened, then:
@@ -1287,6 +1304,7 @@ EXC_VIRT_NONE(0x5800, 0x5900)
 #define MASKED_INTERRUPT(_H)				\
 masked_##_H##interrupt:					\
 	std	r11,PACA_EXGEN+EX_R11(r13);		\
+	std	r12,PACA_EXGEN+EX_R12(r13);		\
 	lbz	r11,PACAIRQHAPPENED(r13);		\
 	or	r11,r11,r10;				\
 	stb	r11,PACAIRQHAPPENED(r13);		\
@@ -1300,10 +1318,7 @@ masked_##_H##interrupt:					\
 	beq	2f;					\
 	cmpwi	r10,PACA_IRQ_HMI;			\
 	beq	2f;					\
-	mfspr	r10,SPRN_##_H##SRR1;			\
-	rldicl	r10,r10,48,1; /* clear MSR_EE */	\
-	rotldi	r10,r10,16;				\
-	mtspr	SPRN_##_H##SRR1,r10;			\
+	MASKED_INTERRUPT_DISABLE(_H)			\
 2:	mtcrf	0x80,r9;				\
 	ld	r9,PACA_EXGEN+EX_R9(r13);		\
 	ld	r10,PACA_EXGEN+EX_R10(r13);		\
@@ -1321,6 +1336,8 @@ USE_FIXED_SECTION(virt_trampolines)
 	MASKED_INTERRUPT()
 	MASKED_INTERRUPT(H)
 
+EXC_COMMON(handle_irq_mask, 0x500, handle_masked_irq)
+
 #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
 TRAMP_REAL_BEGIN(kvmppc_skip_interrupt)
 	/*
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index a018f5c..f6c23f2 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -97,6 +97,31 @@ extern int tau_interrupts(int);
 
 int distribute_irqs = 1;
 
+#ifdef CONFIG_PPC_XICS
+static inline notrace int get_paca_irq(void)
+{
+	int irq;
+
+	__asm__ __volatile__("lbz %0,%1(13)"
+	: "=r" (irq) : "i" (offsetof(struct paca_struct, irq)));
+
+	return irq;
+}
+#else
+static inline notrace int get_paca_irq(void)
+{
+	return -1;
+}
+#endif
+
+#ifdef CONFIG_PPC_XICS
+static inline notrace void set_paca_irq(int irq)
+{
+	__asm__ __volatile__("stb %0,%1(13)"
+	: : "r" (irq), "i" (offsetof(struct paca_struct, irq)));
+}
+#endif
+
 static inline notrace unsigned long get_irq_happened(void)
 {
 	unsigned long happened;
@@ -498,6 +523,26 @@ static inline void check_stack_overflow(void)
 #endif
 }
 
+#ifdef CONFIG_PPC_XICS
+void handle_masked_irq(struct pt_regs *regs)
+{
+	/*
+	 * TODO: Add support for XIVE as applicable
+	 */
+	unsigned int irq;
+	/*
+	 * NOTE, we don't use irq_enter/exit, otherwise
+	 * our accounting and tracing might be incorrect.
+	 */
+	irq = ppc_md.get_irq();
+
+	/*
+	 * Store away irq in PACA for replay later
+	 */
+	set_paca_irq(irq);
+}
+#endif
+
 void __do_irq(struct pt_regs *regs)
 {
 	unsigned int irq;
@@ -513,7 +558,12 @@ void __do_irq(struct pt_regs *regs)
 	 *
 	 * This will typically lower the interrupt line to the CPU
 	 */
-	irq = ppc_md.get_irq();
+	irq = get_paca_irq();
+	if (irq != - 1) {
+		set_paca_irq(-1);
+	} else {
+		irq = ppc_md.get_irq();
+	}
 
 	/* We can hard enable interrupts now to allow perf interrupts */
 	may_hard_irq_enable();
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index bc2e08d..52f8f81 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -549,7 +549,6 @@ static void __timer_interrupt(void)
 		cu->current_tb = mfspr(SPRN_PURR);
 	}
 #endif
-
 	trace_timer_interrupt_exit(regs);
 }
 
@@ -598,6 +597,7 @@ void timer_interrupt(struct pt_regs * regs)
 }
 EXPORT_SYMBOL(timer_interrupt);
 
+
 /*
  * Hypervisor decrementer interrupts shouldn't occur but are sometimes
  * left pending on exit from a KVM guest.  We don't need to do anything
-- 
2.9.3

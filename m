Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tcdPR43qHzDvv2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Dec 2016 20:50:35 +1100 (AEDT)
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tcdPQ6By3z9tB1
 for <linuxppc-dev@ozlabs.org>; Mon, 12 Dec 2016 20:50:34 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id i88so286167pfk.2
 for <linuxppc-dev@ozlabs.org>; Mon, 12 Dec 2016 01:50:34 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@ozlabs.org
Cc: Balbir Singh <bsingharora@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>
Subject: [powerpc/nmi: RFC 2/2] Keep interrupts enabled even on soft disable
Date: Mon, 12 Dec 2016 20:50:03 +1100
Message-Id: <20161212095003.1885-3-bsingharora@gmail.com>
In-Reply-To: <20161212095003.1885-1-bsingharora@gmail.com>
References: <20161212095003.1885-1-bsingharora@gmail.com>
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
following

a. On decrementer interrupt, instead of setting
dec to maximum and returning, we do the following
  i. Call a function handle_nmi_dec, which in
     turn calls handle_soft_nmi
  ii. handle_soft_nmi sets the decrementer value
      to 1 second and checks if more than 30
      seconds have passed since starting it. If
      so it calls BUG_ON(1), we can do an NMI
      panic as well.
b. When an external interrupt is received, we
   store the interrupt in local_paca via
   ppc_md.get_irq(). Later when interrupts are
   enabled and replayed, we reuse the stored
   interrupt and process it via generic_handle_irq

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Nicholas Piggin <npiggin@gmail.com>

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/include/asm/paca.h      |  1 +
 arch/powerpc/kernel/exceptions-64s.S | 17 ++++++++++-------
 arch/powerpc/kernel/irq.c            | 21 ++++++++++++++++++++-
 arch/powerpc/kernel/time.c           | 27 ++++++++++++++++++++++++++-
 4 files changed, 57 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 6a6792b..091af5c 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -158,6 +158,7 @@ struct paca_struct {
 	u8 irq_happened;		/* irq happened while soft-disabled */
 	u8 io_sync;			/* writel() needs spin_unlock sync */
 	u8 irq_work_pending;		/* IRQ_WORK interrupt while soft-disable */
+	u32 irq;			/* IRQ pending */
 	u8 nap_state_lost;		/* NV GPR values lost in power7_idle */
 	u64 sprg_vdso;			/* Saved user-visible sprg */
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index d39d611..2620a90 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1287,23 +1287,23 @@ EXC_VIRT_NONE(0x5800, 0x5900)
 #define MASKED_INTERRUPT(_H)				\
 masked_##_H##interrupt:					\
 	std	r11,PACA_EXGEN+EX_R11(r13);		\
+	std	r12,PACA_EXGEN+EX_R12(r13);		\
 	lbz	r11,PACAIRQHAPPENED(r13);		\
 	or	r11,r11,r10;				\
 	stb	r11,PACAIRQHAPPENED(r13);		\
 	cmpwi	r10,PACA_IRQ_DEC;			\
 	bne	1f;					\
-	lis	r10,0x7fff;				\
-	ori	r10,r10,0xffff;				\
-	mtspr	SPRN_DEC,r10;				\
+	GET_SCRATCH0(r10);				\
+	std	r13,PACA_EXGEN+EX_R13(r13);		\
+	EXCEPTION_PROLOG_PSERIES_1(handle_nmi_dec, _H);	\
 	b	2f;					\
 1:	cmpwi	r10,PACA_IRQ_DBELL;			\
 	beq	2f;					\
 	cmpwi	r10,PACA_IRQ_HMI;			\
 	beq	2f;					\
-	mfspr	r10,SPRN_##_H##SRR1;			\
-	rldicl	r10,r10,48,1; /* clear MSR_EE */	\
-	rotldi	r10,r10,16;				\
-	mtspr	SPRN_##_H##SRR1,r10;			\
+	GET_SCRATCH0(r10);				\
+	std	r13,PACA_EXGEN+EX_R13(r13);		\
+	EXCEPTION_PROLOG_PSERIES_1(elevate_save_irq, _H);\
 2:	mtcrf	0x80,r9;				\
 	ld	r9,PACA_EXGEN+EX_R9(r13);		\
 	ld	r10,PACA_EXGEN+EX_R10(r13);		\
@@ -1321,6 +1321,9 @@ USE_FIXED_SECTION(virt_trampolines)
 	MASKED_INTERRUPT()
 	MASKED_INTERRUPT(H)
 
+EXC_COMMON(handle_nmi_dec, 0x900, handle_soft_nmi)
+EXC_COMMON(elevate_save_irq, 0x500, handle_elevated_irq)
+
 #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
 TRAMP_REAL_BEGIN(kvmppc_skip_interrupt)
 	/*
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 3c05c31..c5b42f7 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -498,6 +498,21 @@ static inline void check_stack_overflow(void)
 #endif
 }
 
+void handle_elevated_irq(struct pt_regs *regs)
+{
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
+	local_paca->irq = irq;
+}
+
 void __do_irq(struct pt_regs *regs)
 {
 	unsigned int irq;
@@ -513,7 +528,11 @@ void __do_irq(struct pt_regs *regs)
 	 *
 	 * This will typically lower the interrupt line to the CPU
 	 */
-	irq = ppc_md.get_irq();
+	if (local_paca->irq) {
+		irq = local_paca->irq;
+		local_paca->irq = 0;
+	} else
+		irq = ppc_md.get_irq();
 
 	/* We can hard enable interrupts now to allow perf interrupts */
 	may_hard_irq_enable();
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index be9751f..1f3b3cd 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -117,6 +117,7 @@ struct clock_event_device decrementer_clockevent = {
 };
 EXPORT_SYMBOL(decrementer_clockevent);
 
+DEFINE_PER_CPU(unsigned long long, nmi_started);
 DEFINE_PER_CPU(u64, decrementers_next_tb);
 static DEFINE_PER_CPU(struct clock_event_device, decrementers);
 
@@ -520,6 +521,7 @@ static void __timer_interrupt(void)
 	u64 now;
 
 	trace_timer_interrupt_entry(regs);
+	__this_cpu_write(nmi_started, 0);
 
 	if (test_irq_work_pending()) {
 		clear_irq_work_pending();
@@ -549,7 +551,6 @@ static void __timer_interrupt(void)
 		cu->current_tb = mfspr(SPRN_PURR);
 	}
 #endif
-
 	trace_timer_interrupt_exit(regs);
 }
 
@@ -566,6 +567,7 @@ void timer_interrupt(struct pt_regs * regs)
 	 * some CPUs will continue to take decrementer exceptions.
 	 */
 	set_dec(decrementer_max);
+	__this_cpu_write(nmi_started, 0);
 
 	/* Some implementations of hotplug will get timer interrupts while
 	 * offline, just ignore these and we also need to set
@@ -598,6 +600,29 @@ void timer_interrupt(struct pt_regs * regs)
 }
 EXPORT_SYMBOL(timer_interrupt);
 
+
+/*
+ * If we have watchdog enabled, we do expect to hit this
+ * at-least once per sample_frequence (20 seconds).
+ * We set the decrement to 20 seconds and if we hit it
+ * again.. it's an NMI panic
+ */
+void handle_soft_nmi(struct pt_regs *regs)
+{
+	unsigned long long tb = mftb();
+	unsigned long long nmi_started_tb = __this_cpu_read(nmi_started);
+
+	if (!nmi_started_tb) {
+		set_dec(ppc_tb_freq);
+		__this_cpu_write(nmi_started, tb);
+	} else {
+		if ((tb - nmi_started_tb) >= (30 * ppc_tb_freq)) {
+			BUG_ON(1);
+		} else
+			set_dec(ppc_tb_freq);
+	}
+}
+
 /*
  * Hypervisor decrementer interrupts shouldn't occur but are sometimes
  * left pending on exit from a KVM guest.  We don't need to do anything
-- 
2.9.3

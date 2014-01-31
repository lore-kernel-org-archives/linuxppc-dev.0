Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7EF3B2C0401
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 15:14:16 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Thu, 30 Jan 2014 23:14:13 -0500
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 4B80F6E8040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 23:14:05 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0V4E9nR3014966
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 04:14:09 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0V4E7L0027575
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 23:14:09 -0500
Subject: [PATCH 3/3] cpuidle/ppc: Split timer_interrupt() into timer
 handling and interrupt handling routines
To: deepthi@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com, toshi.kani@hp.com,
 arnd@arndb.de, geoff@infradead.org, mpe@ellerman.id.au,
 rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
 paul.gortmaker@windriver.com, afleming@freescale.com, anton@samba.org,
 srivatsa.bhat@linux.vnet.ibm.com, benh@kernel.crashing.org,
 paulus@samba.org, ady8radu@gmail.com, linuxppc-dev@lists.ozlabs.org
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Fri, 31 Jan 2014 09:40:33 +0530
Message-ID: <20140131041033.13071.80345.stgit@preeti.in.ibm.com>
In-Reply-To: <20140131040631.13071.19603.stgit@preeti.in.ibm.com>
References: <20140131040631.13071.19603.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Preeti U Murthy <preeti@linux.vnet.ibm.com>

Split timer_interrupt(), which is the local timer interrupt handler on ppc
into routines called during regular interrupt handling and __timer_interrupt(),
which takes care of running local timers and collecting time related stats.

This will enable callers interested only in running expired local timers to
directly call into __timer_interupt(). One of the use cases of this is the
tick broadcast IPI handling in which the sleeping CPUs need to handle the local
timers that have expired.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---

 arch/powerpc/kernel/time.c |   81 +++++++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 3ff97db..df2989b 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -478,6 +478,47 @@ void arch_irq_work_raise(void)
 
 #endif /* CONFIG_IRQ_WORK */
 
+void __timer_interrupt(void)
+{
+	struct pt_regs *regs = get_irq_regs();
+	u64 *next_tb = &__get_cpu_var(decrementers_next_tb);
+	struct clock_event_device *evt = &__get_cpu_var(decrementers);
+	u64 now;
+
+	trace_timer_interrupt_entry(regs);
+
+	if (test_irq_work_pending()) {
+		clear_irq_work_pending();
+		irq_work_run();
+	}
+
+	now = get_tb_or_rtc();
+	if (now >= *next_tb) {
+		*next_tb = ~(u64)0;
+		if (evt->event_handler)
+			evt->event_handler(evt);
+		__get_cpu_var(irq_stat).timer_irqs_event++;
+	} else {
+		now = *next_tb - now;
+		if (now <= DECREMENTER_MAX)
+			set_dec((int)now);
+		/* We may have raced with new irq work */
+		if (test_irq_work_pending())
+			set_dec(1);
+		__get_cpu_var(irq_stat).timer_irqs_others++;
+	}
+
+#ifdef CONFIG_PPC64
+	/* collect purr register values often, for accurate calculations */
+	if (firmware_has_feature(FW_FEATURE_SPLPAR)) {
+		struct cpu_usage *cu = &__get_cpu_var(cpu_usage_array);
+		cu->current_tb = mfspr(SPRN_PURR);
+	}
+#endif
+
+	trace_timer_interrupt_exit(regs);
+}
+
 /*
  * timer_interrupt - gets called when the decrementer overflows,
  * with interrupts disabled.
@@ -486,8 +527,6 @@ void timer_interrupt(struct pt_regs * regs)
 {
 	struct pt_regs *old_regs;
 	u64 *next_tb = &__get_cpu_var(decrementers_next_tb);
-	struct clock_event_device *evt = &__get_cpu_var(decrementers);
-	u64 now;
 
 	/* Ensure a positive value is written to the decrementer, or else
 	 * some CPUs will continue to take decrementer exceptions.
@@ -519,39 +558,7 @@ void timer_interrupt(struct pt_regs * regs)
 	old_regs = set_irq_regs(regs);
 	irq_enter();
 
-	trace_timer_interrupt_entry(regs);
-
-	if (test_irq_work_pending()) {
-		clear_irq_work_pending();
-		irq_work_run();
-	}
-
-	now = get_tb_or_rtc();
-	if (now >= *next_tb) {
-		*next_tb = ~(u64)0;
-		if (evt->event_handler)
-			evt->event_handler(evt);
-		__get_cpu_var(irq_stat).timer_irqs_event++;
-	} else {
-		now = *next_tb - now;
-		if (now <= DECREMENTER_MAX)
-			set_dec((int)now);
-		/* We may have raced with new irq work */
-		if (test_irq_work_pending())
-			set_dec(1);
-		__get_cpu_var(irq_stat).timer_irqs_others++;
-	}
-
-#ifdef CONFIG_PPC64
-	/* collect purr register values often, for accurate calculations */
-	if (firmware_has_feature(FW_FEATURE_SPLPAR)) {
-		struct cpu_usage *cu = &__get_cpu_var(cpu_usage_array);
-		cu->current_tb = mfspr(SPRN_PURR);
-	}
-#endif
-
-	trace_timer_interrupt_exit(regs);
-
+	__timer_interrupt();
 	irq_exit();
 	set_irq_regs(old_regs);
 }
@@ -828,6 +835,10 @@ static void decrementer_set_mode(enum clock_event_mode mode,
 /* Interrupt handler for the timer broadcast IPI */
 void tick_broadcast_ipi_handler(void)
 {
+	u64 *next_tb = &__get_cpu_var(decrementers_next_tb);
+
+	*next_tb = get_tb_or_rtc();
+	__timer_interrupt();
 }
 
 static void register_decrementer_clockevent(int cpu)

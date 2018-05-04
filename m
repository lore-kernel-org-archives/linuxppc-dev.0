Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40czKP0JGkzDqhm
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 May 2018 03:19:52 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id o76so17929948pfi.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 May 2018 10:19:52 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 01/11] powerpc/64: irq_work avoid interrupt when called with
 hardware irqs enabled
Date: Sat,  5 May 2018 03:19:25 +1000
Message-Id: <20180504171935.25410-2-npiggin@gmail.com>
In-Reply-To: <20180504171935.25410-1-npiggin@gmail.com>
References: <20180504171935.25410-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

irq_work_raise should not cause a decrementer exception unless it is
called from NMI context. Doing so often just results in an immediate
masked decrementer interrupt:

   <...>-550    90d...    4us : update_curr_rt <-dequeue_task_rt
   <...>-550    90d...    5us : dbs_update_util_handler <-update_curr_rt
   <...>-550    90d...    6us : arch_irq_work_raise <-irq_work_queue
   <...>-550    90d...    7us : soft_nmi_interrupt <-soft_nmi_common
   <...>-550    90d...    7us : printk_nmi_enter <-soft_nmi_interrupt
   <...>-550    90d.Z.    8us : rcu_nmi_enter <-soft_nmi_interrupt
   <...>-550    90d.Z.    9us : rcu_nmi_exit <-soft_nmi_interrupt
   <...>-550    90d...    9us : printk_nmi_exit <-soft_nmi_interrupt
   <...>-550    90d...   10us : cpuacct_charge <-update_curr_rt

The soft_nmi_interrupt here is the call into the watchdog, due to the
decrementer interrupt firing with irqs soft-disabled. This is
harmless, but sub-optimal.

When it's not called from NMI context or with interrupts enabled, mark
the decrementer pending in the irq_happened mask directly, rather than
having the masked decrementer interupt handler do it. This will be
replayed at the next local_irq_enable. See the comment for details.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/time.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 360e71d455cc..e7e8611e8863 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -513,6 +513,35 @@ static inline void clear_irq_work_pending(void)
 		"i" (offsetof(struct paca_struct, irq_work_pending)));
 }
 
+void arch_irq_work_raise(void)
+{
+	preempt_disable();
+	set_irq_work_pending_flag();
+	/*
+	 * Non-nmi code running with interrupts disabled will replay
+	 * irq_happened before it re-enables interrupts, so setthe
+	 * decrementer there instead of causing a hardware exception
+	 * which would immediately hit the masked interrupt handler
+	 * and have the net effect of setting the decrementer in
+	 * irq_happened.
+	 *
+	 * NMI interrupts can not check this when they return, so the
+	 * decrementer hardware exception is raised, which will fire
+	 * when interrupts are next enabled.
+	 *
+	 * BookE does not support this yet, it must audit all NMI
+	 * interrupt handlers to ensure they call nmi_enter() so this
+	 * check would be correct.
+	 */
+	if (IS_ENABLED(CONFIG_BOOKE) || !irqs_disabled() || in_nmi()) {
+		set_dec(1);
+	} else {
+		hard_irq_disable();
+		local_paca->irq_happened |= PACA_IRQ_DEC;
+	}
+	preempt_enable();
+}
+
 #else /* 32-bit */
 
 DEFINE_PER_CPU(u8, irq_work_pending);
@@ -521,8 +550,6 @@ DEFINE_PER_CPU(u8, irq_work_pending);
 #define test_irq_work_pending()		__this_cpu_read(irq_work_pending)
 #define clear_irq_work_pending()	__this_cpu_write(irq_work_pending, 0)
 
-#endif /* 32 vs 64 bit */
-
 void arch_irq_work_raise(void)
 {
 	preempt_disable();
@@ -531,6 +558,8 @@ void arch_irq_work_raise(void)
 	preempt_enable();
 }
 
+#endif /* 32 vs 64 bit */
+
 #else  /* CONFIG_IRQ_WORK */
 
 #define test_irq_work_pending()	0
-- 
2.17.0

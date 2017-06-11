Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wmChQ2X8LzDqLd
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 10:00:22 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id y7so14693507pfd.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Jun 2017 17:00:22 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH 04/14] powerpc/64s: idle process interrupts from system reset
 wakeup
Date: Mon, 12 Jun 2017 09:58:25 +1000
Message-Id: <20170611235835.7400-5-npiggin@gmail.com>
In-Reply-To: <20170611235835.7400-1-npiggin@gmail.com>
References: <20170611235835.7400-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When the CPU wakes from low power state, it begins at the system reset
interrupt with the exception that caused the wakeup encoded in SRR1.

Today, powernv idle wakeup ignores the wakeup reason (except a special
case for HMI), and the regular interrupt corresponding to the
exception will fire after the idle wakeup exits.

Change this to replay the interrupt from the idle wakeup before
interrupts are hard-enabled.

Test on POWER8 of context_switch selftests benchmark with polling idle
disabled (e.g., always nap, giving cross-CPU IPIs) gives the following
results:

                                original         wakeup direct
Different threads, same core:   315k/s           264k/s
Different cores:                235k/s           242k/s

There is a slowdown for doorbell IPI (same core) case because system
reset wakeup does not clear the message and the doorbell interrupt
fires again needlessly.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/hw_irq.h     |  2 ++
 arch/powerpc/kernel/irq.c             | 25 +++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/idle.c | 10 ++++++++--
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index f06112cf8734..8366bdc69988 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -32,6 +32,7 @@
 #ifndef __ASSEMBLY__
 
 extern void __replay_interrupt(unsigned int vector);
+extern void __replay_wakeup_interrupt(unsigned long srr1);
 
 extern void timer_interrupt(struct pt_regs *);
 extern void performance_monitor_exception(struct pt_regs *regs);
@@ -130,6 +131,7 @@ static inline bool arch_irq_disabled_regs(struct pt_regs *regs)
 
 extern bool prep_irq_for_idle(void);
 extern bool prep_irq_for_idle_irqsoff(void);
+extern void irq_set_pending_from_srr1(unsigned long srr1);
 
 #define fini_irq_for_idle_irqsoff() trace_hardirqs_off();
 
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index be32cec28107..d8a85768c8ec 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -348,6 +348,7 @@ bool prep_irq_for_idle(void)
 	return true;
 }
 
+#ifdef CONFIG_PPC_BOOK3S
 /*
  * This is for idle sequences that return with IRQs off, but the
  * idle state itself wakes on interrupt. Tell the irq tracer that
@@ -379,6 +380,30 @@ bool prep_irq_for_idle_irqsoff(void)
 }
 
 /*
+ * Take the SRR1 wakeup reason, index into this table to find the
+ * appropriate irq_happened bit.
+ */
+static const u8 srr1_to_irq[0x10] = {
+	0, 0, 0,
+	PACA_IRQ_DBELL,
+	0,
+	PACA_IRQ_DBELL,
+	PACA_IRQ_DEC,
+	0,
+	PACA_IRQ_EE,
+	PACA_IRQ_EE,
+	PACA_IRQ_HMI,
+	0, 0, 0, 0, 0 };
+
+void irq_set_pending_from_srr1(unsigned long srr1)
+{
+	unsigned int idx = (srr1 >> 18) & SRR1_WAKEMASK_P8;
+
+	local_paca->irq_happened |= srr1_to_irq[idx];
+}
+#endif /* CONFIG_PPC_BOOK3S */
+
+/*
  * Force a replay of the external interrupt handler on this CPU.
  */
 void force_external_irq_replay(void)
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index e327e1585ddc..ee416e016387 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -302,7 +302,10 @@ static unsigned long __power7_idle_type(unsigned long type)
 
 void power7_idle_type(unsigned long type)
 {
-	__power7_idle_type(type);
+	unsigned long srr1;
+
+	srr1 = __power7_idle_type(type);
+	irq_set_pending_from_srr1(srr1);
 }
 
 void power7_idle(void)
@@ -337,7 +340,10 @@ static unsigned long __power9_idle_type(unsigned long stop_psscr_val,
 void power9_idle_type(unsigned long stop_psscr_val,
 				      unsigned long stop_psscr_mask)
 {
-	__power9_idle_type(stop_psscr_val, stop_psscr_mask);
+	unsigned long srr1;
+
+	srr1 = __power9_idle_type(stop_psscr_val, stop_psscr_mask);
+	irq_set_pending_from_srr1(srr1);
 }
 
 /*
-- 
2.11.0

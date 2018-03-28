Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40B2cn3nL5zF2Kq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 20:28:41 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id l27so745473pfk.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 02:28:41 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 4/5] powerpc: move timer broadcast code under
 GENERIC_CLOCKEVENTS_BROADCAST ifdef
Date: Wed, 28 Mar 2018 19:28:18 +1000
Message-Id: <20180328092819.27015-5-npiggin@gmail.com>
In-Reply-To: <20180328092819.27015-1-npiggin@gmail.com>
References: <20180328092819.27015-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/smp.c  | 8 ++++++++
 arch/powerpc/kernel/time.c | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index de5ac63b4ad6..17c6abed3def 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -155,11 +155,13 @@ static irqreturn_t reschedule_action(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 static irqreturn_t tick_broadcast_ipi_action(int irq, void *data)
 {
 	timer_broadcast_interrupt();
 	return IRQ_HANDLED;
 }
+#endif
 
 #ifdef CONFIG_NMI_IPI
 static irqreturn_t nmi_ipi_action(int irq, void *data)
@@ -172,7 +174,9 @@ static irqreturn_t nmi_ipi_action(int irq, void *data)
 static irq_handler_t smp_ipi_action[] = {
 	[PPC_MSG_CALL_FUNCTION] =  call_function_action,
 	[PPC_MSG_RESCHEDULE] = reschedule_action,
+#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 	[PPC_MSG_TICK_BROADCAST] = tick_broadcast_ipi_action,
+#endif
 #ifdef CONFIG_NMI_IPI
 	[PPC_MSG_NMI_IPI] = nmi_ipi_action,
 #endif
@@ -186,7 +190,9 @@ static irq_handler_t smp_ipi_action[] = {
 const char *smp_ipi_name[] = {
 	[PPC_MSG_CALL_FUNCTION] =  "ipi call function",
 	[PPC_MSG_RESCHEDULE] = "ipi reschedule",
+#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 	[PPC_MSG_TICK_BROADCAST] = "ipi tick-broadcast",
+#endif
 	[PPC_MSG_NMI_IPI] = "nmi ipi",
 };
 
@@ -277,8 +283,10 @@ irqreturn_t smp_ipi_demux_relaxed(void)
 			generic_smp_call_function_interrupt();
 		if (all & IPI_MESSAGE(PPC_MSG_RESCHEDULE))
 			scheduler_ipi();
+#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 		if (all & IPI_MESSAGE(PPC_MSG_TICK_BROADCAST))
 			timer_broadcast_interrupt();
+#endif
 #ifdef CONFIG_NMI_IPI
 		if (all & IPI_MESSAGE(PPC_MSG_NMI_IPI))
 			nmi_ipi_action(0, NULL);
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 199f330e8f01..4c02b6725844 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -604,6 +604,7 @@ void timer_interrupt(struct pt_regs *regs)
 }
 EXPORT_SYMBOL(timer_interrupt);
 
+#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 void timer_broadcast_interrupt(void)
 {
 	u64 *next_tb = this_cpu_ptr(&decrementers_next_tb);
@@ -615,6 +616,7 @@ void timer_broadcast_interrupt(void)
 	__this_cpu_inc(irq_stat.timer_irqs_event);
 	trace_timer_interrupt_exit(regs);
 }
+#endif
 
 /*
  * Hypervisor decrementer interrupts shouldn't occur but are sometimes
-- 
2.16.1

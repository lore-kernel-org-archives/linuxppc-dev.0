Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 07F3F2C0082
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Jan 2014 17:11:45 +1100 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id s0E6BdWR024348
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Jan 2014 00:11:41 -0600
Message-ID: <1389679899.6933.10.camel@pasglop>
Subject: [PATCH] powerpc: Fix races with irq_work
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Date: Tue, 14 Jan 2014 17:11:39 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If we set irq_work on a processor and immediately afterward, before the
irq work has a chance to be processed, we change the decrementer value,
we can seriously delay the handling of that irq_work.

Fix it by checking in a few places for pending irq work, first before
changing the decrementer in decrementer_set_next_event() and after
changing it in the same function and in timer_interrupt().

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index afb1b56..b3dab20 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -536,6 +536,9 @@ void timer_interrupt(struct pt_regs * regs)
 		now = *next_tb - now;
 		if (now <= DECREMENTER_MAX)
 			set_dec((int)now);
+		/* We may have raced with new irq work */
+		if (test_irq_work_pending())
+			set_dec(1);
 		__get_cpu_var(irq_stat).timer_irqs_others++;
 	}
 
@@ -802,8 +805,16 @@ static void __init clocksource_init(void)
 static int decrementer_set_next_event(unsigned long evt,
 				      struct clock_event_device *dev)
 {
+	/* Don't adjust the decrementer if some irq work is pending */
+	if (test_irq_work_pending())
+		return 0;
 	__get_cpu_var(decrementers_next_tb) = get_tb_or_rtc() + evt;
 	set_dec(evt);
+
+	/* We may have raced with new irq work */
+	if (test_irq_work_pending())
+		set_dec(1);
+
 	return 0;
 }
 

Return-Path: <alistair@popple.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 613461A1A1E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Dec 2015 17:20:48 +1100 (AEDT)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@ozlabs.org,
	mpe@ellerman.id.au
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>, Daniel Axtens <dja@axtens.net>,
 Alistair Popple <alistair@popple.id.au>, stable@vger.kernel.org
Subject: [PATCH] powerpc/opal-irqchip: Fix deadlock introduced by "Fix double
 endian conversion"
Date: Fri, 18 Dec 2015 17:16:17 +1100
Message-Id: <1450419377-29847-1-git-send-email-alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 25642e1459ac ("powerpc/opal-irqchip: Fix double endian
conversion") fixed an endian bug by calling opal_handle_events() in
opal_event_unmask(). However this introduces a deadlock when an event
is active during unmasking as opal_handle_events() calls
generic_handle_irq() which may call opal_event_unmask() with the irq
descriptor lock held.

When generating multiple opal events in quick succession this would
lead to the following stall warnings:

EEH: Fenced PHB#0 detected, location: U78C9.001.WZS09XA-P1-C32
INFO: rcu_sched detected stalls on CPUs/tasks:

         12-...: (1 GPs behind) idle=68f/140000000000001/0 softirq=860/861 fqs=2065
         15-...: (1 GPs behind) idle=be5/140000000000001/0 softirq=1142/1143 fqs=2065
         (detected by 13, t=2102 jiffies, g=1325, c=1324, q=602)
NMI watchdog: BUG: soft lockup - CPU#18 stuck for 22s! [irqbalance:2696]
INFO: rcu_sched detected stalls on CPUs/tasks:
         12-...: (1 GPs behind) idle=68f/140000000000001/0 softirq=860/861 fqs=8371
         15-...: (1 GPs behind) idle=be5/140000000000001/0 softirq=1142/1143 fqs=8371
         (detected by 20, t=8407 jiffies, g=1325, c=1324, q=1290)

This patch corrects the problem by queuing the work if an event is
active during unmasking, which is similar to the pre-endian fix
behaviour.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
Reported-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: stable@vger.kernel.org
---

Michael,

I'm quite confident this fixes the problem as it is just reverting to
the previous behaviour only with the endian corrected, which was
really the correct fix in the first place. Thanks.

arch/powerpc/platforms/powernv/opal-irqchip.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal-irqchip.c b/arch/powerpc/platforms/powernv/opal-irqchip.c
index 0a00e2a..2f12cb9 100644
--- a/arch/powerpc/platforms/powernv/opal-irqchip.c
+++ b/arch/powerpc/platforms/powernv/opal-irqchip.c
@@ -83,7 +83,19 @@ static void opal_event_unmask(struct irq_data *d)
 	set_bit(d->hwirq, &opal_event_irqchip.mask);

 	opal_poll_events(&events);
-	opal_handle_events(be64_to_cpu(events));
+	last_outstanding_events = be64_to_cpu(events);
+
+	/*
+	 * We can't just handle the events now with
+	 * opal_handle_events() as opal_event_unmask() gets called
+	 * from generic_handle_irq() which holds the irq descriptor
+	 * lock leading to a deadlock if generic_handle_irq() gets
+	 * called again from opal_handle_events(). Instead queue the
+	 * events for later.
+	 */
+	if (last_outstanding_events & opal_event_irqchip.mask)
+		/* Need to retrigger the interrupt */
+		irq_work_queue(&opal_event_irq_work);
 }

 static int opal_event_set_type(struct irq_data *d, unsigned int flow_type)
--
2.1.4

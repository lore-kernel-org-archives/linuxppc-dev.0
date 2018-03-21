Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405YVT1mW9zF0mt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 13:22:40 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id l27so1435819pfk.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 19:22:40 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/64s: Fix lost pending interrupt due to race causing
 lost update to irq_happened
Date: Wed, 21 Mar 2018 12:22:28 +1000
Message-Id: <20180321022228.9606-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

force_external_irq_replay() can be called in the do_IRQ path with
interrupts hard enabled and soft disabled if may_hard_irq_enable() set
MSR[EE]=1. It updates local_paca->irq_happened with a load, modify,
store sequence. If a maskable interrupt hits during this sequence, it
will go to the masked handler to be marked pending in irq_happened.
This update will be lost when the interrupt returns and the store
instruction executes.  This can result in unpredictable latencies,
timeouts, lockups, etc.

Fix this by ensuring hard interrupts are disabled before modifying
irq_happened.

This could cause any maskable asynchronous interrupt to get lost, but
it was noticed on P9 SMP system doing RDMA NVMe target over 100GbE,
so very high external interrupt rate and high IPI rate. The hang was
bisected down to enabling doorbell interrupts for IPIs. These provided
an interrupt type that could run at high rates in the do_IRQ path,
stressing the race.

Fixes: 1d607bb3bd ("powerpc/irq: Add mechanism to force a replay of interrupts")
Reported-by: Carol L. Soto <clsoto@us.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

This has survived stress testing quite well so far, may need a little
more testing but I'd like to post it now to get some more comments.

We can optimise the mtmsr a bit more (e.g., skip it if interrupts are
already disabled or EE alrady set), but I've got some other patches
pending which change things there slightly, so I prefer to have this
minimal fix now, then make such changes upstream later.

---
 arch/powerpc/kernel/irq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index f88038847790..061aa0f47bb1 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -476,6 +476,14 @@ void force_external_irq_replay(void)
 	 */
 	WARN_ON(!arch_irqs_disabled());
 
+	/*
+	 * Interrupts must always be hard disabled before irq_happened is
+	 * modified (to prevent lost update in case of interrupt between
+	 * load and store).
+	 */
+	__hard_irq_disable();
+	local_paca->irq_happened |= PACA_IRQ_HARD_DIS;
+
 	/* Indicate in the PACA that we have an interrupt to replay */
 	local_paca->irq_happened |= PACA_IRQ_EE;
 }
-- 
2.16.1

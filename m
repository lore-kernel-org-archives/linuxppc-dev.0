Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yJw396XWfzDq5v
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Oct 2017 18:56:21 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id l24so8268976pgu.11
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Oct 2017 00:56:21 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] powerpc/64: Fix latency tracing for lazy irq replay
Date: Sat, 21 Oct 2017 17:56:06 +1000
Message-Id: <20171021075606.26814-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When returning from an exception to a soft-enabled context, pending
IRQs are replayed but IRQ tracing is not reset, so a number of them
can get chained together into the same IRQ-disabled trace.

Fix this by having __check_irq_replay re-set IRQ trace. This is
conceptually where we respond to the next interrupt, so it fits the
semantics of the IRQ tracer.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/irq.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index efbadcbbf694..df18085de8c4 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -138,6 +138,13 @@ notrace unsigned int __check_irq_replay(void)
 	 */
 	unsigned char happened = local_paca->irq_happened;
 
+	/*
+	 * We are responding to the next interrupt, so interrupt-off
+	 * latencies should be reset here.
+	 */
+	trace_hardirqs_on();
+	trace_hardirqs_off();
+
 	if (happened & PACA_IRQ_HARD_DIS) {
 		/* Clear bit 0 which we wouldn't clear otherwise */
 		local_paca->irq_happened &= ~PACA_IRQ_HARD_DIS;
@@ -292,6 +299,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 #endif /* CONFIG_TRACE_IRQFLAGS */
 
 	soft_disable_set(IRQS_DISABLED);
+	trace_hardirqs_off();
 
 	/*
 	 * Check if anything needs to be re-emitted. We haven't
@@ -301,6 +309,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 	replay = __check_irq_replay();
 
 	/* We can soft-enable now */
+	trace_hardirqs_on();
 	soft_disable_set(IRQS_ENABLED);
 
 	/*
-- 
2.13.3

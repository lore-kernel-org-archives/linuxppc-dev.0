Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y3HBH2DlfzDsQf
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 13:30:15 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id y192so118018pgd.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Sep 2017 20:30:15 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 5/6] powerpc/64s: Implement system reset idle wakeup reason
Date: Fri, 29 Sep 2017 13:29:41 +1000
Message-Id: <20170929032942.4321-6-npiggin@gmail.com>
In-Reply-To: <20170929032942.4321-1-npiggin@gmail.com>
References: <20170929032942.4321-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It is possible to wake from idle due to a system reset exception, in
which case the CPU takes a system reset interrupt to wake from idle,
with system reset as the wakeup reason.

The regular (not idle wakeup) system reset interrupt handler must be
invoked in this case, otherwise the system reset interrupt is lost.

Handle the system reset interrupt immediately after CPU state has been
restored.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/irq.c | 41 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 4e65bf82f5e0..4813b83b22aa 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -394,11 +394,19 @@ bool prep_irq_for_idle_irqsoff(void)
 /*
  * Take the SRR1 wakeup reason, index into this table to find the
  * appropriate irq_happened bit.
+ *
+ * Sytem reset exceptions taken in idle state also come through here,
+ * but they are NMI interrupts so do not need to wait for IRQs to be
+ * restored, and should be taken as early as practical. These are marked
+ * with 0xff in the table. The Power ISA specifies 0100b as the system
+ * reset interrupt reason.
  */
+#define IRQ_SYSTEM_RESET	0xff
+
 static const u8 srr1_to_lazyirq[0x10] = {
 	0, 0, 0,
 	PACA_IRQ_DBELL,
-	0,
+	IRQ_SYSTEM_RESET,
 	PACA_IRQ_DBELL,
 	PACA_IRQ_DEC,
 	0,
@@ -407,15 +415,42 @@ static const u8 srr1_to_lazyirq[0x10] = {
 	PACA_IRQ_HMI,
 	0, 0, 0, 0, 0 };
 
+static noinline void replay_system_reset(void)
+{
+	struct pt_regs regs;
+
+	ppc_save_regs(&regs);
+	regs.trap = 0x100;
+	get_paca()->in_nmi = 1;
+	system_reset_exception(&regs);
+	get_paca()->in_nmi = 0;
+}
+
 void irq_set_pending_from_srr1(unsigned long srr1)
 {
 	unsigned int idx = (srr1 & SRR1_WAKEMASK_P8) >> 18;
+	u8 reason = srr1_to_lazyirq[idx];
+
+	/*
+	 * Take the system reset now, which is immediately after registers
+	 * are restored from idle. It's an NMI, so interrupts need not be
+	 * re-enabled before it is taken.
+	 */
+	if (unlikely(reason == IRQ_SYSTEM_RESET)) {
+		replay_system_reset();
+		return;
+	}
 
 	/*
 	 * The 0 index (SRR1[42:45]=b0000) must always evaluate to 0,
-	 * so this can be called unconditionally with srr1 wake reason.
+	 * so this can be called unconditionally with the SRR1 wake
+	 * reason as returned by the idle code, which uses 0 to mean no
+	 * interrupt.
+	 *
+	 * If a future CPU was to designate this as an interrupt reason,
+	 * then a new index for no interrupt must be assigned.
 	 */
-	local_paca->irq_happened |= srr1_to_lazyirq[idx];
+	local_paca->irq_happened |= reason;
 }
 #endif /* CONFIG_PPC_BOOK3S */
 
-- 
2.13.3

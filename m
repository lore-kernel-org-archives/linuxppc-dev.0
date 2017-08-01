Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMHxy0j8qzDrHd
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Aug 2017 23:59:50 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id 72so2613180pfl.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Aug 2017 06:59:50 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] powerpc/64: Fix __check_irq_replay missing decrementer
 interrupt
Date: Tue,  1 Aug 2017 23:59:28 +1000
Message-Id: <20170801135928.22262-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If the decrementer wraps and de-asserts the decrementer exception while
hard-disabled, __check_irq_replay has a test to notice the wrap when
interrupts are re-enabled.

The decrementer check must be done when clearing the PACA_IRQ_HARD_DIS
flag, not when the PACA_IRQ_DEC flag is tested. Previously this worked
because the decrementer interrupt was always the first one checked after
clearing the hard disable flag, but HMI check was moved ahead of that,
which introduced this bug.

This can cause a missed decrementer interrupt if we soft-disable
interrupts then take an HMI which is recorded in irq_happened, then
hard-disable interrupts for > 4s to wrap the decrementer.

Fixes: e0e0d6b739 ("powerpc/64: Replay hypervisor maintenance interrupt first")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/irq.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 0bcec745a672..f291f7826abc 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -145,6 +145,19 @@ notrace unsigned int __check_irq_replay(void)
 
 	/* Clear bit 0 which we wouldn't clear otherwise */
 	local_paca->irq_happened &= ~PACA_IRQ_HARD_DIS;
+	if (happened & PACA_IRQ_HARD_DIS) {
+		/*
+		 * We may have missed a decrementer interrupt if hard disabled.
+		 * Check the decrementer register in case we had a rollover
+		 * while hard disabled.
+		 */
+		if (!(happened & PACA_IRQ_DEC)) {
+			if (decrementer_check_overflow()) {
+				local_paca->irq_happened |= PACA_IRQ_DEC;
+				happened |= PACA_IRQ_DEC;
+			}
+		}
+	}
 
 	/*
 	 * Force the delivery of pending soft-disabled interrupts on PS3.
@@ -170,7 +183,7 @@ notrace unsigned int __check_irq_replay(void)
 	 * in case we also had a rollover while hard disabled
 	 */
 	local_paca->irq_happened &= ~PACA_IRQ_DEC;
-	if ((happened & PACA_IRQ_DEC) || decrementer_check_overflow())
+	if (happened & PACA_IRQ_DEC)
 		return 0x900;
 
 	/* Finally check if an external interrupt happened */
-- 
2.11.0

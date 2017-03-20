Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vmmMC2Gg1zDqZY
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 17:32:07 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id b5so18200618pgg.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Mar 2017 23:32:07 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 2/2] powerpc/cbe: do not process external or decremeter
 interrupts from sreset
Date: Mon, 20 Mar 2017 16:31:49 +1000
Message-Id: <20170320063149.3068-3-npiggin@gmail.com>
In-Reply-To: <20170320063149.3068-1-npiggin@gmail.com>
References: <20170320063149.3068-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cell will wake from low power state at the system reset interrupt,
with the event encoded in SRR1, rather than waking at the interrupt
vector that corresponds to that event.

The system reset handler for this platform decodes SRR1 event reason
and calls the interrupt handler to process it directly from the system
reset handlre.

A subsequent change will treat the system reset interrupt as a Linux NMI
with its own per-CPU stack, and this will no longer work. Remove the
external and decrementer handlers from the system reset handler.

- The external exception remains raised and will fire again at the
  EE interrupt vector when system reset returns.

- The decrementer is set to 1 so it will be raised again and fire when
  the system reset returns.

It is possible to branch to an idle handler from the system reset
interrupt (like POWER does), then restore a normal stack and restore
this optimisation. But simplicity wins for now.

Tested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/cell/pervasive.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/cell/pervasive.c b/arch/powerpc/platforms/cell/pervasive.c
index e7d075077cb0..a88944db9fc3 100644
--- a/arch/powerpc/platforms/cell/pervasive.c
+++ b/arch/powerpc/platforms/cell/pervasive.c
@@ -88,11 +88,14 @@ static void cbe_power_save(void)
 static int cbe_system_reset_exception(struct pt_regs *regs)
 {
 	switch (regs->msr & SRR1_WAKEMASK) {
-	case SRR1_WAKEEE:
-		do_IRQ(regs);
-		break;
 	case SRR1_WAKEDEC:
-		timer_interrupt(regs);
+		set_dec(1);
+	case SRR1_WAKEEE:
+		/*
+		 * Handle these when interrupts get re-enabled and we take
+		 * them as regular exceptions. We are in an NMI context
+		 * and can't handle these here.
+		 */
 		break;
 	case SRR1_WAKEMT:
 		return cbe_sysreset_hack();
-- 
2.11.0

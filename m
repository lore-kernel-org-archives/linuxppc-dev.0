Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D79002C007E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 12:13:46 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r5F2DfGx026917
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jun 2013 21:13:42 -0500
Message-ID: <1371262420.21896.26.camel@pasglop>
Subject: [PATCH] powerpc: Fix missing/delayed calls to irq_work
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Sat, 15 Jun 2013 12:13:40 +1000
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

When replaying interrupts (as a result of the interrupt occurring
while soft-disabled), in the case of the decrementer, we are exclusively
testing for a pending timer target. However we also use decrementer
interrupts to trigger the new "irq_work", which in this case would
be missed.

This change the logic to force a replay in both cases of a timer
boundary reached and a decrementer interrupt having actually occurred
while disabled. The former test is still useful to catch cases where
a CPU having been hard-disabled for a long time completely misses the
interrupt due to a decrementer rollover.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 5cbcf4d..ea185e0 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -162,7 +162,7 @@ notrace unsigned int __check_irq_replay(void)
 	 * in case we also had a rollover while hard disabled
 	 */
 	local_paca->irq_happened &= ~PACA_IRQ_DEC;
-	if (decrementer_check_overflow())
+	if ((happened & PACA_IRQ_DEC) || decrementer_check_overflow())
 		return 0x900;
 
 	/* Finally check if an external interrupt happened */

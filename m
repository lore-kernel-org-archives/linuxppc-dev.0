Return-Path: <john.ogness@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 51C971A01D6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2015 01:15:09 +1100 (AEDT)
From: John Ogness <john.ogness@linutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ian Campbell <ian.campbell@citrix.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: IRQF_NO_SUSPEND not IRQF_TIMER for non-timer
Date: Wed, 11 Nov 2015 15:15:03 +0100
Message-ID: <87lha4fwrc.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since gpio1 is not a timer, it also should not use IRQF_TIMER.

Similar to commit ba461f094bab ("powerpc: Use IRQF_NO_SUSPEND not
IRQF_TIMER for non-timer interrupts").

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/macintosh/via-pmu.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index f9512bf..01ee736 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -425,8 +425,9 @@ static int __init via_pmu_start(void)
 			gpio_irq = irq_of_parse_and_map(gpio_node, 0);
 
 		if (gpio_irq != NO_IRQ) {
-			if (request_irq(gpio_irq, gpio1_interrupt, IRQF_TIMER,
-					"GPIO1 ADB", (void *)0))
+			if (request_irq(gpio_irq, gpio1_interrupt,
+					IRQF_NO_SUSPEND, "GPIO1 ADB",
+					(void *)0))
 				printk(KERN_ERR "pmu: can't get irq %d"
 				       " (GPIO1)\n", gpio_irq);
 			else
-- 
1.7.10.4

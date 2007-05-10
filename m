Return-Path: <benh@ozlabs.org>
To: <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 10 May 2007 15:25:59 +1000
Subject: [PATCH 3/3] stop_machine() now uses hard_irq_disable
Message-Id: <20070510052624.06AD7DDF2E@ozlabs.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Rusty Russell <rusty@rustcorp.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a call to hard_irq_disable() to stop_machine so that we make sure
IRQs are really disabled and not only lazy-disabled on archs like
powerpc as some users of stop_machine() may rely on that.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 kernel/stop_machine.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-cell/kernel/stop_machine.c
===================================================================
--- linux-cell.orig/kernel/stop_machine.c	2007-05-10 14:46:08.000000000 +1000
+++ linux-cell/kernel/stop_machine.c	2007-05-10 14:47:12.000000000 +1000
@@ -45,6 +45,7 @@ static int stopmachine(void *cpu)
 		if (stopmachine_state == STOPMACHINE_DISABLE_IRQ 
 		    && !irqs_disabled) {
 			local_irq_disable();
+			hard_irq_disable();
 			irqs_disabled = 1;
 			/* Ack: irqs disabled. */
 			smp_mb(); /* Must read state first. */
@@ -124,6 +125,7 @@ static int stop_machine(void)
 
 	/* Make them disable irqs. */
 	local_irq_disable();
+	hard_irq_disable();
 	stopmachine_set_state(STOPMACHINE_DISABLE_IRQ);
 
 	return 0;

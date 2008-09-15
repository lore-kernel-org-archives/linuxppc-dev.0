Return-Path: <sebastien.dugue@bull.net>
Received: from ecfrec.frec.bull.fr (ecfrec.frec.bull.fr [129.183.4.8])
	by ozlabs.org (Postfix) with ESMTP id C5254DE23C
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Sep 2008 18:04:16 +1000 (EST)
Date: Mon, 15 Sep 2008 10:04:06 +0200
From: Sebastien Dugue <sebastien.dugue@bull.net>
Subject: [PATCH HACK] powerpc: quick hack to get a functional eHEA with
	hardirq preemption
Message-ID: <20080915100406.342e027a@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: tklein@de.ibm.com, tinytim@us.ibm.com,
	Linux-rt <linux-rt-users@vger.kernel.org>, themann@de.ibm.com,
	netdev@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
	jean-pierre.dion@bull.net, linux-ppc <linuxppc-dev@ozlabs.org>,
	raisch@de.ibm.com, gilles.carry@ext.bull.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


WARNING: HACK - HACK - HACK

  Under the RT kernel (with hardirq preemption) the eHEA driver hangs right
after booting. Fiddling with the hardirqs and softirqs priorities allows to
run a bit longer but as soon as the network gets under load, the hang
returns. After investigating, it appears that the driver is loosing interrupts.

  To make a long story short, looking at the code, it appears that the XICS
maps all its interrupts to level sensitive interrupts (I don't know if it's the
reality or if it's due to an incomplete implementation - no datasheets
available to check) and use the fasteoi processing flow.

  When entering the low level handler, level sensitive interrupts are masked,
then eio'd in interrupt context and then unmasked at the end of hardirq
processing.
That's fine as any interrupt comming in-between will still be processed since
the kernel replays those pending interrupts.

  However, it appears that the eHEA interrupts are behaving as edge sensitive
interrupts and are routed through the XICS which process those as level
sensitive using the fasteoi handler __OR__ the XICS loses interrupts when they
are masked.

  Therefore the masking done in the handler causes any interrupt happening while
in the handler to be lost.

  So this patch maps the interrupts being requested through
ibmebus_request_irq() as edge sensitive interrupts (this concerns both the eHEA
and the eHCA - only users of ibmebus_request_irq()) and changes the way edge
interrupts are processed by the fasteoi handler.

  It works for the eHEA, dunno for the eHCA.

  So, unless all the designers of the XICS & eHEA have been shot to keep it
a secret, could someone knowledgeable shed some light on this issue.

  Thanks,

  Sebastien.

Not-Signed-off-by: Sebastien Dugue <sebastien.dugue@bull.net>
---
 arch/powerpc/kernel/ibmebus.c |   11 ++++++++++-
 kernel/irq/chip.c             |    5 +++--
 kernel/irq/manage.c           |    9 ++++++---
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/ibmebus.c b/arch/powerpc/kernel/ibmebus.c
index 9971159..5200323 100644
--- a/arch/powerpc/kernel/ibmebus.c
+++ b/arch/powerpc/kernel/ibmebus.c
@@ -41,6 +41,7 @@
 #include <linux/kobject.h>
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <asm/ibmebus.h>
@@ -213,11 +214,19 @@ int ibmebus_request_irq(u32 ist, irq_handler_t handler,
 			void *dev_id)
 {
 	unsigned int irq = irq_create_mapping(NULL, ist);
+	struct irq_desc *desc;
+	int ret;
 
 	if (irq == NO_IRQ)
 		return -EINVAL;
 
-	return request_irq(irq, handler, irq_flags, devname, dev_id);
+	ret = request_irq(irq, handler, irq_flags, devname, dev_id);
+
+	desc = irq_desc + irq;
+	desc->status &= ~(IRQ_TYPE_SENSE_MASK | IRQ_LEVEL);
+	desc->status |= IRQ_TYPE_EDGE_RISING;
+
+	return ret;
 }
 EXPORT_SYMBOL(ibmebus_request_irq);
 
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index b7b397a..6d366ca 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -430,7 +430,7 @@ handle_fasteoi_irq(unsigned int irq, struct irq_desc *desc)
 	action = desc->action;
 	if (unlikely(!action || (desc->status & (IRQ_INPROGRESS |
 						 IRQ_DISABLED)))) {
-		desc->status |= IRQ_PENDING;
+		desc->status |= IRQ_PENDING | IRQ_MASKED;
 		if (desc->chip->mask)
 			desc->chip->mask(irq);
 		goto out;
@@ -439,9 +439,10 @@ handle_fasteoi_irq(unsigned int irq, struct irq_desc *desc)
 	desc->status |= IRQ_INPROGRESS;
 	/*
 	 * In the threaded case we fall back to a mask+eoi sequence:
+	 * excepted for edge interrupts which are not masked.
 	 */
 	if (redirect_hardirq(desc)) {
-		if (desc->chip->mask)
+		if (desc->chip->mask && !(desc->status & IRQ_TYPE_EDGE_BOTH))
 			desc->chip->mask(irq);
 		goto out;
 	}
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 3bffa20..3e39c71 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -788,9 +788,12 @@ static void do_hardirq(struct irq_desc *desc)
 		thread_simple_irq(desc);
 	else if (desc->handle_irq == handle_level_irq)
 		thread_level_irq(desc);
-	else if (desc->handle_irq == handle_fasteoi_irq)
-		thread_fasteoi_irq(desc);
-	else if (desc->handle_irq == handle_edge_irq)
+	else if (desc->handle_irq == handle_fasteoi_irq) {
+		if (desc->status & IRQ_TYPE_EDGE_BOTH)
+			thread_edge_irq(desc);
+		else
+			thread_fasteoi_irq(desc);
+	} else if (desc->handle_irq == handle_edge_irq)
 		thread_edge_irq(desc);
 	else
 		thread_do_irq(desc);
-- 
1.6.0.1.308.gede4c

Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 3A514DDE99
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 00:32:45 +1000 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id C37778810
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 19:32:43 +0500 (SAMST)
Date: Tue, 25 Sep 2007 18:34:35 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/7] [POWERPC] QEIC: implement low+high multiplexed IRQ
	chained handler
Message-ID: <20070925143435.GC5323@localhost.localdomain>
References: <20070925143126.GA30013@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20070925143126.GA30013@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For MPC8568E low and high QEIC lines routed to the single MPIC
input, thus low and high sources should be demultiplexed.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/sysdev/qe_lib/qe_ic.c |   34 ++++++++++++++++++++++++++++------
 1 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.c b/arch/powerpc/sysdev/qe_lib/qe_ic.c
index 8e743e0..0ecb614 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_ic.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_ic.c
@@ -345,6 +345,22 @@ void qe_ic_cascade_high(unsigned int irq, struct irq_desc *desc)
 		desc->chip->end(irq);
 }
 
+static void qe_ic_cascade_muxed(unsigned int irq, struct irq_desc *desc)
+{
+	struct qe_ic *qe_ic = desc->handler_data;
+	unsigned int cascade_irq;
+
+	cascade_irq = qe_ic_get_high_irq(qe_ic);
+	if (cascade_irq == NO_IRQ)
+		cascade_irq = qe_ic_get_low_irq(qe_ic);
+
+	if (cascade_irq != NO_IRQ)
+		generic_handle_irq(cascade_irq);
+
+	if (desc->chip->end)
+		desc->chip->end(irq);
+}
+
 void __init qe_ic_init(struct device_node *node, unsigned int flags)
 {
 	struct qe_ic *qe_ic;
@@ -404,12 +420,18 @@ void __init qe_ic_init(struct device_node *node, unsigned int flags)
 
 	qe_ic_write(qe_ic->regs, QEIC_CICR, temp);
 
-	set_irq_data(qe_ic->virq_low, qe_ic);
-	set_irq_chained_handler(qe_ic->virq_low, qe_ic_cascade_low);
-
-	if (qe_ic->virq_high != NO_IRQ) {
-		set_irq_data(qe_ic->virq_high, qe_ic);
-		set_irq_chained_handler(qe_ic->virq_high, qe_ic_cascade_high);
+	if (qe_ic->virq_high == qe_ic->virq_low) {
+		set_irq_data(qe_ic->virq_low, qe_ic);
+		set_irq_chained_handler(qe_ic->virq_low, qe_ic_cascade_muxed);
+	} else {
+		set_irq_data(qe_ic->virq_low, qe_ic);
+		set_irq_chained_handler(qe_ic->virq_low, qe_ic_cascade_low);
+
+		if (qe_ic->virq_high != NO_IRQ) {
+			set_irq_data(qe_ic->virq_high, qe_ic);
+			set_irq_chained_handler(qe_ic->virq_high,
+						qe_ic_cascade_high);
+		}
 	}
 
 	printk("QEIC (%d IRQ sources) at %p\n", NR_QE_IC_INTS, qe_ic->regs);
-- 
1.5.0.6

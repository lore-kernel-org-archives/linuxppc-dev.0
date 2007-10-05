Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id A0C48DE2A3
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Oct 2007 03:46:39 +1000 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 21B8D8810
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Oct 2007 22:46:37 +0500 (SAMST)
Date: Fri, 5 Oct 2007 21:47:29 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/7] [POWERPC] QEIC: Implement pluggable handlers, fix MPIC
	cascading
Message-ID: <20071005174729.GF32145@localhost.localdomain>
References: <20071005174015.GA11016@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071005174015.GA11016@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

set_irq_chained_handler overwrites MPIC's handle_irq function
(handle_fasteoi_irq) thus MPIC never gets eoi event from the
cascaded IRQ. This situation hangs MPIC on MPC8568E.

To solve this problem efficiently, QEIC needs pluggable handlers,
specific to the underlaying interrupt controller.

Patch extends qe_ic_init() function to accept low and high interrupt
handlers. To avoid #ifdefs, stack of interrupt handlers specified in
the header file and functions are marked 'static inline', thus
handlers are compiled-in only if actually used (in the board file).
Another option would be to lookup for parent controller and
automatically detect handlers (will waste text size because of
never used handlers, so this option abolished).

qe_ic_init() also changed in regard to support multiplexed high/low
lines as found in MPC8568E-MDS, plus qe_ic_cascade_muxed_mpic()
handler implemented appropriately.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/83xx/mpc832x_mds.c |    2 +-
 arch/powerpc/platforms/83xx/mpc832x_rdb.c |    2 +-
 arch/powerpc/platforms/83xx/mpc836x_mds.c |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |    2 +-
 arch/powerpc/sysdev/qe_lib/qe_ic.c        |   29 +++---------
 include/asm-powerpc/qe_ic.h               |   68 ++++++++++++++++++++++++++++-
 6 files changed, 78 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
index b8d8c91..972fa85 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -140,7 +140,7 @@ static void __init mpc832x_sys_init_IRQ(void)
 	if (!np)
 		return;
 
-	qe_ic_init(np, 0);
+	qe_ic_init(np, 0, qe_ic_cascade_low_ipic, qe_ic_cascade_high_ipic);
 	of_node_put(np);
 #endif				/* CONFIG_QUICC_ENGINE */
 }
diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index 4da0698..fbca336 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -151,7 +151,7 @@ void __init mpc832x_rdb_init_IRQ(void)
 	if (!np)
 		return;
 
-	qe_ic_init(np, 0);
+	qe_ic_init(np, 0, qe_ic_cascade_low_ipic, qe_ic_cascade_high_ipic);
 	of_node_put(np);
 #endif				/* CONFIG_QUICC_ENGINE */
 }
diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platforms/83xx/mpc836x_mds.c
index 0b18a75..0f3855c 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -147,7 +147,7 @@ static void __init mpc836x_mds_init_IRQ(void)
 	if (!np)
 		return;
 
-	qe_ic_init(np, 0);
+	qe_ic_init(np, 0, qe_ic_cascade_low_ipic, qe_ic_cascade_high_ipic);
 	of_node_put(np);
 #endif				/* CONFIG_QUICC_ENGINE */
 }
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 00f4c3a..57e840a 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -180,7 +180,7 @@ static void __init mpc85xx_mds_pic_init(void)
 	if (!np)
 		return;
 
-	qe_ic_init(np, 0);
+	qe_ic_init(np, 0, qe_ic_cascade_muxed_mpic, NULL);
 	of_node_put(np);
 #endif				/* CONFIG_QUICC_ENGINE */
 }
diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.c b/arch/powerpc/sysdev/qe_lib/qe_ic.c
index 9a2d1ed..e1c0fd6 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_ic.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_ic.c
@@ -321,25 +321,9 @@ unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
 	return irq_linear_revmap(qe_ic->irqhost, irq);
 }
 
-void qe_ic_cascade_low(unsigned int irq, struct irq_desc *desc)
-{
-	struct qe_ic *qe_ic = desc->handler_data;
-	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
-
-	if (cascade_irq != NO_IRQ)
-		generic_handle_irq(cascade_irq);
-}
-
-void qe_ic_cascade_high(unsigned int irq, struct irq_desc *desc)
-{
-	struct qe_ic *qe_ic = desc->handler_data;
-	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
-
-	if (cascade_irq != NO_IRQ)
-		generic_handle_irq(cascade_irq);
-}
-
-void __init qe_ic_init(struct device_node *node, unsigned int flags)
+void __init qe_ic_init(struct device_node *node, unsigned int flags,
+		void (*low_handler)(unsigned int irq, struct irq_desc *desc),
+		void (*high_handler)(unsigned int irq, struct irq_desc *desc))
 {
 	struct qe_ic *qe_ic;
 	struct resource res;
@@ -399,11 +383,12 @@ void __init qe_ic_init(struct device_node *node, unsigned int flags)
 	qe_ic_write(qe_ic->regs, QEIC_CICR, temp);
 
 	set_irq_data(qe_ic->virq_low, qe_ic);
-	set_irq_chained_handler(qe_ic->virq_low, qe_ic_cascade_low);
+	set_irq_chained_handler(qe_ic->virq_low, low_handler);
 
-	if (qe_ic->virq_high != NO_IRQ) {
+	if (qe_ic->virq_high != NO_IRQ &&
+			qe_ic->virq_high != qe_ic->virq_low) {
 		set_irq_data(qe_ic->virq_high, qe_ic);
-		set_irq_chained_handler(qe_ic->virq_high, qe_ic_cascade_high);
+		set_irq_chained_handler(qe_ic->virq_high, high_handler);
 	}
 }
 
diff --git a/include/asm-powerpc/qe_ic.h b/include/asm-powerpc/qe_ic.h
index e386fb7..a779b2c 100644
--- a/include/asm-powerpc/qe_ic.h
+++ b/include/asm-powerpc/qe_ic.h
@@ -56,9 +56,75 @@ enum qe_ic_grp_id {
 	QE_IC_GRP_RISCB		/* QE interrupt controller RISC group B */
 };
 
-void qe_ic_init(struct device_node *node, unsigned int flags);
+void qe_ic_init(struct device_node *node, unsigned int flags,
+		void (*low_handler)(unsigned int irq, struct irq_desc *desc),
+		void (*high_handler)(unsigned int irq, struct irq_desc *desc));
 void qe_ic_set_highest_priority(unsigned int virq, int high);
 int qe_ic_set_priority(unsigned int virq, unsigned int priority);
 int qe_ic_set_high_priority(unsigned int virq, unsigned int priority, int high);
 
+struct qe_ic;
+unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic);
+unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic);
+
+static inline void qe_ic_cascade_low_ipic(unsigned int irq,
+					  struct irq_desc *desc)
+{
+	struct qe_ic *qe_ic = desc->handler_data;
+	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
+
+	if (cascade_irq != NO_IRQ)
+		generic_handle_irq(cascade_irq);
+}
+
+static inline void qe_ic_cascade_high_ipic(unsigned int irq,
+					   struct irq_desc *desc)
+{
+	struct qe_ic *qe_ic = desc->handler_data;
+	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
+
+	if (cascade_irq != NO_IRQ)
+		generic_handle_irq(cascade_irq);
+}
+
+static inline void qe_ic_cascade_low_mpic(unsigned int irq,
+					  struct irq_desc *desc)
+{
+	struct qe_ic *qe_ic = desc->handler_data;
+	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
+
+	if (cascade_irq != NO_IRQ)
+		generic_handle_irq(cascade_irq);
+
+	desc->chip->eoi(irq);
+}
+
+static inline void qe_ic_cascade_high_mpic(unsigned int irq,
+					   struct irq_desc *desc)
+{
+	struct qe_ic *qe_ic = desc->handler_data;
+	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
+
+	if (cascade_irq != NO_IRQ)
+		generic_handle_irq(cascade_irq);
+
+	desc->chip->eoi(irq);
+}
+
+static inline void qe_ic_cascade_muxed_mpic(unsigned int irq,
+					    struct irq_desc *desc)
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
+	desc->chip->eoi(irq);
+}
+
 #endif /* _ASM_POWERPC_QE_IC_H */
-- 
1.5.0.6

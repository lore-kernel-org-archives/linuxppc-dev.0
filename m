Return-Path: <qiang.zhao@nxp.com>
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on0084.outbound.protection.outlook.com [104.47.38.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3skNgc4czXzDrYf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 13:37:32 +1000 (AEST)
From: Zhao Qiang <qiang.zhao@nxp.com>
To: <oss@buserror.net>, <tglx@linutronix.de>
CC: <jason@lakedaemon.net>, <marc.zyngier@arm.com>, <xiaobo.xie@nxp.com>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>, Zhao Qiang
 <qiang.zhao@nxp.com>
Subject: [PATCH v6 4/4] irqchip/qeic: remove PPCisms for QEIC
Date: Wed, 28 Sep 2016 11:25:03 +0800
Message-ID: <1475033103-18192-4-git-send-email-qiang.zhao@nxp.com>
In-Reply-To: <1475033103-18192-1-git-send-email-qiang.zhao@nxp.com>
References: <1475033103-18192-1-git-send-email-qiang.zhao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

QEIC was supported on PowerPC, and dependent on PPC,
Now it is supported on other platforms, so remove PPCisms.

Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
Changes for v6:
	- new added

 drivers/irqchip/irq-qeic.c | 28 +++++++++++++++++-----------
 include/soc/fsl/qe/qe_ic.h | 12 ++++++------
 2 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/irq-qeic.c b/drivers/irqchip/irq-qeic.c
index 4f49d4b..98a8b38 100644
--- a/drivers/irqchip/irq-qeic.c
+++ b/drivers/irqchip/irq-qeic.c
@@ -18,7 +18,10 @@
 #include <linux/of_address.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/irqdomain.h>
 #include <linux/errno.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/reboot.h>
 #include <linux/slab.h>
 #include <linux/stddef.h>
@@ -266,13 +269,13 @@ static struct qe_ic_info qe_ic_info[] = {
 
 static inline u32 qe_ic_read(volatile __be32  __iomem * base, unsigned int reg)
 {
-	return in_be32(base + (reg >> 2));
+	return ioread32be(base + (reg >> 2));
 }
 
 static inline void qe_ic_write(volatile __be32  __iomem * base, unsigned int reg,
 			       u32 value)
 {
-	out_be32(base + (reg >> 2), value);
+	iowrite32be(value, base + (reg >> 2));
 }
 
 static inline struct qe_ic *qe_ic_from_irq(unsigned int virq)
@@ -374,7 +377,7 @@ static const struct irq_domain_ops qe_ic_host_ops = {
 	.xlate = irq_domain_xlate_onetwocell,
 };
 
-/* Return an interrupt vector or NO_IRQ if no interrupt is pending. */
+/* Return an interrupt vector or 0 if no interrupt is pending. */
 unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic)
 {
 	int irq;
@@ -385,12 +388,12 @@ unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic)
 	irq = qe_ic_read(qe_ic->regs, QEIC_CIVEC) >> 26;
 
 	if (irq == 0)
-		return NO_IRQ;
+		return 0;
 
 	return irq_linear_revmap(qe_ic->irqhost, irq);
 }
 
-/* Return an interrupt vector or NO_IRQ if no interrupt is pending. */
+/* Return an interrupt vector or 0 if no interrupt is pending. */
 unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
 {
 	int irq;
@@ -401,7 +404,7 @@ unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
 	irq = qe_ic_read(qe_ic->regs, QEIC_CHIVEC) >> 26;
 
 	if (irq == 0)
-		return NO_IRQ;
+		return 0;
 
 	return irq_linear_revmap(qe_ic->irqhost, irq);
 }
@@ -447,7 +450,7 @@ static int __init qe_ic_init(unsigned int flags)
 	qe_ic->virq_high = irq_of_parse_and_map(node, 0);
 	qe_ic->virq_low = irq_of_parse_and_map(node, 1);
 
-	if (qe_ic->virq_low == NO_IRQ) {
+	if (qe_ic->virq_low == 0) {
 		pr_err("Failed to map QE_IC low IRQ\n");
 		ret = -ENOMEM;
 		goto err_domain_remove;
@@ -479,7 +482,7 @@ static int __init qe_ic_init(unsigned int flags)
 	irq_set_handler_data(qe_ic->virq_low, qe_ic);
 	irq_set_chained_handler(qe_ic->virq_low, qe_ic_cascade_low_mpic);
 
-	if (qe_ic->virq_high != NO_IRQ &&
+	if (qe_ic->virq_high != 0 &&
 			qe_ic->virq_high != qe_ic->virq_low) {
 		irq_set_handler_data(qe_ic->virq_high, qe_ic);
 		irq_set_chained_handler(qe_ic->virq_high,
@@ -500,7 +503,8 @@ err_put_node:
 void qe_ic_set_highest_priority(unsigned int virq, int high)
 {
 	struct qe_ic *qe_ic = qe_ic_from_irq(virq);
-	unsigned int src = virq_to_hw(virq);
+	struct irq_data *irq_data = irq_get_irq_data(virq);
+	irq_hw_number_t src = WARN_ON(!irq_data) ? 0 : irq_data->hwirq;
 	u32 temp = 0;
 
 	temp = qe_ic_read(qe_ic->regs, QEIC_CICR);
@@ -518,7 +522,8 @@ void qe_ic_set_highest_priority(unsigned int virq, int high)
 int qe_ic_set_priority(unsigned int virq, unsigned int priority)
 {
 	struct qe_ic *qe_ic = qe_ic_from_irq(virq);
-	unsigned int src = virq_to_hw(virq);
+	struct irq_data *irq_data = irq_get_irq_data(virq);
+	irq_hw_number_t src = WARN_ON(!irq_data) ? 0 : irq_data->hwirq;
 	u32 temp;
 
 	if (priority > 8 || priority == 0)
@@ -548,7 +553,8 @@ int qe_ic_set_priority(unsigned int virq, unsigned int priority)
 int qe_ic_set_high_priority(unsigned int virq, unsigned int priority, int high)
 {
 	struct qe_ic *qe_ic = qe_ic_from_irq(virq);
-	unsigned int src = virq_to_hw(virq);
+	struct irq_data *irq_data = irq_get_irq_data(virq);
+	irq_hw_number_t src = WARN_ON(!irq_data) ? 0 : irq_data->hwirq;
 	u32 temp, control_reg = QEIC_CICNR, shift = 0;
 
 	if (priority > 2 || priority == 0)
diff --git a/include/soc/fsl/qe/qe_ic.h b/include/soc/fsl/qe/qe_ic.h
index 6113699..863cfec 100644
--- a/include/soc/fsl/qe/qe_ic.h
+++ b/include/soc/fsl/qe/qe_ic.h
@@ -76,7 +76,7 @@ static inline void qe_ic_cascade_low_ipic(struct irq_desc *desc)
 	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
 	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
 
-	if (cascade_irq != NO_IRQ)
+	if (cascade_irq != 0)
 		generic_handle_irq(cascade_irq);
 }
 
@@ -85,7 +85,7 @@ static inline void qe_ic_cascade_high_ipic(struct irq_desc *desc)
 	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
 	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
 
-	if (cascade_irq != NO_IRQ)
+	if (cascade_irq != 0)
 		generic_handle_irq(cascade_irq);
 }
 
@@ -95,7 +95,7 @@ static inline void qe_ic_cascade_low_mpic(struct irq_desc *desc)
 	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 
-	if (cascade_irq != NO_IRQ)
+	if (cascade_irq != 0)
 		generic_handle_irq(cascade_irq);
 
 	chip->irq_eoi(&desc->irq_data);
@@ -107,7 +107,7 @@ static inline void qe_ic_cascade_high_mpic(struct irq_desc *desc)
 	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 
-	if (cascade_irq != NO_IRQ)
+	if (cascade_irq != 0)
 		generic_handle_irq(cascade_irq);
 
 	chip->irq_eoi(&desc->irq_data);
@@ -120,10 +120,10 @@ static inline void qe_ic_cascade_muxed_mpic(struct irq_desc *desc)
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 
 	cascade_irq = qe_ic_get_high_irq(qe_ic);
-	if (cascade_irq == NO_IRQ)
+	if (cascade_irq == 0)
 		cascade_irq = qe_ic_get_low_irq(qe_ic);
 
-	if (cascade_irq != NO_IRQ)
+	if (cascade_irq != 0)
 		generic_handle_irq(cascade_irq);
 
 	chip->irq_eoi(&desc->irq_data);
-- 
2.1.0.27.g96db324

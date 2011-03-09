Return-Path: <buytenh@wantstofly.org>
Received: from mail.wantstofly.org (fw.wantstofly.org [80.101.37.227])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ED2E51008C2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Mar 2011 19:27:05 +1100 (EST)
Date: Wed, 9 Mar 2011 09:27:00 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2 23/28] powerpc: sysdev/qe_lib/qe_ic irq_data conversion.
Message-ID: <20110309082700.GS16649@mail.wantstofly.org>
References: <cover.1299541392.git.buytenh@wantstofly.org>
	<20110308000010.GB16649@mail.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110308000010.GB16649@mail.wantstofly.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
v2: get_irq_chip_data(d->irq) => irq_data_get_irq_chip_data(d)

 arch/powerpc/include/asm/qe_ic.h   |   19 +++++++++++--------
 arch/powerpc/sysdev/qe_lib/qe_ic.c |   25 +++++++++++++++----------
 2 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/qe_ic.h b/arch/powerpc/include/asm/qe_ic.h
index cf51966..9e2cb20 100644
--- a/arch/powerpc/include/asm/qe_ic.h
+++ b/arch/powerpc/include/asm/qe_ic.h
@@ -81,7 +81,7 @@ int qe_ic_set_high_priority(unsigned int virq, unsigned int priority, int high);
 static inline void qe_ic_cascade_low_ipic(unsigned int irq,
 					  struct irq_desc *desc)
 {
-	struct qe_ic *qe_ic = desc->handler_data;
+	struct qe_ic *qe_ic = get_irq_desc_data(desc);
 	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
 
 	if (cascade_irq != NO_IRQ)
@@ -91,7 +91,7 @@ static inline void qe_ic_cascade_low_ipic(unsigned int irq,
 static inline void qe_ic_cascade_high_ipic(unsigned int irq,
 					   struct irq_desc *desc)
 {
-	struct qe_ic *qe_ic = desc->handler_data;
+	struct qe_ic *qe_ic = get_irq_desc_data(desc);
 	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
 
 	if (cascade_irq != NO_IRQ)
@@ -101,32 +101,35 @@ static inline void qe_ic_cascade_high_ipic(unsigned int irq,
 static inline void qe_ic_cascade_low_mpic(unsigned int irq,
 					  struct irq_desc *desc)
 {
-	struct qe_ic *qe_ic = desc->handler_data;
+	struct qe_ic *qe_ic = get_irq_desc_data(desc);
 	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 
 	if (cascade_irq != NO_IRQ)
 		generic_handle_irq(cascade_irq);
 
-	desc->chip->eoi(irq);
+	chip->irq_eoi(&desc->irq_data);
 }
 
 static inline void qe_ic_cascade_high_mpic(unsigned int irq,
 					   struct irq_desc *desc)
 {
-	struct qe_ic *qe_ic = desc->handler_data;
+	struct qe_ic *qe_ic = get_irq_desc_data(desc);
 	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 
 	if (cascade_irq != NO_IRQ)
 		generic_handle_irq(cascade_irq);
 
-	desc->chip->eoi(irq);
+	chip->irq_eoi(&desc->irq_data);
 }
 
 static inline void qe_ic_cascade_muxed_mpic(unsigned int irq,
 					    struct irq_desc *desc)
 {
-	struct qe_ic *qe_ic = desc->handler_data;
+	struct qe_ic *qe_ic = get_irq_desc_data(desc);
 	unsigned int cascade_irq;
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 
 	cascade_irq = qe_ic_get_high_irq(qe_ic);
 	if (cascade_irq == NO_IRQ)
@@ -135,7 +138,7 @@ static inline void qe_ic_cascade_muxed_mpic(unsigned int irq,
 	if (cascade_irq != NO_IRQ)
 		generic_handle_irq(cascade_irq);
 
-	desc->chip->eoi(irq);
+	chip->irq_eoi(&desc->irq_data);
 }
 
 #endif /* _ASM_POWERPC_QE_IC_H */
diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.c b/arch/powerpc/sysdev/qe_lib/qe_ic.c
index 541ba98..8c9ded8 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_ic.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_ic.c
@@ -189,15 +189,20 @@ static inline void qe_ic_write(volatile __be32  __iomem * base, unsigned int reg
 
 static inline struct qe_ic *qe_ic_from_irq(unsigned int virq)
 {
-	return irq_to_desc(virq)->chip_data;
+	return get_irq_chip_data(virq);
+}
+
+static inline struct qe_ic *qe_ic_from_irq_data(struct irq_data *d)
+{
+	return irq_data_get_irq_chip_data(d);
 }
 
 #define virq_to_hw(virq)	((unsigned int)irq_map[virq].hwirq)
 
-static void qe_ic_unmask_irq(unsigned int virq)
+static void qe_ic_unmask_irq(struct irq_data *d)
 {
-	struct qe_ic *qe_ic = qe_ic_from_irq(virq);
-	unsigned int src = virq_to_hw(virq);
+	struct qe_ic *qe_ic = qe_ic_from_irq_data(d);
+	unsigned int src = virq_to_hw(d->irq);
 	unsigned long flags;
 	u32 temp;
 
@@ -210,10 +215,10 @@ static void qe_ic_unmask_irq(unsigned int virq)
 	raw_spin_unlock_irqrestore(&qe_ic_lock, flags);
 }
 
-static void qe_ic_mask_irq(unsigned int virq)
+static void qe_ic_mask_irq(struct irq_data *d)
 {
-	struct qe_ic *qe_ic = qe_ic_from_irq(virq);
-	unsigned int src = virq_to_hw(virq);
+	struct qe_ic *qe_ic = qe_ic_from_irq_data(d);
+	unsigned int src = virq_to_hw(d->irq);
 	unsigned long flags;
 	u32 temp;
 
@@ -238,9 +243,9 @@ static void qe_ic_mask_irq(unsigned int virq)
 
 static struct irq_chip qe_ic_irq_chip = {
 	.name = "QEIC",
-	.unmask = qe_ic_unmask_irq,
-	.mask = qe_ic_mask_irq,
-	.mask_ack = qe_ic_mask_irq,
+	.irq_unmask = qe_ic_unmask_irq,
+	.irq_mask = qe_ic_mask_irq,
+	.irq_mask_ack = qe_ic_mask_irq,
 };
 
 static int qe_ic_host_match(struct irq_host *h, struct device_node *node)
-- 
1.7.4

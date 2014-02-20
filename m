Return-Path: <bigeasy@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DADF32C0316
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Feb 2014 07:53:18 +1100 (EST)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/2] irqdomain: add support for creating a continous mapping
Date: Thu, 20 Feb 2014 21:53:09 +0100
Message-Id: <1392929590-12888-2-git-send-email-bigeasy@linutronix.de>
In-Reply-To: <1392929590-12888-1-git-send-email-bigeasy@linutronix.de>
References: <1392929590-12888-1-git-send-email-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Scott Wood <scottwood@freescale.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A MSI device may have multiple interrupts. That means that the
interrupts numbers should be continuos so that pdev->irq refers to the
first interrupt, pdev->irq + 1 to the second and so on.
This patch adds support for continuous allocation of virqs for a range
of hwirqs. The function is based on irq_create_mapping() but due to the
number argument there is very little in common now.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/irqdomain.h |  2 ++
 kernel/irq/irqdomain.c    | 61 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index c983ed1..21d0635 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -175,6 +175,8 @@ extern void irq_domain_associate_many(struct irq_domain *domain,
 
 extern unsigned int irq_create_mapping(struct irq_domain *host,
 				       irq_hw_number_t hwirq);
+extern unsigned int irq_create_mapping_block(struct irq_domain *host,
+		irq_hw_number_t hwirq, unsigned int num);
 extern void irq_dispose_mapping(unsigned int virq);
 
 /**
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index cf68bb3..323d417 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -433,6 +433,67 @@ unsigned int irq_create_mapping(struct irq_domain *domain,
 EXPORT_SYMBOL_GPL(irq_create_mapping);
 
 /**
+ * irq_create_mapping_block() - Map multiple hardware interrupts
+ * @domain: domain owning this hardware interrupt or NULL for default domain
+ * @hwirq: hardware irq number in that domain space
+ * @num: number of interrupts
+ *
+ * Maps a hwirq to a newly allocated virq. Num should be greater than 1 so num
+ * hwirqs (hwirq … hwirq + num - 1) will be mapped which and virq will be
+ * continuous. Returns the first linux virq number.
+ *
+ * If the sense/trigger is to be specified, set_irq_type() should be called
+ * on the number returned from that call.
+ */
+unsigned int irq_create_mapping_block(struct irq_domain *domain,
+		irq_hw_number_t hwirq, unsigned int num)
+{
+	int virq;
+	int i;
+
+	pr_debug("%s(0x%p, 0x%lx) %d\n", __func__, domain, hwirq, num);
+
+	if (num < 2)
+		return 0;
+
+	/* Look for default domain if nececssary */
+	if (domain == NULL) {
+		WARN(1, "%s(, %lx) called with NULL domain\n", __func__, hwirq);
+		return 0;
+	}
+	for (i = 0; i < num; i++) {
+		/* Check if mapping already exists */
+		virq = irq_find_mapping(domain, hwirq);
+		if (virq != NO_IRQ) {
+			if (i == 0) {
+				pr_debug("-> existing mapping on virq %d\n",
+						virq);
+				return virq;
+			}
+			pr_err("irq: hwirq %ld has no mapping but hwirq %ld "
+				"maps to virq %d. This can't be a block\n",
+				hwirq, hwirq + i, virq);
+			return -EINVAL;
+		}
+	}
+
+	/* Allocate a virtual interrupt number */
+	virq = irq_alloc_descs_from(1, num, of_node_to_nid(domain->of_node));
+	if (virq <= 0) {
+		pr_debug("-> virq allocation failed\n");
+		return 0;
+	}
+
+	irq_domain_associate_many(domain, virq, hwirq, num);
+
+	pr_debug("irqs %lu…%lu on domain %s mapped to virtual irqs %u…%u\n",
+		hwirq, hwirq + num - 1, of_node_full_name(domain->of_node),
+		virq, virq + num - 1);
+
+	return virq;
+}
+
+/**
  * irq_create_strict_mappings() - Map a range of hw irqs to fixed linux irqs
  * @domain: domain owning the interrupt range
  * @irq_base: beginning of linux IRQ range
-- 
1.9.0.rc3

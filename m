Return-Path: <bigeasy@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1978C2C032B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Feb 2014 19:57:42 +1100 (EST)
Date: Fri, 21 Feb 2014 09:57:36 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Scott Wood <scottwood@freescale.com>
Subject: [PATCH 1/2 v2] irqdomain: add support for creating a continous mapping
Message-ID: <20140221085736.GA11411@linutronix.de>
References: <1392929590-12888-1-git-send-email-bigeasy@linutronix.de>
 <1392929590-12888-2-git-send-email-bigeasy@linutronix.de>
 <1392930384.6733.842.camel@snotra.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1392930384.6733.842.camel@snotra.buserror.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
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
Scott, this is what you suggested. I must admit, it does not look that
bad. It is just compile tested.

v1.v2:
    - use irq_create_mapping_block() for irq_create_mapping()

 include/linux/irqdomain.h | 10 ++++--
 kernel/irq/irqdomain.c    | 87 ++++++++++++++++++++++++++++++++++---------=
----
 2 files changed, 72 insertions(+), 25 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index c983ed1..8b09a6b 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -171,12 +171,18 @@ extern int irq_domain_associate(struct irq_domain *do=
main, unsigned int irq,
 					irq_hw_number_t hwirq);
 extern void irq_domain_associate_many(struct irq_domain *domain,
 				      unsigned int irq_base,
 				      irq_hw_number_t hwirq_base, int count);
=20
-extern unsigned int irq_create_mapping(struct irq_domain *host,
-				       irq_hw_number_t hwirq);
+extern unsigned int irq_create_mapping_block(struct irq_domain *host,
+		irq_hw_number_t hwirq, unsigned int num);
+static inline unsigned int irq_create_mapping(struct irq_domain *host,
+		irq_hw_number_t hwirq)
+{
+	return irq_create_mapping_block(host, hwirq, 1);
+}
+
 extern void irq_dispose_mapping(unsigned int virq);
=20
 /**
  * irq_linear_revmap() - Find a linux irq from a hw irq number.
  * @domain: domain owning this hardware interrupt
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index cf68bb3..cdc6627 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -372,67 +372,108 @@ unsigned int irq_create_direct_mapping(struct irq_do=
main *domain)
=20
 	return virq;
 }
 EXPORT_SYMBOL_GPL(irq_create_direct_mapping);
=20
+static int irq_check_continuous_mapping(struct irq_domain *domain,
+		irq_hw_number_t hwirq, unsigned int num)
+{
+	int virq;
+	int i;
+
+	virq =3D irq_find_mapping(domain, hwirq);
+
+	for (i =3D 1; i < num; i++) {
+		unsigned int next;
+
+		next =3D irq_find_mapping(domain, hwirq + i);
+		if (next =3D=3D virq + i)
+			continue;
+
+		pr_err("irq: invalid partial mapping. First hwirq %lu maps to "
+				"%d and \n", hwirq, virq);
+		pr_err("irq: +%d hwirq (%lu) maps to %d but should be %d.\n",
+				i, hwirq + i, next, virq + i);
+		return -EINVAL;
+	}
+
+	pr_debug("-> existing mapping on virq %d\n", virq);
+	return virq;
+}
+
 /**
- * irq_create_mapping() - Map a hardware interrupt into linux irq space
+ * irq_create_mapping_block() - Map multiple hardware interrupts
  * @domain: domain owning this hardware interrupt or NULL for default doma=
in
  * @hwirq: hardware irq number in that domain space
+ * @num: number of interrupts
+ *
+ * Maps a hwirq to a newly allocated virq. If num is greater than 1 then n=
um
+ * hwirqs (hwirq =E2=80=A6 hwirq + num - 1) will be mapped and virq will b=
e  continuous.
+ * Returns the first linux virq number.
  *
- * Only one mapping per hardware interrupt is permitted. Returns a linux
- * irq number.
  * If the sense/trigger is to be specified, set_irq_type() should be called
  * on the number returned from that call.
  */
-unsigned int irq_create_mapping(struct irq_domain *domain,
-				irq_hw_number_t hwirq)
+unsigned int irq_create_mapping_block(struct irq_domain *domain,
+		irq_hw_number_t hwirq, unsigned int num)
 {
-	unsigned int hint;
 	int virq;
+	int i;
+	int node;
+	unsigned int hint;
=20
-	pr_debug("irq_create_mapping(0x%p, 0x%lx)\n", domain, hwirq);
+	pr_debug("%s(0x%p, 0x%lx, %d)\n", __func__, domain, hwirq, num);
=20
 	/* Look for default domain if nececssary */
-	if (domain =3D=3D NULL)
+	if (!domain && num =3D=3D 1)
 		domain =3D irq_default_domain;
+
 	if (domain =3D=3D NULL) {
 		WARN(1, "%s(, %lx) called with NULL domain\n", __func__, hwirq);
 		return 0;
 	}
 	pr_debug("-> using domain @%p\n", domain);
=20
 	/* Check if mapping already exists */
-	virq =3D irq_find_mapping(domain, hwirq);
-	if (virq) {
-		pr_debug("-> existing mapping on virq %d\n", virq);
-		return virq;
+	for (i =3D 0; i < num; i++) {
+		virq =3D irq_find_mapping(domain, hwirq + i);
+		if (virq !=3D NO_IRQ) {
+			if (i =3D=3D 0)
+				return irq_check_continuous_mapping(domain,
+						hwirq, num);
+			pr_err("irq: hwirq %ld has no mapping but hwirq %ld "
+				"maps to virq %d. This can't be a block\n",
+				hwirq, hwirq + i, virq);
+			return -EINVAL;
+		}
 	}
=20
+	node =3D of_node_to_nid(domain->of_node);
 	/* Allocate a virtual interrupt number */
 	hint =3D hwirq % nr_irqs;
 	if (hint =3D=3D 0)
 		hint++;
-	virq =3D irq_alloc_desc_from(hint, of_node_to_nid(domain->of_node));
-	if (virq <=3D 0)
-		virq =3D irq_alloc_desc_from(1, of_node_to_nid(domain->of_node));
+	virq =3D irq_alloc_descs_from(hint, num, node);
+	if (virq <=3D 0 && hint !=3D 1)
+		virq =3D irq_alloc_descs_from(1, num, node);
 	if (virq <=3D 0) {
 		pr_debug("-> virq allocation failed\n");
 		return 0;
 	}
=20
-	if (irq_domain_associate(domain, virq, hwirq)) {
-		irq_free_desc(virq);
-		return 0;
+	irq_domain_associate_many(domain, virq, hwirq, num);
+	if (num =3D=3D 1) {
+		pr_debug("irq %lu on domain %s mapped to virtual irq %u\n",
+			hwirq, of_node_full_name(domain->of_node), virq);
+		return virq;
 	}
-
-	pr_debug("irq %lu on domain %s mapped to virtual irq %u\n",
-		hwirq, of_node_full_name(domain->of_node), virq);
-
+	pr_debug("irqs %lu=E2=80=A6%lu on domain %s mapped to virtual irqs %u=E2=
=80=A6%u\n",
+		hwirq, hwirq + num - 1, of_node_full_name(domain->of_node),
+			virq, virq + num - 1);
 	return virq;
 }
-EXPORT_SYMBOL_GPL(irq_create_mapping);
+EXPORT_SYMBOL_GPL(irq_create_mapping_block);
=20
 /**
  * irq_create_strict_mappings() - Map a range of hw irqs to fixed linux ir=
qs
  * @domain: domain owning the interrupt range
  * @irq_base: beginning of linux IRQ range
--=20
1.9.0.rc3

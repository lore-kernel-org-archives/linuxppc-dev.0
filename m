Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AE0712C009F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2013 18:39:13 +1100 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Tue, 15 Jan 2013 17:31:30 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 4E7A23578051
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2013 18:39:06 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0F7d5wc40566934
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2013 18:39:05 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0F7d52O008375
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2013 18:39:06 +1100
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] irq: Add hw continuous IRQs map to virtual continuous
 IRQs support
Date: Tue, 15 Jan 2013 15:38:55 +0800
Message-Id: <1358235536-32741-3-git-send-email-qiudayu@linux.vnet.ibm.com>
In-Reply-To: <1358235536-32741-1-git-send-email-qiudayu@linux.vnet.ibm.com>
References: <1358235536-32741-1-git-send-email-qiudayu@linux.vnet.ibm.com>
Cc: tglx@linutronix.de, Mike Qiu <qiudayu@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adding a function irq_create_mapping_many() which can associate
multiple MSIs to a continous irq mapping.

This is needed to enable multiple MSI support for pSeries.

Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
---
 include/linux/irq.h       |    2 +
 include/linux/irqdomain.h |    3 ++
 kernel/irq/irqdomain.c    |   61 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 60ef45b..e00a7ec 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -592,6 +592,8 @@ int __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
 #define irq_alloc_desc_from(from, node)		\
 	irq_alloc_descs(-1, from, 1, node)
 
+#define irq_alloc_desc_n(nevc, node)		\
+	irq_alloc_descs(-1, 0, nevc, node)
 void irq_free_descs(unsigned int irq, unsigned int cnt);
 int irq_reserve_irqs(unsigned int from, unsigned int cnt);
 
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 0d5b17b..831dded 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -168,6 +168,9 @@ extern int irq_create_strict_mappings(struct irq_domain *domain,
 				      unsigned int irq_base,
 				      irq_hw_number_t hwirq_base, int count);
 
+extern int irq_create_mapping_many(struct irq_domain *domain,
+					irq_hw_number_t hwirq_base, int count);
+
 static inline int irq_create_identity_mapping(struct irq_domain *host,
 					      irq_hw_number_t hwirq)
 {
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 96f3a1d..38648e6 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -636,6 +636,67 @@ int irq_create_strict_mappings(struct irq_domain *domain, unsigned int irq_base,
 }
 EXPORT_SYMBOL_GPL(irq_create_strict_mappings);
 
+/**
+ * irq_create_mapping_many - Map a range of hw IRQs to a range of virtual IRQs
+ * @domain: domain owning the interrupt range
+ * @hwirq_base: beginning of continuous hardware IRQ range
+ * @count: Number of interrupts to map
+ *
+ * This routine is used for allocating and mapping a range of hardware
+ * irqs to virtual IRQs where the virtual irq numbers are not at pre-defined
+ * locations.
+ *
+ * Greater than 0 is returned upon success, while any failure to establish a
+ * static mapping is treated as an error.
+ */
+int irq_create_mapping_many(struct irq_domain *domain,
+		irq_hw_number_t hwirq_base, int count)
+{
+	int ret, irq_base;
+	int virq, i;
+
+	pr_debug("irq_create_mapping(0x%p, 0x%lx)\n", domain, hwirq_base);
+
+	/* Look for default domain if nececssary */
+	if (!domain)
+		domain = irq_default_domain;
+	if (!domain) {
+		pr_warn("irq_create_mapping called for NULL domain, hwirq=%lx\n"
+			, hwirq_base);
+		WARN_ON(1);
+		return 0;
+	}
+	pr_debug("-> using domain @%p\n", domain);
+
+	/* For IRQ_DOMAIN_MAP_LEGACY, get the first virtual interrupt number */
+	if (domain->revmap_type == IRQ_DOMAIN_MAP_LEGACY)
+		return irq_domain_legacy_revmap(domain, hwirq_base);
+
+	/* Check if mapping already exists */
+	for (i = 0; i < count; i++) {
+		virq = irq_find_mapping(domain, hwirq_base+i);
+		if (virq) {
+			pr_debug("existing mapping on virq %d,"
+					" now dispose it first\n", virq);
+			irq_dispose_mapping(virq);
+		}
+	}
+
+	/* Allocate the continuous virtual interrupt numbers */
+	irq_base = irq_alloc_desc_n(count, of_node_to_nid(domain->of_node));
+	if (unlikely(irq_base < 0))
+		return  irq_base;
+
+	ret = irq_domain_associate_many(domain, irq_base, hwirq_base, count);
+	if (unlikely(ret < 0)) {
+		irq_free_descs(irq_base, count);
+		return ret;
+	}
+
+	return irq_base;
+}
+EXPORT_SYMBOL_GPL(irq_create_mapping_many);
+
 unsigned int irq_create_of_mapping(struct device_node *controller,
 				   const u32 *intspec, unsigned int intsize)
 {
-- 
1.7.7.6

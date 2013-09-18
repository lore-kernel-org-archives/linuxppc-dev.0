Return-Path: <thierry.reding@gmail.com>
Received: from mail-bk0-f48.google.com (mail-bk0-f48.google.com
 [209.85.214.48])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B4E062C0218
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Sep 2013 23:26:56 +1000 (EST)
Received: by mail-bk0-f48.google.com with SMTP id my13so2782828bkb.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Sep 2013 06:26:23 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Rob Herring <rob.herring@calxeda.com>,
 Grant Likely <grant.likely@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 03/10] irqdomain: Introduce __irq_create_mapping()
Date: Wed, 18 Sep 2013 15:24:45 +0200
Message-Id: <1379510692-32435-4-git-send-email-treding@nvidia.com>
In-Reply-To: <1379510692-32435-1-git-send-email-treding@nvidia.com>
References: <1379510692-32435-1-git-send-email-treding@nvidia.com>
Cc: linux-mips@linux-mips.org, Russell King <linux@arm.linux.org.uk>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, sparclinux@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a version of irq_create_mapping() that propagates the precise
error code instead of returning 0 for all errors. It will be used in
subsequent patches to allow further propagation of error codes.

To avoid code duplication, implement irq_create_mapping() as a wrapper
around the new __irq_create_mapping().

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 kernel/irq/irqdomain.c | 59 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 20 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 706724e..d2a3b01 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -374,30 +374,21 @@ unsigned int irq_create_direct_mapping(struct irq_domain *domain)
 }
 EXPORT_SYMBOL_GPL(irq_create_direct_mapping);
 
-/**
- * irq_create_mapping() - Map a hardware interrupt into linux irq space
- * @domain: domain owning this hardware interrupt or NULL for default domain
- * @hwirq: hardware irq number in that domain space
- *
- * Only one mapping per hardware interrupt is permitted. Returns a linux
- * irq number.
- * If the sense/trigger is to be specified, set_irq_type() should be called
- * on the number returned from that call.
- */
-unsigned int irq_create_mapping(struct irq_domain *domain,
-				irq_hw_number_t hwirq)
+static int __irq_create_mapping(struct irq_domain *domain,
+				irq_hw_number_t hwirq, unsigned int *virqp)
 {
-	unsigned int hint;
-	int virq;
+	unsigned int hint, virq;
+	int ret;
 
-	pr_debug("irq_create_mapping(0x%p, 0x%lx)\n", domain, hwirq);
+	pr_debug("__irq_create_mapping(0x%p, 0x%lx, %p)\n", domain, hwirq,
+		 virqp);
 
 	/* Look for default domain if nececssary */
 	if (domain == NULL)
 		domain = irq_default_domain;
 	if (domain == NULL) {
 		WARN(1, "%s(, %lx) called with NULL domain\n", __func__, hwirq);
-		return 0;
+		return -ENODEV;
 	}
 	pr_debug("-> using domain @%p\n", domain);
 
@@ -405,7 +396,11 @@ unsigned int irq_create_mapping(struct irq_domain *domain,
 	virq = irq_find_mapping(domain, hwirq);
 	if (virq) {
 		pr_debug("-> existing mapping on virq %d\n", virq);
-		return virq;
+
+		if (virqp)
+			*virqp = virq;
+
+		return 0;
 	}
 
 	/* Allocate a virtual interrupt number */
@@ -417,17 +412,41 @@ unsigned int irq_create_mapping(struct irq_domain *domain,
 		virq = irq_alloc_desc_from(1, of_node_to_nid(domain->of_node));
 	if (virq <= 0) {
 		pr_debug("-> virq allocation failed\n");
-		return 0;
+		return virq ? : -ENOSPC;
 	}
 
-	if (irq_domain_associate(domain, virq, hwirq)) {
+	ret = irq_domain_associate(domain, virq, hwirq);
+	if (ret) {
 		irq_free_desc(virq);
-		return 0;
+		return ret;
 	}
 
 	pr_debug("irq %lu on domain %s mapped to virtual irq %u\n",
 		hwirq, of_node_full_name(domain->of_node), virq);
 
+	if (virqp)
+		*virqp = virq;
+
+	return 0;
+}
+/**
+ * irq_create_mapping() - Map a hardware interrupt into linux irq space
+ * @domain: domain owning this hardware interrupt or NULL for default domain
+ * @hwirq: hardware irq number in that domain space
+ *
+ * Only one mapping per hardware interrupt is permitted. Returns a linux
+ * irq number.
+ * If the sense/trigger is to be specified, set_irq_type() should be called
+ * on the number returned from that call.
+ */
+unsigned int irq_create_mapping(struct irq_domain *domain,
+				irq_hw_number_t hwirq)
+{
+	unsigned int virq;
+
+	if (__irq_create_mapping(domain, hwirq, &virq))
+		return 0;
+
 	return virq;
 }
 EXPORT_SYMBOL_GPL(irq_create_mapping);
-- 
1.8.4

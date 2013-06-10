Return-Path: <glikely@secretlab.ca>
Received: from mail-ee0-x231.google.com (mail-ee0-x231.google.com
 [IPv6:2a00:1450:4013:c00::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A99952C02EF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jun 2013 10:49:46 +1000 (EST)
Received: by mail-ee0-f49.google.com with SMTP id b57so2635907eek.8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Jun 2013 17:49:42 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@linaro.org>
To: linux-kernel@vger.kernel.org
Subject: [RFC 09/10] irqdomain: remove irq_domain_generate_simple()
Date: Mon, 10 Jun 2013 01:49:21 +0100
Message-Id: <1370825362-11145-10-git-send-email-grant.likely@linaro.org>
In-Reply-To: <1370825362-11145-1-git-send-email-grant.likely@linaro.org>
References: <1370825362-11145-1-git-send-email-grant.likely@linaro.org>
Cc: Grant Likely <grant.likely@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nobody calls it; remove the function

Signed-off-by: Grant Likely <grant.likely@linaro.org>
---
 include/linux/irqdomain.h |  8 --------
 kernel/irq/irqdomain.c    | 15 ---------------
 2 files changed, 23 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index f9e8e06..fe7c57d 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -205,14 +205,6 @@ int irq_domain_xlate_onetwocell(struct irq_domain *d, struct device_node *ctrlr,
 			const u32 *intspec, unsigned int intsize,
 			irq_hw_number_t *out_hwirq, unsigned int *out_type);
 
-#if defined(CONFIG_OF_IRQ)
-extern void irq_domain_generate_simple(const struct of_device_id *match,
-					u64 phys_base, unsigned int irq_start);
-#else /* CONFIG_OF_IRQ */
-static inline void irq_domain_generate_simple(const struct of_device_id *match,
-					u64 phys_base, unsigned int irq_start) { }
-#endif /* !CONFIG_OF_IRQ */
-
 #else /* CONFIG_IRQ_DOMAIN */
 static inline void irq_dispose_mapping(unsigned int virq) { }
 #endif /* !CONFIG_IRQ_DOMAIN */
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 80e9249..e47b356 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -741,18 +741,3 @@ const struct irq_domain_ops irq_domain_simple_ops = {
 	.xlate = irq_domain_xlate_onetwocell,
 };
 EXPORT_SYMBOL_GPL(irq_domain_simple_ops);
-
-#ifdef CONFIG_OF_IRQ
-void irq_domain_generate_simple(const struct of_device_id *match,
-				u64 phys_base, unsigned int irq_start)
-{
-	struct device_node *node;
-	pr_debug("looking for phys_base=%llx, irq_start=%i\n",
-		(unsigned long long) phys_base, (int) irq_start);
-	node = of_find_matching_node_by_address(NULL, match, phys_base);
-	if (node)
-		irq_domain_add_legacy(node, 32, irq_start, 0,
-				      &irq_domain_simple_ops, NULL);
-}
-EXPORT_SYMBOL_GPL(irq_domain_generate_simple);
-#endif
-- 
1.8.1.2

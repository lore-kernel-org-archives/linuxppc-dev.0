Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <1e7f2ee0ff2e863d04e1f98f381f217359110163.1180961962.git.michael@ellerman.id.au>
In-Reply-To: <f0cd638495b96585dec513f41335154e60675813.1180961962.git.michael@ellerman.id.au>
References: <f0cd638495b96585dec513f41335154e60675813.1180961962.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 2/4] Add irq_create_direct_mapping()
Date: Mon,  4 Jun 2007 23:00:00 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds irq_create_direct_mapping(). This routine is
an alternative to irq_create_mapping(), for irq controllers that
can use linux virq numbers directly as hardware numbers.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/irq.c |   24 ++++++++++++++++++++++++
 include/asm-powerpc/irq.h |    9 +++++++++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 9bafc88..fdb3b00 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -611,6 +611,30 @@ static int irq_setup_virq(struct irq_host *host, unsigned int virq,
 	return 0;
 }
 
+unsigned int irq_create_direct_mapping(struct irq_host *host)
+{
+	unsigned int virq;
+
+	if (host == NULL)
+		host = irq_default_host;
+
+	BUG_ON(host == NULL);
+	WARN_ON(host->revmap_type != IRQ_HOST_MAP_NOMAP);
+
+	virq = irq_alloc_virt(host, 1, 0);
+	if (virq == NO_IRQ) {
+		pr_debug("irq: create_direct virq allocation failed\n");
+		return NO_IRQ;
+	}
+
+	pr_debug("irq: create_direct obtained virq %d\n", virq);
+
+	if (irq_setup_virq(host, virq, virq))
+		return NO_IRQ;
+
+	return virq;
+}
+
 unsigned int irq_create_mapping(struct irq_host *host,
 				irq_hw_number_t hwirq)
 {
diff --git a/include/asm-powerpc/irq.h b/include/asm-powerpc/irq.h
index 4734cc1..8384e3f 100644
--- a/include/asm-powerpc/irq.h
+++ b/include/asm-powerpc/irq.h
@@ -226,6 +226,15 @@ extern void irq_dispose_mapping(unsigned int virq);
 extern unsigned int irq_find_mapping(struct irq_host *host,
 				     irq_hw_number_t hwirq);
 
+/**
+ * irq_create_direct_mapping - Allocate a virq for direct mapping
+ * @host: host to allocate the virq for or NULL for default host
+ *
+ * This routine is used for irq controllers which can choose the hardware
+ * interrupt numbers they generate. In such a case it's simplest to use
+ * the linux virq as the hardware interrupt number.
+ */
+extern unsigned int irq_create_direct_mapping(struct irq_host *host);
 
 /**
  * irq_radix_revmap - Find a linux virq from a hw irq number.
-- 
1.5.1.3.g7a33b-dirty

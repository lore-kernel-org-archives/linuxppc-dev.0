Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 231E6100876
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 17:42:35 +1000 (EST)
To: <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <fd94023491cca4b3eb3a06da3f69c8afadc9a8b1.1305092637.git.miltonm@bga.com>
In-Reply-To: <cover.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
From: Milton Miller <miltonm@bga.com>
Date: Wed, 11 May 2011 00:30:36 -0500
Subject: [PATCH 35/37] powerpc: add virq_is_host to reduce virq_to_host usage
Cc: Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some irq_host implementations are using virq_to_host to check if
they are the irq_host for a virtual irq.  To allow us to make space
versus time tradeoffs, replace this usage with an assertive
virq_is_host that confirms or denies the irq is associated with the
given irq_host.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
 arch/powerpc/include/asm/irq.h         |    1 +
 arch/powerpc/kernel/irq.c              |    6 ++++++
 arch/powerpc/sysdev/xics/xics-common.c |    2 +-
 3 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
index 6f4a3ef..a65d170 100644
--- a/arch/powerpc/include/asm/irq.h
+++ b/arch/powerpc/include/asm/irq.h
@@ -128,6 +128,7 @@ struct irq_host {
 struct irq_data;
 extern irq_hw_number_t irqd_to_hwirq(struct irq_data *d);
 extern irq_hw_number_t virq_to_hw(unsigned int virq);
+extern bool virq_is_host(unsigned int virq, struct irq_host *host);
 extern struct irq_host *virq_to_host(unsigned int virq);
 
 /**
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 0715a09..73cf290 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -510,6 +510,12 @@ irq_hw_number_t virq_to_hw(unsigned int virq)
 }
 EXPORT_SYMBOL_GPL(virq_to_hw);
 
+bool virq_is_host(unsigned int virq, struct irq_host *host)
+{
+	return irq_map[virq].host == host;
+}
+EXPORT_SYMBOL_GPL(virq_is_host);
+
 struct irq_host *virq_to_host(unsigned int virq)
 {
 	return irq_map[virq].host;
diff --git a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
index 43b2a79..445c5a0 100644
--- a/arch/powerpc/sysdev/xics/xics-common.c
+++ b/arch/powerpc/sysdev/xics/xics-common.c
@@ -213,7 +213,7 @@ void xics_migrate_irqs_away(void)
 		/* We can't set affinity on ISA interrupts */
 		if (virq < NUM_ISA_INTERRUPTS)
 			continue;
-		if (virq_to_host(virq) != xics_host)
+		if (!virq_is_host(virq, xics_host))
 			continue;
 		irq = (unsigned int)virq_to_hw(virq);
 		/* We need to get IPIs still. */
-- 
1.7.0.4

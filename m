Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 126161007E7
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 17:42:40 +1000 (EST)
To: <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <e01cafe6352e8e4715788f959b747c1363459cee.1305092637.git.miltonm@bga.com>
In-Reply-To: <cover.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
From: Milton Miller <miltonm@bga.com>
Date: Wed, 11 May 2011 00:30:40 -0500
Subject: [PATCH 36/37] powerpc: remove virq_to_host
Cc: Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The only references to the irq_map[].host field are internal to
arch/powerpc/kernel/irq.c

Signed-off-by: Milton Miller <miltonm@bga.com>
---
---
 arch/powerpc/include/asm/irq.h |    1 -
 arch/powerpc/kernel/irq.c      |    6 ------
 2 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
index a65d170..1bff591 100644
--- a/arch/powerpc/include/asm/irq.h
+++ b/arch/powerpc/include/asm/irq.h
@@ -129,7 +129,6 @@ struct irq_data;
 extern irq_hw_number_t irqd_to_hwirq(struct irq_data *d);
 extern irq_hw_number_t virq_to_hw(unsigned int virq);
 extern bool virq_is_host(unsigned int virq, struct irq_host *host);
-extern struct irq_host *virq_to_host(unsigned int virq);
 
 /**
  * irq_alloc_host - Allocate a new irq_host data structure
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 73cf290..4368b5e 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -516,12 +516,6 @@ bool virq_is_host(unsigned int virq, struct irq_host *host)
 }
 EXPORT_SYMBOL_GPL(virq_is_host);
 
-struct irq_host *virq_to_host(unsigned int virq)
-{
-	return irq_map[virq].host;
-}
-EXPORT_SYMBOL_GPL(virq_to_host);
-
 static int default_irq_host_match(struct irq_host *h, struct device_node *np)
 {
 	return h->of_node != NULL && h->of_node == np;
-- 
1.7.0.4

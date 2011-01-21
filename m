Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 62D16B7101
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 22 Jan 2011 03:12:36 +1100 (EST)
Message-Id: <20110121142944.531412425@linutronix.de>
Date: Fri, 21 Jan 2011 16:12:28 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [patch 1/2] powerpc: Use ARCH_IRQ_INIT_FLAGS
References: <20110121142848.050196552@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Define the ARCH_IRQ_INIT_FLAGS instead of fixing it up in a loop.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/include/asm/hw_irq.h |    2 ++
 arch/powerpc/kernel/irq.c         |   15 ---------------
 2 files changed, 2 insertions(+), 15 deletions(-)

Index: linux-2.6-tip/arch/powerpc/include/asm/hw_irq.h
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/include/asm/hw_irq.h
+++ linux-2.6-tip/arch/powerpc/include/asm/hw_irq.h
@@ -141,6 +141,8 @@ static inline bool arch_irqs_disabled(vo
 
 #endif /* CONFIG_PPC64 */
 
+#define ARCH_IRQ_INIT_FLAGS	IRQ_NOREQUEST
+
 /*
  * interrupt-retrigger: should we handle this via lost interrupts and IPIs
  * or should we not care like we do now ? --BenH.
Index: linux-2.6-tip/arch/powerpc/kernel/irq.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/kernel/irq.c
+++ linux-2.6-tip/arch/powerpc/kernel/irq.c
@@ -1074,21 +1074,6 @@ void irq_free_virt(unsigned int virq, un
 
 int arch_early_irq_init(void)
 {
-	struct irq_desc *desc;
-	int i;
-
-	for (i = 0; i < NR_IRQS; i++) {
-		desc = irq_to_desc(i);
-		if (desc)
-			desc->status |= IRQ_NOREQUEST;
-	}
-
-	return 0;
-}
-
-int arch_init_chip_data(struct irq_desc *desc, int node)
-{
-	desc->status |= IRQ_NOREQUEST;
 	return 0;
 }
 

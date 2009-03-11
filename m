Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E77CADE17A
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 11:47:05 +1100 (EST)
Message-Id: <20090311003236.263019667@linutronix.de>
Date: Wed, 11 Mar 2009 00:45:54 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 08/18] powerpc: convert obsolete irq_desc_t to struct irq_desc
References: <20090311003204.592133594@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Impact: cleanup

Convert the last remaining users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linuxppc-dev@ozlabs.org
---
 arch/powerpc/kernel/irq.c            |    4 ++--
 arch/powerpc/platforms/iseries/irq.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6/arch/powerpc/kernel/irq.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/irq.c
+++ linux-2.6/arch/powerpc/kernel/irq.c
@@ -171,7 +171,7 @@ int show_interrupts(struct seq_file *p, 
 {
 	int i = *(loff_t *)v, j;
 	struct irqaction *action;
-	irq_desc_t *desc;
+	struct irq_desc *desc;
 	unsigned long flags;
 
 	if (i == 0) {
@@ -1038,7 +1038,7 @@ arch_initcall(irq_late_init);
 static int virq_debug_show(struct seq_file *m, void *private)
 {
 	unsigned long flags;
-	irq_desc_t *desc;
+	struct irq_desc *desc;
 	const char *p;
 	char none[] = "none";
 	int i;
Index: linux-2.6/arch/powerpc/platforms/iseries/irq.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/iseries/irq.c
+++ linux-2.6/arch/powerpc/platforms/iseries/irq.c
@@ -214,7 +214,7 @@ void __init iSeries_activate_IRQs()
 	unsigned long flags;
 
 	for_each_irq (irq) {
-		irq_desc_t *desc = get_irq_desc(irq);
+		struct irq_desc *desc = get_irq_desc(irq);
 
 		if (desc && desc->chip && desc->chip->startup) {
 			spin_lock_irqsave(&desc->lock, flags);

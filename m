Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DDA5167B3A
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jun 2006 13:59:00 +1000 (EST)
Subject: [PATCH] powerpc-genirq: port iseries pseudo-PIC to genirq
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 13:58:39 +1000
Message-Id: <1150171119.13958.29.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch ports the iSeries pseudo-PIC to genirq
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Patch depends on Ingo/Thomas genirq patchset. It's not to be merged
right away, It's being posted here for comments as I may have further
rework.

Index: linux-work/arch/powerpc/platforms/iseries/irq.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/iseries/irq.c	2006-06-05 17:55:22.000000000 +1000
+++ linux-work/arch/powerpc/platforms/iseries/irq.c	2006-06-07 14:41:55.000000000 +1000
@@ -297,13 +297,13 @@ static void iseries_end_IRQ(unsigned int
 		(REAL_IRQ_TO_IDSEL(rirq) << 4) + REAL_IRQ_TO_FUNC(rirq));
 }
 
-static hw_irq_controller iSeries_IRQ_handler = {
-	.typename = "iSeries irq controller",
-	.startup = iseries_startup_IRQ,
-	.shutdown = iseries_shutdown_IRQ,
-	.enable = iseries_enable_IRQ,
-	.disable = iseries_disable_IRQ,
-	.end = iseries_end_IRQ
+static struct irq_chip iseries_pic = {
+	.typename	= "iSeries irq controller",
+	.startup	= iseries_startup_IRQ,
+	.shutdown	= iseries_shutdown_IRQ,
+	.unmask		= iseries_enable_IRQ,
+	.mask		= iseries_disable_IRQ,
+	.eoi		= iseries_end_IRQ
 };
 
 /*
@@ -322,8 +322,7 @@ int __init iSeries_allocate_IRQ(HvBusNum
 	realirq = (((((sub_bus << 8) + (bus - 1)) << 3) + (idsel - 1)) << 3)
 		+ function;
 	virtirq = virt_irq_create_mapping(realirq);
-
-	irq_desc[virtirq].chip = &iSeries_IRQ_handler;
+	set_irq_chip_and_handler(virtirq, &iseries_pic, handle_fasteoi_irq);
 	return virtirq;
 }
 

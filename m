Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 01A3C1A0ACC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 06:50:38 +1000 (AEST)
Message-Id: <20150713135740.580798175@linutronix.de>
Date: Mon, 13 Jul 2015 20:50:29 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Julia Lawall <Julia.Lawall@lip6.fr>,
 Jiang Liu <jiang.liu@linux.intel.com>
Subject: [patch 19/20] powerpc/85xx: Prepare cascade handlers for irq argument
 removal
References: <20150713135648.540293392@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The irq argument of most interrupt flow handlers is unused or merily
used instead of a local variable. The handlers which need the irq
argument can retrieve the irq number from the irq descriptor.

Search and update was done with coccinelle and the invaluable help of
Julia Lawall.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/powerpc/platforms/85xx/mpc85xx_cds.c       |    3 ++-
 arch/powerpc/platforms/85xx/socrates_fpga_pic.c |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

Index: tip/arch/powerpc/platforms/85xx/mpc85xx_cds.c
===================================================================
--- tip.orig/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ tip/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -192,9 +192,10 @@ void mpc85xx_cds_fixup_bus(struct pci_bu
 }
 
 #ifdef CONFIG_PPC_I8259
-static void mpc85xx_8259_cascade_handler(unsigned int irq,
+static void mpc85xx_8259_cascade_handler(unsigned int __irq,
 					 struct irq_desc *desc)
 {
+	unsigned int irq = irq_desc_get_irq(desc);
 	unsigned int cascade_irq = i8259_irq();
 
 	if (cascade_irq != NO_IRQ)
Index: tip/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
===================================================================
--- tip.orig/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
+++ tip/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
@@ -91,8 +91,9 @@ static inline unsigned int socrates_fpga
 			(irq_hw_number_t)i);
 }
 
-void socrates_fpga_pic_cascade(unsigned int irq, struct irq_desc *desc)
+void socrates_fpga_pic_cascade(unsigned int __irq, struct irq_desc *desc)
 {
+	unsigned int irq = irq_desc_get_irq(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int cascade_irq;
 

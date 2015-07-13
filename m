Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2B34A1A08EC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 06:50:37 +1000 (AEST)
Message-Id: <20150713135740.499139784@linutronix.de>
Date: Mon, 13 Jul 2015 20:50:28 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Julia Lawall <Julia.Lawall@lip6.fr>,
 Jiang Liu <jiang.liu@linux.intel.com>
Subject: [patch 18/20] powerpc/mpc5121: Prepare cpld_pic_cascade for irq
 argument removal
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
 arch/powerpc/platforms/512x/mpc5121_ads_cpld.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: tip/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
===================================================================
--- tip.orig/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
+++ tip/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
@@ -105,8 +105,10 @@ cpld_pic_get_irq(int offset, u8 ignore,
 }
 
 static void
-cpld_pic_cascade(unsigned int irq, struct irq_desc *desc)
+cpld_pic_cascade(unsigned int __irq, struct irq_desc *desc)
 {
+	unsigned int irq;
+
 	irq = cpld_pic_get_irq(0, PCI_IGNORE, &cpld_regs->pci_status,
 		&cpld_regs->pci_mask);
 	if (irq != NO_IRQ) {

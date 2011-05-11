Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 018DE100967
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 17:42:38 +1000 (EST)
To: <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <f27d82eb62660e32008528aeec6fc0cb18e27262.1305092637.git.miltonm@bga.com>
In-Reply-To: <cover.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
From: Milton Miller <miltonm@bga.com>
Date: Wed, 11 May 2011 00:30:04 -0500
Subject: [PATCH 26/37] powerpc: remove i8259 irq_host_ops->unmap
Cc: Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It was never called because the host is always IRQ_HOST_MAP_LEGACY.

And what it purported to do was mask the interrupt (which will already
have happend if we shutdown the interrupt), then synchronise_irq and
clear the chip pointer, both of which will have been be done by the
caller were we to call unmap on a legacy irq.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
---
 arch/powerpc/sysdev/i8259.c |   13 -------------
 1 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/sysdev/i8259.c b/arch/powerpc/sysdev/i8259.c
index 142770c..d18bb27 100644
--- a/arch/powerpc/sysdev/i8259.c
+++ b/arch/powerpc/sysdev/i8259.c
@@ -185,18 +185,6 @@ static int i8259_host_map(struct irq_host *h, unsigned int virq,
 	return 0;
 }
 
-static void i8259_host_unmap(struct irq_host *h, unsigned int virq)
-{
-	/* Make sure irq is masked in hardware */
-	i8259_mask_irq(irq_get_irq_data(virq));
-
-	/* remove chip and handler */
-	irq_set_chip_and_handler(virq, NULL, NULL);
-
-	/* Make sure it's completed */
-	synchronize_irq(virq);
-}
-
 static int i8259_host_xlate(struct irq_host *h, struct device_node *ct,
 			    const u32 *intspec, unsigned int intsize,
 			    irq_hw_number_t *out_hwirq, unsigned int *out_flags)
@@ -220,7 +208,6 @@ static int i8259_host_xlate(struct irq_host *h, struct device_node *ct,
 static struct irq_host_ops i8259_host_ops = {
 	.match = i8259_host_match,
 	.map = i8259_host_map,
-	.unmap = i8259_host_unmap,
 	.xlate = i8259_host_xlate,
 };
 
-- 
1.7.0.4

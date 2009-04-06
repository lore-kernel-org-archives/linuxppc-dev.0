Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <b804a7950247ceb99706be8cadb9bf5da5f73b09.1238983497.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] powerpc: Print information about mapping hw irqs to virtual
	irqs
Date: Mon,  6 Apr 2009 12:05:02 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The irq remapping layer seems to cause some confusion when people
see a different irq number in /proc/interrupts vs the one they
request in their driver or DTS.

So have the irq remapping layer print out a message when we map an
irq. The message is only printed the first time the irq is mapped,
and it's KERN_DEBUG so most people won't see it.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/irq.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 5576147..8c1a496 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -672,11 +672,13 @@ unsigned int irq_create_mapping(struct irq_host *host,
 			return NO_IRQ;
 		}
 	}
-	pr_debug("irq: -> obtained virq %d\n", virq);
 
 	if (irq_setup_virq(host, virq, hwirq))
 		return NO_IRQ;
 
+	printk(KERN_DEBUG "irq: irq %lu on host %s mapped to virtual irq %u\n",
+		hwirq, host->of_node ? host->of_node->full_name : "null", virq);
+
 	return virq;
 }
 EXPORT_SYMBOL_GPL(irq_create_mapping);
-- 
1.6.1.2

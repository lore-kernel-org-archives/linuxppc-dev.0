Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <4fc238c0a3de68eb04ebbfbac2bf5ab61d42c167.1185366282.git.michael@ellerman.id.au>
In-Reply-To: <41400bb89c154723f795e998d5ac777345eb9ebc.1185366282.git.michael@ellerman.id.au>
References: <41400bb89c154723f795e998d5ac777345eb9ebc.1185366282.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 4/5] Initialise hwirq for legacy irqs
Date: Wed, 25 Jul 2007 22:24:56 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Although no one uses the hwirq value for legacy irqs at the moment, we
should really setup the correct value in the irq_map.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/irq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 3dd582f..f71432c 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -487,7 +487,7 @@ struct irq_host *irq_alloc_host(struct device_node *of_node,
 		host->inval_irq = 0;
 		/* setup us as the host for all legacy interrupts */
 		for (i = 1; i < NUM_ISA_INTERRUPTS; i++) {
-			irq_map[i].hwirq = 0;
+			irq_map[i].hwirq = i;
 			smp_wmb();
 			irq_map[i].host = host;
 			smp_wmb();
-- 
1.5.1.3.g7a33b

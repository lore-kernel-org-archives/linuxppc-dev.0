Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <4bba1953b14248f3d34884ef7eb29a8e64877c5f.1188290811.git.michael@ellerman.id.au>
In-Reply-To: <460e86e8b5a08c23dcbedb5d4bd484a519246dd3.1188290811.git.michael@ellerman.id.au>
References: <460e86e8b5a08c23dcbedb5d4bd484a519246dd3.1188290811.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 4/5] Initialise hwirq for legacy irqs
Date: Tue, 28 Aug 2007 18:47:56 +1000 (EST)
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
index d5c7e4c..1339f32 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -487,7 +487,7 @@ __init_refok struct irq_host *irq_alloc_host(struct device_node *of_node,
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

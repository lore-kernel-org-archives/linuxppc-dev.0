Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 2166B100875
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 17:42:35 +1000 (EST)
To: <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <2e97f048f0a39de47c9af61c1b53fb6fba6260d6.1305092637.git.miltonm@bga.com>
In-Reply-To: <cover.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
From: Milton Miller <miltonm@bga.com>
Date: Wed, 11 May 2011 00:30:44 -0500
Subject: [PATCH 37/37] powerpc: make IRQ_NOREQUEST last to clear, first to set
Cc: Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When allocating irqs, wait to clear the IRQ_NOREQUEST flag until the
host map hook has been called.

When freeing irqs, set the IRQ_NOREQUEST flag before calling the host
unmap hook.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
 arch/powerpc/kernel/irq.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 4368b5e..a24d37d 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -586,14 +586,14 @@ struct irq_host *irq_alloc_host(struct device_node *of_node,
 			irq_map[i].host = host;
 			smp_wmb();
 
-			/* Clear norequest flags */
-			irq_clear_status_flags(i, IRQ_NOREQUEST);
-
 			/* Legacy flags are left to default at this point,
 			 * one can then use irq_create_mapping() to
 			 * explicitly change them
 			 */
 			ops->map(host, i, i);
+
+			/* Clear norequest flags */
+			irq_clear_status_flags(i, IRQ_NOREQUEST);
 		}
 		break;
 	case IRQ_HOST_MAP_LINEAR:
@@ -664,8 +664,6 @@ static int irq_setup_virq(struct irq_host *host, unsigned int virq,
 		goto error;
 	}
 
-	irq_clear_status_flags(virq, IRQ_NOREQUEST);
-
 	/* map it */
 	smp_wmb();
 	irq_map[virq].hwirq = hwirq;
@@ -676,6 +674,8 @@ static int irq_setup_virq(struct irq_host *host, unsigned int virq,
 		goto errdesc;
 	}
 
+	irq_clear_status_flags(virq, IRQ_NOREQUEST);
+
 	return 0;
 
 errdesc:
@@ -819,6 +819,8 @@ void irq_dispose_mapping(unsigned int virq)
 	if (host->revmap_type == IRQ_HOST_MAP_LEGACY)
 		return;
 
+	irq_set_status_flags(virq, IRQ_NOREQUEST);
+
 	/* remove chip and handler */
 	irq_set_chip_and_handler(virq, NULL, NULL);
 
@@ -848,8 +850,6 @@ void irq_dispose_mapping(unsigned int virq)
 	smp_mb();
 	irq_map[virq].hwirq = host->inval_irq;
 
-	irq_set_status_flags(virq, IRQ_NOREQUEST);
-
 	irq_free_descs(virq, 1);
 	/* Free it */
 	irq_free_virt(virq, 1);
-- 
1.7.0.4

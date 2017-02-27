Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vWjTH5bp8zDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 11:37:07 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id 5so10866597pgj.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Feb 2017 16:37:07 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/xics: Fix migrate_irqs_away - set CPPR to lowest
 priority
Date: Mon, 27 Feb 2017 11:36:55 +1100
Message-Id: <20170227003655.18459-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With XICS emulation, setting the CPPR to DEFAULT_PRIORITY
masks all interrupts including IPI's which map to a single
underlying priority. The fix does two things

1. It moves the setting of CPPR to after all IRQ migration
   is complete
2. It sets the CPPR to LOWEST_PRIORITY, so that interrupts
   and IPI's are effectively enabled. The expectation is that
   we'll see just IPI's after migration

The fix is quite generic in that it will work when we move
DEFAULT and IPI priorities to the same value in the kernel
later.

Cc: mikey@neuling.org
Cc: benh@kernel.crashing.org

Fixes: d74361881f0d ("powerpc/xics: Add ICP OPAL backend")
Cc: stable@vger.kernel.org # v4.8+

Reported-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Tested-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/sysdev/xics/xics-common.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
index c674a9d..31774e0 100644
--- a/arch/powerpc/sysdev/xics/xics-common.c
+++ b/arch/powerpc/sysdev/xics/xics-common.c
@@ -20,6 +20,7 @@
 #include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/delay.h>
 
 #include <asm/prom.h>
 #include <asm/io.h>
@@ -198,9 +199,6 @@ void xics_migrate_irqs_away(void)
 	/* Remove ourselves from the global interrupt queue */
 	xics_set_cpu_giq(xics_default_distrib_server, 0);
 
-	/* Allow IPIs again... */
-	icp_ops->set_priority(LOWEST_PRIORITY);
-
 	for_each_irq_desc(virq, desc) {
 		struct irq_chip *chip;
 		long server;
@@ -255,6 +253,19 @@ void xics_migrate_irqs_away(void)
 unlock:
 		raw_spin_unlock_irqrestore(&desc->lock, flags);
 	}
+
+	/*
+	 * Allow sufficient time to drop any inflight IRQ's
+	 */
+	mdelay(1);
+
+	/*
+	 * Allow IPIs again. This is done at the very end, after
+	 * migrating all interrupts, the expectation is that we'll
+	 * only get woken up by an IPI interrupt beyond this point
+	 */
+	icp_ops->set_priority(LOWEST_PRIORITY);
+
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
-- 
2.9.3

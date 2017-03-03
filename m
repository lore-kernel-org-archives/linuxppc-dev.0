Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vZ9mc3Qg2zDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Mar 2017 11:58:56 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id e66so2553202pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Mar 2017 16:58:56 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/xics,icp-opal: Fix CPPR setting for icp-opal
Date: Fri,  3 Mar 2017 11:58:44 +1100
Message-Id: <20170303005844.21050-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CPPR (Current Processor Priority Register) emulation on icp-opal
uses a single priority in the backend and that can cause CPU
hotplug to be affected when we try to send an IPI to it.

The fix is in migrate_irqs_away, the fix does the following:

1. It moves the setting of CPPR to after all IRQ migration
   is complete
2. In icp-opal, we ignore masking the CPPR when the CPPR
is set to default priority, anything else we just pass
through

Right now this fix is designed with backporting to stable
in mind

We'll need a newer version of this later when we merge the
DEFAULT and IPI priorities to the same value in the kernel.

Fixes: d74361881f0d ("powerpc/xics: Add ICP OPAL backend")
Cc: stable@vger.kernel.org (v4.8+)

Testing

1. I've tested this fix on a virtual partition running under
   kvm
2. Gautham and Vaidy have done some testing on an system that
   uses the OPAL backend
3. I've also tested this on a system with a native XICS controller

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Reported-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Tested-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/sysdev/xics/icp-opal.c    | 12 ++++++++++++
 arch/powerpc/sysdev/xics/xics-common.c | 19 ++++++++++++++++---
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/xics/icp-opal.c b/arch/powerpc/sysdev/xics/icp-opal.c
index f9670ea..77cdb36 100644
--- a/arch/powerpc/sysdev/xics/icp-opal.c
+++ b/arch/powerpc/sysdev/xics/icp-opal.c
@@ -91,6 +91,18 @@ static unsigned int icp_opal_get_irq(void)
 
 static void icp_opal_set_cpu_priority(unsigned char cppr)
 {
+	/*
+	 * Mask only IPI's and not external interrupts
+	 * XIVE emulation of XICS exposed as an OPAL
+	 * interface uses just one priority level for
+	 * both external and IPI's. By dropping default
+	 * priority to lowest, we leave all interrupts
+	 * on, assuming the only caller is migrate_irqs_away
+	 * at the time of CPU hotplug
+	 */
+	if (cppr == DEFAULT_PRIORITY)
+		cppr = LOWEST_PRIORITY;
+
 	xics_set_base_cppr(cppr);
 	opal_int_set_cppr(cppr);
 	iosync();
diff --git a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
index 69d858e..f025320 100644
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
-	icp_ops->set_priority(DEFAULT_PRIORITY);
-
 	for_each_irq_desc(virq, desc) {
 		struct irq_chip *chip;
 		long server;
@@ -255,6 +253,21 @@ void xics_migrate_irqs_away(void)
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
+	 * only get woken up by an IPI interrupt beyond this point.
+	 * For this to work, we have a hack when icp_ops are OPAL
+	 * ops.
+	 */
+	icp_ops->set_priority(DEFAULT_PRIORITY);
+
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
-- 
2.9.3

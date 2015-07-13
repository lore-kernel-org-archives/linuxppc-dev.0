Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5E7731A0490
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 06:50:29 +1000 (AEST)
Message-Id: <20150713135740.079385036@linutronix.de>
Date: Mon, 13 Jul 2015 20:50:20 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Jiang Liu <jiang.liu@linux.intel.com>
Subject: [patch 13/20] powerpc/irq: Use access helper
 irq_data_get_affinity_mask()
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

From: Jiang Liu <jiang.liu@linux.intel.com>

This is a preparatory patch for moving irq_data struct members.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/kernel/irq.c           |    2 +-
 arch/powerpc/sysdev/xics/ics-opal.c |    2 +-
 arch/powerpc/sysdev/xics/ics-rtas.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

Index: tip/arch/powerpc/kernel/irq.c
===================================================================
--- tip.orig/arch/powerpc/kernel/irq.c
+++ tip/arch/powerpc/kernel/irq.c
@@ -441,7 +441,7 @@ void migrate_irqs(void)
 
 		chip = irq_data_get_irq_chip(data);
 
-		cpumask_and(mask, data->affinity, map);
+		cpumask_and(mask, irq_data_get_affinity_mask(data), map);
 		if (cpumask_any(mask) >= nr_cpu_ids) {
 			pr_warn("Breaking affinity for irq %i\n", irq);
 			cpumask_copy(mask, map);
Index: tip/arch/powerpc/sysdev/xics/ics-opal.c
===================================================================
--- tip.orig/arch/powerpc/sysdev/xics/ics-opal.c
+++ tip/arch/powerpc/sysdev/xics/ics-opal.c
@@ -54,7 +54,7 @@ static void ics_opal_unmask_irq(struct i
 	if (hw_irq == XICS_IPI || hw_irq == XICS_IRQ_SPURIOUS)
 		return;
 
-	server = xics_get_irq_server(d->irq, d->affinity, 0);
+	server = xics_get_irq_server(d->irq, irq_data_get_affinity_mask(d), 0);
 	server = ics_opal_mangle_server(server);
 
 	rc = opal_set_xive(hw_irq, server, DEFAULT_PRIORITY);
Index: tip/arch/powerpc/sysdev/xics/ics-rtas.c
===================================================================
--- tip.orig/arch/powerpc/sysdev/xics/ics-rtas.c
+++ tip/arch/powerpc/sysdev/xics/ics-rtas.c
@@ -47,7 +47,7 @@ static void ics_rtas_unmask_irq(struct i
 	if (hw_irq == XICS_IPI || hw_irq == XICS_IRQ_SPURIOUS)
 		return;
 
-	server = xics_get_irq_server(d->irq, d->affinity, 0);
+	server = xics_get_irq_server(d->irq, irq_data_get_affinity_mask(d), 0);
 
 	call_status = rtas_call(ibm_set_xive, 3, 1, NULL, hw_irq, server,
 				DEFAULT_PRIORITY);

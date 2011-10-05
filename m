Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
	[IPv6:2001:470:1f0b:1c35:abcd:42:0:1])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AA9EDB6F8F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Oct 2011 23:30:59 +1100 (EST)
Message-Id: <20111005122747.341936579@linutronix.de>
Date: Wed, 05 Oct 2011 12:30:50 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [patch 3/4] powerpc: Mark IPI interrupts IRQF_NO_THREAD
References: <20111005122122.553832402@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

IPI handlers cannot be threaded. Remove the obsolete IRQF_DISABLED
flag (see commit e58aa3d2) while at it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/kernel/smp.c              |    2 +-
 arch/powerpc/platforms/powermac/smp.c  |    4 ++--
 arch/powerpc/sysdev/xics/xics-common.c |    6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

Index: linux-2.6/arch/powerpc/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/smp.c
+++ linux-2.6/arch/powerpc/kernel/smp.c
@@ -170,7 +170,7 @@ int smp_request_message_ipi(int virq, in
 		return 1;
 	}
 #endif
-	err = request_irq(virq, smp_ipi_action[msg], IRQF_DISABLED|IRQF_PERCPU,
+	err = request_irq(virq, smp_ipi_action[msg], IRQF_NO_THREAD|IRQF_PERCPU,
 			  smp_ipi_name[msg], 0);
 	WARN(err < 0, "unable to request_irq %d for %s (rc %d)\n",
 		virq, smp_ipi_name[msg], err);
Index: linux-2.6/arch/powerpc/platforms/powermac/smp.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/powermac/smp.c
+++ linux-2.6/arch/powerpc/platforms/powermac/smp.c
@@ -200,7 +200,7 @@ static int psurge_secondary_ipi_init(voi
 
 	if (psurge_secondary_virq)
 		rc = request_irq(psurge_secondary_virq, psurge_ipi_intr,
-			IRQF_DISABLED|IRQF_PERCPU, "IPI", NULL);
+			IRQF_NO_THREAD|IRQF_PERCPU, "IPI", NULL);
 
 	if (rc)
 		pr_err("Failed to setup secondary cpu IPI\n");
@@ -408,7 +408,7 @@ static int __init smp_psurge_kick_cpu(in
 
 static struct irqaction psurge_irqaction = {
 	.handler = psurge_ipi_intr,
-	.flags = IRQF_DISABLED|IRQF_PERCPU,
+	.flags = IRQF_NO_THREAD|IRQF_PERCPU,
 	.name = "primary IPI",
 };
 
Index: linux-2.6/arch/powerpc/sysdev/xics/xics-common.c
===================================================================
--- linux-2.6.orig/arch/powerpc/sysdev/xics/xics-common.c
+++ linux-2.6/arch/powerpc/sysdev/xics/xics-common.c
@@ -134,11 +134,11 @@ static void xics_request_ipi(void)
 	BUG_ON(ipi == NO_IRQ);
 
 	/*
-	 * IPIs are marked IRQF_DISABLED as they must run with irqs
-	 * disabled, and PERCPU.  The handler was set in map.
+	 * IPIs are marked PERCPU and also IRQF_NO_THREAD as they must
+	 * run in hard interrupt context. The handler was set in map.
 	 */
 	BUG_ON(request_irq(ipi, icp_ops->ipi_action,
-			   IRQF_DISABLED|IRQF_PERCPU, "IPI", NULL));
+			   IRQF_NO_THREAD|IRQF_PERCPU, "IPI", NULL));
 }
 
 int __init xics_smp_probe(void)

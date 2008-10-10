Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1DE3CDE140
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 22:56:43 +1100 (EST)
Date: Fri, 10 Oct 2008 06:56:34 -0500 (CDT)
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: linuxppc-dev@ozlabs.org, Ben Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Message-id: <patch-xics-8@bga.com>
In-Reply-To: <patch-xics-0@bga.com>
Subject: [PATCH 8/16] xics: factor out giq set and unset
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There is a bit of math to calculate the arguments to rtas to join
or leave the global interrupt queue, and a warning on failure
afterwards.  Make a helper for the 3 callers.

Signed-off-by: Milton Miller <miltonm@bga.com>

Index: next.git/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- next.git.orig/arch/powerpc/platforms/pseries/xics.c	2008-10-04 17:40:00.000000000 -0500
+++ next.git/arch/powerpc/platforms/pseries/xics.c	2008-10-04 17:42:53.000000000 -0500
@@ -727,20 +727,19 @@ static void xics_set_cpu_priority(unsign
 	iosync();
 }
 
+/* Have the calling processor join or leave the specified global queue */
+static void xics_set_cpu_giq(unsigned int gserver, unsigned int join)
+{
+	int status = rtas_set_indicator_fast(GLOBAL_INTERRUPT_QUEUE,
+		(1UL << interrupt_server_size) - 1 - gserver, join);
+	WARN_ON(status < 0);
+}
 
 void xics_setup_cpu(void)
 {
 	xics_set_cpu_priority(0xff);
 
-	/*
-	 * Put the calling processor into the GIQ.  This is really only
-	 * necessary from a secondary thread as the OF start-cpu interface
-	 * performs this function for us on primary threads.
-	 *
-	 * XXX: undo of teardown on kexec needs this too, as may hotplug
-	 */
-	rtas_set_indicator_fast(GLOBAL_INTERRUPT_QUEUE,
-		(1UL << interrupt_server_size) - 1 - default_distrib_server, 1);
+	xics_set_cpu_giq(default_distrib_server, 1);
 }
 
 void xics_teardown_cpu(void)
@@ -749,9 +748,7 @@ void xics_teardown_cpu(void)
 
 	xics_set_cpu_priority(0);
 
-	/*
-	 * Clear IPI
-	 */
+	/* Clear any pending IPI request */
 	if (firmware_has_feature(FW_FEATURE_LPAR))
 		lpar_qirr_info(cpu, 0xff);
 	else
@@ -785,9 +782,7 @@ void xics_kexec_teardown_cpu(int seconda
 	 * so leave the master cpu in the group.
 	 */
 	if (secondary)
-		rtas_set_indicator_fast(GLOBAL_INTERRUPT_QUEUE,
-				   (1UL << interrupt_server_size) - 1 -
-				   default_distrib_server, 0);
+		xics_set_cpu_giq(default_distrib_server, 0);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -795,7 +790,6 @@ void xics_kexec_teardown_cpu(int seconda
 /* Interrupts are disabled. */
 void xics_migrate_irqs_away(void)
 {
-	int status;
 	int cpu = smp_processor_id(), hw_cpu = hard_smp_processor_id();
 	unsigned int irq, virq;
 
@@ -806,10 +800,8 @@ void xics_migrate_irqs_away(void)
 	/* Reject any interrupt that was queued to us... */
 	xics_set_cpu_priority(0);
 
-	/* remove ourselves from the global interrupt queue */
-	status = rtas_set_indicator_fast(GLOBAL_INTERRUPT_QUEUE,
-		(1UL << interrupt_server_size) - 1 - default_distrib_server, 0);
-	WARN_ON(status < 0);
+	/* Remove ourselves from the global interrupt queue */
+	xics_set_cpu_giq(default_distrib_server, 0);
 
 	/* Allow IPIs again... */
 	xics_set_cpu_priority(DEFAULT_PRIORITY);
@@ -817,6 +809,7 @@ void xics_migrate_irqs_away(void)
 	for_each_irq(virq) {
 		struct irq_desc *desc;
 		int xics_status[2];
+		int status;
 		unsigned long flags;
 
 		/* We cant set affinity on ISA interrupts */

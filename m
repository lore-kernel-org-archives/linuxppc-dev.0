Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CB218DDFE2
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 22:56:36 +1100 (EST)
Date: Fri, 10 Oct 2008 06:56:29 -0500 (CDT)
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: linuxppc-dev@ozlabs.org, Ben Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Message-id: <patch-xics-3@bga.com>
In-Reply-To: <patch-xics-0@bga.com>
Subject: [PATCH 3/16] xics: consolidate ipi message encode and decode
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

xics supports only one ipi per cpu, and expects software to use some
queue to know why the interrupt was sent.  In Linux, we use a an array
of bitmaps indexed by cpu to identify the message.  Currently the bits
are set in smp.c and decoded in xics.c, with the data structure in a
header file.   Consolidate the code in xics.c similar to mpic and other
interrupt controllers.

Also, while making the the array static, the message word doesn't need
to be volatile as set_bit and test_clear_bit take care of it for us, and
put it under ifdef smp.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
iseries and powermac psurge have similar code due to only one ipi,
but they don't spread out the lines by cachelines for scalability
like pseries.  Since that is one other platform per arch head, I
left the code replicated.

I kept smp_xics_cpu_setup in smp.c as the vpa init is unrelated.

Index: next.git/arch/powerpc/platforms/pseries/smp.c
===================================================================
--- next.git.orig/arch/powerpc/platforms/pseries/smp.c	2008-10-04 16:34:45.000000000 -0500
+++ next.git/arch/powerpc/platforms/pseries/smp.c	2008-10-04 16:37:39.000000000 -0500
@@ -37,7 +37,6 @@
 #include <asm/paca.h>
 #include <asm/time.h>
 #include <asm/machdep.h>
-#include "xics.h"
 #include <asm/cputable.h>
 #include <asm/firmware.h>
 #include <asm/system.h>
@@ -49,6 +48,7 @@
 
 #include "plpar_wrappers.h"
 #include "pseries.h"
+#include "xics.h"
 
 
 /*
@@ -105,36 +105,6 @@ static inline int __devinit smp_startup_
 }
 
 #ifdef CONFIG_XICS
-static inline void smp_xics_do_message(int cpu, int msg)
-{
-	set_bit(msg, &xics_ipi_message[cpu].value);
-	mb();
-	xics_cause_IPI(cpu);
-}
-
-static void smp_xics_message_pass(int target, int msg)
-{
-	unsigned int i;
-
-	if (target < NR_CPUS) {
-		smp_xics_do_message(target, msg);
-	} else {
-		for_each_online_cpu(i) {
-			if (target == MSG_ALL_BUT_SELF
-			    && i == smp_processor_id())
-				continue;
-			smp_xics_do_message(i, msg);
-		}
-	}
-}
-
-static int __init smp_xics_probe(void)
-{
-	xics_request_IPIs();
-
-	return cpus_weight(cpu_possible_map);
-}
-
 static void __devinit smp_xics_setup_cpu(int cpu)
 {
 	if (cpu != boot_cpuid)
Index: next.git/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- next.git.orig/arch/powerpc/platforms/pseries/xics.c	2008-10-04 16:36:09.000000000 -0500
+++ next.git/arch/powerpc/platforms/pseries/xics.c	2008-10-04 17:09:57.000000000 -0500
@@ -71,11 +71,6 @@ static unsigned int interrupt_server_siz
 
 static struct irq_host *xics_host;
 
-/*
- * XICS only has a single IPI, so encode the messages per CPU
- */
-struct xics_ipi_struct xics_ipi_message[NR_CPUS] __cacheline_aligned;
-
 /* RTAS service tokens */
 static int ibm_get_xive;
 static int ibm_set_xive;
@@ -201,6 +196,15 @@ static void xics_update_irq_servers(void
 }
 
 #ifdef CONFIG_SMP
+/*
+ * XICS only has a single IPI, so encode the messages per CPU
+ */
+struct xics_ipi_struct {
+        unsigned long value;
+	} ____cacheline_aligned;
+
+static struct xics_ipi_struct xics_ipi_message[NR_CPUS] __cacheline_aligned;
+
 static int get_irq_server(unsigned int virq, unsigned int strict_check)
 {
 	int server;
@@ -387,7 +391,6 @@ static unsigned int xics_get_irq_lpar(vo
 }
 
 #ifdef CONFIG_SMP
-
 static irqreturn_t xics_ipi_dispatch(int cpu)
 {
 	WARN_ON(cpu_is_offline(cpu));
@@ -419,6 +422,33 @@ static irqreturn_t xics_ipi_dispatch(int
 	return IRQ_HANDLED;
 }
 
+static inline void smp_xics_do_message(int cpu, int msg)
+{
+	set_bit(msg, &xics_ipi_message[cpu].value);
+	mb();
+	if (firmware_has_feature(FW_FEATURE_LPAR))
+		lpar_qirr_info(cpu, IPI_PRIORITY);
+	else
+		direct_qirr_info(cpu, IPI_PRIORITY);
+}
+
+void smp_xics_message_pass(int target, int msg)
+{
+	unsigned int i;
+
+	if (target < NR_CPUS) {
+		smp_xics_do_message(target, msg);
+	} else {
+		for_each_online_cpu(i) {
+			if (target == MSG_ALL_BUT_SELF
+			    && i == smp_processor_id())
+				continue;
+			smp_xics_do_message(i, msg);
+		}
+	}
+}
+
+
 static irqreturn_t xics_ipi_action_direct(int irq, void *dev_id)
 {
 	int cpu = smp_processor_id();
@@ -436,15 +466,6 @@ static irqreturn_t xics_ipi_action_lpar(
 
 	return xics_ipi_dispatch(cpu);
 }
-
-void xics_cause_IPI(int cpu)
-{
-	if (firmware_has_feature(FW_FEATURE_LPAR))
-		lpar_qirr_info(cpu, IPI_PRIORITY);
-	else
-		direct_qirr_info(cpu, IPI_PRIORITY);
-}
-
 #endif /* CONFIG_SMP */
 
 static void xics_set_cpu_priority(unsigned char cppr)
@@ -697,7 +718,7 @@ void __init xics_init_IRQ(void)
 
 
 #ifdef CONFIG_SMP
-void xics_request_IPIs(void)
+static void xics_request_ipi(void)
 {
 	unsigned int ipi;
 	int rc;
@@ -718,6 +739,14 @@ void xics_request_IPIs(void)
 				"IPI", NULL);
 	BUG_ON(rc);
 }
+
+int __init smp_xics_probe(void)
+{
+	xics_request_ipi();
+
+	return cpus_weight(cpu_possible_map);
+}
+
 #endif /* CONFIG_SMP */
 
 void xics_teardown_cpu(void)
Index: next.git/arch/powerpc/platforms/pseries/xics.h
===================================================================
--- next.git.orig/arch/powerpc/platforms/pseries/xics.h	2008-10-04 16:34:45.000000000 -0500
+++ next.git/arch/powerpc/platforms/pseries/xics.h	2008-10-04 16:51:10.000000000 -0500
@@ -12,20 +12,12 @@
 #ifndef _POWERPC_KERNEL_XICS_H
 #define _POWERPC_KERNEL_XICS_H
 
-#include <linux/cache.h>
-
 extern void xics_init_IRQ(void);
 extern void xics_setup_cpu(void);
 extern void xics_teardown_cpu(void);
 extern void xics_kexec_teardown_cpu(int secondary);
-extern void xics_cause_IPI(int cpu);
-extern  void xics_request_IPIs(void);
 extern void xics_migrate_irqs_away(void);
-
-struct xics_ipi_struct {
-	volatile unsigned long value;
-} ____cacheline_aligned;
-
-extern struct xics_ipi_struct xics_ipi_message[NR_CPUS] __cacheline_aligned;
+extern int smp_xics_probe(void);
+extern void smp_xics_message_pass(int target, int msg);
 
 #endif /* _POWERPC_KERNEL_XICS_H */

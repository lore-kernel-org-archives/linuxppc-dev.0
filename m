Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5E2DDDE061
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 22:56:37 +1100 (EST)
Date: Fri, 10 Oct 2008 06:56:30 -0500 (CDT)
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: linuxppc-dev@ozlabs.org, Ben Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Message-id: <patch-xics-4@bga.com>
In-Reply-To: <patch-xics-0@bga.com>
Subject: [PATCH 4/16] xics: rearrange file to group code by function
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that xics_update_irq_servers is called only from init and hotplug
code, it becomes possible to clean up the ordering of functions in the
file, grouping them but the interfaces they implement.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
This patch is pure function reordering and comments.

This patch applies to -next.  For prior kernels, there are 6 more lines
in xics_startup() that affect patch application.

Index: next.git/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- next.git.orig/arch/powerpc/platforms/pseries/xics.c	2008-10-04 17:09:57.000000000 -0500
+++ next.git/arch/powerpc/platforms/pseries/xics.c	2008-10-04 17:39:02.000000000 -0500
@@ -9,7 +9,6 @@
  *  2 of the License, or (at your option) any later version.
  */
 
-
 #include <linux/types.h>
 #include <linux/threads.h>
 #include <linux/kernel.h>
@@ -35,6 +34,8 @@
 #include "xics.h"
 #include "plpar_wrappers.h"
 
+static struct irq_host *xics_host;
+
 #define XICS_IPI		2
 #define XICS_IRQ_SPURIOUS	0
 
@@ -47,6 +48,20 @@
  */
 #define IPI_PRIORITY		4
 
+static unsigned int default_server = 0xFF;
+static unsigned int default_distrib_server = 0;
+static unsigned int interrupt_server_size = 8;
+
+/* RTAS service tokens */
+static int ibm_get_xive;
+static int ibm_set_xive;
+static int ibm_int_on;
+static int ibm_int_off;
+
+
+/* Direct hardware low level accessors */
+
+/* The part of the interrupt presentation layer that we care about */
 struct xics_ipl {
 	union {
 		u32 word;
@@ -65,22 +80,6 @@ struct xics_ipl {
 
 static struct xics_ipl __iomem *xics_per_cpu[NR_CPUS];
 
-static unsigned int default_server = 0xFF;
-static unsigned int default_distrib_server = 0;
-static unsigned int interrupt_server_size = 8;
-
-static struct irq_host *xics_host;
-
-/* RTAS service tokens */
-static int ibm_get_xive;
-static int ibm_set_xive;
-static int ibm_int_on;
-static int ibm_int_off;
-
-
-/* Direct HW low level accessors */
-
-
 static inline unsigned int direct_xirr_info_get(void)
 {
 	int cpu = smp_processor_id();
@@ -110,7 +109,6 @@ static inline void direct_qirr_info(int 
 
 /* LPAR low level accessors */
 
-
 static inline unsigned int lpar_xirr_info_get(void)
 {
 	unsigned long lpar_rc;
@@ -152,59 +150,9 @@ static inline void lpar_qirr_info(int n_
 }
 
 
-/* High level handlers and init code */
-
-static void xics_update_irq_servers(void)
-{
-	int i, j;
-	struct device_node *np;
-	u32 ilen;
-	const u32 *ireg, *isize;
-	u32 hcpuid;
-
-	/* Find the server numbers for the boot cpu. */
-	np = of_get_cpu_node(boot_cpuid, NULL);
-	BUG_ON(!np);
-
-	ireg = of_get_property(np, "ibm,ppc-interrupt-gserver#s", &ilen);
-	if (!ireg) {
-		of_node_put(np);
-		return;
-	}
-
-	i = ilen / sizeof(int);
-	hcpuid = get_hard_smp_processor_id(boot_cpuid);
-
-	/* Global interrupt distribution server is specified in the last
-	 * entry of "ibm,ppc-interrupt-gserver#s" property. Get the last
-	 * entry fom this property for current boot cpu id and use it as
-	 * default distribution server
-	 */
-	for (j = 0; j < i; j += 2) {
-		if (ireg[j] == hcpuid) {
-			default_server = hcpuid;
-			default_distrib_server = ireg[j+1];
-
-			isize = of_get_property(np,
-					"ibm,interrupt-server#-size", NULL);
-			if (isize)
-				interrupt_server_size = *isize;
-		}
-	}
-
-	of_node_put(np);
-}
+/* Interface to generic irq subsystem */
 
 #ifdef CONFIG_SMP
-/*
- * XICS only has a single IPI, so encode the messages per CPU
- */
-struct xics_ipi_struct {
-        unsigned long value;
-	} ____cacheline_aligned;
-
-static struct xics_ipi_struct xics_ipi_message[NR_CPUS] __cacheline_aligned;
-
 static int get_irq_server(unsigned int virq, unsigned int strict_check)
 {
 	int server;
@@ -239,7 +187,6 @@ static int get_irq_server(unsigned int v
 }
 #endif
 
-
 static void xics_unmask_irq(unsigned int virq)
 {
 	unsigned int irq;
@@ -273,6 +220,13 @@ static void xics_unmask_irq(unsigned int
 	}
 }
 
+static unsigned int xics_startup(unsigned int virq)
+{
+	/* unmask it */
+	xics_unmask_irq(virq);
+	return 0;
+}
+
 static void xics_mask_real_irq(unsigned int irq)
 {
 	int call_status;
@@ -309,28 +263,10 @@ static void xics_mask_irq(unsigned int v
 	xics_mask_real_irq(irq);
 }
 
-static unsigned int xics_startup(unsigned int virq)
-{
-	/* unmask it */
-	xics_unmask_irq(virq);
-	return 0;
-}
-
-static void xics_eoi_direct(unsigned int virq)
-{
-	unsigned int irq = (unsigned int)irq_map[virq].hwirq;
-
-	iosync();
-	direct_xirr_info_set((0xff << 24) | irq);
-}
-
-
-static void xics_eoi_lpar(unsigned int virq)
+static void xics_mask_unknown_vec(unsigned int vec)
 {
-	unsigned int irq = (unsigned int)irq_map[virq].hwirq;
-
-	iosync();
-	lpar_xirr_info_set((0xff << 24) | irq);
+	printk(KERN_ERR "Interrupt %u (real) is invalid, disabling it.\n", vec);
+	xics_mask_real_irq(vec);
 }
 
 static inline unsigned int xics_xirr_vector(unsigned int xirr)
@@ -342,12 +278,6 @@ static inline unsigned int xics_xirr_vec
 	return xirr & 0x00ffffff;
 }
 
-static void xics_mask_unknown_vec(unsigned int vec)
-{
-	printk(KERN_ERR "Interrupt %u (real) is invalid, disabling it.\n", vec);
-	xics_mask_real_irq(vec);
-}
-
 static unsigned int xics_get_irq_direct(void)
 {
 	unsigned int xirr = direct_xirr_info_get();
@@ -390,91 +320,20 @@ static unsigned int xics_get_irq_lpar(vo
 	return NO_IRQ;
 }
 
-#ifdef CONFIG_SMP
-static irqreturn_t xics_ipi_dispatch(int cpu)
-{
-	WARN_ON(cpu_is_offline(cpu));
-
-	while (xics_ipi_message[cpu].value) {
-		if (test_and_clear_bit(PPC_MSG_CALL_FUNCTION,
-				       &xics_ipi_message[cpu].value)) {
-			mb();
-			smp_message_recv(PPC_MSG_CALL_FUNCTION);
-		}
-		if (test_and_clear_bit(PPC_MSG_RESCHEDULE,
-				       &xics_ipi_message[cpu].value)) {
-			mb();
-			smp_message_recv(PPC_MSG_RESCHEDULE);
-		}
-		if (test_and_clear_bit(PPC_MSG_CALL_FUNC_SINGLE,
-				       &xics_ipi_message[cpu].value)) {
-			mb();
-			smp_message_recv(PPC_MSG_CALL_FUNC_SINGLE);
-		}
-#if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)
-		if (test_and_clear_bit(PPC_MSG_DEBUGGER_BREAK,
-				       &xics_ipi_message[cpu].value)) {
-			mb();
-			smp_message_recv(PPC_MSG_DEBUGGER_BREAK);
-		}
-#endif
-	}
-	return IRQ_HANDLED;
-}
-
-static inline void smp_xics_do_message(int cpu, int msg)
-{
-	set_bit(msg, &xics_ipi_message[cpu].value);
-	mb();
-	if (firmware_has_feature(FW_FEATURE_LPAR))
-		lpar_qirr_info(cpu, IPI_PRIORITY);
-	else
-		direct_qirr_info(cpu, IPI_PRIORITY);
-}
-
-void smp_xics_message_pass(int target, int msg)
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
-
-static irqreturn_t xics_ipi_action_direct(int irq, void *dev_id)
+static void xics_eoi_direct(unsigned int virq)
 {
-	int cpu = smp_processor_id();
-
-	direct_qirr_info(cpu, 0xff);
+	unsigned int irq = (unsigned int)irq_map[virq].hwirq;
 
-	return xics_ipi_dispatch(cpu);
+	iosync();
+	direct_xirr_info_set((0xff << 24) | irq);
 }
 
-static irqreturn_t xics_ipi_action_lpar(int irq, void *dev_id)
+static void xics_eoi_lpar(unsigned int virq)
 {
-	int cpu = smp_processor_id();
-
-	lpar_qirr_info(cpu, 0xff);
-
-	return xics_ipi_dispatch(cpu);
-}
-#endif /* CONFIG_SMP */
+	unsigned int irq = (unsigned int)irq_map[virq].hwirq;
 
-static void xics_set_cpu_priority(unsigned char cppr)
-{
-	if (firmware_has_feature(FW_FEATURE_LPAR))
-		lpar_cppr_info(cppr);
-	else
-		direct_cppr_info(cppr);
 	iosync();
+	lpar_xirr_info_set((0xff << 24) | irq);
 }
 
 static void xics_set_affinity(unsigned int virq, cpumask_t cpumask)
@@ -519,22 +378,6 @@ static void xics_set_affinity(unsigned i
 	}
 }
 
-void xics_setup_cpu(void)
-{
-	xics_set_cpu_priority(0xff);
-
-	/*
-	 * Put the calling processor into the GIQ.  This is really only
-	 * necessary from a secondary thread as the OF start-cpu interface
-	 * performs this function for us on primary threads.
-	 *
-	 * XXX: undo of teardown on kexec needs this too, as may hotplug
-	 */
-	rtas_set_indicator_fast(GLOBAL_INTERRUPT_QUEUE,
-		(1UL << interrupt_server_size) - 1 - default_distrib_server, 1);
-}
-
-
 static struct irq_chip xics_pic_direct = {
 	.typename = " XICS     ",
 	.startup = xics_startup,
@@ -544,7 +387,6 @@ static struct irq_chip xics_pic_direct =
 	.set_affinity = xics_set_affinity
 };
 
-
 static struct irq_chip xics_pic_lpar = {
 	.typename = " XICS     ",
 	.startup = xics_startup,
@@ -554,6 +396,9 @@ static struct irq_chip xics_pic_lpar = {
 	.set_affinity = xics_set_affinity
 };
 
+
+/* Interface to arch irq controller subsystem layer */
+
 /* Points to the irq_chip we're actually using */
 static struct irq_chip *xics_irq_chip;
 
@@ -613,6 +458,169 @@ static void __init xics_init_host(void)
 	irq_set_default_host(xics_host);
 }
 
+
+/* Inter-processor interrupt support */
+
+#ifdef CONFIG_SMP
+/*
+ * XICS only has a single IPI, so encode the messages per CPU
+ */
+struct xics_ipi_struct {
+        unsigned long value;
+	} ____cacheline_aligned;
+
+static struct xics_ipi_struct xics_ipi_message[NR_CPUS] __cacheline_aligned;
+
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
+static irqreturn_t xics_ipi_dispatch(int cpu)
+{
+	WARN_ON(cpu_is_offline(cpu));
+
+	while (xics_ipi_message[cpu].value) {
+		if (test_and_clear_bit(PPC_MSG_CALL_FUNCTION,
+				       &xics_ipi_message[cpu].value)) {
+			mb();
+			smp_message_recv(PPC_MSG_CALL_FUNCTION);
+		}
+		if (test_and_clear_bit(PPC_MSG_RESCHEDULE,
+				       &xics_ipi_message[cpu].value)) {
+			mb();
+			smp_message_recv(PPC_MSG_RESCHEDULE);
+		}
+		if (test_and_clear_bit(PPC_MSG_CALL_FUNC_SINGLE,
+				       &xics_ipi_message[cpu].value)) {
+			mb();
+			smp_message_recv(PPC_MSG_CALL_FUNC_SINGLE);
+		}
+#if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)
+		if (test_and_clear_bit(PPC_MSG_DEBUGGER_BREAK,
+				       &xics_ipi_message[cpu].value)) {
+			mb();
+			smp_message_recv(PPC_MSG_DEBUGGER_BREAK);
+		}
+#endif
+	}
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t xics_ipi_action_direct(int irq, void *dev_id)
+{
+	int cpu = smp_processor_id();
+
+	direct_qirr_info(cpu, 0xff);
+
+	return xics_ipi_dispatch(cpu);
+}
+
+static irqreturn_t xics_ipi_action_lpar(int irq, void *dev_id)
+{
+	int cpu = smp_processor_id();
+
+	lpar_qirr_info(cpu, 0xff);
+
+	return xics_ipi_dispatch(cpu);
+}
+
+static void xics_request_ipi(void)
+{
+	unsigned int ipi;
+	int rc;
+
+	ipi = irq_create_mapping(xics_host, XICS_IPI);
+	BUG_ON(ipi == NO_IRQ);
+
+	/*
+	 * IPIs are marked IRQF_DISABLED as they must run with irqs
+	 * disabled
+	 */
+	set_irq_handler(ipi, handle_percpu_irq);
+	if (firmware_has_feature(FW_FEATURE_LPAR))
+		rc = request_irq(ipi, xics_ipi_action_lpar, IRQF_DISABLED,
+				"IPI", NULL);
+	else
+		rc = request_irq(ipi, xics_ipi_action_direct, IRQF_DISABLED,
+				"IPI", NULL);
+	BUG_ON(rc);
+}
+
+int __init smp_xics_probe(void)
+{
+	xics_request_ipi();
+
+	return cpus_weight(cpu_possible_map);
+}
+
+#endif /* CONFIG_SMP */
+
+
+/* Initialization */
+
+static void xics_update_irq_servers(void)
+{
+	int i, j;
+	struct device_node *np;
+	u32 ilen;
+	const u32 *ireg, *isize;
+	u32 hcpuid;
+
+	/* Find the server numbers for the boot cpu. */
+	np = of_get_cpu_node(boot_cpuid, NULL);
+	BUG_ON(!np);
+
+	ireg = of_get_property(np, "ibm,ppc-interrupt-gserver#s", &ilen);
+	if (!ireg) {
+		of_node_put(np);
+		return;
+	}
+
+	i = ilen / sizeof(int);
+	hcpuid = get_hard_smp_processor_id(boot_cpuid);
+
+	/* Global interrupt distribution server is specified in the last
+	 * entry of "ibm,ppc-interrupt-gserver#s" property. Get the last
+	 * entry fom this property for current boot cpu id and use it as
+	 * default distribution server
+	 */
+	for (j = 0; j < i; j += 2) {
+		if (ireg[j] == hcpuid) {
+			default_server = hcpuid;
+			default_distrib_server = ireg[j+1];
+
+			isize = of_get_property(np,
+					"ibm,interrupt-server#-size", NULL);
+			if (isize)
+				interrupt_server_size = *isize;
+		}
+	}
+
+	of_node_put(np);
+}
+
 static void __init xics_map_one_cpu(int hw_id, unsigned long addr,
 				     unsigned long size)
 {
@@ -716,39 +724,33 @@ void __init xics_init_IRQ(void)
 	ppc64_boot_msg(0x21, "XICS Done");
 }
 
+/* Cpu startup, shutdown, and hotplug */
 
-#ifdef CONFIG_SMP
-static void xics_request_ipi(void)
+static void xics_set_cpu_priority(unsigned char cppr)
 {
-	unsigned int ipi;
-	int rc;
-
-	ipi = irq_create_mapping(xics_host, XICS_IPI);
-	BUG_ON(ipi == NO_IRQ);
-
-	/*
-	 * IPIs are marked IRQF_DISABLED as they must run with irqs
-	 * disabled
-	 */
-	set_irq_handler(ipi, handle_percpu_irq);
 	if (firmware_has_feature(FW_FEATURE_LPAR))
-		rc = request_irq(ipi, xics_ipi_action_lpar, IRQF_DISABLED,
-				"IPI", NULL);
+		lpar_cppr_info(cppr);
 	else
-		rc = request_irq(ipi, xics_ipi_action_direct, IRQF_DISABLED,
-				"IPI", NULL);
-	BUG_ON(rc);
+		direct_cppr_info(cppr);
+	iosync();
 }
 
-int __init smp_xics_probe(void)
+
+void xics_setup_cpu(void)
 {
-	xics_request_ipi();
+	xics_set_cpu_priority(0xff);
 
-	return cpus_weight(cpu_possible_map);
+	/*
+	 * Put the calling processor into the GIQ.  This is really only
+	 * necessary from a secondary thread as the OF start-cpu interface
+	 * performs this function for us on primary threads.
+	 *
+	 * XXX: undo of teardown on kexec needs this too, as may hotplug
+	 */
+	rtas_set_indicator_fast(GLOBAL_INTERRUPT_QUEUE,
+		(1UL << interrupt_server_size) - 1 - default_distrib_server, 1);
 }
 
-#endif /* CONFIG_SMP */
-
 void xics_teardown_cpu(void)
 {
 	int cpu = smp_processor_id();

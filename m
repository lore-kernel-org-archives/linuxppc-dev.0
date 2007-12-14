Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A070FDE036
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 15:52:13 +1100 (EST)
Date: Thu, 13 Dec 2007 22:52:09 -0600 (CST)
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/6] push down or eliminate smp_processor_id in xics
In-Reply-To: <mm-cpu-0@bga.com>
Message-Id: <mm-cpu-1@bga.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Delay callling smp_processor_id until its needed.

The per-processor interrupt request register and current processor 
priority register are only accessed on the current cpu.  In fact the
hypervisor doesn't even let us choose this.

The only function to use cpu twice is xics_migrate_irqs_away, not a fast
path.  But we can cache the result of get_hard_processor_id() instead of
calling get_hard_smp_processor_id(cpu) in a loop across the call to rtas.

Years ago the irq code passed smp_processor_id into get_irq, I thought
we might initialize the CPPR third party at boot as an extra measure of
saftey, and it made the code symetric with the qirr (queued interrupt for
software generated interrupts), but now it is just extra and sometimes
unneeded work to pass it down.

Signed-off-by: Milton Miller <miltonm@bga.com>
---

Index: kernel/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- kernel.orig/arch/powerpc/platforms/pseries/xics.c	2007-10-10 03:44:55.000000000 -0500
+++ kernel/arch/powerpc/platforms/pseries/xics.c	2007-10-10 04:28:58.000000000 -0500
@@ -87,19 +87,25 @@ static int ibm_int_off;
 /* Direct HW low level accessors */
 
 
-static inline unsigned int direct_xirr_info_get(int n_cpu)
+static inline unsigned int direct_xirr_info_get(void)
 {
-	return in_be32(&xics_per_cpu[n_cpu]->xirr.word);
+	int cpu = smp_processor_id();
+
+	return in_be32(&xics_per_cpu[cpu]->xirr.word);
 }
 
-static inline void direct_xirr_info_set(int n_cpu, int value)
+static inline void direct_xirr_info_set(int value)
 {
-	out_be32(&xics_per_cpu[n_cpu]->xirr.word, value);
+	int cpu = smp_processor_id();
+
+	out_be32(&xics_per_cpu[cpu]->xirr.word, value);
 }
 
-static inline void direct_cppr_info(int n_cpu, u8 value)
+static inline void direct_cppr_info(u8 value)
 {
-	out_8(&xics_per_cpu[n_cpu]->xirr.bytes[0], value);
+	int cpu = smp_processor_id();
+
+	out_8(&xics_per_cpu[cpu]->xirr.bytes[0], value);
 }
 
 static inline void direct_qirr_info(int n_cpu, u8 value)
@@ -111,7 +117,7 @@ static inline void direct_qirr_info(int 
 /* LPAR low level accessors */
 
 
-static inline unsigned int lpar_xirr_info_get(int n_cpu)
+static inline unsigned int lpar_xirr_info_get(void)
 {
 	unsigned long lpar_rc;
 	unsigned long return_value;
@@ -122,7 +128,7 @@ static inline unsigned int lpar_xirr_inf
 	return (unsigned int)return_value;
 }
 
-static inline void lpar_xirr_info_set(int n_cpu, int value)
+static inline void lpar_xirr_info_set(int value)
 {
 	unsigned long lpar_rc;
 	unsigned long val64 = value & 0xffffffff;
@@ -133,7 +139,7 @@ static inline void lpar_xirr_info_set(in
 		      val64);
 }
 
-static inline void lpar_cppr_info(int n_cpu, u8 value)
+static inline void lpar_cppr_info(u8 value)
 {
 	unsigned long lpar_rc;
 
@@ -275,21 +281,19 @@ static unsigned int xics_startup(unsigne
 
 static void xics_eoi_direct(unsigned int virq)
 {
-	int cpu = smp_processor_id();
 	unsigned int irq = (unsigned int)irq_map[virq].hwirq;
 
 	iosync();
-	direct_xirr_info_set(cpu, (0xff << 24) | irq);
+	direct_xirr_info_set((0xff << 24) | irq);
 }
 
 
 static void xics_eoi_lpar(unsigned int virq)
 {
-	int cpu = smp_processor_id();
 	unsigned int irq = (unsigned int)irq_map[virq].hwirq;
 
 	iosync();
-	lpar_xirr_info_set(cpu, (0xff << 24) | irq);
+	lpar_xirr_info_set((0xff << 24) | irq);
 }
 
 static inline unsigned int xics_remap_irq(unsigned int vec)
@@ -312,16 +316,12 @@ static inline unsigned int xics_remap_ir
 
 static unsigned int xics_get_irq_direct(void)
 {
-	unsigned int cpu = smp_processor_id();
-
-	return xics_remap_irq(direct_xirr_info_get(cpu));
+	return xics_remap_irq(direct_xirr_info_get());
 }
 
 static unsigned int xics_get_irq_lpar(void)
 {
-	unsigned int cpu = smp_processor_id();
-
-	return xics_remap_irq(lpar_xirr_info_get(cpu));
+	return xics_remap_irq(lpar_xirr_info_get());
 }
 
 #ifdef CONFIG_SMP
@@ -387,12 +387,12 @@ void xics_cause_IPI(int cpu)
 
 #endif /* CONFIG_SMP */
 
-static void xics_set_cpu_priority(int cpu, unsigned char cppr)
+static void xics_set_cpu_priority(unsigned char cppr)
 {
 	if (firmware_has_feature(FW_FEATURE_LPAR))
-		lpar_cppr_info(cpu, cppr);
+		lpar_cppr_info(cppr);
 	else
-		direct_cppr_info(cpu, cppr);
+		direct_cppr_info(cppr);
 	iosync();
 }
 
@@ -440,9 +440,7 @@ static void xics_set_affinity(unsigned i
 
 void xics_setup_cpu(void)
 {
-	int cpu = smp_processor_id();
-
-	xics_set_cpu_priority(cpu, 0xff);
+	xics_set_cpu_priority(0xff);
 
 	/*
 	 * Put the calling processor into the GIQ.  This is really only
@@ -783,7 +781,7 @@ void xics_teardown_cpu(int secondary)
 	unsigned int ipi;
 	struct irq_desc *desc;
 
-	xics_set_cpu_priority(cpu, 0);
+	xics_set_cpu_priority(0);
 
 	/*
 	 * Clear IPI
@@ -824,10 +822,11 @@ void xics_teardown_cpu(int secondary)
 void xics_migrate_irqs_away(void)
 {
 	int status;
-	unsigned int irq, virq, cpu = smp_processor_id();
+	int cpu = smp_processor_id(), hw_cpu = hard_smp_processor_id();
+	unsigned int irq, virq;
 
 	/* Reject any interrupt that was queued to us... */
-	xics_set_cpu_priority(cpu, 0);
+	xics_set_cpu_priority(0);
 
 	/* remove ourselves from the global interrupt queue */
 	status = rtas_set_indicator_fast(GLOBAL_INTERRUPT_QUEUE,
@@ -835,7 +834,7 @@ void xics_migrate_irqs_away(void)
 	WARN_ON(status < 0);
 
 	/* Allow IPIs again... */
-	xics_set_cpu_priority(cpu, DEFAULT_PRIORITY);
+	xics_set_cpu_priority(DEFAULT_PRIORITY);
 
 	for_each_irq(virq) {
 		struct irq_desc *desc;
@@ -874,7 +873,7 @@ void xics_migrate_irqs_away(void)
 		 * The irq has to be migrated only in the single cpu
 		 * case.
 		 */
-		if (xics_status[0] != get_hard_smp_processor_id(cpu))
+		if (xics_status[0] != hw_cpu)
 			goto unlock;
 
 		printk(KERN_WARNING "IRQ %u affinity broken off cpu %u\n",
Index: kernel/arch/powerpc/platforms/pseries/xics.h
===================================================================
--- kernel.orig/arch/powerpc/platforms/pseries/xics.h	2007-10-10 03:46:30.000000000 -0500
+++ kernel/arch/powerpc/platforms/pseries/xics.h	2007-10-10 03:48:57.000000000 -0500
@@ -21,9 +21,6 @@ extern void xics_cause_IPI(int cpu);
 extern  void xics_request_IPIs(void);
 extern void xics_migrate_irqs_away(void);
 
-/* first argument is ignored for now*/
-void pSeriesLP_cppr_info(int n_cpu, u8 value);
-
 struct xics_ipi_struct {
 	volatile unsigned long value;
 } ____cacheline_aligned;

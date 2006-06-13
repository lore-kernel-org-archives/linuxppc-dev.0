Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DE6C467B2D
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jun 2006 13:53:59 +1000 (EST)
Subject: [PATCH] powerpc-genirq: port xics driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 13:53:32 +1000
Message-Id: <1150170812.13958.20.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch ports the xics driver to genirq and updates the pSeries
platform code accordingly. It also removes the local function pointers
structure and use separate callbacks at the toplevel instead when
necessary (to avoid too many function pointer indirections) or if's in
some cases.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Patch depends on Ingo/Thomas genirq patchset. It's not to be merged
right away, It's being posted here for comments as I may have further
rework.

Index: linux-work/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/pseries/setup.c	2006-06-06 14:39:19.000000000 +1000
+++ linux-work/arch/powerpc/platforms/pseries/setup.c	2006-06-06 14:43:43.000000000 +1000
@@ -119,6 +119,21 @@ static void __init fwnmi_init(void)
 		fwnmi_active = 1;
 }
 
+void pSeries_8259_cascade(unsigned int irq, struct irq_desc *desc,
+			  struct pt_regs *regs)
+{
+	unsigned int max = 100;
+
+	while(max--) {
+		int cascade_irq = i8259_irq(regs);
+		if (max == 99)
+			desc->chip->eoi(irq);
+		if (cascade_irq < 0)
+			break;
+		generic_handle_irq(cascade_irq, regs);
+	};
+}
+
 static void __init pSeries_init_mpic(void)
 {
         unsigned int *addrp;
@@ -141,7 +156,7 @@ static void __init pSeries_init_mpic(voi
 	i8259_init(intack, 0);
 
 	/* Hook cascade to mpic */
-	mpic_setup_cascade(NUM_ISA_INTERRUPTS, i8259_irq_cascade, NULL);
+	set_irq_chained_handler(NUM_ISA_INTERRUPTS, pSeries_8259_cascade);
 }
 
 static void __init pSeries_setup_mpic(void)
@@ -202,10 +217,8 @@ static void __init pSeries_setup_arch(vo
 		/* Allocate the mpic now, so that find_and_init_phbs() can
 		 * fill the ISUs */
 		pSeries_setup_mpic();
-	} else {
+	} else
 		ppc_md.init_IRQ       = xics_init_IRQ;
-		ppc_md.get_irq        = xics_get_irq;
-	}
 
 #ifdef CONFIG_SMP
 	smp_init_pSeries();
@@ -292,10 +305,7 @@ static void pSeries_mach_cpu_die(void)
 {
 	local_irq_disable();
 	idle_task_exit();
-	/* Some hardware requires clearing the CPPR, while other hardware does not
-	 * it is safe either way
-	 */
-	pSeriesLP_cppr_info(0, 0);
+	xics_teardown_cpu(0);
 	rtas_stop_self();
 	/* Should never get here... */
 	BUG();
Index: linux-work/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/pseries/xics.c	2006-06-06 14:39:19.000000000 +1000
+++ linux-work/arch/powerpc/platforms/pseries/xics.c	2006-06-06 14:39:48.000000000 +1000
@@ -32,23 +32,6 @@
 
 #include "xics.h"
 
-static unsigned int xics_startup(unsigned int irq);
-static void xics_enable_irq(unsigned int irq);
-static void xics_disable_irq(unsigned int irq);
-static void xics_mask_and_ack_irq(unsigned int irq);
-static void xics_end_irq(unsigned int irq);
-static void xics_set_affinity(unsigned int irq_nr, cpumask_t cpumask);
-
-static struct hw_interrupt_type xics_pic = {
-	.typename = " XICS     ",
-	.startup = xics_startup,
-	.enable = xics_enable_irq,
-	.disable = xics_disable_irq,
-	.ack = xics_mask_and_ack_irq,
-	.end = xics_end_irq,
-	.set_affinity = xics_set_affinity
-};
-
 /* This is used to map real irq numbers to virtual */
 static struct radix_tree_root irq_map = RADIX_TREE_INIT(GFP_ATOMIC);
 
@@ -99,47 +82,33 @@ static int ibm_set_xive;
 static int ibm_int_on;
 static int ibm_int_off;
 
-typedef struct {
-	int (*xirr_info_get)(int cpu);
-	void (*xirr_info_set)(int cpu, int val);
-	void (*cppr_info)(int cpu, u8 val);
-	void (*qirr_info)(int cpu, u8 val);
-} xics_ops;
 
+/* Direct HW low level accessors */
 
-/* SMP */
 
-static int pSeries_xirr_info_get(int n_cpu)
+static inline int direct_xirr_info_get(int n_cpu)
 {
 	return in_be32(&xics_per_cpu[n_cpu]->xirr.word);
 }
 
-static void pSeries_xirr_info_set(int n_cpu, int value)
+static inline void direct_xirr_info_set(int n_cpu, int value)
 {
 	out_be32(&xics_per_cpu[n_cpu]->xirr.word, value);
 }
 
-static void pSeries_cppr_info(int n_cpu, u8 value)
+static inline void direct_cppr_info(int n_cpu, u8 value)
 {
 	out_8(&xics_per_cpu[n_cpu]->xirr.bytes[0], value);
 }
 
-static void pSeries_qirr_info(int n_cpu, u8 value)
+static inline void direct_qirr_info(int n_cpu, u8 value)
 {
 	out_8(&xics_per_cpu[n_cpu]->qirr.bytes[0], value);
 }
 
-static xics_ops pSeries_ops = {
-	pSeries_xirr_info_get,
-	pSeries_xirr_info_set,
-	pSeries_cppr_info,
-	pSeries_qirr_info
-};
-
-static xics_ops *ops = &pSeries_ops;
 
+/* LPAR low level accessors */
 
-/* LPAR */
 
 static inline long plpar_eoi(unsigned long xirr)
 {
@@ -162,7 +131,7 @@ static inline long plpar_xirr(unsigned l
 	return plpar_hcall(H_XIRR, 0, 0, 0, 0, xirr_ret, &dummy, &dummy);
 }
 
-static int pSeriesLP_xirr_info_get(int n_cpu)
+static inline int lpar_xirr_info_get(int n_cpu)
 {
 	unsigned long lpar_rc;
 	unsigned long return_value;
@@ -173,7 +142,7 @@ static int pSeriesLP_xirr_info_get(int n
 	return (int)return_value;
 }
 
-static void pSeriesLP_xirr_info_set(int n_cpu, int value)
+static inline void lpar_xirr_info_set(int n_cpu, int value)
 {
 	unsigned long lpar_rc;
 	unsigned long val64 = value & 0xffffffff;
@@ -184,7 +153,7 @@ static void pSeriesLP_xirr_info_set(int 
 		      val64);
 }
 
-void pSeriesLP_cppr_info(int n_cpu, u8 value)
+static inline void lpar_cppr_info(int n_cpu, u8 value)
 {
 	unsigned long lpar_rc;
 
@@ -193,7 +162,7 @@ void pSeriesLP_cppr_info(int n_cpu, u8 v
 		panic("bad return code cppr - rc = %lx\n", lpar_rc);
 }
 
-static void pSeriesLP_qirr_info(int n_cpu , u8 value)
+static inline void lpar_qirr_info(int n_cpu , u8 value)
 {
 	unsigned long lpar_rc;
 
@@ -202,36 +171,9 @@ static void pSeriesLP_qirr_info(int n_cp
 		panic("bad return code qirr - rc = %lx\n", lpar_rc);
 }
 
-xics_ops pSeriesLP_ops = {
-	pSeriesLP_xirr_info_get,
-	pSeriesLP_xirr_info_set,
-	pSeriesLP_cppr_info,
-	pSeriesLP_qirr_info
-};
-
-static unsigned int xics_startup(unsigned int virq)
-{
-	unsigned int irq;
-
-	irq = irq_offset_down(virq);
-	if (radix_tree_insert(&irq_map, virt_irq_to_real(irq),
-			      &virt_irq_to_real_map[irq]) == -ENOMEM)
-		printk(KERN_CRIT "Out of memory creating real -> virtual"
-		       " IRQ mapping for irq %u (real 0x%x)\n",
-		       virq, virt_irq_to_real(irq));
-	xics_enable_irq(virq);
-	return 0;	/* return value is ignored */
-}
 
-static unsigned int real_irq_to_virt(unsigned int real_irq)
-{
-	unsigned int *ptr;
+/* High level handlers and init code */
 
-	ptr = radix_tree_lookup(&irq_map, real_irq);
-	if (ptr == NULL)
-		return NO_IRQ;
-	return ptr - virt_irq_to_real_map;
-}
 
 #ifdef CONFIG_SMP
 static int get_irq_server(unsigned int irq)
@@ -265,17 +207,20 @@ static int get_irq_server(unsigned int i
 }
 #endif
 
-static void xics_enable_irq(unsigned int virq)
+
+static void xics_unmask_irq(unsigned int virq)
 {
 	unsigned int irq;
 	int call_status;
 	unsigned int server;
 
 	irq = virt_irq_to_real(irq_offset_down(virq));
-	if (irq == XICS_IPI)
+	WARN_ON(irq == NO_IRQ);
+	if (irq == XICS_IPI || irq == NO_IRQ)
 		return;
 
 	server = get_irq_server(virq);
+
 	call_status = rtas_call(ibm_set_xive, 3, 1, NULL, irq, server,
 				DEFAULT_PRIORITY);
 	if (call_status != 0) {
@@ -294,7 +239,7 @@ static void xics_enable_irq(unsigned int
 	}
 }
 
-static void xics_disable_real_irq(unsigned int irq)
+static void xics_mask_real_irq(unsigned int irq)
 {
 	int call_status;
 	unsigned int server;
@@ -319,75 +264,104 @@ static void xics_disable_real_irq(unsign
 	}
 }
 
-static void xics_disable_irq(unsigned int virq)
+static void xics_mask_irq(unsigned int virq)
 {
 	unsigned int irq;
 
 	irq = virt_irq_to_real(irq_offset_down(virq));
-	xics_disable_real_irq(irq);
+	WARN_ON(irq == NO_IRQ);
+	if (irq != NO_IRQ)
+		xics_mask_real_irq(irq);
+}
+
+static void xics_set_irq_revmap(unsigned int virq)
+{
+	unsigned int irq;
+
+	irq = irq_offset_down(virq);
+	if (radix_tree_insert(&irq_map, virt_irq_to_real(irq),
+			      &virt_irq_to_real_map[irq]) == -ENOMEM)
+		printk(KERN_CRIT "Out of memory creating real -> virtual"
+		       " IRQ mapping for irq %u (real 0x%x)\n",
+		       virq, virt_irq_to_real(irq));
+}
+
+static unsigned int xics_startup(unsigned int virq)
+{
+	xics_set_irq_revmap(virq);
+	xics_unmask_irq(virq);
+	return 0;
+}
+
+static unsigned int real_irq_to_virt(unsigned int real_irq)
+{
+	unsigned int *ptr;
+
+	ptr = radix_tree_lookup(&irq_map, real_irq);
+	if (ptr == NULL)
+		return NO_IRQ;
+	return ptr - virt_irq_to_real_map;
 }
 
-static void xics_end_irq(unsigned int irq)
+static void xics_eoi_direct(unsigned int irq)
 {
 	int cpu = smp_processor_id();
 
 	iosync();
-	ops->xirr_info_set(cpu, ((0xff << 24) |
-				 (virt_irq_to_real(irq_offset_down(irq)))));
-
+	direct_xirr_info_set(cpu, ((0xff << 24) |
+				   (virt_irq_to_real(irq_offset_down(irq)))));
 }
 
-static void xics_mask_and_ack_irq(unsigned int irq)
+
+static void xics_eoi_lpar(unsigned int irq)
 {
 	int cpu = smp_processor_id();
 
-	if (irq < irq_offset_value()) {
-		i8259_pic.ack(irq);
-		iosync();
-		ops->xirr_info_set(cpu, ((0xff<<24) |
-					 xics_irq_8259_cascade_real));
-		iosync();
-	}
+	iosync();
+	lpar_xirr_info_set(cpu, ((0xff << 24) |
+				 (virt_irq_to_real(irq_offset_down(irq)))));
+
 }
 
-int xics_get_irq(struct pt_regs *regs)
+static inline int xics_remap_irq(int vec)
 {
-	unsigned int cpu = smp_processor_id();
-	unsigned int vec;
 	int irq;
 
-	vec = ops->xirr_info_get(cpu);
-	/*  (vec >> 24) == old priority */
 	vec &= 0x00ffffff;
 
-	/* for sanity, this had better be < NR_IRQS - 16 */
-	if (vec == xics_irq_8259_cascade_real) {
-		irq = i8259_irq(regs);
-		xics_end_irq(irq_offset_up(xics_irq_8259_cascade));
-	} else if (vec == XICS_IRQ_SPURIOUS) {
-		irq = -1;
-	} else {
-		irq = real_irq_to_virt(vec);
-		if (irq == NO_IRQ)
-			irq = real_irq_to_virt_slowpath(vec);
-		if (irq == NO_IRQ) {
-			printk(KERN_ERR "Interrupt %u (real) is invalid,"
-			       " disabling it.\n", vec);
-			xics_disable_real_irq(vec);
-		} else
-			irq = irq_offset_up(irq);
-	}
-	return irq;
+	if (vec == XICS_IRQ_SPURIOUS)
+		return NO_IRQ;
+
+	irq = real_irq_to_virt(vec);
+	if (irq == NO_IRQ)
+		irq = real_irq_to_virt_slowpath(vec);
+	if (likely(irq != NO_IRQ))
+		return irq_offset_up(irq);
+
+	printk(KERN_ERR "Interrupt %u (real) is invalid,"
+	       " disabling it.\n", vec);
+	xics_mask_real_irq(vec);
+	return NO_IRQ;
 }
 
-#ifdef CONFIG_SMP
+static int xics_get_irq_direct(struct pt_regs *regs)
+{
+	unsigned int cpu = smp_processor_id();
 
-static irqreturn_t xics_ipi_action(int irq, void *dev_id, struct pt_regs *regs)
+	return xics_remap_irq(direct_xirr_info_get(cpu));
+}
+
+static int xics_get_irq_lpar(struct pt_regs *regs)
 {
-	int cpu = smp_processor_id();
+	unsigned int cpu = smp_processor_id();
+
+	return xics_remap_irq(lpar_xirr_info_get(cpu));
+}
 
-	ops->qirr_info(cpu, 0xff);
+#ifdef CONFIG_SMP
 
+static irqreturn_t xics_ipi_dispatch(int cpu, struct pt_regs *regs)
+{
 	WARN_ON(cpu_is_offline(cpu));
 
 	while (xics_ipi_message[cpu].value) {
@@ -419,18 +393,108 @@ static irqreturn_t xics_ipi_action(int i
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t xics_ipi_action_direct(int irq, void *dev_id, struct pt_regs *regs)
+{
+	int cpu = smp_processor_id();
+
+	direct_qirr_info(cpu, 0xff);
+
+	return xics_ipi_dispatch(cpu, regs);
+}
+
+static irqreturn_t xics_ipi_action_lpar(int irq, void *dev_id, struct pt_regs *regs)
+{
+	int cpu = smp_processor_id();
+
+	lpar_qirr_info(cpu, 0xff);
+
+	return xics_ipi_dispatch(cpu, regs);
+}
+
 void xics_cause_IPI(int cpu)
 {
-	ops->qirr_info(cpu, IPI_PRIORITY);
+	if (firmware_has_feature(FW_FEATURE_LPAR))
+		lpar_qirr_info(cpu, IPI_PRIORITY);
+	else
+		direct_qirr_info(cpu, IPI_PRIORITY);
 }
+
 #endif /* CONFIG_SMP */
 
+static void xics_set_cpu_priority(int cpu, unsigned char cppr)
+{
+	if (firmware_has_feature(FW_FEATURE_LPAR))
+		lpar_cppr_info(cpu, cppr);
+	else
+		direct_cppr_info(cpu, cppr);
+	iosync();
+}
+
+static void xics_set_affinity(unsigned int virq, cpumask_t cpumask)
+{
+	unsigned int irq;
+	int status;
+	int xics_status[2];
+	unsigned long newmask;
+	cpumask_t tmp = CPU_MASK_NONE;
+
+	irq = virt_irq_to_real(irq_offset_down(virq));
+	if (irq == XICS_IPI || irq == NO_IRQ)
+		return;
+
+	status = rtas_call(ibm_get_xive, 1, 3, xics_status, irq);
+
+	if (status) {
+		printk(KERN_ERR "xics_set_affinity: irq=%u ibm,get-xive "
+		       "returns %d\n", irq, status);
+		return;
+	}
+
+	/* For the moment only implement delivery to all cpus or one cpu */
+	if (cpus_equal(cpumask, CPU_MASK_ALL)) {
+		newmask = default_distrib_server;
+	} else {
+		cpus_and(tmp, cpu_online_map, cpumask);
+		if (cpus_empty(tmp))
+			return;
+		newmask = get_hard_smp_processor_id(first_cpu(tmp));
+	}
+
+	status = rtas_call(ibm_set_xive, 3, 1, NULL,
+				irq, newmask, xics_status[1]);
+
+	if (status) {
+		printk(KERN_ERR "xics_set_affinity: irq=%u ibm,set-xive "
+		       "returns %d\n", irq, status);
+		return;
+	}
+}
+
+static struct irq_chip xics_pic_direct = {
+	.typename = " XICS     ",
+	.startup = xics_startup,
+	.mask = xics_mask_irq,
+	.unmask = xics_unmask_irq,
+	.eoi = xics_eoi_direct,
+	.set_affinity = xics_set_affinity
+};
+
+
+static struct irq_chip xics_pic_lpar = {
+	.typename = " XICS     ",
+	.startup = xics_startup,
+	.mask = xics_mask_irq,
+	.unmask = xics_unmask_irq,
+	.eoi = xics_eoi_lpar,
+	.set_affinity = xics_set_affinity
+};
+
+
 void xics_setup_cpu(void)
 {
 	int cpu = smp_processor_id();
 
-	ops->cppr_info(cpu, 0xff);
-	iosync();
+	xics_set_cpu_priority(cpu, 0xff);
 
 	/*
 	 * Put the calling processor into the GIQ.  This is really only
@@ -454,6 +518,7 @@ void xics_init_IRQ(void)
 		unsigned long addr;
 		unsigned long size;
 	} intnodes[NR_CPUS];
+	struct irq_chip *chip;
 
 	ppc64_boot_msg(0x20, "XICS Init");
 
@@ -520,26 +585,10 @@ nextnode:
 	intr_base = intnodes[0].addr;
 	intr_size = intnodes[0].size;
 
-	np = of_find_node_by_type(NULL, "interrupt-controller");
-	if (!np) {
-		printk(KERN_WARNING "xics: no ISA interrupt controller\n");
-		xics_irq_8259_cascade_real = -1;
-		xics_irq_8259_cascade = -1;
+	if (firmware_has_feature(FW_FEATURE_LPAR)) {
+		ppc_md.get_irq = xics_get_irq_lpar;
+		chip = &xics_pic_lpar;
 	} else {
-		ireg = (uint *) get_property(np, "interrupts", NULL);
-		if (!ireg)
-			panic("xics_init_IRQ: can't find ISA interrupts property");
-
-		xics_irq_8259_cascade_real = *ireg;
-		xics_irq_8259_cascade
-			= virt_irq_create_mapping(xics_irq_8259_cascade_real);
-		i8259_init(0, 0);
-		of_node_put(np);
-	}
-
-	if (firmware_has_feature(FW_FEATURE_LPAR))
-		ops = &pSeriesLP_ops;
-	else {
 #ifdef CONFIG_SMP
 		for_each_possible_cpu(i) {
 			int hard_id;
@@ -555,32 +604,54 @@ nextnode:
 #else
 		xics_per_cpu[0] = ioremap(intr_base, intr_size);
 #endif /* CONFIG_SMP */
+		ppc_md.get_irq = xics_get_irq_direct;
+		chip = &xics_pic_direct;
+
 	}
 
-	for (i = irq_offset_value(); i < NR_IRQS; ++i)
-		get_irq_desc(i)->chip = &xics_pic;
+	for (i = irq_offset_value(); i < NR_IRQS; ++i) {
+		/* All IRQs on XICS are level for now. MSI code may want to modify
+		 * that for reporting purposes
+		 */
+		get_irq_desc(i)->status |= IRQ_LEVEL;
+		set_irq_chip_and_handler(i, chip, handle_fasteoi_irq);
+	}
 
 	xics_setup_cpu();
 
 	ppc64_boot_msg(0x21, "XICS Done");
 }
 
-/*
- * We cant do this in init_IRQ because we need the memory subsystem up for
- * request_irq()
- */
-static int __init xics_setup_i8259(void)
+static int xics_setup_8259_cascade(void)
 {
-	if (ppc64_interrupt_controller == IC_PPC_XIC &&
-	    xics_irq_8259_cascade != -1) {
-		if (request_irq(irq_offset_up(xics_irq_8259_cascade),
-				no_action, 0, "8259 cascade", NULL))
-			printk(KERN_ERR "xics_setup_i8259: couldn't get 8259 "
-					"cascade\n");
+	struct device_node *np;
+	uint *ireg;
+
+	np = of_find_node_by_type(NULL, "interrupt-controller");
+	if (np == NULL) {
+		printk(KERN_WARNING "xics: no ISA interrupt controller\n");
+		xics_irq_8259_cascade_real = -1;
+		xics_irq_8259_cascade = -1;
+		return 0;
 	}
+
+	ireg = (uint *) get_property(np, "interrupts", NULL);
+	if (!ireg)
+		panic("xics_init_IRQ: can't find ISA interrupts property");
+
+	xics_irq_8259_cascade_real = *ireg;
+	xics_irq_8259_cascade = irq_offset_up
+		(virt_irq_create_mapping(xics_irq_8259_cascade_real));
+	i8259_init(0, 0);
+	of_node_put(np);
+
+	xics_set_irq_revmap(xics_irq_8259_cascade);
+	set_irq_chained_handler(xics_irq_8259_cascade, pSeries_8259_cascade);
+
 	return 0;
 }
-arch_initcall(xics_setup_i8259);
+arch_initcall(xics_setup_8259_cascade);
+
 
 #ifdef CONFIG_SMP
 void xics_request_IPIs(void)
@@ -588,64 +659,28 @@ void xics_request_IPIs(void)
 	virt_irq_to_real_map[XICS_IPI] = XICS_IPI;
 
 	/* IPIs are marked SA_INTERRUPT as they must run with irqs disabled */
-	request_irq(irq_offset_up(XICS_IPI), xics_ipi_action, SA_INTERRUPT,
-		    "IPI", NULL);
-	get_irq_desc(irq_offset_up(XICS_IPI))->status |= IRQ_PER_CPU;
+	set_irq_handler(irq_offset_up(XICS_IPI), handle_percpu_irq);
+	if (firmware_has_feature(FW_FEATURE_LPAR))
+		request_irq(irq_offset_up(XICS_IPI), xics_ipi_action_lpar,
+			    SA_INTERRUPT, "IPI", NULL);
+	else
+		request_irq(irq_offset_up(XICS_IPI), xics_ipi_action_direct,
+			    SA_INTERRUPT, "IPI", NULL);
 }
 #endif
 
-static void xics_set_affinity(unsigned int virq, cpumask_t cpumask)
-{
-	unsigned int irq;
-	int status;
-	int xics_status[2];
-	unsigned long newmask;
-	cpumask_t tmp = CPU_MASK_NONE;
-
-	irq = virt_irq_to_real(irq_offset_down(virq));
-	if (irq == XICS_IPI || irq == NO_IRQ)
-		return;
-
-	status = rtas_call(ibm_get_xive, 1, 3, xics_status, irq);
-
-	if (status) {
-		printk(KERN_ERR "xics_set_affinity: irq=%u ibm,get-xive "
-		       "returns %d\n", irq, status);
-		return;
-	}
-
-	/* For the moment only implement delivery to all cpus or one cpu */
-	if (cpus_equal(cpumask, CPU_MASK_ALL)) {
-		newmask = default_distrib_server;
-	} else {
-		cpus_and(tmp, cpu_online_map, cpumask);
-		if (cpus_empty(tmp))
-			return;
-		newmask = get_hard_smp_processor_id(first_cpu(tmp));
-	}
-
-	status = rtas_call(ibm_set_xive, 3, 1, NULL,
-				irq, newmask, xics_status[1]);
-
-	if (status) {
-		printk(KERN_ERR "xics_set_affinity: irq=%u ibm,set-xive "
-		       "returns %d\n", irq, status);
-		return;
-	}
-}
-
 void xics_teardown_cpu(int secondary)
 {
 	int cpu = smp_processor_id();
 
-	ops->cppr_info(cpu, 0x00);
-	iosync();
+	xics_set_cpu_priority(cpu, 0);
 
 	/*
 	 * Some machines need to have at least one cpu in the GIQ,
 	 * so leave the master cpu in the group.
 	 */
 	if (secondary) {
+		struct irq_desc *desc = get_irq_desc(irq_offset_up(XICS_IPI));
 		/*
 		 * we need to EOI the IPI if we got here from kexec down IPI
 		 *
@@ -653,7 +688,8 @@ void xics_teardown_cpu(int secondary)
 		 * should we be flagging idle loop instead?
 		 * or creating some task to be scheduled?
 		 */
-		ops->xirr_info_set(cpu, XICS_IPI);
+		if (desc->chip && desc->chip->eoi)
+			desc->chip->eoi(XICS_IPI);
 		rtas_set_indicator(GLOBAL_INTERRUPT_QUEUE,
 			(1UL << interrupt_server_size) - 1 -
 			default_distrib_server, 0);
@@ -669,8 +705,7 @@ void xics_migrate_irqs_away(void)
 	unsigned int irq, virq, cpu = smp_processor_id();
 
 	/* Reject any interrupt that was queued to us... */
-	ops->cppr_info(cpu, 0);
-	iosync();
+	xics_set_cpu_priority(cpu, 0);
 
 	/* remove ourselves from the global interrupt queue */
 	status = rtas_set_indicator(GLOBAL_INTERRUPT_QUEUE,
@@ -678,11 +713,10 @@ void xics_migrate_irqs_away(void)
 	WARN_ON(status < 0);
 
 	/* Allow IPIs again... */
-	ops->cppr_info(cpu, DEFAULT_PRIORITY);
-	iosync();
+	xics_set_cpu_priority(cpu, DEFAULT_PRIORITY);
 
 	for_each_irq(virq) {
-		irq_desc_t *desc;
+		struct irq_desc *desc;
 		int xics_status[2];
 		unsigned long flags;
 
Index: linux-work/arch/powerpc/platforms/pseries/xics.h
===================================================================
--- linux-work.orig/arch/powerpc/platforms/pseries/xics.h	2006-06-06 14:39:19.000000000 +1000
+++ linux-work/arch/powerpc/platforms/pseries/xics.h	2006-06-06 14:39:48.000000000 +1000
@@ -14,13 +14,12 @@
 
 #include <linux/cache.h>
 
-void xics_init_IRQ(void);
-int xics_get_irq(struct pt_regs *);
-void xics_setup_cpu(void);
-void xics_teardown_cpu(int secondary);
-void xics_cause_IPI(int cpu);
-void xics_request_IPIs(void);
-void xics_migrate_irqs_away(void);
+extern void xics_init_IRQ(void);
+extern void xics_setup_cpu(void);
+extern void xics_teardown_cpu(int secondary);
+extern void xics_cause_IPI(int cpu);
+extern  void xics_request_IPIs(void);
+extern void xics_migrate_irqs_away(void);
 
 /* first argument is ignored for now*/
 void pSeriesLP_cppr_info(int n_cpu, u8 value);
@@ -31,4 +30,8 @@ struct xics_ipi_struct {
 
 extern struct xics_ipi_struct xics_ipi_message[NR_CPUS] __cacheline_aligned;
 
+struct irq_desc;
+extern void pSeries_8259_cascade(unsigned int irq, struct irq_desc *desc,
+				 struct pt_regs *regs);
+
 #endif /* _POWERPC_KERNEL_XICS_H */
Index: linux-work/include/asm-powerpc/irq.h
===================================================================
--- linux-work.orig/include/asm-powerpc/irq.h	2006-06-06 14:39:19.000000000 +1000
+++ linux-work/include/asm-powerpc/irq.h	2006-06-06 14:39:48.000000000 +1000
@@ -496,7 +496,6 @@ extern void irq_ctx_init(void);
 extern void call_do_softirq(struct thread_info *tp);
 extern int call_handle_irq(int irq, void *p1, void *p2,
 			   struct thread_info *tp, void *func);
-
 #else
 #define irq_ctx_init()
 

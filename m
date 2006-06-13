Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D43A067B3E
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jun 2006 14:07:37 +1000 (EST)
Subject: [PATCH] powerpc-genirq: port cell iic and spider-pic to genirq
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 14:07:05 +1000
Message-Id: <1150171625.13958.36.camel@localhost.localdomain>
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

This patch is a quick hack at porting the cell iic and spider-pic to
genirq. It applies on top of other cell patches not yet in mainline. It
needs more work though, for example, we need to handle proper retrigger
of interrupts that have been masked etc...

It also hacks together some cascade handling that need to be reworked,
mostly when my irq number allocator/remapper is ready (I currently
hijack spider irq 32 which doesn't exist to do the iic->spider cascade).
It needs some work to properly handle the RAS interrupts on cell as
well. One feature it adds that wasn't there is better handling of
stacked priorities (that should be done for xics as well btw). That is,
when an irq is completed (eoi), the processor priority is restored to
the previous priority that got interrupted rather than 0xff
systematically, thus avoiding the potential for infinite stacking of
interrupts.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Patch depends on Ingo/Thomas genirq patchset. It's not to be merged
right away, It's being posted here for comments as I may have further
rework.

Index: linux-work/arch/powerpc/platforms/cell/interrupt.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/cell/interrupt.c	2006-06-08 15:10:24.000000000 +1000
+++ linux-work/arch/powerpc/platforms/cell/interrupt.c	2006-06-09 18:08:56.000000000 +1000
@@ -57,64 +57,51 @@ struct iic_regs {
 struct iic {
 	struct iic_regs __iomem *regs;
 	u8 target_id;
+	u8 eoi_stack[16];
+	int eoi_ptr;
 };
 
 static DEFINE_PER_CPU(struct iic, iic);
 
-void iic_local_enable(void)
+static void iic_mask(unsigned int irq)
 {
-	struct iic *iic = &__get_cpu_var(iic);
-	u64 tmp;
-
-	/*
-	 * There seems to be a bug that is present in DD2.x CPUs
-	 * and still only partially fixed in DD3.1.
-	 * This bug causes a value written to the priority register
-	 * not to make it there, resulting in a system hang unless we
-	 * write it again.
-	 * Masking with 0xf0 is done because the Cell BE does not
-	 * implement the lower four bits of the interrupt priority,
-	 * they always read back as zeroes, although future CPUs
-	 * might implement different bits.
-	 */
-	do {
-		out_be64(&iic->regs->prio, 0xff);
-		tmp = in_be64(&iic->regs->prio);
-	} while ((tmp & 0xf0) != 0xf0);
-}
-
-void iic_local_disable(void)
-{
-	out_be64(&__get_cpu_var(iic).regs->prio, 0x0);
 }
 
-static unsigned int iic_startup(unsigned int irq)
+static void iic_unmask(unsigned int irq)
 {
-	return 0;
 }
 
-static void iic_enable(unsigned int irq)
+static void iic_eoi(unsigned int irq)
 {
-	iic_local_enable();
-}
-
-static void iic_disable(unsigned int irq)
-{
-}
-
-static void iic_end(unsigned int irq)
-{
-	iic_local_enable();
+	struct iic *iic = &__get_cpu_var(iic);
+	out_be64(&iic->regs->prio, iic->eoi_stack[--iic->eoi_ptr]);
+	BUG_ON(iic->eoi_ptr < 0);
 }
 
-static struct hw_interrupt_type iic_pic = {
+static struct irq_chip iic_chip = {
 	.typename = " CELL-IIC ",
-	.startup = iic_startup,
-	.enable = iic_enable,
-	.disable = iic_disable,
-	.end = iic_end,
+	.mask = iic_mask,
+	.unmask = iic_unmask,
+	.eoi = iic_eoi,
 };
 
+/* XXX All of this has to be reworked completely. We need to assign a real
+ * interrupt numbers to the external interrupts and remove all the hard coded
+ * interrupt maps (rely on the device-tree whenever possible).
+ *
+ * Basically, my scheme is to define the "pendings" bits to be the HW interrupt
+ * number (ignoring the data and flags here). That means we can sort-of split
+ * external sources based on priority, and we can use request_irq() on pretty
+ * much anything.
+ *
+ * For spider or axon, they have their own interrupt space. spider will just have
+ * local "hardward" interrupts 0...xx * node stride. The node stride is not
+ * necessary (separate interrupt chips will have separate HW number space), but
+ * will allow to be compatible with existing device-trees.
+ *
+ * All of thise little world will get a standard remapping scheme to map those HW
+ * numbers into the linux flat irq number space.
+ */
 static int iic_external_get_irq(struct iic_pending_bits pending)
 {
 	int irq;
@@ -138,9 +125,10 @@ static int iic_external_get_irq(struct i
 		 */
 		if (pending.class != 2)
 			break;
-		irq = IIC_EXT_OFFSET
-			+ spider_get_irq(node)
-			+ node * IIC_NODE_STRIDE;
+		/* TODO: We might want to silently ignore cascade interrupts
+		 * when no cascade handler exist yet
+		 */
+		irq = IIC_EXT_CASCADE + node * IIC_NODE_STRIDE;
 		break;
 	case 0x01 ... 0x04:
 	case 0x07 ... 0x0a:
@@ -172,6 +160,8 @@ int iic_get_irq(struct pt_regs *regs)
 	iic = &__get_cpu_var(iic);
 	*(unsigned long *) &pending = 
 		in_be64((unsigned long __iomem *) &iic->regs->pending_destr);
+	iic->eoi_stack[++iic->eoi_ptr] = pending.prio;
+	BUG_ON(iic->eoi_ptr > 15);
 
 	irq = -1;
 	if (pending.flags & IIC_VALID) {
@@ -192,7 +182,7 @@ int iic_get_irq(struct pt_regs *regs)
 
 /* hardcoded part to be compatible with older firmware */
 
-static int setup_iic_hardcoded(void)
+static int __init setup_iic_hardcoded(void)
 {
 	struct device_node *np;
 	int nodeid, cpu;
@@ -232,7 +222,7 @@ static int setup_iic_hardcoded(void)
 	return 0;
 }
 
-static int setup_iic(void)
+static int __init setup_iic(void)
 {
 	struct device_node *dn;
 	unsigned long *regs;
@@ -268,11 +258,13 @@ static int setup_iic(void)
  		iic = &per_cpu(iic, np[0]);
  		iic->regs = ioremap(regs[0], sizeof(struct iic_regs));
 		iic->target_id = ((np[0] & 2) << 3) + ((np[0] & 1) ? 0xf : 0xe);
+		iic->eoi_stack[0] = 0xff;
  		printk("IIC for CPU %d at %lx mapped to %p\n", np[0], regs[0], iic->regs);
 
  		iic = &per_cpu(iic, np[1]);
  		iic->regs = ioremap(regs[2], sizeof(struct iic_regs));
 		iic->target_id = ((np[1] & 2) << 3) + ((np[1] & 1) ? 0xf : 0xe);
+		iic->eoi_stack[0] = 0xff;
  		printk("IIC for CPU %d at %lx mapped to %p\n", np[1], regs[2], iic->regs);
 
 		found++;
@@ -324,10 +316,10 @@ static void iic_request_ipi(int ipi, con
 	int irq;
 
 	irq = iic_ipi_to_irq(ipi);
+
 	/* IPIs are marked SA_INTERRUPT as they must run with irqs
 	 * disabled */
-	get_irq_desc(irq)->chip = &iic_pic;
-	get_irq_desc(irq)->status |= IRQ_PER_CPU;
+	set_irq_chip_and_handler(irq, &iic_chip, handle_percpu_irq);
 	request_irq(irq, iic_ipi_action, SA_INTERRUPT, name, NULL);
 }
 
@@ -341,20 +333,26 @@ void iic_request_IPIs(void)
 }
 #endif /* CONFIG_SMP */
 
-static void iic_setup_spe_handlers(void)
+static void __init iic_setup_builtin_handlers(void)
 {
 	int be, isrc;
 
-	/* Assume two threads per BE are present */
+	/* XXX FIXME: Assume two threads per BE are present */
 	for (be=0; be < num_present_cpus() / 2; be++) {
+		int irq;
+
+		/* setup SPE chip and handlers */
 		for (isrc = 0; isrc < IIC_CLASS_STRIDE * 3; isrc++) {
-			int irq = IIC_NODE_STRIDE * be + IIC_SPE_OFFSET + isrc;
-			get_irq_desc(irq)->chip = &iic_pic;
+			irq = IIC_NODE_STRIDE * be + IIC_SPE_OFFSET + isrc;
+			set_irq_chip_and_handler(irq, &iic_chip, handle_fasteoi_irq);
 		}
+		/* setup cascade chip */
+		irq = IIC_EXT_CASCADE + be * IIC_NODE_STRIDE;
+		set_irq_chip_and_handler(irq, &iic_chip, handle_fasteoi_irq);
 	}
 }
 
-void iic_init_IRQ(void)
+void __init iic_init_IRQ(void)
 {
 	int cpu, irq_offset;
 	struct iic *iic;
@@ -368,5 +366,6 @@ void iic_init_IRQ(void)
 		if (iic->regs)
 			out_be64(&iic->regs->prio, 0xff);
 	}
-	iic_setup_spe_handlers();
+	iic_setup_builtin_handlers();
+
 }
Index: linux-work/arch/powerpc/Kconfig.debug
===================================================================
--- linux-work.orig/arch/powerpc/Kconfig.debug	2006-03-31 12:13:01.000000000 +1100
+++ linux-work/arch/powerpc/Kconfig.debug	2006-06-09 17:50:53.000000000 +1000
@@ -131,12 +131,30 @@ config PPC_EARLY_DEBUG_G5
 	help
 	  Select this to enable early debugging for Apple G5 machines.
 
-config PPC_EARLY_DEBUG_RTAS
+config PPC_EARLY_DEBUG_RTAS_PANEL
 	bool "RTAS Panel"
 	depends on PPC_RTAS
 	help
 	  Select this to enable early debugging via the RTAS panel.
 
+config PPC_EARLY_DEBUG_RTAS_CONSOLE
+	bool "RTAS Console"
+	depends on PPC_RTAS
+	help
+	  Select this to enable early debugging via the RTAS console.
+
+config PPC_EARLY_DEBUG_RTAS_PUTCHAR_TOKEN
+	hex "  RTAS token for put-term-char function" if PPC_EARLY_DEBUG_RTAS_CONSOLE
+	default "0x27"
+	help
+	  Enter the value for the put-term-char rtas token on your machine
+
+config PPC_EARLY_DEBUG_RTAS_GETCHAR_TOKEN
+	hex "  RTAS token for get-term-char function" if PPC_EARLY_DEBUG_RTAS_CONSOLE
+	default "0x28"
+	help
+	  Enter the value for the get-term-char rtas token on your machine
+
 config PPC_EARLY_DEBUG_MAPLE
 	bool "Maple real mode"
 	depends on PPC_MAPLE
Index: linux-work/arch/powerpc/kernel/rtas.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/rtas.c	2006-04-21 14:16:03.000000000 +1000
+++ linux-work/arch/powerpc/kernel/rtas.c	2006-06-09 18:00:28.000000000 +1000
@@ -106,11 +106,68 @@ static void call_rtas_display_status_del
 	}
 }
 
-void __init udbg_init_rtas(void)
+void __init udbg_init_rtas_panel(void)
 {
 	udbg_putc = call_rtas_display_status_delay;
 }
 
+#ifdef CONFIG_PPC_EARLY_DEBUG_RTAS_CONSOLE
+
+static unsigned int rtas_putchar_token;
+static unsigned int rtas_getchar_token;
+
+static void udbg_rtascon_putc(char c)
+{
+	int tries, result;
+
+	if (!rtas.base)
+		return;
+
+	/* Add CRs before LFs */
+	if (c == 10)
+		udbg_rtascon_putc(13);
+
+	/* if there is more than one character to be displayed, wait a bit */
+	for (tries = 0; tries < 16; tries++) {
+		result = rtas_call(rtas_putchar_token, 1, 1, NULL, c);
+		if (result == 0)
+			break;
+		udelay(1000);
+	}
+}
+
+static int udbg_rtascon_getc_poll(void)
+{
+	int c;
+
+	if (!rtas.base)
+		return -1;
+
+	if (rtas_call(rtas_getchar_token, 0, 2, &c))
+		return -1;
+	return c;
+}
+
+static int udbg_rtascon_getc(void)
+{
+	int c;
+	while ((c = udbg_rtascon_getc_poll()) == -1)
+		;
+	return c;
+}
+
+
+void __init udbg_init_rtas_console(unsigned int put_token,
+				   unsigned int get_token)
+{
+	rtas_putchar_token = put_token;
+	rtas_getchar_token = get_token;
+	udbg_putc = udbg_rtascon_putc;
+	udbg_getc = udbg_rtascon_getc;
+	udbg_getc_poll = udbg_rtascon_getc_poll;
+}
+#endif /* CONFIG_PPC_EARLY_DEBUG_RTAS_CONSOLE */
+
 void rtas_progress(char *s, unsigned short hex)
 {
 	struct device_node *root;
Index: linux-work/arch/powerpc/kernel/udbg.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/udbg.c	2006-06-06 13:38:03.000000000 +1000
+++ linux-work/arch/powerpc/kernel/udbg.c	2006-06-09 17:49:54.000000000 +1000
@@ -34,9 +34,13 @@ void __init udbg_early_init(void)
 #elif defined(CONFIG_PPC_EARLY_DEBUG_G5)
 	/* For use on Apple G5 machines */
 	udbg_init_pmac_realmode();
-#elif defined(CONFIG_PPC_EARLY_DEBUG_RTAS)
+#elif defined(CONFIG_PPC_EARLY_DEBUG_RTAS_PANEL)
 	/* RTAS panel debug */
-	udbg_init_rtas();
+	udbg_init_rtas_panel();
+#elif defined(CONFIG_PPC_EARLY_DEBUG_RTAS_CONSOLE)
+	/* RTAS console debug */
+	udbg_init_rtas_console(CONFIG_PPC_EARLY_DEBUG_RTAS_PUTCHAR_TOKEN,
+			       CONFIG_PPC_EARLY_DEBUG_RTAS_GETCHAR_TOKEN);
 #elif defined(CONFIG_PPC_EARLY_DEBUG_MAPLE)
 	/* Maple real mode debug */
 	udbg_init_maple_realmode();
Index: linux-work/arch/powerpc/platforms/cell/interrupt.h
===================================================================
--- linux-work.orig/arch/powerpc/platforms/cell/interrupt.h	2006-03-31 12:13:01.000000000 +1100
+++ linux-work/arch/powerpc/platforms/cell/interrupt.h	2006-06-09 15:51:29.000000000 +1000
@@ -38,6 +38,7 @@
 
 enum {
 	IIC_EXT_OFFSET   = 0x00, /* Start of south bridge IRQs */
+	IIC_EXT_CASCADE  = 0x20, /* There is no interrupt 32 on spider */
 	IIC_NUM_EXT      = 0x40, /* Number of south bridge IRQs */
 	IIC_SPE_OFFSET   = 0x40, /* Start of SPE interrupts */
 	IIC_CLASS_STRIDE = 0x10, /* SPE IRQs per class    */
@@ -51,13 +52,10 @@ extern int  iic_get_irq(struct pt_regs *
 extern void iic_cause_IPI(int cpu, int mesg);
 extern void iic_request_IPIs(void);
 extern void iic_setup_cpu(void);
-extern void iic_local_enable(void);
-extern void iic_local_disable(void);
 
 extern u8 iic_get_target_id(int cpu);
 
 extern void spider_init_IRQ(void);
-extern int spider_get_irq(int node);
 
 #endif
 #endif /* ASM_CELL_PIC_H */
Index: linux-work/arch/powerpc/platforms/cell/setup.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/cell/setup.c	2006-06-06 13:38:03.000000000 +1000
+++ linux-work/arch/powerpc/platforms/cell/setup.c	2006-06-09 18:07:15.000000000 +1000
@@ -77,11 +77,14 @@ static void cell_progress(char *s, unsig
 	printk("*** %04x : %s\n", hex, s ? s : "");
 }
 
-static void __init cell_setup_arch(void)
+static void __init cell_init_irq(void)
 {
-	ppc_md.init_IRQ       = iic_init_IRQ;
-	ppc_md.get_irq        = iic_get_irq;
+	iic_init_IRQ();
+	spider_init_IRQ();
+}
 
+static void __init cell_setup_arch(void)
+{
 #ifdef CONFIG_SMP
 	smp_init_cell();
 #endif
@@ -97,7 +100,6 @@ static void __init cell_setup_arch(void)
 	/* Find and initialize PCI host bridges */
 	init_pci_config_tokens();
 	find_and_init_phbs();
-	spider_init_IRQ();
 	cell_pervasive_init();
 #ifdef CONFIG_DUMMY_CONSOLE
 	conswitchp = &dummy_con;
@@ -158,6 +160,9 @@ define_machine(cell) {
 	.calibrate_decr		= generic_calibrate_decr,
 	.check_legacy_ioport	= cell_check_legacy_ioport,
 	.progress		= cell_progress,
+	.init_IRQ       	= cell_init_irq,
+	.get_irq        	= iic_get_irq,
+
 #ifdef CONFIG_KEXEC
 	.machine_kexec		= default_machine_kexec,
 	.machine_kexec_prepare	= default_machine_kexec_prepare,
Index: linux-work/arch/powerpc/platforms/cell/spider-pic.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/cell/spider-pic.c	2006-06-05 17:55:22.000000000 +1000
+++ linux-work/arch/powerpc/platforms/cell/spider-pic.c	2006-06-09 17:24:45.000000000 +1000
@@ -82,17 +82,20 @@ static void __iomem *spider_get_irq_conf
 	return pic + TIR_CFGA + 8 * spider_get_nr(irq);
 }
 
-static void spider_enable_irq(unsigned int irq)
+static void spider_unmask_irq(unsigned int irq)
 {
 	int nodeid = (irq / IIC_NODE_STRIDE) * 0x10;
 	void __iomem *cfg = spider_get_irq_config(irq);
 	irq = spider_get_nr(irq);
 
+	/* FIXME: Most of that is configuration and has nothing to do with enabling/disable,
+	 * besides, it's also partially bogus.
+	 */
 	out_be32(cfg, (in_be32(cfg) & ~0xf0)| 0x3107000eu | nodeid);
 	out_be32(cfg + 4, in_be32(cfg + 4) | 0x00020000u | irq);
 }
 
-static void spider_disable_irq(unsigned int irq)
+static void spider_mask_irq(unsigned int irq)
 {
 	void __iomem *cfg = spider_get_irq_config(irq);
 	irq = spider_get_nr(irq);
@@ -100,39 +103,21 @@ static void spider_disable_irq(unsigned 
 	out_be32(cfg, in_be32(cfg) & ~0x30000000u);
 }
 
-static unsigned int spider_startup_irq(unsigned int irq)
-{
-	spider_enable_irq(irq);
-	return 0;
-}
-
-static void spider_shutdown_irq(unsigned int irq)
-{
-	spider_disable_irq(irq);
-}
-
-static void spider_end_irq(unsigned int irq)
-{
-	spider_enable_irq(irq);
-}
-
 static void spider_ack_irq(unsigned int irq)
 {
-	spider_disable_irq(irq);
-	iic_local_enable();
+	/* Should reset edge detection logic but we don't configure any edge interrupt
+	 * at the moment.
+	 */
 }
 
-static struct hw_interrupt_type spider_pic = {
+static struct irq_chip spider_pic = {
 	.typename = " SPIDER   ",
-	.startup = spider_startup_irq,
-	.shutdown = spider_shutdown_irq,
-	.enable = spider_enable_irq,
-	.disable = spider_disable_irq,
+	.unmask = spider_unmask_irq,
+	.mask = spider_mask_irq,
 	.ack = spider_ack_irq,
-	.end = spider_end_irq,
 };
 
-int spider_get_irq(int node)
+static int spider_get_irq(int node)
 {
 	unsigned long cs;
 	void __iomem *regs = spider_pics[node];
@@ -145,95 +130,89 @@ int spider_get_irq(int node)
 		return cs;
 }
 
+static void spider_irq_cascade(unsigned int irq, struct irq_desc *desc,
+			       struct pt_regs *regs)
+{
+	int node = (int)(long)desc->handler_data;
+	int cascade_irq;
+
+	cascade_irq = spider_get_irq(node);
+	generic_handle_irq(cascade_irq, regs);
+	desc->chip->eoi(irq);
+}
+
 /* hardcoded part to be compatible with older firmware */
 
-void spider_init_IRQ_hardcoded(void)
+static void __init spider_init_one(int node, unsigned long addr)
 {
-	int node;
-	long spiderpic;
-	long pics[] = { 0x24000008000, 0x34000008000 };
-	int n;
-
-	pr_debug("%s(%d): Using hardcoded defaults\n", __FUNCTION__, __LINE__);
-
-	for (node = 0; node < num_present_cpus()/2; node++) {
-		spiderpic = pics[node];
-		printk(KERN_DEBUG "SPIDER addr: %lx\n", spiderpic);
-		spider_pics[node] = ioremap(spiderpic, 0x800);
-		for (n = 0; n < IIC_NUM_EXT; n++) {
-			int irq = n + IIC_EXT_OFFSET + node * IIC_NODE_STRIDE;
-			get_irq_desc(irq)->chip = &spider_pic;
-		}
-
- 		/* do not mask any interrupts because of level */
- 		out_be32(spider_pics[node] + TIR_MSK, 0x0);
-
- 		/* disable edge detection clear */
- 		/* out_be32(spider_pics[node] + TIR_EDC, 0x0); */
-
- 		/* enable interrupt packets to be output */
- 		out_be32(spider_pics[node] + TIR_PIEN,
-			in_be32(spider_pics[node] + TIR_PIEN) | 0x1);
-
- 		/* Enable the interrupt detection enable bit. Do this last! */
- 		out_be32(spider_pics[node] + TIR_DEN,
-			in_be32(spider_pics[node] + TIR_DEN) | 0x1);
+	int n, irq;
+
+	spider_pics[node] = ioremap(addr, 0x800);
+	if (spider_pics[node] == NULL)
+		panic("spider_pic: can't map registers !");
+
+	printk(KERN_INFO "spider_pic: mapped for node %d, addr: 0x%lx mapped to %p\n",
+	       node, addr, spider_pics[node]);
+
+	for (n = 0; n < IIC_NUM_EXT; n++) {
+		if (n == IIC_EXT_CASCADE)
+			continue;
+		irq = n + IIC_EXT_OFFSET + node * IIC_NODE_STRIDE;
+		set_irq_chip_and_handler(irq, &spider_pic, handle_level_irq);
+		get_irq_desc(irq)->status |= IRQ_LEVEL;
 	}
+
+	/* do not mask any interrupts because of level */
+	out_be32(spider_pics[node] + TIR_MSK, 0x0);
+
+	/* disable edge detection clear */
+	/* out_be32(spider_pics[node] + TIR_EDC, 0x0); */
+
+	/* enable interrupt packets to be output */
+	out_be32(spider_pics[node] + TIR_PIEN,
+		 in_be32(spider_pics[node] + TIR_PIEN) | 0x1);
+
+	/* Hook up cascade */
+	irq = IIC_EXT_CASCADE + node * IIC_NODE_STRIDE;
+	set_irq_data(irq, (void *)(long)node);
+	set_irq_chained_handler(irq, spider_irq_cascade);
+
+	/* Enable the interrupt detection enable bit. Do this last! */
+	out_be32(spider_pics[node] + TIR_DEN,
+		 in_be32(spider_pics[node] + TIR_DEN) | 0x1);
 }
 
-void spider_init_IRQ(void)
+void __init spider_init_IRQ(void)
 {
-	long spider_reg;
+	unsigned long *spider_reg;
 	struct device_node *dn;
 	char *compatible;
-	int n, node = 0;
+	int node = 0;
 
+	/* XXX node numbers are totally bogus. We _hope_ we get the device nodes in the right
+	 * order here but that's definitely not guaranteed, we need to get the node from the
+	 * device tree instead. There is currently no proper property for it (but our whole
+	 * device-tree is bogus anyway) so all we can do is pray or maybe test the address
+	 * and deduce the node-id
+	 */
 	for (dn = NULL; (dn = of_find_node_by_name(dn, "interrupt-controller"));) {
 		compatible = (char *)get_property(dn, "compatible", NULL);
 
 		if (!compatible)
 			continue;
 
-		if (strstr(compatible, "CBEA,platform-spider-pic"))
-			spider_reg = *(long *)get_property(dn,"reg", NULL);
-		else if (strstr(compatible, "sti,platform-spider-pic")) {
-			spider_init_IRQ_hardcoded();
-			return;
+ 		if (strstr(compatible, "CBEA,platform-spider-pic"))
+			spider_reg = (unsigned long *)get_property(dn, "reg", NULL);
+		else if (strstr(compatible, "sti,platform-spider-pic") && (node < 2)) {
+			static long hard_coded_pics[] = { 0x24000008000, 0x34000008000 };
+			spider_reg = &hard_coded_pics[node];
 		} else
 			continue;
 
-		if (!spider_reg)
-			printk("interrupt controller does not have reg property !\n");
-
-		n = prom_n_addr_cells(dn);
-
-		if ( n != 2)
-			printk("reg property with invalid number of elements \n");
-
-		spider_pics[node] = ioremap(spider_reg, 0x800);
-
-		printk("SPIDER addr: %lx with %i addr_cells mapped to %p\n",
-		       spider_reg, n, spider_pics[node]);
-
-		for (n = 0; n < IIC_NUM_EXT; n++) {
-			int irq = n + IIC_EXT_OFFSET + node * IIC_NODE_STRIDE;
-			get_irq_desc(irq)->chip = &spider_pic;
-		}
-
-		/* do not mask any interrupts because of level */
-		out_be32(spider_pics[node] + TIR_MSK, 0x0);
-
-		/* disable edge detection clear */
-		/* out_be32(spider_pics[node] + TIR_EDC, 0x0); */
-
-		/* enable interrupt packets to be output */
-		out_be32(spider_pics[node] + TIR_PIEN,
-			in_be32(spider_pics[node] + TIR_PIEN) | 0x1);
-
-		/* Enable the interrupt detection enable bit. Do this last! */
-		out_be32(spider_pics[node] + TIR_DEN,
-			in_be32(spider_pics[node] + TIR_DEN) | 0x1);
+		if (spider_reg == NULL)
+			printk(KERN_ERR "spider_pic: No address for node %d\n", node);
 
+		spider_init_one(node, *spider_reg);
 		node++;
 	}
 }
Index: linux-work/include/asm-powerpc/udbg.h
===================================================================
--- linux-work.orig/include/asm-powerpc/udbg.h	2006-01-14 14:43:33.000000000 +1100
+++ linux-work/include/asm-powerpc/udbg.h	2006-06-09 17:50:10.000000000 +1000
@@ -41,7 +41,9 @@ extern void __init udbg_init_debug_lpar(
 extern void __init udbg_init_pmac_realmode(void);
 extern void __init udbg_init_maple_realmode(void);
 extern void __init udbg_init_iseries(void);
-extern void __init udbg_init_rtas(void);
+extern void __init udbg_init_rtas_panel(void);
+extern void __init udbg_init_rtas_console(unsigned int put_token,
+					  unsigned int get_token);
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_UDBG_H */

Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 629DEDDDE9
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Dec 2007 05:25:07 +1100 (EST)
Date: Sat, 1 Dec 2007 12:28:41 -0600
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [RFC] [PATCH] pasemi: NMI support with MPIC
Message-ID: <20071201182841.GA25103@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some PWRficient-based boards have a NMI button that's wired up to a GPIO
as interrupt source. By configuring the openpic accordingly, these get
delivered as a machine check with high priority, instead of as an external
interrupt.

The device tree contains a property "nmi-source" in the openpic node
for these systems, and it's the (hwirq) source for the input.

Also, for these interrupts, the IACK is read from another register than
the regular (MCACK), but they are EOI'd as usual. So implement said
function for the mpic driver.

Finally, move a couple of external function defines to include/ instead
of local under sysdev. Being able to mask/unmask and eoi directly saves
us from setting up a dummy irq handler that will never be called.


---

 arch/powerpc/platforms/pasemi/setup.c |   29 ++++++++++++++++++++++++++---
 arch/powerpc/sysdev/mpic.c            |   26 +++++++++++++++++++++++---
 arch/powerpc/sysdev/mpic.h            |    3 ---
 include/asm-powerpc/mpic.h            |   17 ++++++++++++++++-
 4 files changed, 65 insertions(+), 10 deletions(-)


diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index 14dace7..2102acc 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -56,6 +56,7 @@ struct mce_regs {
 
 static struct mce_regs mce_regs[MAX_MCE_REGS];
 static int num_mce_regs;
+static int nmi_virq = NO_IRQ;
 
 
 static void pas_restart(char *cmd)
@@ -184,6 +185,8 @@ static __init void pas_init_IRQ(void)
 	unsigned long openpic_addr;
 	const unsigned int *opprop;
 	int naddr, opplen;
+	int mpic_flags;
+	const unsigned int *nmiprop;
 	struct mpic *mpic;
 
 	mpic_node = NULL;
@@ -216,13 +219,25 @@ static __init void pas_init_IRQ(void)
 	openpic_addr = of_read_number(opprop, naddr);
 	printk(KERN_DEBUG "OpenPIC addr: %lx\n", openpic_addr);
 
+	mpic_flags = MPIC_PRIMARY | MPIC_LARGE_VECTORS;
+
+	nmiprop = of_get_property(mpic_node, "nmi-source", NULL);
+	if (nmiprop)
+		mpic_flags |= MPIC_ENABLE_MCK;
+
 	mpic = mpic_alloc(mpic_node, openpic_addr,
-			  MPIC_PRIMARY|MPIC_LARGE_VECTORS,
-			  0, 0, " PAS-OPIC  ");
+			  mpic_flags, 0, 0, " PAS-OPIC  ");
 	BUG_ON(!mpic);
 
 	mpic_assign_isu(mpic, 0, openpic_addr + 0x10000);
 	mpic_init(mpic);
+	/* The NMI/MCK source needs to be prio 15 */
+	if (nmiprop) {
+		nmi_virq = irq_create_mapping(NULL, *nmiprop);
+		mpic_irq_set_priority(nmi_virq, 15);
+		mpic_unmask_irq(nmi_virq);
+	}
+
 	of_node_put(mpic_node);
 	of_node_put(root);
 }
@@ -242,6 +257,14 @@ static int pas_machine_check_handler(struct pt_regs *regs)
 
 	srr0 = regs->nip;
 	srr1 = regs->msr;
+
+	if (mpic_get_mcirq() == nmi_virq) {
+		printk(KERN_ERR "NMI delivered\n");
+		debugger(regs);
+		mpic_end_irq(nmi_virq);
+		goto out;
+	}
+
 	dsisr = mfspr(SPRN_DSISR);
 	printk(KERN_ERR "Machine Check on CPU %d\n", cpu);
 	printk(KERN_ERR "SRR0  0x%016lx SRR1 0x%016lx\n", srr0, srr1);
@@ -305,7 +328,7 @@ static int pas_machine_check_handler(struct pt_regs *regs)
 		}
 	}
 
-
+out:
 	/* SRR1[62] is from MSR[62] if recoverable, so pass that back */
 	return !!(srr1 & 0x2);
 }
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index e479388..22a691b 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -83,6 +83,7 @@ static u32 mpic_infos[][MPIC_IDX_END] = {
 		MPIC_CPU_WHOAMI,
 		MPIC_CPU_INTACK,
 		MPIC_CPU_EOI,
+		MPIC_CPU_MCACK,
 
 		MPIC_IRQ_BASE,
 		MPIC_IRQ_STRIDE,
@@ -121,6 +122,7 @@ static u32 mpic_infos[][MPIC_IDX_END] = {
 		TSI108_CPU_WHOAMI,
 		TSI108_CPU_INTACK,
 		TSI108_CPU_EOI,
+		TSI108_CPU_MCACK,
 
 		TSI108_IRQ_BASE,
 		TSI108_IRQ_STRIDE,
@@ -1109,6 +1111,11 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 			mb();
 	}
 
+	if (flags & MPIC_ENABLE_MCK)
+		mpic_write(mpic->gregs, MPIC_INFO(GREG_GLOBAL_CONF_0),
+			   mpic_read(mpic->gregs, MPIC_INFO(GREG_GLOBAL_CONF_0))
+			   | MPIC_GREG_GCONF_MCK);
+
 	/* Read feature register, calculate num CPUs and, for non-ISU
 	 * MPICs, num sources as well. On ISU MPICs, sources are counted
 	 * as ISUs are added
@@ -1419,13 +1426,13 @@ void mpic_send_ipi(unsigned int ipi_no, unsigned int cpu_mask)
 		       mpic_physmask(cpu_mask & cpus_addr(cpu_online_map)[0]));
 }
 
-unsigned int mpic_get_one_irq(struct mpic *mpic)
+static unsigned int _mpic_get_one_irq(struct mpic *mpic, int reg)
 {
 	u32 src;
 
-	src = mpic_cpu_read(MPIC_INFO(CPU_INTACK)) & MPIC_INFO(VECPRI_VECTOR_MASK);
+	src = mpic_cpu_read(reg) & MPIC_INFO(VECPRI_VECTOR_MASK);
 #ifdef DEBUG_LOW
-	DBG("%s: get_one_irq(): %d\n", mpic->name, src);
+	DBG("%s: get_one_irq(reg 0x%x): %d\n", mpic->name, reg, src);
 #endif
 	if (unlikely(src == mpic->spurious_vec)) {
 		if (mpic->flags & MPIC_SPV_EOI)
@@ -1443,6 +1450,11 @@ unsigned int mpic_get_one_irq(struct mpic *mpic)
 	return irq_linear_revmap(mpic->irqhost, src);
 }
 
+unsigned int mpic_get_one_irq(struct mpic *mpic)
+{
+	return _mpic_get_one_irq(mpic, MPIC_INFO(CPU_INTACK));
+}
+
 unsigned int mpic_get_irq(void)
 {
 	struct mpic *mpic = mpic_primary;
@@ -1452,6 +1464,14 @@ unsigned int mpic_get_irq(void)
 	return mpic_get_one_irq(mpic);
 }
 
+unsigned int mpic_get_mcirq(void)
+{
+	struct mpic *mpic = mpic_primary;
+
+	BUG_ON(mpic == NULL);
+
+	return _mpic_get_one_irq(mpic, MPIC_INFO(CPU_MCACK));
+}
 
 #ifdef CONFIG_SMP
 void mpic_request_ipis(void)
diff --git a/arch/powerpc/sysdev/mpic.h b/arch/powerpc/sysdev/mpic.h
index 1cb6bd8..31bc44f 100644
--- a/arch/powerpc/sysdev/mpic.h
+++ b/arch/powerpc/sysdev/mpic.h
@@ -31,9 +31,6 @@ static inline int mpic_u3msi_init(struct mpic *mpic)
 #endif
 
 extern int mpic_set_irq_type(unsigned int virq, unsigned int flow_type);
-extern void mpic_end_irq(unsigned int irq);
-extern void mpic_mask_irq(unsigned int irq);
-extern void mpic_unmask_irq(unsigned int irq);
 extern void mpic_set_affinity(unsigned int irq, cpumask_t cpumask);
 
 #endif /* _POWERPC_SYSDEV_MPIC_H */
diff --git a/include/asm-powerpc/mpic.h b/include/asm-powerpc/mpic.h
index ae84dde..e7ac810 100644
--- a/include/asm-powerpc/mpic.h
+++ b/include/asm-powerpc/mpic.h
@@ -23,6 +23,7 @@
 #define		MPIC_GREG_GCONF_RESET			0x80000000
 #define		MPIC_GREG_GCONF_8259_PTHROU_DIS		0x20000000
 #define		MPIC_GREG_GCONF_BASE_MASK		0x000fffff
+#define		MPIC_GREG_GCONF_MCK			0x08000000
 #define MPIC_GREG_GLOBAL_CONF_1		0x00030
 #define		MPIC_GREG_GLOBAL_CONF_1_SIE		0x08000000
 #define		MPIC_GREG_GLOBAL_CONF_1_CLK_RATIO_MASK	0x70000000
@@ -78,6 +79,7 @@
 #define 	MPIC_CPU_WHOAMI_MASK			0x0000001f
 #define MPIC_CPU_INTACK			0x000a0
 #define MPIC_CPU_EOI			0x000b0
+#define MPIC_CPU_MCACK			0x000c0
 
 /*
  * Per-source registers
@@ -141,6 +143,7 @@
 #define TSI108_CPU_WHOAMI		0xffffffff
 #define TSI108_CPU_INTACK		0x00004
 #define TSI108_CPU_EOI			0x00008
+#define TSI108_CPU_MCACK		0x00004 /* Doesn't really exist here */
 
 /*
  * Per-source registers
@@ -183,6 +186,7 @@ enum {
 	MPIC_IDX_CPU_WHOAMI,
 	MPIC_IDX_CPU_INTACK,
 	MPIC_IDX_CPU_EOI,
+	MPIC_IDX_CPU_MCACK,
 
 	MPIC_IDX_IRQ_BASE,
 	MPIC_IDX_IRQ_STRIDE,
@@ -344,6 +348,8 @@ struct mpic
 #define MPIC_USES_DCR			0x00000080
 /* MPIC has 11-bit vector fields (or larger) */
 #define MPIC_LARGE_VECTORS		0x00000100
+/* Enable delivery of prio 15 interrupts as MCK instead of EE */
+#define MPIC_ENABLE_MCK			0x00000200
 
 /* MPIC HW modification ID */
 #define MPIC_REGSET_MASK		0xf0000000
@@ -447,10 +453,19 @@ extern void mpic_send_ipi(unsigned int ipi_no, unsigned int cpu_mask);
 /* Send a message (IPI) to a given target (cpu number or MSG_*) */
 void smp_mpic_message_pass(int target, int msg);
 
+/* Unmask a specific virq */
+extern void mpic_unmask_irq(unsigned int irq);
+/* Mask a specific virq */
+extern void mpic_mask_irq(unsigned int irq);
+/* EOI a specific virq */
+extern void mpic_end_irq(unsigned int irq);
+
 /* Fetch interrupt from a given mpic */
 extern unsigned int mpic_get_one_irq(struct mpic *mpic);
-/* This one gets to the primary mpic */
+/* This one gets from the primary mpic */
 extern unsigned int mpic_get_irq(void);
+/* Fetch Machine Check interrupt from primary mpic */
+extern unsigned int mpic_get_mcirq(void);
 
 /* Set the EPIC clock ratio */
 void mpic_set_clk_ratio(struct mpic *mpic, u32 clock_ratio);

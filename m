From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Tue, 11 Mar 2003 13:29:43 -0700
To: linuxppc-dev@lists.linuxppc.org
Subject: gt64260_pic.c SMP cleanup
Message-ID: <20030311202943.GA4138@rover.farnsworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This patch generalizes the GT64260's SMP irq affinity handling.

It replaces the hardcoded per-cpu masks specific to the MOTMVP with
per-cpu mask tables that can be manipulated via the set_affinity API.
Interrupts can now be shared or steered dynamically between processors
by manipulating /proc/irq/*/smp_affinity.

-Dale

This patch is relative to linuxppc_2_4_devel with my gt64260_mask_irq
patch.

===== include/asm-ppc/gt64260.h 1.14 vs edited =====
--- 1.14/include/asm-ppc/gt64260.h	Fri Feb 28 10:31:00 2003
+++ edited/include/asm-ppc/gt64260.h	Tue Mar 11 13:01:45 2003
@@ -351,4 +351,6 @@

 void gt64260_mpsc_progress(char *s, unsigned short hex);

+void gt64260_set_irq_affinity(unsigned int irq, unsigned long mask);
+
 #endif /* __ASMPPC_GT64260_H */
===== arch/ppc/kernel/gt64260_pic.c 1.11 vs edited =====
--- 1.11/arch/ppc/kernel/gt64260_pic.c	Tue Mar 11 13:03:30 2003
+++ edited/arch/ppc/kernel/gt64260_pic.c	Tue Mar 11 13:06:44 2003
@@ -8,7 +8,7 @@
  *
  * Based on sources from Rabeeh Khoury / Galileo Technology
  *
- * 2001-2002 (c) MontaVista, Software, Inc.  This file is licensed under
+ * 2001-2003 (c) MontaVista, Software, Inc.  This file is licensed under
  * the terms of the GNU General Public License version 2.  This program
  * is licensed "as is" without any warranty of any kind, whether express
  * or implied.
@@ -69,11 +69,35 @@
 	gt64260_mask_irq,		/* disable */
 	gt64260_mask_irq,		/* mask and ack */
 	gt64260_end_irq,		/* end */
-	NULL				/* set_affinity */
+	gt64260_set_irq_affinity	/* set_affinity */
 };

 u32 gt64260_irq_base = 0;      /* GT64260 handles the next 96 IRQs from here */

+    				/* intr_mask_lo, intr_mask_hi, intr_mask_gpp */
+#define GT64260_VALID_IRQ_MASK	{ 0x3dfffffe,	0x0f000db7,	0xffffffff }
+
+static u32 gt64260_valid_irqs[] = GT64260_VALID_IRQ_MASK;
+
+static u32 gt64260_cpu_intr_mask[NR_CPUS][3] = {
+#if defined(CONFIG_SMP) && defined(CONFIG_IRQ_ALL_CPUS)
+	[0 ... NR_CPUS-1] =		/* set masks for each cpu */
+#endif
+	GT64260_VALID_IRQ_MASK
+};
+
+/*
+ * These are the default interrupt mask register offsets.
+ * Since the interrupt lines going to each cpu is board-specific,
+ * they may be changed by calling gt64260_set_intr_mask_reg_offsets().
+ */
+static u32 gt64260_intr_mask_reg_offset[NR_CPUS][2] = {
+    { GT64260_IC_CPU_INTR_MASK_LO, GT64260_IC_CPU_INTR_MASK_HI },
+#ifdef CONFIG_SMP
+    { GT64260_IC_PCI_1_INTR_MASK_LO, GT64260_IC_PCI_1_INTR_MASK_HI }
+#endif
+};
+
 #ifdef ENABLE_ECC_INT_HANDLER
 static u32
 gt_ecc_irq_ack(void)
@@ -124,6 +148,95 @@
 }
 #endif /* ENABLE_ECC_INT_HANDLER */

+#ifdef CONFIG_SMP
+
+static inline void
+gt_write_intr_mask_lo(void)
+{
+	gt_write(gt64260_intr_mask_reg_offset[0][0],
+		gt64260_cpu_intr_mask[0][0] & ppc_cached_irq_mask[0]);
+	gt_write(gt64260_intr_mask_reg_offset[1][0],
+		gt64260_cpu_intr_mask[1][0] & ppc_cached_irq_mask[0]);
+}
+
+static inline void
+gt_write_intr_mask_hi(void)
+{
+	gt_write(gt64260_intr_mask_reg_offset[0][1],
+		gt64260_cpu_intr_mask[0][1] & ppc_cached_irq_mask[1]);
+	gt_write(gt64260_intr_mask_reg_offset[1][1],
+		gt64260_cpu_intr_mask[1][1] & ppc_cached_irq_mask[1]);
+}
+
+static inline void
+gt_set_intr_mask_hi_for_gpp(unsigned int irq)
+{
+	int cpu;
+    	unsigned int gpp_bit;
+	unsigned int hi_bit;
+	unsigned int gpp_group_mask;
+
+	/* each group of 8 gpp irqs shares one bit of intr_mask_hi */
+	gpp_bit = irq - 64;
+	hi_bit = (gpp_bit >> 3) + 24;
+	gpp_group_mask = 0xff << (gpp_bit & ~7);
+
+	for (cpu=0; cpu<NR_CPUS; cpu++) {
+		if (gpp_group_mask & gt64260_cpu_intr_mask[cpu][2])
+			set_bit(hi_bit, &gt64260_cpu_intr_mask[cpu][1]);
+		else
+			clear_bit(hi_bit, &gt64260_cpu_intr_mask[cpu][1]);
+	}
+	gt_write_intr_mask_hi();
+}
+
+void
+gt64260_set_irq_affinity(unsigned int irqa, unsigned long mask)
+{
+	int cpu;
+	unsigned int irq = irqa - gt64260_irq_base;
+
+	if (!test_bit(irq, &gt64260_valid_irqs)) {
+		printk(KERN_WARNING "smp_affinity: invalid irq: %d\n", irqa);
+		return;
+	}
+
+	for (cpu=0; cpu<NR_CPUS; cpu++) {
+		if (mask & (1<<cpu))
+			set_bit(irq, &gt64260_cpu_intr_mask[cpu]);
+		else
+			clear_bit(irq, &gt64260_cpu_intr_mask[cpu]);
+	}
+
+	if (irq < 32)
+		gt_write_intr_mask_lo();
+	else if (irq < 64)
+		gt_write_intr_mask_hi();
+	else
+		gt_set_intr_mask_hi_for_gpp(irq);
+}
+
+#else
+
+static inline void
+gt_write_intr_mask_lo()
+{
+	gt_write(gt64260_intr_mask_reg_offset[0][0], ppc_cached_irq_mask[0]);
+}
+
+static inline void
+gt_write_intr_mask_hi()
+{
+	gt_write(gt64260_intr_mask_reg_offset[0][1], ppc_cached_irq_mask[1]);
+}
+#endif
+
+__init void
+gt64260_set_intr_mask_reg_offsets(int cpu, u32 lo_reg_offset, u32 hi_reg_offset)
+{
+    	gt64260_intr_mask_reg_offset[cpu][0] = lo_reg_offset;
+    	gt64260_intr_mask_reg_offset[cpu][1] = hi_reg_offset;
+}

 /* gt64260_init_irq()
  *
@@ -151,19 +264,14 @@
 	if ( ppc_md.progress ) ppc_md.progress("gt64260_init_irq: enter", 0x0);

 	ppc_cached_irq_mask[0] = 0;
-#if defined(CONFIG_MOT_MVP) || defined(CONFIG_HXEB100)
-	ppc_cached_irq_mask[1] = 0x07000000; /* Enable GPP intrs */
-	ppc_cached_irq_mask[2] = 0x08000020;
-#else
 	ppc_cached_irq_mask[1] = 0x0f000000; /* Enable GPP intrs */
 	ppc_cached_irq_mask[2] = 0;
-#endif

 	/* disable all interrupts and clear current interrupts */
 	gt_write(GT64260_GPP_INTR_MASK, ppc_cached_irq_mask[2]);
 	gt_write(GT64260_GPP_INTR_CAUSE,0);
-	gt_write(GT64260_IC_CPU_INTR_MASK_LO, ppc_cached_irq_mask[0]);
-	gt_write(GT64260_IC_CPU_INTR_MASK_HI, ppc_cached_irq_mask[1]);
+	gt_write_intr_mask_lo();
+	gt_write_intr_mask_hi();

 	/* use the gt64260 for all (possible) interrupt sources */
 	for( i = gt64260_irq_base;  i < (gt64260_irq_base + 96);  i++ )  {
@@ -188,9 +296,28 @@
 #endif

 	if ( ppc_md.progress ) ppc_md.progress("gt64260_init_irq: exit", 0x0);
-
 }

+static inline u32
+gt_read_main_cause_lo(int cpu)
+{
+	return gt_read(GT64260_IC_MAIN_CAUSE_LO) &
+		gt64260_cpu_intr_mask[cpu][0] & ppc_cached_irq_mask[0];
+}
+
+static inline u32
+gt_read_main_cause_hi(int cpu)
+{
+	return gt_read(GT64260_IC_MAIN_CAUSE_HI) &
+		gt64260_cpu_intr_mask[cpu][1] & ppc_cached_irq_mask[1];
+}
+
+static inline u32
+gt_read_gpp_cause(int cpu)
+{
+	return gt_read(GT64260_GPP_INTR_CAUSE) &
+		gt64260_cpu_intr_mask[cpu][2] & ppc_cached_irq_mask[2];
+}

 /* gt64260_get_irq()
  *
@@ -211,59 +338,42 @@
 gt64260_get_irq(struct pt_regs *regs)
 {
 	int irq;
-	int irq_gpp;
-	int cpu;
+	int cpu = smp_processor_id();

-	cpu = smp_processor_id();
-	irq = gt_read(GT64260_IC_MAIN_CAUSE_LO);
-	irq = __ilog2((irq & 0x3dfffffe) & ppc_cached_irq_mask[0]);
+	irq = __ilog2(gt_read_main_cause_lo(cpu));

 	if (irq == -1) {
-		irq = gt_read(GT64260_IC_MAIN_CAUSE_HI);
-#if defined(CONFIG_MOT_MVP) || defined(CONFIG_HXEB100)
-		/* Okay, this whole irq mess needs a rewrite bad, but who
-		 * am I to argue with a deadline? -- Troy
-		 */
-		if (cpu == 1){
-			irq = __ilog2((irq & 0x08000000));
-		}else{
-			irq = __ilog2((irq & 0x07000db7) & ppc_cached_irq_mask[1]);
-		}
-#else
-		irq = __ilog2((irq & 0x0f000db7) & ppc_cached_irq_mask[1]);
-#endif
+		irq = __ilog2(gt_read_main_cause_hi(cpu));

 		if (irq == -1) {
-			irq = -2;   /* bogus interrupt, should never happen */
+#ifdef CONFIG_SMP
+/*
+ * When irq are shared between two cpus, both may trap.
+ * The second one to respond finds no irq pending.
+ * Set return value to -2, so it's not recorded as a spurious interrupt.
+ */
+			irq = -2;
+#endif
 		}
-		else if (irq < 24) {
+		else if (irq < 24)
 			irq += 32;
-		}
 		else {
-			irq_gpp = gt_read(GT64260_GPP_INTR_CAUSE);
-#if defined(CONFIG_MOT_MVP) || defined(CONFIG_HXEB100)
-			if (cpu == 1){
-				irq_gpp = __ilog2((irq_gpp & 0x08000000));
-			}else{
-				irq_gpp = __ilog2(irq_gpp & ppc_cached_irq_mask[2] & ~0x08000000);
-			}
-#else
-			irq_gpp = __ilog2(irq_gpp & ppc_cached_irq_mask[2]);
-#endif
+			irq = __ilog2(gt_read_gpp_cause(cpu));

-			if (irq_gpp == -1) {
-				irq = -2;
-			} else {
-				irq = irq_gpp + 64;
+			if (irq == -1) {
+#ifdef CONFIG_SMP
+				irq = -2; /* assume this cpu lost the race */
+#endif
 			}
+			else
+				irq += 64;
 		}
 	}

-	if( irq < 0 )  {
-		return( irq );
-	} else  {
-		return( gt64260_irq_base + irq );
-	}
+	if (irq < 0)
+		return irq;
+	else
+		return gt64260_irq_base + irq;
 }

 /* gt64260_unmask_irq()
@@ -293,13 +403,12 @@
 		} else {
 			/* unmask high interrupt register */
 			set_bit(irq-32, &ppc_cached_irq_mask[1]);
-			gt_write(GT64260_IC_CPU_INTR_MASK_HI,
-				     ppc_cached_irq_mask[1]);
+			gt_write_intr_mask_hi();
 		}
 	} else {
 		/* unmask low interrupt register */
 		set_bit(irq, &ppc_cached_irq_mask[0]);
-		gt_write(GT64260_IC_CPU_INTR_MASK_LO, ppc_cached_irq_mask[0]);
+		gt_write_intr_mask_lo();
 	}
 }

@@ -331,13 +440,12 @@
 		} else {
 			/* mask high interrupt register */
 			clear_bit(irq-32, &ppc_cached_irq_mask[1]);
-			gt_write(GT64260_IC_CPU_INTR_MASK_HI,
-				     ppc_cached_irq_mask[1]);
+			gt_write_intr_mask_hi();
 		}
 	} else {
 		/* mask low interrupt register */
 		clear_bit(irq, &ppc_cached_irq_mask[0]);
-		gt_write(GT64260_IC_CPU_INTR_MASK_LO, ppc_cached_irq_mask[0]);
+		gt_write_intr_mask_lo();
 	}
 	/*
 	 * Need to drain the pipeline to ensure that the register has

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

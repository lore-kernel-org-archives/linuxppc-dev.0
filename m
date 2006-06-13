Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 3F20D67B43
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jun 2006 17:07:34 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k5D7ID7r009293
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jun 2006 00:18:13 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k5D77SZc011425
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jun 2006 02:07:29 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD4673069C3F42@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>
Subject: [PATCH/2.6.17-rc6 3/4 v2]Powerpc:  Add tsi108 mpic support
Date: Tue, 13 Jun 2006 15:07:27 +0800
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Alexandre.Bounine@tundra.com,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


 Add Tundra Semiconductor tsi108 host bridge interrupt 
 controller support (by modified mpic port). 
 
 Signed-off-by: Alexandre Bounine <alexandreb@tundra.com>
 Signed-off-by: Roy Zang	<tie-fei.zang@freescale.com>
 
 ---
 
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 7dcdfcb..fc21e47 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -55,6 +55,78 @@ #define distribute_irqs	(0)
 #endif
 #endif
 
+static struct mpic_info mpic_infos[] = {
+	[0] = {	/* Original OpenPIC compatible MPIC */
+	.greg_base	= MPIC_GREG_BASE,
+	.greg_frr0	= MPIC_GREG_FEATURE_0,
+	.greg_config0	= MPIC_GREG_GLOBAL_CONF_0,
+	.greg_vendor_id	= MPIC_GREG_VENDOR_ID,
+	.greg_ipi_vp0	= MPIC_GREG_IPI_VECTOR_PRI_0,
+	.greg_ipi_stride	= MPIC_GREG_IPI_STRIDE,
+	.greg_spurious	= MPIC_GREG_SPURIOUS,
+	.greg_tfrr	= MPIC_GREG_TIMER_FREQ,
+
+	.timer_base	= MPIC_TIMER_BASE,
+	.timer_stride	= MPIC_TIMER_STRIDE,
+	.timer_ccr	= MPIC_TIMER_CURRENT_CNT,
+	.timer_bcr	= MPIC_TIMER_BASE_CNT,
+	.timer_vpr	= MPIC_TIMER_VECTOR_PRI,
+	.timer_dest	= MPIC_TIMER_DESTINATION,
+
+	.cpu_base	= MPIC_CPU_BASE,
+	.cpu_stride	= MPIC_CPU_STRIDE,
+	.cpu_ipi_disp0	= MPIC_CPU_IPI_DISPATCH_0,
+	.cpu_ipi_disp_stride	= MPIC_CPU_IPI_DISPATCH_STRIDE,
+	.cpu_task_pri	= MPIC_CPU_CURRENT_TASK_PRI,
+	.cpu_whoami	= MPIC_CPU_WHOAMI,
+	.cpu_intack	= MPIC_CPU_INTACK,
+	.cpu_eoi	= MPIC_CPU_EOI,
+
+	.irq_base	= MPIC_IRQ_BASE,
+	.irq_stride	= MPIC_IRQ_STRIDE,
+	.irq_vpr	= MPIC_IRQ_VECTOR_PRI,
+	.irq_vpr_vector	= MPIC_VECPRI_VECTOR_MASK,
+	.irq_vpr_polpos	= MPIC_VECPRI_POLARITY_POSITIVE,
+	.irq_vpr_senlvl	= MPIC_VECPRI_SENSE_LEVEL,
+	.irq_dest	= MPIC_IRQ_DESTINATION,
+	},
+
+	[1] = {	/* Tsi108/109 PIC */
+	.greg_base	= TSI108_GREG_BASE,
+	.greg_frr0	= TSI108_GREG_FEATURE_0,
+	.greg_config0	= TSI108_GREG_GLOBAL_CONF_0,
+	.greg_vendor_id	= TSI108_GREG_VENDOR_ID,
+	.greg_ipi_vp0	= TSI108_GREG_IPI_VECTOR_PRI_0,
+	.greg_ipi_stride	= TSI108_GREG_IPI_STRIDE,
+	.greg_spurious	= TSI108_GREG_SPURIOUS,
+	.greg_tfrr	= TSI108_GREG_TIMER_FREQ,
+
+	.timer_base	= TSI108_TIMER_BASE,
+	.timer_stride	= TSI108_TIMER_STRIDE,
+	.timer_ccr	= TSI108_TIMER_CURRENT_CNT,
+	.timer_bcr	= TSI108_TIMER_BASE_CNT,
+	.timer_vpr	= TSI108_TIMER_VECTOR_PRI,
+	.timer_dest	= TSI108_TIMER_DESTINATION,
+
+	.cpu_base	= TSI108_CPU_BASE,
+	.cpu_stride	= TSI108_CPU_STRIDE,
+	.cpu_ipi_disp0	= TSI108_CPU_IPI_DISPATCH_0,
+	.cpu_ipi_disp_stride	= TSI108_CPU_IPI_DISPATCH_STRIDE,
+	.cpu_task_pri	= TSI108_CPU_CURRENT_TASK_PRI,
+	.cpu_whoami	= 0xFFFFFFFF,
+	.cpu_intack	= TSI108_CPU_INTACK,
+	.cpu_eoi	= TSI108_CPU_EOI,
+
+	.irq_base	= TSI108_IRQ_REG_BASE,
+	.irq_stride	= TSI108_IRQ_STRIDE,
+	.irq_vpr	= TSI108_IRQ_VECTOR_PRI,
+	.irq_vpr_vector = TSI108_VECPRI_VECTOR_MASK,
+	.irq_vpr_polpos = TSI108_VECPRI_POLARITY_POSITIVE,
+	.irq_vpr_senlvl = TSI108_VECPRI_SENSE_LEVEL,
+	.irq_dest	= TSI108_IRQ_DESTINATION,
+	},
+};
+
 /*
  * Register accessor functions
  */
@@ -81,7 +153,8 @@ static inline void _mpic_write(unsigned 
 static inline u32 _mpic_ipi_read(struct mpic *mpic, unsigned int ipi)
 {
 	unsigned int be = (mpic->flags & MPIC_BIG_ENDIAN) != 0;
-	unsigned int offset = MPIC_GREG_IPI_VECTOR_PRI_0 + (ipi * 0x10);
+	unsigned int offset = mpic->hw_set->greg_ipi_vp0 +
+			      (ipi * mpic->hw_set->greg_ipi_stride);
 
 	if (mpic->flags & MPIC_BROKEN_IPI)
 		be = !be;
@@ -90,7 +163,8 @@ static inline u32 _mpic_ipi_read(struct 
 
 static inline void _mpic_ipi_write(struct mpic *mpic, unsigned int ipi, u32 value)
 {
-	unsigned int offset = MPIC_GREG_IPI_VECTOR_PRI_0 + (ipi * 0x10);
+	unsigned int offset = mpic->hw_set->greg_ipi_vp0 +
+			      (ipi * mpic->hw_set->greg_ipi_stride);
 
 	_mpic_write(mpic->flags & MPIC_BIG_ENDIAN, mpic->gregs, offset, value);
 }
@@ -121,7 +195,7 @@ static inline u32 _mpic_irq_read(struct 
 	unsigned int	idx = src_no & mpic->isu_mask;
 
 	return _mpic_read(mpic->flags & MPIC_BIG_ENDIAN, mpic->isus[isu],
-			  reg + (idx * MPIC_IRQ_STRIDE));
+			  reg + (idx * mpic->hw_set->irq_stride));
 }
 
 static inline void _mpic_irq_write(struct mpic *mpic, unsigned int src_no,
@@ -131,7 +205,7 @@ static inline void _mpic_irq_write(struc
 	unsigned int	idx = src_no & mpic->isu_mask;
 
 	_mpic_write(mpic->flags & MPIC_BIG_ENDIAN, mpic->isus[isu],
-		    reg + (idx * MPIC_IRQ_STRIDE), value);
+		    reg + (idx * mpic->hw_set->irq_stride), value);
 }
 
 #define mpic_read(b,r)		_mpic_read(mpic->flags & MPIC_BIG_ENDIAN,(b),(r))
@@ -157,8 +231,8 @@ static void __init mpic_test_broken_ipi(
 {
 	u32 r;
 
-	mpic_write(mpic->gregs, MPIC_GREG_IPI_VECTOR_PRI_0, MPIC_VECPRI_MASK);
-	r = mpic_read(mpic->gregs, MPIC_GREG_IPI_VECTOR_PRI_0);
+	mpic_write(mpic->gregs, mpic->hw_set->greg_ipi_vp0, MPIC_VECPRI_MASK);
+	r = mpic_read(mpic->gregs, mpic->hw_set->greg_ipi_vp0);
 
 	if (r == le32_to_cpu(MPIC_VECPRI_MASK)) {
 		printk(KERN_INFO "mpic: Detected reversed IPI registers\n");
@@ -392,8 +466,8 @@ static inline struct mpic * mpic_from_ir
 /* Send an EOI */
 static inline void mpic_eoi(struct mpic *mpic)
 {
-	mpic_cpu_write(MPIC_CPU_EOI, 0);
-	(void)mpic_cpu_read(MPIC_CPU_WHOAMI);
+	mpic_cpu_write(mpic->hw_set->cpu_eoi, 0);
+	(void)mpic_cpu_read(mpic->hw_set->cpu_task_pri);
 }
 
 #ifdef CONFIG_SMP
@@ -419,8 +493,8 @@ static void mpic_enable_irq(unsigned int
 
 	DBG("%p: %s: enable_irq: %d (src %d)\n", mpic, mpic->name, irq, src);
 
-	mpic_irq_write(src, MPIC_IRQ_VECTOR_PRI,
-		       mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) &
+	mpic_irq_write(src, mpic->hw_set->irq_vpr,
+		       mpic_irq_read(src, mpic->hw_set->irq_vpr) &
 		       ~MPIC_VECPRI_MASK);
 
 	/* make sure mask gets to controller before we return to user */
@@ -429,7 +503,7 @@ static void mpic_enable_irq(unsigned int
 			printk(KERN_ERR "mpic_enable_irq timeout\n");
 			break;
 		}
-	} while(mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) & MPIC_VECPRI_MASK);	
+	} while(mpic_irq_read(src, mpic->hw_set->irq_vpr) & MPIC_VECPRI_MASK);	
 
 #ifdef CONFIG_MPIC_BROKEN_U3
 	if (mpic->flags & MPIC_BROKEN_U3) {
@@ -466,8 +540,8 @@ static void mpic_disable_irq(unsigned in
 
 	DBG("%s: disable_irq: %d (src %d)\n", mpic->name, irq, src);
 
-	mpic_irq_write(src, MPIC_IRQ_VECTOR_PRI,
-		       mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) |
+	mpic_irq_write(src, mpic->hw_set->irq_vpr,
+		       mpic_irq_read(src, mpic->hw_set->irq_vpr) |
 		       MPIC_VECPRI_MASK);
 
 	/* make sure mask gets to controller before we return to user */
@@ -476,7 +550,7 @@ static void mpic_disable_irq(unsigned in
 			printk(KERN_ERR "mpic_enable_irq timeout\n");
 			break;
 		}
-	} while(!(mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) & MPIC_VECPRI_MASK));
+	} while(!(mpic_irq_read(src, mpic->hw_set->irq_vpr) & MPIC_VECPRI_MASK));
 }
 
 static void mpic_shutdown_irq(unsigned int irq)
@@ -557,7 +631,7 @@ static void mpic_set_affinity(unsigned i
 
 	cpus_and(tmp, cpumask, cpu_online_map);
 
-	mpic_irq_write(irq - mpic->irq_offset, MPIC_IRQ_DESTINATION,
+	mpic_irq_write(irq - mpic->irq_offset, mpic->hw_set->irq_dest,
 		       mpic_physmask(cpus_addr(tmp)[0]));	
 }
 
@@ -613,18 +687,20 @@ #endif /* CONFIG_SMP */
 	mpic->num_sources = 0; /* so far */
 	mpic->senses = senses;
 	mpic->senses_count = senses_count;
+	mpic->hw_set = &mpic_infos[MPIC_GET_MOD_ID(flags)];
 
 	/* Map the global registers */
-	mpic->gregs = ioremap(phys_addr + MPIC_GREG_BASE, 0x1000);
-	mpic->tmregs = mpic->gregs + ((MPIC_TIMER_BASE - MPIC_GREG_BASE) >> 2);
+	mpic->gregs = ioremap(phys_addr + mpic->hw_set->greg_base, 0x1000);
+	mpic->tmregs = mpic->gregs +
+		       ((mpic->hw_set->timer_base - mpic->hw_set->greg_base) >> 2);
 	BUG_ON(mpic->gregs == NULL);
 
 	/* Reset */
 	if (flags & MPIC_WANTS_RESET) {
-		mpic_write(mpic->gregs, MPIC_GREG_GLOBAL_CONF_0,
-			   mpic_read(mpic->gregs, MPIC_GREG_GLOBAL_CONF_0)
+		mpic_write(mpic->gregs, mpic->hw_set->greg_config0,
+			   mpic_read(mpic->gregs, mpic->hw_set->greg_config0)
 			   | MPIC_GREG_GCONF_RESET);
-		while( mpic_read(mpic->gregs, MPIC_GREG_GLOBAL_CONF_0)
+		while( mpic_read(mpic->gregs, mpic->hw_set->greg_config0)
 		       & MPIC_GREG_GCONF_RESET)
 			mb();
 	}
@@ -633,7 +709,7 @@ #endif /* CONFIG_SMP */
 	 * MPICs, num sources as well. On ISU MPICs, sources are counted
 	 * as ISUs are added
 	 */
-	reg = mpic_read(mpic->gregs, MPIC_GREG_FEATURE_0);
+	reg = mpic_read(mpic->gregs, mpic->hw_set->greg_frr0);
 	mpic->num_cpus = ((reg & MPIC_GREG_FEATURE_LAST_CPU_MASK)
 			  >> MPIC_GREG_FEATURE_LAST_CPU_SHIFT) + 1;
 	if (isu_size == 0)
@@ -642,16 +718,16 @@ #endif /* CONFIG_SMP */
 
 	/* Map the per-CPU registers */
 	for (i = 0; i < mpic->num_cpus; i++) {
-		mpic->cpuregs[i] = ioremap(phys_addr + MPIC_CPU_BASE +
-					   i * MPIC_CPU_STRIDE, 0x1000);
+		mpic->cpuregs[i] = ioremap(phys_addr + mpic->hw_set->cpu_base +
+					   i * mpic->hw_set->cpu_stride, 0x1000);
 		BUG_ON(mpic->cpuregs[i] == NULL);
 	}
 
 	/* Initialize main ISU if none provided */
 	if (mpic->isu_size == 0) {
 		mpic->isu_size = mpic->num_sources;
-		mpic->isus[0] = ioremap(phys_addr + MPIC_IRQ_BASE,
-					MPIC_IRQ_STRIDE * mpic->isu_size);
+		mpic->isus[0] = ioremap(phys_addr + mpic->hw_set->irq_base,
+					mpic->hw_set->irq_stride * mpic->isu_size);
 		BUG_ON(mpic->isus[0] == NULL);
 	}
 	mpic->isu_shift = 1 + __ilog2(mpic->isu_size - 1);
@@ -693,7 +769,8 @@ void __init mpic_assign_isu(struct mpic 
 
 	BUG_ON(isu_num >= MPIC_MAX_ISU);
 
-	mpic->isus[isu_num] = ioremap(phys_addr, MPIC_IRQ_STRIDE * mpic->isu_size);
+	mpic->isus[isu_num] = ioremap(phys_addr,
+				      mpic->hw_set->irq_stride * mpic->isu_size);
 	if ((isu_first + mpic->isu_size) > mpic->num_sources)
 		mpic->num_sources = isu_first + mpic->isu_size;
 }
@@ -729,14 +806,15 @@ void __init mpic_init(struct mpic *mpic)
 	printk(KERN_INFO "mpic: Initializing for %d sources\n", mpic->num_sources);
 
 	/* Set current processor priority to max */
-	mpic_cpu_write(MPIC_CPU_CURRENT_TASK_PRI, 0xf);
+	mpic_cpu_write(mpic->hw_set->cpu_task_pri, 0xf);
 
 	/* Initialize timers: just disable them all */
 	for (i = 0; i < 4; i++) {
 		mpic_write(mpic->tmregs,
-			   i * MPIC_TIMER_STRIDE + MPIC_TIMER_DESTINATION, 0);
+			   i * mpic->hw_set->timer_stride +
+			   mpic->hw_set->timer_dest, 0);
 		mpic_write(mpic->tmregs,
-			   i * MPIC_TIMER_STRIDE + MPIC_TIMER_VECTOR_PRI,
+			   i * mpic->hw_set->timer_stride + mpic->hw_set->timer_vpr,
 			   MPIC_VECPRI_MASK |
 			   (MPIC_VEC_TIMER_0 + i));
 	}
@@ -780,14 +858,14 @@ #endif /* CONFIG_MPIC_BROKEN_U3 */
 		/* do senses munging */
 		if (mpic->senses && i < mpic->senses_count) {
 			if (mpic->senses[i] & IRQ_SENSE_LEVEL)
-				vecpri |= MPIC_VECPRI_SENSE_LEVEL;
+				vecpri |= mpic->hw_set->irq_vpr_senlvl;
 			if (mpic->senses[i] & IRQ_POLARITY_POSITIVE)
-				vecpri |= MPIC_VECPRI_POLARITY_POSITIVE;
+				vecpri |= mpic->hw_set->irq_vpr_polpos;
 		} else
-			vecpri |= MPIC_VECPRI_SENSE_LEVEL;
+			vecpri |= mpic->hw_set->irq_vpr_senlvl;
 
 		/* remember if it was a level interrupts */
-		level = (vecpri & MPIC_VECPRI_SENSE_LEVEL);
+		level = (vecpri & mpic->hw_set->irq_vpr_senlvl);
 
 		/* deal with broken U3 */
 		if (mpic->flags & MPIC_BROKEN_U3) {
@@ -795,7 +873,7 @@ #ifdef CONFIG_MPIC_BROKEN_U3
 			if (mpic_is_ht_interrupt(mpic, i)) {
 				vecpri &= ~(MPIC_VECPRI_SENSE_MASK |
 					    MPIC_VECPRI_POLARITY_MASK);
-				vecpri |= MPIC_VECPRI_POLARITY_POSITIVE;
+				vecpri |= mpic->hw_set->irq_vpr_polpos;
 			}
 #else
 			printk(KERN_ERR "mpic: BROKEN_U3 set, but CONFIG doesn't match\n");
@@ -806,8 +884,8 @@ #endif
 		    (level != 0));
 
 		/* init hw */
-		mpic_irq_write(i, MPIC_IRQ_VECTOR_PRI, vecpri);
-		mpic_irq_write(i, MPIC_IRQ_DESTINATION,
+		mpic_irq_write(i, mpic->hw_set->irq_vpr, vecpri);
+		mpic_irq_write(i, mpic->hw_set->irq_dest,
 			       1 << hard_smp_processor_id());
 
 		/* init linux descriptors */
@@ -818,15 +896,16 @@ #endif
 	}
 	
 	/* Init spurrious vector */
-	mpic_write(mpic->gregs, MPIC_GREG_SPURIOUS, MPIC_VEC_SPURRIOUS);
+	mpic_write(mpic->gregs, mpic->hw_set->greg_spurious, MPIC_VEC_SPURRIOUS);
 
-	/* Disable 8259 passthrough */
-	mpic_write(mpic->gregs, MPIC_GREG_GLOBAL_CONF_0,
-		   mpic_read(mpic->gregs, MPIC_GREG_GLOBAL_CONF_0)
-		   | MPIC_GREG_GCONF_8259_PTHROU_DIS);
+	/* Disable 8259 passthrough, if supported */
+	if (MPIC_GET_MOD_ID(mpic->flags) != MPIC_ID_TSI108)
+		mpic_write(mpic->gregs, mpic->hw_set->greg_config0,
+			   mpic_read(mpic->gregs, mpic->hw_set->greg_config0)
+			   | MPIC_GREG_GCONF_8259_PTHROU_DIS);
 
 	/* Set current processor priority to 0 */
-	mpic_cpu_write(MPIC_CPU_CURRENT_TASK_PRI, 0);
+	mpic_cpu_write(mpic->hw_set->cpu_task_pri, 0);
 }
 
 
@@ -845,9 +924,9 @@ void mpic_irq_set_priority(unsigned int 
 		mpic_ipi_write(irq - mpic->ipi_offset,
 			       reg | (pri << MPIC_VECPRI_PRIORITY_SHIFT));
 	} else {
-		reg = mpic_irq_read(irq - mpic->irq_offset,MPIC_IRQ_VECTOR_PRI)
+		reg = mpic_irq_read(irq - mpic->irq_offset,mpic->hw_set->irq_vpr)
 			& ~MPIC_VECPRI_PRIORITY_MASK;
-		mpic_irq_write(irq - mpic->irq_offset, MPIC_IRQ_VECTOR_PRI,
+		mpic_irq_write(irq - mpic->irq_offset, mpic->hw_set->irq_vpr,
 			       reg | (pri << MPIC_VECPRI_PRIORITY_SHIFT));
 	}
 	spin_unlock_irqrestore(&mpic_lock, flags);
@@ -864,7 +943,7 @@ unsigned int mpic_irq_get_priority(unsig
 	if (is_ipi)
 		reg = mpic_ipi_read(irq - mpic->ipi_offset);
 	else
-		reg = mpic_irq_read(irq - mpic->irq_offset, MPIC_IRQ_VECTOR_PRI);
+		reg = mpic_irq_read(irq - mpic->irq_offset, mpic->hw_set->irq_vpr);
 	spin_unlock_irqrestore(&mpic_lock, flags);
 	return (reg & MPIC_VECPRI_PRIORITY_MASK) >> MPIC_VECPRI_PRIORITY_SHIFT;
 }
@@ -890,12 +969,12 @@ #ifdef CONFIG_SMP
  	 */
 	if (distribute_irqs) {
 	 	for (i = 0; i < mpic->num_sources ; i++)
-			mpic_irq_write(i, MPIC_IRQ_DESTINATION,
-				mpic_irq_read(i, MPIC_IRQ_DESTINATION) | msk);
+			mpic_irq_write(i, mpic->hw_set->irq_dest,
+				mpic_irq_read(i, mpic->hw_set->irq_dest) | msk);
 	}
 
 	/* Set current processor priority to 0 */
-	mpic_cpu_write(MPIC_CPU_CURRENT_TASK_PRI, 0);
+	mpic_cpu_write(mpic->hw_set->cpu_task_pri, 0);
 
 	spin_unlock_irqrestore(&mpic_lock, flags);
 #endif /* CONFIG_SMP */
@@ -905,7 +984,7 @@ int mpic_cpu_get_priority(void)
 {
 	struct mpic *mpic = mpic_primary;
 
-	return mpic_cpu_read(MPIC_CPU_CURRENT_TASK_PRI);
+	return mpic_cpu_read(mpic->hw_set->cpu_task_pri);
 }
 
 void mpic_cpu_set_priority(int prio)
@@ -913,7 +992,7 @@ void mpic_cpu_set_priority(int prio)
 	struct mpic *mpic = mpic_primary;
 
 	prio &= MPIC_CPU_TASKPRI_MASK;
-	mpic_cpu_write(MPIC_CPU_CURRENT_TASK_PRI, prio);
+	mpic_cpu_write(mpic->hw_set->cpu_task_pri, prio);
 }
 
 /*
@@ -935,11 +1014,11 @@ void mpic_teardown_this_cpu(int secondar
 
 	/* let the mpic know we don't want intrs.  */
 	for (i = 0; i < mpic->num_sources ; i++)
-		mpic_irq_write(i, MPIC_IRQ_DESTINATION,
-			mpic_irq_read(i, MPIC_IRQ_DESTINATION) & ~msk);
+		mpic_irq_write(i, mpic->hw_set->irq_dest,
+			mpic_irq_read(i, mpic->hw_set->irq_dest) & ~msk);
 
 	/* Set current processor priority to max */
-	mpic_cpu_write(MPIC_CPU_CURRENT_TASK_PRI, 0xf);
+	mpic_cpu_write(mpic->hw_set->cpu_task_pri, 0xf);
 
 	spin_unlock_irqrestore(&mpic_lock, flags);
 }
@@ -955,7 +1034,8 @@ #ifdef DEBUG_IPI
 	DBG("%s: send_ipi(ipi_no: %d)\n", mpic->name, ipi_no);
 #endif
 
-	mpic_cpu_write(MPIC_CPU_IPI_DISPATCH_0 + ipi_no * 0x10,
+	mpic_cpu_write(mpic->hw_set->cpu_ipi_disp0 +
+		       ipi_no * mpic->hw_set->cpu_ipi_disp_stride,
 		       mpic_physmask(cpu_mask & cpus_addr(cpu_online_map)[0]));
 }
 
@@ -963,7 +1043,7 @@ int mpic_get_one_irq(struct mpic *mpic, 
 {
 	u32 irq;
 
-	irq = mpic_cpu_read(MPIC_CPU_INTACK) & MPIC_VECPRI_VECTOR_MASK;
+	irq = mpic_cpu_read(mpic->hw_set->cpu_intack) & mpic->hw_set->irq_vpr_vector;
 #ifdef DEBUG_LOW
 	DBG("%s: get_one_irq(): %d\n", mpic->name, irq);
 #endif
@@ -972,11 +1052,17 @@ #ifdef DEBUG_LOW
 		DBG("%s: cascading ...\n", mpic->name);
 #endif
 		irq = mpic->cascade(regs, mpic->cascade_data);
+#ifdef DEBUG_LOW
+		DBG("%s: cascaded irq: %d\n", mpic->name, irq);
+#endif
 		mpic_eoi(mpic);
 		return irq;
 	}
-	if (unlikely(irq == MPIC_VEC_SPURRIOUS))
+	if (unlikely(irq == MPIC_VEC_SPURRIOUS)) {
+		if (mpic->flags & MPIC_SPV_EOI)
+			mpic_eoi(mpic);
 		return -1;
+	}
 	if (irq < MPIC_VEC_IPI_0) {
 #ifdef DEBUG_IRQ
 		DBG("%s: irq %d\n", mpic->name, irq + mpic->irq_offset);
diff --git a/include/asm-powerpc/mpic.h b/include/asm-powerpc/mpic.h
index 6b9e781..72131a4 100644
--- a/include/asm-powerpc/mpic.h
+++ b/include/asm-powerpc/mpic.h
@@ -37,6 +37,7 @@ #define MPIC_GREG_IPI_VECTOR_PRI_0	0x000
 #define MPIC_GREG_IPI_VECTOR_PRI_1	0x000b0
 #define MPIC_GREG_IPI_VECTOR_PRI_2	0x000c0
 #define MPIC_GREG_IPI_VECTOR_PRI_3	0x000d0
+#define MPIC_GREG_IPI_STRIDE		0x10
 #define MPIC_GREG_SPURIOUS		0x000e0
 #define MPIC_GREG_TIMER_FREQ		0x000f0
 
@@ -64,6 +65,7 @@ #define MPIC_CPU_IPI_DISPATCH_0		0x00040
 #define MPIC_CPU_IPI_DISPATCH_1		0x00050
 #define MPIC_CPU_IPI_DISPATCH_2		0x00060
 #define MPIC_CPU_IPI_DISPATCH_3		0x00070
+#define MPIC_CPU_IPI_DISPATCH_STRIDE	0x00010
 #define MPIC_CPU_CURRENT_TASK_PRI	0x00080
 #define 	MPIC_CPU_TASKPRI_MASK			0x0000000f
 #define MPIC_CPU_WHOAMI			0x00090
@@ -91,6 +93,55 @@ #define 	MPIC_VECPRI_SENSE_EDGE			0x0000
 #define 	MPIC_VECPRI_SENSE_MASK			0x00400000
 #define MPIC_IRQ_DESTINATION		0x00010
 
+/******************************************************************************
+ * Tsi108 implementation of MPIC has many differences form the original one
+ */
+
+/*
+ * Global registers
+ */
+
+#define TSI108_GREG_BASE		0x00000
+#define TSI108_GREG_FEATURE_0		0x00000
+#define TSI108_GREG_GLOBAL_CONF_0	0x00004
+#define TSI108_GREG_VENDOR_ID		0x0000c
+#define TSI108_GREG_IPI_VECTOR_PRI_0	0x00204		/* Doorbell 0 */
+#define TSI108_GREG_IPI_STRIDE		0x0c
+#define TSI108_GREG_SPURIOUS		0x00010
+#define TSI108_GREG_TIMER_FREQ		0x00014
+
+/*
+ * Timer registers
+ */
+#define TSI108_TIMER_BASE		0x0030
+#define TSI108_TIMER_STRIDE		0x10
+#define TSI108_TIMER_CURRENT_CNT	0x00000
+#define TSI108_TIMER_BASE_CNT		0x00004
+#define TSI108_TIMER_VECTOR_PRI		0x00008
+#define TSI108_TIMER_DESTINATION	0x0000c
+
+/*
+ * Per-Processor registers
+ */
+#define TSI108_CPU_BASE			0x00300
+#define TSI108_CPU_STRIDE		0x00040
+#define TSI108_CPU_IPI_DISPATCH_0	0x00200
+#define TSI108_CPU_IPI_DISPATCH_STRIDE	0x00000
+#define TSI108_CPU_CURRENT_TASK_PRI	0x00000
+#define TSI108_CPU_INTACK		0x00004
+#define TSI108_CPU_EOI			0x00008
+
+/*
+ * Per-source registers
+ */
+#define TSI108_IRQ_REG_BASE		0x00100
+#define TSI108_IRQ_STRIDE		0x00008
+#define TSI108_IRQ_VECTOR_PRI		0x00000
+#define 	TSI108_VECPRI_VECTOR_MASK		0x000000ff
+#define 	TSI108_VECPRI_POLARITY_POSITIVE		0x01000000
+#define 	TSI108_VECPRI_SENSE_LEVEL		0x02000000
+#define TSI108_IRQ_DESTINATION		0x00004
+
 #define MPIC_MAX_IRQ_SOURCES	2048
 #define MPIC_MAX_CPUS		32
 #define MPIC_MAX_ISU		32
@@ -124,6 +175,40 @@ struct mpic_irq_fixup
 };
 #endif /* CONFIG_MPIC_BROKEN_U3 */
 
+struct mpic_info {
+	u32	greg_base;	/* offset of global registers from MPIC base */
+	u32	greg_frr0;	/* FRR0 offset from base */
+	u32	greg_config0;	/* Global Config register offset from base */
+	u32	greg_vendor_id;	/* VID register offset from base */
+	u32	greg_ipi_vp0;	/* IPI Vector/Priority Registers */
+	u32	greg_ipi_stride; /* IPI Vector/Priority Registers spacing */
+	u32	greg_spurious;	/* Spurious Vector Register */
+	u32	greg_tfrr;	/* Global Timer Frequency Reporting Register */
+
+	u32	timer_base;	/* Global Timer Registers base */
+	u32	timer_stride;	/* Global Timer Registers spacing */
+	u32	timer_ccr;	/* Global Timer Current Count Register */
+	u32	timer_bcr;	/* Global Timer Base Count Register */
+	u32	timer_vpr;	/* Global Timer Vector/Priority Register */
+	u32	timer_dest;	/* Global Timer Destination Register */
+
+	u32	cpu_base;	/* Global Timer Destination Register */
+	u32	cpu_stride;	/* Global Timer Destination Register */
+	u32	cpu_ipi_disp0;	/* IPI 0 Dispatch Command Register */
+	u32	cpu_ipi_disp_stride;	/* IPI Dispatch spacing */
+	u32	cpu_task_pri;	/* Processor Current Task Priority Register */
+	u32	cpu_whoami;	/* Who Am I Register */
+	u32	cpu_intack;	/* Interrupt Acknowledge Register */
+	u32	cpu_eoi;	/* End of Interrupt Register */
+
+	u32	irq_base;	/* Interrupt registers base */
+	u32	irq_stride;	/* Interrupt registers spacing */
+	u32	irq_vpr;	/* Interrupt Vector/Priority Register */
+	u32	irq_vpr_vector;	/* Interrupt Vector Mask */
+	u32	irq_vpr_polpos;	/* Interrupt Positive Polarity bit */
+	u32	irq_vpr_senlvl;	/* Interrupt Level Sense bit */
+	u32	irq_dest;	/* Interrupt Destination Register */
+};
 
 /* The instance data of a given MPIC */
 struct mpic
@@ -168,6 +253,8 @@ #endif
 	volatile u32 __iomem	*tmregs;
 	volatile u32 __iomem	*cpuregs[MPIC_MAX_CPUS];
 	volatile u32 __iomem	*isus[MPIC_MAX_ISU];
+	/* Pointer to HW info structure */
+	struct mpic_info	*hw_set;
 
 	/* link */
 	struct mpic		*next;
@@ -186,6 +273,14 @@ #define MPIC_BROKEN_U3			0x00000004
 #define MPIC_BROKEN_IPI			0x00000008
 /* MPIC wants a reset */
 #define MPIC_WANTS_RESET		0x00000010
+/* Spurious vector requires EOI */
+#define MPIC_SPV_EOI			0x00000020
+/* MPIC HW modification ID */
+#define MPIC_MOD_ID_MASK		0x00000f00
+#define MPIC_MOD_ID(val)		(((val) << 8) & MPIC_MOD_ID_MASK)
+#define MPIC_GET_MOD_ID(flags)		(((flags) & MPIC_MOD_ID_MASK) >> 8)
+#define		MPIC_ID_MPIC		0	/* Original MPIC */
+#define		MPIC_ID_TSI108		1	/* Tsi108/109 PIC */
 
 /* Allocate the controller structure and setup the linux irq descs
  * for the range if interrupts passed in. No HW initialization is
diff --git a/include/asm-powerpc/tsi108_irq.h b/include/asm-powerpc/tsi108_irq.h
new file mode 100644
index 0000000..4d725ed
--- /dev/null
+++ b/include/asm-powerpc/tsi108_irq.h
@@ -0,0 +1,124 @@
+/*
+ * (C) Copyright 2005 Tundra Semiconductor Corp.
+ * Alex Bounine, <alexandreb@tundra.com).
+ *
+ * See file CREDITS for list of people who contributed to this
+ * project.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
+ */
+
+/*
+ * asm-ppc/tsi108_irq.h - definitions for interrupt controller
+ * initialization and external interrupt demultiplexing on TSI108EMU/SVB boards.
+ */
+
+#ifndef _ASM_PPC_TSI108_IRQ_H
+#define _ASM_PPC_TSI108_IRQ_H
+
+/*
+ * Tsi108 interrupts
+ */
+#ifndef TSI108_IRQ_BASE
+#define TSI108_IRQ_BASE		0
+#endif
+
+#define TSI108_IRQ(x)		(TSI108_IRQ_BASE + (x))
+
+#define TSI108_MAX_VECTORS	(36 + 4)	/* 36 sources + PCI INT demux */
+#define MAX_TASK_PRIO	0xF
+
+#define TSI108_IRQ_SPURIOUS	(TSI108_MAX_VECTORS)
+
+#define DEFAULT_PRIO_LVL	10	/* initial priority level */
+
+/* Interrupt vectors assignment to external and internal 
+ * sources of requests. */
+
+/* EXTERNAL INTERRUPT SOURCES */
+
+#define IRQ_TSI108_EXT_INT0	TSI108_IRQ(0)	/* External Source at INT[0] */
+#define IRQ_TSI108_EXT_INT1	TSI108_IRQ(1)	/* External Source at INT[1] */
+#define IRQ_TSI108_EXT_INT2	TSI108_IRQ(2)	/* External Source at INT[2] */
+#define IRQ_TSI108_EXT_INT3	TSI108_IRQ(3)	/* External Source at INT[3] */
+
+/* INTERNAL INTERRUPT SOURCES */
+
+#define IRQ_TSI108_RESERVED0	TSI108_IRQ(4)	/* Reserved IRQ */
+#define IRQ_TSI108_RESERVED1	TSI108_IRQ(5)	/* Reserved IRQ */
+#define IRQ_TSI108_RESERVED2	TSI108_IRQ(6)	/* Reserved IRQ */
+#define IRQ_TSI108_RESERVED3	TSI108_IRQ(7)	/* Reserved IRQ */
+#define IRQ_TSI108_DMA0		TSI108_IRQ(8)	/* DMA0 */
+#define IRQ_TSI108_DMA1		TSI108_IRQ(9)	/* DMA1 */
+#define IRQ_TSI108_DMA2		TSI108_IRQ(10)	/* DMA2 */
+#define IRQ_TSI108_DMA3		TSI108_IRQ(11)	/* DMA3 */
+#define IRQ_TSI108_UART0	TSI108_IRQ(12)	/* UART0 */
+#define IRQ_TSI108_UART1	TSI108_IRQ(13)	/* UART1 */
+#define IRQ_TSI108_I2C		TSI108_IRQ(14)	/* I2C */
+#define IRQ_TSI108_GPIO		TSI108_IRQ(15)	/* GPIO */
+#define IRQ_TSI108_GIGE0	TSI108_IRQ(16)	/* GIGE0 */
+#define IRQ_TSI108_GIGE1	TSI108_IRQ(17)	/* GIGE1 */
+#define IRQ_TSI108_RESERVED4	TSI108_IRQ(18)	/* Reserved IRQ */
+#define IRQ_TSI108_HLP		TSI108_IRQ(19)	/* HLP */
+#define IRQ_TSI108_SDRAM	TSI108_IRQ(20)	/* SDC */
+#define IRQ_TSI108_PROC_IF	TSI108_IRQ(21)	/* Processor IF */
+#define IRQ_TSI108_RESERVED5	TSI108_IRQ(22)	/* Reserved IRQ */
+#define IRQ_TSI108_PCI		TSI108_IRQ(23)	/* PCI/X block */
+
+#define IRQ_TSI108_MBOX0	TSI108_IRQ(24)	/* Mailbox 0 register */
+#define IRQ_TSI108_MBOX1	TSI108_IRQ(25)	/* Mailbox 1 register */
+#define IRQ_TSI108_MBOX2	TSI108_IRQ(26)	/* Mailbox 2 register */
+#define IRQ_TSI108_MBOX3	TSI108_IRQ(27)	/* Mailbox 3 register */
+
+#define IRQ_TSI108_DBELL0	TSI108_IRQ(28)	/* Doorbell 0 */
+#define IRQ_TSI108_DBELL1	TSI108_IRQ(29)	/* Doorbell 1 */
+#define IRQ_TSI108_DBELL2	TSI108_IRQ(30)	/* Doorbell 2 */
+#define IRQ_TSI108_DBELL3	TSI108_IRQ(31)	/* Doorbell 3 */
+
+#define IRQ_TSI108_TIMER0	TSI108_IRQ(32)	/* Global Timer 0 */
+#define IRQ_TSI108_TIMER1	TSI108_IRQ(33)	/* Global Timer 1 */
+#define IRQ_TSI108_TIMER2	TSI108_IRQ(34)	/* Global Timer 2 */
+#define IRQ_TSI108_TIMER3	TSI108_IRQ(35)	/* Global Timer 3 */
+
+/*
+ * PCI bus INTA# - INTD# lines demultiplexor
+ */
+#define IRQ_PCI_INTAD_BASE	TSI108_IRQ(36)
+#define IRQ_PCI_INTA		(IRQ_PCI_INTAD_BASE + 0)
+#define IRQ_PCI_INTB		(IRQ_PCI_INTAD_BASE + 1)
+#define IRQ_PCI_INTC		(IRQ_PCI_INTAD_BASE + 2)
+#define IRQ_PCI_INTD		(IRQ_PCI_INTAD_BASE + 3)
+#define NUM_PCI_IRQS		(4)
+
+/* number of entries in vector dispatch table */
+#define IRQ_TSI108_TAB_SIZE	(TSI108_MAX_VECTORS + 1)
+
+/* Mapping of MPIC outputs to processors' interrupt pins */
+
+#define IDIR_INT_OUT0		0x1
+#define IDIR_INT_OUT1		0x2
+#define IDIR_INT_OUT2		0x4
+#define IDIR_INT_OUT3		0x8
+
+/*---------------------------------------------------------------
+ * IRQ line configuration parameters */
+
+/* Interrupt delivery modes */
+typedef enum {
+	TSI108_IRQ_DIRECTED,
+	TSI108_IRQ_DISTRIBUTED,
+} TSI108_IRQ_MODE;
+#endif				/*  _ASM_PPC_TSI108_IRQ_H */

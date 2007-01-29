Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id EA376DE020
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 16:26:55 +1100 (EST)
Date: Sun, 28 Jan 2007 23:33:18 -0600
To: paulus@samba.org
Subject: [PATCH] [v2] powerpc: MPIC: support more than 256 sources
Message-ID: <20070129053318.GA7561@lixom.net>
References: <20070125213834.GA22121@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070125213834.GA22121@lixom.net>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Allow more than the default 256 MPIC sources. Allocates a new flag
(MPIC_LARGE_VECTORS) to be used by platform code when instantiating
the mpic.

I picked 11 bits worth right now since it would cover the number of
sources on any hardware I have seen. It can always be increased later
if needed.


Signed-off-by: Olof Johansson <olof@lixom.net>

Index: merge/arch/powerpc/sysdev/mpic.c
===================================================================
--- merge.orig/arch/powerpc/sysdev/mpic.c
+++ merge/arch/powerpc/sysdev/mpic.c
@@ -496,13 +496,18 @@ static void __init mpic_scan_ht_pics(str
 static struct mpic *mpic_find(unsigned int irq, unsigned int *is_ipi)
 {
 	unsigned int src = mpic_irq_to_hw(irq);
+	struct mpic *mpic;
 
 	if (irq < NUM_ISA_INTERRUPTS)
 		return NULL;
+
+	mpic = irq_desc[irq].chip_data;
+
 	if (is_ipi)
-		*is_ipi = (src >= MPIC_VEC_IPI_0 && src <= MPIC_VEC_IPI_3);
+		*is_ipi = (src >= mpic->ipi_vecs[0] &&
+			   src <= mpic->ipi_vecs[3]);
 
-	return irq_desc[irq].chip_data;
+	return mpic;
 }
 
 /* Convert a cpu mask from logical to physical cpu numbers. */
@@ -540,7 +545,11 @@ static inline void mpic_eoi(struct mpic 
 #ifdef CONFIG_SMP
 static irqreturn_t mpic_ipi_action(int irq, void *dev_id)
 {
-	smp_message_recv(mpic_irq_to_hw(irq) - MPIC_VEC_IPI_0);
+	struct mpic *mpic;
+
+	mpic = mpic_find(irq, NULL);
+	smp_message_recv(mpic_irq_to_hw(irq) - mpic->ipi_vecs[0]);
+
 	return IRQ_HANDLED;
 }
 #endif /* CONFIG_SMP */
@@ -663,7 +672,7 @@ static void mpic_end_ht_irq(unsigned int
 static void mpic_unmask_ipi(unsigned int irq)
 {
 	struct mpic *mpic = mpic_from_ipi(irq);
-	unsigned int src = mpic_irq_to_hw(irq) - MPIC_VEC_IPI_0;
+	unsigned int src = mpic_irq_to_hw(irq) - mpic->ipi_vecs[0];
 
 	DBG("%s: enable_ipi: %d (ipi %d)\n", mpic->name, irq, src);
 	mpic_ipi_write(src, mpic_ipi_read(src) & ~MPIC_VECPRI_MASK);
@@ -807,11 +816,11 @@ static int mpic_host_map(struct irq_host
 
 	DBG("mpic: map virq %d, hwirq 0x%lx\n", virq, hw);
 
-	if (hw == MPIC_VEC_SPURRIOUS)
+	if (hw == mpic->spurious_vec)
 		return -EINVAL;
 
 #ifdef CONFIG_SMP
-	else if (hw >= MPIC_VEC_IPI_0) {
+	else if (hw >= mpic->ipi_vecs[0]) {
 		WARN_ON(!(mpic->flags & MPIC_PRIMARY));
 
 		DBG("mpic: mapping as IPI\n");
@@ -904,6 +913,7 @@ struct mpic * __init mpic_alloc(struct d
 	u32		reg;
 	const char	*vers;
 	int		i;
+	int		intvec_top;
 	u64		paddr = phys_addr;
 
 	mpic = alloc_bootmem(sizeof(struct mpic));
@@ -914,9 +924,9 @@ struct mpic * __init mpic_alloc(struct d
 	mpic->name = name;
 	mpic->of_node = node ? of_node_get(node) : NULL;
 
-	mpic->irqhost = irq_alloc_host(IRQ_HOST_MAP_LINEAR, 256,
+	mpic->irqhost = irq_alloc_host(IRQ_HOST_MAP_LINEAR, isu_size,
 				       &mpic_host_ops,
-				       MPIC_VEC_SPURRIOUS);
+				       flags & MPIC_LARGE_VECTORS ? 2048 : 256);
 	if (mpic->irqhost == NULL) {
 		of_node_put(node);
 		return NULL;
@@ -944,6 +954,21 @@ struct mpic * __init mpic_alloc(struct d
 	mpic->irq_count = irq_count;
 	mpic->num_sources = 0; /* so far */
 
+	if (flags & MPIC_LARGE_VECTORS)
+		intvec_top = 2047;
+	else
+		intvec_top = 255;
+
+	mpic->timer_vecs[0] = intvec_top - 8;
+	mpic->timer_vecs[1] = intvec_top - 7;
+	mpic->timer_vecs[2] = intvec_top - 6;
+	mpic->timer_vecs[3] = intvec_top - 5;
+	mpic->ipi_vecs[0]   = intvec_top - 4;
+	mpic->ipi_vecs[1]   = intvec_top - 3;
+	mpic->ipi_vecs[2]   = intvec_top - 2;
+	mpic->ipi_vecs[3]   = intvec_top - 1;
+	mpic->spurious_vec  = intvec_top;
+
 	/* Check for "big-endian" in device-tree */
 	if (node && get_property(node, "big-endian", NULL) != NULL)
 		mpic->flags |= MPIC_BIG_ENDIAN;
@@ -1084,11 +1109,6 @@ void __init mpic_init(struct mpic *mpic)
 	int i;
 
 	BUG_ON(mpic->num_sources == 0);
-	WARN_ON(mpic->num_sources > MPIC_VEC_IPI_0);
-
-	/* Sanitize source count */
-	if (mpic->num_sources > MPIC_VEC_IPI_0)
-		mpic->num_sources = MPIC_VEC_IPI_0;
 
 	printk(KERN_INFO "mpic: Initializing for %d sources\n", mpic->num_sources);
 
@@ -1104,7 +1124,7 @@ void __init mpic_init(struct mpic *mpic)
 			   i * MPIC_INFO(TIMER_STRIDE) +
 			   MPIC_INFO(TIMER_VECTOR_PRI),
 			   MPIC_VECPRI_MASK |
-			   (MPIC_VEC_TIMER_0 + i));
+			   (mpic->timer_vecs[0] + i));
 	}
 
 	/* Initialize IPIs to our reserved vectors and mark them disabled for now */
@@ -1113,7 +1133,7 @@ void __init mpic_init(struct mpic *mpic)
 		mpic_ipi_write(i,
 			       MPIC_VECPRI_MASK |
 			       (10 << MPIC_VECPRI_PRIORITY_SHIFT) |
-			       (MPIC_VEC_IPI_0 + i));
+			       (mpic->ipi_vecs[0] + i));
 	}
 
 	/* Initialize interrupt sources */
@@ -1136,8 +1156,8 @@ void __init mpic_init(struct mpic *mpic)
 			       1 << hard_smp_processor_id());
 	}
 	
-	/* Init spurrious vector */
-	mpic_write(mpic->gregs, MPIC_INFO(GREG_SPURIOUS), MPIC_VEC_SPURRIOUS);
+	/* Init spurious vector */
+	mpic_write(mpic->gregs, MPIC_INFO(GREG_SPURIOUS), mpic->spurious_vec);
 
 	/* Disable 8259 passthrough, if supported */
 	if (!(mpic->flags & MPIC_NO_PTHROU_DIS))
@@ -1184,9 +1204,9 @@ void mpic_irq_set_priority(unsigned int 
 
 	spin_lock_irqsave(&mpic_lock, flags);
 	if (is_ipi) {
-		reg = mpic_ipi_read(src - MPIC_VEC_IPI_0) &
+		reg = mpic_ipi_read(src - mpic->ipi_vecs[0]) &
 			~MPIC_VECPRI_PRIORITY_MASK;
-		mpic_ipi_write(src - MPIC_VEC_IPI_0,
+		mpic_ipi_write(src - mpic->ipi_vecs[0],
 			       reg | (pri << MPIC_VECPRI_PRIORITY_SHIFT));
 	} else {
 		reg = mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI))
@@ -1207,7 +1227,7 @@ unsigned int mpic_irq_get_priority(unsig
 
 	spin_lock_irqsave(&mpic_lock, flags);
 	if (is_ipi)
-		reg = mpic_ipi_read(src = MPIC_VEC_IPI_0);
+		reg = mpic_ipi_read(src = mpic->ipi_vecs[0]);
 	else
 		reg = mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI));
 	spin_unlock_irqrestore(&mpic_lock, flags);
@@ -1313,7 +1333,7 @@ unsigned int mpic_get_one_irq(struct mpi
 #ifdef DEBUG_LOW
 	DBG("%s: get_one_irq(): %d\n", mpic->name, src);
 #endif
-	if (unlikely(src == MPIC_VEC_SPURRIOUS))
+	if (unlikely(src == mpic->spurious_vec))
 		return NO_IRQ;
 	return irq_linear_revmap(mpic->irqhost, src);
 }
@@ -1345,7 +1365,7 @@ void mpic_request_ipis(void)
 
 	for (i = 0; i < 4; i++) {
 		unsigned int vipi = irq_create_mapping(mpic->irqhost,
-						       MPIC_VEC_IPI_0 + i);
+						       mpic->ipi_vecs[0] + i);
 		if (vipi == NO_IRQ) {
 			printk(KERN_ERR "Failed to map IPI %d\n", i);
 			break;
Index: merge/include/asm-powerpc/mpic.h
===================================================================
--- merge.orig/include/asm-powerpc/mpic.h
+++ merge/include/asm-powerpc/mpic.h
@@ -103,21 +103,6 @@
 #define MPIC_MAX_ISU		32
 
 /*
- * Special vector numbers (internal use only)
- */
-#define MPIC_VEC_SPURRIOUS	255
-#define MPIC_VEC_IPI_3		254
-#define MPIC_VEC_IPI_2		253
-#define MPIC_VEC_IPI_1		252
-#define MPIC_VEC_IPI_0		251
-
-/* unused */
-#define MPIC_VEC_TIMER_3	250
-#define MPIC_VEC_TIMER_2	249
-#define MPIC_VEC_TIMER_1	248
-#define MPIC_VEC_TIMER_0	247
-
-/*
  * Tsi108 implementation of MPIC has many differences from the original one
  */
 
@@ -276,6 +261,13 @@ struct mpic
 	unsigned char		*senses;
 	unsigned int		senses_count;
 
+	/* vector numbers used for internal sources (ipi/timers) */
+	unsigned int		ipi_vecs[4];
+	unsigned int		timer_vecs[4];
+
+	/* Spurious vector to program into unused sources */
+	unsigned int		spurious_vec;
+
 #ifdef CONFIG_MPIC_BROKEN_U3
 	/* The fixup table */
 	struct mpic_irq_fixup	*fixups;
@@ -332,6 +324,8 @@ struct mpic
 #define MPIC_NO_PTHROU_DIS		0x00000040
 /* DCR based MPIC */
 #define MPIC_USES_DCR			0x00000080
+/* MPIC has 11-bit vector fields (or larger) */
+#define MPIC_LARGE_VECTORS		0x00000100
 
 /* MPIC HW modification ID */
 #define MPIC_REGSET_MASK		0xf0000000
Index: merge/arch/powerpc/platforms/pasemi/setup.c
===================================================================
--- merge.orig/arch/powerpc/platforms/pasemi/setup.c
+++ merge/arch/powerpc/platforms/pasemi/setup.c
@@ -130,8 +130,9 @@ static __init void pas_init_IRQ(void)
 	openpic_addr = of_read_number(opprop, naddr);
 	printk(KERN_DEBUG "OpenPIC addr: %lx\n", openpic_addr);
 
-	mpic = mpic_alloc(mpic_node, openpic_addr, MPIC_PRIMARY, 0, 0,
-			  " PAS-OPIC  ");
+	mpic = mpic_alloc(mpic_node, openpic_addr,
+			  MPIC_PRIMARY|MPIC_LARGE_VECTORS,
+			  0, 0, " PAS-OPIC  ");
 	BUG_ON(!mpic);
 
 	mpic_assign_isu(mpic, 0, openpic_addr + 0x10000);

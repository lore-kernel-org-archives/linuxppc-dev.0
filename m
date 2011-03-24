Return-Path: <B07421@freescale.com>
Date: Thu, 24 Mar 2011 16:43:55 -0500
From: Scott Wood <scottwood@freescale.com>
To: <galak@kernel.crashing.org>
Subject: [PATCH 4/4] powerpc/mpic: add the mpic global timer support
Message-ID: <20110324214355.GC9524@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20110324214315.GA9502@schlenkerla.am.freescale.net>
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add support for MPIC timers as requestable interrupt sources.

Based on http://patchwork.ozlabs.org/patch/20941/ by Dave Liu.

Signed-off-by: Dave Liu <daveliu@freescale.com>
Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/include/asm/mpic.h |    3 +-
 arch/powerpc/sysdev/mpic.c      |   92 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 88 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/mpic.h b/arch/powerpc/include/asm/mpic.h
index 25a0cb3..664bee6 100644
--- a/arch/powerpc/include/asm/mpic.h
+++ b/arch/powerpc/include/asm/mpic.h
@@ -263,6 +263,7 @@ struct mpic
 #ifdef CONFIG_SMP
 	struct irq_chip		hc_ipi;
 #endif
+	struct irq_chip		hc_tm;
 	const char		*name;
 	/* Flags */
 	unsigned int		flags;
@@ -281,7 +282,7 @@ struct mpic
 
 	/* vector numbers used for internal sources (ipi/timers) */
 	unsigned int		ipi_vecs[4];
-	unsigned int		timer_vecs[4];
+	unsigned int		timer_vecs[8];
 
 	/* Spurious vector to program into unused sources */
 	unsigned int		spurious_vec;
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 69f96ec..c173e67 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -219,6 +219,28 @@ static inline void _mpic_ipi_write(struct mpic *mpic, unsigned int ipi, u32 valu
 	_mpic_write(mpic->reg_type, &mpic->gregs, offset, value);
 }
 
+static inline u32 _mpic_tm_read(struct mpic *mpic, unsigned int tm)
+{
+	unsigned int offset = MPIC_INFO(TIMER_VECTOR_PRI) +
+			      ((tm & 3) * MPIC_INFO(TIMER_STRIDE));
+
+	if (tm >= 4)
+		offset += 0x1000 / 4;
+
+	return _mpic_read(mpic->reg_type, &mpic->tmregs, offset);
+}
+
+static inline void _mpic_tm_write(struct mpic *mpic, unsigned int tm, u32 value)
+{
+	unsigned int offset = MPIC_INFO(TIMER_VECTOR_PRI) +
+			      ((tm & 3) * MPIC_INFO(TIMER_STRIDE));
+
+	if (tm >= 4)
+		offset += 0x1000 / 4;
+
+	_mpic_write(mpic->reg_type, &mpic->tmregs, offset, value);
+}
+
 static inline u32 _mpic_cpu_read(struct mpic *mpic, unsigned int reg)
 {
 	unsigned int cpu = mpic_processor_id(mpic);
@@ -269,6 +291,8 @@ static inline void _mpic_irq_write(struct mpic *mpic, unsigned int src_no,
 #define mpic_write(b,r,v)	_mpic_write(mpic->reg_type,&(b),(r),(v))
 #define mpic_ipi_read(i)	_mpic_ipi_read(mpic,(i))
 #define mpic_ipi_write(i,v)	_mpic_ipi_write(mpic,(i),(v))
+#define mpic_tm_read(i)		_mpic_tm_read(mpic,(i))
+#define mpic_tm_write(i,v)	_mpic_tm_write(mpic,(i),(v))
 #define mpic_cpu_read(i)	_mpic_cpu_read(mpic,(i))
 #define mpic_cpu_write(i,v)	_mpic_cpu_write(mpic,(i),(v))
 #define mpic_irq_read(s,r)	_mpic_irq_read(mpic,(s),(r))
@@ -628,6 +652,13 @@ static unsigned int mpic_is_ipi(struct mpic *mpic, unsigned int irq)
 	return (src >= mpic->ipi_vecs[0] && src <= mpic->ipi_vecs[3]);
 }
 
+/* Determine if the linux irq is a timer */
+static unsigned int mpic_is_tm(struct mpic *mpic, unsigned int irq)
+{
+	unsigned int src = mpic_irq_to_hw(irq);
+
+	return (src >= mpic->timer_vecs[0] && src <= mpic->timer_vecs[7]);
+}
 
 /* Convert a cpu mask from logical to physical cpu numbers. */
 static inline u32 mpic_physmask(u32 cpumask)
@@ -814,6 +845,25 @@ static void mpic_end_ipi(struct irq_data *d)
 
 #endif /* CONFIG_SMP */
 
+static void mpic_unmask_tm(struct irq_data *d)
+{
+	struct mpic *mpic = mpic_from_irq_data(d);
+	unsigned int src = mpic_irq_to_hw(d->irq) - mpic->timer_vecs[0];
+
+	DBG("%s: enable_tm: %d (tm %d)\n", mpic->name, irq, src);
+	mpic_tm_write(src, mpic_tm_read(src) & ~MPIC_VECPRI_MASK);
+	mpic_tm_read(src);
+}
+
+static void mpic_mask_tm(struct irq_data *d)
+{
+	struct mpic *mpic = mpic_from_irq_data(d);
+	unsigned int src = mpic_irq_to_hw(d->irq) - mpic->timer_vecs[0];
+
+	mpic_tm_write(src, mpic_tm_read(src) | MPIC_VECPRI_MASK);
+	mpic_tm_read(src);
+}
+
 int mpic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
 		      bool force)
 {
@@ -948,6 +998,12 @@ static struct irq_chip mpic_ipi_chip = {
 };
 #endif /* CONFIG_SMP */
 
+static struct irq_chip mpic_tm_chip = {
+	.irq_mask	= mpic_mask_tm,
+	.irq_unmask	= mpic_unmask_tm,
+	.irq_eoi	= mpic_end_irq,
+};
+
 #ifdef CONFIG_MPIC_U3_HT_IRQS
 static struct irq_chip mpic_irq_ht_chip = {
 	.irq_startup	= mpic_startup_ht_irq,
@@ -991,6 +1047,16 @@ static int mpic_host_map(struct irq_host *h, unsigned int virq,
 	}
 #endif /* CONFIG_SMP */
 
+	if (hw >= mpic->timer_vecs[0] && hw <= mpic->timer_vecs[7]) {
+		WARN_ON(!(mpic->flags & MPIC_PRIMARY));
+
+		DBG("mpic: mapping as timer\n");
+		set_irq_chip_data(virq, mpic);
+		set_irq_chip_and_handler(virq, &mpic->hc_tm,
+					 handle_fasteoi_irq);
+		return 0;
+	}
+
 	if (hw >= mpic->irq_count)
 		return -EINVAL;
 
@@ -1147,6 +1213,9 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	mpic->hc_ipi.name = name;
 #endif /* CONFIG_SMP */
 
+	mpic->hc_tm = mpic_tm_chip;
+	mpic->hc_tm.name = name;
+
 	mpic->flags = flags;
 	mpic->isu_size = isu_size;
 	mpic->irq_count = irq_count;
@@ -1157,10 +1226,14 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	else
 		intvec_top = 255;
 
-	mpic->timer_vecs[0] = intvec_top - 8;
-	mpic->timer_vecs[1] = intvec_top - 7;
-	mpic->timer_vecs[2] = intvec_top - 6;
-	mpic->timer_vecs[3] = intvec_top - 5;
+	mpic->timer_vecs[0] = intvec_top - 12;
+	mpic->timer_vecs[1] = intvec_top - 11;
+	mpic->timer_vecs[2] = intvec_top - 10;
+	mpic->timer_vecs[3] = intvec_top - 9;
+	mpic->timer_vecs[4] = intvec_top - 8;
+	mpic->timer_vecs[5] = intvec_top - 7;
+	mpic->timer_vecs[6] = intvec_top - 6;
+	mpic->timer_vecs[7] = intvec_top - 5;
 	mpic->ipi_vecs[0]   = intvec_top - 4;
 	mpic->ipi_vecs[1]   = intvec_top - 3;
 	mpic->ipi_vecs[2]   = intvec_top - 2;
@@ -1363,15 +1436,17 @@ void __init mpic_init(struct mpic *mpic)
 	/* Set current processor priority to max */
 	mpic_cpu_write(MPIC_INFO(CPU_CURRENT_TASK_PRI), 0xf);
 
-	/* Initialize timers: just disable them all */
+	/* Initialize timers to our reserved vectors and mask them for now */
 	for (i = 0; i < 4; i++) {
 		mpic_write(mpic->tmregs,
 			   i * MPIC_INFO(TIMER_STRIDE) +
-			   MPIC_INFO(TIMER_DESTINATION), 0);
+			   MPIC_INFO(TIMER_DESTINATION),
+			   1 << hard_smp_processor_id());
 		mpic_write(mpic->tmregs,
 			   i * MPIC_INFO(TIMER_STRIDE) +
 			   MPIC_INFO(TIMER_VECTOR_PRI),
 			   MPIC_VECPRI_MASK |
+			   (9 << MPIC_VECPRI_PRIORITY_SHIFT) |
 			   (mpic->timer_vecs[0] + i));
 	}
 
@@ -1480,6 +1555,11 @@ void mpic_irq_set_priority(unsigned int irq, unsigned int pri)
 			~MPIC_VECPRI_PRIORITY_MASK;
 		mpic_ipi_write(src - mpic->ipi_vecs[0],
 			       reg | (pri << MPIC_VECPRI_PRIORITY_SHIFT));
+	} else if (mpic_is_tm(mpic, irq)) {
+		reg = mpic_tm_read(src - mpic->timer_vecs[0]) &
+			~MPIC_VECPRI_PRIORITY_MASK;
+		mpic_tm_write(src - mpic->timer_vecs[0],
+			      reg | (pri << MPIC_VECPRI_PRIORITY_SHIFT));
 	} else {
 		reg = mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI))
 			& ~MPIC_VECPRI_PRIORITY_MASK;
-- 
1.7.1

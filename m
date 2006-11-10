Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 10 Nov 2006 18:44:53 +1100
Subject: [PATCH 11/32] powerpc: Support for DCR based MPIC
In-Reply-To: <1163144683.554182.685908332811.qpush@grosgo>
Message-Id: <20061110074457.3B14667DD7@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch implements support for DCR based MPIC implementations. Such
implementations have the MPIC_USES_DCR flag set and don't use the phys_addr
argument of mpic_alloc (they require a valid dcr mapping in the device node)

This version of the patch can use a little bif of cleanup still (I can
probably consolidate rb->dbase/doff, at least once I'm sure on how the
hardware is actually supposed to work vs. possible simulator issues) and
it should be possible to build a DCR-only version of the driver. I need
to cleanup a bit the CONFIG_* handling for that and probably introduce
CONFIG_MPIC_MMIO and CONFIG_MPIC_DCR.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>


 arch/powerpc/sysdev/mpic.c |  138 ++++++++++++++++++++++++++++++++-------------
 include/asm-powerpc/mpic.h |   35 ++++++++++-
 2 files changed, 132 insertions(+), 41 deletions(-)

Index: linux-cell/arch/powerpc/sysdev/mpic.c
===================================================================
--- linux-cell.orig/arch/powerpc/sysdev/mpic.c	2006-10-16 17:20:39.000000000 +1000
+++ linux-cell/arch/powerpc/sysdev/mpic.c	2006-10-16 17:29:50.000000000 +1000
@@ -147,33 +147,51 @@ static u32 mpic_infos[][MPIC_IDX_END] = 
  */
 
 
-static inline u32 _mpic_read(unsigned int be, volatile u32 __iomem *base,
-			    unsigned int reg)
-{
-	if (be)
-		return in_be32(base + (reg >> 2));
-	else
-		return in_le32(base + (reg >> 2));
+static inline u32 _mpic_read(enum mpic_reg_type type,
+			     struct mpic_reg_bank *rb,
+			     unsigned int reg)
+{
+	switch(type) {
+#ifdef CONFIG_PPC_DCR
+	case mpic_access_dcr:
+		return dcr_read(rb->dhost,
+				rb->dbase + reg + rb->doff);
+#endif
+	case mpic_access_mmio_be:
+		return in_be32(rb->base + (reg >> 2));
+	case mpic_access_mmio_le:
+	default:
+		return in_le32(rb->base + (reg >> 2));
+	}
 }
 
-static inline void _mpic_write(unsigned int be, volatile u32 __iomem *base,
-			      unsigned int reg, u32 value)
+static inline void _mpic_write(enum mpic_reg_type type,
+			       struct mpic_reg_bank *rb,
+ 			       unsigned int reg, u32 value)
 {
-	if (be)
-		out_be32(base + (reg >> 2), value);
-	else
-		out_le32(base + (reg >> 2), value);
+	switch(type) {
+#ifdef CONFIG_PPC_DCR
+	case mpic_access_dcr:
+		return dcr_write(rb->dhost,
+				 rb->dbase + reg + rb->doff, value);
+#endif
+	case mpic_access_mmio_be:
+		return out_be32(rb->base + (reg >> 2), value);
+	case mpic_access_mmio_le:
+	default:
+		return out_le32(rb->base + (reg >> 2), value);
+	}
 }
 
 static inline u32 _mpic_ipi_read(struct mpic *mpic, unsigned int ipi)
 {
-	unsigned int be = (mpic->flags & MPIC_BIG_ENDIAN) != 0;
+	enum mpic_reg_type type = mpic->reg_type;
 	unsigned int offset = MPIC_INFO(GREG_IPI_VECTOR_PRI_0) +
 			      (ipi * MPIC_INFO(GREG_IPI_STRIDE));
 
-	if (mpic->flags & MPIC_BROKEN_IPI)
-		be = !be;
-	return _mpic_read(be, mpic->gregs, offset);
+	if ((mpic->flags & MPIC_BROKEN_IPI) && type == mpic_access_mmio_le)
+		type = mpic_access_mmio_be;
+	return _mpic_read(type, &mpic->gregs, offset);
 }
 
 static inline void _mpic_ipi_write(struct mpic *mpic, unsigned int ipi, u32 value)
@@ -181,7 +199,7 @@ static inline void _mpic_ipi_write(struc
 	unsigned int offset = MPIC_INFO(GREG_IPI_VECTOR_PRI_0) +
 			      (ipi * MPIC_INFO(GREG_IPI_STRIDE));
 
-	_mpic_write(mpic->flags & MPIC_BIG_ENDIAN, mpic->gregs, offset, value);
+	_mpic_write(mpic->reg_type, &mpic->gregs, offset, value);
 }
 
 static inline u32 _mpic_cpu_read(struct mpic *mpic, unsigned int reg)
@@ -190,8 +208,7 @@ static inline u32 _mpic_cpu_read(struct 
 
 	if (mpic->flags & MPIC_PRIMARY)
 		cpu = hard_smp_processor_id();
-	return _mpic_read(mpic->flags & MPIC_BIG_ENDIAN,
-			  mpic->cpuregs[cpu], reg);
+	return _mpic_read(mpic->reg_type, &mpic->cpuregs[cpu], reg);
 }
 
 static inline void _mpic_cpu_write(struct mpic *mpic, unsigned int reg, u32 value)
@@ -201,7 +218,7 @@ static inline void _mpic_cpu_write(struc
 	if (mpic->flags & MPIC_PRIMARY)
 		cpu = hard_smp_processor_id();
 
-	_mpic_write(mpic->flags & MPIC_BIG_ENDIAN, mpic->cpuregs[cpu], reg, value);
+	_mpic_write(mpic->reg_type, &mpic->cpuregs[cpu], reg, value);
 }
 
 static inline u32 _mpic_irq_read(struct mpic *mpic, unsigned int src_no, unsigned int reg)
@@ -209,7 +226,7 @@ static inline u32 _mpic_irq_read(struct 
 	unsigned int	isu = src_no >> mpic->isu_shift;
 	unsigned int	idx = src_no & mpic->isu_mask;
 
-	return _mpic_read(mpic->flags & MPIC_BIG_ENDIAN, mpic->isus[isu],
+	return _mpic_read(mpic->reg_type, &mpic->isus[isu],
 			  reg + (idx * MPIC_INFO(IRQ_STRIDE)));
 }
 
@@ -219,12 +236,12 @@ static inline void _mpic_irq_write(struc
 	unsigned int	isu = src_no >> mpic->isu_shift;
 	unsigned int	idx = src_no & mpic->isu_mask;
 
-	_mpic_write(mpic->flags & MPIC_BIG_ENDIAN, mpic->isus[isu],
+	_mpic_write(mpic->reg_type, &mpic->isus[isu],
 		    reg + (idx * MPIC_INFO(IRQ_STRIDE)), value);
 }
 
-#define mpic_read(b,r)		_mpic_read(mpic->flags & MPIC_BIG_ENDIAN,(b),(r))
-#define mpic_write(b,r,v)	_mpic_write(mpic->flags & MPIC_BIG_ENDIAN,(b),(r),(v))
+#define mpic_read(b,r)		_mpic_read(mpic->reg_type,&(b),(r))
+#define mpic_write(b,r,v)	_mpic_write(mpic->reg_type,&(b),(r),(v))
 #define mpic_ipi_read(i)	_mpic_ipi_read(mpic,(i))
 #define mpic_ipi_write(i,v)	_mpic_ipi_write(mpic,(i),(v))
 #define mpic_cpu_read(i)	_mpic_cpu_read(mpic,(i))
@@ -238,6 +255,38 @@ static inline void _mpic_irq_write(struc
  */
 
 
+static void _mpic_map_mmio(struct mpic *mpic, unsigned long phys_addr,
+			   struct mpic_reg_bank *rb, unsigned int offset,
+			   unsigned int size)
+{
+	rb->base = ioremap(phys_addr + offset, size);
+	BUG_ON(rb->base == NULL);
+}
+
+#ifdef CONFIG_PPC_DCR
+static void _mpic_map_dcr(struct mpic *mpic, struct mpic_reg_bank *rb,
+			  unsigned int offset, unsigned int size)
+{
+	rb->dbase = mpic->dcr_base;
+	rb->doff = offset;
+	rb->dhost = dcr_map(mpic->of_node, rb->dbase + rb->doff, size);
+	BUG_ON(!DCR_MAP_OK(rb->dhost));
+}
+
+static inline void mpic_map(struct mpic *mpic, unsigned long phys_addr,
+			    struct mpic_reg_bank *rb, unsigned int offset,
+			    unsigned int size)
+{
+	if (mpic->flags & MPIC_USES_DCR)
+		_mpic_map_dcr(mpic, rb, offset, size);
+	else
+		_mpic_map_mmio(mpic, phys_addr, rb, offset, size);
+}
+#else /* CONFIG_PPC_DCR */
+#define mpic_map(m,p,b,o,s)	_mpic_map_mmio(m,p,b,o,s)
+#endif /* !CONFIG_PPC_DCR */
+
+
 
 /* Check if we have one of those nice broken MPICs with a flipped endian on
  * reads from IPI registers
@@ -883,6 +932,7 @@ struct mpic * __init mpic_alloc(struct d
 	if (flags & MPIC_PRIMARY)
 		mpic->hc_ht_irq.set_affinity = mpic_set_affinity;
 #endif /* CONFIG_MPIC_BROKEN_U3 */
+
 #ifdef CONFIG_SMP
 	mpic->hc_ipi = mpic_ipi_chip;
 	mpic->hc_ipi.typename = name;
@@ -897,11 +947,26 @@ struct mpic * __init mpic_alloc(struct d
 	mpic->hw_set = mpic_infos[MPIC_GET_REGSET(flags)];
 #endif
 
+	/* default register type */
+	mpic->reg_type = (flags & MPIC_BIG_ENDIAN) ?
+		mpic_access_mmio_be : mpic_access_mmio_le;
+
+#ifdef CONFIG_PPC_DCR
+	if (mpic->flags & MPIC_USES_DCR) {
+		const u32 *dbasep;
+		BUG_ON(mpic->of_node == NULL);
+		dbasep = get_property(mpic->of_node, "dcr-reg", NULL);
+		BUG_ON(dbasep == NULL);
+		mpic->dcr_base = *dbasep;
+		mpic->reg_type = mpic_access_dcr;
+	}
+#else
+	BUG_ON (mpic->flags & MPIC_USES_DCR);
+#endif /* CONFIG_PPC_DCR */
+
 	/* Map the global registers */
-	mpic->gregs = ioremap(phys_addr + MPIC_INFO(GREG_BASE), 0x1000);
-	mpic->tmregs = mpic->gregs +
-		       ((MPIC_INFO(TIMER_BASE) - MPIC_INFO(GREG_BASE)) >> 2);
-	BUG_ON(mpic->gregs == NULL);
+	mpic_map(mpic, phys_addr, &mpic->gregs, MPIC_INFO(GREG_BASE), 0x1000);
+	mpic_map(mpic, phys_addr, &mpic->tmregs, MPIC_INFO(TIMER_BASE), 0x1000);
 
 	/* Reset */
 	if (flags & MPIC_WANTS_RESET) {
@@ -926,17 +991,16 @@ struct mpic * __init mpic_alloc(struct d
 
 	/* Map the per-CPU registers */
 	for (i = 0; i < mpic->num_cpus; i++) {
-		mpic->cpuregs[i] = ioremap(phys_addr + MPIC_INFO(CPU_BASE) +
-					   i * MPIC_INFO(CPU_STRIDE), 0x1000);
-		BUG_ON(mpic->cpuregs[i] == NULL);
+		mpic_map(mpic, phys_addr, &mpic->cpuregs[i],
+			 MPIC_INFO(CPU_BASE) + i * MPIC_INFO(CPU_STRIDE),
+			 0x1000);
 	}
 
 	/* Initialize main ISU if none provided */
 	if (mpic->isu_size == 0) {
 		mpic->isu_size = mpic->num_sources;
-		mpic->isus[0] = ioremap(phys_addr + MPIC_INFO(IRQ_BASE),
-					MPIC_INFO(IRQ_STRIDE) * mpic->isu_size);
-		BUG_ON(mpic->isus[0] == NULL);
+		mpic_map(mpic, phys_addr, &mpic->isus[0],
+			 MPIC_INFO(IRQ_BASE), MPIC_INFO(IRQ_STRIDE) * mpic->isu_size);
 	}
 	mpic->isu_shift = 1 + __ilog2(mpic->isu_size - 1);
 	mpic->isu_mask = (1 << mpic->isu_shift) - 1;
@@ -979,8 +1043,8 @@ void __init mpic_assign_isu(struct mpic 
 
 	BUG_ON(isu_num >= MPIC_MAX_ISU);
 
-	mpic->isus[isu_num] = ioremap(phys_addr,
-				      MPIC_INFO(IRQ_STRIDE) * mpic->isu_size);
+	mpic_map(mpic, phys_addr, &mpic->isus[isu_num], 0,
+		 MPIC_INFO(IRQ_STRIDE) * mpic->isu_size);
 	if ((isu_first + mpic->isu_size) > mpic->num_sources)
 		mpic->num_sources = isu_first + mpic->isu_size;
 }
Index: linux-cell/include/asm-powerpc/mpic.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/mpic.h	2006-10-16 17:20:39.000000000 +1000
+++ linux-cell/include/asm-powerpc/mpic.h	2006-10-16 17:26:46.000000000 +1000
@@ -3,6 +3,7 @@
 #ifdef __KERNEL__
 
 #include <linux/irq.h>
+#include <asm/dcr.h>
 
 /*
  * Global registers
@@ -225,6 +226,23 @@ struct mpic_irq_fixup
 #endif /* CONFIG_MPIC_BROKEN_U3 */
 
 
+enum mpic_reg_type {
+	mpic_access_mmio_le,
+	mpic_access_mmio_be,
+#ifdef CONFIG_PPC_DCR
+	mpic_access_dcr
+#endif
+};
+
+struct mpic_reg_bank {
+	u32 __iomem	*base;
+#ifdef CONFIG_PPC_DCR
+	dcr_host_t	dhost;
+	unsigned int	dbase;
+	unsigned int	doff;
+#endif /* CONFIG_PPC_DCR */
+};
+
 /* The instance data of a given MPIC */
 struct mpic
 {
@@ -264,11 +282,18 @@ struct mpic
 	spinlock_t		fixup_lock;
 #endif
 
+	/* Register access method */
+	enum mpic_reg_type	reg_type;
+
 	/* The various ioremap'ed bases */
-	volatile u32 __iomem	*gregs;
-	volatile u32 __iomem	*tmregs;
-	volatile u32 __iomem	*cpuregs[MPIC_MAX_CPUS];
-	volatile u32 __iomem	*isus[MPIC_MAX_ISU];
+	struct mpic_reg_bank	gregs;
+	struct mpic_reg_bank	tmregs;
+	struct mpic_reg_bank	cpuregs[MPIC_MAX_CPUS];
+	struct mpic_reg_bank	isus[MPIC_MAX_ISU];
+
+#ifdef CONFIG_PPC_DCR
+	unsigned int		dcr_base;
+#endif
 
 #ifdef CONFIG_MPIC_WEIRD
 	/* Pointer to HW info array */
@@ -305,6 +330,8 @@ struct mpic
 #define MPIC_SPV_EOI			0x00000020
 /* No passthrough disable */
 #define MPIC_NO_PTHROU_DIS		0x00000040
+/* DCR based MPIC */
+#define MPIC_USES_DCR			0x00000080
 
 /* MPIC HW modification ID */
 #define MPIC_REGSET_MASK		0xf0000000

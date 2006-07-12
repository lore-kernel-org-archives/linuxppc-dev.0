Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 822B7679E7
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Jul 2006 13:28:27 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k6C3SOWI028052
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Jul 2006 20:28:24 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k6C3SEFV006672
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Jul 2006 22:28:16 -0500 (CDT)
Subject: [PATCH] powerpc: Add tsi108/9 and new hardware interface to mpic
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 12 Jul 2006 11:28:12 +0800
Message-ID: <7EA18FDD2DC2154AA3BD6D2F22A62A0E0456D0@zch01exm23.fsl.freescale.net>
In-Reply-To: <9FCDBA58F226D911B202000BDBAD4673069C3F3F@zch01exm40.ap.freescale.net>
From: "Zang Roy-r61911" <tie-fei.zang@freescale.com>
To: "Paul Mackerras" <paulus@samba.org>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>,
	Alexandre.Bounine@tundra.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The patch add new hardware information table for mpic. This enables mpic
code=20
to deal with OpenPIC controller with hardware behavior difference.
Add TSI108/109 PIC hardware information table.  The Tsi108/109 PIC looks
like=20
standard OpenPIC but, in fact, is different in registers mapping and
behavior.
  =20
Signed-off-by: Alexandre Bounine <alexandreb@tundra.com>
Signed-off-by: Roy Zang	<tie-fei.zang@freescale.com>=20

---

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 6e0281a..b8d4423 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -54,6 +54,82 @@ #define distribute_irqs	(0)
 #endif
 #endif
=20
+static struct mpic_info mpic_infos[] =3D {
+	[0] =3D {	/* Original OpenPIC compatible MPIC */
+	.greg_base	=3D MPIC_GREG_BASE,
+	.greg_frr0	=3D MPIC_GREG_FEATURE_0,
+	.greg_config0	=3D MPIC_GREG_GLOBAL_CONF_0,
+	.greg_vendor_id	=3D MPIC_GREG_VENDOR_ID,
+	.greg_ipi_vp0	=3D MPIC_GREG_IPI_VECTOR_PRI_0,
+	.greg_ipi_stride	=3D MPIC_GREG_IPI_STRIDE,
+	.greg_spurious	=3D MPIC_GREG_SPURIOUS,
+	.greg_tfrr	=3D MPIC_GREG_TIMER_FREQ,
+
+	.timer_base	=3D MPIC_TIMER_BASE,
+	.timer_stride	=3D MPIC_TIMER_STRIDE,
+	.timer_ccr	=3D MPIC_TIMER_CURRENT_CNT,
+	.timer_bcr	=3D MPIC_TIMER_BASE_CNT,
+	.timer_vpr	=3D MPIC_TIMER_VECTOR_PRI,
+	.timer_dest	=3D MPIC_TIMER_DESTINATION,
+
+	.cpu_base	=3D MPIC_CPU_BASE,
+	.cpu_stride	=3D MPIC_CPU_STRIDE,
+	.cpu_ipi_disp0	=3D MPIC_CPU_IPI_DISPATCH_0,
+	.cpu_ipi_disp_stride	=3D MPIC_CPU_IPI_DISPATCH_STRIDE,
+	.cpu_task_pri	=3D MPIC_CPU_CURRENT_TASK_PRI,
+	.cpu_whoami	=3D MPIC_CPU_WHOAMI,
+	.cpu_intack	=3D MPIC_CPU_INTACK,
+	.cpu_eoi	=3D MPIC_CPU_EOI,
+
+	.irq_base	=3D MPIC_IRQ_BASE,
+	.irq_stride	=3D MPIC_IRQ_STRIDE,
+	.irq_vpr	=3D MPIC_IRQ_VECTOR_PRI,
+	.irq_vpr_vector	=3D MPIC_VECPRI_VECTOR_MASK,
+	.irq_vpr_polpos	=3D MPIC_VECPRI_POLARITY_POSITIVE,
+	.irq_vpr_polneg =3D MPIC_VECPRI_POLARITY_NEGATIVE,
+	.irq_vpr_senlvl	=3D MPIC_VECPRI_SENSE_LEVEL,
+	.irq_vpr_senedg =3D MPIC_VECPRI_SENSE_EDGE,
+	.irq_dest	=3D MPIC_IRQ_DESTINATION,
+	},
+
+	[1] =3D {	/* Tsi108/109 PIC */
+	.greg_base	=3D TSI108_GREG_BASE,
+	.greg_frr0	=3D TSI108_GREG_FEATURE_0,
+	.greg_config0	=3D TSI108_GREG_GLOBAL_CONF_0,
+	.greg_vendor_id	=3D TSI108_GREG_VENDOR_ID,
+	.greg_ipi_vp0	=3D TSI108_GREG_IPI_VECTOR_PRI_0,
+	.greg_ipi_stride	=3D TSI108_GREG_IPI_STRIDE,
+	.greg_spurious	=3D TSI108_GREG_SPURIOUS,
+	.greg_tfrr	=3D TSI108_GREG_TIMER_FREQ,
+
+	.timer_base	=3D TSI108_TIMER_BASE,
+	.timer_stride	=3D TSI108_TIMER_STRIDE,
+	.timer_ccr	=3D TSI108_TIMER_CURRENT_CNT,
+	.timer_bcr	=3D TSI108_TIMER_BASE_CNT,
+	.timer_vpr	=3D TSI108_TIMER_VECTOR_PRI,
+	.timer_dest	=3D TSI108_TIMER_DESTINATION,
+
+	.cpu_base	=3D TSI108_CPU_BASE,
+	.cpu_stride	=3D TSI108_CPU_STRIDE,
+	.cpu_ipi_disp0	=3D TSI108_CPU_IPI_DISPATCH_0,
+	.cpu_ipi_disp_stride	=3D TSI108_CPU_IPI_DISPATCH_STRIDE,
+	.cpu_task_pri	=3D TSI108_CPU_CURRENT_TASK_PRI,
+	.cpu_whoami	=3D 0xFFFFFFFF,
+	.cpu_intack	=3D TSI108_CPU_INTACK,
+	.cpu_eoi	=3D TSI108_CPU_EOI,
+
+	.irq_base	=3D TSI108_IRQ_REG_BASE,
+	.irq_stride	=3D TSI108_IRQ_STRIDE,
+	.irq_vpr	=3D TSI108_IRQ_VECTOR_PRI,
+	.irq_vpr_vector =3D TSI108_VECPRI_VECTOR_MASK,
+	.irq_vpr_polpos =3D TSI108_VECPRI_POLARITY_POSITIVE,
+	.irq_vpr_polneg =3D TSI108_VECPRI_POLARITY_NEGATIVE,
+	.irq_vpr_senlvl =3D TSI108_VECPRI_SENSE_LEVEL,
+	.irq_vpr_senedg =3D TSI108_VECPRI_SENSE_EDGE,
+	.irq_dest	=3D TSI108_IRQ_DESTINATION,
+	},
+};
+
 /*
  * Register accessor functions
  */
@@ -80,7 +156,8 @@ static inline void _mpic_write(unsigned=20
 static inline u32 _mpic_ipi_read(struct mpic *mpic, unsigned int ipi)
 {
 	unsigned int be =3D (mpic->flags & MPIC_BIG_ENDIAN) !=3D 0;
-	unsigned int offset =3D MPIC_GREG_IPI_VECTOR_PRI_0 + (ipi * 0x10);
+	unsigned int offset =3D mpic->hw_set->greg_ipi_vp0 +
+			      (ipi * mpic->hw_set->greg_ipi_stride);
=20
 	if (mpic->flags & MPIC_BROKEN_IPI)
 		be =3D !be;
@@ -89,7 +166,8 @@ static inline u32 _mpic_ipi_read(struct=20
=20
 static inline void _mpic_ipi_write(struct mpic *mpic, unsigned int ipi,
u32 value)
 {
-	unsigned int offset =3D MPIC_GREG_IPI_VECTOR_PRI_0 + (ipi * 0x10);
+	unsigned int offset =3D mpic->hw_set->greg_ipi_vp0 +
+			      (ipi * mpic->hw_set->greg_ipi_stride);
=20
 	_mpic_write(mpic->flags & MPIC_BIG_ENDIAN, mpic->gregs, offset,
value);
 }
@@ -120,7 +198,7 @@ static inline u32 _mpic_irq_read(struct=20
 	unsigned int	idx =3D src_no & mpic->isu_mask;
=20
 	return _mpic_read(mpic->flags & MPIC_BIG_ENDIAN,
mpic->isus[isu],
-			  reg + (idx * MPIC_IRQ_STRIDE));
+			  reg + (idx * mpic->hw_set->irq_stride));
 }
=20
 static inline void _mpic_irq_write(struct mpic *mpic, unsigned int
src_no,
@@ -130,7 +208,7 @@ static inline void _mpic_irq_write(struc
 	unsigned int	idx =3D src_no & mpic->isu_mask;
=20
 	_mpic_write(mpic->flags & MPIC_BIG_ENDIAN, mpic->isus[isu],
-		    reg + (idx * MPIC_IRQ_STRIDE), value);
+		    reg + (idx * mpic->hw_set->irq_stride), value);
 }
=20
 #define mpic_read(b,r)		_mpic_read(mpic->flags &
MPIC_BIG_ENDIAN,(b),(r))
@@ -156,8 +234,8 @@ static void __init mpic_test_broken_ipi(
 {
 	u32 r;
=20
-	mpic_write(mpic->gregs, MPIC_GREG_IPI_VECTOR_PRI_0,
MPIC_VECPRI_MASK);
-	r =3D mpic_read(mpic->gregs, MPIC_GREG_IPI_VECTOR_PRI_0);
+	mpic_write(mpic->gregs, mpic->hw_set->greg_ipi_vp0,
MPIC_VECPRI_MASK);
+	r =3D mpic_read(mpic->gregs, mpic->hw_set->greg_ipi_vp0);
=20
 	if (r =3D=3D le32_to_cpu(MPIC_VECPRI_MASK)) {
 		printk(KERN_INFO "mpic: Detected reversed IPI
registers\n");
@@ -394,8 +472,8 @@ static inline struct mpic * mpic_from_ir
 /* Send an EOI */
 static inline void mpic_eoi(struct mpic *mpic)
 {
-	mpic_cpu_write(MPIC_CPU_EOI, 0);
-	(void)mpic_cpu_read(MPIC_CPU_WHOAMI);
+	mpic_cpu_write(mpic->hw_set->cpu_eoi, 0);
+	(void)mpic_cpu_read(mpic->hw_set->cpu_task_pri);
 }
=20
 #ifdef CONFIG_SMP
@@ -419,8 +497,8 @@ static void mpic_unmask_irq(unsigned int
=20
 	DBG("%p: %s: enable_irq: %d (src %d)\n", mpic, mpic->name, irq,
src);
=20
-	mpic_irq_write(src, MPIC_IRQ_VECTOR_PRI,
-		       mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) &
+	mpic_irq_write(src, mpic->hw_set->irq_vpr,
+		       mpic_irq_read(src, mpic->hw_set->irq_vpr) &
 		       ~MPIC_VECPRI_MASK);
 	/* make sure mask gets to controller before we return to user */
 	do {
@@ -428,7 +506,7 @@ static void mpic_unmask_irq(unsigned int
 			printk(KERN_ERR "mpic_enable_irq timeout\n");
 			break;
 		}
-	} while(mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) &
MPIC_VECPRI_MASK);
+	} while(mpic_irq_read(src, mpic->hw_set->irq_vpr) &
MPIC_VECPRI_MASK);=09
 }
=20
 static void mpic_mask_irq(unsigned int irq)
@@ -439,8 +517,8 @@ static void mpic_mask_irq(unsigned int i
=20
 	DBG("%s: disable_irq: %d (src %d)\n", mpic->name, irq, src);
=20
-	mpic_irq_write(src, MPIC_IRQ_VECTOR_PRI,
-		       mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) |
+	mpic_irq_write(src, mpic->hw_set->irq_vpr,
+		       mpic_irq_read(src, mpic->hw_set->irq_vpr) |
 		       MPIC_VECPRI_MASK);
=20
 	/* make sure mask gets to controller before we return to user */
@@ -449,7 +527,7 @@ static void mpic_mask_irq(unsigned int i
 			printk(KERN_ERR "mpic_enable_irq timeout\n");
 			break;
 		}
-	} while(!(mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) &
MPIC_VECPRI_MASK));
+	} while(!(mpic_irq_read(src, mpic->hw_set->irq_vpr) &
MPIC_VECPRI_MASK));
 }
=20
 static void mpic_end_irq(unsigned int irq)
@@ -560,24 +638,28 @@ static void mpic_set_affinity(unsigned i
=20
 	cpus_and(tmp, cpumask, cpu_online_map);
=20
-	mpic_irq_write(src, MPIC_IRQ_DESTINATION,
+	mpic_irq_write(src, mpic->hw_set->irq_dest,
 		       mpic_physmask(cpus_addr(tmp)[0]));=09
 }
=20
-static unsigned int mpic_type_to_vecpri(unsigned int type)
+static unsigned int mpic_type_to_vecpri(struct mpic *mpic, unsigned int
type)
 {
 	/* Now convert sense value */
 	switch(type & IRQ_TYPE_SENSE_MASK) {
 	case IRQ_TYPE_EDGE_RISING:
-		return MPIC_VECPRI_SENSE_EDGE |
MPIC_VECPRI_POLARITY_POSITIVE;
+		return mpic->hw_set->irq_vpr_senedg |
+			mpic->hw_set->irq_vpr_polpos;
 	case IRQ_TYPE_EDGE_FALLING:
 	case IRQ_TYPE_EDGE_BOTH:
-		return MPIC_VECPRI_SENSE_EDGE |
MPIC_VECPRI_POLARITY_NEGATIVE;
+		return mpic->hw_set->irq_vpr_senedg |
+			mpic->hw_set->irq_vpr_polneg;
 	case IRQ_TYPE_LEVEL_HIGH:
-		return MPIC_VECPRI_SENSE_LEVEL |
MPIC_VECPRI_POLARITY_POSITIVE;
+		return mpic->hw_set->irq_vpr_senlvl |
+			mpic->hw_set->irq_vpr_polpos;
 	case IRQ_TYPE_LEVEL_LOW:
 	default:
-		return MPIC_VECPRI_SENSE_LEVEL |
MPIC_VECPRI_POLARITY_NEGATIVE;
+		return mpic->hw_set->irq_vpr_senlvl |
+			mpic->hw_set->irq_vpr_polneg;
 	}
 }
=20
@@ -609,13 +691,13 @@ static int mpic_set_irq_type(unsigned in
 		vecpri =3D MPIC_VECPRI_POLARITY_POSITIVE |
 			MPIC_VECPRI_SENSE_EDGE;
 	else
-		vecpri =3D mpic_type_to_vecpri(flow_type);
+		vecpri =3D mpic_type_to_vecpri(mpic, flow_type);
=20
-	vold =3D mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI);
+	vold =3D mpic_irq_read(src, mpic->hw_set->irq_vpr);
 	vnew =3D vold & ~(MPIC_VECPRI_POLARITY_MASK |
MPIC_VECPRI_SENSE_MASK);
 	vnew |=3D vecpri;
 	if (vold !=3D vnew)
-		mpic_irq_write(src, MPIC_IRQ_VECTOR_PRI, vnew);
+		mpic_irq_write(src, mpic->hw_set->irq_vpr, vnew);
=20
 	return 0;
 }
@@ -797,18 +879,20 @@ #endif /* CONFIG_SMP */
 	mpic->isu_size =3D isu_size;
 	mpic->irq_count =3D irq_count;
 	mpic->num_sources =3D 0; /* so far */
+	mpic->hw_set =3D &mpic_infos[MPIC_GET_MOD_ID(flags)];
=20
 	/* Map the global registers */
-	mpic->gregs =3D ioremap(phys_addr + MPIC_GREG_BASE, 0x1000);
-	mpic->tmregs =3D mpic->gregs + ((MPIC_TIMER_BASE - MPIC_GREG_BASE)
>> 2);
+	mpic->gregs =3D ioremap(phys_addr + mpic->hw_set->greg_base,
0x1000);
+	mpic->tmregs =3D mpic->gregs +
+		       ((mpic->hw_set->timer_base -
mpic->hw_set->greg_base) >> 2);
 	BUG_ON(mpic->gregs =3D=3D NULL);
=20
 	/* Reset */
 	if (flags & MPIC_WANTS_RESET) {
-		mpic_write(mpic->gregs, MPIC_GREG_GLOBAL_CONF_0,
-			   mpic_read(mpic->gregs,
MPIC_GREG_GLOBAL_CONF_0)
+		mpic_write(mpic->gregs, mpic->hw_set->greg_config0,
+			   mpic_read(mpic->gregs,
mpic->hw_set->greg_config0)
 			   | MPIC_GREG_GCONF_RESET);
-		while( mpic_read(mpic->gregs, MPIC_GREG_GLOBAL_CONF_0)
+		while( mpic_read(mpic->gregs,
mpic->hw_set->greg_config0)
 		       & MPIC_GREG_GCONF_RESET)
 			mb();
 	}
@@ -817,7 +901,7 @@ #endif /* CONFIG_SMP */
 	 * MPICs, num sources as well. On ISU MPICs, sources are counted
 	 * as ISUs are added
 	 */
-	reg =3D mpic_read(mpic->gregs, MPIC_GREG_FEATURE_0);
+	reg =3D mpic_read(mpic->gregs, mpic->hw_set->greg_frr0);
 	mpic->num_cpus =3D ((reg & MPIC_GREG_FEATURE_LAST_CPU_MASK)
 			  >> MPIC_GREG_FEATURE_LAST_CPU_SHIFT) + 1;
 	if (isu_size =3D=3D 0)
@@ -826,16 +910,16 @@ #endif /* CONFIG_SMP */
=20
 	/* Map the per-CPU registers */
 	for (i =3D 0; i < mpic->num_cpus; i++) {
-		mpic->cpuregs[i] =3D ioremap(phys_addr + MPIC_CPU_BASE +
-					   i * MPIC_CPU_STRIDE, 0x1000);
+		mpic->cpuregs[i] =3D ioremap(phys_addr +
mpic->hw_set->cpu_base +
+					   i * mpic->hw_set->cpu_stride,
0x1000);
 		BUG_ON(mpic->cpuregs[i] =3D=3D NULL);
 	}
=20
 	/* Initialize main ISU if none provided */
 	if (mpic->isu_size =3D=3D 0) {
 		mpic->isu_size =3D mpic->num_sources;
-		mpic->isus[0] =3D ioremap(phys_addr + MPIC_IRQ_BASE,
-					MPIC_IRQ_STRIDE *
mpic->isu_size);
+		mpic->isus[0] =3D ioremap(phys_addr +
mpic->hw_set->irq_base,
+					mpic->hw_set->irq_stride *
mpic->isu_size);
 		BUG_ON(mpic->isus[0] =3D=3D NULL);
 	}
 	mpic->isu_shift =3D 1 + __ilog2(mpic->isu_size - 1);
@@ -879,7 +963,8 @@ void __init mpic_assign_isu(struct mpic=20
=20
 	BUG_ON(isu_num >=3D MPIC_MAX_ISU);
=20
-	mpic->isus[isu_num] =3D ioremap(phys_addr, MPIC_IRQ_STRIDE *
mpic->isu_size);
+	mpic->isus[isu_num] =3D ioremap(phys_addr,
+				      mpic->hw_set->irq_stride *
mpic->isu_size);
 	if ((isu_first + mpic->isu_size) > mpic->num_sources)
 		mpic->num_sources =3D isu_first + mpic->isu_size;
 }
@@ -904,14 +989,15 @@ void __init mpic_init(struct mpic *mpic)
 	printk(KERN_INFO "mpic: Initializing for %d sources\n",
mpic->num_sources);
=20
 	/* Set current processor priority to max */
-	mpic_cpu_write(MPIC_CPU_CURRENT_TASK_PRI, 0xf);
+	mpic_cpu_write(mpic->hw_set->cpu_task_pri, 0xf);
=20
 	/* Initialize timers: just disable them all */
 	for (i =3D 0; i < 4; i++) {
 		mpic_write(mpic->tmregs,
-			   i * MPIC_TIMER_STRIDE +
MPIC_TIMER_DESTINATION, 0);
+			   i * mpic->hw_set->timer_stride +
+			   mpic->hw_set->timer_dest, 0);
 		mpic_write(mpic->tmregs,
-			   i * MPIC_TIMER_STRIDE +
MPIC_TIMER_VECTOR_PRI,
+			   i * mpic->hw_set->timer_stride +
mpic->hw_set->timer_vpr,
 			   MPIC_VECPRI_MASK |
 			   (MPIC_VEC_TIMER_0 + i));
 	}
@@ -940,21 +1026,22 @@ void __init mpic_init(struct mpic *mpic)
 			(8 << MPIC_VECPRI_PRIORITY_SHIFT);
 	=09
 		/* init hw */
-		mpic_irq_write(i, MPIC_IRQ_VECTOR_PRI, vecpri);
-		mpic_irq_write(i, MPIC_IRQ_DESTINATION,
+		mpic_irq_write(i, mpic->hw_set->irq_vpr, vecpri);
+		mpic_irq_write(i, mpic->hw_set->irq_dest,
 			       1 << hard_smp_processor_id());
 	}
 =09
 	/* Init spurrious vector */
-	mpic_write(mpic->gregs, MPIC_GREG_SPURIOUS, MPIC_VEC_SPURRIOUS);
+	mpic_write(mpic->gregs, mpic->hw_set->greg_spurious,
MPIC_VEC_SPURRIOUS);
=20
-	/* Disable 8259 passthrough */
-	mpic_write(mpic->gregs, MPIC_GREG_GLOBAL_CONF_0,
-		   mpic_read(mpic->gregs, MPIC_GREG_GLOBAL_CONF_0)
-		   | MPIC_GREG_GCONF_8259_PTHROU_DIS);
+	/* Disable 8259 passthrough, if supported */
+	if (MPIC_GET_MOD_ID(mpic->flags) !=3D MPIC_ID_TSI108)
+		mpic_write(mpic->gregs, mpic->hw_set->greg_config0,
+			   mpic_read(mpic->gregs,
mpic->hw_set->greg_config0)
+			   | MPIC_GREG_GCONF_8259_PTHROU_DIS);
=20
 	/* Set current processor priority to 0 */
-	mpic_cpu_write(MPIC_CPU_CURRENT_TASK_PRI, 0);
+	mpic_cpu_write(mpic->hw_set->cpu_task_pri, 0);
 }
=20
 void __init mpic_set_clk_ratio(struct mpic *mpic, u32 clock_ratio)
@@ -997,9 +1084,9 @@ void mpic_irq_set_priority(unsigned int=20
 		mpic_ipi_write(src - MPIC_VEC_IPI_0,
 			       reg | (pri <<
MPIC_VECPRI_PRIORITY_SHIFT));
 	} else {
-		reg =3D mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI)
+		reg =3D mpic_irq_read(src, mpic->hw_set->irq_vpr)
 			& ~MPIC_VECPRI_PRIORITY_MASK;
-		mpic_irq_write(src, MPIC_IRQ_VECTOR_PRI,
+		mpic_irq_write(src, mpic->hw_set->irq_vpr,
 			       reg | (pri <<
MPIC_VECPRI_PRIORITY_SHIFT));
 	}
 	spin_unlock_irqrestore(&mpic_lock, flags);
@@ -1017,7 +1104,7 @@ unsigned int mpic_irq_get_priority(unsig
 	if (is_ipi)
 		reg =3D mpic_ipi_read(src =3D MPIC_VEC_IPI_0);
 	else
-		reg =3D mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI);
+		reg =3D mpic_irq_read(src, mpic->hw_set->irq_vpr);
 	spin_unlock_irqrestore(&mpic_lock, flags);
 	return (reg & MPIC_VECPRI_PRIORITY_MASK) >>
MPIC_VECPRI_PRIORITY_SHIFT;
 }
@@ -1043,12 +1130,12 @@ #ifdef CONFIG_SMP
  	 */
 	if (distribute_irqs) {
 	 	for (i =3D 0; i < mpic->num_sources ; i++)
-			mpic_irq_write(i, MPIC_IRQ_DESTINATION,
-				mpic_irq_read(i, MPIC_IRQ_DESTINATION) |
msk);
+			mpic_irq_write(i, mpic->hw_set->irq_dest,
+				mpic_irq_read(i, mpic->hw_set->irq_dest)
| msk);
 	}
=20
 	/* Set current processor priority to 0 */
-	mpic_cpu_write(MPIC_CPU_CURRENT_TASK_PRI, 0);
+	mpic_cpu_write(mpic->hw_set->cpu_task_pri, 0);
=20
 	spin_unlock_irqrestore(&mpic_lock, flags);
 #endif /* CONFIG_SMP */
@@ -1058,7 +1145,7 @@ int mpic_cpu_get_priority(void)
 {
 	struct mpic *mpic =3D mpic_primary;
=20
-	return mpic_cpu_read(MPIC_CPU_CURRENT_TASK_PRI);
+	return mpic_cpu_read(mpic->hw_set->cpu_task_pri);
 }
=20
 void mpic_cpu_set_priority(int prio)
@@ -1066,7 +1153,7 @@ void mpic_cpu_set_priority(int prio)
 	struct mpic *mpic =3D mpic_primary;
=20
 	prio &=3D MPIC_CPU_TASKPRI_MASK;
-	mpic_cpu_write(MPIC_CPU_CURRENT_TASK_PRI, prio);
+	mpic_cpu_write(mpic->hw_set->cpu_task_pri, prio);
 }
=20
 /*
@@ -1088,11 +1175,11 @@ void mpic_teardown_this_cpu(int secondar
=20
 	/* let the mpic know we don't want intrs.  */
 	for (i =3D 0; i < mpic->num_sources ; i++)
-		mpic_irq_write(i, MPIC_IRQ_DESTINATION,
-			mpic_irq_read(i, MPIC_IRQ_DESTINATION) & ~msk);
+		mpic_irq_write(i, mpic->hw_set->irq_dest,
+			mpic_irq_read(i, mpic->hw_set->irq_dest) &
~msk);
=20
 	/* Set current processor priority to max */
-	mpic_cpu_write(MPIC_CPU_CURRENT_TASK_PRI, 0xf);
+	mpic_cpu_write(mpic->hw_set->cpu_task_pri, 0xf);
=20
 	spin_unlock_irqrestore(&mpic_lock, flags);
 }
@@ -1108,7 +1195,8 @@ #ifdef DEBUG_IPI
 	DBG("%s: send_ipi(ipi_no: %d)\n", mpic->name, ipi_no);
 #endif
=20
-	mpic_cpu_write(MPIC_CPU_IPI_DISPATCH_0 + ipi_no * 0x10,
+	mpic_cpu_write(mpic->hw_set->cpu_ipi_disp0 +
+		       ipi_no * mpic->hw_set->cpu_ipi_disp_stride,
 		       mpic_physmask(cpu_mask &
cpus_addr(cpu_online_map)[0]));
 }
=20
@@ -1116,7 +1204,7 @@ unsigned int mpic_get_one_irq(struct mpi
 {
 	u32 src;
=20
-	src =3D mpic_cpu_read(MPIC_CPU_INTACK) & MPIC_VECPRI_VECTOR_MASK;
+	src =3D mpic_cpu_read(mpic->hw_set->cpu_intack) &
mpic->hw_set->irq_vpr_vector;
 #ifdef DEBUG_LOW
 	DBG("%s: get_one_irq(): %d\n", mpic->name, src);
 #endif

diff --git a/include/asm-powerpc/mpic.h b/include/asm-powerpc/mpic.h
index eb241c9..073dabc 100644
--- a/include/asm-powerpc/mpic.h
+++ b/include/asm-powerpc/mpic.h
@@ -41,6 +41,7 @@ #define MPIC_GREG_IPI_VECTOR_PRI_0	0x000
 #define MPIC_GREG_IPI_VECTOR_PRI_1	0x000b0
 #define MPIC_GREG_IPI_VECTOR_PRI_2	0x000c0
 #define MPIC_GREG_IPI_VECTOR_PRI_3	0x000d0
+#define MPIC_GREG_IPI_STRIDE		0x10
 #define MPIC_GREG_SPURIOUS		0x000e0
 #define MPIC_GREG_TIMER_FREQ		0x000f0
=20
@@ -68,6 +69,7 @@ #define MPIC_CPU_IPI_DISPATCH_0		0x00040
 #define MPIC_CPU_IPI_DISPATCH_1		0x00050
 #define MPIC_CPU_IPI_DISPATCH_2		0x00060
 #define MPIC_CPU_IPI_DISPATCH_3		0x00070
+#define MPIC_CPU_IPI_DISPATCH_STRIDE	0x00010
 #define MPIC_CPU_CURRENT_TASK_PRI	0x00080
 #define 	MPIC_CPU_TASKPRI_MASK			0x0000000f
 #define MPIC_CPU_WHOAMI			0x00090
@@ -95,6 +97,57 @@ #define 	MPIC_VECPRI_SENSE_EDGE
0x0000
 #define 	MPIC_VECPRI_SENSE_MASK			0x00400000
 #define MPIC_IRQ_DESTINATION		0x00010
=20
+/**********************************************************************
********
+ * Tsi108 implementation of MPIC has many differences form the original
one
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
+#define TSI108_VECPRI_VECTOR_MASK	0x000000ff
+#define TSI108_VECPRI_POLARITY_POSITIVE	0x01000000
+#define TSI108_VECPRI_POLARITY_NEGATIVE	0x00000000
+#define TSI108_VECPRI_SENSE_LEVEL	0x02000000
+#define TSI108_VECPRI_SENSE_EDGE	0x00000000
+#define TSI108_IRQ_DESTINATION		0x00004
+
 #define MPIC_MAX_IRQ_SOURCES	2048
 #define MPIC_MAX_CPUS		32
 #define MPIC_MAX_ISU		32
@@ -125,6 +178,42 @@ struct mpic_irq_fixup
 };
 #endif /* CONFIG_MPIC_BROKEN_U3 */
=20
+struct mpic_info {
+	u32	greg_base;	/* offset of global registers from MPIC
base */
+	u32	greg_frr0;	/* FRR0 offset from base */
+	u32	greg_config0;	/* Global Config register offset from
base */
+	u32	greg_vendor_id;	/* VID register offset from base */
+	u32	greg_ipi_vp0;	/* IPI Vector/Priority Registers */
+	u32	greg_ipi_stride; /* IPI Vector/Priority Registers
spacing */
+	u32	greg_spurious;	/* Spurious Vector Register */
+	u32	greg_tfrr;	/* Global Timer Frequency Reporting
Register */
+
+	u32	timer_base;	/* Global Timer Registers base */
+	u32	timer_stride;	/* Global Timer Registers spacing */
+	u32	timer_ccr;	/* Global Timer Current Count Register
*/
+	u32	timer_bcr;	/* Global Timer Base Count Register */
+	u32	timer_vpr;	/* Global Timer Vector/Priority Register
*/
+	u32	timer_dest;	/* Global Timer Destination Register */
+
+	u32	cpu_base;	/* Global Timer Destination Register */
+	u32	cpu_stride;	/* Global Timer Destination Register */
+	u32	cpu_ipi_disp0;	/* IPI 0 Dispatch Command Register */
+	u32	cpu_ipi_disp_stride;	/* IPI Dispatch spacing */
+	u32	cpu_task_pri;	/* Processor Current Task Priority
Register */
+	u32	cpu_whoami;	/* Who Am I Register */
+	u32	cpu_intack;	/* Interrupt Acknowledge Register */
+	u32	cpu_eoi;	/* End of Interrupt Register */
+
+	u32	irq_base;	/* Interrupt registers base */
+	u32	irq_stride;	/* Interrupt registers spacing */
+	u32	irq_vpr;	/* Interrupt Vector/Priority Register */
+	u32	irq_vpr_vector;	/* Interrupt Vector Mask */
+	u32	irq_vpr_polpos;	/* Interrupt Positive Polarity bit */
+	u32	irq_vpr_polneg;	/* Interrupt Negative Polarity bit */
+	u32	irq_vpr_senlvl;	/* Interrupt Level Sense bit */
+	u32	irq_vpr_senedg;	/* Interrupt edge Sense bit */
+	u32	irq_dest;	/* Interrupt Destination Register */
+};
=20
 /* The instance data of a given MPIC */
 struct mpic
@@ -170,6 +259,8 @@ #endif
 	volatile u32 __iomem	*tmregs;
 	volatile u32 __iomem	*cpuregs[MPIC_MAX_CPUS];
 	volatile u32 __iomem	*isus[MPIC_MAX_ISU];
+	/* Pointer to HW info structure */
+	struct mpic_info	*hw_set;
=20
 	/* link */
 	struct mpic		*next;
@@ -188,6 +279,14 @@ #define MPIC_BROKEN_U3
0x00000004
 #define MPIC_BROKEN_IPI			0x00000008
 /* MPIC wants a reset */
 #define MPIC_WANTS_RESET		0x00000010
+/* Spurious vector requires EOI */
+#define MPIC_SPV_EOI			0x00000020
+/* MPIC HW modification ID */
+#define MPIC_MOD_ID_MASK		0x00000f00
+#define MPIC_MOD_ID(val)		(((val) << 8) &
MPIC_MOD_ID_MASK)
+#define MPIC_GET_MOD_ID(flags)		(((flags) & MPIC_MOD_ID_MASK) >>
8)
+#define	MPIC_ID_MPIC		0	/* Original MPIC */
+#define	MPIC_ID_TSI108		1	/* Tsi108/109 PIC */
=20
 /* Allocate the controller structure and setup the linux irq descs
  * for the range if interrupts passed in. No HW initialization is

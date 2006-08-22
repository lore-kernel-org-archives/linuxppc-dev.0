Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 55E8A67BFF
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 20:07:51 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k7MBQXRo025198
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 05:26:33 -0600 (MDT)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k7MA7i2R021990
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 05:07:45 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: [PATCH ] powerpc: Add tsi108/9 and non standard mpic support
Date: Tue, 22 Aug 2006 18:07:43 +0800
Message-ID: <7EA18FDD2DC2154AA3BD6D2F22A62A0E19E353@zch01exm23.fsl.freescale.net>
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

The patch adds new hardware information table for mpic. This=20
enables mpic code to deal with mpic controller with=20
hardware behavior difference.

CONFIG_MPIC_WEIRD is introduced in the code.
If a board with non standard mpic controller,  it can select the
CONFIG_MPIC_WEIRD with board and add its hardware information
in the array mpic_infos.

TSI108/109 PIC takes the first index of weird  hardware information=20
table:) .  The table can be extended. The Tsi108/109 PIC looks like=20
standard OpenPIC but, in fact, is different in registers mapping and
behavior.

The patch does not affect the behavior of standard mpic.
CONFIG_MPIC_WEIRD
excludes the weird mpic code when building standard mpic.
   =20
Signed-off-by: Alexandre Bounine <alexandreb@tundra.com>
Signed-off-by: Roy Zang	<tie-fei.zang@freescale.com>=20

---
 arch/powerpc/Kconfig         |    8 +-
 arch/powerpc/sysdev/Makefile |    1=20
 arch/powerpc/sysdev/mpic.c   |  187
+++++++++++++++++++++++++++++-------------
 include/asm-powerpc/mpic.h   |  114 ++++++++++++++++++++++++++
 4 files changed, 252 insertions(+), 58 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index abb325e..c88b647 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -440,11 +440,15 @@ config U3_DART
 	default n
=20
 config MPIC
-	depends on PPC_PSERIES || PPC_PMAC || PPC_MAPLE || PPC_CHRP \
-			       || MPC7448HPC2
+	depends on PPC_PSERIES || PPC_PMAC || PPC_MAPLE || PPC_CHRP
 	bool
 	default y
=20
+config MPIC_WEIRD
+	depends on MPC7448HPC2
+	bool
+	default y
+=09
 config PPC_RTAS
 	bool
 	default n
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index cebfae2..8ae887b 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -3,6 +3,7 @@ EXTRA_CFLAGS			+=3D -mno-minimal-toc
 endif
=20
 obj-$(CONFIG_MPIC)		+=3D mpic.o
+obj-$(CONFIG_MPIC_WEIRD)	+=3D mpic.o
 obj-$(CONFIG_PPC_INDIRECT_PCI)	+=3D indirect_pci.o
 obj-$(CONFIG_PPC_MPC106)	+=3D grackle.o
 obj-$(CONFIG_BOOKE)		+=3D dcr.o
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 6e0281a..78e0515 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -54,6 +54,55 @@ #define distribute_irqs	(0)
 #endif
 #endif
=20
+#ifdef CONFIG_MPIC_WEIRD
+static u32 mpic_infos[][INDEX_MPIC_WEIRD_END] =3D {
+	[0] =3D {	/* Tsi108/109 PIC */
+		TSI108_GREG_BASE,
+		TSI108_GREG_FEATURE_0,
+		TSI108_GREG_GLOBAL_CONF_0,
+		TSI108_GREG_VENDOR_ID,
+		TSI108_GREG_IPI_VECTOR_PRI_0,
+		TSI108_GREG_IPI_STRIDE,
+		TSI108_GREG_SPURIOUS,
+		TSI108_GREG_TIMER_FREQ,
+
+		TSI108_TIMER_BASE,
+		TSI108_TIMER_STRIDE,
+		TSI108_TIMER_CURRENT_CNT,
+		TSI108_TIMER_BASE_CNT,
+		TSI108_TIMER_VECTOR_PRI,
+		TSI108_TIMER_DESTINATION,
+
+		TSI108_CPU_BASE,
+		TSI108_CPU_STRIDE,
+		TSI108_CPU_IPI_DISPATCH_0,
+		TSI108_CPU_IPI_DISPATCH_STRIDE,
+		TSI108_CPU_CURRENT_TASK_PRI,
+		TSI108_CPU_WHOAMI,
+		TSI108_CPU_INTACK,
+		TSI108_CPU_EOI,
+
+		TSI108_IRQ_BASE,
+		TSI108_IRQ_STRIDE,
+		TSI108_IRQ_VECTOR_PRI,
+		TSI108_VECPRI_VECTOR_MASK,
+		TSI108_VECPRI_POLARITY_POSITIVE,
+		TSI108_VECPRI_POLARITY_NEGATIVE,
+		TSI108_VECPRI_SENSE_LEVEL,
+		TSI108_VECPRI_SENSE_EDGE,
+		TSI108_VECPRI_POLARITY_MASK,
+		TSI108_VECPRI_SENSE_MASK,
+		TSI108_IRQ_DESTINATION
+	},
+};
+#endif
+
+#ifdef CONFIG_MPIC_WEIRD
+#define MPIC_INFO(name) mpic->hw_set[INDEX_##name]
+#else
+#define MPIC_INFO(name) MPIC_##name
+#endif
+
 /*
  * Register accessor functions
  */
@@ -80,7 +129,8 @@ static inline void _mpic_write(unsigned=20
 static inline u32 _mpic_ipi_read(struct mpic *mpic, unsigned int ipi)
 {
 	unsigned int be =3D (mpic->flags & MPIC_BIG_ENDIAN) !=3D 0;
-	unsigned int offset =3D MPIC_GREG_IPI_VECTOR_PRI_0 + (ipi * 0x10);
+	unsigned int offset =3D MPIC_INFO(GREG_IPI_VECTOR_PRI_0) +
+			      (ipi * MPIC_INFO(GREG_IPI_STRIDE));
=20
 	if (mpic->flags & MPIC_BROKEN_IPI)
 		be =3D !be;
@@ -89,7 +139,8 @@ static inline u32 _mpic_ipi_read(struct=20
=20
 static inline void _mpic_ipi_write(struct mpic *mpic, unsigned int ipi,
u32 value)
 {
-	unsigned int offset =3D MPIC_GREG_IPI_VECTOR_PRI_0 + (ipi * 0x10);
+	unsigned int offset =3D MPIC_INFO(GREG_IPI_VECTOR_PRI_0) +
+			      (ipi * MPIC_INFO(GREG_IPI_STRIDE));
=20
 	_mpic_write(mpic->flags & MPIC_BIG_ENDIAN, mpic->gregs, offset,
value);
 }
@@ -120,7 +171,7 @@ static inline u32 _mpic_irq_read(struct=20
 	unsigned int	idx =3D src_no & mpic->isu_mask;
=20
 	return _mpic_read(mpic->flags & MPIC_BIG_ENDIAN,
mpic->isus[isu],
-			  reg + (idx * MPIC_IRQ_STRIDE));
+			  reg + (idx * MPIC_INFO(IRQ_STRIDE)));
 }
=20
 static inline void _mpic_irq_write(struct mpic *mpic, unsigned int
src_no,
@@ -130,7 +181,7 @@ static inline void _mpic_irq_write(struc
 	unsigned int	idx =3D src_no & mpic->isu_mask;
=20
 	_mpic_write(mpic->flags & MPIC_BIG_ENDIAN, mpic->isus[isu],
-		    reg + (idx * MPIC_IRQ_STRIDE), value);
+		    reg + (idx * MPIC_INFO(IRQ_STRIDE)), value);
 }
=20
 #define mpic_read(b,r)		_mpic_read(mpic->flags &
MPIC_BIG_ENDIAN,(b),(r))
@@ -156,8 +207,8 @@ static void __init mpic_test_broken_ipi(
 {
 	u32 r;
=20
-	mpic_write(mpic->gregs, MPIC_GREG_IPI_VECTOR_PRI_0,
MPIC_VECPRI_MASK);
-	r =3D mpic_read(mpic->gregs, MPIC_GREG_IPI_VECTOR_PRI_0);
+	mpic_write(mpic->gregs, MPIC_INFO(GREG_IPI_VECTOR_PRI_0),
MPIC_VECPRI_MASK);
+	r =3D mpic_read(mpic->gregs, MPIC_INFO(GREG_IPI_VECTOR_PRI_0));
=20
 	if (r =3D=3D le32_to_cpu(MPIC_VECPRI_MASK)) {
 		printk(KERN_INFO "mpic: Detected reversed IPI
registers\n");
@@ -394,8 +445,8 @@ static inline struct mpic * mpic_from_ir
 /* Send an EOI */
 static inline void mpic_eoi(struct mpic *mpic)
 {
-	mpic_cpu_write(MPIC_CPU_EOI, 0);
-	(void)mpic_cpu_read(MPIC_CPU_WHOAMI);
+	mpic_cpu_write(MPIC_INFO(CPU_EOI), 0);
+	(void)mpic_cpu_read(MPIC_INFO(CPU_WHOAMI));
 }
=20
 #ifdef CONFIG_SMP
@@ -419,8 +470,8 @@ static void mpic_unmask_irq(unsigned int
=20
 	DBG("%p: %s: enable_irq: %d (src %d)\n", mpic, mpic->name, irq,
src);
=20
-	mpic_irq_write(src, MPIC_IRQ_VECTOR_PRI,
-		       mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) &
+	mpic_irq_write(src, MPIC_INFO(IRQ_VECTOR_PRI),
+		       mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI)) &
 		       ~MPIC_VECPRI_MASK);
 	/* make sure mask gets to controller before we return to user */
 	do {
@@ -428,7 +479,7 @@ static void mpic_unmask_irq(unsigned int
 			printk(KERN_ERR "mpic_enable_irq timeout\n");
 			break;
 		}
-	} while(mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) &
MPIC_VECPRI_MASK);
+	} while(mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI)) &
MPIC_VECPRI_MASK);=09
 }
=20
 static void mpic_mask_irq(unsigned int irq)
@@ -439,8 +490,8 @@ static void mpic_mask_irq(unsigned int i
=20
 	DBG("%s: disable_irq: %d (src %d)\n", mpic->name, irq, src);
=20
-	mpic_irq_write(src, MPIC_IRQ_VECTOR_PRI,
-		       mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) |
+	mpic_irq_write(src, MPIC_INFO(IRQ_VECTOR_PRI),
+		       mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI)) |
 		       MPIC_VECPRI_MASK);
=20
 	/* make sure mask gets to controller before we return to user */
@@ -449,7 +500,7 @@ static void mpic_mask_irq(unsigned int i
 			printk(KERN_ERR "mpic_enable_irq timeout\n");
 			break;
 		}
-	} while(!(mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) &
MPIC_VECPRI_MASK));
+	} while(!(mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI)) &
MPIC_VECPRI_MASK));
 }
=20
 static void mpic_end_irq(unsigned int irq)
@@ -560,24 +611,32 @@ static void mpic_set_affinity(unsigned i
=20
 	cpus_and(tmp, cpumask, cpu_online_map);
=20
-	mpic_irq_write(src, MPIC_IRQ_DESTINATION,
+	mpic_irq_write(src, MPIC_INFO(IRQ_DESTINATION),
 		       mpic_physmask(cpus_addr(tmp)[0]));=09
 }
=20
+#ifdef CONFIG_MPIC_WEIRD
+static unsigned int mpic_type_to_vecpri(struct mpic *mpic, unsigned int
type)
+#else
 static unsigned int mpic_type_to_vecpri(unsigned int type)
+#endif
 {
 	/* Now convert sense value */
 	switch(type & IRQ_TYPE_SENSE_MASK) {
 	case IRQ_TYPE_EDGE_RISING:
-		return MPIC_VECPRI_SENSE_EDGE |
MPIC_VECPRI_POLARITY_POSITIVE;
+		return MPIC_INFO(VECPRI_SENSE_EDGE) |
+		       MPIC_INFO(VECPRI_POLARITY_POSITIVE);
 	case IRQ_TYPE_EDGE_FALLING:
 	case IRQ_TYPE_EDGE_BOTH:
-		return MPIC_VECPRI_SENSE_EDGE |
MPIC_VECPRI_POLARITY_NEGATIVE;
+		return MPIC_INFO(VECPRI_SENSE_EDGE) |
+		       MPIC_INFO(VECPRI_POLARITY_NEGATIVE);
 	case IRQ_TYPE_LEVEL_HIGH:
-		return MPIC_VECPRI_SENSE_LEVEL |
MPIC_VECPRI_POLARITY_POSITIVE;
+		return MPIC_INFO(VECPRI_SENSE_LEVEL) |
+		       MPIC_INFO(VECPRI_POLARITY_POSITIVE);
 	case IRQ_TYPE_LEVEL_LOW:
 	default:
-		return MPIC_VECPRI_SENSE_LEVEL |
MPIC_VECPRI_POLARITY_NEGATIVE;
+		return MPIC_INFO(VECPRI_SENSE_LEVEL) |
+		       MPIC_INFO(VECPRI_POLARITY_NEGATIVE);
 	}
 }
=20
@@ -609,13 +668,18 @@ static int mpic_set_irq_type(unsigned in
 		vecpri =3D MPIC_VECPRI_POLARITY_POSITIVE |
 			MPIC_VECPRI_SENSE_EDGE;
 	else
+#ifdef CONFIG_MPIC_WEIRD
+		vecpri =3D mpic_type_to_vecpri(mpic, flow_type);
+#else
 		vecpri =3D mpic_type_to_vecpri(flow_type);
+#endif=09
=20
-	vold =3D mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI);
-	vnew =3D vold & ~(MPIC_VECPRI_POLARITY_MASK |
MPIC_VECPRI_SENSE_MASK);
+	vold =3D mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI));
+	vnew =3D vold & ~(MPIC_INFO(VECPRI_POLARITY_MASK) |=20
+			MPIC_INFO(VECPRI_SENSE_MASK));
 	vnew |=3D vecpri;
 	if (vold !=3D vnew)
-		mpic_irq_write(src, MPIC_IRQ_VECTOR_PRI, vnew);
+		mpic_irq_write(src, MPIC_INFO(IRQ_VECTOR_PRI), vnew);
=20
 	return 0;
 }
@@ -797,18 +861,23 @@ #endif /* CONFIG_SMP */
 	mpic->isu_size =3D isu_size;
 	mpic->irq_count =3D irq_count;
 	mpic->num_sources =3D 0; /* so far */
+=09
+#ifdef CONFIG_MPIC_WEIRD
+	mpic->hw_set =3D mpic_infos[MPIC_GET_MOD_ID(flags)];
+#endif
=20
 	/* Map the global registers */
-	mpic->gregs =3D ioremap(phys_addr + MPIC_GREG_BASE, 0x1000);
-	mpic->tmregs =3D mpic->gregs + ((MPIC_TIMER_BASE - MPIC_GREG_BASE)
>> 2);
+	mpic->gregs =3D ioremap(phys_addr + MPIC_INFO(GREG_BASE), 0x1000);
+	mpic->tmregs =3D mpic->gregs +
+		       ((MPIC_INFO(TIMER_BASE) - MPIC_INFO(GREG_BASE))
>> 2);
 	BUG_ON(mpic->gregs =3D=3D NULL);
=20
 	/* Reset */
 	if (flags & MPIC_WANTS_RESET) {
-		mpic_write(mpic->gregs, MPIC_GREG_GLOBAL_CONF_0,
-			   mpic_read(mpic->gregs,
MPIC_GREG_GLOBAL_CONF_0)
+		mpic_write(mpic->gregs, MPIC_INFO(GREG_GLOBAL_CONF_0),
+			   mpic_read(mpic->gregs,
MPIC_INFO(GREG_GLOBAL_CONF_0))
 			   | MPIC_GREG_GCONF_RESET);
-		while( mpic_read(mpic->gregs, MPIC_GREG_GLOBAL_CONF_0)
+		while( mpic_read(mpic->gregs,
MPIC_INFO(GREG_GLOBAL_CONF_0))
 		       & MPIC_GREG_GCONF_RESET)
 			mb();
 	}
@@ -817,7 +886,7 @@ #endif /* CONFIG_SMP */
 	 * MPICs, num sources as well. On ISU MPICs, sources are counted
 	 * as ISUs are added
 	 */
-	reg =3D mpic_read(mpic->gregs, MPIC_GREG_FEATURE_0);
+	reg =3D mpic_read(mpic->gregs, MPIC_INFO(GREG_FEATURE_0));
 	mpic->num_cpus =3D ((reg & MPIC_GREG_FEATURE_LAST_CPU_MASK)
 			  >> MPIC_GREG_FEATURE_LAST_CPU_SHIFT) + 1;
 	if (isu_size =3D=3D 0)
@@ -826,16 +895,16 @@ #endif /* CONFIG_SMP */
=20
 	/* Map the per-CPU registers */
 	for (i =3D 0; i < mpic->num_cpus; i++) {
-		mpic->cpuregs[i] =3D ioremap(phys_addr + MPIC_CPU_BASE +
-					   i * MPIC_CPU_STRIDE, 0x1000);
+		mpic->cpuregs[i] =3D ioremap(phys_addr +
MPIC_INFO(CPU_BASE) +
+					   i * MPIC_INFO(CPU_STRIDE),
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
+		mpic->isus[0] =3D ioremap(phys_addr + MPIC_INFO(IRQ_BASE),
+					MPIC_INFO(IRQ_STRIDE) *
mpic->isu_size);
 		BUG_ON(mpic->isus[0] =3D=3D NULL);
 	}
 	mpic->isu_shift =3D 1 + __ilog2(mpic->isu_size - 1);
@@ -879,7 +948,8 @@ void __init mpic_assign_isu(struct mpic=20
=20
 	BUG_ON(isu_num >=3D MPIC_MAX_ISU);
=20
-	mpic->isus[isu_num] =3D ioremap(phys_addr, MPIC_IRQ_STRIDE *
mpic->isu_size);
+	mpic->isus[isu_num] =3D ioremap(phys_addr,
+				      MPIC_INFO(IRQ_STRIDE) *
mpic->isu_size);
 	if ((isu_first + mpic->isu_size) > mpic->num_sources)
 		mpic->num_sources =3D isu_first + mpic->isu_size;
 }
@@ -904,14 +974,16 @@ void __init mpic_init(struct mpic *mpic)
 	printk(KERN_INFO "mpic: Initializing for %d sources\n",
mpic->num_sources);
=20
 	/* Set current processor priority to max */
-	mpic_cpu_write(MPIC_CPU_CURRENT_TASK_PRI, 0xf);
+	mpic_cpu_write(MPIC_INFO(CPU_CURRENT_TASK_PRI), 0xf);
=20
 	/* Initialize timers: just disable them all */
 	for (i =3D 0; i < 4; i++) {
 		mpic_write(mpic->tmregs,
-			   i * MPIC_TIMER_STRIDE +
MPIC_TIMER_DESTINATION, 0);
+			   i * MPIC_INFO(TIMER_STRIDE) +
+			   MPIC_INFO(TIMER_DESTINATION), 0);
 		mpic_write(mpic->tmregs,
-			   i * MPIC_TIMER_STRIDE +
MPIC_TIMER_VECTOR_PRI,
+			   i * MPIC_INFO(TIMER_STRIDE) +=20
+			   MPIC_INFO(TIMER_VECTOR_PRI),
 			   MPIC_VECPRI_MASK |
 			   (MPIC_VEC_TIMER_0 + i));
 	}
@@ -940,21 +1012,23 @@ void __init mpic_init(struct mpic *mpic)
 			(8 << MPIC_VECPRI_PRIORITY_SHIFT);
 	=09
 		/* init hw */
-		mpic_irq_write(i, MPIC_IRQ_VECTOR_PRI, vecpri);
-		mpic_irq_write(i, MPIC_IRQ_DESTINATION,
+		mpic_irq_write(i, MPIC_INFO(IRQ_VECTOR_PRI), vecpri);
+		mpic_irq_write(i, MPIC_INFO(IRQ_DESTINATION),
 			       1 << hard_smp_processor_id());
 	}
 =09
 	/* Init spurrious vector */
-	mpic_write(mpic->gregs, MPIC_GREG_SPURIOUS, MPIC_VEC_SPURRIOUS);
+	mpic_write(mpic->gregs, MPIC_INFO(GREG_SPURIOUS),
MPIC_VEC_SPURRIOUS);
=20
-	/* Disable 8259 passthrough */
-	mpic_write(mpic->gregs, MPIC_GREG_GLOBAL_CONF_0,
-		   mpic_read(mpic->gregs, MPIC_GREG_GLOBAL_CONF_0)
+	/* Disable 8259 passthrough, if supported */
+#ifndef CONFIG_MPIC_WEIRD
+	mpic_write(mpic->gregs, MPIC_INFO(GREG_GLOBAL_CONF_0),
+		   mpic_read(mpic->gregs, MPIC_INFO(GREG_GLOBAL_CONF_0))
 		   | MPIC_GREG_GCONF_8259_PTHROU_DIS);
+#endif
=20
 	/* Set current processor priority to 0 */
-	mpic_cpu_write(MPIC_CPU_CURRENT_TASK_PRI, 0);
+	mpic_cpu_write(MPIC_INFO(CPU_CURRENT_TASK_PRI), 0);
 }
=20
 void __init mpic_set_clk_ratio(struct mpic *mpic, u32 clock_ratio)
@@ -997,9 +1071,9 @@ void mpic_irq_set_priority(unsigned int=20
 		mpic_ipi_write(src - MPIC_VEC_IPI_0,
 			       reg | (pri <<
MPIC_VECPRI_PRIORITY_SHIFT));
 	} else {
-		reg =3D mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI)
+		reg =3D mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI))
 			& ~MPIC_VECPRI_PRIORITY_MASK;
-		mpic_irq_write(src, MPIC_IRQ_VECTOR_PRI,
+		mpic_irq_write(src, MPIC_INFO(IRQ_VECTOR_PRI),
 			       reg | (pri <<
MPIC_VECPRI_PRIORITY_SHIFT));
 	}
 	spin_unlock_irqrestore(&mpic_lock, flags);
@@ -1017,7 +1091,7 @@ unsigned int mpic_irq_get_priority(unsig
 	if (is_ipi)
 		reg =3D mpic_ipi_read(src =3D MPIC_VEC_IPI_0);
 	else
-		reg =3D mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI);
+		reg =3D mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI));
 	spin_unlock_irqrestore(&mpic_lock, flags);
 	return (reg & MPIC_VECPRI_PRIORITY_MASK) >>
MPIC_VECPRI_PRIORITY_SHIFT;
 }
@@ -1043,12 +1117,12 @@ #ifdef CONFIG_SMP
  	 */
 	if (distribute_irqs) {
 	 	for (i =3D 0; i < mpic->num_sources ; i++)
-			mpic_irq_write(i, MPIC_IRQ_DESTINATION,
-				mpic_irq_read(i, MPIC_IRQ_DESTINATION) |
msk);
+			mpic_irq_write(i, MPIC_INFO(IRQ_DESTINATION),
+				mpic_irq_read(i,
MPIC_INFO(IRQ_DESTINATION)) | msk);
 	}
=20
 	/* Set current processor priority to 0 */
-	mpic_cpu_write(MPIC_CPU_CURRENT_TASK_PRI, 0);
+	mpic_cpu_write(MPIC_INFO(CPU_CURRENT_TASK_PRI), 0);
=20
 	spin_unlock_irqrestore(&mpic_lock, flags);
 #endif /* CONFIG_SMP */
@@ -1058,7 +1132,7 @@ int mpic_cpu_get_priority(void)
 {
 	struct mpic *mpic =3D mpic_primary;
=20
-	return mpic_cpu_read(MPIC_CPU_CURRENT_TASK_PRI);
+	return mpic_cpu_read(MPIC_INFO(CPU_CURRENT_TASK_PRI));
 }
=20
 void mpic_cpu_set_priority(int prio)
@@ -1066,7 +1140,7 @@ void mpic_cpu_set_priority(int prio)
 	struct mpic *mpic =3D mpic_primary;
=20
 	prio &=3D MPIC_CPU_TASKPRI_MASK;
-	mpic_cpu_write(MPIC_CPU_CURRENT_TASK_PRI, prio);
+	mpic_cpu_write(MPIC_INFO(CPU_CURRENT_TASK_PRI), prio);
 }
=20
 /*
@@ -1088,11 +1162,11 @@ void mpic_teardown_this_cpu(int secondar
=20
 	/* let the mpic know we don't want intrs.  */
 	for (i =3D 0; i < mpic->num_sources ; i++)
-		mpic_irq_write(i, MPIC_IRQ_DESTINATION,
-			mpic_irq_read(i, MPIC_IRQ_DESTINATION) & ~msk);
+		mpic_irq_write(i, MPIC_INFO(IRQ_DESTINATION),
+			mpic_irq_read(i, MPIC_INFO(IRQ_DESTINATION)) &
~msk);
=20
 	/* Set current processor priority to max */
-	mpic_cpu_write(MPIC_CPU_CURRENT_TASK_PRI, 0xf);
+	mpic_cpu_write(MPIC_INFO(CPU_CURRENT_TASK_PRI), 0xf);
=20
 	spin_unlock_irqrestore(&mpic_lock, flags);
 }
@@ -1108,7 +1182,8 @@ #ifdef DEBUG_IPI
 	DBG("%s: send_ipi(ipi_no: %d)\n", mpic->name, ipi_no);
 #endif
=20
-	mpic_cpu_write(MPIC_CPU_IPI_DISPATCH_0 + ipi_no * 0x10,
+	mpic_cpu_write(MPIC_INFO(CPU_IPI_DISPATCH_0) +
+		       ipi_no * MPIC_INFO(CPU_IPI_DISPATCH_STRIDE),
 		       mpic_physmask(cpu_mask &
cpus_addr(cpu_online_map)[0]));
 }
=20
@@ -1116,7 +1191,7 @@ unsigned int mpic_get_one_irq(struct mpi
 {
 	u32 src;
=20
-	src =3D mpic_cpu_read(MPIC_CPU_INTACK) & MPIC_VECPRI_VECTOR_MASK;
+	src =3D mpic_cpu_read(MPIC_INFO(CPU_INTACK)) &
MPIC_INFO(VECPRI_VECTOR_MASK);
 #ifdef DEBUG_LOW
 	DBG("%s: get_one_irq(): %d\n", mpic->name, src);
 #endif
diff --git a/include/asm-powerpc/mpic.h b/include/asm-powerpc/mpic.h
index eb241c9..faebdf2 100644
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
@@ -114,6 +116,103 @@ #define MPIC_VEC_TIMER_2	249
 #define MPIC_VEC_TIMER_1	248
 #define MPIC_VEC_TIMER_0	247
=20
+#ifdef CONFIG_MPIC_WEIRD
+/*
+ * Tsi108 implementation of MPIC has many differences from the original
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
+#define TSI108_CPU_WHOAMI		0xffffffff
+#define TSI108_CPU_INTACK		0x00004
+#define TSI108_CPU_EOI			0x00008
+
+/*
+ * Per-source registers
+ */
+#define TSI108_IRQ_BASE			0x00100
+#define TSI108_IRQ_STRIDE		0x00008
+#define TSI108_IRQ_VECTOR_PRI		0x00000
+#define TSI108_VECPRI_VECTOR_MASK	0x000000ff
+#define TSI108_VECPRI_POLARITY_POSITIVE	0x01000000
+#define TSI108_VECPRI_POLARITY_NEGATIVE	0x00000000
+#define TSI108_VECPRI_SENSE_LEVEL	0x02000000
+#define TSI108_VECPRI_SENSE_EDGE	0x00000000
+#define TSI108_VECPRI_POLARITY_MASK	0x01000000
+#define TSI108_VECPRI_SENSE_MASK	0x02000000
+#define TSI108_IRQ_DESTINATION		0x00004
+
+/* weird mpic variable index in the HW info array */
+enum MPIC_WEIRD_INDEX {
+	INDEX_GREG_BASE =3D 0,	/* Offset of global registers from MPIC
base */
+	INDEX_GREG_FEATURE_0,	/* FRR0 offset from base */
+	INDEX_GREG_GLOBAL_CONF_0, /* Global Config register offset from
base */
+	INDEX_GREG_VENDOR_ID,	/* VID register offset from base */
+	INDEX_GREG_IPI_VECTOR_PRI_0,	/* IPI Vector/Priority Registers
*/
+	INDEX_GREG_IPI_STRIDE, 		/* IPI Vector/Priority Registers
spacing */
+	INDEX_GREG_SPURIOUS,		/* Spurious Vector Register */
+	INDEX_GREG_TIMER_FREQ,	/* Global Timer Frequency Reporting
Register */
+
+	INDEX_TIMER_BASE,		/* Global Timer Registers base
*/
+	INDEX_TIMER_STRIDE,		/* Global Timer Registers
spacing */
+	INDEX_TIMER_CURRENT_CNT,	/* Global Timer Current Count
Register */
+	INDEX_TIMER_BASE_CNT,		/* Global Timer Base Count
Register */
+	INDEX_TIMER_VECTOR_PRI,		/* Global Timer Vector/Priority
Register */
+	INDEX_TIMER_DESTINATION,	/* Global Timer Destination
Register */
+
+	INDEX_CPU_BASE,	/* Offset of cpu base */
+	INDEX_CPU_STRIDE,	/* Cpu register spacing*/
+	INDEX_CPU_IPI_DISPATCH_0,	/* IPI 0 Dispatch Command
Register */
+	INDEX_CPU_IPI_DISPATCH_STRIDE,	/* IPI Dispatch spacing */
+	INDEX_CPU_CURRENT_TASK_PRI,/* Processor Current Task Priority
Register */
+	INDEX_CPU_WHOAMI,	/* Who Am I Register */
+	INDEX_CPU_INTACK,	/* Interrupt Acknowledge Register */
+	INDEX_CPU_EOI,		/* End of Interrupt Register */
+
+	INDEX_IRQ_BASE,	/* Interrupt registers base */
+	INDEX_IRQ_STRIDE,	/* Interrupt registers spacing */
+	INDEX_IRQ_VECTOR_PRI,	/* Interrupt Vector/Priority Register */
+	INDEX_VECPRI_VECTOR_MASK,	/* Interrupt Vector Mask */
+	INDEX_VECPRI_POLARITY_POSITIVE,	/* Interrupt Positive Polarity
bit */
+	INDEX_VECPRI_POLARITY_NEGATIVE,	/* Interrupt Negative Polarity
bit */
+	INDEX_VECPRI_SENSE_LEVEL,	/* Interrupt Level Sense bit */
+	INDEX_VECPRI_SENSE_EDGE,	/* Interrupt edge Sense bit */
+	INDEX_VECPRI_POLARITY_MASK, /* Interrupt Polarity mask */
+	INDEX_VECPRI_SENSE_MASK, /* Interrupt sense mask */
+	INDEX_IRQ_DESTINATION,	/* Interrupt Destination Register */
+	INDEX_MPIC_WEIRD_END	/* Size of the hw info array */
+};
+#endif
+
 #ifdef CONFIG_MPIC_BROKEN_U3
 /* Fixup table entry */
 struct mpic_irq_fixup
@@ -170,6 +269,11 @@ #endif
 	volatile u32 __iomem	*tmregs;
 	volatile u32 __iomem	*cpuregs[MPIC_MAX_CPUS];
 	volatile u32 __iomem	*isus[MPIC_MAX_ISU];
+=09
+#ifdef CONFIG_MPIC_WEIRD
+	/* Pointer to HW info array */
+	u32	*hw_set;
+#endif
=20
 	/* link */
 	struct mpic		*next;
@@ -189,6 +293,16 @@ #define MPIC_BROKEN_IPI
0x00000008
 /* MPIC wants a reset */
 #define MPIC_WANTS_RESET		0x00000010
=20
+#ifdef CONFIG_MPIC_WEIRD
+/* Spurious vector requires EOI */
+#define MPIC_SPV_EOI			0x00000020
+/* MPIC HW modification ID */
+#define MPIC_MOD_ID_MASK		0x00000f00
+#define MPIC_MOD_ID(val)		(((val) << 8) &
MPIC_MOD_ID_MASK)
+#define MPIC_GET_MOD_ID(flags)		(((flags) & MPIC_MOD_ID_MASK) >>
8)
+#define	MPIC_ID_TSI108		0	/* Tsi108/109 PIC */
+#endif
+
 /* Allocate the controller structure and setup the linux irq descs
  * for the range if interrupts passed in. No HW initialization is
  * actually performed.
--=20
1.4.0

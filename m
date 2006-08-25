Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9715D67BAB
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Aug 2006 14:16:52 +1000 (EST)
Subject: [PATCH] powerpc: Support for "weird" MPICs and fixup mpc7448_hpc2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Content-Type: text/plain
Date: Fri, 25 Aug 2006 14:16:30 +1000
Message-Id: <1156479390.8433.293.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch is a slightly cleaned up version of Zang Roy's support for
the TSI108 MPIC variant. It also fixes up MPC7448_hpc2 to use the new
version of the type macros and changes the way MPIC is selected in
Kconfig to better match what is done for other system devices.

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com> 
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Zang Roy, please verify that it still works for you. I've tested it on
an Apple G5 with and without CONFIG_MPIC_WEIRD .

>From tie-fei.zang@freescale.com Thu Aug 24 05:04:51 2006
Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by gate.crashing.org (8.12.8/8.12.8) with ESMTP id
	k7OA4mAu020592 for <benh@kernel.crashing.org>; Thu, 24 Aug 2006 05:04:51
	-0500
Received: from de01smr01.freescale.net (de01smr01.freescale.net
	[10.208.0.31]) by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k7OBBP81018127 for <benh@kernel.crashing.org>; Thu, 24 Aug 2006 05:11:25
	-0600 (MDT)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207]) by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	k7O9qXun020289 for <benh@kernel.crashing.org>; Thu, 24 Aug 2006 04:52:34
	-0500 (CDT)
Received: from [10.193.20.86] ([10.193.20.86]) by
	zch01exm23.fsl.freescale.net with Microsoft SMTPSVC(6.0.3790.2499); Thu, 24
	Aug 2006 17:52:32 +0800
Subject: Re: [PATCH ] powerpc: Add tsi108/9 and non standard mpic support
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
In-Reply-To: <1156398861.8433.197.camel@localhost.localdomain>
References:
	 <7EA18FDD2DC2154AA3BD6D2F22A62A0E19E353@zch01exm23.fsl.freescale.net>
	 <1156398135.5913.43.camel@localhost.localdomain>
	 <1156398861.8433.197.camel@localhost.localdomain>
Content-Type: text/plain
Organization: 
Message-Id: <1156413135.6591.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 24 Aug 2006 17:52:15 +0800
X-OriginalArrivalTime: 24 Aug 2006 09:52:32.0621 (UTC)
	FILETIME=[04FFF1D0:01C6C763]
X-Spam-Checker-Version: SpamAssassin 3.0.1 (2004-10-22) on gate.crashing.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0
	tests=AWL,BAYES_00,UPPERCASE_25_50  autolearn=no version=3.0.1
Status:   
X-Evolution-Source: pop://benh@localhost:10110/
Content-Transfer-Encoding: 8bit

On Thu, 2006-08-24 at 13:54, Benjamin Herrenschmidt wrote:
> On Thu, 2006-08-24 at 13:42 +0800, Zang Roy-r61911 wrote:
> > On Tue, 2006-08-22 at 18:07, Zang Roy-r61911 wrote:
> > > The patch adds new hardware information table for mpic. This 
> > > enables mpic code to deal with mpic controller with 
> > > hardware behavior difference.
> > > 
> > > CONFIG_MPIC_WEIRD is introduced in the code.
> > > If a board with non standard mpic controller,  it can select the
> > > CONFIG_MPIC_WEIRD with board and add its hardware information
> > > in the array mpic_infos.
> > > 
> > > TSI108/109 PIC takes the first index of weird  hardware
> information 
> > > table:) .  The table can be extended. The Tsi108/109 PIC looks
> like 
> > > standard OpenPIC but, in fact, is different in registers mapping
> and
> > > behavior.
> 
> The table should still contain the entries for a normal MPIC. One can
> build a kernel that will boot both machines with the "weird" one and
> with the normal one. Thus CONFIG_MPIC_WEIRD shall not exclude normal
> MPICs, though not having it does exclude weird ones. I thus would
> suggest to keep the table as it was in your earlier patches, that is
> with the normal MPIC mapping at 0.
> 
> I intend to re-use that to handle another weird MPIC from some other
> project :)

That is also my target. I hope the imported mpic_info table can support
more non-standard mpic structure.
The following patch adds the standard MPIC entry to the table. 
I post it here.


Signed-off-by: Roy Zang     <tie-fei.zang@freescale.com> 

Index: linux-work/arch/powerpc/Kconfig
===================================================================
--- linux-work.orig/arch/powerpc/Kconfig	2006-08-17 09:26:19.000000000 +1000
+++ linux-work/arch/powerpc/Kconfig	2006-08-25 14:00:10.000000000 +1000
@@ -354,6 +354,7 @@ endchoice
 config PPC_PSERIES
 	depends on PPC_MULTIPLATFORM && PPC64
 	bool "IBM pSeries & new (POWER5-based) iSeries"
+	select MPIC
 	select PPC_I8259
 	select PPC_RTAS
 	select RTAS_ERROR_LOGGING
@@ -363,6 +364,7 @@ config PPC_PSERIES
 config PPC_CHRP
 	bool "Common Hardware Reference Platform (CHRP) based machines"
 	depends on PPC_MULTIPLATFORM && PPC32
+	select MPIC
 	select PPC_I8259
 	select PPC_INDIRECT_PCI
 	select PPC_RTAS
@@ -373,6 +375,7 @@ config PPC_CHRP
 config PPC_PMAC
 	bool "Apple PowerMac based machines"
 	depends on PPC_MULTIPLATFORM
+	select MPIC
 	select PPC_INDIRECT_PCI if PPC32
 	select PPC_MPC106 if PPC32
 	default y
@@ -380,6 +383,7 @@ config PPC_PMAC
 config PPC_PMAC64
 	bool
 	depends on PPC_PMAC && POWER4
+	select MPIC
 	select U3_DART
 	select MPIC_BROKEN_U3
 	select GENERIC_TBSYNC
@@ -389,6 +393,7 @@ config PPC_PMAC64
 config PPC_PREP
 	bool "PowerPC Reference Platform (PReP) based machines"
 	depends on PPC_MULTIPLATFORM && PPC32 && BROKEN
+	select MPIC
 	select PPC_I8259
 	select PPC_INDIRECT_PCI
 	select PPC_UDBG_16550
@@ -397,6 +402,7 @@ config PPC_PREP
 config PPC_MAPLE
 	depends on PPC_MULTIPLATFORM && PPC64
 	bool "Maple 970FX Evaluation Board"
+	select MPIC
 	select U3_DART
 	select MPIC_BROKEN_U3
 	select GENERIC_TBSYNC
@@ -439,12 +445,6 @@ config U3_DART
 	depends on PPC_MULTIPLATFORM && PPC64
 	default n
 
-config MPIC
-	depends on PPC_PSERIES || PPC_PMAC || PPC_MAPLE || PPC_CHRP \
-			       || MPC7448HPC2
-	bool
-	default y
-
 config PPC_RTAS
 	bool
 	default n
@@ -812,6 +812,14 @@ config GENERIC_ISA_DMA
 	depends on PPC64 || POWER4 || 6xx && !CPM2
 	default y
 
+config MPIC
+	bool
+	default n
+
+config MPIC_WEIRD
+	bool
+	default n
+
 config PPC_I8259
 	bool
 	default n
Index: linux-work/arch/powerpc/sysdev/mpic.c
===================================================================
--- linux-work.orig/arch/powerpc/sysdev/mpic.c	2006-08-17 09:26:19.000000000 +1000
+++ linux-work/arch/powerpc/sysdev/mpic.c	2006-08-25 13:46:53.000000000 +1000
@@ -54,6 +54,94 @@ static DEFINE_SPINLOCK(mpic_lock);
 #endif
 #endif
 
+#ifdef CONFIG_MPIC_WEIRD
+static u32 mpic_infos[][MPIC_IDX_END] = {
+	[0] = {	/* Original OpenPIC compatible MPIC */
+		MPIC_GREG_BASE,
+		MPIC_GREG_FEATURE_0,
+		MPIC_GREG_GLOBAL_CONF_0,
+		MPIC_GREG_VENDOR_ID,
+		MPIC_GREG_IPI_VECTOR_PRI_0,
+		MPIC_GREG_IPI_STRIDE,
+		MPIC_GREG_SPURIOUS,
+		MPIC_GREG_TIMER_FREQ,
+
+		MPIC_TIMER_BASE,
+		MPIC_TIMER_STRIDE,
+		MPIC_TIMER_CURRENT_CNT,
+		MPIC_TIMER_BASE_CNT,
+		MPIC_TIMER_VECTOR_PRI,
+		MPIC_TIMER_DESTINATION,
+
+		MPIC_CPU_BASE,
+		MPIC_CPU_STRIDE,
+		MPIC_CPU_IPI_DISPATCH_0,
+		MPIC_CPU_IPI_DISPATCH_STRIDE,
+		MPIC_CPU_CURRENT_TASK_PRI,
+		MPIC_CPU_WHOAMI,
+		MPIC_CPU_INTACK,
+		MPIC_CPU_EOI,
+
+		MPIC_IRQ_BASE,
+		MPIC_IRQ_STRIDE,
+		MPIC_IRQ_VECTOR_PRI,
+		MPIC_VECPRI_VECTOR_MASK,
+		MPIC_VECPRI_POLARITY_POSITIVE,
+		MPIC_VECPRI_POLARITY_NEGATIVE,
+		MPIC_VECPRI_SENSE_LEVEL,
+		MPIC_VECPRI_SENSE_EDGE,
+		MPIC_VECPRI_POLARITY_MASK,
+		MPIC_VECPRI_SENSE_MASK,
+		MPIC_IRQ_DESTINATION
+	},
+	[1] = {	/* Tsi108/109 PIC */
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
+
+#define MPIC_INFO(name) mpic->hw_set[MPIC_IDX_##name]
+
+#else /* CONFIG_MPIC_WEIRD */
+
+#define MPIC_INFO(name) MPIC_##name
+
+#endif /* CONFIG_MPIC_WEIRD */
+
 /*
  * Register accessor functions
  */
@@ -80,7 +168,8 @@ static inline void _mpic_write(unsigned 
 static inline u32 _mpic_ipi_read(struct mpic *mpic, unsigned int ipi)
 {
 	unsigned int be = (mpic->flags & MPIC_BIG_ENDIAN) != 0;
-	unsigned int offset = MPIC_GREG_IPI_VECTOR_PRI_0 + (ipi * 0x10);
+	unsigned int offset = MPIC_INFO(GREG_IPI_VECTOR_PRI_0) +
+			      (ipi * MPIC_INFO(GREG_IPI_STRIDE));
 
 	if (mpic->flags & MPIC_BROKEN_IPI)
 		be = !be;
@@ -89,7 +178,8 @@ static inline u32 _mpic_ipi_read(struct 
 
 static inline void _mpic_ipi_write(struct mpic *mpic, unsigned int ipi, u32 value)
 {
-	unsigned int offset = MPIC_GREG_IPI_VECTOR_PRI_0 + (ipi * 0x10);
+	unsigned int offset = MPIC_INFO(GREG_IPI_VECTOR_PRI_0) +
+			      (ipi * MPIC_INFO(GREG_IPI_STRIDE));
 
 	_mpic_write(mpic->flags & MPIC_BIG_ENDIAN, mpic->gregs, offset, value);
 }
@@ -120,7 +210,7 @@ static inline u32 _mpic_irq_read(struct 
 	unsigned int	idx = src_no & mpic->isu_mask;
 
 	return _mpic_read(mpic->flags & MPIC_BIG_ENDIAN, mpic->isus[isu],
-			  reg + (idx * MPIC_IRQ_STRIDE));
+			  reg + (idx * MPIC_INFO(IRQ_STRIDE)));
 }
 
 static inline void _mpic_irq_write(struct mpic *mpic, unsigned int src_no,
@@ -130,7 +220,7 @@ static inline void _mpic_irq_write(struc
 	unsigned int	idx = src_no & mpic->isu_mask;
 
 	_mpic_write(mpic->flags & MPIC_BIG_ENDIAN, mpic->isus[isu],
-		    reg + (idx * MPIC_IRQ_STRIDE), value);
+		    reg + (idx * MPIC_INFO(IRQ_STRIDE)), value);
 }
 
 #define mpic_read(b,r)		_mpic_read(mpic->flags & MPIC_BIG_ENDIAN,(b),(r))
@@ -156,8 +246,8 @@ static void __init mpic_test_broken_ipi(
 {
 	u32 r;
 
-	mpic_write(mpic->gregs, MPIC_GREG_IPI_VECTOR_PRI_0, MPIC_VECPRI_MASK);
-	r = mpic_read(mpic->gregs, MPIC_GREG_IPI_VECTOR_PRI_0);
+	mpic_write(mpic->gregs, MPIC_INFO(GREG_IPI_VECTOR_PRI_0), MPIC_VECPRI_MASK);
+	r = mpic_read(mpic->gregs, MPIC_INFO(GREG_IPI_VECTOR_PRI_0));
 
 	if (r == le32_to_cpu(MPIC_VECPRI_MASK)) {
 		printk(KERN_INFO "mpic: Detected reversed IPI registers\n");
@@ -394,8 +484,8 @@ static inline struct mpic * mpic_from_ir
 /* Send an EOI */
 static inline void mpic_eoi(struct mpic *mpic)
 {
-	mpic_cpu_write(MPIC_CPU_EOI, 0);
-	(void)mpic_cpu_read(MPIC_CPU_WHOAMI);
+	mpic_cpu_write(MPIC_INFO(CPU_EOI), 0);
+	(void)mpic_cpu_read(MPIC_INFO(CPU_WHOAMI));
 }
 
 #ifdef CONFIG_SMP
@@ -419,8 +509,8 @@ static void mpic_unmask_irq(unsigned int
 
 	DBG("%p: %s: enable_irq: %d (src %d)\n", mpic, mpic->name, irq, src);
 
-	mpic_irq_write(src, MPIC_IRQ_VECTOR_PRI,
-		       mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) &
+	mpic_irq_write(src, MPIC_INFO(IRQ_VECTOR_PRI),
+		       mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI)) &
 		       ~MPIC_VECPRI_MASK);
 	/* make sure mask gets to controller before we return to user */
 	do {
@@ -428,7 +518,7 @@ static void mpic_unmask_irq(unsigned int
 			printk(KERN_ERR "mpic_enable_irq timeout\n");
 			break;
 		}
-	} while(mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) & MPIC_VECPRI_MASK);
+	} while(mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI)) & MPIC_VECPRI_MASK);
 }
 
 static void mpic_mask_irq(unsigned int irq)
@@ -439,8 +529,8 @@ static void mpic_mask_irq(unsigned int i
 
 	DBG("%s: disable_irq: %d (src %d)\n", mpic->name, irq, src);
 
-	mpic_irq_write(src, MPIC_IRQ_VECTOR_PRI,
-		       mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) |
+	mpic_irq_write(src, MPIC_INFO(IRQ_VECTOR_PRI),
+		       mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI)) |
 		       MPIC_VECPRI_MASK);
 
 	/* make sure mask gets to controller before we return to user */
@@ -449,7 +539,7 @@ static void mpic_mask_irq(unsigned int i
 			printk(KERN_ERR "mpic_enable_irq timeout\n");
 			break;
 		}
-	} while(!(mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) & MPIC_VECPRI_MASK));
+	} while(!(mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI)) & MPIC_VECPRI_MASK));
 }
 
 static void mpic_end_irq(unsigned int irq)
@@ -560,24 +650,28 @@ static void mpic_set_affinity(unsigned i
 
 	cpus_and(tmp, cpumask, cpu_online_map);
 
-	mpic_irq_write(src, MPIC_IRQ_DESTINATION,
+	mpic_irq_write(src, MPIC_INFO(IRQ_DESTINATION),
 		       mpic_physmask(cpus_addr(tmp)[0]));	
 }
 
-static unsigned int mpic_type_to_vecpri(unsigned int type)
+static unsigned int mpic_type_to_vecpri(struct mpic *mpic, unsigned int type)
 {
 	/* Now convert sense value */
 	switch(type & IRQ_TYPE_SENSE_MASK) {
 	case IRQ_TYPE_EDGE_RISING:
-		return MPIC_VECPRI_SENSE_EDGE | MPIC_VECPRI_POLARITY_POSITIVE;
+		return MPIC_INFO(VECPRI_SENSE_EDGE) |
+		       MPIC_INFO(VECPRI_POLARITY_POSITIVE);
 	case IRQ_TYPE_EDGE_FALLING:
 	case IRQ_TYPE_EDGE_BOTH:
-		return MPIC_VECPRI_SENSE_EDGE | MPIC_VECPRI_POLARITY_NEGATIVE;
+		return MPIC_INFO(VECPRI_SENSE_EDGE) |
+		       MPIC_INFO(VECPRI_POLARITY_NEGATIVE);
 	case IRQ_TYPE_LEVEL_HIGH:
-		return MPIC_VECPRI_SENSE_LEVEL | MPIC_VECPRI_POLARITY_POSITIVE;
+		return MPIC_INFO(VECPRI_SENSE_LEVEL) |
+		       MPIC_INFO(VECPRI_POLARITY_POSITIVE);
 	case IRQ_TYPE_LEVEL_LOW:
 	default:
-		return MPIC_VECPRI_SENSE_LEVEL | MPIC_VECPRI_POLARITY_NEGATIVE;
+		return MPIC_INFO(VECPRI_SENSE_LEVEL) |
+		       MPIC_INFO(VECPRI_POLARITY_NEGATIVE);
 	}
 }
 
@@ -609,13 +703,14 @@ static int mpic_set_irq_type(unsigned in
 		vecpri = MPIC_VECPRI_POLARITY_POSITIVE |
 			MPIC_VECPRI_SENSE_EDGE;
 	else
-		vecpri = mpic_type_to_vecpri(flow_type);
+		vecpri = mpic_type_to_vecpri(mpic, flow_type);
 
-	vold = mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI);
-	vnew = vold & ~(MPIC_VECPRI_POLARITY_MASK | MPIC_VECPRI_SENSE_MASK);
+	vold = mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI));
+	vnew = vold & ~(MPIC_INFO(VECPRI_POLARITY_MASK) |
+			MPIC_INFO(VECPRI_SENSE_MASK));
 	vnew |= vecpri;
 	if (vold != vnew)
-		mpic_irq_write(src, MPIC_IRQ_VECTOR_PRI, vnew);
+		mpic_irq_write(src, MPIC_INFO(IRQ_VECTOR_PRI), vnew);
 
 	return 0;
 }
@@ -798,17 +893,22 @@ struct mpic * __init mpic_alloc(struct d
 	mpic->irq_count = irq_count;
 	mpic->num_sources = 0; /* so far */
 
+#ifdef CONFIG_MPIC_WEIRD
+	mpic->hw_set = mpic_infos[MPIC_GET_REGSET(flags)];
+#endif
+
 	/* Map the global registers */
-	mpic->gregs = ioremap(phys_addr + MPIC_GREG_BASE, 0x1000);
-	mpic->tmregs = mpic->gregs + ((MPIC_TIMER_BASE - MPIC_GREG_BASE) >> 2);
+	mpic->gregs = ioremap(phys_addr + MPIC_INFO(GREG_BASE), 0x1000);
+	mpic->tmregs = mpic->gregs +
+		       ((MPIC_INFO(TIMER_BASE) - MPIC_INFO(GREG_BASE)) >> 2);
 	BUG_ON(mpic->gregs == NULL);
 
 	/* Reset */
 	if (flags & MPIC_WANTS_RESET) {
-		mpic_write(mpic->gregs, MPIC_GREG_GLOBAL_CONF_0,
-			   mpic_read(mpic->gregs, MPIC_GREG_GLOBAL_CONF_0)
+		mpic_write(mpic->gregs, MPIC_INFO(GREG_GLOBAL_CONF_0),
+			   mpic_read(mpic->gregs, MPIC_INFO(GREG_GLOBAL_CONF_0))
 			   | MPIC_GREG_GCONF_RESET);
-		while( mpic_read(mpic->gregs, MPIC_GREG_GLOBAL_CONF_0)
+		while( mpic_read(mpic->gregs, MPIC_INFO(GREG_GLOBAL_CONF_0))
 		       & MPIC_GREG_GCONF_RESET)
 			mb();
 	}
@@ -817,7 +917,7 @@ struct mpic * __init mpic_alloc(struct d
 	 * MPICs, num sources as well. On ISU MPICs, sources are counted
 	 * as ISUs are added
 	 */
-	reg = mpic_read(mpic->gregs, MPIC_GREG_FEATURE_0);
+	reg = mpic_read(mpic->gregs, MPIC_INFO(GREG_FEATURE_0));
 	mpic->num_cpus = ((reg & MPIC_GREG_FEATURE_LAST_CPU_MASK)
 			  >> MPIC_GREG_FEATURE_LAST_CPU_SHIFT) + 1;
 	if (isu_size == 0)
@@ -826,16 +926,16 @@ struct mpic * __init mpic_alloc(struct d
 
 	/* Map the per-CPU registers */
 	for (i = 0; i < mpic->num_cpus; i++) {
-		mpic->cpuregs[i] = ioremap(phys_addr + MPIC_CPU_BASE +
-					   i * MPIC_CPU_STRIDE, 0x1000);
+		mpic->cpuregs[i] = ioremap(phys_addr + MPIC_INFO(CPU_BASE) +
+					   i * MPIC_INFO(CPU_STRIDE), 0x1000);
 		BUG_ON(mpic->cpuregs[i] == NULL);
 	}
 
 	/* Initialize main ISU if none provided */
 	if (mpic->isu_size == 0) {
 		mpic->isu_size = mpic->num_sources;
-		mpic->isus[0] = ioremap(phys_addr + MPIC_IRQ_BASE,
-					MPIC_IRQ_STRIDE * mpic->isu_size);
+		mpic->isus[0] = ioremap(phys_addr + MPIC_INFO(IRQ_BASE),
+					MPIC_INFO(IRQ_STRIDE) * mpic->isu_size);
 		BUG_ON(mpic->isus[0] == NULL);
 	}
 	mpic->isu_shift = 1 + __ilog2(mpic->isu_size - 1);
@@ -879,7 +979,8 @@ void __init mpic_assign_isu(struct mpic 
 
 	BUG_ON(isu_num >= MPIC_MAX_ISU);
 
-	mpic->isus[isu_num] = ioremap(phys_addr, MPIC_IRQ_STRIDE * mpic->isu_size);
+	mpic->isus[isu_num] = ioremap(phys_addr,
+				      MPIC_INFO(IRQ_STRIDE) * mpic->isu_size);
 	if ((isu_first + mpic->isu_size) > mpic->num_sources)
 		mpic->num_sources = isu_first + mpic->isu_size;
 }
@@ -904,14 +1005,16 @@ void __init mpic_init(struct mpic *mpic)
 	printk(KERN_INFO "mpic: Initializing for %d sources\n", mpic->num_sources);
 
 	/* Set current processor priority to max */
-	mpic_cpu_write(MPIC_CPU_CURRENT_TASK_PRI, 0xf);
+	mpic_cpu_write(MPIC_INFO(CPU_CURRENT_TASK_PRI), 0xf);
 
 	/* Initialize timers: just disable them all */
 	for (i = 0; i < 4; i++) {
 		mpic_write(mpic->tmregs,
-			   i * MPIC_TIMER_STRIDE + MPIC_TIMER_DESTINATION, 0);
+			   i * MPIC_INFO(TIMER_STRIDE) +
+			   MPIC_INFO(TIMER_DESTINATION), 0);
 		mpic_write(mpic->tmregs,
-			   i * MPIC_TIMER_STRIDE + MPIC_TIMER_VECTOR_PRI,
+			   i * MPIC_INFO(TIMER_STRIDE) +
+			   MPIC_INFO(TIMER_VECTOR_PRI),
 			   MPIC_VECPRI_MASK |
 			   (MPIC_VEC_TIMER_0 + i));
 	}
@@ -940,21 +1043,22 @@ void __init mpic_init(struct mpic *mpic)
 			(8 << MPIC_VECPRI_PRIORITY_SHIFT);
 		
 		/* init hw */
-		mpic_irq_write(i, MPIC_IRQ_VECTOR_PRI, vecpri);
-		mpic_irq_write(i, MPIC_IRQ_DESTINATION,
+		mpic_irq_write(i, MPIC_INFO(IRQ_VECTOR_PRI), vecpri);
+		mpic_irq_write(i, MPIC_INFO(IRQ_DESTINATION),
 			       1 << hard_smp_processor_id());
 	}
 	
 	/* Init spurrious vector */
-	mpic_write(mpic->gregs, MPIC_GREG_SPURIOUS, MPIC_VEC_SPURRIOUS);
+	mpic_write(mpic->gregs, MPIC_INFO(GREG_SPURIOUS), MPIC_VEC_SPURRIOUS);
 
-	/* Disable 8259 passthrough */
-	mpic_write(mpic->gregs, MPIC_GREG_GLOBAL_CONF_0,
-		   mpic_read(mpic->gregs, MPIC_GREG_GLOBAL_CONF_0)
-		   | MPIC_GREG_GCONF_8259_PTHROU_DIS);
+	/* Disable 8259 passthrough, if supported */
+	if (!(mpic->flags & MPIC_NO_PTHROU_DIS))
+		mpic_write(mpic->gregs, MPIC_INFO(GREG_GLOBAL_CONF_0),
+			   mpic_read(mpic->gregs, MPIC_INFO(GREG_GLOBAL_CONF_0))
+			   | MPIC_GREG_GCONF_8259_PTHROU_DIS);
 
 	/* Set current processor priority to 0 */
-	mpic_cpu_write(MPIC_CPU_CURRENT_TASK_PRI, 0);
+	mpic_cpu_write(MPIC_INFO(CPU_CURRENT_TASK_PRI), 0);
 }
 
 void __init mpic_set_clk_ratio(struct mpic *mpic, u32 clock_ratio)
@@ -997,9 +1101,9 @@ void mpic_irq_set_priority(unsigned int 
 		mpic_ipi_write(src - MPIC_VEC_IPI_0,
 			       reg | (pri << MPIC_VECPRI_PRIORITY_SHIFT));
 	} else {
-		reg = mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI)
+		reg = mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI))
 			& ~MPIC_VECPRI_PRIORITY_MASK;
-		mpic_irq_write(src, MPIC_IRQ_VECTOR_PRI,
+		mpic_irq_write(src, MPIC_INFO(IRQ_VECTOR_PRI),
 			       reg | (pri << MPIC_VECPRI_PRIORITY_SHIFT));
 	}
 	spin_unlock_irqrestore(&mpic_lock, flags);
@@ -1017,7 +1121,7 @@ unsigned int mpic_irq_get_priority(unsig
 	if (is_ipi)
 		reg = mpic_ipi_read(src = MPIC_VEC_IPI_0);
 	else
-		reg = mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI);
+		reg = mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI));
 	spin_unlock_irqrestore(&mpic_lock, flags);
 	return (reg & MPIC_VECPRI_PRIORITY_MASK) >> MPIC_VECPRI_PRIORITY_SHIFT;
 }
@@ -1043,12 +1147,12 @@ void mpic_setup_this_cpu(void)
  	 */
 	if (distribute_irqs) {
 	 	for (i = 0; i < mpic->num_sources ; i++)
-			mpic_irq_write(i, MPIC_IRQ_DESTINATION,
-				mpic_irq_read(i, MPIC_IRQ_DESTINATION) | msk);
+			mpic_irq_write(i, MPIC_INFO(IRQ_DESTINATION),
+				mpic_irq_read(i, MPIC_INFO(IRQ_DESTINATION)) | msk);
 	}
 
 	/* Set current processor priority to 0 */
-	mpic_cpu_write(MPIC_CPU_CURRENT_TASK_PRI, 0);
+	mpic_cpu_write(MPIC_INFO(CPU_CURRENT_TASK_PRI), 0);
 
 	spin_unlock_irqrestore(&mpic_lock, flags);
 #endif /* CONFIG_SMP */
@@ -1058,7 +1162,7 @@ int mpic_cpu_get_priority(void)
 {
 	struct mpic *mpic = mpic_primary;
 
-	return mpic_cpu_read(MPIC_CPU_CURRENT_TASK_PRI);
+	return mpic_cpu_read(MPIC_INFO(CPU_CURRENT_TASK_PRI));
 }
 
 void mpic_cpu_set_priority(int prio)
@@ -1066,7 +1170,7 @@ void mpic_cpu_set_priority(int prio)
 	struct mpic *mpic = mpic_primary;
 
 	prio &= MPIC_CPU_TASKPRI_MASK;
-	mpic_cpu_write(MPIC_CPU_CURRENT_TASK_PRI, prio);
+	mpic_cpu_write(MPIC_INFO(CPU_CURRENT_TASK_PRI), prio);
 }
 
 /*
@@ -1088,11 +1192,11 @@ void mpic_teardown_this_cpu(int secondar
 
 	/* let the mpic know we don't want intrs.  */
 	for (i = 0; i < mpic->num_sources ; i++)
-		mpic_irq_write(i, MPIC_IRQ_DESTINATION,
-			mpic_irq_read(i, MPIC_IRQ_DESTINATION) & ~msk);
+		mpic_irq_write(i, MPIC_INFO(IRQ_DESTINATION),
+			mpic_irq_read(i, MPIC_INFO(IRQ_DESTINATION)) & ~msk);
 
 	/* Set current processor priority to max */
-	mpic_cpu_write(MPIC_CPU_CURRENT_TASK_PRI, 0xf);
+	mpic_cpu_write(MPIC_INFO(CPU_CURRENT_TASK_PRI), 0xf);
 
 	spin_unlock_irqrestore(&mpic_lock, flags);
 }
@@ -1108,7 +1212,8 @@ void mpic_send_ipi(unsigned int ipi_no, 
 	DBG("%s: send_ipi(ipi_no: %d)\n", mpic->name, ipi_no);
 #endif
 
-	mpic_cpu_write(MPIC_CPU_IPI_DISPATCH_0 + ipi_no * 0x10,
+	mpic_cpu_write(MPIC_INFO(CPU_IPI_DISPATCH_0) +
+		       ipi_no * MPIC_INFO(CPU_IPI_DISPATCH_STRIDE),
 		       mpic_physmask(cpu_mask & cpus_addr(cpu_online_map)[0]));
 }
 
@@ -1116,7 +1221,7 @@ unsigned int mpic_get_one_irq(struct mpi
 {
 	u32 src;
 
-	src = mpic_cpu_read(MPIC_CPU_INTACK) & MPIC_VECPRI_VECTOR_MASK;
+	src = mpic_cpu_read(MPIC_INFO(CPU_INTACK)) & MPIC_INFO(VECPRI_VECTOR_MASK);
 #ifdef DEBUG_LOW
 	DBG("%s: get_one_irq(): %d\n", mpic->name, src);
 #endif
Index: linux-work/include/asm-powerpc/mpic.h
===================================================================
--- linux-work.orig/include/asm-powerpc/mpic.h	2006-08-17 09:26:22.000000000 +1000
+++ linux-work/include/asm-powerpc/mpic.h	2006-08-25 13:49:01.000000000 +1000
@@ -41,6 +41,7 @@
 #define MPIC_GREG_IPI_VECTOR_PRI_1	0x000b0
 #define MPIC_GREG_IPI_VECTOR_PRI_2	0x000c0
 #define MPIC_GREG_IPI_VECTOR_PRI_3	0x000d0
+#define MPIC_GREG_IPI_STRIDE		0x10
 #define MPIC_GREG_SPURIOUS		0x000e0
 #define MPIC_GREG_TIMER_FREQ		0x000f0
 
@@ -68,6 +69,7 @@
 #define MPIC_CPU_IPI_DISPATCH_1		0x00050
 #define MPIC_CPU_IPI_DISPATCH_2		0x00060
 #define MPIC_CPU_IPI_DISPATCH_3		0x00070
+#define MPIC_CPU_IPI_DISPATCH_STRIDE	0x00010
 #define MPIC_CPU_CURRENT_TASK_PRI	0x00080
 #define 	MPIC_CPU_TASKPRI_MASK			0x0000000f
 #define MPIC_CPU_WHOAMI			0x00090
@@ -114,6 +116,103 @@
 #define MPIC_VEC_TIMER_1	248
 #define MPIC_VEC_TIMER_0	247
 
+/*
+ * Tsi108 implementation of MPIC has many differences from the original one
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
+/* weird mpic register indices and mask bits in the HW info array */
+enum {
+	MPIC_IDX_GREG_BASE = 0,
+	MPIC_IDX_GREG_FEATURE_0,
+	MPIC_IDX_GREG_GLOBAL_CONF_0,
+	MPIC_IDX_GREG_VENDOR_ID,
+	MPIC_IDX_GREG_IPI_VECTOR_PRI_0,
+	MPIC_IDX_GREG_IPI_STRIDE,
+	MPIC_IDX_GREG_SPURIOUS,
+	MPIC_IDX_GREG_TIMER_FREQ,
+
+	MPIC_IDX_TIMER_BASE,
+	MPIC_IDX_TIMER_STRIDE,
+	MPIC_IDX_TIMER_CURRENT_CNT,
+	MPIC_IDX_TIMER_BASE_CNT,
+	MPIC_IDX_TIMER_VECTOR_PRI,
+	MPIC_IDX_TIMER_DESTINATION,
+
+	MPIC_IDX_CPU_BASE,
+	MPIC_IDX_CPU_STRIDE,
+	MPIC_IDX_CPU_IPI_DISPATCH_0,
+	MPIC_IDX_CPU_IPI_DISPATCH_STRIDE,
+	MPIC_IDX_CPU_CURRENT_TASK_PRI,
+	MPIC_IDX_CPU_WHOAMI,
+	MPIC_IDX_CPU_INTACK,
+	MPIC_IDX_CPU_EOI,
+
+	MPIC_IDX_IRQ_BASE,
+	MPIC_IDX_IRQ_STRIDE,
+	MPIC_IDX_IRQ_VECTOR_PRI,
+
+	MPIC_IDX_VECPRI_VECTOR_MASK,
+	MPIC_IDX_VECPRI_POLARITY_POSITIVE,
+	MPIC_IDX_VECPRI_POLARITY_NEGATIVE,
+	MPIC_IDX_VECPRI_SENSE_LEVEL,
+	MPIC_IDX_VECPRI_SENSE_EDGE,
+	MPIC_IDX_VECPRI_POLARITY_MASK,
+	MPIC_IDX_VECPRI_SENSE_MASK,
+	MPIC_IDX_IRQ_DESTINATION,
+	MPIC_IDX_END
+};
+
+
 #ifdef CONFIG_MPIC_BROKEN_U3
 /* Fixup table entry */
 struct mpic_irq_fixup
@@ -171,15 +270,29 @@ struct mpic
 	volatile u32 __iomem	*cpuregs[MPIC_MAX_CPUS];
 	volatile u32 __iomem	*isus[MPIC_MAX_ISU];
 
+#ifdef CONFIG_MPIC_WEIRD
+	/* Pointer to HW info array */
+	u32			*hw_set;
+#endif
+
 	/* link */
 	struct mpic		*next;
 };
 
+/*
+ * MPIC flags (passed to mpic_alloc)
+ *
+ * The top 4 bits contain an MPIC bhw id that is used to index the
+ * register offsets and some masks when CONFIG_MPIC_WEIRD is set.
+ * Note setting any ID (leaving those bits to 0) means standard MPIC
+ */
+
 /* This is the primary controller, only that one has IPIs and
  * has afinity control. A non-primary MPIC always uses CPU0
  * registers only
  */
 #define MPIC_PRIMARY			0x00000001
+
 /* Set this for a big-endian MPIC */
 #define MPIC_BIG_ENDIAN			0x00000002
 /* Broken U3 MPIC */
@@ -188,6 +301,18 @@ struct mpic
 #define MPIC_BROKEN_IPI			0x00000008
 /* MPIC wants a reset */
 #define MPIC_WANTS_RESET		0x00000010
+/* Spurious vector requires EOI */
+#define MPIC_SPV_EOI			0x00000020
+/* No passthrough disable */
+#define MPIC_NO_PTHROU_DIS		0x00000040
+
+/* MPIC HW modification ID */
+#define MPIC_REGSET_MASK		0xf0000000
+#define MPIC_REGSET(val)		(((val) & 0xf ) << 28)
+#define MPIC_GET_REGSET(flags)		(((flags) >> 28) & 0xf)
+
+#define	MPIC_REGSET_STANDARD		MPIC_REGSET(0)	/* Original MPIC */
+#define	MPIC_REGSET_TSI108		MPIC_REGSET(1)	/* Tsi108/109 PIC */
 
 /* Allocate the controller structure and setup the linux irq descs
  * for the range if interrupts passed in. No HW initialization is
Index: linux-work/arch/powerpc/platforms/embedded6xx/Kconfig
===================================================================
--- linux-work.orig/arch/powerpc/platforms/embedded6xx/Kconfig	2006-06-30 11:45:54.000000000 +1000
+++ linux-work/arch/powerpc/platforms/embedded6xx/Kconfig	2006-08-25 13:24:32.000000000 +1000
@@ -80,6 +80,7 @@ config MPC7448HPC2
 	select DEFAULT_UIMAGE
 	select PPC_UDBG_16550
 	select MPIC
+	select MPIC_WEIRD
 	help
 	  Select MPC7448HPC2 if configuring for Freescale MPC7448HPC2 (Taiga)
 	  platform
Index: linux-work/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c	2006-06-30 11:45:54.000000000 +1000
+++ linux-work/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c	2006-08-25 13:46:04.000000000 +1000
@@ -248,7 +248,7 @@ static void __init mpc7448_hpc2_init_IRQ
 
 	mpic = mpic_alloc(mpic_paddr,
 			MPIC_PRIMARY | MPIC_BIG_ENDIAN | MPIC_WANTS_RESET |
-			MPIC_SPV_EOI | MPIC_MOD_ID(MPIC_ID_TSI108),
+			MPIC_SPV_EOI | MPIC_NO_PTHROU_DIS | MPIC_REGSET_TSI108,
 			0, /* num_sources used */
 			TSI108_IRQ_BASE,
 			0, /* num_sources used */

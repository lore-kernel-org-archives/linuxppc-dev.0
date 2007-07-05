Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 03F35DDF46
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 03:03:49 +1000 (EST)
Message-Id: <20070705170239.438013000@lixom.net>
References: <20070705170233.258351000@lixom.net>
Date: Thu, 05 Jul 2007 12:02:55 -0500
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [patch 22/35] Work around errata 4111
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Workaround for errata 4111: IPI registers of the OpenPIC don't read back
right.

Also, reading back regular irq setup registers is broken, so keep a
software copy.


Index: mainline/arch/powerpc/sysdev/mpic.c
===================================================================
--- mainline.orig/arch/powerpc/sysdev/mpic.c
+++ mainline/arch/powerpc/sysdev/mpic.c
@@ -187,6 +187,9 @@ static inline void _mpic_write(enum mpic
 
 static inline u32 _mpic_ipi_read(struct mpic *mpic, unsigned int ipi)
 {
+#ifdef CONFIG_MPIC_BROKEN_REGREAD
+	return mpic->ipi_reg_shadow[ipi];
+#else
 	enum mpic_reg_type type = mpic->reg_type;
 	unsigned int offset = MPIC_INFO(GREG_IPI_VECTOR_PRI_0) +
 			      (ipi * MPIC_INFO(GREG_IPI_STRIDE));
@@ -194,6 +197,7 @@ static inline u32 _mpic_ipi_read(struct 
 	if ((mpic->flags & MPIC_BROKEN_IPI) && type == mpic_access_mmio_le)
 		type = mpic_access_mmio_be;
 	return _mpic_read(type, &mpic->gregs, offset);
+#endif
 }
 
 static inline void _mpic_ipi_write(struct mpic *mpic, unsigned int ipi, u32 value)
@@ -202,6 +206,9 @@ static inline void _mpic_ipi_write(struc
 			      (ipi * MPIC_INFO(GREG_IPI_STRIDE));
 
 	_mpic_write(mpic->reg_type, &mpic->gregs, offset, value);
+#ifdef CONFIG_MPIC_BROKEN_REGREAD
+	mpic->ipi_reg_shadow[ipi] = value;
+#endif
 }
 
 static inline u32 _mpic_cpu_read(struct mpic *mpic, unsigned int reg)
@@ -213,6 +220,13 @@ static inline u32 _mpic_cpu_read(struct 
 	return _mpic_read(mpic->reg_type, &mpic->cpuregs[cpu], reg);
 }
 
+static inline void _mpic_cpu0_write(struct mpic *mpic, unsigned int reg, u32 value)
+{
+	unsigned int cpu = 0;
+
+	_mpic_write(mpic->reg_type, &mpic->cpuregs[cpu], reg, value);
+}
+
 static inline void _mpic_cpu_write(struct mpic *mpic, unsigned int reg, u32 value)
 {
 	unsigned int cpu = 0;
@@ -228,8 +242,13 @@ static inline u32 _mpic_irq_read(struct 
 	unsigned int	isu = src_no >> mpic->isu_shift;
 	unsigned int	idx = src_no & mpic->isu_mask;
 
-	return _mpic_read(mpic->reg_type, &mpic->isus[isu],
-			  reg + (idx * MPIC_INFO(IRQ_STRIDE)));
+#ifdef CONFIG_MPIC_BROKEN_REGREAD
+	if (reg == 0)
+		return mpic->isu_reg0_shadow[idx];
+	else
+#endif
+		return _mpic_read(mpic->reg_type, &mpic->isus[isu],
+				  reg + (idx * MPIC_INFO(IRQ_STRIDE)));
 }
 
 static inline void _mpic_irq_write(struct mpic *mpic, unsigned int src_no,
@@ -240,6 +259,11 @@ static inline void _mpic_irq_write(struc
 
 	_mpic_write(mpic->reg_type, &mpic->isus[isu],
 		    reg + (idx * MPIC_INFO(IRQ_STRIDE)), value);
+
+#ifdef CONFIG_MPIC_BROKEN_REGREAD
+	if (reg == 0)
+		mpic->isu_reg0_shadow[idx] = value;
+#endif
 }
 
 #define mpic_read(b,r)		_mpic_read(mpic->reg_type,&(b),(r))
@@ -1157,6 +1181,8 @@ void __init mpic_assign_isu(struct mpic 
 		 MPIC_INFO(IRQ_STRIDE) * mpic->isu_size);
 	if ((isu_first + mpic->isu_size) > mpic->num_sources)
 		mpic->num_sources = isu_first + mpic->isu_size;
+
+	printk("num_sources %d\n", mpic->num_sources);
 }
 
 void __init mpic_set_default_senses(struct mpic *mpic, u8 *senses, int count)
@@ -1394,7 +1420,7 @@ void mpic_send_ipi(unsigned int ipi_no, 
 	DBG("%s: send_ipi(ipi_no: %d)\n", mpic->name, ipi_no);
 #endif
 
-	mpic_cpu_write(MPIC_INFO(CPU_IPI_DISPATCH_0) +
+	_mpic_cpu0_write(mpic, MPIC_INFO(CPU_IPI_DISPATCH_0) +
 		       ipi_no * MPIC_INFO(CPU_IPI_DISPATCH_STRIDE),
 		       mpic_physmask(cpu_mask & cpus_addr(cpu_online_map)[0]));
 }
Index: mainline/include/asm-powerpc/mpic.h
===================================================================
--- mainline.orig/include/asm-powerpc/mpic.h
+++ mainline/include/asm-powerpc/mpic.h
@@ -306,6 +306,11 @@ struct mpic
 	unsigned long		*hwirq_bitmap;
 #endif
 
+#ifdef CONFIG_MPIC_BROKEN_REGREAD
+	u32			ipi_reg_shadow[4];
+	u32			isu_reg0_shadow[MPIC_MAX_IRQ_SOURCES];
+#endif
+
 	/* link */
 	struct mpic		*next;
 
Index: mainline/arch/powerpc/platforms/Kconfig
===================================================================
--- mainline.orig/arch/powerpc/platforms/Kconfig
+++ mainline/arch/powerpc/platforms/Kconfig
@@ -121,6 +121,11 @@ config MPIC_U3_HT_IRQS
 	depends on PPC_MAPLE
 	default y
 
+config MPIC_BROKEN_REGREAD
+	bool
+	depends on PPC_PASEMI
+	default y
+
 config IBMVIO
 	depends on PPC_PSERIES || PPC_ISERIES
 	bool
Index: mainline/arch/powerpc/platforms/pasemi/Kconfig
===================================================================
--- mainline.orig/arch/powerpc/platforms/pasemi/Kconfig
+++ mainline/arch/powerpc/platforms/pasemi/Kconfig
@@ -6,6 +6,7 @@ config PPC_PASEMI
 	select PPC_UDBG_16550
 	select PPC_NATIVE
 	select EMBEDDED
+	select MPIC_BROKEN_REGREAD
 	help
 	  This option enables support for PA Semi's PWRficient line
 	  of SoC processors, including PA6T-1682M

--

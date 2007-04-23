Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Mon, 23 Apr 2007 18:47:08 +1000
Subject: [PATCH] Rename MPIC_BROKEN_U3 to MPIC_U3_HT_IRQS
Message-Id: <20070423084710.10570DDF14@ozlabs.org>
Cc: Olof Johannsson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rename MPIC_BROKEN_U3 to something a little more descriptive. Its
effect is to enable support for HT irqs behind the PCI-X/HT bridge on
U3/U4 (aka. CPC9x5) parts.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/configs/g5_defconfig       |    2 +-
 arch/powerpc/configs/maple_defconfig    |    2 +-
 arch/powerpc/configs/ppc64_defconfig    |    2 +-
 arch/powerpc/platforms/Kconfig          |    2 +-
 arch/powerpc/platforms/maple/Kconfig    |    2 +-
 arch/powerpc/platforms/maple/setup.c    |    2 +-
 arch/powerpc/platforms/powermac/Kconfig |    2 +-
 arch/powerpc/platforms/powermac/pic.c   |    2 +-
 arch/powerpc/sysdev/mpic.c              |   24 ++++++++++++------------
 include/asm-powerpc/mpic.h              |   12 ++++++------
 10 files changed, 26 insertions(+), 26 deletions(-)

Index: msi-new/arch/powerpc/configs/g5_defconfig
===================================================================
--- msi-new.orig/arch/powerpc/configs/g5_defconfig
+++ msi-new/arch/powerpc/configs/g5_defconfig
@@ -143,7 +143,7 @@ CONFIG_PPC_NATIVE=y
 CONFIG_U3_DART=y
 # CONFIG_PPC_RTAS is not set
 # CONFIG_MMIO_NVRAM is not set
-CONFIG_MPIC_BROKEN_U3=y
+CONFIG_MPIC_U3_HT_IRQS=y
 # CONFIG_PPC_MPC106 is not set
 CONFIG_PPC_970_NAP=y
 # CONFIG_PPC_INDIRECT_IO is not set
Index: msi-new/arch/powerpc/configs/maple_defconfig
===================================================================
--- msi-new.orig/arch/powerpc/configs/maple_defconfig
+++ msi-new/arch/powerpc/configs/maple_defconfig
@@ -146,7 +146,7 @@ CONFIG_PPC_RTAS=y
 CONFIG_RTAS_PROC=y
 # CONFIG_RTAS_FLASH is not set
 # CONFIG_MMIO_NVRAM is not set
-CONFIG_MPIC_BROKEN_U3=y
+CONFIG_MPIC_U3_HT_IRQS=y
 # CONFIG_PPC_MPC106 is not set
 CONFIG_PPC_970_NAP=y
 # CONFIG_PPC_INDIRECT_IO is not set
Index: msi-new/arch/powerpc/configs/ppc64_defconfig
===================================================================
--- msi-new.orig/arch/powerpc/configs/ppc64_defconfig
+++ msi-new/arch/powerpc/configs/ppc64_defconfig
@@ -152,7 +152,7 @@ CONFIG_RTAS_ERROR_LOGGING=y
 CONFIG_RTAS_PROC=y
 CONFIG_RTAS_FLASH=m
 CONFIG_MMIO_NVRAM=y
-CONFIG_MPIC_BROKEN_U3=y
+CONFIG_MPIC_U3_HT_IRQS=y
 CONFIG_IBMVIO=y
 # CONFIG_IBMEBUS is not set
 # CONFIG_PPC_MPC106 is not set
Index: msi-new/arch/powerpc/platforms/Kconfig
===================================================================
--- msi-new.orig/arch/powerpc/platforms/Kconfig
+++ msi-new/arch/powerpc/platforms/Kconfig
@@ -104,7 +104,7 @@ config MMIO_NVRAM
 	bool
 	default n
 
-config MPIC_BROKEN_U3
+config MPIC_U3_HT_IRQS
 	bool
 	depends on PPC_MAPLE
 	default y
Index: msi-new/arch/powerpc/platforms/maple/Kconfig
===================================================================
--- msi-new.orig/arch/powerpc/platforms/maple/Kconfig
+++ msi-new/arch/powerpc/platforms/maple/Kconfig
@@ -3,7 +3,7 @@ config PPC_MAPLE
 	bool "Maple 970FX Evaluation Board"
 	select MPIC
 	select U3_DART
-	select MPIC_BROKEN_U3
+	select MPIC_U3_HT_IRQS
 	select GENERIC_TBSYNC
 	select PPC_UDBG_16550
 	select PPC_970_NAP
Index: msi-new/arch/powerpc/platforms/maple/setup.c
===================================================================
--- msi-new.orig/arch/powerpc/platforms/maple/setup.c
+++ msi-new/arch/powerpc/platforms/maple/setup.c
@@ -264,7 +264,7 @@ static void __init maple_init_IRQ(void)
 		flags |= MPIC_BIG_ENDIAN;
 
 	/* XXX Maple specific bits */
-	flags |= MPIC_BROKEN_U3 | MPIC_WANTS_RESET;
+	flags |= MPIC_U3_HT_IRQS | MPIC_WANTS_RESET;
 	/* All U3/U4 are big-endian, older SLOF firmware doesn't encode this */
 	flags |= MPIC_BIG_ENDIAN;
 
Index: msi-new/arch/powerpc/platforms/powermac/Kconfig
===================================================================
--- msi-new.orig/arch/powerpc/platforms/powermac/Kconfig
+++ msi-new/arch/powerpc/platforms/powermac/Kconfig
@@ -12,7 +12,7 @@ config PPC_PMAC64
 	depends on PPC_PMAC && POWER4
 	select MPIC
 	select U3_DART
-	select MPIC_BROKEN_U3
+	select MPIC_U3_HT_IRQS
 	select GENERIC_TBSYNC
 	select PPC_970_NAP
 	default y
Index: msi-new/arch/powerpc/platforms/powermac/pic.c
===================================================================
--- msi-new.orig/arch/powerpc/platforms/powermac/pic.c
+++ msi-new/arch/powerpc/platforms/powermac/pic.c
@@ -489,7 +489,7 @@ static struct mpic * __init pmac_setup_o
 	 * but works until I find a better way
 	 */
 	if (master && (flags & MPIC_BIG_ENDIAN))
-		flags |= MPIC_BROKEN_U3;
+		flags |= MPIC_U3_HT_IRQS;
 
 	mpic = mpic_alloc(np, r.start, flags, 0, 0, name);
 	if (mpic == NULL)
Index: msi-new/arch/powerpc/sysdev/mpic.c
===================================================================
--- msi-new.orig/arch/powerpc/sysdev/mpic.c
+++ msi-new/arch/powerpc/sysdev/mpic.c
@@ -304,7 +304,7 @@ static void __init mpic_test_broken_ipi(
 	}
 }
 
-#ifdef CONFIG_MPIC_BROKEN_U3
+#ifdef CONFIG_MPIC_U3_HT_IRQS
 
 /* Test if an interrupt is sourced from HyperTransport (used on broken U3s)
  * to force the edge setting on the MPIC and do the ack workaround.
@@ -476,7 +476,7 @@ static void __init mpic_scan_ht_pics(str
 	}
 }
 
-#else /* CONFIG_MPIC_BROKEN_U3 */
+#else /* CONFIG_MPIC_U3_HT_IRQS */
 
 static inline int mpic_is_ht_interrupt(struct mpic *mpic, unsigned int source)
 {
@@ -487,7 +487,7 @@ static void __init mpic_scan_ht_pics(str
 {
 }
 
-#endif /* CONFIG_MPIC_BROKEN_U3 */
+#endif /* CONFIG_MPIC_U3_HT_IRQS */
 
 
 #define mpic_irq_to_hw(virq)	((unsigned int)irq_map[virq].hwirq)
@@ -615,7 +615,7 @@ static void mpic_end_irq(unsigned int ir
 	mpic_eoi(mpic);
 }
 
-#ifdef CONFIG_MPIC_BROKEN_U3
+#ifdef CONFIG_MPIC_U3_HT_IRQS
 
 static void mpic_unmask_ht_irq(unsigned int irq)
 {
@@ -665,7 +665,7 @@ static void mpic_end_ht_irq(unsigned int
 		mpic_ht_end_irq(mpic, src);
 	mpic_eoi(mpic);
 }
-#endif /* !CONFIG_MPIC_BROKEN_U3 */
+#endif /* !CONFIG_MPIC_U3_HT_IRQS */
 
 #ifdef CONFIG_SMP
 
@@ -788,7 +788,7 @@ static struct irq_chip mpic_ipi_chip = {
 };
 #endif /* CONFIG_SMP */
 
-#ifdef CONFIG_MPIC_BROKEN_U3
+#ifdef CONFIG_MPIC_U3_HT_IRQS
 static struct irq_chip mpic_irq_ht_chip = {
 	.startup	= mpic_startup_ht_irq,
 	.shutdown	= mpic_shutdown_ht_irq,
@@ -797,7 +797,7 @@ static struct irq_chip mpic_irq_ht_chip 
 	.eoi		= mpic_end_ht_irq,
 	.set_type	= mpic_set_irq_type,
 };
-#endif /* CONFIG_MPIC_BROKEN_U3 */
+#endif /* CONFIG_MPIC_U3_HT_IRQS */
 
 
 static int mpic_host_match(struct irq_host *h, struct device_node *node)
@@ -837,11 +837,11 @@ static int mpic_host_map(struct irq_host
 	/* Default chip */
 	chip = &mpic->hc_irq;
 
-#ifdef CONFIG_MPIC_BROKEN_U3
+#ifdef CONFIG_MPIC_U3_HT_IRQS
 	/* Check for HT interrupts, override vecpri */
 	if (mpic_is_ht_interrupt(mpic, hw))
 		chip = &mpic->hc_ht_irq;
-#endif /* CONFIG_MPIC_BROKEN_U3 */
+#endif /* CONFIG_MPIC_U3_HT_IRQS */
 
 	DBG("mpic: mapping to irq chip @%p\n", chip);
 
@@ -937,12 +937,12 @@ struct mpic * __init mpic_alloc(struct d
 	mpic->hc_irq.typename = name;
 	if (flags & MPIC_PRIMARY)
 		mpic->hc_irq.set_affinity = mpic_set_affinity;
-#ifdef CONFIG_MPIC_BROKEN_U3
+#ifdef CONFIG_MPIC_U3_HT_IRQS
 	mpic->hc_ht_irq = mpic_irq_ht_chip;
 	mpic->hc_ht_irq.typename = name;
 	if (flags & MPIC_PRIMARY)
 		mpic->hc_ht_irq.set_affinity = mpic_set_affinity;
-#endif /* CONFIG_MPIC_BROKEN_U3 */
+#endif /* CONFIG_MPIC_U3_HT_IRQS */
 
 #ifdef CONFIG_SMP
 	mpic->hc_ipi = mpic_ipi_chip;
@@ -1142,7 +1142,7 @@ void __init mpic_init(struct mpic *mpic)
 
 	/* Do the HT PIC fixups on U3 broken mpic */
 	DBG("MPIC flags: %x\n", mpic->flags);
-	if ((mpic->flags & MPIC_BROKEN_U3) && (mpic->flags & MPIC_PRIMARY))
+	if ((mpic->flags & MPIC_U3_HT_IRQS) && (mpic->flags & MPIC_PRIMARY))
  		mpic_scan_ht_pics(mpic);
 
 	for (i = 0; i < mpic->num_sources; i++) {
Index: msi-new/include/asm-powerpc/mpic.h
===================================================================
--- msi-new.orig/include/asm-powerpc/mpic.h
+++ msi-new/include/asm-powerpc/mpic.h
@@ -199,7 +199,7 @@ enum {
 };
 
 
-#ifdef CONFIG_MPIC_BROKEN_U3
+#ifdef CONFIG_MPIC_U3_HT_IRQS
 /* Fixup table entry */
 struct mpic_irq_fixup
 {
@@ -208,7 +208,7 @@ struct mpic_irq_fixup
 	u32		data;
 	unsigned int	index;
 };
-#endif /* CONFIG_MPIC_BROKEN_U3 */
+#endif /* CONFIG_MPIC_U3_HT_IRQS */
 
 
 enum mpic_reg_type {
@@ -239,7 +239,7 @@ struct mpic
 
 	/* The "linux" controller struct */
 	struct irq_chip		hc_irq;
-#ifdef CONFIG_MPIC_BROKEN_U3
+#ifdef CONFIG_MPIC_U3_HT_IRQS
 	struct irq_chip		hc_ht_irq;
 #endif
 #ifdef CONFIG_SMP
@@ -268,7 +268,7 @@ struct mpic
 	/* Spurious vector to program into unused sources */
 	unsigned int		spurious_vec;
 
-#ifdef CONFIG_MPIC_BROKEN_U3
+#ifdef CONFIG_MPIC_U3_HT_IRQS
 	/* The fixup table */
 	struct mpic_irq_fixup	*fixups;
 	spinlock_t		fixup_lock;
@@ -313,7 +313,7 @@ struct mpic
 /* Set this for a big-endian MPIC */
 #define MPIC_BIG_ENDIAN			0x00000002
 /* Broken U3 MPIC */
-#define MPIC_BROKEN_U3			0x00000004
+#define MPIC_U3_HT_IRQS			0x00000004
 /* Broken IPI registers (autodetected) */
 #define MPIC_BROKEN_IPI			0x00000008
 /* MPIC wants a reset */
@@ -352,7 +352,7 @@ struct mpic
  * @senses_num: number of entries in the array
  *
  * Note about the sense array. If none is passed, all interrupts are
- * setup to be level negative unless MPIC_BROKEN_U3 is set in which
+ * setup to be level negative unless MPIC_U3_HT_IRQS is set in which
  * case they are edge positive (and the array is ignored anyway).
  * The values in the array start at the first source of the MPIC,
  * that is senses[0] correspond to linux irq "irq_offset".

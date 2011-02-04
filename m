Return-Path: <meador_inge@mentor.com>
From: Meador Inge <meador_inge@mentor.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 3/4] powerpc: make MPIC honor the "pic-no-reset" device
	tree property
Date: Fri,  4 Feb 2011 17:25:40 -0600
Message-Id: <1296861941-3370-4-git-send-email-meador_inge@mentor.com>
In-Reply-To: <1296861941-3370-1-git-send-email-meador_inge@mentor.com>
References: <1296861941-3370-1-git-send-email-meador_inge@mentor.com>
Cc: devicetree-discuss@lists.ozlabs.org,
	Hollis Blanchard <hollis_blanchard@mentor.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This property, defined in the Open PIC binding, tells the kernel not to use the
reset bit in the global configuration register.  Additionally, its presence
mandates that only sources which are actually used (i.e. appear in the device
tree) should have their VECPRI bits initialized.

The presence of "protected-sources" is checked for the backwards
compatibility of systems which are already using "protected-sources"
in firmware and the firmware can not be updated.  Any sources encoded in the
"protected-sources" cells are not processed.  "protected-sources" is
effectively a synonym for "pic-no-reset".

Signed-off-by: Meador Inge <meador_inge@mentor.com>
Cc: Hollis Blanchard <hollis_blanchard@mentor.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/mpic.h |    4 ++-
 arch/powerpc/sysdev/mpic.c      |   64 +++++++++++++++++++++++++++++++-------
 2 files changed, 55 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/mpic.h b/arch/powerpc/include/asm/mpic.h
index 9b94f18..688e3e0 100644
--- a/arch/powerpc/include/asm/mpic.h
+++ b/arch/powerpc/include/asm/mpic.h
@@ -322,6 +322,8 @@ struct mpic
 #ifdef CONFIG_PM
 	struct mpic_irq_save	*save_data;
 #endif
+
+	int cpu;
 };
 
 /*
@@ -333,7 +335,7 @@ struct mpic
  */
 
 /* This is the primary controller, only that one has IPIs and
- * has afinity control. A non-primary MPIC always uses CPU0
+ * has affinity control. A non-primary MPIC always uses CPU0
  * registers only
  */
 #define MPIC_PRIMARY			0x00000001
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index a98f41d..8de47ca 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -308,6 +308,15 @@ static inline void mpic_map(struct mpic *mpic, struct device_node *node,
 #define mpic_map(m,n,p,b,o,s)	_mpic_map_mmio(m,p,b,o,s)
 #endif /* !CONFIG_PPC_DCR */
 
+static inline void mpic_init_vector(struct mpic *mpic, int source)
+{
+	/* start with vector = source number, and masked */
+	u32 vecpri = MPIC_VECPRI_MASK | source | (8 << MPIC_VECPRI_PRIORITY_SHIFT);
+		
+	/* init hw */
+	mpic_irq_write(source, MPIC_INFO(IRQ_VECTOR_PRI), vecpri);
+	mpic_irq_write(source, MPIC_INFO(IRQ_DESTINATION), 1 << mpic->cpu);
+}
 
 
 /* Check if we have one of those nice broken MPICs with a flipped endian on
@@ -622,6 +631,14 @@ static unsigned int mpic_is_ipi(struct mpic *mpic, unsigned int irq)
 	return (src >= mpic->ipi_vecs[0] && src <= mpic->ipi_vecs[3]);
 }
 
+/* Determine if the linux irq is a timer interrupt */
+static unsigned int mpic_is_timer_interrupt(struct mpic *mpic, unsigned int irq)
+{
+	unsigned int src = mpic_irq_to_hw(irq);
+
+	return (src >= mpic->timer_vecs[0] && src <= mpic->timer_vecs[3]);
+}
+
 
 /* Convert a cpu mask from logical to physical cpu numbers. */
 static inline u32 mpic_physmask(u32 cpumask)
@@ -963,6 +980,15 @@ static int mpic_host_map(struct irq_host *h, unsigned int virq,
 	if (hw >= mpic->irq_count)
 		return -EINVAL;
 
+	/* If the MPIC was reset, then all vectors have already been
+	 * initialized.  Otherwise, the appropriate vector needs to be
+	 * initialized here to ensure that only used sources are setup with
+	 * a vector.
+	 */
+	if (!(mpic->flags & MPIC_WANTS_RESET))
+		if (!(mpic_is_ipi(mpic, hw) || mpic_is_timer_interrupt(mpic, hw)))
+			mpic_init_vector(mpic, hw);
+
 	mpic_msi_reserve_hwirq(mpic, hw);
 
 	/* Default chip */
@@ -1029,6 +1055,16 @@ static struct irq_host_ops mpic_host_ops = {
 	.xlate = mpic_host_xlate,
 };
 
+static int mpic_reset_prohibited(struct device_node *node)
+{
+	/* The presence of "protected-sources" is checked for the backwards
+	 * compatibility of systems which are already using "protected-sources"
+	 * in firmware and the firmware can not be updated.
+	 */
+	return node && (of_get_property(node, "pic-no-reset", NULL)
+		|| of_get_property(node, "protected-sources", NULL));
+}
+
 /*
  * Exported functions
  */
@@ -1129,7 +1165,16 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	mpic_map(mpic, node, paddr, &mpic->tmregs, MPIC_INFO(TIMER_BASE), 0x1000);
 
 	/* Reset */
-	if (flags & MPIC_WANTS_RESET) {
+
+	/* When using a device-node, reset requests are only honored if the MPIC
+	 * is allowed to reset.
+	 */
+	if (mpic_reset_prohibited(node)) {
+		mpic->flags &= ~MPIC_WANTS_RESET;
+	}
+
+	if (mpic->flags & MPIC_WANTS_RESET) {
+		printk(KERN_DEBUG "mpic: Resetting\n");
 		mpic_write(mpic->gregs, MPIC_INFO(GREG_GLOBAL_CONF_0),
 			   mpic_read(mpic->gregs, MPIC_INFO(GREG_GLOBAL_CONF_0))
 			   | MPIC_GREG_GCONF_RESET);
@@ -1246,7 +1291,6 @@ void __init mpic_set_default_senses(struct mpic *mpic, u8 *senses, int count)
 void __init mpic_init(struct mpic *mpic)
 {
 	int i;
-	int cpu;
 
 	BUG_ON(mpic->num_sources == 0);
 
@@ -1290,18 +1334,14 @@ void __init mpic_init(struct mpic *mpic)
 	mpic_pasemi_msi_init(mpic);
 
 	if (mpic->flags & MPIC_PRIMARY)
-		cpu = hard_smp_processor_id();
+		mpic->cpu = hard_smp_processor_id();
 	else
-		cpu = 0;
+		mpic->cpu = 0;
 
-	for (i = 0; i < mpic->num_sources; i++) {
-		/* start with vector = source number, and masked */
-		u32 vecpri = MPIC_VECPRI_MASK | i |
-			(8 << MPIC_VECPRI_PRIORITY_SHIFT);
-		
-		/* init hw */
-		mpic_irq_write(i, MPIC_INFO(IRQ_VECTOR_PRI), vecpri);
-		mpic_irq_write(i, MPIC_INFO(IRQ_DESTINATION), 1 << cpu);
+	if (mpic->flags & MPIC_WANTS_RESET) {
+		for (i = 0; i < mpic->num_sources; i++) {
+			mpic_init_vector(mpic, i);
+		}
 	}
 	
 	/* Init spurious vector */
-- 
1.6.3.3

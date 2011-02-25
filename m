Return-Path: <meador_inge@mentor.com>
From: Meador Inge <meador_inge@mentor.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 2/2] powerpc: make MPIC honor the "pic-no-reset" device
	tree property
Date: Fri, 25 Feb 2011 15:59:37 -0600
Message-Id: <1298671177-19572-3-git-send-email-meador_inge@mentor.com>
In-Reply-To: <1298671177-19572-1-git-send-email-meador_inge@mentor.com>
References: <1298671177-19572-1-git-send-email-meador_inge@mentor.com>
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

Although, "pic-no-reset" can be used for the same use cases that
"protected-sources" is covering, the "protected-sources" implementation was
left completely intact.  This is a more pragmatic approach as there are
already several existing systems which use protected sources.  If
"pic-no-reset" *and* "protected-sources" are both used, however, then
"pic-no-reset" takes precedence in terms of the init behavior and the
sanity checks done by protected sources will still take place.

Signed-off-by: Meador Inge <meador_inge@mentor.com>
Cc: Hollis Blanchard <hollis_blanchard@mentor.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/mpic.h |    6 +++
 arch/powerpc/sysdev/mpic.c      |   67 +++++++++++++++++++++++++++++---------
 2 files changed, 57 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/mpic.h b/arch/powerpc/include/asm/mpic.h
index e000cce..7e1be12 100644
--- a/arch/powerpc/include/asm/mpic.h
+++ b/arch/powerpc/include/asm/mpic.h
@@ -325,6 +325,8 @@ struct mpic
 #ifdef CONFIG_PM
 	struct mpic_irq_save	*save_data;
 #endif
+
+	int cpu;
 };
 
 /*
@@ -367,6 +369,10 @@ struct mpic
 #define MPIC_SINGLE_DEST_CPU		0x00001000
 /* Enable CoreInt delivery of interrupts */
 #define MPIC_ENABLE_COREINT		0x00002000
+/* Disable resetting of the MPIC.
+ * NOTE: This flag trumps MPIC_WANTS_RESET.
+ */
+#define MPIC_NO_RESET			0x00004000
 
 /* MPIC HW modification ID */
 #define MPIC_REGSET_MASK		0xf0000000
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index b0c8469..eac1a3b 100644
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
@@ -967,6 +984,15 @@ static int mpic_host_map(struct irq_host *h, unsigned int virq,
 	if (hw >= mpic->irq_count)
 		return -EINVAL;
 
+	/* If the MPIC was reset, then all vectors have already been
+	 * initialized.  Otherwise, the appropriate vector needs to be
+	 * initialized here to ensure that only used sources are setup with
+	 * a vector.
+	 */
+	if (mpic->flags & MPIC_NO_RESET)
+		if (!(mpic_is_ipi(mpic, hw) || mpic_is_timer_interrupt(mpic, hw)))
+			mpic_init_vector(mpic, hw);
+
 	mpic_msi_reserve_hwirq(mpic, hw);
 
 	/* Default chip */
@@ -1033,6 +1059,11 @@ static struct irq_host_ops mpic_host_ops = {
 	.xlate = mpic_host_xlate,
 };
 
+static int mpic_reset_prohibited(struct device_node *node)
+{
+	return node && of_get_property(node, "pic-no-reset", NULL);
+}
+
 /*
  * Exported functions
  */
@@ -1153,7 +1184,16 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	mpic_map(mpic, node, paddr, &mpic->tmregs, MPIC_INFO(TIMER_BASE), 0x1000);
 
 	/* Reset */
-	if (flags & MPIC_WANTS_RESET) {
+
+	/* When using a device-node, reset requests are only honored if the MPIC
+	 * is allowed to reset.
+	 */
+	if (mpic_reset_prohibited(node)) {
+		mpic->flags |= MPIC_NO_RESET;
+	}
+
+	if ((flags & MPIC_WANTS_RESET) && !(mpic->flags & MPIC_NO_RESET)) {
+		printk(KERN_DEBUG "mpic: Resetting\n");
 		mpic_write(mpic->gregs, MPIC_INFO(GREG_GLOBAL_CONF_0),
 			   mpic_read(mpic->gregs, MPIC_INFO(GREG_GLOBAL_CONF_0))
 			   | MPIC_GREG_GCONF_RESET);
@@ -1270,7 +1310,6 @@ void __init mpic_set_default_senses(struct mpic *mpic, u8 *senses, int count)
 void __init mpic_init(struct mpic *mpic)
 {
 	int i;
-	int cpu;
 
 	BUG_ON(mpic->num_sources == 0);
 
@@ -1314,21 +1353,17 @@ void __init mpic_init(struct mpic *mpic)
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
-		/* check if protected */
-		if (mpic->protected && test_bit(i, mpic->protected))
-			continue;
-		/* init hw */
-		mpic_irq_write(i, MPIC_INFO(IRQ_VECTOR_PRI), vecpri);
-		mpic_irq_write(i, MPIC_INFO(IRQ_DESTINATION), 1 << cpu);
+	if (!(mpic->flags & MPIC_NO_RESET)) {
+		for (i = 0; i < mpic->num_sources; i++) {
+			/* check if protected */
+			if (mpic->protected && test_bit(i, mpic->protected))
+				continue;
+			mpic_init_vector(mpic, i);
+		}
 	}
 	
 	/* Init spurious vector */
-- 
1.6.3.3

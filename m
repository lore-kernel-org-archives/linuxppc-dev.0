Return-Path: <meador_inge@mentor.com>
From: Meador Inge <meador_inge@mentor.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 2/3] powerpc: make MPIC honor the "pic-no-reset" device
	tree property
Date: Mon, 14 Mar 2011 15:01:06 -0500
Message-Id: <1300132867-4840-3-git-send-email-meador_inge@mentor.com>
In-Reply-To: <1300132867-4840-1-git-send-email-meador_inge@mentor.com>
References: <1300132867-4840-1-git-send-email-meador_inge@mentor.com>
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

This property, defined in the Open PIC binding, tells the kernel not to use
the reset bit in the global configuration register.  Additionally, its
presence mandates that only sources which are actually used (i.e. appear in
the device tree) should have their VECPRI bits initialized.

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
 arch/powerpc/include/asm/mpic.h |    4 ++
 arch/powerpc/sysdev/mpic.c      |   66 ++++++++++++++++++++++++++++++++------
 2 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/mpic.h b/arch/powerpc/include/asm/mpic.h
index e000cce..1c19734 100644
--- a/arch/powerpc/include/asm/mpic.h
+++ b/arch/powerpc/include/asm/mpic.h
@@ -367,6 +367,10 @@ struct mpic
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
index b0c8469..112bff0 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -906,6 +906,20 @@ void mpic_set_vector(unsigned int virq, unsigned int vector)
 	mpic_irq_write(src, MPIC_INFO(IRQ_VECTOR_PRI), vecpri);
 }
 
+void mpic_set_destination(unsigned int virq, unsigned int cpuid)
+{
+	struct mpic *mpic = mpic_from_irq(virq);
+	unsigned int src = mpic_irq_to_hw(virq);
+
+	DBG("mpic: set_destination(mpic:@%p,virq:%d,src:%d,cpuid:0x%x)\n",
+	    mpic, virq, src, cpuid);
+
+	if (src >= mpic->irq_count)
+		return;
+
+	mpic_irq_write(src, MPIC_INFO(IRQ_DESTINATION), 1 << cpuid);
+}
+
 static struct irq_chip mpic_irq_chip = {
 	.mask		= mpic_mask_irq,
 	.unmask		= mpic_unmask_irq,
@@ -986,6 +1000,21 @@ static int mpic_host_map(struct irq_host *h, unsigned int virq,
 	/* Set default irq type */
 	set_irq_type(virq, IRQ_TYPE_NONE);
 
+	/* If the MPIC was reset, then all vectors have already been
+	 * initialized.  Otherwise, a per source lazy initialization
+	 * is done here.
+	 */
+	if (!mpic_is_ipi(mpic, hw) && (mpic->flags & MPIC_NO_RESET)) {
+		unsigned int cpu = 0;
+
+		if (mpic->flags & MPIC_PRIMARY)
+			cpu = hard_smp_processor_id();
+
+		mpic_set_vector(virq, hw);
+		mpic_set_destination(virq, cpu);
+		mpic_irq_set_priority(virq, 8);
+	}
+
 	return 0;
 }
 
@@ -1033,6 +1062,11 @@ static struct irq_host_ops mpic_host_ops = {
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
@@ -1153,7 +1187,15 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	mpic_map(mpic, node, paddr, &mpic->tmregs, MPIC_INFO(TIMER_BASE), 0x1000);
 
 	/* Reset */
-	if (flags & MPIC_WANTS_RESET) {
+
+	/* When using a device-node, reset requests are only honored if the MPIC
+	 * is allowed to reset.
+	 */
+	if (mpic_reset_prohibited(node))
+		mpic->flags |= MPIC_NO_RESET;
+
+	if ((flags & MPIC_WANTS_RESET) && !(mpic->flags & MPIC_NO_RESET)) {
+		printk(KERN_DEBUG "mpic: Resetting\n");
 		mpic_write(mpic->gregs, MPIC_INFO(GREG_GLOBAL_CONF_0),
 			   mpic_read(mpic->gregs, MPIC_INFO(GREG_GLOBAL_CONF_0))
 			   | MPIC_GREG_GCONF_RESET);
@@ -1318,17 +1360,19 @@ void __init mpic_init(struct mpic *mpic)
 	else
 		cpu = 0;
 
-	for (i = 0; i < mpic->num_sources; i++) {
-		/* start with vector = source number, and masked */
-		u32 vecpri = MPIC_VECPRI_MASK | i |
-			(8 << MPIC_VECPRI_PRIORITY_SHIFT);
+	if (!(mpic->flags & MPIC_NO_RESET)) {
+		for (i = 0; i < mpic->num_sources; i++) {
+			/* start with vector = source number, and masked */
+			u32 vecpri = MPIC_VECPRI_MASK | i |
+				(8 << MPIC_VECPRI_PRIORITY_SHIFT);
 		
-		/* check if protected */
-		if (mpic->protected && test_bit(i, mpic->protected))
-			continue;
-		/* init hw */
-		mpic_irq_write(i, MPIC_INFO(IRQ_VECTOR_PRI), vecpri);
-		mpic_irq_write(i, MPIC_INFO(IRQ_DESTINATION), 1 << cpu);
+			/* check if protected */
+			if (mpic->protected && test_bit(i, mpic->protected))
+				continue;
+			/* init hw */
+			mpic_irq_write(i, MPIC_INFO(IRQ_VECTOR_PRI), vecpri);
+			mpic_irq_write(i, MPIC_INFO(IRQ_DESTINATION), 1 << cpu);
+		}
 	}
 	
 	/* Init spurious vector */
-- 
1.6.3.3

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A5DF2B70DC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2012 13:31:04 +1000 (EST)
Message-ID: <1334892657.31646.2.camel@pasglop>
Subject: [PATCH 3/3] powerpc/mpic: Properly set default triggers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 20 Apr 2012 13:30:57 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This gets rid of the unused default senses array, and replaces the
incorrect use of IRQ_TYPE_NONE with the new IRQ_TYPE_DEFAULT for
the initial set_trigger() call when mapping an interrupt.

This in turn makes us read the HW state and update the irq desc
accordingly.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/mpic.h |   18 -----------------
 arch/powerpc/sysdev/mpic.c      |   42 ++++++++++++++++++++++++++++-----------
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/include/asm/mpic.h b/arch/powerpc/include/asm/mpic.h
index c65b929..c9f698a 100644
--- a/arch/powerpc/include/asm/mpic.h
+++ b/arch/powerpc/include/asm/mpic.h
@@ -275,9 +275,6 @@ struct mpic
 	unsigned int		isu_mask;
 	/* Number of sources */
 	unsigned int		num_sources;
-	/* default senses array */
-	unsigned char		*senses;
-	unsigned int		senses_count;
 
 	/* vector numbers used for internal sources (ipi/timers) */
 	unsigned int		ipi_vecs[4];
@@ -415,21 +412,6 @@ extern struct mpic *mpic_alloc(struct device_node *node,
 extern void mpic_assign_isu(struct mpic *mpic, unsigned int isu_num,
 			    phys_addr_t phys_addr);
 
-/* Set default sense codes
- *
- * @mpic:	controller
- * @senses:	array of sense codes
- * @count:	size of above array
- *
- * Optionally provide an array (indexed on hardware interrupt numbers
- * for this MPIC) of default sense codes for the chip. Those are linux
- * sense codes IRQ_TYPE_*
- *
- * The driver gets ownership of the pointer, don't dispose of it or
- * anything like that. __init only.
- */
-extern void mpic_set_default_senses(struct mpic *mpic, u8 *senses, int count);
-
 
 /* Initialize the controller. After this has been called, none of the above
  * should be called again for this mpic
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 665b0f8..395af13 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -872,21 +872,45 @@ int mpic_set_irq_type(struct irq_data *d, unsigned int flow_type)
 	if (src >= mpic->num_sources)
 		return -EINVAL;
 
+	vold = mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI));
+
+	/* We don't support "none" type */
 	if (flow_type == IRQ_TYPE_NONE)
-		if (mpic->senses && src < mpic->senses_count)
-			flow_type = mpic->senses[src];
-	if (flow_type == IRQ_TYPE_NONE)
-		flow_type = IRQ_TYPE_LEVEL_LOW;
+		flow_type = IRQ_TYPE_DEFAULT;
+
+	/* Default: read HW settings */
+	if (flow_type == IRQ_TYPE_DEFAULT) {
+		switch(vold & (MPIC_INFO(VECPRI_POLARITY_MASK) |
+			       MPIC_INFO(VECPRI_SENSE_MASK))) {
+			case MPIC_INFO(VECPRI_SENSE_EDGE) |
+			     MPIC_INFO(VECPRI_POLARITY_POSITIVE):
+				flow_type = IRQ_TYPE_EDGE_RISING;
+				break;
+			case MPIC_INFO(VECPRI_SENSE_EDGE) |
+			     MPIC_INFO(VECPRI_POLARITY_NEGATIVE):
+				flow_type = IRQ_TYPE_EDGE_FALLING;
+				break;
+			case MPIC_INFO(VECPRI_SENSE_LEVEL) |
+			     MPIC_INFO(VECPRI_POLARITY_POSITIVE):
+				flow_type = IRQ_TYPE_LEVEL_HIGH;
+				break;
+			case MPIC_INFO(VECPRI_SENSE_LEVEL) |
+			     MPIC_INFO(VECPRI_POLARITY_NEGATIVE):
+				flow_type = IRQ_TYPE_LEVEL_LOW;
+				break;
+		}
+	}
 
+	/* Apply to irq desc */
 	irqd_set_trigger_type(d, flow_type);
 
+	/* Apply to HW */
 	if (mpic_is_ht_interrupt(mpic, src))
 		vecpri = MPIC_VECPRI_POLARITY_POSITIVE |
 			MPIC_VECPRI_SENSE_EDGE;
 	else
 		vecpri = mpic_type_to_vecpri(mpic, flow_type);
 
-	vold = mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI));
 	vnew = vold & ~(MPIC_INFO(VECPRI_POLARITY_MASK) |
 			MPIC_INFO(VECPRI_SENSE_MASK));
 	vnew |= vecpri;
@@ -1022,7 +1046,7 @@ static int mpic_host_map(struct irq_domain *h, unsigned int virq,
 	irq_set_chip_and_handler(virq, chip, handle_fasteoi_irq);
 
 	/* Set default irq type */
-	irq_set_irq_type(virq, IRQ_TYPE_NONE);
+	irq_set_irq_type(virq, IRQ_TYPE_DEFAULT);
 
 	/* If the MPIC was reset, then all vectors have already been
 	 * initialized.  Otherwise, a per source lazy initialization
@@ -1413,12 +1437,6 @@ void __init mpic_assign_isu(struct mpic *mpic, unsigned int isu_num,
 		mpic->num_sources = isu_first + mpic->isu_size;
 }
 
-void __init mpic_set_default_senses(struct mpic *mpic, u8 *senses, int count)
-{
-	mpic->senses = senses;
-	mpic->senses_count = count;
-}
-
 void __init mpic_init(struct mpic *mpic)
 {
 	int i, cpu;

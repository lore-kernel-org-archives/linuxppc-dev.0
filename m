Return-Path: <bharat.bhushan@nxp.com>
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30087.outbound.protection.outlook.com [40.107.3.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41cPQc1X5ZzDqkJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2018 19:52:40 +1000 (AEST)
From: Bharat Bhushan <Bharat.Bhushan@nxp.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 oss@buserror.net, galak@kernel.crashing.org, mark.rutland@arm.com,
 kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: robh@kernel.org, keescook@chromium.org, tyreld@linux.vnet.ibm.com,
 joe@perches.com, Bharat Bhushan <Bharat.Bhushan@nxp.com>
Subject: [RFC 3/5] powerpc/mpic: Add support for non-contiguous irq ranges
Date: Fri, 27 Jul 2018 15:17:59 +0530
Message-Id: <1532684881-19310-4-git-send-email-Bharat.Bhushan@nxp.com>
In-Reply-To: <1532684881-19310-1-git-send-email-Bharat.Bhushan@nxp.com>
References: <1532684881-19310-1-git-send-email-Bharat.Bhushan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Freescale MPIC h/w may not support all interrupt sources reported
by hardware, "last-interrupt-source" or platform. On these platforms
a misconfigured device tree that assigns one of the reserved
interrupts leaves a non-functioning system without warning.

This patch adds "supported-irq-ranges" property in device tree to
provide the range of supported source of interrupts. If a reserved
interrupt used then it will not be programming h/w, which it does
currently, and through warning.

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
---
 .../devicetree/bindings/powerpc/fsl/mpic.txt       |   8 ++
 arch/powerpc/include/asm/mpic.h                    |   9 ++
 arch/powerpc/sysdev/mpic.c                         | 113 +++++++++++++++++++--
 3 files changed, 121 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/mpic.txt b/Documentation/devicetree/bindings/powerpc/fsl/mpic.txt
index dc57446..bd6da54 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/mpic.txt
+++ b/Documentation/devicetree/bindings/powerpc/fsl/mpic.txt
@@ -77,6 +77,14 @@ PROPERTIES
           in the global feature registers.  If specified, this field will
           override the value read from MPIC_GREG_FEATURE_LAST_SRC.
 
+ - supported-irq-ranges
+      Usage: optional
+      Value type: <prop-encoded-array>
+      Definition: This encodes arbitrary number of start-irq and end-irq
+          pairs, both including. Interrupt source supported by an MPIC
+          may not be contigous, in that case this property will be used
+          to pass supported source of interrupt ranges.
+
 INTERRUPT SPECIFIER DEFINITION
 
   Interrupt specifiers consists of 4 cells encoded as
diff --git a/arch/powerpc/include/asm/mpic.h b/arch/powerpc/include/asm/mpic.h
index fad8ddd..4080c98 100644
--- a/arch/powerpc/include/asm/mpic.h
+++ b/arch/powerpc/include/asm/mpic.h
@@ -252,6 +252,11 @@ struct mpic_irq_save {
 #endif
 };
 
+struct mpic_irq_range {
+	u32	start_irq;
+	u32	end_irq;
+};
+
 /* The instance data of a given MPIC */
 struct mpic
 {
@@ -281,6 +286,10 @@ struct mpic
 	/* Number of sources */
 	unsigned int		num_sources;
 
+	/* Supported source ranges */
+	unsigned int num_ranges;
+	struct mpic_irq_range	*irq_ranges;
+
 	/* vector numbers used for internal sources (ipi/timers) */
 	unsigned int		ipi_vecs[4];
 	unsigned int		timer_vecs[8];
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index d503887..cbf3a51 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -155,6 +155,23 @@ struct bus_type mpic_subsys = {
 
 #endif /* CONFIG_MPIC_WEIRD */
 
+static int mpic_irq_source_invalid(struct mpic *mpic, unsigned int irq)
+{
+	int i;
+
+	for (i = 0; i < mpic->num_ranges; i++) {
+		if ((irq >= mpic->irq_ranges[i].start_irq) &&
+			(irq <= mpic->irq_ranges[i].end_irq))
+			return 0;
+	}
+
+	/* if not supported irq-ranges then check for num_sources */
+	if (!mpic->num_ranges && irq < mpic->num_sources)
+		return 0;
+
+	return -EINVAL;
+}
+
 static inline unsigned int mpic_processor_id(struct mpic *mpic)
 {
 	unsigned int cpu = 0;
@@ -873,8 +890,10 @@ int mpic_set_irq_type(struct irq_data *d, unsigned int flow_type)
 	DBG("mpic: set_irq_type(mpic:@%p,virq:%d,src:0x%x,type:0x%x)\n",
 	    mpic, d->irq, src, flow_type);
 
-	if (src >= mpic->num_sources)
+	if (mpic_irq_source_invalid(mpic, src)) {
+		WARN(1, "mpic: Reserved IRQ source %d\n", src);
 		return -EINVAL;
+	}
 
 	vold = mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI));
 
@@ -933,8 +952,10 @@ void mpic_set_vector(unsigned int virq, unsigned int vector)
 	DBG("mpic: set_vector(mpic:@%p,virq:%d,src:%d,vector:0x%x)\n",
 	    mpic, virq, src, vector);
 
-	if (src >= mpic->num_sources)
+	if (mpic_irq_source_invalid(mpic, src)) {
+		WARN(1, "mpic: Reserved IRQ source %d\n", src);
 		return;
+	}
 
 	vecpri = mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI));
 	vecpri = vecpri & ~MPIC_INFO(VECPRI_VECTOR_MASK);
@@ -950,8 +971,10 @@ static void mpic_set_destination(unsigned int virq, unsigned int cpuid)
 	DBG("mpic: set_destination(mpic:@%p,virq:%d,src:%d,cpuid:0x%x)\n",
 	    mpic, virq, src, cpuid);
 
-	if (src >= mpic->num_sources)
+	if (mpic_irq_source_invalid(mpic, src)) {
+		WARN(1, "mpic: Reserved IRQ source %d\n", src);
 		return;
+	}
 
 	mpic_irq_write(src, MPIC_INFO(IRQ_DESTINATION), 1 << cpuid);
 }
@@ -1038,7 +1061,7 @@ static int mpic_host_map(struct irq_domain *h, unsigned int virq,
 	if (mpic_map_error_int(mpic, virq, hw))
 		return 0;
 
-	if (hw >= mpic->num_sources) {
+	if (mpic_irq_source_invalid(mpic, hw)) {
 		pr_warn("mpic: Mapping of source 0x%x failed, source out of range !\n",
 			(unsigned int)hw);
 		return -EINVAL;
@@ -1210,6 +1233,52 @@ u32 fsl_mpic_primary_get_version(void)
 	return 0;
 }
 
+static u32 mpic_last_irq_from_ranges(struct mpic *mpic)
+{
+	int i;
+	u32 last_irq = 0;
+
+	for (i = 0; i < mpic->num_ranges; i++)
+		if (last_irq < mpic->irq_ranges[i].end_irq)
+			last_irq = mpic->irq_ranges[i].end_irq;
+
+	return last_irq;
+}
+
+static int __init mpic_init_irq_ranges(struct mpic *mpic)
+{
+	const u32 *irq_ranges;
+	u32 len, count;
+	int i;
+
+	irq_ranges = of_get_property(mpic->node, "supported-irq-ranges", &len);
+	if (irq_ranges == NULL) {
+		pr_info("%s : supported-irq-ranges not found in mpic(%p)\n",
+			__func__, mpic->node);
+		return -1;
+	}
+
+	if (len % (2 * sizeof(u32)) != 0) {
+		pr_info("%s : incorrect irq ranges in mpic(%p)\n",
+			__func__, mpic->node);
+		return -1;
+	}
+
+	count = len / (2 * sizeof(u32));
+	mpic->irq_ranges = kcalloc(count, sizeof(struct mpic_irq_range),
+				   GFP_KERNEL);
+	if (mpic->irq_ranges == NULL)
+		return -1;
+
+	mpic->num_ranges = count;
+	for (i = 0; i < count; i++) {
+		mpic->irq_ranges[i].start_irq = *irq_ranges++;
+		mpic->irq_ranges[i].end_irq = *irq_ranges++;
+	}
+
+	return 0;
+}
+
 static int mpic_get_last_irq_source(struct mpic *mpic,
 				    unsigned int irq_count,
 				    unsigned int isu_size)
@@ -1219,14 +1288,18 @@ static int mpic_get_last_irq_source(struct mpic *mpic,
 
 	/* Current priority order for getting last irq:
 	 *  1) irq_count from platform
-	 *  2) "last-interrupt-source" from device tree
-	 *  3) isu_size from platform
-	 *  4) MPIC h/w GREG_FEATURE_0 register
+	 *  2) "supported-irq-ranges" from device tree
+	 *  3) "last-interrupt-source" from device tree
+	 *  4) isu_size from platform
+	 *  5) MPIC h/w GREG_FEATURE_0 register
 	 */
 
 	if (irq_count)
 		return (irq_count - 1);
 
+	if (!mpic_init_irq_ranges(mpic))
+		return mpic_last_irq_from_ranges(mpic);
+
 	if (!of_property_read_u32(mpic->node, "last-interrupt-source",
 				  &last_irq)) {
 		return last_irq;
@@ -1632,6 +1705,10 @@ void __init mpic_init(struct mpic *mpic)
 			u32 vecpri = MPIC_VECPRI_MASK | i |
 				(8 << MPIC_VECPRI_PRIORITY_SHIFT);
 
+			/* Skip if source irq not valid */
+			if (mpic_irq_source_invalid(mpic, i))
+				continue;
+
 			/* check if protected */
 			if (mpic->protected && test_bit(i, mpic->protected))
 				continue;
@@ -1732,9 +1809,14 @@ void mpic_setup_this_cpu(void)
 	 * values of irq_desc[].affinity in irq.c.
  	 */
 	if (distribute_irqs && !(mpic->flags & MPIC_SINGLE_DEST_CPU)) {
-	 	for (i = 0; i < mpic->num_sources ; i++)
+		for (i = 0; i < mpic->num_sources ; i++) {
+			/* Skip if irq source is not valid */
+			if (mpic_irq_source_invalid(mpic, i))
+				continue;
+
 			mpic_irq_write(i, MPIC_INFO(IRQ_DESTINATION),
 				mpic_irq_read(i, MPIC_INFO(IRQ_DESTINATION)) | msk);
+		}
 	}
 
 	/* Set current processor priority to 0 */
@@ -1772,9 +1854,14 @@ void mpic_teardown_this_cpu(int secondary)
 	raw_spin_lock_irqsave(&mpic_lock, flags);
 
 	/* let the mpic know we don't want intrs.  */
-	for (i = 0; i < mpic->num_sources ; i++)
+	for (i = 0; i < mpic->num_sources ; i++) {
+		/* Skip if irq not valid */
+		if (mpic_irq_source_invalid(mpic, i))
+			continue;
+
 		mpic_irq_write(i, MPIC_INFO(IRQ_DESTINATION),
 			mpic_irq_read(i, MPIC_INFO(IRQ_DESTINATION)) & ~msk);
+	}
 
 	/* Set current processor priority to max */
 	mpic_cpu_write(MPIC_INFO(CPU_CURRENT_TASK_PRI), 0xf);
@@ -1958,6 +2045,10 @@ static void mpic_suspend_one(struct mpic *mpic)
 	int i;
 
 	for (i = 0; i < mpic->num_sources; i++) {
+		/* Skip if irq source not valid */
+		if (mpic_irq_source_invalid(mpic, i))
+			continue;
+
 		mpic->save_data[i].vecprio =
 			mpic_irq_read(i, MPIC_INFO(IRQ_VECTOR_PRI));
 		mpic->save_data[i].dest =
@@ -1982,6 +2073,10 @@ static void mpic_resume_one(struct mpic *mpic)
 	int i;
 
 	for (i = 0; i < mpic->num_sources; i++) {
+		/* Skip if irq source not valid */
+		if (mpic_irq_source_invalid(mpic, i))
+			continue;
+
 		mpic_irq_write(i, MPIC_INFO(IRQ_VECTOR_PRI),
 			       mpic->save_data[i].vecprio);
 		mpic_irq_write(i, MPIC_INFO(IRQ_DESTINATION),
-- 
1.9.3

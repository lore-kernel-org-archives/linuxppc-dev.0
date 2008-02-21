Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 435D0DDE30
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2008 20:39:12 +1100 (EST)
Subject: [PATCH v2] mpic: make sparse happy
From: Johannes Berg <johannes@sipsolutions.net>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <91eb052edd9d5c608658fcdcfdc7589c@bga.com>
References: <91eb052edd9d5c608658fcdcfdc7589c@bga.com>
Content-Type: text/plain
Date: Thu, 21 Feb 2008 10:39:01 +0100
Message-Id: <1203586741.17534.128.camel@johannes.berg>
Mime-Version: 1.0
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I was running sparse on something else and noticed sparse warnings
and especially the bogus code that is fixed by the first hunk of
this patch, so I fixed them all while at it.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Milton Miller <miltonm@bga.com>
---
 arch/powerpc/sysdev/mpic.c |   32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

--- everything.orig/arch/powerpc/sysdev/mpic.c	2008-02-20 23:22:52.000000000 +0100
+++ everything/arch/powerpc/sysdev/mpic.c	2008-02-21 10:25:53.000000000 +0100
@@ -175,13 +175,16 @@ static inline void _mpic_write(enum mpic
 	switch(type) {
 #ifdef CONFIG_PPC_DCR
 	case mpic_access_dcr:
-		return dcr_write(rb->dhost, reg, value);
+		dcr_write(rb->dhost, reg, value);
+		break;
 #endif
 	case mpic_access_mmio_be:
-		return out_be32(rb->base + (reg >> 2), value);
+		out_be32(rb->base + (reg >> 2), value);
+		break;
 	case mpic_access_mmio_le:
 	default:
-		return out_le32(rb->base + (reg >> 2), value);
+		out_le32(rb->base + (reg >> 2), value);
+		break;
 	}
 }
 
@@ -1000,7 +1003,7 @@ struct mpic * __init mpic_alloc(struct d
 				const char *name)
 {
 	struct mpic	*mpic;
-	u32		reg;
+	u32		greg_feature;
 	const char	*vers;
 	int		i;
 	int		intvec_top;
@@ -1064,7 +1067,8 @@ struct mpic * __init mpic_alloc(struct d
 
 	/* Look for protected sources */
 	if (node) {
-		unsigned int psize, bits, mapsize;
+		int psize;
+		unsigned int bits, mapsize;
 		const u32 *psrc =
 			of_get_property(node, "protected-sources", &psize);
 		if (psrc) {
@@ -1107,8 +1111,7 @@ struct mpic * __init mpic_alloc(struct d
 	 * in, try to obtain one
 	 */
 	if (paddr == 0 && !(mpic->flags & MPIC_USES_DCR)) {
-		const u32 *reg;
-		reg = of_get_property(node, "reg", NULL);
+		const u32 *reg = of_get_property(node, "reg", NULL);
 		BUG_ON(reg == NULL);
 		paddr = of_translate_address(node, reg);
 		BUG_ON(paddr == OF_BAD_ADDR);
@@ -1137,12 +1140,13 @@ struct mpic * __init mpic_alloc(struct d
 	 * MPICs, num sources as well. On ISU MPICs, sources are counted
 	 * as ISUs are added
 	 */
-	reg = mpic_read(mpic->gregs, MPIC_INFO(GREG_FEATURE_0));
-	mpic->num_cpus = ((reg & MPIC_GREG_FEATURE_LAST_CPU_MASK)
+	greg_feature = mpic_read(mpic->gregs, MPIC_INFO(GREG_FEATURE_0));
+	mpic->num_cpus = ((greg_feature & MPIC_GREG_FEATURE_LAST_CPU_MASK)
 			  >> MPIC_GREG_FEATURE_LAST_CPU_SHIFT) + 1;
 	if (isu_size == 0)
-		mpic->num_sources = ((reg & MPIC_GREG_FEATURE_LAST_SRC_MASK)
-				     >> MPIC_GREG_FEATURE_LAST_SRC_SHIFT) + 1;
+		mpic->num_sources =
+			((greg_feature & MPIC_GREG_FEATURE_LAST_SRC_MASK)
+			 >> MPIC_GREG_FEATURE_LAST_SRC_SHIFT) + 1;
 
 	/* Map the per-CPU registers */
 	for (i = 0; i < mpic->num_cpus; i++) {
@@ -1161,7 +1165,7 @@ struct mpic * __init mpic_alloc(struct d
 	mpic->isu_mask = (1 << mpic->isu_shift) - 1;
 
 	/* Display version */
-	switch (reg & MPIC_GREG_FEATURE_VERSION_MASK) {
+	switch (greg_feature & MPIC_GREG_FEATURE_VERSION_MASK) {
 	case 1:
 		vers = "1.0";
 		break;
@@ -1321,7 +1325,7 @@ void __init mpic_set_serial_int(struct m
 
 void mpic_irq_set_priority(unsigned int irq, unsigned int pri)
 {
-	int is_ipi;
+	unsigned int is_ipi;
 	struct mpic *mpic = mpic_find(irq, &is_ipi);
 	unsigned int src = mpic_irq_to_hw(irq);
 	unsigned long flags;
@@ -1344,7 +1348,7 @@ void mpic_irq_set_priority(unsigned int 
 
 unsigned int mpic_irq_get_priority(unsigned int irq)
 {
-	int is_ipi;
+	unsigned int is_ipi;
 	struct mpic *mpic = mpic_find(irq, &is_ipi);
 	unsigned int src = mpic_irq_to_hw(irq);
 	unsigned long flags;

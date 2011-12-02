Return-Path: <Kyle.D.Moffett@boeing.com>
Received: from border.exmeritus.com (border.exmeritus.com
 [IPv6:2002:46a7:f11a:ffff::])
 by ozlabs.org (Postfix) with ESMTP id 3FC7B100C05
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Dec 2011 03:29:17 +1100 (EST)
From: Kyle Moffett <Kyle.D.Moffett@boeing.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v3 09/10] powerpc/mpic: Cache the device-tree node in "struct
 mpic"
Date: Fri,  2 Dec 2011 11:28:06 -0500
Message-Id: <1322843287-2745-10-git-send-email-Kyle.D.Moffett@boeing.com>
In-Reply-To: <1322795058.3729.48.camel@pasglop>
References: <1322795058.3729.48.camel@pasglop>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <michaele@au1.ibm.com>,
 Kyle Moffett <Kyle.D.Moffett@boeing.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Store the node pointer in the MPIC during initialization so that all of
the later operational code can just reuse the cached pointer.

Signed-off-by: Kyle Moffett <Kyle.D.Moffett@boeing.com>
---
 arch/powerpc/include/asm/mpic.h |    3 +++
 arch/powerpc/sysdev/mpic.c      |   33 ++++++++++++++++-----------------
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/mpic.h b/arch/powerpc/include/asm/mpic.h
index b9d2c0f..67b4d98 100644
--- a/arch/powerpc/include/asm/mpic.h
+++ b/arch/powerpc/include/asm/mpic.h
@@ -251,6 +251,9 @@ struct mpic_irq_save {
 /* The instance data of a given MPIC */
 struct mpic
 {
+	/* The OpenFirmware dt node for this MPIC */
+	struct device_node *node;
+
 	/* The remapper for this MPIC */
 	struct irq_host		*irqhost;
 
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 3240bba..7611060 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -315,26 +315,25 @@ static void _mpic_map_mmio(struct mpic *mpic, phys_addr_t phys_addr,
 }
 
 #ifdef CONFIG_PPC_DCR
-static void _mpic_map_dcr(struct mpic *mpic, struct device_node *node,
-			  struct mpic_reg_bank *rb,
+static void _mpic_map_dcr(struct mpic *mpic, struct mpic_reg_bank *rb,
 			  unsigned int offset, unsigned int size)
 {
-	phys_addr_t phys_addr = dcr_resource_start(node, 0);
+	phys_addr_t phys_addr = dcr_resource_start(mpic->node, 0);
 	rb->dhost = dcr_map(mpic->node, phys_addr + offset, size);
 	BUG_ON(!DCR_MAP_OK(rb->dhost));
 }
 
-static inline void mpic_map(struct mpic *mpic, struct device_node *node,
+static inline void mpic_map(struct mpic *mpic,
 			    phys_addr_t phys_addr, struct mpic_reg_bank *rb,
 			    unsigned int offset, unsigned int size)
 {
 	if (mpic->flags & MPIC_USES_DCR)
-		_mpic_map_dcr(mpic, node, rb, offset, size);
+		_mpic_map_dcr(mpic, rb, offset, size);
 	else
 		_mpic_map_mmio(mpic, phys_addr, rb, offset, size);
 }
 #else /* CONFIG_PPC_DCR */
-#define mpic_map(m,n,p,b,o,s)	_mpic_map_mmio(m,p,b,o,s)
+#define mpic_map(m,p,b,o,s)	_mpic_map_mmio(m,p,b,o,s)
 #endif /* !CONFIG_PPC_DCR */
 
 
@@ -1172,6 +1171,7 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 		goto err_of_node_put;
 
 	mpic->name = name;
+	mpic->node = node;
 	mpic->paddr = phys_addr;
 
 	mpic->hc_irq = mpic_irq_chip;
@@ -1218,13 +1218,13 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	mpic->spurious_vec  = intvec_top;
 
 	/* Check for "big-endian" in device-tree */
-	if (of_get_property(node, "big-endian", NULL) != NULL)
+	if (of_get_property(mpic->node, "big-endian", NULL) != NULL)
 		mpic->flags |= MPIC_BIG_ENDIAN;
-	if (of_device_is_compatible(node, "fsl,mpic"))
+	if (of_device_is_compatible(mpic->node, "fsl,mpic"))
 		mpic->flags |= MPIC_FSL;
 
 	/* Look for protected sources */
-	psrc = of_get_property(node, "protected-sources", &psize);
+	psrc = of_get_property(mpic->node, "protected-sources", &psize);
 	if (psrc) {
 		/* Allocate a bitmap with one bit per interrupt */
 		unsigned int mapsize = BITS_TO_LONGS(intvec_top + 1);
@@ -1259,15 +1259,15 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 #endif
 
 	/* Map the global registers */
-	mpic_map(mpic, node, mpic->paddr, &mpic->gregs, MPIC_INFO(GREG_BASE), 0x1000);
-	mpic_map(mpic, node, mpic->paddr, &mpic->tmregs, MPIC_INFO(TIMER_BASE), 0x1000);
+	mpic_map(mpic, mpic->paddr, &mpic->gregs, MPIC_INFO(GREG_BASE), 0x1000);
+	mpic_map(mpic, mpic->paddr, &mpic->tmregs, MPIC_INFO(TIMER_BASE), 0x1000);
 
 	/* Reset */
 
 	/* When using a device-node, reset requests are only honored if the MPIC
 	 * is allowed to reset.
 	 */
-	if (of_get_property(node, "pic-no-reset", NULL))
+	if (of_get_property(mpic->node, "pic-no-reset", NULL))
 		mpic->flags |= MPIC_NO_RESET;
 
 	if ((flags & MPIC_WANTS_RESET) && !(mpic->flags & MPIC_NO_RESET)) {
@@ -1315,7 +1315,7 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	for_each_possible_cpu(i) {
 		unsigned int cpu = get_hard_smp_processor_id(i);
 
-		mpic_map(mpic, node, mpic->paddr, &mpic->cpuregs[cpu],
+		mpic_map(mpic, mpic->paddr, &mpic->cpuregs[cpu],
 			 MPIC_INFO(CPU_BASE) + cpu * MPIC_INFO(CPU_STRIDE),
 			 0x1000);
 	}
@@ -1323,13 +1323,13 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	/* Initialize main ISU if none provided */
 	if (mpic->isu_size == 0) {
 		mpic->isu_size = mpic->num_sources;
-		mpic_map(mpic, node, mpic->paddr, &mpic->isus[0],
+		mpic_map(mpic, mpic->paddr, &mpic->isus[0],
 			 MPIC_INFO(IRQ_BASE), MPIC_INFO(IRQ_STRIDE) * mpic->isu_size);
 	}
 	mpic->isu_shift = 1 + __ilog2(mpic->isu_size - 1);
 	mpic->isu_mask = (1 << mpic->isu_shift) - 1;
 
-	mpic->irqhost = irq_alloc_host(node, IRQ_HOST_MAP_LINEAR,
+	mpic->irqhost = irq_alloc_host(mpic->node, IRQ_HOST_MAP_LINEAR,
 				       isu_size ? isu_size : mpic->num_sources,
 				       &mpic_host_ops,
 				       flags & MPIC_LARGE_VECTORS ? 2048 : 256);
@@ -1372,7 +1372,6 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 		irq_set_default_host(mpic->irqhost);
 	}
 
-	of_node_put(node);
 	return mpic;
 
 err_of_node_put:
@@ -1387,7 +1386,7 @@ void __init mpic_assign_isu(struct mpic *mpic, unsigned int isu_num,
 
 	BUG_ON(isu_num >= MPIC_MAX_ISU);
 
-	mpic_map(mpic, mpic->irqhost->of_node,
+	mpic_map(mpic,
 		 paddr, &mpic->isus[isu_num], 0,
 		 MPIC_INFO(IRQ_STRIDE) * mpic->isu_size);
 
-- 
1.7.2.5

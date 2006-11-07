Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 07 Nov 2006 18:22:41 +1100
Subject: [PATCH 10/31] powerpc: Improve MPIC driver auto-configuration from DT
In-Reply-To: <1162884150.435786.961370643810.qpush@grosgo>
Message-Id: <20061107072358.7FD6B6815D@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch applies on top of the MPIC DCR support. It makes the MPIC
driver capable of a lot more auto-configuration based on the device-tree,
for example, it can retreive it's own physical address if not passed as
an argument, find out if it's DCR or MMIO mapped, and set the BIG_ENDIAN
flag automatically in the presence of a "big-endian" property in the
device-tree node.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 arch/powerpc/sysdev/mpic.c |   50 +++++++++++++++++++++++++++++++++------------
 include/asm-powerpc/mpic.h |    4 +--
 2 files changed, 39 insertions(+), 15 deletions(-)

Index: linux-cell/arch/powerpc/sysdev/mpic.c
===================================================================
--- linux-cell.orig/arch/powerpc/sysdev/mpic.c	2006-11-06 14:34:17.000000000 +1100
+++ linux-cell/arch/powerpc/sysdev/mpic.c	2006-11-06 14:36:45.000000000 +1100
@@ -894,7 +894,7 @@ static struct irq_host_ops mpic_host_ops
  */
 
 struct mpic * __init mpic_alloc(struct device_node *node,
-				unsigned long phys_addr,
+				phys_addr_t phys_addr,
 				unsigned int flags,
 				unsigned int isu_size,
 				unsigned int irq_count,
@@ -904,6 +904,7 @@ struct mpic * __init mpic_alloc(struct d
 	u32		reg;
 	const char	*vers;
 	int		i;
+	u64		paddr = phys_addr;
 
 	mpic = alloc_bootmem(sizeof(struct mpic));
 	if (mpic == NULL)
@@ -943,6 +944,11 @@ struct mpic * __init mpic_alloc(struct d
 	mpic->irq_count = irq_count;
 	mpic->num_sources = 0; /* so far */
 
+	/* Check for "big-endian" in device-tree */
+	if (node && get_property(node, "big-endian", NULL) != NULL)
+		mpic->flags |= MPIC_BIG_ENDIAN;
+
+
 #ifdef CONFIG_MPIC_WEIRD
 	mpic->hw_set = mpic_infos[MPIC_GET_REGSET(flags)];
 #endif
@@ -951,11 +957,17 @@ struct mpic * __init mpic_alloc(struct d
 	mpic->reg_type = (flags & MPIC_BIG_ENDIAN) ?
 		mpic_access_mmio_be : mpic_access_mmio_le;
 
+	/* If no physical address is passed in, a device-node is mandatory */
+	BUG_ON(paddr == 0 && node == NULL);
+
+	/* If no physical address passed in, check if it's dcr based */
+	if (paddr == 0 && get_property(node, "dcr-reg", NULL) != NULL)
+		mpic->flags |= MPIC_USES_DCR;
+
 #ifdef CONFIG_PPC_DCR
 	if (mpic->flags & MPIC_USES_DCR) {
 		const u32 *dbasep;
-		BUG_ON(mpic->of_node == NULL);
-		dbasep = get_property(mpic->of_node, "dcr-reg", NULL);
+		dbasep = get_property(node, "dcr-reg", NULL);
 		BUG_ON(dbasep == NULL);
 		mpic->dcr_base = *dbasep;
 		mpic->reg_type = mpic_access_dcr;
@@ -964,9 +976,20 @@ struct mpic * __init mpic_alloc(struct d
 	BUG_ON (mpic->flags & MPIC_USES_DCR);
 #endif /* CONFIG_PPC_DCR */
 
+	/* If the MPIC is not DCR based, and no physical address was passed
+	 * in, try to obtain one
+	 */
+	if (paddr == 0 && !(mpic->flags & MPIC_USES_DCR)) {
+		const u32 *reg;
+		reg = get_property(node, "reg", NULL);
+		BUG_ON(reg == NULL);
+		paddr = of_translate_address(node, reg);
+		BUG_ON(paddr == OF_BAD_ADDR);
+	}
+
 	/* Map the global registers */
-	mpic_map(mpic, phys_addr, &mpic->gregs, MPIC_INFO(GREG_BASE), 0x1000);
-	mpic_map(mpic, phys_addr, &mpic->tmregs, MPIC_INFO(TIMER_BASE), 0x1000);
+	mpic_map(mpic, paddr, &mpic->gregs, MPIC_INFO(GREG_BASE), 0x1000);
+	mpic_map(mpic, paddr, &mpic->tmregs, MPIC_INFO(TIMER_BASE), 0x1000);
 
 	/* Reset */
 	if (flags & MPIC_WANTS_RESET) {
@@ -991,7 +1014,7 @@ struct mpic * __init mpic_alloc(struct d
 
 	/* Map the per-CPU registers */
 	for (i = 0; i < mpic->num_cpus; i++) {
-		mpic_map(mpic, phys_addr, &mpic->cpuregs[i],
+		mpic_map(mpic, paddr, &mpic->cpuregs[i],
 			 MPIC_INFO(CPU_BASE) + i * MPIC_INFO(CPU_STRIDE),
 			 0x1000);
 	}
@@ -999,7 +1022,7 @@ struct mpic * __init mpic_alloc(struct d
 	/* Initialize main ISU if none provided */
 	if (mpic->isu_size == 0) {
 		mpic->isu_size = mpic->num_sources;
-		mpic_map(mpic, phys_addr, &mpic->isus[0],
+		mpic_map(mpic, paddr, &mpic->isus[0],
 			 MPIC_INFO(IRQ_BASE), MPIC_INFO(IRQ_STRIDE) * mpic->isu_size);
 	}
 	mpic->isu_shift = 1 + __ilog2(mpic->isu_size - 1);
@@ -1020,10 +1043,11 @@ struct mpic * __init mpic_alloc(struct d
 		vers = "<unknown>";
 		break;
 	}
-	printk(KERN_INFO "mpic: Setting up MPIC \"%s\" version %s at %lx, max %d CPUs\n",
-	       name, vers, phys_addr, mpic->num_cpus);
-	printk(KERN_INFO "mpic: ISU size: %d, shift: %d, mask: %x\n", mpic->isu_size,
-	       mpic->isu_shift, mpic->isu_mask);
+	printk(KERN_INFO "mpic: Setting up MPIC \"%s\" version %s at %llx,"
+	       " max %d CPUs\n",
+	       name, vers, (unsigned long long)paddr, mpic->num_cpus);
+	printk(KERN_INFO "mpic: ISU size: %d, shift: %d, mask: %x\n",
+	       mpic->isu_size, mpic->isu_shift, mpic->isu_mask);
 
 	mpic->next = mpics;
 	mpics = mpic;
@@ -1037,13 +1061,13 @@ struct mpic * __init mpic_alloc(struct d
 }
 
 void __init mpic_assign_isu(struct mpic *mpic, unsigned int isu_num,
-			    unsigned long phys_addr)
+			    phys_addr_t paddr)
 {
 	unsigned int isu_first = isu_num * mpic->isu_size;
 
 	BUG_ON(isu_num >= MPIC_MAX_ISU);
 
-	mpic_map(mpic, phys_addr, &mpic->isus[isu_num], 0,
+	mpic_map(mpic, paddr, &mpic->isus[isu_num], 0,
 		 MPIC_INFO(IRQ_STRIDE) * mpic->isu_size);
 	if ((isu_first + mpic->isu_size) > mpic->num_sources)
 		mpic->num_sources = isu_first + mpic->isu_size;
Index: linux-cell/include/asm-powerpc/mpic.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/mpic.h	2006-11-06 14:34:17.000000000 +1100
+++ linux-cell/include/asm-powerpc/mpic.h	2006-11-06 14:34:38.000000000 +1100
@@ -364,7 +364,7 @@ struct mpic
  * that is senses[0] correspond to linux irq "irq_offset".
  */
 extern struct mpic *mpic_alloc(struct device_node *node,
-			       unsigned long phys_addr,
+			       phys_addr_t phys_addr,
 			       unsigned int flags,
 			       unsigned int isu_size,
 			       unsigned int irq_count,
@@ -377,7 +377,7 @@ extern struct mpic *mpic_alloc(struct de
  * @phys_addr:	physical address of the ISU
  */
 extern void mpic_assign_isu(struct mpic *mpic, unsigned int isu_num,
-			    unsigned long phys_addr);
+			    phys_addr_t phys_addr);
 
 /* Set default sense codes
  *

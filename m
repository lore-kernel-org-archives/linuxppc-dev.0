Return-Path: <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: MPIC init get address from device-tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Mon, 16 Oct 2006 17:45:06 +1000
Message-Id: <1160984706.22522.63.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "cbe-oss-dev@ozlabs.org" <cbe-oss-dev@ozlabs.org>
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


Index: linux-cell/arch/powerpc/sysdev/mpic.c
===================================================================
--- linux-cell.orig/arch/powerpc/sysdev/mpic.c	2006-10-16 17:29:50.000000000 +1000
+++ linux-cell/arch/powerpc/sysdev/mpic.c	2006-10-16 17:29:57.000000000 +1000
@@ -943,6 +943,11 @@ struct mpic * __init mpic_alloc(struct d
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
@@ -951,11 +956,17 @@ struct mpic * __init mpic_alloc(struct d
 	mpic->reg_type = (flags & MPIC_BIG_ENDIAN) ?
 		mpic_access_mmio_be : mpic_access_mmio_le;
 
+	/* If no physical address is passed in, a device-node is mandatory */
+	BUG_ON(phys_addr == 0 && node == NULL);
+
+	/* If no physical address passed in, check if it's dcr based */
+	if (phys_addr == 0 && get_property(node, "dcr-reg", NULL) != NULL)
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
@@ -964,6 +975,17 @@ struct mpic * __init mpic_alloc(struct d
 	BUG_ON (mpic->flags & MPIC_USES_DCR);
 #endif /* CONFIG_PPC_DCR */
 
+	/* If the MPIC is not DCR based, and no physical address was passed
+	 * in, try to obtain one
+	 */
+	if (phys_addr == 0 && !(mpic->flags & MPIC_USES_DCR)) {
+		const u32 *reg;
+		reg = get_property(node, "reg", NULL);
+		BUG_ON(reg == NULL);
+		phys_addr = of_translate_address(node, reg);
+		BUG_ON(phys_addr == OF_BAD_ADDR);
+	}
+
 	/* Map the global registers */
 	mpic_map(mpic, phys_addr, &mpic->gregs, MPIC_INFO(GREG_BASE), 0x1000);
 	mpic_map(mpic, phys_addr, &mpic->tmregs, MPIC_INFO(TIMER_BASE), 0x1000);

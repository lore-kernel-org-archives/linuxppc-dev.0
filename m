Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <cdcb4a9477581e28def3ccc8dab5427d0662b0ba.1182493056.git.michael@ellerman.id.au>
In-Reply-To: <3cdc6bd05b505600609a79667f3674168e2e855b.1182493056.git.michael@ellerman.id.au>
References: <3cdc6bd05b505600609a79667f3674168e2e855b.1182493056.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 2/5] Update mpic to use dcr_host_t.base
Date: Fri, 22 Jun 2007 16:18:08 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that dcr_host_t contains the base address, we can use that in the mpic
code, rather than storing it separately.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/sysdev/mpic.c |   28 +++++++++++-----------------
 include/asm-powerpc/mpic.h |    6 ------
 2 files changed, 11 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 75aad38..6c2e467 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -156,8 +156,7 @@ static inline u32 _mpic_read(enum mpic_reg_type type,
 	switch(type) {
 #ifdef CONFIG_PPC_DCR
 	case mpic_access_dcr:
-		return dcr_read(rb->dhost,
-				rb->dbase + reg + rb->doff);
+		return dcr_read(rb->dhost, rb->dhost.base + reg);
 #endif
 	case mpic_access_mmio_be:
 		return in_be32(rb->base + (reg >> 2));
@@ -174,8 +173,7 @@ static inline void _mpic_write(enum mpic_reg_type type,
 	switch(type) {
 #ifdef CONFIG_PPC_DCR
 	case mpic_access_dcr:
-		return dcr_write(rb->dhost,
-				 rb->dbase + reg + rb->doff, value);
+		return dcr_write(rb->dhost, rb->dhost.base + reg, value);
 #endif
 	case mpic_access_mmio_be:
 		return out_be32(rb->base + (reg >> 2), value);
@@ -269,9 +267,11 @@ static void _mpic_map_mmio(struct mpic *mpic, unsigned long phys_addr,
 static void _mpic_map_dcr(struct mpic *mpic, struct mpic_reg_bank *rb,
 			  unsigned int offset, unsigned int size)
 {
-	rb->dbase = mpic->dcr_base;
-	rb->doff = offset;
-	rb->dhost = dcr_map(mpic->of_node, rb->dbase + rb->doff, size);
+	const u32 *dbasep;
+
+	dbasep = of_get_property(mpic->of_node, "dcr-reg", NULL);
+
+	rb->dhost = dcr_map(mpic->of_node, *dbasep + offset, size);
 	BUG_ON(!DCR_MAP_OK(rb->dhost));
 }
 
@@ -1047,20 +1047,14 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	BUG_ON(paddr == 0 && node == NULL);
 
 	/* If no physical address passed in, check if it's dcr based */
-	if (paddr == 0 && of_get_property(node, "dcr-reg", NULL) != NULL)
-		mpic->flags |= MPIC_USES_DCR;
-
+	if (paddr == 0 && of_get_property(node, "dcr-reg", NULL) != NULL) {
 #ifdef CONFIG_PPC_DCR
-	if (mpic->flags & MPIC_USES_DCR) {
-		const u32 *dbasep;
-		dbasep = of_get_property(node, "dcr-reg", NULL);
-		BUG_ON(dbasep == NULL);
-		mpic->dcr_base = *dbasep;
+		mpic->flags |= MPIC_USES_DCR;
 		mpic->reg_type = mpic_access_dcr;
-	}
 #else
-	BUG_ON (mpic->flags & MPIC_USES_DCR);
+		BUG();
 #endif /* CONFIG_PPC_DCR */
+	}
 
 	/* If the MPIC is not DCR based, and no physical address was passed
 	 * in, try to obtain one
diff --git a/include/asm-powerpc/mpic.h b/include/asm-powerpc/mpic.h
index 2ffb06a..11b8e51 100644
--- a/include/asm-powerpc/mpic.h
+++ b/include/asm-powerpc/mpic.h
@@ -224,8 +224,6 @@ struct mpic_reg_bank {
 	u32 __iomem	*base;
 #ifdef CONFIG_PPC_DCR
 	dcr_host_t	dhost;
-	unsigned int	dbase;
-	unsigned int	doff;
 #endif /* CONFIG_PPC_DCR */
 };
 
@@ -292,10 +290,6 @@ struct mpic
 	struct mpic_reg_bank	cpuregs[MPIC_MAX_CPUS];
 	struct mpic_reg_bank	isus[MPIC_MAX_ISU];
 
-#ifdef CONFIG_PPC_DCR
-	unsigned int		dcr_base;
-#endif
-
 #ifdef CONFIG_MPIC_WEIRD
 	/* Pointer to HW info array */
 	u32			*hw_set;
-- 
1.5.1.3.g7a33b

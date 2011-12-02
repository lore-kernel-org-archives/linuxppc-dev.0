Return-Path: <Kyle.D.Moffett@boeing.com>
Received: from border.exmeritus.com (border.exmeritus.com
 [IPv6:2002:46a7:f11a:ffff::])
 by ozlabs.org (Postfix) with ESMTP id A372A100B25
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Dec 2011 03:29:12 +1100 (EST)
From: Kyle Moffett <Kyle.D.Moffett@boeing.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v3 03/10] powerpc/mpic: Assume a device-node was passed in
 mpic_alloc()
Date: Fri,  2 Dec 2011 11:28:00 -0500
Message-Id: <1322843287-2745-4-git-send-email-Kyle.D.Moffett@boeing.com>
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

All of the existing callers of mpic_alloc() pass in a non-NULL
device-node pointer, so the checks for a NULL device-node may be
removed.

Signed-off-by: Kyle Moffett <Kyle.D.Moffett@boeing.com>
---
 arch/powerpc/sysdev/mpic.c |   50 ++++++++++++++++++-------------------------
 1 files changed, 21 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 8f24c6e..59564dc 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1137,19 +1137,17 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 				unsigned int irq_count,
 				const char *name)
 {
-	struct mpic	*mpic;
-	u32		greg_feature;
-	const char	*vers;
-	int		i;
-	int		intvec_top;
+	int i, psize, intvec_top;
+	struct mpic *mpic;
+	u32 greg_feature;
+	const char *vers;
+	const u32 *psrc;
 
-	/*
-	 * If no phyiscal address was specified then all of the phyiscal
-	 * addressing parameters must come from the device-tree.
-	 */
-	if (!phys_addr) {
-		BUG_ON(!node);
+	/* This code assumes that a non-NULL device node is passed in */
+	BUG_ON(!node);
 
+	/* Pick the physical address from the device tree if unspecified */
+	if (!phys_addr) {
 		/* Check if it is DCR-based */
 		if (of_get_property(node, "dcr-reg", NULL)) {
 			flags |= MPIC_USES_DCR;
@@ -1211,28 +1209,22 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	mpic->spurious_vec  = intvec_top;
 
 	/* Check for "big-endian" in device-tree */
-	if (node && of_get_property(node, "big-endian", NULL) != NULL)
+	if (of_get_property(node, "big-endian", NULL) != NULL)
 		mpic->flags |= MPIC_BIG_ENDIAN;
-	if (node && of_device_is_compatible(node, "fsl,mpic"))
+	if (of_device_is_compatible(node, "fsl,mpic"))
 		mpic->flags |= MPIC_FSL;
 
 	/* Look for protected sources */
-	if (node) {
-		int psize;
-		unsigned int bits, mapsize;
-		const u32 *psrc =
-			of_get_property(node, "protected-sources", &psize);
-		if (psrc) {
-			psize /= 4;
-			bits = intvec_top + 1;
-			mapsize = BITS_TO_LONGS(bits) * sizeof(unsigned long);
-			mpic->protected = kzalloc(mapsize, GFP_KERNEL);
-			BUG_ON(mpic->protected == NULL);
-			for (i = 0; i < psize; i++) {
-				if (psrc[i] > intvec_top)
-					continue;
-				__set_bit(psrc[i], mpic->protected);
-			}
+	psrc = of_get_property(node, "protected-sources", &psize);
+	if (psrc) {
+		/* Allocate a bitmap with one bit per interrupt */
+		unsigned int mapsize = BITS_TO_LONGS(intvec_top + 1);
+		mpic->protected = kzalloc(mapsize*sizeof(long), GFP_KERNEL);
+		BUG_ON(mpic->protected == NULL);
+		for (i = 0; i < psize/sizeof(u32); i++) {
+			if (psrc[i] > intvec_top)
+				continue;
+			__set_bit(psrc[i], mpic->protected);
 		}
 	}
 
-- 
1.7.2.5

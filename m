Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 34D92DDF08
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2008 05:32:36 +1100 (EST)
Subject: [PATCH] mpic: make sparse happy
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Wed, 20 Feb 2008 12:31:44 +0100
Message-Id: <1203507104.17534.32.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
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
---
 arch/powerpc/sysdev/mpic.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

--- everything.orig/arch/powerpc/sysdev/mpic.c	2008-02-20 12:25:41.000000000 +0100
+++ everything/arch/powerpc/sysdev/mpic.c	2008-02-20 12:28:37.000000000 +0100
@@ -175,13 +175,13 @@ static inline void _mpic_write(enum mpic
 	switch(type) {
 #ifdef CONFIG_PPC_DCR
 	case mpic_access_dcr:
-		return dcr_write(rb->dhost, reg, value);
+		dcr_write(rb->dhost, reg, value);
 #endif
 	case mpic_access_mmio_be:
-		return out_be32(rb->base + (reg >> 2), value);
+		out_be32(rb->base + (reg >> 2), value);
 	case mpic_access_mmio_le:
 	default:
-		return out_le32(rb->base + (reg >> 2), value);
+		out_le32(rb->base + (reg >> 2), value);
 	}
 }
 
@@ -1064,7 +1064,8 @@ struct mpic * __init mpic_alloc(struct d
 
 	/* Look for protected sources */
 	if (node) {
-		unsigned int psize, bits, mapsize;
+		int psize;
+		unsigned int bits, mapsize;
 		const u32 *psrc =
 			of_get_property(node, "protected-sources", &psize);
 		if (psrc) {
@@ -1107,10 +1108,10 @@ struct mpic * __init mpic_alloc(struct d
 	 * in, try to obtain one
 	 */
 	if (paddr == 0 && !(mpic->flags & MPIC_USES_DCR)) {
-		const u32 *reg;
-		reg = of_get_property(node, "reg", NULL);
-		BUG_ON(reg == NULL);
-		paddr = of_translate_address(node, reg);
+		const u32 *regprop;
+		regprop = of_get_property(node, "reg", NULL);
+		BUG_ON(regprop == NULL);
+		paddr = of_translate_address(node, regprop);
 		BUG_ON(paddr == OF_BAD_ADDR);
 	}
 
@@ -1321,7 +1322,7 @@ void __init mpic_set_serial_int(struct m
 
 void mpic_irq_set_priority(unsigned int irq, unsigned int pri)
 {
-	int is_ipi;
+	unsigned int is_ipi;
 	struct mpic *mpic = mpic_find(irq, &is_ipi);
 	unsigned int src = mpic_irq_to_hw(irq);
 	unsigned long flags;
@@ -1344,7 +1345,7 @@ void mpic_irq_set_priority(unsigned int 
 
 unsigned int mpic_irq_get_priority(unsigned int irq)
 {
-	int is_ipi;
+	unsigned int is_ipi;
 	struct mpic *mpic = mpic_find(irq, &is_ipi);
 	unsigned int src = mpic_irq_to_hw(irq);
 	unsigned long flags;

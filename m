Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6413EDDECE
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jul 2007 09:55:31 +1000 (EST)
Subject: [PATCH] powerpc: mpic protected sources
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@au1.ibm.com>
In-Reply-To: <OFD54BD0CE.6883770C-ONC125731D.00322C4C-C125731D.00324A9E@de.ibm.com>
References: <OFD54BD0CE.6883770C-ONC125731D.00322C4C-C125731D.00324A9E@de.ibm.com>
Content-Type: text/plain
Date: Sat, 21 Jul 2007 09:55:21 +1000
Message-Id: <1184975721.5439.33.camel@localhost.localdomain>
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

Some HW platforms, such as the new cell blades, requires some MPIC sources
to be left alone by the operating system. This patch implements support for
a "protected-sources" property in the mpic controller node containing a list
of source numbers to be protected against operating system interference.

For those interested in the gory details, the MPIC on the southbridge of
those blades has some of the processor outputs routed to the cell, and
at least one routed as a GPIO to the service processor. It will be used
in the GA product for routing some of the southbridge error interrupts
to the service processor which implements some of the RAS stuff, such
as checkstopping when fatal errors occurs before they can propagate.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Should probably go in 2.6.23, whether it's a bug fix or not is debatable,
it's part of a late HW+SW+FW fix of the blades for reliability purposes.

Index: linux-work/arch/powerpc/sysdev/mpic.c
===================================================================
--- linux-work.orig/arch/powerpc/sysdev/mpic.c	2007-07-19 17:00:32.000000000 +1000
+++ linux-work/arch/powerpc/sysdev/mpic.c	2007-07-19 17:25:21.000000000 +1000
@@ -877,6 +877,8 @@ static int mpic_host_map(struct irq_host
 
 	if (hw == mpic->spurious_vec)
 		return -EINVAL;
+	if (mpic->protected && test_bit(hw, mpic->protected))
+		return -EINVAL;
 
 #ifdef CONFIG_SMP
 	else if (hw >= mpic->ipi_vecs[0]) {
@@ -1034,6 +1036,25 @@ struct mpic * __init mpic_alloc(struct d
 	if (node && of_get_property(node, "big-endian", NULL) != NULL)
 		mpic->flags |= MPIC_BIG_ENDIAN;
 
+	/* Look for protected sources */
+	if (node) {
+		unsigned int psize, bits, mapsize;
+		const u32 *psrc =
+			of_get_property(node, "protected-sources", &psize);
+		if (psrc) {
+			psize /= 4;
+			bits = intvec_top + 1;
+			mapsize = BITS_TO_LONGS(bits) * sizeof(unsigned long);
+			mpic->protected = alloc_bootmem(mapsize);
+			BUG_ON(mpic->protected == NULL);
+			memset(mpic->protected, 0, mapsize);
+			for (i = 0; i < psize; i++) {
+				if (psrc[i] > intvec_top)
+					continue;
+				__set_bit(psrc[i], mpic->protected);
+			}
+		}
+	}
 
 #ifdef CONFIG_MPIC_WEIRD
 	mpic->hw_set = mpic_infos[MPIC_GET_REGSET(flags)];
@@ -1213,6 +1234,9 @@ void __init mpic_init(struct mpic *mpic)
 		u32 vecpri = MPIC_VECPRI_MASK | i |
 			(8 << MPIC_VECPRI_PRIORITY_SHIFT);
 		
+		/* check if protected */
+		if (mpic->protected && test_bit(i, mpic->protected))
+			continue;
 		/* init hw */
 		mpic_irq_write(i, MPIC_INFO(IRQ_VECTOR_PRI), vecpri);
 		mpic_irq_write(i, MPIC_INFO(IRQ_DESTINATION),
@@ -1407,6 +1431,14 @@ unsigned int mpic_get_one_irq(struct mpi
 			mpic_eoi(mpic);
 		return NO_IRQ;
 	}
+	if (unlikely(mpic->protected && test_bit(src, mpic->protected))) {
+		if (printk_ratelimit())
+			printk(KERN_WARNING "%s: Got protected source %d !\n",
+			       mpic->name, (int)src);
+		mpic_eoi(mpic);
+		return NO_IRQ;
+	}
+
 	return irq_linear_revmap(mpic->irqhost, src);
 }
 
Index: linux-work/include/asm-powerpc/mpic.h
===================================================================
--- linux-work.orig/include/asm-powerpc/mpic.h	2007-07-19 16:59:44.000000000 +1000
+++ linux-work/include/asm-powerpc/mpic.h	2007-07-19 17:02:35.000000000 +1000
@@ -296,6 +296,9 @@ struct mpic
 	unsigned int		dcr_base;
 #endif
 
+	/* Protected sources */
+	unsigned long		*protected;
+
 #ifdef CONFIG_MPIC_WEIRD
 	/* Pointer to HW info array */
 	u32			*hw_set;

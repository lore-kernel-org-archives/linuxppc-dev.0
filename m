Return-Path: <sebastien.dugue@bull.net>
Received: from ecfrec.frec.bull.fr (ecfrec.frec.bull.fr [129.183.4.8])
	by ozlabs.org (Postfix) with ESMTP id E0161DDED3
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 01:01:19 +1000 (EST)
Date: Wed, 23 Jul 2008 17:00:24 +0200
From: Sebastien Dugue <sebastien.dugue@bull.net>
To: Linux RT Users <linux-rt-users@vger.kernel.org>
Subject: [PATCH 1/2][RT] powerpc - XICS: move the call to irq_radix_revmap
	from xics_startup to xics_host_map
Message-ID: <20080723170024.1d857980@bull.net>
In-Reply-To: <20080723165932.57e3ada2@bull.net>
References: <20080723165932.57e3ada2@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Tim Chavez <tinytim@us.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jean Pierre Dion <jean-pierre.dion@bull.net>,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	Gilles Carry <Gilles.Carry@ext.bull.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Sebastien Dugue <sebastien.dugue@bull.net>
Date: Tue, 22 Jul 2008 13:05:24 +0200
Subject: [PATCH][RT] powerpc - XICS: move the call to irq_radix_revmap from xics_startup to xics_host_map

  This patch moves the insertion of an irq into the reverse mapping radix tree
from xics_startup() into xics_host_map().

  The reason for this change is that xics_startup() is called with preemption
disabled (which is not the case for xics_host_map()) which is a problem under a
preempt-rt kernel as we cannot even allocate GFP_ATOMIC memory for the radix tree
nodes.


Signed-off-by: Sebastien Dugue <sebastien.dugue@bull.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <michael@ellerman.id.au>

---
 arch/powerpc/platforms/pseries/xics.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

Index: linux-2.6.25.8-rt7/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- linux-2.6.25.8-rt7.orig/arch/powerpc/platforms/pseries/xics.c
+++ linux-2.6.25.8-rt7/arch/powerpc/platforms/pseries/xics.c
@@ -311,12 +311,6 @@ static void xics_mask_irq(unsigned int v
 
 static unsigned int xics_startup(unsigned int virq)
 {
-	unsigned int irq;
-
-	/* force a reverse mapping of the interrupt so it gets in the cache */
-	irq = (unsigned int)irq_map[virq].hwirq;
-	irq_radix_revmap(xics_host, irq);
-
 	/* unmask it */
 	xics_unmask_irq(virq);
 	return 0;
@@ -529,8 +523,14 @@ static int xics_host_match(struct irq_ho
 static int xics_host_map_direct(struct irq_host *h, unsigned int virq,
 				irq_hw_number_t hw)
 {
+	unsigned int irq;
+
 	pr_debug("xics: map_direct virq %d, hwirq 0x%lx\n", virq, hw);
 
+	/* force a reverse mapping of the interrupt so it gets in the cache */
+	irq = (unsigned int)irq_map[virq].hwirq;
+	irq_radix_revmap(xics_host, irq);
+
 	get_irq_desc(virq)->status |= IRQ_LEVEL;
 	set_irq_chip_and_handler(virq, &xics_pic_direct, handle_fasteoi_irq);
 	return 0;
@@ -539,8 +539,14 @@ static int xics_host_map_direct(struct i
 static int xics_host_map_lpar(struct irq_host *h, unsigned int virq,
 			      irq_hw_number_t hw)
 {
+	unsigned int irq;
+
 	pr_debug("xics: map_direct virq %d, hwirq 0x%lx\n", virq, hw);
 
+	/* force a reverse mapping of the interrupt so it gets in the cache */
+	irq = (unsigned int)irq_map[virq].hwirq;
+	irq_radix_revmap(xics_host, irq);
+
 	get_irq_desc(virq)->status |= IRQ_LEVEL;
 	set_irq_chip_and_handler(virq, &xics_pic_lpar, handle_fasteoi_irq);
 	return 0;

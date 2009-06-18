Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B3536B7294
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Jun 2009 14:13:53 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
Message-Id: <64b4bee5b3e4949bf8c273c7d8da77281eefdcfa.1245298429.git.michael@ellerman.id.au>
In-Reply-To: <1fdc1f0bb73b6ff2db7f9b394331d5ef5dfc4cb5.1245298429.git.michael@ellerman.id.au>
References: <1fdc1f0bb73b6ff2db7f9b394331d5ef5dfc4cb5.1245298429.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 6/7] powerpc/pseries: Use pr_devel() in xics.c
Date: Thu, 18 Jun 2009 14:13:53 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pr_debug() can now result in code being generated even when DEBUG
is not defined. That's not really desirable in some places.

With CONFIG_DYNAMIC_DEBUG=y:

size before:
   text    data     bss     dec     hex filename
   7720    5488     296   13504    34c0 platforms/pseries/xics.o

size after:
   text    data     bss     dec     hex filename
   7535	   5456	    296	  13287	   33e7	platforms/pseries/xics.o

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/xics.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/xics.c b/arch/powerpc/platforms/pseries/xics.c
index be3581a..419f8a6 100644
--- a/arch/powerpc/platforms/pseries/xics.c
+++ b/arch/powerpc/platforms/pseries/xics.c
@@ -190,10 +190,10 @@ static void xics_unmask_irq(unsigned int virq)
 	int call_status;
 	int server;
 
-	pr_debug("xics: unmask virq %d\n", virq);
+	pr_devel("xics: unmask virq %d\n", virq);
 
 	irq = (unsigned int)irq_map[virq].hwirq;
-	pr_debug(" -> map to hwirq 0x%x\n", irq);
+	pr_devel(" -> map to hwirq 0x%x\n", irq);
 	if (irq == XICS_IPI || irq == XICS_IRQ_SPURIOUS)
 		return;
 
@@ -252,7 +252,7 @@ static void xics_mask_irq(unsigned int virq)
 {
 	unsigned int irq;
 
-	pr_debug("xics: mask virq %d\n", virq);
+	pr_devel("xics: mask virq %d\n", virq);
 
 	irq = (unsigned int)irq_map[virq].hwirq;
 	if (irq == XICS_IPI || irq == XICS_IRQ_SPURIOUS)
@@ -414,7 +414,7 @@ static int xics_host_match(struct irq_host *h, struct device_node *node)
 static int xics_host_map(struct irq_host *h, unsigned int virq,
 			 irq_hw_number_t hw)
 {
-	pr_debug("xics: map virq %d, hwirq 0x%lx\n", virq, hw);
+	pr_devel("xics: map virq %d, hwirq 0x%lx\n", virq, hw);
 
 	/* Insert the interrupt mapping into the radix tree for fast lookup */
 	irq_radix_revmap_insert(xics_host, virq, hw);
-- 
1.6.2.1

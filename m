Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <87206bccf429273c3d7abba408ef606b69bae265.1207032121.git.michael@ellerman.id.au>
In-Reply-To: <6840627eab063b5246ec661968986a4ae2d7be61.1207032121.git.michael@ellerman.id.au>
References: <6840627eab063b5246ec661968986a4ae2d7be61.1207032121.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [RFC/PATCH 3/4] Use pseries_setup_i8259_cascade() in
	pseries_mpic_init_IRQ()
Date: Tue,  1 Apr 2008 17:42:26 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

pseries_mpic_init_IRQ() implements the same logic as the xics code did to
find the i8259 cascade irq. Now that we've pulled that logic out into
pseries_setup_i8259_cascade() we can use it in the mpic code.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/setup.c |   43 +------------------------------
 1 files changed, 2 insertions(+), 41 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 1e1faa1..22c047c 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -178,12 +178,9 @@ static void __init pseries_setup_i8259_cascade(void)
 
 static void __init pseries_mpic_init_IRQ(void)
 {
-	struct device_node *np, *old, *cascade = NULL;
-        const unsigned int *addrp;
-	unsigned long intack = 0;
+	struct device_node *np;
 	const unsigned int *opprop;
 	unsigned long openpic_addr = 0;
-	unsigned int cascade_irq;
 	int naddr, n, i, opplen;
 	struct mpic *mpic;
 
@@ -216,43 +213,7 @@ static void __init pseries_mpic_init_IRQ(void)
 	mpic_init(mpic);
 
 	/* Look for cascade */
-	for_each_node_by_type(np, "interrupt-controller")
-		if (of_device_is_compatible(np, "chrp,iic")) {
-			cascade = np;
-			break;
-		}
-	if (cascade == NULL)
-		return;
-
-	cascade_irq = irq_of_parse_and_map(cascade, 0);
-	if (cascade_irq == NO_IRQ) {
-		printk(KERN_ERR "mpic: failed to map cascade interrupt");
-		return;
-	}
-
-	/* Check ACK type */
-	for (old = of_node_get(cascade); old != NULL ; old = np) {
-		np = of_get_parent(old);
-		of_node_put(old);
-		if (np == NULL)
-			break;
-		if (strcmp(np->name, "pci") != 0)
-			continue;
-		addrp = of_get_property(np, "8259-interrupt-acknowledge",
-					    NULL);
-		if (addrp == NULL)
-			continue;
-		naddr = of_n_addr_cells(np);
-		intack = addrp[naddr-1];
-		if (naddr > 1)
-			intack |= ((unsigned long)addrp[naddr-2]) << 32;
-	}
-	if (intack)
-		printk(KERN_DEBUG "mpic: PCI 8259 intack at 0x%016lx\n",
-		       intack);
-	i8259_init(cascade, intack);
-	of_node_put(cascade);
-	set_irq_chained_handler(cascade_irq, pseries_8259_cascade);
+	pseries_setup_i8259_cascade();
 }
 
 static void __init pseries_xics_init_IRQ(void)
-- 
1.5.2.rc1.1884.g59b20

Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <f82f14fe5748aa91cafc9341ba02544c05090a28.1207032121.git.michael@ellerman.id.au>
In-Reply-To: <6840627eab063b5246ec661968986a4ae2d7be61.1207032121.git.michael@ellerman.id.au>
References: <6840627eab063b5246ec661968986a4ae2d7be61.1207032121.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [RFC/PATCH 2/4] Turn xics_setup_8259_cascade() into a generic
	pseries_setup_i8259_cascade()
Date: Tue,  1 Apr 2008 17:42:25 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove the xics references from xics_setup_8259_cascade(), and merge the
good bits from the almost identical logic in pseries_mpic_init_IRQ().

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/setup.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 43e4801..1e1faa1 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -127,28 +127,32 @@ void pseries_8259_cascade(unsigned int irq, struct irq_desc *desc)
 	desc->chip->eoi(irq);
 }
 
-static void __init xics_setup_8259_cascade(void)
+static void __init pseries_setup_i8259_cascade(void)
 {
 	struct device_node *np, *old, *found = NULL;
-	int cascade, naddr;
+	unsigned int cascade;
 	const u32 *addrp;
 	unsigned long intack = 0;
+	int naddr;
 
-	for_each_node_by_type(np, "interrupt-controller")
+	for_each_node_by_type(np, "interrupt-controller") {
 		if (of_device_is_compatible(np, "chrp,iic")) {
 			found = np;
 			break;
 		}
+	}
+
 	if (found == NULL) {
-		printk(KERN_DEBUG "xics: no ISA interrupt controller\n");
+		printk(KERN_DEBUG "pic: no ISA interrupt controller\n");
 		return;
 	}
+
 	cascade = irq_of_parse_and_map(found, 0);
 	if (cascade == NO_IRQ) {
-		printk(KERN_ERR "xics: failed to map cascade interrupt");
+		printk(KERN_ERR "pic: failed to map cascade interrupt");
 		return;
 	}
-	pr_debug("xics: cascade mapped to irq %d\n", cascade);
+	pr_debug("pic: cascade mapped to irq %d\n", cascade);
 
 	for (old = of_node_get(found); old != NULL ; old = np) {
 		np = of_get_parent(old);
@@ -166,7 +170,7 @@ static void __init xics_setup_8259_cascade(void)
 			intack |= ((unsigned long)addrp[naddr-2]) << 32;
 	}
 	if (intack)
-		printk(KERN_DEBUG "xics: PCI 8259 intack at 0x%016lx\n", intack);
+		printk(KERN_DEBUG "pic: PCI 8259 intack at 0x%016lx\n", intack);
 	i8259_init(found, intack);
 	of_node_put(found);
 	set_irq_chained_handler(cascade, pseries_8259_cascade);
@@ -254,7 +258,7 @@ static void __init pseries_mpic_init_IRQ(void)
 static void __init pseries_xics_init_IRQ(void)
 {
 	xics_init_IRQ();
-	xics_setup_8259_cascade();
+	pseries_setup_i8259_cascade();
 }
 
 static void pseries_lpar_enable_pmcs(void)
-- 
1.5.2.rc1.1884.g59b20

Return-Path: <b08248@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 8CDD7DDF5F
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 06:17:29 +1100 (EST)
Date: Tue, 20 Mar 2007 14:17:24 -0500
From: Stuart Yoder <b08248@freescale.com>
Message-Id: <200703201917.l2KJHO51015104@ld0164-tx32.am.freescale.net>
To: paulus@samba.org
Subject: [PATCH] powerpc: Support new property called interrupt-parents
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Support new property called interrupt-parents.  This enables the
description of devices that have multiple interrupts that are routed to
different interrupt controllers.

Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
---

-The booting-without-of.txt changes were reviewed and
 discussed on the list in late Feb

-The code change to support this is isolated to of_irq_map_one().
 If the normal interrupt-parent is present everything behaves as
 before.  If the interrupt-parents property is specified, the index
 argument is used to identify the interrupt parent.  In order
 to parse the interrupts property the interrupt tree has to be
 traversed for each interrupt parent to determine the correct
 #interrupt-cells value.

-I've done some limited testing using a network device on a Freescale
 board.

 Documentation/powerpc/booting-without-of.txt |   60 ++++++++++++++++-
 arch/powerpc/kernel/prom_parse.c             |   96 +++++++++++++++++++------
 2 files changed, 132 insertions(+), 24 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index a1f83f1..8a1c311 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1769,7 +1769,65 @@ If the interrupt-parent property is not defined for a node, it's
 interrupt parent is assumed to be an ancestor in the node's
 _device tree_ hierarchy.
 
-3) OpenPIC Interrupt Controllers
+3) interrupt-parents property
+-----------------------------
+
+For devices that generate interrupts to multiple interrupt
+controllers, the  interrupt-parent representation
+is not sufficient because it only describes a single
+interrupt parent. The 'interrupt-parents' property can be used
+to represent this (note the plural in the property name).
+
+The interrupt-parents property consists of one or more 
+interrupt parent phandle values each representing the interrupt
+parent for the corresponding interrupt specifier in the interrupts
+property:
+
+  interrupt-parents = <parent-phandle0 parent-phandle1 ... parent-phandleN>
+  interrupts = <int-specifier0 int-specifier1 ... int-specifierN>
+
+It is required that the number of interrupts encoded in the interrupt-parents
+property exacly match the number of interrupt specifiers in the interrupts
+property.
+
+See the example below:
+
+   pic0: pic@700 {
+       interrupt-controller;
+       #address-cells = <0>;
+       #interrupt-cells = <2>;
+       reg = <700 100>;
+       device_type = "open-pic";
+   };
+
+   pic1: pic@800 {
+       interrupt-controller;
+       #address-cells = <0>;
+       #interrupt-cells = <2>;
+       reg = <800 100>;
+       device_type = "open-pic";
+   };
+
+   ethernet@25000 {
+       device_type = "network";
+       reg = <25000 1000>;
+       ...
+       interrupt-parents = <&pic0 &pic0 &pic1>;
+       interrupts        = <13 3  14 3  18 3>;
+   };
+
+In the above example, the interrupts property and the interrupt-parents
+property defines three interrupts. The first 2 interrupt lines are
+routed to irqs 0x13 and 0x14 on pic0.  The 3rd interrupt line is 
+routed to irq 0x18 on pic1.
+
+Note: each interrupt parent in the interrupt-parents array can
+potentially specify a different value for #interrupt-cells.  The number
+of #interrupt-cells for each parent must be determined to correctly
+parse the interrupts property.
+
+
+4) OpenPIC Interrupt Controllers
 --------------------------------
 
 OpenPIC interrupt controllers require 2 cells to encode
diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_parse.c
index 91b443c..8cf7e96 100644
--- a/arch/powerpc/kernel/prom_parse.c
+++ b/arch/powerpc/kernel/prom_parse.c
@@ -958,10 +958,11 @@ static int of_irq_map_oldworld(struct device_node *device, int index,
 
 int of_irq_map_one(struct device_node *device, int index, struct of_irq *out_irq)
 {
-	struct device_node *p;
-	const u32 *intspec, *tmp, *addr;
-	u32 intsize, intlen;
-	int res;
+	struct device_node *p = NULL;
+	const u32 *intspec, *intprop, *intp, *tmp, *addr, *parp;
+	u32 intsize = 0;
+	u32 intlen, intplen;
+	int res,i;
 
 	DBG("of_irq_map_one: dev=%s, index=%d\n", device->full_name, index);
 
@@ -970,36 +971,85 @@ int of_irq_map_one(struct device_node *device, int index, struct of_irq *out_irq
 		return of_irq_map_oldworld(device, index, out_irq);
 
 	/* Get the interrupts property */
-	intspec = get_property(device, "interrupts", &intlen);
-	if (intspec == NULL)
+	intprop = get_property(device, "interrupts", &intlen);
+	if (intprop == NULL)
 		return -EINVAL;
 	intlen /= sizeof(u32);
 
 	/* Get the reg property (if any) */
 	addr = get_property(device, "reg", NULL);
 
-	/* Look for the interrupt parent. */
-	p = of_irq_find_parent(device);
-	if (p == NULL)
-		return -EINVAL;
+	/* look for interrupt-parents */
+	intp = get_property(device, "interrupt-parents", &intplen);
+	if (intp == NULL) {
 
-	/* Get size of interrupt specifier */
-	tmp = get_property(p, "#interrupt-cells", NULL);
-	if (tmp == NULL) {
-		of_node_put(p);
-		return -EINVAL;
-	}
-	intsize = *tmp;
+		/* Look for the interrupt parent. */
+		p = of_irq_find_parent(device);
+		if (p == NULL)
+			return -EINVAL;
 
-	DBG(" intsize=%d intlen=%d\n", intsize, intlen);
+		/* Get size of interrupt specifier */
+		tmp = get_property(p, "#interrupt-cells", NULL);
+		if (tmp == NULL) {
+			of_node_put(p);
+			return -EINVAL;
+		}
+		intsize = *tmp;
+	
+		DBG(" intsize=%d intlen=%d\n", intsize, intlen);
+	
+		/* Check index */
+		if ((index + 1) * intsize > intlen)
+			return -EINVAL;
 
-	/* Check index */
-	if ((index + 1) * intsize > intlen)
-		return -EINVAL;
+		/* compute pointer to interrupt specifier */
+		intspec = intprop + index * intsize;
+
+	} else {  /* this node has multiple interrupt parents */
+
+		intplen /= sizeof(u32); /* # of cells */
+
+		if ((index+1) > intplen)
+			return -EINVAL; /* index is out of bounds */
+
+		intspec = intprop;
+
+		for (i=0; i < intplen; i++) {
+
+			p = of_find_node_by_phandle(intp[i]);
+
+			/* starting with the specified int parent, search up the int tree for interrupt-cells */
+			while (p && get_property(p, "#interrupt-cells", NULL) == NULL) {
+
+				parp = get_property(p, "interrupt-parent", NULL);
+				if (parp == NULL) {
+					p = of_get_parent(p);
+				} else {
+					p = of_find_node_by_phandle(*parp);
+				}
+			}
+
+			/* Get size of interrupt specifier */
+			tmp = get_property(p, "#interrupt-cells", NULL);
+			if (tmp == NULL) {
+				of_node_put(p);
+				return -EINVAL;
+			}
+			intsize = *tmp;
+
+			if (index == i)
+				break;
+
+			/* advance pointer to next int specifier */
+			intspec = intspec + intsize;
+		}
+
+		DBG(" index=%d intspec[0]=%d intsize=%d \n", i, *intspec, intsize);
+
+	}
 
 	/* Get new specifier and map it */
-	res = of_irq_map_raw(p, intspec + index * intsize, intsize,
-			     addr, out_irq);
+	res = of_irq_map_raw(p, intspec, intsize, addr, out_irq);
 	of_node_put(p);
 	return res;
 }
-- 
1.5.0.3

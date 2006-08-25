Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 62DAD67C36
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Aug 2006 14:46:38 +1000 (EST)
Subject: [PATCH] powerpc: Make OF irq map code detect more error cases
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Fri, 25 Aug 2006 14:46:23 +1000
Message-Id: <1156481183.8433.300.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Device-tree bugs on js20 with some versions of SLOF were causing the
interrupt for IDE to not be parsed correctly and fail to boot. This
patch adds a bit more sanity checking to the parser to detet some of
those errors and fail instead of returning bogus informations. The
powerpc PCI code can then trigger a fallback that works on those
machines.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/powerpc/kernel/pci_64.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/pci_64.c	2006-08-17 09:26:19.000000000 +1000
+++ linux-work/arch/powerpc/kernel/pci_64.c	2006-08-25 14:38:55.000000000 +1000
@@ -1289,6 +1289,9 @@ int pci_read_irq_line(struct pci_dev *pc
 
 	DBG("Try to map irq for %s...\n", pci_name(pci_dev));
 
+#ifdef DEBUG
+	memset(&oirq, 0xff, sizeof(oirq));
+#endif
 	/* Try to get a mapping from the device-tree */
 	if (of_irq_map_pci(pci_dev, &oirq)) {
 		u8 line, pin;
@@ -1314,8 +1317,9 @@ int pci_read_irq_line(struct pci_dev *pc
 		if (virq != NO_IRQ)
 			set_irq_type(virq, IRQ_TYPE_LEVEL_LOW);
 	} else {
-		DBG(" -> got one, spec %d cells (0x%08x...) on %s\n",
-		    oirq.size, oirq.specifier[0], oirq.controller->full_name);
+		DBG(" -> got one, spec %d cells (0x%08x 0x%08x...) on %s\n",
+		    oirq.size, oirq.specifier[0], oirq.specifier[1],
+		    oirq.controller->full_name);
 
 		virq = irq_create_of_mapping(oirq.controller, oirq.specifier,
 					     oirq.size);
@@ -1324,6 +1328,9 @@ int pci_read_irq_line(struct pci_dev *pc
 		DBG(" -> failed to map !\n");
 		return -1;
 	}
+
+	DBG(" -> mapped to linux irq %d\n", virq);
+
 	pci_dev->irq = virq;
 	pci_write_config_byte(pci_dev, PCI_INTERRUPT_LINE, virq);
 
Index: linux-work/arch/powerpc/kernel/prom_parse.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/prom_parse.c	2006-08-17 09:26:19.000000000 +1000
+++ linux-work/arch/powerpc/kernel/prom_parse.c	2006-08-25 14:38:29.000000000 +1000
@@ -644,14 +644,17 @@ void of_irq_map_init(unsigned int flags)
 
 }
 
-int of_irq_map_raw(struct device_node *parent, u32 *intspec, u32 *addr,
-		   struct of_irq *out_irq)
+int of_irq_map_raw(struct device_node *parent, u32 *intspec, u32 ointsize,
+		   u32 *addr, struct of_irq *out_irq)
 {
 	struct device_node *ipar, *tnode, *old = NULL, *newpar = NULL;
 	u32 *tmp, *imap, *imask;
 	u32 intsize = 1, addrsize, newintsize = 0, newaddrsize = 0;
 	int imaplen, match, i;
 
+	DBG("of_irq_map_raw: par=%s,intspec=[0x%08x 0x%08x...],ointsize=%d\n",
+	    parent->full_name, intspec[0], intspec[1], ointsize);
+
 	ipar = of_node_get(parent);
 
 	/* First get the #interrupt-cells property of the current cursor
@@ -675,6 +678,9 @@ int of_irq_map_raw(struct device_node *p
 
 	DBG("of_irq_map_raw: ipar=%s, size=%d\n", ipar->full_name, intsize);
 
+	if (ointsize != intsize)
+		return -EINVAL;
+
 	/* Look for this #address-cells. We have to implement the old linux
 	 * trick of looking for the parent here as some device-trees rely on it
 	 */
@@ -880,12 +886,15 @@ int of_irq_map_one(struct device_node *d
 	}
 	intsize = *tmp;
 
+	DBG(" intsize=%d intlen=%d\n", intsize, intlen);
+
 	/* Check index */
 	if ((index + 1) * intsize > intlen)
 		return -EINVAL;
 
 	/* Get new specifier and map it */
-	res = of_irq_map_raw(p, intspec + index * intsize, addr, out_irq);
+	res = of_irq_map_raw(p, intspec + index * intsize, intsize,
+			     addr, out_irq);
 	of_node_put(p);
 	return res;
 }
@@ -964,7 +973,7 @@ int of_irq_map_pci(struct pci_dev *pdev,
 	laddr[0] = (pdev->bus->number << 16)
 		| (pdev->devfn << 8);
 	laddr[1]  = laddr[2] = 0;
-	return of_irq_map_raw(ppnode, &lspec, laddr, out_irq);
+	return of_irq_map_raw(ppnode, &lspec, 1, laddr, out_irq);
 }
 EXPORT_SYMBOL_GPL(of_irq_map_pci);
 
Index: linux-work/include/asm-powerpc/prom.h
===================================================================
--- linux-work.orig/include/asm-powerpc/prom.h	2006-08-17 09:26:22.000000000 +1000
+++ linux-work/include/asm-powerpc/prom.h	2006-08-25 14:35:55.000000000 +1000
@@ -276,6 +276,7 @@ extern void of_irq_map_init(unsigned int
  * of_irq_map_raw - Low level interrupt tree parsing
  * @parent:	the device interrupt parent
  * @intspec:	interrupt specifier ("interrupts" property of the device)
+ * @ointsize:   size of the passed in interrupt specifier
  * @addr:	address specifier (start of "reg" property of the device)
  * @out_irq:	structure of_irq filled by this function
  *
@@ -288,7 +289,8 @@ extern void of_irq_map_init(unsigned int
  *
  */
 
-extern int of_irq_map_raw(struct device_node *parent, u32 *intspec, u32 *addr,
+extern int of_irq_map_raw(struct device_node *parent, u32 *intspec,
+			  u32 ointsize, u32 *addr,
 			  struct of_irq *out_irq);
 
 

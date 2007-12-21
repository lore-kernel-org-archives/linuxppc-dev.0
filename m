Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id DB346DDF1C
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 15:52:42 +1100 (EST)
Date: Fri, 21 Dec 2007 15:52:43 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] pci_32.c: use for_each_child_of_node
Message-Id: <20071221155243.195ed327.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/pci_32.c |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index 37cb7b9..b5121b8 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -13,6 +13,7 @@
 #include <linux/bootmem.h>
 #include <linux/irq.h>
 #include <linux/list.h>
+#include <linux/of.h>
 
 #include <asm/processor.h>
 #include <asm/io.h>
@@ -171,7 +172,7 @@ make_one_node_map(struct device_node* node, u8 pci_bus)
 	} else
 		pci_to_OF_bus_map[pci_bus] = bus_range[0];
 
-	for (node=node->child; node != 0;node = node->sibling) {
+	for_each_child_of_node(node, node) {
 		struct pci_dev* dev;
 		const unsigned int *class_code, *reg;
 	
@@ -240,15 +241,18 @@ pcibios_make_OF_bus_map(void)
 typedef int (*pci_OF_scan_iterator)(struct device_node* node, void* data);
 
 static struct device_node*
-scan_OF_pci_childs(struct device_node* node, pci_OF_scan_iterator filter, void* data)
+scan_OF_pci_childs(struct device_node *parent, pci_OF_scan_iterator filter, void* data)
 {
+	struct device_node *node;
 	struct device_node* sub_node;
 
-	for (; node != 0;node = node->sibling) {
+	for_each_child_of_node(parent, node) {
 		const unsigned int *class_code;
 	
-		if (filter(node, data))
+		if (filter(node, data)) {
+			of_node_put(node);
 			return node;
+		}
 
 		/* For PCI<->PCI bridges or CardBus bridges, we go down
 		 * Note: some OFs create a parent node "multifunc-device" as
@@ -260,9 +264,11 @@ scan_OF_pci_childs(struct device_node* node, pci_OF_scan_iterator filter, void*
 			(*class_code >> 8) != PCI_CLASS_BRIDGE_CARDBUS)) &&
 			strcmp(node->name, "multifunc-device"))
 			continue;
-		sub_node = scan_OF_pci_childs(node->child, filter, data);
-		if (sub_node)
+		sub_node = scan_OF_pci_childs(node, filter, data);
+		if (sub_node) {
+			of_node_put(node);
 			return sub_node;
+		}
 	}
 	return NULL;
 }
@@ -366,7 +372,7 @@ pci_device_from_OF_node(struct device_node* node, u8* bus, u8* devfn)
 	hose = pci_find_hose_for_OF_device(node);
 	if (!hose || !hose->dn)
 		return -ENODEV;
-	if (!scan_OF_pci_childs(hose->dn->child,
+	if (!scan_OF_pci_childs(hose->dn,
 			find_OF_pci_device_filter, (void *)node))
 		return -ENODEV;
 	reg = of_get_property(node, "reg", NULL);
-- 
1.5.3.7

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

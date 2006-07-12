Return-Path: <jk@ozlabs.org>
To: linuxppc-dev@ozlabs.org
From: Jeremy Kerr <jk@ozlabs.org>
Subject: [PATCH 07/16] [powerpc,maple] Constify & voidify get_property()
Message-ID: <1152678686.20160.07@pokey>
Date: Wed, 12 Jul 2006 15:40:17 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that get_property() returns a void *, there's no need to cast its
return value. Also, treat the return value as const, so we can
constify get_property later.

maple platform changes.

Built for maple_defconfig

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
---

 resend: rebase after benh's IRQ changes

 pci.c   |   20 +++++++++++---------
 setup.c |   27 ++++++++++-----------------
 2 files changed, 21 insertions(+), 26 deletions(-)

Index: linux-2.6/arch/powerpc/platforms/maple/pci.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/maple/pci.c
+++ linux-2.6/arch/powerpc/platforms/maple/pci.c
@@ -38,16 +38,16 @@ static struct pci_controller *u3_agp, *u
 static int __init fixup_one_level_bus_range(struct device_node *node, int higher)
 {
 	for (; node != 0;node = node->sibling) {
-		int * bus_range;
-		unsigned int *class_code;
+		const int *bus_range;
+		const unsigned int *class_code;
 		int len;
 
 		/* For PCI<->PCI bridges or CardBus bridges, we go down */
-		class_code = (unsigned int *) get_property(node, "class-code", NULL);
+		class_code = get_property(node, "class-code", NULL);
 		if (!class_code || ((*class_code >> 8) != PCI_CLASS_BRIDGE_PCI &&
 			(*class_code >> 8) != PCI_CLASS_BRIDGE_CARDBUS))
 			continue;
-		bus_range = (int *) get_property(node, "bus-range", &len);
+		bus_range = get_property(node, "bus-range", &len);
 		if (bus_range != NULL && len > 2 * sizeof(int)) {
 			if (bus_range[1] > higher)
 				higher = bus_range[1];
@@ -65,16 +65,18 @@ static int __init fixup_one_level_bus_ra
  */
 static void __init fixup_bus_range(struct device_node *bridge)
 {
-	int * bus_range;
+	int *bus_range;
+	struct property *prop;
 	int len;
 
 	/* Lookup the "bus-range" property for the hose */
-	bus_range = (int *) get_property(bridge, "bus-range", &len);
-	if (bus_range == NULL || len < 2 * sizeof(int)) {
+	prop = of_find_property(bridge, "bus-range", &len);
+	if (prop == NULL  || prop->value == NULL || len < 2 * sizeof(int)) {
 		printk(KERN_WARNING "Can't get bus-range for %s\n",
 			       bridge->full_name);
 		return;
 	}
+	bus_range = (int *)prop->value;
 	bus_range[1] = fixup_one_level_bus_range(bridge->child, bus_range[1]);
 }
 
@@ -314,12 +316,12 @@ static int __init add_bridge(struct devi
 	int len;
 	struct pci_controller *hose;
 	char* disp_name;
-	int *bus_range;
+	const int *bus_range;
 	int primary = 1;
 
 	DBG("Adding PCI host bridge %s\n", dev->full_name);
 
-	bus_range = (int *) get_property(dev, "bus-range", &len);
+	bus_range = get_property(dev, "bus-range", &len);
 	if (bus_range == NULL || len < 2 * sizeof(int)) {
 		printk(KERN_WARNING "Can't get bus-range for %s, assume bus 0\n",
 		dev->full_name);
Index: linux-2.6/arch/powerpc/platforms/maple/setup.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/maple/setup.c
+++ linux-2.6/arch/powerpc/platforms/maple/setup.c
@@ -99,8 +99,7 @@ static unsigned long maple_find_nvram_ba
 static void maple_restart(char *cmd)
 {
 	unsigned int maple_nvram_base;
-	unsigned int maple_nvram_offset;
-	unsigned int maple_nvram_command;
+	const unsigned int *maple_nvram_offset, *maple_nvram_command;
 	struct device_node *sp;
 
 	maple_nvram_base = maple_find_nvram_base();
@@ -113,14 +112,12 @@ static void maple_restart(char *cmd)
 		printk(KERN_EMERG "Maple: Unable to find Service Processor\n");
 		goto fail;
 	}
-	maple_nvram_offset = *(unsigned int*) get_property(sp,
-			"restart-addr", NULL);
-	maple_nvram_command = *(unsigned int*) get_property(sp,
-			"restart-value", NULL);
+	maple_nvram_offset = get_property(sp, "restart-addr", NULL);
+	maple_nvram_command = get_property(sp, "restart-value", NULL);
 	of_node_put(sp);
 
 	/* send command */
-	outb_p(maple_nvram_command, maple_nvram_base + maple_nvram_offset);
+	outb_p(*maple_nvram_command, maple_nvram_base + *maple_nvram_offset);
 	for (;;) ;
  fail:
 	printk(KERN_EMERG "Maple: Manual Restart Required\n");
@@ -129,8 +126,7 @@ static void maple_restart(char *cmd)
 static void maple_power_off(void)
 {
 	unsigned int maple_nvram_base;
-	unsigned int maple_nvram_offset;
-	unsigned int maple_nvram_command;
+	const unsigned int *maple_nvram_offset, *maple_nvram_command;
 	struct device_node *sp;
 
 	maple_nvram_base = maple_find_nvram_base();
@@ -143,14 +139,12 @@ static void maple_power_off(void)
 		printk(KERN_EMERG "Maple: Unable to find Service Processor\n");
 		goto fail;
 	}
-	maple_nvram_offset = *(unsigned int*) get_property(sp,
-			"power-off-addr", NULL);
-	maple_nvram_command = *(unsigned int*) get_property(sp,
-			"power-off-value", NULL);
+	maple_nvram_offset = get_property(sp, "power-off-addr", NULL);
+	maple_nvram_command = get_property(sp, "power-off-value", NULL);
 	of_node_put(sp);
 
 	/* send command */
-	outb_p(maple_nvram_command, maple_nvram_base + maple_nvram_offset);
+	outb_p(*maple_nvram_command, maple_nvram_base + *maple_nvram_offset);
 	for (;;) ;
  fail:
 	printk(KERN_EMERG "Maple: Manual Power-Down Required\n");
@@ -211,7 +205,7 @@ static void __init maple_init_early(void
 static void __init maple_init_IRQ(void)
 {
 	struct device_node *root, *np, *mpic_node = NULL;
-	unsigned int *opprop;
+	const unsigned int *opprop;
 	unsigned long openpic_addr = 0;
 	int naddr, n, i, opplen, has_isus = 0;
 	struct mpic *mpic;
@@ -234,8 +228,7 @@ static void __init maple_init_IRQ(void)
 	/* Find address list in /platform-open-pic */
 	root = of_find_node_by_path("/");
 	naddr = prom_n_addr_cells(root);
-	opprop = (unsigned int *) get_property(root, "platform-open-pic",
-					       &opplen);
+	opprop = get_property(root, "platform-open-pic", &opplen);
 	if (opprop != 0) {
 		openpic_addr = of_read_number(opprop, naddr);
 		has_isus = (opplen > naddr);

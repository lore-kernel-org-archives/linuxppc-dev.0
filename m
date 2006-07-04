Return-Path: <jk@ozlabs.org>
To: linuxppc-dev@ozlabs.org
From: Jeremy Kerr <jk@ozlabs.org>
Subject: [PATCH 8/20] [powerpc,mpc] Constify & voidify get_property()
Message-ID: 1151993427.2210.09@pokey
Date: Tue,  4 Jul 2006 16:47:19 +1000 (EST)
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

mpc* platform changes.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
---

 83xx/mpc834x_itx.c         |    4 ++--
 83xx/mpc834x_sys.c         |    4 ++--
 83xx/pci.c                 |    4 ++--
 85xx/mpc85xx_ads.c         |    4 ++--
 85xx/mpc85xx_cds.c         |    4 ++--
 85xx/pci.c                 |    4 ++--
 86xx/mpc86xx_hpcn.c        |    4 ++--
 86xx/pci.c                 |    4 ++--
 embedded6xx/mpc7448_hpc2.c |    8 ++++----
 9 files changed, 20 insertions(+), 20 deletions(-)

Index: linux-2.6/arch/powerpc/platforms/83xx/mpc834x_sys.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/83xx/mpc834x_sys.c
+++ linux-2.6/arch/powerpc/platforms/83xx/mpc834x_sys.c
@@ -84,8 +84,8 @@ static void __init mpc834x_sys_setup_arc
 
 	np = of_find_node_by_type(NULL, "cpu");
 	if (np != 0) {
-		unsigned int *fp =
-		    (int *)get_property(np, "clock-frequency", NULL);
+		const unsigned int *fp =
+			get_property(np, "clock-frequency", NULL);
 		if (fp != 0)
 			loops_per_jiffy = *fp / HZ;
 		else
Index: linux-2.6/arch/powerpc/platforms/83xx/pci.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/83xx/pci.c
+++ linux-2.6/arch/powerpc/platforms/83xx/pci.c
@@ -50,7 +50,7 @@ int __init add_bridge(struct device_node
 	int len;
 	struct pci_controller *hose;
 	struct resource rsrc;
-	int *bus_range;
+	const int *bus_range;
 	int primary = 1, has_address = 0;
 	phys_addr_t immr = get_immrbase();
 
@@ -60,7 +60,7 @@ int __init add_bridge(struct device_node
 	has_address = (of_address_to_resource(dev, 0, &rsrc) == 0);
 
 	/* Get bus range if any */
-	bus_range = (int *)get_property(dev, "bus-range", &len);
+	bus_range = get_property(dev, "bus-range", &len);
 	if (bus_range == NULL || len < 2 * sizeof(int)) {
 		printk(KERN_WARNING "Can't get bus-range for %s, assume"
 		       " bus 0\n", dev->full_name);
Index: linux-2.6/arch/powerpc/platforms/85xx/mpc85xx_ads.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ linux-2.6/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -172,9 +172,9 @@ static void __init mpc85xx_ads_setup_arc
 
 	cpu = of_find_node_by_type(NULL, "cpu");
 	if (cpu != 0) {
-		unsigned int *fp;
+		const unsigned int *fp;
 
-		fp = (int *)get_property(cpu, "clock-frequency", NULL);
+		fp = get_property(cpu, "clock-frequency", NULL);
 		if (fp != 0)
 			loops_per_jiffy = *fp / HZ;
 		else
Index: linux-2.6/arch/powerpc/platforms/85xx/mpc85xx_cds.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ linux-2.6/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -273,9 +273,9 @@ mpc85xx_cds_setup_arch(void)
 
 	cpu = of_find_node_by_type(NULL, "cpu");
 	if (cpu != 0) {
-		unsigned int *fp;
+		const unsigned int *fp;
 
-		fp = (int *)get_property(cpu, "clock-frequency", NULL);
+		fp = get_property(cpu, "clock-frequency", NULL);
 		if (fp != 0)
 			loops_per_jiffy = *fp / HZ;
 		else
Index: linux-2.6/arch/powerpc/platforms/86xx/pci.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/86xx/pci.c
+++ linux-2.6/arch/powerpc/platforms/86xx/pci.c
@@ -153,7 +153,7 @@ int __init add_bridge(struct device_node
 	int len;
 	struct pci_controller *hose;
 	struct resource rsrc;
-	int *bus_range;
+	const int *bus_range;
 	int has_address = 0;
 	int primary = 0;
 
@@ -163,7 +163,7 @@ int __init add_bridge(struct device_node
 	has_address = (of_address_to_resource(dev, 0, &rsrc) == 0);
 
 	/* Get bus range if any */
-	bus_range = (int *) get_property(dev, "bus-range", &len);
+	bus_range = get_property(dev, "bus-range", &len);
 	if (bus_range == NULL || len < 2 * sizeof(int))
 		printk(KERN_WARNING "Can't get bus-range for %s, assume"
 		       " bus 0\n", dev->full_name);
Index: linux-2.6/arch/powerpc/platforms/85xx/pci.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/85xx/pci.c
+++ linux-2.6/arch/powerpc/platforms/85xx/pci.c
@@ -41,7 +41,7 @@ int __init add_bridge(struct device_node
 	int len;
 	struct pci_controller *hose;
 	struct resource rsrc;
-	int *bus_range;
+	const int *bus_range;
 	int primary = 1, has_address = 0;
 	phys_addr_t immr = get_immrbase();
 
@@ -51,7 +51,7 @@ int __init add_bridge(struct device_node
 	has_address = (of_address_to_resource(dev, 0, &rsrc) == 0);
 
 	/* Get bus range if any */
-	bus_range = (int *) get_property(dev, "bus-range", &len);
+	bus_range = get_property(dev, "bus-range", &len);
 	if (bus_range == NULL || len < 2 * sizeof(int)) {
 		printk(KERN_WARNING "Can't get bus-range for %s, assume"
 		       " bus 0\n", dev->full_name);
Index: linux-2.6/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ linux-2.6/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -323,9 +323,9 @@ mpc86xx_hpcn_setup_arch(void)
 
 	np = of_find_node_by_type(NULL, "cpu");
 	if (np != 0) {
-		unsigned int *fp;
+		const unsigned int *fp;
 
-		fp = (int *)get_property(np, "clock-frequency", NULL);
+		fp = get_property(np, "clock-frequency", NULL);
 		if (fp != 0)
 			loops_per_jiffy = *fp / HZ;
 		else
Index: linux-2.6/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
+++ linux-2.6/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
@@ -130,7 +130,7 @@ void mpc7448_hpc2_fixup_irq(struct pci_d
 {
 	struct pci_controller *hose;
 	struct device_node *node;
-	unsigned int *interrupt;
+	const unsigned int *interrupt;
 	int busnr;
 	int len;
 	u8 slot;
@@ -147,7 +147,7 @@ void mpc7448_hpc2_fixup_irq(struct pci_d
 	if (!node)
 		printk(KERN_ERR "No pci node found\n");
 
-	interrupt = (unsigned int *) get_property(node, "interrupt-map", &len);
+	interrupt = get_property(node, "interrupt-map", &len);
 	slot = find_slot_by_devfn(interrupt, dev->devfn);
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
 	if (pin == 0 || pin > 4)
@@ -176,9 +176,9 @@ static void __init mpc7448_hpc2_setup_ar
 
 	cpu = of_find_node_by_type(NULL, "cpu");
 	if (cpu != 0) {
-		unsigned int *fp;
+		const unsigned int *fp;
 
-		fp = (int *)get_property(cpu, "clock-frequency", NULL);
+		fp = get_property(cpu, "clock-frequency", NULL);
 		if (fp != 0)
 			loops_per_jiffy = *fp / HZ;
 		else
Index: linux-2.6/arch/powerpc/platforms/83xx/mpc834x_itx.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/83xx/mpc834x_itx.c
+++ linux-2.6/arch/powerpc/platforms/83xx/mpc834x_itx.c
@@ -80,8 +80,8 @@ static void __init mpc834x_itx_setup_arc
 
 	np = of_find_node_by_type(NULL, "cpu");
 	if (np != 0) {
-		unsigned int *fp =
-		    (int *)get_property(np, "clock-frequency", NULL);
+		const unsigned int *fp =
+			get_property(np, "clock-frequency", NULL);
 		if (fp != 0)
 			loops_per_jiffy = *fp / HZ;
 		else

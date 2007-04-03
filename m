Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id D4708DDFC9
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 22:52:35 +1000 (EST)
Date: Tue, 3 Apr 2007 22:37:38 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 08/17] [POWERPC] Rename get_property to of_get_property:
	arch/powerpc/platforms
Message-Id: <20070403223738.03386a13.sfr@canb.auug.org.au>
In-Reply-To: <20070403223535.dd6731d6.sfr@canb.auug.org.au>
References: <20070403105217.7b9fea08.sfr@canb.auug.org.au>
	<20070403105401.1fcdee27.sfr@canb.auug.org.au>
	<20070403105539.7222cf2a.sfr@canb.auug.org.au>
	<20070403105650.204003b6.sfr@canb.auug.org.au>
	<20070403105748.769f156c.sfr@canb.auug.org.au>
	<20070403105852.7c7bfaa0.sfr@canb.auug.org.au>
	<20070403222406.cf39c459.sfr@canb.auug.org.au>
	<20070403222641.e93cb73b.sfr@canb.auug.org.au>
	<20070403222841.a2c6af1c.sfr@canb.auug.org.au>
	<20070403223000.5d44b2f1.sfr@canb.auug.org.au>
	<20070403223136.6ecdabbd.sfr@canb.auug.org.au>
	<20070403223257.cb8c4d15.sfr@canb.auug.org.au>
	<20070403223535.dd6731d6.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, "David S. Miller" <davem@davemloft.net>
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
 arch/powerpc/platforms/52xx/efika.c               |   15 +++++++--------
 arch/powerpc/platforms/52xx/lite5200.c            |    6 +++---
 arch/powerpc/platforms/52xx/mpc52xx_common.c      |    2 +-
 arch/powerpc/platforms/52xx/mpc52xx_pci.c         |    2 +-
 arch/powerpc/platforms/82xx/mpc82xx.c             |    6 +++---
 arch/powerpc/platforms/82xx/mpc82xx_ads.c         |   12 ++++++------
 arch/powerpc/platforms/83xx/pci.c                 |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx_ads.c         |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx_cds.c         |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx_mds.c         |    2 +-
 arch/powerpc/platforms/85xx/pci.c                 |    2 +-
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c        |    4 ++--
 arch/powerpc/platforms/86xx/pci.c                 |    2 +-
 arch/powerpc/platforms/8xx/m8xx_setup.c           |    8 ++++----
 arch/powerpc/platforms/8xx/mpc86xads_setup.c      |    2 +-
 arch/powerpc/platforms/8xx/mpc885ads_setup.c      |    2 +-
 arch/powerpc/platforms/celleb/iommu.c             |    2 +-
 arch/powerpc/platforms/celleb/pci.c               |   18 +++++++++---------
 arch/powerpc/platforms/celleb/setup.c             |    2 +-
 arch/powerpc/platforms/chrp/nvram.c               |    2 +-
 arch/powerpc/platforms/chrp/pci.c                 |   11 ++++++-----
 arch/powerpc/platforms/chrp/setup.c               |   17 +++++++++--------
 arch/powerpc/platforms/embedded6xx/linkstation.c  |    8 ++++----
 arch/powerpc/platforms/embedded6xx/ls_uart.c      |    4 ++--
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |    4 ++--
 arch/powerpc/platforms/iseries/iommu.c            |    2 +-
 arch/powerpc/platforms/iseries/pci.c              |    4 ++--
 arch/powerpc/platforms/iseries/viopath.c          |    2 +-
 arch/powerpc/platforms/maple/pci.c                |    6 +++---
 arch/powerpc/platforms/maple/setup.c              |   12 ++++++------
 arch/powerpc/platforms/pasemi/iommu.c             |    2 +-
 arch/powerpc/platforms/pasemi/setup.c             |    2 +-
 32 files changed, 85 insertions(+), 84 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/platforms/52xx/efika.c b/arch/powerpc/platforms/52xx/efika.c
index 8de0341..a6bba97 100644
--- a/arch/powerpc/platforms/52xx/efika.c
+++ b/arch/powerpc/platforms/52xx/efika.c
@@ -112,7 +112,7 @@ void __init efika_pcisetup(void)
 		return;
 	}
 
-	bus_range = get_property(pcictrl, "bus-range", &len);
+	bus_range = of_get_property(pcictrl, "bus-range", &len);
 	if (bus_range == NULL || len < 2 * sizeof(int)) {
 		printk(KERN_WARNING EFIKA_PLATFORM_NAME
 		       ": Can't get bus-range for %s\n", pcictrl->full_name);
@@ -158,18 +158,17 @@ void __init efika_pcisetup(void)
 static void efika_show_cpuinfo(struct seq_file *m)
 {
 	struct device_node *root;
-	const char *revision = NULL;
-	const char *codegendescription = NULL;
-	const char *codegenvendor = NULL;
+	const char *revision;
+	const char *codegendescription;
+	const char *codegenvendor;
 
 	root = of_find_node_by_path("/");
 	if (!root)
 		return;
 
-	revision = get_property(root, "revision", NULL);
-	codegendescription =
-		    get_property(root, "CODEGEN,description", NULL);
-	codegenvendor = get_property(root, "CODEGEN,vendor", NULL);
+	revision = of_get_property(root, "revision", NULL);
+	codegendescription = of_get_property(root, "CODEGEN,description", NULL);
+	codegenvendor = of_get_property(root, "CODEGEN,vendor", NULL);
 
 	if (codegendescription)
 		seq_printf(m, "machine\t\t: %s\n", codegendescription);
diff --git a/arch/powerpc/platforms/52xx/lite5200.c b/arch/powerpc/platforms/52xx/lite5200.c
index cc3b40d..4f5ebaa 100644
--- a/arch/powerpc/platforms/52xx/lite5200.c
+++ b/arch/powerpc/platforms/52xx/lite5200.c
@@ -94,8 +94,8 @@ static void __init lite5200_setup_arch(void)
 
 	np = of_find_node_by_type(NULL, "cpu");
 	if (np) {
-		unsigned int *fp =
-		    (int *)get_property(np, "clock-frequency", NULL);
+		const unsigned int *fp =
+			of_get_property(np, "clock-frequency", NULL);
 		if (fp != 0)
 			loops_per_jiffy = *fp / HZ;
 		else
@@ -132,7 +132,7 @@ void lite5200_show_cpuinfo(struct seq_file *m)
 	const char *model = NULL;
 
 	if (np)
-		model = get_property(np, "model", NULL);
+		model = of_get_property(np, "model", NULL);
 
 	seq_printf(m, "vendor\t\t:	Freescale Semiconductor\n");
 	seq_printf(m, "machine\t\t:	%s\n", model ? model : "unknown");
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/powerpc/platforms/52xx/mpc52xx_common.c
index ed0cb69..2dd415f 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_common.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_common.c
@@ -60,7 +60,7 @@ mpc52xx_find_ipb_freq(struct device_node *node)
 
 	of_node_get(node);
 	while (node) {
-		p_ipb_freq = get_property(node, "bus-frequency", NULL);
+		p_ipb_freq = of_get_property(node, "bus-frequency", NULL);
 		if (p_ipb_freq)
 			break;
 
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pci.c b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
index faf161b..34d34a2 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pci.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
@@ -370,7 +370,7 @@ mpc52xx_add_bridge(struct device_node *node)
 		return -EINVAL;
 	}
 
-	bus_range = get_property(node, "bus-range", &len);
+	bus_range = of_get_property(node, "bus-range", &len);
 	if (bus_range == NULL || len < 2 * sizeof(int)) {
 		printk(KERN_WARNING "Can't get %s bus-range, assume bus 0\n",
 		       node->full_name);
diff --git a/arch/powerpc/platforms/82xx/mpc82xx.c b/arch/powerpc/platforms/82xx/mpc82xx.c
index 74e7892..cc9900d 100644
--- a/arch/powerpc/platforms/82xx/mpc82xx.c
+++ b/arch/powerpc/platforms/82xx/mpc82xx.c
@@ -55,17 +55,17 @@
 static int __init get_freq(char *name, unsigned long *val)
 {
 	struct device_node *cpu;
-	unsigned int *fp;
+	const unsigned int *fp;
 	int found = 0;
 
 	/* The cpu node should have timebase and clock frequency properties */
 	cpu = of_find_node_by_type(NULL, "cpu");
 
 	if (cpu) {
-		fp = (unsigned int *)get_property(cpu, name, NULL);
+		fp = of_get_property(cpu, name, NULL);
 		if (fp) {
 			found = 1;
-			*val = *fp++;
+			*val = *fp;
 		}
 
 		of_node_put(cpu);
diff --git a/arch/powerpc/platforms/82xx/mpc82xx_ads.c b/arch/powerpc/platforms/82xx/mpc82xx_ads.c
index 7334c1a..47cb09f 100644
--- a/arch/powerpc/platforms/82xx/mpc82xx_ads.c
+++ b/arch/powerpc/platforms/82xx/mpc82xx_ads.c
@@ -456,7 +456,7 @@ void m82xx_pci_init_irq(void)
 		iounmap(immap);
 		return;
 	}
-	irq_map = get_property(np, "interrupt-map", &size);
+	irq_map = of_get_property(np, "interrupt-map", &size);
 	if ((!irq_map) || (size <= 7)) {
 		printk(KERN_INFO "No interrupt-map property of pci node\n");
 		iounmap(immap);
@@ -481,7 +481,7 @@ void m82xx_pci_init_irq(void)
 	}
 	pci_pic_node = of_node_get(np);
 	/* PCI interrupt controller registers: status and mask */
-	regs = get_property(np, "reg", &size);
+	regs = of_get_property(np, "reg", &size);
 	if ((!regs) || (size <= 2)) {
 		printk(KERN_INFO "No reg property in pci pic node\n");
 		iounmap(immap);
@@ -521,20 +521,20 @@ void __init add_bridge(struct device_node *np)
 	struct pci_controller *hose;
 	struct resource r;
 	const int *bus_range;
-	const void *ptr;
+	const uint *ptr;
 
 	memset(&r, 0, sizeof(r));
 	if (of_address_to_resource(np, 0, &r)) {
 		printk(KERN_INFO "No PCI reg property in device tree\n");
 		return;
 	}
-	if (!(ptr = get_property(np, "clock-frequency", NULL))) {
+	if (!(ptr = of_get_property(np, "clock-frequency", NULL))) {
 		printk(KERN_INFO "No clock-frequency property in PCI node");
 		return;
 	}
-	pci_clk_frq = *(uint *) ptr;
+	pci_clk_frq = *ptr;
 	of_node_put(np);
-	bus_range = get_property(np, "bus-range", &len);
+	bus_range = of_get_property(np, "bus-range", &len);
 	if (bus_range == NULL || len < 2 * sizeof(int)) {
 		printk(KERN_WARNING "Can't get bus-range for %s, assume"
 		       " bus 0\n", np->full_name);
diff --git a/arch/powerpc/platforms/83xx/pci.c b/arch/powerpc/platforms/83xx/pci.c
index 9c36505..774457d 100644
--- a/arch/powerpc/platforms/83xx/pci.c
+++ b/arch/powerpc/platforms/83xx/pci.c
@@ -60,7 +60,7 @@ int __init add_bridge(struct device_node *dev)
 	has_address = (of_address_to_resource(dev, 0, &rsrc) == 0);
 
 	/* Get bus range if any */
-	bus_range = get_property(dev, "bus-range", &len);
+	bus_range = of_get_property(dev, "bus-range", &len);
 	if (bus_range == NULL || len < 2 * sizeof(int)) {
 		printk(KERN_WARNING "Can't get bus-range for %s, assume"
 		       " bus 0\n", dev->full_name);
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index 8ed034a..5d27621 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -227,7 +227,7 @@ static void __init mpc85xx_ads_setup_arch(void)
 	if (cpu != 0) {
 		const unsigned int *fp;
 
-		fp = get_property(cpu, "clock-frequency", NULL);
+		fp = of_get_property(cpu, "clock-frequency", NULL);
 		if (fp != 0)
 			loops_per_jiffy = *fp / HZ;
 		else
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 4232686..7e71636 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -237,7 +237,7 @@ static void __init mpc85xx_cds_setup_arch(void)
 	if (cpu != 0) {
 		const unsigned int *fp;
 
-		fp = get_property(cpu, "clock-frequency", NULL);
+		fp = of_get_property(cpu, "clock-frequency", NULL);
 		if (fp != 0)
 			loops_per_jiffy = *fp / HZ;
 		else
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 81144d2..54db416 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -80,7 +80,7 @@ static void __init mpc85xx_mds_setup_arch(void)
 	np = of_find_node_by_type(NULL, "cpu");
 	if (np != NULL) {
 		const unsigned int *fp =
-		    get_property(np, "clock-frequency", NULL);
+		    of_get_property(np, "clock-frequency", NULL);
 		if (fp != NULL)
 			loops_per_jiffy = *fp / HZ;
 		else
diff --git a/arch/powerpc/platforms/85xx/pci.c b/arch/powerpc/platforms/85xx/pci.c
index 05930ee..48f17e2 100644
--- a/arch/powerpc/platforms/85xx/pci.c
+++ b/arch/powerpc/platforms/85xx/pci.c
@@ -51,7 +51,7 @@ int __init add_bridge(struct device_node *dev)
 	has_address = (of_address_to_resource(dev, 0, &rsrc) == 0);
 
 	/* Get bus range if any */
-	bus_range = get_property(dev, "bus-range", &len);
+	bus_range = of_get_property(dev, "bus-range", &len);
 	if (bus_range == NULL || len < 2 * sizeof(int)) {
 		printk(KERN_WARNING "Can't get bus-range for %s, assume"
 		       " bus 0\n", dev->full_name);
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index f42f801..3d3d98f 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -349,7 +349,7 @@ mpc86xx_hpcn_setup_arch(void)
 	if (np != 0) {
 		const unsigned int *fp;
 
-		fp = get_property(np, "clock-frequency", NULL);
+		fp = of_get_property(np, "clock-frequency", NULL);
 		if (fp != 0)
 			loops_per_jiffy = *fp / HZ;
 		else
@@ -384,7 +384,7 @@ mpc86xx_hpcn_show_cpuinfo(struct seq_file *m)
 
 	root = of_find_node_by_path("/");
 	if (root)
-		model = get_property(root, "model", NULL);
+		model = of_get_property(root, "model", NULL);
 	seq_printf(m, "Machine\t\t: %s\n", model);
 	of_node_put(root);
 
diff --git a/arch/powerpc/platforms/86xx/pci.c b/arch/powerpc/platforms/86xx/pci.c
index 481e18e..7e5a910 100644
--- a/arch/powerpc/platforms/86xx/pci.c
+++ b/arch/powerpc/platforms/86xx/pci.c
@@ -163,7 +163,7 @@ int __init add_bridge(struct device_node *dev)
 	has_address = (of_address_to_resource(dev, 0, &rsrc) == 0);
 
 	/* Get bus range if any */
-	bus_range = get_property(dev, "bus-range", &len);
+	bus_range = of_get_property(dev, "bus-range", &len);
 	if (bus_range == NULL || len < 2 * sizeof(int))
 		printk(KERN_WARNING "Can't get bus-range for %s, assume"
 		       " bus 0\n", dev->full_name);
diff --git a/arch/powerpc/platforms/8xx/m8xx_setup.c b/arch/powerpc/platforms/8xx/m8xx_setup.c
index 9ed7125..0901dba 100644
--- a/arch/powerpc/platforms/8xx/m8xx_setup.c
+++ b/arch/powerpc/platforms/8xx/m8xx_setup.c
@@ -85,17 +85,17 @@ init_internal_rtc(void)
 static int __init get_freq(char *name, unsigned long *val)
 {
         struct device_node *cpu;
-        unsigned int *fp;
+        const unsigned int *fp;
         int found = 0;
 
         /* The cpu node should have timebase and clock frequency properties */
         cpu = of_find_node_by_type(NULL, "cpu");
 
         if (cpu) {
-                fp = (unsigned int *)get_property(cpu, name, NULL);
+                fp = of_get_property(cpu, name, NULL);
                 if (fp) {
                         found = 1;
-                        *val = *fp++;
+                        *val = *fp;
                 }
 
                 of_node_put(cpu);
@@ -262,7 +262,7 @@ void mpc8xx_show_cpuinfo(struct seq_file *m)
 
 	root = of_find_node_by_path("/");
 	if (root)
-		model = get_property(root, "model", NULL);
+		model = of_get_property(root, "model", NULL);
 	seq_printf(m, "Machine\t\t: %s\n", model);
 	of_node_put(root);
 
diff --git a/arch/powerpc/platforms/8xx/mpc86xads_setup.c b/arch/powerpc/platforms/8xx/mpc86xads_setup.c
index baad9ac..a35315a 100644
--- a/arch/powerpc/platforms/8xx/mpc86xads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc86xads_setup.c
@@ -260,7 +260,7 @@ static void __init mpc86xads_setup_arch(void)
 	if (cpu != 0) {
 		const unsigned int *fp;
 
-		fp = get_property(cpu, "clock-frequency", NULL);
+		fp = of_get_property(cpu, "clock-frequency", NULL);
 		if (fp != 0)
 			loops_per_jiffy = *fp / HZ;
 		else
diff --git a/arch/powerpc/platforms/8xx/mpc885ads_setup.c b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
index e4dcdfb..a57b577 100644
--- a/arch/powerpc/platforms/8xx/mpc885ads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
@@ -346,7 +346,7 @@ static void __init mpc885ads_setup_arch(void)
 	if (cpu != 0) {
 		const unsigned int *fp;
 
-		fp = get_property(cpu, "clock-frequency", NULL);
+		fp = of_get_property(cpu, "clock-frequency", NULL);
 		if (fp != 0)
 			loops_per_jiffy = *fp / HZ;
 		else
diff --git a/arch/powerpc/platforms/celleb/iommu.c b/arch/powerpc/platforms/celleb/iommu.c
index e94de6a..755d869 100644
--- a/arch/powerpc/platforms/celleb/iommu.c
+++ b/arch/powerpc/platforms/celleb/iommu.c
@@ -37,7 +37,7 @@ static int __init find_dma_window(u64 *io_space_id, u64 *ioid,
 	const unsigned long *dma_window;
 
 	for_each_node_by_type(dn, "ioif") {
-		dma_window = get_property(dn, "toshiba,dma-window", NULL);
+		dma_window = of_get_property(dn, "toshiba,dma-window", NULL);
 		if (dma_window) {
 			*io_space_id = (dma_window[0] >> 32) & 0xffffffffUL;
 			*ioid = dma_window[0] & 0x7ffUL;
diff --git a/arch/powerpc/platforms/celleb/pci.c b/arch/powerpc/platforms/celleb/pci.c
index 98de836..d1adf34 100644
--- a/arch/powerpc/platforms/celleb/pci.c
+++ b/arch/powerpc/platforms/celleb/pci.c
@@ -309,13 +309,13 @@ static int __devinit celleb_setup_fake_pci_device(struct device_node *node,
 		goto error;
 	}
 
-	name = get_property(node, "model", &rlen);
+	name = of_get_property(node, "model", &rlen);
 	if (!name) {
 		printk(KERN_ERR "PCI: model property not found.\n");
 		goto error;
 	}
 
-	wi4 = get_property(node, "reg", &rlen);
+	wi4 = of_get_property(node, "reg", &rlen);
 	if (wi4 == NULL)
 		goto error;
 
@@ -352,10 +352,10 @@ static int __devinit celleb_setup_fake_pci_device(struct device_node *node,
 	}
 	pr_debug("PCI: res assigned 0x%016lx\n", (unsigned long)*res);
 
-	wi0 = get_property(node, "device-id", NULL);
-	wi1 = get_property(node, "vendor-id", NULL);
-	wi2 = get_property(node, "class-code", NULL);
-	wi3 = get_property(node, "revision-id", NULL);
+	wi0 = of_get_property(node, "device-id", NULL);
+	wi1 = of_get_property(node, "vendor-id", NULL);
+	wi2 = of_get_property(node, "class-code", NULL);
+	wi3 = of_get_property(node, "revision-id", NULL);
 
 	celleb_config_write_fake(*config, PCI_DEVICE_ID, 2, wi0[0] & 0xffff);
 	celleb_config_write_fake(*config, PCI_VENDOR_ID, 2, wi1[0] & 0xffff);
@@ -376,7 +376,7 @@ static int __devinit celleb_setup_fake_pci_device(struct device_node *node,
 
 	celleb_setup_pci_base_addrs(hose, devno, fn, num_base_addr);
 
-	li = get_property(node, "interrupts", &rlen);
+	li = of_get_property(node, "interrupts", &rlen);
 	val = li[0];
 	celleb_config_write_fake(*config, PCI_INTERRUPT_PIN, 1, 1);
 	celleb_config_write_fake(*config, PCI_INTERRUPT_LINE, 1, val);
@@ -424,7 +424,7 @@ static int __devinit phb_set_bus_ranges(struct device_node *dev,
 	const int *bus_range;
 	unsigned int len;
 
-	bus_range = get_property(dev, "bus-range", &len);
+	bus_range = of_get_property(dev, "bus-range", &len);
 	if (bus_range == NULL || len < 2 * sizeof(int))
 		return 1;
 
@@ -451,7 +451,7 @@ int __devinit celleb_setup_phb(struct pci_controller *phb)
 	struct device_node *node;
 	unsigned int rlen;
 
-	name = get_property(dev, "name", &rlen);
+	name = of_get_property(dev, "name", &rlen);
 	if (!name)
 		return 1;
 
diff --git a/arch/powerpc/platforms/celleb/setup.c b/arch/powerpc/platforms/celleb/setup.c
index 5f4d0d9..ab1db9d 100644
--- a/arch/powerpc/platforms/celleb/setup.c
+++ b/arch/powerpc/platforms/celleb/setup.c
@@ -67,7 +67,7 @@ static void celleb_show_cpuinfo(struct seq_file *m)
 
 	root = of_find_node_by_path("/");
 	if (root)
-		model = get_property(root, "model", NULL);
+		model = of_get_property(root, "model", NULL);
 	/* using "CHRP" is to trick anaconda into installing FCx into Celleb */
 	seq_printf(m, "machine\t\t: %s %s\n", celleb_machine_type, model);
 	of_node_put(root);
diff --git a/arch/powerpc/platforms/chrp/nvram.c b/arch/powerpc/platforms/chrp/nvram.c
index 0dd4a64..8efd424 100644
--- a/arch/powerpc/platforms/chrp/nvram.c
+++ b/arch/powerpc/platforms/chrp/nvram.c
@@ -74,7 +74,7 @@ void __init chrp_nvram_init(void)
 	if (nvram == NULL)
 		return;
 
-	nbytes_p = get_property(nvram, "#bytes", &proplen);
+	nbytes_p = of_get_property(nvram, "#bytes", &proplen);
 	if (nbytes_p == NULL || proplen != sizeof(unsigned int))
 		return;
 
diff --git a/arch/powerpc/platforms/chrp/pci.c b/arch/powerpc/platforms/chrp/pci.c
index ddb4a11..bddff33 100644
--- a/arch/powerpc/platforms/chrp/pci.c
+++ b/arch/powerpc/platforms/chrp/pci.c
@@ -218,7 +218,7 @@ chrp_find_bridges(void)
 	 * properties to adequately identify them, so we have to
 	 * look at what sort of machine this is as well.
 	 */
-	machine = get_property(root, "model", NULL);
+	machine = of_get_property(root, "model", NULL);
 	if (machine != NULL) {
 		is_longtrail = strncmp(machine, "IBM,LongTrail", 13) == 0;
 		is_mot = strncmp(machine, "MOT", 3) == 0;
@@ -237,7 +237,7 @@ chrp_find_bridges(void)
 			       dev->full_name);
 			continue;
 		}
-		bus_range = get_property(dev, "bus-range", &len);
+		bus_range = of_get_property(dev, "bus-range", &len);
 		if (bus_range == NULL || len < 2 * sizeof(int)) {
 			printk(KERN_WARNING "Can't get bus-range for %s\n",
 				dev->full_name);
@@ -263,7 +263,7 @@ chrp_find_bridges(void)
 		hose->first_busno = bus_range[0];
 		hose->last_busno = bus_range[1];
 
-		model = get_property(dev, "model", NULL);
+		model = of_get_property(dev, "model", NULL);
 		if (model == NULL)
 			model = "<none>";
 		if (device_is_compatible(dev, "IBM,python")) {
@@ -285,7 +285,8 @@ chrp_find_bridges(void)
 					   r.start + 0x000f8000,
 					   r.start + 0x000f8010);
 			if (index == 0) {
-				dma = get_property(dev, "system-dma-base",&len);
+				dma = of_get_property(dev, "system-dma-base",
+							&len);
 				if (dma && len >= sizeof(*dma)) {
 					dma = (unsigned int *)
 						(((unsigned long)dma) +
@@ -303,7 +304,7 @@ chrp_find_bridges(void)
 
 		/* check the first bridge for a property that we can
 		   use to set pci_dram_offset */
-		dma = get_property(dev, "ibm,dma-ranges", &len);
+		dma = of_get_property(dev, "ibm,dma-ranges", &len);
 		if (index == 0 && dma != NULL && len >= 6 * sizeof(*dma)) {
 			pci_dram_offset = dma[2] - dma[3];
 			printk("pci_dram_offset = %lx\n", pci_dram_offset);
diff --git a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
index c0d07fb..d23e899 100644
--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -113,7 +113,7 @@ void chrp_show_cpuinfo(struct seq_file *m)
 
 	root = find_path_device("/");
 	if (root)
-		model = get_property(root, "model", NULL);
+		model = of_get_property(root, "model", NULL);
 	seq_printf(m, "machine\t\t: CHRP %s\n", model);
 
 	/* longtrail (goldengate) stuff */
@@ -206,7 +206,8 @@ static void __init sio_init(void)
 	struct device_node *root;
 
 	if ((root = find_path_device("/")) &&
-	    !strncmp(get_property(root, "model", NULL), "IBM,LongTrail", 13)) {
+	    !strncmp(of_get_property(root, "model", NULL),
+			"IBM,LongTrail", 13)) {
 		/* logical device 0 (KBC/Keyboard) */
 		sio_fixup_irq("keyboard", 0, 1, 2);
 		/* select logical device 1 (KBC/Mouse) */
@@ -226,7 +227,7 @@ static void __init pegasos_set_l2cr(void)
 	/* Enable L2 cache if needed */
 	np = find_type_devices("cpu");
 	if (np != NULL) {
-		const unsigned int *l2cr = get_property(np, "l2cr", NULL);
+		const unsigned int *l2cr = of_get_property(np, "l2cr", NULL);
 		if (l2cr == NULL) {
 			printk ("Pegasos l2cr : no cpu l2cr property found\n");
 			return;
@@ -257,7 +258,7 @@ void __init chrp_setup_arch(void)
 	loops_per_jiffy = 50000000/HZ;
 
 	if (root)
-		machine = get_property(root, "model", NULL);
+		machine = of_get_property(root, "model", NULL);
 	if (machine && strncmp(machine, "Pegasos", 7) == 0) {
 		_chrp_type = _CHRP_Pegasos;
 	} else if (machine && strncmp(machine, "IBM", 3) == 0) {
@@ -361,7 +362,7 @@ static void __init chrp_find_openpic(void)
 		return;
 	root = of_find_node_by_path("/");
 	if (root) {
-		opprop = get_property(root, "platform-open-pic", &oplen);
+		opprop = of_get_property(root, "platform-open-pic", &oplen);
 		na = of_n_addr_cells(root);
 	}
 	if (opprop && oplen >= na * sizeof(unsigned int)) {
@@ -378,7 +379,7 @@ static void __init chrp_find_openpic(void)
 
 	printk(KERN_INFO "OpenPIC at %lx\n", opaddr);
 
-	iranges = get_property(np, "interrupt-ranges", &len);
+	iranges = of_get_property(np, "interrupt-ranges", &len);
 	if (iranges == NULL)
 		len = 0;	/* non-distributed mpic */
 	else
@@ -464,7 +465,7 @@ static void __init chrp_find_8259(void)
 	 * from anyway
 	 */
 	for (np = find_devices("pci"); np != NULL; np = np->next) {
-		const unsigned int *addrp = get_property(np,
+		const unsigned int *addrp = of_get_property(np,
 				"8259-interrupt-acknowledge", NULL);
 
 		if (addrp == NULL)
@@ -544,7 +545,7 @@ chrp_init2(void)
 	 */
 	device = find_devices("rtas");
 	if (device)
-		p = get_property(device, "rtas-event-scan-rate", NULL);
+		p = of_get_property(device, "rtas-event-scan-rate", NULL);
 	if (p && *p) {
 		/*
 		 * Arrange to call chrp_event_scan at least *p times
diff --git a/arch/powerpc/platforms/embedded6xx/linkstation.c b/arch/powerpc/platforms/embedded6xx/linkstation.c
index 3f6c411..b412f00 100644
--- a/arch/powerpc/platforms/embedded6xx/linkstation.c
+++ b/arch/powerpc/platforms/embedded6xx/linkstation.c
@@ -58,11 +58,11 @@ static int __init add_bridge(struct device_node *dev)
 {
 	int len;
 	struct pci_controller *hose;
-	int *bus_range;
+	const int *bus_range;
 
 	printk("Adding PCI host bridge %s\n", dev->full_name);
 
-	bus_range = (int *) get_property(dev, "bus-range", &len);
+	bus_range = of_get_property(dev, "bus-range", &len);
 	if (bus_range == NULL || len < 2 * sizeof(int))
 		printk(KERN_WARNING "Can't get bus-range for %s, assume"
 				" bus 0\n", dev->full_name);
@@ -106,7 +106,7 @@ static void __init linkstation_init_IRQ(void)
 {
 	struct mpic *mpic;
 	struct device_node *dnp;
-	void *prop;
+	const u32 *prop;
 	int size;
 	phys_addr_t paddr;
 
@@ -114,7 +114,7 @@ static void __init linkstation_init_IRQ(void)
 	if (dnp == NULL)
 		return;
 
-	prop = (struct device_node *)get_property(dnp, "reg", &size);
+	prop = of_get_property(dnp, "reg", &size);
 	paddr = (phys_addr_t)of_translate_address(dnp, prop);
 
 	mpic = mpic_alloc(dnp, paddr, MPIC_PRIMARY | MPIC_WANTS_RESET, 4, 32, " EPIC     ");
diff --git a/arch/powerpc/platforms/embedded6xx/ls_uart.c b/arch/powerpc/platforms/embedded6xx/ls_uart.c
index 0e83776..d0bee9f 100644
--- a/arch/powerpc/platforms/embedded6xx/ls_uart.c
+++ b/arch/powerpc/platforms/embedded6xx/ls_uart.c
@@ -110,8 +110,8 @@ static int __init ls_uarts_init(void)
 	if (!avr)
 		return -EINVAL;
 
-	avr_clock = *(u32*)get_property(avr, "clock-frequency", &len);
-	phys_addr = ((u32*)get_property(avr, "reg", &len))[0];
+	avr_clock = *(u32*)of_get_property(avr, "clock-frequency", &len);
+	phys_addr = ((u32*)of_get_property(avr, "reg", &len))[0];
 
 	if (!avr_clock || !phys_addr)
 		return -EINVAL;
diff --git a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
index 9922574..aa493e4 100644
--- a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
+++ b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
@@ -82,7 +82,7 @@ static void __init mpc7448_hpc2_setup_arch(void)
 	if (cpu != 0) {
 		const unsigned int *fp;
 
-		fp = get_property(cpu, "clock-frequency", NULL);
+		fp = of_get_property(cpu, "clock-frequency", NULL);
 		if (fp != 0)
 			loops_per_jiffy = *fp / HZ;
 		else
@@ -133,7 +133,7 @@ static void __init mpc7448_hpc2_init_IRQ(void)
 	tsi_pic = of_find_node_by_type(NULL, "open-pic");
 	if (tsi_pic) {
 		unsigned int size;
-		const void *prop = get_property(tsi_pic, "reg", &size);
+		const void *prop = of_get_property(tsi_pic, "reg", &size);
 		mpic_paddr = of_translate_address(tsi_pic, prop);
 	}
 
diff --git a/arch/powerpc/platforms/iseries/iommu.c b/arch/powerpc/platforms/iseries/iommu.c
index 7df2902..3b6a966 100644
--- a/arch/powerpc/platforms/iseries/iommu.c
+++ b/arch/powerpc/platforms/iseries/iommu.c
@@ -171,7 +171,7 @@ void iommu_devnode_init_iSeries(struct pci_dev *pdev, struct device_node *dn)
 {
 	struct iommu_table *tbl;
 	struct pci_dn *pdn = PCI_DN(dn);
-	const u32 *lsn = get_property(dn, "linux,logical-slot-number", NULL);
+	const u32 *lsn = of_get_property(dn, "linux,logical-slot-number", NULL);
 
 	BUG_ON(lsn == NULL);
 
diff --git a/arch/powerpc/platforms/iseries/pci.c b/arch/powerpc/platforms/iseries/pci.c
index 4a06d9c..0ae3c00 100644
--- a/arch/powerpc/platforms/iseries/pci.c
+++ b/arch/powerpc/platforms/iseries/pci.c
@@ -177,7 +177,7 @@ void __init iSeries_pci_final_fixup(void)
 			struct pci_dn *pdn = PCI_DN(node);
 			const u32 *agent;
 
-			agent = get_property(node, "linux,agent-id", NULL);
+			agent = of_get_property(node, "linux,agent-id", NULL);
 			if ((pdn != NULL) && (agent != NULL)) {
 				u8 irq = iSeries_allocate_IRQ(pdn->busno, 0,
 						pdn->bussubno);
@@ -755,7 +755,7 @@ void __init iSeries_pcibios_init(void)
 		if ((node->type == NULL) || (strcmp(node->type, "pci") != 0))
 			continue;
 
-		busp = get_property(node, "bus-range", NULL);
+		busp = of_get_property(node, "bus-range", NULL);
 		if (busp == NULL)
 			continue;
 		bus = *busp;
diff --git a/arch/powerpc/platforms/iseries/viopath.c b/arch/powerpc/platforms/iseries/viopath.c
index e2100ec..2ca2d8a 100644
--- a/arch/powerpc/platforms/iseries/viopath.c
+++ b/arch/powerpc/platforms/iseries/viopath.c
@@ -155,7 +155,7 @@ static int proc_viopath_show(struct seq_file *m, void *v)
 	node = of_find_node_by_path("/");
 	sysid = NULL;
 	if (node != NULL)
-		sysid = get_property(node, "system-id", NULL);
+		sysid = of_get_property(node, "system-id", NULL);
 
 	if (sysid == NULL)
 		seq_printf(m, "SRLNBR=<UNKNOWN>\n");
diff --git a/arch/powerpc/platforms/maple/pci.c b/arch/powerpc/platforms/maple/pci.c
index ab5a6f1..b1d3b99 100644
--- a/arch/powerpc/platforms/maple/pci.c
+++ b/arch/powerpc/platforms/maple/pci.c
@@ -44,11 +44,11 @@ static int __init fixup_one_level_bus_range(struct device_node *node, int higher
 		int len;
 
 		/* For PCI<->PCI bridges or CardBus bridges, we go down */
-		class_code = get_property(node, "class-code", NULL);
+		class_code = of_get_property(node, "class-code", NULL);
 		if (!class_code || ((*class_code >> 8) != PCI_CLASS_BRIDGE_PCI &&
 			(*class_code >> 8) != PCI_CLASS_BRIDGE_CARDBUS))
 			continue;
-		bus_range = get_property(node, "bus-range", &len);
+		bus_range = of_get_property(node, "bus-range", &len);
 		if (bus_range != NULL && len > 2 * sizeof(int)) {
 			if (bus_range[1] > higher)
 				higher = bus_range[1];
@@ -454,7 +454,7 @@ static int __init add_bridge(struct device_node *dev)
 
 	DBG("Adding PCI host bridge %s\n", dev->full_name);
 
-	bus_range = get_property(dev, "bus-range", &len);
+	bus_range = of_get_property(dev, "bus-range", &len);
 	if (bus_range == NULL || len < 2 * sizeof(int)) {
 		printk(KERN_WARNING "Can't get bus-range for %s, assume bus 0\n",
 		dev->full_name);
diff --git a/arch/powerpc/platforms/maple/setup.c b/arch/powerpc/platforms/maple/setup.c
index a3f05c5..b05eb43 100644
--- a/arch/powerpc/platforms/maple/setup.c
+++ b/arch/powerpc/platforms/maple/setup.c
@@ -114,8 +114,8 @@ static void maple_restart(char *cmd)
 		printk(KERN_EMERG "Maple: Unable to find Service Processor\n");
 		goto fail;
 	}
-	maple_nvram_offset = get_property(sp, "restart-addr", NULL);
-	maple_nvram_command = get_property(sp, "restart-value", NULL);
+	maple_nvram_offset = of_get_property(sp, "restart-addr", NULL);
+	maple_nvram_command = of_get_property(sp, "restart-value", NULL);
 	of_node_put(sp);
 
 	/* send command */
@@ -141,8 +141,8 @@ static void maple_power_off(void)
 		printk(KERN_EMERG "Maple: Unable to find Service Processor\n");
 		goto fail;
 	}
-	maple_nvram_offset = get_property(sp, "power-off-addr", NULL);
-	maple_nvram_command = get_property(sp, "power-off-value", NULL);
+	maple_nvram_offset = of_get_property(sp, "power-off-addr", NULL);
+	maple_nvram_command = of_get_property(sp, "power-off-value", NULL);
 	of_node_put(sp);
 
 	/* send command */
@@ -250,7 +250,7 @@ static void __init maple_init_IRQ(void)
 	/* Find address list in /platform-open-pic */
 	root = of_find_node_by_path("/");
 	naddr = of_n_addr_cells(root);
-	opprop = get_property(root, "platform-open-pic", &opplen);
+	opprop = of_get_property(root, "platform-open-pic", &opplen);
 	if (opprop != 0) {
 		openpic_addr = of_read_number(opprop, naddr);
 		has_isus = (opplen > naddr);
@@ -261,7 +261,7 @@ static void __init maple_init_IRQ(void)
 	BUG_ON(openpic_addr == 0);
 
 	/* Check for a big endian MPIC */
-	if (get_property(np, "big-endian", NULL) != NULL)
+	if (of_get_property(np, "big-endian", NULL) != NULL)
 		flags |= MPIC_BIG_ENDIAN;
 
 	/* XXX Maple specific bits */
diff --git a/arch/powerpc/platforms/pasemi/iommu.c b/arch/powerpc/platforms/pasemi/iommu.c
index 07819cd..95fa6a7 100644
--- a/arch/powerpc/platforms/pasemi/iommu.c
+++ b/arch/powerpc/platforms/pasemi/iommu.c
@@ -249,7 +249,7 @@ void iommu_init_early_pasemi(void)
 	iommu_off = 1;
 #else
 	iommu_off = of_chosen &&
-			get_property(of_chosen, "linux,iommu-off", NULL);
+			of_get_property(of_chosen, "linux,iommu-off", NULL);
 #endif
 	if (iommu_off) {
 		/* Direct I/O, IOMMU off */
diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index d4fd613..32a614c 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -137,7 +137,7 @@ static __init void pas_init_IRQ(void)
 	/* Find address list in /platform-open-pic */
 	root = of_find_node_by_path("/");
 	naddr = of_n_addr_cells(root);
-	opprop = get_property(root, "platform-open-pic", &opplen);
+	opprop = of_get_property(root, "platform-open-pic", &opplen);
 	if (!opprop) {
 		printk(KERN_ERR "No platform-open-pic property.\n");
 		of_node_put(root);
-- 
1.5.0.3

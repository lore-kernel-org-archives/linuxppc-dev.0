Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 0EBCDDDF04
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 22:52:29 +1000 (EST)
Date: Tue, 3 Apr 2007 22:26:41 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 02/17] [POWERPC] Rename get_property to of_get_property:
	arch/powerpc/kernel
Message-Id: <20070403222641.e93cb73b.sfr@canb.auug.org.au>
In-Reply-To: <20070403222406.cf39c459.sfr@canb.auug.org.au>
References: <20070403105217.7b9fea08.sfr@canb.auug.org.au>
	<20070403105401.1fcdee27.sfr@canb.auug.org.au>
	<20070403105539.7222cf2a.sfr@canb.auug.org.au>
	<20070403105650.204003b6.sfr@canb.auug.org.au>
	<20070403105748.769f156c.sfr@canb.auug.org.au>
	<20070403105852.7c7bfaa0.sfr@canb.auug.org.au>
	<20070403222406.cf39c459.sfr@canb.auug.org.au>
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
 arch/powerpc/kernel/btext.c            |   22 ++++++++--------
 arch/powerpc/kernel/ibmebus.c          |   22 +++++++---------
 arch/powerpc/kernel/legacy_serial.c    |   24 +++++++++---------
 arch/powerpc/kernel/lparcfg.c          |    9 +++---
 arch/powerpc/kernel/machine_kexec_64.c |    4 +-
 arch/powerpc/kernel/of_platform.c      |    4 +-
 arch/powerpc/kernel/pci_32.c           |   14 +++++-----
 arch/powerpc/kernel/pci_64.c           |   16 ++++++------
 arch/powerpc/kernel/pci_dn.c           |    9 +++---
 arch/powerpc/kernel/prom_parse.c       |   43 +++++++++++++++----------------
 arch/powerpc/kernel/rtas-proc.c        |    4 +-
 arch/powerpc/kernel/rtas.c             |   16 ++++++------
 arch/powerpc/kernel/rtas_pci.c         |   10 +++---
 arch/powerpc/kernel/setup-common.c     |    7 +++--
 arch/powerpc/kernel/setup_64.c         |   10 +++---
 arch/powerpc/kernel/sysfs.c            |    2 +-
 arch/powerpc/kernel/time.c             |    2 +-
 arch/powerpc/kernel/vio.c              |   14 +++++-----
 18 files changed, 116 insertions(+), 116 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/btext.c b/arch/powerpc/kernel/btext.c
index 3678997..e7b6846 100644
--- a/arch/powerpc/kernel/btext.c
+++ b/arch/powerpc/kernel/btext.c
@@ -161,33 +161,33 @@ int btext_initialize(struct device_node *np)
 	unsigned long address = 0;
 	const u32 *prop;
 
-	prop = get_property(np, "linux,bootx-width", NULL);
+	prop = of_get_property(np, "linux,bootx-width", NULL);
 	if (prop == NULL)
-		prop = get_property(np, "width", NULL);
+		prop = of_get_property(np, "width", NULL);
 	if (prop == NULL)
 		return -EINVAL;
 	width = *prop;
-	prop = get_property(np, "linux,bootx-height", NULL);
+	prop = of_get_property(np, "linux,bootx-height", NULL);
 	if (prop == NULL)
-		prop = get_property(np, "height", NULL);
+		prop = of_get_property(np, "height", NULL);
 	if (prop == NULL)
 		return -EINVAL;
 	height = *prop;
-	prop = get_property(np, "linux,bootx-depth", NULL);
+	prop = of_get_property(np, "linux,bootx-depth", NULL);
 	if (prop == NULL)
-		prop = get_property(np, "depth", NULL);
+		prop = of_get_property(np, "depth", NULL);
 	if (prop == NULL)
 		return -EINVAL;
 	depth = *prop;
 	pitch = width * ((depth + 7) / 8);
-	prop = get_property(np, "linux,bootx-linebytes", NULL);
+	prop = of_get_property(np, "linux,bootx-linebytes", NULL);
 	if (prop == NULL)
-		prop = get_property(np, "linebytes", NULL);
+		prop = of_get_property(np, "linebytes", NULL);
 	if (prop && *prop != 0xffffffffu)
 		pitch = *prop;
 	if (pitch == 1)
 		pitch = 0x1000;
-	prop = get_property(np, "address", NULL);
+	prop = of_get_property(np, "address", NULL);
 	if (prop)
 		address = *prop;
 
@@ -219,7 +219,7 @@ int __init btext_find_display(int allow_nonstdout)
 	struct device_node *np = NULL; 
 	int rc = -ENODEV;
 
-	name = get_property(of_chosen, "linux,stdout-path", NULL);
+	name = of_get_property(of_chosen, "linux,stdout-path", NULL);
 	if (name != NULL) {
 		np = of_find_node_by_path(name);
 		if (np != NULL) {
@@ -236,7 +236,7 @@ int __init btext_find_display(int allow_nonstdout)
 		return rc;
 
 	for (np = NULL; (np = of_find_node_by_type(np, "display"));) {
-		if (get_property(np, "linux,opened", NULL)) {
+		if (of_get_property(np, "linux,opened", NULL)) {
 			printk("trying %s ...\n", np->full_name);
 			rc = btext_initialize(np);
 			printk("result: %d\n", rc);
diff --git a/arch/powerpc/kernel/ibmebus.c b/arch/powerpc/kernel/ibmebus.c
index 8ed1163..48446a6 100644
--- a/arch/powerpc/kernel/ibmebus.c
+++ b/arch/powerpc/kernel/ibmebus.c
@@ -193,7 +193,7 @@ static struct ibmebus_dev* __devinit ibmebus_register_device_node(
 	const char *loc_code;
 	int length;
 
-	loc_code = get_property(dn, "ibm,loc-code", NULL);
+	loc_code = of_get_property(dn, "ibm,loc-code", NULL);
 	if (!loc_code) {
                 printk(KERN_WARNING "%s: node %s missing 'ibm,loc-code'\n",
 		       __FUNCTION__, dn->name ? dn->name : "<unknown>");
@@ -256,12 +256,11 @@ static void ibmebus_add_devices_by_id(struct of_device_id *idt)
 static int ibmebus_match_helper_name(struct device *dev, void *data)
 {
 	const struct ibmebus_dev *ebus_dev = to_ibmebus_dev(dev);
-	char *name;
+	const char *name;
 
-	name = (char*)get_property(
-		ebus_dev->ofdev.node, "name", NULL);
+	name = of_get_property(ebus_dev->ofdev.node, "name", NULL);
 
-	if (name && (strcmp((char*)data, name) == 0))
+	if (name && (strcmp(data, name) == 0))
 		return 1;
 
 	return 0;
@@ -363,7 +362,7 @@ static ssize_t name_show(struct device *dev,
 			 struct device_attribute *attr, char *buf)
 {
 	struct ibmebus_dev *ebus_dev = to_ibmebus_dev(dev);
-	char *name = (char*)get_property(ebus_dev->ofdev.node, "name", NULL);
+	const char *name = of_get_property(ebus_dev->ofdev.node, "name", NULL);
 	return sprintf(buf, "%s\n", name);
 }
 
@@ -375,12 +374,11 @@ static struct device_attribute ibmebus_dev_attrs[] = {
 static int ibmebus_match_helper_loc_code(struct device *dev, void *data)
 {
 	const struct ibmebus_dev *ebus_dev = to_ibmebus_dev(dev);
-	char *loc_code;
+	const char *loc_code;
 
-	loc_code = (char*)get_property(
-		ebus_dev->ofdev.node, "ibm,loc-code", NULL);
+	loc_code = of_get_property(ebus_dev->ofdev.node, "ibm,loc-code", NULL);
 
-	if (loc_code && (strcmp((char*)data, loc_code) == 0))
+	if (loc_code && (strcmp(data, loc_code) == 0))
 		return 1;
 
 	return 0;
@@ -391,7 +389,7 @@ static ssize_t ibmebus_store_probe(struct bus_type *bus,
 {
 	struct device_node *dn = NULL;
 	struct ibmebus_dev *dev;
-	char *loc_code;
+	const char *loc_code;
 	char parm[MAX_LOC_CODE_LENGTH];
 
 	if (count >= MAX_LOC_CODE_LENGTH)
@@ -409,7 +407,7 @@ static ssize_t ibmebus_store_probe(struct bus_type *bus,
 	}
 
 	while ((dn = of_find_all_nodes(dn))) {
-		loc_code = (char *)get_property(dn, "ibm,loc-code", NULL);
+		loc_code = of_get_property(dn, "ibm,loc-code", NULL);
 		if (loc_code && (strncmp(loc_code, parm, count) == 0)) {
 			dev = ibmebus_register_device_node(dn);
 			if (IS_ERR(dev)) {
diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index 325f490..63dd2c3 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -44,12 +44,12 @@ static int __init add_legacy_port(struct device_node *np, int want_index,
 	int index;
 
 	/* get clock freq. if present */
-	clk = get_property(np, "clock-frequency", NULL);
+	clk = of_get_property(np, "clock-frequency", NULL);
 	if (clk && *clk)
 		clock = *clk;
 
 	/* get default speed if present */
-	spd = get_property(np, "current-speed", NULL);
+	spd = of_get_property(np, "current-speed", NULL);
 
 	/* If we have a location index, then try to use it */
 	if (want_index >= 0 && want_index < MAX_LEGACY_SERIAL_PORTS)
@@ -121,11 +121,11 @@ static int __init add_legacy_soc_port(struct device_node *np,
 	/* We only support ports that have a clock frequency properly
 	 * encoded in the device-tree.
 	 */
-	if (get_property(np, "clock-frequency", NULL) == NULL)
+	if (of_get_property(np, "clock-frequency", NULL) == NULL)
 		return -1;
 
 	/* if rtas uses this device, don't try to use it as well */
-	if (get_property(np, "used-by-rtas", NULL) != NULL)
+	if (of_get_property(np, "used-by-rtas", NULL) != NULL)
 		return -1;
 
 	/* Get the address */
@@ -157,7 +157,7 @@ static int __init add_legacy_isa_port(struct device_node *np,
 	DBG(" -> add_legacy_isa_port(%s)\n", np->full_name);
 
 	/* Get the ISA port number */
-	reg = get_property(np, "reg", NULL);
+	reg = of_get_property(np, "reg", NULL);
 	if (reg == NULL)
 		return -1;
 
@@ -168,7 +168,7 @@ static int __init add_legacy_isa_port(struct device_node *np,
 	/* Now look for an "ibm,aix-loc" property that gives us ordering
 	 * if any...
 	 */
-	typep = get_property(np, "ibm,aix-loc", NULL);
+	typep = of_get_property(np, "ibm,aix-loc", NULL);
 
 	/* If we have a location index, then use it */
 	if (typep && *typep == 'S')
@@ -206,7 +206,7 @@ static int __init add_legacy_pci_port(struct device_node *np,
 	 * compatible UARTs on PCI need all sort of quirks (port offsets
 	 * etc...) that this code doesn't know about
 	 */
-	if (get_property(np, "clock-frequency", NULL) == NULL)
+	if (of_get_property(np, "clock-frequency", NULL) == NULL)
 		return -1;
 
 	/* Get the PCI address. Assume BAR 0 */
@@ -232,7 +232,7 @@ static int __init add_legacy_pci_port(struct device_node *np,
 	 * we get to their "reg" property
 	 */
 	if (np != pci_dev) {
-		const u32 *reg = get_property(np, "reg", NULL);
+		const u32 *reg = of_get_property(np, "reg", NULL);
 		if (reg && (*reg < 4))
 			index = lindex = *reg;
 	}
@@ -296,7 +296,7 @@ void __init find_legacy_serial_ports(void)
 	DBG(" -> find_legacy_serial_port()\n");
 
 	/* Now find out if one of these is out firmware console */
-	path = get_property(of_chosen, "linux,stdout-path", NULL);
+	path = of_get_property(of_chosen, "linux,stdout-path", NULL);
 	if (path != NULL) {
 		stdout = of_find_node_by_path(path);
 		if (stdout)
@@ -529,7 +529,7 @@ static int __init check_legacy_serial_console(void)
 	}
 	/* We are getting a weird phandle from OF ... */
 	/* ... So use the full path instead */
-	name = get_property(of_chosen, "linux,stdout-path", NULL);
+	name = of_get_property(of_chosen, "linux,stdout-path", NULL);
 	if (name == NULL) {
 		DBG(" no linux,stdout-path !\n");
 		return -ENODEV;
@@ -541,12 +541,12 @@ static int __init check_legacy_serial_console(void)
 	}
 	DBG("stdout is %s\n", prom_stdout->full_name);
 
-	name = get_property(prom_stdout, "name", NULL);
+	name = of_get_property(prom_stdout, "name", NULL);
 	if (!name) {
 		DBG(" stdout package has no name !\n");
 		goto not_found;
 	}
-	spd = get_property(prom_stdout, "current-speed", NULL);
+	spd = of_get_property(prom_stdout, "current-speed", NULL);
 	if (spd)
 		speed = *spd;
 
diff --git a/arch/powerpc/kernel/lparcfg.c b/arch/powerpc/kernel/lparcfg.c
index 89486b6..b8dc1ee 100644
--- a/arch/powerpc/kernel/lparcfg.c
+++ b/arch/powerpc/kernel/lparcfg.c
@@ -323,7 +323,7 @@ static int pseries_lparcfg_data(struct seq_file *m, void *v)
 
 	rtas_node = find_path_device("/rtas");
 	if (rtas_node)
-		lrdrp = get_property(rtas_node, "ibm,lrdr-capacity", NULL);
+		lrdrp = of_get_property(rtas_node, "ibm,lrdr-capacity", NULL);
 
 	if (lrdrp == NULL) {
 		partition_potential_processors = vdso_data->processorCount;
@@ -539,21 +539,22 @@ static int lparcfg_data(struct seq_file *m, void *v)
 
 	rootdn = find_path_device("/");
 	if (rootdn) {
-		tmp = get_property(rootdn, "model", NULL);
+		tmp = of_get_property(rootdn, "model", NULL);
 		if (tmp) {
 			model = tmp;
 			/* Skip "IBM," - see platforms/iseries/dt.c */
 			if (firmware_has_feature(FW_FEATURE_ISERIES))
 				model += 4;
 		}
-		tmp = get_property(rootdn, "system-id", NULL);
+		tmp = of_get_property(rootdn, "system-id", NULL);
 		if (tmp) {
 			system_id = tmp;
 			/* Skip "IBM," - see platforms/iseries/dt.c */
 			if (firmware_has_feature(FW_FEATURE_ISERIES))
 				system_id += 4;
 		}
-		lp_index_ptr = get_property(rootdn, "ibm,partition-no", NULL);
+		lp_index_ptr = of_get_property(rootdn, "ibm,partition-no",
+					NULL);
 		if (lp_index_ptr)
 			lp_index = *lp_index_ptr;
 	}
diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index b975b5b..704375b 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -72,8 +72,8 @@ int default_machine_kexec_prepare(struct kimage *image)
 	/* We also should not overwrite the tce tables */
 	for (node = of_find_node_by_type(NULL, "pci"); node != NULL;
 			node = of_find_node_by_type(node, "pci")) {
-		basep = get_property(node, "linux,tce-base", NULL);
-		sizep = get_property(node, "linux,tce-size", NULL);
+		basep = of_get_property(node, "linux,tce-base", NULL);
+		sizep = of_get_property(node, "linux,tce-size", NULL);
 		if (basep == NULL || sizep == NULL)
 			continue;
 
diff --git a/arch/powerpc/kernel/of_platform.c b/arch/powerpc/kernel/of_platform.c
index b734517..07324ae 100644
--- a/arch/powerpc/kernel/of_platform.c
+++ b/arch/powerpc/kernel/of_platform.c
@@ -177,7 +177,7 @@ static void of_platform_make_bus_id(struct of_device *dev)
 	 * and 'D' for MMIO DCRs.
 	 */
 #ifdef CONFIG_PPC_DCR
-	reg = get_property(node, "dcr-reg", NULL);
+	reg = of_get_property(node, "dcr-reg", NULL);
 	if (reg) {
 #ifdef CONFIG_PPC_DCR_NATIVE
 		snprintf(name, BUS_ID_SIZE, "d%x.%s",
@@ -197,7 +197,7 @@ static void of_platform_make_bus_id(struct of_device *dev)
 	/*
 	 * For MMIO, get the physical address
 	 */
-	reg = get_property(node, "reg", NULL);
+	reg = of_get_property(node, "reg", NULL);
 	if (reg) {
 		addr = of_translate_address(node, reg);
 		if (addr != OF_BAD_ADDR) {
diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index e99ffe2..ae04f94 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -637,7 +637,7 @@ make_one_node_map(struct device_node* node, u8 pci_bus)
 
 	if (pci_bus >= pci_bus_count)
 		return;
-	bus_range = get_property(node, "bus-range", &len);
+	bus_range = of_get_property(node, "bus-range", &len);
 	if (bus_range == NULL || len < 2 * sizeof(int)) {
 		printk(KERN_WARNING "Can't get bus-range for %s, "
 		       "assuming it starts at 0\n", node->full_name);
@@ -649,11 +649,11 @@ make_one_node_map(struct device_node* node, u8 pci_bus)
 		struct pci_dev* dev;
 		const unsigned int *class_code, *reg;
 	
-		class_code = get_property(node, "class-code", NULL);
+		class_code = of_get_property(node, "class-code", NULL);
 		if (!class_code || ((*class_code >> 8) != PCI_CLASS_BRIDGE_PCI &&
 			(*class_code >> 8) != PCI_CLASS_BRIDGE_CARDBUS))
 			continue;
-		reg = get_property(node, "reg", NULL);
+		reg = of_get_property(node, "reg", NULL);
 		if (!reg)
 			continue;
 		dev = pci_find_slot(pci_bus, ((reg[0] >> 8) & 0xff));
@@ -724,7 +724,7 @@ scan_OF_pci_childs(struct device_node* node, pci_OF_scan_iterator filter, void*
 		 * a fake root for all functions of a multi-function device,
 		 * we go down them as well.
 		 */
-		class_code = get_property(node, "class-code", NULL);
+		class_code = of_get_property(node, "class-code", NULL);
 		if ((!class_code || ((*class_code >> 8) != PCI_CLASS_BRIDGE_PCI &&
 			(*class_code >> 8) != PCI_CLASS_BRIDGE_CARDBUS)) &&
 			strcmp(node->name, "multifunc-device"))
@@ -744,7 +744,7 @@ static struct device_node *scan_OF_for_pci_dev(struct device_node *parent,
 	unsigned int psize;
 
 	while ((np = of_get_next_child(parent, np)) != NULL) {
-		reg = get_property(np, "reg", &psize);
+		reg = of_get_property(np, "reg", &psize);
 		if (reg == NULL || psize < 4)
 			continue;
 		if (((reg[0] >> 8) & 0xff) == devfn)
@@ -859,7 +859,7 @@ pci_device_from_OF_node(struct device_node* node, u8* bus, u8* devfn)
 	if (!scan_OF_pci_childs(((struct device_node*)hose->arch_data)->child,
 			find_OF_pci_device_filter, (void *)node))
 		return -ENODEV;
-	reg = get_property(node, "reg", NULL);
+	reg = of_get_property(node, "reg", NULL);
 	if (!reg)
 		return -ENODEV;
 	*bus = (reg[0] >> 16) & 0xff;
@@ -902,7 +902,7 @@ pci_process_bridge_OF_ranges(struct pci_controller *hose,
 	 * that can have more than 3 ranges, fortunately using contiguous
 	 * addresses -- BenH
 	 */
-	dt_ranges = get_property(dev, "ranges", &rlen);
+	dt_ranges = of_get_property(dev, "ranges", &rlen);
 	if (!dt_ranges)
 		return;
 	/* Sanity check, though hopefully that never happens */
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 84b4f66..60d7d4b 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -268,7 +268,7 @@ static u32 get_int_prop(struct device_node *np, const char *name, u32 def)
 	const u32 *prop;
 	int len;
 
-	prop = get_property(np, name, &len);
+	prop = of_get_property(np, name, &len);
 	if (prop && len >= 4)
 		return *prop;
 	return def;
@@ -301,7 +301,7 @@ static void pci_parse_of_addrs(struct device_node *node, struct pci_dev *dev)
 	u32 i;
 	int proplen;
 
-	addrs = get_property(node, "assigned-addresses", &proplen);
+	addrs = of_get_property(node, "assigned-addresses", &proplen);
 	if (!addrs)
 		return;
 	DBG("    parse addresses (%d bytes) @ %p\n", proplen, addrs);
@@ -343,7 +343,7 @@ struct pci_dev *of_create_pci_dev(struct device_node *node,
 	dev = kzalloc(sizeof(struct pci_dev), GFP_KERNEL);
 	if (!dev)
 		return NULL;
-	type = get_property(node, "device_type", NULL);
+	type = of_get_property(node, "device_type", NULL);
 	if (type == NULL)
 		type = "";
 
@@ -407,7 +407,7 @@ void __devinit of_scan_bus(struct device_node *node,
 
 	while ((child = of_get_next_child(node, child)) != NULL) {
 		DBG("  * %s\n", child->full_name);
-		reg = get_property(child, "reg", &reglen);
+		reg = of_get_property(child, "reg", &reglen);
 		if (reg == NULL || reglen < 20)
 			continue;
 		devfn = (reg[0] >> 8) & 0xff;
@@ -440,13 +440,13 @@ void __devinit of_scan_pci_bridge(struct device_node *node,
 	DBG("of_scan_pci_bridge(%s)\n", node->full_name);
 
 	/* parse bus-range property */
-	busrange = get_property(node, "bus-range", &len);
+	busrange = of_get_property(node, "bus-range", &len);
 	if (busrange == NULL || len != 8) {
 		printk(KERN_DEBUG "Can't get bus-range for PCI-PCI bridge %s\n",
 		       node->full_name);
 		return;
 	}
-	ranges = get_property(node, "ranges", &len);
+	ranges = of_get_property(node, "ranges", &len);
 	if (ranges == NULL) {
 		printk(KERN_DEBUG "Can't get ranges for PCI-PCI bridge %s\n",
 		       node->full_name);
@@ -910,7 +910,7 @@ static void __devinit pci_process_ISA_OF_ranges(struct device_node *isa_node,
 	unsigned int size;
 	int rlen = 0;
 
-	range = get_property(isa_node, "ranges", &rlen);
+	range = of_get_property(isa_node, "ranges", &rlen);
 	if (range == NULL || (rlen < sizeof(struct isa_range))) {
 		printk(KERN_ERR "no ISA ranges or unexpected isa range size,"
 		       "mapping 64k\n");
@@ -970,7 +970,7 @@ void __devinit pci_process_bridge_OF_ranges(struct pci_controller *hose,
 	 *			(size depending on dev->n_addr_cells)
 	 *   cells 4+5 or 5+6:	the size of the range
 	 */
-	ranges = get_property(dev, "ranges", &rlen);
+	ranges = of_get_property(dev, "ranges", &rlen);
 	if (ranges == NULL)
 		return;
 	hose->io_base_phys = 0;
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index 68df018..d7d36df 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -40,7 +40,8 @@
 static void * __devinit update_dn_pci_info(struct device_node *dn, void *data)
 {
 	struct pci_controller *phb = data;
-	const int *type = get_property(dn, "ibm,pci-config-space-type", NULL);
+	const int *type =
+		of_get_property(dn, "ibm,pci-config-space-type", NULL);
 	const u32 *regs;
 	struct pci_dn *pdn;
 
@@ -54,14 +55,14 @@ static void * __devinit update_dn_pci_info(struct device_node *dn, void *data)
 	dn->data = pdn;
 	pdn->node = dn;
 	pdn->phb = phb;
-	regs = get_property(dn, "reg", NULL);
+	regs = of_get_property(dn, "reg", NULL);
 	if (regs) {
 		/* First register entry is addr (00BBSS00)  */
 		pdn->busno = (regs[0] >> 16) & 0xff;
 		pdn->devfn = (regs[0] >> 8) & 0xff;
 	}
 	if (firmware_has_feature(FW_FEATURE_ISERIES)) {
-		const u32 *busp = get_property(dn, "linux,subbus", NULL);
+		const u32 *busp = of_get_property(dn, "linux,subbus", NULL);
 		if (busp)
 			pdn->bussubno = *busp;
 	}
@@ -100,7 +101,7 @@ void *traverse_pci_devices(struct device_node *start, traverse_func pre,
 		u32 class;
 
 		nextdn = NULL;
-		classp = get_property(dn, "class-code", NULL);
+		classp = of_get_property(dn, "class-code", NULL);
 		class = classp ? *classp : 0;
 
 		if (pre && ((ret = pre(dn, data)) != NULL))
diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_parse.c
index ba9c7c1..aa40a53 100644
--- a/arch/powerpc/kernel/prom_parse.c
+++ b/arch/powerpc/kernel/prom_parse.c
@@ -196,7 +196,7 @@ const u32 *of_get_pci_address(struct device_node *dev, int bar_no, u64 *size,
 		return NULL;
 
 	/* Get "reg" or "assigned-addresses" property */
-	prop = get_property(dev, bus->addresses, &psize);
+	prop = of_get_property(dev, bus->addresses, &psize);
 	if (prop == NULL)
 		return NULL;
 	psize /= 4;
@@ -438,7 +438,7 @@ static int of_translate_one(struct device_node *parent, struct of_bus *bus,
 	 * to translate addresses that aren't supposed to be translated in
 	 * the first place. --BenH.
 	 */
-	ranges = get_property(parent, "ranges", &rlen);
+	ranges = of_get_property(parent, "ranges", &rlen);
 	if (ranges == NULL || rlen == 0) {
 		offset = of_read_number(addr, na);
 		memset(addr, 0, pna * 4);
@@ -578,7 +578,7 @@ const u32 *of_get_address(struct device_node *dev, int index, u64 *size,
 		return NULL;
 
 	/* Get "reg" or "assigned-addresses" property */
-	prop = get_property(dev, bus->addresses, &psize);
+	prop = of_get_property(dev, bus->addresses, &psize);
 	if (prop == NULL)
 		return NULL;
 	psize /= 4;
@@ -650,16 +650,16 @@ void of_parse_dma_window(struct device_node *dn, const void *dma_window_prop,
 	/* busno is always one cell */
 	*busno = *(dma_window++);
 
-	prop = get_property(dn, "ibm,#dma-address-cells", NULL);
+	prop = of_get_property(dn, "ibm,#dma-address-cells", NULL);
 	if (!prop)
-		prop = get_property(dn, "#address-cells", NULL);
+		prop = of_get_property(dn, "#address-cells", NULL);
 
 	cells = prop ? *(u32 *)prop : of_n_addr_cells(dn);
 	*phys = of_read_number(dma_window, cells);
 
 	dma_window += cells;
 
-	prop = get_property(dn, "ibm,#dma-size-cells", NULL);
+	prop = of_get_property(dn, "ibm,#dma-size-cells", NULL);
 	cells = prop ? *(u32 *)prop : of_n_size_cells(dn);
 	*size = of_read_number(dma_window, cells);
 }
@@ -680,7 +680,7 @@ static struct device_node *of_irq_find_parent(struct device_node *child)
 		return NULL;
 
 	do {
-		parp = get_property(child, "interrupt-parent", NULL);
+		parp = of_get_property(child, "interrupt-parent", NULL);
 		if (parp == NULL)
 			p = of_get_parent(child);
 		else {
@@ -691,7 +691,7 @@ static struct device_node *of_irq_find_parent(struct device_node *child)
 		}
 		of_node_put(child);
 		child = p;
-	} while (p && get_property(p, "#interrupt-cells", NULL) == NULL);
+	} while (p && of_get_property(p, "#interrupt-cells", NULL) == NULL);
 
 	return p;
 }
@@ -716,7 +716,7 @@ void of_irq_map_init(unsigned int flags)
 		struct device_node *np;
 
 		for(np = NULL; (np = of_find_all_nodes(np)) != NULL;) {
-			if (get_property(np, "interrupt-controller", NULL)
+			if (of_get_property(np, "interrupt-controller", NULL)
 			    == NULL)
 				continue;
 			/* Skip /chosen/interrupt-controller */
@@ -755,7 +755,7 @@ int of_irq_map_raw(struct device_node *parent, const u32 *intspec, u32 ointsize,
 	 * is none, we are nice and just walk up the tree
 	 */
 	do {
-		tmp = get_property(ipar, "#interrupt-cells", NULL);
+		tmp = of_get_property(ipar, "#interrupt-cells", NULL);
 		if (tmp != NULL) {
 			intsize = *tmp;
 			break;
@@ -779,7 +779,7 @@ int of_irq_map_raw(struct device_node *parent, const u32 *intspec, u32 ointsize,
 	 */
 	old = of_node_get(ipar);
 	do {
-		tmp = get_property(old, "#address-cells", NULL);
+		tmp = of_get_property(old, "#address-cells", NULL);
 		tnode = of_get_parent(old);
 		of_node_put(old);
 		old = tnode;
@@ -795,7 +795,8 @@ int of_irq_map_raw(struct device_node *parent, const u32 *intspec, u32 ointsize,
 		/* Now check if cursor is an interrupt-controller and if it is
 		 * then we are done
 		 */
-		if (get_property(ipar, "interrupt-controller", NULL) != NULL) {
+		if (of_get_property(ipar, "interrupt-controller", NULL) !=
+				NULL) {
 			DBG(" -> got it !\n");
 			memcpy(out_irq->specifier, intspec,
 			       intsize * sizeof(u32));
@@ -806,7 +807,7 @@ int of_irq_map_raw(struct device_node *parent, const u32 *intspec, u32 ointsize,
 		}
 
 		/* Now look for an interrupt-map */
-		imap = get_property(ipar, "interrupt-map", &imaplen);
+		imap = of_get_property(ipar, "interrupt-map", &imaplen);
 		/* No interrupt map, check for an interrupt parent */
 		if (imap == NULL) {
 			DBG(" -> no map, getting parent\n");
@@ -816,7 +817,7 @@ int of_irq_map_raw(struct device_node *parent, const u32 *intspec, u32 ointsize,
 		imaplen /= sizeof(u32);
 
 		/* Look for a mask */
-		imask = get_property(ipar, "interrupt-map-mask", NULL);
+		imask = of_get_property(ipar, "interrupt-map-mask", NULL);
 
 		/* If we were passed no "reg" property and we attempt to parse
 		 * an interrupt-map, then #address-cells must be 0.
@@ -863,15 +864,13 @@ int of_irq_map_raw(struct device_node *parent, const u32 *intspec, u32 ointsize,
 			/* Get #interrupt-cells and #address-cells of new
 			 * parent
 			 */
-			tmp = get_property(newpar, "#interrupt-cells",
-						  NULL);
+			tmp = of_get_property(newpar, "#interrupt-cells", NULL);
 			if (tmp == NULL) {
 				DBG(" -> parent lacks #interrupt-cells !\n");
 				goto fail;
 			}
 			newintsize = *tmp;
-			tmp = get_property(newpar, "#address-cells",
-						  NULL);
+			tmp = of_get_property(newpar, "#address-cells", NULL);
 			newaddrsize = (tmp == NULL) ? 0 : *tmp;
 
 			DBG(" -> newintsize=%d, newaddrsize=%d\n",
@@ -928,7 +927,7 @@ static int of_irq_map_oldworld(struct device_node *device, int index,
 	 * everything together on these)
 	 */
 	while (device) {
-		ints = get_property(device, "AAPL,interrupts", &intlen);
+		ints = of_get_property(device, "AAPL,interrupts", &intlen);
 		if (ints != NULL)
 			break;
 		device = device->parent;
@@ -970,13 +969,13 @@ int of_irq_map_one(struct device_node *device, int index, struct of_irq *out_irq
 		return of_irq_map_oldworld(device, index, out_irq);
 
 	/* Get the interrupts property */
-	intspec = get_property(device, "interrupts", &intlen);
+	intspec = of_get_property(device, "interrupts", &intlen);
 	if (intspec == NULL)
 		return -EINVAL;
 	intlen /= sizeof(u32);
 
 	/* Get the reg property (if any) */
-	addr = get_property(device, "reg", NULL);
+	addr = of_get_property(device, "reg", NULL);
 
 	/* Look for the interrupt parent. */
 	p = of_irq_find_parent(device);
@@ -984,7 +983,7 @@ int of_irq_map_one(struct device_node *device, int index, struct of_irq *out_irq
 		return -EINVAL;
 
 	/* Get size of interrupt specifier */
-	tmp = get_property(p, "#interrupt-cells", NULL);
+	tmp = of_get_property(p, "#interrupt-cells", NULL);
 	if (tmp == NULL) {
 		of_node_put(p);
 		return -EINVAL;
diff --git a/arch/powerpc/kernel/rtas-proc.c b/arch/powerpc/kernel/rtas-proc.c
index 6cbf2ae..190b7ed 100644
--- a/arch/powerpc/kernel/rtas-proc.c
+++ b/arch/powerpc/kernel/rtas-proc.c
@@ -450,7 +450,7 @@ static int ppc_rtas_sensors_show(struct seq_file *m, void *v)
 		int llen, offs;
 
 		sprintf (rstr, SENSOR_PREFIX"%04d", p->token);
-		loc = get_property(rtas_node, rstr, &llen);
+		loc = of_get_property(rtas_node, rstr, &llen);
 
 		/* A sensor may have multiple instances */
 		for (j = 0, offs = 0; j <= p->quant; j++) {
@@ -477,7 +477,7 @@ static int ppc_rtas_find_all_sensors(void)
 	const unsigned int *utmp;
 	int len, i;
 
-	utmp = get_property(rtas_node, "rtas-sensors", &len);
+	utmp = of_get_property(rtas_node, "rtas-sensors", &len);
 	if (utmp == NULL) {
 		printk (KERN_ERR "error: could not get rtas-sensors\n");
 		return 1;
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 9d0735a..702fecc 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -193,16 +193,16 @@ void rtas_progress(char *s, unsigned short hex)
 	if (display_width == 0) {
 		display_width = 0x10;
 		if ((root = find_path_device("/rtas"))) {
-			if ((p = get_property(root,
+			if ((p = of_get_property(root,
 					"ibm,display-line-length", NULL)))
 				display_width = *p;
-			if ((p = get_property(root,
+			if ((p = of_get_property(root,
 					"ibm,form-feed", NULL)))
 				form_feed = *p;
-			if ((p = get_property(root,
+			if ((p = of_get_property(root,
 					"ibm,display-number-of-lines", NULL)))
 				display_lines = *p;
-			row_width = get_property(root,
+			row_width = of_get_property(root,
 					"ibm,display-truncation-length", NULL);
 		}
 		display_character = rtas_token("display-character");
@@ -298,7 +298,7 @@ int rtas_token(const char *service)
 	const int *tokp;
 	if (rtas.dev == NULL)
 		return RTAS_UNKNOWN_SERVICE;
-	tokp = get_property(rtas.dev, service, NULL);
+	tokp = of_get_property(rtas.dev, service, NULL);
 	return tokp ? *tokp : RTAS_UNKNOWN_SERVICE;
 }
 EXPORT_SYMBOL(rtas_token);
@@ -832,12 +832,12 @@ void __init rtas_initialize(void)
 	if (rtas.dev) {
 		const u32 *basep, *entryp, *sizep;
 
-		basep = get_property(rtas.dev, "linux,rtas-base", NULL);
-		sizep = get_property(rtas.dev, "rtas-size", NULL);
+		basep = of_get_property(rtas.dev, "linux,rtas-base", NULL);
+		sizep = of_get_property(rtas.dev, "rtas-size", NULL);
 		if (basep != NULL && sizep != NULL) {
 			rtas.base = *basep;
 			rtas.size = *sizep;
-			entryp = get_property(rtas.dev,
+			entryp = of_get_property(rtas.dev,
 					"linux,rtas-entry", NULL);
 			if (entryp == NULL) /* Ugh */
 				rtas.entry = rtas.base;
diff --git a/arch/powerpc/kernel/rtas_pci.c b/arch/powerpc/kernel/rtas_pci.c
index 1616a44..f228682 100644
--- a/arch/powerpc/kernel/rtas_pci.c
+++ b/arch/powerpc/kernel/rtas_pci.c
@@ -60,7 +60,7 @@ static int of_device_available(struct device_node * dn)
 {
         const char *status;
 
-        status = get_property(dn, "status", NULL);
+        status = of_get_property(dn, "status", NULL);
 
         if (!status)
                 return 1;
@@ -177,7 +177,7 @@ struct pci_ops rtas_pci_ops = {
 
 int is_python(struct device_node *dev)
 {
-	const char *model = get_property(dev, "model", NULL);
+	const char *model = of_get_property(dev, "model", NULL);
 
 	if (model && strstr(model, "Python"))
 		return 1;
@@ -247,7 +247,7 @@ static int phb_set_bus_ranges(struct device_node *dev,
 	const int *bus_range;
 	unsigned int len;
 
-	bus_range = get_property(dev, "bus-range", &len);
+	bus_range = of_get_property(dev, "bus-range", &len);
 	if (bus_range == NULL || len < 2 * sizeof(int)) {
 		return 1;
  	}
@@ -309,12 +309,12 @@ void __init find_and_init_phbs(void)
 	if (of_chosen) {
 		const int *prop;
 
-		prop = get_property(of_chosen,
+		prop = of_get_property(of_chosen,
 				"linux,pci-probe-only", NULL);
 		if (prop)
 			pci_probe_only = *prop;
 
-		prop = get_property(of_chosen,
+		prop = of_get_property(of_chosen,
 				"linux,pci-assign-all-buses", NULL);
 		if (prop)
 			pci_assign_all_buses = *prop;
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 8e33526..43055ad 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -353,11 +353,12 @@ void __init smp_setup_cpu_maps(void)
 		const int *intserv;
 		int j, len = sizeof(u32), nthreads = 1;
 
-		intserv = get_property(dn, "ibm,ppc-interrupt-server#s", &len);
+		intserv = of_get_property(dn, "ibm,ppc-interrupt-server#s",
+				&len);
 		if (intserv)
 			nthreads = len / sizeof(int);
 		else {
-			intserv = get_property(dn, "reg", NULL);
+			intserv = of_get_property(dn, "reg", NULL);
 			if (!intserv)
 				intserv = &cpu;	/* assume logical == phys */
 		}
@@ -383,7 +384,7 @@ void __init smp_setup_cpu_maps(void)
 		num_addr_cell = of_n_addr_cells(dn);
 		num_size_cell = of_n_size_cells(dn);
 
-		ireg = get_property(dn, "ibm,lrdr-capacity", NULL);
+		ireg = of_get_property(dn, "ibm,lrdr-capacity", NULL);
 
 		if (!ireg)
 			goto out;
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 3733de3..233024a 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -110,7 +110,7 @@ static void check_smt_enabled(void)
 	dn = of_find_node_by_path("/options");
 
 	if (dn) {
-		smt_option = get_property(dn, "ibm,smt-enabled", NULL);
+		smt_option = of_get_property(dn, "ibm,smt-enabled", NULL);
 
                 if (smt_option) {
 			if (!strcmp(smt_option, "on"))
@@ -305,10 +305,10 @@ static void __init initialize_cache_info(void)
 
 			size = 0;
 			lsize = cur_cpu_spec->dcache_bsize;
-			sizep = get_property(np, "d-cache-size", NULL);
+			sizep = of_get_property(np, "d-cache-size", NULL);
 			if (sizep != NULL)
 				size = *sizep;
-			lsizep = get_property(np, dc, NULL);
+			lsizep = of_get_property(np, dc, NULL);
 			if (lsizep != NULL)
 				lsize = *lsizep;
 			if (sizep == 0 || lsizep == 0)
@@ -322,10 +322,10 @@ static void __init initialize_cache_info(void)
 
 			size = 0;
 			lsize = cur_cpu_spec->icache_bsize;
-			sizep = get_property(np, "i-cache-size", NULL);
+			sizep = of_get_property(np, "i-cache-size", NULL);
 			if (sizep != NULL)
 				size = *sizep;
-			lsizep = get_property(np, ic, NULL);
+			lsizep = of_get_property(np, ic, NULL);
 			if (lsizep != NULL)
 				lsize = *lsizep;
 			if (sizep == 0 || lsizep == 0)
diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index d57818a..476f1d5 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -70,7 +70,7 @@ static int __init smt_setup(void)
 	if (!options)
 		return -ENODEV;
 
-	val = get_property(options, "ibm,smt-snooze-delay", NULL);
+	val = of_get_property(options, "ibm,smt-snooze-delay", NULL);
 	if (!smt_snooze_cmdline && val) {
 		for_each_possible_cpu(cpu)
 			per_cpu(smt_snooze_delay, cpu) = *val;
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index f6f0c6b..7cedef8 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -834,7 +834,7 @@ static int __init get_freq(char *name, int cells, unsigned long *val)
 	cpu = of_find_node_by_type(NULL, "cpu");
 
 	if (cpu) {
-		fp = get_property(cpu, name, NULL);
+		fp = of_get_property(cpu, name, NULL);
 		if (fp) {
 			found = 1;
 			*val = of_read_ulong(fp, cells);
diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index 2968ffe..a09277a 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -81,7 +81,7 @@ static struct iommu_table *vio_build_iommu_table(struct vio_dev *dev)
 		struct iommu_table *tbl;
 		unsigned long offset, size;
 
-		dma_window = get_property(dev->dev.archdata.of_node,
+		dma_window = of_get_property(dev->dev.archdata.of_node,
 					  "ibm,my-dma-window", NULL);
 		if (!dma_window)
 			return NULL;
@@ -226,7 +226,7 @@ struct vio_dev * __devinit vio_register_device_node(struct device_node *of_node)
 		return NULL;
 	}
 
-	unit_address = get_property(of_node, "reg", NULL);
+	unit_address = of_get_property(of_node, "reg", NULL);
 	if (unit_address == NULL) {
 		printk(KERN_WARNING "%s: node %s missing 'reg'\n",
 				__FUNCTION__,
@@ -246,7 +246,7 @@ struct vio_dev * __devinit vio_register_device_node(struct device_node *of_node)
 	viodev->type = of_node->type;
 	viodev->unit_address = *unit_address;
 	if (firmware_has_feature(FW_FEATURE_ISERIES)) {
-		unit_address = get_property(of_node,
+		unit_address = of_get_property(of_node,
 				"linux,unit_address", NULL);
 		if (unit_address != NULL)
 			viodev->unit_address = *unit_address;
@@ -377,7 +377,7 @@ static int vio_hotplug(struct device *dev, char **envp, int num_envp,
 	dn = dev->archdata.of_node;
 	if (!dn)
 		return -ENODEV;
-	cp = get_property(dn, "compatible", &length);
+	cp = of_get_property(dn, "compatible", &length);
 	if (!cp)
 		return -ENODEV;
 
@@ -406,12 +406,12 @@ struct bus_type vio_bus_type = {
  * @which:	The property/attribute to be extracted.
  * @length:	Pointer to length of returned data size (unused if NULL).
  *
- * Calls prom.c's get_property() to return the value of the
+ * Calls prom.c's of_get_property() to return the value of the
  * attribute specified by @which
 */
 const void *vio_get_attribute(struct vio_dev *vdev, char *which, int *length)
 {
-	return get_property(vdev->dev.archdata.of_node, which, length);
+	return of_get_property(vdev->dev.archdata.of_node, which, length);
 }
 EXPORT_SYMBOL(vio_get_attribute);
 
@@ -443,7 +443,7 @@ struct vio_dev *vio_find_node(struct device_node *vnode)
 	char kobj_name[BUS_ID_SIZE];
 
 	/* construct the kobject name from the device node */
-	unit_address = get_property(vnode, "reg", NULL);
+	unit_address = of_get_property(vnode, "reg", NULL);
 	if (!unit_address)
 		return NULL;
 	snprintf(kobj_name, BUS_ID_SIZE, "%x", *unit_address);
-- 
1.5.0.3

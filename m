Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 6CF4DDDF86
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 22:52:33 +1000 (EST)
Date: Tue, 3 Apr 2007 22:32:57 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 06/17] [POWERPC] Rename get_property to of_get_property:
	arch/powerpc/platforms/powermac
Message-Id: <20070403223257.cb8c4d15.sfr@canb.auug.org.au>
In-Reply-To: <20070403223136.6ecdabbd.sfr@canb.auug.org.au>
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
 arch/powerpc/platforms/powermac/backlight.c  |    2 +-
 arch/powerpc/platforms/powermac/cpufreq_32.c |   21 +++++++++++----------
 arch/powerpc/platforms/powermac/cpufreq_64.c |   16 ++++++++--------
 arch/powerpc/platforms/powermac/feature.c    |   24 ++++++++++++------------
 arch/powerpc/platforms/powermac/low_i2c.c    |   15 ++++++++-------
 arch/powerpc/platforms/powermac/pci.c        |   16 ++++++++--------
 arch/powerpc/platforms/powermac/pfunc_base.c |    2 +-
 arch/powerpc/platforms/powermac/pfunc_core.c |    2 +-
 arch/powerpc/platforms/powermac/pic.c        |    6 +++---
 arch/powerpc/platforms/powermac/setup.c      |   20 +++++++++++---------
 arch/powerpc/platforms/powermac/smp.c        |    6 +++---
 arch/powerpc/platforms/powermac/udbg_scc.c   |    6 +++---
 12 files changed, 70 insertions(+), 66 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/platforms/powermac/backlight.c b/arch/powerpc/platforms/powermac/backlight.c
index de7440e..0dc8a45 100644
--- a/arch/powerpc/platforms/powermac/backlight.c
+++ b/arch/powerpc/platforms/powermac/backlight.c
@@ -59,7 +59,7 @@ int pmac_has_backlight_type(const char *type)
 	struct device_node* bk_node = find_devices("backlight");
 
 	if (bk_node) {
-		const char *prop = get_property(bk_node,
+		const char *prop = of_get_property(bk_node,
 				"backlight-control", NULL);
 		if (prop && strncmp(prop, type, strlen(type)) == 0)
 			return 1;
diff --git a/arch/powerpc/platforms/powermac/cpufreq_32.c b/arch/powerpc/platforms/powermac/cpufreq_32.c
index c2b6b41..76eda9f 100644
--- a/arch/powerpc/platforms/powermac/cpufreq_32.c
+++ b/arch/powerpc/platforms/powermac/cpufreq_32.c
@@ -421,7 +421,7 @@ static int pmac_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 static u32 read_gpio(struct device_node *np)
 {
-	const u32 *reg = get_property(np, "reg", NULL);
+	const u32 *reg = of_get_property(np, "reg", NULL);
 	u32 offset;
 
 	if (reg == NULL)
@@ -521,13 +521,14 @@ static int pmac_cpufreq_init_MacRISC3(struct device_node *cpunode)
 		int lenp, rc;
 		const u32 *freqs, *ratio;
 
-		freqs = get_property(cpunode, "bus-frequencies", &lenp);
+		freqs = of_get_property(cpunode, "bus-frequencies", &lenp);
 		lenp /= sizeof(u32);
 		if (freqs == NULL || lenp != 2) {
 			printk(KERN_ERR "cpufreq: bus-frequencies incorrect or missing\n");
 			return 1;
 		}
-		ratio = get_property(cpunode, "processor-to-bus-ratio*2", NULL);
+		ratio = of_get_property(cpunode, "processor-to-bus-ratio*2",
+						NULL);
 		if (ratio == NULL) {
 			printk(KERN_ERR "cpufreq: processor-to-bus-ratio*2 missing\n");
 			return 1;
@@ -562,7 +563,7 @@ static int pmac_cpufreq_init_MacRISC3(struct device_node *cpunode)
 	/* If we use the PMU, look for the min & max frequencies in the
 	 * device-tree
 	 */
-	value = get_property(cpunode, "min-clock-frequency", NULL);
+	value = of_get_property(cpunode, "min-clock-frequency", NULL);
 	if (!value)
 		return 1;
 	low_freq = (*value) / 1000;
@@ -571,7 +572,7 @@ static int pmac_cpufreq_init_MacRISC3(struct device_node *cpunode)
 	if (low_freq < 100000)
 		low_freq *= 10;
 
-	value = get_property(cpunode, "max-clock-frequency", NULL);
+	value = of_get_property(cpunode, "max-clock-frequency", NULL);
 	if (!value)
 		return 1;
 	hi_freq = (*value) / 1000;
@@ -585,7 +586,7 @@ static int pmac_cpufreq_init_7447A(struct device_node *cpunode)
 {
 	struct device_node *volt_gpio_np;
 
-	if (get_property(cpunode, "dynamic-power-step", NULL) == NULL)
+	if (of_get_property(cpunode, "dynamic-power-step", NULL) == NULL)
 		return 1;
 
 	volt_gpio_np = of_find_node_by_name(NULL, "cpu-vcore-select");
@@ -614,11 +615,11 @@ static int pmac_cpufreq_init_750FX(struct device_node *cpunode)
 	u32 pvr;
 	const u32 *value;
 
-	if (get_property(cpunode, "dynamic-power-step", NULL) == NULL)
+	if (of_get_property(cpunode, "dynamic-power-step", NULL) == NULL)
 		return 1;
 
 	hi_freq = cur_freq;
-	value = get_property(cpunode, "reduced-clock-frequency", NULL);
+	value = of_get_property(cpunode, "reduced-clock-frequency", NULL);
 	if (!value)
 		return 1;
 	low_freq = (*value) / 1000;
@@ -662,14 +663,14 @@ static int __init pmac_cpufreq_setup(void)
 		goto out;
 
 	/* Get current cpu clock freq */
-	value = get_property(cpunode, "clock-frequency", NULL);
+	value = of_get_property(cpunode, "clock-frequency", NULL);
 	if (!value)
 		goto out;
 	cur_freq = (*value) / 1000;
 
 	/*  Check for 7447A based MacRISC3 */
 	if (machine_is_compatible("MacRISC3") &&
-	    get_property(cpunode, "dynamic-power-step", NULL) &&
+	    of_get_property(cpunode, "dynamic-power-step", NULL) &&
 	    PVR_VER(mfspr(SPRN_PVR)) == 0x8003) {
 		pmac_cpufreq_init_7447A(cpunode);
 	/* Check for other MacRISC3 machines */
diff --git a/arch/powerpc/platforms/powermac/cpufreq_64.c b/arch/powerpc/platforms/powermac/cpufreq_64.c
index 9d22361..567d552 100644
--- a/arch/powerpc/platforms/powermac/cpufreq_64.c
+++ b/arch/powerpc/platforms/powermac/cpufreq_64.c
@@ -410,7 +410,7 @@ static int __init g5_neo2_cpufreq_init(struct device_node *cpus)
 	/* Get first CPU node */
 	for (cpunode = NULL;
 	     (cpunode = of_get_next_child(cpus, cpunode)) != NULL;) {
-		const u32 *reg = get_property(cpunode, "reg", NULL);
+		const u32 *reg = of_get_property(cpunode, "reg", NULL);
 		if (reg == NULL || (*reg) != 0)
 			continue;
 		if (!strcmp(cpunode->type, "cpu"))
@@ -422,7 +422,7 @@ static int __init g5_neo2_cpufreq_init(struct device_node *cpus)
 	}
 
 	/* Check 970FX for now */
-	valp = get_property(cpunode, "cpu-version", NULL);
+	valp = of_get_property(cpunode, "cpu-version", NULL);
 	if (!valp) {
 		DBG("No cpu-version property !\n");
 		goto bail_noprops;
@@ -434,7 +434,7 @@ static int __init g5_neo2_cpufreq_init(struct device_node *cpus)
 	}
 
 	/* Look for the powertune data in the device-tree */
-	g5_pmode_data = get_property(cpunode, "power-mode-data",&psize);
+	g5_pmode_data = of_get_property(cpunode, "power-mode-data",&psize);
 	if (!g5_pmode_data) {
 		DBG("No power-mode-data !\n");
 		goto bail_noprops;
@@ -493,7 +493,7 @@ static int __init g5_neo2_cpufreq_init(struct device_node *cpus)
 	 * half freq in this version. So far, I haven't yet seen a machine
 	 * supporting anything else.
 	 */
-	valp = get_property(cpunode, "clock-frequency", NULL);
+	valp = of_get_property(cpunode, "clock-frequency", NULL);
 	if (!valp)
 		return -ENODEV;
 	max_freq = (*valp)/1000;
@@ -563,7 +563,7 @@ static int __init g5_pm72_cpufreq_init(struct device_node *cpus)
 	/* Lookup the cpuid eeprom node */
         cpuid = of_find_node_by_path("/u3@0,f8000000/i2c@f8001000/cpuid@a0");
 	if (cpuid != NULL)
-		eeprom = get_property(cpuid, "cpuid", NULL);
+		eeprom = of_get_property(cpuid, "cpuid", NULL);
 	if (eeprom == NULL) {
 		printk(KERN_ERR "cpufreq: Can't find cpuid EEPROM !\n");
 		rc = -ENODEV;
@@ -573,13 +573,13 @@ static int __init g5_pm72_cpufreq_init(struct device_node *cpus)
 	/* Lookup the i2c hwclock */
 	for (hwclock = NULL;
 	     (hwclock = of_find_node_by_name(hwclock, "i2c-hwclock")) != NULL;){
-		const char *loc = get_property(hwclock,
+		const char *loc = of_get_property(hwclock,
 				"hwctrl-location", NULL);
 		if (loc == NULL)
 			continue;
 		if (strcmp(loc, "CPU CLOCK"))
 			continue;
-		if (!get_property(hwclock, "platform-get-frequency", NULL))
+		if (!of_get_property(hwclock, "platform-get-frequency", NULL))
 			continue;
 		break;
 	}
@@ -638,7 +638,7 @@ static int __init g5_pm72_cpufreq_init(struct device_node *cpus)
 	 */
 
 	/* Get max frequency from device-tree */
-	valp = get_property(cpunode, "clock-frequency", NULL);
+	valp = of_get_property(cpunode, "clock-frequency", NULL);
 	if (!valp) {
 		printk(KERN_ERR "cpufreq: Can't find CPU frequency !\n");
 		rc = -ENODEV;
diff --git a/arch/powerpc/platforms/powermac/feature.c b/arch/powerpc/platforms/powermac/feature.c
index 24cc50c..103fcc4 100644
--- a/arch/powerpc/platforms/powermac/feature.c
+++ b/arch/powerpc/platforms/powermac/feature.c
@@ -1057,8 +1057,8 @@ core99_reset_cpu(struct device_node *node, long param, long value)
 	if (np == NULL)
 		return -ENODEV;
 	for (np = np->child; np != NULL; np = np->sibling) {
-		const u32 *num = get_property(np, "reg", NULL);
-		const u32 *rst = get_property(np, "soft-reset", NULL);
+		const u32 *num = of_get_property(np, "reg", NULL);
+		const u32 *rst = of_get_property(np, "soft-reset", NULL);
 		if (num == NULL || rst == NULL)
 			continue;
 		if (param == *num) {
@@ -1095,7 +1095,7 @@ core99_usb_enable(struct device_node *node, long param, long value)
 	    macio->type != macio_intrepid)
 		return -ENODEV;
 
-	prop = get_property(node, "AAPL,clock-id", NULL);
+	prop = of_get_property(node, "AAPL,clock-id", NULL);
 	if (!prop)
 		return -ENODEV;
 	if (strncmp(prop, "usb0u048", 8) == 0)
@@ -1506,8 +1506,8 @@ static long g5_reset_cpu(struct device_node *node, long param, long value)
 	if (np == NULL)
 		return -ENODEV;
 	for (np = np->child; np != NULL; np = np->sibling) {
-		const u32 *num = get_property(np, "reg", NULL);
-		const u32 *rst = get_property(np, "soft-reset", NULL);
+		const u32 *num = of_get_property(np, "reg", NULL);
+		const u32 *rst = of_get_property(np, "soft-reset", NULL);
 		if (num == NULL || rst == NULL)
 			continue;
 		if (param == *num) {
@@ -2411,7 +2411,7 @@ static int __init probe_motherboard(void)
 	 */
 	dt = find_devices("device-tree");
 	if (dt != NULL)
-		model = get_property(dt, "model", NULL);
+		model = of_get_property(dt, "model", NULL);
 	for(i=0; model && i<(sizeof(pmac_mb_defs)/sizeof(struct pmac_mb_def)); i++) {
 	    if (strcmp(model, pmac_mb_defs[i].model_string) == 0) {
 		pmac_mb = pmac_mb_defs[i];
@@ -2509,7 +2509,7 @@ found:
 		if (np->sibling)
 			break;
 		/* Nap mode not supported if flush-on-lock property is present */
-		if (get_property(np, "flush-on-lock", NULL))
+		if (of_get_property(np, "flush-on-lock", NULL))
 			break;
 		powersave_nap = 1;
 		printk(KERN_DEBUG "Processor NAP mode on idle enabled.\n");
@@ -2558,7 +2558,7 @@ static void __init probe_uninorth(void)
 	if (uninorth_node == NULL)
 		return;
 
-	addrp = get_property(uninorth_node, "reg", NULL);
+	addrp = of_get_property(uninorth_node, "reg", NULL);
 	if (addrp == NULL)
 		return;
 	address = of_translate_address(uninorth_node, addrp);
@@ -2642,7 +2642,7 @@ static void __init probe_one_macio(const char *name, const char *compat, int typ
 		return;
 	}
 	if (type == macio_keylargo || type == macio_keylargo2) {
-		const u32 *did = get_property(node, "device-id", NULL);
+		const u32 *did = of_get_property(node, "device-id", NULL);
 		if (*did == 0x00000025)
 			type = macio_pangea;
 		if (*did == 0x0000003e)
@@ -2655,7 +2655,7 @@ static void __init probe_one_macio(const char *name, const char *compat, int typ
 	macio_chips[i].base	= base;
 	macio_chips[i].flags	= MACIO_FLAG_SCCB_ON | MACIO_FLAG_SCCB_ON;
 	macio_chips[i].name	= macio_names[type];
-	revp = get_property(node, "revision-id", NULL);
+	revp = of_get_property(node, "revision-id", NULL);
 	if (revp)
 		macio_chips[i].rev = *revp;
 	printk(KERN_INFO "Found a %s mac-io controller, rev: %d, mapped at 0x%p\n",
@@ -2706,8 +2706,8 @@ initial_serial_shutdown(struct device_node *np)
 	int port_type = PMAC_SCC_ASYNC;
 	int modem = 0;
 
-	slots = get_property(np, "slot-names", &len);
-	conn = get_property(np, "AAPL,connector", &len);
+	slots = of_get_property(np, "slot-names", &len);
+	conn = of_get_property(np, "AAPL,connector", &len);
 	if (conn && (strcmp(conn, "infrared") == 0))
 		port_type = PMAC_SCC_IRDA;
 	else if (device_is_compatible(np, "cobalt"))
diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
index bfc4829..5430e14 100644
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -491,7 +491,7 @@ static struct pmac_i2c_host_kw *__init kw_i2c_host_init(struct device_node *np)
 	 * on all i2c keywest nodes so far ... we would have to fallback
 	 * to macio parsing if that wasn't the case
 	 */
-	addrp = get_property(np, "AAPL,address", NULL);
+	addrp = of_get_property(np, "AAPL,address", NULL);
 	if (addrp == NULL) {
 		printk(KERN_ERR "low_i2c: Can't find address for %s\n",
 		       np->full_name);
@@ -505,13 +505,13 @@ static struct pmac_i2c_host_kw *__init kw_i2c_host_init(struct device_node *np)
 	host->timeout_timer.function = kw_i2c_timeout;
 	host->timeout_timer.data = (unsigned long)host;
 
-	psteps = get_property(np, "AAPL,address-step", NULL);
+	psteps = of_get_property(np, "AAPL,address-step", NULL);
 	steps = psteps ? (*psteps) : 0x10;
 	for (host->bsteps = 0; (steps & 0x01) == 0; host->bsteps++)
 		steps >>= 1;
 	/* Select interface rate */
 	host->speed = KW_I2C_MODE_25KHZ;
-	prate = get_property(np, "AAPL,i2c-rate", NULL);
+	prate = of_get_property(np, "AAPL,i2c-rate", NULL);
 	if (prate) switch(*prate) {
 	case 100:
 		host->speed = KW_I2C_MODE_100KHZ;
@@ -619,7 +619,7 @@ static void __init kw_i2c_probe(void)
 		} else {
 			for (child = NULL;
 			     (child = of_get_next_child(np, child)) != NULL;) {
-				const u32 *reg = get_property(child,
+				const u32 *reg = of_get_property(child,
 						"reg", NULL);
 				if (reg == NULL)
 					continue;
@@ -905,7 +905,7 @@ static void __init smu_i2c_probe(void)
 		if (strcmp(busnode->type, "i2c") &&
 		    strcmp(busnode->type, "i2c-bus"))
 			continue;
-		reg = get_property(busnode, "reg", NULL);
+		reg = of_get_property(busnode, "reg", NULL);
 		if (reg == NULL)
 			continue;
 
@@ -950,7 +950,8 @@ struct pmac_i2c_bus *pmac_i2c_find_bus(struct device_node *node)
 			if (p == bus->busnode) {
 				if (prev && bus->flags & pmac_i2c_multibus) {
 					const u32 *reg;
-					reg = get_property(prev, "reg", NULL);
+					reg = of_get_property(prev, "reg",
+								NULL);
 					if (!reg)
 						continue;
 					if (((*reg) >> 8) != bus->channel)
@@ -971,7 +972,7 @@ EXPORT_SYMBOL_GPL(pmac_i2c_find_bus);
 
 u8 pmac_i2c_get_dev_addr(struct device_node *device)
 {
-	const u32 *reg = get_property(device, "reg", NULL);
+	const u32 *reg = of_get_property(device, "reg", NULL);
 
 	if (reg == NULL)
 		return 0;
diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
index 431a685..092cef4 100644
--- a/arch/powerpc/platforms/powermac/pci.c
+++ b/arch/powerpc/platforms/powermac/pci.c
@@ -70,11 +70,11 @@ static int __init fixup_one_level_bus_range(struct device_node *node, int higher
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
@@ -246,8 +246,8 @@ static int chaos_validate_dev(struct pci_bus *bus, int devfn, int offset)
 	if (np == NULL)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	vendor = get_property(np, "vendor-id", NULL);
-	device = get_property(np, "device-id", NULL);
+	vendor = of_get_property(np, "vendor-id", NULL);
+	device = of_get_property(np, "device-id", NULL);
 	if (vendor == NULL || device == NULL)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
@@ -691,17 +691,17 @@ static void __init fixup_nec_usb2(void)
 		const u32 *prop;
 		u8 bus, devfn;
 
-		prop = get_property(nec, "vendor-id", NULL);
+		prop = of_get_property(nec, "vendor-id", NULL);
 		if (prop == NULL)
 			continue;
 		if (0x1033 != *prop)
 			continue;
-		prop = get_property(nec, "device-id", NULL);
+		prop = of_get_property(nec, "device-id", NULL);
 		if (prop == NULL)
 			continue;
 		if (0x0035 != *prop)
 			continue;
-		prop = get_property(nec, "reg", NULL);
+		prop = of_get_property(nec, "reg", NULL);
 		if (prop == NULL)
 			continue;
 		devfn = (prop[0] >> 8) & 0xff;
@@ -909,7 +909,7 @@ static int __init add_bridge(struct device_node *dev)
 	has_address = (of_address_to_resource(dev, 0, &rsrc) == 0);
 
 	/* Get bus range if any */
-	bus_range = get_property(dev, "bus-range", &len);
+	bus_range = of_get_property(dev, "bus-range", &len);
 	if (bus_range == NULL || len < 2 * sizeof(int)) {
 		printk(KERN_WARNING "Can't get bus-range for %s, assume"
 		       " bus 0\n", dev->full_name);
diff --git a/arch/powerpc/platforms/powermac/pfunc_base.c b/arch/powerpc/platforms/powermac/pfunc_base.c
index 5c6c15c..45d54b9 100644
--- a/arch/powerpc/platforms/powermac/pfunc_base.c
+++ b/arch/powerpc/platforms/powermac/pfunc_base.c
@@ -114,7 +114,7 @@ static void macio_gpio_init_one(struct macio_chip *macio)
 	 * we just create them all
 	 */
 	for (gp = NULL; (gp = of_get_next_child(gparent, gp)) != NULL;) {
-		const u32 *reg = get_property(gp, "reg", NULL);
+		const u32 *reg = of_get_property(gp, "reg", NULL);
 		unsigned long offset;
 		if (reg == NULL)
 			continue;
diff --git a/arch/powerpc/platforms/powermac/pfunc_core.c b/arch/powerpc/platforms/powermac/pfunc_core.c
index a128553..8543423 100644
--- a/arch/powerpc/platforms/powermac/pfunc_core.c
+++ b/arch/powerpc/platforms/powermac/pfunc_core.c
@@ -820,7 +820,7 @@ struct pmf_function *__pmf_find_function(struct device_node *target,
 	 * one, then we fallback to a direct call attempt
 	 */
 	snprintf(fname, 63, "platform-%s", name);
-	prop = get_property(target, fname, NULL);
+	prop = of_get_property(target, fname, NULL);
 	if (prop == NULL)
 		goto find_it;
 	ph = *prop;
diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
index 5e5c0e4..f59d311 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -482,7 +482,7 @@ static struct mpic * __init pmac_setup_one_mpic(struct device_node *np,
 	pmac_call_feature(PMAC_FTR_ENABLE_MPIC, np, 0, 0);
 
 	flags |= MPIC_WANTS_RESET;
-	if (get_property(np, "big-endian", NULL))
+	if (of_get_property(np, "big-endian", NULL))
 		flags |= MPIC_BIG_ENDIAN;
 
 	/* Primary Big Endian means HT interrupts. This is quite dodgy
@@ -510,7 +510,7 @@ static int __init pmac_pic_probe_mpic(void)
 	for (np = NULL; (np = of_find_node_by_type(np, "open-pic"))
 		     != NULL;) {
 		if (master == NULL &&
-		    get_property(np, "interrupts", NULL) == NULL)
+		    of_get_property(np, "interrupts", NULL) == NULL)
 			master = of_node_get(np);
 		else if (slave == NULL)
 			slave = of_node_get(np);
@@ -575,7 +575,7 @@ void __init pmac_pic_init(void)
 #ifdef CONFIG_PPC32
 	if (!pmac_newworld)
 		flags |= OF_IMAP_OLDWORLD_MAC;
-	if (get_property(of_chosen, "linux,bootx", NULL) != NULL)
+	if (of_get_property(of_chosen, "linux,bootx", NULL) != NULL)
 		flags |= OF_IMAP_NO_PHANDLE;
 #endif /* CONFIG_PPC_32 */
 
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 651fa42..4de273d 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -135,12 +135,12 @@ static void pmac_show_cpuinfo(struct seq_file *m)
 	seq_printf(m, "machine\t\t: ");
 	np = of_find_node_by_path("/");
 	if (np != NULL) {
-		pp = get_property(np, "model", NULL);
+		pp = of_get_property(np, "model", NULL);
 		if (pp != NULL)
 			seq_printf(m, "%s\n", pp);
 		else
 			seq_printf(m, "PowerMac\n");
-		pp = get_property(np, "compatible", &plen);
+		pp = of_get_property(np, "compatible", &plen);
 		if (pp != NULL) {
 			seq_printf(m, "motherboard\t:");
 			while (plen > 0) {
@@ -164,11 +164,13 @@ static void pmac_show_cpuinfo(struct seq_file *m)
 	if (np == NULL)
 		np = of_find_node_by_type(NULL, "cache");
 	if (np != NULL) {
-		const unsigned int *ic = get_property(np, "i-cache-size", NULL);
-		const unsigned int *dc = get_property(np, "d-cache-size", NULL);
+		const unsigned int *ic =
+			of_get_property(np, "i-cache-size", NULL);
+		const unsigned int *dc =
+			of_get_property(np, "d-cache-size", NULL);
 		seq_printf(m, "L2 cache\t:");
 		has_l2cache = 1;
-		if (get_property(np, "cache-unified", NULL) != 0 && dc) {
+		if (of_get_property(np, "cache-unified", NULL) != 0 && dc) {
 			seq_printf(m, " %dK unified", *dc / 1024);
 		} else {
 			if (ic)
@@ -177,7 +179,7 @@ static void pmac_show_cpuinfo(struct seq_file *m)
 				seq_printf(m, "%s %dK data",
 					   (ic? " +": ""), *dc / 1024);
 		}
-		pp = get_property(np, "ram-type", NULL);
+		pp = of_get_property(np, "ram-type", NULL);
 		if (pp)
 			seq_printf(m, " %s", pp);
 		seq_printf(m, "\n");
@@ -254,7 +256,7 @@ static void __init l2cr_init(void)
 			np = find_type_devices("cpu");
 		if (np != 0) {
 			const unsigned int *l2cr =
-				get_property(np, "l2cr-value", NULL);
+				of_get_property(np, "l2cr-value", NULL);
 			if (l2cr != 0) {
 				ppc_override_l2cr = 1;
 				ppc_override_l2cr_value = *l2cr;
@@ -286,7 +288,7 @@ static void __init pmac_setup_arch(void)
 	loops_per_jiffy = 50000000 / HZ;
 	cpu = of_find_node_by_type(NULL, "cpu");
 	if (cpu != NULL) {
-		fp = get_property(cpu, "clock-frequency", NULL);
+		fp = of_get_property(cpu, "clock-frequency", NULL);
 		if (fp != NULL) {
 			if (pvr >= 0x30 && pvr < 0x80)
 				/* PPC970 etc. */
@@ -303,7 +305,7 @@ static void __init pmac_setup_arch(void)
 
 	/* See if newworld or oldworld */
 	for (ic = NULL; (ic = of_find_all_nodes(ic)) != NULL; )
-		if (get_property(ic, "interrupt-controller", NULL))
+		if (of_get_property(ic, "interrupt-controller", NULL))
 			break;
 	if (ic) {
 		pmac_newworld = 1;
diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index d73fb73..20f3286 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -567,7 +567,7 @@ static void __init smp_core99_setup_i2c_hwsync(int ncpus)
 		pmac_tb_clock_chip_host = pmac_i2c_find_bus(cc);
 		if (pmac_tb_clock_chip_host == NULL)
 			continue;
-		reg = get_property(cc, "reg", NULL);
+		reg = of_get_property(cc, "reg", NULL);
 		if (reg == NULL)
 			continue;
 		switch (*reg) {
@@ -695,7 +695,7 @@ static void __init smp_core99_setup(int ncpus)
 		struct device_node *cpus =
 			of_find_node_by_path("/cpus");
 		if (cpus &&
-		    get_property(cpus, "platform-cpu-timebase", NULL)) {
+		    of_get_property(cpus, "platform-cpu-timebase", NULL)) {
 			pmac_tb_freeze = smp_core99_pfunc_tb_freeze;
 			printk(KERN_INFO "Processor timebase sync using"
 			       " platform function\n");
@@ -712,7 +712,7 @@ static void __init smp_core99_setup(int ncpus)
 		core99_tb_gpio = KL_GPIO_TB_ENABLE;	/* default value */
 		cpu = of_find_node_by_type(NULL, "cpu");
 		if (cpu != NULL) {
-			tbprop = get_property(cpu, "timebase-enable", NULL);
+			tbprop = of_get_property(cpu, "timebase-enable", NULL);
 			if (tbprop)
 				core99_tb_gpio = *tbprop;
 			of_node_put(cpu);
diff --git a/arch/powerpc/platforms/powermac/udbg_scc.c b/arch/powerpc/platforms/powermac/udbg_scc.c
index 379db05..47de4d3 100644
--- a/arch/powerpc/platforms/powermac/udbg_scc.c
+++ b/arch/powerpc/platforms/powermac/udbg_scc.c
@@ -81,7 +81,7 @@ void udbg_scc_init(int force_scc)
 	macio = of_get_parent(escc);
 	if (macio == NULL)
 		goto bail;
-	path = get_property(of_chosen, "linux,stdout-path", NULL);
+	path = of_get_property(of_chosen, "linux,stdout-path", NULL);
 	if (path != NULL)
 		stdout = of_find_node_by_path(path);
 	for (ch = NULL; (ch = of_get_next_child(escc, ch)) != NULL;) {
@@ -96,13 +96,13 @@ void udbg_scc_init(int force_scc)
 	ch = ch_def ? ch_def : ch_a;
 
 	/* Get address within mac-io ASIC */
-	reg = get_property(escc, "reg", NULL);
+	reg = of_get_property(escc, "reg", NULL);
 	if (reg == NULL)
 		goto bail;
 	addr = reg[0];
 
 	/* Get address of mac-io PCI itself */
-	reg = get_property(macio, "assigned-addresses", NULL);
+	reg = of_get_property(macio, "assigned-addresses", NULL);
 	if (reg == NULL)
 		goto bail;
 	addr += reg[2];
-- 
1.5.0.3

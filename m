Return-Path: <jk@ozlabs.org>
To: linuxppc-dev@ozlabs.org
From: Jeremy Kerr <jk@ozlabs.org>
Subject: [PATCH 08/16] [powerpc,powermac] Constify & voidify get_property()
Message-ID: <1152678686.20160.08@pokey>
Date: Wed, 12 Jul 2006 15:40:29 +1000 (EST)
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

powermac platform & macintosh driver changes.

Built for pmac32_defconfig, g5_defconfig

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
---

 resend: rebase after benh's IRQ changes

 arch/powerpc/platforms/powermac/backlight.c  |    3 +-
 arch/powerpc/platforms/powermac/cpufreq_32.c |   23 ++++++++--------
 arch/powerpc/platforms/powermac/cpufreq_64.c |   27 ++++++++++---------
 arch/powerpc/platforms/powermac/feature.c    |   30 ++++++++++-----------
 arch/powerpc/platforms/powermac/low_i2c.c    |   24 ++++++++---------
 arch/powerpc/platforms/powermac/pci.c        |   37 ++++++++++++++-------------
 arch/powerpc/platforms/powermac/pfunc_base.c |    2 -
 arch/powerpc/platforms/powermac/pfunc_core.c |    5 ++-
 arch/powerpc/platforms/powermac/setup.c      |   18 +++++--------
 arch/powerpc/platforms/powermac/smp.c        |    7 ++---
 arch/powerpc/platforms/powermac/udbg_scc.c   |   10 +++----
 drivers/i2c/busses/i2c-powermac.c            |    3 +-
 drivers/ide/ppc/pmac.c                       |    6 ++--
 drivers/macintosh/macio_asic.c               |   10 ++++---
 drivers/macintosh/macio_sysfs.c              |    8 ++---
 drivers/macintosh/smu.c                      |   19 ++++++-------
 drivers/macintosh/therm_adt746x.c            |    8 ++---
 drivers/macintosh/therm_pm72.c               |   14 +++++-----
 drivers/macintosh/therm_windtunnel.c         |    4 +-
 drivers/macintosh/via-cuda.c                 |    4 +-
 drivers/macintosh/via-pmu-led.c              |    2 -
 drivers/macintosh/via-pmu.c                  |   10 +++----
 drivers/macintosh/windfarm_pm81.c            |    4 +-
 drivers/macintosh/windfarm_pm91.c            |    2 -
 drivers/macintosh/windfarm_smu_controls.c    |   13 +++++----
 drivers/macintosh/windfarm_smu_sat.c         |    8 ++---
 drivers/macintosh/windfarm_smu_sensors.c     |   12 ++++----
 drivers/serial/pmac_zilog.c                  |    9 +++---
 include/asm-powerpc/smu.h                    |    2 -
 29 files changed, 166 insertions(+), 158 deletions(-)

Index: linux-2.6/arch/powerpc/platforms/powermac/cpufreq_32.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/powermac/cpufreq_32.c
+++ linux-2.6/arch/powerpc/platforms/powermac/cpufreq_32.c
@@ -421,7 +421,7 @@ static int pmac_cpufreq_cpu_init(struct 
 
 static u32 read_gpio(struct device_node *np)
 {
-	u32 *reg = (u32 *)get_property(np, "reg", NULL);
+	const u32 *reg = get_property(np, "reg", NULL);
 	u32 offset;
 
 	if (reg == NULL)
@@ -497,7 +497,7 @@ static int pmac_cpufreq_init_MacRISC3(st
 								"frequency-gpio");
 	struct device_node *slew_done_gpio_np = of_find_node_by_name(NULL,
 								     "slewing-done");
-	u32 *value;
+	const u32 *value;
 
 	/*
 	 * Check to see if it's GPIO driven or PMU only
@@ -519,15 +519,15 @@ static int pmac_cpufreq_init_MacRISC3(st
 	 */
 	if (frequency_gpio && slew_done_gpio) {
 		int lenp, rc;
-		u32 *freqs, *ratio;
+		const u32 *freqs, *ratio;
 
-		freqs = (u32 *)get_property(cpunode, "bus-frequencies", &lenp);
+		freqs = get_property(cpunode, "bus-frequencies", &lenp);
 		lenp /= sizeof(u32);
 		if (freqs == NULL || lenp != 2) {
 			printk(KERN_ERR "cpufreq: bus-frequencies incorrect or missing\n");
 			return 1;
 		}
-		ratio = (u32 *)get_property(cpunode, "processor-to-bus-ratio*2", NULL);
+		ratio = get_property(cpunode, "processor-to-bus-ratio*2", NULL);
 		if (ratio == NULL) {
 			printk(KERN_ERR "cpufreq: processor-to-bus-ratio*2 missing\n");
 			return 1;
@@ -562,7 +562,7 @@ static int pmac_cpufreq_init_MacRISC3(st
 	/* If we use the PMU, look for the min & max frequencies in the
 	 * device-tree
 	 */
-	value = (u32 *)get_property(cpunode, "min-clock-frequency", NULL);
+	value = get_property(cpunode, "min-clock-frequency", NULL);
 	if (!value)
 		return 1;
 	low_freq = (*value) / 1000;
@@ -571,7 +571,7 @@ static int pmac_cpufreq_init_MacRISC3(st
 	if (low_freq < 100000)
 		low_freq *= 10;
 
-	value = (u32 *)get_property(cpunode, "max-clock-frequency", NULL);
+	value = get_property(cpunode, "max-clock-frequency", NULL);
 	if (!value)
 		return 1;
 	hi_freq = (*value) / 1000;
@@ -611,13 +611,14 @@ static int pmac_cpufreq_init_7447A(struc
 static int pmac_cpufreq_init_750FX(struct device_node *cpunode)
 {
 	struct device_node *volt_gpio_np;
-	u32 pvr, *value;
+	u32 pvr;
+	const u32 *value;
 
 	if (get_property(cpunode, "dynamic-power-step", NULL) == NULL)
 		return 1;
 
 	hi_freq = cur_freq;
-	value = (u32 *)get_property(cpunode, "reduced-clock-frequency", NULL);
+	value = get_property(cpunode, "reduced-clock-frequency", NULL);
 	if (!value)
 		return 1;
 	low_freq = (*value) / 1000;
@@ -650,7 +651,7 @@ static int pmac_cpufreq_init_750FX(struc
 static int __init pmac_cpufreq_setup(void)
 {
 	struct device_node	*cpunode;
-	u32			*value;
+	const u32		*value;
 
 	if (strstr(cmd_line, "nocpufreq"))
 		return 0;
@@ -661,7 +662,7 @@ static int __init pmac_cpufreq_setup(voi
 		goto out;
 
 	/* Get current cpu clock freq */
-	value = (u32 *)get_property(cpunode, "clock-frequency", NULL);
+	value = get_property(cpunode, "clock-frequency", NULL);
 	if (!value)
 		goto out;
 	cur_freq = (*value) / 1000;
Index: linux-2.6/arch/powerpc/platforms/powermac/cpufreq_64.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/powermac/cpufreq_64.c
+++ linux-2.6/arch/powerpc/platforms/powermac/cpufreq_64.c
@@ -89,7 +89,7 @@ static DEFINE_MUTEX(g5_switch_mutex);
 
 #ifdef CONFIG_PPC_SMU
 
-static u32 *g5_pmode_data;
+static const u32 *g5_pmode_data;
 static int g5_pmode_max;
 
 static struct smu_sdbp_fvt *g5_fvt_table;	/* table of op. points */
@@ -391,7 +391,8 @@ static int __init g5_neo2_cpufreq_init(s
 	unsigned int psize, ssize;
 	unsigned long max_freq;
 	char *freq_method, *volt_method;
-	u32 *valp, pvr_hi;
+	const u32 *valp;
+	u32 pvr_hi;
 	int use_volts_vdnap = 0;
 	int use_volts_smu = 0;
 	int rc = -ENODEV;
@@ -409,8 +410,7 @@ static int __init g5_neo2_cpufreq_init(s
 	/* Get first CPU node */
 	for (cpunode = NULL;
 	     (cpunode = of_get_next_child(cpus, cpunode)) != NULL;) {
-		u32 *reg =
-			(u32 *)get_property(cpunode, "reg", NULL);
+		const u32 *reg = get_property(cpunode, "reg", NULL);
 		if (reg == NULL || (*reg) != 0)
 			continue;
 		if (!strcmp(cpunode->type, "cpu"))
@@ -422,7 +422,7 @@ static int __init g5_neo2_cpufreq_init(s
 	}
 
 	/* Check 970FX for now */
-	valp = (u32 *)get_property(cpunode, "cpu-version", NULL);
+	valp = get_property(cpunode, "cpu-version", NULL);
 	if (!valp) {
 		DBG("No cpu-version property !\n");
 		goto bail_noprops;
@@ -434,7 +434,7 @@ static int __init g5_neo2_cpufreq_init(s
 	}
 
 	/* Look for the powertune data in the device-tree */
-	g5_pmode_data = (u32 *)get_property(cpunode, "power-mode-data",&psize);
+	g5_pmode_data = get_property(cpunode, "power-mode-data",&psize);
 	if (!g5_pmode_data) {
 		DBG("No power-mode-data !\n");
 		goto bail_noprops;
@@ -442,7 +442,7 @@ static int __init g5_neo2_cpufreq_init(s
 	g5_pmode_max = psize / sizeof(u32) - 1;
 
 	if (use_volts_smu) {
-		struct smu_sdbp_header *shdr;
+		const struct smu_sdbp_header *shdr;
 
 		/* Look for the FVT table */
 		shdr = smu_get_sdb_partition(SMU_SDB_FVT_ID, NULL);
@@ -493,7 +493,7 @@ static int __init g5_neo2_cpufreq_init(s
 	 * half freq in this version. So far, I haven't yet seen a machine
 	 * supporting anything else.
 	 */
-	valp = (u32 *)get_property(cpunode, "clock-frequency", NULL);
+	valp = get_property(cpunode, "clock-frequency", NULL);
 	if (!valp)
 		return -ENODEV;
 	max_freq = (*valp)/1000;
@@ -541,8 +541,8 @@ static int __init g5_neo2_cpufreq_init(s
 static int __init g5_pm72_cpufreq_init(struct device_node *cpus)
 {
 	struct device_node *cpuid = NULL, *hwclock = NULL, *cpunode = NULL;
-	u8 *eeprom = NULL;
-	u32 *valp;
+	const u8 *eeprom = NULL;
+	const u32 *valp;
 	u64 max_freq, min_freq, ih, il;
 	int has_volt = 1, rc = 0;
 
@@ -563,7 +563,7 @@ static int __init g5_pm72_cpufreq_init(s
 	/* Lookup the cpuid eeprom node */
         cpuid = of_find_node_by_path("/u3@0,f8000000/i2c@f8001000/cpuid@a0");
 	if (cpuid != NULL)
-		eeprom = (u8 *)get_property(cpuid, "cpuid", NULL);
+		eeprom = get_property(cpuid, "cpuid", NULL);
 	if (eeprom == NULL) {
 		printk(KERN_ERR "cpufreq: Can't find cpuid EEPROM !\n");
 		rc = -ENODEV;
@@ -573,7 +573,8 @@ static int __init g5_pm72_cpufreq_init(s
 	/* Lookup the i2c hwclock */
 	for (hwclock = NULL;
 	     (hwclock = of_find_node_by_name(hwclock, "i2c-hwclock")) != NULL;){
-		char *loc = get_property(hwclock, "hwctrl-location", NULL);
+		const char *loc = get_property(hwclock,
+				"hwctrl-location", NULL);
 		if (loc == NULL)
 			continue;
 		if (strcmp(loc, "CPU CLOCK"))
@@ -637,7 +638,7 @@ static int __init g5_pm72_cpufreq_init(s
 	 */
 
 	/* Get max frequency from device-tree */
-	valp = (u32 *)get_property(cpunode, "clock-frequency", NULL);
+	valp = get_property(cpunode, "clock-frequency", NULL);
 	if (!valp) {
 		printk(KERN_ERR "cpufreq: Can't find CPU frequency !\n");
 		rc = -ENODEV;
Index: linux-2.6/arch/powerpc/platforms/powermac/feature.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/powermac/feature.c
+++ linux-2.6/arch/powerpc/platforms/powermac/feature.c
@@ -1058,8 +1058,8 @@ core99_reset_cpu(struct device_node *nod
 	if (np == NULL)
 		return -ENODEV;
 	for (np = np->child; np != NULL; np = np->sibling) {
-		u32 *num = (u32 *)get_property(np, "reg", NULL);
-		u32 *rst = (u32 *)get_property(np, "soft-reset", NULL);
+		u32 *num = get_property(np, "reg", NULL);
+		u32 *rst = get_property(np, "soft-reset", NULL);
 		if (num == NULL || rst == NULL)
 			continue;
 		if (param == *num) {
@@ -1087,7 +1087,7 @@ core99_usb_enable(struct device_node *no
 {
 	struct macio_chip *macio;
 	unsigned long flags;
-	char *prop;
+	const char *prop;
 	int number;
 	u32 reg;
 
@@ -1096,7 +1096,7 @@ core99_usb_enable(struct device_node *no
 	    macio->type != macio_intrepid)
 		return -ENODEV;
 
-	prop = (char *)get_property(node, "AAPL,clock-id", NULL);
+	prop = get_property(node, "AAPL,clock-id", NULL);
 	if (!prop)
 		return -ENODEV;
 	if (strncmp(prop, "usb0u048", 8) == 0)
@@ -1507,8 +1507,8 @@ static long g5_reset_cpu(struct device_n
 	if (np == NULL)
 		return -ENODEV;
 	for (np = np->child; np != NULL; np = np->sibling) {
-		u32 *num = (u32 *)get_property(np, "reg", NULL);
-		u32 *rst = (u32 *)get_property(np, "soft-reset", NULL);
+		const u32 *num = get_property(np, "reg", NULL);
+		const u32 *rst = get_property(np, "soft-reset", NULL);
 		if (num == NULL || rst == NULL)
 			continue;
 		if (param == *num) {
@@ -2408,7 +2408,7 @@ static int __init probe_motherboard(void
 	 */
 	dt = find_devices("device-tree");
 	if (dt != NULL)
-		model = (const char *) get_property(dt, "model", NULL);
+		model = get_property(dt, "model", NULL);
 	for(i=0; model && i<(sizeof(pmac_mb_defs)/sizeof(struct pmac_mb_def)); i++) {
 	    if (strcmp(model, pmac_mb_defs[i].model_string) == 0) {
 		pmac_mb = pmac_mb_defs[i];
@@ -2536,7 +2536,7 @@ found:
  */
 static void __init probe_uninorth(void)
 {
-	u32 *addrp;
+	const u32 *addrp;
 	phys_addr_t address;
 	unsigned long actrl;
 
@@ -2555,7 +2555,7 @@ static void __init probe_uninorth(void)
 	if (uninorth_node == NULL)
 		return;
 
-	addrp = (u32 *)get_property(uninorth_node, "reg", NULL);
+	addrp = get_property(uninorth_node, "reg", NULL);
 	if (addrp == NULL)
 		return;
 	address = of_translate_address(uninorth_node, addrp);
@@ -2596,7 +2596,7 @@ static void __init probe_one_macio(const
 	struct device_node*	node;
 	int			i;
 	volatile u32 __iomem	*base;
-	u32			*addrp, *revp;
+	const u32		*addrp, *revp;
 	phys_addr_t		addr;
 	u64			size;
 
@@ -2639,7 +2639,7 @@ static void __init probe_one_macio(const
 		return;
 	}
 	if (type == macio_keylargo || type == macio_keylargo2) {
-		u32 *did = (u32 *)get_property(node, "device-id", NULL);
+		const u32 *did = get_property(node, "device-id", NULL);
 		if (*did == 0x00000025)
 			type = macio_pangea;
 		if (*did == 0x0000003e)
@@ -2652,7 +2652,7 @@ static void __init probe_one_macio(const
 	macio_chips[i].base	= base;
 	macio_chips[i].flags	= MACIO_FLAG_SCCB_ON | MACIO_FLAG_SCCB_ON;
 	macio_chips[i].name	= macio_names[type];
-	revp = (u32 *)get_property(node, "revision-id", NULL);
+	revp = get_property(node, "revision-id", NULL);
 	if (revp)
 		macio_chips[i].rev = *revp;
 	printk(KERN_INFO "Found a %s mac-io controller, rev: %d, mapped at 0x%p\n",
@@ -2695,15 +2695,15 @@ static void __init
 initial_serial_shutdown(struct device_node *np)
 {
 	int len;
-	struct slot_names_prop {
+	const struct slot_names_prop {
 		int	count;
 		char	name[1];
 	} *slots;
-	char *conn;
+	const char *conn;
 	int port_type = PMAC_SCC_ASYNC;
 	int modem = 0;
 
-	slots = (struct slot_names_prop *)get_property(np, "slot-names", &len);
+	slots = get_property(np, "slot-names", &len);
 	conn = get_property(np, "AAPL,connector", &len);
 	if (conn && (strcmp(conn, "infrared") == 0))
 		port_type = PMAC_SCC_IRDA;
Index: linux-2.6/arch/powerpc/platforms/powermac/low_i2c.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/powermac/low_i2c.c
+++ linux-2.6/arch/powerpc/platforms/powermac/low_i2c.c
@@ -477,7 +477,8 @@ static int kw_i2c_xfer(struct pmac_i2c_b
 static struct pmac_i2c_host_kw *__init kw_i2c_host_init(struct device_node *np)
 {
 	struct pmac_i2c_host_kw *host;
-	u32			*psteps, *prate, *addrp, steps;
+	const u32		*psteps, *prate, *addrp;
+	u32			steps;
 
 	host = kzalloc(sizeof(struct pmac_i2c_host_kw), GFP_KERNEL);
 	if (host == NULL) {
@@ -490,7 +491,7 @@ static struct pmac_i2c_host_kw *__init k
 	 * on all i2c keywest nodes so far ... we would have to fallback
 	 * to macio parsing if that wasn't the case
 	 */
-	addrp = (u32 *)get_property(np, "AAPL,address", NULL);
+	addrp = get_property(np, "AAPL,address", NULL);
 	if (addrp == NULL) {
 		printk(KERN_ERR "low_i2c: Can't find address for %s\n",
 		       np->full_name);
@@ -504,13 +505,13 @@ static struct pmac_i2c_host_kw *__init k
 	host->timeout_timer.function = kw_i2c_timeout;
 	host->timeout_timer.data = (unsigned long)host;
 
-	psteps = (u32 *)get_property(np, "AAPL,address-step", NULL);
+	psteps = get_property(np, "AAPL,address-step", NULL);
 	steps = psteps ? (*psteps) : 0x10;
 	for (host->bsteps = 0; (steps & 0x01) == 0; host->bsteps++)
 		steps >>= 1;
 	/* Select interface rate */
 	host->speed = KW_I2C_MODE_25KHZ;
-	prate = (u32 *)get_property(np, "AAPL,i2c-rate", NULL);
+	prate = get_property(np, "AAPL,i2c-rate", NULL);
 	if (prate) switch(*prate) {
 	case 100:
 		host->speed = KW_I2C_MODE_100KHZ;
@@ -618,8 +619,8 @@ static void __init kw_i2c_probe(void)
 		} else {
 			for (child = NULL;
 			     (child = of_get_next_child(np, child)) != NULL;) {
-				u32 *reg =
-					(u32 *)get_property(child, "reg", NULL);
+				const u32 *reg = get_property(child,
+						"reg", NULL);
 				if (reg == NULL)
 					continue;
 				kw_i2c_add(host, np, child, *reg);
@@ -881,7 +882,7 @@ static void __init smu_i2c_probe(void)
 {
 	struct device_node *controller, *busnode;
 	struct pmac_i2c_bus *bus;
-	u32 *reg;
+	const u32 *reg;
 	int sz;
 
 	if (!smu_present())
@@ -904,7 +905,7 @@ static void __init smu_i2c_probe(void)
 		if (strcmp(busnode->type, "i2c") &&
 		    strcmp(busnode->type, "i2c-bus"))
 			continue;
-		reg = (u32 *)get_property(busnode, "reg", NULL);
+		reg = get_property(busnode, "reg", NULL);
 		if (reg == NULL)
 			continue;
 
@@ -948,9 +949,8 @@ struct pmac_i2c_bus *pmac_i2c_find_bus(s
 		list_for_each_entry(bus, &pmac_i2c_busses, link) {
 			if (p == bus->busnode) {
 				if (prev && bus->flags & pmac_i2c_multibus) {
-					u32 *reg;
-					reg = (u32 *)get_property(prev, "reg",
-								  NULL);
+					const u32 *reg;
+					reg = get_property(prev, "reg", NULL);
 					if (!reg)
 						continue;
 					if (((*reg) >> 8) != bus->channel)
@@ -971,7 +971,7 @@ EXPORT_SYMBOL_GPL(pmac_i2c_find_bus);
 
 u8 pmac_i2c_get_dev_addr(struct device_node *device)
 {
-	u32 *reg = (u32 *)get_property(device, "reg", NULL);
+	const u32 *reg = get_property(device, "reg", NULL);
 
 	if (reg == NULL)
 		return 0;
Index: linux-2.6/arch/powerpc/platforms/powermac/pci.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/powermac/pci.c
+++ linux-2.6/arch/powerpc/platforms/powermac/pci.c
@@ -69,16 +69,16 @@ struct device_node *k2_skiplist[2];
 static int __init fixup_one_level_bus_range(struct device_node *node, int higher)
 {
 	for (; node != 0;node = node->sibling) {
-		int * bus_range;
-		unsigned int *class_code;
+		const int * bus_range;
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
@@ -96,13 +96,15 @@ static int __init fixup_one_level_bus_ra
  */
 static void __init fixup_bus_range(struct device_node *bridge)
 {
-	int * bus_range;
-	int len;
+	int *bus_range, len;
+	struct property *prop;
 
 	/* Lookup the "bus-range" property for the hose */
-	bus_range = (int *) get_property(bridge, "bus-range", &len);
-	if (bus_range == NULL || len < 2 * sizeof(int))
+	prop = of_find_property(bridge, "bus-range", &len);
+	if (prop == NULL || prop->length < 2 * sizeof(int))
 		return;
+
+	bus_range = (int *)prop->value;
 	bus_range[1] = fixup_one_level_bus_range(bridge->child, bus_range[1]);
 }
 
@@ -240,7 +242,7 @@ static struct pci_ops macrisc_pci_ops =
 static int chaos_validate_dev(struct pci_bus *bus, int devfn, int offset)
 {
 	struct device_node *np;
-	u32 *vendor, *device;
+	const u32 *vendor, *device;
 
 	if (offset >= 0x100)
 		return  PCIBIOS_BAD_REGISTER_NUMBER;
@@ -248,8 +250,8 @@ static int chaos_validate_dev(struct pci
 	if (np == NULL)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	vendor = (u32 *)get_property(np, "vendor-id", NULL);
-	device = (u32 *)get_property(np, "device-id", NULL);
+	vendor = get_property(np, "vendor-id", NULL);
+	device = get_property(np, "device-id", NULL);
 	if (vendor == NULL || device == NULL)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
@@ -689,20 +691,21 @@ static void __init fixup_nec_usb2(void)
 
 	for (nec = NULL; (nec = of_find_node_by_name(nec, "usb")) != NULL;) {
 		struct pci_controller *hose;
-		u32 data, *prop;
+		u32 data;
+		const u32 *prop;
 		u8 bus, devfn;
 
-		prop = (u32 *)get_property(nec, "vendor-id", NULL);
+		prop = get_property(nec, "vendor-id", NULL);
 		if (prop == NULL)
 			continue;
 		if (0x1033 != *prop)
 			continue;
-		prop = (u32 *)get_property(nec, "device-id", NULL);
+		prop = get_property(nec, "device-id", NULL);
 		if (prop == NULL)
 			continue;
 		if (0x0035 != *prop)
 			continue;
-		prop = (u32 *)get_property(nec, "reg", NULL);
+		prop = get_property(nec, "reg", NULL);
 		if (prop == NULL)
 			continue;
 		devfn = (prop[0] >> 8) & 0xff;
@@ -901,7 +904,7 @@ static int __init add_bridge(struct devi
 	struct pci_controller *hose;
 	struct resource rsrc;
 	char *disp_name;
-	int *bus_range;
+	const int *bus_range;
 	int primary = 1, has_address = 0;
 
 	DBG("Adding PCI host bridge %s\n", dev->full_name);
@@ -910,7 +913,7 @@ static int __init add_bridge(struct devi
 	has_address = (of_address_to_resource(dev, 0, &rsrc) == 0);
 
 	/* Get bus range if any */
-	bus_range = (int *) get_property(dev, "bus-range", &len);
+	bus_range = get_property(dev, "bus-range", &len);
 	if (bus_range == NULL || len < 2 * sizeof(int)) {
 		printk(KERN_WARNING "Can't get bus-range for %s, assume"
 		       " bus 0\n", dev->full_name);
Index: linux-2.6/arch/powerpc/platforms/powermac/pfunc_base.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/powermac/pfunc_base.c
+++ linux-2.6/arch/powerpc/platforms/powermac/pfunc_base.c
@@ -114,7 +114,7 @@ static void macio_gpio_init_one(struct m
 	 * we just create them all
 	 */
 	for (gp = NULL; (gp = of_get_next_child(gparent, gp)) != NULL;) {
-		u32 *reg = (u32 *)get_property(gp, "reg", NULL);
+		const u32 *reg = get_property(gp, "reg", NULL);
 		unsigned long offset;
 		if (reg == NULL)
 			continue;
Index: linux-2.6/arch/powerpc/platforms/powermac/pfunc_core.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/powermac/pfunc_core.c
+++ linux-2.6/arch/powerpc/platforms/powermac/pfunc_core.c
@@ -813,14 +813,15 @@ struct pmf_function *__pmf_find_function
 	struct pmf_device *dev;
 	struct pmf_function *func, *result = NULL;
 	char fname[64];
-	u32 *prop, ph;
+	const u32 *prop;
+	u32 ph;
 
 	/*
 	 * Look for a "platform-*" function reference. If we can't find
 	 * one, then we fallback to a direct call attempt
 	 */
 	snprintf(fname, 63, "platform-%s", name);
-	prop = (u32 *)get_property(target, fname, NULL);
+	prop = get_property(target, fname, NULL);
 	if (prop == NULL)
 		goto find_it;
 	ph = *prop;
Index: linux-2.6/arch/powerpc/platforms/powermac/smp.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/powermac/smp.c
+++ linux-2.6/arch/powerpc/platforms/powermac/smp.c
@@ -548,7 +548,7 @@ static void __init smp_core99_setup_i2c_
 	struct device_node *cc = NULL;	
 	struct device_node *p;
 	const char *name = NULL;
-	u32 *reg;
+	const u32 *reg;
 	int ok;
 
 	/* Look for the clock chip */
@@ -562,7 +562,7 @@ static void __init smp_core99_setup_i2c_
 		pmac_tb_clock_chip_host = pmac_i2c_find_bus(cc);
 		if (pmac_tb_clock_chip_host == NULL)
 			continue;
-		reg = (u32 *)get_property(cc, "reg", NULL);
+		reg = get_property(cc, "reg", NULL);
 		if (reg == NULL)
 			continue;
 		switch (*reg) {
@@ -707,8 +707,7 @@ static void __init smp_core99_setup(int 
 		core99_tb_gpio = KL_GPIO_TB_ENABLE;	/* default value */
 		cpu = of_find_node_by_type(NULL, "cpu");
 		if (cpu != NULL) {
-			tbprop = (u32 *)get_property(cpu, "timebase-enable",
-						     NULL);
+			tbprop = get_property(cpu, "timebase-enable", NULL);
 			if (tbprop)
 				core99_tb_gpio = *tbprop;
 			of_node_put(cpu);
Index: linux-2.6/arch/powerpc/platforms/powermac/udbg_scc.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/powermac/udbg_scc.c
+++ linux-2.6/arch/powerpc/platforms/powermac/udbg_scc.c
@@ -68,11 +68,11 @@ static unsigned char scc_inittab[] = {
 
 void udbg_scc_init(int force_scc)
 {
-	u32 *reg;
+	const u32 *reg;
 	unsigned long addr;
 	struct device_node *stdout = NULL, *escc = NULL, *macio = NULL;
 	struct device_node *ch, *ch_def = NULL, *ch_a = NULL;
-	char *path;
+	const char *path;
 	int i, x;
 
 	escc = of_find_node_by_name(NULL, "escc");
@@ -81,7 +81,7 @@ void udbg_scc_init(int force_scc)
 	macio = of_get_parent(escc);
 	if (macio == NULL)
 		goto bail;
-	path = (char *)get_property(of_chosen, "linux,stdout-path", NULL);
+	path = get_property(of_chosen, "linux,stdout-path", NULL);
 	if (path != NULL)
 		stdout = of_find_node_by_path(path);
 	for (ch = NULL; (ch = of_get_next_child(escc, ch)) != NULL;) {
@@ -96,13 +96,13 @@ void udbg_scc_init(int force_scc)
 	ch = ch_def ? ch_def : ch_a;
 
 	/* Get address within mac-io ASIC */
-	reg = (u32 *)get_property(escc, "reg", NULL);
+	reg = get_property(escc, "reg", NULL);
 	if (reg == NULL)
 		goto bail;
 	addr = reg[0];
 
 	/* Get address of mac-io PCI itself */
-	reg = (u32 *)get_property(macio, "assigned-addresses", NULL);
+	reg = get_property(macio, "assigned-addresses", NULL);
 	if (reg == NULL)
 		goto bail;
 	addr += reg[2];
Index: linux-2.6/arch/powerpc/platforms/powermac/backlight.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/powermac/backlight.c
+++ linux-2.6/arch/powerpc/platforms/powermac/backlight.c
@@ -38,7 +38,8 @@ int pmac_has_backlight_type(const char *
 	struct device_node* bk_node = find_devices("backlight");
 
 	if (bk_node) {
-		char *prop = get_property(bk_node, "backlight-control", NULL);
+		const char *prop = get_property(bk_node,
+				"backlight-control", NULL);
 		if (prop && strncmp(prop, type, strlen(type)) == 0)
 			return 1;
 	}
Index: linux-2.6/arch/powerpc/platforms/powermac/setup.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/powermac/setup.c
+++ linux-2.6/arch/powerpc/platforms/powermac/setup.c
@@ -116,7 +116,7 @@ extern struct smp_ops_t core99_smp_ops;
 static void pmac_show_cpuinfo(struct seq_file *m)
 {
 	struct device_node *np;
-	char *pp;
+	const char *pp;
 	int plen;
 	int mbmodel;
 	unsigned int mbflags;
@@ -134,12 +134,12 @@ static void pmac_show_cpuinfo(struct seq
 	seq_printf(m, "machine\t\t: ");
 	np = of_find_node_by_path("/");
 	if (np != NULL) {
-		pp = (char *) get_property(np, "model", NULL);
+		pp = get_property(np, "model", NULL);
 		if (pp != NULL)
 			seq_printf(m, "%s\n", pp);
 		else
 			seq_printf(m, "PowerMac\n");
-		pp = (char *) get_property(np, "compatible", &plen);
+		pp = get_property(np, "compatible", &plen);
 		if (pp != NULL) {
 			seq_printf(m, "motherboard\t:");
 			while (plen > 0) {
@@ -163,10 +163,8 @@ static void pmac_show_cpuinfo(struct seq
 	if (np == NULL)
 		np = of_find_node_by_type(NULL, "cache");
 	if (np != NULL) {
-		unsigned int *ic = (unsigned int *)
-			get_property(np, "i-cache-size", NULL);
-		unsigned int *dc = (unsigned int *)
-			get_property(np, "d-cache-size", NULL);
+		const unsigned int *ic = get_property(np, "i-cache-size", NULL);
+		const unsigned int *dc = get_property(np, "d-cache-size", NULL);
 		seq_printf(m, "L2 cache\t:");
 		has_l2cache = 1;
 		if (get_property(np, "cache-unified", NULL) != 0 && dc) {
@@ -254,7 +252,7 @@ static void __init l2cr_init(void)
 		if (np == 0)
 			np = find_type_devices("cpu");
 		if (np != 0) {
-			unsigned int *l2cr = (unsigned int *)
+			const unsigned int *l2cr =
 				get_property(np, "l2cr-value", NULL);
 			if (l2cr != 0) {
 				ppc_override_l2cr = 1;
@@ -277,7 +275,7 @@ static void __init l2cr_init(void)
 static void __init pmac_setup_arch(void)
 {
 	struct device_node *cpu, *ic;
-	int *fp;
+	const int *fp;
 	unsigned long pvr;
 
 	pvr = PVR_VER(mfspr(SPRN_PVR));
@@ -287,7 +285,7 @@ static void __init pmac_setup_arch(void)
 	loops_per_jiffy = 50000000 / HZ;
 	cpu = of_find_node_by_type(NULL, "cpu");
 	if (cpu != NULL) {
-		fp = (int *) get_property(cpu, "clock-frequency", NULL);
+		fp = get_property(cpu, "clock-frequency", NULL);
 		if (fp != NULL) {
 			if (pvr >= 0x30 && pvr < 0x80)
 				/* PPC970 etc. */
Index: linux-2.6/drivers/macintosh/therm_adt746x.c
===================================================================
--- linux-2.6.orig/drivers/macintosh/therm_adt746x.c
+++ linux-2.6/drivers/macintosh/therm_adt746x.c
@@ -47,7 +47,7 @@ static u8 FAN_SPD_SET[2] = {0x30, 0x31};
 
 static u8 default_limits_local[3] = {70, 50, 70};    /* local, sensor1, sensor2 */
 static u8 default_limits_chip[3] = {80, 65, 80};    /* local, sensor1, sensor2 */
-static char *sensor_location[3] = {NULL, NULL, NULL};
+static const char *sensor_location[3] = {NULL, NULL, NULL};
 
 static int limit_adjust = 0;
 static int fan_speed = -1;
@@ -553,7 +553,7 @@ static int __init
 thermostat_init(void)
 {
 	struct device_node* np;
-	u32 *prop;
+	const u32 *prop;
 	int i = 0, offset = 0;
 	
 	np = of_find_node_by_name(NULL, "fan");
@@ -566,13 +566,13 @@ thermostat_init(void)
 	else
 		return -ENODEV;
 
-	prop = (u32 *)get_property(np, "hwsensor-params-version", NULL);
+	prop = get_property(np, "hwsensor-params-version", NULL);
 	printk(KERN_INFO "adt746x: version %d (%ssupported)\n", *prop,
 			 (*prop == 1)?"":"un");
 	if (*prop != 1)
 		return -ENODEV;
 
-	prop = (u32 *)get_property(np, "reg", NULL);
+	prop = get_property(np, "reg", NULL);
 	if (!prop)
 		return -ENODEV;
 
Index: linux-2.6/drivers/macintosh/macio_asic.c
===================================================================
--- linux-2.6.orig/drivers/macintosh/macio_asic.c
+++ linux-2.6/drivers/macintosh/macio_asic.c
@@ -139,7 +139,9 @@ static int macio_uevent(struct device *d
 {
 	struct macio_dev * macio_dev;
 	struct of_device * of;
-	char *scratch, *compat, *compat2;
+	char *scratch;
+	const char *compat, *compat2;
+
 	int i = 0;
 	int length, cplen, cplen2, seen = 0;
 
@@ -173,7 +175,7 @@ static int macio_uevent(struct device *d
          * it's not really legal to split it out with commas. We split it
          * up using a number of environment variables instead. */
 
-	compat = (char *) get_property(of->node, "compatible", &cplen);
+	compat = get_property(of->node, "compatible", &cplen);
 	compat2 = compat;
 	cplen2= cplen;
 	while (compat && cplen > 0) {
@@ -454,7 +456,7 @@ static struct macio_dev * macio_add_one_
 					       struct resource *parent_res)
 {
 	struct macio_dev *dev;
-	u32 *reg;
+	const u32 *reg;
 	
 	if (np == NULL)
 		return NULL;
@@ -489,7 +491,7 @@ static struct macio_dev * macio_add_one_
 #endif
 			MAX_NODE_NAME_SIZE, np->name);
 	} else {
-		reg = (u32 *)get_property(np, "reg", NULL);
+		reg = get_property(np, "reg", NULL);
 		sprintf(dev->ofdev.dev.bus_id, "%1d.%08x:%.*s",
 			chip->lbus.index,
 			reg ? *reg : 0, MAX_NODE_NAME_SIZE, np->name);
Index: linux-2.6/drivers/macintosh/smu.c
===================================================================
--- linux-2.6.orig/drivers/macintosh/smu.c
+++ linux-2.6/drivers/macintosh/smu.c
@@ -447,7 +447,7 @@ EXPORT_SYMBOL(smu_present);
 int __init smu_init (void)
 {
 	struct device_node *np;
-	u32 *data;
+	const u32 *data;
 
         np = of_find_node_by_type(NULL, "smu");
         if (np == NULL)
@@ -483,7 +483,7 @@ int __init smu_init (void)
 		printk(KERN_ERR "SMU: Can't find doorbell GPIO !\n");
 		goto fail;
 	}
-	data = (u32 *)get_property(np, "reg", NULL);
+	data = get_property(np, "reg", NULL);
 	if (data == NULL) {
 		of_node_put(np);
 		printk(KERN_ERR "SMU: Can't find doorbell GPIO address !\n");
@@ -506,7 +506,7 @@ int __init smu_init (void)
 		np = of_find_node_by_name(NULL, "smu-interrupt");
 		if (np == NULL)
 			break;
-		data = (u32 *)get_property(np, "reg", NULL);
+		data = get_property(np, "reg", NULL);
 		if (data == NULL) {
 			of_node_put(np);
 			break;
@@ -959,11 +959,11 @@ static struct smu_sdbp_header *smu_creat
 /* Note: Only allowed to return error code in pointers (using ERR_PTR)
  * when interruptible is 1
  */
-struct smu_sdbp_header *__smu_get_sdb_partition(int id, unsigned int *size,
-						int interruptible)
+const struct smu_sdbp_header *__smu_get_sdb_partition(int id,
+		unsigned int *size, int interruptible)
 {
 	char pname[32];
-	struct smu_sdbp_header *part;
+	const struct smu_sdbp_header *part;
 
 	if (!smu)
 		return NULL;
@@ -980,8 +980,7 @@ struct smu_sdbp_header *__smu_get_sdb_pa
 	} else
 		mutex_lock(&smu_part_access);
 
-	part = (struct smu_sdbp_header *)get_property(smu->of_node,
-						      pname, size);
+	part = get_property(smu->of_node, pname, size);
 	if (part == NULL) {
 		DPRINTK("trying to extract from SMU ...\n");
 		part = smu_create_sdb_partition(id);
@@ -992,7 +991,7 @@ struct smu_sdbp_header *__smu_get_sdb_pa
 	return part;
 }
 
-struct smu_sdbp_header *smu_get_sdb_partition(int id, unsigned int *size)
+const struct smu_sdbp_header *smu_get_sdb_partition(int id, unsigned int *size)
 {
 	return __smu_get_sdb_partition(id, size, 0);
 }
@@ -1071,7 +1070,7 @@ static ssize_t smu_write(struct file *fi
 		pp->mode = smu_file_events;
 		return 0;
 	} else if (hdr.cmdtype == SMU_CMDTYPE_GET_PARTITION) {
-		struct smu_sdbp_header *part;
+		const struct smu_sdbp_header *part;
 		part = __smu_get_sdb_partition(hdr.cmd, NULL, 1);
 		if (part == NULL)
 			return -EINVAL;
Index: linux-2.6/drivers/macintosh/therm_pm72.c
===================================================================
--- linux-2.6.orig/drivers/macintosh/therm_pm72.c
+++ linux-2.6/drivers/macintosh/therm_pm72.c
@@ -660,7 +660,7 @@ static int read_eeprom(int cpu, struct m
 {
 	struct device_node *np;
 	char nodename[64];
-	u8 *data;
+	const u8 *data;
 	int len;
 
 	/* prom.c routine for finding a node by path is a bit brain dead
@@ -673,7 +673,7 @@ static int read_eeprom(int cpu, struct m
 		printk(KERN_ERR "therm_pm72: Failed to retrieve cpuid node from device-tree\n");
 		return -ENODEV;
 	}
-	data = (u8 *)get_property(np, "cpuid", &len);
+	data = get_property(np, "cpuid", &len);
 	if (data == NULL) {
 		printk(KERN_ERR "therm_pm72: Failed to retrieve cpuid property from device-tree\n");
 		of_node_put(np);
@@ -1336,7 +1336,7 @@ static int init_backside_state(struct ba
 	 */
 	u3 = of_find_node_by_path("/u3@0,f8000000");
 	if (u3 != NULL) {
-		u32 *vers = (u32 *)get_property(u3, "device-rev", NULL);
+		const u32 *vers = get_property(u3, "device-rev", NULL);
 		if (vers)
 			if (((*vers) & 0x3f) < 0x34)
 				u3h = 0;
@@ -2111,8 +2111,8 @@ static void fcu_lookup_fans(struct devic
 
 	while ((np = of_get_next_child(fcu_node, np)) != NULL) {
 		int type = -1;
-		char *loc;
-		u32 *reg;
+		const char *loc;
+		const u32 *reg;
 
 		DBG(" control: %s, type: %s\n", np->name, np->type);
 
@@ -2128,8 +2128,8 @@ static void fcu_lookup_fans(struct devic
 			continue;
 
 		/* Lookup for a matching location */
-		loc = (char *)get_property(np, "location", NULL);
-		reg = (u32 *)get_property(np, "reg", NULL);
+		loc = get_property(np, "location", NULL);
+		reg = get_property(np, "reg", NULL);
 		if (loc == NULL || reg == NULL)
 			continue;
 		DBG(" matching location: %s, reg: 0x%08x\n", loc, *reg);
Index: linux-2.6/drivers/macintosh/via-cuda.c
===================================================================
--- linux-2.6.orig/drivers/macintosh/via-cuda.c
+++ linux-2.6/drivers/macintosh/via-cuda.c
@@ -123,7 +123,7 @@ int __init find_via_cuda(void)
 {
     struct adb_request req;
     phys_addr_t taddr;
-    u32 *reg;
+    const u32 *reg;
     int err;
 
     if (vias != 0)
@@ -132,7 +132,7 @@ int __init find_via_cuda(void)
     if (vias == 0)
 	return 0;
 
-    reg = (u32 *)get_property(vias, "reg", NULL);
+    reg = get_property(vias, "reg", NULL);
     if (reg == NULL) {
 	    printk(KERN_ERR "via-cuda: No \"reg\" property !\n");
 	    goto fail;
Index: linux-2.6/drivers/macintosh/via-pmu-led.c
===================================================================
--- linux-2.6.orig/drivers/macintosh/via-pmu-led.c
+++ linux-2.6/drivers/macintosh/via-pmu-led.c
@@ -120,7 +120,7 @@ static int __init via_pmu_led_init(void)
 	dt = of_find_node_by_path("/");
 	if (dt == NULL)
 		return -ENODEV;
-	model = (const char *)get_property(dt, "model", NULL);
+	model = get_property(dt, "model", NULL);
 	if (model == NULL)
 		return -ENODEV;
 	if (strncmp(model, "PowerBook", strlen("PowerBook")) != 0 &&
Index: linux-2.6/drivers/macintosh/via-pmu.c
===================================================================
--- linux-2.6.orig/drivers/macintosh/via-pmu.c
+++ linux-2.6/drivers/macintosh/via-pmu.c
@@ -287,7 +287,7 @@ static char *pbook_type[] = {
 int __init find_via_pmu(void)
 {
 	u64 taddr;
-	u32 *reg;
+	const u32 *reg;
 
 	if (via != 0)
 		return 1;
@@ -295,7 +295,7 @@ int __init find_via_pmu(void)
 	if (vias == NULL)
 		return 0;
 
-	reg = (u32 *)get_property(vias, "reg", NULL);
+	reg = get_property(vias, "reg", NULL);
 	if (reg == NULL) {
 		printk(KERN_ERR "via-pmu: No \"reg\" property !\n");
 		goto fail;
@@ -337,7 +337,7 @@ int __init find_via_pmu(void)
 		
 		gpiop = of_find_node_by_name(NULL, "gpio");
 		if (gpiop) {
-			reg = (u32 *)get_property(gpiop, "reg", NULL);
+			reg = get_property(gpiop, "reg", NULL);
 			if (reg)
 				gaddr = of_translate_address(gpiop, reg);
 			if (gaddr != OF_BAD_ADDR)
@@ -486,9 +486,9 @@ static int __init via_pmu_dev_init(void)
 		pmu_batteries[1].flags |= PMU_BATT_TYPE_SMART;
 	} else {
 		struct device_node* prim = find_devices("power-mgt");
-		u32 *prim_info = NULL;
+		const u32 *prim_info = NULL;
 		if (prim)
-			prim_info = (u32 *)get_property(prim, "prim-info", NULL);
+			prim_info = get_property(prim, "prim-info", NULL);
 		if (prim_info) {
 			/* Other stuffs here yet unknown */
 			pmu_battery_count = (prim_info[6] >> 16) & 0xff;
Index: linux-2.6/drivers/macintosh/windfarm_smu_controls.c
===================================================================
--- linux-2.6.orig/drivers/macintosh/windfarm_smu_controls.c
+++ linux-2.6/drivers/macintosh/windfarm_smu_controls.c
@@ -159,14 +159,15 @@ static struct smu_fan_control *smu_fan_c
 					      int pwm_fan)
 {
 	struct smu_fan_control *fct;
-	s32 *v; u32 *reg;
-	char *l;
+	const s32 *v;
+	const u32 *reg;
+	const char *l;
 
 	fct = kmalloc(sizeof(struct smu_fan_control), GFP_KERNEL);
 	if (fct == NULL)
 		return NULL;
 	fct->ctrl.ops = &smu_fan_ops;
-	l = (char *)get_property(node, "location", NULL);
+	l = get_property(node, "location", NULL);
 	if (l == NULL)
 		goto fail;
 
@@ -223,17 +224,17 @@ static struct smu_fan_control *smu_fan_c
 		goto fail;
 
 	/* Get min & max values*/
-	v = (s32 *)get_property(node, "min-value", NULL);
+	v = get_property(node, "min-value", NULL);
 	if (v == NULL)
 		goto fail;
 	fct->min = *v;
-	v = (s32 *)get_property(node, "max-value", NULL);
+	v = get_property(node, "max-value", NULL);
 	if (v == NULL)
 		goto fail;
 	fct->max = *v;
 
 	/* Get "reg" value */
-	reg = (u32 *)get_property(node, "reg", NULL);
+	reg = get_property(node, "reg", NULL);
 	if (reg == NULL)
 		goto fail;
 	fct->reg = *reg;
Index: linux-2.6/drivers/macintosh/windfarm_smu_sat.c
===================================================================
--- linux-2.6.orig/drivers/macintosh/windfarm_smu_sat.c
+++ linux-2.6/drivers/macintosh/windfarm_smu_sat.c
@@ -233,15 +233,15 @@ static void wf_sat_create(struct i2c_ada
 {
 	struct wf_sat *sat;
 	struct wf_sat_sensor *sens;
-	u32 *reg;
-	char *loc, *type;
+	const u32 *reg;
+	const char *loc, *type;
 	u8 addr, chip, core;
 	struct device_node *child;
 	int shift, cpu, index;
 	char *name;
 	int vsens[2], isens[2];
 
-	reg = (u32 *) get_property(dev, "reg", NULL);
+	reg = get_property(dev, "reg", NULL);
 	if (reg == NULL)
 		return;
 	addr = *reg;
@@ -268,7 +268,7 @@ static void wf_sat_create(struct i2c_ada
 	isens[0] = isens[1] = -1;
 	child = NULL;
 	while ((child = of_get_next_child(dev, child)) != NULL) {
-		reg = (u32 *) get_property(child, "reg", NULL);
+		reg = get_property(child, "reg", NULL);
 		type = get_property(child, "device_type", NULL);
 		loc = get_property(child, "location", NULL);
 		if (reg == NULL || loc == NULL)
Index: linux-2.6/drivers/macintosh/windfarm_smu_sensors.c
===================================================================
--- linux-2.6.orig/drivers/macintosh/windfarm_smu_sensors.c
+++ linux-2.6/drivers/macintosh/windfarm_smu_sensors.c
@@ -198,14 +198,14 @@ static struct wf_sensor_ops smu_slotspow
 static struct smu_ad_sensor *smu_ads_create(struct device_node *node)
 {
 	struct smu_ad_sensor *ads;
-	char *c, *l;
-	u32 *v;
+	const char *c, *l;
+	const u32 *v;
 
 	ads = kmalloc(sizeof(struct smu_ad_sensor), GFP_KERNEL);
 	if (ads == NULL)
 		return NULL;
-	c = (char *)get_property(node, "device_type", NULL);
-	l = (char *)get_property(node, "location", NULL);
+	c = get_property(node, "device_type", NULL);
+	l = get_property(node, "location", NULL);
 	if (c == NULL || l == NULL)
 		goto fail;
 
@@ -255,7 +255,7 @@ static struct smu_ad_sensor *smu_ads_cre
 	} else
 		goto fail;
 
-	v = (u32 *)get_property(node, "reg", NULL);
+	v = get_property(node, "reg", NULL);
 	if (v == NULL)
 		goto fail;
 	ads->reg = *v;
@@ -382,7 +382,7 @@ smu_cpu_power_create(struct wf_sensor *v
 
 static void smu_fetch_param_partitions(void)
 {
-	struct smu_sdbp_header *hdr;
+	const struct smu_sdbp_header *hdr;
 
 	/* Get CPU voltage/current/power calibration data */
 	hdr = smu_get_sdb_partition(SMU_SDB_CPUVCP_ID, NULL);
Index: linux-2.6/drivers/macintosh/windfarm_pm81.c
===================================================================
--- linux-2.6.orig/drivers/macintosh/windfarm_pm81.c
+++ linux-2.6/drivers/macintosh/windfarm_pm81.c
@@ -396,7 +396,7 @@ static void wf_smu_sys_fans_tick(struct 
 static void wf_smu_create_cpu_fans(void)
 {
 	struct wf_cpu_pid_param pid_param;
-	struct smu_sdbp_header *hdr;
+	const struct smu_sdbp_header *hdr;
 	struct smu_sdbp_cpupiddata *piddata;
 	struct smu_sdbp_fvt *fvt;
 	s32 tmax, tdelta, maxpow, powadj;
@@ -702,7 +702,7 @@ static struct notifier_block wf_smu_even
 
 static int wf_init_pm(void)
 {
-	struct smu_sdbp_header *hdr;
+	const struct smu_sdbp_header *hdr;
 
 	hdr = smu_get_sdb_partition(SMU_SDB_SENSORTREE_ID, NULL);
 	if (hdr != 0) {
Index: linux-2.6/drivers/macintosh/windfarm_pm91.c
===================================================================
--- linux-2.6.orig/drivers/macintosh/windfarm_pm91.c
+++ linux-2.6/drivers/macintosh/windfarm_pm91.c
@@ -144,7 +144,7 @@ static struct wf_smu_slots_fans_state *w
 static void wf_smu_create_cpu_fans(void)
 {
 	struct wf_cpu_pid_param pid_param;
-	struct smu_sdbp_header *hdr;
+	const struct smu_sdbp_header *hdr;
 	struct smu_sdbp_cpupiddata *piddata;
 	struct smu_sdbp_fvt *fvt;
 	s32 tmax, tdelta, maxpow, powadj;
Index: linux-2.6/include/asm-powerpc/smu.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/smu.h
+++ linux-2.6/include/asm-powerpc/smu.h
@@ -517,7 +517,7 @@ struct smu_sdbp_cpupiddata {
  * This returns the pointer to an SMU "sdb" partition data or NULL
  * if not found. The data format is described below
  */
-extern struct smu_sdbp_header *smu_get_sdb_partition(int id,
+extern const struct smu_sdbp_header *smu_get_sdb_partition(int id,
 					unsigned int *size);
 
 /* Get "sdb" partition data from an SMU satellite */
Index: linux-2.6/drivers/macintosh/macio_sysfs.c
===================================================================
--- linux-2.6.orig/drivers/macintosh/macio_sysfs.c
+++ linux-2.6/drivers/macintosh/macio_sysfs.c
@@ -16,12 +16,12 @@ static ssize_t
 compatible_show (struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct of_device *of;
-	char *compat;
+	const char *compat;
 	int cplen;
 	int length = 0;
 
 	of = &to_macio_device (dev)->ofdev;
-	compat = (char *) get_property(of->node, "compatible", &cplen);
+	compat = get_property(of->node, "compatible", &cplen);
 	if (!compat) {
 		*buf = '\0';
 		return 0;
@@ -42,12 +42,12 @@ static ssize_t modalias_show (struct dev
 			      char *buf)
 {
 	struct of_device *of;
-	char *compat;
+	const char *compat;
 	int cplen;
 	int length;
 
 	of = &to_macio_device (dev)->ofdev;
-	compat = (char *) get_property (of->node, "compatible", &cplen);
+	compat = get_property(of->node, "compatible", &cplen);
 	if (!compat) compat = "", cplen = 1;
 	length = sprintf (buf, "of:N%sT%s", of->node->name, of->node->type);
 	buf += length;
Index: linux-2.6/drivers/macintosh/therm_windtunnel.c
===================================================================
--- linux-2.6.orig/drivers/macintosh/therm_windtunnel.c
+++ linux-2.6/drivers/macintosh/therm_windtunnel.c
@@ -484,14 +484,14 @@ struct apple_thermal_info {
 static int __init
 g4fan_init( void )
 {
-	struct apple_thermal_info *info;
+	const struct apple_thermal_info *info;
 	struct device_node *np;
 
 	init_MUTEX( &x.lock );
 
 	if( !(np=of_find_node_by_name(NULL, "power-mgt")) )
 		return -ENODEV;
-	info = (struct apple_thermal_info*)get_property(np, "thermal-info", NULL);
+	info = get_property(np, "thermal-info", NULL);
 	of_node_put(np);
 
 	if( !info || !machine_is_compatible("PowerMac3,6") )
Index: linux-2.6/drivers/i2c/busses/i2c-powermac.c
===================================================================
--- linux-2.6.orig/drivers/i2c/busses/i2c-powermac.c
+++ linux-2.6/drivers/i2c/busses/i2c-powermac.c
@@ -209,7 +209,8 @@ static int i2c_powermac_probe(struct dev
 	struct pmac_i2c_bus *bus = dev->platform_data;
 	struct device_node *parent = NULL;
 	struct i2c_adapter *adapter;
-	char name[32], *basename;
+	char name[32];
+	const char *basename;
 	int rc;
 
 	if (bus == NULL)
Index: linux-2.6/drivers/ide/ppc/pmac.c
===================================================================
--- linux-2.6.orig/drivers/ide/ppc/pmac.c
+++ linux-2.6/drivers/ide/ppc/pmac.c
@@ -1154,7 +1154,7 @@ static int
 pmac_ide_setup_device(pmac_ide_hwif_t *pmif, ide_hwif_t *hwif)
 {
 	struct device_node *np = pmif->node;
-	int *bidp;
+	const int *bidp;
 
 	pmif->cable_80 = 0;
 	pmif->broken_dma = pmif->broken_dma_warn = 0;
@@ -1176,14 +1176,14 @@ pmac_ide_setup_device(pmac_ide_hwif_t *p
 		pmif->broken_dma = 1;
 	}
 
-	bidp = (int *)get_property(np, "AAPL,bus-id", NULL);
+	bidp = get_property(np, "AAPL,bus-id", NULL);
 	pmif->aapl_bus_id =  bidp ? *bidp : 0;
 
 	/* Get cable type from device-tree */
 	if (pmif->kind == controller_kl_ata4 || pmif->kind == controller_un_ata6
 	    || pmif->kind == controller_k2_ata6
 	    || pmif->kind == controller_sh_ata6) {
-		char* cable = get_property(np, "cable-type", NULL);
+		const char* cable = get_property(np, "cable-type", NULL);
 		if (cable && !strncmp(cable, "80-", 3))
 			pmif->cable_80 = 1;
 	}
Index: linux-2.6/drivers/serial/pmac_zilog.c
===================================================================
--- linux-2.6.orig/drivers/serial/pmac_zilog.c
+++ linux-2.6/drivers/serial/pmac_zilog.c
@@ -1400,8 +1400,8 @@ static struct uart_ops pmz_pops = {
 static int __init pmz_init_port(struct uart_pmac_port *uap)
 {
 	struct device_node *np = uap->node;
-	char *conn;
-	struct slot_names_prop {
+	const char *conn;
+	const struct slot_names_prop {
 		int	count;
 		char	name[1];
 	} *slots;
@@ -1458,7 +1458,7 @@ no_dma:
 		uap->flags |= PMACZILOG_FLAG_IS_IRDA;
 	uap->port_type = PMAC_SCC_ASYNC;
 	/* 1999 Powerbook G3 has slot-names property instead */
-	slots = (struct slot_names_prop *)get_property(np, "slot-names", &len);
+	slots = get_property(np, "slot-names", &len);
 	if (slots && slots->count > 0) {
 		if (strcmp(slots->name, "IrDA") == 0)
 			uap->flags |= PMACZILOG_FLAG_IS_IRDA;
@@ -1470,7 +1470,8 @@ no_dma:
 	if (ZS_IS_INTMODEM(uap)) {
 		struct device_node* i2c_modem = find_devices("i2c-modem");
 		if (i2c_modem) {
-			char* mid = get_property(i2c_modem, "modem-id", NULL);
+			const char* mid =
+				get_property(i2c_modem, "modem-id", NULL);
 			if (mid) switch(*mid) {
 			case 0x04 :
 			case 0x05 :

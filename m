Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 94DB6DDF2A
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 13:53:00 +1000 (EST)
Date: Tue, 24 Apr 2007 13:50:55 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 3/5] [POWERPC] Remove old interface find_path_device
Message-Id: <20070424135055.1b7d9e62.sfr@canb.auug.org.au>
In-Reply-To: <20070424134841.cee3ff4e.sfr@canb.auug.org.au>
References: <20070413171422.c19353e2.sfr@canb.auug.org.au>
	<20070424134841.cee3ff4e.sfr@canb.auug.org.au>
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

Replaced by of_find_node_by_path.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/lparcfg.c             |    6 +++-
 arch/powerpc/kernel/pci_32.c              |   17 ++++++++++----
 arch/powerpc/kernel/prom.c                |   14 ------------
 arch/powerpc/kernel/rtas.c                |    3 +-
 arch/powerpc/kernel/sysfs.c               |    3 +-
 arch/powerpc/platforms/chrp/pci.c         |    7 +++--
 arch/powerpc/platforms/chrp/setup.c       |    9 +++++--
 arch/powerpc/platforms/powermac/feature.c |   34 +++++++++++++++++++---------
 drivers/char/briq_panel.c                 |    7 ++++-
 drivers/scsi/ibmvscsi/ibmvstgt.c          |    3 +-
 drivers/scsi/ibmvscsi/rpa_vscsi.c         |    3 +-
 include/asm-powerpc/prom.h                |    1 -
 12 files changed, 62 insertions(+), 45 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/lparcfg.c b/arch/powerpc/kernel/lparcfg.c
index b8dc1ee..fc1f7a9 100644
--- a/arch/powerpc/kernel/lparcfg.c
+++ b/arch/powerpc/kernel/lparcfg.c
@@ -321,7 +321,7 @@ static int pseries_lparcfg_data(struct seq_file *m, void *v)
 	struct device_node *rtas_node;
 	const int *lrdrp = NULL;
 
-	rtas_node = find_path_device("/rtas");
+	rtas_node = of_find_node_by_path("/rtas");
 	if (rtas_node)
 		lrdrp = of_get_property(rtas_node, "ibm,lrdr-capacity", NULL);
 
@@ -330,6 +330,7 @@ static int pseries_lparcfg_data(struct seq_file *m, void *v)
 	} else {
 		partition_potential_processors = *(lrdrp + 4);
 	}
+	of_node_put(rtas_node);
 
 	partition_active_processors = lparcfg_count_active_processors();
 
@@ -537,7 +538,7 @@ static int lparcfg_data(struct seq_file *m, void *v)
 
 	seq_printf(m, "%s %s \n", MODULE_NAME, MODULE_VERS);
 
-	rootdn = find_path_device("/");
+	rootdn = of_find_node_by_path("/");
 	if (rootdn) {
 		tmp = of_get_property(rootdn, "model", NULL);
 		if (tmp) {
@@ -557,6 +558,7 @@ static int lparcfg_data(struct seq_file *m, void *v)
 					NULL);
 		if (lp_index_ptr)
 			lp_index = *lp_index_ptr;
+		of_node_put(rootdn);
 	}
 	seq_printf(m, "serial_number=%s\n", system_id);
 	seq_printf(m, "system_type=%s\n", model);
diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index ae04f94..5b05a09 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -669,6 +669,7 @@ pcibios_make_OF_bus_map(void)
 	int i;
 	struct pci_controller* hose;
 	struct property *map_prop;
+	struct device_node *dn;
 
 	pci_to_OF_bus_map = kmalloc(pci_bus_count, GFP_KERNEL);
 	if (!pci_to_OF_bus_map) {
@@ -690,12 +691,13 @@ pcibios_make_OF_bus_map(void)
 			continue;
 		make_one_node_map(node, hose->first_busno);
 	}
-	map_prop = of_find_property(find_path_device("/"),
-			"pci-OF-bus-map", NULL);
+	dn = of_find_node_by_path("/");
+	map_prop = of_find_property(dn, "pci-OF-bus-map", NULL);
 	if (map_prop) {
 		BUG_ON(pci_bus_count > map_prop->length);
 		memcpy(map_prop->value, pci_to_OF_bus_map, pci_bus_count);
 	}
+	of_node_put(dn);
 #ifdef DEBUG
 	printk("PCI->OF bus map:\n");
 	for (i=0; i<pci_bus_count; i++) {
@@ -1006,14 +1008,19 @@ void __init
 pci_create_OF_bus_map(void)
 {
 	struct property* of_prop;
-	
+	struct device_node *dn;
+
 	of_prop = (struct property*) alloc_bootmem(sizeof(struct property) + 256);
-	if (of_prop && find_path_device("/")) {
+	if (!of_prop)
+		return;
+	dn = of_find_node_by_path("/");
+	if (dn) {
 		memset(of_prop, -1, sizeof(struct property) + 256);
 		of_prop->name = "pci-OF-bus-map";
 		of_prop->length = 256;
 		of_prop->value = &of_prop[1];
-		prom_add_property(find_path_device("/"), of_prop);
+		prom_add_property(dn, of_prop);
+		of_node_put(dn);
 	}
 }
 
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 911ec77..17c41fe 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -1153,20 +1153,6 @@ int machine_is_compatible(const char *compat)
 }
 EXPORT_SYMBOL(machine_is_compatible);
 
-/**
- * Find the device_node with a given full_name.
- */
-struct device_node *find_path_device(const char *path)
-{
-	struct device_node *np;
-
-	for (np = allnodes; np != 0; np = np->allnext)
-		if (np->full_name != 0 && strcasecmp(np->full_name, path) == 0)
-			return np;
-	return NULL;
-}
-EXPORT_SYMBOL(find_path_device);
-
 /*******
  *
  * New implementation of the OF "find" APIs, return a refcounted
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 702fecc..2147807 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -192,7 +192,7 @@ void rtas_progress(char *s, unsigned short hex)
 
 	if (display_width == 0) {
 		display_width = 0x10;
-		if ((root = find_path_device("/rtas"))) {
+		if ((root = of_find_node_by_path("/rtas"))) {
 			if ((p = of_get_property(root,
 					"ibm,display-line-length", NULL)))
 				display_width = *p;
@@ -204,6 +204,7 @@ void rtas_progress(char *s, unsigned short hex)
 				display_lines = *p;
 			row_width = of_get_property(root,
 					"ibm,display-truncation-length", NULL);
+			of_node_put(root);
 		}
 		display_character = rtas_token("display-character");
 		set_indicator = rtas_token("set-indicator");
diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 476f1d5..fe329d6 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -66,7 +66,7 @@ static int __init smt_setup(void)
 	if (!cpu_has_feature(CPU_FTR_SMT))
 		return -ENODEV;
 
-	options = find_path_device("/options");
+	options = of_find_node_by_path("/options");
 	if (!options)
 		return -ENODEV;
 
@@ -76,6 +76,7 @@ static int __init smt_setup(void)
 			per_cpu(smt_snooze_delay, cpu) = *val;
 	}
 
+	of_node_put(options);
 	return 0;
 }
 __initcall(smt_setup);
diff --git a/arch/powerpc/platforms/chrp/pci.c b/arch/powerpc/platforms/chrp/pci.c
index b23e397..de776e3 100644
--- a/arch/powerpc/platforms/chrp/pci.c
+++ b/arch/powerpc/platforms/chrp/pci.c
@@ -185,10 +185,9 @@ setup_python(struct pci_controller *hose, struct device_node *dev)
 /* Marvell Discovery II based Pegasos 2 */
 static void __init setup_peg2(struct pci_controller *hose, struct device_node *dev)
 {
-	struct device_node *root = find_path_device("/");
+	struct device_node *root = of_find_node_by_path("/");
 	struct device_node *rtas;
 
-	of_node_get(root);
 	rtas = of_find_node_by_name (root, "rtas");
 	if (rtas) {
 		hose->ops = &rtas_pci_ops;
@@ -198,6 +197,7 @@ static void __init setup_peg2(struct pci_controller *hose, struct device_node *d
 			" your firmware\n");
 	}
 	pci_assign_all_buses = 1;
+	/* keep the reference to the root node */
 }
 
 void __init
@@ -210,7 +210,7 @@ chrp_find_bridges(void)
 	const unsigned int *dma;
 	const char *model, *machine;
 	int is_longtrail = 0, is_mot = 0, is_pegasos = 0;
-	struct device_node *root = find_path_device("/");
+	struct device_node *root = of_find_node_by_path("/");
 	struct resource r;
 	/*
 	 * The PCI host bridge nodes on some machines don't have
@@ -309,6 +309,7 @@ chrp_find_bridges(void)
 			printk("pci_dram_offset = %lx\n", pci_dram_offset);
 		}
 	}
+	of_node_put(root);
 }
 
 /* SL82C105 IDE Control/Status Register */
diff --git a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
index 05d1bc0..e46c4d4 100644
--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -110,7 +110,7 @@ void chrp_show_cpuinfo(struct seq_file *m)
 	struct device_node *root;
 	const char *model = "";
 
-	root = find_path_device("/");
+	root = of_find_node_by_path("/");
 	if (root)
 		model = of_get_property(root, "model", NULL);
 	seq_printf(m, "machine\t\t: CHRP %s\n", model);
@@ -160,6 +160,7 @@ void chrp_show_cpuinfo(struct seq_file *m)
 			   gg2_cachetypes[(t>>2) & 3],
 			   gg2_cachemodes[t & 3]);
 	}
+	of_node_put(root);
 }
 
 /*
@@ -204,7 +205,7 @@ static void __init sio_init(void)
 {
 	struct device_node *root;
 
-	if ((root = find_path_device("/")) &&
+	if ((root = of_find_node_by_path("/")) &&
 	    !strncmp(of_get_property(root, "model", NULL),
 			"IBM,LongTrail", 13)) {
 		/* logical device 0 (KBC/Keyboard) */
@@ -212,6 +213,7 @@ static void __init sio_init(void)
 		/* select logical device 1 (KBC/Mouse) */
 		sio_fixup_irq("mouse", 1, 12, 2);
 	}
+	of_node_put(root);
 }
 
 
@@ -250,7 +252,7 @@ static void briq_restart(char *cmd)
 
 void __init chrp_setup_arch(void)
 {
-	struct device_node *root = find_path_device ("/");
+	struct device_node *root = of_find_node_by_path("/");
 	const char *machine = NULL;
 
 	/* init to some ~sane value until calibrate_delay() runs */
@@ -273,6 +275,7 @@ void __init chrp_setup_arch(void)
 		/* Let's assume it is an IBM chrp if all else fails */
 		_chrp_type = _CHRP_IBM;
 	}
+	of_node_put(root);
 	printk("chrp type = %x [%s]\n", _chrp_type, chrp_names[_chrp_type]);
 
 	rtas_initialize();
diff --git a/arch/powerpc/platforms/powermac/feature.c b/arch/powerpc/platforms/powermac/feature.c
index 103fcc4..44f8550 100644
--- a/arch/powerpc/platforms/powermac/feature.c
+++ b/arch/powerpc/platforms/powermac/feature.c
@@ -1044,6 +1044,7 @@ core99_reset_cpu(struct device_node *node, long param, long value)
 	unsigned long flags;
 	struct macio_chip *macio;
 	struct device_node *np;
+	struct device_node *cpus;
 	const int dflt_reset_lines[] = {	KL_GPIO_RESET_CPU0,
 						KL_GPIO_RESET_CPU1,
 						KL_GPIO_RESET_CPU2,
@@ -1053,10 +1054,10 @@ core99_reset_cpu(struct device_node *node, long param, long value)
 	if (macio->type != macio_keylargo)
 		return -ENODEV;
 
-	np = find_path_device("/cpus");
-	if (np == NULL)
+	cpus = of_find_node_by_path("/cpus");
+	if (cpus == NULL)
 		return -ENODEV;
-	for (np = np->child; np != NULL; np = np->sibling) {
+	for (np = cpus->child; np != NULL; np = np->sibling) {
 		const u32 *num = of_get_property(np, "reg", NULL);
 		const u32 *rst = of_get_property(np, "soft-reset", NULL);
 		if (num == NULL || rst == NULL)
@@ -1066,6 +1067,7 @@ core99_reset_cpu(struct device_node *node, long param, long value)
 			break;
 		}
 	}
+	of_node_put(cpus);
 	if (np == NULL || reset_io == 0)
 		reset_io = dflt_reset_lines[param];
 
@@ -1497,15 +1499,16 @@ static long g5_reset_cpu(struct device_node *node, long param, long value)
 	unsigned long flags;
 	struct macio_chip *macio;
 	struct device_node *np;
+	struct device_node *cpus;
 
 	macio = &macio_chips[0];
 	if (macio->type != macio_keylargo2 && macio->type != macio_shasta)
 		return -ENODEV;
 
-	np = find_path_device("/cpus");
-	if (np == NULL)
+	cpus = of_find_node_by_path("/cpus");
+	if (cpus == NULL)
 		return -ENODEV;
-	for (np = np->child; np != NULL; np = np->sibling) {
+	for (np = cpus->child; np != NULL; np = np->sibling) {
 		const u32 *num = of_get_property(np, "reg", NULL);
 		const u32 *rst = of_get_property(np, "soft-reset", NULL);
 		if (num == NULL || rst == NULL)
@@ -1515,6 +1518,7 @@ static long g5_reset_cpu(struct device_node *node, long param, long value)
 			break;
 		}
 	}
+	of_node_put(cpus);
 	if (np == NULL || reset_io == 0)
 		return -ENODEV;
 
@@ -2499,18 +2503,26 @@ found:
 	 * that all Apple OF revs did it properly, I do it the paranoid way.
 	 */
 	while (uninorth_base && uninorth_rev > 3) {
-		struct device_node *np = find_path_device("/cpus");
-		if (!np || !np->child) {
+		struct device_node *cpus = of_find_node_by_path("/cpus");
+		struct device_node *np;
+
+		if (!cpus || !cpus->child) {
 			printk(KERN_WARNING "Can't find CPU(s) in device tree !\n");
+			of_node_put(cpus);
 			break;
 		}
-		np = np->child;
+		np = cpus->child;
 		/* Nap mode not supported on SMP */
-		if (np->sibling)
+		if (np->sibling) {
+			of_node_put(cpus);
 			break;
+		}
 		/* Nap mode not supported if flush-on-lock property is present */
-		if (of_get_property(np, "flush-on-lock", NULL))
+		if (of_get_property(np, "flush-on-lock", NULL)) {
+			of_node_put(cpus);
 			break;
+		}
+		of_node_put(cpus);
 		powersave_nap = 1;
 		printk(KERN_DEBUG "Processor NAP mode on idle enabled.\n");
 		break;
diff --git a/drivers/char/briq_panel.c b/drivers/char/briq_panel.c
index 669965a..ed53f54 100644
--- a/drivers/char/briq_panel.c
+++ b/drivers/char/briq_panel.c
@@ -202,13 +202,16 @@ static struct miscdevice briq_panel_miscdev = {
 
 static int __init briq_panel_init(void)
 {
-	struct device_node *root = find_path_device("/");
+	struct device_node *root = of_find_node_by_path("/");
 	const char *machine;
 	int i;
 
 	machine = of_get_property(root, "model", NULL);
-	if (!machine || strncmp(machine, "TotalImpact,BRIQ-1", 18) != 0)
+	if (!machine || strncmp(machine, "TotalImpact,BRIQ-1", 18) != 0) {
+		of_node_put(root);
 		return -ENODEV;
+	}
+	of_node_put(root);
 
 	printk(KERN_INFO
 		"briq_panel: v%s Dr. Karsten Jeppesen (kj@totalimpact.com)\n",
diff --git a/drivers/scsi/ibmvscsi/ibmvstgt.c b/drivers/scsi/ibmvscsi/ibmvstgt.c
index 3fe831c..140dd97 100644
--- a/drivers/scsi/ibmvscsi/ibmvstgt.c
+++ b/drivers/scsi/ibmvscsi/ibmvstgt.c
@@ -899,7 +899,7 @@ static int get_system_info(void)
 	const char *id, *model, *name;
 	const unsigned int *num;
 
-	rootdn = find_path_device("/");
+	rootdn = of_find_node_by_path("/");
 	if (!rootdn)
 		return -ENOENT;
 
@@ -916,6 +916,7 @@ static int get_system_info(void)
 	if (num)
 		partition_number = *num;
 
+	of_node_put(rootdn);
 	return 0;
 }
 
diff --git a/drivers/scsi/ibmvscsi/rpa_vscsi.c b/drivers/scsi/ibmvscsi/rpa_vscsi.c
index 9bbb69c..d8700aa 100644
--- a/drivers/scsi/ibmvscsi/rpa_vscsi.c
+++ b/drivers/scsi/ibmvscsi/rpa_vscsi.c
@@ -157,7 +157,7 @@ static void gather_partition_info(void)
 	const unsigned int *p_number_ptr;
 
 	/* Retrieve information about this partition */
-	rootdn = find_path_device("/");
+	rootdn = of_find_node_by_path("/");
 	if (!rootdn) {
 		return;
 	}
@@ -169,6 +169,7 @@ static void gather_partition_info(void)
 	p_number_ptr = of_get_property(rootdn, "ibm,partition-no", NULL);
 	if (p_number_ptr)
 		partition_number = *p_number_ptr;
+	of_node_put(rootdn);
 }
 
 static void set_adapter_info(struct ibmvscsi_host_data *hostdata)
diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
index 38f7c3e..7c510a7 100644
--- a/include/asm-powerpc/prom.h
+++ b/include/asm-powerpc/prom.h
@@ -114,7 +114,6 @@ static inline void set_node_proc_entry(struct device_node *dn, struct proc_dir_e
 /* OBSOLETE: Old style node lookup */
 extern struct device_node *find_devices(const char *name);
 extern struct device_node *find_type_devices(const char *type);
-extern struct device_node *find_path_device(const char *path);
 
 /* New style node lookup */
 extern struct device_node *of_find_node_by_name(struct device_node *from,
-- 
1.5.1.1

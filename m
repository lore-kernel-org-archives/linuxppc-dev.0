Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 0DD64DDF57
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 13:53:02 +1000 (EST)
Date: Tue, 24 Apr 2007 13:53:04 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 5/5] [POWERPC] Remove old interface find_devices
Message-Id: <20070424135304.ac26d0de.sfr@canb.auug.org.au>
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

Replace uses with of_find_node_by_name and for_each_node_by_name.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/prom.c                  |   19 ------
 arch/powerpc/kernel/vio.c                   |    3 +-
 arch/powerpc/platforms/chrp/pci.c           |    6 +-
 arch/powerpc/platforms/chrp/setup.c         |    9 ++-
 arch/powerpc/platforms/powermac/backlight.c |    7 ++-
 arch/powerpc/platforms/powermac/feature.c   |   45 +++++++------
 arch/powerpc/platforms/powermac/pci.c       |   23 ++++---
 arch/powerpc/platforms/powermac/setup.c     |   25 ++++++-
 arch/powerpc/platforms/powermac/smp.c       |    5 +-
 drivers/macintosh/ans-lcd.c                 |    9 ++-
 drivers/macintosh/via-pmu.c                 |    4 +-
 drivers/media/video/planb.c                 |    5 +-
 drivers/serial/pmac_zilog.c                 |    4 +-
 drivers/video/controlfb.c                   |   16 +++--
 include/asm-powerpc/prom.h                  |    3 -
 sound/oss/dmasound/dmasound_awacs.c         |   90 +++++++++++++++++---------
 sound/oss/dmasound/tas_common.c             |    5 +-
 sound/ppc/pmac.c                            |   27 +++++---
 sound/ppc/tumbler.c                         |   35 +++++++---
 19 files changed, 206 insertions(+), 134 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 860c88b..caef555 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -1072,25 +1072,6 @@ int of_n_size_cells(struct device_node* np)
 }
 EXPORT_SYMBOL(of_n_size_cells);
 
-/**
- * Construct and return a list of the device_nodes with a given name.
- */
-struct device_node *find_devices(const char *name)
-{
-	struct device_node *head, **prevp, *np;
-
-	prevp = &head;
-	for (np = allnodes; np != 0; np = np->allnext) {
-		if (np->name != 0 && strcasecmp(np->name, name) == 0) {
-			*prevp = np;
-			prevp = &np->next;
-		}
-	}
-	*prevp = NULL;
-	return head;
-}
-EXPORT_SYMBOL(find_devices);
-
 /** Checks if the given "compat" string matches one of the strings in
  * the device's "compatible" property
  */
diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index a09277a..9eaefac 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -308,7 +308,7 @@ static int __init vio_bus_init(void)
 		return err;
 	}
 
-	node_vroot = find_devices("vdevice");
+	node_vroot = of_find_node_by_name(NULL, "vdevice");
 	if (node_vroot) {
 		struct device_node *of_node;
 
@@ -322,6 +322,7 @@ static int __init vio_bus_init(void)
 					__FUNCTION__, of_node);
 			vio_register_device_node(of_node);
 		}
+		of_node_put(node_vroot);
 	}
 
 	return 0;
diff --git a/arch/powerpc/platforms/chrp/pci.c b/arch/powerpc/platforms/chrp/pci.c
index de776e3..1469d64 100644
--- a/arch/powerpc/platforms/chrp/pci.c
+++ b/arch/powerpc/platforms/chrp/pci.c
@@ -136,9 +136,11 @@ hydra_init(void)
 	struct device_node *np;
 	struct resource r;
 
-	np = find_devices("mac-io");
-	if (np == NULL || of_address_to_resource(np, 0, &r))
+	np = of_find_node_by_name(NULL, "mac-io");
+	if (np == NULL || of_address_to_resource(np, 0, &r)) {
+		of_node_put(np);
 		return 0;
+	}
 	Hydra = ioremap(r.start, r.end-r.start);
 	printk("Hydra Mac I/O at %llx\n", (unsigned long long)r.start);
 	printk("Hydra Feature_Control was %x",
diff --git a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
index 9c1b231..1870038 100644
--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -468,7 +468,7 @@ static void __init chrp_find_8259(void)
 	 * Also, Pegasos-type platforms don't have a proper node to start
 	 * from anyway
 	 */
-	for (np = find_devices("pci"); np != NULL; np = np->next) {
+	for_each_node_by_name(np, "pci") {
 		const unsigned int *addrp = of_get_property(np,
 				"8259-interrupt-acknowledge", NULL);
 
@@ -477,6 +477,7 @@ static void __init chrp_find_8259(void)
 		chrp_int_ack = addrp[of_n_addr_cells(np)-1];
 		break;
 	}
+	of_node_put(np);
 	if (np == NULL)
 		printk(KERN_WARNING "Cannot find PCI interrupt acknowledge"
 		       " address, polling\n");
@@ -518,10 +519,11 @@ void __init chrp_init_IRQ(void)
 #if defined(CONFIG_VT) && defined(CONFIG_INPUT_ADBHID) && defined(CONFIG_XMON)
 	/* see if there is a keyboard in the device tree
 	   with a parent of type "adb" */
-	for (kbd = find_devices("keyboard"); kbd; kbd = kbd->next)
+	for_each_node_by_name(kbd, "keyboard")
 		if (kbd->parent && kbd->parent->type
 		    && strcmp(kbd->parent->type, "adb") == 0)
 			break;
+	of_node_put(kbd);
 	if (kbd)
 		setup_irq(HYDRA_INT_ADB_NMI, &xmon_irqaction);
 #endif
@@ -547,7 +549,7 @@ chrp_init2(void)
 	/* Get the event scan rate for the rtas so we know how
 	 * often it expects a heartbeat. -- Cort
 	 */
-	device = find_devices("rtas");
+	device = of_find_node_by_name(NULL, "rtas");
 	if (device)
 		p = of_get_property(device, "rtas-event-scan-rate", NULL);
 	if (p && *p) {
@@ -576,6 +578,7 @@ chrp_init2(void)
 		printk("RTAS Event Scan Rate: %u (%lu jiffies)\n",
 		       *p, interval);
 	}
+	of_node_put(device);
 
 	if (ppc_md.progress)
 		ppc_md.progress("  Have fun!    ", 0x7777);
diff --git a/arch/powerpc/platforms/powermac/backlight.c b/arch/powerpc/platforms/powermac/backlight.c
index 0dc8a45..d679964 100644
--- a/arch/powerpc/platforms/powermac/backlight.c
+++ b/arch/powerpc/platforms/powermac/backlight.c
@@ -56,13 +56,16 @@ struct backlight_device *pmac_backlight;
 
 int pmac_has_backlight_type(const char *type)
 {
-	struct device_node* bk_node = find_devices("backlight");
+	struct device_node* bk_node = of_find_node_by_name(NULL, "backlight");
 
 	if (bk_node) {
 		const char *prop = of_get_property(bk_node,
 				"backlight-control", NULL);
-		if (prop && strncmp(prop, type, strlen(type)) == 0)
+		if (prop && strncmp(prop, type, strlen(type)) == 0) {
+			of_node_put(bk_node);
 			return 1;
+		}
+		of_node_put(bk_node);
 	}
 
 	return 0;
diff --git a/arch/powerpc/platforms/powermac/feature.c b/arch/powerpc/platforms/powermac/feature.c
index 44f8550..52cfdd8 100644
--- a/arch/powerpc/platforms/powermac/feature.c
+++ b/arch/powerpc/platforms/powermac/feature.c
@@ -2408,12 +2408,13 @@ static int __init probe_motherboard(void)
 	struct macio_chip *macio = &macio_chips[0];
 	const char *model = NULL;
 	struct device_node *dt;
+	int ret = 0;
 
 	/* Lookup known motherboard type in device-tree. First try an
 	 * exact match on the "model" property, then try a "compatible"
 	 * match is none is found.
 	 */
-	dt = find_devices("device-tree");
+	dt = of_find_node_by_name(NULL, "device-tree");
 	if (dt != NULL)
 		model = of_get_property(dt, "model", NULL);
 	for(i=0; model && i<(sizeof(pmac_mb_defs)/sizeof(struct pmac_mb_def)); i++) {
@@ -2478,15 +2479,18 @@ static int __init probe_motherboard(void)
 		break;
 #endif /* CONFIG_POWER4 */
 	default:
-		return -ENODEV;
+		ret = -ENODEV;
+		goto done;
 	}
 found:
 #ifndef CONFIG_POWER4
 	/* Fixup Hooper vs. Comet */
 	if (pmac_mb.model_id == PMAC_TYPE_HOOPER) {
 		u32 __iomem * mach_id_ptr = ioremap(0xf3000034, 4);
-		if (!mach_id_ptr)
-			return -ENODEV;
+		if (!mach_id_ptr) {
+			ret = -ENODEV;
+			goto done;
+		}
 		/* Here, I used to disable the media-bay on comet. It
 		 * appears this is wrong, the floppy connector is actually
 		 * a kind of media-bay and works with the current driver.
@@ -2544,7 +2548,9 @@ found:
 
 
 	printk(KERN_INFO "PowerMac motherboard: %s\n", pmac_mb.model_name);
-	return 0;
+done:
+	of_node_put(dt);
+	return ret;
 }
 
 /* Initialize the Core99 UniNorth host bridge and memory controller
@@ -2747,12 +2753,14 @@ set_initial_features(void)
 	 * differenciate them all and since that hack was there for a long
 	 * time, I'll keep it around
 	 */
-	if (macio_chips[0].type == macio_ohare && !find_devices("via-pmu")) {
-		struct macio_chip *macio = &macio_chips[0];
-		MACIO_OUT32(OHARE_FCR, STARMAX_FEATURES);
-	} else if (macio_chips[0].type == macio_ohare) {
+	if (macio_chips[0].type == macio_ohare) {
 		struct macio_chip *macio = &macio_chips[0];
-		MACIO_BIS(OHARE_FCR, OH_IOBUS_ENABLE);
+		np = of_find_node_by_name(NULL, "via-pmu");
+		if (np)
+			MACIO_BIS(OHARE_FCR, OH_IOBUS_ENABLE);
+		else
+			MACIO_OUT32(OHARE_FCR, STARMAX_FEATURES);
+		of_node_put(np);
 	} else if (macio_chips[1].type == macio_ohare) {
 		struct macio_chip *macio = &macio_chips[1];
 		MACIO_BIS(OHARE_FCR, OH_IOBUS_ENABLE);
@@ -2845,14 +2853,13 @@ set_initial_features(void)
 		}
 
 		/* Switch airport off */
-		np = find_devices("radio");
-		while(np) {
+		for_each_node_by_name(np, "radio") {
 			if (np && np->parent == macio_chips[0].of_node) {
 				macio_chips[0].flags |= MACIO_FLAG_AIRPORT_ON;
 				core99_airport_enable(np, 0, 0);
 			}
-			np = np->next;
 		}
+		of_node_put(np);
 	}
 
 	/* On all machines that support sound PM, switch sound off */
@@ -2872,16 +2879,12 @@ set_initial_features(void)
 #endif /* CONFIG_POWER4 */
 
 	/* On all machines, switch modem & serial ports off */
-	np = find_devices("ch-a");
-	while(np) {
+	for_each_node_by_name(np, "ch-a")
 		initial_serial_shutdown(np);
-		np = np->next;
-	}
-	np = find_devices("ch-b");
-	while(np) {
+	of_node_put(np);
+	for_each_node_by_name(np, "ch-b")
 		initial_serial_shutdown(np);
-		np = np->next;
-	}
+	of_node_put(np);
 }
 
 void __init
diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
index 092cef4..22c4ae4 100644
--- a/arch/powerpc/platforms/powermac/pci.c
+++ b/arch/powerpc/platforms/powermac/pci.c
@@ -622,13 +622,14 @@ static void __init init_p2pbridge(void)
 
 	/* XXX it would be better here to identify the specific
 	   PCI-PCI bridge chip we have. */
-	if ((p2pbridge = find_devices("pci-bridge")) == 0
+	p2pbridge = of_find_node_by_name(NULL, "pci-bridge");
+	if (p2pbridge == NULL
 	    || p2pbridge->parent == NULL
 	    || strcmp(p2pbridge->parent->name, "pci") != 0)
-		return;
+		goto done;
 	if (pci_device_from_OF_node(p2pbridge, &bus, &devfn) < 0) {
 		DBG("Can't find PCI infos for PCI<->PCI bridge\n");
-		return;
+		goto done;
 	}
 	/* Warning: At this point, we have not yet renumbered all busses.
 	 * So we must use OF walking to find out hose
@@ -636,16 +637,18 @@ static void __init init_p2pbridge(void)
 	hose = pci_find_hose_for_OF_device(p2pbridge);
 	if (!hose) {
 		DBG("Can't find hose for PCI<->PCI bridge\n");
-		return;
+		goto done;
 	}
 	if (early_read_config_word(hose, bus, devfn,
 				   PCI_BRIDGE_CONTROL, &val) < 0) {
 		printk(KERN_ERR "init_p2pbridge: couldn't read bridge"
 		       " control\n");
-		return;
+		goto done;
 	}
 	val &= ~PCI_BRIDGE_CTL_MASTER_ABORT;
 	early_write_config_word(hose, bus, devfn, PCI_BRIDGE_CONTROL, val);
+done:
+	of_node_put(p2pbridge);
 }
 
 static void __init init_second_ohare(void)
@@ -1199,8 +1202,7 @@ void __init pmac_pcibios_after_init(void)
 	}
 #endif /* CONFIG_BLK_DEV_IDE */
 
-	nd = find_devices("firewire");
-	while (nd) {
+	for_each_node_by_name(nd, "firewire") {
 		if (nd->parent && (device_is_compatible(nd, "pci106b,18") ||
 				   device_is_compatible(nd, "pci106b,30") ||
 				   device_is_compatible(nd, "pci11c1,5811"))
@@ -1208,15 +1210,14 @@ void __init pmac_pcibios_after_init(void)
 			pmac_call_feature(PMAC_FTR_1394_ENABLE, nd, 0, 0);
 			pmac_call_feature(PMAC_FTR_1394_CABLE_POWER, nd, 0, 0);
 		}
-		nd = nd->next;
 	}
-	nd = find_devices("ethernet");
-	while (nd) {
+	of_node_put(nd);
+	for_each_node_by_name(nd, "ethernet") {
 		if (nd->parent && device_is_compatible(nd, "gmac")
 		    && device_is_compatible(nd->parent, "uni-north"))
 			pmac_call_feature(PMAC_FTR_GMAC_ENABLE, nd, 0, 0);
-		nd = nd->next;
 	}
+	of_node_put(nd);
 }
 
 #ifdef CONFIG_PPC32
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index ae37d3e..0444e07 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -193,8 +193,11 @@ static void pmac_show_cpuinfo(struct seq_file *m)
 #ifndef CONFIG_ADB_CUDA
 int find_via_cuda(void)
 {
-	if (!find_devices("via-cuda"))
+	struct device_node *dn = of_find_node_by_name(NULL, "via-cuda");
+
+	if (!dn)
 		return 0;
+	of_node_put(dn);
 	printk("WARNING ! Your machine is CUDA-based but your kernel\n");
 	printk("          wasn't compiled with CONFIG_ADB_CUDA option !\n");
 	return 0;
@@ -204,8 +207,11 @@ int find_via_cuda(void)
 #ifndef CONFIG_ADB_PMU
 int find_via_pmu(void)
 {
-	if (!find_devices("via-pmu"))
+	struct device_node *dn = of_find_node_by_name(NULL, "via-pmu");
+
+	if (!dn)
 		return 0;
+	of_node_put(dn);
 	printk("WARNING ! Your machine is PMU-based but your kernel\n");
 	printk("          wasn't compiled with CONFIG_ADB_PMU option !\n");
 	return 0;
@@ -225,6 +231,8 @@ static volatile u32 *sysctrl_regs;
 
 static void __init ohare_init(void)
 {
+	struct device_node *dn;
+
 	/* this area has the CPU identification register
 	   and some registers used by smp boards */
 	sysctrl_regs = (volatile u32 *) ioremap(0xf8000000, 0x1000);
@@ -234,7 +242,9 @@ static void __init ohare_init(void)
 	 * We assume that we have a PSX memory controller iff
 	 * we have an ohare I/O controller.
 	 */
-	if (find_devices("ohare") != NULL) {
+	dn = of_find_node_by_name(NULL, "ohare");
+	if (dn) {
+		of_node_put(dn);
 		if (((sysctrl_regs[2] >> 24) & 0xf) >= 3) {
 			if (sysctrl_regs[4] & 0x10)
 				sysctrl_regs[4] |= 0x04000020;
@@ -343,8 +353,15 @@ static void __init pmac_setup_arch(void)
 
 #ifdef CONFIG_SMP
 	/* Check for Core99 */
-	if (find_devices("uni-n") || find_devices("u3") || find_devices("u4"))
+	ic = of_find_node_by_name(NULL, "uni-n");
+	if (!ic)
+		ic = of_find_node_by_name(NULL, "u3");
+	if (!ic)
+		ic = of_find_node_by_name(NULL, "u4");
+	if (ic) {
+		of_node_put(ic);
 		smp_ops = &core99_smp_ops;
+	}
 #ifdef CONFIG_PPC32
 	else
 		smp_ops = &psurge_smp_ops;
diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index 20f3286..6f32c4e 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -264,6 +264,7 @@ static void __init psurge_quad_init(void)
 static int __init smp_psurge_probe(void)
 {
 	int i, ncpus;
+	struct device_node *dn;
 
 	/* We don't do SMP on the PPC601 -- paulus */
 	if (PVR_VER(mfspr(SPRN_PVR)) == 1)
@@ -279,8 +280,10 @@ static int __init smp_psurge_probe(void)
 	 * in the hammerhead memory controller in the case of the
 	 * dual-cpu powersurge board.  -- paulus.
 	 */
-	if (find_devices("hammerhead") == NULL)
+	dn = of_find_node_by_name(NULL, "hammerhead");
+	if (dn == NULL)
 		return 1;
+	of_node_put(dn);
 
 	hhead_base = ioremap(HAMMERHEAD_BASE, 0x800);
 	quad_base = ioremap(PSURGE_QUAD_REG_ADDR, 1024);
diff --git a/drivers/macintosh/ans-lcd.c b/drivers/macintosh/ans-lcd.c
index cdd5a0f..e54c4d9 100644
--- a/drivers/macintosh/ans-lcd.c
+++ b/drivers/macintosh/ans-lcd.c
@@ -145,11 +145,12 @@ anslcd_init(void)
 	int retval;
 	struct device_node* node;
 
-	node = find_devices("lcd");
-	if (!node || !node->parent)
-		return -ENODEV;
-	if (strcmp(node->parent->name, "gc"))
+	node = of_find_node_by_name(NULL, "lcd");
+	if (!node || !node->parent || strcmp(node->parent->name, "gc")) {
+		of_node_put(node);
 		return -ENODEV;
+	}
+	of_node_put(node);
 
 	anslcd_ptr = ioremap(ANSLCD_ADDR, 0x20);
 	
diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 7b7db5d..e31cb1e 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -487,7 +487,8 @@ static int __init via_pmu_dev_init(void)
 		pmu_batteries[0].flags |= PMU_BATT_TYPE_SMART;
 		pmu_batteries[1].flags |= PMU_BATT_TYPE_SMART;
 	} else {
-		struct device_node* prim = find_devices("power-mgt");
+		struct device_node* prim =
+			of_find_node_by_name(NULL, "power-mgt");
 		const u32 *prim_info = NULL;
 		if (prim)
 			prim_info = of_get_property(prim, "prim-info", NULL);
@@ -498,6 +499,7 @@ static int __init via_pmu_dev_init(void)
 			if (pmu_battery_count > 1)
 				pmu_batteries[1].flags |= PMU_BATT_TYPE_SMART;
 		}
+		of_node_put(prim);
 	}
 #endif /* CONFIG_PPC32 */
 
diff --git a/drivers/media/video/planb.c b/drivers/media/video/planb.c
index 86d2884..e6e61df 100644
--- a/drivers/media/video/planb.c
+++ b/drivers/media/video/planb.c
@@ -2160,7 +2160,7 @@ static int find_planb(void)
 	if (!machine_is(powermac))
 		return 0;
 
-	planb_devices = find_devices("planb");
+	planb_devices = of_find_node_by_name(NULL, "planb");
 	if (planb_devices == 0) {
 		planb_num=0;
 		printk(KERN_WARNING "PlanB: no device found!\n");
@@ -2175,12 +2175,14 @@ static int find_planb(void)
 	if (planb_devices->n_addrs != 1) {
 		printk (KERN_WARNING "PlanB: expecting 1 address for planb "
 			"(got %d)", planb_devices->n_addrs);
+		of_node_put(planb_devices);
 		return 0;
 	}
 
 	if (planb_devices->n_intrs == 0) {
 		printk(KERN_WARNING "PlanB: no intrs for device %s\n",
 		       planb_devices->full_name);
+		of_node_put(planb_devices);
 		return 0;
 	} else {
 		irq = planb_devices->intrs[0].line;
@@ -2202,6 +2204,7 @@ static int find_planb(void)
 	confreg = planb_devices->addrs[0].space & 0xff;
 	old_base = planb_devices->addrs[0].address;
 	new_base = 0xf1000000;
+	of_node_put(planb_devices);
 
 	DEBUG("PlanB: Found on bus %d, dev %d, func %d, "
 		"membase 0x%x (base reg. 0x%x)\n",
diff --git a/drivers/serial/pmac_zilog.c b/drivers/serial/pmac_zilog.c
index 2b163c5..cd92a39 100644
--- a/drivers/serial/pmac_zilog.c
+++ b/drivers/serial/pmac_zilog.c
@@ -1467,7 +1467,8 @@ no_dma:
 	if (ZS_IS_IRDA(uap))
 		uap->port_type = PMAC_SCC_IRDA;
 	if (ZS_IS_INTMODEM(uap)) {
-		struct device_node* i2c_modem = find_devices("i2c-modem");
+		struct device_node* i2c_modem =
+			of_find_node_by_name(NULL, "i2c-modem");
 		if (i2c_modem) {
 			const char* mid =
 				of_get_property(i2c_modem, "modem-id", NULL);
@@ -1482,6 +1483,7 @@ no_dma:
 			}
 			printk(KERN_INFO "pmac_zilog: i2c-modem detected, id: %d\n",
 				mid ? (*mid) : 0);
+			of_node_put(i2c_modem);
 		} else {
 			printk(KERN_INFO "pmac_zilog: serial modem detected\n");
 		}
diff --git a/drivers/video/controlfb.c b/drivers/video/controlfb.c
index fd60dba..8b76273 100644
--- a/drivers/video/controlfb.c
+++ b/drivers/video/controlfb.c
@@ -179,12 +179,14 @@ MODULE_LICENSE("GPL");
 int init_module(void)
 {
 	struct device_node *dp;
+	int ret = -ENXIO;
 
-	dp = find_devices("control");
+	dp = of_find_node_by_name(NULL, "control");
 	if (dp != 0 && !control_of_init(dp))
-		return 0;
+		ret = 0;
+	of_node_put(dp);
 
-	return -ENXIO;
+	return ret;
 }
 
 void cleanup_module(void)
@@ -589,16 +591,18 @@ static int __init control_init(void)
 {
 	struct device_node *dp;
 	char *option = NULL;
+	int ret = -ENXIO;
 
 	if (fb_get_options("controlfb", &option))
 		return -ENODEV;
 	control_setup(option);
 
-	dp = find_devices("control");
+	dp = of_find_node_by_name(NULL, "control");
 	if (dp != 0 && !control_of_init(dp))
-		return 0;
+		ret = 0;
+	of_node_put(dp);
 
-	return -ENXIO;
+	return ret;
 }
 
 module_init(control_init);
diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
index 052b613..73ceade 100644
--- a/include/asm-powerpc/prom.h
+++ b/include/asm-powerpc/prom.h
@@ -111,9 +111,6 @@ static inline void set_node_proc_entry(struct device_node *dn, struct proc_dir_e
 }
 
 
-/* OBSOLETE: Old style node lookup */
-extern struct device_node *find_devices(const char *name);
-
 /* New style node lookup */
 extern struct device_node *of_find_node_by_name(struct device_node *from,
 	const char *name);
diff --git a/sound/oss/dmasound/dmasound_awacs.c b/sound/oss/dmasound/dmasound_awacs.c
index 977b91c..730fa1d 100644
--- a/sound/oss/dmasound/dmasound_awacs.c
+++ b/sound/oss/dmasound/dmasound_awacs.c
@@ -346,14 +346,16 @@ int gpio_headphone_irq;
 int
 setup_audio_gpio(const char *name, const char* compatible, int *gpio_addr, int* gpio_pol)
 {
+	struct device_node *gpiop;
 	struct device_node *np;
 	const u32* pp;
+	int ret = -ENODEV;
 
-	np = find_devices("gpio");
-	if (!np)
-		return -ENODEV;
+	gpiop = of_find_node_by_name(NULL, "gpio");
+	if (!gpiop)
+		goto done;
 
-	np = np->child;
+	np = of_get_next_child(gpiop, NULL);
 	while(np != 0) {
 		if (name) {
 			const char *property =
@@ -362,20 +364,24 @@ setup_audio_gpio(const char *name, const char* compatible, int *gpio_addr, int*
 				break;
 		} else if (compatible && device_is_compatible(np, compatible))
 			break;
-		np = np->sibling;
+		np = of_get_next_child(gpiop, np);
 	}
 	if (!np)
-		return -ENODEV;
+		goto done;
 	pp = of_get_property(np, "AAPL,address", NULL);
 	if (!pp)
-		return -ENODEV;
+		goto done;
 	*gpio_addr = (*pp) & 0x0000ffff;
 	pp = of_get_property(np, "audio-gpio-active-state", NULL);
 	if (pp)
 		*gpio_pol = *pp;
 	else
 		*gpio_pol = 1;
-	return irq_of_parse_and_map(np, 0);
+	ret = irq_of_parse_and_map(np, 0);
+done:
+	of_node_put(np);
+	of_node_put(gpiop);
+	return ret;
 }
 
 static inline void
@@ -2552,32 +2558,33 @@ set_model(void)
 static struct device_node* __init
 get_snd_io_node(void)
 {
-	struct device_node *np = NULL;
+	struct device_node *np;
 
 	/* set up awacs_node for early OF which doesn't have a full set of
 	 * properties on davbus
-	*/
-
-	awacs_node = find_devices("awacs");
+	 */
+	awacs_node = of_find_node_by_name(NULL, "awacs");
 	if (awacs_node)
 		awacs_revision = AWACS_AWACS;
 
 	/* powermac models after 9500 (other than those which use DACA or
 	 * Tumbler) have a node called "davbus".
 	 */
-	np = find_devices("davbus");
+	np = of_find_node_by_name(NULL, "davbus");
 	/*
 	 * if we didn't find a davbus device, try 'i2s-a' since
 	 * this seems to be what iBooks (& Tumbler) have.
 	 */
-	if (np == NULL)
-		np = i2s_node = find_devices("i2s-a");
+	if (np == NULL) {
+		i2s_node = of_find_node_by_name(NULL, "i2s-a");
+		np = of_node_get(i2s_node);
+	}
 
 	/* if we didn't find this - perhaps we are on an early model
 	 * which _only_ has an 'awacs' node
 	*/
 	if (np == NULL && awacs_node)
-		np = awacs_node ;
+		np = of_node_get(awacs_node);
 
 	/* if we failed all these return null - this will cause the
 	 * driver to give up...
@@ -2596,9 +2603,9 @@ get_snd_info_node(struct device_node *io)
 {
 	struct device_node *info;
 
-	info = find_devices("sound");
-	while (info && info->parent != io)
-		info = info->next;
+	for_each_node_by_name(info, "sound")
+		if (info->parent == io)
+			break;
 	return info;
 }
 
@@ -2634,11 +2641,17 @@ get_codec_type(struct device_node *info)
 static void __init
 get_expansion_type(void)
 {
-	if (find_devices("perch") != NULL)
+	struct device_node *dn;
+
+	dn = of_find_node_by_name(NULL, "perch");
+	if (dn != NULL)
 		has_perch = 1;
+	of_node_put(dn);
 
-	if (find_devices("pb-ziva-pc") != NULL)
+	dn = of_find_node_by_name(NULL, "pb-ziva-pc");
+	if (dn != NULL)
 		has_ziva = 1;
+	of_node_put(dn);
 	/* need to work out how we deal with iMac SRS module */
 }
 
@@ -2827,7 +2840,7 @@ int __init dmasound_awacs_init(void)
 #ifdef DEBUG_DMASOUND
 printk("dmasound_pmac: couldn't find sound io OF node\n");
 #endif
-		return -ENODEV ;
+		goto no_device;
 	}
 
 	/* find the OF node that tells us about the sound sub-system
@@ -2839,7 +2852,7 @@ printk("dmasound_pmac: couldn't find sound io OF node\n");
 #ifdef DEBUG_DMASOUND
 printk("dmasound_pmac: couldn't find 'sound' OF node\n");
 #endif
-			return -ENODEV ;
+			goto no_device;
 		}
 	}
 
@@ -2848,7 +2861,7 @@ printk("dmasound_pmac: couldn't find 'sound' OF node\n");
 #ifdef DEBUG_DMASOUND
 printk("dmasound_pmac: couldn't find a Codec we can handle\n");
 #endif
-		return -ENODEV ; /* we don't know this type of h/w */
+		goto no_device; /* we don't know this type of h/w */
 	}
 
 	/* set up perch, ziva, SRS or whatever else we have as sound
@@ -2866,11 +2879,12 @@ printk("dmasound_pmac: couldn't find a Codec we can handle\n");
 		 * machines).
 		 */
 		if (awacs_node) {
-			io = awacs_node ;
+			of_node_put(io);
+			io = of_node_get(awacs_node);
 			if (of_get_address(io, 2, NULL, NULL) == NULL) {
 				printk("dmasound_pmac: can't use %s\n",
 				       io->full_name);
-				return -ENODEV;
+				goto no_device;
 			}
 		} else
 			printk("dmasound_pmac: can't use %s\n", io->full_name);
@@ -2881,7 +2895,7 @@ printk("dmasound_pmac: couldn't find a Codec we can handle\n");
 			       awacs_rsrc[0].end - awacs_rsrc[0].start + 1,
 			       " (IO)") == NULL) {
 		printk(KERN_ERR "dmasound: can't request IO resource !\n");
-		return -ENODEV;
+		goto no_device;
 	}
 	if (of_address_to_resource(io, 1, &awacs_rsrc[1]) ||
 	    request_mem_region(awacs_rsrc[1].start,
@@ -2890,7 +2904,7 @@ printk("dmasound_pmac: couldn't find a Codec we can handle\n");
 		release_mem_region(awacs_rsrc[0].start,
 				   awacs_rsrc[0].end - awacs_rsrc[0].start + 1);
 		printk(KERN_ERR "dmasound: can't request Tx DMA resource !\n");
-		return -ENODEV;
+		goto no_device;
 	}
 	if (of_address_to_resource(io, 2, &awacs_rsrc[2]) ||
 	    request_mem_region(awacs_rsrc[2].start,
@@ -2901,7 +2915,7 @@ printk("dmasound_pmac: couldn't find a Codec we can handle\n");
 		release_mem_region(awacs_rsrc[1].start,
 				   awacs_rsrc[1].end - awacs_rsrc[1].start + 1);
 		printk(KERN_ERR "dmasound: can't request Rx DMA resource !\n");
-		return -ENODEV;
+		goto no_device;
 	}
 
 	awacs_beep_dev = input_allocate_device();
@@ -2913,7 +2927,7 @@ printk("dmasound_pmac: couldn't find a Codec we can handle\n");
 		release_mem_region(awacs_rsrc[2].start,
 				   awacs_rsrc[2].end - awacs_rsrc[2].start + 1);
 		printk(KERN_ERR "dmasound: can't allocate input device !\n");
-		return -ENOMEM;
+		goto no_device;
 	}
 
 	awacs_beep_dev->name = "dmasound beeper";
@@ -2941,7 +2955,8 @@ printk("dmasound_pmac: couldn't find a Codec we can handle\n");
 	awacs_rx_irq = irq_of_parse_and_map(io, 2);
 
 	/* Hack for legacy crap that will be killed someday */
-	awacs_node = io;
+	of_node_put(awacs_node);
+	awacs_node = of_node_get(io);
 
 	/* if we have an awacs or screamer - probe the chip to make
 	 * sure we have the right revision.
@@ -2990,6 +3005,8 @@ printk("dmasound_pmac: Awacs/Screamer Codec Mfct: %d Rev %d\n", mfg, rev);
 
 		/* if it's there use it to set up frame rates */
 		init_frame_rates(prop, l) ;
+		of_node_put(info);
+		info = NULL;
 	}
 
 	if (awacs)
@@ -3159,7 +3176,16 @@ printk("dmasound_pmac: Awacs/Screamer Codec Mfct: %d Rev %d\n", mfg, rev);
 	 */
 	input_register_device(awacs_beep_dev);
 
+	of_node_put(io);
+
 	return dmasound_init();
+
+no_device:
+	of_node_put(info);
+	of_node_put(awacs_node);
+	of_node_put(i2s_node);
+	of_node_put(io);
+	return -ENODEV ;
 }
 
 static void __exit dmasound_awacs_cleanup(void)
@@ -3178,6 +3204,8 @@ static void __exit dmasound_awacs_cleanup(void)
 	}
 	dmasound_deinit();
 
+	of_node_put(awacs_node);
+	of_node_put(i2s_node);
 }
 
 MODULE_DESCRIPTION("PowerMac built-in audio driver.");
diff --git a/sound/oss/dmasound/tas_common.c b/sound/oss/dmasound/tas_common.c
index 1125760..b295ef6 100644
--- a/sound/oss/dmasound/tas_common.c
+++ b/sound/oss/dmasound/tas_common.c
@@ -41,7 +41,6 @@
 
 static u8 tas_i2c_address = 0x34;
 static struct i2c_client *tas_client;
-static struct device_node* tas_node;
 
 static int tas_attach_adapter(struct i2c_adapter *);
 static int tas_detach_client(struct i2c_client *);
@@ -191,13 +190,14 @@ int __init
 tas_init(int driver_id, const char *driver_name)
 {
 	const u32* paddr;
+	struct device_node *tas_node;
 
 	printk(KERN_INFO "tas driver [%s])\n", driver_name);
 
 #ifndef CONFIG_I2C_POWERMAC
 	request_module("i2c-powermac");
 #endif
-	tas_node = find_devices("deq");
+	tas_node = of_find_node_by_name("deq");
 	if (tas_node == NULL)
 		return -ENODEV;
 	paddr = of_get_property(tas_node, "i2c-address", NULL);
@@ -208,6 +208,7 @@ tas_init(int driver_id, const char *driver_name)
 	} else    
 		printk(KERN_INFO "using i2c address: 0x%x (default)\n",
 				tas_i2c_address);
+	of_node_put(tas_node);
 
 	return i2c_add_driver(&tas_driver);
 }
diff --git a/sound/ppc/pmac.c b/sound/ppc/pmac.c
index 5e82968..2bae9c1 100644
--- a/sound/ppc/pmac.c
+++ b/sound/ppc/pmac.c
@@ -816,6 +816,7 @@ static int snd_pmac_free(struct snd_pmac *chip)
 
 	if (chip->pdev)
 		pci_dev_put(chip->pdev);
+	of_node_put(chip->node);
 	kfree(chip);
 	return 0;
 }
@@ -863,7 +864,8 @@ static void __init detect_byte_swap(struct snd_pmac *chip)
  */
 static int __init snd_pmac_detect(struct snd_pmac *chip)
 {
-	struct device_node *sound = NULL;
+	struct device_node *sound;
+	struct device_node *dn;
 	const unsigned int *prop;
 	unsigned int l;
 	struct macio_chip* macio;
@@ -891,22 +893,21 @@ static int __init snd_pmac_detect(struct snd_pmac *chip)
 	else if (machine_is_compatible("PowerBook1,1")
 		 || machine_is_compatible("AAPL,PowerBook1998"))
 		chip->is_pbook_G3 = 1;
-	chip->node = find_devices("awacs");
-	if (chip->node)
-		sound = chip->node;
+	chip->node = of_find_node_by_name(NULL, "awacs");
+	sound = of_node_get(chip->node);
 
 	/*
 	 * powermac G3 models have a node called "davbus"
 	 * with a child called "sound".
 	 */
 	if (!chip->node)
-		chip->node = find_devices("davbus");
+		chip->node = of_find_node_by_name(NULL, "davbus");
 	/*
 	 * if we didn't find a davbus device, try 'i2s-a' since
 	 * this seems to be what iBooks have
 	 */
 	if (! chip->node) {
-		chip->node = find_devices("i2s-a");
+		chip->node = of_find_node_by_name(NULL, "i2s-a");
 		if (chip->node && chip->node->parent &&
 		    chip->node->parent->parent) {
 			if (device_is_compatible(chip->node->parent->parent,
@@ -918,12 +919,14 @@ static int __init snd_pmac_detect(struct snd_pmac *chip)
 		return -ENODEV;
 
 	if (!sound) {
-		sound = find_devices("sound");
+		sound = of_find_node_by_name(NULL, "sound");
 		while (sound && sound->parent != chip->node)
-			sound = sound->next;
+			sound = of_find_node_by_name(sound, "sound");
 	}
-	if (! sound)
+	if (! sound) {
+		of_node_put(chip->node);
 		return -ENODEV;
+	}
 	prop = of_get_property(sound, "sub-frame", NULL);
 	if (prop && *prop < 16)
 		chip->subframe = *prop;
@@ -934,6 +937,7 @@ static int __init snd_pmac_detect(struct snd_pmac *chip)
 		printk(KERN_INFO "snd-powermac no longer handles any "
 				 "machines with a layout-id property "
 				 "in the device-tree, use snd-aoa.\n");
+		of_node_put(chip->node);
 		return -ENODEV;
 	}
 	/* This should be verified on older screamers */
@@ -971,7 +975,9 @@ static int __init snd_pmac_detect(struct snd_pmac *chip)
 	prop = of_get_property(sound, "device-id", NULL);
 	if (prop)
 		chip->device_id = *prop;
-	chip->has_iic = (find_devices("perch") != NULL);
+	dn = of_find_node_by_name(NULL, "perch");
+	chip->has_iic = (dn != NULL);
+	of_node_put(dn);
 
 	/* We need the PCI device for DMA allocations, let's use a crude method
 	 * for now ...
@@ -1021,6 +1027,7 @@ static int __init snd_pmac_detect(struct snd_pmac *chip)
 		chip->freqs_ok = 1;
 	}
 
+	of_node_put(sound);
 	return 0;
 }
 
diff --git a/sound/ppc/tumbler.c b/sound/ppc/tumbler.c
index 8e01b55..54e333f 100644
--- a/sound/ppc/tumbler.c
+++ b/sound/ppc/tumbler.c
@@ -1031,32 +1031,40 @@ static irqreturn_t headphone_intr(int irq, void *devid)
 /* look for audio-gpio device */
 static struct device_node *find_audio_device(const char *name)
 {
+	struct device_node *gpiop;
 	struct device_node *np;
   
-	if (! (np = find_devices("gpio")))
+	gpiop = of_find_node_by_name(NULL, "gpio");
+	if (! gpiop)
 		return NULL;
   
-	for (np = np->child; np; np = np->sibling) {
+	for (np = of_get_next_child(gpiop, NULL); np;
+			np = of_get_next_child(gpiop, np)) {
 		const char *property = of_get_property(np, "audio-gpio", NULL);
 		if (property && strcmp(property, name) == 0)
-			return np;
+			break;
 	}  
-	return NULL;
+	of_node_put(gpiop);
+	return np;
 }
 
 /* look for audio-gpio device */
 static struct device_node *find_compatible_audio_device(const char *name)
 {
+	struct device_node *gpiop;
 	struct device_node *np;
   
-	if (! (np = find_devices("gpio")))
+	gpiop = of_find_node_by_name(NULL, "gpio");
+	if (!gpiop)
 		return NULL;
   
-	for (np = np->child; np; np = np->sibling) {
+	for (np = of_get_next_child(gpiop, NULL); np;
+			np = of_get_next_child(gpiop, np)) {
 		if (device_is_compatible(np, name))
-			return np;
+			break;
 	}  
-	return NULL;
+	of_node_put(gpiop);
+	return np;
 }
 
 /* find an audio device and get its address */
@@ -1066,6 +1074,7 @@ static long tumbler_find_device(const char *device, const char *platform,
 	struct device_node *node;
 	const u32 *base;
 	u32 addr;
+	long ret;
 
 	if (is_compatible)
 		node = find_compatible_audio_device(device);
@@ -1083,6 +1092,7 @@ static long tumbler_find_device(const char *device, const char *platform,
 		if (!base) {
 			DBG("(E) cannot find address for device %s !\n", device);
 			snd_printd("cannot find address for device %s\n", device);
+			of_node_put(node);
 			return -ENODEV;
 		}
 		addr = *base;
@@ -1124,7 +1134,9 @@ static long tumbler_find_device(const char *device, const char *platform,
 	DBG("(I) GPIO device %s found, offset: %x, active state: %d !\n",
 	    device, gp->addr, gp->active_state);
 
-	return irq_of_parse_and_map(node, 0);
+	ret = irq_of_parse_and_map(node, 0);
+	of_node_put(node);
+	return ret;
 }
 
 /* reset audio */
@@ -1342,9 +1354,9 @@ int __init snd_pmac_tumbler_init(struct snd_pmac *chip)
 		return err;
 
 	/* set up TAS */
-	tas_node = find_devices("deq");
+	tas_node = of_find_node_by_name(NULL, "deq");
 	if (tas_node == NULL)
-		tas_node = find_devices("codec");
+		tas_node = of_find_node_by_name(NULL, "codec");
 	if (tas_node == NULL)
 		return -ENODEV;
 
@@ -1355,6 +1367,7 @@ int __init snd_pmac_tumbler_init(struct snd_pmac *chip)
 		mix->i2c.addr = (*paddr) >> 1;
 	else
 		mix->i2c.addr = TAS_I2C_ADDR;
+	of_node_put(tas_node);
 
 	DBG("(I) TAS i2c address is: %x\n", mix->i2c.addr);
 
-- 
1.5.1.1

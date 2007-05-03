Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 44469DE017
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 17:26:54 +1000 (EST)
Date: Thu, 3 May 2007 17:26:52 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] Rename device_is_compatible to of_device_is_compatible
Message-Id: <20070503172652.e5ac6314.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

for consistency with other Open Firmware interfaces (and Sparc).

This is just a straight replacement.

This leaves the compatibility define in place.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/legacy_serial.c         |   14 ++++++------
 arch/powerpc/kernel/of_device.c             |    2 +-
 arch/powerpc/kernel/vio.c                   |    2 +-
 arch/powerpc/platforms/85xx/mpc8544_ds.c    |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx_cds.c   |    2 +-
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c  |    2 +-
 arch/powerpc/platforms/cell/interrupt.c     |    6 ++--
 arch/powerpc/platforms/cell/setup.c         |    2 +-
 arch/powerpc/platforms/cell/spider-pic.c    |    4 +-
 arch/powerpc/platforms/chrp/pci.c           |    2 +-
 arch/powerpc/platforms/chrp/setup.c         |    2 +-
 arch/powerpc/platforms/maple/pci.c          |   12 +++++-----
 arch/powerpc/platforms/maple/setup.c        |    2 +-
 arch/powerpc/platforms/pasemi/setup.c       |    2 +-
 arch/powerpc/platforms/powermac/feature.c   |   26 +++++++++++-----------
 arch/powerpc/platforms/powermac/low_i2c.c   |    2 +-
 arch/powerpc/platforms/powermac/nvram.c     |    4 +-
 arch/powerpc/platforms/powermac/pci.c       |   30 +++++++++++++-------------
 arch/powerpc/platforms/powermac/pic.c       |    2 +-
 arch/powerpc/platforms/powermac/setup.c     |    4 +-
 arch/powerpc/platforms/powermac/smp.c       |    6 ++--
 arch/powerpc/platforms/pseries/lpar.c       |    4 +-
 arch/powerpc/platforms/pseries/setup.c      |    2 +-
 arch/powerpc/platforms/pseries/xics.c       |    4 +-
 arch/powerpc/sysdev/uic.c                   |    2 +-
 drivers/char/hvc_iseries.c                  |    2 +-
 drivers/char/hvc_vio.c                      |    2 +-
 drivers/char/tpm/tpm_atmel.h                |    2 +-
 drivers/hwmon/ams/ams-core.c                |    4 +-
 drivers/ide/pci/pdc202xx_new.c              |    2 +-
 drivers/ide/ppc/pmac.c                      |   14 ++++++------
 drivers/macintosh/smu.c                     |    2 +-
 drivers/macintosh/therm_adt746x.c           |    4 +-
 drivers/macintosh/via-pmu.c                 |   10 ++++----
 drivers/macintosh/windfarm_lm75_sensor.c    |    4 +-
 drivers/macintosh/windfarm_max6690_sensor.c |    2 +-
 drivers/macintosh/windfarm_smu_controls.c   |    2 +-
 drivers/macintosh/windfarm_smu_sat.c        |    2 +-
 drivers/serial/pmac_zilog.c                 |    2 +-
 drivers/usb/host/ohci-ppc-of.c              |    4 +-
 drivers/video/offb.c                        |    4 +-
 sound/aoa/codecs/snd-aoa-codec-onyx.c       |    4 +-
 sound/aoa/codecs/snd-aoa-codec-tas.c        |    2 +-
 sound/aoa/soundbus/i2sbus/i2sbus-core.c     |    4 +-
 sound/oss/dmasound/dmasound_awacs.c         |   16 +++++++-------
 sound/ppc/pmac.c                            |   14 ++++++------
 sound/ppc/tumbler.c                         |    2 +-
 47 files changed, 123 insertions(+), 123 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index 63dd2c3..662cd67 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -243,9 +243,9 @@ static int __init add_legacy_pci_port(struct device_node *np,
 	 * doesn't work for these settings, you'll have to add your own special
 	 * cases here
 	 */
-	if (device_is_compatible(pci_dev, "pci13a8,152") ||
-	    device_is_compatible(pci_dev, "pci13a8,154") ||
-	    device_is_compatible(pci_dev, "pci13a8,158")) {
+	if (of_device_is_compatible(pci_dev, "pci13a8,152") ||
+	    of_device_is_compatible(pci_dev, "pci13a8,154") ||
+	    of_device_is_compatible(pci_dev, "pci13a8,158")) {
 		addr += 0x200 * lindex;
 		base += 0x200 * lindex;
 	} else {
@@ -364,11 +364,11 @@ void __init find_legacy_serial_ports(void)
 		/* Check for known pciclass, and also check wether we have
 		 * a device with child nodes for ports or not
 		 */
-		if (device_is_compatible(np, "pciclass,0700") ||
-		    device_is_compatible(np, "pciclass,070002"))
+		if (of_device_is_compatible(np, "pciclass,0700") ||
+		    of_device_is_compatible(np, "pciclass,070002"))
 			pci = np;
-		else if (device_is_compatible(parent, "pciclass,0700") ||
-			 device_is_compatible(parent, "pciclass,070002"))
+		else if (of_device_is_compatible(parent, "pciclass,0700") ||
+			 of_device_is_compatible(parent, "pciclass,070002"))
 			pci = parent;
 		else {
 			of_node_put(parent);
diff --git a/arch/powerpc/kernel/of_device.c b/arch/powerpc/kernel/of_device.c
index 0c8ea76..e2c765f 100644
--- a/arch/powerpc/kernel/of_device.c
+++ b/arch/powerpc/kernel/of_device.c
@@ -27,7 +27,7 @@ const struct of_device_id *of_match_node(const struct of_device_id *matches,
 			match &= node->type
 				&& !strcmp(matches->type, node->type);
 		if (matches->compatible[0])
-			match &= device_is_compatible(node,
+			match &= of_device_is_compatible(node,
 						      matches->compatible);
 		if (match)
 			return matches;
diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index 9eaefac..ec87106 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -117,7 +117,7 @@ static const struct vio_device_id *vio_match_device(
 {
 	while (ids->type[0] != '\0') {
 		if ((strncmp(dev->type, ids->type, strlen(ids->type)) == 0) &&
-		    device_is_compatible(dev->dev.archdata.of_node,
+		    of_device_is_compatible(dev->dev.archdata.of_node,
 					 ids->compat))
 			return ids;
 		ids++;
diff --git a/arch/powerpc/platforms/85xx/mpc8544_ds.c b/arch/powerpc/platforms/85xx/mpc8544_ds.c
index 2867f85..bec84ff 100644
--- a/arch/powerpc/platforms/85xx/mpc8544_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc8544_ds.c
@@ -84,7 +84,7 @@ void __init mpc8544_ds_pic_init(void)
 #ifdef CONFIG_PPC_I8259
 	/* Initialize the i8259 controller */
 	for_each_node_by_type(np, "interrupt-controller")
-	    if (device_is_compatible(np, "chrp,iic")) {
+	    if (of_device_is_compatible(np, "chrp,iic")) {
 		cascade_node = np;
 		break;
 	}
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 7e71636..1490eb3 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -197,7 +197,7 @@ static void __init mpc85xx_cds_pic_init(void)
 #ifdef CONFIG_PPC_I8259
 	/* Initialize the i8259 controller */
 	for_each_node_by_type(np, "interrupt-controller")
-		if (device_is_compatible(np, "chrp,iic")) {
+		if (of_device_is_compatible(np, "chrp,iic")) {
 			cascade_node = np;
 			break;
 		}
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index 3d3d98f..9087756 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -102,7 +102,7 @@ mpc86xx_hpcn_init_irq(void)
 #ifdef CONFIG_PCI
 	/* Initialize i8259 controller */
 	for_each_node_by_type(np, "interrupt-controller")
-		if (device_is_compatible(np, "chrp,iic")) {
+		if (of_device_is_compatible(np, "chrp,iic")) {
 			cascade_node = np;
 			break;
 		}
diff --git a/arch/powerpc/platforms/cell/interrupt.c b/arch/powerpc/platforms/cell/interrupt.c
index 4fc4e92..47264e7 100644
--- a/arch/powerpc/platforms/cell/interrupt.c
+++ b/arch/powerpc/platforms/cell/interrupt.c
@@ -227,7 +227,7 @@ void iic_request_IPIs(void)
 
 static int iic_host_match(struct irq_host *h, struct device_node *node)
 {
-	return device_is_compatible(node,
+	return of_device_is_compatible(node,
 				    "IBM,CBEA-Internal-Interrupt-Controller");
 }
 
@@ -256,7 +256,7 @@ static int iic_host_xlate(struct irq_host *h, struct device_node *ct,
 	unsigned int node, ext, unit, class;
 	const u32 *val;
 
-	if (!device_is_compatible(ct,
+	if (!of_device_is_compatible(ct,
 				     "IBM,CBEA-Internal-Interrupt-Controller"))
 		return -ENODEV;
 	if (intsize != 1)
@@ -324,7 +324,7 @@ static int __init setup_iic(void)
 
 	for (dn = NULL;
 	     (dn = of_find_node_by_name(dn,"interrupt-controller")) != NULL;) {
-		if (!device_is_compatible(dn,
+		if (!of_device_is_compatible(dn,
 				     "IBM,CBEA-Internal-Interrupt-Controller"))
 			continue;
 		np = of_get_property(dn, "ibm,interrupt-server-ranges", NULL);
diff --git a/arch/powerpc/platforms/cell/setup.c b/arch/powerpc/platforms/cell/setup.c
index 54b9618..db66542 100644
--- a/arch/powerpc/platforms/cell/setup.c
+++ b/arch/powerpc/platforms/cell/setup.c
@@ -112,7 +112,7 @@ static void __init mpic_init_IRQ(void)
 
 	for (dn = NULL;
 	     (dn = of_find_node_by_name(dn, "interrupt-controller"));) {
-		if (!device_is_compatible(dn, "CBEA,platform-open-pic"))
+		if (!of_device_is_compatible(dn, "CBEA,platform-open-pic"))
 			continue;
 
 		/* The MPIC driver will get everything it needs from the
diff --git a/arch/powerpc/platforms/cell/spider-pic.c b/arch/powerpc/platforms/cell/spider-pic.c
index fb1f157..05f4b3d 100644
--- a/arch/powerpc/platforms/cell/spider-pic.c
+++ b/arch/powerpc/platforms/cell/spider-pic.c
@@ -358,12 +358,12 @@ void __init spider_init_IRQ(void)
 	 */
 	for (dn = NULL;
 	     (dn = of_find_node_by_name(dn, "interrupt-controller"));) {
-		if (device_is_compatible(dn, "CBEA,platform-spider-pic")) {
+		if (of_device_is_compatible(dn, "CBEA,platform-spider-pic")) {
 			if (of_address_to_resource(dn, 0, &r)) {
 				printk(KERN_WARNING "spider-pic: Failed\n");
 				continue;
 			}
-		} else if (device_is_compatible(dn, "sti,platform-spider-pic")
+		} else if (of_device_is_compatible(dn, "sti,platform-spider-pic")
 			   && (chip < 2)) {
 			static long hard_coded_pics[] =
 				{ 0x24000008000ul, 0x34000008000ul};
diff --git a/arch/powerpc/platforms/chrp/pci.c b/arch/powerpc/platforms/chrp/pci.c
index 1469d64..d32fedc 100644
--- a/arch/powerpc/platforms/chrp/pci.c
+++ b/arch/powerpc/platforms/chrp/pci.c
@@ -267,7 +267,7 @@ chrp_find_bridges(void)
 		model = of_get_property(dev, "model", NULL);
 		if (model == NULL)
 			model = "<none>";
-		if (device_is_compatible(dev, "IBM,python")) {
+		if (of_device_is_compatible(dev, "IBM,python")) {
 			setup_python(hose, dev);
 		} else if (is_mot
 			   || strncmp(model, "Motorola, Grackle", 17) == 0) {
diff --git a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
index 1870038..373de4c 100644
--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -448,7 +448,7 @@ static void __init chrp_find_8259(void)
 
 	/* Look for cascade */
 	for_each_node_by_type(np, "interrupt-controller")
-		if (device_is_compatible(np, "chrp,iic")) {
+		if (of_device_is_compatible(np, "chrp,iic")) {
 			pic = np;
 			break;
 		}
diff --git a/arch/powerpc/platforms/maple/pci.c b/arch/powerpc/platforms/maple/pci.c
index b1d3b99..7aaa5bb 100644
--- a/arch/powerpc/platforms/maple/pci.c
+++ b/arch/powerpc/platforms/maple/pci.c
@@ -467,15 +467,15 @@ static int __init add_bridge(struct device_node *dev)
 	hose->last_busno = bus_range ? bus_range[1] : 0xff;
 
 	disp_name = NULL;
-	if (device_is_compatible(dev, "u3-agp")) {
+	if (of_device_is_compatible(dev, "u3-agp")) {
 		setup_u3_agp(hose);
 		disp_name = "U3-AGP";
 		primary = 0;
-	} else if (device_is_compatible(dev, "u3-ht")) {
+	} else if (of_device_is_compatible(dev, "u3-ht")) {
 		setup_u3_ht(hose);
 		disp_name = "U3-HT";
 		primary = 1;
-        } else if (device_is_compatible(dev, "u4-pcie")) {
+        } else if (of_device_is_compatible(dev, "u4-pcie")) {
                 setup_u4_pcie(hose);
                 disp_name = "U4-PCIE";
                 primary = 0;
@@ -556,12 +556,12 @@ void __init maple_pci_init(void)
 			continue;
 		if (strcmp(np->type, "pci") && strcmp(np->type, "ht"))
 			continue;
-		if ((device_is_compatible(np, "u4-pcie") ||
-		     device_is_compatible(np, "u3-agp")) &&
+		if ((of_device_is_compatible(np, "u4-pcie") ||
+		     of_device_is_compatible(np, "u3-agp")) &&
 		    add_bridge(np) == 0)
 			of_node_get(np);
 
-		if (device_is_compatible(np, "u3-ht")) {
+		if (of_device_is_compatible(np, "u3-ht")) {
 			of_node_get(np);
 			ht = np;
 		}
diff --git a/arch/powerpc/platforms/maple/setup.c b/arch/powerpc/platforms/maple/setup.c
index 2a30c5b..354c058 100644
--- a/arch/powerpc/platforms/maple/setup.c
+++ b/arch/powerpc/platforms/maple/setup.c
@@ -231,7 +231,7 @@ static void __init maple_init_IRQ(void)
 	 */
 
 	for_each_node_by_type(np, "interrupt-controller")
-		if (device_is_compatible(np, "open-pic")) {
+		if (of_device_is_compatible(np, "open-pic")) {
 			mpic_node = np;
 			break;
 		}
diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index 38bd903..38f107b 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -114,7 +114,7 @@ static __init void pas_init_IRQ(void)
 	mpic_node = NULL;
 
 	for_each_node_by_type(np, "interrupt-controller")
-		if (device_is_compatible(np, "open-pic")) {
+		if (of_device_is_compatible(np, "open-pic")) {
 			mpic_node = np;
 			break;
 		}
diff --git a/arch/powerpc/platforms/powermac/feature.c b/arch/powerpc/platforms/powermac/feature.c
index 52cfdd8..f29705f 100644
--- a/arch/powerpc/platforms/powermac/feature.c
+++ b/arch/powerpc/platforms/powermac/feature.c
@@ -1418,7 +1418,7 @@ static long g5_eth_phy_reset(struct device_node *node, long param, long value)
 	phy = of_get_next_child(node, NULL);
 	if (!phy)
 		return -ENODEV;
-	need_reset = device_is_compatible(phy, "B5221");
+	need_reset = of_device_is_compatible(phy, "B5221");
 	of_node_put(phy);
 	if (!need_reset)
 		return 0;
@@ -2624,7 +2624,7 @@ static void __init probe_one_macio(const char *name, const char *compat, int typ
 	for (node = NULL; (node = of_find_node_by_name(node, name)) != NULL;) {
 		if (!compat)
 			break;
-		if (device_is_compatible(node, compat))
+		if (of_device_is_compatible(node, compat))
 			break;
 	}
 	if (!node)
@@ -2728,7 +2728,7 @@ initial_serial_shutdown(struct device_node *np)
 	conn = of_get_property(np, "AAPL,connector", &len);
 	if (conn && (strcmp(conn, "infrared") == 0))
 		port_type = PMAC_SCC_IRDA;
-	else if (device_is_compatible(np, "cobalt"))
+	else if (of_device_is_compatible(np, "cobalt"))
 		modem = 1;
 	else if (slots && slots->count > 0) {
 		if (strcmp(slots->name, "IrDA") == 0)
@@ -2787,7 +2787,7 @@ set_initial_features(void)
 		 */
 		np = of_find_node_by_name(NULL, "ethernet");
 		while(np) {
-			if (device_is_compatible(np, "K2-GMAC"))
+			if (of_device_is_compatible(np, "K2-GMAC"))
 				g5_gmac_enable(np, 0, 1);
 			np = of_find_node_by_name(np, "ethernet");
 		}
@@ -2799,7 +2799,7 @@ set_initial_features(void)
 		 */
 		np = of_find_node_by_name(NULL, "firewire");
 		while(np) {
-			if (device_is_compatible(np, "pci106b,5811")) {
+			if (of_device_is_compatible(np, "pci106b,5811")) {
 				macio_chips[0].flags |= MACIO_FLAG_FW_SUPPORTED;
 				g5_fw_enable(np, 0, 1);
 			}
@@ -2817,8 +2817,8 @@ set_initial_features(void)
 		np = of_find_node_by_name(NULL, "ethernet");
 		while(np) {
 			if (np->parent
-			    && device_is_compatible(np->parent, "uni-north")
-			    && device_is_compatible(np, "gmac"))
+			    && of_device_is_compatible(np->parent, "uni-north")
+			    && of_device_is_compatible(np, "gmac"))
 				core99_gmac_enable(np, 0, 1);
 			np = of_find_node_by_name(np, "ethernet");
 		}
@@ -2831,10 +2831,10 @@ set_initial_features(void)
 		np = of_find_node_by_name(NULL, "firewire");
 		while(np) {
 			if (np->parent
-			    && device_is_compatible(np->parent, "uni-north")
-			    && (device_is_compatible(np, "pci106b,18") ||
-			        device_is_compatible(np, "pci106b,30") ||
-			        device_is_compatible(np, "pci11c1,5811"))) {
+			    && of_device_is_compatible(np->parent, "uni-north")
+			    && (of_device_is_compatible(np, "pci106b,18") ||
+			        of_device_is_compatible(np, "pci106b,30") ||
+			        of_device_is_compatible(np, "pci11c1,5811"))) {
 				macio_chips[0].flags |= MACIO_FLAG_FW_SUPPORTED;
 				core99_firewire_enable(np, 0, 1);
 			}
@@ -2845,8 +2845,8 @@ set_initial_features(void)
 		np = of_find_node_by_name(NULL, "ata-6");
 		while(np) {
 			if (np->parent
-			    && device_is_compatible(np->parent, "uni-north")
-			    && device_is_compatible(np, "kauai-ata")) {
+			    && of_device_is_compatible(np->parent, "uni-north")
+			    && of_device_is_compatible(np, "kauai-ata")) {
 				core99_ata100_enable(np, 1);
 			}
 			np = of_find_node_by_name(np, "ata-6");
diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
index 5430e14..3f507ab 100644
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -1207,7 +1207,7 @@ static void pmac_i2c_devscan(void (*callback)(struct device_node *dev,
 				if (strcmp(np->name, p->name))
 					continue;
 				if (p->compatible &&
-				    !device_is_compatible(np, p->compatible))
+				    !of_device_is_compatible(np, p->compatible))
 					continue;
 				if (p->quirks & pmac_i2c_quirk_skip)
 					break;
diff --git a/arch/powerpc/platforms/powermac/nvram.c b/arch/powerpc/platforms/powermac/nvram.c
index 692945c..c6f0f9e 100644
--- a/arch/powerpc/platforms/powermac/nvram.c
+++ b/arch/powerpc/platforms/powermac/nvram.c
@@ -553,7 +553,7 @@ static int __init core99_nvram_setup(struct device_node *dp, unsigned long addr)
 	 * identify the chip using flash id commands and base ourselves on
 	 * a list of known chips IDs
 	 */
-	if (device_is_compatible(dp, "amd-0137")) {
+	if (of_device_is_compatible(dp, "amd-0137")) {
 		core99_erase_bank = amd_erase_bank;
 		core99_write_bank = amd_write_bank;
 	} else {
@@ -588,7 +588,7 @@ int __init pmac_nvram_init(void)
 		}
 	}
 
-	is_core_99 = device_is_compatible(dp, "nvram,flash");
+	is_core_99 = of_device_is_compatible(dp, "nvram,flash");
 	if (is_core_99) {
 		err = core99_nvram_setup(dp, r1.start);
 		goto bail;
diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
index 22c4ae4..c4af9e2 100644
--- a/arch/powerpc/platforms/powermac/pci.c
+++ b/arch/powerpc/platforms/powermac/pci.c
@@ -934,15 +934,15 @@ static int __init add_bridge(struct device_node *dev)
 
 	/* 64 bits only bridges */
 #ifdef CONFIG_PPC64
-	if (device_is_compatible(dev, "u3-agp")) {
+	if (of_device_is_compatible(dev, "u3-agp")) {
 		setup_u3_agp(hose);
 		disp_name = "U3-AGP";
 		primary = 0;
-	} else if (device_is_compatible(dev, "u3-ht")) {
+	} else if (of_device_is_compatible(dev, "u3-ht")) {
 		setup_u3_ht(hose);
 		disp_name = "U3-HT";
 		primary = 1;
-	} else if (device_is_compatible(dev, "u4-pcie")) {
+	} else if (of_device_is_compatible(dev, "u4-pcie")) {
 		setup_u4_pcie(hose);
 		disp_name = "U4-PCIE";
 		primary = 0;
@@ -953,7 +953,7 @@ static int __init add_bridge(struct device_node *dev)
 
 	/* 32 bits only bridges */
 #ifdef CONFIG_PPC32
-	if (device_is_compatible(dev, "uni-north")) {
+	if (of_device_is_compatible(dev, "uni-north")) {
 		primary = setup_uninorth(hose, &rsrc);
 		disp_name = "UniNorth";
 	} else if (strcmp(dev->name, "pci") == 0) {
@@ -1129,21 +1129,21 @@ pmac_pci_enable_device_hook(struct pci_dev *dev, int initial)
 		return 0;
 
 	uninorth_child = node->parent &&
-		device_is_compatible(node->parent, "uni-north");
+		of_device_is_compatible(node->parent, "uni-north");
 
 	/* Firewire & GMAC were disabled after PCI probe, the driver is
 	 * claiming them, we must re-enable them now.
 	 */
 	if (uninorth_child && !strcmp(node->name, "firewire") &&
-	    (device_is_compatible(node, "pci106b,18") ||
-	     device_is_compatible(node, "pci106b,30") ||
-	     device_is_compatible(node, "pci11c1,5811"))) {
+	    (of_device_is_compatible(node, "pci106b,18") ||
+	     of_device_is_compatible(node, "pci106b,30") ||
+	     of_device_is_compatible(node, "pci11c1,5811"))) {
 		pmac_call_feature(PMAC_FTR_1394_CABLE_POWER, node, 0, 1);
 		pmac_call_feature(PMAC_FTR_1394_ENABLE, node, 0, 1);
 		updatecfg = 1;
 	}
 	if (uninorth_child && !strcmp(node->name, "ethernet") &&
-	    device_is_compatible(node, "gmac")) {
+	    of_device_is_compatible(node, "gmac")) {
 		pmac_call_feature(PMAC_FTR_GMAC_ENABLE, node, 0, 1);
 		updatecfg = 1;
 	}
@@ -1203,18 +1203,18 @@ void __init pmac_pcibios_after_init(void)
 #endif /* CONFIG_BLK_DEV_IDE */
 
 	for_each_node_by_name(nd, "firewire") {
-		if (nd->parent && (device_is_compatible(nd, "pci106b,18") ||
-				   device_is_compatible(nd, "pci106b,30") ||
-				   device_is_compatible(nd, "pci11c1,5811"))
-		    && device_is_compatible(nd->parent, "uni-north")) {
+		if (nd->parent && (of_device_is_compatible(nd, "pci106b,18") ||
+				   of_device_is_compatible(nd, "pci106b,30") ||
+				   of_device_is_compatible(nd, "pci11c1,5811"))
+		    && of_device_is_compatible(nd->parent, "uni-north")) {
 			pmac_call_feature(PMAC_FTR_1394_ENABLE, nd, 0, 0);
 			pmac_call_feature(PMAC_FTR_1394_CABLE_POWER, nd, 0, 0);
 		}
 	}
 	of_node_put(nd);
 	for_each_node_by_name(nd, "ethernet") {
-		if (nd->parent && device_is_compatible(nd, "gmac")
-		    && device_is_compatible(nd->parent, "uni-north"))
+		if (nd->parent && of_device_is_compatible(nd, "gmac")
+		    && of_device_is_compatible(nd->parent, "uni-north"))
 			pmac_call_feature(PMAC_FTR_GMAC_ENABLE, nd, 0, 0);
 	}
 	of_node_put(nd);
diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
index ae5097a..87cd680 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -364,7 +364,7 @@ static void __init pmac_pic_probe_oldstyle(void)
 		slave = of_find_node_by_name(master, "mac-io");
 
 		/* Check ordering of master & slave */
-		if (device_is_compatible(master, "gatwick")) {
+		if (of_device_is_compatible(master, "gatwick")) {
 			struct device_node *tmp;
 			BUG_ON(slave == NULL);
 			tmp = master;
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 5ae57e1..0fd3b2a 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -656,8 +656,8 @@ static int pmac_pci_probe_mode(struct pci_bus *bus)
 	/* We need to use normal PCI probing for the AGP bus,
 	 * since the device for the AGP bridge isn't in the tree.
 	 */
-	if (bus->self == NULL && (device_is_compatible(node, "u3-agp") ||
-				  device_is_compatible(node, "u4-pcie")))
+	if (bus->self == NULL && (of_device_is_compatible(node, "u3-agp") ||
+				  of_device_is_compatible(node, "u4-pcie")))
 		return PCI_PROBE_NORMAL;
 	return PCI_PROBE_DEVTREE;
 }
diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index 6f32c4e..23314a8 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -562,7 +562,7 @@ static void __init smp_core99_setup_i2c_hwsync(int ncpus)
 	/* Look for the clock chip */
 	while ((cc = of_find_node_by_name(cc, "i2c-hwclock")) != NULL) {
 		p = of_get_parent(cc);
-		ok = p && device_is_compatible(p, "uni-n-i2c");
+		ok = p && of_device_is_compatible(p, "uni-n-i2c");
 		of_node_put(p);
 		if (!ok)
 			continue;
@@ -575,11 +575,11 @@ static void __init smp_core99_setup_i2c_hwsync(int ncpus)
 			continue;
 		switch (*reg) {
 		case 0xd2:
-			if (device_is_compatible(cc,"pulsar-legacy-slewing")) {
+			if (of_device_is_compatible(cc,"pulsar-legacy-slewing")) {
 				pmac_tb_freeze = smp_core99_pulsar_tb_freeze;
 				pmac_tb_pulsar_addr = 0xd2;
 				name = "Pulsar";
-			} else if (device_is_compatible(cc, "cy28508")) {
+			} else if (of_device_is_compatible(cc, "cy28508")) {
 				pmac_tb_freeze = smp_core99_cypress_tb_freeze;
 				name = "Cypress";
 			}
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 3a70e8a..362dfbc 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -231,13 +231,13 @@ void __init find_udbg_vterm(void)
 		goto out;
 	vtermno = termno[0];
 
-	if (device_is_compatible(stdout_node, "hvterm1")) {
+	if (of_device_is_compatible(stdout_node, "hvterm1")) {
 		udbg_putc = udbg_putcLP;
 		udbg_getc = udbg_getcLP;
 		udbg_getc_poll = udbg_getc_pollLP;
 		if (add_console)
 			add_preferred_console("hvc", termno[0] & 0xff, NULL);
-	} else if (device_is_compatible(stdout_node, "hvterm-protocol")) {
+	} else if (of_device_is_compatible(stdout_node, "hvterm-protocol")) {
 		vtermno = termno[0];
 		udbg_putc = udbg_hvsi_putc;
 		udbg_getc = udbg_hvsi_getc;
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 33eec28..470db6e 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -168,7 +168,7 @@ static void __init pseries_mpic_init_IRQ(void)
 
 	/* Look for cascade */
 	for_each_node_by_type(np, "interrupt-controller")
-		if (device_is_compatible(np, "chrp,iic")) {
+		if (of_device_is_compatible(np, "chrp,iic")) {
 			cascade = np;
 			break;
 		}
diff --git a/arch/powerpc/platforms/pseries/xics.c b/arch/powerpc/platforms/pseries/xics.c
index 896cbf3..b854e7f 100644
--- a/arch/powerpc/platforms/pseries/xics.c
+++ b/arch/powerpc/platforms/pseries/xics.c
@@ -477,7 +477,7 @@ static int xics_host_match(struct irq_host *h, struct device_node *node)
 	 * like vdevices, events, etc... The trick we use here is to match
 	 * everything here except the legacy 8259 which is compatible "chrp,iic"
 	 */
-	return !device_is_compatible(node, "chrp,iic");
+	return !of_device_is_compatible(node, "chrp,iic");
 }
 
 static int xics_host_map_direct(struct irq_host *h, unsigned int virq,
@@ -618,7 +618,7 @@ static void __init xics_setup_8259_cascade(void)
 	unsigned long intack = 0;
 
 	for_each_node_by_type(np, "interrupt-controller")
-		if (device_is_compatible(np, "chrp,iic")) {
+		if (of_device_is_compatible(np, "chrp,iic")) {
 			found = np;
 			break;
 		}
diff --git a/arch/powerpc/sysdev/uic.c b/arch/powerpc/sysdev/uic.c
index 968fb40..8905989 100644
--- a/arch/powerpc/sysdev/uic.c
+++ b/arch/powerpc/sysdev/uic.c
@@ -221,7 +221,7 @@ static struct uic * __init uic_init_one(struct device_node *node)
 	const u32 *indexp, *dcrreg;
 	int len;
 
-	BUG_ON(! device_is_compatible(node, "ibm,uic"));
+	BUG_ON(! of_device_is_compatible(node, "ibm,uic"));
 
 	uic = alloc_bootmem(sizeof(*uic));
 	if (! uic)
diff --git a/drivers/char/hvc_iseries.c b/drivers/char/hvc_iseries.c
index ec420fe..b37f1d5 100644
--- a/drivers/char/hvc_iseries.c
+++ b/drivers/char/hvc_iseries.c
@@ -579,7 +579,7 @@ static int hvc_find_vtys(void)
 		if (!vtermno)
 			continue;
 
-		if (!device_is_compatible(vty, "IBM,iSeries-vty"))
+		if (!of_device_is_compatible(vty, "IBM,iSeries-vty"))
 			continue;
 
 		if (num_found == 0)
diff --git a/drivers/char/hvc_vio.c b/drivers/char/hvc_vio.c
index 94a542e..79711aa 100644
--- a/drivers/char/hvc_vio.c
+++ b/drivers/char/hvc_vio.c
@@ -157,7 +157,7 @@ static int hvc_find_vtys(void)
 		if (!vtermno)
 			continue;
 
-		if (device_is_compatible(vty, "hvterm1")) {
+		if (of_device_is_compatible(vty, "hvterm1")) {
 			hvc_instantiate(*vtermno, num_found, &hvc_get_put_ops);
 			++num_found;
 		}
diff --git a/drivers/char/tpm/tpm_atmel.h b/drivers/char/tpm/tpm_atmel.h
index 377bc60..c912d86 100644
--- a/drivers/char/tpm/tpm_atmel.h
+++ b/drivers/char/tpm/tpm_atmel.h
@@ -47,7 +47,7 @@ static void __iomem * atmel_get_base_addr(unsigned long *base, int *region_size)
 	if (!dn)
 		return NULL;
 
-	if (!device_is_compatible(dn, "AT97SC3201")) {
+	if (!of_device_is_compatible(dn, "AT97SC3201")) {
 		of_node_put(dn);
 		return NULL;
 	}
diff --git a/drivers/hwmon/ams/ams-core.c b/drivers/hwmon/ams/ams-core.c
index 93b963f..dbe6a32 100644
--- a/drivers/hwmon/ams/ams-core.c
+++ b/drivers/hwmon/ams/ams-core.c
@@ -208,14 +208,14 @@ int __init ams_init(void)
 
 #ifdef CONFIG_SENSORS_AMS_I2C
 	np = of_find_node_by_name(NULL, "accelerometer");
-	if (np && device_is_compatible(np, "AAPL,accelerometer_1"))
+	if (np && of_device_is_compatible(np, "AAPL,accelerometer_1"))
 		/* Found I2C motion sensor */
 		return ams_i2c_init(np);
 #endif
 
 #ifdef CONFIG_SENSORS_AMS_PMU
 	np = of_find_node_by_name(NULL, "sms");
-	if (np && device_is_compatible(np, "sms"))
+	if (np && of_device_is_compatible(np, "sms"))
 		/* Found PMU motion sensor */
 		return ams_pmu_init(np);
 #endif
diff --git a/drivers/ide/pci/pdc202xx_new.c b/drivers/ide/pci/pdc202xx_new.c
index ace9892..ae20fb3 100644
--- a/drivers/ide/pci/pdc202xx_new.c
+++ b/drivers/ide/pci/pdc202xx_new.c
@@ -398,7 +398,7 @@ static void __devinit apple_kiwi_init(struct pci_dev *pdev)
 	unsigned int class_rev = 0;
 	u8 conf;
 
-	if (np == NULL || !device_is_compatible(np, "kiwi-root"))
+	if (np == NULL || !of_device_is_compatible(np, "kiwi-root"))
 		return;
 
 	pci_read_config_dword(pdev, PCI_CLASS_REVISION, &class_rev);
diff --git a/drivers/ide/ppc/pmac.c b/drivers/ide/ppc/pmac.c
index 774bfd3..a49ebe4 100644
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1157,18 +1157,18 @@ pmac_ide_setup_device(pmac_ide_hwif_t *pmif, ide_hwif_t *hwif)
 
 	pmif->cable_80 = 0;
 	pmif->broken_dma = pmif->broken_dma_warn = 0;
-	if (device_is_compatible(np, "shasta-ata"))
+	if (of_device_is_compatible(np, "shasta-ata"))
 		pmif->kind = controller_sh_ata6;
-	else if (device_is_compatible(np, "kauai-ata"))
+	else if (of_device_is_compatible(np, "kauai-ata"))
 		pmif->kind = controller_un_ata6;
-	else if (device_is_compatible(np, "K2-UATA"))
+	else if (of_device_is_compatible(np, "K2-UATA"))
 		pmif->kind = controller_k2_ata6;
-	else if (device_is_compatible(np, "keylargo-ata")) {
+	else if (of_device_is_compatible(np, "keylargo-ata")) {
 		if (strcmp(np->name, "ata-4") == 0)
 			pmif->kind = controller_kl_ata4;
 		else
 			pmif->kind = controller_kl_ata3;
-	} else if (device_is_compatible(np, "heathrow-ata"))
+	} else if (of_device_is_compatible(np, "heathrow-ata"))
 		pmif->kind = controller_heathrow;
 	else {
 		pmif->kind = controller_ohare;
@@ -1190,8 +1190,8 @@ pmac_ide_setup_device(pmac_ide_hwif_t *pmif, ide_hwif_t *hwif)
 	 * they have a 80 conductor cable, this seem to be always the case unless
 	 * the user mucked around
 	 */
-	if (device_is_compatible(np, "K2-UATA") ||
-	    device_is_compatible(np, "shasta-ata"))
+	if (of_device_is_compatible(np, "K2-UATA") ||
+	    of_device_is_compatible(np, "shasta-ata"))
 		pmif->cable_80 = 1;
 
 	/* On Kauai-type controllers, we make sure the FCR is correct */
diff --git a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
index a98a328..f8e1a13 100644
--- a/drivers/macintosh/smu.c
+++ b/drivers/macintosh/smu.c
@@ -606,7 +606,7 @@ static void smu_expose_childs(struct work_struct *unused)
 	struct device_node *np;
 
 	for (np = NULL; (np = of_get_next_child(smu->of_node, np)) != NULL;)
-		if (device_is_compatible(np, "smu-sensors"))
+		if (of_device_is_compatible(np, "smu-sensors"))
 			of_platform_device_create(np, "smu-sensors",
 						  &smu->of_dev->dev);
 }
diff --git a/drivers/macintosh/therm_adt746x.c b/drivers/macintosh/therm_adt746x.c
index 2289034..178afa1 100644
--- a/drivers/macintosh/therm_adt746x.c
+++ b/drivers/macintosh/therm_adt746x.c
@@ -560,9 +560,9 @@ thermostat_init(void)
 	np = of_find_node_by_name(NULL, "fan");
 	if (!np)
 		return -ENODEV;
-	if (device_is_compatible(np, "adt7460"))
+	if (of_device_is_compatible(np, "adt7460"))
 		therm_type = ADT7460;
-	else if (device_is_compatible(np, "adt7467"))
+	else if (of_device_is_compatible(np, "adt7467"))
 		therm_type = ADT7467;
 	else
 		return -ENODEV;
diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 1729d3f..0707624 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -310,14 +310,14 @@ int __init find_via_pmu(void)
 			PMU_INT_TICK;
 	
 	if (vias->parent->name && ((strcmp(vias->parent->name, "ohare") == 0)
-	    || device_is_compatible(vias->parent, "ohare")))
+	    || of_device_is_compatible(vias->parent, "ohare")))
 		pmu_kind = PMU_OHARE_BASED;
-	else if (device_is_compatible(vias->parent, "paddington"))
+	else if (of_device_is_compatible(vias->parent, "paddington"))
 		pmu_kind = PMU_PADDINGTON_BASED;
-	else if (device_is_compatible(vias->parent, "heathrow"))
+	else if (of_device_is_compatible(vias->parent, "heathrow"))
 		pmu_kind = PMU_HEATHROW_BASED;
-	else if (device_is_compatible(vias->parent, "Keylargo")
-		 || device_is_compatible(vias->parent, "K2-Keylargo")) {
+	else if (of_device_is_compatible(vias->parent, "Keylargo")
+		 || of_device_is_compatible(vias->parent, "K2-Keylargo")) {
 		struct device_node *gpiop;
 		struct device_node *adbp;
 		u64 gaddr = OF_BAD_ADDR;
diff --git a/drivers/macintosh/windfarm_lm75_sensor.c b/drivers/macintosh/windfarm_lm75_sensor.c
index ab4d1b6..a0fabf3 100644
--- a/drivers/macintosh/windfarm_lm75_sensor.c
+++ b/drivers/macintosh/windfarm_lm75_sensor.c
@@ -188,10 +188,10 @@ static int wf_lm75_attach(struct i2c_adapter *adapter)
 		if (loc == NULL || addr == 0)
 			continue;
 		/* real lm75 */
-		if (device_is_compatible(dev, "lm75"))
+		if (of_device_is_compatible(dev, "lm75"))
 			wf_lm75_create(adapter, addr, 0, loc);
 		/* ds1775 (compatible, better resolution */
-		else if (device_is_compatible(dev, "ds1775"))
+		else if (of_device_is_compatible(dev, "ds1775"))
 			wf_lm75_create(adapter, addr, 1, loc);
 	}
 	return 0;
diff --git a/drivers/macintosh/windfarm_max6690_sensor.c b/drivers/macintosh/windfarm_max6690_sensor.c
index eaa74af..5f03aab 100644
--- a/drivers/macintosh/windfarm_max6690_sensor.c
+++ b/drivers/macintosh/windfarm_max6690_sensor.c
@@ -131,7 +131,7 @@ static int wf_max6690_attach(struct i2c_adapter *adapter)
 		 */
 		if (!pmac_i2c_match_adapter(dev, adapter))
 			continue;
-		if (!device_is_compatible(dev, "max6690"))
+		if (!of_device_is_compatible(dev, "max6690"))
 			continue;
 		addr = pmac_i2c_get_dev_addr(dev);
 		loc = of_get_property(dev, "hwsensor-location", NULL);
diff --git a/drivers/macintosh/windfarm_smu_controls.c b/drivers/macintosh/windfarm_smu_controls.c
index ff398ad..58c2590 100644
--- a/drivers/macintosh/windfarm_smu_controls.c
+++ b/drivers/macintosh/windfarm_smu_controls.c
@@ -263,7 +263,7 @@ static int __init smu_controls_init(void)
 	/* Look for RPM fans */
 	for (fans = NULL; (fans = of_get_next_child(smu, fans)) != NULL;)
 		if (!strcmp(fans->name, "rpm-fans") ||
-		    device_is_compatible(fans, "smu-rpm-fans"))
+		    of_device_is_compatible(fans, "smu-rpm-fans"))
 			break;
 	for (fan = NULL;
 	     fans && (fan = of_get_next_child(fans, fan)) != NULL;) {
diff --git a/drivers/macintosh/windfarm_smu_sat.c b/drivers/macintosh/windfarm_smu_sat.c
index 9a6c2cf..1043b39 100644
--- a/drivers/macintosh/windfarm_smu_sat.c
+++ b/drivers/macintosh/windfarm_smu_sat.c
@@ -380,7 +380,7 @@ static int wf_sat_attach(struct i2c_adapter *adapter)
 	busnode = pmac_i2c_get_bus_node(bus);
 
 	while ((dev = of_get_next_child(busnode, dev)) != NULL)
-		if (device_is_compatible(dev, "smu-sat"))
+		if (of_device_is_compatible(dev, "smu-sat"))
 			wf_sat_create(adapter, dev);
 	return 0;
 }
diff --git a/drivers/serial/pmac_zilog.c b/drivers/serial/pmac_zilog.c
index cd92a39..0fa9f67 100644
--- a/drivers/serial/pmac_zilog.c
+++ b/drivers/serial/pmac_zilog.c
@@ -1450,7 +1450,7 @@ no_dma:
 	/*
 	 * Detect port type
 	 */
-	if (device_is_compatible(np, "cobalt"))
+	if (of_device_is_compatible(np, "cobalt"))
 		uap->flags |= PMACZILOG_FLAG_IS_INTMODEM;
 	conn = of_get_property(np, "AAPL,connector", &len);
 	if (conn && (strcmp(conn, "infrared") == 0))
diff --git a/drivers/usb/host/ohci-ppc-of.c b/drivers/usb/host/ohci-ppc-of.c
index 08e237c..c43b66a 100644
--- a/drivers/usb/host/ohci-ppc-of.c
+++ b/drivers/usb/host/ohci-ppc-of.c
@@ -97,8 +97,8 @@ ohci_hcd_ppc_of_probe(struct of_device *op, const struct of_device_id *match)
 		return -ENODEV;
 
 	is_bigendian =
-		device_is_compatible(dn, "ohci-bigendian") ||
-		device_is_compatible(dn, "ohci-be");
+		of_device_is_compatible(dn, "ohci-bigendian") ||
+		of_device_is_compatible(dn, "ohci-be");
 
 	dev_dbg(&op->dev, "initializing PPC-OF USB Controller\n");
 
diff --git a/drivers/video/offb.c b/drivers/video/offb.c
index 3cf603c..885b428 100644
--- a/drivers/video/offb.c
+++ b/drivers/video/offb.c
@@ -322,8 +322,8 @@ static void __init offb_init_fb(const char *name, const char *full_name,
 			    ioremap(base + 0x7ff000, 0x1000) + 0xcc0;
 			par->cmap_data = par->cmap_adr + 1;
 			par->cmap_type = cmap_m64;
-		} else if (dp && (device_is_compatible(dp, "pci1014,b7") ||
-				  device_is_compatible(dp, "pci1014,21c"))) {
+		} else if (dp && (of_device_is_compatible(dp, "pci1014,b7") ||
+				  of_device_is_compatible(dp, "pci1014,21c"))) {
 			par->cmap_adr = offb_map_reg(dp, 0, 0x6000, 0x1000);
 			if (par->cmap_adr)
 				par->cmap_type = cmap_gxt2000;
diff --git a/sound/aoa/codecs/snd-aoa-codec-onyx.c b/sound/aoa/codecs/snd-aoa-codec-onyx.c
index 7f980be..e91f9f6 100644
--- a/sound/aoa/codecs/snd-aoa-codec-onyx.c
+++ b/sound/aoa/codecs/snd-aoa-codec-onyx.c
@@ -1061,7 +1061,7 @@ static int onyx_i2c_attach(struct i2c_adapter *adapter)
 	busnode = pmac_i2c_get_bus_node(bus);
 
 	while ((dev = of_get_next_child(busnode, dev)) != NULL) {
-		if (device_is_compatible(dev, "pcm3052")) {
+		if (of_device_is_compatible(dev, "pcm3052")) {
 			const u32 *addr;
 			printk(KERN_DEBUG PFX "found pcm3052\n");
 			addr = of_get_property(dev, "reg", NULL);
@@ -1074,7 +1074,7 @@ static int onyx_i2c_attach(struct i2c_adapter *adapter)
 	/* if that didn't work, try desperate mode for older
 	 * machines that have stuff missing from the device tree */
 	
-	if (!device_is_compatible(busnode, "k2-i2c"))
+	if (!of_device_is_compatible(busnode, "k2-i2c"))
 		return -ENODEV;
 
 	printk(KERN_DEBUG PFX "found k2-i2c, checking if onyx chip is on it\n");
diff --git a/sound/aoa/codecs/snd-aoa-codec-tas.c b/sound/aoa/codecs/snd-aoa-codec-tas.c
index ceca384..041fe52 100644
--- a/sound/aoa/codecs/snd-aoa-codec-tas.c
+++ b/sound/aoa/codecs/snd-aoa-codec-tas.c
@@ -938,7 +938,7 @@ static int tas_i2c_attach(struct i2c_adapter *adapter)
 	busnode = pmac_i2c_get_bus_node(bus);
 
 	while ((dev = of_get_next_child(busnode, dev)) != NULL) {
-		if (device_is_compatible(dev, "tas3004")) {
+		if (of_device_is_compatible(dev, "tas3004")) {
 			const u32 *addr;
 			printk(KERN_DEBUG PFX "found tas3004\n");
 			addr = of_get_property(dev, "reg", NULL);
diff --git a/sound/aoa/soundbus/i2sbus/i2sbus-core.c b/sound/aoa/soundbus/i2sbus/i2sbus-core.c
index 79fc4bc..0fccdbf 100644
--- a/sound/aoa/soundbus/i2sbus/i2sbus-core.c
+++ b/sound/aoa/soundbus/i2sbus/i2sbus-core.c
@@ -336,8 +336,8 @@ static int i2sbus_probe(struct macio_dev* dev, const struct of_device_id *match)
 	}
 
 	while ((np = of_get_next_child(dev->ofdev.node, np))) {
-		if (device_is_compatible(np, "i2sbus") ||
-		    device_is_compatible(np, "i2s-modem")) {
+		if (of_device_is_compatible(np, "i2sbus") ||
+		    of_device_is_compatible(np, "i2s-modem")) {
 			got += i2sbus_add_dev(dev, control, np);
 		}
 	}
diff --git a/sound/oss/dmasound/dmasound_awacs.c b/sound/oss/dmasound/dmasound_awacs.c
index 730fa1d..8f63880 100644
--- a/sound/oss/dmasound/dmasound_awacs.c
+++ b/sound/oss/dmasound/dmasound_awacs.c
@@ -362,7 +362,7 @@ setup_audio_gpio(const char *name, const char* compatible, int *gpio_addr, int*
 				of_get_property(np,"audio-gpio",NULL);
 			if (property != 0 && strcmp(property,name) == 0)
 				break;
-		} else if (compatible && device_is_compatible(np, compatible))
+		} else if (compatible && of_device_is_compatible(np, compatible))
 			break;
 		np = of_get_next_child(gpiop, np);
 	}
@@ -2620,17 +2620,17 @@ get_codec_type(struct device_node *info)
 
 	if (info) {
 		/* must do awacs first to allow screamer to overide it */
-		if (device_is_compatible(info, "awacs"))
+		if (of_device_is_compatible(info, "awacs"))
 			codec = AWACS_AWACS ;
-		if (device_is_compatible(info, "screamer"))
+		if (of_device_is_compatible(info, "screamer"))
 			codec = AWACS_SCREAMER;
-		if (device_is_compatible(info, "burgundy"))
+		if (of_device_is_compatible(info, "burgundy"))
 			codec = AWACS_BURGUNDY ;
-		if (device_is_compatible(info, "daca"))
+		if (of_device_is_compatible(info, "daca"))
 			codec = AWACS_DACA;
-		if (device_is_compatible(info, "tumbler"))
+		if (of_device_is_compatible(info, "tumbler"))
 			codec = AWACS_TUMBLER;
-		if (device_is_compatible(info, "snapper"))
+		if (of_device_is_compatible(info, "snapper"))
 			codec = AWACS_SNAPPER;
 	}
 	return codec ;
@@ -2772,7 +2772,7 @@ set_hw_byteswap(struct device_node *io)
 
 	for (mio = io->parent; mio ; mio = mio->parent) {
 		if (strcmp(mio->name, "mac-io") == 0) {
-			if (device_is_compatible(mio, "Keylargo"))
+			if (of_device_is_compatible(mio, "Keylargo"))
 				kl = 1;
 			break;
 		}
diff --git a/sound/ppc/pmac.c b/sound/ppc/pmac.c
index 2bae9c1..5a2bef4 100644
--- a/sound/ppc/pmac.c
+++ b/sound/ppc/pmac.c
@@ -843,7 +843,7 @@ static void __init detect_byte_swap(struct snd_pmac *chip)
 	/* if seems that Keylargo can't byte-swap  */
 	for (mio = chip->node->parent; mio; mio = mio->parent) {
 		if (strcmp(mio->name, "mac-io") == 0) {
-			if (device_is_compatible(mio, "Keylargo"))
+			if (of_device_is_compatible(mio, "Keylargo"))
 				chip->can_byte_swap = 0;
 			break;
 		}
@@ -910,7 +910,7 @@ static int __init snd_pmac_detect(struct snd_pmac *chip)
 		chip->node = of_find_node_by_name(NULL, "i2s-a");
 		if (chip->node && chip->node->parent &&
 		    chip->node->parent->parent) {
-			if (device_is_compatible(chip->node->parent->parent,
+			if (of_device_is_compatible(chip->node->parent->parent,
 						 "K2-Keylargo"))
 				chip->is_k2 = 1;
 		}
@@ -941,22 +941,22 @@ static int __init snd_pmac_detect(struct snd_pmac *chip)
 		return -ENODEV;
 	}
 	/* This should be verified on older screamers */
-	if (device_is_compatible(sound, "screamer")) {
+	if (of_device_is_compatible(sound, "screamer")) {
 		chip->model = PMAC_SCREAMER;
 		// chip->can_byte_swap = 0; /* FIXME: check this */
 	}
-	if (device_is_compatible(sound, "burgundy")) {
+	if (of_device_is_compatible(sound, "burgundy")) {
 		chip->model = PMAC_BURGUNDY;
 		chip->control_mask = MASK_IEPC | 0x11; /* disable IEE */
 	}
-	if (device_is_compatible(sound, "daca")) {
+	if (of_device_is_compatible(sound, "daca")) {
 		chip->model = PMAC_DACA;
 		chip->can_capture = 0;  /* no capture */
 		chip->can_duplex = 0;
 		// chip->can_byte_swap = 0; /* FIXME: check this */
 		chip->control_mask = MASK_IEPC | 0x11; /* disable IEE */
 	}
-	if (device_is_compatible(sound, "tumbler")) {
+	if (of_device_is_compatible(sound, "tumbler")) {
 		chip->model = PMAC_TUMBLER;
 		chip->can_capture = 0;  /* no capture */
 		chip->can_duplex = 0;
@@ -965,7 +965,7 @@ static int __init snd_pmac_detect(struct snd_pmac *chip)
 		chip->freq_table = tumbler_freqs;
 		chip->control_mask = MASK_IEPC | 0x11; /* disable IEE */
 	}
-	if (device_is_compatible(sound, "snapper")) {
+	if (of_device_is_compatible(sound, "snapper")) {
 		chip->model = PMAC_SNAPPER;
 		// chip->can_byte_swap = 0; /* FIXME: check this */
 		chip->num_freqs = ARRAY_SIZE(tumbler_freqs);
diff --git a/sound/ppc/tumbler.c b/sound/ppc/tumbler.c
index 54e333f..5821cdd 100644
--- a/sound/ppc/tumbler.c
+++ b/sound/ppc/tumbler.c
@@ -1060,7 +1060,7 @@ static struct device_node *find_compatible_audio_device(const char *name)
   
 	for (np = of_get_next_child(gpiop, NULL); np;
 			np = of_get_next_child(gpiop, np)) {
-		if (device_is_compatible(np, name))
+		if (of_device_is_compatible(np, name))
 			break;
 	}  
 	of_node_put(gpiop);
-- 
1.5.1.3

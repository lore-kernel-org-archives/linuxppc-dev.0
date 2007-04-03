Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id E7768DDEFB
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 22:52:30 +1000 (EST)
Date: Tue, 3 Apr 2007 22:30:00 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 04/17] [POWERPC] Rename get_property to of_get_property:
	arch/powerpc/sysdev
Message-Id: <20070403223000.5d44b2f1.sfr@canb.auug.org.au>
In-Reply-To: <20070403222841.a2c6af1c.sfr@canb.auug.org.au>
References: <20070403105217.7b9fea08.sfr@canb.auug.org.au>
	<20070403105401.1fcdee27.sfr@canb.auug.org.au>
	<20070403105539.7222cf2a.sfr@canb.auug.org.au>
	<20070403105650.204003b6.sfr@canb.auug.org.au>
	<20070403105748.769f156c.sfr@canb.auug.org.au>
	<20070403105852.7c7bfaa0.sfr@canb.auug.org.au>
	<20070403222406.cf39c459.sfr@canb.auug.org.au>
	<20070403222641.e93cb73b.sfr@canb.auug.org.au>
	<20070403222841.a2c6af1c.sfr@canb.auug.org.au>
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
 arch/powerpc/platforms/8xx/mpc86xads_setup.c |    2 +-
 arch/powerpc/platforms/8xx/mpc885ads_setup.c |    2 +-
 arch/powerpc/sysdev/dcr.c                    |   14 ++--
 arch/powerpc/sysdev/fsl_soc.c                |   90 ++++++++++++++------------
 arch/powerpc/sysdev/mpic.c                   |    8 +-
 arch/powerpc/sysdev/qe_lib/qe.c              |    4 +-
 arch/powerpc/sysdev/qe_lib/qe_io.c           |    6 +-
 arch/powerpc/sysdev/tsi108_dev.c             |   16 ++--
 arch/powerpc/sysdev/tsi108_pci.c             |    2 +-
 9 files changed, 75 insertions(+), 69 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/platforms/8xx/mpc86xads_setup.c b/arch/powerpc/platforms/8xx/mpc86xads_setup.c
index ef52ce7..baad9ac 100644
--- a/arch/powerpc/platforms/8xx/mpc86xads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc86xads_setup.c
@@ -247,7 +247,7 @@ void init_smc_ioports(struct fs_uart_platform_info *data)
 	}
 }
 
-int platform_device_skip(char *model, int id)
+int platform_device_skip(const char *model, int id)
 {
 	return 0;
 }
diff --git a/arch/powerpc/platforms/8xx/mpc885ads_setup.c b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
index c5fefdf..e4dcdfb 100644
--- a/arch/powerpc/platforms/8xx/mpc885ads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
@@ -322,7 +322,7 @@ void init_smc_ioports(struct fs_uart_platform_info *data)
 	}
 }
 
-int platform_device_skip(char *model, int id)
+int platform_device_skip(const char *model, int id)
 {
 #ifdef CONFIG_MPC8xx_SECOND_ETH_SCC3
 	const char *dev = "FEC";
diff --git a/arch/powerpc/sysdev/dcr.c b/arch/powerpc/sysdev/dcr.c
index dffeeae..7cca362 100644
--- a/arch/powerpc/sysdev/dcr.c
+++ b/arch/powerpc/sysdev/dcr.c
@@ -26,7 +26,7 @@
 unsigned int dcr_resource_start(struct device_node *np, unsigned int index)
 {
 	unsigned int ds;
-	const u32 *dr = get_property(np, "dcr-reg", &ds);
+	const u32 *dr = of_get_property(np, "dcr-reg", &ds);
 
 	if (dr == NULL || ds & 1 || index >= (ds / 8))
 		return 0;
@@ -37,7 +37,7 @@ unsigned int dcr_resource_start(struct device_node *np, unsigned int index)
 unsigned int dcr_resource_len(struct device_node *np, unsigned int index)
 {
 	unsigned int ds;
-	const u32 *dr = get_property(np, "dcr-reg", &ds);
+	const u32 *dr = of_get_property(np, "dcr-reg", &ds);
 
 	if (dr == NULL || ds & 1 || index >= (ds / 8))
 		return 0;
@@ -53,9 +53,9 @@ static struct device_node * find_dcr_parent(struct device_node * node)
 	const u32 *p;
 
 	for (par = of_node_get(node); par;) {
-		if (get_property(par, "dcr-controller", NULL))
+		if (of_get_property(par, "dcr-controller", NULL))
 			break;
-		p = get_property(par, "dcr-parent", NULL);
+		p = of_get_property(par, "dcr-parent", NULL);
 		tmp = par;
 		if (p == NULL)
 			par = of_get_parent(par);
@@ -80,13 +80,13 @@ u64 of_translate_dcr_address(struct device_node *dev,
 		return OF_BAD_ADDR;
 
 	/* Stride is not properly defined yet, default to 0x10 for Axon */
-	p = get_property(dp, "dcr-mmio-stride", NULL);
+	p = of_get_property(dp, "dcr-mmio-stride", NULL);
 	stride = (p == NULL) ? 0x10 : *p;
 
 	/* XXX FIXME: Which property name is to use of the 2 following ? */
-	p = get_property(dp, "dcr-mmio-range", NULL);
+	p = of_get_property(dp, "dcr-mmio-range", NULL);
 	if (p == NULL)
-		p = get_property(dp, "dcr-mmio-space", NULL);
+		p = of_get_property(dp, "dcr-mmio-space", NULL);
 	if (p == NULL)
 		return OF_BAD_ADDR;
 
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index d20f029..8a123c7 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -52,7 +52,7 @@ phys_addr_t get_immrbase(void)
 	soc = of_find_node_by_type(NULL, "soc");
 	if (soc) {
 		unsigned int size;
-		const void *prop = get_property(soc, "reg", &size);
+		const void *prop = of_get_property(soc, "reg", &size);
 
 		if (prop)
 			immrbase = of_translate_address(soc, prop);
@@ -78,8 +78,8 @@ u32 get_brgfreq(void)
 	node = of_find_node_by_type(NULL, "cpm");
 	if (node) {
 		unsigned int size;
-		const unsigned int *prop = get_property(node, "brg-frequency",
-					&size);
+		const unsigned int *prop = of_get_property(node,
+					"brg-frequency", &size);
 
 		if (prop)
 			brgfreq = *prop;
@@ -103,8 +103,8 @@ u32 get_baudrate(void)
 	node = of_find_node_by_type(NULL, "serial");
 	if (node) {
 		unsigned int size;
-		const unsigned int *prop = get_property(node, "current-speed",
-				&size);
+		const unsigned int *prop = of_get_property(node,
+				"current-speed", &size);
 
 		if (prop)
 			fs_baudrate = *prop;
@@ -153,7 +153,8 @@ static int __init gfar_mdio_of_init(void)
 		while ((child = of_get_next_child(np, child)) != NULL) {
 			int irq = irq_of_parse_and_map(child, 0);
 			if (irq != NO_IRQ) {
-				const u32 *id = get_property(child, "reg", NULL);
+				const u32 *id = of_get_property(child,
+							"reg", NULL);
 				mdio_data.irq[*id] = irq;
 			}
 		}
@@ -209,7 +210,7 @@ static int __init gfar_of_init(void)
 
 		of_irq_to_resource(np, 0, &r[1]);
 
-		model = get_property(np, "model", NULL);
+		model = of_get_property(np, "model", NULL);
 
 		/* If we aren't the FEC we have multiple interrupts */
 		if (model && strcasecmp(model, "FEC")) {
@@ -253,7 +254,7 @@ static int __init gfar_of_init(void)
 			    FSL_GIANFAR_DEV_HAS_VLAN |
 			    FSL_GIANFAR_DEV_HAS_EXTENDED_HASH;
 
-		ph = get_property(np, "phy-handle", NULL);
+		ph = of_get_property(np, "phy-handle", NULL);
 		phy = of_find_node_by_phandle(*ph);
 
 		if (phy == NULL) {
@@ -263,7 +264,7 @@ static int __init gfar_of_init(void)
 
 		mdio = of_get_parent(phy);
 
-		id = get_property(phy, "reg", NULL);
+		id = of_get_property(phy, "reg", NULL);
 		ret = of_address_to_resource(mdio, 0, &res);
 		if (ret) {
 			of_node_put(phy);
@@ -325,11 +326,11 @@ static int __init fsl_i2c_of_init(void)
 		}
 
 		i2c_data.device_flags = 0;
-		flags = get_property(np, "dfsrr", NULL);
+		flags = of_get_property(np, "dfsrr", NULL);
 		if (flags)
 			i2c_data.device_flags |= FSL_I2C_DEV_SEPARATE_DFSRR;
 
-		flags = get_property(np, "fsl5200-clocking", NULL);
+		flags = of_get_property(np, "fsl5200-clocking", NULL);
 		if (flags)
 			i2c_data.device_flags |= FSL_I2C_DEV_CLOCK_5200;
 
@@ -374,7 +375,7 @@ static int __init mpc83xx_wdt_init(void)
 		goto nosoc;
 	}
 
-	freq = get_property(soc, "bus-frequency", NULL);
+	freq = of_get_property(soc, "bus-frequency", NULL);
 	if (!freq) {
 		ret = -ENODEV;
 		goto err;
@@ -466,15 +467,15 @@ static int __init fsl_usb_of_init(void)
 
 		usb_data.operating_mode = FSL_USB2_MPH_HOST;
 
-		prop = get_property(np, "port0", NULL);
+		prop = of_get_property(np, "port0", NULL);
 		if (prop)
 			usb_data.port_enables |= FSL_USB2_PORT0_ENABLED;
 
-		prop = get_property(np, "port1", NULL);
+		prop = of_get_property(np, "port1", NULL);
 		if (prop)
 			usb_data.port_enables |= FSL_USB2_PORT1_ENABLED;
 
-		prop = get_property(np, "phy_type", NULL);
+		prop = of_get_property(np, "phy_type", NULL);
 		usb_data.phy_mode = determine_usb_phy(prop);
 
 		ret =
@@ -501,7 +502,7 @@ static int __init fsl_usb_of_init(void)
 
 		of_irq_to_resource(np, 0, &r[1]);
 
-		prop = get_property(np, "dr_mode", NULL);
+		prop = of_get_property(np, "dr_mode", NULL);
 
 		if (!prop || !strcmp(prop, "host")) {
 			usb_data.operating_mode = FSL_USB2_DR_HOST;
@@ -538,7 +539,7 @@ static int __init fsl_usb_of_init(void)
 			goto err;
 		}
 
-		prop = get_property(np, "phy_type", NULL);
+		prop = of_get_property(np, "phy_type", NULL);
 		usb_data.phy_mode = determine_usb_phy(prop);
 
 		if (usb_dev_dr_host) {
@@ -633,7 +634,7 @@ static int __init fs_enet_of_init(void)
 			goto err;
 		}
 
-		model = get_property(np, "model", NULL);
+		model = of_get_property(np, "model", NULL);
 		if (model == NULL) {
 			ret = -ENODEV;
 			goto unreg;
@@ -643,7 +644,7 @@ static int __init fs_enet_of_init(void)
 		if (mac_addr)
 			memcpy(fs_enet_data.macaddr, mac_addr, 6);
 
-		ph = get_property(np, "phy-handle", NULL);
+		ph = of_get_property(np, "phy-handle", NULL);
 		phy = of_find_node_by_phandle(*ph);
 
 		if (phy == NULL) {
@@ -651,12 +652,12 @@ static int __init fs_enet_of_init(void)
 			goto unreg;
 		}
 
-		phy_addr = get_property(phy, "reg", NULL);
+		phy_addr = of_get_property(phy, "reg", NULL);
 		fs_enet_data.phy_addr = *phy_addr;
 
-		phy_irq = get_property(phy, "interrupts", NULL);
+		phy_irq = of_get_property(phy, "interrupts", NULL);
 
-		id = get_property(np, "device-id", NULL);
+		id = of_get_property(np, "device-id", NULL);
 		fs_enet_data.fs_no = *id;
 		strcpy(fs_enet_data.fs_type, model);
 
@@ -668,8 +669,10 @@ static int __init fs_enet_of_init(void)
                         goto unreg;
                 }
 
-		fs_enet_data.clk_rx = *((u32 *) get_property(np, "rx-clock", NULL));
-		fs_enet_data.clk_tx = *((u32 *) get_property(np, "tx-clock", NULL));
+		fs_enet_data.clk_rx = *((u32 *)of_get_property(np,
+						"rx-clock", NULL));
+		fs_enet_data.clk_tx = *((u32 *)of_get_property(np,
+						"tx-clock", NULL));
 
 		if (strstr(model, "FCC")) {
 			int fcc_index = *id - 1;
@@ -690,7 +693,7 @@ static int __init fs_enet_of_init(void)
 			fs_enet_data.bus_id = (char*)&bus_id[(*id)];
 			fs_enet_data.init_ioports = init_fcc_ioports;
 
-			mdio_bb_prop = get_property(phy, "bitbang", NULL);
+			mdio_bb_prop = of_get_property(phy, "bitbang", NULL);
 			if (mdio_bb_prop) {
 				struct platform_device *fs_enet_mdio_bb_dev;
 				struct fs_mii_bb_platform_info fs_enet_mdio_bb_data;
@@ -796,10 +799,10 @@ static int __init cpm_uart_of_init(void)
 			goto err;
 		}
 
-		id = get_property(np, "device-id", NULL);
+		id = of_get_property(np, "device-id", NULL);
 		cpm_uart_data.fs_no = *id;
 
-		model = (char*)get_property(np, "model", NULL);
+		model = of_get_property(np, "model", NULL);
 		strcpy(cpm_uart_data.fs_type, model);
 
 		cpm_uart_data.uart_clk = ppc_proc_freq;
@@ -808,8 +811,10 @@ static int __init cpm_uart_of_init(void)
 		cpm_uart_data.tx_buf_size = 32;
 		cpm_uart_data.rx_num_fifo = 4;
 		cpm_uart_data.rx_buf_size = 32;
-		cpm_uart_data.clk_rx = *((u32 *) get_property(np, "rx-clock", NULL));
-		cpm_uart_data.clk_tx = *((u32 *) get_property(np, "tx-clock", NULL));
+		cpm_uart_data.clk_rx = *((u32 *)of_get_property(np,
+						"rx-clock", NULL));
+		cpm_uart_data.clk_tx = *((u32 *)of_get_property(np,
+						"tx-clock", NULL));
 
 		ret =
 		    platform_device_add_data(cpm_uart_dev, &cpm_uart_data,
@@ -833,7 +838,7 @@ arch_initcall(cpm_uart_of_init);
 #ifdef CONFIG_8xx
 
 extern void init_scc_ioports(struct fs_platform_info*);
-extern int platform_device_skip(char *model, int id);
+extern int platform_device_skip(const char *model, int id);
 
 static int __init fs_enet_mdio_of_init(void)
 {
@@ -900,21 +905,22 @@ static int __init fs_enet_of_init(void)
 		struct resource r[4];
 		struct device_node *phy = NULL, *mdio = NULL;
 		struct fs_platform_info fs_enet_data;
-		unsigned int *id, *phy_addr;
+		const unsigned int *id;
+		const unsigned int *phy_addr;
 		void *mac_addr;
-		phandle *ph;
-		char *model;
+		const phandle *ph;
+		const char *model;
 
 		memset(r, 0, sizeof(r));
 		memset(&fs_enet_data, 0, sizeof(fs_enet_data));
 
-		model = (char *)get_property(np, "model", NULL);
+		model = of_get_property(np, "model", NULL);
 		if (model == NULL) {
 			ret = -ENODEV;
 			goto unreg;
 		}
 
-		id = (u32 *) get_property(np, "device-id", NULL);
+		id = of_get_property(np, "device-id", NULL);
 		fs_enet_data.fs_no = *id;
 
 		if (platform_device_skip(model, *id))
@@ -929,12 +935,12 @@ static int __init fs_enet_of_init(void)
 		if (mac_addr)
 			memcpy(fs_enet_data.macaddr, mac_addr, 6);
 
-		ph = (phandle *) get_property(np, "phy-handle", NULL);
+		ph = of_get_property(np, "phy-handle", NULL);
 		if (ph != NULL)
 			phy = of_find_node_by_phandle(*ph);
 
 		if (phy != NULL) {
-			phy_addr = (u32 *) get_property(phy, "reg", NULL);
+			phy_addr = of_get_property(phy, "reg", NULL);
 			fs_enet_data.phy_addr = *phy_addr;
 			fs_enet_data.has_phy = 1;
 
@@ -947,7 +953,7 @@ static int __init fs_enet_of_init(void)
 			}
 		}
 
-		model = (char*)get_property(np, "model", NULL);
+		model = of_get_property(np, "model", NULL);
 		strcpy(fs_enet_data.fs_type, model);
 
 		if (strstr(model, "FEC")) {
@@ -1038,8 +1044,8 @@ static int __init cpm_smc_uart_of_init(void)
 	     i++) {
 		struct resource r[3];
 		struct fs_uart_platform_info cpm_uart_data;
-		int *id;
-		char *model;
+		const int *id;
+		const char *model;
 
 		memset(r, 0, sizeof(r));
 		memset(&cpm_uart_data, 0, sizeof(cpm_uart_data));
@@ -1066,10 +1072,10 @@ static int __init cpm_smc_uart_of_init(void)
 			goto err;
 		}
 
-		model = (char*)get_property(np, "model", NULL);
+		model = of_get_property(np, "model", NULL);
 		strcpy(cpm_uart_data.fs_type, model);
 
-		id = (int*)get_property(np, "device-id", NULL);
+		id = of_get_property(np, "device-id", NULL);
 		cpm_uart_data.fs_no = *id;
 		cpm_uart_data.uart_clk = ppc_proc_freq;
 
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index bcfb900..27e6f78 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -970,7 +970,7 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	mpic->spurious_vec  = intvec_top;
 
 	/* Check for "big-endian" in device-tree */
-	if (node && get_property(node, "big-endian", NULL) != NULL)
+	if (node && of_get_property(node, "big-endian", NULL) != NULL)
 		mpic->flags |= MPIC_BIG_ENDIAN;
 
 
@@ -986,13 +986,13 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	BUG_ON(paddr == 0 && node == NULL);
 
 	/* If no physical address passed in, check if it's dcr based */
-	if (paddr == 0 && get_property(node, "dcr-reg", NULL) != NULL)
+	if (paddr == 0 && of_get_property(node, "dcr-reg", NULL) != NULL)
 		mpic->flags |= MPIC_USES_DCR;
 
 #ifdef CONFIG_PPC_DCR
 	if (mpic->flags & MPIC_USES_DCR) {
 		const u32 *dbasep;
-		dbasep = get_property(node, "dcr-reg", NULL);
+		dbasep = of_get_property(node, "dcr-reg", NULL);
 		BUG_ON(dbasep == NULL);
 		mpic->dcr_base = *dbasep;
 		mpic->reg_type = mpic_access_dcr;
@@ -1006,7 +1006,7 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	 */
 	if (paddr == 0 && !(mpic->flags & MPIC_USES_DCR)) {
 		const u32 *reg;
-		reg = get_property(node, "reg", NULL);
+		reg = of_get_property(node, "reg", NULL);
 		BUG_ON(reg == NULL);
 		paddr = of_translate_address(node, reg);
 		BUG_ON(paddr == OF_BAD_ADDR);
diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
index e3d71e0..0558b1c 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -71,7 +71,7 @@ phys_addr_t get_qe_base(void)
 	qe = of_find_node_by_type(NULL, "qe");
 	if (qe) {
 		unsigned int size;
-		const void *prop = get_property(qe, "reg", &size);
+		const void *prop = of_get_property(qe, "reg", &size);
 		qebase = of_translate_address(qe, prop);
 		of_node_put(qe);
 	};
@@ -158,7 +158,7 @@ unsigned int get_brg_clk(void)
 	qe = of_find_node_by_type(NULL, "qe");
 	if (qe) {
 		unsigned int size;
-		const u32 *prop = get_property(qe, "brg-frequency", &size);
+		const u32 *prop = of_get_property(qe, "brg-frequency", &size);
 		brg_clk = *prop;
 		of_node_put(qe);
 	};
diff --git a/arch/powerpc/sysdev/qe_lib/qe_io.c b/arch/powerpc/sysdev/qe_lib/qe_io.c
index 0afe6bf..e32b45b 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_io.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_io.c
@@ -53,7 +53,7 @@ int par_io_init(struct device_node *np)
 		return ret;
 	par_io = ioremap(res.start, res.end - res.start + 1);
 
-	num_ports = get_property(np, "num-ports", NULL);
+	num_ports = of_get_property(np, "num-ports", NULL);
 	if (num_ports)
 		num_par_io_ports = *num_ports;
 
@@ -161,7 +161,7 @@ int par_io_of_config(struct device_node *np)
 		return -1;
 	}
 
-	ph = get_property(np, "pio-handle", NULL);
+	ph = of_get_property(np, "pio-handle", NULL);
 	if (ph == 0) {
 		printk(KERN_ERR "pio-handle not available \n");
 		return -1;
@@ -169,7 +169,7 @@ int par_io_of_config(struct device_node *np)
 
 	pio = of_find_node_by_phandle(*ph);
 
-	pio_map = get_property(pio, "pio-map", &pio_map_len);
+	pio_map = of_get_property(pio, "pio-map", &pio_map_len);
 	if (pio_map == NULL) {
 		printk(KERN_ERR "pio-map is not set! \n");
 		return -1;
diff --git a/arch/powerpc/sysdev/tsi108_dev.c b/arch/powerpc/sysdev/tsi108_dev.c
index 97f37ef..337039e 100644
--- a/arch/powerpc/sysdev/tsi108_dev.c
+++ b/arch/powerpc/sysdev/tsi108_dev.c
@@ -48,7 +48,7 @@ phys_addr_t get_csrbase(void)
 	tsi = of_find_node_by_type(NULL, "tsi-bridge");
 	if (tsi) {
 		unsigned int size;
-		const void *prop = get_property(tsi, "reg", &size);
+		const void *prop = of_get_property(tsi, "reg", &size);
 		tsi108_csr_base = of_translate_address(tsi, prop);
 		of_node_put(tsi);
 	};
@@ -77,10 +77,10 @@ static int __init tsi108_eth_of_init(void)
 		struct resource r[2];
 		struct device_node *phy;
 		hw_info tsi_eth_data;
-		unsigned int *id;
-		unsigned int *phy_id;
+		const unsigned int *id;
+		const unsigned int *phy_id;
 		const void *mac_addr;
-		phandle *ph;
+		const phandle *ph;
 
 		memset(r, 0, sizeof(r));
 		memset(&tsi_eth_data, 0, sizeof(tsi_eth_data));
@@ -107,10 +107,10 @@ static int __init tsi108_eth_of_init(void)
 			goto err;
 		}
 
-		mac_addr = get_property(np, "address", NULL);
+		mac_addr = of_get_property(np, "address", NULL);
 		memcpy(tsi_eth_data.mac_addr, mac_addr, 6);
 
-		ph = (phandle *) get_property(np, "phy-handle", NULL);
+		ph = of_get_property(np, "phy-handle", NULL);
 		phy = of_find_node_by_phandle(*ph);
 
 		if (phy == NULL) {
@@ -118,8 +118,8 @@ static int __init tsi108_eth_of_init(void)
 			goto unreg;
 		}
 
-		id = (u32 *) get_property(phy, "reg", NULL);
-		phy_id = (u32 *) get_property(phy, "phy-id", NULL);
+		id = of_get_property(phy, "reg", NULL);
+		phy_id = of_get_property(phy, "phy-id", NULL);
 		ret = of_address_to_resource(phy, 0, &res);
 		if (ret) {
 			of_node_put(phy);
diff --git a/arch/powerpc/sysdev/tsi108_pci.c b/arch/powerpc/sysdev/tsi108_pci.c
index ae249c6..58b9e7f 100644
--- a/arch/powerpc/sysdev/tsi108_pci.c
+++ b/arch/powerpc/sysdev/tsi108_pci.c
@@ -211,7 +211,7 @@ int __init tsi108_setup_pci(struct device_node *dev)
 	has_address = (of_address_to_resource(dev, 0, &rsrc) == 0);
 
 	/* Get bus range if any */
-	bus_range = get_property(dev, "bus-range", &len);
+	bus_range = of_get_property(dev, "bus-range", &len);
 	if (bus_range == NULL || len < 2 * sizeof(int)) {
 		printk(KERN_WARNING "Can't get bus-range for %s, assume"
 		       " bus 0\n", dev->full_name);
-- 
1.5.0.3

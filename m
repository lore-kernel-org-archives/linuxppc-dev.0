Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id D4A9BDDFE8
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 22:52:41 +1000 (EST)
Date: Tue, 3 Apr 2007 22:49:37 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 15/17] [POWERPC] Rename get_property to of_get_property:
	drivers
Message-Id: <20070403224937.f6a07e56.sfr@canb.auug.org.au>
In-Reply-To: <20070403224610.b61c7377.sfr@canb.auug.org.au>
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
	<20070403223738.03386a13.sfr@canb.auug.org.au>
	<20070403223914.35bf04e1.sfr@canb.auug.org.au>
	<20070403224039.913af749.sfr@canb.auug.org.au>
	<20070403224205.807cffe0.sfr@canb.auug.org.au>
	<20070403224340.5533abc9.sfr@canb.auug.org.au>
	<20070403224505.5d5a1495.sfr@canb.auug.org.au>
	<20070403224610.b61c7377.sfr@canb.auug.org.au>
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
 drivers/ata/sata_svw.c                 |    2 +-
 drivers/hwmon/ams/ams-core.c           |    2 +-
 drivers/hwmon/ams/ams-i2c.c            |    2 +-
 drivers/hwmon/ams/ams-pmu.c            |    2 +-
 drivers/ide/ppc/pmac.c                 |    4 ++--
 drivers/infiniband/hw/ehca/ehca_main.c |    2 +-
 drivers/mtd/maps/physmap_of.c          |    8 ++++----
 drivers/pci/hotplug/rpaphp_core.c      |   10 +++++-----
 drivers/serial/mpc52xx_uart.c          |    2 +-
 drivers/serial/of_serial.c             |    4 ++--
 drivers/serial/pmac_zilog.c            |    6 +++---
 11 files changed, 22 insertions(+), 22 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
index b121195..3e56211 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -297,7 +297,7 @@ static int k2_sata_proc_info(struct Scsi_Host *shost, char *page, char **start,
 	/* Match it to a port node */
 	index = (ap == ap->host->ports[0]) ? 0 : 1;
 	for (np = np->child; np != NULL; np = np->sibling) {
-		const u32 *reg = get_property(np, "reg", NULL);
+		const u32 *reg = of_get_property(np, "reg", NULL);
 		if (!reg)
 			continue;
 		if (index == *reg)
diff --git a/drivers/hwmon/ams/ams-core.c b/drivers/hwmon/ams/ams-core.c
index f5ebad5..93b963f 100644
--- a/drivers/hwmon/ams/ams-core.c
+++ b/drivers/hwmon/ams/ams-core.c
@@ -144,7 +144,7 @@ int ams_sensor_attach(void)
 	const u32 *prop;
 
 	/* Get orientation */
-	prop = get_property(ams_info.of_node, "orientation", NULL);
+	prop = of_get_property(ams_info.of_node, "orientation", NULL);
 	if (!prop)
 		return -ENODEV;
 	ams_info.orient1 = *prop;
diff --git a/drivers/hwmon/ams/ams-i2c.c b/drivers/hwmon/ams/ams-i2c.c
index 485d333..ccd5cef 100644
--- a/drivers/hwmon/ams/ams-i2c.c
+++ b/drivers/hwmon/ams/ams-i2c.c
@@ -276,7 +276,7 @@ int __init ams_i2c_init(struct device_node *np)
 	ams_info.bustype = BUS_I2C;
 
 	/* look for bus either using "reg" or by path */
-	prop = get_property(ams_info.of_node, "reg", NULL);
+	prop = of_get_property(ams_info.of_node, "reg", NULL);
 	if (!prop) {
 		result = -ENODEV;
 
diff --git a/drivers/hwmon/ams/ams-pmu.c b/drivers/hwmon/ams/ams-pmu.c
index 1b01c21..9463e97 100644
--- a/drivers/hwmon/ams/ams-pmu.c
+++ b/drivers/hwmon/ams/ams-pmu.c
@@ -160,7 +160,7 @@ int __init ams_pmu_init(struct device_node *np)
 	ams_info.bustype = BUS_HOST;
 
 	/* Get PMU command, should be 0x4e, but we can never know */
-	prop = get_property(ams_info.of_node, "reg", NULL);
+	prop = of_get_property(ams_info.of_node, "reg", NULL);
 	if (!prop) {
 		result = -ENODEV;
 		goto exit;
diff --git a/drivers/ide/ppc/pmac.c b/drivers/ide/ppc/pmac.c
index 071a030..774bfd3 100644
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1175,14 +1175,14 @@ pmac_ide_setup_device(pmac_ide_hwif_t *pmif, ide_hwif_t *hwif)
 		pmif->broken_dma = 1;
 	}
 
-	bidp = get_property(np, "AAPL,bus-id", NULL);
+	bidp = of_get_property(np, "AAPL,bus-id", NULL);
 	pmif->aapl_bus_id =  bidp ? *bidp : 0;
 
 	/* Get cable type from device-tree */
 	if (pmif->kind == controller_kl_ata4 || pmif->kind == controller_un_ata6
 	    || pmif->kind == controller_k2_ata6
 	    || pmif->kind == controller_sh_ata6) {
-		const char* cable = get_property(np, "cable-type", NULL);
+		const char* cable = of_get_property(np, "cable-type", NULL);
 		if (cable && !strncmp(cable, "80-", 3))
 			pmif->cable_80 = 1;
 	}
diff --git a/drivers/infiniband/hw/ehca/ehca_main.c b/drivers/infiniband/hw/ehca/ehca_main.c
index cee66b7..e5c2bcc 100644
--- a/drivers/infiniband/hw/ehca/ehca_main.c
+++ b/drivers/infiniband/hw/ehca/ehca_main.c
@@ -569,7 +569,7 @@ static int __devinit ehca_probe(struct ibmebus_dev *dev,
 	struct ib_pd *ibpd;
 	int ret;
 
-	handle = get_property(dev->ofdev.node, "ibm,hca-handle", NULL);
+	handle = of_get_property(dev->ofdev.node, "ibm,hca-handle", NULL);
 	if (!handle) {
 		ehca_gen_err("Cannot get eHCA handle for adapter: %s.",
 			     dev->ofdev.node->full_name);
diff --git a/drivers/mtd/maps/physmap_of.c b/drivers/mtd/maps/physmap_of.c
index 7efe744..72107dc 100644
--- a/drivers/mtd/maps/physmap_of.c
+++ b/drivers/mtd/maps/physmap_of.c
@@ -48,7 +48,7 @@ static int parse_flash_partitions(struct device_node *node,
 	const  u32  *part;
 	const  char *name;
 
-	part = get_property(node, "partitions", &plen);
+	part = of_get_property(node, "partitions", &plen);
 	if (part == NULL)
 		goto err;
 
@@ -59,7 +59,7 @@ static int parse_flash_partitions(struct device_node *node,
 		goto err;
 	}
 
-	name = get_property(node, "partition-names", &plen);
+	name = of_get_property(node, "partition-names", &plen);
 
 	for (i = 0; i < retval; i++) {
 		(*parts)[i].offset = *part++;
@@ -153,7 +153,7 @@ static int __devinit of_physmap_probe(struct of_device *dev, const struct of_dev
 		goto err_out;
 	}
 
-	width = get_property(dp, "bank-width", NULL);
+	width = of_get_property(dp, "bank-width", NULL);
 	if (width == NULL) {
 		dev_err(&dev->dev, "Can't get the flash bank width!\n");
 		err = -EINVAL;
@@ -174,7 +174,7 @@ static int __devinit of_physmap_probe(struct of_device *dev, const struct of_dev
 
 	simple_map_init(&info->map);
 
-	of_probe = get_property(dp, "probe-type", NULL);
+	of_probe = of_get_property(dp, "probe-type", NULL);
 	if (of_probe == NULL) {
 		probe_type = rom_probe_types;
 		for (; info->mtd == NULL && *probe_type != NULL; probe_type++)
diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
index 71a2cb8..353da5b 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -182,10 +182,10 @@ static int get_children_props(struct device_node *dn, const int **drc_indexes,
 {
 	const int *indexes, *names, *types, *domains;
 
-	indexes = get_property(dn, "ibm,drc-indexes", NULL);
-	names = get_property(dn, "ibm,drc-names", NULL);
-	types = get_property(dn, "ibm,drc-types", NULL);
-	domains = get_property(dn, "ibm,drc-power-domains", NULL);
+	indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
+	names = of_get_property(dn, "ibm,drc-names", NULL);
+	types = of_get_property(dn, "ibm,drc-types", NULL);
+	domains = of_get_property(dn, "ibm,drc-power-domains", NULL);
 
 	if (!indexes || !names || !types || !domains) {
 		/* Slot does not have dynamically-removable children */
@@ -218,7 +218,7 @@ int rpaphp_get_drc_props(struct device_node *dn, int *drc_index,
 	char *name_tmp, *type_tmp;
 	int i, rc;
 
-	my_index = get_property(dn, "ibm,my-drc-index", NULL);
+	my_index = of_get_property(dn, "ibm,my-drc-index", NULL);
 	if (!my_index) {
 		/* Node isn't DLPAR/hotplug capable */
 		return -EINVAL;
diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index 8d24cd5..f8c1761 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -1069,7 +1069,7 @@ mpc52xx_uart_of_enumerate(void)
 			continue;
 
 		/* Is a particular device number requested? */
-		devno = get_property(np, "port-number", NULL);
+		devno = of_get_property(np, "port-number", NULL);
 		mpc52xx_uart_of_assign(of_node_get(np), devno ? *devno : -1);
 	}
 
diff --git a/drivers/serial/of_serial.c b/drivers/serial/of_serial.c
index 09b0b73..e7928fe 100644
--- a/drivers/serial/of_serial.c
+++ b/drivers/serial/of_serial.c
@@ -29,8 +29,8 @@ static int __devinit of_platform_serial_setup(struct of_device *ofdev,
 	int ret;
 
 	memset(port, 0, sizeof *port);
-	spd = get_property(np, "current-speed", NULL);
-	clk = get_property(np, "clock-frequency", NULL);
+	spd = of_get_property(np, "current-speed", NULL);
+	clk = of_get_property(np, "clock-frequency", NULL);
 	if (!clk) {
 		dev_warn(&ofdev->dev, "no clock-frequency property set\n");
 		return -ENODEV;
diff --git a/drivers/serial/pmac_zilog.c b/drivers/serial/pmac_zilog.c
index 752ef07..2b163c5 100644
--- a/drivers/serial/pmac_zilog.c
+++ b/drivers/serial/pmac_zilog.c
@@ -1452,12 +1452,12 @@ no_dma:
 	 */
 	if (device_is_compatible(np, "cobalt"))
 		uap->flags |= PMACZILOG_FLAG_IS_INTMODEM;
-	conn = get_property(np, "AAPL,connector", &len);
+	conn = of_get_property(np, "AAPL,connector", &len);
 	if (conn && (strcmp(conn, "infrared") == 0))
 		uap->flags |= PMACZILOG_FLAG_IS_IRDA;
 	uap->port_type = PMAC_SCC_ASYNC;
 	/* 1999 Powerbook G3 has slot-names property instead */
-	slots = get_property(np, "slot-names", &len);
+	slots = of_get_property(np, "slot-names", &len);
 	if (slots && slots->count > 0) {
 		if (strcmp(slots->name, "IrDA") == 0)
 			uap->flags |= PMACZILOG_FLAG_IS_IRDA;
@@ -1470,7 +1470,7 @@ no_dma:
 		struct device_node* i2c_modem = find_devices("i2c-modem");
 		if (i2c_modem) {
 			const char* mid =
-				get_property(i2c_modem, "modem-id", NULL);
+				of_get_property(i2c_modem, "modem-id", NULL);
 			if (mid) switch(*mid) {
 			case 0x04 :
 			case 0x05 :
-- 
1.5.0.3

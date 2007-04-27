Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 7F3CBDDF44
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2007 13:40:47 +1000 (EST)
Date: Fri, 27 Apr 2007 13:41:15 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Rename get_property to of_get_property: partial
	drivers
Message-Id: <20070427134115.36950017.sfr@canb.auug.org.au>
In-Reply-To: <20070403224205.807cffe0.sfr@canb.auug.org.au>
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

This does dirvers/machintosh and the hvc code.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/char/hvc_iseries.c                  |    2 +-
 drivers/char/hvc_vio.c                      |    2 +-
 drivers/char/hvsi.c                         |    4 ++--
 drivers/macintosh/macio_asic.c              |    2 +-
 drivers/macintosh/macio_sysfs.c             |    4 ++--
 drivers/macintosh/rack-meter.c              |    2 +-
 drivers/macintosh/smu.c                     |    6 +++---
 drivers/macintosh/therm_adt746x.c           |    8 ++++----
 drivers/macintosh/therm_pm72.c              |    8 ++++----
 drivers/macintosh/therm_windtunnel.c        |    2 +-
 drivers/macintosh/via-cuda.c                |    2 +-
 drivers/macintosh/via-pmu-led.c             |    2 +-
 drivers/macintosh/via-pmu.c                 |    6 +++---
 drivers/macintosh/windfarm_lm75_sensor.c    |    2 +-
 drivers/macintosh/windfarm_max6690_sensor.c |    2 +-
 drivers/macintosh/windfarm_smu_controls.c   |    8 ++++----
 drivers/macintosh/windfarm_smu_sat.c        |    8 ++++----
 drivers/macintosh/windfarm_smu_sensors.c    |    6 +++---
 18 files changed, 38 insertions(+), 38 deletions(-)

Paul,

This is on top of your reversion of
d05c7a80cf39ae7d0f8d0c3e47c93d51fcd393d3.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/drivers/char/hvc_iseries.c b/drivers/char/hvc_iseries.c
index f144a94..ec420fe 100644
--- a/drivers/char/hvc_iseries.c
+++ b/drivers/char/hvc_iseries.c
@@ -575,7 +575,7 @@ static int hvc_find_vtys(void)
 				(num_found >= VTTY_PORTS))
 			break;
 
-		vtermno = get_property(vty, "reg", NULL);
+		vtermno = of_get_property(vty, "reg", NULL);
 		if (!vtermno)
 			continue;
 
diff --git a/drivers/char/hvc_vio.c b/drivers/char/hvc_vio.c
index f9c0084..94a542e 100644
--- a/drivers/char/hvc_vio.c
+++ b/drivers/char/hvc_vio.c
@@ -153,7 +153,7 @@ static int hvc_find_vtys(void)
 		if (num_found >= MAX_NR_HVC_CONSOLES)
 			break;
 
-		vtermno = get_property(vty, "reg", NULL);
+		vtermno = of_get_property(vty, "reg", NULL);
 		if (!vtermno)
 			continue;
 
diff --git a/drivers/char/hvsi.c b/drivers/char/hvsi.c
index 50315d6..d5a752d 100644
--- a/drivers/char/hvsi.c
+++ b/drivers/char/hvsi.c
@@ -1279,8 +1279,8 @@ static int __init hvsi_console_init(void)
 		struct hvsi_struct *hp;
 		const uint32_t *vtermno, *irq;
 
-		vtermno = get_property(vty, "reg", NULL);
-		irq = get_property(vty, "interrupts", NULL);
+		vtermno = of_get_property(vty, "reg", NULL);
+		irq = of_get_property(vty, "interrupts", NULL);
 		if (!vtermno || !irq)
 			continue;
 
diff --git a/drivers/macintosh/macio_asic.c b/drivers/macintosh/macio_asic.c
index e851266..c96b7fe 100644
--- a/drivers/macintosh/macio_asic.c
+++ b/drivers/macintosh/macio_asic.c
@@ -395,7 +395,7 @@ static struct macio_dev * macio_add_one_device(struct macio_chip *chip,
 #endif
 			MAX_NODE_NAME_SIZE, np->name);
 	} else {
-		reg = get_property(np, "reg", NULL);
+		reg = of_get_property(np, "reg", NULL);
 		sprintf(dev->ofdev.dev.bus_id, "%1d.%08x:%.*s",
 			chip->lbus.index,
 			reg ? *reg : 0, MAX_NODE_NAME_SIZE, np->name);
diff --git a/drivers/macintosh/macio_sysfs.c b/drivers/macintosh/macio_sysfs.c
index 0a5647f..cc82679 100644
--- a/drivers/macintosh/macio_sysfs.c
+++ b/drivers/macintosh/macio_sysfs.c
@@ -21,7 +21,7 @@ compatible_show (struct device *dev, struct device_attribute *attr, char *buf)
 	int length = 0;
 
 	of = &to_macio_device (dev)->ofdev;
-	compat = get_property(of->node, "compatible", &cplen);
+	compat = of_get_property(of->node, "compatible", &cplen);
 	if (!compat) {
 		*buf = '\0';
 		return 0;
@@ -47,7 +47,7 @@ static ssize_t modalias_show (struct device *dev, struct device_attribute *attr,
 	int length;
 
 	of = &to_macio_device (dev)->ofdev;
-	compat = get_property(of->node, "compatible", &cplen);
+	compat = of_get_property(of->node, "compatible", &cplen);
 	if (!compat) compat = "", cplen = 1;
 	length = sprintf (buf, "of:N%sT%s", of->node->name, of->node->type);
 	buf += length;
diff --git a/drivers/macintosh/rack-meter.c b/drivers/macintosh/rack-meter.c
index f83fad2..4177ff0 100644
--- a/drivers/macintosh/rack-meter.c
+++ b/drivers/macintosh/rack-meter.c
@@ -387,7 +387,7 @@ static int __devinit rackmeter_probe(struct macio_dev* mdev,
 	       if (strcmp(np->name, "lightshow") == 0)
 		       break;
 	       if ((strcmp(np->name, "sound") == 0) &&
-		   get_property(np, "virtual", NULL) != NULL)
+		   of_get_property(np, "virtual", NULL) != NULL)
 		       break;
 	}
 	if (np == NULL) {
diff --git a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
index 45bb3c1..135f22e 100644
--- a/drivers/macintosh/smu.c
+++ b/drivers/macintosh/smu.c
@@ -491,7 +491,7 @@ int __init smu_init (void)
 		printk(KERN_ERR "SMU: Can't find doorbell GPIO !\n");
 		goto fail;
 	}
-	data = get_property(smu->db_node, "reg", NULL);
+	data = of_get_property(smu->db_node, "reg", NULL);
 	if (data == NULL) {
 		of_node_put(smu->db_node);
 		smu->db_node = NULL;
@@ -512,7 +512,7 @@ int __init smu_init (void)
 		smu->msg_node = of_find_node_by_name(NULL, "smu-interrupt");
 		if (smu->msg_node == NULL)
 			break;
-		data = get_property(smu->msg_node, "reg", NULL);
+		data = of_get_property(smu->msg_node, "reg", NULL);
 		if (data == NULL) {
 			of_node_put(smu->msg_node);
 			smu->msg_node = NULL;
@@ -1004,7 +1004,7 @@ const struct smu_sdbp_header *__smu_get_sdb_partition(int id,
 	} else
 		mutex_lock(&smu_part_access);
 
-	part = get_property(smu->of_node, pname, size);
+	part = of_get_property(smu->of_node, pname, size);
 	if (part == NULL) {
 		DPRINTK("trying to extract from SMU ...\n");
 		part = smu_create_sdb_partition(id);
diff --git a/drivers/macintosh/therm_adt746x.c b/drivers/macintosh/therm_adt746x.c
index a7ce559..2289034 100644
--- a/drivers/macintosh/therm_adt746x.c
+++ b/drivers/macintosh/therm_adt746x.c
@@ -567,13 +567,13 @@ thermostat_init(void)
 	else
 		return -ENODEV;
 
-	prop = get_property(np, "hwsensor-params-version", NULL);
+	prop = of_get_property(np, "hwsensor-params-version", NULL);
 	printk(KERN_INFO "adt746x: version %d (%ssupported)\n", *prop,
 			 (*prop == 1)?"":"un");
 	if (*prop != 1)
 		return -ENODEV;
 
-	prop = get_property(np, "reg", NULL);
+	prop = of_get_property(np, "reg", NULL);
 	if (!prop)
 		return -ENODEV;
 
@@ -591,9 +591,9 @@ thermostat_init(void)
 			 "limit_adjust: %d, fan_speed: %d\n",
 			 therm_bus, therm_address, limit_adjust, fan_speed);
 
-	if (get_property(np, "hwsensor-location", NULL)) {
+	if (of_get_property(np, "hwsensor-location", NULL)) {
 		for (i = 0; i < 3; i++) {
-			sensor_location[i] = get_property(np,
+			sensor_location[i] = of_get_property(np,
 					"hwsensor-location", NULL) + offset;
 
 			if (sensor_location[i] == NULL)
diff --git a/drivers/macintosh/therm_pm72.c b/drivers/macintosh/therm_pm72.c
index 2e4ad44..78ff186 100644
--- a/drivers/macintosh/therm_pm72.c
+++ b/drivers/macintosh/therm_pm72.c
@@ -674,7 +674,7 @@ static int read_eeprom(int cpu, struct mpu_data *out)
 		printk(KERN_ERR "therm_pm72: Failed to retrieve cpuid node from device-tree\n");
 		return -ENODEV;
 	}
-	data = get_property(np, "cpuid", &len);
+	data = of_get_property(np, "cpuid", &len);
 	if (data == NULL) {
 		printk(KERN_ERR "therm_pm72: Failed to retrieve cpuid property from device-tree\n");
 		of_node_put(np);
@@ -1337,7 +1337,7 @@ static int init_backside_state(struct backside_pid_state *state)
 	 */
 	u3 = of_find_node_by_path("/u3@0,f8000000");
 	if (u3 != NULL) {
-		const u32 *vers = get_property(u3, "device-rev", NULL);
+		const u32 *vers = of_get_property(u3, "device-rev", NULL);
 		if (vers)
 			if (((*vers) & 0x3f) < 0x34)
 				u3h = 0;
@@ -2129,8 +2129,8 @@ static void fcu_lookup_fans(struct device_node *fcu_node)
 			continue;
 
 		/* Lookup for a matching location */
-		loc = get_property(np, "location", NULL);
-		reg = get_property(np, "reg", NULL);
+		loc = of_get_property(np, "location", NULL);
+		reg = of_get_property(np, "reg", NULL);
 		if (loc == NULL || reg == NULL)
 			continue;
 		DBG(" matching location: %s, reg: 0x%08x\n", loc, *reg);
diff --git a/drivers/macintosh/therm_windtunnel.c b/drivers/macintosh/therm_windtunnel.c
index a1d3a98..35233de 100644
--- a/drivers/macintosh/therm_windtunnel.c
+++ b/drivers/macintosh/therm_windtunnel.c
@@ -492,7 +492,7 @@ g4fan_init( void )
 
 	if( !(np=of_find_node_by_name(NULL, "power-mgt")) )
 		return -ENODEV;
-	info = get_property(np, "thermal-info", NULL);
+	info = of_get_property(np, "thermal-info", NULL);
 	of_node_put(np);
 
 	if( !info || !machine_is_compatible("PowerMac3,6") )
diff --git a/drivers/macintosh/via-cuda.c b/drivers/macintosh/via-cuda.c
index d58fcf6..76d2177 100644
--- a/drivers/macintosh/via-cuda.c
+++ b/drivers/macintosh/via-cuda.c
@@ -131,7 +131,7 @@ int __init find_via_cuda(void)
     if (vias == 0)
 	return 0;
 
-    reg = get_property(vias, "reg", NULL);
+    reg = of_get_property(vias, "reg", NULL);
     if (reg == NULL) {
 	    printk(KERN_ERR "via-cuda: No \"reg\" property !\n");
 	    goto fail;
diff --git a/drivers/macintosh/via-pmu-led.c b/drivers/macintosh/via-pmu-led.c
index f8d7a46..fc89a70 100644
--- a/drivers/macintosh/via-pmu-led.c
+++ b/drivers/macintosh/via-pmu-led.c
@@ -118,7 +118,7 @@ static int __init via_pmu_led_init(void)
 	dt = of_find_node_by_path("/");
 	if (dt == NULL)
 		return -ENODEV;
-	model = get_property(dt, "model", NULL);
+	model = of_get_property(dt, "model", NULL);
 	if (model == NULL)
 		return -ENODEV;
 	if (strncmp(model, "PowerBook", strlen("PowerBook")) != 0 &&
diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 8470210..1729d3f 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -289,7 +289,7 @@ int __init find_via_pmu(void)
 	if (vias == NULL)
 		return 0;
 
-	reg = get_property(vias, "reg", NULL);
+	reg = of_get_property(vias, "reg", NULL);
 	if (reg == NULL) {
 		printk(KERN_ERR "via-pmu: No \"reg\" property !\n");
 		goto fail;
@@ -334,7 +334,7 @@ int __init find_via_pmu(void)
 		
 		gpiop = of_find_node_by_name(NULL, "gpio");
 		if (gpiop) {
-			reg = get_property(gpiop, "reg", NULL);
+			reg = of_get_property(gpiop, "reg", NULL);
 			if (reg)
 				gaddr = of_translate_address(gpiop, reg);
 			if (gaddr != OF_BAD_ADDR)
@@ -491,7 +491,7 @@ static int __init via_pmu_dev_init(void)
 			of_find_node_by_name(NULL, "power-mgt");
 		const u32 *prim_info = NULL;
 		if (prim)
-			prim_info = get_property(prim, "prim-info", NULL);
+			prim_info = of_get_property(prim, "prim-info", NULL);
 		if (prim_info) {
 			/* Other stuffs here yet unknown */
 			pmu_battery_count = (prim_info[6] >> 16) & 0xff;
diff --git a/drivers/macintosh/windfarm_lm75_sensor.c b/drivers/macintosh/windfarm_lm75_sensor.c
index 3f7967f..ab4d1b6 100644
--- a/drivers/macintosh/windfarm_lm75_sensor.c
+++ b/drivers/macintosh/windfarm_lm75_sensor.c
@@ -176,7 +176,7 @@ static int wf_lm75_attach(struct i2c_adapter *adapter)
 	for (dev = NULL;
 	     (dev = of_get_next_child(busnode, dev)) != NULL;) {
 		const char *loc =
-			get_property(dev, "hwsensor-location", NULL);
+			of_get_property(dev, "hwsensor-location", NULL);
 		u8 addr;
 
 		/* We must re-match the adapter in order to properly check
diff --git a/drivers/macintosh/windfarm_max6690_sensor.c b/drivers/macintosh/windfarm_max6690_sensor.c
index eae1189..eaa74af 100644
--- a/drivers/macintosh/windfarm_max6690_sensor.c
+++ b/drivers/macintosh/windfarm_max6690_sensor.c
@@ -134,7 +134,7 @@ static int wf_max6690_attach(struct i2c_adapter *adapter)
 		if (!device_is_compatible(dev, "max6690"))
 			continue;
 		addr = pmac_i2c_get_dev_addr(dev);
-		loc = get_property(dev, "hwsensor-location", NULL);
+		loc = of_get_property(dev, "hwsensor-location", NULL);
 		if (loc == NULL || addr == 0)
 			continue;
 		printk("found max6690, loc=%s addr=0x%02x\n", loc, addr);
diff --git a/drivers/macintosh/windfarm_smu_controls.c b/drivers/macintosh/windfarm_smu_controls.c
index 31b750d..ff398ad 100644
--- a/drivers/macintosh/windfarm_smu_controls.c
+++ b/drivers/macintosh/windfarm_smu_controls.c
@@ -167,7 +167,7 @@ static struct smu_fan_control *smu_fan_create(struct device_node *node,
 	if (fct == NULL)
 		return NULL;
 	fct->ctrl.ops = &smu_fan_ops;
-	l = get_property(node, "location", NULL);
+	l = of_get_property(node, "location", NULL);
 	if (l == NULL)
 		goto fail;
 
@@ -224,17 +224,17 @@ static struct smu_fan_control *smu_fan_create(struct device_node *node,
 		goto fail;
 
 	/* Get min & max values*/
-	v = get_property(node, "min-value", NULL);
+	v = of_get_property(node, "min-value", NULL);
 	if (v == NULL)
 		goto fail;
 	fct->min = *v;
-	v = get_property(node, "max-value", NULL);
+	v = of_get_property(node, "max-value", NULL);
 	if (v == NULL)
 		goto fail;
 	fct->max = *v;
 
 	/* Get "reg" value */
-	reg = get_property(node, "reg", NULL);
+	reg = of_get_property(node, "reg", NULL);
 	if (reg == NULL)
 		goto fail;
 	fct->reg = *reg;
diff --git a/drivers/macintosh/windfarm_smu_sat.c b/drivers/macintosh/windfarm_smu_sat.c
index 83f79de..9a6c2cf 100644
--- a/drivers/macintosh/windfarm_smu_sat.c
+++ b/drivers/macintosh/windfarm_smu_sat.c
@@ -241,7 +241,7 @@ static void wf_sat_create(struct i2c_adapter *adapter, struct device_node *dev)
 	char *name;
 	int vsens[2], isens[2];
 
-	reg = get_property(dev, "reg", NULL);
+	reg = of_get_property(dev, "reg", NULL);
 	if (reg == NULL)
 		return;
 	addr = *reg;
@@ -268,9 +268,9 @@ static void wf_sat_create(struct i2c_adapter *adapter, struct device_node *dev)
 	isens[0] = isens[1] = -1;
 	child = NULL;
 	while ((child = of_get_next_child(dev, child)) != NULL) {
-		reg = get_property(child, "reg", NULL);
-		type = get_property(child, "device_type", NULL);
-		loc = get_property(child, "location", NULL);
+		reg = of_get_property(child, "reg", NULL);
+		type = of_get_property(child, "device_type", NULL);
+		loc = of_get_property(child, "location", NULL);
 		if (reg == NULL || loc == NULL)
 			continue;
 
diff --git a/drivers/macintosh/windfarm_smu_sensors.c b/drivers/macintosh/windfarm_smu_sensors.c
index 01b4c50..9c567b9 100644
--- a/drivers/macintosh/windfarm_smu_sensors.c
+++ b/drivers/macintosh/windfarm_smu_sensors.c
@@ -204,8 +204,8 @@ static struct smu_ad_sensor *smu_ads_create(struct device_node *node)
 	ads = kmalloc(sizeof(struct smu_ad_sensor), GFP_KERNEL);
 	if (ads == NULL)
 		return NULL;
-	c = get_property(node, "device_type", NULL);
-	l = get_property(node, "location", NULL);
+	c = of_get_property(node, "device_type", NULL);
+	l = of_get_property(node, "location", NULL);
 	if (c == NULL || l == NULL)
 		goto fail;
 
@@ -255,7 +255,7 @@ static struct smu_ad_sensor *smu_ads_create(struct device_node *node)
 	} else
 		goto fail;
 
-	v = get_property(node, "reg", NULL);
+	v = of_get_property(node, "reg", NULL);
 	if (v == NULL)
 		goto fail;
 	ads->reg = *v;
-- 
1.5.1.2

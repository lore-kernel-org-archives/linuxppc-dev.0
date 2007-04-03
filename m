Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id CA731DE032
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 10:58:39 +1000 (EST)
Date: Tue, 3 Apr 2007 10:52:17 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 1/6] [POWERPC] get_property returns const
Message-Id: <20070403105217.7b9fea08.sfr@canb.auug.org.au>
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

This just tidies up some of the remains.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/hwmon/ams/ams-core.c              |    4 ++--
 drivers/hwmon/ams/ams-i2c.c               |    4 ++--
 drivers/hwmon/ams/ams-pmu.c               |    4 ++--
 drivers/infiniband/hw/ehca/ehca_main.c    |    4 ++--
 drivers/net/ehea/ehea_main.c              |    8 ++++----
 drivers/scsi/ibmvscsi/ibmvstgt.c          |    4 ++--
 drivers/video/aty/radeon_pm.c             |    2 +-
 sound/aoa/codecs/snd-aoa-codec-onyx.c     |    4 ++--
 sound/aoa/codecs/snd-aoa-codec-tas.c      |    7 ++++---
 sound/aoa/core/snd-aoa-gpio-feature.c     |    6 +++---
 sound/aoa/fabrics/snd-aoa-fabric-layout.c |    4 ++--
 sound/aoa/soundbus/core.c                 |    9 ++++-----
 sound/aoa/soundbus/i2sbus/i2sbus-core.c   |    7 +++----
 sound/oss/dmasound/dmasound_awacs.c       |   20 ++++++++++----------
 sound/oss/dmasound/tas_common.c           |    4 ++--
 15 files changed, 45 insertions(+), 46 deletions(-)

Compiled an allmodconfig with this.

I am pretty sure that none of the following patches depends on this one.

Dave, just cc'ing you on this set of patches to let you know what
direction we are heading in.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/drivers/hwmon/ams/ams-core.c b/drivers/hwmon/ams/ams-core.c
index f1f0f5d..f5ebad5 100644
--- a/drivers/hwmon/ams/ams-core.c
+++ b/drivers/hwmon/ams/ams-core.c
@@ -141,10 +141,10 @@ static void ams_worker(struct work_struct *work)
 int ams_sensor_attach(void)
 {
 	int result;
-	u32 *prop;
+	const u32 *prop;
 
 	/* Get orientation */
-	prop = (u32*)get_property(ams_info.of_node, "orientation", NULL);
+	prop = get_property(ams_info.of_node, "orientation", NULL);
 	if (!prop)
 		return -ENODEV;
 	ams_info.orient1 = *prop;
diff --git a/drivers/hwmon/ams/ams-i2c.c b/drivers/hwmon/ams/ams-i2c.c
index 0d24bdf..485d333 100644
--- a/drivers/hwmon/ams/ams-i2c.c
+++ b/drivers/hwmon/ams/ams-i2c.c
@@ -263,7 +263,7 @@ int __init ams_i2c_init(struct device_node *np)
 {
 	char *tmp_bus;
 	int result;
-	u32 *prop;
+	const u32 *prop;
 
 	mutex_lock(&ams_info.lock);
 
@@ -276,7 +276,7 @@ int __init ams_i2c_init(struct device_node *np)
 	ams_info.bustype = BUS_I2C;
 
 	/* look for bus either using "reg" or by path */
-	prop = (u32*)get_property(ams_info.of_node, "reg", NULL);
+	prop = get_property(ams_info.of_node, "reg", NULL);
 	if (!prop) {
 		result = -ENODEV;
 
diff --git a/drivers/hwmon/ams/ams-pmu.c b/drivers/hwmon/ams/ams-pmu.c
index 4636ae0..1b01c21 100644
--- a/drivers/hwmon/ams/ams-pmu.c
+++ b/drivers/hwmon/ams/ams-pmu.c
@@ -146,7 +146,7 @@ static void ams_pmu_exit(void)
 
 int __init ams_pmu_init(struct device_node *np)
 {
-	u32 *prop;
+	const u32 *prop;
 	int result;
 
 	mutex_lock(&ams_info.lock);
@@ -160,7 +160,7 @@ int __init ams_pmu_init(struct device_node *np)
 	ams_info.bustype = BUS_HOST;
 
 	/* Get PMU command, should be 0x4e, but we can never know */
-	prop = (u32*)get_property(ams_info.of_node, "reg", NULL);
+	prop = get_property(ams_info.of_node, "reg", NULL);
 	if (!prop) {
 		result = -ENODEV;
 		goto exit;
diff --git a/drivers/infiniband/hw/ehca/ehca_main.c b/drivers/infiniband/hw/ehca/ehca_main.c
index 059da96..cee66b7 100644
--- a/drivers/infiniband/hw/ehca/ehca_main.c
+++ b/drivers/infiniband/hw/ehca/ehca_main.c
@@ -565,11 +565,11 @@ static int __devinit ehca_probe(struct ibmebus_dev *dev,
 				const struct of_device_id *id)
 {
 	struct ehca_shca *shca;
-	u64 *handle;
+	const u64 *handle;
 	struct ib_pd *ibpd;
 	int ret;
 
-	handle = (u64 *)get_property(dev->ofdev.node, "ibm,hca-handle", NULL);
+	handle = get_property(dev->ofdev.node, "ibm,hca-handle", NULL);
 	if (!handle) {
 		ehca_gen_err("Cannot get eHCA handle for adapter: %s.",
 			     dev->ofdev.node->full_name);
diff --git a/drivers/net/ehea/ehea_main.c b/drivers/net/ehea/ehea_main.c
index 0e4042b..d1a8134 100644
--- a/drivers/net/ehea/ehea_main.c
+++ b/drivers/net/ehea/ehea_main.c
@@ -2320,7 +2320,7 @@ static int ehea_setup_single_port(struct ehea_port *port,
 	struct net_device *dev = port->netdev;
 	struct ehea_adapter *adapter = port->adapter;
 	struct hcp_ehea_port_cb4 *cb4;
-	u32 *dn_log_port_id;
+	const u32 *dn_log_port_id;
 	int jumbo = 0;
 
 	sema_init(&port->port_lock, 1);
@@ -2336,7 +2336,7 @@ static int ehea_setup_single_port(struct ehea_port *port,
 	port->of_dev_node = dn;
 
 	/* Determine logical port id */
-	dn_log_port_id = (u32*)get_property(dn, "ibm,hea-port-no", NULL);
+	dn_log_port_id = get_property(dn, "ibm,hea-port-no", NULL);
 
 	if (!dn_log_port_id) {
 		ehea_error("bad device node: dn_log_port_id=%p",
@@ -2492,7 +2492,7 @@ static int __devinit ehea_probe(struct ibmebus_dev *dev,
 				const struct of_device_id *id)
 {
 	struct ehea_adapter *adapter;
-	u64 *adapter_handle;
+	const u64 *adapter_handle;
 	int ret;
 
 	adapter = kzalloc(sizeof(*adapter), GFP_KERNEL);
@@ -2502,7 +2502,7 @@ static int __devinit ehea_probe(struct ibmebus_dev *dev,
 		goto out;
 	}
 
-	adapter_handle = (u64*)get_property(dev->ofdev.node, "ibm,hea-handle",
+	adapter_handle = get_property(dev->ofdev.node, "ibm,hea-handle",
 					    NULL);
 	if (adapter_handle)
 		adapter->handle = *adapter_handle;
diff --git a/drivers/scsi/ibmvscsi/ibmvstgt.c b/drivers/scsi/ibmvscsi/ibmvstgt.c
index 4368ca0..f65f21d 100644
--- a/drivers/scsi/ibmvscsi/ibmvstgt.c
+++ b/drivers/scsi/ibmvscsi/ibmvstgt.c
@@ -897,7 +897,7 @@ static int get_system_info(void)
 {
 	struct device_node *rootdn;
 	const char *id, *model, *name;
-	unsigned int *num;
+	const unsigned int *num;
 
 	rootdn = find_path_device("/");
 	if (!rootdn)
@@ -912,7 +912,7 @@ static int get_system_info(void)
 	if (name)
 		strncpy(partition_name, name, sizeof(partition_name));
 
-	num = (unsigned int *) get_property(rootdn, "ibm,partition-no", NULL);
+	num = get_property(rootdn, "ibm,partition-no", NULL);
 	if (num)
 		partition_number = *num;
 
diff --git a/drivers/video/aty/radeon_pm.c b/drivers/video/aty/radeon_pm.c
index 9a2b0d6..c411293 100644
--- a/drivers/video/aty/radeon_pm.c
+++ b/drivers/video/aty/radeon_pm.c
@@ -1262,7 +1262,7 @@ static void radeon_pm_full_reset_sdram(struct radeonfb_info *rinfo)
 	/* This is the code for the Aluminium PowerBooks M10 / iBooks M11 */
 	if (rinfo->family == CHIP_FAMILY_RV350) {
 		u32 sdram_mode_reg = rinfo->save_regs[35];
-		static u32 default_mrtable[] =
+		static const u32 default_mrtable[] =
 			{ 0x21320032,
 			  0x21321000, 0xa1321000, 0x21321000, 0xffffffff,
 			  0x21320032, 0xa1320032, 0x21320032, 0xffffffff,
diff --git a/sound/aoa/codecs/snd-aoa-codec-onyx.c b/sound/aoa/codecs/snd-aoa-codec-onyx.c
index b00fc48..bf7f031 100644
--- a/sound/aoa/codecs/snd-aoa-codec-onyx.c
+++ b/sound/aoa/codecs/snd-aoa-codec-onyx.c
@@ -1062,9 +1062,9 @@ static int onyx_i2c_attach(struct i2c_adapter *adapter)
 
 	while ((dev = of_get_next_child(busnode, dev)) != NULL) {
 		if (device_is_compatible(dev, "pcm3052")) {
-			u32 *addr;
+			const u32 *addr;
 			printk(KERN_DEBUG PFX "found pcm3052\n");
-			addr = (u32 *) get_property(dev, "reg", NULL);
+			addr = get_property(dev, "reg", NULL);
 			if (!addr)
 				return -ENODEV;
 			return onyx_create(adapter, dev, (*addr)>>1);
diff --git a/sound/aoa/codecs/snd-aoa-codec-tas.c b/sound/aoa/codecs/snd-aoa-codec-tas.c
index 2cd81fa..ed6bdb0 100644
--- a/sound/aoa/codecs/snd-aoa-codec-tas.c
+++ b/sound/aoa/codecs/snd-aoa-codec-tas.c
@@ -939,9 +939,9 @@ static int tas_i2c_attach(struct i2c_adapter *adapter)
 
 	while ((dev = of_get_next_child(busnode, dev)) != NULL) {
 		if (device_is_compatible(dev, "tas3004")) {
-			u32 *addr;
+			const u32 *addr;
 			printk(KERN_DEBUG PFX "found tas3004\n");
-			addr = (u32 *) get_property(dev, "reg", NULL);
+			addr = get_property(dev, "reg", NULL);
 			if (!addr)
 				continue;
 			return tas_create(adapter, dev, ((*addr) >> 1) & 0x7f);
@@ -950,7 +950,8 @@ static int tas_i2c_attach(struct i2c_adapter *adapter)
 		 * property that says 'tas3004', they just have a 'deq'
 		 * node without any such property... */
 		if (strcmp(dev->name, "deq") == 0) {
-			u32 *_addr, addr;
+			const u32 *_addr;
+			u32 addr;
 			printk(KERN_DEBUG PFX "found 'deq' node\n");
 			_addr = (u32 *) get_property(dev, "i2c-address", NULL);
 			if (!_addr)
diff --git a/sound/aoa/core/snd-aoa-gpio-feature.c b/sound/aoa/core/snd-aoa-gpio-feature.c
index 2b03bc7..d34e5db 100644
--- a/sound/aoa/core/snd-aoa-gpio-feature.c
+++ b/sound/aoa/core/snd-aoa-gpio-feature.c
@@ -55,7 +55,7 @@ static struct device_node *get_gpio(char *name,
 				    int *gpioactiveptr)
 {
 	struct device_node *np, *gpio;
-	u32 *reg;
+	const u32 *reg;
 	const char *audio_gpio;
 
 	*gpioptr = -1;
@@ -84,7 +84,7 @@ static struct device_node *get_gpio(char *name,
 			return NULL;
 	}
 
-	reg = (u32 *)get_property(np, "reg", NULL);
+	reg = get_property(np, "reg", NULL);
 	if (!reg)
 		return NULL;
 
@@ -96,7 +96,7 @@ static struct device_node *get_gpio(char *name,
 	if (*gpioptr < 0x50)
 		*gpioptr += 0x50;
 
-	reg = (u32 *)get_property(np, "audio-gpio-active-state", NULL);
+	reg = get_property(np, "audio-gpio-active-state", NULL);
 	if (!reg)
 		/* Apple seems to default to 1, but
 		 * that doesn't seem right at least on most
diff --git a/sound/aoa/fabrics/snd-aoa-fabric-layout.c b/sound/aoa/fabrics/snd-aoa-fabric-layout.c
index 1b94ba6..7e38809 100644
--- a/sound/aoa/fabrics/snd-aoa-fabric-layout.c
+++ b/sound/aoa/fabrics/snd-aoa-fabric-layout.c
@@ -724,7 +724,7 @@ static int check_codec(struct aoa_codec *codec,
 		       struct layout_dev *ldev,
 		       struct codec_connect_info *cci)
 {
-	u32 *ref;
+	const u32 *ref;
 	char propname[32];
 	struct codec_connection *cc;
 
@@ -732,7 +732,7 @@ static int check_codec(struct aoa_codec *codec,
 	if (codec->node && (strcmp(codec->node->name, "codec") == 0)) {
 		snprintf(propname, sizeof(propname),
 			 "platform-%s-codec-ref", codec->name);
-		ref = (u32*)get_property(ldev->sound, propname, NULL);
+		ref = get_property(ldev->sound, propname, NULL);
 		if (!ref) {
 			printk(KERN_INFO "snd-aoa-fabric-layout: "
 				"required property %s not present\n", propname);
diff --git a/sound/aoa/soundbus/core.c b/sound/aoa/soundbus/core.c
index 47b3e37..45680b5 100644
--- a/sound/aoa/soundbus/core.c
+++ b/sound/aoa/soundbus/core.c
@@ -61,9 +61,10 @@ static int soundbus_uevent(struct device *dev, char **envp, int num_envp,
 {
 	struct soundbus_dev * soundbus_dev;
 	struct of_device * of;
-	char *scratch, *compat, *compat2;
+	char *scratch;
+	const char *compat;
 	int i = 0;
-	int length, cplen, cplen2, seen = 0;
+	int length, cplen, seen = 0;
 
 	if (!dev)
 		return -ENODEV;
@@ -95,9 +96,7 @@ static int soundbus_uevent(struct device *dev, char **envp, int num_envp,
 	 * it's not really legal to split it out with commas. We split it
 	 * up using a number of environment variables instead. */
 
-	compat = (char *) get_property(of->node, "compatible", &cplen);
-	compat2 = compat;
-	cplen2= cplen;
+	compat = get_property(of->node, "compatible", &cplen);
 	while (compat && cplen > 0) {
 		envp[i++] = scratch;
 		length = scnprintf (scratch, buffer_size,
diff --git a/sound/aoa/soundbus/i2sbus/i2sbus-core.c b/sound/aoa/soundbus/i2sbus/i2sbus-core.c
index e36f6aa..bbe50a0 100644
--- a/sound/aoa/soundbus/i2sbus/i2sbus-core.c
+++ b/sound/aoa/soundbus/i2sbus/i2sbus-core.c
@@ -122,7 +122,7 @@ static int i2sbus_get_and_fixup_rsrc(struct device_node *np, int index,
 {
 	struct device_node *parent;
 	int pindex, rc = -ENXIO;
-	u32 *reg;
+	const u32 *reg;
 
 	/* Machines with layout 76 and 36 (K2 based) have a weird device
 	 * tree what we need to special case.
@@ -141,7 +141,7 @@ static int i2sbus_get_and_fixup_rsrc(struct device_node *np, int index,
 	rc = of_address_to_resource(parent, pindex, res);
 	if (rc)
 		goto bail;
-	reg = (u32 *)get_property(np, "reg", NULL);
+	reg = get_property(np, "reg", NULL);
 	if (reg == NULL) {
 		rc = -ENXIO;
 		goto bail;
@@ -188,8 +188,7 @@ static int i2sbus_add_dev(struct macio_dev *macio,
 		}
 	}
 	if (i == 1) {
-		u32 *layout_id;
-		layout_id = (u32*) get_property(sound, "layout-id", NULL);
+		const u32 *layout_id = get_property(sound, "layout-id", NULL);
 		if (layout_id) {
 			layout = *layout_id;
 			snprintf(dev->sound.modalias, 32,
diff --git a/sound/oss/dmasound/dmasound_awacs.c b/sound/oss/dmasound/dmasound_awacs.c
index f8a49bd..7aa4d43 100644
--- a/sound/oss/dmasound/dmasound_awacs.c
+++ b/sound/oss/dmasound/dmasound_awacs.c
@@ -578,7 +578,7 @@ tas_mixer_ioctl(u_int cmd, u_long arg)
 }
 
 static void __init
-tas_init_frame_rates(unsigned int *prop, unsigned int l)
+tas_init_frame_rates(const unsigned int *prop, unsigned int l)
 {
 	int i ;
 	if (prop) {
@@ -2651,7 +2651,7 @@ get_expansion_type(void)
 */
 
 static void __init
-awacs_init_frame_rates(unsigned int *prop, unsigned int l)
+awacs_init_frame_rates(const unsigned int *prop, unsigned int l)
 {
 	int i ;
 	if (prop) {
@@ -2674,7 +2674,7 @@ awacs_init_frame_rates(unsigned int *prop, unsigned int l)
 }
 
 static void __init
-burgundy_init_frame_rates(unsigned int *prop, unsigned int l)
+burgundy_init_frame_rates(const unsigned int *prop, unsigned int l)
 {
 	int temp[9] ;
 	int i = 0 ;
@@ -2700,7 +2700,7 @@ if (i > 1){
 }
 
 static void __init
-daca_init_frame_rates(unsigned int *prop, unsigned int l)
+daca_init_frame_rates(const unsigned int *prop, unsigned int l)
 {
 	int temp[9] ;
 	int i = 0 ;
@@ -2727,7 +2727,7 @@ if (i > 1){
 }
 
 static void __init
-init_frame_rates(unsigned int *prop, unsigned int l)
+init_frame_rates(const unsigned int *prop, unsigned int l)
 {
 	switch (awacs_revision) {
 		case AWACS_TUMBLER:
@@ -2972,21 +2972,21 @@ printk("dmasound_pmac: Awacs/Screamer Codec Mfct: %d Rev %d\n", mfg, rev);
 	*/
 
 	if (info) {
-		unsigned int *prop, l;
+		const unsigned int *prop;
+		unsigned int l;
 
 		sound_device_id = 0;
 		/* device ID appears post g3 b&w */
-		prop = (unsigned int *)get_property(info, "device-id", NULL);
+		prop = get_property(info, "device-id", NULL);
 		if (prop != 0)
 			sound_device_id = *prop;
 
 		/* look for a property saying what sample rates
 		   are available */
 
-		prop = (unsigned int *)get_property(info, "sample-rates", &l);
+		prop = get_property(info, "sample-rates", &l);
 		if (prop == 0)
-			prop = (unsigned int *) get_property
-				(info, "output-frame-rates", &l);
+			prop = get_property(info, "output-frame-rates", &l);
 
 		/* if it's there use it to set up frame rates */
 		init_frame_rates(prop, l) ;
diff --git a/sound/oss/dmasound/tas_common.c b/sound/oss/dmasound/tas_common.c
index 665e85b..5e2c0ae 100644
--- a/sound/oss/dmasound/tas_common.c
+++ b/sound/oss/dmasound/tas_common.c
@@ -190,7 +190,7 @@ tas_cleanup(void)
 int __init
 tas_init(int driver_id, const char *driver_name)
 {
-	u32* paddr;
+	const u32* paddr;
 
 	printk(KERN_INFO "tas driver [%s])\n", driver_name);
 
@@ -200,7 +200,7 @@ tas_init(int driver_id, const char *driver_name)
 	tas_node = find_devices("deq");
 	if (tas_node == NULL)
 		return -ENODEV;
-	paddr = (u32 *)get_property(tas_node, "i2c-address", NULL);
+	paddr = get_property(tas_node, "i2c-address", NULL);
 	if (paddr) {
 		tas_i2c_address = (*paddr) >> 1;
 		printk(KERN_INFO "using i2c address: 0x%x from device-tree\n",
-- 
1.5.0.3

Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 0674BDDF0C
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 22:52:36 +1000 (EST)
Date: Tue, 3 Apr 2007 22:39:14 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 09/17] [POWERPC] Rename get_property to of_get_property: sound
Message-Id: <20070403223914.35bf04e1.sfr@canb.auug.org.au>
In-Reply-To: <20070403223738.03386a13.sfr@canb.auug.org.au>
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
 sound/aoa/codecs/snd-aoa-codec-onyx.c     |    2 +-
 sound/aoa/codecs/snd-aoa-codec-tas.c      |    4 ++--
 sound/aoa/core/snd-aoa-gpio-feature.c     |    6 +++---
 sound/aoa/fabrics/snd-aoa-fabric-layout.c |    6 +++---
 sound/aoa/soundbus/core.c                 |    2 +-
 sound/aoa/soundbus/i2sbus/i2sbus-core.c   |    5 +++--
 sound/oss/dmasound/dmasound_awacs.c       |   12 ++++++------
 sound/oss/dmasound/tas_common.c           |    2 +-
 sound/ppc/pmac.c                          |   14 +++++++-------
 sound/ppc/tumbler.c                       |   20 ++++++++++----------
 10 files changed, 37 insertions(+), 36 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/sound/aoa/codecs/snd-aoa-codec-onyx.c b/sound/aoa/codecs/snd-aoa-codec-onyx.c
index bf7f031..7f980be 100644
--- a/sound/aoa/codecs/snd-aoa-codec-onyx.c
+++ b/sound/aoa/codecs/snd-aoa-codec-onyx.c
@@ -1064,7 +1064,7 @@ static int onyx_i2c_attach(struct i2c_adapter *adapter)
 		if (device_is_compatible(dev, "pcm3052")) {
 			const u32 *addr;
 			printk(KERN_DEBUG PFX "found pcm3052\n");
-			addr = get_property(dev, "reg", NULL);
+			addr = of_get_property(dev, "reg", NULL);
 			if (!addr)
 				return -ENODEV;
 			return onyx_create(adapter, dev, (*addr)>>1);
diff --git a/sound/aoa/codecs/snd-aoa-codec-tas.c b/sound/aoa/codecs/snd-aoa-codec-tas.c
index ed6bdb0..ceca384 100644
--- a/sound/aoa/codecs/snd-aoa-codec-tas.c
+++ b/sound/aoa/codecs/snd-aoa-codec-tas.c
@@ -941,7 +941,7 @@ static int tas_i2c_attach(struct i2c_adapter *adapter)
 		if (device_is_compatible(dev, "tas3004")) {
 			const u32 *addr;
 			printk(KERN_DEBUG PFX "found tas3004\n");
-			addr = get_property(dev, "reg", NULL);
+			addr = of_get_property(dev, "reg", NULL);
 			if (!addr)
 				continue;
 			return tas_create(adapter, dev, ((*addr) >> 1) & 0x7f);
@@ -953,7 +953,7 @@ static int tas_i2c_attach(struct i2c_adapter *adapter)
 			const u32 *_addr;
 			u32 addr;
 			printk(KERN_DEBUG PFX "found 'deq' node\n");
-			_addr = (u32 *) get_property(dev, "i2c-address", NULL);
+			_addr = of_get_property(dev, "i2c-address", NULL);
 			if (!_addr)
 				continue;
 			addr = ((*_addr) >> 1) & 0x7f;
diff --git a/sound/aoa/core/snd-aoa-gpio-feature.c b/sound/aoa/core/snd-aoa-gpio-feature.c
index d34e5db..805dcbf 100644
--- a/sound/aoa/core/snd-aoa-gpio-feature.c
+++ b/sound/aoa/core/snd-aoa-gpio-feature.c
@@ -71,7 +71,7 @@ static struct device_node *get_gpio(char *name,
 		if (!gpio)
 			return NULL;
 		while ((np = of_get_next_child(gpio, np))) {
-			audio_gpio = get_property(np, "audio-gpio", NULL);
+			audio_gpio = of_get_property(np, "audio-gpio", NULL);
 			if (!audio_gpio)
 				continue;
 			if (strcmp(audio_gpio, name) == 0)
@@ -84,7 +84,7 @@ static struct device_node *get_gpio(char *name,
 			return NULL;
 	}
 
-	reg = get_property(np, "reg", NULL);
+	reg = of_get_property(np, "reg", NULL);
 	if (!reg)
 		return NULL;
 
@@ -96,7 +96,7 @@ static struct device_node *get_gpio(char *name,
 	if (*gpioptr < 0x50)
 		*gpioptr += 0x50;
 
-	reg = get_property(np, "audio-gpio-active-state", NULL);
+	reg = of_get_property(np, "audio-gpio-active-state", NULL);
 	if (!reg)
 		/* Apple seems to default to 1, but
 		 * that doesn't seem right at least on most
diff --git a/sound/aoa/fabrics/snd-aoa-fabric-layout.c b/sound/aoa/fabrics/snd-aoa-fabric-layout.c
index 7e38809..9880628 100644
--- a/sound/aoa/fabrics/snd-aoa-fabric-layout.c
+++ b/sound/aoa/fabrics/snd-aoa-fabric-layout.c
@@ -732,7 +732,7 @@ static int check_codec(struct aoa_codec *codec,
 	if (codec->node && (strcmp(codec->node->name, "codec") == 0)) {
 		snprintf(propname, sizeof(propname),
 			 "platform-%s-codec-ref", codec->name);
-		ref = get_property(ldev->sound, propname, NULL);
+		ref = of_get_property(ldev->sound, propname, NULL);
 		if (!ref) {
 			printk(KERN_INFO "snd-aoa-fabric-layout: "
 				"required property %s not present\n", propname);
@@ -946,7 +946,7 @@ static struct aoa_fabric layout_fabric = {
 static int aoa_fabric_layout_probe(struct soundbus_dev *sdev)
 {
 	struct device_node *sound = NULL;
-	unsigned int *layout_id;
+	const unsigned int *layout_id;
 	struct layout *layout;
 	struct layout_dev *ldev = NULL;
 	int err;
@@ -962,7 +962,7 @@ static int aoa_fabric_layout_probe(struct soundbus_dev *sdev)
 	}
 	if (!sound) return -ENODEV;
 
-	layout_id = (unsigned int *) get_property(sound, "layout-id", NULL);
+	layout_id = of_get_property(sound, "layout-id", NULL);
 	if (!layout_id)
 		goto outnodev;
 	printk(KERN_INFO "snd-aoa-fabric-layout: found bus with layout %d\n",
diff --git a/sound/aoa/soundbus/core.c b/sound/aoa/soundbus/core.c
index 45680b5..6f004f7 100644
--- a/sound/aoa/soundbus/core.c
+++ b/sound/aoa/soundbus/core.c
@@ -96,7 +96,7 @@ static int soundbus_uevent(struct device *dev, char **envp, int num_envp,
 	 * it's not really legal to split it out with commas. We split it
 	 * up using a number of environment variables instead. */
 
-	compat = get_property(of->node, "compatible", &cplen);
+	compat = of_get_property(of->node, "compatible", &cplen);
 	while (compat && cplen > 0) {
 		envp[i++] = scratch;
 		length = scnprintf (scratch, buffer_size,
diff --git a/sound/aoa/soundbus/i2sbus/i2sbus-core.c b/sound/aoa/soundbus/i2sbus/i2sbus-core.c
index bbe50a0..79fc4bc 100644
--- a/sound/aoa/soundbus/i2sbus/i2sbus-core.c
+++ b/sound/aoa/soundbus/i2sbus/i2sbus-core.c
@@ -141,7 +141,7 @@ static int i2sbus_get_and_fixup_rsrc(struct device_node *np, int index,
 	rc = of_address_to_resource(parent, pindex, res);
 	if (rc)
 		goto bail;
-	reg = get_property(np, "reg", NULL);
+	reg = of_get_property(np, "reg", NULL);
 	if (reg == NULL) {
 		rc = -ENXIO;
 		goto bail;
@@ -188,7 +188,8 @@ static int i2sbus_add_dev(struct macio_dev *macio,
 		}
 	}
 	if (i == 1) {
-		const u32 *layout_id = get_property(sound, "layout-id", NULL);
+		const u32 *layout_id =
+			of_get_property(sound, "layout-id", NULL);
 		if (layout_id) {
 			layout = *layout_id;
 			snprintf(dev->sound.modalias, 32,
diff --git a/sound/oss/dmasound/dmasound_awacs.c b/sound/oss/dmasound/dmasound_awacs.c
index 7aa4d43..977b91c 100644
--- a/sound/oss/dmasound/dmasound_awacs.c
+++ b/sound/oss/dmasound/dmasound_awacs.c
@@ -357,7 +357,7 @@ setup_audio_gpio(const char *name, const char* compatible, int *gpio_addr, int*
 	while(np != 0) {
 		if (name) {
 			const char *property =
-				get_property(np,"audio-gpio",NULL);
+				of_get_property(np,"audio-gpio",NULL);
 			if (property != 0 && strcmp(property,name) == 0)
 				break;
 		} else if (compatible && device_is_compatible(np, compatible))
@@ -366,11 +366,11 @@ setup_audio_gpio(const char *name, const char* compatible, int *gpio_addr, int*
 	}
 	if (!np)
 		return -ENODEV;
-	pp = get_property(np, "AAPL,address", NULL);
+	pp = of_get_property(np, "AAPL,address", NULL);
 	if (!pp)
 		return -ENODEV;
 	*gpio_addr = (*pp) & 0x0000ffff;
-	pp = get_property(np, "audio-gpio-active-state", NULL);
+	pp = of_get_property(np, "audio-gpio-active-state", NULL);
 	if (pp)
 		*gpio_pol = *pp;
 	else
@@ -2977,16 +2977,16 @@ printk("dmasound_pmac: Awacs/Screamer Codec Mfct: %d Rev %d\n", mfg, rev);
 
 		sound_device_id = 0;
 		/* device ID appears post g3 b&w */
-		prop = get_property(info, "device-id", NULL);
+		prop = of_get_property(info, "device-id", NULL);
 		if (prop != 0)
 			sound_device_id = *prop;
 
 		/* look for a property saying what sample rates
 		   are available */
 
-		prop = get_property(info, "sample-rates", &l);
+		prop = of_get_property(info, "sample-rates", &l);
 		if (prop == 0)
-			prop = get_property(info, "output-frame-rates", &l);
+			prop = of_get_property(info, "output-frame-rates", &l);
 
 		/* if it's there use it to set up frame rates */
 		init_frame_rates(prop, l) ;
diff --git a/sound/oss/dmasound/tas_common.c b/sound/oss/dmasound/tas_common.c
index 5e2c0ae..1125760 100644
--- a/sound/oss/dmasound/tas_common.c
+++ b/sound/oss/dmasound/tas_common.c
@@ -200,7 +200,7 @@ tas_init(int driver_id, const char *driver_name)
 	tas_node = find_devices("deq");
 	if (tas_node == NULL)
 		return -ENODEV;
-	paddr = get_property(tas_node, "i2c-address", NULL);
+	paddr = of_get_property(tas_node, "i2c-address", NULL);
 	if (paddr) {
 		tas_i2c_address = (*paddr) >> 1;
 		printk(KERN_INFO "using i2c address: 0x%x from device-tree\n",
diff --git a/sound/ppc/pmac.c b/sound/ppc/pmac.c
index c64af55..5e82968 100644
--- a/sound/ppc/pmac.c
+++ b/sound/ppc/pmac.c
@@ -864,7 +864,8 @@ static void __init detect_byte_swap(struct snd_pmac *chip)
 static int __init snd_pmac_detect(struct snd_pmac *chip)
 {
 	struct device_node *sound = NULL;
-	unsigned int *prop, l;
+	const unsigned int *prop;
+	unsigned int l;
 	struct macio_chip* macio;
 
 	if (!machine_is(powermac))
@@ -923,10 +924,10 @@ static int __init snd_pmac_detect(struct snd_pmac *chip)
 	}
 	if (! sound)
 		return -ENODEV;
-	prop = (unsigned int *) get_property(sound, "sub-frame", NULL);
+	prop = of_get_property(sound, "sub-frame", NULL);
 	if (prop && *prop < 16)
 		chip->subframe = *prop;
-	prop = (unsigned int *) get_property(sound, "layout-id", NULL);
+	prop = of_get_property(sound, "layout-id", NULL);
 	if (prop) {
 		/* partly deprecate snd-powermac, for those machines
 		 * that have a layout-id property for now */
@@ -967,7 +968,7 @@ static int __init snd_pmac_detect(struct snd_pmac *chip)
 		chip->freq_table = tumbler_freqs;
 		chip->control_mask = MASK_IEPC | 0x11; /* disable IEE */
 	}
-	prop = (unsigned int *)get_property(sound, "device-id", NULL);
+	prop = of_get_property(sound, "device-id", NULL);
 	if (prop)
 		chip->device_id = *prop;
 	chip->has_iic = (find_devices("perch") != NULL);
@@ -997,10 +998,9 @@ static int __init snd_pmac_detect(struct snd_pmac *chip)
 
 	/* look for a property saying what sample rates
 	   are available */
-	prop = (unsigned int *) get_property(sound, "sample-rates", &l);
+	prop = of_get_property(sound, "sample-rates", &l);
 	if (! prop)
-		prop = (unsigned int *) get_property(sound,
-						     "output-frame-rates", &l);
+		prop = of_get_property(sound, "output-frame-rates", &l);
 	if (prop) {
 		int i;
 		chip->freqs_ok = 0;
diff --git a/sound/ppc/tumbler.c b/sound/ppc/tumbler.c
index 8f074c7..8e01b55 100644
--- a/sound/ppc/tumbler.c
+++ b/sound/ppc/tumbler.c
@@ -1037,7 +1037,7 @@ static struct device_node *find_audio_device(const char *name)
 		return NULL;
   
 	for (np = np->child; np; np = np->sibling) {
-		const char *property = get_property(np, "audio-gpio", NULL);
+		const char *property = of_get_property(np, "audio-gpio", NULL);
 		if (property && strcmp(property, name) == 0)
 			return np;
 	}  
@@ -1077,9 +1077,9 @@ static long tumbler_find_device(const char *device, const char *platform,
 		return -ENODEV;
 	}
 
-	base = get_property(node, "AAPL,address", NULL);
+	base = of_get_property(node, "AAPL,address", NULL);
 	if (! base) {
-		base = get_property(node, "reg", NULL);
+		base = of_get_property(node, "reg", NULL);
 		if (!base) {
 			DBG("(E) cannot find address for device %s !\n", device);
 			snd_printd("cannot find address for device %s\n", device);
@@ -1093,7 +1093,7 @@ static long tumbler_find_device(const char *device, const char *platform,
 
 	gp->addr = addr & 0x0000ffff;
 	/* Try to find the active state, default to 0 ! */
-	base = get_property(node, "audio-gpio-active-state", NULL);
+	base = of_get_property(node, "audio-gpio-active-state", NULL);
 	if (base) {
 		gp->active_state = *base;
 		gp->active_val = (*base) ? 0x5 : 0x4;
@@ -1108,7 +1108,7 @@ static long tumbler_find_device(const char *device, const char *platform,
 		 * as we don't yet have an interpreter for these things
 		 */
 		if (platform)
-			prop = get_property(node, platform, NULL);
+			prop = of_get_property(node, platform, NULL);
 		if (prop) {
 			if (prop[3] == 0x9 && prop[4] == 0x9) {
 				gp->active_val = 0xd;
@@ -1310,7 +1310,7 @@ int __init snd_pmac_tumbler_init(struct snd_pmac *chip)
 {
 	int i, err;
 	struct pmac_tumbler *mix;
-	u32 *paddr;
+	const u32 *paddr;
 	struct device_node *tas_node, *np;
 	char *chipname;
 
@@ -1331,9 +1331,9 @@ int __init snd_pmac_tumbler_init(struct snd_pmac *chip)
 
 	for (np = chip->node->child; np; np = np->sibling) {
 		if (!strcmp(np->name, "sound")) {
-			if (get_property(np, "has-anded-reset", NULL))
+			if (of_get_property(np, "has-anded-reset", NULL))
 				mix->anded_reset = 1;
-			if (get_property(np, "layout-id", NULL))
+			if (of_get_property(np, "layout-id", NULL))
 				mix->reset_on_sleep = 0;
 			break;
 		}
@@ -1348,9 +1348,9 @@ int __init snd_pmac_tumbler_init(struct snd_pmac *chip)
 	if (tas_node == NULL)
 		return -ENODEV;
 
-	paddr = (u32 *)get_property(tas_node, "i2c-address", NULL);
+	paddr = of_get_property(tas_node, "i2c-address", NULL);
 	if (paddr == NULL)
-		paddr = (u32 *)get_property(tas_node, "reg", NULL);
+		paddr = of_get_property(tas_node, "reg", NULL);
 	if (paddr)
 		mix->i2c.addr = (*paddr) >> 1;
 	else
-- 
1.5.0.3

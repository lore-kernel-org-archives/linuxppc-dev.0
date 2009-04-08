Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 95327DDFB3
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Apr 2009 23:29:36 +1000 (EST)
Date: Wed, 8 Apr 2009 15:02:49 +0200
From: Jean Delvare <khali@linux-fr.org>
To: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] AOA: Convert onyx and tas codecs to new-style i2c drivers
Message-ID: <20090408150249.5a62a56c@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

The legacy i2c model is going away soon, the remaining drivers that
still use it need to be converted very quickly. There are 3 sound
drivers remaining:

sound/aoa/codecs/onyx.c
sound/aoa/codecs/tas.c
sound/ppc/keywest.c

I've given a try to the former two, patch below. I could only
build-test it, so I would appreciate if anyone with supported hardware
could test the patch. I also welcome reviews and comments, of course. I
am not familiar with PowerPC so I might as well have done it wrong.

Basically the idea is to move the I2C device instantiation from the
codec drivers (onyx, tas) to the I2C adapter driver (i2c-powermac.)
This follows the Linux device driver model, requires slightly less
code, runs faster and and lets the required chip drivers be loaded by
udev or similar automatically.

The last driver to convert, keywest, is a mystery to me. I have a hard
time understanding how it interacts with tumbler and daca. I have the
feeling that it is essentially a glue module to workaround the legacy
i2c model limitations, so probably it could go away entirely now, but
I'm not sure how to do that in practice. Maybe tumbler and daca would
be made separate i2c drivers, I'm not sure.

One thing in particular which I find strange is that tumbler has
references to the TAS3004 device, much like the tas codec driver. It is
unclear to me whether tas is a replacement for tumbler, or if both
drivers work together, or if they are for separate hardware. I would
appreciate clarifications about this.

Thanks.

* * * * *

The legacy i2c binding model is going away soon, so convert the AOA
codec drivers to the new model or they'll break.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/i2c/busses/i2c-powermac.c |   76 +++++++++++++++++++++++++++++++
 sound/aoa/codecs/onyx.c           |   77 +++++++-------------------------
 sound/aoa/codecs/tas.c            |   89 +++++++++----------------------------
 3 files changed, 116 insertions(+), 126 deletions(-)

--- linux-2.6.30-rc1.orig/drivers/i2c/busses/i2c-powermac.c	2009-04-08 08:52:48.000000000 +0200
+++ linux-2.6.30-rc1/drivers/i2c/busses/i2c-powermac.c	2009-04-08 13:48:31.000000000 +0200
@@ -204,7 +204,7 @@ static int __devexit i2c_powermac_remove
 static int __devinit i2c_powermac_probe(struct platform_device *dev)
 {
 	struct pmac_i2c_bus *bus = dev->dev.platform_data;
-	struct device_node *parent = NULL;
+	struct device_node *parent = NULL, *busnode, *devnode;
 	struct i2c_adapter *adapter;
 	char name[32];
 	const char *basename;
@@ -212,6 +212,7 @@ static int __devinit i2c_powermac_probe(
 
 	if (bus == NULL)
 		return -EINVAL;
+	busnode = pmac_i2c_get_bus_node(bus);
 
 	/* Ok, now we need to make up a name for the interface that will
 	 * match what we used to do in the past, that is basically the
@@ -289,6 +290,79 @@ static int __devinit i2c_powermac_probe(
 		}
 	}
 
+	devnode = NULL;
+	while ((devnode = of_get_next_child(busnode, devnode)) != NULL) {
+		struct i2c_board_info info;
+		const u32 *addr;
+
+		/* Instantiate I2C sound device if present */
+		if (of_device_is_compatible(devnode, "pcm3052")) {
+			printk(KERN_DEBUG "i2c-powermac: found pcm3052\n");
+			addr = of_get_property(devnode, "reg", NULL);
+			if (!addr)
+				continue;
+
+			memset(&info, 0, sizeof(struct i2c_board_info));
+			info.addr = (*addr) >> 1;
+			strlcpy(info.type, "aoa_codec_onyx", I2C_NAME_SIZE);
+			info.platform_data = devnode;
+			i2c_new_device(adapter, &info);
+			continue;
+		}
+
+		if (of_device_is_compatible(devnode, "tas3004")) {
+			printk(KERN_DEBUG "i2c-powermac: found tas3004\n");
+			addr = of_get_property(devnode, "reg", NULL);
+			if (!addr)
+				continue;
+
+			memset(&info, 0, sizeof(struct i2c_board_info));
+			info.addr = ((*addr) >> 1) & 0x7f;
+			strlcpy(info.type, "aoa_codec_tas", I2C_NAME_SIZE);
+			info.platform_data = devnode;
+			i2c_new_device(adapter, &info);
+			continue;
+		}
+
+		/* older machines have no 'codec' node with a 'compatible'
+		 * property that says 'tas3004', they just have a 'deq'
+		 * node without any such property... */
+		if (strcmp(devnode->name, "deq") == 0) {
+			printk(KERN_DEBUG "i2c-powermac: found 'deq' node\n");
+			addr = of_get_property(devnode, "i2c-address", NULL);
+			if (!addr)
+				continue;
+
+			memset(&info, 0, sizeof(struct i2c_board_info));
+			info.addr = ((*addr) >> 1) & 0x7f;
+			/* now, if the address doesn't match any of the two
+			 * that a tas3004 can have, we cannot handle this.
+			 * I doubt it ever happens but hey. */
+			if (info.addr != 0x34 && info.addr != 0x35)
+				continue;
+			strlcpy(info.type, "aoa_codec_tas", I2C_NAME_SIZE);
+			info.platform_data = devnode;
+			i2c_new_device(adapter, &info);
+			continue;
+		}
+
+		/* if that didn't work, try desperate mode for older
+		 * machines that have stuff missing from the device tree */
+		if (of_device_is_compatible(busnode, "k2-i2c")) {
+			unsigned short probe_onyx[] = {
+				0x46, 0x47, I2C_CLIENT_END
+			};
+
+			printk(KERN_DEBUG "i2c-powermac: found k2-i2c, "
+			       "checking if onyx chip is on it\n");
+
+			memset(&info, 0, sizeof(struct i2c_board_info));
+			strlcpy(info.type, "aoa_codec_onyx", I2C_NAME_SIZE);
+			info.platform_data = devnode;
+			i2c_new_probed_device(adapter, &info, probe_onyx);
+		}
+	}
+
 	return rc;
 }
 
--- linux-2.6.30-rc1.orig/sound/aoa/codecs/onyx.c	2009-03-26 15:08:13.000000000 +0100
+++ linux-2.6.30-rc1/sound/aoa/codecs/onyx.c	2009-04-08 13:50:11.000000000 +0200
@@ -47,7 +47,7 @@ MODULE_DESCRIPTION("pcm3052 (onyx) codec
 struct onyx {
 	/* cache registers 65 to 80, they are write-only! */
 	u8			cache[16];
-	struct i2c_client	i2c;
+	struct i2c_client	*i2c;
 	struct aoa_codec	codec;
 	u32			initialised:1,
 				spdif_locked:1,
@@ -72,7 +72,7 @@ static int onyx_read_register(struct ony
 		*value = onyx->cache[reg-FIRSTREGISTER];
 		return 0;
 	}
-	v = i2c_smbus_read_byte_data(&onyx->i2c, reg);
+	v = i2c_smbus_read_byte_data(onyx->i2c, reg);
 	if (v < 0)
 		return -1;
 	*value = (u8)v;
@@ -84,7 +84,7 @@ static int onyx_write_register(struct on
 {
 	int result;
 
-	result = i2c_smbus_write_byte_data(&onyx->i2c, reg, value);
+	result = i2c_smbus_write_byte_data(onyx->i2c, reg, value);
 	if (!result)
 		onyx->cache[reg-FIRSTREGISTER] = value;
 	return result;
@@ -998,10 +998,10 @@ static void onyx_exit_codec(struct aoa_c
 
 static struct i2c_driver onyx_driver;
 
-static int onyx_create(struct i2c_adapter *adapter,
-		       struct device_node *node,
-		       int addr)
+static int onyx_i2c_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
 {
+	struct device_node *node = client->dev.platform_data;
 	struct onyx *onyx;
 	u8 dummy;
 
@@ -1011,20 +1011,12 @@ static int onyx_create(struct i2c_adapte
 		return -ENOMEM;
 
 	mutex_init(&onyx->mutex);
-	onyx->i2c.driver = &onyx_driver;
-	onyx->i2c.adapter = adapter;
-	onyx->i2c.addr = addr & 0x7f;
-	strlcpy(onyx->i2c.name, "onyx audio codec", I2C_NAME_SIZE);
-
-	if (i2c_attach_client(&onyx->i2c)) {
-		printk(KERN_ERR PFX "failed to attach to i2c\n");
-		goto fail;
-	}
+	onyx->i2c = client;
+	i2c_set_clientdata(client, onyx);
 
 	/* we try to read from register ONYX_REG_CONTROL
 	 * to check if the codec is present */
 	if (onyx_read_register(onyx, ONYX_REG_CONTROL, &dummy) != 0) {
-		i2c_detach_client(&onyx->i2c);
 		printk(KERN_ERR PFX "failed to read control register\n");
 		goto fail;
 	}
@@ -1036,7 +1028,6 @@ static int onyx_create(struct i2c_adapte
 	onyx->codec.node = of_node_get(node);
 
 	if (aoa_codec_register(&onyx->codec)) {
-		i2c_detach_client(&onyx->i2c);
 		goto fail;
 	}
 	printk(KERN_DEBUG PFX "created and attached onyx instance\n");
@@ -1046,47 +1037,10 @@ static int onyx_create(struct i2c_adapte
 	return -EINVAL;
 }
 
-static int onyx_i2c_attach(struct i2c_adapter *adapter)
+static int onyx_i2c_remove(struct i2c_client *client)
 {
-	struct device_node *busnode, *dev = NULL;
-	struct pmac_i2c_bus *bus;
-
-	bus = pmac_i2c_adapter_to_bus(adapter);
-	if (bus == NULL)
-		return -ENODEV;
-	busnode = pmac_i2c_get_bus_node(bus);
+	struct onyx *onyx = i2c_get_clientdata(client);
 
-	while ((dev = of_get_next_child(busnode, dev)) != NULL) {
-		if (of_device_is_compatible(dev, "pcm3052")) {
-			const u32 *addr;
-			printk(KERN_DEBUG PFX "found pcm3052\n");
-			addr = of_get_property(dev, "reg", NULL);
-			if (!addr)
-				return -ENODEV;
-			return onyx_create(adapter, dev, (*addr)>>1);
-		}
-	}
-
-	/* if that didn't work, try desperate mode for older
-	 * machines that have stuff missing from the device tree */
-
-	if (!of_device_is_compatible(busnode, "k2-i2c"))
-		return -ENODEV;
-
-	printk(KERN_DEBUG PFX "found k2-i2c, checking if onyx chip is on it\n");
-	/* probe both possible addresses for the onyx chip */
-	if (onyx_create(adapter, NULL, 0x46) == 0)
-		return 0;
-	return onyx_create(adapter, NULL, 0x47);
-}
-
-static int onyx_i2c_detach(struct i2c_client *client)
-{
-	struct onyx *onyx = container_of(client, struct onyx, i2c);
-	int err;
-
-	if ((err = i2c_detach_client(client)))
-		return err;
 	aoa_codec_unregister(&onyx->codec);
 	of_node_put(onyx->codec.node);
 	if (onyx->codec_info)
@@ -1095,13 +1049,20 @@ static int onyx_i2c_detach(struct i2c_cl
 	return 0;
 }
 
+static const struct i2c_device_id onyx_i2c_id[] = {
+	{ "aoa_codec_onyx", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, onyx_i2c_id);
+
 static struct i2c_driver onyx_driver = {
 	.driver = {
 		.name = "aoa_codec_onyx",
 		.owner = THIS_MODULE,
 	},
-	.attach_adapter = onyx_i2c_attach,
-	.detach_client = onyx_i2c_detach,
+	.probe = onyx_i2c_probe,
+	.remove = onyx_i2c_remove,
+	.id_table = onyx_i2c_id,
 };
 
 static int __init onyx_init(void)
--- linux-2.6.30-rc1.orig/sound/aoa/codecs/tas.c	2009-03-24 13:44:06.000000000 +0100
+++ linux-2.6.30-rc1/sound/aoa/codecs/tas.c	2009-04-08 13:50:22.000000000 +0200
@@ -82,7 +82,7 @@ MODULE_DESCRIPTION("tas codec driver for
 
 struct tas {
 	struct aoa_codec	codec;
-	struct i2c_client	i2c;
+	struct i2c_client	*i2c;
 	u32			mute_l:1, mute_r:1 ,
 				controls_created:1 ,
 				drc_enabled:1,
@@ -108,9 +108,9 @@ static struct tas *codec_to_tas(struct a
 static inline int tas_write_reg(struct tas *tas, u8 reg, u8 len, u8 *data)
 {
 	if (len == 1)
-		return i2c_smbus_write_byte_data(&tas->i2c, reg, *data);
+		return i2c_smbus_write_byte_data(tas->i2c, reg, *data);
 	else
-		return i2c_smbus_write_i2c_block_data(&tas->i2c, reg, len, data);
+		return i2c_smbus_write_i2c_block_data(tas->i2c, reg, len, data);
 }
 
 static void tas3004_set_drc(struct tas *tas)
@@ -884,10 +884,10 @@ static void tas_exit_codec(struct aoa_co
 
 static struct i2c_driver tas_driver;
 
-static int tas_create(struct i2c_adapter *adapter,
-		       struct device_node *node,
-		       int addr)
+static int tas_i2c_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
 {
+	struct device_node *node = client->dev.platform_data;
 	struct tas *tas;
 
 	tas = kzalloc(sizeof(struct tas), GFP_KERNEL);
@@ -896,17 +896,11 @@ static int tas_create(struct i2c_adapter
 		return -ENOMEM;
 
 	mutex_init(&tas->mtx);
-	tas->i2c.driver = &tas_driver;
-	tas->i2c.adapter = adapter;
-	tas->i2c.addr = addr;
+	tas->i2c = client;
+	i2c_set_clientdata(client, tas);
+
 	/* seems that half is a saner default */
 	tas->drc_range = TAS3004_DRC_MAX / 2;
-	strlcpy(tas->i2c.name, "tas audio codec", I2C_NAME_SIZE);
-
-	if (i2c_attach_client(&tas->i2c)) {
-		printk(KERN_ERR PFX "failed to attach to i2c\n");
-		goto fail;
-	}
 
 	strlcpy(tas->codec.name, "tas", MAX_CODEC_NAME_LEN);
 	tas->codec.owner = THIS_MODULE;
@@ -915,69 +909,23 @@ static int tas_create(struct i2c_adapter
 	tas->codec.node = of_node_get(node);
 
 	if (aoa_codec_register(&tas->codec)) {
-		goto detach;
+		goto fail;
 	}
 	printk(KERN_DEBUG
 	       "snd-aoa-codec-tas: tas found, addr 0x%02x on %s\n",
-	       addr, node->full_name);
+	       (unsigned int)client->addr, node->full_name);
 	return 0;
- detach:
-	i2c_detach_client(&tas->i2c);
  fail:
 	mutex_destroy(&tas->mtx);
 	kfree(tas);
 	return -EINVAL;
 }
 
-static int tas_i2c_attach(struct i2c_adapter *adapter)
-{
-	struct device_node *busnode, *dev = NULL;
-	struct pmac_i2c_bus *bus;
-
-	bus = pmac_i2c_adapter_to_bus(adapter);
-	if (bus == NULL)
-		return -ENODEV;
-	busnode = pmac_i2c_get_bus_node(bus);
-
-	while ((dev = of_get_next_child(busnode, dev)) != NULL) {
-		if (of_device_is_compatible(dev, "tas3004")) {
-			const u32 *addr;
-			printk(KERN_DEBUG PFX "found tas3004\n");
-			addr = of_get_property(dev, "reg", NULL);
-			if (!addr)
-				continue;
-			return tas_create(adapter, dev, ((*addr) >> 1) & 0x7f);
-		}
-		/* older machines have no 'codec' node with a 'compatible'
-		 * property that says 'tas3004', they just have a 'deq'
-		 * node without any such property... */
-		if (strcmp(dev->name, "deq") == 0) {
-			const u32 *_addr;
-			u32 addr;
-			printk(KERN_DEBUG PFX "found 'deq' node\n");
-			_addr = of_get_property(dev, "i2c-address", NULL);
-			if (!_addr)
-				continue;
-			addr = ((*_addr) >> 1) & 0x7f;
-			/* now, if the address doesn't match any of the two
-			 * that a tas3004 can have, we cannot handle this.
-			 * I doubt it ever happens but hey. */
-			if (addr != 0x34 && addr != 0x35)
-				continue;
-			return tas_create(adapter, dev, addr);
-		}
-	}
-	return -ENODEV;
-}
-
-static int tas_i2c_detach(struct i2c_client *client)
+static int tas_i2c_remove(struct i2c_client *client)
 {
-	struct tas *tas = container_of(client, struct tas, i2c);
-	int err;
+	struct tas *tas = i2c_get_clientdata(client);
 	u8 tmp = TAS_ACR_ANALOG_PDOWN;
 
-	if ((err = i2c_detach_client(client)))
-		return err;
 	aoa_codec_unregister(&tas->codec);
 	of_node_put(tas->codec.node);
 
@@ -989,13 +937,20 @@ static int tas_i2c_detach(struct i2c_cli
 	return 0;
 }
 
+static const struct i2c_device_id tas_i2c_id[] = {
+	{ "aoa_codec_tas", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, tas_i2c_id);
+
 static struct i2c_driver tas_driver = {
 	.driver = {
 		.name = "aoa_codec_tas",
 		.owner = THIS_MODULE,
 	},
-	.attach_adapter = tas_i2c_attach,
-	.detach_client = tas_i2c_detach,
+	.probe = tas_i2c_probe,
+	.remove = tas_i2c_remove,
+	.id_table = tas_i2c_id,
 };
 
 static int __init tas_init(void)


-- 
Jean Delvare

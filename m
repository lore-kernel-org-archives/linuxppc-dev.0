Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 88FB6DDDA2
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 06:54:40 +1000 (EST)
Date: Mon, 20 Apr 2009 22:54:25 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] AOA: Convert onyx and tas codecs to new-style i2c drivers
Message-ID: <20090420225425.2a150a4f@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Benjamin, alsa-devel@alsa-project.org, linuxppc-dev@ozlabs.org,
	Andreas Schwab <schwab@linux-m68k.org>,
	Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The legacy i2c binding model is going away soon, so convert the AOA
codec drivers to the new model or they'll break.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Tested-by: Johannes Berg <johannes@sipsolutions.net>
Tested-by: Andreas Schwab <schwab@linux-m68k.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Takashi Iwai <tiwai@suse.de>
---
Takashi, please push this patch to Linus quickly, as this is blocking
the removal of the legacy i2c binding model, which is scheduled for
2.6.30.

 sound/aoa/codecs/onyx.c |   76 ++++++++++++++++++++++++++++++++---------------
 sound/aoa/codecs/tas.c  |   66 +++++++++++++++++++++++++---------------
 2 files changed, 95 insertions(+), 47 deletions(-)

--- linux-2.6.30-rc2.orig/sound/aoa/codecs/onyx.c	2009-04-15 09:55:20.000000000 +0200
+++ linux-2.6.30-rc2/sound/aoa/codecs/onyx.c	2009-04-15 14:07:50.000000000 +0200
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
@@ -996,12 +996,45 @@ static void onyx_exit_codec(struct aoa_c
 	onyx->codec.soundbus_dev->detach_codec(onyx->codec.soundbus_dev, onyx);
 }
 
-static struct i2c_driver onyx_driver;
-
 static int onyx_create(struct i2c_adapter *adapter,
 		       struct device_node *node,
 		       int addr)
 {
+	struct i2c_board_info info;
+	struct i2c_client *client;
+
+	memset(&info, 0, sizeof(struct i2c_board_info));
+	strlcpy(info.type, "aoa_codec_onyx", I2C_NAME_SIZE);
+	info.addr = addr;
+	info.platform_data = node;
+	client = i2c_new_device(adapter, &info);
+	if (!client)
+		return -ENODEV;
+
+	/*
+	 * We know the driver is already loaded, so the device should be
+	 * already bound. If not it means binding failed, which suggests
+	 * the device doesn't really exist and should be deleted.
+	 * Ideally this would be replaced by better checks _before_
+	 * instantiating the device.
+	 */
+	if (!client->driver) {
+		i2c_unregister_device(client);
+		return -ENODEV;
+	}
+
+	/*
+	 * Let i2c-core delete that device on driver removal.
+	 * This is safe because i2c-core holds the core_lock mutex for us.
+	 */
+	list_add_tail(&client->detected, &client->driver->clients);
+	return 0;
+}
+
+static int onyx_i2c_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
+{
+	struct device_node *node = client->dev.platform_data;
 	struct onyx *onyx;
 	u8 dummy;
 
@@ -1011,20 +1044,12 @@ static int onyx_create(struct i2c_adapte
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
@@ -1036,14 +1061,14 @@ static int onyx_create(struct i2c_adapte
 	onyx->codec.node = of_node_get(node);
 
 	if (aoa_codec_register(&onyx->codec)) {
-		i2c_detach_client(&onyx->i2c);
 		goto fail;
 	}
 	printk(KERN_DEBUG PFX "created and attached onyx instance\n");
 	return 0;
  fail:
+	i2c_set_clientdata(client, NULL);
 	kfree(onyx);
-	return -EINVAL;
+	return -ENODEV;
 }
 
 static int onyx_i2c_attach(struct i2c_adapter *adapter)
@@ -1080,28 +1105,33 @@ static int onyx_i2c_attach(struct i2c_ad
 	return onyx_create(adapter, NULL, 0x47);
 }
 
-static int onyx_i2c_detach(struct i2c_client *client)
+static int onyx_i2c_remove(struct i2c_client *client)
 {
-	struct onyx *onyx = container_of(client, struct onyx, i2c);
-	int err;
+	struct onyx *onyx = i2c_get_clientdata(client);
 
-	if ((err = i2c_detach_client(client)))
-		return err;
 	aoa_codec_unregister(&onyx->codec);
 	of_node_put(onyx->codec.node);
 	if (onyx->codec_info)
 		kfree(onyx->codec_info);
+	i2c_set_clientdata(client, onyx);
 	kfree(onyx);
 	return 0;
 }
 
+static const struct i2c_device_id onyx_i2c_id[] = {
+	{ "aoa_codec_onyx", 0 },
+	{ }
+};
+
 static struct i2c_driver onyx_driver = {
 	.driver = {
 		.name = "aoa_codec_onyx",
 		.owner = THIS_MODULE,
 	},
 	.attach_adapter = onyx_i2c_attach,
-	.detach_client = onyx_i2c_detach,
+	.probe = onyx_i2c_probe,
+	.remove = onyx_i2c_remove,
+	.id_table = onyx_i2c_id,
 };
 
 static int __init onyx_init(void)
--- linux-2.6.30-rc2.orig/sound/aoa/codecs/tas.c	2009-04-15 09:55:20.000000000 +0200
+++ linux-2.6.30-rc2/sound/aoa/codecs/tas.c	2009-04-15 09:56:39.000000000 +0200
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
@@ -882,12 +882,34 @@ static void tas_exit_codec(struct aoa_co
 }
 
 
-static struct i2c_driver tas_driver;
-
 static int tas_create(struct i2c_adapter *adapter,
 		       struct device_node *node,
 		       int addr)
 {
+	struct i2c_board_info info;
+	struct i2c_client *client;
+
+	memset(&info, 0, sizeof(struct i2c_board_info));
+	strlcpy(info.type, "aoa_codec_tas", I2C_NAME_SIZE);
+	info.addr = addr;
+	info.platform_data = node;
+
+	client = i2c_new_device(adapter, &info);
+	if (!client)
+		return -ENODEV;
+
+	/*
+	 * Let i2c-core delete that device on driver removal.
+	 * This is safe because i2c-core holds the core_lock mutex for us.
+	 */
+	list_add_tail(&client->detected, &client->driver->clients);
+	return 0;
+}
+
+static int tas_i2c_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct device_node *node = client->dev.platform_data;
 	struct tas *tas;
 
 	tas = kzalloc(sizeof(struct tas), GFP_KERNEL);
@@ -896,17 +918,11 @@ static int tas_create(struct i2c_adapter
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
@@ -915,14 +931,12 @@ static int tas_create(struct i2c_adapter
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
@@ -970,14 +984,11 @@ static int tas_i2c_attach(struct i2c_ada
 	return -ENODEV;
 }
 
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
 
@@ -989,13 +1000,20 @@ static int tas_i2c_detach(struct i2c_cli
 	return 0;
 }
 
+static const struct i2c_device_id tas_i2c_id[] = {
+	{ "aoa_codec_tas", 0 },
+	{ }
+};
+
 static struct i2c_driver tas_driver = {
 	.driver = {
 		.name = "aoa_codec_tas",
 		.owner = THIS_MODULE,
 	},
 	.attach_adapter = tas_i2c_attach,
-	.detach_client = tas_i2c_detach,
+	.probe = tas_i2c_probe,
+	.remove = tas_i2c_remove,
+	.id_table = tas_i2c_id,
 };
 
 static int __init tas_init(void)


-- 
Jean Delvare

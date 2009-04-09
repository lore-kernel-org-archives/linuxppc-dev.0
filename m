Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 829ABDE107
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Apr 2009 22:20:03 +1000 (EST)
Date: Thu, 9 Apr 2009 14:19:45 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] AOA: Convert onyx and tas codecs to new-style i2c  
	drivers
Message-ID: <20090409141945.116772e3@hyperion.delvare>
In-Reply-To: <1239263089.24548.30.camel@johannes.local>
References: <20090408150249.5a62a56c@hyperion.delvare>
	<1239205899.16477.32.camel@johannes.local>
	<20090408224858.04cb6dc4@hyperion.delvare>
	<1239263089.24548.30.camel@johannes.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Benjamin, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	Takashi Iwai <tiwai@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Johannes,

On Thu, 09 Apr 2009 09:44:49 +0200, Johannes Berg wrote:
> > Can you please point me to the layout fabric / aoa fabric? I'd like to
> > understand how it works. Then I may be able to rewrite my patch
> > completely differently.
> 
> That's in sound/aoa/fabric/layout.c

OK, I understand how it works now, thanks for pointing me to the
relevant piece of code. It's easier to modify the code when you
understand the current logic ;)

> > There are basically two ways to instantiate I2C devices in the new
> > model. The first method is to declare the I2C devices as platform data
> > and let i2c-core instantiate them. The second method is to have the i2c
> > bus driver instantiate the clients. My patch uses the second method
> > because I didn't know how to use the first method. However using the
> > first method would solve the issues you raised. But I need some help
> > from someone more familiar with the powermac platform initialization
> > code to get it right.
> 
> Interesting. Does it need to be _platform_ data, or could
> sound/aoa/fabric/layout.c declare the devices instead?

It can be anywhere as long as it is early enough. Early enough means
that the code must run before device drivers can loaded. As
snd-aoa-fabric-layout can be built as a module, it doesn't seem right.

The idea is to assign fixed i2c bus numbers to the relevant i2c buses,
and declare the i2c devices connected to each bus by bus number and
device address. The i2c-powermac buses are created in
arch/powerpc/platforms/powermac/low_i2c.c, so you would have to
instantiate the i2c devices there too. That would basically mean
merging part of snd-aoa-fabric-layout into
arch/powerpc/platforms/powermac/low_i2c.c as I understand it, I don't
know if this sounds reasonable to you.

More generally, in order to instantiate an i2c device (for the new
binding model), you need at least two things: a reference to the
underlying i2c bus, and the address of the i2c device. The address can
be read from the device tree, but what is more difficult is to get the
reference to the underlying i2c bus. That reference can be the
i2c_adapter number (which only makes sense in a fixed-bus-number
scheme), or a pointer to the i2c_adapter. For now the powermac systems
do not have fixed i2c bus numbers, which is why I put the code
instantiating the devices in i2c-powermac: there I have a pointer to
the i2c_adapter.

So I think we have two options: switch the powermac systems to fixed
i2c bus numbers and instantiate the i2c sound devices from
arch/powerpc/platforms/powermac/*, or find a way to obtain a reference
to the relevant i2c_adapter.

I think I have found a way to achieve the latter. This isn't exactly
how the new model was supposed to work, but it has the advantage to be
way less intrusive than my original proposal. It may require larger
changes in the future as the i2c-core cleanups go on, but this should
do for now.

> > (...)
> > I think I've found that one by now (snd_pmac_detect in
> > sound/ppc/pmac.c, right?), thanks for the clarification.
> 
> That's snd-powermac, yes.
> 
> > BTW, that code doesn't seem significantly different from what my patch
> > is adding to i2c-powermac.
> 
> That would be true, yes, with your patch I don't understand how to load
> snd-powermac _or_ snd-aoa based on the platform data (or in the case of
> snd-powermac, not load it automatically at all).

My patch was really only about snd-aoa, it did not take care about
snd-powermac at all, because I expected them to be essentially
independent. Of course, if the code I added to i2c-powermac
instantiates devices on systems which were previous handled by
snd-powermac, it would break. More work would be needed to handle the
systems supported by snd-powermac.

> (...)
> Oh ok, that kinda ties in with my very first question about what happens
> if the same chip is known in different contexts, on different buses etc.
> Makes sense in that case I guess. But I still think that you shouldn't
> auto-load the aoa codec modules based on this anyway.

My new approach doesn't auto-load anything. Here we go, what you think?
This time there is no logic change, I'm really only turning legacy code
into new-style i2c code (basically calling i2c_new_device() instead of
i2c_attach_client()) and that's about it.

(Once again this is only build-tested and I would like people with the
hardware to give it a try.)

From: Jean Delvare <khali@linux-fr.org>
Subject: AOA: Convert onyx and tas codecs to new-style i2c drivers

The legacy i2c binding model is going away soon, so convert the AOA
codec drivers to the new model or they'll break.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 sound/aoa/codecs/onyx.c |   71 +++++++++++++++++++++++++++++------------------
 sound/aoa/codecs/tas.c  |   63 +++++++++++++++++++++++++----------------
 2 files changed, 84 insertions(+), 50 deletions(-)

--- linux-2.6.30-rc1.orig/sound/aoa/codecs/onyx.c	2009-04-09 11:53:11.000000000 +0200
+++ linux-2.6.30-rc1/sound/aoa/codecs/onyx.c	2009-04-09 13:58:44.000000000 +0200
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
@@ -996,12 +996,38 @@ static void onyx_exit_codec(struct aoa_c
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
+	if (node) {
+		info.addr = addr;
+		info.platform_data = node;
+		client = i2c_new_device(adapter, &info);
+	} else {
+		/* probe both possible addresses for the onyx chip */
+		unsigned short probe_onyx[] = {
+			0x46, 0x47, I2C_CLIENT_END
+		};
+
+		client = i2c_new_probed_device(adapter, &info, probe_onyx);
+	}
+	if (!client)
+		return -ENODEV;
+
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
 
@@ -1011,20 +1037,12 @@ static int onyx_create(struct i2c_adapte
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
@@ -1036,7 +1054,6 @@ static int onyx_create(struct i2c_adapte
 	onyx->codec.node = of_node_get(node);
 
 	if (aoa_codec_register(&onyx->codec)) {
-		i2c_detach_client(&onyx->i2c);
 		goto fail;
 	}
 	printk(KERN_DEBUG PFX "created and attached onyx instance\n");
@@ -1074,19 +1091,13 @@ static int onyx_i2c_attach(struct i2c_ad
 		return -ENODEV;
 
 	printk(KERN_DEBUG PFX "found k2-i2c, checking if onyx chip is on it\n");
-	/* probe both possible addresses for the onyx chip */
-	if (onyx_create(adapter, NULL, 0x46) == 0)
-		return 0;
-	return onyx_create(adapter, NULL, 0x47);
+	return onyx_create(adapter, NULL, 0);
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
@@ -1095,13 +1106,21 @@ static int onyx_i2c_detach(struct i2c_cl
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
 	.attach_adapter = onyx_i2c_attach,
-	.detach_client = onyx_i2c_detach,
+	.probe = onyx_i2c_probe,
+	.remove = onyx_i2c_remove,
+	.id_table = onyx_i2c_id,
 };
 
 static int __init onyx_init(void)
--- linux-2.6.30-rc1.orig/sound/aoa/codecs/tas.c	2009-04-09 11:53:11.000000000 +0200
+++ linux-2.6.30-rc1/sound/aoa/codecs/tas.c	2009-04-09 13:58:41.000000000 +0200
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
@@ -882,12 +882,30 @@ static void tas_exit_codec(struct aoa_co
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
@@ -896,17 +914,11 @@ static int tas_create(struct i2c_adapter
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
@@ -915,14 +927,12 @@ static int tas_create(struct i2c_adapter
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
@@ -970,14 +980,11 @@ static int tas_i2c_attach(struct i2c_ada
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
 
@@ -989,13 +996,21 @@ static int tas_i2c_detach(struct i2c_cli
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
 	.attach_adapter = tas_i2c_attach,
-	.detach_client = tas_i2c_detach,
+	.probe = tas_i2c_probe,
+	.remove = tas_i2c_remove,
+	.id_table = tas_i2c_id,
 };
 
 static int __init tas_init(void)


-- 
Jean Delvare

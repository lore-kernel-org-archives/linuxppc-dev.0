Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 84B16B70F8
 for <linuxppc-dev@ozlabs.org>; Mon, 18 Jun 2012 17:30:17 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] sound/aoa: remove i2c attach_adapter method
References: <1334823416-9138-1-git-send-email-benh@kernel.crashing.org>
 <1334823416-9138-2-git-send-email-benh__33169.052625499$1334826821$gmane$org@kernel.crashing.org>
 <m2r4tofuxr.fsf@igel.home> <1339984980.2372.9.camel@pasglop>
Date: Mon, 18 Jun 2012 09:30:09 +0200
In-Reply-To: <1339984980.2372.9.camel@pasglop> (Benjamin Herrenschmidt's
 message of "Mon, 18 Jun 2012 12:03:00 +1000")
Message-ID: <m21uldvzzy.fsf_-_@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since i2c-powermac now creates all i2c devices on its own, remove the
attach_adapter methods from the TAS and Onyx drivers, and adjust the
module aliases to match the names used by i2c-powermac.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 sound/aoa/codecs/onyx.c | 75 ++--------------------------------------------
 sound/aoa/codecs/tas.c  | 80 ++-----------------------------------------------
 2 files changed, 6 insertions(+), 149 deletions(-)

diff --git a/sound/aoa/codecs/onyx.c b/sound/aoa/codecs/onyx.c
index 270790d..4cedc69 100644
--- a/sound/aoa/codecs/onyx.c
+++ b/sound/aoa/codecs/onyx.c
@@ -997,45 +997,10 @@ static void onyx_exit_codec(struct aoa_codec *codec)
 	onyx->codec.soundbus_dev->detach_codec(onyx->codec.soundbus_dev, onyx);
 }
 
-static int onyx_create(struct i2c_adapter *adapter,
-		       struct device_node *node,
-		       int addr)
-{
-	struct i2c_board_info info;
-	struct i2c_client *client;
-
-	memset(&info, 0, sizeof(struct i2c_board_info));
-	strlcpy(info.type, "aoa_codec_onyx", I2C_NAME_SIZE);
-	info.addr = addr;
-	info.platform_data = node;
-	client = i2c_new_device(adapter, &info);
-	if (!client)
-		return -ENODEV;
-
-	/*
-	 * We know the driver is already loaded, so the device should be
-	 * already bound. If not it means binding failed, which suggests
-	 * the device doesn't really exist and should be deleted.
-	 * Ideally this would be replaced by better checks _before_
-	 * instantiating the device.
-	 */
-	if (!client->driver) {
-		i2c_unregister_device(client);
-		return -ENODEV;
-	}
-
-	/*
-	 * Let i2c-core delete that device on driver removal.
-	 * This is safe because i2c-core holds the core_lock mutex for us.
-	 */
-	list_add_tail(&client->detected, &client->driver->clients);
-	return 0;
-}
-
 static int onyx_i2c_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id)
 {
-	struct device_node *node = client->dev.platform_data;
+	struct device_node *node = client->dev.of_node;
 	struct onyx *onyx;
 	u8 dummy;
 
@@ -1071,40 +1036,6 @@ static int onyx_i2c_probe(struct i2c_client *client,
 	return -ENODEV;
 }
 
-static int onyx_i2c_attach(struct i2c_adapter *adapter)
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
 static int onyx_i2c_remove(struct i2c_client *client)
 {
 	struct onyx *onyx = i2c_get_clientdata(client);
@@ -1117,16 +1048,16 @@ static int onyx_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id onyx_i2c_id[] = {
-	{ "aoa_codec_onyx", 0 },
+	{ "MAC,pcm3052", 0 },
 	{ }
 };
+MODULE_DEVICE_TABLE(i2c,onyx_i2c_id);
 
 static struct i2c_driver onyx_driver = {
 	.driver = {
 		.name = "aoa_codec_onyx",
 		.owner = THIS_MODULE,
 	},
-	.attach_adapter = onyx_i2c_attach,
 	.probe = onyx_i2c_probe,
 	.remove = onyx_i2c_remove,
 	.id_table = onyx_i2c_id,
diff --git a/sound/aoa/codecs/tas.c b/sound/aoa/codecs/tas.c
index 8e63d1f..c491ae0 100644
--- a/sound/aoa/codecs/tas.c
+++ b/sound/aoa/codecs/tas.c
@@ -883,43 +883,10 @@ static void tas_exit_codec(struct aoa_codec *codec)
 }
 
 
-static int tas_create(struct i2c_adapter *adapter,
-		       struct device_node *node,
-		       int addr)
-{
-	struct i2c_board_info info;
-	struct i2c_client *client;
-
-	memset(&info, 0, sizeof(struct i2c_board_info));
-	strlcpy(info.type, "aoa_codec_tas", I2C_NAME_SIZE);
-	info.addr = addr;
-	info.platform_data = node;
-
-	client = i2c_new_device(adapter, &info);
-	if (!client)
-		return -ENODEV;
-	/*
-	 * We know the driver is already loaded, so the device should be
-	 * already bound. If not it means binding failed, and then there
-	 * is no point in keeping the device instantiated.
-	 */
-	if (!client->driver) {
-		i2c_unregister_device(client);
-		return -ENODEV;
-	}
-
-	/*
-	 * Let i2c-core delete that device on driver removal.
-	 * This is safe because i2c-core holds the core_lock mutex for us.
-	 */
-	list_add_tail(&client->detected, &client->driver->clients);
-	return 0;
-}
-
 static int tas_i2c_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
-	struct device_node *node = client->dev.platform_data;
+	struct device_node *node = client->dev.of_node;
 	struct tas *tas;
 
 	tas = kzalloc(sizeof(struct tas), GFP_KERNEL);
@@ -953,47 +920,6 @@ static int tas_i2c_probe(struct i2c_client *client,
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
 static int tas_i2c_remove(struct i2c_client *client)
 {
 	struct tas *tas = i2c_get_clientdata(client);
@@ -1011,16 +937,16 @@ static int tas_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id tas_i2c_id[] = {
-	{ "aoa_codec_tas", 0 },
+	{ "MAC,tas3004", 0 },
 	{ }
 };
+MODULE_DEVICE_TABLE(i2c,tas_i2c_id);
 
 static struct i2c_driver tas_driver = {
 	.driver = {
 		.name = "aoa_codec_tas",
 		.owner = THIS_MODULE,
 	},
-	.attach_adapter = tas_i2c_attach,
 	.probe = tas_i2c_probe,
 	.remove = tas_i2c_remove,
 	.id_table = tas_i2c_id,
-- 
1.7.11


Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E0B95B6FBB
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2012 18:20:22 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@kernel.crashing.org>;
 Thu, 19 Apr 2012 08:10:52 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q3J8JnNV37224484
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2012 18:19:49 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q3J8JmsC008271
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2012 18:19:49 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 03/15] powerpc/pmac: Convert windfarm_lm75 to new i2c probing
Date: Thu, 19 Apr 2012 18:16:44 +1000
Message-Id: <1334823416-9138-4-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1334823416-9138-1-git-send-email-benh@kernel.crashing.org>
References: <1334823416-9138-1-git-send-email-benh@kernel.crashing.org>
Cc: khali@linux-fr.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This simplifies the driver to stop using the deprecated attach interface

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/macintosh/windfarm_lm75_sensor.c |  124 ++++++++----------------------
 1 file changed, 30 insertions(+), 94 deletions(-)

diff --git a/drivers/macintosh/windfarm_lm75_sensor.c b/drivers/macintosh/windfarm_lm75_sensor.c
index 4d6a90a..4cc3f93 100644
--- a/drivers/macintosh/windfarm_lm75_sensor.c
+++ b/drivers/macintosh/windfarm_lm75_sensor.c
@@ -23,7 +23,7 @@
 
 #include "windfarm.h"
 
-#define VERSION "0.2"
+#define VERSION "1.0"
 
 #undef DEBUG
 
@@ -36,8 +36,8 @@
 struct wf_lm75_sensor {
 	int			ds1775 : 1;
 	int			inited : 1;
-	struct 	i2c_client	*i2c;
-	struct 	wf_sensor	sens;
+	struct i2c_client	*i2c;
+	struct wf_sensor	sens;
 };
 #define wf_to_lm75(c) container_of(c, struct wf_lm75_sensor, sens)
 
@@ -90,40 +90,19 @@ static struct wf_sensor_ops wf_lm75_ops = {
 
 static int wf_lm75_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
-{
+{	
 	struct wf_lm75_sensor *lm;
-	int rc;
-
-	lm = kzalloc(sizeof(struct wf_lm75_sensor), GFP_KERNEL);
-	if (lm == NULL)
-		return -ENODEV;
-
-	lm->inited = 0;
-	lm->ds1775 = id->driver_data;
-	lm->i2c = client;
-	lm->sens.name = client->dev.platform_data;
-	lm->sens.ops = &wf_lm75_ops;
-	i2c_set_clientdata(client, lm);
-
-	rc = wf_register_sensor(&lm->sens);
-	if (rc)
-		kfree(lm);
-
-	return rc;
-}
-
-static struct i2c_driver wf_lm75_driver;
-
-static struct i2c_client *wf_lm75_create(struct i2c_adapter *adapter,
-					     u8 addr, int ds1775,
-					     const char *loc)
-{
-	struct i2c_board_info info;
-	struct i2c_client *client;
-	char *name;
+	int rc, ds1775 = id->driver_data;
+	const char *name, *loc;
 
 	DBG("wf_lm75: creating  %s device at address 0x%02x\n",
-	    ds1775 ? "ds1775" : "lm75", addr);
+	    ds1775 ? "ds1775" : "lm75", client->addr);
+
+	loc = of_get_property(client->dev.of_node, "hwsensor-location", NULL);
+	if (!loc) {
+		dev_warn(&client->dev, "Missing hwsensor-location property!\n");
+		return -ENXIO;
+	}
 
 	/* Usual rant about sensor names not beeing very consistent in
 	 * the device-tree, oh well ...
@@ -138,67 +117,24 @@ static struct i2c_client *wf_lm75_create(struct i2c_adapter *adapter,
 	else if (!strcmp(loc, "HD Temp"))
 		name = "hard-drive-temp";
 	else
-		goto fail;
-
-	memset(&info, 0, sizeof(struct i2c_board_info));
-	info.addr = (addr >> 1) & 0x7f;
-	info.platform_data = name;
-	strlcpy(info.type, ds1775 ? "wf_ds1775" : "wf_lm75", I2C_NAME_SIZE);
-
-	client = i2c_new_device(adapter, &info);
-	if (client == NULL) {
-		printk(KERN_ERR "windfarm: failed to attach %s %s to i2c\n",
-		       ds1775 ? "ds1775" : "lm75", name);
-		goto fail;
-	}
-
-	/*
-	 * Let i2c-core delete that device on driver removal.
-	 * This is safe because i2c-core holds the core_lock mutex for us.
-	 */
-	list_add_tail(&client->detected, &wf_lm75_driver.clients);
-	return client;
- fail:
-	return NULL;
-}
-
-static int wf_lm75_attach(struct i2c_adapter *adapter)
-{
-	struct device_node *busnode, *dev;
-	struct pmac_i2c_bus *bus;
+		return -ENXIO;
+ 	
 
-	DBG("wf_lm75: adapter %s detected\n", adapter->name);
-
-	bus = pmac_i2c_adapter_to_bus(adapter);
-	if (bus == NULL)
+	lm = kzalloc(sizeof(struct wf_lm75_sensor), GFP_KERNEL);
+	if (lm == NULL)
 		return -ENODEV;
-	busnode = pmac_i2c_get_bus_node(bus);
 
-	DBG("wf_lm75: bus found, looking for device...\n");
-
-	/* Now look for lm75(s) in there */
-	for (dev = NULL;
-	     (dev = of_get_next_child(busnode, dev)) != NULL;) {
-		const char *loc =
-			of_get_property(dev, "hwsensor-location", NULL);
-		u8 addr;
+	lm->inited = 0;
+	lm->ds1775 = ds1775;
+	lm->i2c = client;
+	lm->sens.name = (char *)name; /* XXX fix constness in structure */
+	lm->sens.ops = &wf_lm75_ops;
+	i2c_set_clientdata(client, lm);
 
-		/* We must re-match the adapter in order to properly check
-		 * the channel on multibus setups
-		 */
-		if (!pmac_i2c_match_adapter(dev, adapter))
-			continue;
-		addr = pmac_i2c_get_dev_addr(dev);
-		if (loc == NULL || addr == 0)
-			continue;
-		/* real lm75 */
-		if (of_device_is_compatible(dev, "lm75"))
-			wf_lm75_create(adapter, addr, 0, loc);
-		/* ds1775 (compatible, better resolution */
-		else if (of_device_is_compatible(dev, "ds1775"))
-			wf_lm75_create(adapter, addr, 1, loc);
-	}
-	return 0;
+	rc = wf_register_sensor(&lm->sens);
+	if (rc)
+		kfree(lm);
+	return rc;
 }
 
 static int wf_lm75_remove(struct i2c_client *client)
@@ -217,16 +153,16 @@ static int wf_lm75_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id wf_lm75_id[] = {
-	{ "wf_lm75", 0 },
-	{ "wf_ds1775", 1 },
+	{ "MAC,lm75", 0 },
+	{ "MAC,ds1775", 1 },
 	{ }
 };
+MODULE_DEVICE_TABLE(i2c, wf_lm75_id);
 
 static struct i2c_driver wf_lm75_driver = {
 	.driver = {
 		.name	= "wf_lm75",
 	},
-	.attach_adapter	= wf_lm75_attach,
 	.probe		= wf_lm75_probe,
 	.remove		= wf_lm75_remove,
 	.id_table	= wf_lm75_id,
-- 
1.7.9.5

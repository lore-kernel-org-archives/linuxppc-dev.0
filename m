Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 85199B7094
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2012 18:42:46 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@kernel.crashing.org>;
 Thu, 19 Apr 2012 08:15:42 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q3J8DEWx733318
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2012 18:13:14 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q3J8JmfV008275
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2012 18:19:49 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 04/15] powerpc/pmac: Convert windfarm_max6690 to new i2c
 probing
Date: Thu, 19 Apr 2012 18:16:45 +1000
Message-Id: <1334823416-9138-5-git-send-email-benh@kernel.crashing.org>
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
 drivers/macintosh/windfarm_max6690_sensor.c |  100 ++++++---------------------
 1 file changed, 21 insertions(+), 79 deletions(-)

diff --git a/drivers/macintosh/windfarm_max6690_sensor.c b/drivers/macintosh/windfarm_max6690_sensor.c
index 8204113..f4902f4 100644
--- a/drivers/macintosh/windfarm_max6690_sensor.c
+++ b/drivers/macintosh/windfarm_max6690_sensor.c
@@ -16,7 +16,7 @@
 
 #include "windfarm.h"
 
-#define VERSION "0.2"
+#define VERSION "1.0"
 
 /* This currently only exports the external temperature sensor,
    since that's all the control loops need. */
@@ -64,9 +64,25 @@ static struct wf_sensor_ops wf_max6690_ops = {
 static int wf_max6690_probe(struct i2c_client *client,
 			    const struct i2c_device_id *id)
 {
+	const char *name, *loc;
 	struct wf_6690_sensor *max;
 	int rc;
 
+	loc = of_get_property(client->dev.of_node, "hwsensor-location", NULL);
+	if (!loc) {
+		dev_warn(&client->dev, "Missing hwsensor-location property!\n");
+		return -ENXIO;
+	}
+
+	if (!strcmp(loc, "BACKSIDE"))
+		name = "backside-temp";
+	else if (!strcmp(loc, "NB Ambient"))
+		name = "north-bridge-temp";
+	else if (!strcmp(loc, "GPU Ambient"))
+		name = "gpu-temp";
+	else
+		return -ENXIO;
+
 	max = kzalloc(sizeof(struct wf_6690_sensor), GFP_KERNEL);
 	if (max == NULL) {
 		printk(KERN_ERR "windfarm: Couldn't create MAX6690 sensor: "
@@ -75,90 +91,16 @@ static int wf_max6690_probe(struct i2c_client *client,
 	}
 
 	max->i2c = client;
-	max->sens.name = client->dev.platform_data;
+	max->sens.name = (char *)name; /* XXX fix constness in structure */
 	max->sens.ops = &wf_max6690_ops;
 	i2c_set_clientdata(client, max);
 
 	rc = wf_register_sensor(&max->sens);
-	if (rc) {
+	if (rc)
 		kfree(max);
-	}
-
 	return rc;
 }
 
-static struct i2c_driver wf_max6690_driver;
-
-static struct i2c_client *wf_max6690_create(struct i2c_adapter *adapter,
-					    u8 addr, const char *loc)
-{
-	struct i2c_board_info info;
-	struct i2c_client *client;
-	char *name;
-
-	if (!strcmp(loc, "BACKSIDE"))
-		name = "backside-temp";
-	else if (!strcmp(loc, "NB Ambient"))
-		name = "north-bridge-temp";
-	else if (!strcmp(loc, "GPU Ambient"))
-		name = "gpu-temp";
-	else
-		goto fail;
-
-	memset(&info, 0, sizeof(struct i2c_board_info));
-	info.addr = addr >> 1;
-	info.platform_data = name;
-	strlcpy(info.type, "wf_max6690", I2C_NAME_SIZE);
-
-	client = i2c_new_device(adapter, &info);
-	if (client == NULL) {
-		printk(KERN_ERR "windfarm: failed to attach MAX6690 sensor\n");
-		goto fail;
-	}
-
-	/*
-	 * Let i2c-core delete that device on driver removal.
-	 * This is safe because i2c-core holds the core_lock mutex for us.
-	 */
-	list_add_tail(&client->detected, &wf_max6690_driver.clients);
-	return client;
-
- fail:
-	return NULL;
-}
-
-static int wf_max6690_attach(struct i2c_adapter *adapter)
-{
-	struct device_node *busnode, *dev = NULL;
-	struct pmac_i2c_bus *bus;
-	const char *loc;
-
-	bus = pmac_i2c_adapter_to_bus(adapter);
-	if (bus == NULL)
-		return -ENODEV;
-	busnode = pmac_i2c_get_bus_node(bus);
-
-	while ((dev = of_get_next_child(busnode, dev)) != NULL) {
-		u8 addr;
-
-		/* We must re-match the adapter in order to properly check
-		 * the channel on multibus setups
-		 */
-		if (!pmac_i2c_match_adapter(dev, adapter))
-			continue;
-		if (!of_device_is_compatible(dev, "max6690"))
-			continue;
-		addr = pmac_i2c_get_dev_addr(dev);
-		loc = of_get_property(dev, "hwsensor-location", NULL);
-		if (loc == NULL || addr == 0)
-			continue;
-		printk("found max6690, loc=%s addr=0x%02x\n", loc, addr);
-		wf_max6690_create(adapter, addr, loc);
-	}
-
-	return 0;
-}
-
 static int wf_max6690_remove(struct i2c_client *client)
 {
 	struct wf_6690_sensor *max = i2c_get_clientdata(client);
@@ -170,15 +112,15 @@ static int wf_max6690_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id wf_max6690_id[] = {
-	{ "wf_max6690", 0 },
+	{ "MAC,max6690", 0 },
 	{ }
 };
+MODULE_DEVICE_TABLE(i2c, wf_max6690_id);
 
 static struct i2c_driver wf_max6690_driver = {
 	.driver = {
 		.name		= "wf_max6690",
 	},
-	.attach_adapter	= wf_max6690_attach,
 	.probe		= wf_max6690_probe,
 	.remove		= wf_max6690_remove,
 	.id_table	= wf_max6690_id,
-- 
1.7.9.5

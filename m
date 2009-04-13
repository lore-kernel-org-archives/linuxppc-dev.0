Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2FC49DE0F6
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Apr 2009 00:09:42 +1000 (EST)
Date: Mon, 13 Apr 2009 16:09:27 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] therm_pm72: Convert to a new-style i2c driver
Message-ID: <20090413160927.3b8675b8@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The legacy i2c binding model is going away soon, so convert the
macintosh therm_pm72 driver to the new model or it will break.

This is really a quick and dirty conversion, that should do the trick
for now, but no doubt that something cleaner can be done if anyone is
interested.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
Can anyone please run-test this patch? I could only build-test it.

 drivers/macintosh/therm_pm72.c |   95 +++++++++++++++++++---------------------
 1 file changed, 47 insertions(+), 48 deletions(-)

--- linux-2.6.30-rc1.orig/drivers/macintosh/therm_pm72.c	2009-04-12 08:49:54.000000000 +0200
+++ linux-2.6.30-rc1/drivers/macintosh/therm_pm72.c	2009-04-13 09:50:50.000000000 +0200
@@ -287,22 +287,6 @@ struct fcu_fan_table	fcu_fans[] = {
 };
 
 /*
- * i2c_driver structure to attach to the host i2c controller
- */
-
-static int therm_pm72_attach(struct i2c_adapter *adapter);
-static int therm_pm72_detach(struct i2c_adapter *adapter);
-
-static struct i2c_driver therm_pm72_driver =
-{
-	.driver = {
-		.name	= "therm_pm72",
-	},
-	.attach_adapter	= therm_pm72_attach,
-	.detach_adapter	= therm_pm72_detach,
-};
-
-/*
  * Utility function to create an i2c_client structure and
  * attach it to one of u3 adapters
  */
@@ -310,6 +294,7 @@ static struct i2c_client *attach_i2c_chi
 {
 	struct i2c_client *clt;
 	struct i2c_adapter *adap;
+	struct i2c_board_info info;
 
 	if (id & 0x200)
 		adap = k2;
@@ -320,31 +305,21 @@ static struct i2c_client *attach_i2c_chi
 	if (adap == NULL)
 		return NULL;
 
-	clt = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
-	if (clt == NULL)
-		return NULL;
-
-	clt->addr = (id >> 1) & 0x7f;
-	clt->adapter = adap;
-	clt->driver = &therm_pm72_driver;
-	strncpy(clt->name, name, I2C_NAME_SIZE-1);
-
-	if (i2c_attach_client(clt)) {
+	memset(&info, 0, sizeof(struct i2c_board_info));
+	info.addr = (id >> 1) & 0x7f;
+	strlcpy(info.type, "therm_pm72", I2C_NAME_SIZE);
+	clt = i2c_new_device(adap, &info);
+	if (!clt) {
 		printk(KERN_ERR "therm_pm72: Failed to attach to i2c ID 0x%x\n", id);
-		kfree(clt);
 		return NULL;
 	}
-	return clt;
-}
 
-/*
- * Utility function to get rid of the i2c_client structure
- * (will also detach from the adapter hopepfully)
- */
-static void detach_i2c_chip(struct i2c_client *clt)
-{
-	i2c_detach_client(clt);
-	kfree(clt);
+	/*
+	 * Let i2c-core delete that device on driver removal.
+	 * This is safe because i2c-core holds the core_lock mutex for us.
+	 */
+	list_add_tail(&clt->detected, &clt->driver->clients);
+	return clt;
 }
 
 /*
@@ -1203,8 +1178,6 @@ static int init_cpu_state(struct cpu_pid
 
 	return 0;
  fail:
-	if (state->monitor)
-		detach_i2c_chip(state->monitor);
 	state->monitor = NULL;
 	
 	return -ENODEV;
@@ -1232,7 +1205,6 @@ static void dispose_cpu_state(struct cpu
 		device_remove_file(&of_dev->dev, &dev_attr_cpu1_intake_fan_rpm);
 	}
 
-	detach_i2c_chip(state->monitor);
 	state->monitor = NULL;
 }
 
@@ -1407,7 +1379,6 @@ static void dispose_backside_state(struc
 	device_remove_file(&of_dev->dev, &dev_attr_backside_temperature);
 	device_remove_file(&of_dev->dev, &dev_attr_backside_fan_pwm);
 
-	detach_i2c_chip(state->monitor);
 	state->monitor = NULL;
 }
  
@@ -1532,7 +1503,6 @@ static void dispose_drives_state(struct
 	device_remove_file(&of_dev->dev, &dev_attr_drives_temperature);
 	device_remove_file(&of_dev->dev, &dev_attr_drives_fan_rpm);
 
-	detach_i2c_chip(state->monitor);
 	state->monitor = NULL;
 }
 
@@ -1654,7 +1624,6 @@ static void dispose_dimms_state(struct d
 
 	device_remove_file(&of_dev->dev, &dev_attr_dimms_temperature);
 
-	detach_i2c_chip(state->monitor);
 	state->monitor = NULL;
 }
 
@@ -1779,7 +1748,6 @@ static void dispose_slots_state(struct s
 	device_remove_file(&of_dev->dev, &dev_attr_slots_temperature);
 	device_remove_file(&of_dev->dev, &dev_attr_slots_fan_pwm);
 
-	detach_i2c_chip(state->monitor);
 	state->monitor = NULL;
 }
 
@@ -2008,8 +1976,6 @@ static int attach_fcu(void)
  */
 static void detach_fcu(void)
 {
-	if (fcu)
-		detach_i2c_chip(fcu);
 	fcu = NULL;
 }
 
@@ -2060,12 +2026,21 @@ static int therm_pm72_attach(struct i2c_
 	return 0;
 }
 
+static int therm_pm72_probe(struct i2c_client *client,
+			    const struct i2c_device_id *id)
+{
+	/* Always succeed, the real work was done in therm_pm72_attach() */
+	return 0;
+}
+
 /*
- * Called on every adapter when the driver or the i2c controller
+ * Called when any of the devices which participates into thermal management
  * is going away.
  */
-static int therm_pm72_detach(struct i2c_adapter *adapter)
+static int therm_pm72_remove(struct i2c_client *client)
 {
+	struct i2c_adapter *adapter = client->adapter;
+
 	mutex_lock(&driver_lock);
 
 	if (state != state_detached)
@@ -2096,6 +2071,30 @@ static int therm_pm72_detach(struct i2c_
 	return 0;
 }
 
+/*
+ * i2c_driver structure to attach to the host i2c controller
+ */
+
+static const struct i2c_device_id therm_pm72_id[] = {
+	/*
+	 * Fake device name, thermal management is done by several
+	 * chips but we don't need to differentiate between them at
+	 * this point.
+	 */
+	{ "therm_pm72", 0 },
+	{ }
+};
+
+static struct i2c_driver therm_pm72_driver = {
+	.driver = {
+		.name	= "therm_pm72",
+	},
+	.attach_adapter	= therm_pm72_attach,
+	.probe		= therm_pm72_probe,
+	.remove		= therm_pm72_remove,
+	.id_table	= therm_pm72_id,
+};
+
 static int fan_check_loc_match(const char *loc, int fan)
 {
 	char	tmp[64];


-- 
Jean Delvare

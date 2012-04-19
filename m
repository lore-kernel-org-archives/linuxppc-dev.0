Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CF4DDB7034
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2012 19:03:48 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@kernel.crashing.org>;
 Thu, 19 Apr 2012 08:14:49 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q3J8DB161544246
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2012 18:13:11 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q3J8JmsU008260
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2012 18:19:49 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 02/15] powerpc/pmac: Convert therm_adt746x to new i2c probing
Date: Thu, 19 Apr 2012 18:16:43 +1000
Message-Id: <1334823416-9138-3-git-send-email-benh@kernel.crashing.org>
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

This simplifies the driver to stop using the deprecated attach interface,

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/macintosh/therm_adt746x.c |  480 ++++++++++++++++---------------------
 1 file changed, 204 insertions(+), 276 deletions(-)

diff --git a/drivers/macintosh/therm_adt746x.c b/drivers/macintosh/therm_adt746x.c
index fc71723..f433521 100644
--- a/drivers/macintosh/therm_adt746x.c
+++ b/drivers/macintosh/therm_adt746x.c
@@ -47,7 +47,7 @@ static u8 FAN_SPD_SET[2] = {0x30, 0x31};
 
 static u8 default_limits_local[3] = {70, 50, 70};    /* local, sensor1, sensor2 */
 static u8 default_limits_chip[3] = {80, 65, 80};    /* local, sensor1, sensor2 */
-static const char *sensor_location[3];
+static const char *sensor_location[3] = { "?", "?", "?" };
 
 static int limit_adjust;
 static int fan_speed = -1;
@@ -79,18 +79,16 @@ struct thermostat {
 	int			last_speed[2];
 	int			last_var[2];
 	int			pwm_inv[2];
+	struct task_struct	*thread;
+	struct platform_device	*pdev;
+	enum {
+		ADT7460,
+		ADT7467
+	}			type;
 };
 
-static enum {ADT7460, ADT7467} therm_type;
-static int therm_bus, therm_address;
-static struct platform_device * of_dev;
-static struct thermostat* thermostat;
-static struct task_struct *thread_therm = NULL;
-
 static void write_both_fan_speed(struct thermostat *th, int speed);
 static void write_fan_speed(struct thermostat *th, int speed, int fan);
-static void thermostat_create_files(void);
-static void thermostat_remove_files(void);
 
 static int
 write_reg(struct thermostat* th, int reg, u8 data)
@@ -126,66 +124,6 @@ read_reg(struct thermostat* th, int reg)
 	return data;
 }
 
-static struct i2c_driver thermostat_driver;
-
-static int
-attach_thermostat(struct i2c_adapter *adapter)
-{
-	unsigned long bus_no;
-	struct i2c_board_info info;
-	struct i2c_client *client;
-
-	if (strncmp(adapter->name, "uni-n", 5))
-		return -ENODEV;
-	bus_no = simple_strtoul(adapter->name + 6, NULL, 10);
-	if (bus_no != therm_bus)
-		return -ENODEV;
-
-	memset(&info, 0, sizeof(struct i2c_board_info));
-	strlcpy(info.type, "therm_adt746x", I2C_NAME_SIZE);
-	info.addr = therm_address;
-	client = i2c_new_device(adapter, &info);
-	if (!client)
-		return -ENODEV;
-
-	/*
-	 * Let i2c-core delete that device on driver removal.
-	 * This is safe because i2c-core holds the core_lock mutex for us.
-	 */
-	list_add_tail(&client->detected, &thermostat_driver.clients);
-	return 0;
-}
-
-static int
-remove_thermostat(struct i2c_client *client)
-{
-	struct thermostat *th = i2c_get_clientdata(client);
-	int i;
-	
-	thermostat_remove_files();
-
-	if (thread_therm != NULL) {
-		kthread_stop(thread_therm);
-	}
-
-	printk(KERN_INFO "adt746x: Putting max temperatures back from "
-			 "%d, %d, %d to %d, %d, %d\n",
-		th->limits[0], th->limits[1], th->limits[2],
-		th->initial_limits[0], th->initial_limits[1],
-		th->initial_limits[2]);
-
-	for (i = 0; i < 3; i++)
-		write_reg(th, LIMIT_REG[i], th->initial_limits[i]);
-
-	write_both_fan_speed(th, -1);
-
-	thermostat = NULL;
-
-	kfree(th);
-
-	return 0;
-}
-
 static int read_fan_speed(struct thermostat *th, u8 addr)
 {
 	u8 tmp[2];
@@ -203,7 +141,7 @@ static int read_fan_speed(struct thermostat *th, u8 addr)
 static void write_both_fan_speed(struct thermostat *th, int speed)
 {
 	write_fan_speed(th, speed, 0);
-	if (therm_type == ADT7460)
+	if (th->type == ADT7460)
 		write_fan_speed(th, speed, 1);
 }
 
@@ -216,7 +154,7 @@ static void write_fan_speed(struct thermostat *th, int speed, int fan)
 	else if (speed < -1) 
 		speed = 0;
 	
-	if (therm_type == ADT7467 && fan == 1)
+	if (th->type == ADT7467 && fan == 1)
 		return;
 	
 	if (th->last_speed[fan] != speed) {
@@ -239,7 +177,7 @@ static void write_fan_speed(struct thermostat *th, int speed, int fan)
 		write_reg(th, FAN_SPD_SET[fan], speed);
 	} else {
 		/* back to automatic */
-		if(therm_type == ADT7460) {
+		if(th->type == ADT7460) {
 			manual = read_reg(th,
 				MANUAL_MODE[fan]) & (~MANUAL_MASK);
 			manual &= ~INVERT_MASK;
@@ -293,7 +231,7 @@ static void update_fans_speed (struct thermostat *th)
 	/* we don't care about local sensor, so we start at sensor 1 */
 	for (i = 1; i < 3; i++) {
 		int started = 0;
-		int fan_number = (therm_type == ADT7460 && i == 2);
+		int fan_number = (th->type == ADT7460 && i == 2);
 		int var = th->temps[i] - th->limits[i];
 
 		if (var > -1) {
@@ -370,116 +308,22 @@ static int monitor_task(void *arg)
 
 static void set_limit(struct thermostat *th, int i)
 {
-		/* Set sensor1 limit higher to avoid powerdowns */
-		th->limits[i] = default_limits_chip[i] + limit_adjust;
-		write_reg(th, LIMIT_REG[i], th->limits[i]);
+	/* Set sensor1 limit higher to avoid powerdowns */
+	th->limits[i] = default_limits_chip[i] + limit_adjust;
+	write_reg(th, LIMIT_REG[i], th->limits[i]);
 		
-		/* set our limits to normal */
-		th->limits[i] = default_limits_local[i] + limit_adjust;
+	/* set our limits to normal */
+	th->limits[i] = default_limits_local[i] + limit_adjust;
 }
 
-static int probe_thermostat(struct i2c_client *client,
-			    const struct i2c_device_id *id)
-{
-	struct thermostat* th;
-	int rc;
-	int i;
-
-	if (thermostat)
-		return 0;
-
-	th = kzalloc(sizeof(struct thermostat), GFP_KERNEL);
-	if (!th)
-		return -ENOMEM;
-
-	i2c_set_clientdata(client, th);
-	th->clt = client;
-
-	rc = read_reg(th, CONFIG_REG);
-	if (rc < 0) {
-		dev_err(&client->dev, "Thermostat failed to read config!\n");
-		kfree(th);
-		return -ENODEV;
-	}
-
-	/* force manual control to start the fan quieter */
-	if (fan_speed == -1)
-		fan_speed = 64;
-	
-	if(therm_type == ADT7460) {
-		printk(KERN_INFO "adt746x: ADT7460 initializing\n");
-		/* The 7460 needs to be started explicitly */
-		write_reg(th, CONFIG_REG, 1);
-	} else
-		printk(KERN_INFO "adt746x: ADT7467 initializing\n");
-
-	for (i = 0; i < 3; i++) {
-		th->initial_limits[i] = read_reg(th, LIMIT_REG[i]);
-		set_limit(th, i);
-	}
-
-	printk(KERN_INFO "adt746x: Lowering max temperatures from %d, %d, %d"
-			 " to %d, %d, %d\n",
-			 th->initial_limits[0], th->initial_limits[1],
-			 th->initial_limits[2], th->limits[0], th->limits[1],
-			 th->limits[2]);
-
-	thermostat = th;
-
-	/* record invert bit status because fw can corrupt it after suspend */
-	th->pwm_inv[0] = read_reg(th, MANUAL_MODE[0]) & INVERT_MASK;
-	th->pwm_inv[1] = read_reg(th, MANUAL_MODE[1]) & INVERT_MASK;
-
-	/* be sure to really write fan speed the first time */
-	th->last_speed[0] = -2;
-	th->last_speed[1] = -2;
-	th->last_var[0] = -80;
-	th->last_var[1] = -80;
-
-	if (fan_speed != -1) {
-		/* manual mode, stop fans */
-		write_both_fan_speed(th, 0);
-	} else {
-		/* automatic mode */
-		write_both_fan_speed(th, -1);
-	}
-	
-	thread_therm = kthread_run(monitor_task, th, "kfand");
-
-	if (thread_therm == ERR_PTR(-ENOMEM)) {
-		printk(KERN_INFO "adt746x: Kthread creation failed\n");
-		thread_therm = NULL;
-		return -ENOMEM;
-	}
-
-	thermostat_create_files();
-
-	return 0;
+#define BUILD_SHOW_FUNC_INT(name, data)				\
+static ssize_t show_##name(struct device *dev, struct device_attribute *attr, char *buf)	\
+{								\
+	struct thermostat *th = dev_get_drvdata(dev);		\
+	return sprintf(buf, "%d\n", data);			\
 }
 
-static const struct i2c_device_id therm_adt746x_id[] = {
-	{ "therm_adt746x", 0 },
-	{ }
-};
-
-static struct i2c_driver thermostat_driver = {
-	.driver = {
-		.name	= "therm_adt746x",
-	},
-	.attach_adapter	= attach_thermostat,
-	.probe = probe_thermostat,
-	.remove = remove_thermostat,
-	.id_table = therm_adt746x_id,
-};
-
-/* 
- * Now, unfortunately, sysfs doesn't give us a nice void * we could
- * pass around to the attribute functions, so we don't really have
- * choice but implement a bunch of them...
- *
- * FIXME, it does now...
- */
-#define BUILD_SHOW_FUNC_INT(name, data)				\
+#define BUILD_SHOW_FUNC_INT_LITE(name, data)				\
 static ssize_t show_##name(struct device *dev, struct device_attribute *attr, char *buf)	\
 {								\
 	return sprintf(buf, "%d\n", data);			\
@@ -494,22 +338,24 @@ static ssize_t show_##name(struct device *dev, struct device_attribute *attr, ch
 #define BUILD_SHOW_FUNC_FAN(name, data)				\
 static ssize_t show_##name(struct device *dev, struct device_attribute *attr, char *buf)       \
 {								\
+	struct thermostat *th = dev_get_drvdata(dev);		\
 	return sprintf(buf, "%d (%d rpm)\n", 			\
-		thermostat->last_speed[data],			\
-		read_fan_speed(thermostat, FAN_SPEED[data])	\
+		th->last_speed[data],				\
+		read_fan_speed(th, FAN_SPEED[data])		\
 		);						\
 }
 
 #define BUILD_STORE_FUNC_DEG(name, data)			\
 static ssize_t store_##name(struct device *dev, struct device_attribute *attr, const char *buf, size_t n) \
 {								\
+	struct thermostat *th = dev_get_drvdata(dev);		\
 	int val;						\
 	int i;							\
 	val = simple_strtol(buf, NULL, 10);			\
 	printk(KERN_INFO "Adjusting limits by %d degrees\n", val);	\
 	limit_adjust = val;					\
 	for (i=0; i < 3; i++)					\
-		set_limit(thermostat, i);			\
+		set_limit(th, i);				\
 	return n;						\
 }
 
@@ -525,20 +371,21 @@ static ssize_t store_##name(struct device *dev, struct device_attribute *attr, c
 	return n;						\
 }
 
-BUILD_SHOW_FUNC_INT(sensor1_temperature,	 (read_reg(thermostat, TEMP_REG[1])))
-BUILD_SHOW_FUNC_INT(sensor2_temperature,	 (read_reg(thermostat, TEMP_REG[2])))
-BUILD_SHOW_FUNC_INT(sensor1_limit,		 thermostat->limits[1])
-BUILD_SHOW_FUNC_INT(sensor2_limit,		 thermostat->limits[2])
+BUILD_SHOW_FUNC_INT(sensor1_temperature,	 (read_reg(th, TEMP_REG[1])))
+BUILD_SHOW_FUNC_INT(sensor2_temperature,	 (read_reg(th, TEMP_REG[2])))
+BUILD_SHOW_FUNC_INT(sensor1_limit,		 th->limits[1])
+BUILD_SHOW_FUNC_INT(sensor2_limit,		 th->limits[2])
 BUILD_SHOW_FUNC_STR(sensor1_location,		 sensor_location[1])
 BUILD_SHOW_FUNC_STR(sensor2_location,		 sensor_location[2])
 
-BUILD_SHOW_FUNC_INT(specified_fan_speed, fan_speed)
+BUILD_SHOW_FUNC_INT_LITE(specified_fan_speed, fan_speed)
+BUILD_STORE_FUNC_INT(specified_fan_speed,fan_speed)
+
 BUILD_SHOW_FUNC_FAN(sensor1_fan_speed,	 0)
 BUILD_SHOW_FUNC_FAN(sensor2_fan_speed,	 1)
 
-BUILD_STORE_FUNC_INT(specified_fan_speed,fan_speed)
-BUILD_SHOW_FUNC_INT(limit_adjust,	 limit_adjust)
-BUILD_STORE_FUNC_DEG(limit_adjust,	 thermostat)
+BUILD_SHOW_FUNC_INT_LITE(limit_adjust,	 limit_adjust)
+BUILD_STORE_FUNC_DEG(limit_adjust,	 th)
 		
 static DEVICE_ATTR(sensor1_temperature,	S_IRUGO,
 		   show_sensor1_temperature,NULL);
@@ -564,53 +411,77 @@ static DEVICE_ATTR(sensor2_fan_speed,	S_IRUGO,
 static DEVICE_ATTR(limit_adjust,	S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH,
 		   show_limit_adjust,	store_limit_adjust);
 
-
-static int __init
-thermostat_init(void)
+static void thermostat_create_files(struct thermostat *th)
 {
-	struct device_node* np;
-	const u32 *prop;
-	int i = 0, offset = 0;
+	struct device_node *np = th->clt->dev.of_node;
+	struct device *dev;
+	int err;
 
-	np = of_find_node_by_name(NULL, "fan");
-	if (!np)
-		return -ENODEV;
-	if (of_device_is_compatible(np, "adt7460"))
-		therm_type = ADT7460;
-	else if (of_device_is_compatible(np, "adt7467"))
-		therm_type = ADT7467;
-	else {
-		of_node_put(np);
-		return -ENODEV;
-	}
+	/* To maintain ABI compatibility with userspace, create
+	 * the old style platform driver and attach the attributes
+	 * to it here
+	 */
+	th->pdev = of_platform_device_create(np, "temperatures", NULL);
+	if (!th->pdev)
+		return;
+	dev = &th->pdev->dev;
+	dev_set_drvdata(dev, th);
+	err = device_create_file(dev, &dev_attr_sensor1_temperature);
+	err |= device_create_file(dev, &dev_attr_sensor2_temperature);
+	err |= device_create_file(dev, &dev_attr_sensor1_limit);
+	err |= device_create_file(dev, &dev_attr_sensor2_limit);
+	err |= device_create_file(dev, &dev_attr_sensor1_location);
+	err |= device_create_file(dev, &dev_attr_sensor2_location);
+	err |= device_create_file(dev, &dev_attr_limit_adjust);
+	err |= device_create_file(dev, &dev_attr_specified_fan_speed);
+	err |= device_create_file(dev, &dev_attr_sensor1_fan_speed);
+	if(th->type == ADT7460)
+		err |= device_create_file(dev, &dev_attr_sensor2_fan_speed);
+	if (err)
+		printk(KERN_WARNING
+			"Failed to create temperature attribute file(s).\n");
+}
 
-	prop = of_get_property(np, "hwsensor-params-version", NULL);
-	printk(KERN_INFO "adt746x: version %d (%ssupported)\n", *prop,
-			 (*prop == 1)?"":"un");
-	if (*prop != 1) {
-		of_node_put(np);
-		return -ENODEV;
-	}
+static void thermostat_remove_files(struct thermostat *th)
+{
+	struct device *dev;
 
-	prop = of_get_property(np, "reg", NULL);
-	if (!prop) {
-		of_node_put(np);
-		return -ENODEV;
-	}
+	if (!th->pdev)
+		return;
+	dev = &th->pdev->dev;
+	device_remove_file(dev, &dev_attr_sensor1_temperature);
+	device_remove_file(dev, &dev_attr_sensor2_temperature);
+	device_remove_file(dev, &dev_attr_sensor1_limit);
+	device_remove_file(dev, &dev_attr_sensor2_limit);
+	device_remove_file(dev, &dev_attr_sensor1_location);
+	device_remove_file(dev, &dev_attr_sensor2_location);
+	device_remove_file(dev, &dev_attr_limit_adjust);
+	device_remove_file(dev, &dev_attr_specified_fan_speed);
+	device_remove_file(dev, &dev_attr_sensor1_fan_speed);	
+	if (th->type == ADT7460)
+		device_remove_file(dev, &dev_attr_sensor2_fan_speed);
+	of_device_unregister(th->pdev);
 
-	/* look for bus either by path or using "reg" */
-	if (strstr(np->full_name, "/i2c-bus@") != NULL) {
-		const char *tmp_bus = (strstr(np->full_name, "/i2c-bus@") + 9);
-		therm_bus = tmp_bus[0]-'0';
-	} else {
-		therm_bus = ((*prop) >> 8) & 0x0f;
-	}
+}
 
-	therm_address = ((*prop) & 0xff) >> 1;
+static int probe_thermostat(struct i2c_client *client,
+			    const struct i2c_device_id *id)
+{
+	struct device_node *np = client->dev.of_node;
+	struct thermostat* th;
+	const __be32 *prop;
+	int i, rc, vers, offset = 0;
 
-	printk(KERN_INFO "adt746x: Thermostat bus: %d, address: 0x%02x, "
-			 "limit_adjust: %d, fan_speed: %d\n",
-			 therm_bus, therm_address, limit_adjust, fan_speed);
+	if (!np)
+		return -ENXIO;
+	prop = of_get_property(np, "hwsensor-params-version", NULL);
+	if (!prop)
+		return -ENXIO;
+	vers = be32_to_cpup(prop);
+	printk(KERN_INFO "adt746x: version %d (%ssupported)\n",
+	       vers, vers == 1 ? "" : "un");
+	if (vers != 1)
+		return -ENXIO;
 
 	if (of_get_property(np, "hwsensor-location", NULL)) {
 		for (i = 0; i < 3; i++) {
@@ -623,72 +494,129 @@ thermostat_init(void)
 			printk(KERN_INFO "sensor %d: %s\n", i, sensor_location[i]);
 			offset += strlen(sensor_location[i]) + 1;
 		}
-	} else {
-		sensor_location[0] = "?";
-		sensor_location[1] = "?";
-		sensor_location[2] = "?";
 	}
 
-	of_dev = of_platform_device_create(np, "temperatures", NULL);
-	of_node_put(np);
+	th = kzalloc(sizeof(struct thermostat), GFP_KERNEL);
+	if (!th)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, th);
+	th->clt = client;
+	th->type = id->driver_data;
 
-	if (of_dev == NULL) {
-		printk(KERN_ERR "Can't register temperatures device !\n");
+	rc = read_reg(th, CONFIG_REG);
+	if (rc < 0) {
+		dev_err(&client->dev, "Thermostat failed to read config!\n");
+		kfree(th);
 		return -ENODEV;
 	}
 
-#ifndef CONFIG_I2C_POWERMAC
-	request_module("i2c-powermac");
-#endif
+	/* force manual control to start the fan quieter */
+	if (fan_speed == -1)
+		fan_speed = 64;
+	
+	if (th->type == ADT7460) {
+		printk(KERN_INFO "adt746x: ADT7460 initializing\n");
+		/* The 7460 needs to be started explicitly */
+		write_reg(th, CONFIG_REG, 1);
+	} else
+		printk(KERN_INFO "adt746x: ADT7467 initializing\n");
 
-	return i2c_add_driver(&thermostat_driver);
+	for (i = 0; i < 3; i++) {
+		th->initial_limits[i] = read_reg(th, LIMIT_REG[i]);
+		set_limit(th, i);
+	}
+
+	printk(KERN_INFO "adt746x: Lowering max temperatures from %d, %d, %d"
+			 " to %d, %d, %d\n",
+			 th->initial_limits[0], th->initial_limits[1],
+			 th->initial_limits[2], th->limits[0], th->limits[1],
+			 th->limits[2]);
+
+	/* record invert bit status because fw can corrupt it after suspend */
+	th->pwm_inv[0] = read_reg(th, MANUAL_MODE[0]) & INVERT_MASK;
+	th->pwm_inv[1] = read_reg(th, MANUAL_MODE[1]) & INVERT_MASK;
+
+	/* be sure to really write fan speed the first time */
+	th->last_speed[0] = -2;
+	th->last_speed[1] = -2;
+	th->last_var[0] = -80;
+	th->last_var[1] = -80;
+
+	if (fan_speed != -1) {
+		/* manual mode, stop fans */
+		write_both_fan_speed(th, 0);
+	} else {
+		/* automatic mode */
+		write_both_fan_speed(th, -1);
+	}
+	
+	th->thread = kthread_run(monitor_task, th, "kfand");
+	if (th->thread == ERR_PTR(-ENOMEM)) {
+		printk(KERN_INFO "adt746x: Kthread creation failed\n");
+		th->thread = NULL;
+		return -ENOMEM;
+	}
+
+	thermostat_create_files(th);
+
+	return 0;
 }
 
-static void thermostat_create_files(void)
+static int remove_thermostat(struct i2c_client *client)
 {
-	int err;
+	struct thermostat *th = i2c_get_clientdata(client);
+	int i;
+	
+	thermostat_remove_files(th);
 
-	err = device_create_file(&of_dev->dev, &dev_attr_sensor1_temperature);
-	err |= device_create_file(&of_dev->dev, &dev_attr_sensor2_temperature);
-	err |= device_create_file(&of_dev->dev, &dev_attr_sensor1_limit);
-	err |= device_create_file(&of_dev->dev, &dev_attr_sensor2_limit);
-	err |= device_create_file(&of_dev->dev, &dev_attr_sensor1_location);
-	err |= device_create_file(&of_dev->dev, &dev_attr_sensor2_location);
-	err |= device_create_file(&of_dev->dev, &dev_attr_limit_adjust);
-	err |= device_create_file(&of_dev->dev, &dev_attr_specified_fan_speed);
-	err |= device_create_file(&of_dev->dev, &dev_attr_sensor1_fan_speed);
-	if(therm_type == ADT7460)
-		err |= device_create_file(&of_dev->dev, &dev_attr_sensor2_fan_speed);
-	if (err)
-		printk(KERN_WARNING
-			"Failed to create temperature attribute file(s).\n");
+	if (th->thread != NULL)
+		kthread_stop(th->thread);
+
+	printk(KERN_INFO "adt746x: Putting max temperatures back from "
+			 "%d, %d, %d to %d, %d, %d\n",
+		th->limits[0], th->limits[1], th->limits[2],
+		th->initial_limits[0], th->initial_limits[1],
+		th->initial_limits[2]);
+
+	for (i = 0; i < 3; i++)
+		write_reg(th, LIMIT_REG[i], th->initial_limits[i]);
+
+	write_both_fan_speed(th, -1);
+
+	kfree(th);
+
+	return 0;
 }
 
-static void thermostat_remove_files(void)
+static const struct i2c_device_id therm_adt746x_id[] = {
+	{ "MAC,adt7460", ADT7460 },
+	{ "MAC,adt7467", ADT7467 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, therm_adt746x_id);
+
+static struct i2c_driver thermostat_driver = {
+	.driver = {
+		.name	= "therm_adt746x",
+	},
+	.probe = probe_thermostat,
+	.remove = remove_thermostat,
+	.id_table = therm_adt746x_id,
+};
+
+static int __init thermostat_init(void)
 {
-	if (of_dev) {
-		device_remove_file(&of_dev->dev, &dev_attr_sensor1_temperature);
-		device_remove_file(&of_dev->dev, &dev_attr_sensor2_temperature);
-		device_remove_file(&of_dev->dev, &dev_attr_sensor1_limit);
-		device_remove_file(&of_dev->dev, &dev_attr_sensor2_limit);
-		device_remove_file(&of_dev->dev, &dev_attr_sensor1_location);
-		device_remove_file(&of_dev->dev, &dev_attr_sensor2_location);
-		device_remove_file(&of_dev->dev, &dev_attr_limit_adjust);
-		device_remove_file(&of_dev->dev, &dev_attr_specified_fan_speed);
-		device_remove_file(&of_dev->dev, &dev_attr_sensor1_fan_speed);
-
-		if(therm_type == ADT7460)
-			device_remove_file(&of_dev->dev,
-					   &dev_attr_sensor2_fan_speed);
+#ifndef CONFIG_I2C_POWERMAC
+	request_module("i2c-powermac");
+#endif
 
-	}
+	return i2c_add_driver(&thermostat_driver);
 }
 
-static void __exit
-thermostat_exit(void)
+static void __exit thermostat_exit(void)
 {
 	i2c_del_driver(&thermostat_driver);
-	of_device_unregister(of_dev);
 }
 
 module_init(thermostat_init);
-- 
1.7.9.5

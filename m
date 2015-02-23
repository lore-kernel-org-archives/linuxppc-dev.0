Return-Path: <haschka@gmail.com>
Received: from mail-wi0-x232.google.com (mail-wi0-x232.google.com
 [IPv6:2a00:1450:400c:c05::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0954E1A0360
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 04:08:06 +1100 (AEDT)
Received: by mail-wi0-f178.google.com with SMTP id em10so19131999wid.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 09:08:02 -0800 (PST)
From: Thomas Haschka <haschka@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] Changes in therm_adt746x.c in order to support all three
 sensors. This should avoid overheating of components such as the harddisk
 inside singe fan driven powerbooks/ibooks such as the 12inch albook. Further
 changes were made to the drivers sys interface in order to be more
 interopable with common software such as xosview
Date: Mon, 23 Feb 2015 18:08:41 +0100
Message-Id: <1424711321-19183-1-git-send-email-haschka@gmail.com>
Cc: Thomas Haschka <haschka@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Thomas Haschka <haschka@gmail.com>
---
 drivers/macintosh/therm_adt746x.c | 158 +++++++++++++++++++++++++++++---------
 1 file changed, 121 insertions(+), 37 deletions(-)

diff --git a/drivers/macintosh/therm_adt746x.c b/drivers/macintosh/therm_adt746x.c
index f433521..a29f15d 100644
--- a/drivers/macintosh/therm_adt746x.c
+++ b/drivers/macintosh/therm_adt746x.c
@@ -1,7 +1,8 @@
 /*
  * Device driver for the i2c thermostat found on the iBook G4, Albook G4
  *
- * Copyright (C) 2003, 2004 Colin Leroy, Rasmus Rohde, Benjamin Herrenschmidt
+ * Copyright (C) 2003, 2004, 2015 
+ *   Colin Leroy, Rasmus Rohde, Benjamin Herrenschmidt, Thomas Haschka
  *
  * Documentation from 115254175ADT7467_pra.pdf and 3686221171167ADT7460_b.pdf
  * http://www.onsemi.com/PowerSolutions/product.do?id=ADT7467
@@ -45,8 +46,8 @@ static u8 REM_CONTROL[2] = {0x00, 0x40};
 static u8 FAN_SPEED[2]   = {0x28, 0x2a};
 static u8 FAN_SPD_SET[2] = {0x30, 0x31};
 
-static u8 default_limits_local[3] = {70, 50, 70};    /* local, sensor1, sensor2 */
-static u8 default_limits_chip[3] = {80, 65, 80};    /* local, sensor1, sensor2 */
+static u8 default_limits_local[3] = {45, 50, 70}; /* local, sensor1, sensor2 */
+static u8 default_limits_chip[3] = {80, 65, 80}; /* local, sensor1, sensor2 */
 static const char *sensor_location[3] = { "?", "?", "?" };
 
 static int limit_adjust;
@@ -225,47 +226,114 @@ static void display_stats(struct thermostat *th)
 
 static void update_fans_speed (struct thermostat *th)
 {
-	int lastvar = 0; /* last variation, for iBook */
-	int i = 0;
+	
+	/* Multfan Laptops */
+	if ( th->type == ADT7460 ) {
+		int lastvar = 0; /* last variation, for iBook */
+		int i = 0;
+		/* we don't care about local sensor, so we start at sensor 1 */
+		for (i = 1; i < 3; i++) {
+			int started = 0;
+			int fan_number = (th->type == ADT7460 && i == 2);
+			int var = th->temps[i] - th->limits[i];
+
+			if (var > -1) {
+				int step = (255 - fan_speed) / 7;
+				int new_speed = 0;
 
-	/* we don't care about local sensor, so we start at sensor 1 */
-	for (i = 1; i < 3; i++) {
-		int started = 0;
-		int fan_number = (th->type == ADT7460 && i == 2);
-		int var = th->temps[i] - th->limits[i];
+			/* hysteresis : change fan speed only if variation is
+			 * more than two degrees */
+				if (abs(var - th->last_var[fan_number]) < 2)
+					continue;
+
+				started = 1;
+				new_speed = fan_speed + ((var-1)*step);
+
+				if (new_speed < fan_speed)
+					new_speed = fan_speed;
+				if (new_speed > 255)
+					new_speed = 255;
+
+				if (verbose)
+					printk(KERN_DEBUG 
+					       "adt746x: Setting fans speed"
+					       " to %d "
+				    	       "(limit exceeded by %d on %s)\n",
+					       new_speed, var,
+					       sensor_location[fan_number+1]);
+				write_both_fan_speed(th, new_speed);
+				th->last_var[fan_number] = var;
+			} else if (var < -2) {
+                        /* don't stop fan if sensor2 is cold and sensor1 is not
+			 * so cold (lastvar >= -1) */
+				if (i == 2 && lastvar < -1) {
+					if (th->last_speed[fan_number] != 0)
+						if (verbose)
+							printk(KERN_DEBUG 
+							       "adt746x:"
+							       " Stopping "
+							       "fans.\n");
+					write_both_fan_speed(th, 0);
+				}
+			}
 
+			lastvar = var;
+
+			if (started)
+				return; /* we don't want to re-stop the fan
+					 * if sensor1 is heating and sensor2
+					 * is not */
+		}
+	} else {
+                /*single fan laptops i.e. 12 inch powerbook/ibook*/
+		int lastvar = 0; /* last variation, for iBook */
+		int i = 0;
+		int var = 0;
+		int var_sensor[3];
+		int started = 0;
+		int fan_number = 0;
+		for (i = 0; i < 3; i++) {
+			var_sensor[i] = th->temps[i] - th->limits[i];
+		}
+		var = var_sensor[0];
+		for (i = 1; i < 3; i++) {
+			if (var_sensor[i] > var) {
+				var = var_sensor[i]; 
+			}
+		}
 		if (var > -1) {
 			int step = (255 - fan_speed) / 7;
 			int new_speed = 0;
-
 			/* hysteresis : change fan speed only if variation is
 			 * more than two degrees */
-			if (abs(var - th->last_var[fan_number]) < 2)
-				continue;
-
-			started = 1;
-			new_speed = fan_speed + ((var-1)*step);
-
-			if (new_speed < fan_speed)
-				new_speed = fan_speed;
-			if (new_speed > 255)
-				new_speed = 255;
-
-			if (verbose)
-				printk(KERN_DEBUG "adt746x: Setting fans speed to %d "
-						 "(limit exceeded by %d on %s)\n",
-						new_speed, var,
-						sensor_location[fan_number+1]);
-			write_both_fan_speed(th, new_speed);
-			th->last_var[fan_number] = var;
+		        if (abs(var - th->last_var[fan_number]) > 2) { 
+
+				started = 1;
+				new_speed = fan_speed + ((var-1)*step);
+
+				if (new_speed < fan_speed)
+					new_speed = fan_speed;
+				if (new_speed > 255)
+					new_speed = 255;
+
+				if (verbose)
+					printk(KERN_DEBUG "adt746x:"
+					       " Setting fans speed to %d "
+					       "(limit exceeded by %d on %s)\n",
+					       new_speed, var,
+					       sensor_location[fan_number+1]);
+				write_both_fan_speed(th, new_speed);
+				th->last_var[fan_number] = var; 
+			}
 		} else if (var < -2) {
 			/* don't stop fan if sensor2 is cold and sensor1 is not
 			 * so cold (lastvar >= -1) */
 			if (i == 2 && lastvar < -1) {
 				if (th->last_speed[fan_number] != 0)
 					if (verbose)
-						printk(KERN_DEBUG "adt746x: Stopping "
-							"fans.\n");
+						printk(KERN_DEBUG "adt746x:"
+						       " Stopping "
+						       "fans.\n");
 				write_both_fan_speed(th, 0);
 			}
 		}
@@ -274,10 +342,11 @@ static void update_fans_speed (struct thermostat *th)
 
 		if (started)
 			return; /* we don't want to re-stop the fan
-				* if sensor1 is heating and sensor2 is not */
+				 * if sensor1 is heating and sensor2 is not */
 	}
 }
 
+
 static int monitor_task(void *arg)
 {
 	struct thermostat* th = arg;
@@ -371,10 +440,13 @@ static ssize_t store_##name(struct device *dev, struct device_attribute *attr, c
 	return n;						\
 }
 
-BUILD_SHOW_FUNC_INT(sensor1_temperature,	 (read_reg(th, TEMP_REG[1])))
-BUILD_SHOW_FUNC_INT(sensor2_temperature,	 (read_reg(th, TEMP_REG[2])))
-BUILD_SHOW_FUNC_INT(sensor1_limit,		 th->limits[1])
-BUILD_SHOW_FUNC_INT(sensor2_limit,		 th->limits[2])
+BUILD_SHOW_FUNC_INT(sensor0_temperature,         (read_reg(th, TEMP_REG[0]))*1000)
+BUILD_SHOW_FUNC_INT(sensor1_temperature,	 (read_reg(th, TEMP_REG[1]))*1000)
+BUILD_SHOW_FUNC_INT(sensor2_temperature,	 (read_reg(th, TEMP_REG[2]))*1000)
+BUILD_SHOW_FUNC_INT(sensor0_limit,               (th->limits[0])*1000)
+BUILD_SHOW_FUNC_INT(sensor1_limit,		 (th->limits[1])*1000)
+BUILD_SHOW_FUNC_INT(sensor2_limit,		 (th->limits[2])*1000)
+BUILD_SHOW_FUNC_STR(sensor0_location,            sensor_location[0])
 BUILD_SHOW_FUNC_STR(sensor1_location,		 sensor_location[1])
 BUILD_SHOW_FUNC_STR(sensor2_location,		 sensor_location[2])
 
@@ -387,14 +459,20 @@ BUILD_SHOW_FUNC_FAN(sensor2_fan_speed,	 1)
 BUILD_SHOW_FUNC_INT_LITE(limit_adjust,	 limit_adjust)
 BUILD_STORE_FUNC_DEG(limit_adjust,	 th)
 		
+static DEVICE_ATTR(sensor0_temperature,	S_IRUGO,
+		   show_sensor0_temperature,NULL);
 static DEVICE_ATTR(sensor1_temperature,	S_IRUGO,
 		   show_sensor1_temperature,NULL);
 static DEVICE_ATTR(sensor2_temperature,	S_IRUGO,
 		   show_sensor2_temperature,NULL);
+static DEVICE_ATTR(sensor0_limit, S_IRUGO,
+		   show_sensor0_limit,	NULL);
 static DEVICE_ATTR(sensor1_limit, S_IRUGO,
 		   show_sensor1_limit,	NULL);
 static DEVICE_ATTR(sensor2_limit, S_IRUGO,
 		   show_sensor2_limit,	NULL);
+static DEVICE_ATTR(sensor0_location, S_IRUGO,
+		   show_sensor0_location, NULL);
 static DEVICE_ATTR(sensor1_location, S_IRUGO,
 		   show_sensor1_location, NULL);
 static DEVICE_ATTR(sensor2_location, S_IRUGO,
@@ -426,10 +504,13 @@ static void thermostat_create_files(struct thermostat *th)
 		return;
 	dev = &th->pdev->dev;
 	dev_set_drvdata(dev, th);
-	err = device_create_file(dev, &dev_attr_sensor1_temperature);
+	err = device_create_file(dev, &dev_attr_sensor0_temperature);
+	err |= device_create_file(dev, &dev_attr_sensor1_temperature);
 	err |= device_create_file(dev, &dev_attr_sensor2_temperature);
+	err |= device_create_file(dev, &dev_attr_sensor0_limit);
 	err |= device_create_file(dev, &dev_attr_sensor1_limit);
 	err |= device_create_file(dev, &dev_attr_sensor2_limit);
+	err |= device_create_file(dev, &dev_attr_sensor0_location);
 	err |= device_create_file(dev, &dev_attr_sensor1_location);
 	err |= device_create_file(dev, &dev_attr_sensor2_location);
 	err |= device_create_file(dev, &dev_attr_limit_adjust);
@@ -449,10 +530,13 @@ static void thermostat_remove_files(struct thermostat *th)
 	if (!th->pdev)
 		return;
 	dev = &th->pdev->dev;
+	device_remove_file(dev, &dev_attr_sensor0_temperature);
 	device_remove_file(dev, &dev_attr_sensor1_temperature);
 	device_remove_file(dev, &dev_attr_sensor2_temperature);
+	device_remove_file(dev, &dev_attr_sensor0_limit);
 	device_remove_file(dev, &dev_attr_sensor1_limit);
 	device_remove_file(dev, &dev_attr_sensor2_limit);
+	device_remove_file(dev, &dev_attr_sensor0_location);
 	device_remove_file(dev, &dev_attr_sensor1_location);
 	device_remove_file(dev, &dev_attr_sensor2_location);
 	device_remove_file(dev, &dev_attr_limit_adjust);
-- 
2.0.5

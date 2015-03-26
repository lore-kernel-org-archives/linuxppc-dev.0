Return-Path: <haschka@gmail.com>
Received: from mail-wg0-x22e.google.com (mail-wg0-x22e.google.com
 [IPv6:2a00:1450:400c:c00::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B0CE1A0145
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2015 03:23:03 +1100 (AEDT)
Received: by wgs2 with SMTP id 2so70413231wgs.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 09:22:59 -0700 (PDT)
Date: Thu, 26 Mar 2015 17:23:58 +0100
From: Thomas Haschka <haschka@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/1]: thermal driver therm_adt746.c
Message-ID: <20150326162358.GA1025@gmail.com>
References: <CADAoK=UH4q9x-OMyOpqCmGpNwDo3vey41xajBw-PDdupmEHnAA@mail.gmail.com>
 <1424726318.12891.1.camel@kernel.crashing.org>
 <20150225112457.GA3491@gmail.com>
 <1424898763.12891.77.camel@kernel.crashing.org>
 <20150226094805.GA1009@gmail.com>
 <1427261800.6468.74.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427261800.6468.74.camel@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

Here's an updated version taking your suggested changements into account
(merged the two loops into one, changed a hardcoded value into a constant).

Just to keep everything together, here are the changements:

1. changes in sensors limits, we are down from 70, 50, 70 
   to 45, 50, 70, where the first value is the environement sensor that is 
   located on the bottumside of the Harddrive. Empirical testing 
   shows that this speeds up the Fan almoast in the same moment as in OS X

2. A function has been added in order to take the environement sensor into 
   account on SingleFan Apple Notebooks (i.e. those that have air inlets
   next to the harddrive and that are cooling, besides other components 
   using the single fan in these machines.

3. Output values in /sys/devices/temperatures/ etc.. have been changed. 
   First: All three sensors can be monitored right now instead of only the 
   GPU and CPU sensors. 
   Second: The units have been changed in order to correspond to the units
   given by other temperature sensors, such as the coretemp (intel) sensor. 
   This allows to monitor them using several applications, notably xosview.

Signed-off-by: Thomas Haschka <haschka@gmail.com>
---
 drivers/macintosh/therm_adt746x.c | 123 +++++++++++++++++++++++++++++++++++---
 1 file changed, 114 insertions(+), 9 deletions(-)

diff --git a/drivers/macintosh/therm_adt746x.c b/drivers/macintosh/therm_adt746x.c
index f433521..1a36ea44 100644
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
@@ -45,8 +46,10 @@ static u8 REM_CONTROL[2] = {0x00, 0x40};
 static u8 FAN_SPEED[2]   = {0x28, 0x2a};
 static u8 FAN_SPD_SET[2] = {0x30, 0x31};
 
-static u8 default_limits_local[3] = {70, 50, 70};    /* local, sensor1, sensor2 */
-static u8 default_limits_chip[3] = {80, 65, 80};    /* local, sensor1, sensor2 */
+/* Local sensor is down to 45 in order to assure stable harddrive and 
+ * components temperature on single fan machines */
+static u8 default_limits_local[3] = {45, 50, 70}; /* local, sensor1, sensor2 */
+static u8 default_limits_chip[3] = {80, 65, 80}; /* local, sensor1, sensor2 */
 static const char *sensor_location[3] = { "?", "?", "?" };
 
 static int limit_adjust;
@@ -223,7 +226,7 @@ static void display_stats(struct thermostat *th)
 }
 #endif
 
-static void update_fans_speed (struct thermostat *th)
+static void update_fans_speed_multifan (struct thermostat *th)
 {
 	int lastvar = 0; /* last variation, for iBook */
 	int i = 0;
@@ -278,6 +281,88 @@ static void update_fans_speed (struct thermostat *th)
 	}
 }
 
+static void update_fans_speed_singlefan (struct thermostat *th) {
+
+	/* Single Fan Laptops i.e. 12 inch Powerbook, Ibook etc.
+	 * Necessites the readout of all three thermal sensors
+	 * in order to avoid the harddisk and other components to overheat
+	 * in the case of cold CPU. */
+	
+	int lastvar = 0; /* last variation, for iBook */
+	int i = 0;
+	int var = 0;
+	int var_sensor[3];
+	int started = 0;
+	const int fan_number = 0;
+
+	/* select the highest delta from all three sensors and store it to var
+	 */
+	
+	var_sensor[0] = th->temps[0] - th->limits[0];
+	var = var_sensor[0];
+	
+	for (i = 1; i < 3; i++) {
+		var_sensor[i] = th->temps[i] - th->limits[i];
+		if (var_sensor[i] > var) {
+			var = var_sensor[i]; 
+		}
+	}
+	
+	if (var > -1) {
+		int step = (255 - fan_speed) / 7;
+		int new_speed = 0;
+		/* hysteresis : change fan speed only if variation is
+		 * more than two degrees */
+		if (abs(var - th->last_var[fan_number]) > 2) { 
+
+			started = 1;
+			new_speed = fan_speed + ((var-1)*step);
+
+			if (new_speed < fan_speed)
+				new_speed = fan_speed;
+			if (new_speed > 255)
+				new_speed = 255;
+
+			if (verbose)
+				printk(KERN_DEBUG "adt746x:"
+				       " Setting fans speed to %d "
+				       "(limit exceeded by %d on %s)\n",
+				       new_speed, var,
+				       sensor_location[fan_number+1]);
+			write_both_fan_speed(th, new_speed);
+			th->last_var[fan_number] = var; 
+		}
+	} else if (var < -2) {
+		/* don't stop fan if sensor2 is cold and sensor1 is not
+		 * so cold (lastvar >= -1) */
+		if (i == 2 && lastvar < -1) {
+			if (th->last_speed[fan_number] != 0)
+				if (verbose)
+					printk(KERN_DEBUG "adt746x:"
+					       " Stopping "
+					       "fans.\n");
+			write_both_fan_speed(th, 0);
+		}
+	}
+
+	lastvar = var;
+
+	if (started)
+		return; /* we don't want to re-stop the fan
+			 * if sensor1 is heating and sensor2 is not */
+}
+
+static void update_fans_speed(struct thermostat *th) {
+
+	if (th->type == ADT7460) {
+		/* Multifan Laptops */
+		update_fans_speed_multifan(th);
+	} else {
+		/* Singlefan Laptops i.e. 12 inch Powerbook, Ibook etc. */
+		update_fans_speed_singlefan(th);
+	}
+}
+
 static int monitor_task(void *arg)
 {
 	struct thermostat* th = arg;
@@ -371,10 +456,18 @@ static ssize_t store_##name(struct device *dev, struct device_attribute *attr, c
 	return n;						\
 }
 
-BUILD_SHOW_FUNC_INT(sensor1_temperature,	 (read_reg(th, TEMP_REG[1])))
-BUILD_SHOW_FUNC_INT(sensor2_temperature,	 (read_reg(th, TEMP_REG[2])))
-BUILD_SHOW_FUNC_INT(sensor1_limit,		 th->limits[1])
-BUILD_SHOW_FUNC_INT(sensor2_limit,		 th->limits[2])
+/* Several units are multiplied by 1000 in order to have
+ * coherent readings with other 
+ * temperature sensors such as intel coretemp. This further
+ * allows programs such as xosview to read these sensors correctly */
+
+BUILD_SHOW_FUNC_INT(sensor0_temperature,       (read_reg(th, TEMP_REG[0]))*1000)
+BUILD_SHOW_FUNC_INT(sensor1_temperature,       (read_reg(th, TEMP_REG[1]))*1000)
+BUILD_SHOW_FUNC_INT(sensor2_temperature,       (read_reg(th, TEMP_REG[2]))*1000)
+BUILD_SHOW_FUNC_INT(sensor0_limit,               (th->limits[0])*1000)
+BUILD_SHOW_FUNC_INT(sensor1_limit,		 (th->limits[1])*1000)
+BUILD_SHOW_FUNC_INT(sensor2_limit,		 (th->limits[2])*1000)
+BUILD_SHOW_FUNC_STR(sensor0_location,            sensor_location[0])
 BUILD_SHOW_FUNC_STR(sensor1_location,		 sensor_location[1])
 BUILD_SHOW_FUNC_STR(sensor2_location,		 sensor_location[2])
 
@@ -387,14 +480,20 @@ BUILD_SHOW_FUNC_FAN(sensor2_fan_speed,	 1)
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
@@ -426,10 +525,13 @@ static void thermostat_create_files(struct thermostat *th)
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
@@ -449,10 +551,13 @@ static void thermostat_remove_files(struct thermostat *th)
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


On Wed, Mar 25, 2015 at 04:36:40PM +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2015-02-26 at 10:48 +0100, Thomas Haschka wrote:
> > Hello, 
> > 
> > I hope I get it correct this time, thanks again.
> 
> Thanks. Sorry for the delay, I've been a bit swamped. I looked at your
> code a bit more in depth and I would appreciate a couple more changes
> if you don't mind:
> 
> 
>  .../...
> 
> > +static void update_fans_speed_singlefan (struct thermostat *th) {
> > +
> > +	/* Single Fan Laptops i.e. 12 inch Powerbook, Ibook etc.
> > +	 * Necessites the readout of all three thermal sensors
> > +	 * in order to avoid the harddisk and other components to overheat
> > +	 * in the case of cold CPU. */
> > +	
> > +	int lastvar = 0; /* last variation, for iBook */
> > +	int i = 0;
> > +	int var = 0;
> > +	int var_sensor[3];
> > +	int started = 0;
> > +	int fan_number = 0;
> 
> So here you hard code fan_number instead of looping accross all fans,
> you could just use a constant...
> 
> > +	for (i = 0; i < 3; i++) {
> > +		var_sensor[i] = th->temps[i] - th->limits[i];
> > +	}
> > +	var = var_sensor[0];
> > +	for (i = 1; i < 3; i++) {
> > +		if (var_sensor[i] > var) {
> > +			var = var_sensor[i]; 
> > +		}
> > +	}
> 
> Why two loops ?
> 
> > +	if (var > -1) {
> > +		int step = (255 - fan_speed) / 7;
> > +		int new_speed = 0;
> > +		/* hysteresis : change fan speed only if variation is
> > +		 * more than two degrees */
> > +		if (abs(var - th->last_var[fan_number]) > 2) { 
> > +
> > +			started = 1;
> > +			new_speed = fan_speed + ((var-1)*step);
> > +
> > +			if (new_speed < fan_speed)
> > +				new_speed = fan_speed;
> > +			if (new_speed > 255)
> > +				new_speed = 255;
> > +
> > +			if (verbose)
> > +				printk(KERN_DEBUG "adt746x:"
> > +				       " Setting fans speed to %d "
> > +				       "(limit exceeded by %d on %s)\n",
> > +				       new_speed, var,
> > +				       sensor_location[fan_number+1]);
> > +			write_both_fan_speed(th, new_speed);
> > +			th->last_var[fan_number] = var; 
> > +		}
> > +	} else if (var < -2) {
> > +		/* don't stop fan if sensor2 is cold and sensor1 is not
> > +		 * so cold (lastvar >= -1) */
> > +		if (i == 2 && lastvar < -1) {
> > +			if (th->last_speed[fan_number] != 0)
> > +				if (verbose)
> > +					printk(KERN_DEBUG "adt746x:"
> > +					       " Stopping "
> > +					       "fans.\n");
> > +			write_both_fan_speed(th, 0);
> > +		}
> > +	}
> 
> This looks identical between the two functions (single/multi fan), can
> you factor it out into a single static helper that they both call ?
> 
> Cheers,
> Ben.
> 
> 

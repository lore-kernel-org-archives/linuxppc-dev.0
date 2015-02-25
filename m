Return-Path: <haschka@gmail.com>
Received: from mail-we0-x236.google.com (mail-we0-x236.google.com
 [IPv6:2a00:1450:400c:c03::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7062A1A0013
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2015 22:24:25 +1100 (AEDT)
Received: by wevk48 with SMTP id k48so2951837wev.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2015 03:24:21 -0800 (PST)
Date: Wed, 25 Feb 2015 12:24:57 +0100
From: Thomas Haschka <haschka@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/1]: thermal driver therm_adt746.c
Message-ID: <20150225112457.GA3491@gmail.com>
References: <CADAoK=UH4q9x-OMyOpqCmGpNwDo3vey41xajBw-PDdupmEHnAA@mail.gmail.com>
 <1424726318.12891.1.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1424726318.12891.1.camel@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Thanks for your comments. Here's a new patch taking them into account.

Cheers,

 
        (a) The contribution was created in whole or in part by me and I
            have the right to submit it under the GPL v2 
	    (Gnu Public License Version 2) 

        (b) The contribution is based upon previous work that, to the best
            of my knowledge, is covered under an appropriate open source
            license and I have the right under that license to submit that
            work with modifications, whether created in whole or in part
            by me, under the same open source license (unless I am
            permitted to submit under a different license), as indicated
            in the file; or

        (c) I understand and agree that this project and the contribution
            are public and that a record of the contribution (including all
            personal information I submit with it, including my sign-off) is
            maintained indefinitely and may be redistributed consistent with
            this project or the open source license(s) involved.

	Signed-off-by: Thomas Haschka <haschka@gmail.com>

--- linux/drivers/macintosh/therm_adt746x.c.orig	2015-02-25 11:26:43.164000000 +0100
+++ linux/drivers/macintosh/therm_adt746x.c	2015-02-25 11:40:54.240000000 +0100
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
@@ -223,7 +226,7 @@ static void display_stats(struct thermos
 }
 #endif
 
-static void update_fans_speed (struct thermostat *th)
+static void update_fans_speed_multifan (struct thermostat *th)
 {
 	int lastvar = 0; /* last variation, for iBook */
 	int i = 0;
@@ -278,6 +281,83 @@ static void update_fans_speed (struct th
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
+	int fan_number = 0;
+	for (i = 0; i < 3; i++) {
+		var_sensor[i] = th->temps[i] - th->limits[i];
+	}
+	var = var_sensor[0];
+	for (i = 1; i < 3; i++) {
+		if (var_sensor[i] > var) {
+			var = var_sensor[i]; 
+		}
+	}
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
@@ -371,10 +451,18 @@ static ssize_t store_##name(struct devic
 	return n;						\
 }
 
-BUILD_SHOW_FUNC_INT(sensor1_temperature,	 (read_reg(th, TEMP_REG[1])))
-BUILD_SHOW_FUNC_INT(sensor2_temperature,	 (read_reg(th, TEMP_REG[2])))
-BUILD_SHOW_FUNC_INT(sensor1_limit,		 th->limits[1])
-BUILD_SHOW_FUNC_INT(sensor2_limit,		 th->limits[2])
+/* Several nits are multiplied by 1000 in order to have
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
 
@@ -387,14 +475,20 @@ BUILD_SHOW_FUNC_FAN(sensor2_fan_speed,
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
@@ -426,10 +520,13 @@ static void thermostat_create_files(stru
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
@@ -449,10 +546,13 @@ static void thermostat_remove_files(stru
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

On Tue, Feb 24, 2015 at 08:18:38AM +1100, Benjamin Herrenschmidt wrote:
> Hi ! Please try sending patches inline rather than as attachments, it
> makes replying a bit easier... Also don't CC stable, we can shoot to
> stable later on if we think it's justified but first we need to get the
> patch upstream
> 
> A few comments:
> 
> On Mon, 2015-02-23 at 12:58 +0100, Thomas Haschka wrote:
> > --- linux/drivers/macintosh/therm_adt746x.c.orig        2015-02-23 12:19:03.984000000 +0100
> > +++ linux/drivers/macintosh/therm_adt746x.c     2015-02-23 12:22:34.980000000 +0100
> > @@ -1,7 +1,8 @@
> >  /*
> >   * Device driver for the i2c thermostat found on the iBook G4, Albook G4
> >   *
> > - * Copyright (C) 2003, 2004 Colin Leroy, Rasmus Rohde, Benjamin Herrenschmidt
> > + * Copyright (C) 2003, 2004, 2015 
> > + *   Colin Leroy, Rasmus Rohde, Benjamin Herrenschmidt, Thomas Haschka
> >   *
> >   * Documentation from 115254175ADT7467_pra.pdf and 3686221171167ADT7460_b.pdf
> >   * http://www.onsemi.com/PowerSolutions/product.do?id=ADT7467
> > @@ -45,7 +46,7 @@ static u8 REM_CONTROL[2] = {0x00, 0x40};
> >  static u8 FAN_SPEED[2]   = {0x28, 0x2a};
> >  static u8 FAN_SPD_SET[2] = {0x30, 0x31};
> >  
> > -static u8 default_limits_local[3] = {70, 50, 70};    /* local, sensor1, sensor2 */
> > +static u8 default_limits_local[3] = {45, 50, 70};    /* local, sensor1, sensor2 */
> 
> Here you change the limit for the local sensor for existing machines,
> care to explain ? I *think* that got adjusted a while back due to
> a bunch of bogus error on some machines.
> 
> >  static u8 default_limits_chip[3] = {80, 65, 80};    /* local, sensor1, sensor2 */
> >  static const char *sensor_location[3] = { "?", "?", "?" };
> >  
> > @@ -225,59 +226,123 @@ static void display_stats(struct thermos
> >  
> >  static void update_fans_speed (struct thermostat *th)
> >  {
> > -       int lastvar = 0; /* last variation, for iBook */
> > -       int i = 0;
> > -
> > -       /* we don't care about local sensor, so we start at sensor 1 */
> > -       for (i = 1; i < 3; i++) {
> > -               int started = 0;
> > -               int fan_number = (th->type == ADT7460 && i == 2);
> > -               int var = th->temps[i] - th->limits[i];
> > -
> > -               if (var > -1) {
> > -                       int step = (255 - fan_speed) / 7;
> > -                       int new_speed = 0;
> > +       
> > +       /* Multfan Laptops */
> > +       if ( th->type == ADT7460 ) {
> > +                int lastvar = 0; /* last variation, for iBook */
> > +               int i = 0;
> > +                /* we don't care about local sensor, so we start at sensor 1 */
> > +               for (i = 1; i < 3; i++) {
> > +                       int started = 0;
> > +                       int fan_number = (th->type == ADT7460 && i == 2);
> > +                       int var = th->temps[i] - th->limits[i];
> > +
> > +                       if (var > -1) {
> > +                               int step = (255 - fan_speed) / 7;
> > +                               int new_speed = 0;
> 
> The function is too big, please break it down into two sub functions,
> one for multifan and one for single fan.
> 
> It is also unclear due to the indentation changes whether you changed
> the behaviour on "other" laptops. makes the review a bit harder.
> 
> >                         /* hysteresis : change fan speed only if variation is
> >                          * more than two degrees */
> > -                       if (abs(var - th->last_var[fan_number]) < 2)
> > -                               continue;
> > -
> > -                       started = 1;
> > -                       new_speed = fan_speed + ((var-1)*step);
> > +                               if (abs(var - th->last_var[fan_number]) < 2)
> > +                                       continue;
> >  
> > -                       if (new_speed < fan_speed)
> > -                               new_speed = fan_speed;
> > -                       if (new_speed > 255)
> > -                               new_speed = 255;
> > +                               started = 1;
> > +                               new_speed = fan_speed + ((var-1)*step);
> >  
> > -                       if (verbose)
> > -                               printk(KERN_DEBUG "adt746x: Setting fans speed to %d "
> > -                                                "(limit exceeded by %d on %s)\n",
> > -                                               new_speed, var,
> > -                                               sensor_location[fan_number+1]);
> > -                       write_both_fan_speed(th, new_speed);
> > -                       th->last_var[fan_number] = var;
> > -               } else if (var < -2) {
> > +                               if (new_speed < fan_speed)
> > +                                       new_speed = fan_speed;
> > +                               if (new_speed > 255)
> > +                                       new_speed = 255;
> > +
> > +                               if (verbose)
> > +                                       printk(KERN_DEBUG "adt746x: Setting fans speed to %d "
> > +                                                        "(limit exceeded by %d on %s)\n",
> > +                                                       new_speed, var,
> > +                                                       sensor_location[fan_number+1]);
> > +                               write_both_fan_speed(th, new_speed);
> > +                               th->last_var[fan_number] = var;
> > +                       } else if (var < -2) {
> >                         /* don't stop fan if sensor2 is cold and sensor1 is not
> >                          * so cold (lastvar >= -1) */
> > -                       if (i == 2 && lastvar < -1) {
> > -                               if (th->last_speed[fan_number] != 0)
> > -                                       if (verbose)
> > +                               if (i == 2 && lastvar < -1) {
> > +                                       if (th->last_speed[fan_number] != 0)
> > +                                               if (verbose)
> > +                                                       printk(KERN_DEBUG "adt746x: Stopping "
> > +                                                               "fans.\n");
> > +                                       write_both_fan_speed(th, 0);
> > +                               }
> > +                       }
> > +
> > +                       lastvar = var;
> > +
> > +                       if (started)
> > +                               return; /* we don't want to re-stop the fan
> > +                               * if sensor1 is heating and sensor2 is not */
> > +               }
> > +       
> > +       } else {
> > +               /*single fan laptops i.e. 12 inch powerbook/ibook*/
> > +                int lastvar = 0; /* last variation, for iBook */
> > +               int i = 0;
> > +               int var = 0;
> > +               int var_sensor[3];
> > +               int started = 0;
> > +               int fan_number = 0;
> > +               for (i = 0; i < 3; i++) {
> > +                       var_sensor[i] = th->temps[i] - th->limits[i];
> > +               }
> > +               var = var_sensor[0];
> > +               for (i = 1; i < 3; i++) {
> > +                       if (var_sensor[i] > var) {
> > +                               var = var_sensor[i]; 
> > +                       }
> > +               }
> > +               if (var > -1) {
> > +                       int step = (255 - fan_speed) / 7;
> > +                       int new_speed = 0;
> > +
> > +                       /* hysteresis : change fan speed only if variation is
> > +                        * more than two degrees */
> > +                       if (abs(var - th->last_var[fan_number]) > 2) { 
> > +
> > +                       started = 1;
> > +                       new_speed = fan_speed + ((var-1)*step);
> > +
> > +                       if (new_speed < fan_speed)
> > +                               new_speed = fan_speed;
> > +                       if (new_speed > 255)
> > +                               new_speed = 255;
> > +
> > +                       if (verbose)
> > +                               printk(
> > +                                      KERN_DEBUG "adt746x: Setting fans speed to %d "
> > +                                                "(limit exceeded by %d on %s)\n",
> > +                              new_speed, var,
> > +                              sensor_location[fan_number+1]);
> > +                       write_both_fan_speed(th, new_speed);
> > +                       th->last_var[fan_number] = var; 
> > +                        }
> > +               } else if (var < -2) {
> > +         /* don't stop fan if sensor2 is cold and sensor1 is not
> > +          * so cold (lastvar >= -1) */
> > +                        if (i == 2 && lastvar < -1) {
> > +                               if (th->last_speed[fan_number] != 0)
> > +                                       if (verbose)
> >                                                 printk(KERN_DEBUG "adt746x: Stopping "
> >                                                         "fans.\n");
> > -                               write_both_fan_speed(th, 0);
> > +                                       write_both_fan_speed(th, 0);
> >                         }
> >                 }
> >  
> > -               lastvar = var;
> > +               lastvar = var;
> >  
> >                 if (started)
> > -                       return; /* we don't want to re-stop the fan
> > -                               * if sensor1 is heating and sensor2 is not */
> > +               return; /* we don't want to re-stop the fan
> > +                        * if sensor1 is heating and sensor2 is not */
> >         }
> >  }
> >  
> > +
> >  static int monitor_task(void *arg)
> >  {
> >         struct thermostat* th = arg;
> > @@ -371,10 +436,13 @@ static ssize_t store_##name(struct devic
> >         return n;                                               \
> >  }
> >  
> > -BUILD_SHOW_FUNC_INT(sensor1_temperature,        (read_reg(th, TEMP_REG[1])))
> > -BUILD_SHOW_FUNC_INT(sensor2_temperature,        (read_reg(th, TEMP_REG[2])))
> > -BUILD_SHOW_FUNC_INT(sensor1_limit,              th->limits[1])
> > -BUILD_SHOW_FUNC_INT(sensor2_limit,              th->limits[2])
> > +BUILD_SHOW_FUNC_INT(sensor0_temperature,         (read_reg(th, TEMP_REG[0]))*1000)
> > +BUILD_SHOW_FUNC_INT(sensor1_temperature,        (read_reg(th, TEMP_REG[1]))*1000)
> > +BUILD_SHOW_FUNC_INT(sensor2_temperature,        (read_reg(th, TEMP_REG[2]))*1000)
> > +BUILD_SHOW_FUNC_INT(sensor0_limit,               (th->limits[0])*1000)
> > +BUILD_SHOW_FUNC_INT(sensor1_limit,              (th->limits[1])*1000)
> > +BUILD_SHOW_FUNC_INT(sensor2_limit,              (th->limits[2])*1000)
> 
> You changed the units here, that should be documented and why.
> 
> > +BUILD_SHOW_FUNC_STR(sensor0_location,            sensor_location[0])
> >  BUILD_SHOW_FUNC_STR(sensor1_location,           sensor_location[1])
> >  BUILD_SHOW_FUNC_STR(sensor2_location,           sensor_location[2])
> >  
> > @@ -387,14 +455,20 @@ BUILD_SHOW_FUNC_FAN(sensor2_fan_speed,
> >  BUILD_SHOW_FUNC_INT_LITE(limit_adjust,  limit_adjust)
> >  BUILD_STORE_FUNC_DEG(limit_adjust,      th)
> >                 
> > +static DEVICE_ATTR(sensor0_temperature,        S_IRUGO,
> > +                  show_sensor0_temperature,NULL);
> >  static DEVICE_ATTR(sensor1_temperature,        S_IRUGO,
> >                    show_sensor1_temperature,NULL);
> >  static DEVICE_ATTR(sensor2_temperature,        S_IRUGO,
> >                    show_sensor2_temperature,NULL);
> > +static DEVICE_ATTR(sensor0_limit, S_IRUGO,
> > +                  show_sensor0_limit,  NULL);
> >  static DEVICE_ATTR(sensor1_limit, S_IRUGO,
> >                    show_sensor1_limit,  NULL);
> >  static DEVICE_ATTR(sensor2_limit, S_IRUGO,
> >                    show_sensor2_limit,  NULL);
> > +static DEVICE_ATTR(sensor0_location, S_IRUGO,
> > +                  show_sensor0_location, NULL);
> >  static DEVICE_ATTR(sensor1_location, S_IRUGO,
> >                    show_sensor1_location, NULL);
> >  static DEVICE_ATTR(sensor2_location, S_IRUGO,
> > @@ -426,10 +500,13 @@ static void thermostat_create_files(stru
> >                 return;
> >         dev = &th->pdev->dev;
> >         dev_set_drvdata(dev, th);
> > -       err = device_create_file(dev, &dev_attr_sensor1_temperature);
> > +       err = device_create_file(dev, &dev_attr_sensor0_temperature);
> > +       err |= device_create_file(dev, &dev_attr_sensor1_temperature);
> >         err |= device_create_file(dev, &dev_attr_sensor2_temperature);
> > +       err |= device_create_file(dev, &dev_attr_sensor0_limit);
> >         err |= device_create_file(dev, &dev_attr_sensor1_limit);
> >         err |= device_create_file(dev, &dev_attr_sensor2_limit);
> > +       err |= device_create_file(dev, &dev_attr_sensor0_location);
> >         err |= device_create_file(dev, &dev_attr_sensor1_location);
> >         err |= device_create_file(dev, &dev_attr_sensor2_location);
> >         err |= device_create_file(dev, &dev_attr_limit_adjust);
> > @@ -449,10 +526,13 @@ static void thermostat_remove_files(stru
> >         if (!th->pdev)
> >                 return;
> >         dev = &th->pdev->dev;
> > +       device_remove_file(dev, &dev_attr_sensor0_temperature);
> >         device_remove_file(dev, &dev_attr_sensor1_temperature);
> >         device_remove_file(dev, &dev_attr_sensor2_temperature);
> > +       device_remove_file(dev, &dev_attr_sensor0_limit);
> >         device_remove_file(dev, &dev_attr_sensor1_limit);
> >         device_remove_file(dev, &dev_attr_sensor2_limit);
> > +       device_remove_file(dev, &dev_attr_sensor0_location);
> >         device_remove_file(dev, &dev_attr_sensor1_location);
> >         device_remove_file(dev, &dev_attr_sensor2_location);
> >         device_remove_file(dev, &dev_attr_limit_adjust);
> 
> Cheers,
> Ben.
> 
> 

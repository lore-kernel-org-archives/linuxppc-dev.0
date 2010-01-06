Return-Path: <khali@linux-fr.org>
Received: from bamako.nerim.net (bamako.nerim.net [62.4.17.28])
	by ozlabs.org (Postfix) with ESMTP id C95F2B6EFE
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jan 2010 03:43:31 +1100 (EST)
Date: Wed, 6 Jan 2010 17:37:45 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: i2c_powermac: Kernel access of bad area
Message-ID: <20100106173745.57207520@hyperion.delvare>
In-Reply-To: <1262079255.2173.216.camel@pasglop>
References: <alpine.DEB.2.01.0912281934170.3483@bogon.housecafe.de>
	<1262079255.2173.216.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Christian Kujau <lists@nerdbynature.de>, linuxppc-dev@ozlabs.org,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Christian, hi Ben,

On Tue, 29 Dec 2009 20:34:15 +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2009-12-28 at 20:40 -0800, Christian Kujau wrote:
> > Hi there,
> > 
> > I was trying to find out if I still need i2c_powermac to get details off 
> > /sys/devices/temperatures, since lm-sensors isn't working for me anyway.

This is because the macintosh/therm_adt746x driver doesn't follow the
standard hwmon sysfs interface. I would love to see that change.

> > After unloading this module, I noticed that reading certain objects would 
> > fail with a segfault on the prompt and an Oops in the kernel log:
> 
> Definitely looks like we fail to clean things up on remove.

Indeed.

> I don't have much time to look into this right now, so best is you file
> a bug report on bugzilla.kernel.org, make sure I'm CCed.
> 
> Jean (added on CC), in case you already know what's up, please share :-)

I don't know anything about this for now. But I'll help if I can.

Christian, did you happen to try removing the i2c-powermac driver
before? I am curious if this is a recent problem, possibly caused by
changes to the i2c stack, or if older kernels already had this problem
and nobody ever noticed. I suspect the latter.

Looking at drivers/macintosh/therm_adt746x.c, the sysfs files are
created in thermostat_init() and removed in thermostat_exit(), which
are the driver's init and exit functions. These files are backed-up by
a per-device structure, so it looks like the wrong thing to do. I think
this is the problem: the sysfs files have a lifetime longer than the
data structure that is backing it up. This is somewhat different from
"we fail to clean things up on remove": I suspect that even if
i2c-powermac was never ever loaded, the same problem would happen.

I think that sysfs files creation should be moved to the end of
probe_thermostat() and sysfs files removal should be moved to the
beginning of remove_thermostat(). Something like the totally untested
patch below (no ppc machine at hand):

---
 drivers/macintosh/therm_adt746x.c |   34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

--- linux-2.6.33-rc3.orig/drivers/macintosh/therm_adt746x.c	2010-01-06 17:30:48.000000000 +0100
+++ linux-2.6.33-rc3/drivers/macintosh/therm_adt746x.c	2010-01-06 17:36:35.000000000 +0100
@@ -90,6 +90,8 @@ static struct task_struct *thread_therm
 
 static void write_both_fan_speed(struct thermostat *th, int speed);
 static void write_fan_speed(struct thermostat *th, int speed, int fan);
+static void thermostat_create_files(void);
+static void thermostat_remove_files(void);
 
 static int
 write_reg(struct thermostat* th, int reg, u8 data)
@@ -161,6 +163,8 @@ remove_thermostat(struct i2c_client *cli
 	struct thermostat *th = i2c_get_clientdata(client);
 	int i;
 	
+	thermostat_remove_files();
+
 	if (thread_therm != NULL) {
 		kthread_stop(thread_therm);
 	}
@@ -449,6 +453,8 @@ static int probe_thermostat(struct i2c_c
 		return -ENOMEM;
 	}
 
+	thermostat_create_files();
+
 	return 0;
 }
 
@@ -566,7 +572,6 @@ thermostat_init(void)
 	struct device_node* np;
 	const u32 *prop;
 	int i = 0, offset = 0;
-	int err;
 
 	np = of_find_node_by_name(NULL, "fan");
 	if (!np)
@@ -633,6 +638,17 @@ thermostat_init(void)
 		return -ENODEV;
 	}
 
+#ifndef CONFIG_I2C_POWERMAC
+	request_module("i2c-powermac");
+#endif
+
+	return i2c_add_driver(&thermostat_driver);
+}
+
+static void thermostat_create_files(void)
+{
+	int err;
+
 	err = device_create_file(&of_dev->dev, &dev_attr_sensor1_temperature);
 	err |= device_create_file(&of_dev->dev, &dev_attr_sensor2_temperature);
 	err |= device_create_file(&of_dev->dev, &dev_attr_sensor1_limit);
@@ -647,16 +663,9 @@ thermostat_init(void)
 	if (err)
 		printk(KERN_WARNING
 			"Failed to create tempertaure attribute file(s).\n");
-
-#ifndef CONFIG_I2C_POWERMAC
-	request_module("i2c-powermac");
-#endif
-
-	return i2c_add_driver(&thermostat_driver);
 }
 
-static void __exit
-thermostat_exit(void)
+static void thermostat_remove_files(void)
 {
 	if (of_dev) {
 		device_remove_file(&of_dev->dev, &dev_attr_sensor1_temperature);
@@ -673,9 +682,14 @@ thermostat_exit(void)
 			device_remove_file(&of_dev->dev,
 					   &dev_attr_sensor2_fan_speed);
 
-		of_device_unregister(of_dev);
 	}
+}
+
+static void __exit
+thermostat_exit(void)
+{
 	i2c_del_driver(&thermostat_driver);
+	of_device_unregister(of_dev);
 }
 
 module_init(thermostat_init);

-- 
Jean Delvare

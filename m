Return-Path: <rth@twiddle.net>
Received: from are.twiddle.net (are.twiddle.net [64.81.246.98])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A451167AE4
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Feb 2005 06:33:44 +1100 (EST)
Date: Thu, 10 Feb 2005 11:14:51 -0800
From: Richard Henderson <rth@twiddle.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20050210191451.GA6804@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
Subject: therm_pm72 changes for xserve
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The machine appears to be stable under load with this patch.
Which isn't *terribly* surprising since fan speed under darwin
seems to be universally lower.  (If there's a way to probe the
actual values under darwin, I don't know it.  This just from
standing next to the machine and listening.  I suppose this
could be from failing to lower the rpms of the third cpu fans.)

I am kinda surprised about the data we pull out the eeprom.
It seems to believe that 75C is a good target temperature.
Idle temp appears to be 42C; load temp hovers around 60C.
The high target temp means that we don't ever increase the
fan speed from the adversised minimum.

I got the actual fan ids from a patch that Harald Welte wrote
once upon a time, someplace googleable.  I'll admit that I have
no idea how one gets from

  od /proc/device-tree/sep/fans/cpu-a-1/control-id
  0000000 000000 040400

or any other entry in any of that directory, to .id=3.

Anyway, if this isn't clean enough, give me some direction.


r~


===== therm_pm72.c 1.7 vs edited =====
--- 1.7/drivers/macintosh/therm_pm72.c	2004-11-28 04:43:25 -08:00
+++ edited/therm_pm72.c	2005-02-09 23:03:08 -08:00
@@ -48,7 +48,6 @@
  *	  - Deal with fan and i2c failures in a better way
  *	  - Maybe do a generic PID based on params used for
  *	    U3 and Drives ?
- *        - Add RackMac3,1 support (XServe g5)
  *
  * History:
  *
@@ -175,7 +174,7 @@
 
 #define FCU_FAN_COUNT		ARRAY_SIZE(fcu_fans)
 
-struct fcu_fan_table	fcu_fans[] = {
+static struct fcu_fan_table powermac_fcu_fans[] = {
 	[BACKSIDE_FAN_PWM_INDEX] = {
 		.loc	= "BACKSIDE",
 		.type	= FCU_FAN_PWM,
@@ -226,6 +225,59 @@
 	},
 };
 
+/* ??? There are actually 3 fans per cpu.  We lack controling fans 2 and 5.
+   for cpus a and b respectively.  There are also fan-1@47 and fan-2@48,
+   and I don't know where they are.  They're type "adc" though.  */
+static struct fcu_fan_table rackmac_fcu_fans[] = {
+	[BACKSIDE_FAN_PWM_INDEX] = {
+		.loc	= "BACKSIDE",
+		.type	= FCU_FAN_PWM,
+		.id	= BACKSIDE_FAN_PWM_DEFAULT_ID,
+	},
+	[DRIVES_FAN_RPM_INDEX] = {
+		.loc	= "DRIVE BAY",
+		.type	= FCU_FAN_RPM,
+		.id	= FCU_FAN_ABSENT_ID,
+	},
+	[SLOTS_FAN_PWM_INDEX] = {
+		.loc	= "SLOT",
+		.type	= FCU_FAN_PWM,
+		.id	= SLOTS_FAN_PWM_DEFAULT_ID,
+	},
+	[CPUA_INTAKE_FAN_RPM_INDEX] = {
+		.loc	= "CPU A INTAKE",
+		.type	= FCU_FAN_RPM,
+		.id	= 3,
+	},
+	[CPUA_EXHAUST_FAN_RPM_INDEX] = {
+		.loc	= "CPU A EXHAUST",
+		.type	= FCU_FAN_RPM,
+		.id	= 1,
+	},
+	[CPUB_INTAKE_FAN_RPM_INDEX] = {
+		.loc	= "CPU B INTAKE",
+		.type	= FCU_FAN_RPM,
+		.id	= 4,
+	},
+	[CPUB_EXHAUST_FAN_RPM_INDEX] = {
+		.loc	= "CPU B EXHAUST",
+		.type	= FCU_FAN_RPM,
+		.id	= 6,
+	},
+	[CPUA_PUMP_RPM_INDEX] = {
+		.loc	= "CPU A PUMP",
+		.type	= FCU_FAN_RPM,		
+		.id	= FCU_FAN_ABSENT_ID,
+	},
+	[CPUB_PUMP_RPM_INDEX] = {
+		.loc	= "CPU B PUMP",
+		.type	= FCU_FAN_RPM,
+		.id	= FCU_FAN_ABSENT_ID,
+	},
+};
+
+struct fcu_fan_table *fcu_fans;
+
 /*
  * i2c_driver structure to attach to the host i2c controller
  */
@@ -1174,10 +1226,13 @@
 	/* Check fan status */
 	rc = get_rpm_fan(DRIVES_FAN_RPM_INDEX, !RPM_PID_USE_ACTUAL_SPEED);
 	if (rc < 0) {
-		printk(KERN_WARNING "Error %d reading drives fan !\n", rc);
-		/* XXX What do we do now ? */
-	} else
-		state->rpm = rc;
+		if (rc != -EINVAL)
+			printk(KERN_WARNING "Error %d reading drives fan !\n",
+			       rc);
+		return;
+	}
+
+	state->rpm = rc;
 	DBG("  current rpm: %d\n", state->rpm);
 
 	/* Get some sensor readings */
@@ -1671,8 +1726,12 @@
 {
 	struct device_node *np;
 
-	if (!machine_is_compatible("PowerMac7,2") &&
-	    !machine_is_compatible("PowerMac7,3"))
+	if (machine_is_compatible("PowerMac7,2") ||
+	    machine_is_compatible("PowerMac7,3"))
+		fcu_fans = powermac_fcu_fans;
+	else if (machine_is_compatible("RackMac3,1"))
+		fcu_fans = rackmac_fcu_fans;
+	else
 	    	return -ENODEV;
 
 	printk(KERN_INFO "PowerMac G5 Thermal control driver %s\n", VERSION);
@@ -1709,6 +1768,6 @@
 module_exit(therm_pm72_exit);
 
 MODULE_AUTHOR("Benjamin Herrenschmidt <benh@kernel.crashing.org>");
-MODULE_DESCRIPTION("Driver for Apple's PowerMac7,2 G5 thermal control");
+MODULE_DESCRIPTION("Driver for Apple's PowerMac and RackMac G5 thermal control");
 MODULE_LICENSE("GPL");
 
===== Kconfig 1.9 vs edited =====
--- 1.9/drivers/macintosh/Kconfig	2004-08-02 01:00:44 -07:00
+++ edited/Kconfig	2005-02-09 23:02:41 -08:00
@@ -177,11 +177,11 @@
 	  better fan behaviour by default, and some manual control.
 
 config THERM_PM72
-	tristate "Support for thermal management on PowerMac G5"
+	tristate "Support for thermal management on Apple G5"
 	depends on I2C && I2C_KEYWEST && PPC_PMAC64
 	help
-	  This driver provides thermostat and fan control for the desktop
-	  G5 machines. 
+	  This driver provides thermostat and fan control for desktop
+	  and rack-mounted G5 machines. 
 
 config ANSLCD
 	tristate "Support for ANS LCD display"

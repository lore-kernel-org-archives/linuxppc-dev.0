Date: Thu, 5 Aug 2004 13:43:48 +0200
From: Harald Welte <laforge@gnumonks.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] ugly hack to make therm_pm72 work on XServe G5
Message-ID: <20040805114348.GD7112@sunbeam2>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="juZjCTNxrMaZdGZC"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--juZjCTNxrMaZdGZC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi!

I've now figured out most of the details on the Apple FCU setup on my
Dual G5 XServe ClusterNode.  In case anybody is interested, attached is
a ugly hack to add support for RackMac3,1 to therm_pm72.c and make the
machine a bit less noisy.

I'm now working on a completely new FCU driver that just exports the fan
RPM / PWM, voltage/current/... to userspace.  I think some userspace
process can then take care about the policy when and how to blow what
amount of air through the individual fans.

My main problem is that the machine will be installed in some rack 500km
away, so I can't really make sure that any further driver development
will actually work as expected. ;)

Just in case anybody else wants to dive into this issue, please contact
me before, I already discovered quite a lot more about the FCU/i2c/...
setup in the RackMac3,1 than what is visible in this patch.

(attached also a small userspace program to hard-code the fans to some
rpm/pwm)
--
- Harald Welte <laforge@gnumonks.org>               http://www.gnumonks.org/
============================================================================
Programming is like sex: One mistake and you have to support it your lifetime

--juZjCTNxrMaZdGZC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="therm_pm72-xserve.patch"
Content-Transfer-Encoding: quoted-printable

diff -u orig-kernel/therm_pm72.c old-kernel/therm_pm72.c
--- orig-kernel/drivers/macintosh/therm_pm72.c	2004-08-05 14:12:18.00000000=
0 +0200
+++ old-kernel/drivers/macintosh/therm_pm72.c	2004-08-05 15:20:16.000000000=
 +0200
@@ -73,6 +73,9 @@
  *        values in the configuration register
  *	- Switch back to use of target fan speed for PID, thus lowering
  *        pressure on i2c
+ * Aug. 05, 2004: 0.91
+ *	- Harald Welte <laforge@gnumonks.org>:
+ *		- add minimal support for XServe G5
  */
=20
 #include <linux/config.h>
@@ -101,9 +104,9 @@
=20
 #include "therm_pm72.h"
=20
-#define VERSION "0.9"
+#define VERSION "0.91"
=20
-#undef DEBUG
+#define DEBUG
=20
 #ifdef DEBUG
 #define DBG(args...)	printk(args)
@@ -509,10 +514,7 @@
 	DBG("cpu %d:\n", state->index);
=20
 	/* Read current fan status */
-	if (state->index =3D=3D 0)
-		rc =3D get_rpm_fan(CPUA_EXHAUST_FAN_RPM_ID, !RPM_PID_USE_ACTUAL_SPEED);
-	else
-		rc =3D get_rpm_fan(CPUB_EXHAUST_FAN_RPM_ID, !RPM_PID_USE_ACTUAL_SPEED);
+	rc =3D get_rpm_fan(state->exhaust_fan_id, !RPM_PID_USE_ACTUAL_SPEED);
 	if (rc < 0) {
 		printk(KERN_WARNING "Error %d reading CPU %d exhaust fan !\n",
 		       rc, state->index);
@@ -662,12 +664,15 @@
 	 * failures (-EFAULT) we probably want to notify userland
 	 * some way...
 	 */
-	if (state->index =3D=3D 0) {
-		set_rpm_fan(CPUA_INTAKE_FAN_RPM_ID, intake);
-		set_rpm_fan(CPUA_EXHAUST_FAN_RPM_ID, state->rpm);
-	} else {
-		set_rpm_fan(CPUB_INTAKE_FAN_RPM_ID, intake);
-		set_rpm_fan(CPUB_EXHAUST_FAN_RPM_ID, state->rpm);
+	set_rpm_fan(state->intake_fan_id, intake);
+	set_rpm_fan(state->exhaust_fan_id, state->rpm);
+
+	/* ugly hack */
+	if (machine_is_compatible("RackMac3,1")) {
+		if (state->index =3D=3D 0)
+			set_rpm_fan(2, state->rpm);
+		else
+			set_rpm_fan(5, state->rpm);
 	}
 }
=20
@@ -699,6 +704,24 @@
 	}
 	DBG("CPU %d Using %d power history entries\n", index, state->count_power);
=20
+	if (machine_is_compatible("PowerMac7,2")) {
+		if (index =3D=3D 0) {
+			state->intake_fan_id =3D 3;
+			state->exhaust_fan_id =3D 4;
+		} else {
+			state->intake_fan_id =3D 5;
+			state->exhaust_fan_id =3D 6;
+		}
+	} else {
+		/* RackMac 3,1 */
+		if (index =3D=3D 0) {
+			state->intake_fan_id =3D 3;	/* right */
+			state->exhaust_fan_id =3D 1;	/* left */
+		} else {
+			state->intake_fan_id =3D 4;	/* left */
+			state->exhaust_fan_id =3D 6;	/* right */
+		}
+	}
 	if (index =3D=3D 0) {
 		device_create_file(&of_dev->dev, &dev_attr_cpu0_temperature);
 		device_create_file(&of_dev->dev, &dev_attr_cpu0_voltage);
@@ -772,6 +795,7 @@
 		state->pwm =3D rc;
 	DBG("  current pwm: %d\n", state->pwm);
=20
+	if (machine_is_compatible("PowerMac7,2")) {
 	/* Get some sensor readings */
 	temp =3D i2c_smbus_read_byte_data(state->monitor, MAX6690_EXT_TEMP) << 16;
 	state->last_temp =3D temp;
@@ -829,6 +853,8 @@
 		state->pwm =3D BACKSIDE_PID_OUTPUT_MIN;
 	if (state->pwm > BACKSIDE_PID_OUTPUT_MAX)
 		state->pwm =3D BACKSIDE_PID_OUTPUT_MAX;
+	} else=20
+		state->pwm =3D 40;
=20
 	DBG("** BACKSIDE PWM: %d\n", (int)state->pwm);
 	set_pwm_fan(BACKSIDE_FAN_PWM_ID, state->pwm);
@@ -843,11 +869,16 @@
 	state->first =3D 1;
 	state->pwm =3D 50;
=20
-	state->monitor =3D attach_i2c_chip(BACKSIDE_MAX_ID, "backside_temp");
-	if (state->monitor =3D=3D NULL)
-		return -ENODEV;
+	if (machine_is_compatible("PowerMac7,2")) {
+		state->monitor =3D attach_i2c_chip(BACKSIDE_MAX_ID,=20
+						 "backside_temp");
+		if (state->monitor =3D=3D NULL)
+			return -ENODEV;
+
+		device_create_file(&of_dev->dev,=20
+				   &dev_attr_backside_temperature);
+	}
=20
-	device_create_file(&of_dev->dev, &dev_attr_backside_temperature);
 	device_create_file(&of_dev->dev, &dev_attr_backside_fan_pwm);
=20
 	return 0;
@@ -860,11 +891,13 @@
 {
 	if (state->monitor =3D=3D NULL)
 		return;
-
-	device_remove_file(&of_dev->dev, &dev_attr_backside_temperature);
+	if (machine_is_compatible("PowerMac7,2")) {
+		device_remove_file(&of_dev->dev,=20
+				   &dev_attr_backside_temperature);
+		detach_i2c_chip(state->monitor);
+	}
 	device_remove_file(&of_dev->dev, &dev_attr_backside_fan_pwm);
=20
-	detach_i2c_chip(state->monitor);
 	state->monitor =3D NULL;
 }
 =20
@@ -1031,7 +1064,9 @@
 		if (cpu_state[1].monitor !=3D NULL)
 			do_monitor_cpu(&cpu_state[1]);
 		do_monitor_backside(&backside_state);
-		do_monitor_drives(&drives_state);
+		if (machine_is_compatible("PowerMac7,2")) {
+			do_monitor_drives(&drives_state);
+		}
 		up(&driver_lock);
=20
 		if (critical_state =3D=3D 1) {
@@ -1070,9 +1105,11 @@
 {
 	dispose_cpu_state(&cpu_state[0]);
 	dispose_cpu_state(&cpu_state[1]);
-
 	dispose_backside_state(&backside_state);
-	dispose_drives_state(&drives_state);
+
+	if (machine_is_compatible("PowerMac7,2")) {
+		dispose_drives_state(&drives_state);
+	}
 }
=20
 /*
@@ -1101,8 +1138,11 @@
 		goto fail;
 	if (init_backside_state(&backside_state))
 		goto fail;
-	if (init_drives_state(&drives_state))
-		goto fail;
+
+	if (machine_is_compatible("PowerMac7,2")) {
+		if (init_drives_state(&drives_state))
+			goto fail;
+	}
=20
 	DBG("all control loops up !\n");
=20
@@ -1280,7 +1320,8 @@
 {
 	struct device_node *np;
=20
-	if (!machine_is_compatible("PowerMac7,2"))
+	if (!machine_is_compatible("PowerMac7,2") &&
+	    !machine_is_compatible("RackMac3,1"))
 	    	return -ENODEV;
=20
 	printk(KERN_INFO "PowerMac G5 Thermal control driver %s\n", VERSION);
@@ -1313,6 +1354,6 @@
 module_exit(therm_pm72_exit);
=20
 MODULE_AUTHOR("Benjamin Herrenschmidt <benh@kernel.crashing.org>");
-MODULE_DESCRIPTION("Driver for Apple's PowerMac7,2 G5 thermal control");
+MODULE_DESCRIPTION("Driver for Apple's PowerMac7,2 / RackMac3,1  G5 therma=
l control");
 MODULE_LICENSE("GPL");
=20
diff -u orig-kernel/therm_pm72.h old-kernel/therm_pm72.h
--- orig-kernel/drivers/macintosh/therm_pm72.h	2004-08-05 14:12:18.00000000=
0 +0200
+++ old-kernel/drivers/macintosh/therm_pm72.h	2004-08-05 15:20:16.000000000=
 +0200
@@ -191,11 +191,6 @@
  * CPU B FAKE POWER	49	(I_V_inputs: 18, 19)
  */
=20
-#define CPUA_INTAKE_FAN_RPM_ID		3
-#define CPUA_EXHAUST_FAN_RPM_ID		4
-#define CPUB_INTAKE_FAN_RPM_ID		5
-#define CPUB_EXHAUST_FAN_RPM_ID		6
-
 #define CPU_INTAKE_SCALE		0x0000f852
 #define CPU_TEMP_HISTORY_SIZE		2
 #define CPU_POWER_HISTORY_SIZE		10
@@ -221,6 +216,8 @@
 	s32			last_temp;
 	int			first;
 	u8			adc_config;
+	int			exhaust_fan_id;
+	int			intake_fan_id;
 };
=20
 /*

--juZjCTNxrMaZdGZC--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

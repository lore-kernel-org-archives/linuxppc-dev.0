Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5560D67AD5
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Feb 2005 09:32:49 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Richard Henderson <rth@twiddle.net>
In-Reply-To: <20050210191451.GA6804@twiddle.net>
References: <20050210191451.GA6804@twiddle.net>
Content-Type: text/plain
Date: Fri, 11 Feb 2005 09:31:36 +1100
Message-Id: <1108074696.7686.210.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: therm_pm72 changes for xserve
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2005-02-10 at 11:14 -0800, Richard Henderson wrote:
> The machine appears to be stable under load with this patch.
> Which isn't *terribly* surprising since fan speed under darwin
> seems to be universally lower.  (If there's a way to probe the
> actual values under darwin, I don't know it.  This just from
> standing next to the machine and listening.  I suppose this
> could be from failing to lower the rpms of the third cpu fans.)
> 
> I am kinda surprised about the data we pull out the eeprom.
> It seems to believe that 75C is a good target temperature.
> Idle temp appears to be 42C; load temp hovers around 60C.
> The high target temp means that we don't ever increase the
> fan speed from the adversised minimum.
> 
> I got the actual fan ids from a patch that Harald Welte wrote
> once upon a time, someplace googleable.  I'll admit that I have
> no idea how one gets from
> 
>   od /proc/device-tree/sep/fans/cpu-a-1/control-id
>   0000000 000000 040400
> 
> or any other entry in any of that directory, to .id=3.
> 
> Anyway, if this isn't clean enough, give me some direction.

Hi ! You should have asked me :) I did some work on the Xserve. Notably,
it uses a slightly different algorithm.... Here's my current patch.

Index: linux-work/drivers/macintosh/therm_pm72.c
===================================================================
--- linux-work.orig/drivers/macintosh/therm_pm72.c	2005-01-18 18:15:25.000000000 +1100
+++ linux-work/drivers/macintosh/therm_pm72.c	2005-01-18 18:15:33.000000000 +1100
@@ -47,8 +47,11 @@
  *          decisions, like slewing down CPUs
  *	  - Deal with fan and i2c failures in a better way
  *	  - Maybe do a generic PID based on params used for
- *	    U3 and Drives ?
- *        - Add RackMac3,1 support (XServe g5)
+ *	    U3 and Drives ? Definitely need to factor code a bit
+ *          bettter... also make sensor detection more robust using
+ *          the device-tree to probe for them
+ *        - Figure out how to get the slots consumption and set the
+ *          slots fan accordingly
  *
  * History:
  *
@@ -85,6 +88,12 @@
  *	- Add new CPU cooling algorithm for machines with liquid cooling
  *	- Workaround for some PowerMac7,3 with empty "fan" node in the devtree
  *	- Fix a signed/unsigned compare issue in some PID loops
+ *
+ *  Nov. 16, 2004 : 1.2b2
+ *	- Add basic support for Xserve G5
+ *	- Retreive pumps min/max from EEPROM image in device-tree (broken)
+ *	- Use min/max macros here or there
+ *	- Latest darwin updated U3H min fan speed to 20% PWM
  */
 
 #include <linux/config.h>
@@ -113,7 +122,7 @@
 
 #include "therm_pm72.h"
 
-#define VERSION "1.1"
+#define VERSION "1.2b2"
 
 #undef DEBUG
 
@@ -131,21 +140,26 @@
 static struct of_device *		of_dev;
 static struct i2c_adapter *		u3_0;
 static struct i2c_adapter *		u3_1;
+static struct i2c_adapter *		k2;
 static struct i2c_client *		fcu;
 static struct cpu_pid_state		cpu_state[2];
 static struct basckside_pid_params	backside_params;
 static struct backside_pid_state	backside_state;
 static struct drives_pid_state		drives_state;
+static struct dimm_pid_state		dimms_state;
 static int				state;
 static int				cpu_count;
 static int				cpu_pid_type;
 static pid_t				ctrl_task;
 static struct completion		ctrl_complete;
 static int				critical_state;
+static int				rackmac;
+static s32				dimm_output_clamp;
+
 static DECLARE_MUTEX(driver_lock);
 
 /*
- * We have 2 types of CPU PID control. One is "split" old style control
+ * We have 3 types of CPU PID control. One is "split" old style control
  * for intake & exhaust fans, the other is "combined" control for both
  * CPUs that also deals with the pumps when present. To be "compatible"
  * with OS X at this point, we only use "COMBINED" on the machines that
@@ -155,6 +169,7 @@
  */
 #define CPU_PID_TYPE_SPLIT	0
 #define CPU_PID_TYPE_COMBINED	1
+#define CPU_PID_TYPE_RACKMAC	2
 
 /*
  * This table describes all fans in the FCU. The "id" and "type" values
@@ -177,7 +192,7 @@
 
 struct fcu_fan_table	fcu_fans[] = {
 	[BACKSIDE_FAN_PWM_INDEX] = {
-		.loc	= "BACKSIDE",
+		.loc	= "BACKSIDE,SYS CTRLR FAN",
 		.type	= FCU_FAN_PWM,
 		.id	= BACKSIDE_FAN_PWM_DEFAULT_ID,
 	},
@@ -187,7 +202,7 @@
 		.id	= DRIVES_FAN_RPM_DEFAULT_ID,
 	},
 	[SLOTS_FAN_PWM_INDEX] = {
-		.loc	= "SLOT",
+		.loc	= "SLOT,PCI FAN",
 		.type	= FCU_FAN_PWM,
 		.id	= SLOTS_FAN_PWM_DEFAULT_ID,
 	},
@@ -224,6 +239,37 @@
 		.type	= FCU_FAN_RPM,
 		.id	= FCU_FAN_ABSENT_ID,
 	},
+	/* Xserve fans */
+	[CPU_A1_FAN_RPM_INDEX] = {
+		.loc	= "CPU A 1",
+		.type	= FCU_FAN_RPM,
+		.id	= FCU_FAN_ABSENT_ID,
+	},
+	[CPU_A2_FAN_RPM_INDEX] = {
+		.loc	= "CPU A 2",
+		.type	= FCU_FAN_RPM,
+		.id	= FCU_FAN_ABSENT_ID,
+	},
+	[CPU_A3_FAN_RPM_INDEX] = {
+		.loc	= "CPU A 3",
+		.type	= FCU_FAN_RPM,
+		.id	= FCU_FAN_ABSENT_ID,
+	},
+	[CPU_B1_FAN_RPM_INDEX] = {
+		.loc	= "CPU B 1",
+		.type	= FCU_FAN_RPM,
+		.id	= FCU_FAN_ABSENT_ID,
+	},
+	[CPU_B2_FAN_RPM_INDEX] = {
+		.loc	= "CPU B 2",
+		.type	= FCU_FAN_RPM,
+		.id	= FCU_FAN_ABSENT_ID,
+	},
+	[CPU_B3_FAN_RPM_INDEX] = {
+		.loc	= "CPU B 3",
+		.type	= FCU_FAN_RPM,
+		.id	= FCU_FAN_ABSENT_ID,
+	},
 };
 
 /*
@@ -251,7 +297,9 @@
 	struct i2c_client *clt;
 	struct i2c_adapter *adap;
 
-	if (id & 0x100)
+	if (id & 0x200)
+		adap = k2;
+	else if (id & 0x100)
 		adap = u3_1;
 	else
 		adap = u3_0;
@@ -361,6 +409,31 @@
 	}
 }
 
+static int read_lm87_reg(struct i2c_client * chip, int reg)
+{
+	int rc, tries = 0;
+	u8 buf;
+
+	for (;;) {
+		/* Set address */
+		buf = (u8)reg;
+		rc = i2c_master_send(chip, &buf, 1);
+		if (rc <= 0)
+			goto error;
+		rc = i2c_master_recv(chip, &buf, 1);
+		if (rc <= 0)
+			goto error;
+		return (int)buf;
+	error:
+		DBG("Error reading LM87, retrying...\n");
+		if (++tries > 10) {
+			printk(KERN_ERR "therm_pm72: Error reading LM87 !\n");
+			return -1;
+		}
+		msleep(10);
+	}
+}
+
 static int fan_read_reg(int reg, unsigned char *buf, int nb)
 {
 	int tries, nr, nw;
@@ -570,6 +643,38 @@
 	return 0;
 }
 
+static void fetch_cpu_pumps_minmax(void)
+{
+	struct cpu_pid_state *state0 = &cpu_state[0];
+	struct cpu_pid_state *state1 = &cpu_state[1];
+	u16 pump_min = 0, pump_max = 0xffff;
+	u16 tmp[4];
+
+	/* Try to fetch pumps min/max infos from eeprom */
+
+	memcpy(&tmp, &state0->mpu.processor_part_num, 8);
+	if (tmp[0] != 0xffff && tmp[1] != 0xffff) {
+		pump_min = max(pump_min, tmp[0]);
+		pump_max = min(pump_max, tmp[1]);
+	}
+	if (tmp[2] != 0xffff && tmp[3] != 0xffff) {
+		pump_min = max(pump_min, tmp[2]);
+		pump_max = min(pump_max, tmp[3]);
+	}
+
+	/* Double check the values, this _IS_ needed as the EEPROM on
+	 * some dual 2.5Ghz G5s seem, at least, to have both min & max
+	 * same to the same value ... (grrrr)
+	 */
+	if (pump_min == pump_max || pump_min == 0 || pump_max == 0xffff) {
+		pump_min = CPU_PUMP_OUTPUT_MIN;
+		pump_max = CPU_PUMP_OUTPUT_MAX;
+	}
+
+	state0->pump_min = state1->pump_min = pump_min;
+	state0->pump_max = state1->pump_max = pump_max;
+}
+
 /* 
  * Now, unfortunately, sysfs doesn't give us a nice void * we could
  * pass around to the attribute functions, so we don't really have
@@ -611,6 +716,8 @@
 BUILD_SHOW_FUNC_FIX(drives_temperature, drives_state.last_temp)
 BUILD_SHOW_FUNC_INT(drives_fan_rpm, drives_state.rpm)
 
+BUILD_SHOW_FUNC_FIX(dimms_temperature, dimms_state.last_temp)
+
 static DEVICE_ATTR(cpu0_temperature,S_IRUGO,show_cpu0_temperature,NULL);
 static DEVICE_ATTR(cpu0_voltage,S_IRUGO,show_cpu0_voltage,NULL);
 static DEVICE_ATTR(cpu0_current,S_IRUGO,show_cpu0_current,NULL);
@@ -629,6 +736,8 @@
 static DEVICE_ATTR(drives_temperature,S_IRUGO,show_drives_temperature,NULL);
 static DEVICE_ATTR(drives_fan_rpm,S_IRUGO,show_drives_fan_rpm,NULL);
 
+static DEVICE_ATTR(dimms_temperature,S_IRUGO,show_dimms_temperature,NULL);
+
 /*
  * CPUs fans control loop
  */
@@ -636,17 +745,21 @@
 static int do_read_one_cpu_values(struct cpu_pid_state *state, s32 *temp, s32 *power)
 {
 	s32 ltemp, volts, amps;
-	int rc = 0;
+	int index, rc = 0;
 
 	/* Default (in case of error) */
 	*temp = state->cur_temp;
 	*power = state->cur_power;
 
-	/* Read current fan status */
-	if (state->index == 0)
-		rc = get_rpm_fan(CPUA_EXHAUST_FAN_RPM_INDEX, !RPM_PID_USE_ACTUAL_SPEED);
+	if (cpu_pid_type == CPU_PID_TYPE_RACKMAC)
+		index = (state->index == 0) ?
+			CPU_A1_FAN_RPM_INDEX : CPU_B1_FAN_RPM_INDEX;
 	else
-		rc = get_rpm_fan(CPUB_EXHAUST_FAN_RPM_INDEX, !RPM_PID_USE_ACTUAL_SPEED);
+		index = (state->index == 0) ?
+			CPUA_EXHAUST_FAN_RPM_INDEX : CPUB_EXHAUST_FAN_RPM_INDEX;
+
+	/* Read current fan status */
+	rc = get_rpm_fan(index, !RPM_PID_USE_ACTUAL_SPEED);
 	if (rc < 0) {
 		/* XXX What do we do now ? Nothing for now, keep old value, but
 		 * return error upstream
@@ -777,11 +890,6 @@
 
 	DBG("   sum: %d\n", (int)sum);
 	state->rpm += (s32)sum;
-
-	if (state->rpm < (int)state->mpu.rminn_exhaust_fan)
-		state->rpm = state->mpu.rminn_exhaust_fan;
-	if (state->rpm > (int)state->mpu.rmaxn_exhaust_fan)
-		state->rpm = state->mpu.rmaxn_exhaust_fan;
 }
 
 static void do_monitor_cpu_combined(void)
@@ -823,28 +931,28 @@
 	if (state0->overtemp > 0) {
 		state0->rpm = state0->mpu.rmaxn_exhaust_fan;
 		state0->intake_rpm = intake = state0->mpu.rmaxn_intake_fan;
-		pump = CPU_PUMP_OUTPUT_MAX;
+		pump = state0->pump_min;
 		goto do_set_fans;
 	}
 
 	/* Do the PID */
 	do_cpu_pid(state0, temp_combi, power_combi);
 
+	/* Range check */
+	state0->rpm = max(state0->rpm, (int)state0->mpu.rminn_exhaust_fan);
+	state0->rpm = min(state0->rpm, (int)state0->mpu.rmaxn_exhaust_fan);
+
 	/* Calculate intake fan speed */
 	intake = (state0->rpm * CPU_INTAKE_SCALE) >> 16;
-	if (intake < (int)state0->mpu.rminn_intake_fan)
-		intake = state0->mpu.rminn_intake_fan;
-	if (intake > (int)state0->mpu.rmaxn_intake_fan)
-		intake = state0->mpu.rmaxn_intake_fan;
+	intake = max(intake, (int)state0->mpu.rminn_intake_fan);
+	intake = min(intake, (int)state0->mpu.rmaxn_intake_fan);
 	state0->intake_rpm = intake;
 
 	/* Calculate pump speed */
-	pump = (state0->rpm * CPU_PUMP_OUTPUT_MAX) /
+	pump = (state0->rpm * state0->pump_max) /
 		state0->mpu.rmaxn_exhaust_fan;
-	if (pump > CPU_PUMP_OUTPUT_MAX)
-		pump = CPU_PUMP_OUTPUT_MAX;
-	if (pump < CPU_PUMP_OUTPUT_MIN)
-		pump = CPU_PUMP_OUTPUT_MIN;
+	pump = min(pump, state0->pump_max);
+	pump = max(pump, state0->pump_min);
 	
  do_set_fans:
 	/* We copy values from state 0 to state 1 for /sysfs */
@@ -904,11 +1012,14 @@
 	/* Do the PID */
 	do_cpu_pid(state, temp, power);
 
+	/* Range check */
+	state->rpm = max(state->rpm, (int)state->mpu.rminn_exhaust_fan);
+	state->rpm = min(state->rpm, (int)state->mpu.rmaxn_exhaust_fan);
+
+	/* Calculate intake fan */
 	intake = (state->rpm * CPU_INTAKE_SCALE) >> 16;
-	if (intake < (int)state->mpu.rminn_intake_fan)
-		intake = state->mpu.rminn_intake_fan;
-	if (intake > (int)state->mpu.rmaxn_intake_fan)
-		intake = state->mpu.rmaxn_intake_fan;
+	intake = max(intake, (int)state->mpu.rminn_intake_fan);
+	intake = min(intake, (int)state->mpu.rmaxn_intake_fan);
 	state->intake_rpm = intake;
 
  do_set_fans:
@@ -929,6 +1040,67 @@
 	}
 }
 
+static void do_monitor_cpu_rack(struct cpu_pid_state *state)
+{
+	s32 temp, power, fan_min;
+	int rc;
+
+	/* Read current fan status */
+	rc = do_read_one_cpu_values(state, &temp, &power);
+	if (rc < 0) {
+		/* XXX What do we do now ? */
+	}
+
+	/* Check tmax, increment overtemp if we are there. At tmax+8, we go
+	 * full blown immediately and try to trigger a shutdown
+	 */
+	if (temp >= ((state->mpu.tmax + 8) << 16)) {
+		printk(KERN_WARNING "Warning ! CPU %d temperature way above maximum"
+		       " (%d) !\n",
+		       state->index, temp >> 16);
+		state->overtemp = CPU_MAX_OVERTEMP;
+	} else if (temp > (state->mpu.tmax << 16))
+		state->overtemp++;
+	else
+		state->overtemp = 0;
+	if (state->overtemp >= CPU_MAX_OVERTEMP)
+		critical_state = 1;
+	if (state->overtemp > 0) {
+		state->rpm = state->intake_rpm = state->mpu.rmaxn_intake_fan;
+		goto do_set_fans;
+	}
+
+	/* Do the PID */
+	do_cpu_pid(state, temp, power);
+
+	/* Check clamp from dimms */
+	fan_min = dimm_output_clamp;
+	fan_min = max(fan_min, (int)state->mpu.rminn_intake_fan);
+
+	state->rpm = max(state->rpm, (int)fan_min);
+	state->rpm = min(state->rpm, (int)state->mpu.rmaxn_intake_fan);
+	state->intake_rpm = state->rpm;
+
+ do_set_fans:
+	DBG("** CPU %d RPM: %d overtemp: %d\n",
+	    state->index, (int)state->rpm, state->overtemp);
+
+	/* We should check for errors, shouldn't we ? But then, what
+	 * do we do once the error occurs ? For FCU notified fan
+	 * failures (-EFAULT) we probably want to notify userland
+	 * some way...
+	 */
+	if (state->index == 0) {
+		set_rpm_fan(CPU_A1_FAN_RPM_INDEX, state->rpm);
+		set_rpm_fan(CPU_A2_FAN_RPM_INDEX, state->rpm);
+		set_rpm_fan(CPU_A3_FAN_RPM_INDEX, state->rpm);
+	} else {
+		set_rpm_fan(CPU_B1_FAN_RPM_INDEX, state->rpm);
+		set_rpm_fan(CPU_B2_FAN_RPM_INDEX, state->rpm);
+		set_rpm_fan(CPU_B3_FAN_RPM_INDEX, state->rpm);
+	}
+}
+
 /*
  * Initialize the state structure for one CPU control loop
  */
@@ -936,7 +1108,7 @@
 {
 	state->index = index;
 	state->first = 1;
-	state->rpm = 1000;
+	state->rpm = (cpu_pid_type == CPU_PID_TYPE_RACKMAC) ? 4000 : 1000;
 	state->overtemp = 0;
 	state->adc_config = 0x00;
 
@@ -1012,13 +1184,13 @@
  */
 static void do_monitor_backside(struct backside_pid_state *state)
 {
-	s32 temp, integral, derivative;
+	s32 temp, integral, derivative, fan_min;
 	s64 integ_p, deriv_p, prop_p, sum; 
 	int i, rc;
 
 	if (--state->ticks != 0)
 		return;
-	state->ticks = BACKSIDE_PID_INTERVAL;
+	state->ticks = backside_params.interval;
 
 	DBG("backside:\n");
 
@@ -1059,7 +1231,7 @@
 	integral = 0;
 	for (i = 0; i < BACKSIDE_PID_HISTORY_SIZE; i++)
 		integral += state->error_history[i];
-	integral *= BACKSIDE_PID_INTERVAL;
+	integral *= backside_params.interval;
 	DBG("  integral: %08x\n", integral);
 	integ_p = ((s64)backside_params.G_r) * (s64)integral;
 	DBG("   integ_p: %d\n", (int)(integ_p >> 36));
@@ -1069,7 +1241,7 @@
 	derivative = state->error_history[state->cur_sample] -
 		state->error_history[(state->cur_sample + BACKSIDE_PID_HISTORY_SIZE - 1)
 				    % BACKSIDE_PID_HISTORY_SIZE];
-	derivative /= BACKSIDE_PID_INTERVAL;
+	derivative /= backside_params.interval;
 	deriv_p = ((s64)backside_params.G_d) * (s64)derivative;
 	DBG("   deriv_p: %d\n", (int)(deriv_p >> 36));
 	sum += deriv_p;
@@ -1083,11 +1255,17 @@
 	sum >>= 36;
 
 	DBG("   sum: %d\n", (int)sum);
-	state->pwm += (s32)sum;
-	if (state->pwm < backside_params.output_min)
-		state->pwm = backside_params.output_min;
-	if (state->pwm > backside_params.output_max)
-		state->pwm = backside_params.output_max;
+	if (backside_params.additive)
+		state->pwm += (s32)sum;
+	else
+		state->pwm = sum;
+
+	/* Check for clamp */
+	fan_min = (dimm_output_clamp * 100) / 14000;
+	fan_min = max(fan_min, backside_params.output_min);
+
+	state->pwm = max(state->pwm, fan_min);
+	state->pwm = min(state->pwm, backside_params.output_max);
 
 	DBG("** BACKSIDE PWM: %d\n", (int)state->pwm);
 	set_pwm_fan(BACKSIDE_FAN_PWM_INDEX, state->pwm);
@@ -1114,17 +1292,33 @@
 		of_node_put(u3);
 	}
 
-	backside_params.G_p = BACKSIDE_PID_G_p;
-	backside_params.G_r = BACKSIDE_PID_G_r;
-	backside_params.output_max = BACKSIDE_PID_OUTPUT_MAX;
-	if (u3h) {
+	if (rackmac) {
+		backside_params.G_d = BACKSIDE_PID_RACK_G_d;
+		backside_params.input_target = BACKSIDE_PID_RACK_INPUT_TARGET;
+		backside_params.output_min = BACKSIDE_PID_U3H_OUTPUT_MIN;
+		backside_params.interval = BACKSIDE_PID_RACK_INTERVAL;
+		backside_params.G_p = BACKSIDE_PID_RACK_G_p;
+		backside_params.G_r = BACKSIDE_PID_G_r;
+		backside_params.output_max = BACKSIDE_PID_OUTPUT_MAX;
+		backside_params.additive = 0;
+	} else if (u3h) {
 		backside_params.G_d = BACKSIDE_PID_U3H_G_d;
 		backside_params.input_target = BACKSIDE_PID_U3H_INPUT_TARGET;
 		backside_params.output_min = BACKSIDE_PID_U3H_OUTPUT_MIN;
+		backside_params.interval = BACKSIDE_PID_INTERVAL;
+		backside_params.G_p = BACKSIDE_PID_G_p;
+		backside_params.G_r = BACKSIDE_PID_G_r;
+		backside_params.output_max = BACKSIDE_PID_OUTPUT_MAX;
+		backside_params.additive = 1;
 	} else {
 		backside_params.G_d = BACKSIDE_PID_U3_G_d;
 		backside_params.input_target = BACKSIDE_PID_U3_INPUT_TARGET;
 		backside_params.output_min = BACKSIDE_PID_U3_OUTPUT_MIN;
+		backside_params.interval = BACKSIDE_PID_INTERVAL;
+		backside_params.G_p = BACKSIDE_PID_G_p;
+		backside_params.G_r = BACKSIDE_PID_G_r;
+		backside_params.output_max = BACKSIDE_PID_OUTPUT_MAX;
+		backside_params.additive = 1;
 	}
 
 	state->ticks = 1;
@@ -1233,10 +1427,9 @@
 
 	DBG("   sum: %d\n", (int)sum);
 	state->rpm += (s32)sum;
-	if (state->rpm < DRIVES_PID_OUTPUT_MIN)
-		state->rpm = DRIVES_PID_OUTPUT_MIN;
-	if (state->rpm > DRIVES_PID_OUTPUT_MAX)
-		state->rpm = DRIVES_PID_OUTPUT_MAX;
+
+	state->rpm = max(state->rpm, DRIVES_PID_OUTPUT_MIN);
+	state->rpm = min(state->rpm, DRIVES_PID_OUTPUT_MAX);
 
 	DBG("** DRIVES RPM: %d\n", (int)state->rpm);
 	set_rpm_fan(DRIVES_FAN_RPM_INDEX, state->rpm);
@@ -1276,6 +1469,126 @@
 	state->monitor = NULL;
 }
 
+/*
+ * DIMMs temp control loop
+ */
+static void do_monitor_dimms(struct dimm_pid_state *state)
+{
+	s32 temp, integral, derivative, fan_min;
+	s64 integ_p, deriv_p, prop_p, sum; 
+	int i;
+
+	if (--state->ticks != 0)
+		return;
+	state->ticks = DIMM_PID_INTERVAL;
+
+	DBG("DIMM:\n");
+
+	DBG("  current value: %d\n", state->output);
+
+	temp = read_lm87_reg(state->monitor, LM87_INT_TEMP);
+	if (temp < 0)
+		return;
+	temp <<= 16;
+	state->last_temp = temp;
+	DBG("  temp: %d.%03d, target: %d.%03d\n", FIX32TOPRINT(temp),
+	    FIX32TOPRINT(DIMM_PID_INPUT_TARGET));
+
+	/* Store temperature and error in history array */
+	state->cur_sample = (state->cur_sample + 1) % DIMM_PID_HISTORY_SIZE;
+	state->sample_history[state->cur_sample] = temp;
+	state->error_history[state->cur_sample] = temp - DIMM_PID_INPUT_TARGET;
+	
+	/* If first loop, fill the history table */
+	if (state->first) {
+		for (i = 0; i < (DIMM_PID_HISTORY_SIZE - 1); i++) {
+			state->cur_sample = (state->cur_sample + 1) %
+				DIMM_PID_HISTORY_SIZE;
+			state->sample_history[state->cur_sample] = temp;
+			state->error_history[state->cur_sample] =
+				temp - DIMM_PID_INPUT_TARGET;
+		}
+		state->first = 0;
+	}
+
+	/* Calculate the integral term */
+	sum = 0;
+	integral = 0;
+	for (i = 0; i < DIMM_PID_HISTORY_SIZE; i++)
+		integral += state->error_history[i];
+	integral *= DIMM_PID_INTERVAL;
+	DBG("  integral: %08x\n", integral);
+	integ_p = ((s64)DIMM_PID_G_r) * (s64)integral;
+	DBG("   integ_p: %d\n", (int)(integ_p >> 36));
+	sum += integ_p;
+
+	/* Calculate the derivative term */
+	derivative = state->error_history[state->cur_sample] -
+		state->error_history[(state->cur_sample + DIMM_PID_HISTORY_SIZE - 1)
+				    % DIMM_PID_HISTORY_SIZE];
+	derivative /= DIMM_PID_INTERVAL;
+	deriv_p = ((s64)DIMM_PID_G_d) * (s64)derivative;
+	DBG("   deriv_p: %d\n", (int)(deriv_p >> 36));
+	sum += deriv_p;
+
+	/* Calculate the proportional term */
+	prop_p = ((s64)DIMM_PID_G_p) * (s64)(state->error_history[state->cur_sample]);
+	DBG("   prop_p: %d\n", (int)(prop_p >> 36));
+	sum += prop_p;
+
+	/* Scale sum */
+	sum >>= 36;
+
+	DBG("   sum: %d\n", (int)sum);
+	state->output = (s32)sum;
+	state->output = max(state->output, DIMM_PID_OUTPUT_MIN);
+	state->output = min(state->output, DIMM_PID_OUTPUT_MAX);
+	dimm_output_clamp = state->output;
+
+	DBG("** DIMM clamp value: %d\n", (int)state->output);
+
+	/* Backside PID is only every 5 seconds, force backside fan clamping now */
+	fan_min = (dimm_output_clamp * 100) / 14000;
+	fan_min = max(fan_min, backside_params.output_min);
+	if (backside_state.pwm < fan_min) {
+		backside_state.pwm = fan_min;
+		DBG(" -> applying clamp to backside fan now: %d  !\n", fan_min);
+		set_pwm_fan(BACKSIDE_FAN_PWM_INDEX, fan_min);
+	}
+}
+
+/*
+ * Initialize the state structure for the DIMM temp control loop
+ */
+static int init_dimms_state(struct dimm_pid_state *state)
+{
+	state->ticks = 1;
+	state->first = 1;
+	state->output = 4000;
+
+	state->monitor = attach_i2c_chip(XSERVE_DIMMS_LM87, "dimms_temp");
+	if (state->monitor == NULL)
+		return -ENODEV;
+
+       	device_create_file(&of_dev->dev, &dev_attr_dimms_temperature);
+
+	return 0;
+}
+
+/*
+ * Dispose of the state data for the drives control loop
+ */
+static void dispose_dimms_state(struct dimm_pid_state *state)
+{
+	if (state->monitor == NULL)
+		return;
+
+	device_remove_file(&of_dev->dev, &dev_attr_dimms_temperature);
+
+	detach_i2c_chip(state->monitor);
+	state->monitor = NULL;
+}
+
 static int call_critical_overtemp(void)
 {
 	char *argv[] = { critical_overtemp_path, NULL };
@@ -1321,15 +1634,29 @@
 		start = jiffies;
 
 		down(&driver_lock);
+
+		/* First, we always calculate the new DIMMs state on an Xserve */
+		if (rackmac)
+			do_monitor_dimms(&dimms_state);
+
+		/* Then, the CPUs */
 		if (cpu_pid_type == CPU_PID_TYPE_COMBINED)
 			do_monitor_cpu_combined();
-		else {
+		else if (cpu_pid_type == CPU_PID_TYPE_RACKMAC) {
+			do_monitor_cpu_rack(&cpu_state[0]);
+			if (cpu_state[1].monitor != NULL)
+				do_monitor_cpu_rack(&cpu_state[1]);
+			// better deal with UP
+		} else {
 			do_monitor_cpu_split(&cpu_state[0]);
 			if (cpu_state[1].monitor != NULL)
 				do_monitor_cpu_split(&cpu_state[1]);
+			// better deal with UP
 		}
+		/* Then, the rest */
 		do_monitor_backside(&backside_state);
-		do_monitor_drives(&drives_state);
+		if (!rackmac)
+			do_monitor_drives(&drives_state);
 		up(&driver_lock);
 
 		if (critical_state == 1) {
@@ -1369,9 +1696,9 @@
 {
 	dispose_cpu_state(&cpu_state[0]);
 	dispose_cpu_state(&cpu_state[1]);
-
 	dispose_backside_state(&backside_state);
 	dispose_drives_state(&drives_state);
+	dispose_dimms_state(&dimms_state);
 }
 
 /*
@@ -1395,7 +1722,9 @@
 	 * the pumps, though that may not be the best way, that is good enough
 	 * for now
 	 */
-	if (machine_is_compatible("PowerMac7,3")
+	if (rackmac)
+		cpu_pid_type = CPU_PID_TYPE_RACKMAC;
+	else if (machine_is_compatible("PowerMac7,3")
 	    && (cpu_count > 1)
 	    && fcu_fans[CPUA_PUMP_RPM_INDEX].id != FCU_FAN_ABSENT_ID
 	    && fcu_fans[CPUB_PUMP_RPM_INDEX].id != FCU_FAN_ABSENT_ID) {
@@ -1409,11 +1738,16 @@
 	 */
 	if (init_cpu_state(&cpu_state[0], 0))
 		goto fail;
+	if (cpu_pid_type == CPU_PID_TYPE_COMBINED)
+		fetch_cpu_pumps_minmax();
+
 	if (cpu_count > 1 && init_cpu_state(&cpu_state[1], 1))
 		goto fail;
 	if (init_backside_state(&backside_state))
 		goto fail;
-	if (init_drives_state(&drives_state))
+	if (rackmac && init_dimms_state(&dimms_state))
+		goto fail;
+	if (!rackmac && init_drives_state(&drives_state))
 		goto fail;
 
 	DBG("all control loops up !\n");
@@ -1492,17 +1826,24 @@
 	/* Check if we are looking for one of these */
 	if (u3_0 == NULL && !strcmp(adapter->name, "u3 0")) {
 		u3_0 = adapter;
-		DBG("found U3-0, creating control loops\n");
-		if (create_control_loops())
-			u3_0 = NULL;
+		DBG("found U3-0\n");
+		if (k2 || !rackmac)
+			if (create_control_loops())
+				u3_0 = NULL;
 	} else if (u3_1 == NULL && !strcmp(adapter->name, "u3 1")) {
 		u3_1 = adapter;
 		DBG("found U3-1, attaching FCU\n");
 		if (attach_fcu())
 			u3_1 = NULL;
+	} else if (k2 == NULL && !strcmp(adapter->name, "mac-io 0")) {
+		k2 = adapter;
+		DBG("Found K2\n");
+		if (u3_0 && rackmac)
+			if (create_control_loops())
+				k2 = NULL;
 	}
 	/* We got all we need, start control loops */
-	if (u3_0 != NULL && u3_1 != NULL) {
+	if (u3_0 != NULL && u3_1 != NULL && (k2 || !rackmac)) {
 		DBG("everything up, starting control loops\n");
 		state = state_attached;
 		start_control_loops();
@@ -1548,6 +1889,27 @@
 	return 0;
 }
 
+static int fan_check_loc_match(const char *loc, int fan)
+{
+	char	tmp[64];
+	char	*c, *e;
+	
+	strlcpy(tmp, fcu_fans[fan].loc, 64);
+	
+	c = tmp;
+	for (;;) {
+		e = strchr(c, ',');
+		if (e)
+			*e = 0;
+		if (strcmp(loc, c) == 0)
+			return 1;
+		if (e == NULL)
+			break;
+		c = e + 1;
+	}
+	return 0;
+}
+
 static void fcu_lookup_fans(struct device_node *fcu_node)
 {
 	struct device_node *np = NULL;
@@ -1589,7 +1951,7 @@
 		for (i = 0; i < FCU_FAN_COUNT; i++) {
 			int fan_id;
 
-			if (strcmp(loc, fcu_fans[i].loc))
+			if (!fan_check_loc_match(loc, i))
 				continue;
 			DBG(" location match, index: %d\n", i);
 			fcu_fans[i].id = FCU_FAN_ABSENT_ID;
@@ -1671,8 +2033,11 @@
 {
 	struct device_node *np;
 
+	rackmac = machine_is_compatible("RackMac3,1");
+
 	if (!machine_is_compatible("PowerMac7,2") &&
-	    !machine_is_compatible("PowerMac7,3"))
+	    !machine_is_compatible("PowerMac7,3") &&
+	    !rackmac)
 	    	return -ENODEV;
 
 	printk(KERN_INFO "PowerMac G5 Thermal control driver %s\n", VERSION);
@@ -1709,6 +2074,6 @@
 module_exit(therm_pm72_exit);
 
 MODULE_AUTHOR("Benjamin Herrenschmidt <benh@kernel.crashing.org>");
-MODULE_DESCRIPTION("Driver for Apple's PowerMac7,2 G5 thermal control");
+MODULE_DESCRIPTION("Driver for Apple's PowerMac G5 thermal control");
 MODULE_LICENSE("GPL");
 
Index: linux-work/drivers/macintosh/therm_pm72.h
===================================================================
--- linux-work.orig/drivers/macintosh/therm_pm72.h	2005-01-18 18:15:25.000000000 +1100
+++ linux-work/drivers/macintosh/therm_pm72.h	2005-01-18 18:15:33.000000000 +1100
@@ -52,7 +52,7 @@
 	u16	rmaxn_intake_fan;	/* 0x4e - Intake fan max RPM */
 	u16	rminn_exhaust_fan;	/* 0x50 - Exhaust fan min RPM */
 	u16	rmaxn_exhaust_fan;	/* 0x52 - Exhaust fan max RPM */
-	u8	processor_part_num[8];	/* 0x54 - Processor part number */
+	u8	processor_part_num[8];	/* 0x54 - Processor part number XX pumps min/max */
 	u32	processor_lot_num;	/* 0x5c - Processor lot number */
 	u8	orig_card_sernum[0x10];	/* 0x60 - Card original serial number */
 	u8	curr_card_sernum[0x10];	/* 0x70 - Card current serial number */
@@ -94,19 +94,25 @@
  * of the driver, though I would accept any clean patch
  * doing a better use of the device-tree without turning the
  * while i2c registration mecanism into a racy mess
+ *
+ * Note: Xserve changed this. We have some bits on the K2 bus,
+ * which I arbitrarily set to 0x200. Ultimately, we really want
+ * too lookup these in the device-tree though
  */
 #define FAN_CTRLER_ID		0x15e
 #define SUPPLY_MONITOR_ID      	0x58
 #define SUPPLY_MONITORB_ID     	0x5a
 #define DRIVES_DALLAS_ID	0x94
 #define BACKSIDE_MAX_ID		0x98
+#define XSERVE_DIMMS_LM87	0x25a
 
 /*
- * Some MAX6690 & DS1775 register definitions
+ * Some MAX6690, DS1775, LM87 register definitions
  */
 #define MAX6690_INT_TEMP	0
 #define MAX6690_EXT_TEMP	1
 #define DS1775_TEMP		0
+#define LM87_INT_TEMP		0x27
 
 /*
  * Scaling factors for the AD7417 ADC converters (except
@@ -126,14 +132,18 @@
 #define BACKSIDE_FAN_PWM_INDEX		0
 #define BACKSIDE_PID_U3_G_d		0x02800000
 #define BACKSIDE_PID_U3H_G_d		0x01400000
+#define BACKSIDE_PID_RACK_G_d		0x00500000
 #define BACKSIDE_PID_G_p		0x00500000
+#define BACKSIDE_PID_RACK_G_p		0x0004cccc
 #define BACKSIDE_PID_G_r		0x00000000
 #define BACKSIDE_PID_U3_INPUT_TARGET	0x00410000
 #define BACKSIDE_PID_U3H_INPUT_TARGET	0x004b0000
+#define BACKSIDE_PID_RACK_INPUT_TARGET	0x00460000
 #define BACKSIDE_PID_INTERVAL		5
+#define BACKSIDE_PID_RACK_INTERVAL	1
 #define BACKSIDE_PID_OUTPUT_MAX		100
 #define BACKSIDE_PID_U3_OUTPUT_MIN	20
-#define BACKSIDE_PID_U3H_OUTPUT_MIN	30
+#define BACKSIDE_PID_U3H_OUTPUT_MIN	20
 #define BACKSIDE_PID_HISTORY_SIZE	2
 
 struct basckside_pid_params
@@ -144,6 +154,8 @@
 	s32			input_target;
 	s32			output_min;
 	s32			output_max;
+	s32			interval;
+	int			additive;
 };
 
 struct backside_pid_state
@@ -188,25 +200,34 @@
 #define SLOTS_FAN_PWM_INDEX		2
 #define	SLOTS_FAN_DEFAULT_PWM		50 /* Do better here ! */
 
+
 /*
- * IDs in Darwin for the sensors & fans
- *
- * CPU A AD7417_TEMP	10	(CPU A ambient temperature)
- * CPU A AD7417_AD1	11	(CPU A diode temperature)
- * CPU A AD7417_AD2	12	(CPU A 12V current)
- * CPU A AD7417_AD3	13	(CPU A voltage)
- * CPU A AD7417_AD4	14	(CPU A current)
- *
- * CPU A FAKE POWER	48	(I_V_inputs: 13, 14)
- *
- * CPU B AD7417_TEMP	15	(CPU B ambient temperature)
- * CPU B AD7417_AD1	16	(CPU B diode temperature)
- * CPU B AD7417_AD2	17	(CPU B 12V current)
- * CPU B AD7417_AD3	18	(CPU B voltage)
- * CPU B AD7417_AD4	19	(CPU B current)
- *
- * CPU B FAKE POWER	49	(I_V_inputs: 18, 19)
+ * PID factors for the Xserve DIMM control loop
  */
+#define DIMM_PID_G_d			0
+#define DIMM_PID_G_p			0
+#define DIMM_PID_G_r			0x6553600
+#define DIMM_PID_INPUT_TARGET		3276800
+#define DIMM_PID_INTERVAL    		1
+#define DIMM_PID_OUTPUT_MAX		14000
+#define DIMM_PID_OUTPUT_MIN		4000
+#define DIMM_PID_HISTORY_SIZE		20
+
+struct dimm_pid_state
+{
+	int			ticks;
+	struct i2c_client *	monitor;
+	s32	       		sample_history[DIMM_PID_HISTORY_SIZE];
+	s32			error_history[DIMM_PID_HISTORY_SIZE];
+	int			cur_sample;
+	s32			last_temp;
+	int			first;
+	int			output;
+};
+
+
+
+/* Desktops */
 
 #define CPUA_INTAKE_FAN_RPM_DEFAULT_ID	3
 #define CPUA_EXHAUST_FAN_RPM_DEFAULT_ID	4
@@ -226,8 +247,17 @@
 
 #define CPUA_PUMP_RPM_INDEX		7
 #define CPUB_PUMP_RPM_INDEX		8
-#define CPU_PUMP_OUTPUT_MAX		3700
-#define CPU_PUMP_OUTPUT_MIN		1000
+#define CPU_PUMP_OUTPUT_MAX		3200
+#define CPU_PUMP_OUTPUT_MIN		1250
+
+/* Xserve */
+#define CPU_A1_FAN_RPM_INDEX		9
+#define CPU_A2_FAN_RPM_INDEX		10
+#define CPU_A3_FAN_RPM_INDEX		11
+#define CPU_B1_FAN_RPM_INDEX		12
+#define CPU_B2_FAN_RPM_INDEX		13
+#define CPU_B3_FAN_RPM_INDEX		14
+
 
 struct cpu_pid_state
 {
@@ -249,6 +279,8 @@
 	s32			last_power;
 	int			first;
 	u8			adc_config;
+	s32			pump_min;
+	s32			pump_max;
 };
 
 /*

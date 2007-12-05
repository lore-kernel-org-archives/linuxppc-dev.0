Return-Path: <bersace@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id C18B3DDE19
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2007 10:37:48 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so646192uge
	for <linuxppc-dev@ozlabs.org>; Wed, 05 Dec 2007 15:37:46 -0800 (PST)
Subject: [patch] Windfarm plateform module for PowerMac12,1
From: =?ISO-8859-1?Q?=C9tienne?= Bersac <bersace@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-/odplyClfo3Wpr0jYGxC"
Date: Thu, 06 Dec 2007 00:37:42 +0100
Message-Id: <1196897863.7132.5.camel@thilivren>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-/odplyClfo3Wpr0jYGxC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi everyone,

Finally, i had time, skills and help from Benjamin Herrenschmidt to
implement the Windfarm plateform module for PowerMac12,1 named
windfarm-pm121. This plateform is used in iMac G5 iSight models (17" and
20").

I review the patch a couple of time, especially the hex values which are
copied from Darwin code. The patch passes thru checkpatch.pl with one
error :) :

Missing Signed-off-by: line(s)


Here is the patch :



diff --git a/arch/powerpc/configs/g5_defconfig b/arch/powerpc/configs/g5_de=
fconfig
index 0a6fa1f..7125837 100644
--- a/arch/powerpc/configs/g5_defconfig
+++ b/arch/powerpc/configs/g5_defconfig
@@ -656,6 +656,7 @@ CONFIG_WINDFARM=3Dy
 CONFIG_WINDFARM_PM81=3Dy
 CONFIG_WINDFARM_PM91=3Dy
 CONFIG_WINDFARM_PM112=3Dy
+CONFIG_WINDFARM_PM121=3Dy
 # CONFIG_PMAC_RACKMETER is not set
 CONFIG_NETDEVICES=3Dy
 # CONFIG_NETDEVICES_MULTIQUEUE is not set
diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
index 77f50b6..2d028e6 100644
--- a/drivers/macintosh/Kconfig
+++ b/drivers/macintosh/Kconfig
@@ -234,6 +234,14 @@ config WINDFARM_PM112
 	  which are the recent dual and quad G5 machines using the
 	  970MP dual-core processor.
=20
+config WINDFARM_PM121
+	tristate "Support for thermal management on PowerMac12,1"
+	depends on WINDFARM && I2C && PMAC_SMU
+	select I2C_POWERMAC
+	help
+	  This driver provides thermal control for the PowerMac12,1
+	  which is the iMac G5 (iSight) 970MP
+
 config ANSLCD
 	tristate "Support for ANS LCD display"
 	depends on ADB_CUDA && PPC_PMAC
diff --git a/drivers/macintosh/Makefile b/drivers/macintosh/Makefile
index 2dfc3f4..e3132ef 100644
--- a/drivers/macintosh/Makefile
+++ b/drivers/macintosh/Makefile
@@ -42,4 +42,9 @@ obj-$(CONFIG_WINDFARM_PM112)	+=3D windfarm_pm112.o windfa=
rm_smu_sat.o \
 				   windfarm_smu_sensors.o \
 				   windfarm_max6690_sensor.o \
 				   windfarm_lm75_sensor.o windfarm_pid.o
+obj-$(CONFIG_WINDFARM_PM121)	+=3D windfarm_pm121.o windfarm_smu_sat.o \
+				   windfarm_smu_controls.o \
+				   windfarm_smu_sensors.o \
+				   windfarm_max6690_sensor.o \
+				   windfarm_lm75_sensor.o windfarm_pid.o
 obj-$(CONFIG_PMAC_RACKMETER)	+=3D rack-meter.o
diff --git a/drivers/macintosh/windfarm_lm75_sensor.c b/drivers/macintosh/w=
indfarm_lm75_sensor.c
index 7e10c3a..b92b959 100644
--- a/drivers/macintosh/windfarm_lm75_sensor.c
+++ b/drivers/macintosh/windfarm_lm75_sensor.c
@@ -127,6 +127,12 @@ static struct wf_lm75_sensor *wf_lm75_create(struct i2=
c_adapter *adapter,
 	 */
 	if (!strcmp(loc, "Hard drive") || !strcmp(loc, "DRIVE BAY"))
 		lm->sens.name =3D "hd-temp";
+	else if (!strcmp(loc, "Incoming Air Temp"))
+		lm->sens.name =3D "incoming-air-temp";
+	else if (!strcmp(loc, "ODD Temp"))
+		lm->sens.name =3D "optical-drive-temp";
+	else if (!strcmp(loc, "HD Temp"))
+		lm->sens.name =3D "hard-drive-temp";
 	else
 		goto fail;
=20
diff --git a/drivers/macintosh/windfarm_max6690_sensor.c b/drivers/macintos=
h/windfarm_max6690_sensor.c
index 5f03aab..c2b6d1c 100644
--- a/drivers/macintosh/windfarm_max6690_sensor.c
+++ b/drivers/macintosh/windfarm_max6690_sensor.c
@@ -77,10 +77,11 @@ static struct wf_sensor_ops wf_max6690_ops =3D {
 	.owner		=3D THIS_MODULE,
 };
=20
-static void wf_max6690_create(struct i2c_adapter *adapter, u8 addr)
+static void wf_max6690_create(struct i2c_adapter *adapter, u8 addr,
+			      const char *loc)
 {
 	struct wf_6690_sensor *max;
-	char *name =3D "backside-temp";
+	char *name =3D NULL;
=20
 	max =3D kzalloc(sizeof(struct wf_6690_sensor), GFP_KERNEL);
 	if (max =3D=3D NULL) {
@@ -89,6 +90,15 @@ static void wf_max6690_create(struct i2c_adapter *adapte=
r, u8 addr)
 		return;
 	}
=20
+	if (!strcmp(loc, "BACKSIDE"))
+		name =3D "backside-temp";
+	else if (!strcmp(loc, "NB Ambient"))
+		name =3D "north-bridge-temp";
+	else if (!strcmp(loc, "GPU Ambient"))
+		name =3D "gpu-temp";
+	else
+		goto fail;
+
 	max->sens.ops =3D &wf_max6690_ops;
 	max->sens.name =3D name;
 	max->i2c.addr =3D addr >> 1;
@@ -138,9 +148,7 @@ static int wf_max6690_attach(struct i2c_adapter *adapte=
r)
 		if (loc =3D=3D NULL || addr =3D=3D 0)
 			continue;
 		printk("found max6690, loc=3D%s addr=3D0x%02x\n", loc, addr);
-		if (strcmp(loc, "BACKSIDE"))
-			continue;
-		wf_max6690_create(adapter, addr);
+		wf_max6690_create(adapter, addr, loc);
 	}
=20
 	return 0;
diff --git a/drivers/macintosh/windfarm_pm121.c b/drivers/macintosh/windfar=
m_pm121.c
new file mode 100644
index 0000000..0cb4b3e
--- /dev/null
+++ b/drivers/macintosh/windfarm_pm121.c
@@ -0,0 +1,1052 @@
+/*
+ * Windfarm PowerMac thermal control. iMac G5 iSight
+ *
+ * (c) Copyright 2007 =C3=89tienne Bersac <bersace@gmail.com>
+ *
+ * Bits & pieces from windfarm_pm81.c by (c) Copyright 2005 Benjamin
+ * Herrenschmidt, IBM Corp. <benh@kernel.crashing.org>
+ *
+ * Released under the term of the GNU GPL v2.
+ *
+ *
+ *
+ * PowerMac12,1
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ *
+ *
+ * The algorithm used is the PID control algorithm, used the same way
+ * the published Darwin code does, using the same values that are
+ * present in the Darwin 8.10 snapshot property lists (note however
+ * that none of the code has been re-used, it's a complete
+ * re-implementation
+ *
+ * There is two models using PowerMac12,1. Model 2 is iMac G5 iSight
+ * 17" while Model 3 is iMac G5 20". They do have both the same
+ * controls with a tiny difference. The control-ids of hard-drive-fan
+ * and cpu-fan is swapped.
+ *
+ *
+ * Target Correction :
+ *
+ * controls have a target correction calculated as :
+ *
+ * new_min =3D ((((average_power * slope) >> 16) + offset) >> 16) + min_va=
lue
+ * new_value =3D max(new_value, max(new_min, 0))
+ *
+ * OD Fan control correction.
+ *
+ * # model_id: 2
+ *   offset		: -19563152
+ *   slope		:  1956315
+ *
+ * # model_id: 3
+ *   offset		: -15650652
+ *   slope		:  1565065
+ *
+ * HD Fan control correction.
+ *
+ * # model_id: 2
+ *   offset		: -15650652
+ *   slope		:  1565065
+ *
+ * # model_id: 3
+ *   offset		: -19563152
+ *   slope		:  1956315
+ *
+ * CPU Fan control correction.
+ *
+ * # model_id: 2
+ *   offset		: -25431900
+ *   slope		:  2543190
+ *
+ * # model_id: 3
+ *   offset		: -15650652
+ *   slope		:  1565065
+ *
+ *
+ * Target rubber-banding :
+ *
+ * Some controls have a target correction which depends on another
+ * control value. The correction is computed in the following way :
+ *
+ * new_min =3D ref_value * slope + offset
+ *
+ * ref_value is the value of the reference control. If new_min is
+ * greater than 0, then we correct the target value using :
+ *
+ * new_target =3D max (new_target, new_min >> 16)
+ *
+ *
+ * # model_id : 2
+ *   control	: cpu-fan
+ *   ref	: optical-drive-fan
+ *   offset	: -15650652
+ *   slope	: 1565065
+ *
+ * # model_id : 3
+ *   control	: optical-drive-fan
+ *   ref	: hard-drive-fan
+ *   offset	: -32768000
+ *   slope	: 65536
+ *
+ *
+ * In order to have the moste efficient correction with those
+ * dependencies, we must trigger HD loop before OD loop before CPU
+ * loop.
+ *
+ *
+ * The various control loops found in Darwin config file are:
+ *
+ * HD Fan control loop.
+ *
+ * # model_id: 2
+ *   control        : hard-drive-fan
+ *   sensor         : hard-drive-temp
+ *   PID params     : G_d =3D 0x00000000
+ *                    G_p =3D 0x002D70A3
+ *                    G_r =3D 0x00019999
+ *                    History =3D 2 entries
+ *                    Input target =3D 0x370000
+ *                    Interval =3D 5s
+ *
+ * # model_id: 3
+ *   control        : hard-drive-fan
+ *   sensor         : hard-drive-temp
+ *   PID params     : G_d =3D 0x00000000
+ *                    G_p =3D 0x002170A3
+ *                    G_r =3D 0x00019999
+ *                    History =3D 2 entries
+ *                    Input target =3D 0x370000
+ *                    Interval =3D 5s
+ *
+ * OD Fan control loop.
+ *
+ * # model_id: 2
+ *   control        : optical-drive-fan
+ *   sensor         : optical-drive-temp
+ *   PID params     : G_d =3D 0x00000000
+ *                    G_p =3D 0x001FAE14
+ *                    G_r =3D 0x00019999
+ *                    History =3D 2 entries
+ *                    Input target =3D 0x320000
+ *                    Interval =3D 5s
+ *
+ * # model_id: 3
+ *   control        : optical-drive-fan
+ *   sensor         : optical-drive-temp
+ *   PID params     : G_d =3D 0x00000000
+ *                    G_p =3D 0x001FAE14
+ *                    G_r =3D 0x00019999
+ *                    History =3D 2 entries
+ *                    Input target =3D 0x320000
+ *                    Interval =3D 5s
+ *
+ * GPU Fan control loop.
+ *
+ * # model_id: 2
+ *   control        : hard-drive-fan
+ *   sensor         : gpu-temp
+ *   PID params     : G_d =3D 0x00000000
+ *                    G_p =3D 0x002A6666
+ *                    G_r =3D 0x00019999
+ *                    History =3D 2 entries
+ *                    Input target =3D 0x5A0000
+ *                    Interval =3D 5s
+ *
+ * # model_id: 3
+ *   control        : cpu-fan
+ *   sensor         : gpu-temp
+ *   PID params     : G_d =3D 0x00000000
+ *                    G_p =3D 0x0010CCCC
+ *                    G_r =3D 0x00019999
+ *                    History =3D 2 entries
+ *                    Input target =3D 0x500000
+ *                    Interval =3D 5s
+ *
+ * KODIAK (aka northbridge) Fan control loop.
+ *
+ * # model_id: 2
+ *   control        : optical-drive-fan
+ *   sensor         : north-bridge-temp
+ *   PID params     : G_d =3D 0x00000000
+ *                    G_p =3D 0x003BD70A
+ *                    G_r =3D 0x00019999
+ *                    History =3D 2 entries
+ *                    Input target =3D 0x550000
+ *                    Interval =3D 5s
+ *
+ * # model_id: 3
+ *   control        : hard-drive-fan
+ *   sensor         : north-bridge-temp
+ *   PID params     : G_d =3D 0x00000000
+ *                    G_p =3D 0x0030F5C2
+ *                    G_r =3D 0x00019999
+ *                    History =3D 2 entries
+ *                    Input target =3D 0x550000
+ *                    Interval =3D 5s
+ *
+ * CPU Fan control loop.
+ *
+ *   control        : cpu-fan
+ *   sensors        : cpu-temp, cpu-power
+ *   PID params     : from SDB partition
+ *
+ *
+ * CPU Slew control loop.
+ *
+ *   control        : cpufreq-clamp
+ *   sensor         : cpu-temp
+ *
+ */
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
+#include <linux/kmod.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <asm/prom.h>
+#include <asm/machdep.h>
+#include <asm/io.h>
+#include <asm/system.h>
+#include <asm/sections.h>
+#include <asm/smu.h>
+
+#include "windfarm.h"
+#include "windfarm_pid.h"
+
+#define VERSION "0.4"
+
+#undef	DEBUG
+
+#ifdef DEBUG
+#define DBG(args...)	printk(args)
+#else
+#define DBG(args...)	do { } while (0)
+#endif
+
+static int pm121_mach_model;	/* machine model id */
+
+/* Controls & sensors */
+static struct wf_sensor	*sensor_cpu_power;
+static struct wf_sensor	*sensor_cpu_temp;
+static struct wf_sensor	*sensor_cpu_voltage;
+static struct wf_sensor	*sensor_cpu_current;
+static struct wf_sensor	*sensor_gpu_temp;
+static struct wf_sensor	*sensor_north_bridge_temp;
+static struct wf_sensor	*sensor_hard_drive_temp;
+static struct wf_sensor	*sensor_optical_drive_temp;
+static struct wf_sensor	*sensor_incoming_air_temp; /* unused ! */
+
+enum {
+	FAN_CPU,
+	FAN_HD,
+	FAN_OD,
+	CPUFREQ,
+	N_CONTROLS
+};
+static struct wf_control *controls[N_CONTROLS] =3D {};
+
+/* Set to kick the control loop into life */
+static int pm121_all_controls_ok, pm121_all_sensors_ok, pm121_started;
+
+enum {
+	FAILURE_FAN		=3D 1 << 0,
+	FAILURE_SENSOR		=3D 1 << 1,
+	FAILURE_OVERTEMP	=3D 1 << 2
+};
+
+/* All sys loops. Note the HD before the OD loop in order to have it
+   run before. */
+enum {
+	LOOP_GPU,		/* control =3D hd or cpu, but luckily,
+				   it doesn't matter */
+	LOOP_HD,		/* control =3D hd */
+	LOOP_KODIAK,		/* control =3D hd or od */
+	LOOP_OD,		/* control =3D od */
+	N_LOOPS
+};
+
+static const char *loop_names[N_LOOPS] =3D {
+	"GPU",
+	"HD",
+	"KODIAK",
+	"OD",
+};
+
+#define	PM121_NUM_CONFIGS	2
+
+static unsigned int pm121_failure_state;
+static int pm121_readjust, pm121_skipping;
+static s32 average_power;
+
+struct pm121_correction {
+	int	offset;
+	int	slope;
+};
+
+struct pm121_correction corrections[N_CONTROLS][PM121_NUM_CONFIGS] =3D {
+	/* FAN_OD */
+	{
+		/* MODEL 2 */
+		{ .offset	=3D -19563152,
+		  .slope	=3D  1956315
+		},
+		/* MODEL 3 */
+		{ .offset	=3D -15650652,
+		  .slope	=3D  1565065
+		},
+	},
+	/* FAN_HD */
+	{
+		/* MODEL 2 */
+		{ .offset	=3D -15650652,
+		  .slope	=3D  1565065
+		},
+		/* MODEL 3 */
+		{ .offset	=3D -19563152,
+		  .slope	=3D  1956315
+		},
+	},
+	/* FAN_CPU */
+	{
+		/* MODEL 2 */
+		{ .offset	=3D -25431900,
+		  .slope	=3D  2543190
+		},
+		/* MODEL 3 */
+		{ .offset	=3D -15650652,
+		  .slope	=3D  1565065
+		},
+	},
+	/* CPUFREQ has no correction (and is not implemented at all) */
+};
+
+struct pm121_connection {
+	unsigned int	control_id;
+	unsigned int	ref_id;
+	struct pm121_correction	correction;
+};
+
+static struct pm121_connection pm121_connections[] =3D {
+	/* MODEL 2 */
+	{ .control_id	=3D FAN_CPU,
+	  .ref_id	=3D FAN_OD,
+	  { .offset	=3D -32768000,
+	    .slope	=3D  65536
+	  }
+	},
+	/* MODEL 3 */
+	{ .control_id	=3D FAN_OD,
+	  .ref_id	=3D FAN_HD,
+	  { .offset	=3D -32768000,
+	    .slope	=3D  65536
+	  }
+	},
+};
+
+/* pointer to the current model connection */
+static struct pm121_connection *pm121_connection;
+
+/*
+ * ****** System Fans Control Loop ******
+ *
+ */
+
+/* Since each loop handles only one control and we want to avoid
+ * writing virtual control, we store the control correction with the
+ * loop params. Some data are not set, there are common to all loop
+ * and thus, hardcoded.
+ */
+struct pm121_sys_param {
+	/* purely informative since we use mach_model-2 as index */
+	int			model_id;
+	struct wf_sensor	**sensor; /* use sensor_id instead ? */
+	s32			gp, itarget;
+	unsigned int		control_id;
+};
+
+static struct pm121_sys_param
+pm121_sys_all_params[N_LOOPS][PM121_NUM_CONFIGS] =3D {
+	/* GPU Fan control loop */
+	{
+		{ .model_id	=3D 2,
+		  .sensor	=3D &sensor_gpu_temp,
+		  .gp		=3D 0x002A6666,
+		  .itarget	=3D 0x5A0000,
+		  .control_id	=3D FAN_HD,
+		},
+		{ .model_id	=3D 3,
+		  .sensor	=3D &sensor_gpu_temp,
+		  .gp		=3D 0x0010CCCC,
+		  .itarget	=3D 0x500000,
+		  .control_id	=3D FAN_CPU,
+		},
+	},
+	/* HD Fan control loop */
+	{
+		{ .model_id	=3D 2,
+		  .sensor	=3D &sensor_hard_drive_temp,
+		  .gp		=3D 0x002D70A3,
+		  .itarget	=3D 0x370000,
+		  .control_id	=3D FAN_HD,
+		},
+		{ .model_id	=3D 3,
+		  .sensor	=3D &sensor_hard_drive_temp,
+		  .gp		=3D 0x002170A3,
+		  .itarget	=3D 0x370000,
+		  .control_id	=3D FAN_HD,
+		},
+	},
+	/* KODIAK Fan control loop */
+	{
+		{ .model_id	=3D 2,
+		  .sensor	=3D &sensor_north_bridge_temp,
+		  .gp		=3D 0x003BD70A,
+		  .itarget	=3D 0x550000,
+		  .control_id	=3D FAN_OD,
+		},
+		{ .model_id	=3D 3,
+		  .sensor	=3D &sensor_north_bridge_temp,
+		  .gp		=3D 0x0030F5C2,
+		  .itarget	=3D 0x550000,
+		  .control_id	=3D FAN_HD,
+		},
+	},
+	/* OD Fan control loop */
+	{
+		{ .model_id	=3D 2,
+		  .sensor	=3D &sensor_optical_drive_temp,
+		  .gp		=3D 0x001FAE14,
+		  .itarget	=3D 0x320000,
+		  .control_id	=3D FAN_OD,
+		},
+		{ .model_id	=3D 3,
+		  .sensor	=3D &sensor_optical_drive_temp,
+		  .gp		=3D 0x001FAE14,
+		  .itarget	=3D 0x320000,
+		  .control_id	=3D FAN_OD,
+		},
+	},
+};
+
+/* the hardcoded values */
+#define	PM121_SYS_GD		0x00000000
+#define	PM121_SYS_GR		0x00019999
+#define	PM121_SYS_HISTORY_SIZE	2
+#define	PM121_SYS_INTERVAL	5
+
+/* State data used by the system fans control loop
+ */
+struct pm121_sys_state {
+	int			ticks;
+	s32			setpoint;
+	struct wf_pid_state	pid;
+};
+
+struct pm121_sys_state *pm121_sys_state[N_LOOPS] =3D {};
+
+/*
+ * ****** CPU Fans Control Loop ******
+ *
+ */
+
+#define PM121_CPU_INTERVAL	1
+
+/* State data used by the cpu fans control loop
+ */
+struct pm121_cpu_state {
+	int			ticks;
+	s32			setpoint;
+	struct wf_cpu_pid_state	pid;
+};
+
+static struct pm121_cpu_state *pm121_cpu_state;
+
+
+
+/*
+ * ***** Implementation *****
+ *
+ */
+
+/* correction the value using the output-low-bound correction algo */
+static s32 pm121_correct(s32 new_setpoint,
+			 unsigned int control_id,
+			 s32 min)
+{
+	s32 new_min;
+	struct pm121_correction *correction;
+	correction =3D &corrections[control_id][pm121_mach_model - 2];
+
+	new_min =3D (average_power * correction->slope) >> 16;
+	new_min +=3D correction->offset;
+	new_min =3D (new_min >> 16) + min;
+
+	return max(new_setpoint, max(new_min, 0));
+}
+
+static s32 pm121_connect(unsigned int control_id, s32 setpoint)
+{
+	s32 new_min, value, new_setpoint;
+
+	if (pm121_connection->control_id =3D=3D control_id) {
+		controls[control_id]->ops->get_value(controls[control_id],
+						     &value);
+		new_min =3D value * pm121_connection->correction.slope;
+		new_min +=3D pm121_connection->correction.offset;
+		if (new_min > 0) {
+			new_setpoint =3D max(setpoint, (new_min >> 16));
+			if (new_setpoint !=3D setpoint) {
+				DBG("pm121: %s depending on %s, "
+				    "corrected from %d to %d RPM\n",
+				    controls[control_id]->name,
+				    controls[pm121_connection->ref_id]->name,
+				    (int) setpoint, (int) new_setpoint);
+			}
+		} else
+			new_setpoint =3D setpoint;
+	}
+	/* no connection */
+	else
+		new_setpoint =3D setpoint;
+
+	return new_setpoint;
+}
+
+/* FAN LOOPS */
+static void pm121_create_sys_fans(int loop_id)
+{
+	struct pm121_sys_param *param =3D NULL;
+	struct wf_pid_param pid_param;
+	struct wf_control *control =3D NULL;
+	int i;
+
+	/* First, locate the params for this model */
+	for (i =3D 0; i < PM121_NUM_CONFIGS; i++) {
+		param =3D &(pm121_sys_all_params[loop_id][i]);
+		if (param->model_id =3D=3D pm121_mach_model)
+			break;
+	}
+
+	/* No params found, put fans to max */
+	if (param =3D=3D NULL) {
+		printk(KERN_WARNING "pm121: %s fan config not found "
+		       " for this machine model\n",
+		       loop_names[loop_id]);
+		goto fail;
+	}
+
+	control =3D controls[param->control_id];
+
+	/* Alloc & initialize state */
+	pm121_sys_state[loop_id] =3D kmalloc(sizeof(struct pm121_sys_state),
+					   GFP_KERNEL);
+	if (pm121_sys_state[loop_id] =3D=3D NULL) {
+		printk(KERN_WARNING "pm121: Memory allocation error\n");
+		goto fail;
+	}
+	pm121_sys_state[loop_id]->ticks =3D 1;
+
+	/* Fill PID params */
+	pid_param.gd		=3D PM121_SYS_GD;
+	pid_param.gp		=3D param->gp;
+	pid_param.gr		=3D PM121_SYS_GR;
+	pid_param.interval	=3D PM121_SYS_INTERVAL;
+	pid_param.history_len	=3D PM121_SYS_HISTORY_SIZE;
+	pid_param.itarget	=3D param->itarget;
+	pid_param.min		=3D control->ops->get_min(control);
+	pid_param.max		=3D control->ops->get_max(control);
+
+	wf_pid_init(&pm121_sys_state[loop_id]->pid, &pid_param);
+
+	DBG("pm121: %s Fan control loop initialized.\n"
+	    "       itarged=3D%d.%03d, min=3D%d RPM, max=3D%d RPM\n",
+	    loop_names[loop_id], FIX32TOPRINT(pid_param.itarget),
+	    pid_param.min, pid_param.max);
+	return;
+
+ fail:
+	/* note that this is not optimal since another loop may still
+	   control the same control */
+	printk(KERN_WARNING "pm121: failed to set up %s loop "
+	       "setting \"%s\" to max speed.\n",
+	       loop_names[loop_id], control->name);
+
+	if (control)
+		wf_control_set_max(control);
+}
+
+static void pm121_sys_fans_tick(int loop_id)
+{
+	struct pm121_sys_param *param;
+	struct pm121_sys_state *st;
+	struct wf_sensor *sensor;
+	struct wf_control *control;
+	s32 temp, new_setpoint;
+	int rc;
+
+	param =3D &(pm121_sys_all_params[loop_id][pm121_mach_model-2]);
+	st =3D pm121_sys_state[loop_id];
+	sensor =3D *(param->sensor);
+	control =3D controls[param->control_id];
+
+	if (--st->ticks !=3D 0) {
+		if (pm121_readjust)
+			goto readjust;
+		return;
+	}
+	st->ticks =3D PM121_SYS_INTERVAL;
+
+	rc =3D sensor->ops->get_value(sensor, &temp);
+	if (rc) {
+		printk(KERN_WARNING "windfarm: %s sensor error %d\n",
+		       sensor->name, rc);
+		pm121_failure_state |=3D FAILURE_SENSOR;
+		return;
+	}
+
+	DBG("pm121: %s Fan tick ! %s: %d.%03d\n",
+	    loop_names[loop_id], sensor->name,
+	    FIX32TOPRINT(temp));
+
+	new_setpoint =3D wf_pid_run(&st->pid, temp);
+
+	/* correction */
+	new_setpoint =3D pm121_correct(new_setpoint,
+				     param->control_id,
+				     st->pid.param.min);
+	/* linked corretion */
+	new_setpoint =3D pm121_connect(param->control_id, new_setpoint);
+
+	if (new_setpoint =3D=3D st->setpoint)
+		return;
+	st->setpoint =3D new_setpoint;
+	DBG("pm121: %s corrected setpoint: %d RPM\n",
+	    control->name, (int)new_setpoint);
+ readjust:
+	if (control && pm121_failure_state =3D=3D 0) {
+		rc =3D control->ops->set_value(control, st->setpoint);
+		if (rc) {
+			printk(KERN_WARNING "windfarm: %s fan error %d\n",
+			       control->name, rc);
+			pm121_failure_state |=3D FAILURE_FAN;
+		}
+	}
+}
+
+
+/* CPU LOOP */
+static void pm121_create_cpu_fans(void)
+{
+	struct wf_cpu_pid_param pid_param;
+	const struct smu_sdbp_header *hdr;
+	struct smu_sdbp_cpupiddata *piddata;
+	struct smu_sdbp_fvt *fvt;
+	struct wf_control *fan_cpu;
+	s32 tmax, tdelta, maxpow, powadj;
+
+	fan_cpu =3D controls[FAN_CPU];
+
+	/* First, locate the PID params in SMU SBD */
+	hdr =3D smu_get_sdb_partition(SMU_SDB_CPUPIDDATA_ID, NULL);
+	if (hdr =3D=3D 0) {
+		printk(KERN_WARNING "pm121: CPU PID fan config not found.\n");
+		goto fail;
+	}
+	piddata =3D (struct smu_sdbp_cpupiddata *)&hdr[1];
+
+	/* Get the FVT params for operating point 0 (the only supported one
+	 * for now) in order to get tmax
+	 */
+	hdr =3D smu_get_sdb_partition(SMU_SDB_FVT_ID, NULL);
+	if (hdr) {
+		fvt =3D (struct smu_sdbp_fvt *)&hdr[1];
+		tmax =3D ((s32)fvt->maxtemp) << 16;
+	} else
+		tmax =3D 0x5e0000; /* 94 degree default */
+
+	/* Alloc & initialize state */
+	pm121_cpu_state =3D kmalloc(sizeof(struct pm121_cpu_state),
+				  GFP_KERNEL);
+	if (pm121_cpu_state =3D=3D NULL)
+		goto fail;
+	pm121_cpu_state->ticks =3D 1;
+
+	/* Fill PID params */
+	pid_param.interval =3D PM121_CPU_INTERVAL;
+	pid_param.history_len =3D piddata->history_len;
+	if (pid_param.history_len > WF_CPU_PID_MAX_HISTORY) {
+		printk(KERN_WARNING "pm121: History size overflow on "
+		       "CPU control loop (%d)\n", piddata->history_len);
+		pid_param.history_len =3D WF_CPU_PID_MAX_HISTORY;
+	}
+	pid_param.gd =3D piddata->gd;
+	pid_param.gp =3D piddata->gp;
+	pid_param.gr =3D piddata->gr / pid_param.history_len;
+
+	tdelta =3D ((s32)piddata->target_temp_delta) << 16;
+	maxpow =3D ((s32)piddata->max_power) << 16;
+	powadj =3D ((s32)piddata->power_adj) << 16;
+
+	pid_param.tmax =3D tmax;
+	pid_param.ttarget =3D tmax - tdelta;
+	pid_param.pmaxadj =3D maxpow - powadj;
+
+	pid_param.min =3D fan_cpu->ops->get_min(fan_cpu);
+	pid_param.max =3D fan_cpu->ops->get_max(fan_cpu);
+
+	wf_cpu_pid_init(&pm121_cpu_state->pid, &pid_param);
+
+	DBG("pm121: CPU Fan control initialized.\n");
+	DBG("       ttarged=3D%d.%03d, tmax=3D%d.%03d, min=3D%d RPM, max=3D%d RPM=
,\n",
+	    FIX32TOPRINT(pid_param.ttarget), FIX32TOPRINT(pid_param.tmax),
+	    pid_param.min, pid_param.max);
+
+	return;
+
+ fail:
+	printk(KERN_WARNING "pm121: CPU fan config not found, max fan speed\n");
+
+	if (controls[CPUFREQ])
+		wf_control_set_max(controls[CPUFREQ]);
+	if (fan_cpu)
+		wf_control_set_max(fan_cpu);
+}
+
+
+static void pm121_cpu_fans_tick(struct pm121_cpu_state *st)
+{
+	s32 new_setpoint, temp, power;
+	struct wf_control *fan_cpu =3D NULL;
+	int rc;
+
+	if (--st->ticks !=3D 0) {
+		if (pm121_readjust)
+			goto readjust;
+		return;
+	}
+	st->ticks =3D PM121_CPU_INTERVAL;
+
+	fan_cpu =3D controls[FAN_CPU];
+
+	rc =3D sensor_cpu_temp->ops->get_value(sensor_cpu_temp, &temp);
+	if (rc) {
+		printk(KERN_WARNING "pm121: CPU temp sensor error %d\n",
+		       rc);
+		pm121_failure_state |=3D FAILURE_SENSOR;
+		return;
+	}
+
+	rc =3D sensor_cpu_power->ops->get_value(sensor_cpu_power, &power);
+	if (rc) {
+		printk(KERN_WARNING "pm121: CPU power sensor error %d\n",
+		       rc);
+		pm121_failure_state |=3D FAILURE_SENSOR;
+		return;
+	}
+
+	DBG("pm121: CPU Fans tick ! CPU temp: %d.%03d=C2=B0C, power: %d.%03d\n",
+	    FIX32TOPRINT(temp), FIX32TOPRINT(power));
+
+#ifdef HACKED_OVERTEMP
+#define	MAX	0x4a0000
+#else
+#define	MAX	st->pid.param.tmax
+#endif
+	if (temp > MAX)
+		pm121_failure_state |=3D FAILURE_OVERTEMP;
+
+#undef	MAX
+
+	new_setpoint =3D wf_cpu_pid_run(&st->pid, power, temp);
+
+	/* correction */
+	new_setpoint =3D pm121_correct(new_setpoint,
+				     FAN_CPU,
+				     st->pid.param.min);
+
+	/* connected correction */
+	new_setpoint =3D pm121_connect(FAN_CPU, new_setpoint);
+
+	if (st->setpoint =3D=3D new_setpoint)
+		return;
+	st->setpoint =3D new_setpoint;
+	DBG("pm121: CPU corrected setpoint: %d RPM\n", (int)new_setpoint);
+
+ readjust:
+	if (fan_cpu && pm121_failure_state =3D=3D 0) {
+		rc =3D fan_cpu->ops->set_value(fan_cpu, st->setpoint);
+		if (rc) {
+			printk(KERN_WARNING "pm121: %s fan error %d\n",
+			       fan_cpu->name, rc);
+			pm121_failure_state |=3D FAILURE_FAN;
+		}
+	}
+}
+
+/*
+ * ****** Common ******
+ *
+ */
+
+static void pm121_tick(void)
+{
+	unsigned int last_failure =3D pm121_failure_state;
+	unsigned int new_failure;
+	s32 total_power;
+	int i;
+
+	if (!pm121_started) {
+		DBG("pm121: creating control loops !\n");
+		for (i =3D 0; i < N_LOOPS; i++)
+			pm121_create_sys_fans(i);
+
+		pm121_create_cpu_fans();
+		pm121_started =3D 1;
+	}
+
+	/* skipping ticks */
+	if (pm121_skipping && --pm121_skipping)
+		return;
+
+	/* compute average power */
+	total_power =3D 0;
+	for (i =3D 0; i < pm121_cpu_state->pid.param.history_len; i++)
+		total_power +=3D pm121_cpu_state->pid.powers[i];
+
+	average_power =3D total_power / pm121_cpu_state->pid.param.history_len;
+
+
+	pm121_failure_state =3D 0;
+	for (i =3D 0 ; i < N_LOOPS; i++) {
+		if (pm121_sys_state[i])
+			pm121_sys_fans_tick(i);
+	}
+
+	if (pm121_cpu_state)
+		pm121_cpu_fans_tick(pm121_cpu_state);
+
+	pm121_readjust =3D 0;
+	new_failure =3D pm121_failure_state & ~last_failure;
+
+	/* If entering failure mode, clamp cpufreq and ramp all
+	 * fans to full speed.
+	 */
+	if (pm121_failure_state && !last_failure) {
+		for (i =3D 0; i < N_CONTROLS; i++) {
+			if (controls[i])
+				wf_control_set_max(controls[i]);
+		}
+	}
+
+	/* If leaving failure mode, unclamp cpufreq and readjust
+	 * all fans on next iteration
+	 */
+	if (!pm121_failure_state && last_failure) {
+		if (controls[CPUFREQ])
+			wf_control_set_min(controls[CPUFREQ]);
+		pm121_readjust =3D 1;
+	}
+
+	/* Overtemp condition detected, notify and start skipping a couple
+	 * ticks to let the temperature go down
+	 */
+	if (new_failure & FAILURE_OVERTEMP) {
+		wf_set_overtemp();
+		pm121_skipping =3D 2;
+	}
+
+	/* We only clear the overtemp condition if overtemp is cleared
+	 * _and_ no other failure is present. Since a sensor error will
+	 * clear the overtemp condition (can't measure temperature) at
+	 * the control loop levels, but we don't want to keep it clear
+	 * here in this case
+	 */
+	if (new_failure =3D=3D 0 && last_failure & FAILURE_OVERTEMP)
+		wf_clear_overtemp();
+}
+
+
+
+
+#define	pm121_register_control(control, match, id)			\
+	if (controls[id] =3D=3D NULL && !strcmp(control->name,match)) {	\
+		if (wf_get_control(control) =3D=3D 0)			\
+			controls[id] =3D control;				\
+	}								\
+	all =3D all && controls[id];
+
+static void pm121_new_control(struct wf_control *ct)
+{
+	int all =3D 1;
+
+	if (pm121_all_controls_ok)
+		return;
+
+	pm121_register_control(ct, "optical-drive-fan",	FAN_OD);
+	pm121_register_control(ct, "hard-drive-fan",	FAN_HD);
+	pm121_register_control(ct, "cpu-fan",		FAN_CPU);
+	pm121_register_control(ct, "cpufreq-clamp",	CPUFREQ);
+
+	if (all)
+		pm121_all_controls_ok =3D 1;
+}
+#undef pm121_register_control
+
+
+
+
+#define	pm121_register_sensor(sensor, match, var)		\
+	if (var =3D=3D NULL && !strcmp(sensor->name,match)) {	\
+		if (wf_get_sensor(sensor) =3D=3D 0)			\
+			var =3D sensor;				\
+	}							\
+	all =3D all && var;
+
+static void pm121_new_sensor(struct wf_sensor *sr)
+{
+	int all =3D 1;
+
+	if (pm121_all_sensors_ok)
+		return;
+
+	pm121_register_sensor(sr, "cpu-temp",
+			      sensor_cpu_temp);
+	pm121_register_sensor(sr, "cpu-current",
+			      sensor_cpu_current);
+	pm121_register_sensor(sr, "cpu-voltage",
+			      sensor_cpu_voltage);
+	pm121_register_sensor(sr, "cpu-power",
+			      sensor_cpu_power);
+	pm121_register_sensor(sr, "hard-drive-temp",
+			      sensor_hard_drive_temp);
+	pm121_register_sensor(sr, "optical-drive-temp",
+			      sensor_optical_drive_temp);
+	pm121_register_sensor(sr, "incoming-air-temp",
+			      sensor_incoming_air_temp);
+	pm121_register_sensor(sr, "north-bridge-temp",
+			      sensor_north_bridge_temp);
+	pm121_register_sensor(sr, "gpu-temp",
+			      sensor_gpu_temp);
+
+	if (all)
+		pm121_all_sensors_ok =3D 1;
+}
+
+#undef pm121_register_sensor
+
+
+
+static int pm121_notify(struct notifier_block *self,
+			unsigned long event, void *data)
+{
+	switch (event) {
+	case WF_EVENT_NEW_CONTROL:
+		DBG("pm121: new control %s detected\n",
+		    ((struct wf_control *)data)->name);
+		pm121_new_control(data);
+		break;
+	case WF_EVENT_NEW_SENSOR:
+		DBG("pm121: new sensor %s detected\n",
+		    ((struct wf_sensor *)data)->name);
+		pm121_new_sensor(data);
+		break;
+	case WF_EVENT_TICK:
+		if (pm121_all_controls_ok && pm121_all_sensors_ok)
+			pm121_tick();
+		break;
+	}
+
+	return 0;
+}
+
+static struct notifier_block pm121_events =3D {
+	.notifier_call	=3D pm121_notify,
+};
+
+static int pm121_init_pm(void)
+{
+	const struct smu_sdbp_header *hdr;
+
+	hdr =3D smu_get_sdb_partition(SMU_SDB_SENSORTREE_ID, NULL);
+	if (hdr !=3D 0) {
+		struct smu_sdbp_sensortree *st =3D
+			(struct smu_sdbp_sensortree *)&hdr[1];
+		pm121_mach_model =3D st->model_id;
+	}
+
+	pm121_connection =3D &pm121_connections[pm121_mach_model - 2];
+
+	printk(KERN_INFO "pm121: Initializing for iMac G5 iSight model ID %d\n",
+	       pm121_mach_model);
+
+	return 0;
+}
+
+
+static int pm121_probe(struct platform_device *ddev)
+{
+	wf_register_client(&pm121_events);
+
+	return 0;
+}
+
+static int __devexit pm121_remove(struct platform_device *ddev)
+{
+	wf_unregister_client(&pm121_events);
+	return 0;
+}
+
+static struct platform_driver pm121_driver =3D {
+	.probe =3D pm121_probe,
+	.remove =3D __devexit_p(pm121_remove),
+	.driver =3D {
+		.name =3D "windfarm",
+		.bus =3D &platform_bus_type,
+	},
+};
+
+
+static int __init pm121_init(void)
+{
+	int rc =3D -ENODEV;
+
+	if (machine_is_compatible("PowerMac12,1"))
+		rc =3D pm121_init_pm();
+
+	if (rc =3D=3D 0) {
+#ifdef MODULE
+		request_module("windfarm_smu_controls");
+		request_module("windfarm_smu_sensors");
+		request_module("windfarm_smu_sat");
+		request_module("windfarm_lm75_sensor");
+		request_module("windfarm_max6690_sensor");
+		request_module("windfarm_cpufreq_clamp");
+
+#endif /* MODULE */
+		platform_driver_register(&pm121_driver);
+	}
+
+	return rc;
+}
+
+static void __exit pm121_exit(void)
+{
+
+	platform_driver_unregister(&pm121_driver);
+}
+
+
+module_init(pm121_init);
+module_exit(pm121_exit);
+
+MODULE_AUTHOR("=C3=89tienne Bersac <bersace@gmail.com>");
+MODULE_DESCRIPTION("Thermal control logic for iMac G5 (iSight)");
+MODULE_LICENSE("GPL");
+
diff --git a/drivers/macintosh/windfarm_smu_controls.c b/drivers/macintosh/=
windfarm_smu_controls.c
index 58c2590..961fa0e 100644
--- a/drivers/macintosh/windfarm_smu_controls.c
+++ b/drivers/macintosh/windfarm_smu_controls.c
@@ -218,6 +218,10 @@ static struct smu_fan_control *smu_fan_create(struct d=
evice_node *node,
 		fct->ctrl.name =3D "cpu-fan";
 	else if (!strcmp(l, "Hard Drive") || !strcmp(l, "Hard drive"))
 		fct->ctrl.name =3D "drive-bay-fan";
+	else if (!strcmp(l, "HDD Fan")) /* seen on iMac G5 iSight */
+		fct->ctrl.name =3D "hard-drive-fan";
+	else if (!strcmp(l, "ODD Fan")) /* same */
+		fct->ctrl.name =3D "optical-drive-fan";
=20
 	/* Unrecognized fan, bail out */
 	if (fct->ctrl.name =3D=3D NULL)


Thank you,
=C3=89tienne.
--=20
E Ultre=C3=AFa !

--=-/odplyClfo3Wpr0jYGxC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHVzZGbyMDDeXZS7URAmOIAJ9bgICgzqYEgHQlmWwfpWJRRWBqvwCfayhI
L4Y3xNFDZrntcw6M4bVwc4Y=
=HVKF
-----END PGP SIGNATURE-----

--=-/odplyClfo3Wpr0jYGxC--

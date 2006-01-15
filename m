Return-Path: <cedric.pradalier@free.fr>
Received: from qsrv01sl.mx.bigpond.com (qsrv01sl.mx.bigpond.com
	[144.140.92.181]) by ozlabs.org (Postfix) with ESMTP id 3A7AF681BD
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Jan 2006 14:09:55 +1100 (EST)
Date: Sun, 15 Jan 2006 11:43:45 +1000
From: Cedric Pradalier <cedric.pradalier@free.fr>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 001/001] subsystem: Themperature monitoring for ibook 2.2
Message-Id: <20060115114345.6c24125c.cedric.pradalier@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Cedric Pradalier <cedric.pradalier@free.fr>

This driver provides some thermostat monitoring for ibook2,
equipped with a adm103x fan control chip. It also provides
and sysfs access to the adm103x fan control parameters. For
instance 
	#cat /sys/device/temperature/info? 
	T:51*C S:56*C R:10*C  <-- sensor 0
	T:48*C S:76*C R:10*C  <-- sensor 1
	#echo "56 10" > /sys/device/temperature/info0 
make the fan starts at 56 degrees and accelerate
progressively till max at 66 degrees (56 + 10), on the
sensor 0.

The drivers also provides a ioctl access to the fan
parameters. This can be enabled/disabled at compile time.
major/minor number are 63 200, in the experimental range.

Developer's Certificate of Origin 
	By making a contribution to this project, I certify that:
	(a) The contribution was created in whole or in part by me and I
		have the right to submit it under the open source license
		indicated in the file; or
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

Signed-off-by: Cedric Pradalier <cedric.pradalier@free.fr>

---
diff -Naurp -X linux-2.6.15/Documentation/dontdiff linux-2.6.15/Documentation/therm_adm103x.txt linux-2.6.15-adm/Documentation/therm_adm103x.txt
--- linux-2.6.15/Documentation/therm_adm103x.txt	1970-01-01 10:00:00.000000000 +1000
+++ linux-2.6.15-adm/Documentation/therm_adm103x.txt	2006-01-15 11:27:58.000000000 +1000
@@ -0,0 +1,94 @@
+
+Therm ADM103X Version 1.2.3
+--------------------------------------------------------------
+Authors...: Cedric Pradalier (cedric.pradalier@free.fr)
+		
+
+Description
+--------------------------------------------------------------
+ This driver provides some thermostat monitoring for ibook2, equipped
+ with a adm1030 or adm1031 fan control chip. It also provides a sysfs
+ access to the adm103x fan control parameters. For instance
+ * #cat /sys/device/temperature/info? 
+ * T:51*C S:56*C R:10*C  <-- sensor 0
+ * T:48*C S:76*C R:10*C  <-- sensor 1
+ * #echo "56 10" > /sys/device/temperature/info0 
+ make the fan starts at 56 degrees and accelerate progressively till max
+ at 66 degrees (56 + 10), on the sensor 0.
+
+ Reading /sys/device/temperatures/minpwm0 shows the minimum speed of the fan.
+ Writing an integer value between 0 and 100 set this value. Low speed make
+ lower noise, but high speed lower temperature faster... Default is 33%.
+ * #echo "45" > /sys/device/temperature/minpwm0
+
+ You can also access the driver with ioctl commands. You need to include 
+ /usr/include/linux/therm_adm103x.h in sources. Then, nearly all commands
+ expect a struct IOC_Adm103x argument. 
+ 
+ typedef struct _IOC_Adm103x_ {
+	 unsigned char id;        /* sensor or fan id        */
+	 unsigned char mintemp;   /* fan starting temp  (deg)*/
+	 unsigned char rangetemp; /* fan speeding range (deg)*/
+	 unsigned char minpwm;    /* min fan speed  (percent)*/
+	 signed long int millitemp; /* current temp  (millideg)*/
+	 unsigned char hysteresis;/* current histeresis (deg)*/
+	 unsigned char reg;       /* accessed register       */
+	 unsigned char value;     /* value get/set into reg  */
+ } IOC_Adm103x;
+ 
+ Nine commands are available :
+
+ ADM103X_IOC_GETTEMP                
+ Argument : struct IOC_Adm103x * arg.
+ Action   : put temperature in milli-degrees in arg->millitemp
+ 
+ ADM103X_IOC_GETLIMITS              
+ Argument : struct IOC_Adm103x * arg.
+ Action   : read fan starting temperature and fan speeding range and 
+            write them in arg->mintemp and arg->rangetemp.
+			arg->id is used to select which sensor is concerned.
+
+ ADM103X_IOC_SETLIMITS              
+ Argument : struct IOC_Adm103x * arg.
+ Action   : set fan starting temperature and fan speeding range 
+            from arg->mintemp and arg->rangetemp.
+			arg->id is used to select which sensor is concerned.
+
+ ADM103X_IOC_GETMINPWM              
+ Argument : struct IOC_Adm103x * arg.
+ Action   : read fan minimal speed and write it in arg->minpwm
+			arg->id is used to select which fan is concerned.
+
+ ADM103X_IOC_SETMINPWM              
+ Argument : struct IOC_Adm103x * arg.
+ Action   : set fan minimal speed and from arg->minpwm
+			arg->id is used to select which fan is concerned.
+
+ ADM103X_IOC_CHECK_IF_FAN_IS_NEEDED 
+ Argument : None
+ Action   : Compare current temperature to current limits minus hysteresis 
+            and switch the fan off is needed. 
+
+ ADM103X_IOC_SETHYSTERESIS          
+ Argument : struct IOC_Adm103x * arg.
+ Action   : Set hysteresis for the ADM103X_IOC_CHECK_IF_FAN_IS_NEEDED
+            command. Default value is 2 degrees.
+
+ ADM103X_IOC_GETHYSTERESIS          
+ Argument : struct IOC_Adm103x * arg.
+ Action   : Get hysteresis for the ADM103X_IOC_CHECK_IF_FAN_IS_NEEDED
+            command. Value is written in arg->hysteresis. arg->id is used 
+			to select which sensor is concerned.
+
+ ADM103X_IOC_GETREGISTER             
+ Argument : struct IOC_Adm103x * arg.
+ Action   : Read a chip register. Register is selected with arg->reg and 
+            written in arg->value.
+
+Copyright
+--------------------------------------------------------------
+From my point of view this is freeware - I don't know what
+others think but...
+Read the COPYING file for the complete GNU license.
+
+
diff -Naurp -X linux-2.6.15/Documentation/dontdiff linux-2.6.15/drivers/macintosh/Kconfig linux-2.6.15-adm/drivers/macintosh/Kconfig
--- linux-2.6.15/drivers/macintosh/Kconfig	2006-01-03 13:21:10.000000000 +1000
+++ linux-2.6.15-adm/drivers/macintosh/Kconfig	2006-01-12 21:26:22.000000000 +1000
@@ -154,6 +154,20 @@ config THERM_WINDTUNNEL
 	  This driver provides some thermostat and fan control for the desktop
 	  G4 "Windtunnel"
 
+config THERM_ADM103X
+	tristate "Support for thermal monitoring on ibook2"
+	depends on I2C && I2C_KEYWEST && PPC_PMAC && !PPC_PMAC64
+	help
+	  This driver provides some thermostat monitoring for ibook2, equipped
+	  with a adm103x fan control chip. It also provides and sysfs
+	  access to the adm103x fan control parameters. For instance
+	  #cat /sys/device/temperature/info? 
+	  T:51*C S:56*C R:10*C  <-- sensor 0
+	  T:48*C S:76*C R:10*C  <-- sensor 1
+	  #echo "56 10" > /sys/device/temperature/info0 
+	  make the fan starts at 56 degrees and accelerate progressively till max
+	  at 66 degrees (56 + 10), on the sensor 0.
+
 config THERM_ADT746X
 	tristate "Support for thermal mgmnt on laptops with ADT 746x chipset"
 	depends on I2C && I2C_KEYWEST && PPC_PMAC && !PPC_PMAC64
diff -Naurp -X linux-2.6.15/Documentation/dontdiff linux-2.6.15/drivers/macintosh/Makefile linux-2.6.15-adm/drivers/macintosh/Makefile
--- linux-2.6.15/drivers/macintosh/Makefile	2006-01-03 13:21:10.000000000 +1000
+++ linux-2.6.15-adm/drivers/macintosh/Makefile	2006-01-12 21:26:22.000000000 +1000
@@ -25,6 +25,7 @@ obj-$(CONFIG_ADB_MACIO)		+= macio-adb.o
 
 obj-$(CONFIG_THERM_PM72)	+= therm_pm72.o
 obj-$(CONFIG_THERM_WINDTUNNEL)	+= therm_windtunnel.o
+obj-$(CONFIG_THERM_ADM103X)	+= therm_adm103x.o
 obj-$(CONFIG_THERM_ADT746X)	+= therm_adt746x.o
 obj-$(CONFIG_WINDFARM)	        += windfarm_core.o
 obj-$(CONFIG_WINDFARM_PM81)     += windfarm_smu_controls.o \
diff -Naurp -X linux-2.6.15/Documentation/dontdiff linux-2.6.15/drivers/macintosh/therm_adm103x.c linux-2.6.15-adm/drivers/macintosh/therm_adm103x.c
--- linux-2.6.15/drivers/macintosh/therm_adm103x.c	1970-01-01 10:00:00.000000000 +1000
+++ linux-2.6.15-adm/drivers/macintosh/therm_adm103x.c	2006-01-15 11:38:36.000000000 +1000
@@ -0,0 +1,895 @@
+/*
+ * Device driver for the i2c thermostat found on some iBook G3 (for intance
+ * ibook 2.2) : Namely the adm1030 or adm1031 chip.
+ *
+ * Copyright (C) 2003, 2004 Cedric Pradalier, Colin Leroy, 
+ * 	                        Rasmus Rohde, Benjamin Herrenschmidt
+ *
+ * Documentation from
+ * http://www.analog.com/UploadedFiles/Data_Sheets/27250527ADM1031_a.pdf
+ * http://www.analog.com/UploadedFiles/Data_Sheets/878926113ADM1030_a.pdf
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/sched.h>
+#include <linux/i2c.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/spinlock.h>
+#include <linux/smp_lock.h>
+#include <linux/wait.h>
+#include <linux/miscdevice.h>
+#include <linux/syscalls.h>
+#include <linux/poll.h>
+#include <linux/devfs_fs_kernel.h>
+#include <asm/prom.h>
+#include <asm/machdep.h>
+#include <asm/io.h>
+#include <asm/system.h>
+#include <asm/sections.h>
+#include <asm/of_device.h>
+#include <asm/uaccess.h>
+
+
+#define ADM103X_USE_IOCTL
+
+
+#ifdef ADM103X_USE_IOCTL
+#include "linux/therm_adm103x.h"
+#endif
+
+
+/* Choose for display which caracter to use. The degree symbol is */
+/* not supported in all fonts.                                    */
+#define DEGREE_CHARACTER '*'
+
+/* ADM Part */
+static uint8_t ADM_LIMIT_REG[3] = { 0x24, 0x25, 0x26 };	/* local, remote, remote */
+static uint8_t ADM_OFFSET_REG[3] = { 0x0D, 0x0E, 0x0F };	/* local, remote, remote */
+static uint8_t ADM_TEMP_REG[3] = { 0x0a, 0x0b, 0x0c };	/* local, remote, remote */
+#define ADM_RESOL_REG 0x06
+#define ADM_MINPWM_REG 0x22
+
+/* Regs marked with 1 are used on adm1030 and adm1031 
+ * regs marked with 2 are used only on adm1031 */
+static uint8_t ADM_USED_REG[0x40] = 
+{
+	 /* 0 1 2 3 4 5 6 7 8 9 A B C D E F */
+/*0*/   1,1,1,1,0,0,1,0,1,2,1,1,2,1,1,2,
+/*1*/   1,2,0,0,1,1,1,0,1,1,1,0,2,2,2,0,
+/*2*/   1,2,1,1,1,1,2,0,0,0,0,0,0,0,0,0,
+/*3*/   0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1
+};
+
+#define DRIVER_NAME "adm103x"
+#define DRIVER_VERSION "2004 May 25"
+#define DRIVER_DESC "Driver for ADM103x thermostat in iBook G3"
+#define DRIVER_INFO DRIVER_VERSION " " DRIVER_DESC
+MODULE_AUTHOR ("Cedric Pradalier <cedric.pradalier@free.fr>");
+MODULE_DESCRIPTION (DRIVER_INFO);
+MODULE_LICENSE ("GPL");
+MODULE_VERSION ("1:2.3");
+
+static int debug = 0;
+
+MODULE_PARM(debug, "i");
+MODULE_PARM_DESC(debug, "If != 0, activates debug output. If > 1, activates monitoring thread.");
+#define DPRINTK if (debug) printk
+
+
+#ifdef ADM103X_USE_IOCTL
+static int useioctl = 0;
+MODULE_PARM(useioctl, "i");
+MODULE_PARM_DESC(useioctl, "if non-zero, activates ioctl interface in /dev/adm103x (10,200)");
+#endif
+
+struct thermostat
+{
+	struct i2c_client clt;
+	uint8_t startfan[3];
+	uint8_t ranges[3];
+	uint8_t regtoread;
+	uint8_t hysteresis[3];
+};
+
+static enum { ADM1030, ADM1031 } therm_type;
+static int therm_bus, therm_address;
+static struct of_device *of_dev;
+static struct thermostat *thermostat;
+
+static pid_t monitor_thread_id;
+static int monitor_running;
+static struct completion monitor_task_compl;
+
+static int attach_one_thermostat (struct i2c_adapter *adapter, int addr,
+		int busno);
+
+/** Encoding of limit in adm103x registers : 
+ * Bits 7:3 : min   : fan starting temperature divided by 4
+ * Bits 2:0 : range :temperature at which fan motors is running at full speed
+ *      |                                  
+ *   max|                      oooooooooooo
+ *      |                    oo            
+ *fan   |                 ooo              
+ *speed |              ooo                 
+ *      |           ooo                    
+ *      |         oo                       
+ *   min|        o                         
+ *      |        o                         
+ *      |        o<----range--->|     Temperature
+ *     0+ooooooooo--------------|--------> in Celcius                      
+ *               min
+ *               
+ * */
+static void
+adm_reg2minrange (uint8_t reg, uint8_t * min, uint8_t * range)
+{
+	*min = (reg & 0xF8) >> 1;
+	if ((reg&0x07)>4)
+		printk (KERN_INFO "adm103x: invalid limit temp register %02x\n", reg);
+	*range = 5 * (1<<(reg&0x07));
+}
+
+static uint8_t
+adm_minrange2reg (uint8_t min, uint8_t range)
+{
+	/* Rounding to nearest 4 degree */
+	if (min & 0x2) min += 4;
+	min = (min & 0xFC) << 1;
+	switch (range) {
+		case 5: return min;
+		case 10: return min | 0x01;
+		case 20: return min | 0x02;
+		case 40: return min | 0x03;
+		case 80: return min | 0x04;
+		default:
+				 printk (KERN_INFO "adm103x: invalid limit temp range %d-%d\n", min, range);
+				 return min;
+	}
+}
+
+static char *
+therm_name (int therm_type)
+{
+	switch (therm_type) {
+		case ADM1030:
+			return "adm1030";
+		case ADM1031:
+			return "adm1031";
+	}
+	return "unknown";
+}
+
+/*****************************************************
+ *
+ * I2C Bus Management
+ *
+ *****************************************************/
+static int
+write_reg (struct thermostat *th, int reg, uint8_t data)
+{
+	uint8_t tmp[2];
+	int rc;
+
+	tmp[0] = reg;
+	tmp[1] = data;
+	rc = i2c_master_send (&th->clt, (const char *) tmp, 2);
+	if (rc < 0)
+		return rc;
+	if (rc != 2)
+		return -ENODEV;
+	return 0;
+}
+
+static int
+read_reg (struct thermostat *th, int reg)
+{
+	uint8_t reg_addr, data;
+	int rc;
+
+	reg_addr = (uint8_t) reg;
+	rc = i2c_master_send (&th->clt, (const char*)&reg_addr, 1);
+	if (rc < 0)
+		return rc;
+	if (rc != 1)
+		return -ENODEV;
+	rc = i2c_master_recv (&th->clt, (char *) &data, 1);
+	if (rc < 0)
+		return rc;
+	return data;
+}
+
+static int
+attach_thermostat (struct i2c_adapter *adapter)
+{
+	unsigned long bus_no;
+	DPRINTK (KERN_INFO "adm103x: attach_thermostat\n");
+
+
+	if (strncmp (adapter->name, "uni-n", 5))
+		return -ENODEV;
+	bus_no = simple_strtoul (adapter->name + 6, NULL, 10);
+	if (bus_no != therm_bus)
+		return -ENODEV;
+	return attach_one_thermostat (adapter, therm_address, bus_no);
+}
+
+static int
+detach_thermostat (struct i2c_adapter *adapter)
+{
+	struct thermostat *th;
+	DPRINTK (KERN_INFO "adm103x: deattach_thermostat\n");
+
+	if (thermostat == NULL)
+		return 0;
+
+	th = thermostat;
+
+	if (debug>1) {
+		if (monitor_running) {
+			monitor_running = 0;
+			wait_for_completion (&monitor_task_compl);
+		}
+	}
+
+	i2c_detach_client (&th->clt);
+
+	thermostat = NULL;
+
+	kfree (th);
+
+	return 0;
+}
+
+static struct i2c_driver thermostat_driver = {
+	.name = "Apple Thermostat ADM103x",
+	.id = 0xDEAD1030,
+	.flags = I2C_DF_NOTIFY,
+	.attach_adapter = &attach_thermostat,
+	.detach_adapter = &detach_thermostat
+};
+
+static int
+monitor_task (void *arg)
+{
+	/**
+	 * Monitoring thread. Only useful in debug. Otherwise, you can
+	 * access chip state in sysfs 
+	 * **/
+	struct thermostat *th = arg;
+	uint8_t temps[3], start[3], range[3];
+	uint8_t nbsensor, reg;
+	int i;
+	start[2] = range[2] = temps[2] = 0;
+
+	lock_kernel ();
+	daemonize ("kfand");
+	unlock_kernel ();
+	strcpy (current->comm, "thermostat");
+	monitor_running = 1;
+
+	while (monitor_running) {
+		set_task_state (current, TASK_UNINTERRUPTIBLE);
+		schedule_timeout (1 * HZ);
+
+		/* Read status */
+		/* local   : chip */
+		/* remote 1: CPU ? */
+		/* remote 2: GPU ? */
+		nbsensor = (therm_type == ADM1030) ? 2 : 3;
+		for (i = 0; i < nbsensor; i++) {
+			temps[i] = read_reg (th, ADM_TEMP_REG[i]);
+			reg = read_reg (th, ADM_LIMIT_REG[i]);
+			adm_reg2minrange (reg, &start[i], &range[i]);
+		}
+
+		printk (KERN_INFO "adm103x: Temperature infos: %d,%d,%d%cC\n",
+				temps[0], temps[1], temps[2],DEGREE_CHARACTER);
+		printk (KERN_INFO "adm103x: FanCtrl infos: %d,%d,%d%cC\n",
+				start[0], start[1], start[2],DEGREE_CHARACTER);
+		printk (KERN_INFO "adm103x: FanCtrl infos: %d,%d,%d%cC\n",
+				range[0], range[1], range[2],DEGREE_CHARACTER);
+	}
+
+	complete_and_exit (&monitor_task_compl, 0);
+	return 0;
+}
+
+
+static int attach_one_thermostat (struct i2c_adapter *adapter, int addr, int busno)
+{
+	struct thermostat *th;
+	int rc;
+	int i;
+	uint8_t reg;
+
+	DPRINTK (KERN_INFO "adm103x: attach_one_thermostat\n");
+	if (thermostat)
+		return 0;
+	th = (struct thermostat *) kmalloc (sizeof (struct thermostat), GFP_KERNEL);
+	if (!th)
+		return -ENOMEM;
+	memset (th, 0, sizeof (*th));
+	th->clt.addr = addr;
+	th->clt.adapter = adapter;
+	th->clt.driver = &thermostat_driver;
+	/*th->clt.id = 0xDEAD1030;*/
+	strcpy (th->clt.name, "thermostat");
+
+	rc = read_reg (th, 0);
+	if (rc < 0) {
+		printk (KERN_ERR
+				"adm103x: Thermostat failed to read config from bus %d !\n",
+				busno);
+		kfree (th);
+		return -ENODEV;
+	}
+
+	printk (KERN_INFO "adm103x: %s initializing\n", therm_name (therm_type));
+
+	/* Initializing thermostat structure from chip registers */
+	for (i = 0; i < ((therm_type == ADM1030) ? 2 : 3); i++) {
+		uint8_t min, range, off;
+		reg = read_reg (th, ADM_LIMIT_REG[i]);
+		off = read_reg (th, ADM_OFFSET_REG[i]);
+		adm_reg2minrange (reg, &min, &range);
+		printk (KERN_INFO "adm103x: %s initializing %d:%d+%d%cC\n",
+				therm_name (therm_type), i, 
+				(off&0x80)?(min+(off&0x0F)):(min-(off&0x0F)), range,
+				DEGREE_CHARACTER);
+		th->startfan[i] = min;
+		th->ranges[i] = range;
+		th->hysteresis[i] = 2;
+	}
+	th->regtoread = 0;
+	/* activate automatic control and set analog speed input */
+	reg = read_reg (th, 0x00);
+	write_reg (th, 0x00, reg | 0x84);
+
+	thermostat = th;
+
+	if (i2c_attach_client (&th->clt)) {
+		printk ("adm103x: Thermostat failed to attach client !\n");
+		thermostat = NULL;
+		kfree (th);
+		return -ENODEV;
+	}
+
+	if (debug > 1) {
+		/* In debug we launch a monitoring thread which output
+		 * chip state in syslog */
+		init_completion (&monitor_task_compl);
+
+		monitor_thread_id = kernel_thread (monitor_task, th,
+				SIGCHLD | CLONE_KERNEL);
+	}
+
+	return 0;
+}
+
+
+/*****************************************************
+ *
+ * ADM103X Data Manipulation
+ *
+ *****************************************************/
+
+
+
+static int set_limit (struct thermostat *th, int i, int min, int range)
+{
+	int error;
+	uint8_t offset = min % 4;
+	uint8_t limit = adm_minrange2reg ((offset==0)?min:(min-offset+4), range);
+	th->startfan[i] = min;
+	th->ranges[i] = range;
+	printk (KERN_INFO "adm103x: Setting FanCtrl infos: %d : %d+%d%cC\n",
+			i, th->startfan[i], th->ranges[i],DEGREE_CHARACTER);
+	error = write_reg (th, ADM_OFFSET_REG[i], (offset==0)?0x00:(4-offset));
+	if (error) return error;
+	error = write_reg (th, ADM_LIMIT_REG[i], limit);
+	return error;
+}
+
+static int get_limit (struct thermostat *th, int i, uint8_t * min, uint8_t * range)
+{
+	uint8_t lim; 
+	uint8_t o = read_reg(th, ADM_OFFSET_REG[i]);
+	uint8_t l = read_reg(th, ADM_LIMIT_REG[i]);
+	adm_reg2minrange(l,&lim,range);
+	*min = (o&0x80)?(lim+(o&0x0F)):(lim-(o&0x0F));
+	return 0;
+}
+
+static int get_temp(struct thermostat * th, int i, int32_t * millitemp)
+{
+	uint16_t resol=0;
+	uint8_t o = read_reg(th, ADM_OFFSET_REG[i]);
+	uint8_t t = read_reg(th, ADM_TEMP_REG[i]);
+	uint8_t p = read_reg(th, ADM_RESOL_REG);
+	switch(i){
+		case 0: resol = ((((uint16_t)p)&0xC0)>>6)*250; break;
+		case 1: resol = (((uint16_t)p)&0x07)*125; break;
+		case 2: resol = ((((uint16_t)p)&0x38)>>3)*125; break;
+	}
+	t = (o&0x80)?(t+(o&0x0F)):(t-(o&0x0F));
+	*millitemp = (((int32_t)t)*1000)+resol;
+	return 0;
+}
+
+static uint8_t show_minPWM(struct thermostat * th, uint8_t index)
+{
+	static uint8_t s[16]={0,7,14,20, 27,33,40,47, 53,60,67,73, 80,87,93,100};
+	uint8_t minpwm = read_reg(th, ADM_MINPWM_REG);
+	uint8_t val=0;
+	switch (index) {
+		case 0 : val = s[minpwm&0x0F]; break;
+		case 1 : val = s[(minpwm&0xF0)>>4]; break;
+	}
+	return val;
+}
+
+static int set_minPWM(struct thermostat * th, int newpwm, uint8_t index)
+{
+	static uint8_t s[16]={0,7,14,20, 27,33,40,47, 53,60,67,73, 80,87,93,100};
+	uint8_t i,minpwm; 
+	int d;
+	for (i=0;i<16;i++) {
+		d=s[i]-newpwm;
+		if ((d<=3)&&(d>-3)) 
+			break;
+	}
+	minpwm = read_reg(th, ADM_MINPWM_REG);
+	switch(index) {
+		case 0 : minpwm = (minpwm&0xF0) | i; break;
+		case 1 : minpwm = (minpwm&0x0F) | (i<<4); break;
+	}
+	return write_reg(th,ADM_MINPWM_REG,minpwm);
+}
+
+#ifdef ADM103X_USE_IOCTL
+static int checkIfFanIsNeeded(struct thermostat * th)
+{
+	int i,nbsensors;
+	uint8_t lim,rge;
+	int32_t millitemp;
+	uint8_t fanIsNeeded = 0;
+	nbsensors = (therm_type==ADM1030)?2:3;
+	DPRINTK (KERN_INFO "adm103x: check if fan is needed \n");
+	for (i=0;i<nbsensors;i++) {
+		get_limit(th,i,&lim,&rge);
+		get_temp(th,i,&millitemp);
+		DPRINTK (KERN_INFO "adm103x: sensor %d : %d.%d <? %d - %d \n",i, 
+				millitemp/1000, millitemp%1000, lim,th->hysteresis[i] );
+		if (millitemp > 1000*((int32_t)lim - th->hysteresis[i]))
+			fanIsNeeded = 1;
+	}
+	if (!fanIsNeeded) {
+		uint8_t lim[3],rge[3];
+		DPRINTK (KERN_INFO "adm103x: fan is not needed \n");
+		for (i=0;i<nbsensors;i++) {
+			/* The following hack stop the fan is no-longer needed. */
+			/* Hard coded adm1030/1 hysteresis is 5 degrees.        */
+			get_limit(th,i,&lim[i],&rge[i]);
+			set_limit(th,i,lim[i]+6,rge[i]);
+		}
+		set_task_state (current, TASK_UNINTERRUPTIBLE);
+		schedule_timeout (1 * HZ);
+		for (i=0;i<nbsensors;i++) {
+			set_limit(th,i,lim[i],rge[i]);
+		}
+	}
+	else
+	{
+		DPRINTK (KERN_INFO "adm103x: fan is needed \n");
+	}
+	return 0;
+}
+#endif
+
+
+/*****************************************************
+ *
+ * SYSFS Access
+ *
+ *****************************************************/
+
+
+/* 
+ * Now, unfortunately, sysfs doesn't give us a nice void * we could
+ * pass around to the attribute functions, so we don't really have
+ * choice but implement a bunch of them...
+ *
+ */
+#define BUILD_SHOWPWM_FUNC(index) \
+static ssize_t show_minPWM##index(struct device *dev, struct device_attribute *attr, char *buf)\
+{   uint8_t minpwm = 0;                      \
+	minpwm = show_minPWM(thermostat,index);  \
+	return sprintf(buf, "%3d%%\n", minpwm); }
+
+#define BUILD_SETPWM_FUNC(index) \
+static ssize_t set_minPWM##index(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)\
+{ \
+	int newpwm; \
+	if (sscanf (buf, "%d", &newpwm) != 1)\
+		return -EINVAL;\
+	if ((newpwm < 0) || (newpwm > 100))\
+		return -EINVAL;\
+	set_minPWM(thermostat,newpwm,index);      \
+	return count; \
+}
+
+
+static ssize_t show_regtoread(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%02X\n", thermostat->regtoread);
+}
+
+static ssize_t show_reg(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	uint8_t reg = 0;                                           
+	reg = read_reg(thermostat, thermostat->regtoread);
+	return sprintf(buf, "%02X\n", reg);
+}
+
+static ssize_t set_regtoread(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+{
+	unsigned int r2r;
+	thermostat->regtoread=0;
+	if (sscanf (buf, "%X", &r2r) != 1)
+		return -EINVAL;
+	if ((r2r > 0x3F)||(ADM_USED_REG[r2r]==0)){
+		printk (KERN_INFO 
+				"adm103x: invalid register %02X \n", r2r);
+		return -EINVAL;
+	}
+
+	if ((therm_type==ADM1030)&&(ADM_USED_REG[r2r]==2)) {
+		printk (KERN_INFO 
+				"adm103x: invalid register %02X on device adm1030\n", r2r);
+		return -EINVAL;
+	}
+	DPRINTK (KERN_INFO "adm103x: register to read : %02X \n", r2r);
+	thermostat->regtoread=r2r;
+	return count;
+}
+	
+
+
+#define BUILD_SHOW_FUNC(index)				\
+static ssize_t show_info##index(struct device *dev, struct device_attribute *attr, char *buf)		   \
+{                                                                      \
+	uint8_t lim,rge; int32_t millitemp;                                \
+	get_limit(thermostat,index,&lim,&rge);                             \
+	get_temp(thermostat,index,&millitemp);                             \
+	return sprintf(buf, "T:%d.%03u%cC S:%d%cC R:%d%cC H:%d%cC\n",      \
+			millitemp/1000, millitemp%1000, DEGREE_CHARACTER,          \
+			lim, DEGREE_CHARACTER,                                     \
+			rge, DEGREE_CHARACTER,                                     \
+			thermostat->hysteresis[index],DEGREE_CHARACTER);           \
+}
+
+#define BUILD_SET_FUNC(index)				\
+static ssize_t set_info##index(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)		\
+{																	\
+	int start,range,hyst,narg; \
+	narg = sscanf (buf, " %u %u %u", &start, &range, &hyst);        \
+	if ((narg != 2) && (narg != 3))return -EINVAL;					\
+    if (narg == 2) hyst = 2;                                        \
+	if (start > 124) return -EINVAL;								\
+	if ((range!=5)&&(range!=10)&&(range!=20)&&(range!=40)) 			\
+		return -EINVAL;												\
+	if ((hyst < 0) || (hyst > 100)) hyst = 2;                       \
+	set_limit(thermostat,index,start,range);						\
+	thermostat->hysteresis[index] = hyst;                           \
+	return count;													\
+}
+
+
+BUILD_SHOWPWM_FUNC (0)
+BUILD_SETPWM_FUNC (0)
+BUILD_SHOWPWM_FUNC (1) 
+BUILD_SETPWM_FUNC (1) 
+
+BUILD_SHOW_FUNC (0)
+BUILD_SET_FUNC (0)
+BUILD_SHOW_FUNC (1) 
+BUILD_SET_FUNC (1) 
+BUILD_SHOW_FUNC (2) 
+BUILD_SET_FUNC (2)
+
+static DEVICE_ATTR (info0, S_IRUGO | S_IWUSR, show_info0, set_info0);
+static DEVICE_ATTR (info1, S_IRUGO | S_IWUSR, show_info1, set_info1);
+static DEVICE_ATTR (info2, S_IRUGO | S_IWUSR, show_info2, set_info2);
+static DEVICE_ATTR (minpwm0, S_IRUGO | S_IWUSR, show_minPWM0, set_minPWM0);
+static DEVICE_ATTR (minpwm1, S_IRUGO | S_IWUSR, show_minPWM1, set_minPWM1);
+static DEVICE_ATTR (regtoread, S_IRUGO | S_IWOTH , show_regtoread, set_regtoread);
+static DEVICE_ATTR (register, S_IRUGO | S_IWUSR , show_reg, NULL);
+
+/*****************************************************
+ *
+ * IOCTL Access
+ *
+ *****************************************************/
+#ifdef ADM103X_USE_IOCTL
+static int adm103x_open(struct inode *inode, struct file *file)
+{
+	file->private_data = 0;
+	return 0;
+}
+
+static int adm103x_release(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+static int adm103x_ioctl(struct inode * inode, struct file *filp,
+		     u_int cmd, u_long arg)
+{
+	int error = 0;
+	IOC_Adm103x data;
+
+	switch (cmd) {
+		case ADM103X_IOC_SETLIMITS:
+			/* arg : struct {?id, ?tmin, ?trange} */
+			if (!capable(CAP_SYS_ADMIN))
+				return -EACCES;
+			if (copy_from_user(&data,(void*)arg,sizeof(IOC_Adm103x)))
+				return -EFAULT;
+			if (data.id >= 3) return -EINVAL;
+			if ((data.id >= 2) && (therm_type != ADM1031)) return -EINVAL;
+			if (data.mintemp > 124)
+				return -EINVAL;
+			if ((data.rangetemp!=5)&&(data.rangetemp!=10)&&
+					(data.rangetemp!=20)&&(data.rangetemp!=40))
+				return -EINVAL;
+			set_limit(thermostat,data.id,data.mintemp,data.rangetemp);
+			return 0;
+		case ADM103X_IOC_GETLIMITS:
+			/* arg : struct {?id, !tmin, !trange} */
+			if (copy_from_user(&data,(void*)arg,sizeof(IOC_Adm103x)))
+				return -EFAULT;
+			if (data.id >= 3) return -EINVAL;
+			if ((data.id >= 2) && (therm_type != ADM1031)) return -EINVAL;
+			{
+				uint8_t mt,rt;
+				get_limit(thermostat,data.id,&mt,&rt);
+				data.mintemp = mt;
+				data.rangetemp = rt;
+			}
+			if (copy_to_user((void*)arg,&data,sizeof(IOC_Adm103x)))
+				return -EFAULT;
+			return 0;	
+		case ADM103X_IOC_GETTEMP:
+			/* arg : struct {?id, !temp} */
+			if (copy_from_user(&data,(void*)arg,sizeof(IOC_Adm103x)))
+				return -EFAULT;
+			if (data.id >= 3) return -EINVAL;
+			if ((data.id >= 2) && (therm_type != ADM1031)) return -EINVAL;
+			{
+				int32_t millitemp;
+				get_temp(thermostat,data.id,&millitemp);
+				data.millitemp = millitemp;
+			}
+			if (copy_to_user((void*)arg,&data,sizeof(IOC_Adm103x)))
+				return -EFAULT;
+			return 0;	
+		case ADM103X_IOC_SETMINPWM:
+			/* arg : struct {?id, ?minpwm} */
+			if (copy_from_user(&data,(void*)arg,sizeof(IOC_Adm103x)))
+				return -EFAULT;
+			if (!capable(CAP_SYS_ADMIN))
+				return -EACCES;
+			if (data.id >= 2) return -EINVAL;
+			if ((data.id >= 1) && (therm_type != ADM1031)) return -EINVAL;
+			if (data.minpwm > 100)
+				return -EINVAL;
+			set_minPWM(thermostat,data.minpwm,data.id);
+			return 0;
+		case ADM103X_IOC_GETMINPWM:
+			/* arg : struct {?id, !minpwm} */
+			if (copy_from_user(&data,(void*)arg,sizeof(IOC_Adm103x)))
+				return -EFAULT;
+			if (data.id >= 2) return -EINVAL;
+			if ((data.id >= 1) && (therm_type != ADM1031)) return -EINVAL;
+			data.minpwm = show_minPWM(thermostat,data.id);
+			if (copy_to_user((void*)arg,&data,sizeof(IOC_Adm103x)))
+				return -EFAULT;
+			return 0;	
+		case ADM103X_IOC_CHECK_IF_FAN_IS_NEEDED:
+			/* arg : void */
+			error = checkIfFanIsNeeded(thermostat);
+			return error;
+		case ADM103X_IOC_GETHYSTERESIS:
+			/* arg : struct {?id, !hysteresis} */
+			if (copy_from_user(&data,(void*)arg,sizeof(IOC_Adm103x)))
+				return -EFAULT;
+			if (data.id >= 3) return -EINVAL;
+			if ((data.id >= 2) && (therm_type != ADM1031)) return -EINVAL;
+			data.hysteresis = thermostat->hysteresis[data.id];
+			if (copy_to_user((void*)arg,&data,sizeof(IOC_Adm103x)))
+				return -EFAULT;
+			return 0;	
+		case ADM103X_IOC_SETHYSTERESIS:
+			/* arg : struct {?id, ?hysteresis} */
+			if (copy_from_user(&data,(void*)arg,sizeof(IOC_Adm103x)))
+				return -EFAULT;
+			if (!capable(CAP_SYS_ADMIN))
+				return -EACCES;
+			if (data.id >= 3) return -EINVAL;
+			if ((data.id >= 2) && (therm_type != ADM1031)) return -EINVAL;
+			thermostat->hysteresis[data.id] = data.hysteresis;
+			return 0;
+		case ADM103X_IOC_GETREGISTER:
+			/* arg : struct {?id, ?register, !value} */
+			if (copy_from_user(&data,(void*)arg,sizeof(IOC_Adm103x)))
+				return -EFAULT;
+			if ((data.reg > 0x3F)||(ADM_USED_REG[data.reg]==0)){
+				printk (KERN_INFO "adm103x: invalid register %02X \n", data.reg);
+				return -EINVAL;
+			}
+			if ((therm_type==ADM1030)&&(ADM_USED_REG[data.reg]==2)) {
+				printk (KERN_INFO "adm103x: invalid register %02X on device adm1030\n", data.reg);
+				return -EINVAL;
+			}
+			data.value = read_reg(thermostat, data.reg);
+			if (copy_to_user((void*)arg,&data,sizeof(IOC_Adm103x)))
+				return -EFAULT;
+			return 0;	
+	}
+	return -EINVAL;
+}
+
+
+static ssize_t adm103x_read(struct file *file, char __user *buf,
+			size_t count, loff_t *ppos)
+{
+	return -EINVAL;
+}
+
+static ssize_t adm103x_write(struct file *file, const char __user *buf,
+			 size_t count, loff_t *ppos)
+{
+	return -EINVAL;
+}
+
+static unsigned int adm103x_fpoll(struct file *filp, poll_table *wait)
+{
+	return -EINVAL;
+}
+
+static struct file_operations adm103x_device_fops = {
+	.read		= adm103x_read,
+	.write		= adm103x_write,
+	.poll		= adm103x_fpoll,
+	.ioctl		= adm103x_ioctl,
+	.open		= adm103x_open,
+	.release	= adm103x_release,
+};
+
+
+#endif
+
+/*****************************************************
+ *
+ * Module management
+ *
+ *****************************************************/
+
+
+static int __init
+thermostat_init (void)
+{
+	int error;
+	struct device_node *np;
+	uint32_t *prop;
+
+
+	/* Currently, we only deal with the iBook G3, rev 2.2
+	 */
+	np = of_find_node_by_name (NULL, "fan");
+	if (!np)
+		return -ENODEV;
+	if (device_is_compatible (np, "adm1030")) {
+		therm_type = ADM1030;
+	} else if (device_is_compatible (np, "adm1031")) {
+		therm_type = ADM1031;
+	}
+	else
+		return -ENODEV;
+
+	prop = (uint32_t *) get_property (np, "reg", NULL);
+	if (!prop)
+		return -ENODEV;
+	therm_bus = ((*prop) >> 8) & 0x0f;
+	therm_address = ((*prop) & 0xff) >> 1;
+
+	printk (KERN_INFO "adm103x: Thermostat bus: %d, address: 0x%02x\n",
+			therm_bus, therm_address);
+
+#ifndef CONFIG_I2C_KEYWEST
+	request_module ("i2c-keywest");
+#endif
+
+#ifdef ADM103X_USE_IOCTL
+	if (useioctl) {
+		/* 
+		 *      * try to register device major number against driver entry points.
+		 *           */
+		if (register_chrdev(ADM103X_MAJOR,DRIVER_NAME,&adm103x_device_fops)) {
+			if (devfs_mk_cdev(MKDEV(ADM103X_MAJOR, ADM103X_MINOR) ,
+						S_IFCHR | S_IRUSR | S_IWUSR, DRIVER_NAME)!=0) {
+				printk(KERN_ERR "adm103x: cannot create device.\n");
+				useioctl = 0;
+			}
+			printk(KERN_ERR "adm103x: cannot register major %d device.\n",ADM103X_MAJOR);
+			useioctl = 0;
+		} else
+			printk(KERN_INFO "adm103x: device registered.\n");
+	}
+#endif
+	of_dev = of_platform_device_create (np, "temperatures",NULL);
+
+	if (of_dev == NULL) {
+		printk (KERN_ERR "Can't register temperatures device !\n");
+		return -ENODEV;
+	}
+
+	device_create_file (&of_dev->dev, &dev_attr_register);
+	device_create_file (&of_dev->dev, &dev_attr_regtoread);
+	device_create_file (&of_dev->dev, &dev_attr_info0);
+	device_create_file (&of_dev->dev, &dev_attr_info1);
+	device_create_file (&of_dev->dev, &dev_attr_minpwm0);
+	if (therm_type == ADM1031) {
+		device_create_file (&of_dev->dev, &dev_attr_minpwm1);
+		device_create_file (&of_dev->dev, &dev_attr_info2);
+	}
+
+	error = i2c_add_driver (&thermostat_driver);
+
+	DPRINTK(KERN_INFO "Driver initialized %d\n",error);
+
+	return error;
+}
+
+static void __exit
+thermostat_exit (void)
+{
+	if (of_dev) {
+		device_remove_file (&of_dev->dev, &dev_attr_register);
+		device_remove_file (&of_dev->dev, &dev_attr_regtoread);
+		device_remove_file (&of_dev->dev, &dev_attr_info0);
+		device_remove_file (&of_dev->dev, &dev_attr_info1);
+		device_remove_file (&of_dev->dev, &dev_attr_minpwm0);
+		if (therm_type == ADM1031) {
+			device_remove_file (&of_dev->dev, &dev_attr_minpwm1);
+			device_remove_file (&of_dev->dev, &dev_attr_info2);
+		}
+
+		of_device_unregister (of_dev);
+	}
+#ifdef ADM103X_USE_IOCTL
+	if (useioctl) {
+		devfs_remove(DRIVER_NAME);
+		if (unregister_chrdev(ADM103X_MAJOR,DRIVER_NAME)<0)
+			printk(KERN_ERR "adm103x: cannot deregister %d  device.\n",ADM103X_MAJOR);
+		else
+			printk(KERN_INFO "adm103x: driver deregistered.\n");
+	}
+#endif
+	i2c_del_driver (&thermostat_driver);
+}
+
+module_init (thermostat_init);
+module_exit (thermostat_exit);
+
+
+
+
+
diff -Naurp -X linux-2.6.15/Documentation/dontdiff linux-2.6.15/include/linux/therm_adm103x.h linux-2.6.15-adm/include/linux/therm_adm103x.h
--- linux-2.6.15/include/linux/therm_adm103x.h	1970-01-01 10:00:00.000000000 +1000
+++ linux-2.6.15-adm/include/linux/therm_adm103x.h	2006-01-12 21:27:51.000000000 +1000
@@ -0,0 +1,30 @@
+#ifndef THERM_ADM103X_H
+#define THERM_ADM103X_H
+
+#define ADM103X_MINOR 200
+#define ADM103X_MAJOR 63 // Experimental
+
+typedef struct _IOC_Adm103x_ {
+	unsigned char id;        /* sensor or fan id        */
+	unsigned char mintemp;   /* fan starting temp  (deg)*/
+	unsigned char rangetemp; /* fan speeding range (deg)*/
+	unsigned char minpwm;    /* min fan speed  (percent)*/
+	signed long int millitemp; /* current temp  (millideg)*/
+	unsigned char hysteresis;/* current histeresis (deg)*/
+	unsigned char reg;       /* accessed register       */
+	unsigned char value;     /* value get/set into reg  */
+} IOC_Adm103x;
+
+#define ADM103X_IOC_GETTEMP                1
+#define ADM103X_IOC_GETLIMITS              2
+#define ADM103X_IOC_SETLIMITS              3
+#define ADM103X_IOC_SETMINPWM              4
+#define ADM103X_IOC_GETMINPWM              5
+#define ADM103X_IOC_CHECK_IF_FAN_IS_NEEDED 6
+#define ADM103X_IOC_SETHYSTERESIS          7
+#define ADM103X_IOC_GETHYSTERESIS          8
+#define ADM103X_IOC_GETREGISTER            9
+
+
+
+#endif // THERM_ADM103X_H



-- 
Cedric

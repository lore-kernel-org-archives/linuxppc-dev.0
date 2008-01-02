Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 8A6BDDDE02
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jan 2008 16:25:36 +1100 (EST)
Date: Wed, 2 Jan 2008 16:25:32 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] therm_pm72: suppress some compile warnings
Message-Id: <20080102162532.38d9c1e1.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We don't really care if any of these calls to device_create_file fails,
so just issue warnings in that case.

drivers/macintosh/therm_pm72.c: In function 'init_cpu_state':
drivers/macintosh/therm_pm72.c:1185: warning: ignoring return value of 'device_create_file', declared with attribute warn_unused_result
drivers/macintosh/therm_pm72.c:1186: warning: ignoring return value of 'device_create_file', declared with attribute warn_unused_result
drivers/macintosh/therm_pm72.c:1187: warning: ignoring return value of 'device_create_file', declared with attribute warn_unused_result
drivers/macintosh/therm_pm72.c:1188: warning: ignoring return value of 'device_create_file', declared with attribute warn_unused_result
drivers/macintosh/therm_pm72.c:1189: warning: ignoring return value of 'device_create_file', declared with attribute warn_unused_result
drivers/macintosh/therm_pm72.c:1191: warning: ignoring return value of 'device_create_file', declared with attribute warn_unused_result
drivers/macintosh/therm_pm72.c:1192: warning: ignoring return value of 'device_create_file', declared with attribute warn_unused_result
drivers/macintosh/therm_pm72.c:1193: warning: ignoring return value of 'device_create_file', declared with attribute warn_unused_result
drivers/macintosh/therm_pm72.c:1194: warning: ignoring return value of 'device_create_file', declared with attribute warn_unused_result
drivers/macintosh/therm_pm72.c:1195: warning: ignoring return value of 'device_create_file', declared with attribute warn_unused_result
drivers/macintosh/therm_pm72.c: In function 'init_backside_state':
drivers/macintosh/therm_pm72.c:1383: warning: ignoring return value of 'device_create_file', declared with attribute warn_unused_result
drivers/macintosh/therm_pm72.c:1384: warning: ignoring return value of 'device_create_file', declared with attribute warn_unused_result
drivers/macintosh/therm_pm72.c: In function 'init_drives_state':
drivers/macintosh/therm_pm72.c:1503: warning: ignoring return value of 'device_create_file', declared with attribute warn_unused_result
drivers/macintosh/therm_pm72.c:1504: warning: ignoring return value of 'device_create_file', declared with attribute warn_unused_result
drivers/macintosh/therm_pm72.c: In function 'init_dimms_state':
drivers/macintosh/therm_pm72.c:1625: warning: ignoring return value of 'device_create_file', declared with attribute warn_unused_result
drivers/macintosh/therm_pm72.c: In function 'init_slots_state':
drivers/macintosh/therm_pm72.c:1743: warning: ignoring return value of 'device_create_file', declared with attribute warn_unused_result
drivers/macintosh/therm_pm72.c:1744: warning: ignoring return value of 'device_create_file', declared with attribute warn_unused_result

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/macintosh/therm_pm72.c |   55 +++++++++++++++++++++++++++------------
 1 files changed, 38 insertions(+), 17 deletions(-)

diff --git a/drivers/macintosh/therm_pm72.c b/drivers/macintosh/therm_pm72.c
index 6fadc9a..1e0a69a 100644
--- a/drivers/macintosh/therm_pm72.c
+++ b/drivers/macintosh/therm_pm72.c
@@ -1157,6 +1157,8 @@ static void do_monitor_cpu_rack(struct cpu_pid_state *state)
  */
 static int init_cpu_state(struct cpu_pid_state *state, int index)
 {
+	int err;
+
 	state->index = index;
 	state->first = 1;
 	state->rpm = (cpu_pid_type == CPU_PID_TYPE_RACKMAC) ? 4000 : 1000;
@@ -1182,18 +1184,21 @@ static int init_cpu_state(struct cpu_pid_state *state, int index)
 	DBG("CPU %d Using %d power history entries\n", index, state->count_power);
 
 	if (index == 0) {
-		device_create_file(&of_dev->dev, &dev_attr_cpu0_temperature);
-		device_create_file(&of_dev->dev, &dev_attr_cpu0_voltage);
-		device_create_file(&of_dev->dev, &dev_attr_cpu0_current);
-		device_create_file(&of_dev->dev, &dev_attr_cpu0_exhaust_fan_rpm);
-		device_create_file(&of_dev->dev, &dev_attr_cpu0_intake_fan_rpm);
+		err = device_create_file(&of_dev->dev, &dev_attr_cpu0_temperature);
+		err |= device_create_file(&of_dev->dev, &dev_attr_cpu0_voltage);
+		err |= device_create_file(&of_dev->dev, &dev_attr_cpu0_current);
+		err |= device_create_file(&of_dev->dev, &dev_attr_cpu0_exhaust_fan_rpm);
+		err |= device_create_file(&of_dev->dev, &dev_attr_cpu0_intake_fan_rpm);
 	} else {
-		device_create_file(&of_dev->dev, &dev_attr_cpu1_temperature);
-		device_create_file(&of_dev->dev, &dev_attr_cpu1_voltage);
-		device_create_file(&of_dev->dev, &dev_attr_cpu1_current);
-		device_create_file(&of_dev->dev, &dev_attr_cpu1_exhaust_fan_rpm);
-		device_create_file(&of_dev->dev, &dev_attr_cpu1_intake_fan_rpm);
+		err = device_create_file(&of_dev->dev, &dev_attr_cpu1_temperature);
+		err |= device_create_file(&of_dev->dev, &dev_attr_cpu1_voltage);
+		err |= device_create_file(&of_dev->dev, &dev_attr_cpu1_current);
+		err |= device_create_file(&of_dev->dev, &dev_attr_cpu1_exhaust_fan_rpm);
+		err |= device_create_file(&of_dev->dev, &dev_attr_cpu1_intake_fan_rpm);
 	}
+	if (err)
+		printk(KERN_WARNING "Failed to create some of the atribute"
+			"files for CPU %d\n", index);
 
 	return 0;
  fail:
@@ -1329,6 +1334,7 @@ static int init_backside_state(struct backside_pid_state *state)
 {
 	struct device_node *u3;
 	int u3h = 1; /* conservative by default */
+	int err;
 
 	/*
 	 * There are different PID params for machines with U3 and machines
@@ -1380,8 +1386,11 @@ static int init_backside_state(struct backside_pid_state *state)
 	if (state->monitor == NULL)
 		return -ENODEV;
 
-	device_create_file(&of_dev->dev, &dev_attr_backside_temperature);
-	device_create_file(&of_dev->dev, &dev_attr_backside_fan_pwm);
+	err = device_create_file(&of_dev->dev, &dev_attr_backside_temperature);
+	err |= device_create_file(&of_dev->dev, &dev_attr_backside_fan_pwm);
+	if (err)
+		printk(KERN_WARNING "Failed to create attribute file(s)"
+			" for backside fan\n");
 
 	return 0;
 }
@@ -1492,6 +1501,8 @@ static void do_monitor_drives(struct drives_pid_state *state)
  */
 static int init_drives_state(struct drives_pid_state *state)
 {
+	int err;
+
 	state->ticks = 1;
 	state->first = 1;
 	state->rpm = 1000;
@@ -1500,8 +1511,11 @@ static int init_drives_state(struct drives_pid_state *state)
 	if (state->monitor == NULL)
 		return -ENODEV;
 
-	device_create_file(&of_dev->dev, &dev_attr_drives_temperature);
-	device_create_file(&of_dev->dev, &dev_attr_drives_fan_rpm);
+	err = device_create_file(&of_dev->dev, &dev_attr_drives_temperature);
+	err |= device_create_file(&of_dev->dev, &dev_attr_drives_fan_rpm);
+	if (err)
+		printk(KERN_WARNING "Failed to create attribute file(s)"
+			" for drives bay fan\n");
 
 	return 0;
 }
@@ -1622,7 +1636,9 @@ static int init_dimms_state(struct dimm_pid_state *state)
 	if (state->monitor == NULL)
 		return -ENODEV;
 
-       	device_create_file(&of_dev->dev, &dev_attr_dimms_temperature);
+	if (device_create_file(&of_dev->dev, &dev_attr_dimms_temperature))
+		printk(KERN_WARNING "Failed to create attribute file"
+			" for DIMM temperature\n");
 
 	return 0;
 }
@@ -1732,6 +1748,8 @@ static void do_monitor_slots(struct slots_pid_state *state)
  */
 static int init_slots_state(struct slots_pid_state *state)
 {
+	int err;
+
 	state->ticks = 1;
 	state->first = 1;
 	state->pwm = 50;
@@ -1740,8 +1758,11 @@ static int init_slots_state(struct slots_pid_state *state)
 	if (state->monitor == NULL)
 		return -ENODEV;
 
-	device_create_file(&of_dev->dev, &dev_attr_slots_temperature);
-	device_create_file(&of_dev->dev, &dev_attr_slots_fan_pwm);
+	err = device_create_file(&of_dev->dev, &dev_attr_slots_temperature);
+	err |= device_create_file(&of_dev->dev, &dev_attr_slots_fan_pwm);
+	if (err)
+		printk(KERN_WARNING "Failed to create attribute file(s)"
+			" for slots bay fan\n");
 
 	return 0;
 }
-- 
1.5.3.7

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

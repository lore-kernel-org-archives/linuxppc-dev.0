Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EA16AB7069
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2012 19:03:52 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@kernel.crashing.org>;
 Thu, 19 Apr 2012 08:14:50 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q3J8DEd0458898
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2012 18:13:14 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q3J8JnJn008301
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2012 18:19:49 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 10/15] powerpc/windfarm: Add useful accessors
Date: Thu, 19 Apr 2012 18:16:51 +1000
Message-Id: <1334823416-9138-11-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1334823416-9138-1-git-send-email-benh@kernel.crashing.org>
References: <1334823416-9138-1-git-send-email-benh@kernel.crashing.org>
Cc: khali@linux-fr.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Makes the code more readable

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/macintosh/windfarm.h      |   25 +++++++++++++++++++++++++
 drivers/macintosh/windfarm_pm81.c |   25 ++++++++++++-------------
 drivers/macintosh/windfarm_pm91.c |   33 +++++++++++++++------------------
 3 files changed, 52 insertions(+), 31 deletions(-)

diff --git a/drivers/macintosh/windfarm.h b/drivers/macintosh/windfarm.h
index 3ef192a..a9e385e 100644
--- a/drivers/macintosh/windfarm.h
+++ b/drivers/macintosh/windfarm.h
@@ -72,6 +72,26 @@ static inline int wf_control_set_min(struct wf_control *ct)
 	return ct->ops->set_value(ct, vmin);
 }
 
+static inline int wf_control_set(struct wf_control *ct, s32 val)
+{
+	return ct->ops->set_value(ct, val);
+}
+
+static inline int wf_control_get(struct wf_control *ct, s32 *val)
+{
+	return ct->ops->get_value(ct, val);
+}
+
+static inline s32 wf_control_get_min(struct wf_control *ct)
+{
+	return ct->ops->get_min(ct);
+}
+
+static inline s32 wf_control_get_max(struct wf_control *ct)
+{
+	return ct->ops->get_max(ct);
+}
+
 /*
  * Sensor objects
  */
@@ -100,6 +120,11 @@ extern struct wf_sensor * wf_find_sensor(const char *name);
 extern int wf_get_sensor(struct wf_sensor *sr);
 extern void wf_put_sensor(struct wf_sensor *sr);
 
+static inline int wf_sensor_get(struct wf_sensor *sr, s32 *val)
+{
+	return sr->ops->get_value(sr, val);
+}
+
 /* For use by clients. Note that we are a bit racy here since
  * notifier_block doesn't have a module owner field. I may fix
  * it one day ...
diff --git a/drivers/macintosh/windfarm_pm81.c b/drivers/macintosh/windfarm_pm81.c
index fc13d0f..990c876 100644
--- a/drivers/macintosh/windfarm_pm81.c
+++ b/drivers/macintosh/windfarm_pm81.c
@@ -302,13 +302,13 @@ static void wf_smu_create_sys_fans(void)
 	pid_param.interval = WF_SMU_SYS_FANS_INTERVAL;
 	pid_param.history_len = WF_SMU_SYS_FANS_HISTORY_SIZE;
 	pid_param.itarget = param->itarget;
-	pid_param.min = fan_system->ops->get_min(fan_system);
-	pid_param.max = fan_system->ops->get_max(fan_system);
+	pid_param.min = wf_control_get_min(fan_system);
+	pid_param.max = wf_control_get_max(fan_system);
 	if (fan_hd) {
 		pid_param.min =
-			max(pid_param.min,fan_hd->ops->get_min(fan_hd));
+			max(pid_param.min, wf_control_get_min(fan_hd));
 		pid_param.max =
-			min(pid_param.max,fan_hd->ops->get_max(fan_hd));
+			min(pid_param.max, wf_control_get_max(fan_hd));
 	}
 	wf_pid_init(&wf_smu_sys_fans->pid, &pid_param);
 
@@ -337,7 +337,7 @@ static void wf_smu_sys_fans_tick(struct wf_smu_sys_fans_state *st)
 	}
 	st->ticks = WF_SMU_SYS_FANS_INTERVAL;
 
-	rc = sensor_hd_temp->ops->get_value(sensor_hd_temp, &temp);
+	rc = wf_sensor_get(sensor_hd_temp, &temp);
 	if (rc) {
 		printk(KERN_WARNING "windfarm: HD temp sensor error %d\n",
 		       rc);
@@ -373,7 +373,7 @@ static void wf_smu_sys_fans_tick(struct wf_smu_sys_fans_state *st)
 	st->hd_setpoint = new_setpoint;
  readjust:
 	if (fan_system && wf_smu_failure_state == 0) {
-		rc = fan_system->ops->set_value(fan_system, st->sys_setpoint);
+		rc = wf_control_set(fan_system, st->sys_setpoint);
 		if (rc) {
 			printk(KERN_WARNING "windfarm: Sys fan error %d\n",
 			       rc);
@@ -381,7 +381,7 @@ static void wf_smu_sys_fans_tick(struct wf_smu_sys_fans_state *st)
 		}
 	}
 	if (fan_hd && wf_smu_failure_state == 0) {
-		rc = fan_hd->ops->set_value(fan_hd, st->hd_setpoint);
+		rc = wf_control_set(fan_hd, st->hd_setpoint);
 		if (rc) {
 			printk(KERN_WARNING "windfarm: HD fan error %d\n",
 			       rc);
@@ -447,8 +447,8 @@ static void wf_smu_create_cpu_fans(void)
 	pid_param.ttarget = tmax - tdelta;
 	pid_param.pmaxadj = maxpow - powadj;
 
-	pid_param.min = fan_cpu_main->ops->get_min(fan_cpu_main);
-	pid_param.max = fan_cpu_main->ops->get_max(fan_cpu_main);
+	pid_param.min = wf_control_get_min(fan_cpu_main);
+	pid_param.max = wf_control_get_max(fan_cpu_main);
 
 	wf_cpu_pid_init(&wf_smu_cpu_fans->pid, &pid_param);
 
@@ -481,7 +481,7 @@ static void wf_smu_cpu_fans_tick(struct wf_smu_cpu_fans_state *st)
 	}
 	st->ticks = WF_SMU_CPU_FANS_INTERVAL;
 
-	rc = sensor_cpu_temp->ops->get_value(sensor_cpu_temp, &temp);
+	rc = wf_sensor_get(sensor_cpu_temp, &temp);
 	if (rc) {
 		printk(KERN_WARNING "windfarm: CPU temp sensor error %d\n",
 		       rc);
@@ -489,7 +489,7 @@ static void wf_smu_cpu_fans_tick(struct wf_smu_cpu_fans_state *st)
 		return;
 	}
 
-	rc = sensor_cpu_power->ops->get_value(sensor_cpu_power, &power);
+	rc = wf_sensor_get(sensor_cpu_power, &power);
 	if (rc) {
 		printk(KERN_WARNING "windfarm: CPU power sensor error %d\n",
 		       rc);
@@ -525,8 +525,7 @@ static void wf_smu_cpu_fans_tick(struct wf_smu_cpu_fans_state *st)
 	st->cpu_setpoint = new_setpoint;
  readjust:
 	if (fan_cpu_main && wf_smu_failure_state == 0) {
-		rc = fan_cpu_main->ops->set_value(fan_cpu_main,
-						  st->cpu_setpoint);
+		rc = wf_control_set(fan_cpu_main, st->cpu_setpoint);
 		if (rc) {
 			printk(KERN_WARNING "windfarm: CPU main fan"
 			       " error %d\n", rc);
diff --git a/drivers/macintosh/windfarm_pm91.c b/drivers/macintosh/windfarm_pm91.c
index a9430ed..e18002b 100644
--- a/drivers/macintosh/windfarm_pm91.c
+++ b/drivers/macintosh/windfarm_pm91.c
@@ -192,8 +192,8 @@ static void wf_smu_create_cpu_fans(void)
 	pid_param.ttarget = tmax - tdelta;
 	pid_param.pmaxadj = maxpow - powadj;
 
-	pid_param.min = fan_cpu_main->ops->get_min(fan_cpu_main);
-	pid_param.max = fan_cpu_main->ops->get_max(fan_cpu_main);
+	pid_param.min = wf_control_get_min(fan_cpu_main);
+	pid_param.max = wf_control_get_max(fan_cpu_main);
 
 	wf_cpu_pid_init(&wf_smu_cpu_fans->pid, &pid_param);
 
@@ -226,7 +226,7 @@ static void wf_smu_cpu_fans_tick(struct wf_smu_cpu_fans_state *st)
 	}
 	st->ticks = WF_SMU_CPU_FANS_INTERVAL;
 
-	rc = sensor_cpu_temp->ops->get_value(sensor_cpu_temp, &temp);
+	rc = wf_sensor_get(sensor_cpu_temp, &temp);
 	if (rc) {
 		printk(KERN_WARNING "windfarm: CPU temp sensor error %d\n",
 		       rc);
@@ -234,7 +234,7 @@ static void wf_smu_cpu_fans_tick(struct wf_smu_cpu_fans_state *st)
 		return;
 	}
 
-	rc = sensor_cpu_power->ops->get_value(sensor_cpu_power, &power);
+	rc = wf_sensor_get(&sensor_cpu_power, &power);
 	if (rc) {
 		printk(KERN_WARNING "windfarm: CPU power sensor error %d\n",
 		       rc);
@@ -261,8 +261,7 @@ static void wf_smu_cpu_fans_tick(struct wf_smu_cpu_fans_state *st)
 	st->cpu_setpoint = new_setpoint;
  readjust:
 	if (fan_cpu_main && wf_smu_failure_state == 0) {
-		rc = fan_cpu_main->ops->set_value(fan_cpu_main,
-						  st->cpu_setpoint);
+		rc = wf_control_set(fan_cpu_main, st->cpu_setpoint);
 		if (rc) {
 			printk(KERN_WARNING "windfarm: CPU main fan"
 			       " error %d\n", rc);
@@ -270,8 +269,7 @@ static void wf_smu_cpu_fans_tick(struct wf_smu_cpu_fans_state *st)
 		}
 	}
 	if (fan_cpu_second && wf_smu_failure_state == 0) {
-		rc = fan_cpu_second->ops->set_value(fan_cpu_second,
-						    st->cpu_setpoint);
+		rc = wf_control_set(fan_cpu_second, st->cpu_setpoint);
 		if (rc) {
 			printk(KERN_WARNING "windfarm: CPU second fan"
 			       " error %d\n", rc);
@@ -279,8 +277,7 @@ static void wf_smu_cpu_fans_tick(struct wf_smu_cpu_fans_state *st)
 		}
 	}
 	if (fan_cpu_third && wf_smu_failure_state == 0) {
-		rc = fan_cpu_main->ops->set_value(fan_cpu_third,
-						  st->cpu_setpoint);
+		rc = wf_control_set(fan_cpu_third, st->cpu_setpoint);
 		if (rc) {
 			printk(KERN_WARNING "windfarm: CPU third fan"
 			       " error %d\n", rc);
@@ -312,8 +309,8 @@ static void wf_smu_create_drive_fans(void)
 
 	/* Fill PID params */
 	param.additive = (fan_hd->type == WF_CONTROL_RPM_FAN);
-	param.min = fan_hd->ops->get_min(fan_hd);
-	param.max = fan_hd->ops->get_max(fan_hd);
+	param.min = wf_control_get_min(fan_hd);
+	param.max = wf_control_get_max(fan_hd);
 	wf_pid_init(&wf_smu_drive_fans->pid, &param);
 
 	DBG("wf: Drive Fan control initialized.\n");
@@ -338,7 +335,7 @@ static void wf_smu_drive_fans_tick(struct wf_smu_drive_fans_state *st)
 	}
 	st->ticks = st->pid.param.interval;
 
-	rc = sensor_hd_temp->ops->get_value(sensor_hd_temp, &temp);
+	rc = wf_sensor_get(sensor_hd_temp, &temp);
 	if (rc) {
 		printk(KERN_WARNING "windfarm: HD temp sensor error %d\n",
 		       rc);
@@ -361,7 +358,7 @@ static void wf_smu_drive_fans_tick(struct wf_smu_drive_fans_state *st)
 	st->setpoint = new_setpoint;
  readjust:
 	if (fan_hd && wf_smu_failure_state == 0) {
-		rc = fan_hd->ops->set_value(fan_hd, st->setpoint);
+		rc = wf_control_set(fan_hd, st->setpoint);
 		if (rc) {
 			printk(KERN_WARNING "windfarm: HD fan error %d\n",
 			       rc);
@@ -393,8 +390,8 @@ static void wf_smu_create_slots_fans(void)
 
 	/* Fill PID params */
 	param.additive = (fan_slots->type == WF_CONTROL_RPM_FAN);
-	param.min = fan_slots->ops->get_min(fan_slots);
-	param.max = fan_slots->ops->get_max(fan_slots);
+	param.min = wf_control_get_min(fan_slots);
+	param.max = wf_control_get_max(fan_slots);
 	wf_pid_init(&wf_smu_slots_fans->pid, &param);
 
 	DBG("wf: Slots Fan control initialized.\n");
@@ -419,7 +416,7 @@ static void wf_smu_slots_fans_tick(struct wf_smu_slots_fans_state *st)
 	}
 	st->ticks = st->pid.param.interval;
 
-	rc = sensor_slots_power->ops->get_value(sensor_slots_power, &power);
+	rc = wf_sensor_get(sensor_slots_power, &power);
 	if (rc) {
 		printk(KERN_WARNING "windfarm: Slots power sensor error %d\n",
 		       rc);
@@ -444,7 +441,7 @@ static void wf_smu_slots_fans_tick(struct wf_smu_slots_fans_state *st)
 	st->setpoint = new_setpoint;
  readjust:
 	if (fan_slots && wf_smu_failure_state == 0) {
-		rc = fan_slots->ops->set_value(fan_slots, st->setpoint);
+		rc = wf_control_set(fan_slots, st->setpoint);
 		if (rc) {
 			printk(KERN_WARNING "windfarm: Slots fan error %d\n",
 			       rc);
-- 
1.7.9.5

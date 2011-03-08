Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BD9F8B6EF7
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Mar 2011 17:37:40 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp01.au.ibm.com (8.14.4/8.13.1) with ESMTP id p286XsUK024961
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:33:54 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p286beca2367598
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:37:40 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p286bdKE005187
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:37:39 +1100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 12/18] powerpc/pmac: Rename cpu_state in therm_pm72 to avoid
	collision
Date: Tue,  8 Mar 2011 17:37:24 +1100
Message-Id: <1299566250-10516-13-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1299566250-10516-1-git-send-email-benh@kernel.crashing.org>
References: <1299566250-10516-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This collides with the cpu_state in our SMP code, use processor_state
instead.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/macintosh/therm_pm72.c |   60 ++++++++++++++++++++--------------------
 1 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/macintosh/therm_pm72.c b/drivers/macintosh/therm_pm72.c
index f3a29f2..02b4f13 100644
--- a/drivers/macintosh/therm_pm72.c
+++ b/drivers/macintosh/therm_pm72.c
@@ -153,7 +153,7 @@ static struct i2c_adapter *		u3_0;
 static struct i2c_adapter *		u3_1;
 static struct i2c_adapter *		k2;
 static struct i2c_client *		fcu;
-static struct cpu_pid_state		cpu_state[2];
+static struct cpu_pid_state		processor_state[2];
 static struct basckside_pid_params	backside_params;
 static struct backside_pid_state	backside_state;
 static struct drives_pid_state		drives_state;
@@ -664,8 +664,8 @@ static int read_eeprom(int cpu, struct mpu_data *out)
 
 static void fetch_cpu_pumps_minmax(void)
 {
-	struct cpu_pid_state *state0 = &cpu_state[0];
-	struct cpu_pid_state *state1 = &cpu_state[1];
+	struct cpu_pid_state *state0 = &processor_state[0];
+	struct cpu_pid_state *state1 = &processor_state[1];
 	u16 pump_min = 0, pump_max = 0xffff;
 	u16 tmp[4];
 
@@ -717,17 +717,17 @@ static ssize_t show_##name(struct device *dev, struct device_attribute *attr, ch
 	return sprintf(buf, "%d", data);			\
 }
 
-BUILD_SHOW_FUNC_FIX(cpu0_temperature, cpu_state[0].last_temp)
-BUILD_SHOW_FUNC_FIX(cpu0_voltage, cpu_state[0].voltage)
-BUILD_SHOW_FUNC_FIX(cpu0_current, cpu_state[0].current_a)
-BUILD_SHOW_FUNC_INT(cpu0_exhaust_fan_rpm, cpu_state[0].rpm)
-BUILD_SHOW_FUNC_INT(cpu0_intake_fan_rpm, cpu_state[0].intake_rpm)
+BUILD_SHOW_FUNC_FIX(cpu0_temperature, processor_state[0].last_temp)
+BUILD_SHOW_FUNC_FIX(cpu0_voltage, processor_state[0].voltage)
+BUILD_SHOW_FUNC_FIX(cpu0_current, processor_state[0].current_a)
+BUILD_SHOW_FUNC_INT(cpu0_exhaust_fan_rpm, processor_state[0].rpm)
+BUILD_SHOW_FUNC_INT(cpu0_intake_fan_rpm, processor_state[0].intake_rpm)
 
-BUILD_SHOW_FUNC_FIX(cpu1_temperature, cpu_state[1].last_temp)
-BUILD_SHOW_FUNC_FIX(cpu1_voltage, cpu_state[1].voltage)
-BUILD_SHOW_FUNC_FIX(cpu1_current, cpu_state[1].current_a)
-BUILD_SHOW_FUNC_INT(cpu1_exhaust_fan_rpm, cpu_state[1].rpm)
-BUILD_SHOW_FUNC_INT(cpu1_intake_fan_rpm, cpu_state[1].intake_rpm)
+BUILD_SHOW_FUNC_FIX(cpu1_temperature, processor_state[1].last_temp)
+BUILD_SHOW_FUNC_FIX(cpu1_voltage, processor_state[1].voltage)
+BUILD_SHOW_FUNC_FIX(cpu1_current, processor_state[1].current_a)
+BUILD_SHOW_FUNC_INT(cpu1_exhaust_fan_rpm, processor_state[1].rpm)
+BUILD_SHOW_FUNC_INT(cpu1_intake_fan_rpm, processor_state[1].intake_rpm)
 
 BUILD_SHOW_FUNC_FIX(backside_temperature, backside_state.last_temp)
 BUILD_SHOW_FUNC_INT(backside_fan_pwm, backside_state.pwm)
@@ -919,8 +919,8 @@ static void do_cpu_pid(struct cpu_pid_state *state, s32 temp, s32 power)
 
 static void do_monitor_cpu_combined(void)
 {
-	struct cpu_pid_state *state0 = &cpu_state[0];
-	struct cpu_pid_state *state1 = &cpu_state[1];
+	struct cpu_pid_state *state0 = &processor_state[0];
+	struct cpu_pid_state *state1 = &processor_state[1];
 	s32 temp0, power0, temp1, power1;
 	s32 temp_combi, power_combi;
 	int rc, intake, pump;
@@ -1150,7 +1150,7 @@ static void do_monitor_cpu_rack(struct cpu_pid_state *state)
 /*
  * Initialize the state structure for one CPU control loop
  */
-static int init_cpu_state(struct cpu_pid_state *state, int index)
+static int init_processor_state(struct cpu_pid_state *state, int index)
 {
 	int err;
 
@@ -1205,7 +1205,7 @@ static int init_cpu_state(struct cpu_pid_state *state, int index)
 /*
  * Dispose of the state data for one CPU control loop
  */
-static void dispose_cpu_state(struct cpu_pid_state *state)
+static void dispose_processor_state(struct cpu_pid_state *state)
 {
 	if (state->monitor == NULL)
 		return;
@@ -1804,9 +1804,9 @@ static int main_control_loop(void *x)
 		set_pwm_fan(SLOTS_FAN_PWM_INDEX, SLOTS_FAN_DEFAULT_PWM);
 
 	/* Initialize ADCs */
-	initialize_adc(&cpu_state[0]);
-	if (cpu_state[1].monitor != NULL)
-		initialize_adc(&cpu_state[1]);
+	initialize_adc(&processor_state[0]);
+	if (processor_state[1].monitor != NULL)
+		initialize_adc(&processor_state[1]);
 
 	fcu_tickle_ticks = FCU_TICKLE_TICKS;
 
@@ -1833,14 +1833,14 @@ static int main_control_loop(void *x)
 		if (cpu_pid_type == CPU_PID_TYPE_COMBINED)
 			do_monitor_cpu_combined();
 		else if (cpu_pid_type == CPU_PID_TYPE_RACKMAC) {
-			do_monitor_cpu_rack(&cpu_state[0]);
-			if (cpu_state[1].monitor != NULL)
-				do_monitor_cpu_rack(&cpu_state[1]);
+			do_monitor_cpu_rack(&processor_state[0]);
+			if (processor_state[1].monitor != NULL)
+				do_monitor_cpu_rack(&processor_state[1]);
 			// better deal with UP
 		} else {
-			do_monitor_cpu_split(&cpu_state[0]);
-			if (cpu_state[1].monitor != NULL)
-				do_monitor_cpu_split(&cpu_state[1]);
+			do_monitor_cpu_split(&processor_state[0]);
+			if (processor_state[1].monitor != NULL)
+				do_monitor_cpu_split(&processor_state[1]);
 			// better deal with UP
 		}
 		/* Then, the rest */
@@ -1885,8 +1885,8 @@ static int main_control_loop(void *x)
  */
 static void dispose_control_loops(void)
 {
-	dispose_cpu_state(&cpu_state[0]);
-	dispose_cpu_state(&cpu_state[1]);
+	dispose_processor_state(&processor_state[0]);
+	dispose_processor_state(&processor_state[1]);
 	dispose_backside_state(&backside_state);
 	dispose_drives_state(&drives_state);
 	dispose_slots_state(&slots_state);
@@ -1928,12 +1928,12 @@ static int create_control_loops(void)
 	/* Create control loops for everything. If any fail, everything
 	 * fails
 	 */
-	if (init_cpu_state(&cpu_state[0], 0))
+	if (init_processor_state(&processor_state[0], 0))
 		goto fail;
 	if (cpu_pid_type == CPU_PID_TYPE_COMBINED)
 		fetch_cpu_pumps_minmax();
 
-	if (cpu_count > 1 && init_cpu_state(&cpu_state[1], 1))
+	if (cpu_count > 1 && init_processor_state(&processor_state[1], 1))
 		goto fail;
 	if (init_backside_state(&backside_state))
 		goto fail;
-- 
1.7.1

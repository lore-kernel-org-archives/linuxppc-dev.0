Return-Path: <gustavo@embeddedor.com>
Received: from gateway23.websitewelcome.com (gateway23.websitewelcome.com
 [192.185.50.185])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zR7n438TMzDr4f
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jan 2018 13:06:00 +1100 (AEDT)
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
 by gateway23.websitewelcome.com (Postfix) with ESMTP id D9F228DE6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 19:42:29 -0600 (CST)
Date: Tue, 23 Jan 2018 19:42:28 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Colin Leroy <colin@colino.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] macintosh: change some data types from int to bool
Message-ID: <20180124014228.GA26899@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Change the data type of the following variables from int to bool
across all macintosh drivers:

started
slots_started
pm121_started
wf_smu_started

Some of these issues were detected with the help of Coccinelle.

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/macintosh/therm_adt746x.c  | 4 ++--
 drivers/macintosh/windfarm_pm112.c | 8 ++++----
 drivers/macintosh/windfarm_pm121.c | 5 +++--
 drivers/macintosh/windfarm_pm72.c  | 2 +-
 drivers/macintosh/windfarm_pm81.c  | 5 +++--
 drivers/macintosh/windfarm_pm91.c  | 5 +++--
 drivers/macintosh/windfarm_rm31.c  | 2 +-
 7 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/macintosh/therm_adt746x.c b/drivers/macintosh/therm_adt746x.c
index f433521..d7cd5af 100644
--- a/drivers/macintosh/therm_adt746x.c
+++ b/drivers/macintosh/therm_adt746x.c
@@ -230,7 +230,7 @@ static void update_fans_speed (struct thermostat *th)
 
 	/* we don't care about local sensor, so we start at sensor 1 */
 	for (i = 1; i < 3; i++) {
-		int started = 0;
+		bool started = false;
 		int fan_number = (th->type == ADT7460 && i == 2);
 		int var = th->temps[i] - th->limits[i];
 
@@ -243,7 +243,7 @@ static void update_fans_speed (struct thermostat *th)
 			if (abs(var - th->last_var[fan_number]) < 2)
 				continue;
 
-			started = 1;
+			started = true;
 			new_speed = fan_speed + ((var-1)*step);
 
 			if (new_speed < fan_speed)
diff --git a/drivers/macintosh/windfarm_pm112.c b/drivers/macintosh/windfarm_pm112.c
index 96d16fc..fec91db 100644
--- a/drivers/macintosh/windfarm_pm112.c
+++ b/drivers/macintosh/windfarm_pm112.c
@@ -96,14 +96,14 @@ static int cpu_last_target;
 static struct wf_pid_state backside_pid;
 static int backside_tick;
 static struct wf_pid_state slots_pid;
-static int slots_started;
+static bool slots_started;
 static struct wf_pid_state drive_bay_pid;
 static int drive_bay_tick;
 
 static int nr_cores;
 static int have_all_controls;
 static int have_all_sensors;
-static int started;
+static bool started;
 
 static int failure_state;
 #define FAILURE_SENSOR		1
@@ -462,7 +462,7 @@ static void slots_fan_tick(void)
 		/* first time; initialize things */
 		printk(KERN_INFO "windfarm: Slots control loop started.\n");
 		wf_pid_init(&slots_pid, &slots_param);
-		slots_started = 1;
+		slots_started = true;
 	}
 
 	err = slots_power->ops->get_value(slots_power, &power);
@@ -506,7 +506,7 @@ static void pm112_tick(void)
 	int i, last_failure;
 
 	if (!started) {
-		started = 1;
+		started = true;
 		printk(KERN_INFO "windfarm: CPUs control loops started.\n");
 		for (i = 0; i < nr_cores; ++i) {
 			if (create_cpu_loop(i) < 0) {
diff --git a/drivers/macintosh/windfarm_pm121.c b/drivers/macintosh/windfarm_pm121.c
index b350fb8..4d72d8f 100644
--- a/drivers/macintosh/windfarm_pm121.c
+++ b/drivers/macintosh/windfarm_pm121.c
@@ -246,7 +246,8 @@ enum {
 static struct wf_control *controls[N_CONTROLS] = {};
 
 /* Set to kick the control loop into life */
-static int pm121_all_controls_ok, pm121_all_sensors_ok, pm121_started;
+static int pm121_all_controls_ok, pm121_all_sensors_ok;
+static bool pm121_started;
 
 enum {
 	FAILURE_FAN		= 1 << 0,
@@ -806,7 +807,7 @@ static void pm121_tick(void)
 			pm121_create_sys_fans(i);
 
 		pm121_create_cpu_fans();
-		pm121_started = 1;
+		pm121_started = true;
 	}
 
 	/* skipping ticks */
diff --git a/drivers/macintosh/windfarm_pm72.c b/drivers/macintosh/windfarm_pm72.c
index e88cfb3..8330215 100644
--- a/drivers/macintosh/windfarm_pm72.c
+++ b/drivers/macintosh/windfarm_pm72.c
@@ -611,7 +611,7 @@ static void pm72_tick(void)
 	int i, last_failure;
 
 	if (!started) {
-		started = 1;
+		started = true;
 		printk(KERN_INFO "windfarm: CPUs control loops started.\n");
 		for (i = 0; i < nr_chips; ++i) {
 			if (cpu_setup_pid(i) < 0) {
diff --git a/drivers/macintosh/windfarm_pm81.c b/drivers/macintosh/windfarm_pm81.c
index 93faf29..d9ea455 100644
--- a/drivers/macintosh/windfarm_pm81.c
+++ b/drivers/macintosh/windfarm_pm81.c
@@ -140,7 +140,8 @@ static struct wf_control *fan_system;
 static struct wf_control *cpufreq_clamp;
 
 /* Set to kick the control loop into life */
-static int wf_smu_all_controls_ok, wf_smu_all_sensors_ok, wf_smu_started;
+static int wf_smu_all_controls_ok, wf_smu_all_sensors_ok;
+static bool wf_smu_started;
 
 /* Failure handling.. could be nicer */
 #define FAILURE_FAN		0x01
@@ -549,7 +550,7 @@ static void wf_smu_tick(void)
 		DBG("wf: creating control loops !\n");
 		wf_smu_create_sys_fans();
 		wf_smu_create_cpu_fans();
-		wf_smu_started = 1;
+		wf_smu_started = true;
 	}
 
 	/* Skipping ticks */
diff --git a/drivers/macintosh/windfarm_pm91.c b/drivers/macintosh/windfarm_pm91.c
index 81fdf40..7fd73dc 100644
--- a/drivers/macintosh/windfarm_pm91.c
+++ b/drivers/macintosh/windfarm_pm91.c
@@ -75,7 +75,8 @@ static struct wf_control *fan_slots;
 static struct wf_control *cpufreq_clamp;
 
 /* Set to kick the control loop into life */
-static int wf_smu_all_controls_ok, wf_smu_all_sensors_ok, wf_smu_started;
+static int wf_smu_all_controls_ok, wf_smu_all_sensors_ok;
+static bool wf_smu_started;
 static bool wf_smu_overtemp;
 
 /* Failure handling.. could be nicer */
@@ -467,7 +468,7 @@ static void wf_smu_tick(void)
 		wf_smu_create_drive_fans();
 		wf_smu_create_slots_fans();
 		wf_smu_create_cpu_fans();
-		wf_smu_started = 1;
+		wf_smu_started = true;
 	}
 
 	/* Skipping ticks */
diff --git a/drivers/macintosh/windfarm_rm31.c b/drivers/macintosh/windfarm_rm31.c
index a0cd9c7..9ce87cc 100644
--- a/drivers/macintosh/windfarm_rm31.c
+++ b/drivers/macintosh/windfarm_rm31.c
@@ -514,7 +514,7 @@ static void rm31_tick(void)
 	int i, last_failure;
 
 	if (!started) {
-		started = 1;
+		started = true;
 		printk(KERN_INFO "windfarm: CPUs control loops started.\n");
 		for (i = 0; i < nr_chips; ++i) {
 			if (cpu_setup_pid(i) < 0) {
-- 
2.7.4

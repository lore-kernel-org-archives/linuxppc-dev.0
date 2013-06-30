Return-Path: <aaro.koskinen@iki.fi>
Received: from filtteri2.pp.htv.fi (filtteri2.pp.htv.fi [213.243.153.185])
 by ozlabs.org (Postfix) with ESMTP id 54A5B2C023D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jul 2013 05:09:04 +1000 (EST)
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/windfarm: fix overtemperature clearing
Date: Sun, 30 Jun 2013 22:00:42 +0300
Message-Id: <1372618842-27429-1-git-send-email-aaro.koskinen@iki.fi>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With pm81/pm91/pm121, when the overtemperature state is entered, and
when it remains on after skipped ticks, the driver will try to leave
it too soon (immediately on the next tick). This is because the active
FAILURE_OVERTEMP state is not visible in "new_failure" variable of the
current tick. Furthermore, the driver will keep trying to clear condition
in subsequent ticks as FAILURE_OVERTEMP remains set in the "last_failure"
variable. These will start to trigger WARNINGS from windfarm core:

[  100.082735] windfarm: Clamping CPU frequency to minimum !
[  100.108132] windfarm: Overtemp condition detected !
[  101.952908] windfarm: Overtemp condition cleared !
[...]
[  102.980388] WARNING: at drivers/macintosh/windfarm_core.c:463
[...]
[  103.982227] WARNING: at drivers/macintosh/windfarm_core.c:463
[...]
[  105.030494] WARNING: at drivers/macintosh/windfarm_core.c:463
[...]
[  105.973666] WARNING: at drivers/macintosh/windfarm_core.c:463
[...]
[  106.977913] WARNING: at drivers/macintosh/windfarm_core.c:463

Fix by adding a helper global variable. We leave the overtemp state only
after all failure bits have been cleared.

I saw this error on iMac G5 iSight (pm121). Also pm81/pm91 are fixed
based on the observation that these are almost identical/copy-pasted code.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/macintosh/windfarm_pm121.c | 6 +++++-
 drivers/macintosh/windfarm_pm81.c  | 6 +++++-
 drivers/macintosh/windfarm_pm91.c  | 6 +++++-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/macintosh/windfarm_pm121.c b/drivers/macintosh/windfarm_pm121.c
index af605e9..7fe58b0 100644
--- a/drivers/macintosh/windfarm_pm121.c
+++ b/drivers/macintosh/windfarm_pm121.c
@@ -276,6 +276,7 @@ static const char *loop_names[N_LOOPS] = {
 
 static unsigned int pm121_failure_state;
 static int pm121_readjust, pm121_skipping;
+static bool pm121_overtemp;
 static s32 average_power;
 
 struct pm121_correction {
@@ -847,6 +848,7 @@ static void pm121_tick(void)
 	if (new_failure & FAILURE_OVERTEMP) {
 		wf_set_overtemp();
 		pm121_skipping = 2;
+		pm121_overtemp = true;
 	}
 
 	/* We only clear the overtemp condition if overtemp is cleared
@@ -855,8 +857,10 @@ static void pm121_tick(void)
 	 * the control loop levels, but we don't want to keep it clear
 	 * here in this case
 	 */
-	if (new_failure == 0 && last_failure & FAILURE_OVERTEMP)
+	if (!pm121_failure_state && pm121_overtemp) {
 		wf_clear_overtemp();
+		pm121_overtemp = false;
+	}
 }
 
 
diff --git a/drivers/macintosh/windfarm_pm81.c b/drivers/macintosh/windfarm_pm81.c
index f84933f..2a5e1b1 100644
--- a/drivers/macintosh/windfarm_pm81.c
+++ b/drivers/macintosh/windfarm_pm81.c
@@ -149,6 +149,7 @@ static int wf_smu_all_controls_ok, wf_smu_all_sensors_ok, wf_smu_started;
 
 static unsigned int wf_smu_failure_state;
 static int wf_smu_readjust, wf_smu_skipping;
+static bool wf_smu_overtemp;
 
 /*
  * ****** System Fans Control Loop ******
@@ -593,6 +594,7 @@ static void wf_smu_tick(void)
 	if (new_failure & FAILURE_OVERTEMP) {
 		wf_set_overtemp();
 		wf_smu_skipping = 2;
+		wf_smu_overtemp = true;
 	}
 
 	/* We only clear the overtemp condition if overtemp is cleared
@@ -601,8 +603,10 @@ static void wf_smu_tick(void)
 	 * the control loop levels, but we don't want to keep it clear
 	 * here in this case
 	 */
-	if (new_failure == 0 && last_failure & FAILURE_OVERTEMP)
+	if (!wf_smu_failure_state && wf_smu_overtemp) {
 		wf_clear_overtemp();
+		wf_smu_overtemp = false;
+	}
 }
 
 static void wf_smu_new_control(struct wf_control *ct)
diff --git a/drivers/macintosh/windfarm_pm91.c b/drivers/macintosh/windfarm_pm91.c
index 2eb484f..a8ac66c 100644
--- a/drivers/macintosh/windfarm_pm91.c
+++ b/drivers/macintosh/windfarm_pm91.c
@@ -76,6 +76,7 @@ static struct wf_control *cpufreq_clamp;
 
 /* Set to kick the control loop into life */
 static int wf_smu_all_controls_ok, wf_smu_all_sensors_ok, wf_smu_started;
+static bool wf_smu_overtemp;
 
 /* Failure handling.. could be nicer */
 #define FAILURE_FAN		0x01
@@ -517,6 +518,7 @@ static void wf_smu_tick(void)
 	if (new_failure & FAILURE_OVERTEMP) {
 		wf_set_overtemp();
 		wf_smu_skipping = 2;
+		wf_smu_overtemp = true;
 	}
 
 	/* We only clear the overtemp condition if overtemp is cleared
@@ -525,8 +527,10 @@ static void wf_smu_tick(void)
 	 * the control loop levels, but we don't want to keep it clear
 	 * here in this case
 	 */
-	if (new_failure == 0 && last_failure & FAILURE_OVERTEMP)
+	if (!wf_smu_failure_state && wf_smu_overtemp) {
 		wf_clear_overtemp();
+		wf_smu_overtemp = false;
+	}
 }
 
 
-- 
1.8.3.1

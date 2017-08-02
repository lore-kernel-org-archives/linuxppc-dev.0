Return-Path: <Julia.Lawall@lip6.fr>
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xN5qm5pghzDqfm
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 07:27:13 +1000 (AEST)
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/macintosh: constify wf_sensor_ops structures
Date: Wed,  2 Aug 2017 23:01:45 +0200
Message-Id: <1501707705-32425-1-git-send-email-Julia.Lawall@lip6.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The wf_sensor_ops structures are only stored in the ops field of a
wf_sensor structure, which is declared as const.  Thus the
wf_sensor_ops structures themselves can be const.

Done with the help of Coccinelle.

// <smpl>
@r disable optional_qualifier@
identifier i;
position p;
@@
static struct wf_sensor_ops i@p = { ... };

@ok1@
identifier r.i;
struct wf_sensor s;
position p;
@@
s.ops = &i@p

@ok2@
identifier r.i;
struct wf_sat_sensor s;
position p;
@@
s.sens.ops = &i@p

@bad@
position p != {r.p,ok1.p,ok2.p};
identifier r.i;
struct wf_sensor_ops e;
@@
e@i@p

@depends on !bad disable optional_qualifier@
identifier r.i;
@@
static
+const
 struct wf_sensor_ops i = { ... };
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/macintosh/windfarm_lm75_sensor.c    |    2 +-
 drivers/macintosh/windfarm_lm87_sensor.c    |    2 +-
 drivers/macintosh/windfarm_max6690_sensor.c |    2 +-
 drivers/macintosh/windfarm_smu_sat.c        |    2 +-
 drivers/macintosh/windfarm_smu_sensors.c    |   10 +++++-----
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/macintosh/windfarm_lm75_sensor.c b/drivers/macintosh/windfarm_lm75_sensor.c
index 590214b..6cdfe71 100644
--- a/drivers/macintosh/windfarm_lm75_sensor.c
+++ b/drivers/macintosh/windfarm_lm75_sensor.c
@@ -82,7 +82,7 @@ static void wf_lm75_release(struct wf_sensor *sr)
 	kfree(lm);
 }
 
-static struct wf_sensor_ops wf_lm75_ops = {
+static const struct wf_sensor_ops wf_lm75_ops = {
 	.get_value	= wf_lm75_get,
 	.release	= wf_lm75_release,
 	.owner		= THIS_MODULE,
diff --git a/drivers/macintosh/windfarm_lm87_sensor.c b/drivers/macintosh/windfarm_lm87_sensor.c
index c071aab..273d7d4 100644
--- a/drivers/macintosh/windfarm_lm87_sensor.c
+++ b/drivers/macintosh/windfarm_lm87_sensor.c
@@ -91,7 +91,7 @@ static void wf_lm87_release(struct wf_sensor *sr)
 	kfree(lm);
 }
 
-static struct wf_sensor_ops wf_lm87_ops = {
+static const struct wf_sensor_ops wf_lm87_ops = {
 	.get_value	= wf_lm87_get,
 	.release	= wf_lm87_release,
 	.owner		= THIS_MODULE,
diff --git a/drivers/macintosh/windfarm_max6690_sensor.c b/drivers/macintosh/windfarm_max6690_sensor.c
index 87e439b..6ad035e 100644
--- a/drivers/macintosh/windfarm_max6690_sensor.c
+++ b/drivers/macintosh/windfarm_max6690_sensor.c
@@ -55,7 +55,7 @@ static void wf_max6690_release(struct wf_sensor *sr)
 	kfree(max);
 }
 
-static struct wf_sensor_ops wf_max6690_ops = {
+static const struct wf_sensor_ops wf_max6690_ops = {
 	.get_value	= wf_max6690_get,
 	.release	= wf_max6690_release,
 	.owner		= THIS_MODULE,
diff --git a/drivers/macintosh/windfarm_smu_sat.c b/drivers/macintosh/windfarm_smu_sat.c
index ad6223e..5a58fc2 100644
--- a/drivers/macintosh/windfarm_smu_sat.c
+++ b/drivers/macintosh/windfarm_smu_sat.c
@@ -195,7 +195,7 @@ static void wf_sat_sensor_release(struct wf_sensor *sr)
 	kref_put(&sat->ref, wf_sat_release);
 }
 
-static struct wf_sensor_ops wf_sat_ops = {
+static const struct wf_sensor_ops wf_sat_ops = {
 	.get_value	= wf_sat_sensor_get,
 	.release	= wf_sat_sensor_release,
 	.owner		= THIS_MODULE,
diff --git a/drivers/macintosh/windfarm_smu_sensors.c b/drivers/macintosh/windfarm_smu_sensors.c
index 1cc4e49..172fd26 100644
--- a/drivers/macintosh/windfarm_smu_sensors.c
+++ b/drivers/macintosh/windfarm_smu_sensors.c
@@ -172,22 +172,22 @@ static int smu_slotspow_get(struct wf_sensor *sr, s32 *value)
 }
 
 
-static struct wf_sensor_ops smu_cputemp_ops = {
+static const struct wf_sensor_ops smu_cputemp_ops = {
 	.get_value	= smu_cputemp_get,
 	.release	= smu_ads_release,
 	.owner		= THIS_MODULE,
 };
-static struct wf_sensor_ops smu_cpuamp_ops = {
+static const struct wf_sensor_ops smu_cpuamp_ops = {
 	.get_value	= smu_cpuamp_get,
 	.release	= smu_ads_release,
 	.owner		= THIS_MODULE,
 };
-static struct wf_sensor_ops smu_cpuvolt_ops = {
+static const struct wf_sensor_ops smu_cpuvolt_ops = {
 	.get_value	= smu_cpuvolt_get,
 	.release	= smu_ads_release,
 	.owner		= THIS_MODULE,
 };
-static struct wf_sensor_ops smu_slotspow_ops = {
+static const struct wf_sensor_ops smu_slotspow_ops = {
 	.get_value	= smu_slotspow_get,
 	.release	= smu_ads_release,
 	.owner		= THIS_MODULE,
@@ -327,7 +327,7 @@ static int smu_cpu_power_get(struct wf_sensor *sr, s32 *value)
 	return 0;
 }
 
-static struct wf_sensor_ops smu_cpu_power_ops = {
+static const struct wf_sensor_ops smu_cpu_power_ops = {
 	.get_value	= smu_cpu_power_get,
 	.release	= smu_cpu_power_release,
 	.owner		= THIS_MODULE,

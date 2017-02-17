Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0166.hostedemail.com
 [216.40.44.166])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPkrb32xqzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 18:18:07 +1100 (AEDT)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave03.hostedemail.com (Postfix) with ESMTP id 64089290DC1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 07:12:56 +0000 (UTC)
From: Joe Perches <joe@perches.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 21/35] drivers/macintosh: Convert remaining uses of pr_warning
 to pr_warn
Date: Thu, 16 Feb 2017 23:11:34 -0800
Message-Id: <3b11f71725b81463e4aa4bad448b48ef9ebaa424.1487314667.git.joe@perches.com>
In-Reply-To: <cover.1487314666.git.joe@perches.com>
References: <cover.1487314666.git.joe@perches.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To enable eventual removal of pr_warning

This makes pr_warn use consistent for drivers/macintosh

Prior to this patch, there were 10 uses of pr_warning and
1 use of pr_warn in drivers/macintosh

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/macintosh/windfarm_fcu_controls.c |  5 ++---
 drivers/macintosh/windfarm_lm87_sensor.c  |  4 ++--
 drivers/macintosh/windfarm_pm72.c         | 22 +++++++++++-----------
 drivers/macintosh/windfarm_rm31.c         |  6 +++---
 4 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/macintosh/windfarm_fcu_controls.c b/drivers/macintosh/windfarm_fcu_controls.c
index 0226b796a21c..3d8d9eaf9b68 100644
--- a/drivers/macintosh/windfarm_fcu_controls.c
+++ b/drivers/macintosh/windfarm_fcu_controls.c
@@ -469,9 +469,8 @@ static void wf_fcu_lookup_fans(struct wf_fcu_priv *pv)
 			else
 				id = ((*reg) - 0x30) / 2;
 			if (id > 7) {
-				pr_warning("wf_fcu: Can't parse "
-				       "fan ID in device-tree for %s\n",
-					   np->full_name);
+				pr_warn("wf_fcu: Can't parse fan ID in device-tree for %s\n",
+					np->full_name);
 				break;
 			}
 			wf_fcu_add_fan(pv, name, type, id);
diff --git a/drivers/macintosh/windfarm_lm87_sensor.c b/drivers/macintosh/windfarm_lm87_sensor.c
index c071aab79dd1..93fb8660261d 100644
--- a/drivers/macintosh/windfarm_lm87_sensor.c
+++ b/drivers/macintosh/windfarm_lm87_sensor.c
@@ -126,8 +126,8 @@ static int wf_lm87_probe(struct i2c_client *client,
 		}
 	}
 	if (!name) {
-		pr_warning("wf_lm87: Unsupported sensor %s\n",
-			   client->dev.of_node->full_name);
+		pr_warn("wf_lm87: Unsupported sensor %s\n",
+			client->dev.of_node->full_name);
 		return -ENODEV;
 	}
 
diff --git a/drivers/macintosh/windfarm_pm72.c b/drivers/macintosh/windfarm_pm72.c
index e88cfb36a74d..1d3ac758a0c0 100644
--- a/drivers/macintosh/windfarm_pm72.c
+++ b/drivers/macintosh/windfarm_pm72.c
@@ -286,8 +286,8 @@ static void cpu_fans_tick_split(void)
 		/* Apply result directly to exhaust fan */
 		err = wf_control_set(cpu_rear_fans[cpu], sp->target);
 		if (err) {
-			pr_warning("wf_pm72: Fan %s reports error %d\n",
-			       cpu_rear_fans[cpu]->name, err);
+			pr_warn("wf_pm72: Fan %s reports error %d\n",
+				cpu_rear_fans[cpu]->name, err);
 			failure_state |= FAILURE_FAN;
 			break;
 		}
@@ -297,8 +297,8 @@ static void cpu_fans_tick_split(void)
 		DBG_LOTS("  CPU%d: intake = %d RPM\n", cpu, intake);
 		err = wf_control_set(cpu_front_fans[cpu], intake);
 		if (err) {
-			pr_warning("wf_pm72: Fan %s reports error %d\n",
-			       cpu_front_fans[cpu]->name, err);
+			pr_warn("wf_pm72: Fan %s reports error %d\n",
+				cpu_front_fans[cpu]->name, err);
 			failure_state |= FAILURE_FAN;
 			break;
 		}
@@ -368,22 +368,22 @@ static void cpu_fans_tick_combined(void)
 	for (cpu = 0; cpu < nr_chips; cpu++) {
 		err = wf_control_set(cpu_rear_fans[cpu], sp->target);
 		if (err) {
-			pr_warning("wf_pm72: Fan %s reports error %d\n",
-				   cpu_rear_fans[cpu]->name, err);
+			pr_warn("wf_pm72: Fan %s reports error %d\n",
+				cpu_rear_fans[cpu]->name, err);
 			failure_state |= FAILURE_FAN;
 		}
 		err = wf_control_set(cpu_front_fans[cpu], intake);
 		if (err) {
-			pr_warning("wf_pm72: Fan %s reports error %d\n",
-				   cpu_front_fans[cpu]->name, err);
+			pr_warn("wf_pm72: Fan %s reports error %d\n",
+				cpu_front_fans[cpu]->name, err);
 			failure_state |= FAILURE_FAN;
 		}
 		err = 0;
 		if (cpu_pumps[cpu])
 			err = wf_control_set(cpu_pumps[cpu], pump);
 		if (err) {
-			pr_warning("wf_pm72: Pump %s reports error %d\n",
-				   cpu_pumps[cpu]->name, err);
+			pr_warn("wf_pm72: Pump %s reports error %d\n",
+				cpu_pumps[cpu]->name, err);
 			failure_state |= FAILURE_FAN;
 		}
 	}
@@ -562,7 +562,7 @@ static void drives_fan_tick(void)
 
 	err = wf_sensor_get(drives_temp, &temp);
 	if (err) {
-		pr_warning("wf_pm72: drive bay temp sensor error %d\n", err);
+		pr_warn("wf_pm72: drive bay temp sensor error %d\n", err);
 		failure_state |= FAILURE_SENSOR;
 		wf_control_set_max(drives_fan);
 		return;
diff --git a/drivers/macintosh/windfarm_rm31.c b/drivers/macintosh/windfarm_rm31.c
index bdfcb8a8bfbb..8fb3f1aee96e 100644
--- a/drivers/macintosh/windfarm_rm31.c
+++ b/drivers/macintosh/windfarm_rm31.c
@@ -282,8 +282,8 @@ static void cpu_fans_tick(void)
 		for (i = 0; i < 3; i++) {
 			err = wf_control_set(cpu_fans[cpu][i], speed);
 			if (err) {
-				pr_warning("wf_rm31: Fan %s reports error %d\n",
-					   cpu_fans[cpu][i]->name, err);
+				pr_warn("wf_rm31: Fan %s reports error %d\n",
+					cpu_fans[cpu][i]->name, err);
 				failure_state |= FAILURE_FAN;
 			}
 		}
@@ -466,7 +466,7 @@ static void slots_fan_tick(void)
 
 	err = wf_sensor_get(slots_temp, &temp);
 	if (err) {
-		pr_warning("wf_rm31: slots temp sensor error %d\n", err);
+		pr_warn("wf_rm31: slots temp sensor error %d\n", err);
 		failure_state |= FAILURE_SENSOR;
 		wf_control_set_max(slots_fan);
 		return;
-- 
2.10.0.rc2.1.g053435c

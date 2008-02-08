Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound3-wa4-R.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9C4C2DDEC6
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Feb 2008 09:54:22 +1100 (EST)
Message-ID: <47ACDD39.5070701@am.sony.com>
Date: Fri, 08 Feb 2008 14:52:41 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 2/6] PS3: Fix lpm read pm interval
References: <20080208224723.029462363@am.sony.com>
In-Reply-To: <20080208224723.029462363@am.sony.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Takashi Yamamoto <TakashiA.Yamamoto@jp.sony.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Takashi Yamamoto <TakashiA.Yamamoto@jp.sony.com>

ps3_read_pm (pm_interval) should return an actual HW register value
because the pm_interval register is a counter register.
This patch removes the shadow pm_interval register.

Signed-off-by: Takashi Yamamoto <TakashiA.Yamamoto@jp.sony.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 drivers/ps3/ps3-lpm.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

--- a/drivers/ps3/ps3-lpm.c
+++ b/drivers/ps3/ps3-lpm.c
@@ -76,7 +76,6 @@
  *
  * @pm_control: Shadow of the processor's pm_control register.
  * @pm_start_stop: Shadow of the processor's pm_start_stop register.
- * @pm_interval: Shadow of the processor's pm_interval register.
  * @group_control: Shadow of the processor's group_control register.
  * @debug_bus_control: Shadow of the processor's debug_bus_control register.
  *
@@ -91,7 +90,6 @@
 struct ps3_lpm_shadow_regs {
 	u64 pm_control;
 	u64 pm_start_stop;
-	u64 pm_interval;
 	u64 group_control;
 	u64 debug_bus_control;
 };
@@ -408,7 +406,14 @@ u32 ps3_read_pm(u32 cpu, enum pm_reg_nam
 	case pm_start_stop:
 		return lpm_priv->shadow.pm_start_stop;
 	case pm_interval:
-		return lpm_priv->shadow.pm_interval;
+		result = lv1_set_lpm_interval(lpm_priv->lpm_id, 0, 0, &val);
+		if (result) {
+			val = 0;
+			dev_dbg(sbd_core(), "%s:%u: lv1 set_inteval failed: "
+				"reg %u, %s\n", __func__, __LINE__, reg,
+				ps3_result(result));
+		}
+		return (u32)val;
 	case group_control:
 		return lpm_priv->shadow.group_control;
 	case debug_bus_control:
@@ -475,10 +480,8 @@ void ps3_write_pm(u32 cpu, enum pm_reg_n
 		lpm_priv->shadow.pm_control = val;
 		break;
 	case pm_interval:
-		if (val != lpm_priv->shadow.pm_interval)
-			result = lv1_set_lpm_interval(lpm_priv->lpm_id, val,
-						   PS3_WRITE_PM_MASK, &dummy);
-		lpm_priv->shadow.pm_interval = val;
+		result = lv1_set_lpm_interval(lpm_priv->lpm_id, val,
+					      PS3_WRITE_PM_MASK, &dummy);
 		break;
 	case pm_start_stop:
 		if (val != lpm_priv->shadow.pm_start_stop)
@@ -1140,7 +1143,6 @@ int ps3_lpm_open(enum ps3_lpm_tb_type tb
 
 	lpm_priv->shadow.pm_control = PS3_LPM_SHADOW_REG_INIT;
 	lpm_priv->shadow.pm_start_stop = PS3_LPM_SHADOW_REG_INIT;
-	lpm_priv->shadow.pm_interval = PS3_LPM_SHADOW_REG_INIT;
 	lpm_priv->shadow.group_control = PS3_LPM_SHADOW_REG_INIT;
 	lpm_priv->shadow.debug_bus_control = PS3_LPM_SHADOW_REG_INIT;
 

-- 

Return-Path: <aaro.koskinen@iki.fi>
Received: from filtteri5.pp.htv.fi (filtteri5.pp.htv.fi [213.243.153.188])
 by ozlabs.org (Postfix) with ESMTP id 376A02C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Jul 2013 10:33:08 +1000 (EST)
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/windfarm: fix noisy slots-fan on Xserve (rm31)
Date: Sun, 21 Jul 2013 03:30:11 +0300
Message-Id: <1374366611-1678-1-git-send-email-aaro.koskinen@iki.fi>
Cc: Jan Engelhardt <jengelh@inai.de>, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

slots-fan on G5 Xserve is always running at full speed with windfarm_rm31
driver, resulting in a very high acoustic noise level. It seems the fan
parameters are incorrect, and have been copied from the Drive Bay fan
(RPM, not present on rm31) of the legacy therm_pm72 driver. This patch
changes the parameters to match the Slots fan (PWM) of therm_pm72. With
the patch, slots-fan speed drops from 99% to 19% during normal use,
and slots-temp settle to ~42'C.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/macintosh/windfarm_rm31.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/macintosh/windfarm_rm31.c b/drivers/macintosh/windfarm_rm31.c
index 0b9a79b..82fc86a 100644
--- a/drivers/macintosh/windfarm_rm31.c
+++ b/drivers/macintosh/windfarm_rm31.c
@@ -439,15 +439,15 @@ static void backside_setup_pid(void)
 
 /* Slots fan */
 static const struct wf_pid_param slots_param = {
-	.interval	= 5,
-	.history_len	= 2,
-	.gd		= 30 << 20,
-	.gp		= 5 << 20,
-	.gr		= 0,
-	.itarget	= 40 << 16,
-	.additive	= 1,
-	.min		= 300,
-	.max		= 4000,
+	.interval	= 1,
+	.history_len	= 20,
+	.gd		= 0,
+	.gp		= 0,
+	.gr		= 0x00100000,
+	.itarget	= 3200000,
+	.additive	= 0,
+	.min		= 20,
+	.max		= 100,
 };
 
 static void slots_fan_tick(void)
-- 
1.8.3.2

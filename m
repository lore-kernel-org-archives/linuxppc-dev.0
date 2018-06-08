Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 4125pB36llzF33p
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 12:24:33 +1000 (AEST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Schmitz <schmitzmic@gmail.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-m68k@lists.linux-m68k.org>, <linux-kernel@vger.kernel.org>
Message-Id: <fb1fddcf77a2091e78244a56bef0bf3deb589a38.1528423341.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1528423341.git.fthain@telegraphics.com.au>
References: <cover.1528423341.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v2 11/12] macintosh/via-pmu: Clean up interrupt statistics
Date: Thu,  7 Jun 2018 22:24:29 -0400 (EDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Replace an open-coded ffs() with the function call.
Simplify an if-else cascade using a switch statement.
Correct a typo and an indentation issue.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/macintosh/via-pmu.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 38d7dd0bdb28..730c10f7fbb7 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -1392,7 +1392,8 @@ pmu_resume(void)
 static void
 pmu_handle_data(unsigned char *data, int len)
 {
-	unsigned char ints, pirq;
+	unsigned char ints;
+	int idx;
 	int i = 0;
 
 	asleep = 0;
@@ -1414,25 +1415,24 @@ pmu_handle_data(unsigned char *data, int len)
 		ints &= ~(PMU_INT_ADB_AUTO | PMU_INT_AUTO_SRQ_POLL);
 
 next:
-
 	if (ints == 0) {
 		if (i > pmu_irq_stats[10])
 			pmu_irq_stats[10] = i;
 		return;
 	}
-
-	for (pirq = 0; pirq < 8; pirq++)
-		if (ints & (1 << pirq))
-			break;
-	pmu_irq_stats[pirq]++;
 	i++;
-	ints &= ~(1 << pirq);
+
+	idx = ffs(ints) - 1;
+	ints &= ~BIT(idx);
+
+	pmu_irq_stats[idx]++;
 
 	/* Note: for some reason, we get an interrupt with len=1,
 	 * data[0]==0 after each normal ADB interrupt, at least
 	 * on the Pismo. Still investigating...  --BenH
 	 */
-	if ((1 << pirq) & PMU_INT_ADB) {
+	switch (BIT(idx)) {
+	case PMU_INT_ADB:
 		if ((data[0] & PMU_INT_ADB_AUTO) == 0) {
 			struct adb_request *req = req_awaiting_reply;
 			if (req == 0) {
@@ -1470,25 +1470,28 @@ pmu_handle_data(unsigned char *data, int len)
 				adb_input(data+1, len-1, 1);
 #endif /* CONFIG_ADB */		
 		}
-	}
+		break;
+
 	/* Sound/brightness button pressed */
-	else if ((1 << pirq) & PMU_INT_SNDBRT) {
+	case PMU_INT_SNDBRT:
 #ifdef CONFIG_PMAC_BACKLIGHT
 		if (len == 3)
 			pmac_backlight_set_legacy_brightness_pmu(data[1] >> 4);
 #endif
-	}
+		break;
+
 	/* Tick interrupt */
-	else if ((1 << pirq) & PMU_INT_TICK) {
-		/* Environement or tick interrupt, query batteries */
+	case PMU_INT_TICK:
+		/* Environment or tick interrupt, query batteries */
 		if (pmu_battery_count) {
 			if ((--query_batt_timer) == 0) {
 				query_battery_state();
 				query_batt_timer = BATTERY_POLLING_COUNT;
 			}
 		}
-        }
-	else if ((1 << pirq) & PMU_INT_ENVIRONMENT) {
+		break;
+
+	case PMU_INT_ENVIRONMENT:
 		if (pmu_battery_count)
 			query_battery_state();
 		pmu_pass_intr(data, len);
@@ -1498,7 +1501,9 @@ pmu_handle_data(unsigned char *data, int len)
 			via_pmu_event(PMU_EVT_POWER, !!(data[1]&8));
 			via_pmu_event(PMU_EVT_LID, data[1]&1);
 		}
-	} else {
+		break;
+
+	default:
 	       pmu_pass_intr(data, len);
 	}
 	goto next;
-- 
2.16.4

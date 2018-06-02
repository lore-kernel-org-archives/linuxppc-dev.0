Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 40yRV52fplzF0cy
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 13:27:57 +1000 (AEST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Schmitz <schmitzmic@gmail.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-m68k@lists.linux-m68k.org>, <linux-kernel@vger.kernel.org>
Message-Id: <af2106d65c6b845c178bb2a0837e8554be2d1e8e.1527909627.git.fthain@telegraphics.com.au>
In-Reply-To: <ddfa9261a77d747e6523dd5cc0df84cc555dc440.1527909627.git.fthain@telegraphics.com.au>
References: <cover.1527909627.git.fthain@telegraphics.com.au>
 <f32f4e3a0fd736152f768b7a00bfc731daba1629.1527909627.git.fthain@telegraphics.com.au>
 <7ce9a8c3996506ae6f9ab16b3cf73c287e205a89.1527909627.git.fthain@telegraphics.com.au>
 <8597ac466215f573d8bea40e74fdec2bf72fabbb.1527909627.git.fthain@telegraphics.com.au>
 <878b389293851359e53de186bf302ce52d95ad95.1527909627.git.fthain@telegraphics.com.au>
 <adba0545c06cd6c67e26c433990d036b0d7e968c.1527909627.git.fthain@telegraphics.com.au>
 <166b4c3a7347fe27f12bda86d50533cd01ee11b9.1527909627.git.fthain@telegraphics.com.au>
 <73507a3e9444da17c222cf74df41842ce30d15ee.1527909627.git.fthain@telegraphics.com.au>
 <de8edb03dbd2fd25b53d0bdf9c6d65adf9aa0aa3.1527909627.git.fthain@telegraphics.com.au>
 <ddfa9261a77d747e6523dd5cc0df84cc555dc440.1527909627.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 10/11] macintosh/via-pmu: Clean up interrupt statistics
Date: Fri,  1 Jun 2018 23:27:51 -0400 (EDT)
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
---
 drivers/macintosh/via-pmu.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 3cbccd346997..5c5ebad4e6ae 100644
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
@@ -1470,25 +1470,25 @@ pmu_handle_data(unsigned char *data, int len)
 				adb_input(data+1, len-1, 1);
 #endif /* CONFIG_ADB */		
 		}
-	}
+		break;
 	/* Sound/brightness button pressed */
-	else if ((1 << pirq) & PMU_INT_SNDBRT) {
+	case PMU_INT_SNDBRT:
 #ifdef CONFIG_PMAC_BACKLIGHT
 		if (len == 3)
 			pmac_backlight_set_legacy_brightness_pmu(data[1] >> 4);
 #endif
-	}
+		break;
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
+	case PMU_INT_ENVIRONMENT:
 		if (pmu_battery_count)
 			query_battery_state();
 		pmu_pass_intr(data, len);
@@ -1498,7 +1498,8 @@ pmu_handle_data(unsigned char *data, int len)
 			via_pmu_event(PMU_EVT_POWER, !!(data[1]&8));
 			via_pmu_event(PMU_EVT_LID, data[1]&1);
 		}
-	} else {
+		break;
+	default:
 	       pmu_pass_intr(data, len);
 	}
 	goto next;
-- 
2.16.1

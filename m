Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4C29ADDF82
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Apr 2008 01:28:28 +1100 (EST)
Subject: [PATCH/RFC] via-pmu: remove mdelays from suspend/resume code
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 03 Apr 2008 17:44:44 +0200
Message-Id: <1207237484.3797.2.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I don't see a reason for either of those mdelay()s, is there any? Works
fine for me without them...

johannes
---
 drivers/macintosh/via-pmu.c |   20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

--- everything.orig/drivers/macintosh/via-pmu.c	2008-04-03 17:27:29.000000000 +0200
+++ everything/drivers/macintosh/via-pmu.c	2008-04-03 17:28:23.000000000 +0200
@@ -2165,8 +2165,6 @@ static void pmac_suspend_disable_irqs(vo
 
 static int powerbook_sleep(suspend_state_t state)
 {
-	int error = 0;
-
 	/* Wait for completion of async requests */
 	while (!batt_req.complete)
 		pmu_poll();
@@ -2183,25 +2181,15 @@ static int powerbook_sleep(suspend_state
 
 	switch (pmu_kind) {
 	case PMU_OHARE_BASED:
-		error = powerbook_sleep_3400();
-		break;
+		return powerbook_sleep_3400();
 	case PMU_HEATHROW_BASED:
 	case PMU_PADDINGTON_BASED:
-		error = powerbook_sleep_grackle();
-		break;
+		return powerbook_sleep_grackle();
 	case PMU_KEYLARGO_BASED:
-		error = powerbook_sleep_Core99();
-		break;
+		return powerbook_sleep_Core99();
 	default:
 		return -ENOSYS;
 	}
-
-	if (error)
-		return error;
-
-	mdelay(100);
-
-	return 0;
 }
 
 static void pmac_suspend_enable_irqs(void)
@@ -2210,8 +2198,6 @@ static void pmac_suspend_enable_irqs(voi
 	adb_int_pending = 1;
 	via_pmu_interrupt(0, NULL);
 
-	mdelay(10);
-
 	/* Call platform functions marked "on wake" */
 	pmac_pfunc_base_resume();
 	pmac_pfunc_i2c_resume();

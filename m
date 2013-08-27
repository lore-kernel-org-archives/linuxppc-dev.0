Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 401E92C02CE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2013 04:32:13 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Wed, 28 Aug 2013 04:28:56 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id DEB602BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2013 04:32:10 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7RIVxaG327994
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2013 04:31:59 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7RIW9T6018646
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2013 04:32:10 +1000
Subject: [PATCH V6 4/7] pseries/cpuidle: Remove MAX_IDLE_STATE macro.
To: linux-pm@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Wed, 28 Aug 2013 00:01:28 +0530
Message-ID: <20130827183126.18579.80649.stgit@deepthi.in.ibm.com>
In-Reply-To: <20130827183016.18579.16595.stgit@deepthi.in.ibm.com>
References: <20130827183016.18579.16595.stgit@deepthi.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: b.zolnierkie@samsung.com, daniel.lezcano@linaro.org,
 dongsheng.wang@freescale.com, preeti@linux.vnet.ibm.com,
 srivatsa.bhat@linux.vnet.ibm.com, scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch removes the usage of MAX_IDLE_STATE macro
and dead code around it. The number of states
are determined at run time based on the cpuidle
state table selected on a given platform

Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
---
 drivers/cpuidle/cpuidle-ibm-power.c |   26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-ibm-power.c b/drivers/cpuidle/cpuidle-ibm-power.c
index 262db3c..14ebdb4 100644
--- a/drivers/cpuidle/cpuidle-ibm-power.c
+++ b/drivers/cpuidle/cpuidle-ibm-power.c
@@ -25,9 +25,7 @@ struct cpuidle_driver pseries_idle_driver = {
 	.owner            = THIS_MODULE,
 };
 
-#define MAX_IDLE_STATE_COUNT	2
-
-static int max_idle_state = MAX_IDLE_STATE_COUNT - 1;
+static int max_idle_state;
 static struct cpuidle_state *cpuidle_state_table;
 
 static inline void idle_loop_prolog(unsigned long *in_purr)
@@ -133,7 +131,7 @@ static int shared_cede_loop(struct cpuidle_device *dev,
 /*
  * States for dedicated partition case.
  */
-static struct cpuidle_state dedicated_states[MAX_IDLE_STATE_COUNT] = {
+static struct cpuidle_state dedicated_states[] = {
 	{ /* Snooze */
 		.name = "snooze",
 		.desc = "snooze",
@@ -153,7 +151,7 @@ static struct cpuidle_state dedicated_states[MAX_IDLE_STATE_COUNT] = {
 /*
  * States for shared partition case.
  */
-static struct cpuidle_state shared_states[MAX_IDLE_STATE_COUNT] = {
+static struct cpuidle_state shared_states[] = {
 	{ /* Shared Cede */
 		.name = "Shared Cede",
 		.desc = "Shared Cede",
@@ -223,11 +221,7 @@ static int pseries_cpuidle_driver_init(void)
 	struct cpuidle_driver *drv = &pseries_idle_driver;
 
 	drv->state_count = 0;
-
-	for (idle_state = 0; idle_state < MAX_IDLE_STATE_COUNT; ++idle_state) {
-
-		if (idle_state > max_idle_state)
-			break;
+	for (idle_state = 0; idle_state < max_idle_state; ++idle_state) {
 
 		/* is the state not enabled? */
 		if (cpuidle_state_table[idle_state].enter == NULL)
@@ -252,16 +246,14 @@ static int pseries_idle_probe(void)
 	if (cpuidle_disable != IDLE_NO_OVERRIDE)
 		return -ENODEV;
 
-	if (max_idle_state == 0) {
-		printk(KERN_DEBUG "pseries processor idle disabled.\n");
-		return -EPERM;
-	}
-
 	if (firmware_has_feature(FW_FEATURE_SPLPAR)) {
-		if (get_lppaca()->shared_proc)
+		if (get_lppaca()->shared_proc) {
 			cpuidle_state_table = shared_states;
-		else
+			max_idle_state = ARRAY_SIZE(shared_states);
+		} else {
 			cpuidle_state_table = dedicated_states;
+			max_idle_state = ARRAY_SIZE(dedicated_states);
+		}
 	} else
 		return -ENODEV;
 

Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 049552C0354
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2013 04:32:45 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Wed, 28 Aug 2013 04:15:30 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E89553578051
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2013 04:32:40 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7RIWTex59769050
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2013 04:32:29 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7RIWdHA026098
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2013 04:32:40 +1000
Subject: [PATCH V6 6/7] POWER/cpuidle: Enable powernv cpuidle support.
To: linux-pm@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Wed, 28 Aug 2013 00:01:47 +0530
Message-ID: <20130827183145.18579.9940.stgit@deepthi.in.ibm.com>
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

The following patch extends the current power backend
idle driver to the powernv platform.

Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
---
 drivers/cpuidle/cpuidle-ibm-power.c |   39 ++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-ibm-power.c b/drivers/cpuidle/cpuidle-ibm-power.c
index 162deda..f8905c3 100644
--- a/drivers/cpuidle/cpuidle-ibm-power.c
+++ b/drivers/cpuidle/cpuidle-ibm-power.c
@@ -48,9 +48,10 @@ static int snooze_loop(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv,
 			int index)
 {
-	unsigned long in_purr;
+	unsigned long in_purr = 0;
 
-	idle_loop_prolog(&in_purr);
+	if (firmware_has_feature(FW_FEATURE_SPLPAR))
+		idle_loop_prolog(&in_purr);
 	local_irq_enable();
 	set_thread_flag(TIF_POLLING_NRFLAG);
 
@@ -64,7 +65,8 @@ static int snooze_loop(struct cpuidle_device *dev,
 	clear_thread_flag(TIF_POLLING_NRFLAG);
 	smp_mb();
 
-	idle_loop_epilog(in_purr);
+	if (firmware_has_feature(FW_FEATURE_SPLPAR))
+		idle_loop_epilog(in_purr);
 
 	return index;
 }
@@ -128,6 +130,15 @@ static int shared_cede_loop(struct cpuidle_device *dev,
 	return index;
 }
 
+static int nap_loop(struct cpuidle_device *dev,
+			struct cpuidle_driver *drv,
+			int index)
+{
+	ppc64_runlatch_off();
+	power7_idle();
+	return index;
+}
+
 /*
  * States for dedicated partition case.
  */
@@ -161,6 +172,23 @@ static struct cpuidle_state shared_states[] = {
 		.enter = &shared_cede_loop },
 };
 
+static struct cpuidle_state powernv_states[] = {
+	{ /* Snooze */
+		.name = "snooze",
+		.desc = "snooze",
+		.flags = CPUIDLE_FLAG_TIME_VALID,
+		.exit_latency = 0,
+		.target_residency = 0,
+		.enter = &snooze_loop },
+	{ /* NAP */
+		.name = "NAP",
+		.desc = "NAP",
+		.flags = CPUIDLE_FLAG_TIME_VALID,
+		.exit_latency = 10,
+		.target_residency = 100,
+		.enter = &nap_loop },
+};
+
 void update_smt_snooze_delay(int cpu, int residency)
 {
 	struct cpuidle_driver *drv = cpuidle_get_driver();
@@ -254,6 +282,11 @@ static int power_idle_probe(void)
 			cpuidle_state_table = dedicated_states;
 			max_idle_state = ARRAY_SIZE(dedicated_states);
 		}
+
+	} else if (firmware_has_feature(FW_FEATURE_OPALv3)) {
+		cpuidle_state_table = powernv_states;
+		max_idle_state = ARRAY_SIZE(powernv_states);
+
 	} else
 		return -ENODEV;
 

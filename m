Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D28C72C03B6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 22:02:22 +1100 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Tue, 29 Oct 2013 16:32:19 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 00B791258055
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 16:32:55 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9TB2Asx9830544
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 16:32:10 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9TB2Cqt029407
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 16:32:13 +0530
Subject: [PATCH V7 6/7] POWER/cpuidle: Enable powernv cpuidle support.
To: benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Tue, 29 Oct 2013 16:31:56 +0530
Message-ID: <20131029110154.31547.94129.stgit@deepthi.in.ibm.com>
In-Reply-To: <20131029110052.31547.82682.stgit@deepthi.in.ibm.com>
References: <20131029110052.31547.82682.stgit@deepthi.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: daniel.lezcano@linaro.org, preeti@linux.vnet.ibm.com,
 srivatsa.bhat@linux.vnet.ibm.com, scottwood@freescale.com,
 linux-pm@lists.linux-foundation.org
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
index 5b92242..f790ea2 100644
--- a/drivers/cpuidle/cpuidle-ibm-power.c
+++ b/drivers/cpuidle/cpuidle-ibm-power.c
@@ -52,9 +52,10 @@ static int snooze_loop(struct cpuidle_device *dev,
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
 
@@ -68,7 +69,8 @@ static int snooze_loop(struct cpuidle_device *dev,
 	clear_thread_flag(TIF_POLLING_NRFLAG);
 	smp_mb();
 
-	idle_loop_epilog(in_purr);
+	if (firmware_has_feature(FW_FEATURE_SPLPAR))
+		idle_loop_epilog(in_purr);
 
 	return index;
 }
@@ -132,6 +134,15 @@ static int shared_cede_loop(struct cpuidle_device *dev,
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
@@ -165,6 +176,23 @@ static struct cpuidle_state shared_states[] = {
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
@@ -258,6 +286,11 @@ static int power_idle_probe(void)
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
 

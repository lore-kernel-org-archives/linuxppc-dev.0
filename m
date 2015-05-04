Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 19F7E1A0E40
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 May 2015 19:00:30 +1000 (AEST)
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E2C32140157
 for <linuxppc-dev@ozlabs.org>; Mon,  4 May 2015 19:00:29 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Mon, 4 May 2015 19:00:28 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5FA4D2CE804E
 for <linuxppc-dev@ozlabs.org>; Mon,  4 May 2015 19:00:27 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4490JvU17694812
 for <linuxppc-dev@ozlabs.org>; Mon, 4 May 2015 19:00:27 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t448xspG023720
 for <linuxppc-dev@ozlabs.org>; Mon, 4 May 2015 18:59:54 +1000
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/6] cpufreq: powernv: Call throttle_check() on receiving
 OCC_THROTTLE
Date: Mon,  4 May 2015 14:24:10 +0530
Message-Id: <1430729652-14813-5-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
In-Reply-To: <1430729652-14813-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1430729652-14813-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Cc: preeti@linux.vnet.ibm.com, viresh.kumar@linaro.org, rjw@rjwysocki.net,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Re-evaluate the chip's throttled state on recieving OCC_THROTTLE
notification by executing *throttle_check() on any one of the cpu on
the chip. This is a sanity check to verify if we were indeed
throttled/unthrottled after receiving OCC_THROTTLE notification.

We cannot call *throttle_check() directly from the notification
handler because we could be handling chip1's notification in chip2. So
initiate an smp_call to execute *throttle_check(). We are irq-disabled
in the notification handler, so use a worker thread to smp_call
throttle_check() on any of the cpu in the chipmask.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 9268424..9618813 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -50,6 +50,8 @@ static bool rebooting, throttled, occ_reset;
 static struct chip {
 	unsigned int id;
 	bool throttled;
+	cpumask_t mask;
+	struct work_struct throttle;
 } *chips;
 
 static int nr_chips;
@@ -310,8 +312,9 @@ static inline unsigned int get_nominal_index(void)
 	return powernv_pstate_info.max - powernv_pstate_info.nominal;
 }
 
-static void powernv_cpufreq_throttle_check(unsigned int cpu)
+static void powernv_cpufreq_throttle_check(void *data)
 {
+	unsigned int cpu = smp_processor_id();
 	unsigned long pmsr;
 	int pmsr_pmax, pmsr_lp, i;
 
@@ -373,7 +376,7 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
 		return 0;
 
 	if (!throttled)
-		powernv_cpufreq_throttle_check(smp_processor_id());
+		powernv_cpufreq_throttle_check(NULL);
 
 	freq_data.pstate_id = powernv_freqs[new_index].driver_data;
 
@@ -418,6 +421,14 @@ static struct notifier_block powernv_cpufreq_reboot_nb = {
 	.notifier_call = powernv_cpufreq_reboot_notifier,
 };
 
+void powernv_cpufreq_work_fn(struct work_struct *work)
+{
+	struct chip *chip = container_of(work, struct chip, throttle);
+
+	smp_call_function_any(&chip->mask,
+			      powernv_cpufreq_throttle_check, NULL, 0);
+}
+
 static char throttle_reason[][30] = {
 					"No throttling",
 					"Power Cap",
@@ -433,6 +444,7 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
 	struct opal_msg *occ_msg = msg;
 	uint64_t token;
 	uint64_t chip_id, reason;
+	int i;
 
 	if (msg_type != OPAL_MSG_OCC)
 		return 0;
@@ -466,6 +478,10 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
 			occ_reset = false;
 			throttled = false;
 			pr_info("OCC: Active\n");
+
+			for (i = 0; i < nr_chips; i++)
+				schedule_work(&chips[i].throttle);
+
 			return 0;
 		}
 
@@ -476,6 +492,12 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
 		else if (!reason)
 			pr_info("OCC: Chip %u %s\n", (unsigned int)chip_id,
 				throttle_reason[reason]);
+		else
+			return 0;
+
+		for (i = 0; i < nr_chips; i++)
+			if (chips[i].id == chip_id)
+				schedule_work(&chips[i].throttle);
 	}
 	return 0;
 }
@@ -527,6 +549,8 @@ static int init_chip_info(void)
 	for (i = 0; i < nr_chips; i++) {
 		chips[i].id = chip[i];
 		chips[i].throttled = false;
+		cpumask_copy(&chips[i].mask, cpumask_of_node(chip[i]));
+		INIT_WORK(&chips[i].throttle, powernv_cpufreq_work_fn);
 	}
 
 	return 0;
-- 
1.9.3

Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F1B1A1A0727
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 18:04:56 +1000 (AEST)
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 53D52140285
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2015 18:04:56 +1000 (AEST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Thu, 16 Jul 2015 13:34:53 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id EBB13E005A
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2015 13:38:43 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6G84iOX25755776
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2015 13:34:45 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6G84ghT030705
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2015 13:34:43 +0530
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: rjw@rjwysocki.net
Cc: joel@jms.id.au, viresh.kumar@linaro.org, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v5 4/6] cpufreq: powernv: Call throttle_check() on receiving
 OCC_THROTTLE
Date: Thu, 16 Jul 2015 13:34:21 +0530
Message-Id: <1437033863-15864-5-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
In-Reply-To: <1437033863-15864-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1437033863-15864-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
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
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
No changes from v4

Changes from v3:
- Refer to the members of 'struct opal_occ_msg' in the patch.
  Replace 'chip_id' with 'omsg.chip'

 drivers/cpufreq/powernv-cpufreq.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index a634199..22f33ff 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -47,6 +47,8 @@ static bool rebooting, throttled, occ_reset;
 static struct chip {
 	unsigned int id;
 	bool throttled;
+	cpumask_t mask;
+	struct work_struct throttle;
 } *chips;
 
 static int nr_chips;
@@ -307,8 +309,9 @@ static inline unsigned int get_nominal_index(void)
 	return powernv_pstate_info.max - powernv_pstate_info.nominal;
 }
 
-static void powernv_cpufreq_throttle_check(unsigned int cpu)
+static void powernv_cpufreq_throttle_check(void *data)
 {
+	unsigned int cpu = smp_processor_id();
 	unsigned long pmsr;
 	int pmsr_pmax, pmsr_lp, i;
 
@@ -370,7 +373,7 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
 		return 0;
 
 	if (!throttled)
-		powernv_cpufreq_throttle_check(smp_processor_id());
+		powernv_cpufreq_throttle_check(NULL);
 
 	freq_data.pstate_id = powernv_freqs[new_index].driver_data;
 
@@ -415,6 +418,14 @@ static struct notifier_block powernv_cpufreq_reboot_nb = {
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
@@ -429,6 +440,7 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
 {
 	struct opal_msg *msg = _msg;
 	struct opal_occ_msg omsg;
+	int i;
 
 	if (msg_type != OPAL_MSG_OCC)
 		return 0;
@@ -462,6 +474,10 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
 			occ_reset = false;
 			throttled = false;
 			pr_info("OCC: Active\n");
+
+			for (i = 0; i < nr_chips; i++)
+				schedule_work(&chips[i].throttle);
+
 			return 0;
 		}
 
@@ -473,6 +489,12 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
 		else if (!omsg.throttle_status)
 			pr_info("OCC: Chip %u %s\n", (unsigned int)omsg.chip,
 				throttle_reason[omsg.throttle_status]);
+		else
+			return 0;
+
+		for (i = 0; i < nr_chips; i++)
+			if (chips[i].id == omsg.chip)
+				schedule_work(&chips[i].throttle);
 	}
 	return 0;
 }
@@ -524,6 +546,8 @@ static int init_chip_info(void)
 	for (i = 0; i < nr_chips; i++) {
 		chips[i].id = chip[i];
 		chips[i].throttled = false;
+		cpumask_copy(&chips[i].mask, cpumask_of_node(chip[i]));
+		INIT_WORK(&chips[i].throttle, powernv_cpufreq_work_fn);
 	}
 
 	return 0;
-- 
1.9.3

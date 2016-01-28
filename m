Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B05331A0393
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 18:26:59 +1100 (AEDT)
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7B402140B8C
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 18:26:59 +1100 (AEDT)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Thu, 28 Jan 2016 17:26:59 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 852F12CE8055
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 18:26:57 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0S7QnVe14155866
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 18:26:57 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0S7QON0029769
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 18:26:25 +1100
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 pc@us.ibm.com, anton@samba.org, ego@linux.vnet.ibm.com,
 shreyas@linux.vnet.ibm.com, bsingharora@gmail.com, mpe@ellerman.id.au,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v7 2/6] cpufreq: powernv: Hot-plug safe the kworker thread
Date: Thu, 28 Jan 2016 12:55:37 +0530
Message-Id: <1453965941-7363-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
In-Reply-To: <1453965941-7363-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1453965941-7363-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the kworker_thread powernv_cpufreq_work_fn(), we can end up
sending an IPI to a cpu going offline. This is a rare corner case
which is fixed using {get/put}_online_cpus(). Along with this fix,
this patch adds changes to do oneshot cpumask_{clear/and} operation.

Suggested-by: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
Suggested-by: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
No changes from v6.

Changes form v5:
- Fix the kbuild-error:
drivers/cpufreq/powernv-cpufreq.c:428:2: error: implicit declaration of
function 'get_online_cpus' [-Werror=implicit-function-declaration

 drivers/cpufreq/powernv-cpufreq.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 53f980b..a271b0f 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -28,6 +28,7 @@
 #include <linux/of.h>
 #include <linux/reboot.h>
 #include <linux/slab.h>
+#include <linux/cpu.h>
 
 #include <asm/cputhreads.h>
 #include <asm/firmware.h>
@@ -423,18 +424,19 @@ void powernv_cpufreq_work_fn(struct work_struct *work)
 {
 	struct chip *chip = container_of(work, struct chip, throttle);
 	unsigned int cpu;
-	cpumask_var_t mask;
+	cpumask_t mask;
 
-	smp_call_function_any(&chip->mask,
+	get_online_cpus();
+	cpumask_and(&mask, &chip->mask, cpu_online_mask);
+	smp_call_function_any(&mask,
 			      powernv_cpufreq_throttle_check, NULL, 0);
 
 	if (!chip->restore)
-		return;
+		goto out;
 
 	chip->restore = false;
-	cpumask_copy(mask, &chip->mask);
-	for_each_cpu_and(cpu, mask, cpu_online_mask) {
-		int index, tcpu;
+	for_each_cpu(cpu, &mask) {
+		int index;
 		struct cpufreq_policy policy;
 
 		cpufreq_get_policy(&policy, cpu);
@@ -442,9 +444,10 @@ void powernv_cpufreq_work_fn(struct work_struct *work)
 					       policy.cur,
 					       CPUFREQ_RELATION_C, &index);
 		powernv_cpufreq_target_index(&policy, index);
-		for_each_cpu(tcpu, policy.cpus)
-			cpumask_clear_cpu(tcpu, mask);
+		cpumask_andnot(&mask, &mask, policy.cpus);
 	}
+out:
+	put_online_cpus();
 }
 
 static char throttle_reason[][30] = {
-- 
1.9.3

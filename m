Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 67DB51A0E9C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jan 2016 18:20:07 +1100 (AEDT)
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3A1011402DE
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Jan 2016 18:20:07 +1100 (AEDT)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Fri, 22 Jan 2016 17:20:06 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A0F782CE8054
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Jan 2016 18:20:03 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0M7JXEh8913088
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Jan 2016 18:19:41 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0M7JU6N023343
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Jan 2016 18:19:31 +1100
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 pc@us.ibm.com, anton@samba.org, ego@linux.vnet.ibm.com,
 shreyas@linux.vnet.ibm.com,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v6 1/5] cpufreq: powernv: Hot-plug safe the kworker thread
Date: Fri, 22 Jan 2016 12:49:01 +0530
Message-Id: <1453447145-17722-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
In-Reply-To: <1453447145-17722-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1453447145-17722-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
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
---
Changes form v5:
- Fix the kbuild-error:
drivers/cpufreq/powernv-cpufreq.c:428:2: error: implicit declaration of
function 'get_online_cpus' [-Werror=implicit-function-declaration

 drivers/cpufreq/powernv-cpufreq.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 547890f..140c75f 100644
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

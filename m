Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qkvzn3KVwzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 04:07:49 +1000 (AEST)
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Tue, 12 Apr 2016 23:37:47 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3CI846G22675740
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 23:38:04 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3CI7f6K025896
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 23:37:43 +0530
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: ego@linux.vnet.ibm.com, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH 1/2] cpufreq: powernv: Remove flag use-case of
 policy->driver_data
Date: Tue, 12 Apr 2016 23:36:25 +0530
Message-Id: <1460484386-28389-2-git-send-email-akshay.adiga@linux.vnet.ibm.com>
In-Reply-To: <1460484386-28389-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
References: <1460484386-28389-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

'commit 1b0289848d5d ("cpufreq: powernv: Add sysfs attributes to show throttle
stats")' used policy->driver_data as a flag for one-time creation
of throttle sysfs files. Instead of this use 'kernfs_find_and_get()'
to check if the attribute already exists. This is required as
policy->driver_data is used for other purposes in the later patch.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Reviewed-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 39ac78c..e2e2219 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -455,13 +455,15 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
 static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	int base, i;
+	struct kernfs_node *kn;
 
 	base = cpu_first_thread_sibling(policy->cpu);
 
 	for (i = 0; i < threads_per_core; i++)
 		cpumask_set_cpu(base + i, policy->cpus);
 
-	if (!policy->driver_data) {
+	kn = kernfs_find_and_get(policy->kobj.sd, throttle_attr_grp.name);
+	if (!kn) {
 		int ret;
 
 		ret = sysfs_create_group(&policy->kobj, &throttle_attr_grp);
@@ -470,11 +472,8 @@ static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
 				policy->cpu);
 			return ret;
 		}
-		/*
-		 * policy->driver_data is used as a flag for one-time
-		 * creation of throttle sysfs files.
-		 */
-		policy->driver_data = policy;
+	} else {
+		kernfs_put(kn);
 	}
 	return cpufreq_table_validate_and_show(policy, powernv_freqs);
 }
-- 
2.5.5

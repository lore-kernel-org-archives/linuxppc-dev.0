Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pf0-x232.google.com (mail-pf0-x232.google.com
 [IPv6:2607:f8b0:400e:c00::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rKRYw2VnpzDqZ3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Jun 2016 20:34:43 +1000 (AEST)
Received: by mail-pf0-x232.google.com with SMTP id g64so12934377pfb.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jun 2016 03:34:43 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] cpufreq: powerenv: Fix memory leak
Date: Wed,  1 Jun 2016 16:04:17 +0530
Message-Id: <f67b4b395c777a3e933ab51eafcd76b1299bf1fb.1464776797.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1464776797.git.viresh.kumar@linaro.org>
References: <cover.1464776797.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1464776797.git.viresh.kumar@linaro.org>
References: <cover.1464776797.git.viresh.kumar@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The policy is copied (unnecessarily) and is never freed. Fix it by just
getting a reference to the existing policy structure and putting it
back.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/powernv-cpufreq.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 54c45368e3f1..96bb4acd366e 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -756,15 +756,18 @@ void powernv_cpufreq_work_fn(struct work_struct *work)
 
 	chip->restore = false;
 	for_each_cpu(cpu, &mask) {
+		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu)
 		int index;
-		struct cpufreq_policy policy;
 
-		cpufreq_get_policy(&policy, cpu);
-		cpufreq_frequency_table_target(&policy, policy.freq_table,
-					       policy.cur,
+		if (!policy)
+			continue;
+
+		cpufreq_frequency_table_target(policy, policy->freq_table,
+					       policy->cur,
 					       CPUFREQ_RELATION_C, &index);
-		powernv_cpufreq_target_index(&policy, index);
-		cpumask_andnot(&mask, &mask, policy.cpus);
+		powernv_cpufreq_target_index(policy, index);
+		cpumask_andnot(&mask, &mask, policy->cpus);
+		cpufreq_cpu_put(policy);
 	}
 out:
 	put_online_cpus();
-- 
2.7.1.410.g6faf27b

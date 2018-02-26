Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqVJM0WsjzF1P9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 16:10:10 +1100 (AEDT)
Received: by mail-pl0-x243.google.com with SMTP id x19so8655034plr.13
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Feb 2018 21:10:10 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rafael Wysocki <rjw@rjwysocki.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 Vincent Guittot <vincent.guittot@linaro.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 15/27] cpufreq: powerenv: Don't validate the frequency table
 twice
Date: Mon, 26 Feb 2018 10:38:58 +0530
Message-Id: <3120e4db4ae3bc014d198a206f46be1305ec65e8.1519620578.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1519620578.git.viresh.kumar@linaro.org>
References: <cover.1519620578.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1519620578.git.viresh.kumar@linaro.org>
References: <cover.1519620578.git.viresh.kumar@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The cpufreq core is already validating the CPU frequency table after
calling the ->init() callback of the cpufreq drivers and the drivers
don't need to do the same anymore. Though they need to set the
policy->freq_table field directly from the ->init() callback now.

Stop validating the frequency table from powerenv driver.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/powernv-cpufreq.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 29cdec198657..0591874856d3 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -812,7 +812,7 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
 
 static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
-	int base, i, ret;
+	int base, i;
 	struct kernfs_node *kn;
 	struct global_pstate_info *gpstates;
 
@@ -848,15 +848,10 @@ static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	gpstates->timer.expires = jiffies +
 				msecs_to_jiffies(GPSTATE_TIMER_INTERVAL);
 	spin_lock_init(&gpstates->gpstate_lock);
-	ret = cpufreq_table_validate_and_show(policy, powernv_freqs);
-
-	if (ret < 0) {
-		kfree(policy->driver_data);
-		return ret;
-	}
 
+	policy->freq_table = powernv_freqs;
 	policy->fast_switch_possible = true;
-	return ret;
+	return 0;
 }
 
 static int powernv_cpufreq_cpu_exit(struct cpufreq_policy *policy)
-- 
2.15.0.194.g9af6a3dea062

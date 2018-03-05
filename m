Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zvms36XfNzF09v
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2018 15:19:50 +1100 (AEDT)
Received: by mail-pl0-x241.google.com with SMTP id f23-v6so8994641plr.10
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Mar 2018 20:19:49 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rafael Wysocki <rjw@rjwysocki.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 Vincent Guittot <vincent.guittot@linaro.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V2 15/27] cpufreq: powernv: Don't validate the frequency table
 twice
Date: Mon,  5 Mar 2018 09:49:32 +0530
Message-Id: <fd8651e59a1b5c539e0a9589f2d0648afd42cce1.1520223512.git.viresh.kumar@linaro.org>
In-Reply-To: <3120e4db4ae3bc014d198a206f46be1305ec65e8.1519620578.git.viresh.kumar@linaro.org>
References: <3120e4db4ae3bc014d198a206f46be1305ec65e8.1519620578.git.viresh.kumar@linaro.org>
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

Stop validating the frequency table from powernv driver.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V1->V2:
- s/powerenv/powernv/

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

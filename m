Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pf0-x22b.google.com (mail-pf0-x22b.google.com
 [IPv6:2607:f8b0:400e:c00::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rL8Ck1S3KzDqg5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jun 2016 00:06:25 +1000 (AEST)
Received: by mail-pf0-x22b.google.com with SMTP id f144so31820905pfa.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jun 2016 07:06:25 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V2 4/6] cpufreq: Drop freq-table param to
 cpufreq_frequency_table_target()
Date: Thu,  2 Jun 2016 19:34:58 +0530
Message-Id: <4473fc3374db1e227bf36278d2a02b638bcee339.1464876229.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1464876229.git.viresh.kumar@linaro.org>
References: <cover.1464876229.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1464876229.git.viresh.kumar@linaro.org>
References: <cover.1464876229.git.viresh.kumar@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The policy already has this pointer set, use it instead.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/cpu-freq/cpu-drivers.txt |  1 -
 drivers/cpufreq/amd_freq_sensitivity.c |  3 +--
 drivers/cpufreq/cpufreq.c              |  4 ++--
 drivers/cpufreq/cpufreq_ondemand.c     | 11 +++++------
 drivers/cpufreq/freq_table.c           |  2 +-
 drivers/cpufreq/powernv-cpufreq.c      |  3 +--
 drivers/cpufreq/s3c24xx-cpufreq.c      | 11 +++++------
 drivers/cpufreq/s5pv210-cpufreq.c      |  3 +--
 include/linux/cpufreq.h                |  1 -
 9 files changed, 16 insertions(+), 23 deletions(-)

diff --git a/Documentation/cpu-freq/cpu-drivers.txt b/Documentation/cpu-freq/cpu-drivers.txt
index decbb8cb5573..74e812f0719c 100644
--- a/Documentation/cpu-freq/cpu-drivers.txt
+++ b/Documentation/cpu-freq/cpu-drivers.txt
@@ -244,7 +244,6 @@ policy->max, and all other criteria are met. This is helpful for the
 ->verify call.
 
 int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
-                                   struct cpufreq_frequency_table *table,
                                    unsigned int target_freq,
                                    unsigned int relation,
                                    unsigned int *index);
diff --git a/drivers/cpufreq/amd_freq_sensitivity.c b/drivers/cpufreq/amd_freq_sensitivity.c
index bc86816693a8..3bea1bb791a9 100644
--- a/drivers/cpufreq/amd_freq_sensitivity.c
+++ b/drivers/cpufreq/amd_freq_sensitivity.c
@@ -92,8 +92,7 @@ static unsigned int amd_powersave_bias_target(struct cpufreq_policy *policy,
 			unsigned int index;
 
 			cpufreq_frequency_table_target(policy,
-				policy->freq_table, policy->cur - 1,
-				CPUFREQ_RELATION_H, &index);
+				policy->cur - 1, CPUFREQ_RELATION_H, &index);
 			freq_next = policy->freq_table[index].frequency;
 		}
 
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 1833eda1f9d4..e68611a67bd9 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1947,8 +1947,8 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 		return -EINVAL;
 	}
 
-	retval = cpufreq_frequency_table_target(policy, freq_table, target_freq,
-						relation, &index);
+	retval = cpufreq_frequency_table_target(policy, target_freq, relation,
+						&index);
 	if (unlikely(retval)) {
 		pr_err("%s: Unable to find matching freq\n", __func__);
 		return retval;
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 528353f204fd..2ee476f5a2bd 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -79,20 +79,19 @@ static unsigned int generic_powersave_bias_target(struct cpufreq_policy *policy,
 		return freq_next;
 	}
 
-	cpufreq_frequency_table_target(policy, freq_table, freq_next, relation,
-				       &index);
+	cpufreq_frequency_table_target(policy, freq_next, relation, &index);
 	freq_req = freq_table[index].frequency;
 	freq_reduc = freq_req * od_tuners->powersave_bias / 1000;
 	freq_avg = freq_req - freq_reduc;
 
 	/* Find freq bounds for freq_avg in freq_table */
 	index = 0;
-	cpufreq_frequency_table_target(policy, freq_table, freq_avg,
-				       CPUFREQ_RELATION_H, &index);
+	cpufreq_frequency_table_target(policy, freq_avg, CPUFREQ_RELATION_H,
+				       &index);
 	freq_lo = freq_table[index].frequency;
 	index = 0;
-	cpufreq_frequency_table_target(policy, freq_table, freq_avg,
-				       CPUFREQ_RELATION_L, &index);
+	cpufreq_frequency_table_target(policy, freq_avg, CPUFREQ_RELATION_L,
+				       &index);
 	freq_hi = freq_table[index].frequency;
 
 	/* Find out how long we have to be in hi and lo freqs */
diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index f52b5473b1f4..f145b64649ef 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -114,7 +114,6 @@ int cpufreq_generic_frequency_table_verify(struct cpufreq_policy *policy)
 EXPORT_SYMBOL_GPL(cpufreq_generic_frequency_table_verify);
 
 int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
-				   struct cpufreq_frequency_table *table,
 				   unsigned int target_freq,
 				   unsigned int relation,
 				   unsigned int *index)
@@ -128,6 +127,7 @@ int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
 		.frequency = 0,
 	};
 	struct cpufreq_frequency_table *pos;
+	struct cpufreq_frequency_table *table = policy->freq_table;
 	unsigned int freq, diff, i = 0;
 
 	pr_debug("request for target %u kHz (relation: %u) for cpu %u\n",
diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 54c45368e3f1..bf267c2dfe20 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -760,8 +760,7 @@ void powernv_cpufreq_work_fn(struct work_struct *work)
 		struct cpufreq_policy policy;
 
 		cpufreq_get_policy(&policy, cpu);
-		cpufreq_frequency_table_target(&policy, policy.freq_table,
-					       policy.cur,
+		cpufreq_frequency_table_target(&policy, policy.cur,
 					       CPUFREQ_RELATION_C, &index);
 		powernv_cpufreq_target_index(&policy, index);
 		cpumask_andnot(&mask, &mask, policy.cpus);
diff --git a/drivers/cpufreq/s3c24xx-cpufreq.c b/drivers/cpufreq/s3c24xx-cpufreq.c
index 4567c3cab095..05a9737278f3 100644
--- a/drivers/cpufreq/s3c24xx-cpufreq.c
+++ b/drivers/cpufreq/s3c24xx-cpufreq.c
@@ -293,9 +293,8 @@ static int s3c_cpufreq_target(struct cpufreq_policy *policy,
 		     __func__, policy, target_freq, relation);
 
 	if (ftab) {
-		if (cpufreq_frequency_table_target(policy, ftab,
-						   target_freq, relation,
-						   &index)) {
+		if (cpufreq_frequency_table_target(policy, target_freq,
+						   relation, &index)) {
 			s3c_freq_dbg("%s: table failed\n", __func__);
 			return -EINVAL;
 		}
@@ -323,14 +322,14 @@ static int s3c_cpufreq_target(struct cpufreq_policy *policy,
 		tmp_policy.min = policy->min * 1000;
 		tmp_policy.max = policy->max * 1000;
 		tmp_policy.cpu = policy->cpu;
+		tmp_policy.freq_table = pll_reg;
 
 		/* cpufreq_frequency_table_target uses a pointer to 'index'
 		 * which is the number of the table entry, not the value of
 		 * the table entry's index field. */
 
-		ret = cpufreq_frequency_table_target(&tmp_policy, pll_reg,
-						     target_freq, relation,
-						     &index);
+		ret = cpufreq_frequency_table_target(&tmp_policy, target_freq,
+						     relation, &index);
 
 		if (ret < 0) {
 			pr_err("%s: no PLL available\n", __func__);
diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index 06d85917b6d5..6b0cfc3b8c46 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -246,8 +246,7 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
 	new_freq = s5pv210_freq_table[index].frequency;
 
 	/* Finding current running level index */
-	if (cpufreq_frequency_table_target(policy, s5pv210_freq_table,
-					   old_freq, CPUFREQ_RELATION_H,
+	if (cpufreq_frequency_table_target(policy, old_freq, CPUFREQ_RELATION_H,
 					   &priv_index)) {
 		ret = -EINVAL;
 		goto exit;
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 1342cbc0f25e..bdd7f0c035ae 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -598,7 +598,6 @@ int cpufreq_frequency_table_verify(struct cpufreq_policy *policy,
 int cpufreq_generic_frequency_table_verify(struct cpufreq_policy *policy);
 
 int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
-				   struct cpufreq_frequency_table *table,
 				   unsigned int target_freq,
 				   unsigned int relation,
 				   unsigned int *index);
-- 
2.7.1.410.g6faf27b

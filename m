Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pf0-x231.google.com (mail-pf0-x231.google.com
 [IPv6:2607:f8b0:400e:c00::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rKRZG1t4zzDqcg
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Jun 2016 20:35:02 +1000 (AEST)
Received: by mail-pf0-x231.google.com with SMTP id g64so12938754pfb.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jun 2016 03:35:02 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 8/8] cpufreq: Return index from
 cpufreq_frequency_table_target()
Date: Wed,  1 Jun 2016 16:04:22 +0530
Message-Id: <ff52bb2de0ab87c7143f42afc3495d9af44aedd2.1464776797.git.viresh.kumar@linaro.org>
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

This routine can't fail unless the frequency table is invalid and
doesn't contain any valid entries.

Make it return the index and WARN() in case it is used for an invalid
table.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/cpu-freq/cpu-drivers.txt |  7 +++----
 drivers/cpufreq/amd_freq_sensitivity.c |  4 ++--
 drivers/cpufreq/cpufreq.c              |  9 ++-------
 drivers/cpufreq/cpufreq_ondemand.c     | 14 ++++++--------
 drivers/cpufreq/freq_table.c           | 24 +++++++++++++-----------
 drivers/cpufreq/powernv-cpufreq.c      |  4 ++--
 drivers/cpufreq/s3c24xx-cpufreq.c      | 26 ++++++--------------------
 drivers/cpufreq/s5pv210-cpufreq.c      |  7 ++-----
 include/linux/cpufreq.h                |  3 +--
 9 files changed, 37 insertions(+), 61 deletions(-)

diff --git a/Documentation/cpu-freq/cpu-drivers.txt b/Documentation/cpu-freq/cpu-drivers.txt
index 74e812f0719c..772b94fde264 100644
--- a/Documentation/cpu-freq/cpu-drivers.txt
+++ b/Documentation/cpu-freq/cpu-drivers.txt
@@ -245,12 +245,11 @@ policy->max, and all other criteria are met. This is helpful for the
 
 int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
                                    unsigned int target_freq,
-                                   unsigned int relation,
-                                   unsigned int *index);
+                                   unsigned int relation);
 
 is the corresponding frequency table helper for the ->target
-stage. Just pass the values to this function, and the unsigned int
-index returns the number of the frequency table entry which contains
+stage. Just pass the values to this function, and this function
+returns the number of the frequency table entry which contains
 the frequency the CPU shall be set to.
 
 The following macros can be used as iterators over cpufreq_frequency_table:
diff --git a/drivers/cpufreq/amd_freq_sensitivity.c b/drivers/cpufreq/amd_freq_sensitivity.c
index 3bea1bb791a9..6d5dc04c3a37 100644
--- a/drivers/cpufreq/amd_freq_sensitivity.c
+++ b/drivers/cpufreq/amd_freq_sensitivity.c
@@ -91,8 +91,8 @@ static unsigned int amd_powersave_bias_target(struct cpufreq_policy *policy,
 		else {
 			unsigned int index;
 
-			cpufreq_frequency_table_target(policy,
-				policy->cur - 1, CPUFREQ_RELATION_H, &index);
+			index = cpufreq_frequency_table_target(policy,
+				policy->cur - 1, CPUFREQ_RELATION_H);
 			freq_next = policy->freq_table[index].frequency;
 		}
 
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 1685e930770f..07c933c6c29a 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1914,7 +1914,7 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 			    unsigned int relation)
 {
 	unsigned int old_target_freq = target_freq;
-	int index, retval;
+	int index;
 
 	if (cpufreq_disabled())
 		return -ENODEV;
@@ -1943,12 +1943,7 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 	if (!cpufreq_driver->target_index)
 		return -EINVAL;
 
-	retval = cpufreq_frequency_table_target(policy, target_freq, relation,
-						&index);
-	if (unlikely(retval)) {
-		pr_err("%s: Unable to find matching freq\n", __func__);
-		return retval;
-	}
+	index = cpufreq_frequency_table_target(policy, target_freq, relation);
 
 	return __target_index(policy, index);
 }
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 2ee476f5a2bd..0c93cd9dee99 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -65,7 +65,7 @@ static unsigned int generic_powersave_bias_target(struct cpufreq_policy *policy,
 {
 	unsigned int freq_req, freq_reduc, freq_avg;
 	unsigned int freq_hi, freq_lo;
-	unsigned int index = 0;
+	unsigned int index;
 	unsigned int delay_hi_us;
 	struct policy_dbs_info *policy_dbs = policy->governor_data;
 	struct od_policy_dbs_info *dbs_info = to_dbs_info(policy_dbs);
@@ -79,19 +79,17 @@ static unsigned int generic_powersave_bias_target(struct cpufreq_policy *policy,
 		return freq_next;
 	}
 
-	cpufreq_frequency_table_target(policy, freq_next, relation, &index);
+	index = cpufreq_frequency_table_target(policy, freq_next, relation);
 	freq_req = freq_table[index].frequency;
 	freq_reduc = freq_req * od_tuners->powersave_bias / 1000;
 	freq_avg = freq_req - freq_reduc;
 
 	/* Find freq bounds for freq_avg in freq_table */
-	index = 0;
-	cpufreq_frequency_table_target(policy, freq_avg, CPUFREQ_RELATION_H,
-				       &index);
+	index = cpufreq_frequency_table_target(policy, freq_avg,
+					       CPUFREQ_RELATION_H);
 	freq_lo = freq_table[index].frequency;
-	index = 0;
-	cpufreq_frequency_table_target(policy, freq_avg, CPUFREQ_RELATION_L,
-				       &index);
+	index = cpufreq_frequency_table_target(policy, freq_avg,
+					       CPUFREQ_RELATION_L);
 	freq_hi = freq_table[index].frequency;
 
 	/* Find out how long we have to be in hi and lo freqs */
diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index f145b64649ef..eac8bcbdaad1 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -114,9 +114,8 @@ int cpufreq_generic_frequency_table_verify(struct cpufreq_policy *policy)
 EXPORT_SYMBOL_GPL(cpufreq_generic_frequency_table_verify);
 
 int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
-				   unsigned int target_freq,
-				   unsigned int relation,
-				   unsigned int *index)
+				    unsigned int target_freq,
+				    unsigned int relation)
 {
 	struct cpufreq_frequency_table optimal = {
 		.driver_data = ~0,
@@ -129,6 +128,7 @@ int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
 	struct cpufreq_frequency_table *pos;
 	struct cpufreq_frequency_table *table = policy->freq_table;
 	unsigned int freq, diff, i = 0;
+	int index;
 
 	pr_debug("request for target %u kHz (relation: %u) for cpu %u\n",
 					target_freq, relation, policy->cpu);
@@ -192,16 +192,18 @@ int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
 		}
 	}
 	if (optimal.driver_data > i) {
-		if (suboptimal.driver_data > i)
-			return -EINVAL;
-		*index = suboptimal.driver_data;
-	} else
-		*index = optimal.driver_data;
+		if (suboptimal.driver_data > i) {
+			WARN(1, "Invalid frequency table: %d\n", policy->cpu);
+			return 0;
+		}
 
-	pr_debug("target index is %u, freq is:%u kHz\n", *index,
-		 table[*index].frequency);
+		index = suboptimal.driver_data;
+	} else
+		index = optimal.driver_data;
 
-	return 0;
+	pr_debug("target index is %u, freq is:%u kHz\n", index,
+		 table[index].frequency);
+	return index;
 }
 EXPORT_SYMBOL_GPL(cpufreq_frequency_table_target);
 
diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 4d5799f5270f..0b8e6d3d4ac2 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -762,8 +762,8 @@ void powernv_cpufreq_work_fn(struct work_struct *work)
 		if (!policy)
 			continue;
 
-		cpufreq_frequency_table_target(policy, policy->cur,
-					       CPUFREQ_RELATION_C, &index);
+		index = cpufreq_frequency_table_target(policy, policy->cur,
+						       CPUFREQ_RELATION_C);
 		powernv_cpufreq_target_index(policy, index);
 		cpumask_andnot(&mask, &mask, policy->cpus);
 		cpufreq_cpu_put(policy);
diff --git a/drivers/cpufreq/s3c24xx-cpufreq.c b/drivers/cpufreq/s3c24xx-cpufreq.c
index 05a9737278f3..7b596fa38ad2 100644
--- a/drivers/cpufreq/s3c24xx-cpufreq.c
+++ b/drivers/cpufreq/s3c24xx-cpufreq.c
@@ -293,11 +293,8 @@ static int s3c_cpufreq_target(struct cpufreq_policy *policy,
 		     __func__, policy, target_freq, relation);
 
 	if (ftab) {
-		if (cpufreq_frequency_table_target(policy, target_freq,
-						   relation, &index)) {
-			s3c_freq_dbg("%s: table failed\n", __func__);
-			return -EINVAL;
-		}
+		index = cpufreq_frequency_table_target(policy, target_freq,
+						       relation);
 
 		s3c_freq_dbg("%s: adjust %d to entry %d (%u)\n", __func__,
 			     target_freq, index, ftab[index].frequency);
@@ -314,7 +311,6 @@ static int s3c_cpufreq_target(struct cpufreq_policy *policy,
 		pll = NULL;
 	} else {
 		struct cpufreq_policy tmp_policy;
-		int ret;
 
 		/* we keep the cpu pll table in Hz, to ensure we get an
 		 * accurate value for the PLL output. */
@@ -324,18 +320,12 @@ static int s3c_cpufreq_target(struct cpufreq_policy *policy,
 		tmp_policy.cpu = policy->cpu;
 		tmp_policy.freq_table = pll_reg;
 
-		/* cpufreq_frequency_table_target uses a pointer to 'index'
-		 * which is the number of the table entry, not the value of
+		/* cpufreq_frequency_table_target returns the index
+		 * of the table entry, not the value of
 		 * the table entry's index field. */
 
-		ret = cpufreq_frequency_table_target(&tmp_policy, target_freq,
-						     relation, &index);
-
-		if (ret < 0) {
-			pr_err("%s: no PLL available\n", __func__);
-			goto err_notpossible;
-		}
-
+		index = cpufreq_frequency_table_target(&tmp_policy, target_freq,
+						       relation);
 		pll = pll_reg + index;
 
 		s3c_freq_dbg("%s: target %u => %u\n",
@@ -345,10 +335,6 @@ static int s3c_cpufreq_target(struct cpufreq_policy *policy,
 	}
 
 	return s3c_cpufreq_settarget(policy, target_freq, pll);
-
- err_notpossible:
-	pr_err("no compatible settings for %d\n", target_freq);
-	return -EINVAL;
 }
 
 struct clk *s3c_cpufreq_clk_get(struct device *dev, const char *name)
diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index 6b0cfc3b8c46..4f4e9df9b7fc 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -246,11 +246,8 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
 	new_freq = s5pv210_freq_table[index].frequency;
 
 	/* Finding current running level index */
-	if (cpufreq_frequency_table_target(policy, old_freq, CPUFREQ_RELATION_H,
-					   &priv_index)) {
-		ret = -EINVAL;
-		goto exit;
-	}
+	priv_index = cpufreq_frequency_table_target(policy, old_freq,
+						    CPUFREQ_RELATION_H);
 
 	arm_volt = dvs_conf[index].arm_volt;
 	int_volt = dvs_conf[index].int_volt;
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index bdd7f0c035ae..c378776628b4 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -599,8 +599,7 @@ int cpufreq_generic_frequency_table_verify(struct cpufreq_policy *policy);
 
 int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
 				   unsigned int target_freq,
-				   unsigned int relation,
-				   unsigned int *index);
+				   unsigned int relation);
 int cpufreq_frequency_table_get_index(struct cpufreq_policy *policy,
 		unsigned int freq);
 
-- 
2.7.1.410.g6faf27b

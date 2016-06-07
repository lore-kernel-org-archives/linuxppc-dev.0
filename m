Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rP75g5V49zDqGL
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jun 2016 20:26:31 +1000 (AEST)
Received: by mail-pa0-f45.google.com with SMTP id bz2so44929972pad.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jun 2016 03:26:31 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, steve.muckle@linaro.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V4 2/2] cpufreq: Reuse new freq-table helpers
Date: Tue,  7 Jun 2016 15:55:15 +0530
Message-Id: <ff0bd4e3d9b131ac94044326e26ada22e3cb7e87.1465295033.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1465295033.git.viresh.kumar@linaro.org>
References: <cover.1465295033.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1465295033.git.viresh.kumar@linaro.org>
References: <cover.1465295033.git.viresh.kumar@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch migrates few users of cpufreq tables to the new helpers that
work on sorted freq-tables.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/acpi-cpufreq.c         | 14 ++++----------
 drivers/cpufreq/amd_freq_sensitivity.c |  4 ++--
 drivers/cpufreq/cpufreq_ondemand.c     |  6 ++----
 drivers/cpufreq/powernv-cpufreq.c      |  3 +--
 drivers/cpufreq/s5pv210-cpufreq.c      |  3 +--
 5 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 32a15052f363..11c9a078e0fd 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -468,20 +468,14 @@ unsigned int acpi_cpufreq_fast_switch(struct cpufreq_policy *policy,
 	struct acpi_cpufreq_data *data = policy->driver_data;
 	struct acpi_processor_performance *perf;
 	struct cpufreq_frequency_table *entry;
-	unsigned int next_perf_state, next_freq, freq;
+	unsigned int next_perf_state, next_freq, index;
 
 	/*
 	 * Find the closest frequency above target_freq.
-	 *
-	 * The table is sorted in the reverse order with respect to the
-	 * frequency and all of the entries are valid (see the initialization).
 	 */
-	entry = policy->freq_table;
-	do {
-		entry++;
-		freq = entry->frequency;
-	} while (freq >= target_freq && freq != CPUFREQ_TABLE_END);
-	entry--;
+	index = cpufreq_table_find_index_dl(policy, target_freq);
+
+	entry = &policy->freq_table[index];
 	next_freq = entry->frequency;
 	next_perf_state = entry->driver_data;
 
diff --git a/drivers/cpufreq/amd_freq_sensitivity.c b/drivers/cpufreq/amd_freq_sensitivity.c
index 6d5dc04c3a37..042023bbbf62 100644
--- a/drivers/cpufreq/amd_freq_sensitivity.c
+++ b/drivers/cpufreq/amd_freq_sensitivity.c
@@ -91,8 +91,8 @@ static unsigned int amd_powersave_bias_target(struct cpufreq_policy *policy,
 		else {
 			unsigned int index;
 
-			index = cpufreq_frequency_table_target(policy,
-				policy->cur - 1, CPUFREQ_RELATION_H);
+			index = cpufreq_table_find_index_h(policy,
+							   policy->cur - 1);
 			freq_next = policy->freq_table[index].frequency;
 		}
 
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 0c93cd9dee99..3a1f49f5f4c6 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -85,11 +85,9 @@ static unsigned int generic_powersave_bias_target(struct cpufreq_policy *policy,
 	freq_avg = freq_req - freq_reduc;
 
 	/* Find freq bounds for freq_avg in freq_table */
-	index = cpufreq_frequency_table_target(policy, freq_avg,
-					       CPUFREQ_RELATION_H);
+	index = cpufreq_table_find_index_h(policy, freq_avg);
 	freq_lo = freq_table[index].frequency;
-	index = cpufreq_frequency_table_target(policy, freq_avg,
-					       CPUFREQ_RELATION_L);
+	index = cpufreq_table_find_index_l(policy, freq_avg);
 	freq_hi = freq_table[index].frequency;
 
 	/* Find out how long we have to be in hi and lo freqs */
diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index b29c5c20c3a1..2a2920c4fdf9 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -760,8 +760,7 @@ void powernv_cpufreq_work_fn(struct work_struct *work)
 		struct cpufreq_policy policy;
 
 		cpufreq_get_policy(&policy, cpu);
-		index = cpufreq_frequency_table_target(&policy, policy.cur,
-					       CPUFREQ_RELATION_C);
+		index = cpufreq_table_find_index_c(&policy, policy.cur);
 		powernv_cpufreq_target_index(&policy, index);
 		cpumask_andnot(&mask, &mask, policy.cpus);
 	}
diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index 4f4e9df9b7fc..9e07588ea9f5 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -246,8 +246,7 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
 	new_freq = s5pv210_freq_table[index].frequency;
 
 	/* Finding current running level index */
-	priv_index = cpufreq_frequency_table_target(policy, old_freq,
-						    CPUFREQ_RELATION_H);
+	priv_index = cpufreq_table_find_index_h(policy, old_freq);
 
 	arm_volt = dvs_conf[index].arm_volt;
 	int_volt = dvs_conf[index].int_volt;
-- 
2.7.1.410.g6faf27b

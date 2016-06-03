Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pf0-x230.google.com (mail-pf0-x230.google.com
 [IPv6:2607:f8b0:400e:c00::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rLlV61RmbzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jun 2016 23:35:57 +1000 (AEST)
Received: by mail-pf0-x230.google.com with SMTP id g64so43967845pfb.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jun 2016 06:35:57 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, steve.muckle@linaro.org,
 linuxppc-dev@lists.ozlabs.org,
 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 Kukjin Kim <kgene@kernel.org>, Shawn Guo <shawn.guo@freescale.com>,
 Steven Miao <realmz6@gmail.com>
Subject: [PATCH V3 8/9] cpufreq: Keep policy->freq_table sorted in ascending
 order
Date: Fri,  3 Jun 2016 19:05:14 +0530
Message-Id: <e155257e7f76c3dc71f9347e0433fb1e4d9a3358.1464960877.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1464960877.git.viresh.kumar@linaro.org>
References: <cover.1464960877.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1464960877.git.viresh.kumar@linaro.org>
References: <cover.1464960877.git.viresh.kumar@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The drivers aren't required to provide a sorted frequency table today,
and its not optimal to work on an unsorted frequency tables.

To simplify and improve code performance, always keep policy->freq_table
sorted in ascending order.

Now that freq_table is sorted, update cpufreq_frequency_table_target()
to make it more efficient with help of new helpers.

As these helpers will be used by scheduler hotpath later on, keep them
in a new header cpufreq_table.h to avoid unnecessary function calls.

Also update acpi-cpufreq driver to use the efficient
cpufreq_frequency_table_target() routine, as we can't assume the
descending order of frequencies in freq_table anymore.

Tested on Exynos board with both ondemand and schedutil governor and
confirmed with help of various print messages that we are eventually
switching to the desired frequency based on a target frequency.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 MAINTAINERS                        |   1 +
 drivers/cpufreq/acpi-cpufreq.c     |  16 ++--
 drivers/cpufreq/cpufreq.c          |  20 +++--
 drivers/cpufreq/cpufreq_ondemand.h |   1 +
 drivers/cpufreq/freq_table.c       | 163 +++++++++++++++----------------------
 drivers/cpufreq/powernv-cpufreq.c  |   1 +
 drivers/cpufreq/s3c24xx-cpufreq.c  |   1 +
 drivers/cpufreq/s5pv210-cpufreq.c  |   1 +
 include/linux/cpufreq.h            |   3 -
 include/linux/cpufreq_table.h      | 139 +++++++++++++++++++++++++++++++
 10 files changed, 227 insertions(+), 119 deletions(-)
 create mode 100644 include/linux/cpufreq_table.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7304d2e37a98..315d49d68500 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3205,6 +3205,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 T:	git git://git.linaro.org/people/vireshk/linux.git (For ARM Updates)
 F:	drivers/cpufreq/
 F:	include/linux/cpufreq.h
+F:	include/linux/cpufreq_table.h
 
 CPU FREQUENCY DRIVERS - ARM BIG LITTLE
 M:	Viresh Kumar <viresh.kumar@linaro.org>
diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 32a15052f363..364b86119f3f 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -33,6 +33,7 @@
 #include <linux/smp.h>
 #include <linux/sched.h>
 #include <linux/cpufreq.h>
+#include <linux/cpufreq_table.h>
 #include <linux/compiler.h>
 #include <linux/dmi.h>
 #include <linux/slab.h>
@@ -468,20 +469,15 @@ unsigned int acpi_cpufreq_fast_switch(struct cpufreq_policy *policy,
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
+	index = cpufreq_frequency_table_target(policy, target_freq,
+					       CPUFREQ_RELATION_L);
+
+	entry = &policy->freq_table[index];
 	next_freq = entry->frequency;
 	next_perf_state = entry->driver_data;
 
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 9ae58a18ccb9..91f33bc28fa4 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -19,6 +19,7 @@
 
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
+#include <linux/cpufreq_table.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/init.h>
@@ -1137,6 +1138,16 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy, bool notify)
 	kfree(policy);
 }
 
+static void cpufreq_policy_exit(struct cpufreq_policy *policy)
+{
+	if (!cpufreq_driver->exit)
+		return;
+
+	cpufreq_driver->exit(policy);
+	kfree(policy->freq_table);
+	policy->freq_table = NULL;
+}
+
 static int cpufreq_online(unsigned int cpu)
 {
 	struct cpufreq_policy *policy;
@@ -1291,9 +1302,7 @@ static int cpufreq_online(unsigned int cpu)
 
 out_exit_policy:
 	up_write(&policy->rwsem);
-
-	if (cpufreq_driver->exit)
-		cpufreq_driver->exit(policy);
+	cpufreq_policy_exit(policy);
 out_free_policy:
 	cpufreq_policy_free(policy, !new_policy);
 	return ret;
@@ -1378,10 +1387,7 @@ static void cpufreq_offline(unsigned int cpu)
 	 * since this is a core component, and is essential for the
 	 * subsequent light-weight ->init() to succeed.
 	 */
-	if (cpufreq_driver->exit) {
-		cpufreq_driver->exit(policy);
-		policy->freq_table = NULL;
-	}
+	cpufreq_policy_exit(policy);
 
 unlock:
 	up_write(&policy->rwsem);
diff --git a/drivers/cpufreq/cpufreq_ondemand.h b/drivers/cpufreq/cpufreq_ondemand.h
index 640ea4e97106..dc90c07ace8e 100644
--- a/drivers/cpufreq/cpufreq_ondemand.h
+++ b/drivers/cpufreq/cpufreq_ondemand.h
@@ -9,6 +9,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/cpufreq_table.h>
 #include "cpufreq_governor.h"
 
 struct od_policy_dbs_info {
diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index eac8bcbdaad1..740b3a9fce8e 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -13,6 +13,7 @@
 
 #include <linux/cpufreq.h>
 #include <linux/module.h>
+#include <linux/slab.h>
 
 /*********************************************************************
  *                     FREQUENCY TABLE HELPERS                       *
@@ -113,100 +114,6 @@ int cpufreq_generic_frequency_table_verify(struct cpufreq_policy *policy)
 }
 EXPORT_SYMBOL_GPL(cpufreq_generic_frequency_table_verify);
 
-int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
-				    unsigned int target_freq,
-				    unsigned int relation)
-{
-	struct cpufreq_frequency_table optimal = {
-		.driver_data = ~0,
-		.frequency = 0,
-	};
-	struct cpufreq_frequency_table suboptimal = {
-		.driver_data = ~0,
-		.frequency = 0,
-	};
-	struct cpufreq_frequency_table *pos;
-	struct cpufreq_frequency_table *table = policy->freq_table;
-	unsigned int freq, diff, i = 0;
-	int index;
-
-	pr_debug("request for target %u kHz (relation: %u) for cpu %u\n",
-					target_freq, relation, policy->cpu);
-
-	switch (relation) {
-	case CPUFREQ_RELATION_H:
-		suboptimal.frequency = ~0;
-		break;
-	case CPUFREQ_RELATION_L:
-	case CPUFREQ_RELATION_C:
-		optimal.frequency = ~0;
-		break;
-	}
-
-	cpufreq_for_each_valid_entry(pos, table) {
-		freq = pos->frequency;
-
-		i = pos - table;
-		if ((freq < policy->min) || (freq > policy->max))
-			continue;
-		if (freq == target_freq) {
-			optimal.driver_data = i;
-			break;
-		}
-		switch (relation) {
-		case CPUFREQ_RELATION_H:
-			if (freq < target_freq) {
-				if (freq >= optimal.frequency) {
-					optimal.frequency = freq;
-					optimal.driver_data = i;
-				}
-			} else {
-				if (freq <= suboptimal.frequency) {
-					suboptimal.frequency = freq;
-					suboptimal.driver_data = i;
-				}
-			}
-			break;
-		case CPUFREQ_RELATION_L:
-			if (freq > target_freq) {
-				if (freq <= optimal.frequency) {
-					optimal.frequency = freq;
-					optimal.driver_data = i;
-				}
-			} else {
-				if (freq >= suboptimal.frequency) {
-					suboptimal.frequency = freq;
-					suboptimal.driver_data = i;
-				}
-			}
-			break;
-		case CPUFREQ_RELATION_C:
-			diff = abs(freq - target_freq);
-			if (diff < optimal.frequency ||
-			    (diff == optimal.frequency &&
-			     freq > table[optimal.driver_data].frequency)) {
-				optimal.frequency = diff;
-				optimal.driver_data = i;
-			}
-			break;
-		}
-	}
-	if (optimal.driver_data > i) {
-		if (suboptimal.driver_data > i) {
-			WARN(1, "Invalid frequency table: %d\n", policy->cpu);
-			return 0;
-		}
-
-		index = suboptimal.driver_data;
-	} else
-		index = optimal.driver_data;
-
-	pr_debug("target index is %u, freq is:%u kHz\n", index,
-		 table[index].frequency);
-	return index;
-}
-EXPORT_SYMBOL_GPL(cpufreq_frequency_table_target);
-
 int cpufreq_frequency_table_get_index(struct cpufreq_policy *policy,
 		unsigned int freq)
 {
@@ -297,15 +204,73 @@ struct freq_attr *cpufreq_generic_attr[] = {
 };
 EXPORT_SYMBOL_GPL(cpufreq_generic_attr);
 
+static int next_larger(struct cpufreq_policy *policy, unsigned int freq,
+		       struct cpufreq_frequency_table *table)
+{
+	struct cpufreq_frequency_table *pos;
+	unsigned int next_freq = ~0;
+	int index = -EINVAL;
+
+	cpufreq_for_each_valid_entry(pos, table) {
+		if (pos->frequency <= freq)
+			continue;
+
+		if (next_freq > pos->frequency) {
+			next_freq = pos->frequency;
+			index = pos - table;
+		}
+	}
+
+	return index;
+}
+
+static int create_sorted_freq_table(struct cpufreq_policy *policy,
+				    struct cpufreq_frequency_table *table)
+{
+	struct cpufreq_frequency_table *pos, *new_table;
+	unsigned int freq, index, i, count = 0;
+
+	cpufreq_for_each_valid_entry(pos, table)
+		count++;
+
+	/* Extra entry for CPUFREQ_TABLE_END */
+	count++;
+
+	new_table = kmalloc_array(count, sizeof(*new_table), GFP_KERNEL);
+	if (!new_table)
+		return -ENOMEM;
+
+	for (i = 0, freq = 0; i < count - 1; i++) {
+		index = next_larger(policy, freq, table);
+		if (index == -EINVAL)
+			break;
+
+		new_table[i].frequency = table[index].frequency;
+		new_table[i].driver_data = table[index].driver_data;
+		new_table[i].flags = table[index].flags;
+
+		freq = table[index].frequency;
+	}
+
+	new_table[i].frequency = CPUFREQ_TABLE_END;
+	policy->freq_table = new_table;
+
+	return 0;
+}
+
 int cpufreq_table_validate_and_show(struct cpufreq_policy *policy,
-				      struct cpufreq_frequency_table *table)
+				    struct cpufreq_frequency_table *table)
 {
-	int ret = cpufreq_frequency_table_cpuinfo(policy, table);
+	int ret;
+
+	if (!table)
+		return -EINVAL;
 
-	if (!ret)
-		policy->freq_table = table;
+	ret = cpufreq_frequency_table_cpuinfo(policy, table);
+	if (ret)
+		return ret;
 
-	return ret;
+	return create_sorted_freq_table(policy, table);
 }
 EXPORT_SYMBOL_GPL(cpufreq_table_validate_and_show);
 
diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index b29c5c20c3a1..06c0f39d0133 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -24,6 +24,7 @@
 #include <linux/cpumask.h>
 #include <linux/module.h>
 #include <linux/cpufreq.h>
+#include <linux/cpufreq_table.h>
 #include <linux/smp.h>
 #include <linux/of.h>
 #include <linux/reboot.h>
diff --git a/drivers/cpufreq/s3c24xx-cpufreq.c b/drivers/cpufreq/s3c24xx-cpufreq.c
index 7b596fa38ad2..1ff12e869e02 100644
--- a/drivers/cpufreq/s3c24xx-cpufreq.c
+++ b/drivers/cpufreq/s3c24xx-cpufreq.c
@@ -17,6 +17,7 @@
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/cpufreq.h>
+#include <linux/cpufreq_table.h>
 #include <linux/cpu.h>
 #include <linux/clk.h>
 #include <linux/err.h>
diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index 4f4e9df9b7fc..89e0ae4c7b11 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -18,6 +18,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/cpufreq.h>
+#include <linux/cpufreq_table.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index c378776628b4..ee23b25b6c61 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -597,9 +597,6 @@ int cpufreq_frequency_table_verify(struct cpufreq_policy *policy,
 				   struct cpufreq_frequency_table *table);
 int cpufreq_generic_frequency_table_verify(struct cpufreq_policy *policy);
 
-int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
-				   unsigned int target_freq,
-				   unsigned int relation);
 int cpufreq_frequency_table_get_index(struct cpufreq_policy *policy,
 		unsigned int freq);
 
diff --git a/include/linux/cpufreq_table.h b/include/linux/cpufreq_table.h
new file mode 100644
index 000000000000..a3e4a09ac58f
--- /dev/null
+++ b/include/linux/cpufreq_table.h
@@ -0,0 +1,139 @@
+/*
+ * linux/include/linux/cpufreq_table.h
+ *
+ * Copyright (C) 2016 Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef _LINUX_CPUFREQ_TABLE_H
+#define _LINUX_CPUFREQ_TABLE_H
+
+#include <linux/cpufreq.h>
+
+static inline int cpufreq_find_index_l(struct cpufreq_policy *policy,
+				       unsigned int target_freq)
+{
+	struct cpufreq_frequency_table *table = policy->freq_table;
+	struct cpufreq_frequency_table *pos, *best = NULL;
+	unsigned int freq;
+
+	cpufreq_for_each_valid_entry(pos, table) {
+		freq = pos->frequency;
+
+		if ((freq < policy->min) || (freq > policy->max))
+			continue;
+
+		if (freq >= target_freq)
+			return pos - table;
+
+		best = pos;
+	}
+
+	if (best)
+		return best - table;
+
+	return -EINVAL;
+}
+
+static inline int cpufreq_find_index_h(struct cpufreq_policy *policy,
+				       unsigned int target_freq)
+{
+	struct cpufreq_frequency_table *table = policy->freq_table;
+	struct cpufreq_frequency_table *pos, *best = NULL;
+	unsigned int freq;
+
+	cpufreq_for_each_valid_entry(pos, table) {
+		freq = pos->frequency;
+
+		if ((freq < policy->min) || (freq > policy->max))
+			continue;
+
+		if (freq == target_freq)
+			return pos - table;
+
+		if (freq < target_freq) {
+			best = pos;
+			continue;
+		}
+
+		/* No freq found below target_freq */
+		if (!best)
+			best = pos;
+		break;
+	}
+
+	if (best)
+		return best - table;
+
+	return -EINVAL;
+}
+
+static inline int cpufreq_find_index_c(struct cpufreq_policy *policy,
+				       unsigned int target_freq)
+{
+	struct cpufreq_frequency_table *table = policy->freq_table;
+	struct cpufreq_frequency_table *pos, *best = NULL;
+	unsigned int freq;
+
+	cpufreq_for_each_valid_entry(pos, table) {
+		freq = pos->frequency;
+
+		if ((freq < policy->min) || (freq > policy->max))
+			continue;
+
+		if (freq == target_freq)
+			return pos - table;
+
+		if (freq < target_freq) {
+			best = pos;
+			continue;
+		}
+
+		/* No freq found below target_freq */
+		if (!best) {
+			best = pos;
+			break;
+		}
+
+		/* Choose the closest freq */
+		if (target_freq - best->frequency > freq - target_freq)
+			best = pos;
+
+		break;
+	}
+
+	if (best)
+		return best - table;
+
+	return -EINVAL;
+}
+
+static inline int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
+						 unsigned int target_freq,
+						 unsigned int relation)
+{
+	int index;
+
+	switch (relation) {
+	case CPUFREQ_RELATION_L:
+		index = cpufreq_find_index_l(policy, target_freq);
+		break;
+	case CPUFREQ_RELATION_H:
+		index = cpufreq_find_index_h(policy, target_freq);
+		break;
+	case CPUFREQ_RELATION_C:
+		index = cpufreq_find_index_c(policy, target_freq);
+		break;
+	default:
+		pr_err("%s: Invalid relation: %d\n", __func__, relation);
+		return -EINVAL;
+	}
+
+	if (index == -EINVAL)
+		WARN(1, "Invalid frequency table: %d\n", policy->cpu);
+
+	return index;
+}
+#endif /* _LINUX_CPUFREQ_TABLE_H */
-- 
2.7.1.410.g6faf27b

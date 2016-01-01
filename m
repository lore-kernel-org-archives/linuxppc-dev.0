Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 034881A114D
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jan 2016 09:23:02 +1100 (AEDT)
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 395E31400CB
 for <linuxppc-dev@ozlabs.org>; Sat,  2 Jan 2016 09:23:01 +1100 (AEDT)
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Sat, 2 Jan 2016 03:52:59 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 9C1E31258059
 for <linuxppc-dev@ozlabs.org>; Sat,  2 Jan 2016 03:53:37 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u01MMs0L8061204
 for <linuxppc-dev@ozlabs.org>; Sat, 2 Jan 2016 03:52:54 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u01MMrLo031783
 for <linuxppc-dev@ozlabs.org>; Sat, 2 Jan 2016 03:52:54 +0530
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 pc@us.ibm.com, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v2 2/2] cpufreq: powernv: Redesign the presentation of
 throttle notification
Date: Sat,  2 Jan 2016 03:51:54 +0530
Message-Id: <1451686914-3761-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
In-Reply-To: <1451686914-3761-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1451686914-3761-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Replace the throttling event console messages to perf trace point
"power:powernv_throttle" and throttle counter stats which are
exported in sysfs in /sys/devices/system/cpu/cpufreq/chipN. The
newly added sysfs files are as follows:

1)/sys/devices/system/cpu/cpufreq/chip0/throttle_frequencies
  This gives the throttle stats for each of the available frequencies.
  The throttle stat of a frequency is the total number of times the max
  frequency is reduced to that frequency.
  # cat /sys/devices/system/cpu/cpufreq/chip0/throttle_frequencies
  4023000 0
  3990000 0
  3956000 1
  3923000 0
  3890000 0
  3857000 2
  3823000 0
  3790000 0
  3757000 2
  3724000 1
  3690000 1
  ...

2)/sys/devices/system/cpu/cpufreq/chip0/throttle_reasons
  This directory contains throttle reason files. Each file gives the
  total number of times the max frequency is throttled, except for
  'throttle_reset', which gives the total number of times the max
  frequency is unthrottled after being throttled.
  # cd /sys/devices/system/cpu/cpufreq/chip0/throttle_reasons
  # cat cpu_over_temperature
  7
  # cat occ_reset
  0
  # cat over_current
  0
  # cat power_cap
  0
  # cat power_supply_failure
  0
  # cat throttle_reset
  7

3)/sys/devices/system/cpu/cpufreq/chip0/throttle_stat
  This gives the total number of events of max frequency throttling to
  lower frequencies in the turbo range of frequencies and the sub-turbo(at
  and below nominal) range of frequencies.
  # cat /sys/devices/system/cpu/cpufreq/chip0/throttle_stat
  turbo 7
  sub-turbo 0

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
Changes from v1:
- Added a kobject to struct chip
- Grouped the throttle reasons under a separate attribute_group and
  exported each reason as individual file.
- Moved the sysfs files from /sys/devices/system/node/nodeN to
  /sys/devices/system/cpu/cpufreq/chipN
- As suggested by Paul Clarke replaced 'Nominal' with 'sub-turbo' and
  char * throttle_reason[][30] by const char * const throttle_reason[].
- Modified the commit message.

 drivers/cpufreq/powernv-cpufreq.c | 247 +++++++++++++++++++++++++++++++-------
 1 file changed, 204 insertions(+), 43 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index cb50138..00caef1 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -28,6 +28,7 @@
 #include <linux/of.h>
 #include <linux/reboot.h>
 #include <linux/slab.h>
+#include <trace/events/power.h>
 
 #include <asm/cputhreads.h>
 #include <asm/firmware.h>
@@ -43,12 +44,37 @@
 static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
 static bool rebooting, throttled, occ_reset;
 
+static const char * const throttle_reason[] = {
+	"No throttling",
+	"Power Cap",
+	"Processor Over Temperature",
+	"Power Supply Failure",
+	"Over Current",
+	"OCC Reset"
+};
+
+enum throt_reason_type {
+	NO_THROTTLE = 0,
+	POWERCAP,
+	CPU_OVERTEMP,
+	POWER_SUPPLY_FAILURE,
+	OVERCURRENT,
+	OCC_RESET_THROTTLE
+};
+
 static struct chip {
 	unsigned int id;
 	bool throttled;
 	cpumask_t mask;
 	struct work_struct throttle;
 	bool restore;
+	/* Pmax throttle stats */
+	int throt_reason;
+	int throt_turbo;
+	int throt_nominal;
+	int reason[OCC_MAX_THROTTLE_STATUS + 1];
+	int *pstate_stat;
+	struct kobject *kobj;
 } *chips;
 
 static int nr_chips;
@@ -309,11 +335,11 @@ static inline unsigned int get_nominal_index(void)
 	return powernv_pstate_info.max - powernv_pstate_info.nominal;
 }
 
-static void powernv_cpufreq_throttle_check(void *data)
+static void powernv_cpufreq_read_pmax(void *data)
 {
 	unsigned int cpu = smp_processor_id();
 	unsigned long pmsr;
-	int pmsr_pmax, i;
+	int pmsr_pmax, i, index;
 
 	pmsr = get_pmspr(SPRN_PMSR);
 
@@ -321,28 +347,43 @@ static void powernv_cpufreq_throttle_check(void *data)
 		if (chips[i].id == cpu_to_chip_id(cpu))
 			break;
 
-	/* Check for Pmax Capping */
 	pmsr_pmax = (s8)PMSR_MAX(pmsr);
 	if (pmsr_pmax != powernv_pstate_info.max) {
 		if (chips[i].throttled)
-			goto next;
+			return;
 		chips[i].throttled = true;
-		if (pmsr_pmax < powernv_pstate_info.nominal)
-			pr_crit("CPU %d on Chip %u has Pmax reduced below nominal frequency (%d < %d)\n",
-				cpu, chips[i].id, pmsr_pmax,
+		if (pmsr_pmax < powernv_pstate_info.nominal) {
+			pr_warn_once("CPU %d on Chip %u has Pmax reduced below nominal frequency (%d < %d)\n",
+				     cpu, chips[i].id, pmsr_pmax,
 				powernv_pstate_info.nominal);
-		else
-			pr_info("CPU %d on Chip %u has Pmax reduced below turbo frequency (%d < %d)\n",
-				cpu, chips[i].id, pmsr_pmax,
-				powernv_pstate_info.max);
+			chips[i].throt_nominal++;
+		} else {
+			chips[i].throt_turbo++;
+		}
+		index  = powernv_pstate_info.max - pmsr_pmax;
+		if (index >= 0 && index < powernv_pstate_info.nr_pstates)
+			chips[i].pstate_stat[index]++;
+		trace_powernv_throttle(chips[i].id,
+				       throttle_reason[chips[i].throt_reason],
+				       pmsr_pmax);
 	} else if (chips[i].throttled) {
 		chips[i].throttled = false;
-		pr_info("CPU %d on Chip %u has Pmax restored to %d\n", cpu,
-			chips[i].id, pmsr_pmax);
+		trace_powernv_throttle(chips[i].id,
+				       throttle_reason[chips[i].throt_reason],
+				       pmsr_pmax);
 	}
+}
+
+static void powernv_cpufreq_throttle_check(void *data)
+{
+	unsigned long pmsr;
+
+	pmsr = get_pmspr(SPRN_PMSR);
+
+	/* Check for Pmax Capping */
+	powernv_cpufreq_read_pmax(NULL);
 
 	/* Check if Psafe_mode_active is set in PMSR. */
-next:
 	if (pmsr & PMSR_PSAFE_ENABLE) {
 		throttled = true;
 		pr_info("Pstate set to safe frequency\n");
@@ -356,7 +397,7 @@ next:
 
 	if (throttled) {
 		pr_info("PMSR = %16lx\n", pmsr);
-		pr_crit("CPU Frequency could be throttled\n");
+		pr_warn("CPU Frequency could be throttled\n");
 	}
 }
 
@@ -447,15 +488,6 @@ void powernv_cpufreq_work_fn(struct work_struct *work)
 	}
 }
 
-static char throttle_reason[][30] = {
-					"No throttling",
-					"Power Cap",
-					"Processor Over Temperature",
-					"Power Supply Failure",
-					"Over Current",
-					"OCC Reset"
-				     };
-
 static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
 				   unsigned long msg_type, void *_msg)
 {
@@ -481,7 +513,7 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
 		 */
 		if (!throttled) {
 			throttled = true;
-			pr_crit("CPU frequency is throttled for duration\n");
+			pr_warn("CPU frequency is throttled for duration\n");
 		}
 
 		break;
@@ -505,23 +537,19 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
 			return 0;
 		}
 
-		if (omsg.throttle_status &&
-		    omsg.throttle_status <= OCC_MAX_THROTTLE_STATUS)
-			pr_info("OCC: Chip %u Pmax reduced due to %s\n",
-				(unsigned int)omsg.chip,
-				throttle_reason[omsg.throttle_status]);
-		else if (!omsg.throttle_status)
-			pr_info("OCC: Chip %u %s\n", (unsigned int)omsg.chip,
-				throttle_reason[omsg.throttle_status]);
-		else
-			return 0;
-
 		for (i = 0; i < nr_chips; i++)
-			if (chips[i].id == omsg.chip) {
-				if (!omsg.throttle_status)
-					chips[i].restore = true;
-				schedule_work(&chips[i].throttle);
-			}
+			if (chips[i].id == omsg.chip)
+				break;
+		if (omsg.throttle_status >= 0 &&
+		    omsg.throttle_status <= OCC_MAX_THROTTLE_STATUS) {
+			chips[i].reason[omsg.throttle_status]++;
+			chips[i].throt_reason = omsg.throttle_status;
+		}
+
+		if (!omsg.throttle_status)
+			chips[i].restore = true;
+
+		schedule_work(&chips[i].throttle);
 	}
 	return 0;
 }
@@ -532,6 +560,101 @@ static struct notifier_block powernv_cpufreq_opal_nb = {
 	.priority	= 0,
 };
 
+static ssize_t throttle_freq_show(struct kobject *kobj,
+				  struct kobj_attribute *attr, char *buf)
+{
+	int i, count = 0, id;
+
+	kstrtoint(kobj->name + 4, 0, &id);
+	for (i = 0; i < nr_chips; i++)
+		if (chips[i].id == id)
+			break;
+	id = i;
+	for (i = 0; i < powernv_pstate_info.nr_pstates; i++)
+		count += sprintf(&buf[count], "%d %d\n",
+				powernv_freqs[i].frequency,
+				chips[id].pstate_stat[i]);
+
+	return count;
+}
+
+static struct kobj_attribute attr_throttle_frequencies =
+__ATTR(throttle_frequencies, 0444, throttle_freq_show, NULL);
+
+static ssize_t throttle_stat_show(struct kobject *kobj,
+				  struct kobj_attribute *attr, char *buf)
+{
+	int i, count = 0, id;
+
+	kstrtoint(kobj->name + 4, 0, &id);
+	for (i = 0; i < nr_chips; i++)
+		if (chips[i].id == id)
+			break;
+
+	count += sprintf(&buf[count], "turbo %d\n", chips[i].throt_turbo);
+	count += sprintf(&buf[count], "sub-turbo %d\n", chips[i].throt_nominal);
+
+	return count;
+}
+
+static struct kobj_attribute attr_throttle_stat =
+__ATTR(throttle_stat, 0444, throttle_stat_show, NULL);
+
+#define define_throttle_reason_attr(attr_name, val)			   \
+static ssize_t attr_name##_show(struct kobject *kobj,			   \
+				   struct kobj_attribute *attr, char *buf) \
+{									   \
+	int i, id;							   \
+									   \
+	kstrtoint(kobj->name + 4, 0, &id);				   \
+	for (i = 0; i < nr_chips; i++)					   \
+		if (chips[i].id == id)					   \
+			break;						   \
+									   \
+	return sprintf(buf, "%d\n", chips[i].reason[val]);		   \
+}									   \
+									   \
+static struct kobj_attribute attr_##attr_name =				   \
+__ATTR(attr_name, 0444, attr_name##_show, NULL)
+
+define_throttle_reason_attr(throttle_reset, NO_THROTTLE);
+define_throttle_reason_attr(power_cap, POWERCAP);
+define_throttle_reason_attr(cpu_over_temperature, CPU_OVERTEMP);
+define_throttle_reason_attr(power_supply_failure, POWER_SUPPLY_FAILURE);
+define_throttle_reason_attr(over_current, OVERCURRENT);
+define_throttle_reason_attr(occ_reset, OCC_RESET_THROTTLE);
+
+static struct attribute *throttle_reason_attrs[] = {
+	&attr_throttle_reset.attr,
+	&attr_power_cap.attr,
+	&attr_cpu_over_temperature.attr,
+	&attr_power_supply_failure.attr,
+	&attr_over_current.attr,
+	&attr_occ_reset.attr,
+	NULL
+};
+
+static struct attribute *throttle_stat_attrs[] = {
+	&attr_throttle_frequencies.attr,
+	&attr_throttle_stat.attr,
+	NULL
+};
+
+static const struct attribute_group throttle_reason_group = {
+	.name	= "throttle_reasons",
+	.attrs	= throttle_reason_attrs,
+};
+
+static const struct attribute_group throttle_stat_group = {
+	.attrs = throttle_stat_attrs,
+};
+
+static const struct attribute_group *throttle_attr_groups[] = {
+	&throttle_stat_group,
+	&throttle_reason_group,
+	NULL
+};
+
 static void powernv_cpufreq_stop_cpu(struct cpufreq_policy *policy)
 {
 	struct powernv_smp_call_data freq_data;
@@ -556,6 +679,7 @@ static int init_chip_info(void)
 	unsigned int chip[256];
 	unsigned int cpu, i;
 	unsigned int prev_chip_id = UINT_MAX;
+	int ret = -ENOMEM;
 
 	for_each_possible_cpu(cpu) {
 		unsigned int id = cpu_to_chip_id(cpu);
@@ -566,19 +690,47 @@ static int init_chip_info(void)
 		}
 	}
 
-	chips = kmalloc_array(nr_chips, sizeof(struct chip), GFP_KERNEL);
+	chips = kcalloc(nr_chips, sizeof(struct chip), GFP_KERNEL);
 	if (!chips)
-		return -ENOMEM;
+		goto out;
 
 	for (i = 0; i < nr_chips; i++) {
+		char name[10];
+
 		chips[i].id = chip[i];
 		chips[i].throttled = false;
 		cpumask_copy(&chips[i].mask, cpumask_of_node(chip[i]));
 		INIT_WORK(&chips[i].throttle, powernv_cpufreq_work_fn);
 		chips[i].restore = false;
+		chips[i].pstate_stat = kcalloc(powernv_pstate_info.nr_pstates,
+						sizeof(int), GFP_KERNEL);
+		if (!chips[i].pstate_stat)
+			goto free;
+
+		sprintf(name, "chip%d", chips[i].id);
+		chips[i].kobj = kobject_create_and_add(name,
+						       cpufreq_global_kobject);
+		if (!chips[i].kobj)
+			goto free;
+
+		ret = sysfs_create_groups(chips[i].kobj, throttle_attr_groups);
+		if (ret) {
+			pr_info("Chip %d failed to create throttle sysfs group\n",
+				chips[i].id);
+			goto free;
+		}
 	}
 
 	return 0;
+free:
+	nr_chips = i;
+	for (i = 0; i <= nr_chips; i++) {
+		kobject_put(chips[i].kobj);
+		kfree(chips[i].pstate_stat);
+	}
+	kfree(chips);
+out:
+	return ret;
 }
 
 static int __init powernv_cpufreq_init(void)
@@ -609,9 +761,18 @@ module_init(powernv_cpufreq_init);
 
 static void __exit powernv_cpufreq_exit(void)
 {
+	int i;
+
 	unregister_reboot_notifier(&powernv_cpufreq_reboot_nb);
 	opal_message_notifier_unregister(OPAL_MSG_OCC,
 					 &powernv_cpufreq_opal_nb);
+
+	for (i = 0; i < nr_chips; i++) {
+		kobject_put(chips[i].kobj);
+		kfree(chips[i].pstate_stat);
+	}
+	kfree(chips);
+
 	cpufreq_unregister_driver(&powernv_cpufreq_driver);
 }
 module_exit(powernv_cpufreq_exit);
-- 
1.9.3

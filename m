Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1AF4F1A1819
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jan 2016 18:20:24 +1100 (AEDT)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DA0411402DE
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Jan 2016 18:20:23 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Fri, 22 Jan 2016 17:20:22 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 7BB152CE8056
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Jan 2016 18:20:20 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0M7KCZ352887758
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Jan 2016 18:20:20 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0M7Jlq1023880
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Jan 2016 18:19:48 +1100
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 pc@us.ibm.com, anton@samba.org, ego@linux.vnet.ibm.com,
 shreyas@linux.vnet.ibm.com,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v6 5/5] cpufreq: powernv: Add sysfs attributes to show
 throttle stats
Date: Fri, 22 Jan 2016 12:49:05 +0530
Message-Id: <1453447145-17722-6-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
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

Create sysfs attributes to export throttle information in
/sys/devices/system/cpu/cpufreq/chipN. The newly added sysfs files are as
follows:

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
Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
No changes from v5.

Changes from v4:
- Taken care of Gautham's comments to use inline get_chip_index()

Changes from v3:
- Seperate the patch to contain only the throttle sysfs attribute changes.
- Add helper inline function get_chip_index()

Changes from v2:
- Fixed kbuild test warning.
drivers/cpufreq/powernv-cpufreq.c:609:2: warning: ignoring return
value of 'kstrtoint', declared with attribute warn_unused_result
[-Wunused-result]

Changes from v1:
- Added a kobject to struct chip
- Grouped the throttle reasons under a separate attribute_group and
  exported each reason as individual file.
- Moved the sysfs files from /sys/devices/system/node/nodeN to
  /sys/devices/system/cpu/cpufreq/chipN
- As suggested by Paul Clarke replaced 'Nominal' with 'sub-turbo'.

 drivers/cpufreq/powernv-cpufreq.c | 205 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 196 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 2d09274..7d65c82 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -55,6 +55,16 @@ static const char * const throttle_reason[] = {
 	"OCC Reset"
 };
 
+enum throt_reason_type {
+	NO_THROTTLE = 0,
+	POWERCAP,
+	CPU_OVERTEMP,
+	POWER_SUPPLY_FAILURE,
+	OVERCURRENT,
+	OCC_RESET_THROTTLE,
+	OCC_MAX_REASON
+};
+
 static struct chip {
 	unsigned int id;
 	bool throttled;
@@ -62,6 +72,11 @@ static struct chip {
 	u8 throt_reason;
 	cpumask_t mask;
 	struct work_struct throttle;
+	int throt_turbo;
+	int throt_nominal;
+	int reason[OCC_MAX_REASON];
+	int *pstate_stat;
+	struct kobject *kobj;
 } *chips;
 
 static int nr_chips;
@@ -196,6 +211,128 @@ static struct freq_attr *powernv_cpu_freq_attr[] = {
 	NULL,
 };
 
+static inline int get_chip_index(unsigned int id)
+{
+	int i;
+
+	for (i = 0; i < nr_chips; i++)
+		if (chips[i].id == id)
+			return i;
+
+	return -EINVAL;
+}
+
+static ssize_t throttle_freq_show(struct kobject *kobj,
+				  struct kobj_attribute *attr, char *buf)
+{
+	int i, count = 0, id;
+
+	i = kstrtoint(kobj->name + 4, 0, &id);
+	if (i)
+		return i;
+
+	id = get_chip_index(id);
+	if (id < 0) {
+		pr_warn_once("%s Matching chip-id not found\n", __func__);
+		return id;
+	}
+
+	for (i = 0; i < powernv_pstate_info.nr_pstates; i++)
+		count += sprintf(&buf[count], "%d %d\n",
+			       powernv_freqs[i].frequency,
+			       chips[id].pstate_stat[i]);
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
+	int ret, id, count = 0;
+
+	ret = kstrtoint(kobj->name + 4, 0, &id);
+	if (ret)
+		return ret;
+
+	id = get_chip_index(id);
+	if (id < 0) {
+		pr_warn_once("%s Matching chip-id not found\n", __func__);
+		return id;
+	}
+
+	count += sprintf(&buf[count], "turbo %d\n", chips[id].throt_turbo);
+	count += sprintf(&buf[count], "sub-turbo %d\n",
+					chips[id].throt_nominal);
+
+	return count;
+}
+
+static struct kobj_attribute attr_throttle_stat =
+__ATTR(throttle_stat, 0444, throttle_stat_show, NULL);
+
+#define define_throttle_reason_attr(attr_name, val)			  \
+static ssize_t attr_name##_show(struct kobject *kobj,			  \
+				  struct kobj_attribute *attr, char *buf) \
+{									  \
+	int ret, id;							  \
+									  \
+	ret = kstrtoint(kobj->name + 4, 0, &id);			  \
+	if (ret)							  \
+		return ret;						  \
+									  \
+	id = get_chip_index(id);					  \
+	if (id < 0) {							  \
+		pr_warn_once("%s Matching chip-id not found\n", __func__);\
+		return id;						  \
+	}								  \
+									  \
+	return sprintf(buf, "%d\n", chips[id].reason[val]);		  \
+}									  \
+									  \
+static struct kobj_attribute attr_##attr_name =				  \
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
+	.name   = "throttle_reasons",
+	.attrs  = throttle_reason_attrs,
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
 /* Helper routines */
 
 /* Access helpers to power mgt SPR */
@@ -327,13 +464,15 @@ static void powernv_cpufreq_throttle_check(void *data)
 	unsigned int cpu = smp_processor_id();
 	unsigned int chip_id = core_to_chip_map[cpu_core_index_of_thread(cpu)];
 	unsigned long pmsr;
-	int pmsr_pmax, i;
+	int pmsr_pmax, i, index;
 
 	pmsr = get_pmspr(SPRN_PMSR);
 
-	for (i = 0; i < nr_chips; i++)
-		if (chips[i].id == chip_id)
-			break;
+	i = get_chip_index(chip_id);
+	if (unlikely(i < 0)) {
+		pr_warn_once("%s Matching chip-id not found\n", __func__);
+		return;
+	}
 
 	/* Check for Pmax Capping */
 	pmsr_pmax = (s8)PMSR_MAX(pmsr);
@@ -341,10 +480,19 @@ static void powernv_cpufreq_throttle_check(void *data)
 		if (chips[i].throttled)
 			goto next;
 		chips[i].throttled = true;
-		if (pmsr_pmax < powernv_pstate_info.nominal)
+		if (pmsr_pmax < powernv_pstate_info.nominal) {
 			pr_warn_once("CPU %d on Chip %u has Pmax reduced below nominal frequency (%d < %d)\n",
 				     cpu, chips[i].id, pmsr_pmax,
 				     powernv_pstate_info.nominal);
+			chips[i].throt_nominal++;
+		} else {
+			chips[i].throt_turbo++;
+		}
+
+		index  = powernv_pstate_info.max - pmsr_pmax;
+		if (index >= 0 && index < powernv_pstate_info.nr_pstates)
+			chips[i].pstate_stat[index]++;
+
 		trace_powernv_throttle(chips[i].id,
 				       throttle_reason[chips[i].throt_reason],
 				       pmsr_pmax);
@@ -512,13 +660,18 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
 			return 0;
 		}
 
-		for (i = 0; i < nr_chips; i++)
-			if (chips[i].id == omsg.chip)
-				break;
+		i = get_chip_index(omsg.chip);
+		if (i < 0) {
+			pr_warn_once("%s Matching chip-id not found\n",
+				     __func__);
+			return i;
+		}
 
 		if (omsg.throttle_status >= 0 &&
-		    omsg.throttle_status <= OCC_MAX_THROTTLE_STATUS)
+		    omsg.throttle_status <= OCC_MAX_THROTTLE_STATUS) {
 			chips[i].throt_reason = omsg.throttle_status;
+			chips[i].reason[omsg.throttle_status]++;
+		}
 
 		if (!omsg.throttle_status)
 			chips[i].restore = true;
@@ -583,12 +736,38 @@ static int init_chip_info(void)
 		goto free_chip_map;
 
 	for (i = 0; i < nr_chips; i++) {
+		char name[10];
+
 		chips[i].id = chip[i];
 		cpumask_copy(&chips[i].mask, cpumask_of_node(chip[i]));
 		INIT_WORK(&chips[i].throttle, powernv_cpufreq_work_fn);
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
 free_chip_map:
 	kfree(core_to_chip_map);
 out:
@@ -623,9 +802,17 @@ module_init(powernv_cpufreq_init);
 
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
+
 	kfree(chips);
 	kfree(core_to_chip_map);
 	cpufreq_unregister_driver(&powernv_cpufreq_driver);
-- 
1.9.3

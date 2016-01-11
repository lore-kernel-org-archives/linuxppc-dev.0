Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 535B91A17BB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 07:57:14 +1100 (AEDT)
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D4BE2140779
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2016 07:57:12 +1100 (AEDT)
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Tue, 12 Jan 2016 02:27:10 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id A982A394005E
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2016 02:27:07 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0BKv66760751954
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2016 02:27:07 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0BKv6D9025132
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2016 02:27:06 +0530
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 pc@us.ibm.com, anton@samba.org, ego@linux.vnet.ibm.com,
 <stable@vger.kernel.org>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v4 4/4] cpufreq: powernv: Add sysfs attributes to show
 throttle stats
Date: Mon, 11 Jan 2016 14:54:40 -0600
Message-Id: <1452545680-11976-5-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
In-Reply-To: <1452545680-11976-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1451899527-14359-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1452545680-11976-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
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
---
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
- Modified the commit message.

 drivers/cpufreq/powernv-cpufreq.c | 177 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 173 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index c98a6e7..40ccd9d 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -54,6 +54,16 @@ static const char * const throttle_reason[] = {
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
@@ -61,6 +71,11 @@ static struct chip {
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
@@ -195,6 +210,113 @@ static struct freq_attr *powernv_cpu_freq_attr[] = {
 	NULL,
 };
 
+static inline int get_chip_index(struct kobject *kobj)
+{
+	int i, id;
+
+	i = kstrtoint(kobj->name + 4, 0, &id);
+	if (i)
+		return i;
+
+	for (i = 0; i < nr_chips; i++)
+		if (chips[i].id == id)
+			return i;
+	return -EINVAL;
+}
+
+static ssize_t throttle_freq_show(struct kobject *kobj,
+				  struct kobj_attribute *attr, char *buf)
+{
+	int i, count = 0, id;
+
+	id = get_chip_index(kobj);
+	if (id < 0)
+		return id;
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
+	int id, count = 0;
+
+	id = get_chip_index(kobj);
+	if (id < 0)
+		return id;
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
+	int id;								  \
+									  \
+	id = get_chip_index(kobj);					  \
+	if (id < 0)							  \
+		return id;						  \
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
@@ -325,7 +447,7 @@ static void powernv_cpufreq_check_pmax(void)
 {
 	unsigned int cpu = smp_processor_id();
 	unsigned int chip_id = pir_to_chip_id(hard_smp_processor_id());
-	int pmsr_pmax, i;
+	int pmsr_pmax, i, index;
 
 	pmsr_pmax = (s8)PMSR_MAX(get_pmspr(SPRN_PMSR));
 
@@ -338,10 +460,18 @@ static void powernv_cpufreq_check_pmax(void)
 			return;
 
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
 
 		trace_powernv_throttle(chips[i].id,
 				       throttle_reason[chips[i].throt_reason],
@@ -522,8 +652,10 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
 				break;
 
 		if (omsg.throttle_status >= 0 &&
-		    omsg.throttle_status <= OCC_MAX_THROTTLE_STATUS)
+		    omsg.throttle_status <= OCC_MAX_THROTTLE_STATUS) {
 			chips[i].throt_reason = omsg.throttle_status;
+			chips[i].reason[omsg.throttle_status]++;
+		}
 
 		if (!omsg.throttle_status)
 			chips[i].restore = true;
@@ -563,6 +695,7 @@ static int init_chip_info(void)
 	unsigned int chip[256];
 	unsigned int cpu, i;
 	unsigned int prev_chip_id = UINT_MAX;
+	int ret = -ENOMEM;
 
 	for_each_possible_cpu(cpu) {
 		unsigned int id =
@@ -576,15 +709,43 @@ static int init_chip_info(void)
 
 	chips = kcalloc(nr_chips, sizeof(struct chip), GFP_KERNEL);
 	if (!chips)
-		return -ENOMEM;
+		goto out;
 
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
+out:
+	return ret;
 }
 
 static int __init powernv_cpufreq_init(void)
@@ -615,9 +776,17 @@ module_init(powernv_cpufreq_init);
 
 static void __exit powernv_cpufreq_exit(void)
 {
+	int i;
+
 	unregister_reboot_notifier(&powernv_cpufreq_reboot_nb);
 	opal_message_notifier_unregister(OPAL_MSG_OCC,
 					 &powernv_cpufreq_opal_nb);
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
1.9.1

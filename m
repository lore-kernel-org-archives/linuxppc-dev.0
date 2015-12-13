Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 11BC31A070E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 05:18:58 +1100 (AEDT)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D70421402B4
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Dec 2015 05:18:57 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Mon, 14 Dec 2015 04:18:56 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id AB7E23578047
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Dec 2015 05:18:45 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBDIITKl23527582
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Dec 2015 05:18:37 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBDIICmV021355
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Dec 2015 05:18:13 +1100
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH] cpufreq: powernv: Redesign the presentation of throttle
 notification
Date: Sun, 13 Dec 2015 23:47:37 +0530
Message-Id: <1450030657-9121-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Replace the throttling event console messages to perf trace event
"power:powernv_throttle" and throttle counter stats which are
exported in sysfs. The newly added sysfs files are as follows:

1)/sys/devices/system/node/node0/throttle_frequencies
  This gives the throttle stats for each of the available frequencies.
  The throttle stat of a frequency is the total number of times the max
  frequency was reduced to that frequency.
  # cat /sys/devices/system/node/node0/throttle_frequencies
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

2)/sys/devices/system/node/node0/throttle_reasons
  This gives the stats for each of the supported throttle reasons.
  This gives the total number of times the frequency was throttled due
  to each of the reasons.
  # cat /sys/devices/system/node/node0/throttle_reasons
  No throttling 7
  Power Cap 0
  Processor Over Temperature 7
  Power Supply Failure 0
  Over Current 0
  OCC Reset 0

3)/sys/devices/system/node/node0/throttle_stat
  This gives the total number of throttle events occurred in turbo
  range of frequencies and non-turbo(below nominal) range of
  frequencies.
  # cat /sys/devices/system/node/node0/throttle_stat
  Turbo 7
  Nominal 0

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 186 +++++++++++++++++++++++++++++---------
 include/trace/events/power.h      |  22 +++++
 2 files changed, 166 insertions(+), 42 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index cb50138..bdde9d6 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -28,6 +28,9 @@
 #include <linux/of.h>
 #include <linux/reboot.h>
 #include <linux/slab.h>
+#include <trace/events/power.h>
+#include <linux/device.h>
+#include <linux/node.h>
 
 #include <asm/cputhreads.h>
 #include <asm/firmware.h>
@@ -43,12 +46,27 @@
 static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
 static bool rebooting, throttled, occ_reset;
 
+static char throttle_reason[][30] = {
+					"No throttling",
+					"Power Cap",
+					"Processor Over Temperature",
+					"Power Supply Failure",
+					"Over Current",
+					"OCC Reset"
+				     };
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
 } *chips;
 
 static int nr_chips;
@@ -309,40 +327,54 @@ static inline unsigned int get_nominal_index(void)
 	return powernv_pstate_info.max - powernv_pstate_info.nominal;
 }
 
-static void powernv_cpufreq_throttle_check(void *data)
+static void powernv_cpufreq_read_pmax(void *data)
 {
 	unsigned int cpu = smp_processor_id();
 	unsigned long pmsr;
-	int pmsr_pmax, i;
-
-	pmsr = get_pmspr(SPRN_PMSR);
+	int pmsr_pmax, index, i;
 
 	for (i = 0; i < nr_chips; i++)
 		if (chips[i].id == cpu_to_chip_id(cpu))
 			break;
 
-	/* Check for Pmax Capping */
+	pmsr = get_pmspr(SPRN_PMSR);
 	pmsr_pmax = (s8)PMSR_MAX(pmsr);
 	if (pmsr_pmax != powernv_pstate_info.max) {
 		if (chips[i].throttled)
-			goto next;
+			return;
 		chips[i].throttled = true;
-		if (pmsr_pmax < powernv_pstate_info.nominal)
-			pr_crit("CPU %d on Chip %u has Pmax reduced below nominal frequency (%d < %d)\n",
+		if (pmsr_pmax < powernv_pstate_info.nominal) {
+			pr_warn("CPU %d on Chip %u has Pmax reduced below nominal frequency (%d < %d)\n",
 				cpu, chips[i].id, pmsr_pmax,
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
@@ -356,7 +388,7 @@ next:
 
 	if (throttled) {
 		pr_info("PMSR = %16lx\n", pmsr);
-		pr_crit("CPU Frequency could be throttled\n");
+		pr_warn("CPU Frequency could be throttled\n");
 	}
 }
 
@@ -447,15 +479,6 @@ void powernv_cpufreq_work_fn(struct work_struct *work)
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
@@ -481,7 +504,7 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
 		 */
 		if (!throttled) {
 			throttled = true;
-			pr_crit("CPU frequency is throttled for duration\n");
+			pr_warn("CPU frequency is throttled for duration\n");
 		}
 
 		break;
@@ -505,23 +528,19 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
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
@@ -532,6 +551,61 @@ static struct notifier_block powernv_cpufreq_opal_nb = {
 	.priority	= 0,
 };
 
+static ssize_t throttle_freq_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	int i, count = 0, id;
+
+	for (i = 0; i < nr_chips; i++)
+		if (chips[i].id == dev->id)
+			break;
+	id = i;
+	for (i = 0; i < powernv_pstate_info.nr_pstates; i++)
+		count += sprintf(&buf[count], "%d %d\n",
+				powernv_freqs[i].frequency,
+				chips[id].pstate_stat[i]);
+	count += sprintf(&buf[count], "\n");
+
+	return count;
+}
+
+static DEVICE_ATTR(throttle_frequencies, 0400, throttle_freq_show, NULL);
+
+static ssize_t throttle_reasons_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	int i, count = 0, id;
+
+	for (i = 0; i < nr_chips; i++)
+		if (chips[i].id == dev->id)
+			break;
+	id = i;
+	for (i = 0; i <= OCC_MAX_THROTTLE_STATUS; i++)
+		count += sprintf(&buf[count], "%s %d\n", throttle_reason[i],
+				 chips[id].reason[i]);
+
+	return count;
+}
+
+static DEVICE_ATTR(throttle_reasons, 0400, throttle_reasons_show, NULL);
+
+static ssize_t throttle_stat_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	int i, count = 0;
+
+	for (i = 0; i < nr_chips; i++)
+		if (chips[i].id == dev->id)
+			break;
+
+	count += sprintf(&buf[count], "Turbo %d\n", chips[i].throt_turbo);
+	count += sprintf(&buf[count], "Nominal %d\n", chips[i].throt_nominal);
+
+	return count;
+}
+
+static DEVICE_ATTR(throttle_stat, 0400, throttle_stat_show, NULL);
+
 static void powernv_cpufreq_stop_cpu(struct cpufreq_policy *policy)
 {
 	struct powernv_smp_call_data freq_data;
@@ -571,11 +645,29 @@ static int init_chip_info(void)
 		return -ENOMEM;
 
 	for (i = 0; i < nr_chips; i++) {
+		unsigned int j;
+
 		chips[i].id = chip[i];
 		chips[i].throttled = false;
 		cpumask_copy(&chips[i].mask, cpumask_of_node(chip[i]));
 		INIT_WORK(&chips[i].throttle, powernv_cpufreq_work_fn);
 		chips[i].restore = false;
+		chips[i].throt_nominal = 0;
+		chips[i].throt_turbo = 0;
+		chips[i].pstate_stat = kcalloc(powernv_pstate_info.nr_pstates,
+						sizeof(int), GFP_KERNEL);
+		if (!chips[i].pstate_stat)
+			return -ENOMEM;
+
+		for (j = 0; j <= OCC_MAX_THROTTLE_STATUS; j++)
+			chips[i].reason[j] = 0;
+
+		device_create_file(&node_devices[chips[i].id]->dev,
+				   &dev_attr_throttle_reasons);
+		device_create_file(&node_devices[chips[i].id]->dev,
+				   &dev_attr_throttle_frequencies);
+		device_create_file(&node_devices[chips[i].id]->dev,
+				   &dev_attr_throttle_stat);
 	}
 
 	return 0;
@@ -609,9 +701,19 @@ module_init(powernv_cpufreq_init);
 
 static void __exit powernv_cpufreq_exit(void)
 {
+	int i;
+
 	unregister_reboot_notifier(&powernv_cpufreq_reboot_nb);
 	opal_message_notifier_unregister(OPAL_MSG_OCC,
 					 &powernv_cpufreq_opal_nb);
+	for (i = 0; i < nr_chips; i++) {
+		device_remove_file(&node_devices[chips[i].id]->dev,
+				   &dev_attr_throttle_reasons);
+		device_remove_file(&node_devices[chips[i].id]->dev,
+				   &dev_attr_throttle_frequencies);
+		device_remove_file(&node_devices[chips[i].id]->dev,
+				   &dev_attr_throttle_stat);
+	}
 	cpufreq_unregister_driver(&powernv_cpufreq_driver);
 }
 module_exit(powernv_cpufreq_exit);
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index 284244e..8a77228 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -38,6 +38,28 @@ DEFINE_EVENT(cpu, cpu_idle,
 	TP_ARGS(state, cpu_id)
 );
 
+TRACE_EVENT(powernv_throttle,
+
+	TP_PROTO(int chip_id, char *reason, int pmax),
+
+	TP_ARGS(chip_id, reason, pmax),
+
+	TP_STRUCT__entry(
+		__field(int, chip_id)
+		__string(reason, reason)
+		__field(int, pmax)
+	),
+
+	TP_fast_assign(
+		__entry->chip_id = chip_id;
+		__assign_str(reason, reason);
+		__entry->pmax = pmax;
+	),
+
+	TP_printk("Chip %d Pmax %d %s", __entry->chip_id,
+		  __entry->pmax, __get_str(reason))
+);
+
 TRACE_EVENT(pstate_sample,
 
 	TP_PROTO(u32 core_busy,
-- 
1.9.3

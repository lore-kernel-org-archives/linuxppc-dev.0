Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A0A201A180C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jan 2016 18:20:18 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5330A1402DE
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Jan 2016 18:20:18 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Fri, 22 Jan 2016 17:20:18 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 25B6B2CE802D
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Jan 2016 18:20:16 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0M7K9Zi14417990
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Jan 2016 18:20:18 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0M7JhE5023761
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Jan 2016 18:19:43 +1100
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 pc@us.ibm.com, anton@samba.org, ego@linux.vnet.ibm.com,
 shreyas@linux.vnet.ibm.com,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v6 4/5] cpufreq: powernv: Replace pr_info with trace print for
 throttle event
Date: Fri, 22 Jan 2016 12:49:04 +0530
Message-Id: <1453447145-17722-5-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
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

Currently we use printk message to notify the throttle event. But this
can flood the console if the cpu is throttled frequently. So replace the
printk with the tracepoint to notify the throttle event. And also events
like throttle below nominal frequency and OCC_RESET are reduced to
pr_warn/pr_warn_once as pointed by MFG to not mark them as critical
messages. This patch adds 'throt_reason' to struct chip to store the
throttle reason.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
No changes from v5.

Changes from v4:
- Taken care of Gautham's comments to remove the new function
  powernv_cpufreq_check_pmax()
- Modified commit message

Changes from v3:
- Separate this patch to contain trace_point changes
- Move struct chip member 'restore' of type bool above 'mask' to reduce
  structure padding.

No changes from v2.

Changes from v1:
- As suggested by Paul Clarke replaced char * throttle_reason[][30] by 
  const char * const throttle_reason[].

 drivers/cpufreq/powernv-cpufreq.c | 73 ++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 39 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 6f186dc..2d09274 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -29,6 +29,7 @@
 #include <linux/reboot.h>
 #include <linux/slab.h>
 #include <linux/cpu.h>
+#include <trace/events/power.h>
 
 #include <asm/cputhreads.h>
 #include <asm/firmware.h>
@@ -45,12 +46,22 @@ static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
 static bool rebooting, throttled, occ_reset;
 static unsigned int *core_to_chip_map;
 
+static const char * const throttle_reason[] = {
+	"No throttling",
+	"Power Cap",
+	"Processor Over Temperature",
+	"Power Supply Failure",
+	"Over Current",
+	"OCC Reset"
+};
+
 static struct chip {
 	unsigned int id;
 	bool throttled;
+	bool restore;
+	u8 throt_reason;
 	cpumask_t mask;
 	struct work_struct throttle;
-	bool restore;
 } *chips;
 
 static int nr_chips;
@@ -331,17 +342,17 @@ static void powernv_cpufreq_throttle_check(void *data)
 			goto next;
 		chips[i].throttled = true;
 		if (pmsr_pmax < powernv_pstate_info.nominal)
-			pr_crit("CPU %d on Chip %u has Pmax reduced below nominal frequency (%d < %d)\n",
-				cpu, chips[i].id, pmsr_pmax,
-				powernv_pstate_info.nominal);
-		else
-			pr_info("CPU %d on Chip %u has Pmax reduced below turbo frequency (%d < %d)\n",
-				cpu, chips[i].id, pmsr_pmax,
-				powernv_pstate_info.max);
+			pr_warn_once("CPU %d on Chip %u has Pmax reduced below nominal frequency (%d < %d)\n",
+				     cpu, chips[i].id, pmsr_pmax,
+				     powernv_pstate_info.nominal);
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
 
 	/* Check if Psafe_mode_active is set in PMSR. */
@@ -359,7 +370,7 @@ next:
 
 	if (throttled) {
 		pr_info("PMSR = %16lx\n", pmsr);
-		pr_crit("CPU Frequency could be throttled\n");
+		pr_warn("CPU Frequency could be throttled\n");
 	}
 }
 
@@ -452,15 +463,6 @@ out:
 	put_online_cpus();
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
@@ -486,7 +488,7 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
 		 */
 		if (!throttled) {
 			throttled = true;
-			pr_crit("CPU frequency is throttled for duration\n");
+			pr_warn("CPU frequency is throttled for duration\n");
 		}
 
 		break;
@@ -510,23 +512,18 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
 			return 0;
 		}
 
-		if (omsg.throttle_status &&
+		for (i = 0; i < nr_chips; i++)
+			if (chips[i].id == omsg.chip)
+				break;
+
+		if (omsg.throttle_status >= 0 &&
 		    omsg.throttle_status <= OCC_MAX_THROTTLE_STATUS)
-			pr_info("OCC: Chip %u Pmax reduced due to %s\n",
-				(unsigned int)omsg.chip,
-				throttle_reason[omsg.throttle_status]);
-		else if (!omsg.throttle_status)
-			pr_info("OCC: Chip %u %s\n", (unsigned int)omsg.chip,
-				throttle_reason[omsg.throttle_status]);
-		else
-			return 0;
+			chips[i].throt_reason = omsg.throttle_status;
 
-		for (i = 0; i < nr_chips; i++)
-			if (chips[i].id == omsg.chip) {
-				if (!omsg.throttle_status)
-					chips[i].restore = true;
-				schedule_work(&chips[i].throttle);
-			}
+		if (!omsg.throttle_status)
+			chips[i].restore = true;
+
+		schedule_work(&chips[i].throttle);
 	}
 	return 0;
 }
@@ -581,16 +578,14 @@ static int init_chip_info(void)
 		cpumask_andnot(&cpu_mask, &cpu_mask, cpu_sibling_mask(cpu));
 	}
 
-	chips = kmalloc_array(nr_chips, sizeof(struct chip), GFP_KERNEL);
+	chips = kcalloc(nr_chips, sizeof(struct chip), GFP_KERNEL);
 	if (!chips)
 		goto free_chip_map;
 
 	for (i = 0; i < nr_chips; i++) {
 		chips[i].id = chip[i];
-		chips[i].throttled = false;
 		cpumask_copy(&chips[i].mask, cpumask_of_node(chip[i]));
 		INIT_WORK(&chips[i].throttle, powernv_cpufreq_work_fn);
-		chips[i].restore = false;
 	}
 
 	return 0;
-- 
1.9.3

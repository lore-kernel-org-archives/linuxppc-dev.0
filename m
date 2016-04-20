Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqc9z0qxCzDqQB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 19:32:55 +1000 (AEST)
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qqc9y2Ctyz9t3s
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Apr 2016 19:32:54 +1000 (AEST)
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Wed, 20 Apr 2016 15:02:49 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3K9Wjp211862296
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Apr 2016 15:02:45 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3K9Wh3N015922
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Apr 2016 15:02:45 +0530
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH] cpufreq: powernv: Fixes initialization of chip and chip mask
Date: Wed, 20 Apr 2016 15:02:38 +0530
Message-Id: <1461144758-17810-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit 735366fc4077 ("cpufreq: powernv: Call throttle_check() on
receiving OCC_THROTTLE") used cpumask_of_node() as the chip mask. But
this mask contains only online cpus. This breaks a setup where cpufreq
is initialized with few offline cores and made online later. So this
patch fixes this bug by scanning all the possible cpus and sets the
cpu in the chip mask. It also fixes the chip discovery with
non-contiguous cpu mask. This patch creates a list of chips
'powernv_chip_list' to replace the chip array for cleaner
initialization.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 80 +++++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 32 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 39ac78c..0581a59 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -64,7 +64,9 @@ enum throttle_reason_type {
 	OCC_MAX_REASON
 };
 
-static struct chip {
+static LIST_HEAD(powernv_chip_list);
+
+struct chip {
 	unsigned int id;
 	bool throttled;
 	bool restore;
@@ -74,9 +76,9 @@ static struct chip {
 	int throttle_turbo;
 	int throttle_sub_turbo;
 	int reason[OCC_MAX_REASON];
-} *chips;
+	struct list_head list;
+};
 
-static int nr_chips;
 static DEFINE_PER_CPU(struct chip *, chip_info);
 
 /*
@@ -528,12 +530,22 @@ out:
 	put_online_cpus();
 }
 
+static inline struct chip *find_chip(unsigned int id)
+{
+	struct chip *chip;
+
+	list_for_each_entry(chip, &powernv_chip_list, list)
+		if (chip->id == id)
+			return chip;
+	return NULL;
+}
+
 static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
 				   unsigned long msg_type, void *_msg)
 {
 	struct opal_msg *msg = _msg;
 	struct opal_occ_msg omsg;
-	int i;
+	struct chip *chip;
 
 	if (msg_type != OPAL_MSG_OCC)
 		return 0;
@@ -569,28 +581,27 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
 			throttled = false;
 			pr_info("OCC Active, CPU frequency is no longer throttled\n");
 
-			for (i = 0; i < nr_chips; i++) {
-				chips[i].restore = true;
-				schedule_work(&chips[i].throttle);
+			list_for_each_entry(chip, &powernv_chip_list, list) {
+				chip->restore = true;
+				schedule_work(&chip->throttle);
 			}
 
 			return 0;
 		}
 
-		for (i = 0; i < nr_chips; i++)
-			if (chips[i].id == omsg.chip)
-				break;
-
+		chip = find_chip(omsg.chip);
+		if (!chip)
+			return -EINVAL;
 		if (omsg.throttle_status >= 0 &&
 		    omsg.throttle_status <= OCC_MAX_THROTTLE_STATUS) {
-			chips[i].throttle_reason = omsg.throttle_status;
-			chips[i].reason[omsg.throttle_status]++;
+			chip->throttle_reason = omsg.throttle_status;
+			chip->reason[omsg.throttle_status]++;
 		}
 
 		if (!omsg.throttle_status)
-			chips[i].restore = true;
+			chip->restore = true;
 
-		schedule_work(&chips[i].throttle);
+		schedule_work(&chip->throttle);
 	}
 	return 0;
 }
@@ -622,37 +633,42 @@ static struct cpufreq_driver powernv_cpufreq_driver = {
 
 static int init_chip_info(void)
 {
-	unsigned int chip[256];
-	unsigned int cpu, i;
+	unsigned int cpu;
 	unsigned int prev_chip_id = UINT_MAX;
+	struct chip *chip = NULL;
 
 	for_each_possible_cpu(cpu) {
 		unsigned int id = cpu_to_chip_id(cpu);
 
 		if (prev_chip_id != id) {
 			prev_chip_id = id;
-			chip[nr_chips++] = id;
+			chip = find_chip(id);
 		}
+		if (!chip) {
+			chip = kzalloc(sizeof(struct chip), GFP_KERNEL);
+			if (!chip)
+				goto out;
+			chip->id = id;
+			INIT_WORK(&chip->throttle, powernv_cpufreq_work_fn);
+			INIT_LIST_HEAD(&chip->list);
+			list_add(&chip->list, &powernv_chip_list);
+		}
+		cpumask_set_cpu(cpu, &chip->mask);
+		per_cpu(chip_info, cpu) = chip;
 	}
-
-	chips = kcalloc(nr_chips, sizeof(struct chip), GFP_KERNEL);
-	if (!chips)
-		return -ENOMEM;
-
-	for (i = 0; i < nr_chips; i++) {
-		chips[i].id = chip[i];
-		cpumask_copy(&chips[i].mask, cpumask_of_node(chip[i]));
-		INIT_WORK(&chips[i].throttle, powernv_cpufreq_work_fn);
-		for_each_cpu(cpu, &chips[i].mask)
-			per_cpu(chip_info, cpu) =  &chips[i];
-	}
-
 	return 0;
+out:
+	list_for_each_entry(chip, &powernv_chip_list, list)
+		kfree(chip);
+	return -ENOMEM;
 }
 
 static inline void clean_chip_info(void)
 {
-	kfree(chips);
+	struct chip *chip;
+
+	list_for_each_entry(chip, &powernv_chip_list, list)
+		kfree(chip);
 }
 
 static inline void unregister_all_notifiers(void)
-- 
1.9.3

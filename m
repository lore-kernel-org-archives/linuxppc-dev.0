Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D81FD1A1A01
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 18:27:05 +1100 (AEDT)
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9ECB8140B97
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 18:27:05 +1100 (AEDT)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Thu, 28 Jan 2016 17:27:05 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id DFD282CE8058
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 18:27:02 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0S7QinV28377294
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 18:26:52 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0S7QTBs030003
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 18:26:30 +1100
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 pc@us.ibm.com, anton@samba.org, ego@linux.vnet.ibm.com,
 shreyas@linux.vnet.ibm.com, bsingharora@gmail.com, mpe@ellerman.id.au,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v7 3/6] cpufreq: powernv: Remove cpu_to_chip_id() from hot-path
Date: Thu, 28 Jan 2016 12:55:38 +0530
Message-Id: <1453965941-7363-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
In-Reply-To: <1453965941-7363-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1453965941-7363-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

cpu_to_chip_id() does a DT walk through to find out the chip id by
taking a contended device tree lock. This adds an unnecessary overhead
in a hot path. So instead of calling cpu_to_chip_id() everytime cache
the chip ids for all cores in the array 'core_to_chip_map' and use it
in the hotpath.

Reported-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
Changes from v6:
- Minor changes to move the code 'cpumask_copy()' after 'core_to_chip_map'
  is allocated.
- Move 'kfree(chips)' to a separate patch.

No changes from v5.

Changes from v4:
- Taken care of Shreyas's comments to add a core_to_chip_map array to
  store the chip id.

 drivers/cpufreq/powernv-cpufreq.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index a271b0f..c670314 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -43,6 +43,7 @@
 
 static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
 static bool rebooting, throttled, occ_reset;
+static unsigned int *core_to_chip_map;
 
 static struct chip {
 	unsigned int id;
@@ -313,13 +314,14 @@ static inline unsigned int get_nominal_index(void)
 static void powernv_cpufreq_throttle_check(void *data)
 {
 	unsigned int cpu = smp_processor_id();
+	unsigned int chip_id = core_to_chip_map[cpu_core_index_of_thread(cpu)];
 	unsigned long pmsr;
 	int pmsr_pmax, i;
 
 	pmsr = get_pmspr(SPRN_PMSR);
 
 	for (i = 0; i < nr_chips; i++)
-		if (chips[i].id == cpu_to_chip_id(cpu))
+		if (chips[i].id == chip_id)
 			break;
 
 	/* Check for Pmax Capping */
@@ -559,19 +561,29 @@ static int init_chip_info(void)
 	unsigned int chip[256];
 	unsigned int cpu, i;
 	unsigned int prev_chip_id = UINT_MAX;
+	cpumask_t cpu_mask;
+	int ret = -ENOMEM;
 
-	for_each_possible_cpu(cpu) {
+	core_to_chip_map = kcalloc(cpu_nr_cores(), sizeof(unsigned int),
+				   GFP_KERNEL);
+	if (!core_to_chip_map)
+		goto out;
+
+	cpumask_copy(&cpu_mask, cpu_possible_mask);
+	for_each_cpu(cpu, &cpu_mask) {
 		unsigned int id = cpu_to_chip_id(cpu);
 
 		if (prev_chip_id != id) {
 			prev_chip_id = id;
 			chip[nr_chips++] = id;
 		}
+		core_to_chip_map[cpu_core_index_of_thread(cpu)] = id;
+		cpumask_andnot(&cpu_mask, &cpu_mask, cpu_sibling_mask(cpu));
 	}
 
 	chips = kmalloc_array(nr_chips, sizeof(struct chip), GFP_KERNEL);
 	if (!chips)
-		return -ENOMEM;
+		goto free_chip_map;
 
 	for (i = 0; i < nr_chips; i++) {
 		chips[i].id = chip[i];
@@ -582,6 +594,10 @@ static int init_chip_info(void)
 	}
 
 	return 0;
+free_chip_map:
+	kfree(core_to_chip_map);
+out:
+	return ret;
 }
 
 static int __init powernv_cpufreq_init(void)
@@ -616,6 +632,7 @@ static void __exit powernv_cpufreq_exit(void)
 	opal_message_notifier_unregister(OPAL_MSG_OCC,
 					 &powernv_cpufreq_opal_nb);
 	kfree(chips);
+	kfree(core_to_chip_map);
 	cpufreq_unregister_driver(&powernv_cpufreq_driver);
 }
 module_exit(powernv_cpufreq_exit);
-- 
1.9.3

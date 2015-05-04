Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A9EB11A0008
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 May 2015 19:00:24 +1000 (AEST)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 673D3140157
 for <linuxppc-dev@ozlabs.org>; Mon,  4 May 2015 19:00:24 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Mon, 4 May 2015 19:00:24 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 575083578053
 for <linuxppc-dev@ozlabs.org>; Mon,  4 May 2015 19:00:21 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4490Db819464196
 for <linuxppc-dev@ozlabs.org>; Mon, 4 May 2015 19:00:21 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t448xmZ3023501
 for <linuxppc-dev@ozlabs.org>; Mon, 4 May 2015 18:59:48 +1000
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/6] cpufreq: poowernv: Handle throttling due to Pmax
 capping at chip level
Date: Mon,  4 May 2015 14:24:07 +0530
Message-Id: <1430729652-14813-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
In-Reply-To: <1430729652-14813-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1430729652-14813-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Cc: preeti@linux.vnet.ibm.com, viresh.kumar@linaro.org, rjw@rjwysocki.net,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The On-Chip-Controller(OCC) can throttle cpu frequency by reducing the
max allowed frequency for that chip if the chip exceeds its power or
temperature limits. As Pmax capping is a chip level condition report
this throttling behavior at chip level and also do not set the global
'throttled' on Pmax capping instead set the per-chip throttled
variable. Report unthrottling if Pmax is restored after throttling.

This patch adds a structure to store chip id and throttled state of
the chip.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 59 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index ebef0d8..d0c18c9 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -27,6 +27,7 @@
 #include <linux/smp.h>
 #include <linux/of.h>
 #include <linux/reboot.h>
+#include <linux/slab.h>
 
 #include <asm/cputhreads.h>
 #include <asm/firmware.h>
@@ -42,6 +43,13 @@
 static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
 static bool rebooting, throttled;
 
+static struct chip {
+	unsigned int id;
+	bool throttled;
+} *chips;
+
+static int nr_chips;
+
 /*
  * Note: The set of pstates consists of contiguous integers, the
  * smallest of which is indicated by powernv_pstate_info.min, the
@@ -301,22 +309,33 @@ static inline unsigned int get_nominal_index(void)
 static void powernv_cpufreq_throttle_check(unsigned int cpu)
 {
 	unsigned long pmsr;
-	int pmsr_pmax, pmsr_lp;
+	int pmsr_pmax, pmsr_lp, i;
 
 	pmsr = get_pmspr(SPRN_PMSR);
 
+	for (i = 0; i < nr_chips; i++)
+		if (chips[i].id == cpu_to_chip_id(cpu))
+			break;
+
 	/* Check for Pmax Capping */
 	pmsr_pmax = (s8)PMSR_MAX(pmsr);
 	if (pmsr_pmax != powernv_pstate_info.max) {
-		throttled = true;
-		pr_info("CPU %d Pmax is reduced to %d\n", cpu, pmsr_pmax);
-		pr_info("Max allowed Pstate is capped\n");
+		if (chips[i].throttled)
+			goto next;
+		chips[i].throttled = true;
+		pr_info("CPU %d on Chip %u has Pmax reduced to %d\n", cpu,
+			chips[i].id, pmsr_pmax);
+	} else if (chips[i].throttled) {
+		chips[i].throttled = false;
+		pr_info("CPU %d on Chip %u has Pmax restored to %d\n", cpu,
+			chips[i].id, pmsr_pmax);
 	}
 
 	/*
 	 * Check for Psafe by reading LocalPstate
 	 * or check if Psafe_mode_active is set in PMSR.
 	 */
+next:
 	pmsr_lp = (s8)PMSR_LP(pmsr);
 	if ((pmsr_lp < powernv_pstate_info.min) ||
 				(pmsr & PMSR_PSAFE_ENABLE)) {
@@ -414,6 +433,33 @@ static struct cpufreq_driver powernv_cpufreq_driver = {
 	.attr		= powernv_cpu_freq_attr,
 };
 
+static int init_chip_info(void)
+{
+	unsigned int chip[256];
+	unsigned int cpu, i;
+	unsigned int prev_chip_id = UINT_MAX;
+
+	for_each_possible_cpu(cpu) {
+		unsigned int id = cpu_to_chip_id(cpu);
+
+		if (prev_chip_id != id) {
+			prev_chip_id = id;
+			chip[nr_chips++] = id;
+		}
+	}
+
+	chips = kmalloc_array(nr_chips, sizeof(struct chip), GFP_KERNEL);
+	if (!chips)
+		return -ENOMEM;
+
+	for (i = 0; i < nr_chips; i++) {
+		chips[i].id = chip[i];
+		chips[i].throttled = false;
+	}
+
+	return 0;
+}
+
 static int __init powernv_cpufreq_init(void)
 {
 	int rc = 0;
@@ -429,6 +475,11 @@ static int __init powernv_cpufreq_init(void)
 		return rc;
 	}
 
+	/* Populate chip info */
+	rc = init_chip_info();
+	if (rc)
+		return rc;
+
 	register_reboot_notifier(&powernv_cpufreq_reboot_nb);
 	return cpufreq_register_driver(&powernv_cpufreq_driver);
 }
-- 
1.9.3

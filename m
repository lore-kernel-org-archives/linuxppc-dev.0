Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tg73J6xH7zDw6F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 22:13:31 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBGBA7wt000959
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 06:13:29 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27cbb2atqq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 06:13:29 -0500
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Fri, 16 Dec 2016 21:13:26 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 5A4882BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 22:13:24 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uBGBDOiQ51904700
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 22:13:24 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uBGBDNmN025540
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 22:13:24 +1100
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: ego@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, svaidy@linux.vnet.ibm.com,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH] cpufreq: powernv: Add boost files to export ultra-turbo
 frequencies
Date: Fri, 16 Dec 2016 16:43:08 +0530
Message-Id: <1481886788-25324-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In P8+, Workload Optimized Frequency(WOF) provides the capability to
boost the cpu frequency based on the utilization of the other cpus
running in the chip. The On-Chip-Controller(OCC) firmware will control
the achievability of these frequencies depending on the power headroom
available in the chip. Currently the ultra-turbo frequencies provided
by this feature are exported along with the turbo and sub-turbo
frequencies as scaling_available_frequencies. This patch will export
the ultra-turbo frequencies separately as scaling_boost_frequencies in
WOF enabled systems. This patch will add the boost sysfs file which
can be used to disable/enable ultra-turbo frequencies.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 48 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 37671b5..56dfd91 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -144,6 +144,7 @@ enum throttle_reason_type {
 	unsigned int max;
 	unsigned int nominal;
 	unsigned int nr_pstates;
+	bool wof_enabled;
 } powernv_pstate_info;
 
 /* Use following macros for conversions between pstate_id and index */
@@ -203,6 +204,7 @@ static int init_powernv_pstates(void)
 	const __be32 *pstate_ids, *pstate_freqs;
 	u32 len_ids, len_freqs;
 	u32 pstate_min, pstate_max, pstate_nominal;
+	u32 pstate_turbo, pstate_ultra_turbo;
 
 	power_mgt = of_find_node_by_path("/ibm,opal/power-mgt");
 	if (!power_mgt) {
@@ -225,6 +227,25 @@ static int init_powernv_pstates(void)
 		pr_warn("ibm,pstate-nominal not found\n");
 		return -ENODEV;
 	}
+
+	if (of_property_read_u32(power_mgt, "ibm,pstate-ultra-turbo",
+				 &pstate_ultra_turbo)) {
+		powernv_pstate_info.wof_enabled = false;
+		goto next;
+	}
+
+	if (of_property_read_u32(power_mgt, "ibm,pstate-turbo",
+				 &pstate_turbo)) {
+		powernv_pstate_info.wof_enabled = false;
+		goto next;
+	}
+
+	if (pstate_turbo == pstate_ultra_turbo)
+		powernv_pstate_info.wof_enabled = false;
+	else
+		powernv_pstate_info.wof_enabled = true;
+
+next:
 	pr_info("cpufreq pstate min %d nominal %d max %d\n", pstate_min,
 		pstate_nominal, pstate_max);
 
@@ -268,6 +289,13 @@ static int init_powernv_pstates(void)
 			powernv_pstate_info.nominal = i;
 		else if (id == pstate_min)
 			powernv_pstate_info.min = i;
+
+		if (powernv_pstate_info.wof_enabled && id == pstate_turbo) {
+			int j;
+
+			for (j = i - 1; j >= (int)powernv_pstate_info.max; j--)
+				powernv_freqs[j].flags = CPUFREQ_BOOST_FREQ;
+		}
 	}
 
 	/* End of list marker entry */
@@ -305,9 +333,12 @@ static ssize_t cpuinfo_nominal_freq_show(struct cpufreq_policy *policy,
 struct freq_attr cpufreq_freq_attr_cpuinfo_nominal_freq =
 	__ATTR_RO(cpuinfo_nominal_freq);
 
+#define SCALING_BOOST_FREQS_ATTR_INDEX		2
+
 static struct freq_attr *powernv_cpu_freq_attr[] = {
 	&cpufreq_freq_attr_scaling_available_freqs,
 	&cpufreq_freq_attr_cpuinfo_nominal_freq,
+	&cpufreq_freq_attr_scaling_boost_freqs,
 	NULL,
 };
 
@@ -1013,11 +1044,22 @@ static int __init powernv_cpufreq_init(void)
 	register_reboot_notifier(&powernv_cpufreq_reboot_nb);
 	opal_message_notifier_register(OPAL_MSG_OCC, &powernv_cpufreq_opal_nb);
 
+	if (powernv_pstate_info.wof_enabled)
+		powernv_cpufreq_driver.boost_enabled = true;
+	else
+		powernv_cpu_freq_attr[SCALING_BOOST_FREQS_ATTR_INDEX] = NULL;
+
 	rc = cpufreq_register_driver(&powernv_cpufreq_driver);
-	if (!rc)
-		return 0;
+	if (rc) {
+		pr_info("Failed to register the cpufreq driver (%d)\n", rc);
+		goto clean_notifiers;
+	}
 
-	pr_info("Failed to register the cpufreq driver (%d)\n", rc);
+	if (powernv_pstate_info.wof_enabled)
+		cpufreq_enable_boost_support();
+
+	return 0;
+clean_notifiers:
 	unregister_all_notifiers();
 	clean_chip_info();
 out:
-- 
1.8.3.1

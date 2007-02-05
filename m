Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 12D4EDDE41
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 06:09:14 +1100 (EST)
Message-Id: <20070205185838.837935000@sipsolutions.net>
References: <20070205183026.989209000@sipsolutions.net>
Date: Mon, 05 Feb 2007 19:30:37 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [RFC 10/10] powermac: fix G5-cpufreq for cpu on/offline
Mime-Version: 1.0
Cc: linux-pm@lists.osdl.org, cpufreq list <cpufreq@lists.linux.org.uk>,
	Torrance <torrance123@gmail.com>, Jacob Shin <jacob.shin@amd.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The original code here is wrong, it applies "previous" knowledge.
The way the cpufreq core is designed is that the policy for the
secondary CPU that comes online says that it must in fact not
use this policy but use the same as the other CPUs that are
listed, which in fact is CPU#0.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: cpufreq list <cpufreq@lists.linux.org.uk>
Cc: Jacob Shin <jacob.shin@amd.com>

---
Not tested yet but from what Jacob said this should work.

--- mb-wireless.orig/arch/powerpc/platforms/powermac/cpufreq_64.c	2007-02-05 18:41:35.414524763 +0100
+++ mb-wireless/arch/powerpc/platforms/powermac/cpufreq_64.c	2007-02-05 19:08:53.994524763 +0100
@@ -357,13 +357,13 @@ static unsigned int g5_cpufreq_get_speed
 
 static int g5_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
-	if (policy->cpu != 0)
-		return -ENODEV;
-
 	policy->governor = CPUFREQ_DEFAULT_GOVERNOR;
 	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
 	policy->cur = g5_cpu_freqs[g5_query_freq()].frequency;
-	policy->cpus = cpu_possible_map;
+	/* secondary CPUs are tied to the primary one by the
+	 * cpufreq core if in the secondary policy we tell it that
+	 * it actually must be one policy together with all others. */
+	policy->cpus = cpu_online_map;
 	cpufreq_frequency_table_get_attr(g5_cpu_freqs, policy->cpu);
 
 	return cpufreq_frequency_table_cpuinfo(policy,

--

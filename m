Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 19C80DE0D5
	for <linuxppc-dev@ozlabs.org>; Wed,  2 May 2007 18:16:52 +1000 (EST)
Subject: [PATCH] powermac: fix G5-cpufreq for cpu on/offline
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Wed, 02 May 2007 08:35:44 +0200
Message-Id: <1178087744.13233.34.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
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

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Paul Mackeras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---
 arch/powerpc/platforms/powermac/cpufreq_64.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- wireless-dev.orig/arch/powerpc/platforms/powermac/cpufreq_64.c	2007-05-01 11:35:43.084734191 +0200
+++ wireless-dev/arch/powerpc/platforms/powermac/cpufreq_64.c	2007-05-01 11:36:31.154734191 +0200
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

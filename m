Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5A407DE011
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 11:23:24 +1100 (EST)
Subject: [PATCH] powerpc: Fix cpufreq drivers after cpufreq core changes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <1231719015.22571.4.camel@pasglop>
References: <20090112104837.69feedec.sfr@canb.auug.org.au>
	<1231719015.22571.4.camel@pasglop>
Content-Type: text/plain
Date: Mon, 12 Jan 2009 11:22:01 +1100
Message-Id: <1231719721.22571.9.camel@pasglop>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	"David S. Miller" <davem@davemloft.net>, arndb <arndb@arndb.de>,
	Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>,
	Mike Travis <travis@sgi.com>, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Olof Johansson <olof@lixom.net>, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This updates the cpufreq drivers in arch/powerpc so they build again
after the core cpufreq changes that broke them in commit
in835481d9bcd65720b473db6b38746a74a3964218.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Tested on a G5. Olof, Arnd, any chance you can test the cell and pasemi
drivers still work ?

Linus, you can probably merge this now to fix the build problems.

diff --git a/arch/powerpc/platforms/cell/cbe_cpufreq.c b/arch/powerpc/platforms/cell/cbe_cpufreq.c
index ec7c8f4..e6506cd 100644
--- a/arch/powerpc/platforms/cell/cbe_cpufreq.c
+++ b/arch/powerpc/platforms/cell/cbe_cpufreq.c
@@ -118,7 +118,7 @@ static int cbe_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	policy->cur = cbe_freqs[cur_pmode].frequency;
 
 #ifdef CONFIG_SMP
-	policy->cpus = per_cpu(cpu_sibling_map, policy->cpu);
+	cpumask_copy(policy->cpus, &per_cpu(cpu_sibling_map, policy->cpu));
 #endif
 
 	cpufreq_frequency_table_get_attr(cbe_freqs, policy->cpu);
diff --git a/arch/powerpc/platforms/cell/cpufreq_spudemand.c b/arch/powerpc/platforms/cell/cpufreq_spudemand.c
index a3c6c01..968c1c0 100644
--- a/arch/powerpc/platforms/cell/cpufreq_spudemand.c
+++ b/arch/powerpc/platforms/cell/cpufreq_spudemand.c
@@ -110,7 +110,7 @@ static int spu_gov_govern(struct cpufreq_policy *policy, unsigned int event)
 		}
 
 		/* initialize spu_gov_info for all affected cpus */
-		for_each_cpu_mask(i, policy->cpus) {
+		for_each_cpu(i, policy->cpus) {
 			affected_info = &per_cpu(spu_gov_info, i);
 			affected_info->policy = policy;
 		}
@@ -127,7 +127,7 @@ static int spu_gov_govern(struct cpufreq_policy *policy, unsigned int event)
 		spu_gov_cancel_work(info);
 
 		/* clean spu_gov_info for all affected cpus */
-		for_each_cpu_mask (i, policy->cpus) {
+		for_each_cpu (i, policy->cpus) {
 			info = &per_cpu(spu_gov_info, i);
 			info->policy = NULL;
 		}
diff --git a/arch/powerpc/platforms/pasemi/cpufreq.c b/arch/powerpc/platforms/pasemi/cpufreq.c
index 86db47c..be2527a 100644
--- a/arch/powerpc/platforms/pasemi/cpufreq.c
+++ b/arch/powerpc/platforms/pasemi/cpufreq.c
@@ -213,7 +213,7 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	pr_debug("current astate is at %d\n",cur_astate);
 
 	policy->cur = pas_freqs[cur_astate].frequency;
-	policy->cpus = cpu_online_map;
+	cpumask_copy(policy->cpus, &cpu_online_map);
 
 	ppc_proc_freq = policy->cur * 1000ul;
 
diff --git a/arch/powerpc/platforms/powermac/cpufreq_64.c b/arch/powerpc/platforms/powermac/cpufreq_64.c
index 4dfb4bc..beb3833 100644
--- a/arch/powerpc/platforms/powermac/cpufreq_64.c
+++ b/arch/powerpc/platforms/powermac/cpufreq_64.c
@@ -362,7 +362,7 @@ static int g5_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	/* secondary CPUs are tied to the primary one by the
 	 * cpufreq core if in the secondary policy we tell it that
 	 * it actually must be one policy together with all others. */
-	policy->cpus = cpu_online_map;
+	cpumask_copy(policy->cpus, &cpu_online_map);
 	cpufreq_frequency_table_get_attr(g5_cpu_freqs, policy->cpu);
 
 	return cpufreq_frequency_table_cpuinfo(policy,

Return-Path: <anton@ozlabs.org>
Message-Id: <20100427013431.581210435@samba.org>
Date: Tue, 27 Apr 2010 11:32:32 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
 rusty@rustcorp.com.au
Subject: [patch 01/15] powerpc: cpumask: Use cpu_online_mask
References: <20100427013231.510168034@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Change &cpu_online_map to cpu_online_mask.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-cpumask/arch/powerpc/platforms/pasemi/cpufreq.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/platforms/pasemi/cpufreq.c	2010-04-08 19:46:04.459196015 +1000
+++ linux-cpumask/arch/powerpc/platforms/pasemi/cpufreq.c	2010-04-22 13:02:53.536695878 +1000
@@ -213,7 +213,7 @@ static int pas_cpufreq_cpu_init(struct c
 	pr_debug("current astate is at %d\n",cur_astate);
 
 	policy->cur = pas_freqs[cur_astate].frequency;
-	cpumask_copy(policy->cpus, &cpu_online_map);
+	cpumask_copy(policy->cpus, cpu_online_mask);
 
 	ppc_proc_freq = policy->cur * 1000ul;
 
Index: linux-cpumask/arch/powerpc/platforms/powermac/cpufreq_64.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/platforms/powermac/cpufreq_64.c	2010-04-08 19:46:04.479196466 +1000
+++ linux-cpumask/arch/powerpc/platforms/powermac/cpufreq_64.c	2010-04-22 13:02:53.546695890 +1000
@@ -362,7 +362,7 @@ static int g5_cpufreq_cpu_init(struct cp
 	/* secondary CPUs are tied to the primary one by the
 	 * cpufreq core if in the secondary policy we tell it that
 	 * it actually must be one policy together with all others. */
-	cpumask_copy(policy->cpus, &cpu_online_map);
+	cpumask_copy(policy->cpus, cpu_online_mask);
 	cpufreq_frequency_table_get_attr(g5_cpu_freqs, policy->cpu);
 
 	return cpufreq_frequency_table_cpuinfo(policy,

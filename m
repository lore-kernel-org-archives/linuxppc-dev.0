Return-Path: <linuxppc-dev+bounces-21520-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6095ECD5BB1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 14:18:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPvx42kCFz2y8t;
	Wed, 27 May 2026 00:18:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779805096;
	cv=none; b=k7PJAf5iLR0QMdhyzbMJ8W8cduaW2y3j0YOVv91PlE+6TjsjntxlUqbPdQp+11fyHiQH9o9upEpgcmuEz1/WtabHIGtVaYhOp+IAAynSFptRk4Oc+CzL5JTpr3MkF1FZ2VkiAaQjjZeOrHiLXW6xqFhnLPBbw/a4kZ5QKCZpjdtViXEzQmAemj7dH7Y+TqqcWeHCQx+aH4PZp1JTgOZhqVbflAwaPDLMXFt3YmDLvCuRuU4Sp3SKah5pt5nwyep6oVdeCFxea1I21fmS0miUrAv3bEuEEbr+OWhUfzAfNjhU4bKuza5xt2DsCXBnwiC+caf7ELqgmMJwYNdIxdJyfg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779805096; c=relaxed/relaxed;
	bh=tjQlfk7go6/1bAyhMxtzLIiwVMACueFYxBZnKobXL84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ld76wEOso1BZZG/MF5Rp4wCitTEe65MC3LHBPL02/AZugXaKXtgE/xnuIKaT0FKiP7q8onejmJh0xWuOyt0ld2tHRweVYSXC54NFC01+0RZvgADwsCgUtL1SJz5sn105GMyAywQ8vcgL0hqJqz0XOiq1ROocLA4fiSDqANVSc+EWr9RrkGCZvcV3PnLu3ZS4nIA7oZ1EyeeQ9ipIQML/9ToPtf+vLgJyZSxFxkhtka15Hyy/5vW5ufrV+szdZ+zFkBe4UDzoVFju/wqCUITlVxlIakz3AHS9t1EGGPk62u9eeJNZherC2LPm40ZSepqRFx1I5HkbdsjzOzJ3H3+KDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L3R5XBl+; dkim-atps=neutral; spf=pass (client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=yu.c.chen@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L3R5XBl+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=yu.c.chen@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPvx06zmGz2xjQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 00:18:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779805093; x=1811341093;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qWQmUISyVvYDZTacgZETA7Z24zdMNhFfMuXRJJtoaaQ=;
  b=L3R5XBl+jkorEH9TKt1hQ9Kp3Wd8uq5UIP72z6mjYOsEyLX6M6Dv651i
   K7TQvPNOkpykwHDlzf7eUNHAXGaFKKHCPMPXMX77I4J8wU7hWQORBiLqv
   BWlN0p7kBLP+EdQf+oLMjKKcX40Rvz8CP1Ki8FWZQLzQzRaEXG/Bhx7K8
   hYnZPJhX4q8XJyjrX4TRYOk7Kx2w7Jf86vmfcGwpB+iLOdK4CkOS8YVtt
   qUyuNWzJqr+C81UZKId/OnangDzYjGy+iYrl+7j8ahqyUrepuwpG9BLS4
   r0KO/iJqc7hSZnCSBedDFS1jVr6MD1Ead/veoccQ0IjXJ5KM9rPHM/D1k
   w==;
X-CSE-ConnectionGUID: x8uUYmkKTZq2V4M0P4oCdQ==
X-CSE-MsgGUID: xs6Ko5fLRsi2qTAs8RW8AQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="92090407"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="92090407"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 07:18:06 -0700
X-CSE-ConnectionGUID: /N/O0jiqRoeBzDL4zz6ugA==
X-CSE-MsgGUID: ust5t8+yRMaCBRZLqc2Yvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="245965852"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by orviesa003.jf.intel.com with ESMTP; 26 May 2026 07:18:03 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: kprateek.nayak@amd.com
Cc: srikar@linux.ibm.com,
	venkat88@linux.ibm.com,
	maddy@linux.ibm.com,
	sshegde@linux.ibm.com,
	riteshh@linux.ibm.com,
	chleroy@kernel.org,
	tim.c.chen@linux.intel.com,
	peterz@infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sched@vger.kernel.org,
	Chen Yu <yu.c.chen@intel.com>
Subject: Re: [BUG] sched/cache: "Make LLC id continuous" causes NULL cpumask
Date: Tue, 26 May 2026 22:08:56 +0800
Message-Id: <20260526140856.139657-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <058664ab-0982-4c13-9d4b-caa2f7616b0f@amd.com>
References: <51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com> <ahUogeqIq5km7JSr@linux.ibm.com> <058664ab-0982-4c13-9d4b-caa2f7616b0f@amd.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Prateek,

On Tue, 26 May 2026 11:23:59 +0530, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
> Hello Srikar,
>
> On 5/26/2026 10:28 AM, Srikar Dronamraju wrote:
> > L2 Cache reported here is for SMT8 Core aka CACHE domain.
>
> Apart for the scheduler, nothing in tree currently cares about
> cpu_coregroup_mask() except for drivers/base/arch_topology.c but
> Power doesn't select GENERIC_ARCH_TOPOLOGY.
>
> Why can't Power have an internal mask for MC domain (tl_mc_mask) and
> the scheduler can use cpu_coregroup_mask() for the actual LLc? (The L2
> mask in this case.)
>
> Power anyways adds its own topology via set_sched_topology() so the
> default_topology from kernel/sched/topology.c remains unused.
>
> ...
>
> > Shouldnt cache-aware scheduling be worried about cpuset partitions too.
> > If a cpuset has subset of LLC cores, then we should Scheduler assume it can
> > control complete LLC?
>
> Well, the scheduling takes care of partitions and the cache aware
> scheduling bits take care of looking at the full system perspective
> for stats aggregation and pointing to a particular LLc.
>
> We don't compare llc_id across cpusets so we keeping one unique llc_id
> per H/W LLC instance is feasible and it enables us to keep llc_id space
> limited for optimizing cache-aware scheduling.
>
> Now if we have threads of same process across partitions, we'll
> still aggregate the utilization numbers across the full LLC but
> the load balancers at individual partitions will make a call on
> the aggregation.
>
> -- 
> Thanks and Regards,
> Prateek
>
>

I suppose what you suggested looks like below:

powerpc/smp: make cpu_coregroup_mask() return the LLC

On pSeries shared LPARs(or coregroup_enabled is false on
Power9 and earlier) the hemisphere map is not allocated, so
build_sched_domains() dereferences a NULL cpumask and crashes.

The generic scheduler expects cpu_coregroup_mask() to span the LLC.
On powerpc the LLC is the L2. Return cpu_l2_cache_mask() instead of
the hemisphere map. Use a coregroup_map() helper for the in-file
hemisphere users, and a powerpc_tl_mc_mask() wrapper for the MC
sched-domain level.

Fixes: b5ea300a17e3 ("sched/cache: Make LLC id continuous")
Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Suggested-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 arch/powerpc/kernel/smp.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1040,11 +1040,22 @@ static const struct cpumask *tl_smallcore_smt_mask(struct sched_domain_topology_
 }
 #endif
 
+static inline struct cpumask *coregroup_map(int cpu)
+{
+	return per_cpu(cpu_coregroup_map, cpu);
+}
+
 struct cpumask *cpu_coregroup_mask(int cpu)
 {
-	return per_cpu(cpu_coregroup_map, cpu);
+	return cpu_l2_cache_mask(cpu);
+}
+
+static const struct cpumask *
+powerpc_tl_mc_mask(struct sched_domain_topology_level *tl, int cpu)
+{
+	return coregroup_map(cpu);
 }
 
 static bool has_coregroup_support(void)
 {
 	if (is_shared_processor())
@@ -1155,7 +1166,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	cpumask_set_cpu(boot_cpuid, cpu_core_mask(boot_cpuid));
 
 	if (has_coregroup_support())
-		cpumask_set_cpu(boot_cpuid, cpu_coregroup_mask(boot_cpuid));
+		cpumask_set_cpu(boot_cpuid, coregroup_map(boot_cpuid));
 
 	init_big_cores();
 	if (has_big_cores) {
@@ -1520,8 +1531,8 @@ static void remove_cpu_from_masks(int cpu)
 		set_cpus_unrelated(cpu, i, cpu_core_mask);
 
 	if (has_coregroup_support()) {
-		for_each_cpu(i, cpu_coregroup_mask(cpu))
-			set_cpus_unrelated(cpu, i, cpu_coregroup_mask);
+		for_each_cpu(i, coregroup_map(cpu))
+			set_cpus_unrelated(cpu, i, coregroup_map);
 	}
 }
 #endif
@@ -1553,7 +1564,7 @@ static void update_coregroup_mask(int cpu, cpumask_var_t *mask)
 	if (!*mask) {
 		/* Assume only siblings are part of this CPU's coregroup */
 		for_each_cpu(i, submask_fn(cpu))
-			set_cpus_related(cpu, i, cpu_coregroup_mask);
+			set_cpus_related(cpu, i, coregroup_map);
 
 		return;
 	}
@@ -1561,18 +1572,18 @@ static void update_coregroup_mask(int cpu, cpumask_var_t *mask)
 	cpumask_and(*mask, cpu_online_mask, cpu_node_mask(cpu));
 
 	/* Update coregroup mask with all the CPUs that are part of submask */
-	or_cpumasks_related(cpu, cpu, submask_fn, cpu_coregroup_mask);
+	or_cpumasks_related(cpu, cpu, submask_fn, coregroup_map);
 
 	/* Skip all CPUs already part of coregroup mask */
-	cpumask_andnot(*mask, *mask, cpu_coregroup_mask(cpu));
+	cpumask_andnot(*mask, *mask, coregroup_map(cpu));
 
 	for_each_cpu(i, *mask) {
 		/* Skip all CPUs not part of this coregroup */
 		if (coregroup_id == cpu_to_coregroup_id(i)) {
-			or_cpumasks_related(cpu, i, submask_fn, cpu_coregroup_mask);
+			or_cpumasks_related(cpu, i, submask_fn, coregroup_map);
 			cpumask_andnot(*mask, *mask, submask_fn(i));
 		} else {
-			cpumask_andnot(*mask, *mask, cpu_coregroup_mask(i));
+			cpumask_andnot(*mask, *mask, coregroup_map(i));
 		}
 	}
 }
@@ -1733,7 +1744,7 @@ static void __init build_sched_topology(void)
 
 	if (has_coregroup_support()) {
 		powerpc_topology[i++] =
-			SDTL_INIT(tl_mc_mask, powerpc_shared_proc_flags, MC);
+			SDTL_INIT(powerpc_tl_mc_mask, powerpc_shared_proc_flags, MC);
 	}
 
 	powerpc_topology[i++] = SDTL_INIT(tl_pkg_mask, powerpc_shared_proc_flags, PKG);
-- 
2.43.0

Thanks,
Yu


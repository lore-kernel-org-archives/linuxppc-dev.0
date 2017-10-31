Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yR65v4Tr5zDqwZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 20:50:10 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9V9l6ur045114
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 05:50:05 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dxj13r8ff-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 05:50:05 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Tue, 31 Oct 2017 09:50:03 -0000
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 maddy@linux.vnet.ibm.com, anju@linux.vnet.ibm.com
Subject: [PATCH] powerpc/perf: Fix core-imc hotplug callback failure during
 imc initialization
Date: Tue, 31 Oct 2017 15:19:58 +0530
Message-Id: <1509443398-26539-1-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Call trace observed during boot:

[c000000ff38ffb80] c0000000002ddfac perf_pmu_migrate_context+0xac/0x470
[c000000ff38ffc40] c00000000011385c ppc_core_imc_cpu_offline+0x1ac/0x1e0
[c000000ff38ffc90] c000000000125758 cpuhp_invoke_callback+0x198/0x5d0
[c000000ff38ffd00] c00000000012782c cpuhp_thread_fun+0x8c/0x3d0
[c000000ff38ffd60] c0000000001678d0 smpboot_thread_fn+0x290/0x2a0
[c000000ff38ffdc0] c00000000015ee78 kthread+0x168/0x1b0
[c000000ff38ffe30] c00000000000b368 ret_from_kernel_thread+0x5c/0x74

While registering the cpuhoplug callbacks for core-imc, if we fails
in the cpuhotplug online path for any random core (either because opal call to
initialize the core-imc counters fails or because memory allocation fails for
that core), ppc_core_imc_cpu_offline() will get invoked for other cpus who
successfully returned from cpuhotplug online path. 

But in the ppc_core_imc_cpu_offline() path we are trying to migrate the event
context, when core-imc counters are not even initialized. Thus creating the
above stack dump.

Add a check to see if core-imc counters are enabled or not in the cpuhotplug
offline path before migrating the context to handle this failing scenario.

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
---
 arch/powerpc/perf/imc-pmu.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 8812624..08139f9 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -30,6 +30,7 @@ static struct imc_pmu *per_nest_pmu_arr[IMC_MAX_PMUS];
 static cpumask_t nest_imc_cpumask;
 struct imc_pmu_ref *nest_imc_refc;
 static int nest_pmus;
+static bool core_imc_enabled;
 
 /* Core IMC data structures and variables */
 
@@ -607,6 +608,19 @@ static int ppc_core_imc_cpu_offline(unsigned int cpu)
 	if (!cpumask_test_and_clear_cpu(cpu, &core_imc_cpumask))
 		return 0;
 
+	/*
+	 * See if core imc counters are enabled or not.
+	 *
+	 * Suppose we reach here from core_imc_cpumask_init(),
+	 * since we failed at the cpuhotplug online path for any random
+	 * core (either because opal call to initialize the core-imc counters
+	 * failed  or because memory allocation failed).
+	 * We need to check whether core imc counters are enabled or not before
+	 * migrating the event context from cpus in the other cores.
+	 */
+	if (!core_imc_enabled)
+		return 0;
+
 	/* Find any online cpu in that core except the current "cpu" */
 	ncpu = cpumask_any_but(cpu_sibling_mask(cpu), cpu);
 
@@ -1299,6 +1313,7 @@ int init_imc_pmu(struct device_node *parent, struct imc_pmu *pmu_ptr, int pmu_id
 			return ret;
 		}
 
+		core_imc_enabled = true;
 		break;
 	case IMC_DOMAIN_THREAD:
 		ret = thread_imc_cpu_init();
-- 
2.7.4

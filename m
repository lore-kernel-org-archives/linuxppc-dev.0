Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHzpB1KKNzDqF4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 06:41:53 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9JJdMbK045566
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 15:41:51 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dq28j0emc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 15:41:51 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Thu, 19 Oct 2017 15:41:49 -0400
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: gpiccoli@linux.vnet.ibm.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, anju@linux.vnet.ibm.com
Subject: [PATCH] powerpc/perf: Fix IMC allocation routine
Date: Thu, 19 Oct 2017 17:41:33 -0200
Message-Id: <20171019194133.27485-1-gpiccoli@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When setting nr_cpus=1, we observed a crash in IMC code during boot
due to a missing allocation: basically, IMC code is taking the number
of threads into account in imc_mem_init() and if we manually set
nr_cpus for a value that is not multiple of the number of threads per
core, an integer division in that function will discard the decimal
portion, leading IMC to not allocate one mem_info struct. This causes
a NULL pointer dereference later, on is_core_imc_mem_inited().

This patch just rounds that division up, fixing the bug.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
---
Anju, looks good to you? Tested in P9 with latest FW available.

 arch/powerpc/perf/imc-pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 88126245881b..92ae5de0bbac 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -1104,7 +1104,7 @@ static int init_nest_pmu_ref(void)
 
 static void cleanup_all_core_imc_memory(void)
 {
-	int i, nr_cores = num_present_cpus() / threads_per_core;
+	int i, nr_cores = DIV_ROUND_UP(num_present_cpus(), threads_per_core);
 	struct imc_mem_info *ptr = core_imc_pmu->mem_info;
 	int size = core_imc_pmu->counter_mem_size;
 
@@ -1212,7 +1212,7 @@ static int imc_mem_init(struct imc_pmu *pmu_ptr, struct device_node *parent,
 		if (!pmu_ptr->pmu.name)
 			return -ENOMEM;
 
-		nr_cores = num_present_cpus() / threads_per_core;
+		nr_cores = DIV_ROUND_UP(num_present_cpus(), threads_per_core);
 		pmu_ptr->mem_info = kcalloc(nr_cores, sizeof(struct imc_mem_info),
 								GFP_KERNEL);
 
-- 
2.14.2

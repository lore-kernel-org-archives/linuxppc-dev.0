Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40m4SJ60HTzF1PD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 16:35:28 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4G6YIGY091273
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 02:35:25 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j0ce0eu8q-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 02:35:25 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Wed, 16 May 2018 07:35:23 +0100
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com, ppaidipe@linux.vnet.ibm.com, bsingharora@gmail.com
Subject: [PATCH v2] powerpc/perf: Fix memory allocation for core-imc based on
 num_possible_cpus()
Date: Wed, 16 May 2018 12:05:18 +0530
Message-Id: <1526452518-12611-1-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently memory is allocated for core-imc based on cpu_present_mask,
which has bit 'cpu' set iff cpu is populated. We use (cpu number / threads
per core) as the array index to access the memory.

Under some circumstances firmware marks a CPU as GUARDed CPU and boot the
system, until cleared of errors, these CPU's are unavailable for all
subsequent boots. GUARDed CPUs are possible but not present from linux
view, so it blows a hole when we assume the max length of our allocation
is driven by our max present cpus, where as one of the cpus might be online
and be beyond the max present cpus, due to the hole. 
So (cpu number / threads per core) value bounds the array index and leads
to memory overflow.

Call trace observed during a guard test:

Faulting instruction address: 0xc000000000149f1c
cpu 0x69: Vector: 380 (Data Access Out of Range) at [c000003fea303420]
    pc:c000000000149f1c: prefetch_freepointer+0x14/0x30
    lr:c00000000014e0f8: __kmalloc+0x1a8/0x1ac
    sp:c000003fea3036a0
   msr:9000000000009033
   dar:c9c54b2c91dbf6b7
  current = 0xc000003fea2c0000
  paca    = 0xc00000000fddd880	 softe: 3	 irq_happened: 0x01
    pid   = 1, comm = swapper/104
Linux version 4.16.7-openpower1 (smc@smc-desktop) (gcc version 6.4.0
(Buildroot 2018.02.1-00006-ga8d1126)) #2 SMP Fri May 4 16:44:54 PDT 2018
enter ? for help
call trace:
	 __kmalloc+0x1a8/0x1ac
	 (unreliable)
	 init_imc_pmu+0x7f4/0xbf0
	 opal_imc_counters_probe+0x3fc/0x43c
	 platform_drv_probe+0x48/0x80
	 driver_probe_device+0x22c/0x308
	 __driver_attach+0xa0/0xd8
	 bus_for_each_dev+0x88/0xb4
	 driver_attach+0x2c/0x40
	 bus_add_driver+0x1e8/0x228
	 driver_register+0xd0/0x114
	 __platform_driver_register+0x50/0x64
	 opal_imc_driver_init+0x24/0x38
	 do_one_initcall+0x150/0x15c
	 kernel_init_freeable+0x250/0x254
	 kernel_init+0x1c/0x150
	 ret_from_kernel_thread+0x5c/0xc8

Allocating memory for core-imc based on cpu_possible_mask, which has
bit 'cpu' set iff cpu is populatable, will fix this issue.

Reported-by: Pridhiviraj Paidipeddi <ppaidipe@linux.vnet.ibm.com>
Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Reviewed-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/perf/imc-pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index d7532e7..75fb23c 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -1146,7 +1146,7 @@ static int init_nest_pmu_ref(void)
 
 static void cleanup_all_core_imc_memory(void)
 {
-	int i, nr_cores = DIV_ROUND_UP(num_present_cpus(), threads_per_core);
+	int i, nr_cores = DIV_ROUND_UP(num_possible_cpus(), threads_per_core);
 	struct imc_mem_info *ptr = core_imc_pmu->mem_info;
 	int size = core_imc_pmu->counter_mem_size;
 
@@ -1264,7 +1264,7 @@ static int imc_mem_init(struct imc_pmu *pmu_ptr, struct device_node *parent,
 		if (!pmu_ptr->pmu.name)
 			return -ENOMEM;
 
-		nr_cores = DIV_ROUND_UP(num_present_cpus(), threads_per_core);
+		nr_cores = DIV_ROUND_UP(num_possible_cpus(), threads_per_core);
 		pmu_ptr->mem_info = kcalloc(nr_cores, sizeof(struct imc_mem_info),
 								GFP_KERNEL);
 
-- 
2.7.4

Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yFVj93sfJzDrFp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 05:43:56 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9FIhoO9102711
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Oct 2017 14:43:54 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dm6k9k7h3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Oct 2017 14:43:53 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Sun, 15 Oct 2017 19:43:52 +0100
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v9FIhmau17563896
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Oct 2017 18:43:49 GMT
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v9FIhlqJ031864
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 05:43:48 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH 1/2] powerpc/perf/imc: use cpu_to_node instead
 topology_physical_package_id
Date: Mon, 16 Oct 2017 00:13:41 +0530
Message-Id: <1508093022-11496-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

...
[1069001518.000000] [c000003f95b3f770] [c0000000000b2574] init_imc_pmu+0x1f4/0xc40
[1069005374.000000] [c000003f95b3f850] [c00000000008fec8] opal_imc_counters_probe+0x2e8/0x3e0
[1069009426.000000] [c000003f95b3f950] [c0000000006153a4] platform_drv_probe+0x44/0x90
[1069012818.000000] [c000003f95b3f9c0] [c0000000006124c0] really_probe+0x290/0x370
[1069016302.000000] [c000003f95b3fa50] [c0000000006126c8] __driver_attach+0x128/0x130
[1069019564.000000] [c000003f95b3fa90] [c00000000060f38c] bus_for_each_dev+0x9c/0x110
[1069022838.000000] [c000003f95b3fae0] [c000000000611dfc] driver_attach+0x3c/0x60
[1069026104.000000] [c000003f95b3fb10] [c0000000006118d8] bus_add_driver+0x298/0x320
[1069029428.000000] [c000003f95b3fb90] [c0000000006135b8] driver_register+0xb8/0x1a0
[1069033016.000000] [c000003f95b3fc00] [c00000000061533c] __platform_driver_register+0x8c/0xb0
[1069036362.000000] [c000003f95b3fc30] [c000000000cbb0fc] opal_imc_driver_init+0x24/0x38
[1069039756.000000] [c000003f95b3fc50] [c00000000000cc70] do_one_initcall+0xd0/0x250
[1069043094.000000] [c000003f95b3fd20] [c000000000ca44d0] kernel_init_freeable+0x244/0x324
[1069046490.000000] [c000003f95b3fdc0] [c00000000000d600] kernel_init+0x30/0x1b0
[1069050348.000000] [c000003f95b3fe30] [c00000000000b268] ret_from_kernel_thread+0x5c/0x74

init_imc_pmu() use topology_physical_package_id() to detect the phy_id
of the processor it is on to get local memory. But this cause crashes
when node_id are not same as physicaly id. As a fix use cpu_to_node().

Reported-By: Rob Lippert <rlippert@google.com>
Tested-By: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/imc-pmu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 88126245881b..88d1415e2547 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -467,7 +467,7 @@ static int nest_imc_event_init(struct perf_event *event)
 	 * Nest HW counter memory resides in a per-chip reserve-memory (HOMER).
 	 * Get the base memory addresss for this cpu.
 	 */
-	chip_id = topology_physical_package_id(event->cpu);
+	chip_id = cpu_to_chip_id(event->cpu);
 	pcni = pmu->mem_info;
 	do {
 		if (pcni->id == chip_id) {
@@ -524,19 +524,19 @@ static int nest_imc_event_init(struct perf_event *event)
  */
 static int core_imc_mem_init(int cpu, int size)
 {
-	int phys_id, rc = 0, core_id = (cpu / threads_per_core);
+	int nid, rc = 0, core_id = (cpu / threads_per_core);
 	struct imc_mem_info *mem_info;
 
 	/*
 	 * alloc_pages_node() will allocate memory for core in the
 	 * local node only.
 	 */
-	phys_id = topology_physical_package_id(cpu);
+	nid = cpu_to_node(cpu);
 	mem_info = &core_imc_pmu->mem_info[core_id];
 	mem_info->id = core_id;
 
 	/* We need only vbase for core counters */
-	mem_info->vbase = page_address(alloc_pages_node(phys_id,
+	mem_info->vbase = page_address(alloc_pages_node(nid,
 					  GFP_KERNEL | __GFP_ZERO | __GFP_THISNODE |
 					  __GFP_NOWARN, get_order(size)));
 	if (!mem_info->vbase)
@@ -783,14 +783,14 @@ static int core_imc_event_init(struct perf_event *event)
 static int thread_imc_mem_alloc(int cpu_id, int size)
 {
 	u64 ldbar_value, *local_mem = per_cpu(thread_imc_mem, cpu_id);
-	int phys_id = topology_physical_package_id(cpu_id);
+	int nid = cpu_to_node(cpu_id);
 
 	if (!local_mem) {
 		/*
 		 * This case could happen only once at start, since we dont
 		 * free the memory in cpu offline path.
 		 */
-		local_mem = page_address(alloc_pages_node(phys_id,
+		local_mem = page_address(alloc_pages_node(nid,
 				  GFP_KERNEL | __GFP_ZERO | __GFP_THISNODE |
 				  __GFP_NOWARN, get_order(size)));
 		if (!local_mem)
-- 
2.7.4

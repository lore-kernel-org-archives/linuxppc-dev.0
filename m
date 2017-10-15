Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yFVjC4XXWzDrFp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 05:43:59 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9FIhnUs035581
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Oct 2017 14:43:56 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dma4qw7hc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Oct 2017 14:43:56 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Sun, 15 Oct 2017 19:43:55 +0100
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v9FIhpwC15138974
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Oct 2017 18:43:52 GMT
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v9FIhoWt031891
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 05:43:51 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH 2/2] powerpc/perf/imc: use NUMA_NO_NODE for alloc_pages_node
Date: Mon, 16 Oct 2017 00:13:42 +0530
In-Reply-To: <1508093022-11496-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1508093022-11496-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1508093022-11496-2-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

alloc_pages_node() when passed NUMA_NO_NODE for the
node_id, could get memory from closest node. Cleanup
core imc and thread imc memory init functions to use
NUMA_NO_NODE.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/imc-pmu.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 88d1415e2547..897098fb2a31 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -524,19 +524,18 @@ static int nest_imc_event_init(struct perf_event *event)
  */
 static int core_imc_mem_init(int cpu, int size)
 {
-	int nid, rc = 0, core_id = (cpu / threads_per_core);
+	int rc = 0, core_id = (cpu / threads_per_core);
 	struct imc_mem_info *mem_info;
 
 	/*
 	 * alloc_pages_node() will allocate memory for core in the
 	 * local node only.
 	 */
-	nid = cpu_to_node(cpu);
 	mem_info = &core_imc_pmu->mem_info[core_id];
 	mem_info->id = core_id;
 
 	/* We need only vbase for core counters */
-	mem_info->vbase = page_address(alloc_pages_node(nid,
+	mem_info->vbase = page_address(alloc_pages_node(NUMA_NO_NODE,
 					  GFP_KERNEL | __GFP_ZERO | __GFP_THISNODE |
 					  __GFP_NOWARN, get_order(size)));
 	if (!mem_info->vbase)
@@ -783,14 +782,13 @@ static int core_imc_event_init(struct perf_event *event)
 static int thread_imc_mem_alloc(int cpu_id, int size)
 {
 	u64 ldbar_value, *local_mem = per_cpu(thread_imc_mem, cpu_id);
-	int nid = cpu_to_node(cpu_id);
 
 	if (!local_mem) {
 		/*
 		 * This case could happen only once at start, since we dont
 		 * free the memory in cpu offline path.
 		 */
-		local_mem = page_address(alloc_pages_node(nid,
+		local_mem = page_address(alloc_pages_node(NUMA_NO_NODE,
 				  GFP_KERNEL | __GFP_ZERO | __GFP_THISNODE |
 				  __GFP_NOWARN, get_order(size)));
 		if (!local_mem)
-- 
2.7.4

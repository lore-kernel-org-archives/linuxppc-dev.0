Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yBvCj4x5nzDr5S
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 23:57:53 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9BCsYJg054305
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 08:57:50 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dhhahaev1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 08:57:50 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Wed, 11 Oct 2017 13:57:48 +0100
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v9BCvjvH23724244
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 12:57:46 GMT
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v9BCviMS026013
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 23:57:45 +1100
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: anju@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, maddy@linux.vnet.ibm.com,
 hemant@linux.vnet.ibm.com
Subject: [PATCH] powerpc/perf: Add ___GFP_NOWARN flag to alloc_pages_node()
Date: Wed, 11 Oct 2017 18:27:39 +0530
Message-Id: <1507726659-9524-1-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stack trace output during a stress test:
 [    4.310049] Freeing initrd memory: 22592K
[    4.310646] rtas_flash: no firmware flash support
[    4.313341] cpuhp/64: page allocation failure: order:0, mode:0x14480c0(GFP_KERNEL|__GFP_ZERO|__GFP_THISNODE), nodemask=(null)
[    4.313465] cpuhp/64 cpuset=/ mems_allowed=0
[    4.313521] CPU: 64 PID: 392 Comm: cpuhp/64 Not tainted 4.11.0-39.el7a.ppc64le #1
[    4.313588] Call Trace:
[    4.313622] [c000000f1fb1b8e0] [c000000000c09388] dump_stack+0xb0/0xf0 (unreliable)
[    4.313694] [c000000f1fb1b920] [c00000000030ef6c] warn_alloc+0x12c/0x1c0
[    4.313753] [c000000f1fb1b9c0] [c00000000030ff68] __alloc_pages_nodemask+0xea8/0x1000
[    4.313823] [c000000f1fb1bbb0] [c000000000113a8c] core_imc_mem_init+0xbc/0x1c0
[    4.313892] [c000000f1fb1bc00] [c000000000113cdc] ppc_core_imc_cpu_online+0x14c/0x170
[    4.313962] [c000000f1fb1bc90] [c000000000125758] cpuhp_invoke_callback+0x198/0x5d0
[    4.314031] [c000000f1fb1bd00] [c00000000012782c] cpuhp_thread_fun+0x8c/0x3d0
[    4.314101] [c000000f1fb1bd60] [c0000000001678d0] smpboot_thread_fn+0x290/0x2a0
[    4.314169] [c000000f1fb1bdc0] [c00000000015ee78] kthread+0x168/0x1b0
[    4.314229] [c000000f1fb1be30] [c00000000000b368] ret_from_kernel_thread+0x5c/0x74
[    4.314313] Mem-Info:
[    4.314356] active_anon:0 inactive_anon:0 isolated_anon:0

core_imc_mem_init() at system boot use alloc_pages_node() to get memory
and alloc_pages_node() throws this stack dump when tried to allocate
memory from a node which has no memory behind it. Add a ___GFP_NOWARN
flag in allocation request as a fix. 

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Reported-by: Venkat R.B <venkatb3@in.ibm.com>
---
 arch/powerpc/perf/imc-pmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 9ccac86f3463..d99ea01a2028 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -523,8 +523,8 @@ static int core_imc_mem_init(int cpu, int size)
 
 	/* We need only vbase for core counters */
 	mem_info->vbase = page_address(alloc_pages_node(phys_id,
-					  GFP_KERNEL | __GFP_ZERO | __GFP_THISNODE,
-					  get_order(size)));
+					  GFP_KERNEL | __GFP_ZERO | __GFP_THISNODE |
+					  __GFP_NOWARN, get_order(size)));
 	if (!mem_info->vbase)
 		return -ENOMEM;
 
@@ -763,8 +763,8 @@ static int thread_imc_mem_alloc(int cpu_id, int size)
 		 * free the memory in cpu offline path.
 		 */
 		local_mem = page_address(alloc_pages_node(phys_id,
-				  GFP_KERNEL | __GFP_ZERO | __GFP_THISNODE,
-				  get_order(size)));
+				  GFP_KERNEL | __GFP_ZERO | __GFP_THISNODE |
+				  __GFP_NOWARN, get_order(size)));
 		if (!local_mem)
 			return -ENOMEM;
 
-- 
2.14.1

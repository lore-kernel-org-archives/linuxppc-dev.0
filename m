Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWDHh09fZzDr0Y
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 21:42:39 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7EBeYiB143729
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 07:42:36 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cb4kfs3k7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 07:42:35 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Mon, 14 Aug 2017 21:42:33 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7EBgWx837748804
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 21:42:32 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7EBgVp1029637
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 21:42:31 +1000
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 hemant@linux.vnet.ibm.com
Subject: [PATCH] Fix for supporting nest events on muti socket system
Date: Mon, 14 Aug 2017 17:12:23 +0530
Message-Id: <1502710943-22738-1-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In a multi node system with discontinuous node id, nest event values
are not showing up properly.That is,

snip from lscpu output:

..
NUMA node0 CPU(s): 0-15
NUMA node8 CPU(s): 16-31
..

Nest event values on such systems are broken:

$./perf stat -e 'nest_powerbus0_imc/PM_PB_CYC/' -C 0-14 -I 1000 sleep 1000
#           time             counts unit events
     1.000294577    30,17,24,42,880 nest_powerbus0_imc/PM_PB_CYC/
     2.000528938    29,92,08,53,760 nest_powerbus0_imc/PM_PB_CYC/
     3.000713925    29,92,08,00,000 nest_powerbus0_imc/PM_PB_CYC/
     4.000901944    29,95,08,63,360 nest_powerbus0_imc/PM_PB_CYC/
     5.001089119    29,92,07,92,320 nest_powerbus0_imc/PM_PB_CYC/
     6.001276106    29,92,08,11,520 nest_powerbus0_imc/PM_PB_CYC/

$./perf stat -e 'nest_powerbus0_imc/PM_PB_CYC/' -C 16-28 -I 1000 sleep 1000
#           time             counts unit events
     1.000049902    <not supported> nest_powerbus0_imc/PM_PB_CYC/
     2.000147269    <not supported> nest_powerbus0_imc/PM_PB_CYC/
     3.000219730    <not supported> nest_powerbus0_imc/PM_PB_CYC/
     4.000288098    <not supported> nest_powerbus0_imc/PM_PB_CYC/
     5.000358716    <not supported> nest_powerbus0_imc/PM_PB_CYC/
     6.000435615    <not supported> nest_powerbus0_imc/PM_PB_CYC/
     7.000508481    <not supported> nest_powerbus0_imc/PM_PB_CYC/

This is because, when fetching for the reference count, node id is used
as the array index which is not how this is done when initializing the
structure. Patch to fix the same by using the right index to get the
nest_imc_refc.

$./perf stat -e 'nest_powerbus0_imc/PM_PB_CYC/' -C 16-28 -I 1000 sleep 1000
#           time             counts unit events
     1.000241961    26,12,35,28,704 nest_powerbus0_imc/PM_PB_CYC/
     2.000451678    25,95,72,48,512 nest_powerbus0_imc/PM_PB_CYC/
     3.000634963    25,93,13,96,608 nest_powerbus0_imc/PM_PB_CYC/
     4.000821186    25,95,74,38,208 nest_powerbus0_imc/PM_PB_CYC/
     5.001005221    25,93,13,30,048 nest_powerbus0_imc/PM_PB_CYC/ 

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
---
 arch/powerpc/perf/imc-pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 46cd912..bbcce29 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -1064,7 +1064,7 @@ static int init_nest_pmu_ref(void)
 	 */
 	for_each_possible_cpu(cpu) {
 		nid = cpu_to_node(cpu);
-		for_each_online_node(i) {
+		for (i = 0; i < num_possible_nodes(); i++) {
 			if (nest_imc_refc[i].id == nid) {
 				per_cpu(local_nest_imc_refc, cpu) = &nest_imc_refc[i];
 				break;
-- 
2.7.4

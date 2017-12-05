Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yrvYb0hv6zDr8Q
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Dec 2017 08:11:14 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vB5L9oT3010499
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Dec 2017 16:11:11 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2eny1qvj9e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Dec 2017 16:11:10 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 5 Dec 2017 16:11:09 -0500
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 vB5LB7VC46989520
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Dec 2017 21:11:07 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 82A172803E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Dec 2017 16:10:34 -0500 (EST)
Received: from ltcalpine2-lp14.aus.stglabs.ibm.com (unknown [9.40.195.197])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP id 542042803D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Dec 2017 16:10:34 -0500 (EST)
Subject: [PATCH] powerpc/numa: Invalidate numa_cpu_lookup_table on cpu remove
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Tue, 05 Dec 2017 14:55:41 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <151250734088.18010.16614705059743383721.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When DLPAR removing a CPU, the unmapping of the cpu from a node in
unmap_cpu_from_node() should also invalidate the CPUs entry in the
numa_cpu_lookup_table. There is not a guarantee that on a subsequent
DLPAR add of the CPU the associativity will be the same and thus
could be in a different node. Invalidating the entry in the
numa_cpu_lookup_table causes the associativity to be read from the
device tree at the time of the add.

The current behavior of not invalidating the CPUs entry in the
numa_cpu_lookup_table can result in scenarios where the the topology
layout of CPUs in the partition does not match the device tree
or the topology reported by the HMC.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index adb6364f4091..415b1a76b429 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -164,6 +164,8 @@ static void unmap_cpu_from_node(unsigned long cpu)
 
 	dbg("removing cpu %lu from node %d\n", cpu, node);
 
+	update_numa_cpu_lookup_table(cpu, -1);
+
 	if (cpumask_test_cpu(cpu, node_to_cpumask_map[node])) {
 		cpumask_clear_cpu(cpu, node_to_cpumask_map[node]);
 	} else {

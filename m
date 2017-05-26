Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wZ5kD4Tc9zDqVf
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 May 2017 22:56:52 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4QCrUVA068183
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 May 2017 08:56:48 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2apk7yctj4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 May 2017 08:56:48 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Fri, 26 May 2017 08:56:47 -0400
In-Reply-To: <20170526124725.32917.86194.stgit@ltcalpine2-lp20.aus.stglabs.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Reza Arbab <arbab@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Bharata B Rao <bharata@linux.vnet.ib>,
 Balbir Singh <bsingharora@gmail.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Shailendra Singh <shailendras@nvidia.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH V3 2/2] powerpc/hotplug/mm: Fix hot-add memory node assoc
Date: Fri, 26 May 2017 07:56:41 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <bd1197e8-2761-491c-d598-f9559545f418@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Removing or adding memory via the PowerPC hotplug interface currently
dumps newly added processors or memory into default node 0, instead of
into the node that would be calculated based upon the VPHN affinity
tables.  The code was updated to ensure that all nodes found at boot
are still available to subsequent DLPAR hotplug-memory operations,
even if they are not needed at boot time.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
Changes in V3:
  -- Remove code not relevant to this defect.
---
 arch/powerpc/mm/numa.c |    7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 15c2dd5..18f3038 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -907,13 +907,6 @@ void __init initmem_init(void)
 
 	memblock_dump_all();
 
-	/*
-	 * Reduce the possible NUMA nodes to the online NUMA nodes,
-	 * since we do not support node hotplug. This ensures that  we
-	 * lower the maximum NUMA node ID to what is actually present.
-	 */
-	nodes_and(node_possible_map, node_possible_map, node_online_map);
-
 	for_each_online_node(nid) {
 		unsigned long start_pfn, end_pfn;
 

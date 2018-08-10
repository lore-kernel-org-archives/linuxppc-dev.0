Return-Path: <srikar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41nBG94vylzDqrN
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Aug 2018 03:00:48 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7AGxKk9110514
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2018 13:00:46 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kscgdw5hr-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2018 13:00:45 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Fri, 10 Aug 2018 18:00:43 +0100
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Mel Gorman <mgorman@techsingularity.net>,
 Rik van Riel <riel@surriel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Andre Wild <wild@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/2] sched/topology: Set correct numa topology type
Date: Fri, 10 Aug 2018 22:30:18 +0530
In-Reply-To: <reply-to=<20180808081942.GA37418@linux.vnet.ibm.com>
References: <reply-to=<20180808081942.GA37418@linux.vnet.ibm.com>
Message-Id: <1533920419-17410-1-git-send-email-srikar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With commit 051f3ca02e46 ("sched/topology: Introduce NUMA identity node
sched domain") scheduler introduces an new numa level. However this
leads to numa topology on 2 node systems no more marked as NUMA_DIRECT.
After this commit, it gets reported as NUMA_BACKPLANE. This is because
sched_domains_numa_level is now 2 on 2 node systems.

Fix this by allowing setting systems that have upto 2 numa levels as
NUMA_DIRECT.

While here remove a code that assumes level can be 0.

Fixes: 051f3ca02e46 "Introduce NUMA identity node sched domain"
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 kernel/sched/topology.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index a6e6b855ba81..cec3ee3ed320 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1315,7 +1315,7 @@ static void init_numa_topology_type(void)
 
 	n = sched_max_numa_distance;
 
-	if (sched_domains_numa_levels <= 1) {
+	if (sched_domains_numa_levels <= 2) {
 		sched_numa_topology_type = NUMA_DIRECT;
 		return;
 	}
@@ -1400,9 +1400,6 @@ void sched_init_numa(void)
 			break;
 	}
 
-	if (!level)
-		return;
-
 	/*
 	 * 'level' contains the number of unique distances
 	 *
-- 
2.12.3

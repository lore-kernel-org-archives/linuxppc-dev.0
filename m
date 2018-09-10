Return-Path: <tipbot@zytor.com>
Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4284Tw5yb5zF09c
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 20:46:28 +1000 (AEST)
Date: Mon, 10 Sep 2018 03:06:09 -0700
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Srikar Dronamraju <tipbot@zytor.com>
Message-ID: <tip-e5e96fafd9028b1478b165db78c52d981c14f471@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 torvalds@linux-foundation.org, wild@linux.vnet.ibm.com,
 suravee.suthikulpanit@amd.com, hpa@zytor.com, mingo@kernel.org,
 mpe@ellerman.id.au, heiko.carstens@de.ibm.com, tglx@linutronix.de,
 peterz@infradead.org, riel@surriel.com, srikar@linux.vnet.ibm.com,
 mgorman@techsingularity.net
Reply-To: mingo@kernel.org, hpa@zytor.com, suravee.suthikulpanit@amd.com,
 torvalds@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 wild@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 srikar@linux.vnet.ibm.com, mgorman@techsingularity.net,
 riel@surriel.com, peterz@infradead.org, tglx@linutronix.de,
 heiko.carstens@de.ibm.com, mpe@ellerman.id.au
In-Reply-To: <1533920419-17410-1-git-send-email-srikar@linux.vnet.ibm.com>
References: <1533920419-17410-1-git-send-email-srikar@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/topology: Set correct NUMA topology type
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit-ID:  e5e96fafd9028b1478b165db78c52d981c14f471
Gitweb:     https://git.kernel.org/tip/e5e96fafd9028b1478b165db78c52d981c14f471
Author:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
AuthorDate: Fri, 10 Aug 2018 22:30:18 +0530
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 10 Sep 2018 10:13:45 +0200

sched/topology: Set correct NUMA topology type

With the following commit:

  051f3ca02e46 ("sched/topology: Introduce NUMA identity node sched domain")

the scheduler introduced a new NUMA level. However this leads to the NUMA topology
on 2 node systems to not be marked as NUMA_DIRECT anymore.

After this commit, it gets reported as NUMA_BACKPLANE, because
sched_domains_numa_level is now 2 on 2 node systems.

Fix this by allowing setting systems that have up to 2 NUMA levels as
NUMA_DIRECT.

While here remove code that assumes that level can be 0.

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andre Wild <wild@linux.vnet.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Fixes: 051f3ca02e46 "Introduce NUMA identity node sched domain"
Link: http://lkml.kernel.org/r/1533920419-17410-1-git-send-email-srikar@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/topology.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 56a0fed30c0a..505a41c42b96 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1295,7 +1295,7 @@ static void init_numa_topology_type(void)
 
 	n = sched_max_numa_distance;
 
-	if (sched_domains_numa_levels <= 1) {
+	if (sched_domains_numa_levels <= 2) {
 		sched_numa_topology_type = NUMA_DIRECT;
 		return;
 	}
@@ -1380,9 +1380,6 @@ void sched_init_numa(void)
 			break;
 	}
 
-	if (!level)
-		return;
-
 	/*
 	 * 'level' contains the number of unique distances
 	 *

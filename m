Return-Path: <alex.shi@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by ozlabs.org (Postfix) with ESMTP id 03328B6F9A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2012 16:54:46 +1000 (EST)
From: Alex Shi <alex.shi@intel.com>
To: a.p.zijlstra@chello.nl
Subject: [RFC PATCH] sched/numa: do load balance between remote nodes
Date: Wed,  6 Jun 2012 14:52:51 +0800
Message-Id: <1338965571-9812-1-git-send-email-alex.shi@intel.com>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, dhowells@redhat.com, paulus@samba.org, hpa@zytor.com,
 sparclinux@vger.kernel.org, mingo@kernel.org, sivanich@sgi.com, x86@kernel.org,
 greg.pearson@hp.com, chris.mason@oracle.com, arjan.van.de.ven@intel.com,
 mattst88@gmail.com, pjt@google.com, fenghua.yu@intel.com,
 seto.hidetoshi@jp.fujitsu.com, cmetcalf@tilera.com, ak@linux.intel.com,
 ink@jurassic.park.msu.ru, anton@samba.org, tglx@linutronix.de,
 kamezawa.hiroyu@jp.fujitsu.com, rth@twiddle.net, tony.luck@intel.com,
 torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
 ralf@linux-mips.org, lethal@linux-sh.org, linux-alpha@vger.kernel.org,
 bob.picco@oracle.com, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit cb83b629b remove the NODE sched domain and check if the node
distance in SLIT table is farther than REMOTE_DISTANCE, if so, it will
lose the load balance chance at exec/fork/wake_affine points.

But actually, even the node distance is farther than REMOTE_DISTANCE,
Modern CPUs also has QPI like connections, that make memory access is
not too slow between nodes. So above losing on NUMA machine make a
huge performance regression on benchmark: hackbench, tbench, netperf
and oltp etc.

This patch will recover the scheduler behavior to old mode on all my
Intel platforms: NHM EP/EX, WSM EP, SNB EP/EP4S, and so remove the
perfromance regressions. (all of them just has 2 kinds distance, 10 21)

Signed-off-by: Alex Shi <alex.shi@intel.com>
---
 kernel/sched/core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 39eb601..b2ee41a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6286,7 +6286,7 @@ static int sched_domains_curr_level;
 
 static inline int sd_local_flags(int level)
 {
-	if (sched_domains_numa_distance[level] > REMOTE_DISTANCE)
+	if (sched_domains_numa_distance[level] > RECLAIM_DISTANCE)
 		return 0;
 
 	return SD_BALANCE_EXEC | SD_BALANCE_FORK | SD_WAKE_AFFINE;
-- 
1.7.5.4

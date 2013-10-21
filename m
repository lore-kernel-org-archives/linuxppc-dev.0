Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 632842C00D1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Oct 2013 22:44:59 +1100 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Mon, 21 Oct 2013 21:44:50 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 887483578040
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Oct 2013 22:44:48 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9LBRS6M5505306
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Oct 2013 22:27:28 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9LBiloF027272
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Oct 2013 22:44:48 +1100
Subject: [PATCH 1/3] sched: Fix nohz_kick_needed to consider the nr_busy of
 the parent domain's group
To: Peter Zijlstra <peterz@infradead.org>,
 Mike Galbraith <bitbucket@online.de>, Paul Turner <pjt@google.com>,
 Ingo Molnar <mingo@kernel.org>
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Date: Mon, 21 Oct 2013 17:14:42 +0530
Message-ID: <20131021114442.13291.99344.stgit@drishya>
In-Reply-To: <20131021114002.13291.31478.stgit@drishya>
References: <20131021114002.13291.31478.stgit@drishya>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Michael Neuling <mikey@neuling.org>, linux-kernel@vger.kernel.org,
 Anton Blanchard <anton@samba.org>, Preeti U Murthy <preeti@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Preeti U Murthy <preeti@linux.vnet.ibm.com>

In nohz_kick_needed() there are checks around the flags
SD_SHARE_PKG_RESOURCES which decide to initiate nohz_balance if the
domains with this flag set have more than one cpu busy. Therefore at
every domain, a check has to be made on nr_busy of that domain. This
means the sum of the nr_busy of each group in that domain needs to be
checked, since nr_busy is a parameter which is associated with
a group.  However in the current implementation of nohz_kick_needed(),
the nr_busy is being checked for just the group to which the cpu that
has initiated this check belongs to. This will give us the wrong count
of the number of busy cpus in that domain.

The following commit which fixed the sgp->nr_busy_cpus computation
actually exposed the bug in nohz_kick_needed() which worked when
nr_busy was incorrectly > 1

25f55d9d01ad7a7ad248fd5af1d22675ffd202c5
sched: Fix init NOHZ_IDLE flag

To illustrate the scenario,  consider a core, whose domain will have
the SD_SHARE_PKG_RESOURCES set. We want to kick nohz_idle_balance when
we find that more than one thread in the core is busy. With the
current implementation of nohz_kick_needed(), at this domain(sd), the
nr_busy will be 1 always since it returns this parameter for
sd->groups which encompasses a single thread, while we want this
parameter for sd->parent->groups which will rightly point to the
number of busy threads in the core.

This patch also ensures that the order of check for
SD_SHARE_PKG_RESOURCE comes before the check for ASYM_PACKING.
Priority is given to avoid more than one busy thread in a core as much
as possible before attempting asymmetric packing.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
---
 kernel/sched/fair.c |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7c70201..12f0eab 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5807,12 +5807,19 @@ static inline int nohz_kick_needed(struct rq *rq, int cpu)
 
 	rcu_read_lock();
 	for_each_domain(cpu, sd) {
-		struct sched_group *sg = sd->groups;
-		struct sched_group_power *sgp = sg->sgp;
-		int nr_busy = atomic_read(&sgp->nr_busy_cpus);
-
-		if (sd->flags & SD_SHARE_PKG_RESOURCES && nr_busy > 1)
-			goto need_kick_unlock;
+		struct sched_domain *sd_parent = sd->parent;
+		struct sched_group *sg;
+		struct sched_group_power *sgp;
+		int nr_busy;
+
+		if (sd_parent) {
+			sg = sd_parent->groups;
+			sgp = sg->sgp;
+			nr_busy = atomic_read(&sgp->nr_busy_cpus);
+
+			if (sd->flags & SD_SHARE_PKG_RESOURCES && nr_busy > 1)
+				goto need_kick_unlock;
+		}
 
 		if (sd->flags & SD_ASYM_PACKING && nr_busy != sg->group_weight
 		    && (cpumask_first_and(nohz.idle_cpus_mask,

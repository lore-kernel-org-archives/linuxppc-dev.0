Return-Path: <jschopp@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 20A2FB7CD9
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 21 Jan 2010 07:03:02 +1100 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e4.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o0KJr9Lo023598
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2010 14:53:09 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o0KK2m0c1720338
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2010 15:02:48 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o0KK2lRC007895
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2010 18:02:47 -0200
Subject: [PATCH 1/2] sched: Fix the place where group powers are updated.
From: Joel Schopp <jschopp@austin.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <1264017638.5717.121.camel@jschopp-laptop>
References: <1264017638.5717.121.camel@jschopp-laptop>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 20 Jan 2010 14:02:44 -0600
Message-ID: <1264017764.5717.127.camel@jschopp-laptop>
Mime-Version: 1.0
Cc: Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, ego@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Gautham R Shenoy <ego@in.ibm.com>

We want to update the sched_group_powers when balance_cpu == this_cpu.

Currently the group powers are updated only if the balance_cpu is the first
CPU in the local group. But balance_cpu = this_cpu could also be the first
idle cpu in the group. Hence fix the place where the group powers are updated.

Signed-off-by: Gautham R Shenoy <ego@in.ibm.com>
Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>
---
 kernel/sched.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/sched.c b/kernel/sched.c
index 281da29..5d2a451 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -3721,11 +3721,8 @@ static inline void update_sg_lb_stats(struct sched_domain *sd,
 	unsigned long sum_avg_load_per_task;
 	unsigned long avg_load_per_task;
 
-	if (local_group) {
+	if (local_group)
 		balance_cpu = group_first_cpu(group);
-		if (balance_cpu == this_cpu)
-			update_group_power(sd, this_cpu);
-	}
 
 	/* Tally up the load of all CPUs in the group */
 	sum_avg_load_per_task = avg_load_per_task = 0;
@@ -3773,6 +3770,8 @@ static inline void update_sg_lb_stats(struct sched_domain *sd,
 		return;
 	}
 
+	update_group_power(sd, this_cpu);
+
 	/* Adjust by relative CPU power of the group */
 	sgs->avg_load = (sgs->group_load * SCHED_LOAD_SCALE) / group->cpu_power;
 

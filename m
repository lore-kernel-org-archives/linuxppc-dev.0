Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CE3942C03EA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Oct 2013 22:45:11 +1100 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Mon, 21 Oct 2013 21:45:11 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 82C852BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Oct 2013 22:45:08 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9LBiuYN10289600
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Oct 2013 22:44:56 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9LBj7Qd017364
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Oct 2013 22:45:08 +1100
Subject: [PATCH 3/3] sched: Aggressive balance in domains whose groups share
 package resources
To: Peter Zijlstra <peterz@infradead.org>,
 Mike Galbraith <bitbucket@online.de>, Paul Turner <pjt@google.com>,
 Ingo Molnar <mingo@kernel.org>
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Date: Mon, 21 Oct 2013 17:15:02 +0530
Message-ID: <20131021114502.13291.60794.stgit@drishya>
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

The current logic in load balance is such that after picking the
busiest group, the load is attempted to be moved from the busiest cpu
in that group to the dst_cpu. If the load cannot be moved from the
busiest cpu to dst_cpu due to either tsk_cpus_allowed mask or cache
hot tasks, then the dst_cpu is changed to be another idle cpu within
the dst->grpmask. If even then, the load cannot be moved from the
busiest cpu, then the source group is changed. The next busiest group
is found and the above steps are repeated.

However if the cpus in the group share package resources, then when
a load movement from the busiest cpu in this group fails as above,
instead of finding the next busiest group to move load from, find the
next busiest cpu *within the same group* from which to move load away.
By doing so, a conscious effort is made during load balancing to keep
just one cpu busy as much as possible within domains that have
SHARED_PKG_RESOURCES flag set unless under scenarios of high load.
Having multiple cpus busy within a domain which share package resource
could lead to a performance hit.

A similar scenario arises in active load balancing as well. When the
current task on the busiest cpu cannot be moved away due to task
pinning, currently no more attempts at load balancing is made. This
patch checks if the balancing is being done on a group whose cpus
share package resources. If so, then check if the load balancing can
be done for other cpus in the same group.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
---
 kernel/sched/fair.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 828ed97..bbcd96b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5165,6 +5165,8 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 {
 	int ld_moved, cur_ld_moved, active_balance = 0;
 	struct sched_group *group;
+	struct sched_domain *child;
+	int share_pkg_res = 0;
 	struct rq *busiest;
 	unsigned long flags;
 	struct cpumask *cpus = __get_cpu_var(load_balance_mask);
@@ -5190,6 +5192,10 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 
 	schedstat_inc(sd, lb_count[idle]);
 
+	child = sd->child;
+	if (child && child->flags & SD_SHARE_PKG_RESOURCES)
+		share_pkg_res = 1;
+
 redo:
 	if (!should_we_balance(&env)) {
 		*continue_balancing = 0;
@@ -5202,6 +5208,7 @@ redo:
 		goto out_balanced;
 	}
 
+redo_grp:
 	busiest = find_busiest_queue(&env, group);
 	if (!busiest) {
 		schedstat_inc(sd, lb_nobusyq[idle]);
@@ -5292,6 +5299,11 @@ more_balance:
 			if (!cpumask_empty(cpus)) {
 				env.loop = 0;
 				env.loop_break = sched_nr_migrate_break;
+				if (share_pkg_res &&
+					cpumask_intersects(cpus,
+						to_cpumask(group->cpumask)))
+					goto redo_grp;
+
 				goto redo;
 			}
 			goto out_balanced;
@@ -5318,9 +5330,15 @@ more_balance:
 			 */
 			if (!cpumask_test_cpu(this_cpu,
 					tsk_cpus_allowed(busiest->curr))) {
+				cpumask_clear_cpu(cpu_of(busiest), cpus);
 				raw_spin_unlock_irqrestore(&busiest->lock,
 							    flags);
 				env.flags |= LBF_ALL_PINNED;
+				if (share_pkg_res &&
+					cpumask_intersects(cpus,
+						to_cpumask(group->cpumask)))
+					goto redo_grp;
+
 				goto out_one_pinned;
 			}
 

Return-Path: <SRS0=R24o=OB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB2DC433F5
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Sep 2021 01:21:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29AD36113A
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Sep 2021 01:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 29AD36113A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H5w1g6QYlz2ywg
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Sep 2021 11:21:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=linux.intel.com
 (client-ip=134.134.136.65; helo=mga03.intel.com;
 envelope-from=ricardo.neri-calderon@linux.intel.com; receiver=<UNKNOWN>)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H5w0G6Vvfz2yHb
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Sep 2021 11:20:14 +1000 (AEST)
X-IronPort-AV: E=McAfee;i="6200,9189,10103"; a="221271940"
X-IronPort-AV: E=Sophos;i="5.85,284,1624345200"; d="scan'208";a="221271940"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2021 18:19:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,284,1624345200"; d="scan'208";a="695261622"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by fmsmga006.fm.intel.com with ESMTP; 10 Sep 2021 18:19:07 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v5 2/6] sched/topology: Introduce sched_group::flags
Date: Fri, 10 Sep 2021 18:18:15 -0700
Message-Id: <20210911011819.12184-3-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210911011819.12184-1-ricardo.neri-calderon@linux.intel.com>
References: <20210911011819.12184-1-ricardo.neri-calderon@linux.intel.com>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Len Brown <len.brown@intel.com>, Aubrey Li <aubrey.li@intel.com>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 "Ravi V. Shankar" <ravi.v.shankar@intel.com>, linuxppc-dev@lists.ozlabs.org,
 Aubrey Li <aubrey.li@linux.intel.com>, Nicholas Piggin <npiggin@gmail.com>,
 Ricardo Neri <ricardo.neri@intel.com>, Steven Rostedt <rostedt@goodmis.org>,
 Quentin Perret <qperret@google.com>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Joel Fernandes \(Google\)" <joel@joelfernandes.org>,
 Tim Chen <tim.c.chen@linux.intel.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

There exist situations in which the load balance needs to know the
properties of the CPUs in a scheduling group. When using asymmetric
packing, for instance, the load balancer needs to know not only the
state of dst_cpu but also of its SMT siblings, if any.

Use the flags of the child scheduling domains to initialize scheduling
group flags. This will reflect the properties of the CPUs in the
group.

A subsequent changeset will make use of these new flags. No functional
changes are introduced.

Cc: Aubrey Li <aubrey.li@intel.com>
Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Quentin Perret <qperret@google.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reviewed-by: Len Brown <len.brown@intel.com>
Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v4:
  * None

Changes since v3:
  * Clear the flags of the scheduling groups of a domain if its child is
    destroyed.
  * Minor rewording of the commit message.

Changes since v2:
  * Introduced this patch.

Changes since v1:
  * N/A
---
 kernel/sched/sched.h    |  1 +
 kernel/sched/topology.c | 21 ++++++++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3d3e5793e117..86ab33ce529d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1809,6 +1809,7 @@ struct sched_group {
 	unsigned int		group_weight;
 	struct sched_group_capacity *sgc;
 	int			asym_prefer_cpu;	/* CPU of highest priority in group */
+	int			flags;
 
 	/*
 	 * The CPUs this group covers.
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 4e8698e62f07..c56faae461d9 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -716,8 +716,20 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 		tmp = sd;
 		sd = sd->parent;
 		destroy_sched_domain(tmp);
-		if (sd)
+		if (sd) {
+			struct sched_group *sg = sd->groups;
+
+			/*
+			 * sched groups hold the flags of the child sched
+			 * domain for convenience. Clear such flags since
+			 * the child is being destroyed.
+			 */
+			do {
+				sg->flags = 0;
+			} while (sg != sd->groups);
+
 			sd->child = NULL;
+		}
 	}
 
 	for (tmp = sd; tmp; tmp = tmp->parent)
@@ -916,10 +928,12 @@ build_group_from_child_sched_domain(struct sched_domain *sd, int cpu)
 		return NULL;
 
 	sg_span = sched_group_span(sg);
-	if (sd->child)
+	if (sd->child) {
 		cpumask_copy(sg_span, sched_domain_span(sd->child));
-	else
+		sg->flags = sd->child->flags;
+	} else {
 		cpumask_copy(sg_span, sched_domain_span(sd));
+	}
 
 	atomic_inc(&sg->ref);
 	return sg;
@@ -1169,6 +1183,7 @@ static struct sched_group *get_group(int cpu, struct sd_data *sdd)
 	if (child) {
 		cpumask_copy(sched_group_span(sg), sched_domain_span(child));
 		cpumask_copy(group_balance_mask(sg), sched_group_span(sg));
+		sg->flags = child->flags;
 	} else {
 		cpumask_set_cpu(cpu, sched_group_span(sg));
 		cpumask_set_cpu(cpu, group_balance_mask(sg));
-- 
2.17.1


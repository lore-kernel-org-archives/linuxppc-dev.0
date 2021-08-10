Return-Path: <SRS0=xfaR=NB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85564C4338F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Aug 2021 14:45:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 138EF60EB5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Aug 2021 14:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 138EF60EB5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GkbN02rrbz3dX5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Aug 2021 00:45:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=linux.intel.com
 (client-ip=134.134.136.100; helo=mga07.intel.com;
 envelope-from=ricardo.neri-calderon@linux.intel.com; receiver=<UNKNOWN>)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GkbK94hbWz30Lh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Aug 2021 00:42:53 +1000 (AEST)
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="278663301"
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; d="scan'208";a="278663301"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2021 07:41:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; d="scan'208";a="526170588"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
 by fmsmga002.fm.intel.com with ESMTP; 10 Aug 2021 07:41:44 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4 4/6] sched/fair: Provide update_sg_lb_stats() with sched
 domain statistics
Date: Tue, 10 Aug 2021 07:41:43 -0700
Message-Id: <20210810144145.18776-5-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210810144145.18776-1-ricardo.neri-calderon@linux.intel.com>
References: <20210810144145.18776-1-ricardo.neri-calderon@linux.intel.com>
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
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
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

Before deciding to pull tasks when using asymmetric packing of tasks,
on some architectures (e.g., x86) it is necessary to know not only the
state of dst_cpu but also of its SMT siblings. The decision to classify
a candidate busiest group as group_asym_packing is done in
update_sg_lb_stats(). Give this function access to the scheduling domain
statistics, which contains the statistics of the local group.

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
Changes since v3:
  * None

Changes since v2:
  * Introduced this patch.

Changes since v1:
  * N/A
---
 kernel/sched/fair.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3b686e18a39b..ae3d2bc59d8d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8539,6 +8539,7 @@ group_type group_classify(unsigned int imbalance_pct,
  * @sg_status: Holds flag indicating the status of the sched_group
  */
 static inline void update_sg_lb_stats(struct lb_env *env,
+				      struct sd_lb_stats *sds,
 				      struct sched_group *group,
 				      struct sg_lb_stats *sgs,
 				      int *sg_status)
@@ -8547,7 +8548,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 
 	memset(sgs, 0, sizeof(*sgs));
 
-	local_group = cpumask_test_cpu(env->dst_cpu, sched_group_span(group));
+	local_group = group == sds->local;
 
 	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
 		struct rq *rq = cpu_rq(i);
@@ -9110,7 +9111,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 				update_group_capacity(env->sd, env->dst_cpu);
 		}
 
-		update_sg_lb_stats(env, sg, sgs, &sg_status);
+		update_sg_lb_stats(env, sds, sg, sgs, &sg_status);
 
 		if (local_group)
 			goto next_group;
-- 
2.17.1


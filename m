Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2A4C02C035A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Oct 2013 22:45:03 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Mon, 21 Oct 2013 21:45:00 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 90A0D3578054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Oct 2013 22:44:58 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9LBRlAE8388836
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Oct 2013 22:27:47 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9LBivqW027377
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Oct 2013 22:44:58 +1100
Subject: [PATCH 2/3] sched: Fix asymmetric scheduling for POWER7
To: Peter Zijlstra <peterz@infradead.org>,
 Mike Galbraith <bitbucket@online.de>, Paul Turner <pjt@google.com>,
 Ingo Molnar <mingo@kernel.org>
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Date: Mon, 21 Oct 2013 17:14:52 +0530
Message-ID: <20131021114452.13291.19947.stgit@drishya>
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

Asymmetric scheduling within a core is a scheduler loadbalancing
feature that is triggered when SD_ASYM_PACKING flag is set.  The goal
for the load balancer is to move tasks to lower order idle SMT threads
within a core on a POWER7 system.

In nohz_kick_needed(), we intend to check if our sched domain (core)
is completely busy or we have idle cpu.

The following check for SD_ASYM_PACKING:

    (cpumask_first_and(nohz.idle_cpus_mask, sched_domain_span(sd)) < cpu)

already covers the case of checking if the domain has an idle cpu,
because cpumask_first_and() will not yield any set bits if this domain
has no idle cpu.

Hence, nr_busy check against group weight can be removed.

Reported-by: Michael Neuling <michael.neuling@au1.ibm.com>
Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---
 kernel/sched/fair.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 12f0eab..828ed97 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5821,8 +5821,8 @@ static inline int nohz_kick_needed(struct rq *rq, int cpu)
 				goto need_kick_unlock;
 		}
 
-		if (sd->flags & SD_ASYM_PACKING && nr_busy != sg->group_weight
-		    && (cpumask_first_and(nohz.idle_cpus_mask,
+		if (sd->flags & SD_ASYM_PACKING &&
+			(cpumask_first_and(nohz.idle_cpus_mask,
 					  sched_domain_span(sd)) < cpu))
 			goto need_kick_unlock;
 

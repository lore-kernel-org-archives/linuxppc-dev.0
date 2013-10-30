Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C39362C03E8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2013 14:15:48 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Tue, 29 Oct 2013 23:15:45 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 2D28338C804A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 23:15:43 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22035.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9U3FiDV63832246
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2013 03:15:44 GMT
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r9U3Fgsq020810
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 23:15:44 -0400
Subject: [PATCH V2 1/2] sched: Fix asymmetric scheduling for POWER7
To: peterz@infradead.org, mikey@neuling.org, svaidy@linux.vnet.ibm.com,
 mingo@kernel.org
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Wed, 30 Oct 2013 08:42:42 +0530
Message-ID: <20131030031242.23426.13019.stgit@preeti.in.ibm.com>
In-Reply-To: <20131030031145.23426.22930.stgit@preeti.in.ibm.com>
References: <20131030031145.23426.22930.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: vincent.guittot@linaro.org, bitbucket@online.de,
 linux-kernel@vger.kernel.org, anton@samba.org, linuxppc-dev@lists.ozlabs.org,
 Morten.Rasmussen@arm.com, pjt@google.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>

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
Tested-by: Michael Neuling <mikey@neuling.org>
---

 kernel/sched/fair.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 813dd61..e9c9549 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6781,7 +6781,7 @@ static inline int nohz_kick_needed(struct rq *rq, int cpu)
 		if (sd->flags & SD_SHARE_PKG_RESOURCES && nr_busy > 1)
 			goto need_kick_unlock;
 
-		if (sd->flags & SD_ASYM_PACKING && nr_busy != sg->group_weight
+		if (sd->flags & SD_ASYM_PACKING
 		    && (cpumask_first_and(nohz.idle_cpus_mask,
 					  sched_domain_span(sd)) < cpu))
 			goto need_kick_unlock;

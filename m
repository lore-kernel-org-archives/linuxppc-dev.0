Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5121E1A0688
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 15:01:26 +1100 (AEDT)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 25 Mar 2015 22:01:23 -0600
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 1032CC90043
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 23:52:31 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2Q41LWR24641646
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 04:01:21 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2Q41K4o026318
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 00:01:21 -0400
Date: Wed, 25 Mar 2015 21:00:24 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/4] perf: Add 'flags' parameter to pmu txn interfaces
Message-ID: <20150326040024.GB31846@us.ibm.com>
References: <1425458108-3341-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1425458108-3341-2-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150317064745.GL2896@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150317064745.GL2896@worktop.programming.kicks-ass.net>
Cc: dev@codyps.com, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Peter Zijlstra [peterz@infradead.org] wrote:
| On Wed, Mar 04, 2015 at 12:35:05AM -0800, Sukadev Bhattiprolu wrote:
| > In addition to using the transaction interface to schedule events
| > on a PMU, we will use it to also read a group of counters at once.
| > Accordingly, add a flags parameter to the transaction interfaces.
| > The flags indicate wheether the transaction is to add events to
| > the PMU (PERF_PMU_TXN_ADD) or to read the events PERF_PMU_TXN_READ.
| > 
| > Based on input from Peter Zijlstra.
| > 
| > Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
| > ---
| >  arch/powerpc/perf/core-book3s.c  | 15 ++++++++++++---
| >  arch/x86/kernel/cpu/perf_event.c | 15 ++++++++++++---
| >  include/linux/perf_event.h       | 14 +++++++++++---
| >  kernel/events/core.c             | 26 +++++++++++++++-----------
| >  4 files changed, 50 insertions(+), 20 deletions(-)
| 
| s390 and sparc also implement the txn.

Yes, I have fixed that now. Was mostly exploring the basic txn interface.
| 
| # git grep "\.start_txn"
| arch/powerpc/perf/core-book3s.c:        .start_txn      = power_pmu_start_txn,
| arch/s390/kernel/perf_cpum_cf.c:        .start_txn    = cpumf_pmu_start_txn,
| arch/sparc/kernel/perf_event.c: .start_txn      = sparc_pmu_start_txn,
| arch/x86/kernel/cpu/perf_event.c:       .start_txn              = x86_pmu_start_txn,
| 
| Also; you add the flag to all 3 calls; does it make sense to only pass
| it to the first and save the txn type in the txn state itself? We could
| add PERF_EVENT_TXN_READ for this..

We could do that. The one small downside I see with passing the txn flag
only ot ->start_txn() is that checks like this become more complicated,
even in PMUs that don't care about the TXN_READ transactions.

@@ -1619,8 +1622,11 @@ static void x86_pmu_start_txn(struct pmu *pmu)
  * Clear the flag and pmu::enable() will perform the
  * schedulability test.
  */
-static void x86_pmu_cancel_txn(struct pmu *pmu)
+static void x86_pmu_cancel_txn(struct pmu *pmu, int flags)
 {
+       if (flags & ~PERF_PMU_TXN_ADD)
+               return;
+

The ->start_txn will need to save the transaction type in the
architecture's 'cpuhw' and check/clear in ->commit_txn() and
->clear_txn() - right ?

Sukadev

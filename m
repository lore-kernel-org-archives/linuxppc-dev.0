Return-Path: <peterz@infradead.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D91471A02E8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 17:48:05 +1100 (AEDT)
Date: Tue, 17 Mar 2015 07:47:45 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/4] perf: Add 'flags' parameter to pmu txn interfaces
Message-ID: <20150317064745.GL2896@worktop.programming.kicks-ass.net>
References: <1425458108-3341-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1425458108-3341-2-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1425458108-3341-2-git-send-email-sukadev@linux.vnet.ibm.com>
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

On Wed, Mar 04, 2015 at 12:35:05AM -0800, Sukadev Bhattiprolu wrote:
> In addition to using the transaction interface to schedule events
> on a PMU, we will use it to also read a group of counters at once.
> Accordingly, add a flags parameter to the transaction interfaces.
> The flags indicate wheether the transaction is to add events to
> the PMU (PERF_PMU_TXN_ADD) or to read the events PERF_PMU_TXN_READ.
> 
> Based on input from Peter Zijlstra.
> 
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> ---
>  arch/powerpc/perf/core-book3s.c  | 15 ++++++++++++---
>  arch/x86/kernel/cpu/perf_event.c | 15 ++++++++++++---
>  include/linux/perf_event.h       | 14 +++++++++++---
>  kernel/events/core.c             | 26 +++++++++++++++-----------
>  4 files changed, 50 insertions(+), 20 deletions(-)

s390 and sparc also implement the txn.

# git grep "\.start_txn"
arch/powerpc/perf/core-book3s.c:        .start_txn      = power_pmu_start_txn,
arch/s390/kernel/perf_cpum_cf.c:        .start_txn    = cpumf_pmu_start_txn,
arch/sparc/kernel/perf_event.c: .start_txn      = sparc_pmu_start_txn,
arch/x86/kernel/cpu/perf_event.c:       .start_txn              = x86_pmu_start_txn,

Also; you add the flag to all 3 calls; does it make sense to only pass
it to the first and save the txn type in the txn state itself? We could
add PERF_EVENT_TXN_READ for this..

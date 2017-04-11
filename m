Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2Kgx4pYfzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 18:18:37 +1000 (AEST)
Date: Tue, 11 Apr 2017 10:18:30 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jin Yao <yao.jin@linux.intel.com>
Cc: acme@kernel.org, jolsa@kernel.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
 ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
 linuxppc-dev@lists.ozlabs.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 2/5] perf/x86/intel: Record branch type
Message-ID: <20170411081830.57372og2mzkhiftr@hirez.programming.kicks-ass.net>
References: <1491908193-25418-1-git-send-email-yao.jin@linux.intel.com>
 <1491908193-25418-3-git-send-email-yao.jin@linux.intel.com>
 <20170411075219.bcteozodfkmwo45f@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170411075219.bcteozodfkmwo45f@hirez.programming.kicks-ass.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 11, 2017 at 09:52:19AM +0200, Peter Zijlstra wrote:
> On Tue, Apr 11, 2017 at 06:56:30PM +0800, Jin Yao wrote:

> > @@ -960,6 +1006,11 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
> >  			cpuc->lbr_entries[i].from = 0;
> >  			compress = true;
> >  		}
> > +
> > +		if ((br_sel & X86_BR_TYPE_SAVE) == X86_BR_TYPE_SAVE)
> > +			cpuc->lbr_entries[i].type = common_branch_type(type);
> > +		else
> > +			cpuc->lbr_entries[i].type = PERF_BR_NONE;
> >  	}

I was wondering WTH you did that else; because it should already be 0
(aka, BR_NONE). Then I found intel_pmu_lbr_read_32() is already broken,
and you just broke intel_pmu_lbr_read_64().

Arguably we should add a union on the last __u64 with a name for the
entire thing, but the below is the minimal fix.

---
Subject: perf,x86: Avoid exposing wrong/stale data in intel_pmu_lbr_read_32()
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue Apr 11 10:10:28 CEST 2017

When the perf_branch_entry::{in_tx,abort,cycles} fields were added,
intel_pmu_lbr_read_32() wasn't updated to initialize them.

Fixes: 135c5612c460 ("perf/x86/intel: Support Haswell/v4 LBR format")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -507,6 +507,9 @@ static void intel_pmu_lbr_read_32(struct
 		cpuc->lbr_entries[i].to		= msr_lastbranch.to;
 		cpuc->lbr_entries[i].mispred	= 0;
 		cpuc->lbr_entries[i].predicted	= 0;
+		cpuc->lbr_entries[i].in_tx	= 0;
+		cpuc->lbr_entries[i].abort	= 0;
+		cpuc->lbr_entries[i].cycles	= 0;
 		cpuc->lbr_entries[i].reserved	= 0;
 	}
 	cpuc->lbr_stack.nr = i;

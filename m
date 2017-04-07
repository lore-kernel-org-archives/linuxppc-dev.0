Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w03Dp2HhpzDqHg
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Apr 2017 01:20:42 +1000 (AEST)
Date: Fri, 7 Apr 2017 17:20:31 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jin Yao <yao.jin@linux.intel.com>
Cc: acme@kernel.org, jolsa@kernel.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
 ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/5] perf/x86/intel: Record branch type
Message-ID: <20170407152031.k2auigfkj7ek4suo@hirez.programming.kicks-ass.net>
References: <1491562066-7472-1-git-send-email-yao.jin@linux.intel.com>
 <1491562066-7472-3-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491562066-7472-3-git-send-email-yao.jin@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 07, 2017 at 06:47:43PM +0800, Jin Yao wrote:
> Perf already has support for disassembling the branch instruction
> and using the branch type for filtering. The patch just records
> the branch type in perf_branch_entry.
> 
> Before recording, the patch converts the x86 branch classification
> to common branch classification and compute for checking if the
> branches cross 4K or 2MB areas. It's an approximate computing for
> crossing 4K page or 2MB page.

The changelog is completely empty of rationale. Why do we care?

Not having the binary is a very bad reason; you can't do much of
anything if that's missing.


> @@ -923,6 +933,84 @@ static int branch_type(unsigned long from, unsigned long to, int abort)
>  	return ret;
>  }
>  
> +static int
> +common_branch_type(int type, u64 from, u64 to)
> +{
> +	int ret;
> +
> +	type = type & (~(X86_BR_KERNEL | X86_BR_USER));
> +
> +	switch (type) {
> +	case X86_BR_CALL:
> +	case X86_BR_ZERO_CALL:
> +		ret = PERF_BR_CALL;
> +		break;
> +
> +	case X86_BR_RET:
> +		ret = PERF_BR_RET;
> +		break;
> +
> +	case X86_BR_SYSCALL:
> +		ret = PERF_BR_SYSCALL;
> +		break;
> +
> +	case X86_BR_SYSRET:
> +		ret = PERF_BR_SYSRET;
> +		break;
> +
> +	case X86_BR_INT:
> +		ret = PERF_BR_INT;
> +		break;
> +
> +	case X86_BR_IRET:
> +		ret = PERF_BR_IRET;
> +		break;
> +
> +	case X86_BR_IRQ:
> +		ret = PERF_BR_IRQ;
> +		break;
> +
> +	case X86_BR_ABORT:
> +		ret = PERF_BR_FAR_BRANCH;
> +		break;
> +
> +	case X86_BR_JCC:
> +		if (to > from)
> +			ret = PERF_BR_JCC_FWD;
> +		else
> +			ret = PERF_BR_JCC_BWD;
> +		break;

This seems like superfluous information; we already get to and from, so
this comparison is pointless.

The rest looks like something you can simpler implement using a lookup
table.

> +
> +	case X86_BR_JMP:
> +		ret = PERF_BR_JMP;
> +		break;
> +
> +	case X86_BR_IND_CALL:
> +		ret = PERF_BR_IND_CALL;
> +		break;
> +
> +	case X86_BR_IND_JMP:
> +		ret = PERF_BR_IND_JMP;
> +		break;
> +
> +	default:
> +		ret = PERF_BR_NONE;
> +	}
> +
> +	return ret;
> +}
> +
> +static bool
> +cross_area(u64 addr1, u64 addr2, int size)
> +{
> +	u64 align1, align2;
> +
> +	align1 = addr1 & ~(size - 1);
> +	align2 = addr2 & ~(size - 1);
> +
> +	return (align1 != align2) ? true : false;
> +}
> +
>  /*
>   * implement actual branch filter based on user demand.
>   * Hardware may not exactly satisfy that request, thus
> @@ -939,7 +1027,8 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
>  	bool compress = false;
>  
>  	/* if sampling all branches, then nothing to filter */
> -	if ((br_sel & X86_BR_ALL) == X86_BR_ALL)
> +	if (((br_sel & X86_BR_ALL) == X86_BR_ALL) &&
> +	    ((br_sel & X86_BR_TYPE_SAVE) != X86_BR_TYPE_SAVE))
>  		return;
>  
>  	for (i = 0; i < cpuc->lbr_stack.nr; i++) {
> @@ -960,6 +1049,21 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
>  			cpuc->lbr_entries[i].from = 0;
>  			compress = true;
>  		}
> +
> +		if ((br_sel & X86_BR_TYPE_SAVE) == X86_BR_TYPE_SAVE) {
> +			cpuc->lbr_entries[i].type = common_branch_type(type,
> +								       from,
> +								       to);
> +			if (cross_area(from, to, AREA_2M))
> +				cpuc->lbr_entries[i].cross = PERF_BR_CROSS_2M;
> +			else if (cross_area(from, to, AREA_4K))
> +				cpuc->lbr_entries[i].cross = PERF_BR_CROSS_4K;
> +			else
> +				cpuc->lbr_entries[i].cross = PERF_BR_CROSS_NONE;

This again is superfluous information; it is already fully contained in
to and from, which we have.

> +		} else {
> +			cpuc->lbr_entries[i].type = PERF_BR_NONE;
> +			cpuc->lbr_entries[i].cross = PERF_BR_CROSS_NONE;
> +		}
>  	}
>  
>  	if (!compress)
> -- 
> 2.7.4
> 

Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:4830:2446:ff00:4687:fcff:fea6:5117])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 15D812C0082
 for <linuxppc-dev@ozlabs.org>; Wed, 22 May 2013 17:53:32 +1000 (EST)
Date: Wed, 22 May 2013 09:53:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/5] powerpc, perf: Enable conditional branch filter for
 POWER8
Message-ID: <20130522075305.GN26912@twins.programming.kicks-ass.net>
References: <1369203761-12649-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1369203761-12649-3-git-send-email-khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1369203761-12649-3-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, ak@linux.intel.com, linux-kernel@vger.kernel.org,
 eranian@google.com, linuxppc-dev@ozlabs.org, mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 22, 2013 at 11:52:38AM +0530, Anshuman Khandual wrote:
> Enables conditional branch filter support for POWER8
> utilizing MMCRA register based filter and also invalidates
> a BHRB branch filter combination involving conditional
> branches.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
>  arch/powerpc/perf/power8-pmu.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
> index 8ed323d..e60b38f 100644
> --- a/arch/powerpc/perf/power8-pmu.c
> +++ b/arch/powerpc/perf/power8-pmu.c
> @@ -548,11 +548,21 @@ static u64 power8_bhrb_filter_map(u64 branch_sample_type)
>  	if (branch_sample_type & PERF_SAMPLE_BRANCH_IND_CALL)
>  		return -1;
>  
> +	/* Invalid branch filter combination - HW does not support */
> +	if ((branch_sample_type & PERF_SAMPLE_BRANCH_ANY_CALL) &&
> +			(branch_sample_type & PERF_SAMPLE_BRANCH_COND))
> +		return -1;
> +
>  	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY_CALL) {
>  		pmu_bhrb_filter |= POWER8_MMCRA_IFM1;
>  		return pmu_bhrb_filter;
>  	}
>  
> +	if (branch_sample_type & PERF_SAMPLE_BRANCH_COND) {
> +		pmu_bhrb_filter |= POWER8_MMCRA_IFM3;
> +		return pmu_bhrb_filter;
> +	}
> +
>  	/* Every thing else is unsupported */
>  	return -1;
>  }

So I suppose you've seen what x86 does in this case? ;-) I'm not saying
you _have_ to do the software filter, but I would like the changelog to at
least mention the issue.

In fact, I suppose that should have been in the original patches :/ as
this patch series only adds the conditional branch support. 

Return-Path: <ak@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by ozlabs.org (Postfix) with ESMTP id 6DD192C00BC
 for <linuxppc-dev@ozlabs.org>; Sat,  7 Dec 2013 03:46:45 +1100 (EST)
Date: Fri, 6 Dec 2013 08:46:43 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH V4 04/10] x86, perf: Add conditional branch filtering
 support
Message-ID: <20131206164643.GJ22695@tassilo.jf.intel.com>
References: <1386153162-11225-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1386153162-11225-5-git-send-email-khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1386153162-11225-5-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, linux-kernel@vger.kernel.org, eranian@google.com,
 michael@ellerman.id.au, linuxppc-dev@ozlabs.org, acme@ghostprotocols.net,
 sukadev@linux.vnet.ibm.com, mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 04, 2013 at 04:02:36PM +0530, Anshuman Khandual wrote:
> This patch adds conditional branch filtering support,
> enabling it for PERF_SAMPLE_BRANCH_COND in perf branch
> stack sampling framework by utilizing an available
> software filter X86_BR_JCC.

Newer Intel CPUs a hardware filter too for "not a conditional
branch".  I can look at implementing that.

The software option seems fine for now.

-Andi


> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> Reviewed-by: Stephane Eranian <eranian@google.com>
> ---
>  arch/x86/kernel/cpu/perf_event_intel_lbr.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/perf_event_intel_lbr.c b/arch/x86/kernel/cpu/perf_event_intel_lbr.c
> index d82d155..9dd2459 100644
> --- a/arch/x86/kernel/cpu/perf_event_intel_lbr.c
> +++ b/arch/x86/kernel/cpu/perf_event_intel_lbr.c
> @@ -384,6 +384,9 @@ static void intel_pmu_setup_sw_lbr_filter(struct perf_event *event)
>  	if (br_type & PERF_SAMPLE_BRANCH_NO_TX)
>  		mask |= X86_BR_NO_TX;
>  
> +	if (br_type & PERF_SAMPLE_BRANCH_COND)
> +		mask |= X86_BR_JCC;
> +
>  	/*
>  	 * stash actual user request into reg, it may
>  	 * be used by fixup code for some CPU
> @@ -678,6 +681,7 @@ static const int nhm_lbr_sel_map[PERF_SAMPLE_BRANCH_MAX] = {
>  	 * NHM/WSM erratum: must include IND_JMP to capture IND_CALL
>  	 */
>  	[PERF_SAMPLE_BRANCH_IND_CALL] = LBR_IND_CALL | LBR_IND_JMP,
> +	[PERF_SAMPLE_BRANCH_COND]     = LBR_JCC,
>  };
>  
>  static const int snb_lbr_sel_map[PERF_SAMPLE_BRANCH_MAX] = {
> @@ -689,6 +693,7 @@ static const int snb_lbr_sel_map[PERF_SAMPLE_BRANCH_MAX] = {
>  	[PERF_SAMPLE_BRANCH_ANY_CALL]	= LBR_REL_CALL | LBR_IND_CALL
>  					| LBR_FAR,
>  	[PERF_SAMPLE_BRANCH_IND_CALL]	= LBR_IND_CALL,
> +	[PERF_SAMPLE_BRANCH_COND]       = LBR_JCC,
>  };
>  
>  /* core */
> -- 
> 1.7.11.7
> 

-- 
ak@linux.intel.com -- Speaking for myself only

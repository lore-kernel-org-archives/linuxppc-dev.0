Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yB4ND1rnHzDr4x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 15:47:24 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] powerpc/perf: Fix unit_sel/cache_sel checks
In-Reply-To: <1507558360-27145-2-git-send-email-maddy@linux.vnet.ibm.com>
References: <1507558360-27145-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1507558360-27145-2-git-send-email-maddy@linux.vnet.ibm.com>
Date: Tue, 10 Oct 2017 15:47:23 +1100
Message-ID: <878tgjy5gk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Madhavan Srinivasan <maddy@linux.vnet.ibm.com> writes:

> diff --git a/arch/powerpc/perf/isa207-common.c b/arch/powerpc/perf/isa207-common.c
> index 2efee3f196f5..9fd2e5c7a063 100644
> --- a/arch/powerpc/perf/isa207-common.c
> +++ b/arch/powerpc/perf/isa207-common.c
> @@ -285,10 +293,10 @@ int isa207_get_constraint(u64 event, unsigned long *maskp, unsigned long *valp)
>  		 * have a cache selector of zero. The bank selector (bit 3) is
>  		 * irrelevant, as long as the rest of the value is 0.
>  		 */
> -		if (cache & 0x7)
> +		if (!cpu_has_feature(CPU_FTR_ARCH_300) && (cache & 0x7))
>  			return -1;
>  
> -	} else if (event & EVENT_IS_L1) {
> +	} else if (cpu_has_feature(CPU_FTR_ARCH_300) || (event & EVENT_IS_L1)) {
>  		mask  |= CNST_L1_QUAL_MASK;
>  		value |= CNST_L1_QUAL_VAL(cache);

I don't understand this. You're saying all non L2/L3 events are L1
events on Power9. That seems wrong.

>  	}
> @@ -391,11 +399,14 @@ int isa207_compute_mmcr(u64 event[], int n_ev,
>  		/* In continuous sampling mode, update SDAR on TLB miss */
>  		mmcra_sdar_mode(event[i], &mmcra);
>  
> -		if (event[i] & EVENT_IS_L1) {
> -			cache = event[i] >> EVENT_CACHE_SEL_SHIFT;
> -			mmcr1 |= (cache & 1) << MMCR1_IC_QUAL_SHIFT;
> -			cache >>= 1;
> -			mmcr1 |= (cache & 1) << MMCR1_DC_QUAL_SHIFT;
> +		if (cpu_has_feature(CPU_FTR_ARCH_300)) {
> +			cache = dc_ic_rld_quad_l1_sel(event[i]);
> +			mmcr1 |= (cache) << MMCR1_DC_IC_QUAL_SHIFT;
> +		} else {
> +			if (event[i] & EVENT_IS_L1) {
> +				cache = dc_ic_rld_quad_l1_sel(event[i]);
> +				mmcr1 |= (cache) << MMCR1_DC_IC_QUAL_SHIFT;
> +			}
>  		}

I also don't understand this. Both legs of the if have the exact same
code, so at the very least it's factored badly.

But why are we doing it for all events on Power9?


cheers

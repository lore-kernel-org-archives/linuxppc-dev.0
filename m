Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C7C531A0447
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Dec 2014 15:52:59 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 216A81400E7
 for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2014 15:52:58 +1100 (AEDT)
Message-ID: <1417755148.4741.56.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/book3s: Fix partial invalidation of TLBs in MCE
 code.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Fri, 05 Dec 2014 15:52:28 +1100
In-Reply-To: <20141205042616.17216.16015.stgit@mars>
References: <20141205042616.17216.16015.stgit@mars>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-12-05 at 10:01 +0530, Mahesh J Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> The existing MCE code calls flush_tlb hook with IS=0 (single page) resulting
> partial invalidation of TLBs which is not right. This patch fixes that
> by passing IS=0xc00 to invalidate whole TLB for successful recovery from
> TLB and ERAT errors.

What does "TLBIEL_INVAL_SET" means in that context ? Invalidating a set
isn't the same thing as invalidating the TLB ... and that makes no sense
without passing the page address or set # as an argument anyway

I still don't understand your flush_tlb() interface... it's arguments
don't make sense

Ben.

> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> ---
> Hi Michael,
> 	This MCE fix patch is for stable.
> 
>  arch/powerpc/kernel/mce_power.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
> index aa9aff3..b6f123a 100644
> --- a/arch/powerpc/kernel/mce_power.c
> +++ b/arch/powerpc/kernel/mce_power.c
> @@ -79,7 +79,7 @@ static long mce_handle_derror(uint64_t dsisr, uint64_t slb_error_bits)
>  	}
>  	if (dsisr & P7_DSISR_MC_TLB_MULTIHIT_MFTLB) {
>  		if (cur_cpu_spec && cur_cpu_spec->flush_tlb)
> -			cur_cpu_spec->flush_tlb(TLBIEL_INVAL_PAGE);
> +			cur_cpu_spec->flush_tlb(TLBIEL_INVAL_SET);
>  		/* reset error bits */
>  		dsisr &= ~P7_DSISR_MC_TLB_MULTIHIT_MFTLB;
>  	}
> @@ -110,7 +110,7 @@ static long mce_handle_common_ierror(uint64_t srr1)
>  		break;
>  	case P7_SRR1_MC_IFETCH_TLB_MULTIHIT:
>  		if (cur_cpu_spec && cur_cpu_spec->flush_tlb) {
> -			cur_cpu_spec->flush_tlb(TLBIEL_INVAL_PAGE);
> +			cur_cpu_spec->flush_tlb(TLBIEL_INVAL_SET);
>  			handled = 1;
>  		}
>  		break;

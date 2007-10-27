Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 622FEDDE3F
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Oct 2007 14:19:40 +1000 (EST)
Subject: Re: [PATCH] [Powerpc] fix switch_slb handling of 1T ESID values
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Will Schmidt <will_schmidt@vnet.ibm.com>
In-Reply-To: <20071026204641.25514.45178.stgit@farscape.rchland.ibm.com>
References: <20071026204641.25514.45178.stgit@farscape.rchland.ibm.com>
Content-Type: text/plain
Date: Sat, 27 Oct 2007 14:19:31 +1000
Message-Id: <1193458771.18243.55.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2007-10-26 at 15:46 -0500, Will Schmidt wrote:
> [Powerpc] fix switch_slb handling of 1T ESID values
> 
> Now that we have 1TB segment size support, we need to be using the
> GET_ESID_1T macro when comparing ESID values for pc,stack, and
> unmapped_base within switch_slb() when we're on a CPU that supports it.
> 
> This also happens to fix a duplicate-slb-entry inspired machine-check
> exception I was seeing when trying to run java on a power6 partition.
> 
> Tested on power6 and power5.
> 
> Signed-Off-By:  Will Schmidt <will_schmidt@vnet.ibm.com>

Good catch !

A minor comment is maybe you could factor out the code better doing
something like a ESID_COMPARE() macro ?

> ---
> 
> There is a similar bit of code in stab.c switch_stab().  Should this change also be made there?
> ---

There is no machine that does stab and 1T segments.

Ben.

> 
>  arch/powerpc/mm/slb.c |   19 ++++++++++++++-----
>  1 files changed, 14 insertions(+), 5 deletions(-)
> 
> 
> diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
> index bbd2c51..0c527d7 100644
> --- a/arch/powerpc/mm/slb.c
> +++ b/arch/powerpc/mm/slb.c
> @@ -193,16 +193,25 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
>  		return;
>  	slb_allocate(pc);
>  
> -	if (GET_ESID(pc) == GET_ESID(stack))
> -		return;
> +	if (cpu_has_feature(CPU_FTR_1T_SEGMENT)) {
> +		if (GET_ESID_1T(pc) == GET_ESID_1T(stack))
> +			return;
> +	} else
> +		if (GET_ESID(pc) == GET_ESID(stack))
> +			return;
>  
>  	if (is_kernel_addr(stack))
>  		return;
>  	slb_allocate(stack);
>  
> -	if ((GET_ESID(pc) == GET_ESID(unmapped_base))
> -	    || (GET_ESID(stack) == GET_ESID(unmapped_base)))
> -		return;
> +	if (cpu_has_feature(CPU_FTR_1T_SEGMENT)) {
> +		if ((GET_ESID_1T(pc) == GET_ESID_1T(unmapped_base))
> +		    || (GET_ESID_1T(stack) == GET_ESID_1T(unmapped_base)))
> +			return;
> +	} else
> +		if ((GET_ESID(pc) == GET_ESID(unmapped_base))
> +		    || (GET_ESID(stack) == GET_ESID(unmapped_base)))
> +			return;
>  
>  	if (is_kernel_addr(unmapped_base))
>  		return;
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DC20FDDF21
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 11:56:01 +1100 (EST)
Subject: Re: [PATCH] [Powerpc V2.1] fix switch_slb handling of 1T ESID values
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Will Schmidt <will_schmidt@vnet.ibm.com>
In-Reply-To: <20071030185932.6368.7796.stgit@farscape.rchland.ibm.com>
References: <20071030185932.6368.7796.stgit@farscape.rchland.ibm.com>
Content-Type: text/plain
Date: Wed, 31 Oct 2007 11:55:24 +1100
Message-Id: <1193792124.9928.80.camel@pasglop>
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


On Tue, 2007-10-30 at 13:59 -0500, Will Schmidt wrote:
> [Powerpc] fix switch_slb handling of 1T ESID values
> 
> Now that we have 1TB segment size support, we need to be using the
> GET_ESID_1T macro when comparing ESID values for pc,stack, and
> unmapped_base within switch_slb().    A new helper function called
> esids_match() contains the logic for deciding when to call GET_ESID
> and GET_ESID_1T.
> 
> This also happens to fix a duplicate-slb-entry inspired machine-check
> exception I was seeing when trying to run java on a power6 partition.
> 
> Tested on power6 and power5.
> 
> Signed-Off-By:  Will Schmidt <will_schmidt@vnet.ibm.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

> 
> ---
> 
> Just a bit of whitespace cosmetic touchup in this version, as suggested
> by Stephen Rothwell.
> ---
> 
>  arch/powerpc/mm/slb.c |   34 +++++++++++++++++++++++++++++++---
>  1 files changed, 31 insertions(+), 3 deletions(-)
> 
> 
> diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
> index bbd2c51..8cbbfab 100644
> --- a/arch/powerpc/mm/slb.c
> +++ b/arch/powerpc/mm/slb.c
> @@ -148,6 +148,35 @@ void slb_vmalloc_update(void)
>  	slb_flush_and_rebolt();
>  }
>  
> +/* Helper function to compare esids.  There are four cases to handle.
> + * 1. The system is not 1T segment size capable.  Use the GET_ESID compare.
> + * 2. The system is 1T capable, both addresses are < 1T, use the GET_ESID compare.
> + * 3. The system is 1T capable, only one of the two addresses is > 1T.  This is not a match.
> + * 4. The system is 1T capable, both addresses are > 1T, use the GET_ESID_1T macro to compare.
> + */
> +static inline int esids_match(unsigned long addr1, unsigned long addr2)
> +{
> +	int esid_1t_count;
> +
> +	/* System is not 1T segment size capable. */
> +	if (!cpu_has_feature(CPU_FTR_1T_SEGMENT))
> +		return (GET_ESID(addr1) == GET_ESID(addr2));
> +
> +	esid_1t_count = (((addr1 >> SID_SHIFT_1T) != 0) +
> +				((addr2 >> SID_SHIFT_1T) != 0));
> +
> +	/* both addresses are < 1T */
> +	if (esid_1t_count == 0)
> +		return (GET_ESID(addr1) == GET_ESID(addr2));
> +
> +	/* One address < 1T, the other > 1T.  Not a match */
> +	if (esid_1t_count == 1)
> +		return 0;
> +
> +	/* Both addresses are > 1T. */
> +	return (GET_ESID_1T(addr1) == GET_ESID_1T(addr2));
> +}
> +
>  /* Flush all user entries from the segment table of the current processor. */
>  void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
>  {
> @@ -193,15 +222,14 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
>  		return;
>  	slb_allocate(pc);
>  
> -	if (GET_ESID(pc) == GET_ESID(stack))
> +	if (esids_match(pc,stack))
>  		return;
>  
>  	if (is_kernel_addr(stack))
>  		return;
>  	slb_allocate(stack);
>  
> -	if ((GET_ESID(pc) == GET_ESID(unmapped_base))
> -	    || (GET_ESID(stack) == GET_ESID(unmapped_base)))
> +	if (esids_match(pc,unmapped_base) || esids_match(stack,unmapped_base))
>  		return;
>  
>  	if (is_kernel_addr(unmapped_base))
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

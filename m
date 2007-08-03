Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0F961DDE10
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 21:51:21 +1000 (EST)
Subject: Re: [PATCH] Fix special PTE code for secondary hash bucket
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18098.61003.38084.554299@cargo.ozlabs.ibm.com>
References: <18098.61003.38084.554299@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Fri, 03 Aug 2007 21:51:15 +1000
Message-Id: <1186141875.11904.0.camel@gruick>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-08-03 at 18:58 +1000, Paul Mackerras wrote:
> The code for mapping special 4k pages on kernels using a 64kB base
> page size was missing the code for doing the RPN (real page number)
> manipulation when inserting the hardware PTE in the secondary hash
> bucket.  It needs the same code as has already been added to the
> code that inserts the HPTE in the primary hash bucket.  This adds it.
> 
> Spotted by Ben Herrenschmidt.
> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
> diff --git a/arch/powerpc/mm/hash_low_64.S b/arch/powerpc/mm/hash_low_64.S
> index 4762ff7..35eabfb 100644
> --- a/arch/powerpc/mm/hash_low_64.S
> +++ b/arch/powerpc/mm/hash_low_64.S
> @@ -472,10 +472,12 @@ _GLOBAL(htab_call_hpte_insert1)
>  	/* Now try secondary slot */
>  
>  	/* real page number in r5, PTE RPN value + index */
> -	rldicl	r5,r31,64-PTE_RPN_SHIFT,PTE_RPN_SHIFT
> +	andis.	r0,r31,_PAGE_4K_PFN@h
> +	srdi	r5,r31,PTE_RPN_SHIFT
> +	bne-	3f
>  	sldi	r5,r5,PAGE_SHIFT-HW_PAGE_SHIFT
>  	add	r5,r5,r25
> -	sldi	r5,r5,HW_PAGE_SHIFT
> +3:	sldi	r5,r5,HW_PAGE_SHIFT
>  
>  	/* Calculate secondary group hash */
>  	andc	r0,r27,r28
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

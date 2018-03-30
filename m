Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40CLgC2kcrzF1t8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Mar 2018 23:35:19 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/mm/hash: Move the slb_addr_limit check within
 PPC_MM_SLICES
In-Reply-To: <20180307121539.20745-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20180307121539.20745-1-aneesh.kumar@linux.vnet.ibm.com>
Date: Fri, 30 Mar 2018 23:35:15 +1100
Message-ID: <87a7upzqpo.fsf@concordia.ellerman.id.au>
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

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> Should not have any impact, because we always select PP_MM_SLICES these days.
> Nevertheless it is good to indicate that slb_addr_limit is available only
> with slice code.

That file can only be built if PPC_MM_SLICES=y.

So let's just remove the ifdef entirely.

These days PPC_MM_SLICES == PPC_BOOK3S_64, so we should remove
PPC_MM_SLICES #defines wherever possible and replace them with
PPC_BOOK3S_64 otherwise IMO.

cheers

> diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
> index c66cb06e73a1..337ef162851d 100644
> --- a/arch/powerpc/mm/slb_low.S
> +++ b/arch/powerpc/mm/slb_low.S
> @@ -166,6 +166,8 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
>  	 */
>  	cmpdi	r9, 0
>  	bne-	8f
> +
> +#ifdef CONFIG_PPC_MM_SLICES
>          /*
>           * user space make sure we are within the allowed limit
>  	 */
> @@ -183,7 +185,6 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
>  	 * really do dynamic patching unfortunately as processes might flip
>  	 * between 4k and 64k standard page size
>  	 */
> -#ifdef CONFIG_PPC_MM_SLICES
>  	/* r10 have esid */
>  	cmpldi	r10,16
>  	/* below SLICE_LOW_TOP */
> -- 
> 2.14.3

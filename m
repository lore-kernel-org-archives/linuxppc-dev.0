Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sdY0t4tb1zDsfj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 16:35:42 +1000 (AEST)
In-Reply-To: <1471831017-18167-2-git-send-email-bsingharora@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>, benh@kernel.crashing.org,
 paulus@samba.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [2/2] Detect instruction fetch denied and report
Message-Id: <3sdY0t2gfYz9svs@ozlabs.org>
Date: Tue, 20 Sep 2016 16:35:42 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-22-08 at 01:56:57 UTC, Balbir Singh wrote:
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index a4db22f..f162e77 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -404,6 +404,10 @@ good_area:
>  		    (cpu_has_feature(CPU_FTR_NOEXECUTE) ||
>  		     !(vma->vm_flags & (VM_READ | VM_WRITE))))
>  			goto bad_area;
> +#ifdef CONFIG_PPC_RADIX_MMU

We shouldn't need the #ifdef, radix_enabled() will be false.

> +		if (radix_enabled() && regs->msr & PPC_BIT(35))
> +			goto bad_area;

Is it really architected as radix only?

Personally I dislike PPC_BIT(), I'd rather you just used 0x10000000. That way
when I'm staring at a register dump I have some chance of spotting that mask.

Also brackets around the bitwise & would make me feel more comfortable.

cheers

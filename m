Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41H0CH1YQmzF1dh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 11:57:31 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel] powerpc/powernv/ioda2: Reduce upper limit for DMA
 window size
In-Reply-To: <20180601080616.29279-1-aik@ozlabs.ru>
References: <20180601080616.29279-1-aik@ozlabs.ru>
Date: Fri, 29 Jun 2018 11:57:30 +1000
Message-ID: <874lhmwe0l.fsf@concordia.ellerman.id.au>
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

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> We use PHB in mode1 which uses bit 59 to select a correct DMA window.
> However there is mode2 which uses bits 59:55 and allows up to 32 DMA
> windows per a PE.

Do we ever use mode2?

> Even though documentation does not clearly specify that, it seems that
> the actual hardware does not support bits 59:55 even in mode1, in other
> words we can create a window as big as 1<<58 but DMA simply won't work.

Can we get anything more solid than "seems that" ?

Is this documented somewhere to not work or you just found this by
testing?

> This reduces the upper limit from 59 to 55 bits to let the userspace know
> about the hardware limits.
>
> Fixes: 7aafac11e3 "powerpc/powernv/ioda2: Gracefully fail if too many TCE levels requested"

Stable?

cheers

> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 92ca662..50e21d7 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2839,7 +2839,7 @@ static long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
>  	level_shift = entries_shift + 3;
>  	level_shift = max_t(unsigned, level_shift, PAGE_SHIFT);
>  
> -	if ((level_shift - 3) * levels + page_shift >= 60)
> +	if ((level_shift - 3) * levels + page_shift >= 55)
>  		return -EINVAL;
>  
>  	/* Allocate TCE table */
> -- 
> 2.11.0

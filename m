Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41zPq56VQSzDqSL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Aug 2018 18:16:17 +1000 (AEST)
Message-ID: <9fd2cb24976fc3b4534d7ab6186032ac4e27c9d5.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc/64s/radix: Explicitly flush ERAT with local
 LPID invalidation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <pmac@au1.ibm.com>
Date: Mon, 27 Aug 2018 18:16:05 +1000
In-Reply-To: <20180827030302.17541-3-npiggin@gmail.com>
References: <20180827030302.17541-1-npiggin@gmail.com>
 <20180827030302.17541-3-npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-08-27 at 13:03 +1000, Nicholas Piggin wrote:
> Local radix TLB flush operations that operate on congruence classes
> have explicit ERAT flushes for POWER9. The process scoped LPID flush
> did not have a flush, so add it.

Paul, is that an actual bug ? I think the ERAT is flushed on LPID
changes...

> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/mm/tlb-radix.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
> index fef3e1eb3a19..4e798f33c530 100644
> --- a/arch/powerpc/mm/tlb-radix.c
> +++ b/arch/powerpc/mm/tlb-radix.c
> @@ -366,6 +366,7 @@ static inline void _tlbiel_lpid_guest(unsigned long lpid, unsigned long ric)
>  		__tlbiel_lpid_guest(lpid, set, RIC_FLUSH_TLB);
>  
>  	asm volatile("ptesync": : :"memory");
> +	asm volatile(PPC_INVALIDATE_ERAT : : :"memory");
>  }
>  
>  

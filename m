Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 646F1DDEDA
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Dec 2008 22:07:21 +1100 (EST)
Subject: Re: [PATCH] powerpc: remove the redundant _tlbil_pid at SMP case
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Liu <daveliu@freescale.com>
In-Reply-To: <1230716575-30786-1-git-send-email-daveliu@freescale.com>
References: <1230716575-30786-1-git-send-email-daveliu@freescale.com>
Content-Type: text/plain
Date: Wed, 31 Dec 2008 22:05:13 +1100
Message-Id: <1230721513.15389.71.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-12-31 at 17:42 +0800, Dave Liu wrote:
> Signed-off-by: Dave Liu <daveliu@freescale.com>
> ---
>  arch/powerpc/mm/tlb_nohash.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
> index 803a64c..39ac22b 100644
> --- a/arch/powerpc/mm/tlb_nohash.c
> +++ b/arch/powerpc/mm/tlb_nohash.c
> @@ -189,8 +189,9 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
>  	smp_call_function(do_flush_tlb_mm_ipi, NULL, 1);
>  	_tlbil_pid(0);
>  	preempt_enable();
> -#endif
> +#else
>  	_tlbil_pid(0);
> +#endif
>  }
>  EXPORT_SYMBOL(flush_tlb_kernel_range);

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

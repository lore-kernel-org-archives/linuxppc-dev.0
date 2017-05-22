Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wWVZg37NCzDq5j
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 May 2017 17:26:19 +1000 (AEST)
Subject: Re: [PATCH] powerpc/64: Use tick accounting by default
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, npiggin@gmail.com, mikey@neuling.org,
 cyrilbur@gmail.com
References: <20170519144112.15649-1-anton@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <dee9e3a7-af89-b217-ad0f-ee07d7237050@c-s.fr>
Date: Mon, 22 May 2017 09:26:14 +0200
MIME-Version: 1.0
In-Reply-To: <20170519144112.15649-1-anton@ozlabs.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 19/05/2017 à 16:41, Anton Blanchard a écrit :
> From: Anton Blanchard <anton@samba.org>
>
> ppc64 is the only architecture that turns on VIRT_CPU_ACCOUNTING_NATIVE
> by default. The overhead of this option is extremely high - a context
> switch microbenchmark using sched_yield() is almost 20% slower.
>
> To get finer grained user/hardirq/softirq statitics, the
> IRQ_TIME_ACCOUNTING option can be used instead, which has much lower
> overhead.

Does IRQ_TIME_ACCOUNTING allow the same granularity as 
VIRT_CPU_ACCOUNTING_NATIVE ?
I've quickly looked into the source, it seems that this option still 
accounts based on time ticks.
On a hardware doing mainly VoIP handling, the processes run a few ms 
every 20 ms. With TICK_CPU_ACCOUNTING and a 10ms tick, the processes 
either appear with 50% CPU or almost 0%.
Would it be more precise with IRQ_TIME_ACCOUNTING ?

Christophe

>
> As such, disable this option by default. If a user really wants it,
> they can still enable it manually.
>
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>  init/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index 1d3475fc9496..a5c30acc1ede 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -342,8 +342,7 @@ config VIRT_CPU_ACCOUNTING
>
>  choice
>  	prompt "Cputime accounting"
> -	default TICK_CPU_ACCOUNTING if !PPC64
> -	default VIRT_CPU_ACCOUNTING_NATIVE if PPC64
> +	default TICK_CPU_ACCOUNTING
>
>  # Kind of a stub config for the pure tick based cputime accounting
>  config TICK_CPU_ACCOUNTING
>

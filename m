Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405YkJ0fCzzF1GG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 13:32:55 +1100 (AEDT)
Message-ID: <1521599548.16434.263.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/64s: Fix lost pending interrupt due to race
 causing lost update to irq_happened
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Date: Wed, 21 Mar 2018 13:32:28 +1100
In-Reply-To: <20180321022228.9606-1-npiggin@gmail.com>
References: <20180321022228.9606-1-npiggin@gmail.com>
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

On Wed, 2018-03-21 at 12:22 +1000, Nicholas Piggin wrote:
> force_external_irq_replay() can be called in the do_IRQ path with
> interrupts hard enabled and soft disabled if may_hard_irq_enable() set
> MSR[EE]=1. It updates local_paca->irq_happened with a load, modify,
> store sequence. If a maskable interrupt hits during this sequence, it
> will go to the masked handler to be marked pending in irq_happened.
> This update will be lost when the interrupt returns and the store
> instruction executes.  This can result in unpredictable latencies,
> timeouts, lockups, etc.
> 
> Fix this by ensuring hard interrupts are disabled before modifying
> irq_happened.
> 
> This could cause any maskable asynchronous interrupt to get lost, but
> it was noticed on P9 SMP system doing RDMA NVMe target over 100GbE,
> so very high external interrupt rate and high IPI rate. The hang was
> bisected down to enabling doorbell interrupts for IPIs. These provided
> an interrupt type that could run at high rates in the do_IRQ path,
> stressing the race.
> 
> Fixes: 1d607bb3bd ("powerpc/irq: Add mechanism to force a replay of interrupts")
> Reported-by: Carol L. Soto <clsoto@us.ibm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

Nice one. We need that back into the distros asap.

> This has survived stress testing quite well so far, may need a little
> more testing but I'd like to post it now to get some more comments.
> 
> We can optimise the mtmsr a bit more (e.g., skip it if interrupts are
> already disabled or EE alrady set), but I've got some other patches
> pending which change things there slightly, so I prefer to have this
> minimal fix now, then make such changes upstream later.
> 
> ---
>  arch/powerpc/kernel/irq.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index f88038847790..061aa0f47bb1 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -476,6 +476,14 @@ void force_external_irq_replay(void)
>  	 */
>  	WARN_ON(!arch_irqs_disabled());
>  
> +	/*
> +	 * Interrupts must always be hard disabled before irq_happened is
> +	 * modified (to prevent lost update in case of interrupt between
> +	 * load and store).
> +	 */
> +	__hard_irq_disable();
> +	local_paca->irq_happened |= PACA_IRQ_HARD_DIS;
> +
>  	/* Indicate in the PACA that we have an interrupt to replay */
>  	local_paca->irq_happened |= PACA_IRQ_EE;
>  }

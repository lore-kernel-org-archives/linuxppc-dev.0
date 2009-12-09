Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5DE11B7B63
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Dec 2009 19:59:08 +1100 (EST)
Subject: Re: [PATCH 1/3] show_interrupts: use irq_chip::name if available
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Korsgaard <jacmet@sunsite.dk>
In-Reply-To: <87y6lcmwkk.fsf@macbook.be.48ers.dk>
References: <1259700494-17869-1-git-send-email-jacmet@sunsite.dk>
	<87y6lcmwkk.fsf@macbook.be.48ers.dk>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 09 Dec 2009 19:59:02 +1100
Message-ID: <1260349142.16132.39.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-12-09 at 08:32 +0100, Peter Korsgaard wrote:
> >>>>> "Peter" == Peter Korsgaard <jacmet@sunsite.dk> writes:
> 
>  Peter> struct irq_chip::typename is going away (replaced by name). Use name if
>  Peter> set instead of typename in show_interrupt to make ease transition.
> 
> Comments?

Hi Peter !

There's already a patch in my -next tree from Thomas Gleixner that fixes
that up along with a few others in arch/powerpc.

Cheers,
Ben.

>  Peter> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
>  Peter> ---
>  Peter>  arch/powerpc/kernel/irq.c |    3 ++-
>  Peter>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
>  Peter> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
>  Peter> index e5d1211..33e1130 100644
>  Peter> --- a/arch/powerpc/kernel/irq.c
>  Peter> +++ b/arch/powerpc/kernel/irq.c
>  Peter> @@ -203,7 +203,8 @@ int show_interrupts(struct seq_file *p, void *v)
>  Peter>  		seq_printf(p, "%10u ", kstat_irqs(i));
>  Peter>  #endif /* CONFIG_SMP */
>  Peter>  		if (desc->chip)
>  Peter> -			seq_printf(p, " %s ", desc->chip->typename);
>  Peter> +			seq_printf(p, " %s ", desc->chip->name ?
>  Peter> +				   desc->chip->name : desc->chip->typename);
>  Peter>  		else
>  Peter>  			seq_puts(p, "  None      ");
>  Peter>  		seq_printf(p, "%s", (desc->status & IRQ_LEVEL) ? "Level " : "Edge  ");
>  Peter> -- 
>  Peter> 1.6.5
> 
> 

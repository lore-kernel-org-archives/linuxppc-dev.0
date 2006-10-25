Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 97D9A67BD4
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 15:41:31 +1000 (EST)
In-Reply-To: <20061023163522.GA15901@ld0162-tx32.am.freescale.net>
References: <20061023163522.GA15901@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <37995C30-BB76-417A-B499-DC0DA6418139@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] IPIC: Don't call set_irq_handler with desc->lock held.
Date: Wed, 25 Oct 2006 00:41:31 -0500
To: tglx@linutronix.de,
 Ingo Molnar <mingo@elte.hu>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"linux-kernel@vger.kernel.org mailing list" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 23, 2006, at 11:35 AM, Scott Wood wrote:

> This patch causes ipic_set_irq_type to set the handler directly rather
> than call set_irq_handler, which causes spinlock recursion because
> the lock is already held when ipic_set_irq_type is called.
>
> I'm also not convinced that ipic_set_irq_type should be changing the
> handler at all.  There seem to be several controllers that don't and
> several that do.  Those that do would break what appears to be a  
> common
> usage of calling set_irq_chip_and_handler followed by set_irq_type,  
> if a
> non-standard handler were to be used.  OTOH, irq_create_of_mapping()
> doesn't set the handler, but only calls set_irq_type().
>
> This patch gets things working in the spinlock-debugging-enabled case,
> but I'm curious as to where the handler setting is ideally supposed  
> to be
> done.  I don't see any documentation on set_irq_type() that clarifies
> what the semantics are supposed to be.

Guys, Scott pointed this problem out on a PPC interrupt controller,  
and wanted to raise it in a larger forum since it appears to exist on  
at least one ARM interrupt controller I looked at (ixp4xx).  What is  
the proper solution to handle this.

The callers of set_type() I found all grab desc->lock.

- kumar

>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/sysdev/ipic.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
> index bc4d4a7..746f78c 100644
> --- a/arch/powerpc/sysdev/ipic.c
> +++ b/arch/powerpc/sysdev/ipic.c
> @@ -473,9 +473,9 @@ static int ipic_set_irq_type(unsigned in
>  	desc->status |= flow_type & IRQ_TYPE_SENSE_MASK;
>  	if (flow_type & IRQ_TYPE_LEVEL_LOW)  {
>  		desc->status |= IRQ_LEVEL;
> -		set_irq_handler(virq, handle_level_irq);
> +		desc->handle_irq = handle_level_irq;
>  	} else {
> -		set_irq_handler(virq, handle_edge_irq);
> +		desc->handle_irq = handle_edge_irq;
>  	}
>
>  	/* only EXT IRQ senses are programmable on ipic
> -- 
> 1.4.2.3
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

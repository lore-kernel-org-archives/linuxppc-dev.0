Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A6CEAB7D5C
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jun 2010 09:45:43 +1000 (EST)
Date: Mon, 7 Jun 2010 01:45:36 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Esben Haabendal <eha@doredevelopment.dk>
Subject: Re: [PATCH 1/2] powerpc: ipic: use set_irq_chip to ensure irq_chip
	defaults are applied
In-Reply-To: <1275686717.2970.13.camel@eha.doredevelopment.dk>
Message-ID: <alpine.LFD.2.00.1006070141230.2933@localhost.localdomain>
References: <cover.1275686504.git.eha@doredevelopment.dk>
	<1275686717.2970.13.camel@eha.doredevelopment.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 4 Jun 2010, Esben Haabendal wrote:

What's the rationale of this patch and which problem does it solve ?

> Signed-off-by: Esben Haabendal <eha@doredevelopment.dk>
> ---
>  arch/powerpc/sysdev/ipic.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
> index d7b9b9c..8464b86 100644
> --- a/arch/powerpc/sysdev/ipic.c
> +++ b/arch/powerpc/sysdev/ipic.c
> @@ -630,10 +630,10 @@ static int ipic_set_irq_type(unsigned int virq, unsigned int flow_type)
>  	if (flow_type & IRQ_TYPE_LEVEL_LOW)  {
>  		desc->status |= IRQ_LEVEL;
>  		desc->handle_irq = handle_level_irq;
> -		desc->chip = &ipic_level_irq_chip;
> +		set_irq_chip(virq, &ipic_level_irq_chip);

This patch has never been tested with spinlock debugging enabled and
will break SMP as it causes a deadlock on irq_desc->lock.

Again: See Documentation/Submit*

Thanks,

	tglx

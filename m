Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BB3E12C00FB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Aug 2013 07:32:10 +1000 (EST)
Message-ID: <1376343115.32100.183.camel@pasglop>
Subject: Re: powerpc: Mark low level irq handlers NO_THREAD
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Tue, 13 Aug 2013 07:31:55 +1000
In-Reply-To: <1376318939-14447-1-git-send-email-bigeasy@linutronix.de>
References: <1376318939-14447-1-git-send-email-bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Marcelo Tosatti <marcelo@kvack.org>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-08-12 at 16:48 +0200, Sebastian Andrzej Siewior wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> These low level handlers cannot be threaded. Mark them NO_THREAD
> 
> Reported-by: leroy christophe <christophe.leroy@c-s.fr>
> Tested-by: leroy christophe <christophe.leroy@c-s.fr>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> 
> This patch has been posted on Feb 13, 2013 and nobody responded back then.

And it was merged in 3.11 no ? :-)

Cheers,
Ben.

>  arch/powerpc/platforms/8xx/m8xx_setup.c |    1 +
>  arch/powerpc/sysdev/cpm1.c              |    1 +
>  2 files changed, 2 insertions(+)
> 
> --- a/arch/powerpc/platforms/8xx/m8xx_setup.c
> +++ b/arch/powerpc/platforms/8xx/m8xx_setup.c
> @@ -43,6 +43,7 @@ static irqreturn_t timebase_interrupt(in
>  
>  static struct irqaction tbint_irqaction = {
>  	.handler = timebase_interrupt,
> +	.flags = IRQF_NO_THREAD,
>  	.name = "tbint",
>  };
>  
> --- a/arch/powerpc/sysdev/cpm1.c
> +++ b/arch/powerpc/sysdev/cpm1.c
> @@ -120,6 +120,7 @@ static irqreturn_t cpm_error_interrupt(i
>  
>  static struct irqaction cpm_error_irqaction = {
>  	.handler = cpm_error_interrupt,
> +	.flags = IRQF_NO_THREAD,
>  	.name = "error",
>  };
>  

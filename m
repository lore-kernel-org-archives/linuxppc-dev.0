Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (www.linutronix.de [62.245.132.108])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D5F17B6F80
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Jun 2011 20:14:46 +1000 (EST)
Date: Wed, 1 Jun 2011 12:14:40 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] powerpc/fsl: Use irq_data_get_irq_handler_data() in
	chain handler
In-Reply-To: <alpine.DEB.2.00.1106011042080.30334@ayla.of.borg>
Message-ID: <alpine.LFD.2.02.1106011213120.3078@ionos>
References: <alpine.DEB.2.00.1106011042080.30334@ayla.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux/PPC Development <linuxppc-dev@lists.ozlabs.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 1 Jun 2011, Geert Uytterhoeven wrote:

> If you already have a pointer to a struct irq_data , it's more efficient
> to use irq_data_get_irq_handler_data().
> irq_get_handler_data() has to look up the struct irq_desc pointer again,
> which was already passed to the chain handler.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Completely untested, not even compile-tested.
> If this is correct, there are probably more of these?
> 
>  arch/powerpc/sysdev/fsl_msi.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
> index 92e7833..9b92c82 100644
> --- a/arch/powerpc/sysdev/fsl_msi.c
> +++ b/arch/powerpc/sysdev/fsl_msi.c
> @@ -193,7 +193,7 @@ static void fsl_msi_cascade(unsigned int irq, struct irq_desc *desc)
>  	u32 have_shift = 0;
>  	struct fsl_msi_cascade_data *cascade_data;
>  
> -	cascade_data = irq_get_handler_data(irq);
> +	cascade_data = irq_data_get_irq_handler_data(idata);

  cascade_data = irq_desc_get_handler_data(desc);

Might compile and work :)

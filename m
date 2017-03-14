Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjBPq4PFrzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 21:51:59 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linux-pcmcia@lists.infradead.org
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Subject: Re: [PATCH] drivers/pcmcia: NO_IRQ removal for electra_cf.c
In-Reply-To: <1473501690-11987-1-git-send-email-mpe@ellerman.id.au>
References: <1473501690-11987-1-git-send-email-mpe@ellerman.id.au>
Date: Tue, 14 Mar 2017 21:51:58 +1100
Message-ID: <87wpbsuo4x.fsf@concordia.ellerman.id.au>
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

Michael Ellerman <mpe@ellerman.id.au> writes:

> We'd like to eventually remove NO_IRQ on powerpc, so remove usages of it
> from electra_cf.c which is a powerpc-only driver.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  drivers/pcmcia/electra_cf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Ping anyone?

Or should I merge this via the powerpc tree?

cheers

> diff --git a/drivers/pcmcia/electra_cf.c b/drivers/pcmcia/electra_cf.c
> index 4d7bc3f4124a..c6fe2a4a7a6a 100644
> --- a/drivers/pcmcia/electra_cf.c
> +++ b/drivers/pcmcia/electra_cf.c
> @@ -207,7 +207,7 @@ static int electra_cf_probe(struct platform_device *ofdev)
>  		return -ENOMEM;
>  
>  	setup_timer(&cf->timer, electra_cf_timer, (unsigned long)cf);
> -	cf->irq = NO_IRQ;
> +	cf->irq = 0;
>  
>  	cf->ofdev = ofdev;
>  	cf->mem_phys = mem.start;
> @@ -313,7 +313,7 @@ fail3:
>  fail2:
>  	release_mem_region(cf->mem_phys, cf->mem_size);
>  fail1:
> -	if (cf->irq != NO_IRQ)
> +	if (cf->irq)
>  		free_irq(cf->irq, cf);
>  
>  	if (cf->io_virt)
> -- 
> 2.7.4

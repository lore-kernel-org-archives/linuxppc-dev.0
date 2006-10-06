Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BA68867EB0
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Oct 2006 14:23:16 +1000 (EST)
Subject: Re: [PATCH] powerpc: irq change build breaks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20061005203110.4c3022ce@localhost.localdomain>
References: <20061002132116.2663d7a3.akpm@osdl.org>
	<20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com>
	<20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com>
	<18975.1160058127@warthog.cambridge.redhat.com>
	<Pine.LNX.4.64.0610051632250.3952@g5.osdl.org>
	<20061005203110.4c3022ce@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 14:22:41 +1000
Message-Id: <1160108561.22232.108.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, arnd@arndb.de,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Linus Torvalds <torvalds@osdl.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-10-05 at 20:31 -0500, Olof Johansson wrote:
> Fix up some of the buildbreaks from the irq handler changes.
> 
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
> 
> On Thu, 5 Oct 2006 16:35:02 -0700 (PDT) Linus Torvalds <torvalds@osdl.org> wrote:
> 
> 
> > Any fall-out from this should be both obvious and pretty trivial to fix 
> > up.
> > 
> 
> Here's a pass of fixes from building all defconfigs under arch/powerpc
> + grep of generic_handle_irq callers.
> 
> 
> 
>  arch/powerpc/platforms/85xx/mpc85xx_ads.c  |    2 +-
>  arch/powerpc/platforms/85xx/mpc85xx_cds.c  |    2 +-
>  arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    2 +-
>  arch/powerpc/platforms/cell/interrupt.c    |    2 +-
>  arch/powerpc/platforms/chrp/setup.c        |    2 +-
>  arch/powerpc/platforms/powermac/pic.c      |    2 +-
>  arch/powerpc/sysdev/qe_lib/qe_ic.c         |    4 ++--
>  arch/powerpc/sysdev/tsi108_pci.c           |    2 +-
>  drivers/macintosh/via-cuda.c               |    2 +-
>  sound/oss/dmasound/dmasound_awacs.c        |    4 ++--
>  10 files changed, 12 insertions(+), 12 deletions(-)
> 
> 
> 
> Index: linux-2.6/arch/powerpc/platforms/85xx/mpc85xx_ads.c
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/platforms/85xx/mpc85xx_ads.c
> +++ linux-2.6/arch/powerpc/platforms/85xx/mpc85xx_ads.c
> @@ -72,7 +72,7 @@ static void cpm2_cascade(unsigned int ir
>  	int cascade_irq;
>  
>  	while ((cascade_irq = cpm2_get_irq(regs)) >= 0) {
> -		generic_handle_irq(cascade_irq, regs);
> +		generic_handle_irq(cascade_irq);
>  	}
>  	desc->chip->eoi(irq);
>  }
> Index: linux-2.6/arch/powerpc/platforms/85xx/mpc85xx_cds.c
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/platforms/85xx/mpc85xx_cds.c
> +++ linux-2.6/arch/powerpc/platforms/85xx/mpc85xx_cds.c
> @@ -138,7 +138,7 @@ static void mpc85xx_8259_cascade(unsigne
>  	unsigned int cascade_irq = i8259_irq(regs);
>  
>  	if (cascade_irq != NO_IRQ)
> -		generic_handle_irq(cascade_irq, regs);
> +		generic_handle_irq(cascade_irq);
>  
>  	desc->chip->eoi(irq);
>  }
> Index: linux-2.6/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
> +++ linux-2.6/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
> @@ -58,7 +58,7 @@ static void mpc86xx_8259_cascade(unsigne
>  {
>  	unsigned int cascade_irq = i8259_irq(regs);
>  	if (cascade_irq != NO_IRQ)
> -		generic_handle_irq(cascade_irq, regs);
> +		generic_handle_irq(cascade_irq);
>  	desc->chip->eoi(irq);
>  }
>  #endif	/* CONFIG_PCI */
> Index: linux-2.6/arch/powerpc/platforms/cell/interrupt.c
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/platforms/cell/interrupt.c
> +++ linux-2.6/arch/powerpc/platforms/cell/interrupt.c
> @@ -121,7 +121,7 @@ static void iic_ioexc_cascade(unsigned i
>  					irq_linear_revmap(iic_host,
>  							  base | cascade);
>  				if (cirq != NO_IRQ)
> -					generic_handle_irq(cirq, regs);
> +					generic_handle_irq(cirq);
>  			}
>  		/* post-ack level interrupts */
>  		ack = bits & ~IIC_ISR_EDGE_MASK;
> Index: linux-2.6/arch/powerpc/platforms/chrp/setup.c
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/platforms/chrp/setup.c
> +++ linux-2.6/arch/powerpc/platforms/chrp/setup.c
> @@ -340,7 +340,7 @@ static void chrp_8259_cascade(unsigned i
>  {
>  	unsigned int cascade_irq = i8259_irq(regs);
>  	if (cascade_irq != NO_IRQ)
> -		generic_handle_irq(cascade_irq, regs);
> +		generic_handle_irq(cascade_irq);
>  	desc->chip->eoi(irq);
>  }
>  
> Index: linux-2.6/arch/powerpc/sysdev/qe_lib/qe_ic.c
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/sysdev/qe_lib/qe_ic.c
> +++ linux-2.6/arch/powerpc/sysdev/qe_lib/qe_ic.c
> @@ -343,7 +343,7 @@ void fastcall qe_ic_cascade_low(unsigned
>  
>  	chip->mask_ack(irq);
>  	if (cascade_irq != NO_IRQ)
> -		generic_handle_irq(cascade_irq, regs);
> +		generic_handle_irq(cascade_irq);
>  	chip->unmask(irq);
>  }
>  
> @@ -359,7 +359,7 @@ void fastcall qe_ic_cascade_high(unsigne
>  
>  	chip->mask_ack(irq);
>  	if (cascade_irq != NO_IRQ)
> -		generic_handle_irq(cascade_irq, regs);
> +		generic_handle_irq(cascade_irq);
>  	chip->unmask(irq);
>  }
>  
> Index: linux-2.6/arch/powerpc/sysdev/tsi108_pci.c
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/sysdev/tsi108_pci.c
> +++ linux-2.6/arch/powerpc/sysdev/tsi108_pci.c
> @@ -410,6 +410,6 @@ void tsi108_irq_cascade(unsigned int irq
>  {
>  	unsigned int cascade_irq = get_pci_source();
>  	if (cascade_irq != NO_IRQ)
> -		generic_handle_irq(cascade_irq, regs);
> +		generic_handle_irq(cascade_irq);
>  	desc->chip->eoi(irq);
>  }
> Index: linux-2.6/arch/powerpc/platforms/powermac/pic.c
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/platforms/powermac/pic.c
> +++ linux-2.6/arch/powerpc/platforms/powermac/pic.c
> @@ -227,7 +227,7 @@ static irqreturn_t gatwick_action(int cp
>  			continue;
>  		irq += __ilog2(bits);
>  		spin_unlock_irqrestore(&pmac_pic_lock, flags);
> -		__do_IRQ(irq, regs);
> +		__do_IRQ(irq);
>  		spin_lock_irqsave(&pmac_pic_lock, flags);
>  		rc = IRQ_HANDLED;
>  	}
> Index: linux-2.6/drivers/macintosh/via-cuda.c
> ===================================================================
> --- linux-2.6.orig/drivers/macintosh/via-cuda.c
> +++ linux-2.6/drivers/macintosh/via-cuda.c
> @@ -437,7 +437,7 @@ cuda_poll(void)
>       * disable_irq(), would that work on m68k ? --BenH
>       */
>      local_irq_save(flags);
> -    cuda_interrupt(0, NULL, NULL);
> +    cuda_interrupt(0, NULL);
>      local_irq_restore(flags);
>  }
>  
> Index: linux-2.6/sound/oss/dmasound/dmasound_awacs.c
> ===================================================================
> --- linux-2.6.orig/sound/oss/dmasound/dmasound_awacs.c
> +++ linux-2.6/sound/oss/dmasound/dmasound_awacs.c
> @@ -465,7 +465,7 @@ tas_dmasound_init(void)
>  			val = pmac_call_feature(PMAC_FTR_READ_GPIO, NULL, gpio_headphone_detect, 0);
>  			pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL, gpio_headphone_detect, val | 0x80);
>  			/* Trigger it */
> -  			headphone_intr(0,NULL,NULL);
> +  			headphone_intr(0, NULL);
>    		}
>    	}
>    	if (!gpio_headphone_irq) {
> @@ -1499,7 +1499,7 @@ static int awacs_sleep_notify(struct pmu
>  				write_audio_gpio(gpio_audio_reset, !gpio_audio_reset_pol);
>  				msleep(150);
>  				tas_leave_sleep(); /* Stub for now */
> -				headphone_intr(0,NULL,NULL);
> +				headphone_intr(0, NULL);
>  				break;
>  			case AWACS_DACA:
>  				msleep(10); /* Check this !!! */
> -
> To unsubscribe from this list: send the line "unsubscribe linux-arch" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

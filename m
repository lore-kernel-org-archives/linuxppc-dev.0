Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 1D3B7DDF3E
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 03:13:12 +1000 (EST)
Message-ID: <46683D12.1050204@ru.mvista.com>
Date: Thu, 07 Jun 2007 21:14:58 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Randy Vinson <rvinson@mvista.com>
Subject: Re: [RFC] 85XX: Allow 8259 cascade to share an MPIC interrupt line.
References: <466755AC.40201@mvista.com>
In-Reply-To: <466755AC.40201@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Randy Vinson wrote:

> The Freescale MPC8555CDS and MPC8548CDS reference hardware has a legacy
> 8259 interrupt controller pair contained within a VIA VT82C686B Southbridge
> on the main carrier board. The processor complex plugs into the carrier
> card using a PCI slot which limits the available interrupts to the
> INTA-INTD PCI interrupts. The output of the 8259 cascade pair is routed
> through a gate array and connected to the PCI INTA interrupt line.
> The normal interrupt chaining hook (set_irq_chained_handler) does
> not allow sharing of the chained interrupt which prevents the
> use of PCI INTA by PCI devices. This patch allows the 8259 cascade
> pair to share their interrupt line with PCI devices.

    Hmm, I see you've come up with an interesting solution. :-)

> Signed-off-by: Randy Vinson <rvinson@mvista.com>
> ---
> Note that there may very well be a better way of accomplishing this. If someone
> has a better alternative, I'm open to it. This was just the simplest way I could
> get this to work.
> 
> Also, the addition of the .end routine for the MPIC is not strictly necessary for
> this patch. It's there so this code will run from within the threaded interrupt
> context used by the Real Time 

    Hmmm, why would you need that? Where RT is different from the vanilla? :-O

>  arch/powerpc/platforms/85xx/mpc85xx_cds.c |   32 +++++++++++++++++++++++++---
>  arch/powerpc/sysdev/mpic.c                |    1 +
>  2 files changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
> index 1490eb3..431aaa2 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
> @@ -127,16 +127,30 @@ static void __init mpc85xx_cds_pcibios_fixup(void)
>  }
>  
>  #ifdef CONFIG_PPC_I8259
> -#warning The i8259 PIC support is currently broken
> -static void mpc85xx_8259_cascade(unsigned int irq, struct irq_desc *desc)
> +static void mpc85xx_8259_cascade_handler(unsigned int irq,
> +					 struct irq_desc *desc)
>  {
>  	unsigned int cascade_irq = i8259_irq();
>  
>  	if (cascade_irq != NO_IRQ)
> +		/* handle an interrupt from the 8259 */
>  		generic_handle_irq(cascade_irq);
>  
> -	desc->chip->eoi(irq);
> +	/* check for any interrupts from the shared IRQ line */
> +	handle_fasteoi_irq(irq, desc);
>  }
> +
> +static irqreturn_t mpc85xx_8259_cascade_action(int irq, void *dev_id)
> +{
> +	return IRQ_HANDLED;
> +}

    Well, mpc85xx_8259_intr() would probably be more in line with the code 
elsewhere... and you could keep the mpc85xx_8259_cascade() name then.

> +static struct irqaction mpc85xxcds_8259_irqaction = {
> +	.handler = mpc85xx_8259_cascade_action,
> +	.flags = IRQF_SHARED,
> +	.mask = CPU_MASK_NONE,
> +	.name = "8259 cascade",
> +};
>  #endif /* PPC_I8259 */
>  #endif /* CONFIG_PCI */
>  
> @@ -216,7 +230,17 @@ static void __init mpc85xx_cds_pic_init(void)
>  	i8259_init(cascade_node, 0);
>  	of_node_put(cascade_node);
>  
> -	set_irq_chained_handler(cascade_irq, mpc85xx_8259_cascade);
> +	/*
> +	 *  Hook the interrupt to make sure desc->action is never NULL.
> +	 *  This is required to ensure that the interrupt does not get
> +	 *  disabled when the last user of the shared IRQ line frees their
> +	 *  interrupt.
> +	 */
> +	if (setup_irq(cascade_irq, &mpc85xxcds_8259_irqaction))
> +		printk(KERN_ERR "Failed to setup cascade interrupt\n");
> +	else
> +		/* Success. Connect our low-level cascade handler. */
> +		set_irq_handler(cascade_irq, mpc85xx_8259_cascade_handler);
>  #endif /* CONFIG_PPC_I8259 */
>  }
>  
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index 75aad38..14e3d1d 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -836,6 +836,7 @@ static struct irq_chip mpic_irq_chip = {
>  	.mask		= mpic_mask_irq,
>  	.unmask		= mpic_unmask_irq,
>  	.eoi		= mpic_end_irq,
> +	.end		= mpic_unmask_irq,
>  	.set_type	= mpic_set_irq_type,
>  };

WBR, Sergei

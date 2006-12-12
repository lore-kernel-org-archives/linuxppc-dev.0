Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 295EC67BDA
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 06:58:58 +1100 (EST)
In-Reply-To: <20061212215509.696cccf8@vitb.ru.mvista.com>
References: <20061212012641.5ef493f7@localhost.localdomain>
	<20061211223659.20169.50415.stgit@localhost.localdomain>
	<CB3BCBF7-D800-4438-A7D5-3798C56F9720@kernel.crashing.org>
	<20061212215509.696cccf8@vitb.ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A55328DA-0FC7-4334-B300-B853B9050773@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/4] [POWERPC] cpm2: Updates for CPM2 pic
Date: Tue, 12 Dec 2006 13:58:44 -0600
To: Vitaly Bordug <vbordug@ru.mvista.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 12, 2006, at 12:55 PM, Vitaly Bordug wrote:

> On Mon, 11 Dec 2006 20:21:52 -0600
> Kumar Gala <galak@kernel.crashing.org> wrote:
>
>>
>> On Dec 11, 2006, at 4:36 PM, Vitaly Bordug wrote:
>>
>>>
>>> This contains important fixes for the CPM2 PIC code. Eliminated
>>> CPM_IRQ_OFFSET, pulling the respective interrupt numbers from the
>>> interrupt
>>> mapping. Updated devicetree files to reflect that. Changed direct
>>> IC-related IO accesses to the IO accessors.
>>
>> Since your changing the interrupt numbers, do you mind changing the
>> interrupt sense to match ipic?  I was hoping to introduce a generic
>> host_xlate function to cover the various embedded pic's.
> Umm, can you pls elaborate what do you want to achieve?

Its a minor thing, but the values we picked for ipic to encode sense/ 
polarity match the linux definitions.  The idea is that  if we use  
the same encoding on multiple pic's we can sure the host_xlate code.

> I'm inlining updated patch with cpm2_set_irq_type () func which  
> sets up
> senses for EXT irq's and PortC irq's. ipic seems to have only EXT  
> irq's hence
> this approach differs from ipic one...
>
>
>
>
> This contains important fixes for the CPM2 PIC code. Eliminated
> CPM_IRQ_OFFSET, pulling the respective interrupt numbers from the  
> interrupt
> mapping. Updated devicetree files to reflect that. Changed direct
> IC-related IO accesses to the IO accessors.
>
> Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
> ---
>
>  arch/powerpc/boot/dts/mpc8560ads.dts |    8 +-
>  arch/powerpc/sysdev/cpm2_pic.c       |  127 +++++++++++++++++++ 
> +--------------
>  arch/powerpc/sysdev/cpm2_pic.h       |    9 ++
>  include/asm-powerpc/mpc8260.h        |   32 +++++++++
>  4 files changed, 120 insertions(+), 56 deletions(-)
>
> diff --git a/arch/powerpc/boot/dts/mpc8560ads.dts b/arch/powerpc/ 
> boot/dts/mpc8560ads.dts
> index 2b16848..3c1e44a 100644
> --- a/arch/powerpc/boot/dts/mpc8560ads.dts
> +++ b/arch/powerpc/boot/dts/mpc8560ads.dts
> @@ -250,7 +250,7 @@
>  				rx-clock = <1>;
>  				tx-clock = <1>;
>  				current-speed = <1c200>;
> -				interrupts = <64 1>;
> +				interrupts = <28 1>;
>  				interrupt-parent = <90c00>;
>  			};
>
> @@ -264,7 +264,7 @@
>  				rx-clock = <2>;
>  				tx-clock = <2>;
>  				current-speed = <1c200>;
> -				interrupts = <65 1>;
> +				interrupts = <29 1>;
>  				interrupt-parent = <90c00>;
>  			};
>
> @@ -278,7 +278,7 @@
>  				clock-setup = <ff00ffff 250000>;
>  				rx-clock = <15>;
>  				tx-clock = <16>;
> -				interrupts = <5d 1>;
> +				interrupts = <21 1>;
>  				interrupt-parent = <90c00>;
>  				phy-handle = <2452002>;
>  			};
> @@ -293,7 +293,7 @@
>  				clock-setup = <ffff00ff 3700>;
>  				rx-clock = <17>;
>  				tx-clock = <18>;
> -				interrupts = <5e 1>;
> +				interrupts = <22 1>;
>  				interrupt-parent = <90c00>;
>  				phy-handle = <2452003>;
>  			};
> diff --git a/arch/powerpc/sysdev/cpm2_pic.c b/arch/powerpc/sysdev/ 
> cpm2_pic.c
> index 767ee66..bf5c952 100644
> --- a/arch/powerpc/sysdev/cpm2_pic.c
> +++ b/arch/powerpc/sysdev/cpm2_pic.c
> @@ -36,6 +36,7 @@ #include <asm/immap_cpm2.h>
>  #include <asm/mpc8260.h>
>  #include <asm/io.h>
>  #include <asm/prom.h>
> +#include <asm/fs_pd.h>
>
>  #include "cpm2_pic.h"
>
> @@ -68,68 +69,55 @@ static const u_char irq_to_siubit[] = {
>  	24, 25, 26, 27, 28, 29, 30, 31,
>  };
>
> -static void cpm2_mask_irq(unsigned int irq_nr)
> +static void cpm2_mask_irq(unsigned int irq)
>  {
>  	int	bit, word;
> -	volatile uint	*simr;
> -
> -	irq_nr -= CPM_IRQ_OFFSET;
> +	unsigned int irq_nr = (unsigned int)irq_map[irq].hwirq;
>
>  	bit = irq_to_siubit[irq_nr];
>  	word = irq_to_siureg[irq_nr];
>
> -	simr = &(cpm2_intctl->ic_simrh);
>  	ppc_cached_irq_mask[word] &= ~(1 << bit);
> -	simr[word] = ppc_cached_irq_mask[word];
> +	out_be32(&cpm2_intctl->ic_simrh + word, ppc_cached_irq_mask[word]);
>  }
>
> -static void cpm2_unmask_irq(unsigned int irq_nr)
> +static void cpm2_unmask_irq(unsigned int irq)
>  {
>  	int	bit, word;
> -	volatile uint	*simr;
> -
> -	irq_nr -= CPM_IRQ_OFFSET;
> +	unsigned int irq_nr = (unsigned int)irq_map[irq].hwirq;
>
>  	bit = irq_to_siubit[irq_nr];
>  	word = irq_to_siureg[irq_nr];
>
> -	simr = &(cpm2_intctl->ic_simrh);
>  	ppc_cached_irq_mask[word] |= 1 << bit;
> -	simr[word] = ppc_cached_irq_mask[word];
> +	out_be32(&cpm2_intctl->ic_simrh + word, ppc_cached_irq_mask[word]);
>  }
>
> -static void cpm2_mask_and_ack(unsigned int irq_nr)
> +static void cpm2_ack(unsigned int irq)
>  {
>  	int	bit, word;
> -	volatile uint	*simr, *sipnr;
> -
> -	irq_nr -= CPM_IRQ_OFFSET;
> +	unsigned int irq_nr = (unsigned int)irq_map[irq].hwirq;
>
>  	bit = irq_to_siubit[irq_nr];
>  	word = irq_to_siureg[irq_nr];
>
> -	simr = &(cpm2_intctl->ic_simrh);
> -	sipnr = &(cpm2_intctl->ic_sipnrh);
> -	ppc_cached_irq_mask[word] &= ~(1 << bit);
> -	simr[word] = ppc_cached_irq_mask[word];
> -	sipnr[word] = 1 << bit;
> +	out_be32(&cpm2_intctl->ic_sipnrh + word, 1 << bit);
>  }
>
> -static void cpm2_end_irq(unsigned int irq_nr)
> +static void cpm2_end_irq(unsigned int irq)
>  {
>  	int	bit, word;
> -	volatile uint	*simr;
> +	unsigned int irq_nr = (unsigned int)irq_map[irq].hwirq;
>
>  	if (!(irq_desc[irq_nr].status & (IRQ_DISABLED|IRQ_INPROGRESS))
>  			&& irq_desc[irq_nr].action) {
>
> -		irq_nr -= CPM_IRQ_OFFSET;
>  		bit = irq_to_siubit[irq_nr];
>  		word = irq_to_siureg[irq_nr];
>
> -		simr = &(cpm2_intctl->ic_simrh);
>  		ppc_cached_irq_mask[word] |= 1 << bit;
> -		simr[word] = ppc_cached_irq_mask[word];
> +		out_be32(&cpm2_intctl->ic_simrh + word, ppc_cached_irq_mask[word]);
> +
>  		/*
>  		 * Work around large numbers of spurious IRQs on PowerPC 82xx
>  		 * systems.
> @@ -138,13 +126,59 @@ static void cpm2_end_irq(unsigned int ir
>  	}
>  }
>
> +static int cpm2_set_irq_type(unsigned int virq, unsigned int  
> flow_type)
> +{
> +	unsigned int src = (unsigned int)irq_map[virq].hwirq;
> +	struct irq_desc *desc = get_irq_desc(virq);
> +	unsigned int vold, vnew, edibit;
> +
> +	if (flow_type == IRQ_TYPE_NONE)
> +		flow_type = IRQ_TYPE_LEVEL_LOW;
> +
> +	if (flow_type & IRQ_TYPE_EDGE_RISING) {
> +		printk(KERN_ERR "CPM2 PIC: sense type 0x%x not supported\n",
> +			flow_type);
> +		return -EINVAL;
> +	}
> +
> +	desc->status &= ~(IRQ_TYPE_SENSE_MASK | IRQ_LEVEL);
> +	desc->status |= flow_type & IRQ_TYPE_SENSE_MASK;
> +	if (flow_type & IRQ_TYPE_LEVEL_LOW)  {
> +		desc->status |= IRQ_LEVEL;
> +		desc->handle_irq = handle_level_irq;
> +	} else
> +		desc->handle_irq = handle_edge_irq;
> +
> +	/* internal IRQ senses are LEVEL_LOW
> +	 * EXT IRQ and Port C IRQ senses are programmable
> +	 */
> +	if (src >= CPM2_IRQ_EXT1 && src <= CPM2_IRQ_EXT7)
> +			edibit = (14 - (src - CPM2_IRQ_EXT1));
> +	else
> +		if (src >= CPM2_IRQ_PORTC15 && src <= CPM2_IRQ_PORTC0)
> +			edibit = (31 - (src - CPM2_IRQ_PORTC15));
> +		else
> +			return (flow_type & IRQ_TYPE_LEVEL_LOW) ? 0 : -EINVAL;
> +
> +	vold = in_be32(&cpm2_intctl->ic_siexr);
> +
> +	if ((flow_type & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_FALLING)
> +		vnew = vold | (1 << edibit);
> +	else
> +		vnew = vold & ~(1 << edibit);
> +
> +	if (vold != vnew)
> +		out_be32(&cpm2_intctl->ic_siexr, vnew);
> +	return 0;
> +}
> +
>  static struct irq_chip cpm2_pic = {
>  	.typename = " CPM2 SIU ",
> -	.enable = cpm2_unmask_irq,
> -	.disable = cpm2_mask_irq,
> +	.mask = cpm2_mask_irq,
>  	.unmask = cpm2_unmask_irq,
> -	.mask_ack = cpm2_mask_and_ack,
> -	.end = cpm2_end_irq,
> +	.ack = cpm2_ack,
> +	.eoi = cpm2_end_irq,
> +	.set_type = cpm2_set_irq_type,
>  };
>
>  unsigned int cpm2_get_irq(void)
> @@ -154,17 +188,17 @@ unsigned int cpm2_get_irq(void)
>
>         /* For CPM2, read the SIVEC register and shift the bits down
>           * to get the irq number.         */
> -        bits = cpm2_intctl->ic_sivec;
> +        bits = in_be32(&cpm2_intctl->ic_sivec);
>          irq = bits >> 26;
>
>  	if (irq == 0)
>  		return(-1);
> -	return irq+CPM_IRQ_OFFSET;
> +	return irq_linear_revmap(cpm2_pic_host, irq);
>  }
>
>  static int cpm2_pic_host_match(struct irq_host *h, struct  
> device_node *node)
>  {
> -	return cpm2_pic_node == NULL || cpm2_pic_node == node;
> +	return cpm2_pic_node == node;
>  }
>
>  static int cpm2_pic_host_map(struct irq_host *h, unsigned int virq,
> @@ -177,15 +211,6 @@ static int cpm2_pic_host_map(struct irq_
>  	return 0;
>  }
>
> -static void cpm2_host_unmap(struct irq_host *h, unsigned int virq)
> -{
> -	/* Make sure irq is masked in hardware */
> -	cpm2_mask_irq(virq);
> -
> -	/* remove chip and handler */
> -	set_irq_chip_and_handler(virq, NULL, NULL);
> -}
> -
>  static int cpm2_pic_host_xlate(struct irq_host *h, struct  
> device_node *ct,
>  			    u32 *intspec, unsigned int intsize,
>  			    irq_hw_number_t *out_hwirq, unsigned int *out_flags)
> @@ -202,14 +227,12 @@ static int cpm2_pic_host_xlate(struct ir
>  		*out_flags = map_cpm2_senses[intspec[1]];
>  	else
>  		*out_flags = IRQ_TYPE_NONE;
> -
>  	return 0;
>  }
>
>  static struct irq_host_ops cpm2_pic_host_ops = {
>  	.match = cpm2_pic_host_match,
>  	.map = cpm2_pic_host_map,
> -	.unmap = cpm2_host_unmap,
>  	.xlate = cpm2_pic_host_xlate,
>  };
>
> @@ -223,26 +246,26 @@ void cpm2_pic_init(struct device_node *n
>
>  	/* Mask out everything */
>
> -	cpm2_intctl->ic_simrh = 0x00000000;
> -	cpm2_intctl->ic_simrl = 0x00000000;
> +	out_be32(&cpm2_intctl->ic_simrh, 0x00000000);
> +	out_be32(&cpm2_intctl->ic_simrl, 0x00000000);
>
>  	wmb();
>
>  	/* Ack everything */
> -	cpm2_intctl->ic_sipnrh = 0xffffffff;
> -	cpm2_intctl->ic_sipnrl = 0xffffffff;
> +	out_be32(&cpm2_intctl->ic_sipnrh, 0xffffffff);
> +	out_be32(&cpm2_intctl->ic_sipnrl, 0xffffffff);
>  	wmb();
>
>  	/* Dummy read of the vector */
> -	i = cpm2_intctl->ic_sivec;
> +	i = in_be32(&cpm2_intctl->ic_sivec);
>  	rmb();
>
>  	/* Initialize the default interrupt mapping priorities,
>  	 * in case the boot rom changed something on us.
>  	 */
> -	cpm2_intctl->ic_sicr = 0;
> -	cpm2_intctl->ic_scprrh = 0x05309770;
> -	cpm2_intctl->ic_scprrl = 0x05309770;
> +	out_be16(&cpm2_intctl->ic_sicr, 0);
> +	out_be32(&cpm2_intctl->ic_scprrh, 0x05309770);
> +	out_be32(&cpm2_intctl->ic_scprrl, 0x05309770);
>
>  	/* create a legacy host */
>  	if (node)
> diff --git a/arch/powerpc/sysdev/cpm2_pic.h b/arch/powerpc/sysdev/ 
> cpm2_pic.h
> index 2840616..643a857 100644
> --- a/arch/powerpc/sysdev/cpm2_pic.h
> +++ b/arch/powerpc/sysdev/cpm2_pic.h
> @@ -1,6 +1,15 @@
>  #ifndef _PPC_KERNEL_CPM2_H
>  #define _PPC_KERNEL_CPM2_H
>
> +
> +/* External IRQS */
> +#define CPM2_IRQ_EXT1		19
> +#define CPM2_IRQ_EXT7		25
> +
> +/* Port C IRQS */
> +#define CPM2_IRQ_PORTC15	48
> +#define CPM2_IRQ_PORTC0		63
> +
>  extern intctl_cpm2_t *cpm2_intctl;
>
>  extern unsigned int cpm2_get_irq(void);
> diff --git a/include/asm-powerpc/mpc8260.h b/include/asm-powerpc/ 
> mpc8260.h
> new file mode 100644
> index 0000000..c2adcb0
> --- /dev/null
> +++ b/include/asm-powerpc/mpc8260.h
> @@ -0,0 +1,32 @@
> +/*
> + * Since there are many different boards and no standard  
> configuration,
> + * we have a unique include file for each.  Rather than change every
> + * file that has to include MPC8260 configuration, they all include
> + * this one and the configuration switching is done here.
> + */
> +#ifdef __KERNEL__
> +#ifndef __ASM_PPC_MPC8260_H__
> +#define __ASM_PPC_MPC8260_H__
> +
> +
> +#ifdef CONFIG_8260
> +
> +#if defined(CONFIG_PQ2ADS) || defined (CONFIG_PQ2FADS)
> +#include <platforms/82xx/pq2ads.h>
> +#endif
> +
> +#ifdef CONFIG_PCI_8260
> +#include <platforms/82xx/m82xx_pci.h>
> +#endif
> +
> +#ifndef _ISA_MEM_BASE
> +#define _ISA_MEM_BASE   0
> +#endif
> +
> +#ifndef PCI_DRAM_OFFSET
> +#define PCI_DRAM_OFFSET 0
> +#endif
> +
> +#endif /* CONFIG_8260 */
> +#endif /* !__ASM_PPC_MPC8260_H__ */
> +#endif /* __KERNEL__ */
>
>
> -- 
> Sincerely,
> Vitaly

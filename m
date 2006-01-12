Return-Path: <tnt@246tnt.com>
Received: from neptune.fsa.ucl.ac.be (neptune.fsa.ucl.ac.be [130.104.233.21])
	by ozlabs.org (Postfix) with ESMTP id 6DD6D689AE
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jan 2006 21:06:35 +1100 (EST)
Message-ID: <43C625F5.8070602@246tNt.com>
Date: Thu, 12 Jan 2006 10:48:37 +0100
From: Sylvain Munaut <tnt@246tnt.com>
MIME-Version: 1.0
To: Andrey Volkov <avolkov@varma-el.com>
References: <43C614A5.6030703@varma-el.com>
In-Reply-To: <43C614A5.6030703@varma-el.com>
Content-Type: text/plain; charset=KOI8-R
Cc: LKML <linux-kernel@vger.kernel.org>,
	ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [kernel-2.6.15] Fix PCI irq mapping for lite5200
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Andrey,

Andrey Volkov wrote:
> Hi Sylvain,
> 
> This patch fix problem of PCI boards irq mapping on lite5200

What problem is that patch supposed to fix ?
The Lite5200 has a single PCI port, assigned to idsel 24 (afair) and its
INTA is connected to the IRQ0 pin of the 5200 so that looks correct to me.

> (raised after your changes of MPC52xx_IRQ0 number)

I'm not sure I get this either.
Do you mean that change provoked the bug you're talking about or that
before that change the bug was there but just not visible because masked
by the interrupt number being 0 problem ?


	Sylvain

> 
> --
> Regards
> Andrey Volkov
> 
> 
> ------------------------------------------------------------------------
> 
> 	lite5200_map_irq: Fix irq mapping for external PCI boards
> 
> Signed-off-by: Andrey Volkov <avolkov@varma-el.com>
> ---
> 
>  arch/ppc/platforms/lite5200.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/ppc/platforms/lite5200.c b/arch/ppc/platforms/lite5200.c
> index 7ed52dc..cd4acb3 100644
> --- a/arch/ppc/platforms/lite5200.c
> +++ b/arch/ppc/platforms/lite5200.c
> @@ -73,7 +73,8 @@ lite5200_show_cpuinfo(struct seq_file *m
>  static int
>  lite5200_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
>  {
> -	return (pin == 1) && (idsel==24) ? MPC52xx_IRQ0 : -1;
> +	/* Only INTA supported */
> +	return (pin == 1) ? MPC52xx_IRQ0 : -1;
>  }
>  #endif
>  

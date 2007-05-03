Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0D45CDDFEA
	for <linuxppc-dev@ozlabs.org>; Fri,  4 May 2007 00:45:57 +1000 (EST)
In-Reply-To: <1178142818.32136.51.camel@ld0161-tx32>
References: <1178142818.32136.51.camel@ld0161-tx32>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <08D3A1CE-12E0-4759-B055-DE227EA4135E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] 86xx: Enable the AC97 interface on 8641D board.
Date: Thu, 3 May 2007 09:44:56 -0500
To: Jon Loeliger <jdl@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 2, 2007, at 4:53 PM, Jon Loeliger wrote:

> From: Jason Jin <jason.jin@freescale.com>
>
> HD interface and AC97 interface share some pins and they are  
> enabled at
> the same time, In order to use AC97 interface, we need to disable  
> the HD
> interface first.
>
> Signed-off-by:Jason Jin<jason.jin@freescale.com>
> Acked-by: Jon Loeliger <jdl@freescale.com>
> ---
>  arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)

Is the HD feature not used at all?  Is there a AC97 Driver CONFIG_  
that makes sense to wrap that with?  Just wondering about the mutual  
exclusion (and how to provide flexibility to the user).

- k

>
> diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/ 
> powerpc/platforms/86xx/mpc86xx_hpcn.c
> index 3d3d98f..13a14dd 100644
> --- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
> +++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
> @@ -168,7 +168,7 @@ static void __devinit quirk_uli1575(struct  
> pci_dev *dev)
>  {
>  	unsigned short temp;
>  	struct pci_controller *hose = pci_bus_to_host(dev->bus);
> -	unsigned char irq2pin[16];
> +	unsigned char irq2pin[16], c;
>  	unsigned long pirq_map_word = 0;
>  	u32 irq;
>  	int i;
> @@ -288,6 +288,11 @@ static void __devinit quirk_uli1575(struct  
> pci_dev *dev)
>  	outb(0x1e, 0x4d1);
>
>  #undef ULI1575_SET_DEV_IRQ
> +
> +	/* Disable the HD interface and enable the AC97 interface. */
> +	pci_read_config_byte(dev, 0xb8, &c);
> +	c &= 0x7f;
> +	pci_write_config_byte(dev, 0xb8, c);
>  }
>
>  static void __devinit quirk_uli5288(struct pci_dev *dev)
> -- 
> 1.5.0.3
>
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

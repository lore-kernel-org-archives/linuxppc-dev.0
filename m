Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D4592DDEC7
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jun 2007 23:50:03 +1000 (EST)
In-Reply-To: <1180996227.9632.77.camel@ld0161-tx32>
References: <1180996227.9632.77.camel@ld0161-tx32>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <062E6779-8D69-4700-896C-FE06A5F8947E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2 9/9] Created quirk_mpc8641_transparent() to initialize
	bridge resources.
Date: Fri, 22 Jun 2007 08:50:42 -0500
To: Jon Loeliger <jdl@freescale.com>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 4, 2007, at 5:30 PM, Jon Loeliger wrote:

> The 8641 RC poses as a transparent bridge, but does not implement the
> IO_BASE or IO_LIMIT registers in the config space.  This means that
> the code which initializes the bridge resources ends up setting the
> IO resources erroneously.
>
> This change sets RC of mpc8641 to be a transparent bridge
> for legacy I/O access and initializes the RC bridge resources
> from the device tree.
>
> Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
> Signed-off-by: Andy Fleming <afleming@freescale.com>
> Signed-off-by: Jon Loeliger <jdl@freescale.com>
> ---
>
> Incorporates review suggestions from Milton.
>
>  arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |   76 +++++++++++++++++ 
> +++++++++++
>  1 files changed, 76 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/ 
> powerpc/platforms/86xx/mpc86xx_hpcn.c
> index a82da4b..83a2c28 100644
> --- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
> +++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
> @@ -318,6 +318,7 @@ static void __devinit quirk_uli5288(struct  
> pci_dev *dev)
>  static void __devinit quirk_uli5229(struct pci_dev *dev)
>  {
>  	unsigned short temp;
> +
>  	pci_write_config_word(dev, 0x04, 0x0405);
>  	dev->class &= ~0x5;
>  	pci_read_config_word(dev, 0x4a, &temp);
> @@ -325,6 +326,75 @@ static void __devinit quirk_uli5229(struct  
> pci_dev *dev)
>  	pci_write_config_word(dev, 0x4a, temp);
>  }
>
> +static void __devinit quirk_mpc8641_transparent(struct pci_dev *dev)
> +{

Shouldn't we put this in fsl_pcie.c since it will be need by everyone  
using an 85xx/86xx pci-e controller?

[snip]
> +}

- k

Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EF5B3DE056
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 06:51:08 +1000 (EST)
In-Reply-To: <1179805110284-git-send-email-wei.zhang@freescale.com>
References: <11798051102658-git-send-email-wei.zhang@freescale.com>
	<11798051101543-git-send-email-wei.zhang@freescale.com>
	<1179805110272-git-send-email-wei.zhang@freescale.com>
	<1179805110278-git-send-email-wei.zhang@freescale.com>
	<11798051102051-git-send-email-wei.zhang@freescale.com>
	<1179805110284-git-send-email-wei.zhang@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A5691757-8218-489B-B809-DE44F81EA5C8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 5/5] Set IDE in ULI1575 to not native mode.
Date: Tue, 29 May 2007 15:50:55 -0500
To: Zhang Wei <wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 21, 2007, at 10:38 PM, Zhang Wei wrote:

> Set IDE in ULI1575 to not 100% native mode, which forces
> the IDE driver to probe the irq itself.
>
> Signed-off-by: Zhang Wei <wei.zhang@freescale.com>

What causes this to be needed?

- k

> ---
>  arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/ 
> powerpc/platforms/86xx/mpc86xx_hpcn.c
> index eb2bc99..2a2dea7 100644
> --- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
> +++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
> @@ -314,6 +314,7 @@ static void __devinit quirk_uli5229(struct  
> pci_dev *dev)
>  {
>  	unsigned short temp;
>  	pci_write_config_word(dev, 0x04, 0x0405);
> +	dev->class &= ~0x5;
>  	pci_read_config_word(dev, 0x4a, &temp);
>  	temp |= 0x1000;
>  	pci_write_config_word(dev, 0x4a, temp);
> -- 
> 1.5.1
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

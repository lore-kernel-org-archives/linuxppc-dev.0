Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 00556DDEC1
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 02:47:28 +1000 (EST)
Date: Tue, 17 Jul 2007 11:47:07 -0500
From: Scott Wood <scottwood@freescale.com>
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH] USB_DR host support for FSL MPC831x
Message-ID: <20070717164707.GD7347@ld0162-tx32.am.freescale.net>
References: <20070717005832.23019.99739.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070717005832.23019.99739.stgit@localhost.localdomain>
Cc: Greg KH <greg@kroah.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 17, 2007 at 04:58:32AM +0400, Vitaly Bordug wrote:
> diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
> index 1b351dc..c330e79 100644
> --- a/arch/powerpc/boot/dts/mpc8313erdb.dts
> +++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
> @@ -90,6 +90,7 @@
>  			interrupt-parent = < &ipic >;
>  			interrupts = <26 8>;
>  			phy_type = "utmi_wide";
> +			control_init  = <00000280>; // UTMI ext 48 MHz clk

fsl,usb-control-init, please.

> diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
> index 099aff6..994a127 100644
> --- a/drivers/usb/host/ehci-hcd.c
> +++ b/drivers/usb/host/ehci-hcd.c
> @@ -925,7 +925,7 @@ MODULE_LICENSE ("GPL");
>  #define	PCI_DRIVER		ehci_pci_driver
>  #endif
>  
> -#ifdef CONFIG_MPC834x
> +#if defined(CONFIG_MPC834x) || defined(CONFIG_PPC_MPC831x)
>  #include "ehci-fsl.c"
>  #define	PLATFORM_DRIVER		ehci_fsl_driver
>  #endif

It'd be better to define a CONFIG_FSL_EHCI and have the 834x and 831x
configs enable it.

-Scott

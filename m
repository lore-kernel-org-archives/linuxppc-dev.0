Return-Path: <tnt@246tNt.com>
Received: from outmx008.isp.belgacom.be (outmx008.isp.belgacom.be
	[195.238.5.235])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6E0D567C2F
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 02:58:45 +1100 (EST)
Received: from outmx008.isp.belgacom.be (localhost [127.0.0.1])
	by outmx008.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id kBDFweu2007453
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 16:58:40 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <458022EA.2060301@246tNt.com>
Date: Wed, 13 Dec 2006 16:57:30 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [POWERPC] Change mpc52xx Kconfig entries to match other freescale
	parts
References: <11660241251891-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <11660241251891-git-send-email-grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Little nak ;-)

Grant Likely wrote:
> All other Freescale parts use Kconfig defines of the form: PPC_8?xx
> The MPC52xx is currently in the form: PPC_MPC52xx.  This commit changes
> it to PPC_52xx for consistency sake.
>   
In principle I'm not opposed to it and if it's true it's more coherent
with other
platforms.

I have a couple of comments though :
> diff --git a/Documentation/powerpc/mpc52xx.txt b/Documentation/powerpc/mpc52xx.txt
> index 10dd4ab..1ba7997 100644
> --- a/Documentation/powerpc/mpc52xx.txt
> +++ b/Documentation/powerpc/mpc52xx.txt
> @@ -29,7 +29,7 @@ To compile/use :
>       
>  
>  Some remarks :
> - - The port is named mpc52xxx, and config options are PPC_MPC52xx. The MGT5100
> + - The port is named mpc52xxx, and config options are PPC_52xx. The MGT5100
>     is not supported, and I'm not sure anyone is interesting in working on it
>     so. I didn't took 5xxx because there's apparently a lot of 5xxx that have
>     nothing to do with the MPC5200. I also included the 'MPC' for the same
>   
Read this comment in full and then change it appropriately ;)
 (The "I also included the 'MPC' for" part should be removed)


> diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
> index 9980a4d..fab22b8 100644
> --- a/drivers/usb/Kconfig
> +++ b/drivers/usb/Kconfig
> @@ -28,7 +28,7 @@ config USB_ARCH_HAS_OHCI
>  	default y if ARCH_PNX4008
>  	# PPC:
>  	default y if STB03xxx
> -	default y if PPC_MPC52xx
> +	default y if PPC_52xx
>  	# MIPS:
>  	default y if SOC_AU1X00
>  	# more:
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index cc60759..917b691 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -99,7 +99,7 @@ config USB_OHCI_HCD
>  
>  config USB_OHCI_HCD_PPC_SOC
>  	bool "OHCI support for on-chip PPC USB controller"
> -	depends on USB_OHCI_HCD && (STB03xxx || PPC_MPC52xx)
> +	depends on USB_OHCI_HCD && (STB03xxx || PPC_52xx)
>  	default y
>  	select USB_OHCI_BIG_ENDIAN
>  	---help---
> @@ -108,7 +108,7 @@ config USB_OHCI_HCD_PPC_SOC
>  
>  config USB_OHCI_HCD_PCI
>  	bool "OHCI support for PCI-bus USB controllers"
> -	depends on USB_OHCI_HCD && PCI && (STB03xxx || PPC_MPC52xx)
> +	depends on USB_OHCI_HCD && PCI && (STB03xxx || PPC_52xx)
>  	default y
>  	select USB_OHCI_LITTLE_ENDIAN
>  	---help---
> @@ -123,7 +123,7 @@ config USB_OHCI_BIG_ENDIAN
>  config USB_OHCI_LITTLE_ENDIAN
>  	bool
>  	depends on USB_OHCI_HCD
> -	default n if STB03xxx || PPC_MPC52xx
> +	default n if STB03xxx || PPC_52xx
>  	default y
>  
>  config USB_UHCI_HCD
>   
The usb part might conflict with pending changes.

I'm sending a usb patch set tonight to Greg for 2.6.20, so I would say I
can include
that in it and fix the dependencies. But then, we need to make sure this
patches
makes it to 2.6.20 as well else we just break USB for the 5200 ;)

    Sylvain

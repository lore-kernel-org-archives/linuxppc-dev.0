Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DDBF8DDE9F
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jan 2008 18:24:39 +1100 (EST)
Subject: Re: [PATCH] Miscellaneous for Taco
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sean MacLennan <smaclennan@pikatech.com>
In-Reply-To: <477F13C0.7040006@pikatech.com>
References: <477F13C0.7040006@pikatech.com>
Content-Type: text/plain
Date: Sat, 05 Jan 2008 18:24:25 +1100
Message-Id: <1199517865.7291.50.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sat, 2008-01-05 at 00:21 -0500, Sean MacLennan wrote:
> Last ones for now.
> 
> This patch allows you to turn off scsi_wait_scan.

You'll have to run that one via the SCSI maintainers.

> diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
> index a6676be..960dc78 100644
> --- a/drivers/scsi/Kconfig
> +++ b/drivers/scsi/Kconfig
> @@ -248,7 +248,7 @@ config SCSI_SCAN_ASYNC
>           or async on the kernel's command line.
>  
>  config SCSI_WAIT_SCAN
> -       tristate
> +       tristate "SCSI wait scan"
>         default m
>         depends on SCSI
>         depends on MODULES
> 
> This patch allows you to use the USB with the taco. The taco does not 
> have PCI so we must specifically add it.
> 
> diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
> index 7580aa5..480580c 100644
> --- a/drivers/usb/Kconfig
> +++ b/drivers/usb/Kconfig
> @@ -39,6 +39,7 @@ config USB_ARCH_HAS_OHCI
>         # PPC:
>         default y if STB03xxx
>         default y if PPC_MPC52xx
> +       default y if TACO
>         # MIPS:
>         default y if SOC_AU1X00
>         # more:

I think we should instead reference use the 440EP here, or select it
from your board code. I -hate- those long lists of board specific bits
hidden in driver Kconfig...

Cheers,
Ben.

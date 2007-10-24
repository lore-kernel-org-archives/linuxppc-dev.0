Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2866CDDF32
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Oct 2007 08:02:58 +1000 (EST)
Message-ID: <471FC191.6020704@genesi-usa.com>
Date: Wed, 24 Oct 2007 23:05:05 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH 1/2] USB: Rework OHCI PPC OF for new bindings
References: <20071024163412.GA17785@ru.mvista.com>
In-Reply-To: <20071024163412.GA17785@ru.mvista.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, tnt@246tNt.com,
	linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Valentine Barshak wrote:
> Rework ohci-ppc-of driver to use big-endian property instead of
> ohci-be/ohci-le compatible strings. Also remove unnecessary
> user-selectable USB_OHCI_HCD_PPC_OF_LE/BE stuff, because
> USB_OHCI_BIG_ENDIAN_DESC/MMIO should always be enabled for ppc
> and USB_OHCI_LITTLE_ENDIAN is selected for USB_OHCI_HCD_PCI by default.
> 
> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> ---

[snip]

>  
>  config USB_UHCI_HCD
> diff -pruN linux-2.6.orig/drivers/usb/host/ohci-ppc-of.c linux-2.6/drivers/usb/host/ohci-ppc-of.c
> --- linux-2.6.orig/drivers/usb/host/ohci-ppc-of.c	2007-10-24 18:44:25.000000000 +0400
> +++ linux-2.6/drivers/usb/host/ohci-ppc-of.c	2007-10-24 19:32:21.000000000 +0400
> @@ -15,8 +15,8 @@
>  
>  #include <linux/signal.h>
>  
> -#include <asm/of_platform.h>
> -#include <asm/prom.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
>  
>  
>  static int __devinit
> @@ -91,15 +91,10 @@ ohci_hcd_ppc_of_probe(struct of_device *
>  	int irq;
>  
>  	int rv;
> -	int is_bigendian;
>  
>  	if (usb_disabled())
>  		return -ENODEV;
>  
> -	is_bigendian =
> -		of_device_is_compatible(dn, "ohci-bigendian") ||
> -		of_device_is_compatible(dn, "ohci-be");
> -
>  	dev_dbg(&op->dev, "initializing PPC-OF USB Controller\n");
>  
>  	rv = of_address_to_resource(dn, 0, &res);
> @@ -134,9 +129,10 @@ ohci_hcd_ppc_of_probe(struct of_device *
>  	}
>  
>  	ohci = hcd_to_ohci(hcd);
> -	if (is_bigendian) {
> +
> +	if (of_get_property(dn, "big-endian", NULL)) {
>  		ohci->flags |= OHCI_QUIRK_BE_MMIO | OHCI_QUIRK_BE_DESC;
> -		if (of_device_is_compatible(dn, "mpc5200-ohci"))
> +		if (of_device_is_compatible(dn, "mpc5200-usb-ohci"))
>  			ohci->flags |= OHCI_QUIRK_FRAME_NO;
>  	}

Just a note, this is a fairly destructive change and will stop the Efika
from having it's USB ports detected.

I've updated the Efika Device Tree Supplement script internally, but I
would really rather not have users be forced to update their kernel and
firmware quite so often just for what is, here, a merely aesthetic
change.

Can we just make sure real quickly that the changing of compatibles
doesn't break existing, not-easily-flashable firmwares?

At least work in 'mpc5200-ohci' for the endian check (it's always big
endian, but our device tree has no big-endian property by default and
does not contain mpc5200-usb-ohci or usb-ohci properties) otherwise we are
going to have users complain. To you guys.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

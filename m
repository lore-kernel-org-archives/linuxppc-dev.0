Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH/RFC] powerpc: Add of_platform support for OHCI/Bigendian HC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicolas DET <nd@bplan-gmbh.de>
In-Reply-To: <45490407.1010700@bplan-gmbh.de>
References: <45490407.1010700@bplan-gmbh.de>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 09:23:18 +1100
Message-Id: <1162419799.25682.466.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, sl@bplan-gmbh.de, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-11-01 at 21:31 +0100, Nicolas DET wrote:

> +/**+	ohci = hcd_to_ohci(hcd);
> +	ohci->flags |= OHCI_BIG_ENDIAN;
> +	ohci_hcd_init(ohci);

Bon, c'est pas mal. Le seul truc ici, c'est que je prefererais que
big-endian ne soit pas hard-code comme ca mais depende du device-tree.
Ce code doit pouvoir etre re-utilise pour des implementations
little-endian.

> +	retval = usb_add_hcd(hcd, irq, IRQF_DISABLED);
> +	if (retval == 0)
> +		return retval;

Pourquoi IRQF_DISABLED ?

> +module_init(ohci_hcd_ppc_of_init);
> +module_exit(ohci_hcd_ppc_of_cleanup);
> --- a/drivers/usb/host/Kconfig	2006-11-01 09:18:56.000000000 +0100
> +++ b/drivers/usb/host/Kconfig	2006-11-01 21:16:06.000000000 +0100
> @@ -106,6 +106,14 @@ config USB_OHCI_HCD_PPC_SOC
>  	  Enables support for the USB controller on the MPC52xx or
>  	  STB03xxx processor chip.  If unsure, say Y.
>  
> +config USB_OHCI_HCD_PPC_OF
> +	bool "OHCI support for PPC USB controller for OpenFirmware platform"
> +	depends on USB_OHCI_HCD && PPC_OF
> +	default y
> +	select USB_OHCI_BIG_ENDIAN
> +	---help---
> +	  Enables support for the USB controller PowerPC OpenFirmware platform
> +

Je prefererais que USB_OHCI_BIG_ENDIAN soit une option a choisir.

Ben.

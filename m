Return-Path: <tnt@246tNt.com>
Message-ID: <454D0E58.4010100@246tNt.com>
Date: Sat, 04 Nov 2006 23:04:08 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Nicolas DET <nd@bplan-gmbh.de>
Subject: Re: [PATCH/RFC] powerpc: Add of_platform support for	OHCI/Bigendian HC
References: <45490407.1010700@bplan-gmbh.de>		<1162419799.25682.466.camel@localhost.localdomain>	<1162423628.25682.489.camel@localhost.localdomain>
	<454A59CC.6070902@bplan-gmbh.de>
In-Reply-To: <454A59CC.6070902@bplan-gmbh.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org, sl@bplan-gmbh.de, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>
> ------------------------------------------------------------------------
> +
> +static struct of_device_id ohci_hcd_ppc_of_match_be[] = {
> +	{
> +		.name = "usb",
> +		.compatible = "ohci-bigendian",
> +	},
> +	{
> +		.name = "usb",
> +		.compatible = "ohci-be",
> +	},
> +	{},
> +};
>
> +
> +static struct of_device_id ohci_hcd_ppc_of_match_le[] = {
> +	{
> +		.name = "usb",
> +		.compatible = "ohci-littledian",
> +	},
> +	{
> +		.name = "usb",
> +		.compatible = "ohci-le",
> +	},
> +	{},
> +};
>   
Isn't it possible to specify "options" in the device tree rather than
different names ?
(just a though ...)
It's just duplicating all that code doesn't look nice.

> +config USB_OHCI_HCD_PPC_OF
> +	bool "OHCI support for PPC USB controller for OpenFirmware platform"
> +	depends on USB_OHCI_HCD && PPC_OF
> +	default y
> +	select USB_OHCI_BIG_ENDIAN
> +	select USB_OHCI_LITTLE_ENDIAN
> +	---help---
> +	  Enables support for the USB controller PowerPC OpenFirmware platform
> +
>   
I know what benh said but do we really want to select both all the
times. That adds
quite an overhead to the accesses ...

> --- a/drivers/usb/host/ohci-hcd.c	2006-11-01 09:18:56.000000000 +0100
> +++ b/drivers/usb/host/ohci-hcd.c	2006-11-02 18:06:02.000000000 +0100
> @@ -930,6 +930,12 @@ MODULE_LICENSE ("GPL");
>  #include "ohci-ppc-soc.c"
>  #endif
>  
> +#ifdef CONFIG_USB_OHCI_HCD_PPC_OF
> +#include "ohci-ppc-of.c"
> +#endif
> +
> +
> +
>  #if defined(CONFIG_ARCH_AT91RM9200) || defined(CONFIG_ARCH_AT91SAM9261)
>  #include "ohci-at91.c"
>  #endif
>   
Don't add space for nothing. All the #if #endif are space by one empty
line, keep it that way.


You also missed the last #if #end


#if !(defined(CONFIG_PCI) \
      || defined(CONFIG_SA1111) \
      || defined(CONFIG_ARCH_S3C2410) \
      || defined(CONFIG_ARCH_OMAP) \
      || defined (CONFIG_ARCH_LH7A404) \
      || defined (CONFIG_PXA27x) \
      || defined (CONFIG_ARCH_EP93XX) \
      || defined (CONFIG_SOC_AU1X00) \
      || defined (CONFIG_USB_OHCI_HCD_PPC_SOC) \
      || defined (CONFIG_ARCH_AT91RM9200) \
      || defined (CONFIG_ARCH_AT91SAM9261) \
      || defined (CONFIG_ARCH_PNX4008) \
        )
#error "missing bus glue for ohci-hcd"
#endif


You need to add a || defined(...) clause there.



    Sylvain

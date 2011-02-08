Return-Path: <sshtylyov@mvista.com>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B730BB711B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Feb 2011 05:29:30 +1100 (EST)
Received: by bwz10 with SMTP id 10so69288bwz.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 08 Feb 2011 10:29:25 -0800 (PST)
Message-ID: <4D518B2D.3090603@ru.mvista.com>
Date: Tue, 08 Feb 2011 21:27:57 +0300
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: tmarri@apm.com
Subject: Re: [PATCH V9 10/10] USB ppc4xx: Add Synopsys DWC OTG driver kernel
	configuration and Makefile
References: <1297119242-28562-1-git-send-email-tmarri@apm.com>
In-Reply-To: <1297119242-28562-1-git-send-email-tmarri@apm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Mark Miesfeld <mmiesfeld@apm.com>, greg@kroah.com,
	linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

tmarri@apm.com wrote:

> From: Tirumala Marri <tmarri@apm.com>

> Add Synopsys DesignWare HS USB OTG driver kernel configuration.
> Synopsys OTG driver may operate in  host only, device only, or OTG mode.
> The driver also allows user configure the core to use its internal DMA
> or Slave (PIO) mode.

> Signed-off-by: Tirumala R Marri <tmarri@apm.com>
> Signed-off-by: Fushen Chen <fchen@apm.com>
> Signed-off-by: Mark Miesfeld <mmiesfeld@apm.com>
[...]

> diff --git a/drivers/Makefile b/drivers/Makefile
> index 2cbb4b7..3bfc728 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -65,6 +65,7 @@ obj-$(CONFIG_PARIDE) 		+= block/paride/
>  obj-$(CONFIG_TC)		+= tc/
>  obj-$(CONFIG_UWB)		+= uwb/
>  obj-$(CONFIG_USB_OTG_UTILS)	+= usb/otg/
> +obj-$(CONFIG_USB_DWC_OTG)	+= usb/otg/dwc/

    Hardly a good place for this...

>  obj-$(CONFIG_USB)		+= usb/
>  obj-$(CONFIG_USB_MUSB_HDRC)	+= usb/musb/
>  obj-$(CONFIG_PCI)		+= usb/
> @@ -105,6 +106,7 @@ obj-$(CONFIG_ARCH_SHMOBILE)	+= sh/
>  ifndef CONFIG_ARCH_USES_GETTIMEOFFSET
>  obj-y				+= clocksource/
>  endif
> +obj-$(CONFIG_DMA_ENGINE)       += dma/

    How is this change related? Moreover, it's already present several lines ago 
in this file...

> diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
> index 41b6e51..887f702 100644
> --- a/drivers/usb/Kconfig
> +++ b/drivers/usb/Kconfig
> @@ -55,7 +55,6 @@ config USB_ARCH_HAS_OHCI
>  config USB_ARCH_HAS_EHCI
>  	boolean
>  	default y if PPC_83xx
> -	default y if PPC_MPC512x

    How is this change related?

> diff --git a/drivers/usb/otg/dwc/Kconfig b/drivers/usb/otg/dwc/Kconfig
> new file mode 100644
> index 0000000..4d33d72
> --- /dev/null
> +++ b/drivers/usb/otg/dwc/Kconfig
> @@ -0,0 +1,96 @@
> +#
> +# USB Dual Role (OTG-ready) Controller Drivers
> +# for silicon based on Synopsys DesignWare IP
> +#
> +
> +comment "Enable Host or Gadget support for DesignWare OTG controller"
> +	depends on !USB && USB_GADGET=n
> +
> +config USB_DWC_OTG
> +	depends on (USB || USB_GADGET)

    Parens not necessary.

> +	select NOP_USB_XCEIV
> +	select USB_OTG_UTILS
> +	tristate "Synopsys DWC OTG Controller"

    "tristate" should come before "depends" I think -- at least that's how 
everybody does...

> +	default USB_GADGET
> +	help
> +	  This driver provides USB Device Controller support for the
> +	  Synopsys DesignWare USB OTG Core used on the AppliedMicro PowerPC SoC.
[...]
> +choice
> +	prompt "DWC Mode Selection"
> +	depends on USB_DWC_OTG
> +	default DWC_HOST_ONLY
> +	help
> +	  Select the DWC Core in OTG, Host only, or Device only mode.
> +
> +config DWC_HOST_ONLY
> +	bool "DWC Host Only Mode"
> +
> +config DWC_OTG_MODE
> +	bool "DWC OTG Mode"
> +	select USB_GADGET_SELECTED
> +
> +config DWC_DEVICE_ONLY
> +	bool "DWC Device Only Mode"
> +	select USB_GADGET_SELECTED
> +
> +endchoice

    So this is tri-modal driver after all... how come we place it in 
drivers/usb/otg/dwc/, while the same tri-modal MUSB driver was placed in 
drivers/usb/musb/?

> +config USB_OTG_WHITELIST
> +	bool "Rely on OTG Targeted Peripherals List"
> +	depends on !USB_SUSPEND && USB_DWC_OTG
> +	default n
> +	help
> +	  This is the same flag as in ../core/Kconfig.
> +	  It is here for easy deselect.

    What?! Option duplication isn't allowed, I think.

> +config DWC_OTG_REG_LE
> +	depends on USB_DWC_OTG
> +	bool "DWC Little Endian Register"

    "bool" should come before "depends", I think.

> +	default y
> +	help
> +	  OTG core register access is Little-Endian.
> +
> +config DWC_OTG_FIFO_LE
> +	depends on USB_DWC_OTG
> +	bool "DWC FIFO Little Endian"

    Same here.

> +	default n
> +	help
> +	  OTG core FIFO access is Little-Endian.
> +
> +config DWC_LIMITED_XFER_SIZE
> +	depends on USB_GADGET_DWC_HDRC
> +	bool "DWC Endpoint Limited Xfer Size"

    ... and here.

> +	default n
> +	help
> +	  Bit fields in the Device EP Transfer Size Register is 11 bits.

    s/is/are/
    Also, such things should better be passed via the platform data, I think.

WBR, Sergei

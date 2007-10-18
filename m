Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.184])
	by ozlabs.org (Postfix) with ESMTP id DB0B0DDEBD
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 11:26:49 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so11256rvf
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 18:26:49 -0700 (PDT)
Message-ID: <fa686aa40710171826m232e2318l925f654de917b9a0@mail.gmail.com>
Date: Wed, 17 Oct 2007 19:26:48 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] commit e8f605cd71aa09a8f8b73f410a15d2a46022a60e
In-Reply-To: <20071017234100.7729.85901.stgit@trillian.cg.shawcable.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071017234100.7729.85901.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/17/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
>
> mpc8349emitx(gp): add UHCI and USB storage support

Oops, sorry about the subject line; I kind of messed that up in stgit.

g.


>
>     USB support for the 8349itx got added a while back; but the defconfig
>     never got updated.  This patch adds the appropriate USB config options
>     to defconfig
>
>     Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>     CC: Scott Wood <scottwood@freescale.com>
>     CC: Kumar Gala <galak@kernel.crashing.org>
>     CC: Timur Tabi <timur@freescale.com>
> ---
>
>  arch/powerpc/configs/mpc834x_itx_defconfig   |    2 -
>  arch/powerpc/configs/mpc834x_itxgp_defconfig |   88 ++++++++++++++++++++++++++
>  2 files changed, 88 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/configs/mpc834x_itx_defconfig b/arch/powerpc/configs/mpc834x_itx_defconfig
> index eb28dd8..ba512d1 100644
> --- a/arch/powerpc/configs/mpc834x_itx_defconfig
> +++ b/arch/powerpc/configs/mpc834x_itx_defconfig
> @@ -867,7 +867,7 @@ CONFIG_USB_EHCI_ROOT_HUB_TT=y
>  CONFIG_USB_EHCI_FSL=y
>  # CONFIG_USB_ISP116X_HCD is not set
>  # CONFIG_USB_OHCI_HCD is not set
> -# CONFIG_USB_UHCI_HCD is not set
> +CONFIG_USB_UHCI_HCD=y
>  # CONFIG_USB_SL811_HCD is not set
>  # CONFIG_USB_R8A66597_HCD is not set
>
> diff --git a/arch/powerpc/configs/mpc834x_itxgp_defconfig b/arch/powerpc/configs/mpc834x_itxgp_defconfig
> index 22b9546..9faa948 100644
> --- a/arch/powerpc/configs/mpc834x_itxgp_defconfig
> +++ b/arch/powerpc/configs/mpc834x_itxgp_defconfig
> @@ -760,15 +760,101 @@ CONFIG_USB_SUPPORT=y
>  CONFIG_USB_ARCH_HAS_HCD=y
>  CONFIG_USB_ARCH_HAS_OHCI=y
>  CONFIG_USB_ARCH_HAS_EHCI=y
> -# CONFIG_USB is not set
> +CONFIG_USB=y
> +# CONFIG_USB_DEBUG is not set
> +
> +#
> +# Miscellaneous USB options
> +#
> +# CONFIG_USB_DEVICEFS is not set
> +CONFIG_USB_DEVICE_CLASS=y
> +# CONFIG_USB_DYNAMIC_MINORS is not set
> +# CONFIG_USB_OTG is not set
> +
> +#
> +# USB Host Controller Drivers
> +#
> +CONFIG_USB_EHCI_HCD=y
> +# CONFIG_USB_EHCI_SPLIT_ISO is not set
>  CONFIG_USB_EHCI_ROOT_HUB_TT=y
> +# CONFIG_USB_EHCI_TT_NEWSCHED is not set
>  CONFIG_USB_EHCI_FSL=y
> +# CONFIG_USB_ISP116X_HCD is not set
> +# CONFIG_USB_OHCI_HCD is not set
> +CONFIG_USB_UHCI_HCD=y
> +# CONFIG_USB_SL811_HCD is not set
> +# CONFIG_USB_R8A66597_HCD is not set
> +
> +#
> +# USB Device Class drivers
> +#
> +# CONFIG_USB_ACM is not set
> +# CONFIG_USB_PRINTER is not set
>
>  #
>  # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
>  #
>
>  #
> +# may also be needed; see USB_STORAGE Help for more information
> +#
> +CONFIG_USB_STORAGE=y
> +# CONFIG_USB_STORAGE_DEBUG is not set
> +# CONFIG_USB_STORAGE_DATAFAB is not set
> +# CONFIG_USB_STORAGE_FREECOM is not set
> +# CONFIG_USB_STORAGE_DPCM is not set
> +# CONFIG_USB_STORAGE_USBAT is not set
> +# CONFIG_USB_STORAGE_SDDR09 is not set
> +# CONFIG_USB_STORAGE_SDDR55 is not set
> +# CONFIG_USB_STORAGE_JUMPSHOT is not set
> +# CONFIG_USB_STORAGE_ALAUDA is not set
> +# CONFIG_USB_STORAGE_KARMA is not set
> +# CONFIG_USB_LIBUSUAL is not set
> +
> +#
> +# USB Imaging devices
> +#
> +# CONFIG_USB_MDC800 is not set
> +# CONFIG_USB_MICROTEK is not set
> +CONFIG_USB_MON=y
> +
> +#
> +# USB port drivers
> +#
> +
> +#
> +# USB Serial Converter support
> +#
> +# CONFIG_USB_SERIAL is not set
> +
> +#
> +# USB Miscellaneous drivers
> +#
> +# CONFIG_USB_EMI62 is not set
> +# CONFIG_USB_EMI26 is not set
> +# CONFIG_USB_ADUTUX is not set
> +# CONFIG_USB_AUERSWALD is not set
> +# CONFIG_USB_RIO500 is not set
> +# CONFIG_USB_LEGOTOWER is not set
> +# CONFIG_USB_LCD is not set
> +# CONFIG_USB_BERRY_CHARGE is not set
> +# CONFIG_USB_LED is not set
> +# CONFIG_USB_CYPRESS_CY7C63 is not set
> +# CONFIG_USB_CYTHERM is not set
> +# CONFIG_USB_PHIDGET is not set
> +# CONFIG_USB_IDMOUSE is not set
> +# CONFIG_USB_FTDI_ELAN is not set
> +# CONFIG_USB_APPLEDISPLAY is not set
> +# CONFIG_USB_SISUSBVGA is not set
> +# CONFIG_USB_LD is not set
> +# CONFIG_USB_TRANCEVIBRATOR is not set
> +# CONFIG_USB_IOWARRIOR is not set
> +
> +#
> +# USB DSL modem support
> +#
> +
> +#
>  # USB Gadget Support
>  #
>  # CONFIG_USB_GADGET is not set
>
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195

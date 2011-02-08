Return-Path: <sshtylyov@mvista.com>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 59028B7043
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Feb 2011 23:46:06 +1100 (EST)
Received: by bwz10 with SMTP id 10so5986296bwz.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 08 Feb 2011 04:46:01 -0800 (PST)
Message-ID: <4D513ABE.1030700@ru.mvista.com>
Date: Tue, 08 Feb 2011 15:44:46 +0300
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: tmarri@apm.com
Subject: Re: [PATCH V9 09/10] USB/ppc4xx:Synopsys DWC OTG driver enable gadget
	support
References: <1297119240-28531-1-git-send-email-tmarri@apm.com>
In-Reply-To: <1297119240-28531-1-git-send-email-tmarri@apm.com>
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

On 08.02.2011 1:54, tmarri@apm.com wrote:

> From: Tirumala Marri<tmarri@apm.com>

> Enable gadget support

> Signed-off-by: Tirumala R Marri<tmarri@apm.com>
> Signed-off-by: Fushen Chen<fchen@apm.com>
> Signed-off-by: Mark Miesfeld<mmiesfeld@apm.com>
> ---
>   drivers/usb/gadget/Kconfig        |   22 ++++++++++++++++++++++
>   drivers/usb/gadget/gadget_chips.h |    9 +++++++++
>   2 files changed, 31 insertions(+), 0 deletions(-)

> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index 5df8a8d..de7c10b 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -365,6 +365,28 @@ config USB_GADGET_MUSB_HDRC
>   	  This OTG-capable silicon IP is used in dual designs including
>   	  the TI DaVinci, OMAP 243x, OMAP 343x, TUSB 6010, and ADI Blackfin
>
> +# dwc_otg builds in ../dwc_otg along with host support
> +config USB_GADGET_DWC_HDRC
> +	boolean "DesignWare USB Peripheral"
> +	depends on DWC_OTG_MODE || DWC_DEVICE_ONLY

    Patch 10 should precede this one as it defines DWC_OTG_MODE and 
DWC_DEVICE_ONLY.

> +	select USB_GADGET_DUALSPEED
> +	select USB_GADGET_SELECTED
> +	select USB_GADGET_DWC_OTG
> +	help
> +	This OTG-capable Designware USB IP
> +
> +config USB_GADGET_DWC_OTG
> +	boolean "OTG Support"
> +	depends on USB_GADGET_DWC_HDRC

    What's the point of this option if it gets auto-selected by 
USB_GADGET_DWC_HDRC anyway?

WBR, Sergei

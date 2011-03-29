Return-Path: <sshtylyov@mvista.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 31CE5B6F12
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Mar 2011 22:55:02 +1100 (EST)
Received: by wwi36 with SMTP id 36so70839wwi.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Mar 2011 04:54:57 -0700 (PDT)
Message-ID: <4D91C834.3050104@ru.mvista.com>
Date: Tue, 29 Mar 2011 15:53:24 +0400
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: tmarri@apm.com
Subject: Re: [PATCH v10 09/10] USB/ppc4xx:Synopsys DWC OTG driver enable gadget
	support
References: <1301336892-2268-1-git-send-email-tmarri@apm.com>
In-Reply-To: <1301336892-2268-1-git-send-email-tmarri@apm.com>
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

On 28-03-2011 22:28, tmarri@apm.com wrote:

> From: Tirumala Marri <tmarri@apm.com>

> Enable gadget support

> Signed-off-by: Tirumala R Marri <tmarri@apm.com>
> Signed-off-by: Fushen Chen <fchen@apm.com>
> Signed-off-by: Mark Miesfeld <mmiesfeld@apm.com>
[...]

> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index bc5123c..61aca75 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -365,6 +365,28 @@ config USB_GADGET_MUSB_HDRC
>   	  This OTG-capable silicon IP is used in dual designs including
>   	  the TI DaVinci, OMAP 243x, OMAP 343x, TUSB 6010, and ADI Blackfin
>
> +# dwc_otg builds in ../dwc_otg along with host support

    There's no ../dwc_otg any longer.

> +config USB_GADGET_DWC_HDRC
> +	boolean "DesignWare USB Peripheral"
> +	depends on DWC_OTG_MODE || DWC_DEVICE_ONLY
> +	select USB_GADGET_DUALSPEED
> +	select USB_GADGET_SELECTED
> +	select USB_GADGET_DWC_OTG
> +	help
> +	This OTG-capable Designware USB IP
> +
> +config USB_GADGET_DWC_OTG
> +	boolean "OTG Support"
> +	depends on USB_GADGET_DWC_HDRC

    Not on DWC_OTG_MODE? How this option is different from DWC_OTG_MODE?

> +	help
> +	The most notable feature of USB OTG is support for a
> +	"Dual-Role" device, which can act as either a device
> +	or a host.  The initial role choice can be changed
> +	later, when two dual-role devices talk to each other.
> +	Select this only if your board has a Mini-AB connector.
> +
> +
> +

     Too many empty lines.

>   config USB_GADGET_M66592
>   	boolean "Renesas M66592 USB Peripheral Controller"
>   	select USB_GADGET_DUALSPEED

WBR, Sergei

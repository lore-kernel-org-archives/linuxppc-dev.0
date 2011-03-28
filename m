Return-Path: <randy.dunlap@oracle.com>
Received: from rcsinet14.oracle.com (rcsinet14.oracle.com [148.87.113.126])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "rcsinet14.oracle.com",
	Issuer "VeriSign Trust Network" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AD94AB6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Mar 2011 06:45:13 +1100 (EST)
Received: from rcsinet10.oracle.com (rcsinet10.oracle.com [148.87.113.121])
	by rcsinet14.oracle.com (Switch-3.4.2/Switch-3.4.1) with ESMTP id
	p2SJ2ki0003575
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Mar 2011 19:02:46 GMT
Date: Mon, 28 Mar 2011 12:02:30 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: tmarri@apm.com
Subject: Re: [PATCH v10 09/10] USB/ppc4xx:Synopsys DWC OTG driver enable
	gadget support
Message-Id: <20110328120230.9e15eaca.randy.dunlap@oracle.com>
In-Reply-To: <1301336892-2268-1-git-send-email-tmarri@apm.com>
References: <1301336892-2268-1-git-send-email-tmarri@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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


> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index bc5123c..61aca75 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -365,6 +365,28 @@ config USB_GADGET_MUSB_HDRC
>  	  This OTG-capable silicon IP is used in dual designs including
>  	  the TI DaVinci, OMAP 243x, OMAP 343x, TUSB 6010, and ADI Blackfin
>  
> +# dwc_otg builds in ../dwc_otg along with host support
> +config USB_GADGET_DWC_HDRC
> +	boolean "DesignWare USB Peripheral"
> +	depends on DWC_OTG_MODE || DWC_DEVICE_ONLY
> +	select USB_GADGET_DUALSPEED
> +	select USB_GADGET_SELECTED
> +	select USB_GADGET_DWC_OTG
> +	help
> +	This OTG-capable Designware USB IP

missing complete help text.

> +
> +config USB_GADGET_DWC_OTG
> +	boolean "OTG Support"
> +	depends on USB_GADGET_DWC_HDRC
> +	help
> +	The most notable feature of USB OTG is support for a
> +	"Dual-Role" device, which can act as either a device
> +	or a host.  The initial role choice can be changed
> +	later, when two dual-role devices talk to each other.
> +	Select this only if your board has a Mini-AB connector.
> +
> +
> +
>  config USB_GADGET_M66592
>  	boolean "Renesas M66592 USB Peripheral Controller"
>  	select USB_GADGET_DUALSPEED


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***

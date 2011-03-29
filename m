Return-Path: <sshtylyov@mvista.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 89CEBB6F06
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Mar 2011 23:03:26 +1100 (EST)
Received: by wwi36 with SMTP id 36so77653wwi.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Mar 2011 05:03:20 -0700 (PDT)
Message-ID: <4D91CA2B.9080307@ru.mvista.com>
Date: Tue, 29 Mar 2011 16:01:47 +0400
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: tmarri@apm.com
Subject: Re: [PATCH v10 10/10] USB ppc4xx: Add Synopsys DWC OTG driver kernel
	configuration and Makefile
References: <1301336896-2300-1-git-send-email-tmarri@apm.com>
In-Reply-To: <1301336896-2300-1-git-send-email-tmarri@apm.com>
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

> Add Synopsys DesignWare HS USB OTG driver kernel configuration.
> Synopsys OTG driver may operate in  host only, device only, or OTG mode.
> The driver also allows user configure the core to use its internal DMA
> or Slave (PIO) mode.

> Signed-off-by: Tirumala R Marri <tmarri@apm.com>
> Signed-off-by: Fushen Chen <fchen@apm.com>
> Signed-off-by: Mark Miesfeld <mmiesfeld@apm.com>

    This patch should precede patch 9 as patch 9 uses config. options defined 
here.

> diff --git a/drivers/usb/otg/dwc/Kconfig b/drivers/usb/otg/dwc/Kconfig
> new file mode 100644
> index 0000000..a8f22cb
> --- /dev/null
> +++ b/drivers/usb/otg/dwc/Kconfig
> @@ -0,0 +1,88 @@
> +#
> +# USB Dual Role (OTG-ready) Controller Drivers
> +# for silicon based on Synopsys DesignWare IP
> +#
[...]
> +# enable peripheral support (including with OTG)
> +config USB_GADGET_DWC_HDRC
> +	bool
> +	depends on USB_DWC_OTG && (DWC_DEVICE_ONLY || USB_DWC_OTG)

    Haven't we just defined this in patch 9? Redefinition of options isn't 
correct.

> +config DWC_OTG_REG_LE
> +	bool "DWC Little Endian Register"

    This should preferrably be passed via the platform data, I think.

> +	depends on USB_DWC_OTG
> +	default y
> +	help
> +	  OTG core register access is Little-Endian.
> +
> +config DWC_OTG_FIFO_LE
> +	bool "DWC FIFO Little Endian"

    This too.

> +	depends on USB_DWC_OTG
> +	default n

    "default n" not needed.

> +	help
> +	  OTG core FIFO access is Little-Endian.

    Little endian registers and big endian FIFO by default?

> +
> +config DWC_LIMITED_XFER_SIZE
> +	bool "DWC Endpoint Limited Xfer Size"
> +	depends on USB_GADGET_DWC_HDRC
> +	default n

    Not needed.

> +	help
> +	  Bit fields in the Device EP Transfer Size Register is 11 bits.

WBR, Sergei

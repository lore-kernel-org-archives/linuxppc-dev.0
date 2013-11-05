Return-Path: <stern+5260885c@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
 by ozlabs.org (Postfix) with SMTP id 169CA2C008F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Nov 2013 02:10:45 +1100 (EST)
Date: Tue, 5 Nov 2013 10:04:02 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Alistair Popple <alistair@popple.id.au>
Subject: Re: [PATCH 4/7] IBM Akebono: Add support to the OHCI platform driver
 for Akebono
In-Reply-To: <1383629471-16979-4-git-send-email-alistair@popple.id.au>
Message-ID: <Pine.LNX.4.44L0.1311051002131.1360-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 5 Nov 2013, Alistair Popple wrote:

> The IBM Akebono board has a OHCI compliant USB host interface. This
> patch adds support for it to the OHCI platform driver.
> 
> As we use device tree to pass platform specific data instead of
> platform data we remove the check for platform data and instead
> provide reasonable defaults if no platform data is present. This is
> similar to what is currently done in ehci-platform.c.
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: linux-usb@vger.kernel.org
> ---
>  drivers/usb/host/ohci-platform.c |   20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
> index a4c6410..4331454 100644
> --- a/drivers/usb/host/ohci-platform.c
> +++ b/drivers/usb/host/ohci-platform.c
> @@ -23,6 +23,8 @@
>  #include <linux/usb/ohci_pdriver.h>
>  #include <linux/usb.h>
>  #include <linux/usb/hcd.h>
> +#include <linux/slab.h>
> +#include <linux/of.h>
>  
>  #include "ohci.h"
>  
> @@ -55,6 +57,8 @@ static const struct ohci_driver_overrides platform_overrides __initconst = {
>  	.reset =	ohci_platform_reset,
>  };
>  
> +static struct usb_ohci_pdata ohci_platform_defaults;
> +
>  static int ohci_platform_probe(struct platform_device *dev)
>  {
>  	struct usb_hcd *hcd;
> @@ -63,14 +67,14 @@ static int ohci_platform_probe(struct platform_device *dev)
>  	int irq;
>  	int err = -ENOMEM;
>  
> -	if (!pdata) {
> -		WARN_ON(1);
> -		return -ENODEV;
> -	}
> -
>  	if (usb_disabled())
>  		return -ENODEV;
>  
> +	/* Platforms using DT don't always provide platform data.
> +	 * This should provide reasonable defaults. */

	/*
	 * The accepted format for multi-line
	 * comments is like this.
	 */

> +	if (!pdata)
> +		dev->dev.platform_data = pdata = &ohci_platform_defaults;
> +
>  	irq = platform_get_irq(dev, 0);
>  	if (irq < 0) {
>  		dev_err(&dev->dev, "no irq provided");
> @@ -171,6 +175,11 @@ static int ohci_platform_resume(struct device *dev)
>  #define ohci_platform_resume	NULL
>  #endif /* CONFIG_PM */
>  
> +static const struct of_device_id ohci_of_match[] = {
> +	{ .compatible = "ibm,akebono-ohci", },
> +	{},
> +};
> +
>  static const struct platform_device_id ohci_platform_table[] = {
>  	{ "ohci-platform", 0 },
>  	{ }
> @@ -191,6 +200,7 @@ static struct platform_driver ohci_platform_driver = {
>  		.owner	= THIS_MODULE,
>  		.name	= "ohci-platform",
>  		.pm	= &ohci_platform_pm_ops,
> +		.of_match_table = ohci_of_match,
>  	}
>  };

Update the comment formatting, and then you can resubmit with

Acked-by: Alan Stern <stern@rowland.harvard.edu>

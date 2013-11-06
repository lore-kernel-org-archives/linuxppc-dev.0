Return-Path: <stern+5260885c@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
 by ozlabs.org (Postfix) with SMTP id 9386E2C00CC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2013 03:14:48 +1100 (EST)
Date: Wed, 6 Nov 2013 11:14:44 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Alistair Popple <alistair@popple.id.au>
Subject: Re: [RFC PATCH] ehci-platform: Merge ppc-of EHCI driver into the
 ehci-platform driver
In-Reply-To: <1690980.YlPWToa1rW@mexican>
Message-ID: <Pine.LNX.4.44L0.1311061110310.1220-100000@iolanthe.rowland.org>
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

On Wed, 6 Nov 2013, Alistair Popple wrote:

> Currently the ppc-of driver uses the compatibility string
> "usb-ehci". This means platforms that use device-tree and implement an
> EHCI compatible interface have to either use the ppc-of driver or add
> a compatible line to the ehci-platform driver. It would be more
> appropriate for the platform driver to be compatible with "usb-ehci"
> as non-powerpc platforms are also beginning to utilise device-tree.
> 
> This patch merges the device tree property parsing from ehci-ppc-of
> into the platform driver and adds a "usb-ehci" compatibility
> string. The existing ehci-ppc-of driver is renamed to ehci-440epx as
> it contains platform specific work arounds for the 440EPX SoC.
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> ---
> 
> So I could submit something like this that essentially merges the ppc-of 
> driver into the platform driver instead of adding the "ibm,akebono-ehci" 
> compatible line to the platform driver.
> 
> However I'm still fairly new to device-tree so I'm not sure what (if any) the 
> broader impact would be. A quick grep for "usb-ehci" turned up a couple of ARM 
> device tree's using it however they all provided their own drivers and don't 
> select CONFIG_USB_EHCI_HCD_PLATFORM so I'm guess they shouldn't be impacted.
> 
> I have attempted to fix up any PowerPC device trees/configs, although I wasn't 
> sure if "usb-ehci" should remain in sequoia.dts or not given that it needs to 
> use the 440EPX specific driver.
> 
> Also this hasn't been tested (beyond compilation) yet.

> diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-
> platform.c
> index f6b790c..027f368 100644
> --- a/drivers/usb/host/ehci-platform.c
> +++ b/drivers/usb/host/ehci-platform.c
> @@ -77,6 +77,7 @@ static int ehci_platform_probe(struct platform_device *dev)
>  	struct usb_hcd *hcd;
>  	struct resource *res_mem;
>  	struct usb_ehci_pdata *pdata;
> +	struct device_node *dn = dev->dev.of_node;
>  	int irq;
>  	int err = -ENOMEM;
>  
> @@ -96,6 +97,18 @@ static int ehci_platform_probe(struct platform_device *dev)
>  
>  	pdata = dev_get_platdata(&dev->dev);
>  
> +	/* Initialise platform data from device tree if available. */
> +	if (!dn) {

Shouldn't this be "if (dn)"?

> +		if (of_get_property(dn, "big-endian", NULL)) {
> +			pdata->big_endian_mmio = 1;
> +			pdata->big_endian_desc = 1;
> +		}
> +		if (of_get_property(dn, "big-endian-regs", NULL))
> +			pdata->big_endian_mmio = 1;
> +		if (of_get_property(dn, "big-endian-desc", NULL))
> +			pdata->big_endian_desc = 1;
> +	}
> +

This isn't good if there is more than one EHCI controller using 
ehci-platform.  To accomodate such cases, it would be necessary to 
allocate a separate copy of ehci_platform_defaults for each controller.

Alan Stern

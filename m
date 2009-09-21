Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BE38EB70B3
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Sep 2009 20:24:09 +1000 (EST)
Subject: Re: [PATCH] USB: Add support for Xilinx USB host controller
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Julie Zhu <julie.zhu@xilinx.com>
In-Reply-To: <20090915221050.0DA0F2C005E@mail34-va3.bigfish.com>
References: <20090915221050.0DA0F2C005E@mail34-va3.bigfish.com>
Content-Type: text/plain
Date: Mon, 21 Sep 2009 20:23:52 +1000
Message-Id: <1253528632.7103.138.camel@pasglop>
Mime-Version: 1.0
Cc: linux-usb@vger.kernel.org, gregkh@suse.de, juliez@xilinx.com,
	linuxppc-dev@ozlabs.org, john.linn@xilinx.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-09-15 at 16:10 -0600, Julie Zhu wrote:
> Add bus glue driver for Xilinx USB host controller. The controller can be
> configured as HS only or HS/FS hybrid. The driver uses the device tree file
> to configure the driver according to the setting in the hardware system.
> 
> This driver has been tested with usbtest using the NET2280 PCI card.
> 
> Signed-off-by: Julie Zhu <julie.zhu@xilinx.com>

Hi !

First, this is a very clean piece of code, thanks.

Just a few minor nits:

> static int ehci_xilinx_port_handed_over(struct usb_hcd *hcd, int portnum)
> +{
> +	dev_warn(hcd->self.controller, "port %d cannot be enabled\n", portnum);
> +	if (hcd->has_tt) {
> +		dev_warn(hcd->self.controller,
> +			"Maybe you have connected an LS device?\n");
> +
> +		dev_warn(hcd->self.controller,
> +			"We do not support LS devices\n");
> +	} else {
> +		dev_warn(hcd->self.controller,
> +			"Maybe your device is not an HS device?\n");
> +		dev_warn(hcd->self.controller,
> +			"The USB host controller does not support FS or "
> +			"LS devices\n");
> +		dev_warn(hcd->self.controller,
> +			"You can reconfigure the host controller to have "
> +			"FS support\n");
> +	}
> +
> +	return 0;
> +}

I'm not sure the final users would know what "FS", "LS" or "HS" mean
here, it might be worth being a -tad- more verbose :-)

 .../...

> +
> +/**
> + * ehci_hcd_xilinx_of_remove - shutdown hcd and release resources
> + * @op:		pointer to of_device structure that is to be removed
> + *
> + * Remove the hcd structure, and release resources that has been requested
> + * during probe.
> + */
> +static int ehci_hcd_xilinx_of_remove(struct of_device *op)
> +{
> +	struct usb_hcd *hcd = dev_get_drvdata(&op->dev);
> +	dev_set_drvdata(&op->dev, NULL);
> +
> +	dev_dbg(&op->dev, "stopping XILINX-OF USB Controller\n");
> +
> +	usb_remove_hcd(hcd);
> +
> +	iounmap(hcd->regs);
> +	irq_dispose_mapping(hcd->irq);

You don't need to dispose of the irq mapping, and in fact, it could be
harmful if the interrupt is shared, as we don't refcount the mapping
users. Just remove the line above. The mapping doesn't really use
resources (well, it depends on your PIC but even then, it's minor) so
it's better, once a HW IRQ number has been associated to a linux IRQ
number, to keep that association for the lifetime of the kernel.

Cheers,
Ben.

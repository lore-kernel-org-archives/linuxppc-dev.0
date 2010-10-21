Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from www.etchedpixels.co.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 08CDEB70A7
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Oct 2010 20:13:08 +1100 (EST)
Date: Thu, 21 Oct 2010 10:12:03 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Fushen Chen <fchen@apm.com>
Subject: Re: [PATCH V5 2/9] Add Synopsys DesignWare HS USB OTG driver
	framework.
Message-ID: <20101021101203.00009b1b@lxorguk.ukuu.org.uk>
In-Reply-To: <1287621774425-git-send-email-fchen@apm.com>
References: <12876217721253-git-send-email-fchen@apm.com>
	<1287621773567-git-send-email-fchen@apm.com>
	<1287621774425-git-send-email-fchen@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org,
	Mark Miesfeld <mmiesfeld@apm.com>, gregkh@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +	int retval = IRQ_NONE;
> +
> +	retval = dwc_otg_handle_common_intr(dwc_dev->core_if);
> +	return IRQ_RETVAL(retval);

Why assign retval first ?

> +}
> +
> +/**
> + * This function is the interrupt handler for the OverCurrent condition
> + * from the external charge pump (if enabled)
> + */
> +static irqreturn_t dwc_otg_externalchgpump_irq(int _irq, void *dev)
> +{
> +	struct dwc_otg_device *dwc_dev = dev;
> +
> +	if (dwc_otg_is_host_mode(dwc_dev->core_if)) {
> +		struct dwc_hcd *dwc_hcd;
> +		union hprt0_data hprt0 = {.d32 = 0};
> +
> +		dwc_hcd = dwc_dev->hcd;
> +		spin_lock(&dwc_hcd->lock);
> +		dwc_hcd->flags.b.port_over_current_change = 1;
> +
> +		hprt0.b.prtpwr = 0;
> +		dwc_write_reg32(dwc_dev->core_if->host_if->hprt0,
> +				hprt0.d32);
> +		spin_unlock(&dwc_hcd->lock);
> +	} else {
> +		/* Device mode - This int is n/a for device mode */
> +		printk(KERN_ERR "DeviceMode: OTG OverCurrent Detected\n");

Use dev_err



> +	if (of_address_to_resource(ofdev->dev.of_node, 0, &res)) {
> +		printk(KERN_ERR "%s: Can't get USB-OTG register address\n",
> +			__func__);

dev_err

> +		retval = -ENOMEM;
> +		goto fail;
> +	}
> +	dev_dbg(dev, "OTG - ioresource_mem start0x%08x: end:0x%08x\n",
> +			(u32)res.start, (u32)res.end);

Why not print these with the proper types ?


> +	 * Install the interrupt handler for the common interrupts before
> +	 * enabling common interrupts in core_init below.
> +	 */
> +	retval = request_irq(dwc_dev->irq, dwc_otg_common_irq,
> +			IRQF_SHARED, "dwc_otg", dwc_dev);

What if there is an IRQ pending - you've enabled the IRQ handler before
the otg core - is that safe ?



The module options also seems a bit excessive. Is there a reason this
can't just set by the various board platform devices ?

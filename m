Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id ACE79B7B88
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Sep 2009 12:30:05 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n8P2U1A5013770
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2009 19:30:02 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n8P2VuRK020239
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2009 21:31:56 -0500 (CDT)
Date: Thu, 24 Sep 2009 21:30:01 -0500
From: Scott Wood <scottwood@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 3/3] USB: ehci-fsl: Add power management support (resume
	after deep sleep)
Message-ID: <20090925023000.GA22457@b07421-ec1.am.freescale.net>
References: <20090923185158.GA29065@oksana.dev.rtsoft.ru>
	<20090923185244.GC18755@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090923185244.GC18755@oksana.dev.rtsoft.ru>
Cc: linux-usb@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>,
	Greg Kroah-Hartman <gregkh@suse.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 23, 2009 at 10:52:44PM +0400, Anton Vorontsov wrote:
+#ifdef CONFIG_SUSPEND
+struct ehci_fsl {
+       struct ehci_hcd ehci;
+
+       /* Saved USB PHY settings, need to restore after deep sleep. */
+       u32 usb_ctrl;
+};

This doesn't seem like the right place to define this... what if we later
need something else that isn't for suspend?  And you could get rid of
EHCI_FSL_PRIV_SIZE.

> +static int ehci_fsl_drv_suspend(struct device *dev)
> +{
> +	struct usb_hcd *hcd = dev_get_drvdata(dev);
> +	struct ehci_fsl *ehci_fsl = hcd_to_ehci_fsl(hcd);
> +	void __iomem *non_ehci = hcd->regs;
> +
> +	if (!fsl_deep_sleep())
> +		return 0;

We'll also need to do this if we support suspend to disk...  is there any
good way for the driver to determine that that's what's being done?  Or
more generally, for the platform to communicate to the drivers which ones
are going to lose state without one-off hacks like fsl_deep_sleep().

> +	/* Power up ports (avoids devices disconnect). */
> +	port_nm = HCS_N_PORTS(ehci->hcs_params);
> +	while (port_nm--) {
> +		u32 port_sc;
> +
> +		port_sc = ehci_readl(ehci, &ehci->regs->port_status[port_nm]);
> +		port_sc |= PORT_POWER;
> +		ehci_writel(ehci, port_sc, &ehci->regs->port_status[port_nm]);
> +	}
> +	mdelay(30);

Instead of mdelay, can we somehow hold off any USB operations for a
while?

-Scott

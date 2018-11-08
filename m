Return-Path: <SRS0=TQYx=NT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D74BC43441
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 22:17:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1F4020883
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 22:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAsVnCWo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1F4020883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rd1m6y90zF3Vb
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 09:17:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kAsVnCWo";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=nc3z=nt=linuxfoundation.org=gregkh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="kAsVnCWo"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rcxQ0wt1zF3Tv
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2018 09:13:25 +1100 (AEDT)
Received: from localhost (unknown [208.72.13.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B8BC32081D;
 Thu,  8 Nov 2018 22:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1541715203;
 bh=5M1VOJvvYq/OFBB6DLvzqTe/U/E4V5r3oHEXRB0cirs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kAsVnCWoH6o97XE5zky7RNUtHzAM+q7p8Xk6zToloxMoN22gKc12xZl/4ziYxKpIY
 M+38sAObudf0apph6LAK5mTgGtU5+rndGSFJZVYSQpKWma58Hpd/qkOEMIUwYxHYRB
 tykMNQGmui/QlSdJlZzw0efOTUXdFhQ4ph4Kwusc=
Date: Thu, 8 Nov 2018 14:01:17 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Message-ID: <20181108220117.GA11466@kroah.com>
References: <20180918221501.13112-1-mr.nuke.me@gmail.com>
 <20181107234257.GC41183@google.com>
 <20181108200855.GE41183@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108200855.GE41183@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: alex_gagniuc@dellteam.com, Sam Bobroff <sbobroff@linux.ibm.com>,
 linux-pci@vger.kernel.org, shyam_iyer@dell.com, linux-kernel@vger.kernel.org,
 keith.busch@intel.com, Lukas Wunner <lukas@wunner.de>,
 Oliver O'Halloran <oohall@gmail.com>, Alexandru Gagniuc <mr.nuke.me@gmail.com>,
 austin_bolen@dell.com, linuxppc-dev@lists.ozlabs.org,
 Jonathan Derrick <jonathan.derrick@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Nov 08, 2018 at 02:09:17PM -0600, Bjorn Helgaas wrote:
> [+cc Jonathan, Greg, Lukas, Russell, Sam, Oliver for discussion about
> PCI error recovery in general]
> 
> On Wed, Nov 07, 2018 at 05:42:57PM -0600, Bjorn Helgaas wrote:
> > On Tue, Sep 18, 2018 at 05:15:00PM -0500, Alexandru Gagniuc wrote:
> > > When a PCI device is gone, we don't want to send IO to it if we can
> > > avoid it. We expose functionality via the irq_chip structure. As
> > > users of that structure may not know about the underlying PCI device,
> > > it's our responsibility to guard against removed devices.
> > > 
> > > .irq_write_msi_msg() is already guarded inside __pci_write_msi_msg().
> > > .irq_mask/unmask() are not. Guard them for completeness.
> > > 
> > > For example, surprise removal of a PCIe device triggers teardown. This
> > > touches the irq_chips ops some point to disable the interrupts. I/O
> > > generated here can crash the system on firmware-first machines.
> > > Not triggering the IO in the first place greatly reduces the
> > > possibility of the problem occurring.
> > > 
> > > Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> > 
> > Applied to pci/misc for v4.21, thanks!
> 
> I'm having second thoughts about this.  One thing I'm uncomfortable
> with is that sprinkling pci_dev_is_disconnected() around feels ad hoc
> instead of systematic, in the sense that I don't know how we convince
> ourselves that this (and only this) is the correct place to put it.

I think my stance always has been that this call is not good at all
because once you call it you never really know if it is still true as
the device could have been removed right afterward.

So almost any code that relies on it is broken, there is no locking and
it can and will race and you will loose.

I think your patch suffers from this race:

> +static u32 mmio_readl(struct pci_dev *dev, const volatile void __iomem *addr)
> +{
> +	u32 val, id;
> +
> +	if (pci_dev_is_disconnected(dev))
> +		return ~0;

Great, but what happens if I yank the device out right here?

> +	val = readl(addr);

This value could now be all FF, if the device is gone, so what did the
check above help with?

> +	/*
> +	 * If an MMIO read from the device returns ~0 data, that data may
> +	 * be valid, or it may indicate a bus error.  If config space is
> +	 * readable, assume it's valid data; otherwise, assume a bus error.
> +	 */
> +	if (val == ~0) {
> +		pci_read_config_dword(dev, PCI_VENDOR_ID, &id);
> +		if (id == ~0)
> +			pci_dev_set_disconnected(dev, NULL);

So why do the check above for "is disconnected"?  What does this buy us
here, just short-circuiting the readl()?

> +	}
> +
> +	return val;
> +}
> +
> +static void mmio_writel(struct pci_dev *dev, u32 val,
> +			volatile void __iomem *addr)
> +{
> +	if (pci_dev_is_disconnected(dev))
> +		return;
> +
> +	writel(val, addr);

Why even check, what's wrong with always doing the write?

I understand the wish to make this easier, but I think the only way is
that the driver themselves should be checking on their reads.  And they
have to check on all reads, or at least on some subset of reads and be
able to handle 0xff for the other ones without going crazy.

I _think_ the xhci driver does this given that it is hot added/removed
all the time dynamically due to the way that modern laptops are made
where the bios adds/removed the xhci controller when a USB device is
added/removed.

thanks,

greg k-h

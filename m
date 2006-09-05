Return-Path: <yanmin_zhang@linux.intel.com>
Received: from orsmga101.jf.intel.com (mga06.intel.com [134.134.136.21])
	by ozlabs.org (Postfix) with ESMTP id E7C0D67BA8
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Sep 2006 12:34:09 +1000 (EST)
Subject: Re: pci error recovery procedure
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1157360592.22705.46.camel@localhost.localdomain>
References: <1157008212.20092.36.camel@ymzhang-perf.sh.intel.com>
	<20060831175001.GE8704@austin.ibm.com>
	<1157081629.20092.167.camel@ymzhang-perf.sh.intel.com>
	<20060901212548.GS8704@austin.ibm.com>
	<1157348850.20092.304.camel@ymzhang-perf.sh.intel.com>
	<1157360592.22705.46.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1157423528.20092.365.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
Date: Tue, 05 Sep 2006 10:32:08 +0800
Cc: Yanmin Zhang <yanmin.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>,
	Rajesh Shah <rajesh.shah@intel.com>, linuxppc-dev@ozlabs.org,
	linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-09-04 at 17:03, Benjamin Herrenschmidt wrote:
> > As you know, all functions of a device share the same bus number and 5 bit dev number.
> > They just have different 3 bit function number. We could deduce if functions are in the same
> > device (slot).
> 
> Until you have a P2P bridge ...
> > Thanks. Now I understand why you specified mmio_enabled and slot_reset. They are just
> > to map to pSeries platform hardware operation steps. I know little about pSeries hardware,
> > but is it possible to merge such hardware steps from software point of view?
> 
> One of the ideas we had when defining those steps is to be precise
> enough to let drivers who _can_ deal with those fine grained pSeries
> step implement them, but also have the fallback to slot reset whenever
> possible.
> 
> Now, if in practice, after actually implementing this in a number of
> drivers, we see that slot reset is the only ever used path, then we
> might want to simplify things a bit. I didn't want to impose that
> restriction in the initial design though.
Thanks for your explanation. Now it's the time to delete mmio_enabled
and merge slot_reset with resume.

> 
> It's my understanding that doing no slot reset (hardware reset) but just
> re-enabling MMIO, DMA and clearing pending error status in the PCI
> config space is, as far as the driver is concerned, almost functionally
> equivalent to a PCIe link reset. That is, the link reset might not (or
> will not) actually reset the hardware beyond the PCIe link layer.
I agree.

> 
> Thus we could simplify the split between link reset / hard reset. The
> former is an attempt at recovery with only resetting the PCI path to the
> device, which on PCIe becomes a link reset, and on old PCI, just
> clearing of the various error bits along the path (and on pSeries,
> re-enabling MMIO and DMA access). However, there is still the problem
> that if you do that, on pSeries at least, you really want to 1- enable
> MMIO, 2- soft reset the card using MMIO, that is make sure all pending
> DMA is stopped, and 3- re-enable DMA. While if we collapse that into a
> single 'link reset' type of operation, we'll end up re-enabling MMIO and
> DMA before the driver has a chance to stop pending DMA's
Is it the exclusive reason to have multi-steps?

1) Here link reset and hard reset are hardware operations, not the
link_reset and slot_reset callback in pci_error_handlers.

2) Callback error_detected will notify drivers there is PCI errors. Drivers
shouldn't do any I/O in error_detected.

3) If both the link and slot are reset after all error_detected are called,
the device should go back to initial status and all DMA should be stopped
automatically. Why does the driver still need a chance to stop DMA? The
error_detected of the drivers in the latest kernel who support err handlers
always returns PCI_ERS_RESULT_NEED_RESET. They are typical examples.

>  and thus
> increase the chance that we crap out due to a pending DMA on the chip.
> 
> Ben.

Above discussion is only about if mmio_enabled is needed.
As for slot_reset, I think it could be merged with resume, because platforms
do nothing between calling slot_reset and resume. Any comment?

Yanmin

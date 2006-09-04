Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D584C67BA7
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Sep 2006 19:03:36 +1000 (EST)
Subject: Re: pci error recovery procedure
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
In-Reply-To: <1157348850.20092.304.camel@ymzhang-perf.sh.intel.com>
References: <1157008212.20092.36.camel@ymzhang-perf.sh.intel.com>
	<20060831175001.GE8704@austin.ibm.com>
	<1157081629.20092.167.camel@ymzhang-perf.sh.intel.com>
	<20060901212548.GS8704@austin.ibm.com>
	<1157348850.20092.304.camel@ymzhang-perf.sh.intel.com>
Content-Type: text/plain
Date: Mon, 04 Sep 2006 19:03:12 +1000
Message-Id: <1157360592.22705.46.camel@localhost.localdomain>
Mime-Version: 1.0
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


> As you know, all functions of a device share the same bus number and 5 bit dev number.
> They just have different 3 bit function number. We could deduce if functions are in the same
> device (slot).

Until you have a P2P bridge ...

> Thanks. Now I understand why you specified mmio_enabled and slot_reset. They are just
> to map to pSeries platform hardware operation steps. I know little about pSeries hardware,
> but is it possible to merge such hardware steps from software point of view?

One of the ideas we had when defining those steps is to be precise
enough to let drivers who _can_ deal with those fine grained pSeries
step implement them, but also have the fallback to slot reset whenever
possible.

Now, if in practice, after actually implementing this in a number of
drivers, we see that slot reset is the only ever used path, then we
might want to simplify things a bit. I didn't want to impose that
restriction in the initial design though.

It's my understanding that doing no slot reset (hardware reset) but just
re-enabling MMIO, DMA and clearing pending error status in the PCI
config space is, as far as the driver is concerned, almost functionally
equivalent to a PCIe link reset. That is, the link reset might not (or
will not) actually reset the hardware beyond the PCIe link layer.

Thus we could simplify the split between link reset / hard reset. The
former is an attempt at recovery with only resetting the PCI path to the
device, which on PCIe becomes a link reset, and on old PCI, just
clearing of the various error bits along the path (and on pSeries,
re-enabling MMIO and DMA access). However, there is still the problem
that if you do that, on pSeries at least, you really want to 1- enable
MMIO, 2- soft reset the card using MMIO, that is make sure all pending
DMA is stopped, and 3- re-enable DMA. While if we collapse that into a
single 'link reset' type of operation, we'll end up re-enabling MMIO and
DMA before the driver has a chance to stop pending DMA's and thus
increase the chance that we crap out due to a pending DMA on the chip.

Ben.

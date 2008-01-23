Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 5DD47DDF1E
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 06:50:35 +1100 (EST)
Date: Wed, 23 Jan 2008 22:50:22 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: mpc8568e-mds: pci-e is broken
Message-ID: <20080123195022.GA21157@localhost.localdomain>
References: <20080123193712.GA12037@localhost.localdomain>
	<6785FDE5-FEBA-4FE2-A94C-85FCE299D1CC@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <6785FDE5-FEBA-4FE2-A94C-85FCE299D1CC@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 23, 2008 at 01:42:56PM -0600, Kumar Gala wrote:
[...]
> >PCI: Probing PCI hardware
> >PCI: 0001:01:00.0: class b20 doesn't match header type 01. Ignoring  
> >class.
> >PCI: Closing bogus Apple Firmware region 1 on bus 0x02
> >PCI: Closing bogus Apple Firmware region 2 on bus 0x02
> 
> odd, you shouldn't see these anymore w/my git tree.

Yup, I noticed few commits that are trying to fix this. And these
fixes do work for PCI, but not for PCI-E...

[...]
> >static void __devinit __pcibios_fixup_bus(struct pci_bus *bus)
> >{
> >...
> >		if (i >= 3 && bus->self->transparent)
> >			continue;
> >...
> >}
> >
> >That new check doesn't work, here bus->self->transparent == 0.
> >Could it be that the message below is the root cause?
> >
> >PCI: 0001:01:00.0: class b20 doesn't match header type 01. Ignoring  
> >class.
> 
> this is expected but of how FSL hw reports itself.

Well. I see only two places were transparent flag is applied:
drivers/pci/quirks.c:quirk_transparent_bridge()
and
drivers/pci/probe.c:pci_setup_device() in the PCI_HEADER_TYPE_BRIDGE.

So, obviously probe.c is skipping our PCI-E, thus not setting
transparent flag, no?

> >I.e. drivers/pci/probe.c just don't setting transparent flag.
> >I wonder if we need use quirk_transparent_bridge() here or
> >we can fix it other way?
> >
> >Just in case, I'm observing that message for a long long time, and
> >it didn't tell upon any functionality till now.
> 
> 
> Is this with the 8568 MDS in standalone or plugged into the back pane?

This is standalone setup.


Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2

Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 29528DDE34
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 09:04:14 +1100 (EST)
Message-Id: <B4582CB3-2065-40D5-9C16-B0EE1943D83A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20080123195022.GA21157@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: mpc8568e-mds: pci-e is broken
Date: Wed, 23 Jan 2008 16:04:05 -0600
References: <20080123193712.GA12037@localhost.localdomain>
	<6785FDE5-FEBA-4FE2-A94C-85FCE299D1CC@kernel.crashing.org>
	<20080123195022.GA21157@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 23, 2008, at 1:50 PM, Anton Vorontsov wrote:

> On Wed, Jan 23, 2008 at 01:42:56PM -0600, Kumar Gala wrote:
> [...]
>>> PCI: Probing PCI hardware
>>> PCI: 0001:01:00.0: class b20 doesn't match header type 01. Ignoring
>>> class.
>>> PCI: Closing bogus Apple Firmware region 1 on bus 0x02
>>> PCI: Closing bogus Apple Firmware region 2 on bus 0x02
>>
>> odd, you shouldn't see these anymore w/my git tree.
>
> Yup, I noticed few commits that are trying to fix this. And these
> fixes do work for PCI, but not for PCI-E...

I see these now.. I think I'm too lazy to think of a way to fix this.

> [...]
>>> static void __devinit __pcibios_fixup_bus(struct pci_bus *bus)
>>> {
>>> ...
>>> 		if (i >= 3 && bus->self->transparent)
>>> 			continue;
>>> ...
>>> }
>>>
>>> That new check doesn't work, here bus->self->transparent == 0.
>>> Could it be that the message below is the root cause?
>>>
>>> PCI: 0001:01:00.0: class b20 doesn't match header type 01. Ignoring
>>> class.
>>
>> this is expected but of how FSL hw reports itself.
>
> Well. I see only two places were transparent flag is applied:
> drivers/pci/quirks.c:quirk_transparent_bridge()
> and
> drivers/pci/probe.c:pci_setup_device() in the PCI_HEADER_TYPE_BRIDGE.
>
> So, obviously probe.c is skipping our PCI-E, thus not setting
> transparent flag, no?
>
>>> I.e. drivers/pci/probe.c just don't setting transparent flag.
>>> I wonder if we need use quirk_transparent_bridge() here or
>>> we can fix it other way?
>>>
>>> Just in case, I'm observing that message for a long long time, and
>>> it didn't tell upon any functionality till now.
>>
>>
>> Is this with the 8568 MDS in standalone or plugged into the back  
>> pane?
>
> This is standalone setup.

do you have a card plugged in?

- k

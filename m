To: mlan@cpu.lu
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PowerDomain 3940UWD
In-Reply-To: Your message of "Sun, 12 Sep 1999 23:02:09 +0200 (CEST)"
	<199909122102.XAA00251@piglet.cpu.lu>
References: <199909122102.XAA00251@piglet.cpu.lu>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <19990919040757F.roikawa@rr.iij4u.or.jp>
Date: Sun, 19 Sep 1999 04:07:57 +0900
From: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


From: Michel Lanners <mlan@cpu.lu>
Subject: Re: PowerDomain 3940UWD

Sorry for very late response.

> > Is this patch below dangerous? I'd like to use MMIO on the PPC.
> [patch snip'ed]
> 
> I'd qualify it dangerous, as it assumes that you can do MMIO on _any_
> Adaptec chip in a PowerPC machine....
 More precisely it assumes that we can _check_ if MMIO is actually accessible
or not without causing machine check on any Adaptec card on a PPC, while the
original code assumes that we can do normal IO on any Adaptec card, which
made my card crashed. Which is more dangerous? Both? :-)


> Yeah, OF didn't assign any IO region to controller 1. That's weired....
> I wonder whether OF was confused because of two identical PCI devices...
$ hexdump /proc/bus/pci/01/04.0  (controller 1)
0000000 0490 7882 0700 8002 0000 0001 0820 0000
0000010 0100 0000 0000 8080 0000 0000 0000 0000
        ^^^^^^^^^
0000020 0000 0000 0000 0000 0000 0000 0000 0000
0000030 0000 8280 0000 0000 0000 0000 0001 0808
It looks like OF assined IO at 0x0000. Is '0' meaningless?
Of course IO forwarding is disabled as
$ hexdump /proc/bus/pci/00/0d.0
0000000 1110 0100 0700 8002 0200 0406 0820 0100
0000010 0000 0000 0000 0000 0001 0100 1010 8022
                                      ^^^^
0000020 8080 8080 8080 7080 0000 0000 0000 0000
0000030 0000 0000 0000 0000 0000 0000 0000 0400

> Right now, there are no methods implemented in Linux for assigning
> resources to PCI devices _after_ startup; we're relying on the BIOS to
> do that. If it does a bad job, then that has to be fixed in
> pcibios_fixup(). However, there is work underway related to hotplug PCI
> support, where dynamic resource assigment is a must.
 That sounds intereting. Does that work like CardBus?
Can I access the code?

> pcibios_fixupbus() might be empty right now, but every machine type
> under the PPC arch has it's own pcibios_fixup() routine; the one for
> PowerMacs is in arch/ppc/kernel/pmac_pci.c. There is already some work
> done there for fixing IRQ numbers; I'm workjing on adding even more
> fixup. The IRQ problem you discovered is a good candidate for inclusion
> as well.
I never disagree that. You can do everything in _fixup(), but I wonder if
there is any job rest for _fixupbus()...

> I'm only wondering about the more general case of a device without
> IRQ... Will this patch make interrupts appear on those devices?
Unfortunately no in general, if
 - the PCI card has more than one P2P bridge(what kind of card?)
 - OF doesn't insert AAPL,slot-name property
 - OF doesn't assign any IRQ to the card(how can we fix in this case??)


> > 01:04.0 SCSI storage controller: Adaptec AIC-7882U
> > 	Region 0: I/O ports at <unassigned>
> 
> ..... here OF didn't assign any IO region.
0x0000?

> > and list of /proc/device-tree:
> > /proc/device-tree/bandit/pci-bridge:
> > name             "pci-bridge"
> >  
> > /proc/device-tree/bandit/pci-bridge/ADPT,3940UW:
> > name             "ADPT,3940UW"
> > 
> > /proc/device-tree/bandit/pci-bridge/pci9004,8278:
> > name             "pci9004,8278"
> 
> That's the easy way to assign differing device names in OF... Although,
> if I remeber right, the OF code onboard should generate differing names
> by itslef, shouldn't it?
 OF seems to simply assign vendor,device as a name for nameless(?)
devie...


Regards,

Ryuichi Oikawa
roikawa@rr.iij4u.or.jp

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

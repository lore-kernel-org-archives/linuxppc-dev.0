Subject: Re: multiple separate pci bridges ...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Rob Baxter <robb@synergymicro.com>
In-Reply-To: <20040105214239.GA20252@iliana>
References: <20040101181145.GA27294@iliana>
	 <1073016223.1502.179.camel@gaston> <20040102074049.GA2032@iliana>
	 <1073029796.1501.228.camel@gaston> <20040104210335.GA858@iliana>
	 <1073252724.780.5.camel@gaston> <20040104220608.GA1667@iliana>
	 <20040105164038.GA16158@iliana> <1073338095.9497.70.camel@gaston>
	 <20040105214239.GA20252@iliana>
Content-Type: text/plain
Message-Id: <1073340725.9497.105.camel@gaston>
Mime-Version: 1.0
Date: Tue, 06 Jan 2004 09:12:06 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Mmm, will look into this. Actually, linux should not write to those, but
> read access should be ok.

If the BARs contain address ranges that will confuse linux resource
management (like RAM location), then you have to hide them completely.

> Well, i tried ioremapping 0x10000, but without much success
> (cfg_addr/data is at cf8/cfc, and this magic stuff is at f118/f11c). I
> just got a sig 11 OOPS, so ...

I don't fully understand... If you are doing IO cycles, there's no
ioremapping needed at all at this point, just use the one that is done
once for the bridge IO space. neither cf8/cfc not f118 look like
addresses that can be ioremap'ed anyway...

> > just ioremap that in a global once... I do that for a few things in
> > pmac_feature.c, like the northbridge registers.
>
> Yeah, i have seen.
>
> > > Also, i had to manually set hose->bus_offset = 0x10, since that didn't
> > > seem to be set automatically. I don't know why though.
> >
> > Why do you need hose->bus_offset ? For indirect_pci ? Well... that's
>
> Nope, i checked, and it was trying to read the bus 0x10, while the bus
> is in reallity 0. That said, if i understood stuff correctly, it should
> be ok, since type 0 config ignores bus and device, right ?

Yes. And for type 1, just issue a cycle to (bus - hose->first_busno)

> > a kludge, you should rather fix indirect_pci to use first_busno
> > instead... I don't know where this bus_offset comes from in the first
> > place, it's defined in pci_controller but not used at all in 2.6...
>
> Yeah, nor in 2.4, if my grep is correct. I can't use indirect_pci for
> the second bus though.
>
> > (BTW. You should really work on 2.6, not 2.4...)
>
> Ah, yes, but 2.4 means suppoprt for debian-installer. Once that works, i
> will work on 2.6.x. Also, 2.4 provides me a known working base.

I still don't like the idea of new dev. beeing done on 2.4...

> This is which bewilders me, the bridge spec speak about type 0 and type
> 1, and using the last 2 bits for this.

Yes. Usually, you don't put the last 2 bits of the offsets in cfg_addr,
you crop that value to the closest 32 bits boundary (or 64 bits in some
chips), and then you "offset" the cfg_data access.

For example, for a 8 bits access at an offset of 7, you would use 4
as the offset in cfg_addr, and then do a 8 bits access at cfg_data + 3


> The Marvell Discovery II has (one, two or three) gigabit ethernets
> included, these do not appear on the pci bus, but need to be programmed
> directly with the NB registers. On the other hand, the sk98 driver
> provides driver for various Marvell gigabit ethernet.

Argh ????? They don't appear on PCI ? What piece of SHIT is this bridge ?

Really totally insane.

I strongly suggest you still match them as PCI devices, eventually using
the bridge device itself as the match for the driver.... The DMA mapping
ops are designed to work with PCI anyway.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

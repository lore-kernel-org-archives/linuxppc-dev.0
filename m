Subject: Re: multiple separate pci bridges ...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Rob Baxter <robb@synergymicro.com>
In-Reply-To: <20040106073955.GF735@iliana>
References: <1073016223.1502.179.camel@gaston>
	 <20040102074049.GA2032@iliana> <1073029796.1501.228.camel@gaston>
	 <20040104210335.GA858@iliana> <1073252724.780.5.camel@gaston>
	 <20040104220608.GA1667@iliana> <20040105164038.GA16158@iliana>
	 <1073338095.9497.70.camel@gaston> <20040105214239.GA20252@iliana>
	 <1073340725.9497.105.camel@gaston>  <20040106073955.GF735@iliana>
Content-Type: text/plain
Message-Id: <1073376024.26508.220.camel@gaston>
Mime-Version: 1.0
Date: Tue, 06 Jan 2004 19:00:24 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2004-01-06 at 18:39, Sven Luther wrote:
> On Tue, Jan 06, 2004 at 09:12:06AM +1100, Benjamin Herrenschmidt wrote:
> >
> > > Mmm, will look into this. Actually, linux should not write to those, but
> > > read access should be ok.
> >
> > If the BARs contain address ranges that will confuse linux resource
> > management (like RAM location), then you have to hide them completely.
>
> Mmm, will check.
>
> BTW, X has problems with pci config space access. It simply opens the
> /proc/bus/pci/<bus>/<dev>.<func> stuff, and is not happy with the
> result.
>
> Is the above just a plain ioremap of config space or something such, or
> does the reads there use the pci access functions ?

They should use the PCI access function, could be your access size
handling that is wrong (the offset masking stuff), or maybe XFree
shokes on the host bridge

> > > Well, i tried ioremapping 0x10000, but without much success
> > > (cfg_addr/data is at cf8/cfc, and this magic stuff is at f118/f11c). I
> > > just got a sig 11 OOPS, so ...
> >
> > I don't fully understand... If you are doing IO cycles, there's no
> > ioremapping needed at all at this point, just use the one that is done
> > once for the bridge IO space. neither cf8/cfc not f118 look like
> > addresses that can be ioremap'ed anyway...
>
> Well, it is f1000cf8/cfc and f100f118/f11c naturally, and the second is
> needed to enable a hardware kludge to make the second pci bus look like
> agp. I don't really have the details of such, but i need to write to the
> f118/f11c before/after each pci access to the second pci bus, as well as
> disable the CPU interrupts for doing the access.
>
> > > > just ioremap that in a global once... I do that for a few things in
> > > > pmac_feature.c, like the northbridge registers.
> > >
> > > Yeah, i have seen.
> > >
> > > > > Also, i had to manually set hose->bus_offset = 0x10, since that didn't
> > > > > seem to be set automatically. I don't know why though.
> > > >
> > > > Why do you need hose->bus_offset ? For indirect_pci ? Well... that's
> > >
> > > Nope, i checked, and it was trying to read the bus 0x10, while the bus
> > > is in reallity 0. That said, if i understood stuff correctly, it should
> > > be ok, since type 0 config ignores bus and device, right ?
> >
> > Yes. And for type 1, just issue a cycle to (bus - hose->first_busno)
>
> How are the config access functions told that they shall do a type 0 or
> 1 access ? I have seen there is something in the pci_indirect functions
> that do this, but not sure i can do it here.

Type 0 is an access to the primary segment (doesn't contain a bus
number), type 1 is to be forwarded to another bus segment by a P2P
bridge. So for anything directly attached to the host bridge, it's a
type 0 access. Anything else is type 1. Typically, if the bus number of
your "target" == hose->first_busno, it's type 0, else type 1

> > > > a kludge, you should rather fix indirect_pci to use first_busno
> > > > instead... I don't know where this bus_offset comes from in the first
> > > > place, it's defined in pci_controller but not used at all in 2.6...
> > >
> > > Yeah, nor in 2.4, if my grep is correct. I can't use indirect_pci for
> > > the second bus though.
> > >
> > > > (BTW. You should really work on 2.6, not 2.4...)
> > >
> > > Ah, yes, but 2.4 means suppoprt for debian-installer. Once that works, i
> > > will work on 2.6.x. Also, 2.4 provides me a known working base.
> >
> > I still don't like the idea of new dev. beeing done on 2.4...
>
> Well, once i get it working, i will go on to 2.6, promised :))
>
> That said, i was a bit disapointed by 2.6. If you remember, i had some
> problems with 2.4, since the second IDE bus uses a different interrupt
> than the first one, so i used a kludge in the via-ide driver to make it
> work. The 2.6 ide driver has per ide channel setup, but still does get
> the primary ide interrupt for the second channel too.

Well, there is no clean way currently to deal with that issue. If I get
a board, I can try to hack something better :)

> > > This is which bewilders me, the bridge spec speak about type 0 and type
> > > 1, and using the last 2 bits for this.
> >
> > Yes. Usually, you don't put the last 2 bits of the offsets in cfg_addr,
> > you crop that value to the closest 32 bits boundary (or 64 bits in some
> > chips), and then you "offset" the cfg_data access.
> >
> > For example, for a 8 bits access at an offset of 7, you would use 4
> > as the offset in cfg_addr, and then do a 8 bits access at cfg_data + 3
>
> Ok, understand better now.
>
> > > The Marvell Discovery II has (one, two or three) gigabit ethernets
> > > included, these do not appear on the pci bus, but need to be programmed
> > > directly with the NB registers. On the other hand, the sk98 driver
> > > provides driver for various Marvell gigabit ethernet.
> >
> > Argh ????? They don't appear on PCI ? What piece of SHIT is this bridge ?
>
> Well, the Discovery II use a internal crossbar switch, and the ethernet
> are on the same level as the pci buses. This makes for very efficient
> networking i guess, but has problems. In fact, each of these ones has
> the same priority as each pci bus.
>
> I believe it should be possible to have each of these appear as an
> independent pci bus or something ?

They could have appeared as on-chip PCI devices on a "pseudo-bus", but
we can eventually just match with the host's PCI device.

> > Really totally insane.
>
> Well, i am no hardware guy, so i cannot make judgement on this, but i
> guess there are worse hardware out there.

Yah, sure, all hardware is broken some way :)

> > I strongly suggest you still match them as PCI devices, eventually using
> > the bridge device itself as the match for the driver.... The DMA mapping
> > ops are designed to work with PCI anyway.
>
> Mmm. Will have to look into that.
>
> Again, thanks for your help,
>
> Friendly,
>
> Sven Luther
--
Benjamin Herrenschmidt <benh@kernel.crashing.org>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

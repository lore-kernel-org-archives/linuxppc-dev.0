Date: Tue, 6 Jan 2004 09:11:43 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Rob Baxter <robb@synergymicro.com>
Subject: Re: multiple separate pci bridges ...
Message-ID: <20040106081143.GA1644@iliana>
References: <1073029796.1501.228.camel@gaston> <20040104210335.GA858@iliana> <1073252724.780.5.camel@gaston> <20040104220608.GA1667@iliana> <20040105164038.GA16158@iliana> <1073338095.9497.70.camel@gaston> <20040105214239.GA20252@iliana> <1073340725.9497.105.camel@gaston> <20040106073955.GF735@iliana> <1073376024.26508.220.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1073376024.26508.220.camel@gaston>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jan 06, 2004 at 07:00:24PM +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2004-01-06 at 18:39, Sven Luther wrote:
> > On Tue, Jan 06, 2004 at 09:12:06AM +1100, Benjamin Herrenschmidt wrote:
> > >
> > > > Mmm, will look into this. Actually, linux should not write to those, but
> > > > read access should be ok.
> > >
> > > If the BARs contain address ranges that will confuse linux resource
> > > management (like RAM location), then you have to hide them completely.
> >
> > Mmm, will check.
> >
> > BTW, X has problems with pci config space access. It simply opens the
> > /proc/bus/pci/<bus>/<dev>.<func> stuff, and is not happy with the
> > result.
> >
> > Is the above just a plain ioremap of config space or something such, or
> > does the reads there use the pci access functions ?
>
> They should use the PCI access function, could be your access size
> handling that is wrong (the offset masking stuff), or maybe XFree
> shokes on the host bridge

Don't exactly know what happens, it dies with :

(II) Host-to-PCI bridge:
(II) Bus 16: bridge is at (0:0:0), (-1,16,0), BCTRL: 0x0008 (VGA_EN is set)
(II) Bus 16 I/O range:
	[0] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus 16 non-prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 16 prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]

(full log on : http://zapek.com/misc/XFree86.0.log)

Need to install my box, and do some testing myself. X doesn't kill the
box though, which is rather nice.

> Type 0 is an access to the primary segment (doesn't contain a bus
> number), type 1 is to be forwarded to another bus segment by a P2P
> bridge. So for anything directly attached to the host bridge, it's a
> type 0 access. Anything else is type 1. Typically, if the bus number of
> your "target" == hose->first_busno, it's type 0, else type 1

Yep, except we have two pci controllers, and it should be type 0 for
both of them.

> > That said, i was a bit disapointed by 2.6. If you remember, i had some
> > problems with 2.4, since the second IDE bus uses a different interrupt
> > than the first one, so i used a kludge in the via-ide driver to make it
> > work. The 2.6 ide driver has per ide channel setup, but still does get
> > the primary ide interrupt for the second channel too.
>
> Well, there is no clean way currently to deal with that issue. If I get
> a board, I can try to hack something better :)

Will see. How long would you need the board, and you are in Australia
still, right ?

> > > Argh ????? They don't appear on PCI ? What piece of SHIT is this bridge ?
> >
> > Well, the Discovery II use a internal crossbar switch, and the ethernet
> > are on the same level as the pci buses. This makes for very efficient
> > networking i guess, but has problems. In fact, each of these ones has
> > the same priority as each pci bus.
> >
> > I believe it should be possible to have each of these appear as an
> > independent pci bus or something ?
>
> They could have appeared as on-chip PCI devices on a "pseudo-bus", but
> we can eventually just match with the host's PCI device.

Ok. but this can also be faked or something ? But, how can we match with
the host PCI device, if we are going to hide it ?

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

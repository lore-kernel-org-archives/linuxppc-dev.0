Date: Tue, 6 Jan 2004 18:44:26 +0100
To: Rob Baxter <robb@synergymicro.com>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: multiple separate pci bridges ...
Message-ID: <20040106174426.GA9530@iliana>
References: <20040105164038.GA16158@iliana> <1073338095.9497.70.camel@gaston> <20040105214239.GA20252@iliana> <1073340725.9497.105.camel@gaston> <20040106073955.GF735@iliana> <1073376024.26508.220.camel@gaston> <20040106081143.GA1644@iliana> <Pine.GSO.4.58.0401061533510.5752@waterleaf.sonytel.be> <20040106144545.GA7261@iliana> <20040106153305.GA6251@synergy>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20040106153305.GA6251@synergy>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jan 06, 2004 at 08:33:05AM -0700, Rob Baxter wrote:
>
> On Tue, Jan 06, 2004 at 03:45:45PM +0100, Sven Luther wrote:
> >
> > On Tue, Jan 06, 2004 at 03:40:30PM +0100, Geert Uytterhoeven wrote:
> > > On Tue, 6 Jan 2004, Sven Luther wrote:
> > > > On Tue, Jan 06, 2004 at 07:00:24PM +1100, Benjamin Herrenschmidt wrote:
> > > > > Type 0 is an access to the primary segment (doesn't contain
> > > > > a bus number), type 1 is to be forwarded to another bus
> > > > > segment by a P2P bridge. So for anything directly attached
> > > > > to the host bridge, it's a type 0 access. Anything else is
> > > > > type 1. Typically, if the bus number of your "target" ==
> > > > > hose->first_busno, it's type 0, else type 1
> > > >
> > > > Yep, except we have two pci controllers, and it should be type 0
> > > > for both of them.
> > >
> > > Yep, two hoses, with different hose->first_busno.
> >
> > A, yes, right.
> >
> > > > > They could have appeared as on-chip PCI devices on a
> > > > > "pseudo-bus", but we can eventually just match with the host's
> > > > > PCI device.
> > > >
> > > > Ok. but this can also be faked or something ? But, how can we
> > > > match with the host PCI device, if we are going to hide it ?
> > >
> > > Hide the memory BAR only, not the full PCI device.
> >
> > Ok, will try that.
>
> We hide all of the PCI resources (i.e., PCI BARs) by initializing all
> of resources to zero. This allows us to load drivers (e.g., ethernet)
> specific to the Discovery. Registers internal to the Discovery (via
> the PowerPC bus) need to be initialized and queried for memory, PCI
> I/O, PCI memory, and PCI prefecthable memory mappings (hopefully your
> firmware does this).
>
> Here's the code from our pcibios_fixup:
>
> 	dev = NULL;
> 	while ((dev = pci_find_device(PCI_VENDOR_ID_GALILEO,
> 				PCI_DEVICE_ID_GALILEO_GT64260, dev))) {
> 		for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
> 			dev->resource[i].flags = 0;
> 			dev->resource[i].start = 0;
> 			dev->resource[i].end = 0;
> 		}
> 	}

Ok, thanks, will try it out.

BTW, could you please do something to not reject my incoming email ?
Black listing frances biggest ISP is somewhat silly, and my last
experience with such black lister was not conclusive. They blacklisted
it on the basis of 50 or so spams received over one year period, most of
them not even comming from wanadoo but from other ISPs.

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

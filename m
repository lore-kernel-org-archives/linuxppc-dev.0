Date: Tue, 6 Jan 2004 15:17:28 -0700
From: Rob Baxter <robb@synergymicro.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Rob Baxter <robb@synergymicro.com>,
	Sven Luther <sven.luther@wanadoo.fr>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: multiple separate pci bridges ...
Message-ID: <20040106221728.GA8268@synergy>
References: <1073338095.9497.70.camel@gaston> <20040105214239.GA20252@iliana> <1073340725.9497.105.camel@gaston> <20040106073955.GF735@iliana> <1073376024.26508.220.camel@gaston> <20040106081143.GA1644@iliana> <Pine.GSO.4.58.0401061533510.5752@waterleaf.sonytel.be> <20040106144545.GA7261@iliana> <20040106153305.GA6251@synergy> <1073425055.784.3.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1073425055.784.3.camel@gaston>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jan 07, 2004 at 08:37:36AM +1100, Benjamin Herrenschmidt wrote:
>
> > Here's the code from our pcibios_fixup:
> >
> > 	dev = NULL;
> > 	while ((dev = pci_find_device(PCI_VENDOR_ID_GALILEO,
> > 				PCI_DEVICE_ID_GALILEO_GT64260, dev))) {
> > 		for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
> > 			dev->resource[i].flags = 0;
> > 			dev->resource[i].start = 0;
> > 			dev->resource[i].end = 0;
> > 		}
> > 	}
>
> pcibios_fixup isn't the right place to do that ;) You should do this
> from a pci quirk imho.

agreed

>
> note that there's still a problem with XFree which will "see"  those
> BARs and, according to the log posted by Sven, shoke. Sven, can you
> try "hiding" the host bridge completely from the config ops and see
> if that helps with XFree ? That's not a very good solution though,
> we'll have to do something different about it. Now if only XFree
> stopped mucking with the PCI bus...

I have no problem with XFree working with a CT69030 (chips_drv.o) PMC
graphics card and an USB keyboard and mouse setup.

>
> > > BTW, is there any reason the L2 cache is disabled by default in the
> > > 2.4.x kernels ?
> >
> > We have it initialized and enabled.
>
> The kernel doesn't do anything to the L2 cache, it all depends what
> you firmware does to it.

That's true, but for the ppc stuff, there is initialization routines within
the kernel source.

>
> Ben.
>
>

--
-Rob

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

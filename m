Date: Tue, 13 Jan 2004 10:56:38 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Rob Baxter <robb@synergymicro.com>,
	Sven Luther <sven.luther@wanadoo.fr>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: multiple separate pci bridges ...
Message-ID: <20040113095638.GA7633@iliana>
References: <1073338095.9497.70.camel@gaston> <20040105214239.GA20252@iliana> <1073340725.9497.105.camel@gaston> <20040106073955.GF735@iliana> <1073376024.26508.220.camel@gaston> <20040106081143.GA1644@iliana> <Pine.GSO.4.58.0401061533510.5752@waterleaf.sonytel.be> <20040106144545.GA7261@iliana> <20040106153305.GA6251@synergy> <1073425055.784.3.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1073425055.784.3.camel@gaston>
From: Sven Luther <sven.luther@wanadoo.fr>
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

Mmm, what do you mean by a pci quirk ?

Anyway, i did that from pcibios_fixup, as well as blocking all pci
writes to device 0 on both buses and reads to all functions of device 0
on both bus, except function 0, for which i allow reads of the first 15
bytes, and return 0 for the others, as i am told i should do by the
hardware guys.

This works fine for the fbdev, but X is not at all happy with it, well,
it seems to work, but there is nothing outputed on the screen :(, but
that is something i probably have to solve with XFree86.

> note that there's still a problem with XFree which will "see"  those
> BARs and, according to the log posted by Sven, shoke. Sven, can you
> try "hiding" the host bridge completely from the config ops and see
> if that helps with XFree ? That's not a very good solution though,
> we'll have to do something different about it. Now if only XFree
> stopped mucking with the PCI bus...

So, yes, that does help with XFree86, altough i get a strange message i
have to search the origin for :

  (WW) ****INVALID IO ALLOCATION**** b: 0x1000 e:0x10ff correcting

Also, with voodoo 3 cards, the tdfx driver dies with :

  (EE) TDFX(0): No valid PIO address in PCI config space

But Radeon works.

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

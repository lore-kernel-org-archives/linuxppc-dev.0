Date: Tue, 13 Jan 2004 11:26:13 +0100
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Rob Baxter <robb@synergymicro.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: multiple separate pci bridges ...
Message-ID: <20040113102613.GA8205@iliana>
References: <20040105214239.GA20252@iliana> <1073340725.9497.105.camel@gaston> <20040106073955.GF735@iliana> <1073376024.26508.220.camel@gaston> <20040106081143.GA1644@iliana> <Pine.GSO.4.58.0401061533510.5752@waterleaf.sonytel.be> <20040106144545.GA7261@iliana> <20040106153305.GA6251@synergy> <1073425055.784.3.camel@gaston> <20040113095638.GA7633@iliana>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20040113095638.GA7633@iliana>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jan 13, 2004 at 10:56:38AM +0100, Sven Luther wrote:
>
> On Wed, Jan 07, 2004 at 08:37:36AM +1100, Benjamin Herrenschmidt wrote:
> >
> > > Here's the code from our pcibios_fixup:
> > >
> > > 	dev = NULL;
> > > 	while ((dev = pci_find_device(PCI_VENDOR_ID_GALILEO,
> > > 				PCI_DEVICE_ID_GALILEO_GT64260, dev))) {
> > > 		for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
> > > 			dev->resource[i].flags = 0;
> > > 			dev->resource[i].start = 0;
> > > 			dev->resource[i].end = 0;
> > > 		}
> > > 	}
> >
> > pcibios_fixup isn't the right place to do that ;) You should do this
> > from a pci quirk imho.

Damn, i specifically return 0 when reading bytes >15 on the device 0,
func 0, but hexdump /proc/bus/pci/10/00.0 still gives me :

0000000 ab11 6064 0700 b022 0300 0006 2000 0000
0000010 20df 65c3 20df 65c3 20df 65c3 20df 65c3
*
0000040

Should the second line not show only 0s ?

Also, GALILEO is now known as MARVELL, is it ok to add the additional
PCI_VENDOR_ID_MARVELL as the same value as the PCI_VENDOR_ID_GALILEO
above, and also use PCI_DEVICE_ID_MAVELL_... ?

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Wed, 7 Jan 2004 03:35:01 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Rob Baxter <robb@synergymicro.com>,
	Sven Luther <sven.luther@wanadoo.fr>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: multiple separate pci bridges ...
Message-ID: <20040107023501.GA16761@iliana>
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
>
> note that there's still a problem with XFree which will "see"  those
> BARs and, according to the log posted by Sven, shoke. Sven, can you

Not exactly, but i have yet to investigate this issue.

> try "hiding" the host bridge completely from the config ops and see
> if that helps with XFree ? That's not a very good solution though,
> we'll have to do something different about it. Now if only XFree
> stopped mucking with the PCI bus...

Well, XFree86 doesn't seem to see the device 0, since i hide it from the
config ops. Here is a lspci output :

00:01.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46)
00:05.0 SCSI storage controller: LSI Logic / Symbios Logic 53c810 (rev 23)
00:0c.0 ISA bridge: VIA Technologies, Inc. VT8231 [PCI-to-ISA Bridge] (rev 10)
00:0c.1 IDE interface: VIA Technologies, Inc.  VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
00:0c.2 USB Controller: VIA Technologies, Inc. USB (rev 1e)
00:0c.3 USB Controller: VIA Technologies, Inc. USB (rev 1e)
00:0c.4 Non-VGA unclassified device: VIA Technologies, Inc. VT8235 ACPI (rev 10)
00:0c.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 Audio Controller (rev 40)
00:0c.6 Communication controller: VIA Technologies, Inc. Intel 537 [AC97 Modem] (rev 20)
00:0d.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 51)
10:08.0 VGA compatible controller: ATI Technologies Inc: Unknown device 5964 (rev 01)

I am now building X 4.4.0 yesterdays CVS checkout, and will investigate
what exactly goes wrong.

Also, i retire what i said about voodoo support, it works fine with
tdfxfb.

> > > BTW, is there any reason the L2 cache is disabled by default in the
> > > 2.4.x kernels ?
> >
> > We have it initialized and enabled.
>
> The kernel doesn't do anything to the L2 cache, it all depends what
> you firmware does to it.

Mmm, ok. I still have to pass it the l2cr=0x80000000 boot arg, but maybe
it would be easier to add it to the default boot args or something.

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

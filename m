Date: Sun, 18 Jan 2004 13:15:07 +0100
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Rob Baxter <robb@synergymicro.com>
Subject: Re: multiple separate pci bridges ...
Message-ID: <20040118121507.GB4603@iliana>
References: <1073252724.780.5.camel@gaston> <20040104220608.GA1667@iliana> <20040105164038.GA16158@iliana> <1073338095.9497.70.camel@gaston> <20040105214239.GA20252@iliana> <1073340725.9497.105.camel@gaston> <20040106073955.GF735@iliana> <1073376024.26508.220.camel@gaston> <20040106081143.GA1644@iliana> <Pine.GSO.4.58.0401061533510.5752@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <Pine.GSO.4.58.0401061533510.5752@waterleaf.sonytel.be>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jan 06, 2004 at 03:40:30PM +0100, Geert Uytterhoeven wrote:
>
> On Tue, 6 Jan 2004, Sven Luther wrote:
> > On Tue, Jan 06, 2004 at 07:00:24PM +1100, Benjamin Herrenschmidt wrote:
> > > Type 0 is an access to the primary segment (doesn't contain a bus
> > > number), type 1 is to be forwarded to another bus segment by a P2P
> > > bridge. So for anything directly attached to the host bridge, it's a
> > > type 0 access. Anything else is type 1. Typically, if the bus number of
> > > your "target" == hose->first_busno, it's type 0, else type 1
> >
> > Yep, except we have two pci controllers, and it should be type 0 for
> > both of them.
>
> Yep, two hoses, with different hose->first_busno.
>
> > > They could have appeared as on-chip PCI devices on a "pseudo-bus", but
> > > we can eventually just match with the host's PCI device.
> >
> > Ok. but this can also be faked or something ? But, how can we match with
> > the host PCI device, if we are going to hide it ?
>
> Hide the memory BAR only, not the full PCI device.

Ok, i have done this. I have followed the recomendations of the hardware
guy, and did the following :

  device 0, function 0 : read access to bytes 0-15, read returns 0 on
  regs > 15. Write access fails silently.

  device 0, function 1-7 : both read and writes fail with
  PCIBIOS_DEVICE_NOT_FOUND.

Additionnally, i have nullified the ressources with :
	dev->resource[i].flags = 0;
	dev->resource[i].start = 0;
	dev->resource[i].end = 0;
from the pcibios_fixup (not the right place, but i don't know where it
should be done instead).

This allows me to see the host bridge on both buses, and radeonfb works
fine :

$ lspci
00:00.0 Host bridge: Galileo Technology Ltd.: Unknown device 6460 (rev 03)
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
10:00.0 Host bridge: Galileo Technology Ltd.: Unknown device 6460 (rev 03)
10:08.0 VGA compatible controller: ATI Technologies Inc: Unknown device 5964 (rev 01)

But :

$ hexdump /proc/bus/pci/10/00.0
0000000 ab11 6064 0700 b022 0300 0006 2000 0000
0000010 20df 85cf 20df 85cf 20df 85cf 20df 85cf
*
0000040

Why in hell do i have 0x20df85cf on all four bars of the config space
addresses 0x10 to 0x1f ?

Finally, X works, altough DRI freezes after a second or two with my
radeon 9200SE, while it works for a Radeon 7500, but this is probably a
DRI issue.

What makes me wonder, is that X needs around 20 seconds to launch, which
could not be something normal. It usually takes 5-8 seconds only.
Something strange is going on.

Thanks for your help.

Friendly,

Sven Luther


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

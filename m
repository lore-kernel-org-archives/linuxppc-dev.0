Date: Tue, 23 Dec 2003 15:01:49 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
Cc: "David D. Kilzer" <ddkilzer@kilzer.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH] Fix byte-swapped ethernet addr for Asante Fast 10/100
 PCI Adapter
In-Reply-To: <Pine.LNX.4.44.0312231423020.1925-100000@zirkon.biophys.uni-duesseldorf.de>
Message-ID: <Pine.GSO.4.58.0312231500350.1139@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0312231423020.1925-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 23 Dec 2003, Michael Schmitz wrote:
> > > This is a card with an Open Firmware driver or not ? If it has, then
> > > I'd rather use the OF properties (like name property) to detect this
> > > specific card and flip the MAC
> >
> > Please forgive my ignorance, but how do I tell if the card has an OF
> > driver?  Running "ofpath /dev/eth1" doesn't reveal anything, although
> > looking at the source for "ofpath" shows me that it doesn't handle
> > ethernet devices.  I don't see anything under /proc/device-tree/ that
> > would map to the Asante ethernet card, either.
>
> If there's nothing under /proc/device-tree/, the card doesn't have an OF
> driver.
>
> > The card does show up in "lspci" and /proc/pci (obviously).  Would
> > checking for the PCI vendor/device and subvendor/subdevice be
> > equivalent to checking for the OF name property?
>
> I'm not sure - the card having an OF driver might mean it's a Mac card,
> needing byte swapping, whereas a card with no OF driver would be a PC
> card, needing no byte swap. Or vice versa. Asante probably never built PC
> specific ethernet cards so the PCI vendor/device property could be used
> instead of OF data. OF data is just easier to get at :-)

Really? I'd say it's easier to look at the struct pci_dev the Tulip driver
already looks at. Besides, someone may want to try that card in a non-PowerMac,
while still having the correct MAC address.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

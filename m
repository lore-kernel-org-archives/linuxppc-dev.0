Date: Tue, 23 Dec 2003 15:32:27 +0100 (CET)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "David D. Kilzer" <ddkilzer@kilzer.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH] Fix byte-swapped ethernet addr for Asante Fast 10/100
 PCI Adapter
In-Reply-To: <Pine.GSO.4.58.0312231500350.1139@waterleaf.sonytel.be>
Message-ID: <Pine.LNX.4.44.0312231518540.2843-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > > The card does show up in "lspci" and /proc/pci (obviously).  Would
> > > checking for the PCI vendor/device and subvendor/subdevice be
> > > equivalent to checking for the OF name property?
> >
> > I'm not sure - the card having an OF driver might mean it's a Mac card,
> > needing byte swapping, whereas a card with no OF driver would be a PC
> > card, needing no byte swap. Or vice versa. Asante probably never built PC
> > specific ethernet cards so the PCI vendor/device property could be used
> > instead of OF data. OF data is just easier to get at :-)
>
> Really? I'd say it's easier to look at the struct pci_dev the Tulip driver

Easier (if you deal with PCI all the time) but what if they also made
non-Mac cards that behave different there? Seeing the OF data just makes
it clearer that we've got the Mac card here.

> already looks at. Besides, someone may want to try that card in a non-PowerMac,
> while still having the correct MAC address.

So we need both detection methods. Since Dave's card didn't seem to have
OF resources, PCI might be the only way here.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

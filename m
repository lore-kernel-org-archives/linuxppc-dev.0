Date: Tue, 23 Dec 2003 14:30:01 +0100 (CET)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: "David D. Kilzer" <ddkilzer@kilzer.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH] Fix byte-swapped ethernet addr for Asante Fast 10/100
 PCI Adapter
In-Reply-To: <20031223131553.GA21005@permusion.kilzer.net>
Message-ID: <Pine.LNX.4.44.0312231423020.1925-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > This is a card with an Open Firmware driver or not ? If it has, then
> > I'd rather use the OF properties (like name property) to detect this
> > specific card and flip the MAC
>
> Please forgive my ignorance, but how do I tell if the card has an OF
> driver?  Running "ofpath /dev/eth1" doesn't reveal anything, although
> looking at the source for "ofpath" shows me that it doesn't handle
> ethernet devices.  I don't see anything under /proc/device-tree/ that
> would map to the Asante ethernet card, either.

If there's nothing under /proc/device-tree/, the card doesn't have an OF
driver.

> The card does show up in "lspci" and /proc/pci (obviously).  Would
> checking for the PCI vendor/device and subvendor/subdevice be
> equivalent to checking for the OF name property?

I'm not sure - the card having an OF driver might mean it's a Mac card,
needing byte swapping, whereas a card with no OF driver would be a PC
card, needing no byte swap. Or vice versa. Asante probably never built PC
specific ethernet cards so the PCI vendor/device property could be used
instead of OF data. OF data is just easier to get at :-)

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Subject: Re: [PATCH] Fix byte-swapped ethernet addr for Asante Fast 10/100
	PCI Adapter
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: "David D. Kilzer" <ddkilzer@kilzer.net>,
	Jeff Garzik <jgarzik@pobox.com>, tulip-devel@lists.sourceforge.net,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <Pine.LNX.4.44.0312221520490.10152-100000@opal.biophys.uni-duesseldorf.de>
References: 
	 <Pine.LNX.4.44.0312221520490.10152-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain
Message-Id: <1072137958.705.9.camel@gaston>
Mime-Version: 1.0
Date: Tue, 23 Dec 2003 11:05:58 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2003-12-23 at 01:27, Michael Schmitz wrote:
> >   Original:  00:00:B5:94:71:86  [INCORRECT]
> >    Patched:  00:00:94:B5:86:71  [CORRECT]
> >
> > Is it sufficient to simply check the first two bytes of the mac address
> > to determine this?  (This is what the attached patch does.  I added a
> > check for the first byte being 0x00 for the Asante card.)
> >
> > Should the first three bytes of the mac address be used intead?  (Note
> > that I can only identify 00:A0:CC as one of the Lite-On mac addresses
> > that would be matched by the code segment above.  I don't see a 00:C0:**
> > entry for Lite-On in the IEEE database.)
>
> I'd check the first three bytes (after byte swapping :-) - there's plenty
> of other OUIs with the leading two bytes zero.

This is a card with an Open Firmware driver or not ? If it has, then
I'd rather use the OF properties (like name property) to detect this
specific card and flip the MAC

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.173]) by ozlabs.org (Postfix) with ESMTP id 10D9967A84
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Mar 2005 18:35:01 +1000 (EST)
Message-ID: <42491419.4070405@anagramm.de>
Date: Tue, 29 Mar 2005 10:38:49 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: "Wimer, Walt" <walt.wimer@timesys.com>,
	linuxppc-embedded@ozlabs.org
References: <1111705036.15834.29.camel@excalibur.timesys.com>
In-Reply-To: <1111705036.15834.29.camel@excalibur.timesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Re: PCI support under 2.6.11.4 on MPC8272ADS ???
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Walt!

> Using Vitaly's 2.4-based patch below as a starting point, I've been
> adding PCI support to 2.6.11.4 for the MPC8272ADS board.
> 
> The good news is that I think I have PCI interrupts pretty well sorted
> out, and I see *something* half-way reasonable from "lspci".
> 
> The bad news is that neither of the ethernet cards that I'm trying will
> actually work, and I see some very weird behavior with PCI configuration
> space:
> 
>   Card 1:  Some Realtek RTL8139D-based card
>   Card 2:  NETGEAR FA311 (National Semi DP83815 chip)
> 
> With either card installed alone, both U-Boot and my kernel identify the
> cards correctly in PCI configuration space.
> 
> With *both* cards installed, both U-Boot and my kernel see the Realtek-
> based card correctly, but the NETGEAR card has a corrupted Vendor ID
> (e.g. 0x1000 or 0x1003 instead of the correct 0x100b).  This happens
> regardless of which PCI slots I use for the cards (I've tried virtually
> every combination).  This smells of a power problem or something to me.

Check your ADx-IDSEL connections (resistors, 220 Ohms) on the PCI Bus.
I had _two_ AD lines connected to _one_ IDSEL which means that two
AD lines are 'shorted' over 440Ohm which lead to data corruption on the 
PCI bus. Check your schematics and the boards.

Maybe one of your card's PCI pad drive strength (like with the SM501
Voyager GX (where it is programmable)) isn't strong enough to drive
against the resistors in between the AD lines (which would explain that 
the problems get worse with 'more' cards plugged in).

> And again, even with either card alone, the drivers have serious
> problems talking to the cards.  I get various error messages from
> the drivers and I see badly mangled packets on the wire.  It's also
> not uncommon for the whole system to freeze...

Smells like data corruption on the bus... the behaviour you describe
is exactly as on mine system. (MPC8540 with SM501 Graphics Board
and Promise IDE Ctrl. on PCI)

Best greets,

-- 
Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19

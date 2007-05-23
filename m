Return-Path: <benh@kernel.crashing.org>
Subject: RE: TSI ethernet PHY question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexandre Bounine <Alexandre.Bounine@tundra.com>
In-Reply-To: <1B5F013528140F45B5C671039279CA5701BBBDE3@NANUK.pc.tundra.com>
References: <1B5F013528140F45B5C671039279CA5701BBBDE3@NANUK.pc.tundra.com>
Content-Type: text/plain
Date: Thu, 24 May 2007 08:52:07 +1000
Message-Id: <1179960728.32247.953.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> On power up, because this pin is pulled high by the LED, the
> TXC_RXC_DELAY mode is enabled, causing a 1.9ns delay between the clock
> and data on the GMII interface. Tsi109 could not operate properly with
> this delay. The TXC_RXC_DELAY mode has to be disabled by software.
> 
> If the Quality/TXC_RXC_DELAY pin is left not connected PHY will work in
> normal mode without delay and therefore the workaround is not required.

Ok, so this is a workaround that is specific to the Holly board...
interesting. I have to figure out what is the best way of having it in a
"generic" PHY driver for the BCM5461A chip.

Right now, we're seeing a problem where the driver doesn't detect a link
up. It detects the link at boot fine. If we disconnect the cable, it
sees the link going down, but it never sees the link going back up. I
haven't investigated much yet but I wanted to understand this workaround
in case it could be related.

> I think that for situations like one on the Holly board we may need
> board-specific hooks which modify normal initialization. As in our case:
> no LED - no trouble.

Yes, I need to look into that.

> I have put into my plans switching Tsi108/9 driver to common PHY lib
> (after Josh released his patch for Holly) but it looks like you will
> beat me here - I still have to close some other tasks. Let me know if I
> can help with anything around Tsi109.

We'll see, I said I'm contemplating the idea, doesn't mean I'll actually
do it anytime soon :-)

Cheers,
Ben.

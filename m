Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E4A7C67BC8
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 19:31:19 +1000 (EST)
Subject: Re: Recently removed io accessors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Korsgaard <jacmet@sunsite.dk>
In-Reply-To: <87slhstxlk.fsf@sleipner.barco.com>
References: <873b9twnbb.fsf@sleipner.barco.com>
	<1160697861.4792.177.camel@localhost.localdomain>
	<87iriovh3x.fsf@sleipner.barco.com>
	<1160724670.4792.195.camel@localhost.localdomain>
	<87slhstxlk.fsf@sleipner.barco.com>
Content-Type: text/plain
Date: Fri, 13 Oct 2006 19:30:59 +1000
Message-Id: <1160731859.4792.249.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: sfr@canb.auug.org.au, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Endian register set to little endian (default at powerup):
> RedBoot> x -b 0x8e000064 -2 -l 4
> 8E000064: 4321 8765
> RedBoot> x -b 0x8e000064 -4 -l 4
> 8E000064: 43218765
> 
> And with it set to big endian:
> RedBoot> x -b 0x8e000064 -2 -l 4
> 8E000064: 8765 4321
> RedBoot> x -b 0x8e000064 -4 -l 4
> 8E000064: 87654321
> 
> So with this setup I need to enable the big endian mode to read
> registers without byteswapping and use byteswapping for the packet
> fifos.

That's what bothers me... usually, if the registers are little endian
and you need a byteswap to read them, then you don't need a byteswap to
pump the fifo. For example, things like IDE, sound cards, wireless chips
etc... have LE registers (we use byteswap to access them) and we are
fine not swapping on the fifo read/writes.

I'll read the chip spec and try to figure out what can be done. Maybe an
option is to use the per-page little endian flag available on 4xx parts,
I think you may have that in your xilinx, and thus have automatic
byteswapping. We don't support that bit but it shouldn't be too hard to
add it so that you can pass it to __ioremap. But again, I'm surprised
that's necessary.

Ben.

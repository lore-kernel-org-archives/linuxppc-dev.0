Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 616D2DDE2B
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 04:20:27 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Sun, 3 Jun 2007 20:20:21 +0200
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
Message-ID: <20070603182020.GA10355@iram.es>
References: <20070602195308.GA21618@iram.es>
	<12ad593bd17f769e44f05bc24eac4d0a@kernel.crashing.org>
	<1180828907.14025.37.camel@localhost.localdomain>
	<28e0600256815f93db45b2f4eb2d9df5@kernel.crashing.org>
	<20070603083339.GB2157@iram.es>
	<34eddd7ce58e7983017077454d592332@kernel.crashing.org>
	<20070603101052.GA3313@iram.es>
	<ee4d3e25c4b6ede84483399249929632@kernel.crashing.org>
	<20070603124357.GA6419@iram.es>
	<3ffee021f3b721bde0253b1310d4958a@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3ffee021f3b721bde0253b1310d4958a@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jun 03, 2007 at 04:42:38PM +0200, Segher Boessenkool wrote:
> >>This is an IBM NVRAM thing -- write address to ISA I/O
> >>0x74/0x75, read/write a byte from 0x76.
> >
> >Data is 0x77 actually. Port 0x76 systematically returns 0xff
> >on this board (I have one at hand right now and am doing
> >accesses with the firmware).
> 
> Oh okay, I don't know exactly what chip this is so
> obviously my information isn't 100% ;-)
> 
> >>>ISA Device, Slot 0, LogicalDev 0: PNP0B00, SystemPeripheral,
> >>>RealTimeClock, #-1, interface 129
> >>> Device flags 2800: Integrated, Static
> >>> Packets describing allocated resources:
> >>>   Variable (16 decoded bits) I/O port
> >>>     from 0x0074 to 0x0074, alignment 1, 2 ports
> >>>   Variable (16 decoded bits) I/O port
> >>>     from 0x0077 to 0x0077, alignment 1, 1 ports
> >>>   Chip identification: MOT3040
> >>>   Small vendor item type 0x00, data (hex): 01 f8 1f 00 00
> >>
> >>The I/O port numbers here are wrong.
> >
> >No they aren't. It uses exactly the same port as for the NVRAM.
> 
> Then its claim to be PNP 0b00 is incorrect.
> 
> >Otherwise the "feature" of this RTC is that its interrupt
> >is not connected.
> 
> Dunno what you mean here?

On a standard PC, the RTC is connected to interrupt
8 of the 8259 pair. On these boards the interrupt output
of the RTC is not connected (there is no interrupt
in the list of properties). Interrupt 8 is connected
to a front panel button labeled "ABT".

> 
> >>rtc@i70 {
> >>	device_type = "rtc";
> >>	reg = <1 70 2>;
> >>	compatible = "pnpPNP,b00";
> >>}
> >>
> >
> >Nope, there is nothing at 0x70-0x71 (read returns 0xff). The chip
> >is a 48T59.
> 
> [Not so easy to find a datasheet for that -- STM M48T59Y
> is what I found in the end]

It is the correct one.

> 
> This chip doesn't sit on any I/O port range, it is 8kB
> of direct-mapped standard SRAM stuff.  There must be
> some latches or such on your board, or perhaps this is
> driven via some superio chip or something like that.

Indeed, the latches are a bit hard to find (they are inside a 
Lattice chip), and the data byte is directly connected to the 
ISA bus of the PIB (W83C553 / W53C554).

On some variants of the board, there is not even a superIO chip
(only a discrete UART, TL16C550 or similar).

> 
> >Actually I wonder
> >whether using PNP0B00 is correct in the residual data here.
> 
> It's not correct at all, no.

Ok. I don't know well the PNP spec. I don't really remember
also what the chip identification means in the residual data,
but it is always MOT3040. OTOH, there is a but in more
recent versions, that claims that the NVRAM data size is
32768 and not 8192...

> 
> Not sure how best to describe this thing -- one master
> node with a kid for both nvram and rtc; one node; or
> perhaps one node for rtc, with a child node for nvram.
> 

Hey, at least you now understand why I was asking the question :-)
This is the only device on these boards that really causes
me trouble, for all the others I think I can get a reasonable
description in the device tree. 

	Gabriel

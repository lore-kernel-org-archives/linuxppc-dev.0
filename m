Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 04748DDE3C
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Jun 2007 21:42:44 +1000 (EST)
In-Reply-To: <20070603101052.GA3313@iram.es>
References: <1180734314.5674.49.camel@rhino>
	<4fb92a9dfccf515bdc1522d08f10f823@kernel.crashing.org>
	<20070602085359.GA10333@iram.es>
	<3ebd6ca6877ea74925f066ff96ac81db@kernel.crashing.org>
	<20070602195308.GA21618@iram.es>
	<12ad593bd17f769e44f05bc24eac4d0a@kernel.crashing.org>
	<1180828907.14025.37.camel@localhost.localdomain>
	<28e0600256815f93db45b2f4eb2d9df5@kernel.crashing.org>
	<20070603083339.GB2157@iram.es>
	<34eddd7ce58e7983017077454d592332@kernel.crashing.org>
	<20070603101052.GA3313@iram.es>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ee4d3e25c4b6ede84483399249929632@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
Date: Sun, 3 Jun 2007 13:42:22 +0200
To: Gabriel Paubert <paubert@iram.es>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> This said, I'm looking at device trees right now, and I can 
>>> understand
>>> that interrupt-parent of the 8259 is &mpic in mpc8641_hpcn.dts, but
>>> I don't understand at all why it is &pci1 on the mpc85??cds.dts.
>>
>> Perhaps the 8259 IRQ output is routed to a PCI
>> interrupt.  If not, this is just plain wrong.
>
> Maybe, but it ultimately has to go the mpic, no?

Yes, certainly.  A PowerPC CPU has only one connection
to one interrupt controller, everything else hangs below
that one.

>> I have no idea what this whole 8259-ack thing is
>> so I cannot comment further.
>
> It is a way to fetch the vector from the interrupt controller.

[big snip]

Thanks, I did know that stuff, just not the device
tree property :-)

But a great explanation anyway.

> If you need more details, ask me.

That was quite detailed enough, heh :-)

> Now a question: how would you describe the nvram and RTC
> on the PreP boards that I have?
>
> In the residual data I have:
>
> ISA Device, Slot 0, LogicalDev 0: IBM0008, SystemPeripheral, NVRAM, 
> #-1, IndirectNVRAM
>   Device flags 2800: Integrated, Static
>   Packets describing allocated resources:
>     Variable (16 decoded bits) I/O port
>       from 0x0074 to 0x0074, alignment 1, 2 ports
>     Variable (16 decoded bits) I/O port
>       from 0x0077 to 0x0077, alignment 1, 1 ports

This is an IBM NVRAM thing -- write address to ISA I/O
0x74/0x75, read/write a byte from 0x76.

This node should be a child of the "isa" (or isa
compatible) bus, and look something like this:

nvram@i74 {
	device_type = "nvram";
	regs = <1 74 3>;
	compatible = "whatever-chip-this-is";
	#bytes = <2000>; // 8kB, just an example
}

> ISA Device, Slot 0, LogicalDev 0: PNP0B00, SystemPeripheral, 
> RealTimeClock, #-1, interface 129
>   Device flags 2800: Integrated, Static
>   Packets describing allocated resources:
>     Variable (16 decoded bits) I/O port
>       from 0x0074 to 0x0074, alignment 1, 2 ports
>     Variable (16 decoded bits) I/O port
>       from 0x0077 to 0x0077, alignment 1, 1 ports
>     Chip identification: MOT3040
>     Small vendor item type 0x00, data (hex): 01 f8 1f 00 00

The I/O port numbers here are wrong.

rtc@i70 {
	device_type = "rtc";
	reg = <1 70 2>;
	compatible = "pnpPNP,b00";
}

You might want to set the register range to 4 in both
cases, esp. if the chip actually decodes those ranges;
there are no useful registers there though (AFAIK).

> It is the same chip that has the NVRAM and the RTC, only that
> the last 8 bytes of the NVRAM change with time. I've not found
> the last "Small vendor item" described in any doc, but it looks
> like a byte of 1, followed by the offset of the RTC inside the
> NVRAM in little-endian byte order.
>
> But essentially the problem is that I have two logically
> different devices in the same chip.

That isn't a problem -- logically they are both children
of the ISA bus, just describe them like that.  This is
done all the time, just look at some SoC tree ;-)

> Of course the size of
> the nvram should be somewhere (8k-8, starting at 0).

It's implicit from the chip type; the Device Support
Extensions recommended practice defines the "#bytes"
property for nvram devices though.


Segher

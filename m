Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 31563DDE44
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Jun 2007 22:44:04 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Sun, 3 Jun 2007 14:43:57 +0200
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
Message-ID: <20070603124357.GA6419@iram.es>
References: <20070602085359.GA10333@iram.es>
	<3ebd6ca6877ea74925f066ff96ac81db@kernel.crashing.org>
	<20070602195308.GA21618@iram.es>
	<12ad593bd17f769e44f05bc24eac4d0a@kernel.crashing.org>
	<1180828907.14025.37.camel@localhost.localdomain>
	<28e0600256815f93db45b2f4eb2d9df5@kernel.crashing.org>
	<20070603083339.GB2157@iram.es>
	<34eddd7ce58e7983017077454d592332@kernel.crashing.org>
	<20070603101052.GA3313@iram.es>
	<ee4d3e25c4b6ede84483399249929632@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ee4d3e25c4b6ede84483399249929632@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jun 03, 2007 at 01:42:22PM +0200, Segher Boessenkool wrote:
> >>>This said, I'm looking at device trees right now, and I can 
> >>>understand
> >>>that interrupt-parent of the 8259 is &mpic in mpc8641_hpcn.dts, but
> >>>I don't understand at all why it is &pci1 on the mpc85??cds.dts.
> >>
> >>Perhaps the 8259 IRQ output is routed to a PCI
> >>interrupt.  If not, this is just plain wrong.
> >
> >Maybe, but it ultimately has to go the mpic, no?
> 
> Yes, certainly.  A PowerPC CPU has only one connection
> to one interrupt controller, everything else hangs below
> that one.
> 
> >>I have no idea what this whole 8259-ack thing is
> >>so I cannot comment further.
> >
> >It is a way to fetch the vector from the interrupt controller.
> 
> [big snip]
> 
> Thanks, I did know that stuff, just not the device
> tree property :-)
> 
> But a great explanation anyway.
> 
> >If you need more details, ask me.
> 
> That was quite detailed enough, heh :-)
> 
> >Now a question: how would you describe the nvram and RTC
> >on the PreP boards that I have?
> >
> >In the residual data I have:
> >
> >ISA Device, Slot 0, LogicalDev 0: IBM0008, SystemPeripheral, NVRAM, 
> >#-1, IndirectNVRAM
> >  Device flags 2800: Integrated, Static
> >  Packets describing allocated resources:
> >    Variable (16 decoded bits) I/O port
> >      from 0x0074 to 0x0074, alignment 1, 2 ports
> >    Variable (16 decoded bits) I/O port
> >      from 0x0077 to 0x0077, alignment 1, 1 ports
> 
> This is an IBM NVRAM thing -- write address to ISA I/O
> 0x74/0x75, read/write a byte from 0x76.

Data is 0x77 actually. Port 0x76 systematically returns 0xff
on this board (I have one at hand right now and am doing
accesses with the firmware).

> 
> This node should be a child of the "isa" (or isa
> compatible) bus, and look something like this:
> 
> nvram@i74 {
> 	device_type = "nvram";
> 	regs = <1 74 3>;
> 	compatible = "whatever-chip-this-is";
> 	#bytes = <2000>; // 8kB, just an example
> }
> 
> >ISA Device, Slot 0, LogicalDev 0: PNP0B00, SystemPeripheral, 
> >RealTimeClock, #-1, interface 129
> >  Device flags 2800: Integrated, Static
> >  Packets describing allocated resources:
> >    Variable (16 decoded bits) I/O port
> >      from 0x0074 to 0x0074, alignment 1, 2 ports
> >    Variable (16 decoded bits) I/O port
> >      from 0x0077 to 0x0077, alignment 1, 1 ports
> >    Chip identification: MOT3040
> >    Small vendor item type 0x00, data (hex): 01 f8 1f 00 00
> 
> The I/O port numbers here are wrong.

No they aren't. It uses exactly the same port as for the NVRAM.

Otherwise the "feature" of this RTC is that its interrupt
is not connected. 

> 
> rtc@i70 {
> 	device_type = "rtc";
> 	reg = <1 70 2>;
> 	compatible = "pnpPNP,b00";
> }
> 

Nope, there is nothing at 0x70-0x71 (read returns 0xff). The chip
is a 48T59. Look in prep_setup.c in arch/ppc/platforms.
Motorola and IBM boards use different RTC. 

The lines: 

	} else {
		TODC_INIT(TODC_TYPE_MK48T59, PREP_NVRAM_AS0, PREP_NVRAM_AS1,
				PREP_NVRAM_DATA, 8);
	}

show that it uses the same addresses as the nvram. Actually I wonder 
whether using PNP0B00 is correct in the residual data here. 

	Gabriel

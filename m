Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 072EDDDDF3
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 00:42:49 +1000 (EST)
In-Reply-To: <20070603124357.GA6419@iram.es>
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
	<20070603124357.GA6419@iram.es>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3ffee021f3b721bde0253b1310d4958a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
Date: Sun, 3 Jun 2007 16:42:38 +0200
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

>> This is an IBM NVRAM thing -- write address to ISA I/O
>> 0x74/0x75, read/write a byte from 0x76.
>
> Data is 0x77 actually. Port 0x76 systematically returns 0xff
> on this board (I have one at hand right now and am doing
> accesses with the firmware).

Oh okay, I don't know exactly what chip this is so
obviously my information isn't 100% ;-)

>>> ISA Device, Slot 0, LogicalDev 0: PNP0B00, SystemPeripheral,
>>> RealTimeClock, #-1, interface 129
>>>  Device flags 2800: Integrated, Static
>>>  Packets describing allocated resources:
>>>    Variable (16 decoded bits) I/O port
>>>      from 0x0074 to 0x0074, alignment 1, 2 ports
>>>    Variable (16 decoded bits) I/O port
>>>      from 0x0077 to 0x0077, alignment 1, 1 ports
>>>    Chip identification: MOT3040
>>>    Small vendor item type 0x00, data (hex): 01 f8 1f 00 00
>>
>> The I/O port numbers here are wrong.
>
> No they aren't. It uses exactly the same port as for the NVRAM.

Then its claim to be PNP 0b00 is incorrect.

> Otherwise the "feature" of this RTC is that its interrupt
> is not connected.

Dunno what you mean here?

>> rtc@i70 {
>> 	device_type = "rtc";
>> 	reg = <1 70 2>;
>> 	compatible = "pnpPNP,b00";
>> }
>>
>
> Nope, there is nothing at 0x70-0x71 (read returns 0xff). The chip
> is a 48T59.

[Not so easy to find a datasheet for that -- STM M48T59Y
is what I found in the end]

This chip doesn't sit on any I/O port range, it is 8kB
of direct-mapped standard SRAM stuff.  There must be
some latches or such on your board, or perhaps this is
driven via some superio chip or something like that.

> Actually I wonder
> whether using PNP0B00 is correct in the residual data here.

It's not correct at all, no.

Not sure how best to describe this thing -- one master
node with a kid for both nvram and rtc; one node; or
perhaps one node for rtc, with a child node for nvram.


Segher

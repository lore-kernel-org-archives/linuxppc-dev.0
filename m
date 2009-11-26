Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 99E22B7BC5
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 09:38:13 +1100 (EST)
In-Reply-To: <1259210722.16367.256.camel@pasglop>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1259210722.16367.256.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4F4383E1-CE64-4A6A-BCD4-C1C68F8802E6@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 04/19] powerpc: wii: device tree
Date: Thu, 26 Nov 2009 23:45:08 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Albert Herranz <albert_herranz@yahoo.es>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> +/memreserve/ 0x01800000 0xe800000;	/* memory hole (includes I/O  
>> area) */
>> +/memreserve/ 0x10000000 0x0004000;	/* DSP RAM */
>
> Weird layout... nothing you can do about I suppose.
>
> Out of curiosity, what is that DSP RAM ? Some actual DSP core  
> somewhere
> in the IO chip setup to use memory from up there ?

It's an actual DSP yes, and it seems it uses that fixed address range
(at the start of the 64MB GDDR3 memory) always.  So we have to stay
away from that memory range.

>> +	memory {
>> +		device_type = "memory";
>> +		/* MEM1 + memory hole + MEM2 - firmware/buffers area */
>> +		reg = <0x00000000 0x133e0000>;
>> +	};
>
> So we do have a nasty hole here in the middle. How bad it is if you  
> try
> to just have two ranges in there (ie as if it was discontiguous) ?

Not bad at all.  There is no "as if" -- it _is_ discontiguous memory,
they are totally different memory technology even.

>> +		/* Team Twiizers' 'mini' firmware IPC */
>
> Out of curiosity, what are these ? :-)

There is an embedded ARM9 in the Hollywood.  It is "the boss" of the
system, not the PowerPC.  "mini" is the name of the code we run on it.

There is a hardware IPC interface between the ARM and the PowerPC (just
a bunch of doorbells and general purpose regs).

> Similar comment as before, could the above be dynamically probed ? If
> you are not a hacker you may not need that at all to use some linux
> based piece of SW on the wii right ?

Yeah.  Well, after any other drivers have been merged, anyway, heh :-)

>> +		ohci1@0d060000 {
>
> Why the "1" ?

Right, call them both just "ohci" please.  Or "usb" even.

>> +		PIC1: pic1@0d800030 {
>> +			#interrupt-cells = <1>;
>> +			compatible = "nintendo,hollywood-pic";
>> +			reg = <0x0d800030 0x8>;
>> +			interrupt-controller;
>> +			interrupts = <14>;
>> +			interrupt-parent = <&PIC0>;
>> +		};
>
> Ah, a cascaded PIC, fun fun fun

Well at least this cascaded PIC is sane, the root PIC is less so :-P

>> +		hollywood-ahbprot@0d800064 {
>> +			compatible = "nintendo,hollywood-ahbprot";
>> +			reg = <0x0d800064 0x4>;
>> +		};
>
> What is this ?

Most of the devices new in Hollywood (AES engine, NAND engine, USB,
SD, etc.) sit on an AHB bus.  The AHBPROT register is used to configure
which of these can be accessed from the PowerPC.

Modern "mini" always gives us full control.  Also, there is no reason
to single out the AHBPROT reg in the device tree like this, anyway.


Segher

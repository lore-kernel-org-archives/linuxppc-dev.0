Return-Path: <acahalan@gmail.com>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by ozlabs.org (Postfix) with ESMTP id 4AA24B70A7
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Oct 2010 23:05:47 +1100 (EST)
Received: by fxm2 with SMTP id 2so3876922fxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 05 Oct 2010 05:05:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1286266201.2463.336.camel@pasglop>
References: <AANLkTikPhpvJetY+NDFggYE6Wp6ppyt2BLmzEbsiwHuZ@mail.gmail.com>
	<63799.84.105.60.153.1286166325.squirrel@gate.crashing.org>
	<1286266201.2463.336.camel@pasglop>
Date: Tue, 5 Oct 2010 08:05:44 -0400
Message-ID: <AANLkTik9KeVzc6T7U=TX1bSA934Wmtbt4cjHrWSgWtLn@mail.gmail.com>
Subject: Re: use of BAT before taking over the MMU
From: Albert Cahalan <acahalan@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 5, 2010 at 4:10 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Mon, 2010-10-04 at 06:25 +0200, Segher Boessenkool wrote:
>> > On the prom boot path, with the firmware supposed to
>> > be managing the MMU, there is a case where:
>> >
>> > 1. Linux changes some BAT registers.
>> > 2. Bits 0x00000070 are/become set in the MSR.
>> > 3. Linux takes an MMU fault.
>> > 4. The firmware handles it.
>> >
>> > AFAIK, you can't expect the firmware to leave the BAT alone.
>> > If the firmware provides mapping services by using the BAT
>> > as a software-filled TLB, Linux's BAT changes may be lost.
>> >
>> > You also can't expect that your BAT changes will not conflict
>> > with mappings that the firmware uses for itself. The firmware
>> > might write to your new BAT mapping, relying on those virtual
>> > addresses to be something else entirely.
>>
>> The PowerPC OF binding requires the firmware to save and restore
>> the BATs on entry to / exit from the firmware.

That would defeat the purpose of setting them.
They are used to provide Linux with mappings.

> I'm not sure he was talking about OF here... In any case, we don't muck
> around with BATs until after we're done with OF anyways.

It's the Open Firmware client interface, not Firmworks code.
I wrote it. It just does hypervisor-like calls to an emulator which
does the real work. Essentially I have a prom_call opcode
and a handle_exception opcode. I claim to be an MPC7400.

The kernel is sitting at address 0, MSR becomes 0x70 when
an rfi goes to address 0. This will be head_32.S with r5 set,
so Linux will call prom_init to fetch the device tree.

Of course that faults immediately, so I have a handler that
loads IBAT0 with a 128 KiB mapping. I treat the BAT like a
direct-mapped software-loaded TLB. (like MIPS arch MMU)

I threw in a hack to skip to the next BAT when the chosen
one is not a 128 KiB 1:1 mapping. That seems to work, but
sure doesn't feel right.

Note that Linux can fail even with a firmware that doesn't touch
the BAT registers. The MMU is on, and 0xc0000000 may be
where the firmware expects to have... MMIO for the console,
the client interface entry point, a forth stack, whatever.
The BAT takes priority, and thus the firmware splatters stuff
right onto the kernel or dies trying to read something it left there.

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DC7A4B70A5
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Oct 2010 23:28:53 +1100 (EST)
Subject: Re: use of BAT before taking over the MMU
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Cahalan <acahalan@gmail.com>
In-Reply-To: <AANLkTik9KeVzc6T7U=TX1bSA934Wmtbt4cjHrWSgWtLn@mail.gmail.com>
References: <AANLkTikPhpvJetY+NDFggYE6Wp6ppyt2BLmzEbsiwHuZ@mail.gmail.com>
	<63799.84.105.60.153.1286166325.squirrel@gate.crashing.org>
	<1286266201.2463.336.camel@pasglop>
	<AANLkTik9KeVzc6T7U=TX1bSA934Wmtbt4cjHrWSgWtLn@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 05 Oct 2010 23:28:37 +1100
Message-ID: <1286281717.2463.343.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> >> The PowerPC OF binding requires the firmware to save and restore
> >> the BATs on entry to / exit from the firmware.
> 
> That would defeat the purpose of setting them.
> They are used to provide Linux with mappings.

How so ? As long as they are present when executing Linux code,
I don't see the problem if they contain different mappings while
inside FW...

> > I'm not sure he was talking about OF here... In any case, we don't muck
> > around with BATs until after we're done with OF anyways.
> 
> It's the Open Firmware client interface, not Firmworks code.
> I wrote it. It just does hypervisor-like calls to an emulator which
> does the real work. Essentially I have a prom_call opcode
> and a handle_exception opcode. I claim to be an MPC7400.
> 
> The kernel is sitting at address 0, MSR becomes 0x70 when
> an rfi goes to address 0. This will be head_32.S with r5 set,
> so Linux will call prom_init to fetch the device tree.

Right. Within prom_init we don't touch the BATs, we are still under FW
control at this stage.

> Of course that faults immediately,

It shouldn't but it can. When you enter Linux with an OF "client
interface" entry, you are responsible for having reasonable mappings for
executing the client code. You are allowed to fault these if you want
to, and do whatever you want, as long as the prom_init code can execute.
IE. Linux hasn't set any mappings nor BATs at this stage, it's operating
as a client program of the FW and entirely relies on the FW to provide
the necessary MMU setup until the end of prom_init.

>  so I have a handler that
> loads IBAT0 with a 128 KiB mapping. I treat the BAT like a
> direct-mapped software-loaded TLB. (like MIPS arch MMU)
> 
> I threw in a hack to skip to the next BAT when the chosen
> one is not a 128 KiB 1:1 mapping. That seems to work, but
> sure doesn't feel right.

Why would you need to do that ? Linux hasn't done anything to mappings
yet and only cares about what you have setup...

Linux will throw away your BATs etc... only after it returns from
prom_init at which point it won't call your FW anymore anyways.

> Note that Linux can fail even with a firmware that doesn't touch
> the BAT registers. The MMU is on, and 0xc0000000 may be
> where the firmware expects to have... MMIO for the console,
> the client interface entry point, a forth stack, whatever.

Right, but Linux doesn't establish nor relies on mappings at c0000000 at
this point. prom_init is relocatable code that can execute from any
address.

> The BAT takes priority, and thus the firmware splatters stuff
> right onto the kernel or dies trying to read something it left there.

I'm not entirely sure what you are doing but it certainly sounds
wrong :-)

As I said, at this stage, Linux is just a "normal" client interface
program. It's happy to run from any address you put it with any mapping
you provide until it returns from prom_init at which point it takes over
the MMU.

Ben.

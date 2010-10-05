Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D258FB70D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Oct 2010 02:27:39 +1100 (EST)
In-Reply-To: <AANLkTik9KeVzc6T7U=TX1bSA934Wmtbt4cjHrWSgWtLn@mail.gmail.com>
References: <AANLkTikPhpvJetY+NDFggYE6Wp6ppyt2BLmzEbsiwHuZ@mail.gmail.com>
	<63799.84.105.60.153.1286166325.squirrel@gate.crashing.org>
	<1286266201.2463.336.camel@pasglop>
	<AANLkTik9KeVzc6T7U=TX1bSA934Wmtbt4cjHrWSgWtLn@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <B30ADD93-5210-4FFC-A7AA-C6B21A785B09@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: use of BAT before taking over the MMU
Date: Tue, 5 Oct 2010 17:31:46 +0200
To: Albert Cahalan <acahalan@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>> The PowerPC OF binding requires the firmware to save and restore
>>> the BATs on entry to / exit from the firmware.
>
> That would defeat the purpose of setting them.
> They are used to provide Linux with mappings.

The initial state the OS has for the BATs is what the firmware
provides it with, sure.

An OS shouldn't expect to have more than its own program image
RAM mapped, in general.

> Of course that faults immediately, so I have a handler that
> loads IBAT0 with a 128 KiB mapping. I treat the BAT like a
> direct-mapped software-loaded TLB. (like MIPS arch MMU)

Just map the first 256MB and don't worry about anything else?
Seems a lot simpler to me ;-)

> Note that Linux can fail even with a firmware that doesn't touch
> the BAT registers. The MMU is on,

You can boot Linux with the MMU off as well.

> and 0xc0000000 may be
> where the firmware expects to have... MMIO for the console,
> the client interface entry point, a forth stack, whatever.
> The BAT takes priority, and thus the firmware splatters stuff
> right onto the kernel or dies trying to read something it left there.

Like I said, you're supposed to swap OS BATs with firmware BATs
in your client interface entry and exit.  You have to switch
a lot of other registers there as well already, so that's no
big deal.


Segher

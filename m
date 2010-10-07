Return-Path: <acahalan@gmail.com>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by ozlabs.org (Postfix) with ESMTP id C2F5BB6EF0
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Oct 2010 13:06:00 +1100 (EST)
Received: by fxm2 with SMTP id 2so117671fxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 06 Oct 2010 19:05:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <B30ADD93-5210-4FFC-A7AA-C6B21A785B09@kernel.crashing.org>
References: <AANLkTikPhpvJetY+NDFggYE6Wp6ppyt2BLmzEbsiwHuZ@mail.gmail.com>
	<63799.84.105.60.153.1286166325.squirrel@gate.crashing.org>
	<1286266201.2463.336.camel@pasglop>
	<AANLkTik9KeVzc6T7U=TX1bSA934Wmtbt4cjHrWSgWtLn@mail.gmail.com>
	<B30ADD93-5210-4FFC-A7AA-C6B21A785B09@kernel.crashing.org>
Date: Wed, 6 Oct 2010 22:05:56 -0400
Message-ID: <AANLkTikH-f7MCxVyWr_mrfzeooQwRqTf4pGVEFSLO4Zy@mail.gmail.com>
Subject: Re: use of BAT before taking over the MMU
From: Albert Cahalan <acahalan@gmail.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
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

On Tue, Oct 5, 2010 at 11:31 AM, Segher Boessenkool
<segher@kernel.crashing.org> wrote:

> An OS shouldn't expect to have more than its own program image
> RAM mapped, in general.

Linux actually makes calls to allocate more. I'm thankful
that Linux always specifies an address, so I was able to
get away with simply returning success. I wonder how this
works for a firmware implementation that resides in RAM,
using the memory that Linux demands. Must the firmware
move itself out of the way?

>> Of course that faults immediately, so I have a handler that
>> loads IBAT0 with a 128 KiB mapping. I treat the BAT like a
>> direct-mapped software-loaded TLB. (like MIPS arch MMU)
>
> Just map the first 256MB and don't worry about anything else?
> Seems a lot simpler to me ;-)

I was expecting that Linux would demand plenty of mappings,
including small ones and ones for IO. I was preparing myself
for that.

>> Note that Linux can fail even with a firmware that doesn't touch
>> the BAT registers. The MMU is on,
>
> You can boot Linux with the MMU off as well.

That wasn't obvious for the prom_init path. IEEE docs seemed
to suggest that the firmware must provide MMU handling.

>> and 0xc0000000 may be
>> where the firmware expects to have... MMIO for the console,
>> the client interface entry point, a forth stack, whatever.
>> The BAT takes priority, and thus the firmware splatters stuff
>> right onto the kernel or dies trying to read something it left there.
>
> Like I said, you're supposed to swap OS BATs with firmware BATs
> in your client interface entry and exit. =A0You have to switch
> a lot of other registers there as well already, so that's no
> big deal.

Well no. This isn't real hardware. My prom entry point looks
something like this:

eciwx r0,r0,r0
blr

My ISI and DSI handlers look something like this:

ecowx r0,r0,r0
rfi

The firmware doesn't need **any** registers. It's magic. I was
just using the BAT registers to map what Linux wanted mapped.

Anyway, I'm no longer able to reproduce the problem. I think
something unrelated was causing strange behavior. This is a
bit of a surprise since I would've expected a crash. Oh well.

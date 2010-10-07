Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C76E0B70A8
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Oct 2010 19:00:18 +1100 (EST)
Subject: Re: use of BAT before taking over the MMU
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Cahalan <acahalan@gmail.com>
In-Reply-To: <AANLkTikH-f7MCxVyWr_mrfzeooQwRqTf4pGVEFSLO4Zy@mail.gmail.com>
References: <AANLkTikPhpvJetY+NDFggYE6Wp6ppyt2BLmzEbsiwHuZ@mail.gmail.com>
	<63799.84.105.60.153.1286166325.squirrel@gate.crashing.org>
	<1286266201.2463.336.camel@pasglop>
	<AANLkTik9KeVzc6T7U=TX1bSA934Wmtbt4cjHrWSgWtLn@mail.gmail.com>
	<B30ADD93-5210-4FFC-A7AA-C6B21A785B09@kernel.crashing.org>
	<AANLkTikH-f7MCxVyWr_mrfzeooQwRqTf4pGVEFSLO4Zy@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 07 Oct 2010 19:00:03 +1100
Message-ID: <1286438403.2463.377.camel@pasglop>
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

On Wed, 2010-10-06 at 22:05 -0400, Albert Cahalan wrote:
> On Tue, Oct 5, 2010 at 11:31 AM, Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> 
> > An OS shouldn't expect to have more than its own program image
> > RAM mapped, in general.
> 
> Linux actually makes calls to allocate more. I'm thankful
> that Linux always specifies an address, so I was able to
> get away with simply returning success. I wonder how this
> works for a firmware implementation that resides in RAM,
> using the memory that Linux demands. Must the firmware
> move itself out of the way?

No, Linux will retry somewhere else :-)

> >> Of course that faults immediately, so I have a handler that
> >> loads IBAT0 with a 128 KiB mapping. I treat the BAT like a
> >> direct-mapped software-loaded TLB. (like MIPS arch MMU)
> >
> > Just map the first 256MB and don't worry about anything else?
> > Seems a lot simpler to me ;-)
> 
> I was expecting that Linux would demand plenty of mappings,
> including small ones and ones for IO. I was preparing myself
> for that.

No, not during prom_init. It's really just a trampoline code that sucks
out the device-tree and does a few other things. Once that's complete,
Linux takes over the MMU and from that point on, your FW is dead.

> >> Note that Linux can fail even with a firmware that doesn't touch
> >> the BAT registers. The MMU is on,
> >
> > You can boot Linux with the MMU off as well.
> 
> That wasn't obvious for the prom_init path. IEEE docs seemed
> to suggest that the firmware must provide MMU handling.

1275 powerpc binding specifies both mode of operations. Linux doesn't
care which one is active

> >> and 0xc0000000 may be
> >> where the firmware expects to have... MMIO for the console,
> >> the client interface entry point, a forth stack, whatever.
> >> The BAT takes priority, and thus the firmware splatters stuff
> >> right onto the kernel or dies trying to read something it left there.
> >
> > Like I said, you're supposed to swap OS BATs with firmware BATs
> > in your client interface entry and exit.  You have to switch
> > a lot of other registers there as well already, so that's no
> > big deal.
> 
> Well no. This isn't real hardware. My prom entry point looks
> something like this:
> 
> eciwx r0,r0,r0
> blr
> 
> My ISI and DSI handlers look something like this:
> 
> ecowx r0,r0,r0
> rfi
> 
> The firmware doesn't need **any** registers. It's magic. I was
> just using the BAT registers to map what Linux wanted mapped.

Which is really just what any client program wants: You start with the
program ELF sections, and whatever it allocates with claim() calls.

> Anyway, I'm no longer able to reproduce the problem. I think
> something unrelated was causing strange behavior. This is a
> bit of a surprise since I would've expected a crash. Oh well.

Hard to tell from my side :-) But as I said, Linux doesn't rely on any
mapping at c0000000 or any BAT at this point. By the time it sets up
BATs the firmware is long gone and Linux is fully in control of the MMU.

Cheers,
Ben.

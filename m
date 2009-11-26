Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 240A61007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 08:01:11 +1100 (EST)
Subject: Re: [RFC PATCH 04/19] powerpc: wii: device tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Herranz <albert_herranz@yahoo.es>
In-Reply-To: <4B0E9C5F.50304@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<49436.84.105.60.153.1259171377.squirrel@gate.crashing.org>
	<1259211061.16367.260.camel@pasglop>  <4B0E9C5F.50304@yahoo.es>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 27 Nov 2009 08:01:05 +1100
Message-ID: <1259269265.18084.14.camel@pasglop>
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


> > Good point. I can't even guarantee that the kernel will work reliably
> > with nobats :-) At least you really want the kernel .text to be fully
> > covered by an IBAT.
> > 
> 
> It works with nobats.

But does it work -reliably- ? :-)

I haven't looked at that for years, but we used to have a subtle issue
if you happen to take a hash miss on the kernel text or data in the
wrong time, such as when SRR0/SRR1 are modified and before a subsequent
rfi. This is very very hard to trigger and maybe impossible without SMP
but to keep in mind.

Paulus added some code ages ago to close most of these by using the
MSR:RI bit so that the hash code could detect the situation and branch
to some "recovery" code, but from memory, while that dealt with missing
D-BATs, we still had a potential window of problem if the kernel text
itself wasn't entirely covered.

Any ways, not a big deal right now, as I said, we really want the BATs
for performances anyways, so we should probably just add some kind of
hack in mmu_mapin_ram() for the time being.

> I must say that all the patches posted (and the device drivers, which haven't
> been posted yet) are tested and working code.

That was my impression too, but in this case, I'm talking about a
potential very hard to hit problem that you may well have never managed
to actually trigger.

> There you can find the hardware interface that supports the IPC mechanism.
> It is made up of a pair of registers to pass data between the processors and a
> pair of control/flags registers.
> The hardware can interrupt the PowerPC side when there is data available for it.

Ok. So the right way to do that would be to have a node purely
representing the HW IPC, unrelated to whatever is running on the
secondary processor.

However, it's ok to have -below- that node, a set of device nodes or a
node with properties or whatever representing the FW in there and the
function it exposes.

That can be discussed later tho. I'm not that keen on having those info
be in the .dts coming with the kernel since those functions essentially
depend on what FW is loaded on the aux. processor.

What might do however is to have a way for that FW itself to provide you
with the nodes and properties for the functions it provides :-) Then you
can have the boot wrapper or the kernel platform init code use some well
defined (and as stable as possible) IPC API to identify the FW there and
expose all that stuff.

Of course that wouldn't work with FW we don't have control on. Can Linux
run on the wii with the original N. FW on the aux. processor ? Can we
detect what is running there ? Do we care ?

> It is what Nintendo calls the "Serial Interface" (SI) which is a proprietary
> serial hardware to drive the gamepads (and a custom keyboard too, once available
> for an RPG game).

So I would give it a different name than "serial" then. Make it gpsi
maybe ? (game pad serial interface ?) :-) Or invent something else...

Cheers,
Ben.

> > Cheers,
> > Ben.
> > 
> 
> Thanks,
> Albert

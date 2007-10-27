Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 74D8FDDE32
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 27 Oct 2007 11:31:02 +1000 (EST)
Subject: Re: Apparent kernel bug with GDB on ppc405
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matt Mackall <mpm@selenic.com>
In-Reply-To: <20071026144134.GW19691@waste.org>
References: <20071024194640.GB19691@waste.org>
	<1193363202.7018.36.camel@pasglop>
	<fa686aa40710251945l51604c5vdf0b49b03b9a1a57@mail.gmail.com>
	<1193369005.7018.46.camel@pasglop> <20071026144134.GW19691@waste.org>
Content-Type: text/plain
Date: Sat, 27 Oct 2007 11:30:53 +1000
Message-Id: <1193448653.18243.9.camel@pasglop>
Mime-Version: 1.0
Cc: gdb@sourceware.org, linuxppc-embedded@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Fri, 2007-10-26 at 09:41 -0500, Matt Mackall wrote:
> On Fri, Oct 26, 2007 at 01:23:25PM +1000, Benjamin Herrenschmidt
> wrote:
> > 
> > > This is actually 405.  Does that have the same issue?
> > 
> > hrm... I don't remember :-) There -is- something fishy about the
> icache
> > on 405 but I don't remember for sure. Try sticking an iccci in there
> and
> > tell us if that helps.
> 
> I did. I stuck an iccci -and- a dccci loop in. I threw in the tlbia
> when I ran out of other ideas. And the tlbia + existing
> flush_icache_range appears to be sufficient (tested on a non-trivial
> app).
> 
> According to my docs, the 405fx's icache is virtually
> indexed/physically mapped, while the dcache is phys/phys.

I think there is a bug in the 40x/44x support at this stage, it only
doing invalidations for the current PID. That means that a process
trying to invalidate TLB entries of another address space will fail to
do so ... oops.

That can be fixed by adding a pid argument to to _tlbie, and using it in
the assembly. In the 40x case, probably by switching SPRN_PID to that
and then back, in the 44x case, by using that value instead of SPRN_PID
for the MMUCR register.

It's part of a patche I have around taking dirt that rework signficantly
the 44x (though not the 40x yet) TLB handling, cleaning things and
fixing bugs (such as this one, I remember it now). I need to spend a bit
of time to clean it up, remove some experimental stuff from it, and
submit it.

I'll try to do that early next week, and maybe come up with a fix for
that specific bug today or tomorrow.

Ben.

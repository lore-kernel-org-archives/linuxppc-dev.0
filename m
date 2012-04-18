Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3EB9DB6EF1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2012 21:23:40 +1000 (EST)
Message-ID: <1334748206.3143.17.camel@pasglop>
Subject: Re: PowerPC radeon KMS - is it possible?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Date: Wed, 18 Apr 2012 21:23:26 +1000
In-Reply-To: <1334746446.5989.300.camel@thor.local>
References: <BAY163-W54EBB2437ED2068EF5AF5D03F0@phx.gbl>
 <1334732346.1159.5.camel__22339.9641145535$1334732429$gmane$org@pasglop>
 <m2pqb5bhyo.fsf@igel.home> <1334745338.3143.3.camel@pasglop>
 <1334745439.3143.5.camel@pasglop> <1334746446.5989.300.camel@thor.local>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, o jordan <ojordan12345@hotmail.co.uk>,
 Andreas Schwab <schwab@linux-m68k.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-04-18 at 12:54 +0200, Michel Dänzer wrote:
> On Mit, 2012-04-18 at 20:37 +1000, Benjamin Herrenschmidt wrote: 
> > On Wed, 2012-04-18 at 20:35 +1000, Benjamin Herrenschmidt wrote:
> > > On Wed, 2012-04-18 at 09:46 +0200, Andreas Schwab wrote:
> > > > Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> > > > 
> > > > > Note also that KMS doesn't afaik have the power management code that
> > > > > radeonfb has for those old Mac chipsets, so suspend/resume won't work.
> > > > 
> > > > How hard would it be to add it?
> > > 
> > > The code itself is relatively self contained, but the KMS power
> > > management side is a bit ... messy :-)
> 
> That's an interesting way to put it, given the hacks to make it work
> between radeonfb and uninorth_agp. :) (Which are complicating making at
> least hibernation work with KMS on uninorth_agp)

Oh, I forgot about the AGP hooks indeed... but even that, it's in arch
code so it's not necessarily a huge deal to move it over. IE. It's just
a function pointer to call at the right time that's exported by the
arch.

> In contrast, radeon KMS uses the standard Linux device suspend/resume
> hooks.

Well, as radeonfb does.

The hack with AGP is so that radeonfb gets to control when the AGP is
suspended/restored  as it needs to be done in a specific order and the
device model doesn't provide the right ordering (they are sibling
devices).

There's also an early-wakeup hack but that's orthogonal, it's mostly
useful for debugging and doesn't necessarily need to be ported over.
  
> > Argh... bloody x220 touchpad...
> > 
> > So I was saying, there's also some duplication in the area of dynamic
> > clocks configuration. Some of this could be an issue as afaik, to work
> > reliably, the suspend/resume code really wants the stuff to be setup
> > exactly the way the code in radeon_pm does....
> 
> Are you referring to radeon_pm in radeonfb or radeon KMS?

radeonfb.

> Most of the latter isn't used on PPC laptops because it relies on an x86
> video BIOS.

Right, we might be able to easily port my old code over by simply making
it ppc specific. In radeonfb, it's also used for some thinkpads among
others but KMS does that with the BIOS on these no ? (ie. D2 state).

Cheers,
Ben.

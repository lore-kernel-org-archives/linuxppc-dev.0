Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3647CB6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2012 08:25:53 +1000 (EST)
Message-ID: <1334787940.3143.22.camel@pasglop>
Subject: Re: PowerPC radeon KMS - is it possible?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Date: Thu, 19 Apr 2012 08:25:40 +1000
In-Reply-To: <1334754428.5989.308.camel@thor.local>
References: <BAY163-W54EBB2437ED2068EF5AF5D03F0@phx.gbl>
 <1334732346.1159.5.camel__22339.9641145535$1334732429$gmane$org@pasglop>
 <m2pqb5bhyo.fsf@igel.home> <1334745338.3143.3.camel@pasglop>
 <1334745439.3143.5.camel@pasglop> <1334746446.5989.300.camel@thor.local>
 <1334748206.3143.17.camel@pasglop> <1334754428.5989.308.camel@thor.local>
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

On Wed, 2012-04-18 at 15:07 +0200, Michel Dänzer wrote:
> On Mit, 2012-04-18 at 21:23 +1000, Benjamin Herrenschmidt wrote: 
> > 
> > Right, we might be able to easily port my old code over by simply making
> > it ppc specific. In radeonfb, it's also used for some thinkpads among
> > others but KMS does that with the BIOS on these no ? (ie. D2 state).
> 
> KMS doesn't have any non-BIOS suspend/resume code yet, so it's either
> that or no suspend/resume. :)

Sure, my point is I don't know what happens on those old thinkpads, ie,
what does the BIOS provides to KMS and whether it's a good enough
alternative to the "hand made" D2 approach radeonfb used on them.

But heh, I'm happy to just ignore those, that would make things easier,
in which case we can just have a non-bios pair of suspend/resume calls
provided as empty weak functions, and have a radeon_mac_pm.c providing
more/less the existing radeonfb code for power macs overriding those
weak functions.

If it's mac-only it's going to be easier to deal with.

Cheers,
Ben.

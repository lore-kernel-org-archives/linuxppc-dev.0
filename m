Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 60806DDDF8
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Sep 2007 08:49:18 +1000 (EST)
Subject: Re: Powerbook shuts down hard when hot, patch found
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Buesch <mb@bu3sch.de>
In-Reply-To: <200709300026.07219.mb@bu3sch.de>
References: <200709282332.52819.mb@bu3sch.de>
	<200709292353.06476.mb@bu3sch.de> <1191104393.28637.5.camel@pasglop>
	<200709300026.07219.mb@bu3sch.de>
Content-Type: text/plain
Date: Sun, 30 Sep 2007 08:49:05 +1000
Message-Id: <1191106145.28637.11.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sun, 2007-09-30 at 00:26 +0200, Michael Buesch wrote:
> On Sunday 30 September 2007 00:19:53 Benjamin Herrenschmidt wrote:
> > 
> > > 
> > > This all smells to me like a silicon bug, so I'd start searching
> > > in the silicon erratas. But I'm not sure, of course. It's also strange
> > > that it depends on temperature. (That's why I first expected the PMU
> > > would cause this).
> > > 
> > > Thanks for your help.
> > 
> > Could be that we are creating a short by driving the output low, thus
> > causing the silicon to heat up, but that's strange.
> 
> Well. The machine needs to be hot in the first place to trigger it.
> If it's cold it boots and runs fine even with that patch.
> Even if I run it hot after boot it does not shutdown. It only shuts down
> on boot when this register is written and when it's hot at this point.

Well, it's possible that they have a too weak pull-up resistor on those
lines, and thus when asserted to 0, a significant current goes through
causing the whole thing to heat up. That heat added to the residual heat
of a hot boot becomes then enough to trigger the temperature sensor
threshold... just one possible explanation.

> That's why I thought about some silicon bug. Why only when it's hot? :)
> 
> > Also, the other change I made you do turns these into inputs, thus the
> 
> The _EN bits are already all cleared, as you can see in my printk dump.
> So clearing them has no effect, of course.
> So the ports are Inputs as default on boot.

Hrm, that's weird then, because in that case, changing the output bits
shouldn't have any effect, unless maybe on some chips, the EN bits are
flipped. I don't have anything specific about the rv350 tho.

Can you print which specific DDC register is doing that (it's called
twice right ?) and maybe do a patch preventing that write only for one
of them and let me know if it makes a difference.

> > DDL lines should be pulled up, unless ... the board doesn't have
> > pullups.
> 
> Well, I can't tell you :)

Heh

Ben.

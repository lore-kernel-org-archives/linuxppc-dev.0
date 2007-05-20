Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4293EDDE10
	for <linuxppc-dev@ozlabs.org>; Mon, 21 May 2007 01:02:46 +1000 (EST)
Message-ID: <4650632B.1010702@genesi-usa.com>
Date: Sun, 20 May 2007 16:03:07 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2.6.21-rt2] PowerPC: decrementer clockevent driver
References: <200705172142.26739.sshtylyov@ru.mvista.com>	<8E44DB06-767D-4864-8D2C-6132E4D4370B@kernel.crashing.org>	<464C99FF.8080404@ru.mvista.com>	<135307ED-7125-4859-8594-4B5B900D92D6@kernel.crashing.org>	<1179500217.20519.53.camel@imap.mvista.com>	<464DC0DC.7050809@ru.mvista.com>	<1179502773.20519.56.camel@imap.mvista.com>	<17998.28659.702653.237011@cargo.ozlabs.ibm.com>	<1179628991.20925.2.camel@imap.mvista.com>
	<1179630190.32247.534.camel@localhost.localdomain>
In-Reply-To: <1179630190.32247.534.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	tglx@linutronix.de, mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Benjamin Herrenschmidt wrote:
> On Sat, 2007-05-19 at 19:43 -0700, Daniel Walker wrote:
> 
>> In terms of clocksources, gettimeofday() would have to switch to another
>> clocksource if the decrementer started to act that way .. That's why it
>> is possible to register more than one clocksource, to allow for the
>> switching. The decrementer frequency doesn't change even with cpufreq? 
> 
> It's more than just gettimeofday. The linux ppc kernel port has strong
> assumptions all over the place that the timbase and decrementer (which
> always tick at the same rate) have a constant frequency. It might be
> possible to "fix" those assumptions but right now, that is the case.
> 
> For example, nowadays, udelay() also uses the timebase. Not only
> gettimeofday() & friends. The scheduler ticking too. The precise process
> accounting as well, etc...

So.. if we get enough clocksources into the tree, can any of those
parts of the code be reworked to use clocksources/clockevents and
hrtimers quickly and easily? I noticed the patch just posted does
some of it.. but not as much as Ben just mentioned.

Or is it a development nightmare?

I'm fairly sure on a PPC970 box even though the decrementer is
monotonic and never changes frequency, one day it just might, and
it would be better to anticipate this (and allow people to
distribute their timing requirements across an entire system
and not just the CPU core anyway, which I think is probably a
good thing from a system integration and possibly the point of
view of redundancy..)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

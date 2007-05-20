Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4C887DDE3A
	for <linuxppc-dev@ozlabs.org>; Mon, 21 May 2007 07:26:33 +1000 (EST)
Subject: Re: [PATCH 2.6.21-rt2] PowerPC: decrementer clockevent driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matt Sealey <matt@genesi-usa.com>
In-Reply-To: <4650632B.1010702@genesi-usa.com>
References: <200705172142.26739.sshtylyov@ru.mvista.com>
	<8E44DB06-767D-4864-8D2C-6132E4D4370B@kernel.crashing.org>
	<464C99FF.8080404@ru.mvista.com>
	<135307ED-7125-4859-8594-4B5B900D92D6@kernel.crashing.org>
	<1179500217.20519.53.camel@imap.mvista.com>
	<464DC0DC.7050809@ru.mvista.com>
	<1179502773.20519.56.camel@imap.mvista.com>
	<17998.28659.702653.237011@cargo.ozlabs.ibm.com>
	<1179628991.20925.2.camel@imap.mvista.com>
	<1179630190.32247.534.camel@localhost.localdomain>
	<4650632B.1010702@genesi-usa.com>
Content-Type: text/plain
Date: Mon, 21 May 2007 07:25:38 +1000
Message-Id: <1179696339.32247.568.camel@localhost.localdomain>
Mime-Version: 1.0
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

> So.. if we get enough clocksources into the tree, can any of those
> parts of the code be reworked to use clocksources/clockevents and
> hrtimers quickly and easily? I noticed the patch just posted does
> some of it.. but not as much as Ben just mentioned.

Well, some of these are expected to be small & fast and work in all sort
of crazy circumstances, like udelay etc... I'd rather keep that on top
of the TB. Do we have actual examples where the TB freq is changing ?
Beside, on powerpc, we don't have another clock source that is as fast
to access and we have userland using the TB for gettimeofday via the
vdso, so I'd say bad idea ... Just keep the damn thing fixed frequency.

> Or is it a development nightmare?
> 
> I'm fairly sure on a PPC970 box even though the decrementer is
> monotonic and never changes frequency, one day it just might, and
> it would be better to anticipate this (and allow people to
> distribute their timing requirements across an entire system
> and not just the CPU core anyway, which I think is probably a
> good thing from a system integration and possibly the point of
> view of redundancy..)

On a -sane- 970 box (which seems to be the case of all of them that
matter so far), the TB is sourced externally specifically for that
reason : to avoid it changing, The DEC is always derived the TB, so it's
not changing.

I don't have any plan to support somebody coming up with a HW design
broken enough to have a variable TB/DEC speed. If they do it, they
support it and they come up with patches that are acceptable (hint: that
will be hard !). Beside, it means the vDSO will not be useable for
gettimeofday on such a platform, which means it will have to fallback to
the syscall which is much slower.

Ben.

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1DA6867A41
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 07:53:43 +1000 (EST)
Subject: Re: Not coherent cache DMA for G3/G4 CPUs: clarification needed
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <20060427213134.GA12572@mag.az.mvista.com>
References: <20060420210201.GA25755@gate.ebshome.net>
	<10026.1145567455@www088.gmx.net>
	<20060420215514.GE25755@gate.ebshome.net>
	<1145594285.28014.12.camel@localhost.localdomain>
	<20060427213134.GA12572@mag.az.mvista.com>
Content-Type: text/plain
Date: Fri, 28 Apr 2006 07:53:29 +1000
Message-Id: <1146174809.30710.14.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> There are many mv64x60 based platforms working just fine today with
> CONFIG_NOT_COHERENT_CACHE defined.  The reason for turning coherency off
> is that there is a bug in the bridge requiring a hardware workaround.
> Unfortunately, not all of the hardware vendors have implemented that
> workaround and I know of one that considers it infeasible and will
> not implement it.

Define "working fine" ... With the current implementation, and according
to the spec, it will randomly crap out or checkstop due to the same page
beging accessed via the NCU and being in the L2 unless you disabled
speculative loads and made sure it can't prefetch accross page
boundaries maybe ? Or set the G bit all over the BAT mapping (ouch !).

> I expect that the pegasos has that hardware workaround implemented so
> the kernel maintainers for that platform have the good fortune of being
> able to run with coherency on.

I suppose so...

> What Ben says is correct, there is that issue.  However, AFAIK, I have
> not yet to run into it.

Hrm... well, I wouldn't rely on that tho.

> If that hardware workaround is not implemented, the options are:
> a) 100% chance of a system hang with coherency on
> or
> b) < 0.0..1% chance of a system hang with coherency off (at least in my
> experience to far).
> 
> The choice is simple.

I disagree. A solution that is known to have a hole in it is no good
even if you haven't managed to trigger it so far. Now it's Gerhard's
choice.

Ben.

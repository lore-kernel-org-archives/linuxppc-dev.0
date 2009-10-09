Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.180])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D6E16B7B7A
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2009 16:28:36 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH/RFC] powerpc: Fix decrementer setup on 1GHz boards
Date: Fri, 9 Oct 2009 07:28:28 +0200
References: <1255013362-27135-1-git-send-email-sr@denx.de>
	<1255032776.2146.7.camel@pasglop>
In-Reply-To: <1255032776.2146.7.camel@pasglop>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200910090728.28870.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 08 October 2009 22:12:56 Benjamin Herrenschmidt wrote:
> On Thu, 2009-10-08 at 16:49 +0200, Stefan Roese wrote:
> > We noticed that recent kernels didn't boot on our 1GHz Canyonlands 
460EX
> > boards anymore. As it seems, patch 8d165db1 [powerpc: Improve
> > decrementer accuracy] introduced this problem. The routine div_sc()
> > overflows with shift = 32 resulting in this incorrect setup:
> >
> > time_init: decrementer frequency = 1000.000012 MHz
> > time_init: processor frequency   = 1000.000012 MHz
> > clocksource: timebase mult[400000] shift[22] registered
> > clockevent: decrementer mult[33] shift[32] cpu[0]
> >
> > This patch now introduces a local div_dc64() version of this function
> > so that this overflow doesn't happen anymore.
> 
> Ugh ? We never expected that the decrementer would be ticking that fast.
> This is too fast actually. Somebody at AMCC must be told to stick a
> divider in front of the timebase when reaching such frequencies.

As Josh already pointed out on IRC, the source of timebase can be either 
the CPU clock or an external provided clock. We always used the CPU clock 
as timebase source till now. 

I looked at switching to external clock on Canyonlands, but this doesn't 
look promising. The external timer clock here is the output of the RTC 
M41T62, which is a max of 32768 Hz. Enabling this clock also has the 
disadvantage to drain the RTC battery quickly. That's why this clock output 
is currently disabled per default.

So how could we solve this issue now? Apply my current patch? Any other 
suggestions?

Thanks.

Cheers,
Stefan

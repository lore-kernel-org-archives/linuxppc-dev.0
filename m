Return-Path: <mgreer@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 2124B679FB
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 07:30:09 +1000 (EST)
Date: Thu, 27 Apr 2006 14:31:34 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Not coherent cache DMA for G3/G4 CPUs: clarification needed
Message-ID: <20060427213134.GA12572@mag.az.mvista.com>
References: <20060420210201.GA25755@gate.ebshome.net>
	<10026.1145567455@www088.gmx.net>
	<20060420215514.GE25755@gate.ebshome.net>
	<1145594285.28014.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1145594285.28014.12.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 21, 2006 at 02:38:05PM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2006-04-20 at 14:55 -0700, Eugene Surovegin wrote:
> > On Thu, Apr 20, 2006 at 11:10:55PM +0200, Gerhard Pircher wrote:
> > > Well, Freescale's PPC programming environment manual clearly states that
> > > this will not work on G4 CPUs (74xx). Also Benjamin Herrenschmidt told me,
> > > that this implementation will not work for the reasons I mentioned before. 
> > > The approach I'm trying to implement was his idea, so I have to trust in
> > > him.
> > 
> > Well, you aren't the first person who tries to run G4 with 
> > CONFIG_NOT_COHERENT_CACHE. This was done before and I don't remember 
> > that those people had to implement anything as complex as you are 
> > trying to do.
> > 
> > You can try asking on #mklinux. It always better to ask people who 
> > actually _did_ this :).
> > 
> > In fact, I just grepped 2.6 and found 
> > #ifdef(CONFIG_NOT_COHERENT_CACHE) in syslib/mv64x60.c. Guess what 
> > systems usually have this type of bridge? Not 4xx/8xx, that's for sure.
> 
> I think some folks tried ... and failed.

Who has tried and failed?

There are many mv64x60 based platforms working just fine today with
CONFIG_NOT_COHERENT_CACHE defined.  The reason for turning coherency off
is that there is a bug in the bridge requiring a hardware workaround.
Unfortunately, not all of the hardware vendors have implemented that
workaround and I know of one that considers it infeasible and will
not implement it.

I expect that the pegasos has that hardware workaround implemented so
the kernel maintainers for that platform have the good fortune of being
able to run with coherency on.

What Ben says is correct, there is that issue.  However, AFAIK, I have
not yet to run into it.

If that hardware workaround is not implemented, the options are:
a) 100% chance of a system hang with coherency on
or
b) < 0.0..1% chance of a system hang with coherency off (at least in my
experience to far).

The choice is simple.

Mark
